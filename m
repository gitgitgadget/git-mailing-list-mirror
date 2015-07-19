From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 6/6] worktree: wordsmith worktree-related manpages
Date: Sat, 18 Jul 2015 23:21:39 -0400
Message-ID: <CAPig+cShJjmDAnwBJ0gzgHb0KwAbNZLLOCfJ2tiGQJZsCQf1gA@mail.gmail.com>
References: <cover.1437271363.git.mhagger@alum.mit.edu>
	<087f0fbeffa8fb30529ba69498e427d11396eddf.1437271363.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 19 05:22:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGfBn-0000Qb-5c
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 05:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbbGSDVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 23:21:41 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35067 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbbGSDVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 23:21:40 -0400
Received: by ykdu72 with SMTP id u72so117177677ykd.2
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 20:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qHY2f7nkwxrW7th42Ytin4ygFd4SxMJ04kuPtYiUWus=;
        b=mv/tILc/aCwyMgUWzOm6AtUyzAlGIhTRQWVLzvWXn8iOkONrLqK4sc9mv9HbOvbMog
         41ji7mKMc9EAKwPv/pM2rHebG66pZ1d9ozG2r9YeMqKqwF+w85KQc1xNmr5RoiIfy1oO
         Qvd1l5xH/hHSO4fnxlDQ6FZElF1ldBNpIE4+MmI67t75ahhouOJF/hCk3YguiTV6k4sN
         wNQoe3+T5ZDyeB4FM826gCGzk4J+CXpJWdJIbnphUaXyzv4EdhZXPYX8Km1Bl9378Hga
         a1Gm8cwr/WMM8gqdK6p4aVDhLZAFaBzzHGhS+3OdIrvcr1yqAv/vmeyLL1SMoGxPMEY2
         1lXg==
X-Received: by 10.170.97.9 with SMTP id o9mr22335143yka.84.1437276099940; Sat,
 18 Jul 2015 20:21:39 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 18 Jul 2015 20:21:39 -0700 (PDT)
In-Reply-To: <087f0fbeffa8fb30529ba69498e427d11396eddf.1437271363.git.mhagger@alum.mit.edu>
X-Google-Sender-Auth: xahKu3KI6IYiFLwMNaPELwWBEFE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274198>

On Sat, Jul 18, 2015 at 10:10 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 7f65dbb..10bc351 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1292,11 +1292,11 @@ gc.pruneExpire::
>         unreachable objects immediately.
>
>  gc.pruneWorktreesExpire::
> -       When 'git gc' is run, it will call
> +       When 'git gc' is run, it calls
>         'git worktree prune --expire 3.months.ago'.

This is a tangent, but I wonder if this config variable should be
renamed to gc.worktreePruneExpire to reflect the rename of "prune
--wortkrees" to "worktree prune".

> -       Override the grace period with this config variable. The value
> -       "now" may be used to disable the grace period and prune
> -       $GIT_DIR/worktrees immediately.
> +       This config variable can be used to set a different grace
> +       period. The value "now" may be used to disable the grace
> +       period and prune $GIT_DIR/worktrees immediately.
>
>  gc.reflogExpire::
>  gc.<pattern>.reflogExpire::
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index d5aeda0..cecb44c 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -138,7 +138,7 @@ EXAMPLES
>  worktrees/<id>/locked::
>         If this file exists, the linked working tree may be on a
> -       portable device and not available. It does not mean that the
> -       linked working tree is gone and `worktrees/<id>` could be
> -       removed. The file's content contains a reason string on why
> -       the repository is locked.
> +       portable device and not available. The presence of this file
> +       prevents `worktrees/<id>` from being pruned by `git worktree
> +       prune`. The file may contain a string explaining why the
> +       repository is locked.

When I read the new text, I kind of get the impression that pruning
only happens manually when the user invokes "git worktree prune". I
wonder if it can be reworded to mention that pruning can happen
automatically too. Or, maybe don't mention "git worktree prune" at
all, and instead just say, generally, that it prevents the
linked-worktree administrative files from being pruned.
