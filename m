From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] git-rebase: document ack
Date: Sun, 18 May 2014 19:43:45 -0400
Message-ID: <CAPig+cT0evq73-O9Ns5YXjp7Yg-FdX7FehDzW9fOz_Wqp2chUQ@mail.gmail.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
	<1400447743-18513-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon May 19 01:43:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmAkB-0003KK-D9
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 01:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbaERXnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 19:43:46 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:37481 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbaERXnq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 19:43:46 -0400
Received: by mail-yk0-f170.google.com with SMTP id 10so3975542ykt.29
        for <git@vger.kernel.org>; Sun, 18 May 2014 16:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zSfJyMWo3QYsztmD1Um8JNY+zFfZMWNaUbyy4crA3hE=;
        b=yQNOsihleITm9B1vPpC38bChpFrzR8mDYpwwnWLMPT6ZuND8x3f5MVeKCAAYSiD4tY
         O7F3IAh86A8dbVTRvcaClVH+5LxlnrTfqdK/Im/5CEKHsufuaWRCGMxw83G7oe0+FOWp
         bPKQbTD6Eid+P74uhz04skx1o/LdfXk4ynd9gBiOMHKh5YUL3r3LEc4t00v/NPx+ou4N
         zxLxK4EFjp4emcrMuin1VS2n51Fj5hJb3YC564015816xsjbalEceWhzNuRp22sc78mX
         YhSYGkIU1EV3OIxw3++2z8RC+Ac0m1TjpHVYCFgIF1eQkOi5wWLLengNbNXWqbhHjO+w
         vpmg==
X-Received: by 10.236.178.39 with SMTP id e27mr38663010yhm.98.1400456625466;
 Sun, 18 May 2014 16:43:45 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Sun, 18 May 2014 16:43:45 -0700 (PDT)
In-Reply-To: <1400447743-18513-3-git-send-email-mst@redhat.com>
X-Google-Sender-Auth: Tex9G75hXRk8-FQ6IwMo7cy39rE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249553>

On Sun, May 18, 2014 at 5:17 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> document ack! behaviour and use
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  Documentation/git-rebase.txt | 45 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 2a93c64..c27aef4 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -384,7 +384,7 @@ or by giving more than one `--exec`:
>  +
>  If `--autosquash` is used, "exec" lines will not be appended for
>  the intermediate commits, and will only appear at the end of each
> -squash/fixup series.
> +squash/fixup/ack series.
>
>  --root::
>         Rebase all commits reachable from <branch>, instead of
> @@ -398,13 +398,13 @@ squash/fixup series.
>
>  --autosquash::
>  --no-autosquash::
> -       When the commit log message begins with "squash! ..." (or
> -       "fixup! ..."), and there is a commit whose title begins with
> +       When the commit log message begins with "squash! ..." ("fixup! ..."
> +       or "ack! ..."), and there is a commit whose title begins with
>         the same ..., automatically modify the todo list of rebase -i
>         so that the commit marked for squashing comes right after the
>         commit to be modified, and change the action of the moved
> -       commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
> -       "fixup! " or "squash! " after the first, in case you referred to an
> +       commit from `pick` to `squash` (`fixup` or `ack`).  Ignores subsequent
> +       "ack! ", "fixup! " or "squash! " after the first, in case you referred to an
>         earlier fixup/squash with `git commit --fixup/--squash`.
>  +
>  This option is only valid when the '--interactive' option is used.
> @@ -624,6 +624,41 @@ consistent (they compile, pass the testsuite, etc.) you should use
>  'git stash' to stash away the not-yet-committed changes
>  after each commit, test, and amend the commit if fixes are necessary.
>
> +----------------
> +RECORDING ACKS
> +----------------
> +
> +Interactive mode with --autosquash can be used to concatenate
> +commit log for several commits, which is useful to record
> +extra information about the commit, such as ack signatures.
> +This allows, for example, the following workflow:
> +
> +1. receive patches by mail and commit
> +2. receive by mail ack signatures for the patches
> +3. prepare a series for submission
> +4. submit
> +
> +where point 2. consists of several instances of
> +       i) create a (possibly empty) commit with signature
> +         in the commit message
> +
> +Sometimes the ack signature added in i. cannot be amended to the
> +commit it acks, because that commit is buried deeply in a
> +patch series.  That is exactly what rebase --autosquash
> +option is for: use it
> +after plenty of "i"s, to automaticlly rearrange
> +commits, and squashing multiple sign-off commits into
> +the commit that is signed.
> +
> +Start it with the last commit you want to retain as-is:
> +
> +       git rebase --autosquash -i <after-this-commit>
> +
> +An editor will be fired up with all the commits in your current branch
> +which come after the given commit. Ack commits will be
> +re-arranged to come after the commit that is acked,
> +and the action will be utomticlly changed from `pick` to `ack`

s/utomticlly/automatically/

> +to cause them to be squashed into the acked commit.
>
>  RECOVERING FROM UPSTREAM REBASE
>  -------------------------------
> --
> MST
>
