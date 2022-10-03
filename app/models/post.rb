class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    #Post category is either Fiction or Non-Fiction
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }

    validate :clickbait?

    CLICKBAIT_PATTERNS = [
      /Won't Believe/i,
      /Secret/i,
      /Top \d/i,
      /Guess/i
    ]
  
    def clickbait?
      if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
        errors.add(:title, "must be clickbait")
      end
    end

end
