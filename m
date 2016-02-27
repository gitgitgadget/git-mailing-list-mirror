From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFD 3/6] rev-list: list all heads with --all
Date: Sat, 27 Feb 2016 09:15:55 +0700
Message-ID: <CACsJy8CrYYjiyeKZuHW=erJ-JZyaWdJKCAzO=zLs2HwSb5ifKA@mail.gmail.com>
References: <cover.1456504190.git.git@drmicha.warpmail.net> <61d93b0aba1d4cb7348066db0b48f1ce2d5b35c5.1456504190.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 03:16:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZUQp-00075u-Df
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 03:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824AbcB0CQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 21:16:27 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36528 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbcB0CQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 21:16:26 -0500
Received: by mail-lb0-f173.google.com with SMTP id x1so55579062lbj.3
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 18:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LYwmjMV+UNJqZFPaEhKPeh8/7Je4qHpLEKnQcXz6MpI=;
        b=VUs7LV9m0rT38jegvC7EZTqapiBvNbGQXL/U5gMkhB38UIAKDxT5L5N5f4RuL/gWa7
         mmoAgFRNJnESjKfluR4uJehmniRs/fGZcpmlynrIEeI4TI42qR5zBXnAUns5vUS9OtyP
         RK4R4d/sq/k/6S+ctjVyJnmIuEJzn6KmNTbC0Bwh4GClzzCOc3UH3N5wFMbMpd3iFogY
         kEYL0DWUgrNoASrb1dyTqwGxxtcUiQ06h8W/g4YwiPGQh5ieozJwIuNG1B7rHz3wh1Re
         oaWTrbqz4y8yOpJQ4mRrWC1Kyy3Rkm3lwACPYiayryeI+XnmznEdKH5jg8Zs1bAwlEr4
         gGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LYwmjMV+UNJqZFPaEhKPeh8/7Je4qHpLEKnQcXz6MpI=;
        b=knHx5NiXptFTO33nMxgGhOGCV7PSurPkfEUH2ToG6hyxgQBiTyZfD3roD/0/402rvV
         BZXgjM7tzzCN9AGjnly1iOwQjsohAx5il2ZnHIDQmy5xFLegDwmQ/4o9RhL6w4Uxl9RV
         2DZxrXUOoM3olEGPDLnJW6qBr6epADa0S+FpJo6xzbirskygs/ajN90DbUq6l6NqApMB
         7jHXsezeTi//A9fHXJbykp6NYC3E/q0OoMot0uImewmhw4GLc2N0H2/XMt1VBAo9Jt4C
         Y6BSVXIEzyymcPIE0vBNG/XVAZpjpFyj+YyBsCOaPqwq72KDGORUmpAwZBjFOZbTQqKL
         N/nw==
X-Gm-Message-State: AD7BkJLMUt4rahpGxaVTwytmgKEDHXX7tHqJYLaOyHcTwUL6ZfTw9BPELhjc04kzf//jeJhloTc+pM9CY/6P/g==
X-Received: by 10.112.150.133 with SMTP id ui5mr1693522lbb.12.1456539385356;
 Fri, 26 Feb 2016 18:16:25 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 26 Feb 2016 18:15:55 -0800 (PST)
In-Reply-To: <61d93b0aba1d4cb7348066db0b48f1ce2d5b35c5.1456504190.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287652>

On Fri, Feb 26, 2016 at 11:39 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> HEAD is a worktree specific sysmref, so that a repository with multiple
> worktrees can have multiple HEADs, or HEADs in a worktree different from
> the current worktree.
>
> So far, "rev-parse --all" adds only the HEAD from the current worktree
> to the list of refs (besides branches etc.). So, a detached HEAD from a
> different checkout would be missed unless a shared ref (or current HEAD)
> points to it (or descents from it). As a consequence, "git prune" can
> prune detached HEADs from worktrees and leave the repo in an
> inconsistent state.
>
> Make "rev-parse --all" add the HEADs from all worktrees. This results in
> a non-worktree-specific ref list and solves the pruning problem.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>
> Notes:
>     This patch solves the pruning problem with worktrees, but I feel quite
>     uneasy about substituting the ref solving at the very heart of refs.c. So
>     please consider this a mere poc and a request for discussion/input
>     about how to do this the right way.
>
>     In essence, I feel the worktree interface still has to evolve a bit: I'd
>     rather for_each_worktree than loop myself, and if many call sites need to
>     be aware of multiple heads or worktrees than get_worktrees() should be
>     part of our init stuff, not here. [I may be out of sync of newer progress.]

How about adding for_each_head_ref_submodule()  and make
handle_revision_pseudo_opt() use it with a new option, .e.g
--all-work-trees?

I looked over head_ref and head_ref_submodule call sites. I think
we're ok. Most of them only concern about "our head". for-each-ref may
need some improvement though.
-- 
Duy
