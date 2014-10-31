class Player
  attr_reader :code
  def initialize(code=[rand(6), rand(6), rand(6), rand(6)])
    @code = code
  end
end
class Game
  attr_accessor :turns_left, :victory
  attr_reader :secret_code
  def initialize
    @secret_code = Player.new.code
    @turns_left = 12
    @victory = false
  end
  
  def evaluate_guess(guess)
    correct_guess = [false, false, false, false]
    guess.each_with_index do |num, idx|
      correct_guess[idx] = true if num == @secret_code[idx]
    end
    return correct_guess
  end
  
  def make_guess(guess)
    if evaluate_guess(guess).all?{|x| x}
      @victory = true
    else
      @turns_left -= 1
    end
    evaluate_guess(guess).inspect
  end
  
  def start
    while @turns_left > 0 && !@victory
      puts "Enter your guess for each of the four slots (0-5). #{@turns_left} turns left!"
      guess = gets.chomp.split('').map{|e| e.to_i}
      puts make_guess(guess)
    end
    if @victory
      puts "You win!"
    else
      puts "You lose!\nThe correct code is #{@secret_code}"
    end
  end
end
def start
  Game.new.start
end