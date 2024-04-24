class CommentsController < ApplicationController

  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.create(comment_params)
    if @comment.save
      redirect_to prototype_path(@prototype)
    else
      render prototype_path(@prototype_id), status: :unprocessable_entity
    end
  end

  def show
    @comments = @prototype.find(params[:prototype_id])
    @comments = @prototype.comments.includes(:user)
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
