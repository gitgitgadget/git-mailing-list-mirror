From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Fix worktree usage message
Date: Sun, 18 Oct 2015 12:51:47 -0400
Message-ID: <CAPig+cRXq9qonwPpWQdnrFkJgQQW0zDokXQhSvw5n07d7OpqdQ@mail.gmail.com>
References: <20151018113902.GA12622@ikke.info>
	<1445170530-31573-1-git-send-email-tigerkid001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, ch3cooli@gmail.com,
	Kevin Daudt <me@ikke.info>
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 18:51:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnrBY-0000p3-Dv
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 18:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbbJRQvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 12:51:48 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33856 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbbJRQvr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 12:51:47 -0400
Received: by vkat63 with SMTP id t63so92657128vka.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=d3W6sIi9S7oK0CXc1C1x/jO1d/LwDbh4vbchDHksQnA=;
        b=y1B4hJmhpBeAUQuc3+EoYeaFKEny9gHCBOdx8BjaLWRki7YRMYxMAug2UEsp1QeKBG
         zCD5wyeWQdc8o1jYPTpzAfeLsBFj09WCPvHa2m0rlbjX5sY+mlEw3F182nT3f9yWdXY3
         Qe05u/iWlqMAr1lhkAYb3zE8ZDvpgAqkSqBNbfM1YhorLq8HP9FAe6nnwsBcd3uN7zD0
         1v1pCKDAxkgArSZ7yekT9z3jbDuFbMLrgZ5jJOte5ECgt5TdwntVH4ei/u6DK2wITQLf
         78IRbyoqSBpdw3jIt0/Rj9UOls58tMHA0zNpHT3dVXXS3Ecy0AvY8C4NJOnJmQv7jD/a
         MWvg==
X-Received: by 10.31.151.16 with SMTP id z16mr7256553vkd.14.1445187107138;
 Sun, 18 Oct 2015 09:51:47 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Sun, 18 Oct 2015 09:51:47 -0700 (PDT)
In-Reply-To: <1445170530-31573-1-git-send-email-tigerkid001@gmail.com>
X-Google-Sender-Auth: ClDR-UH0p2gBD1UKrVFpLOcwNCg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279814>

On Sun, Oct 18, 2015 at 8:15 AM, Sidhant Sharma <tigerkid001@gmail.com> wrote:
> Mark <branch> optional in worktree command line usage to maintain consistency with man pages.

Thanks for the patch. To clarify that it is the in-code usage string
which is incorrect, rather than the man page, how about something like
the following as commit message instead?

    worktree: usage: denote <branch> as optional with 'add'

    Although 1eb07d8 (worktree: add: auto-vivify new branch when
    <branch> is omitted, 2015-07-06) updated the documentation when
    <branch> became optional, it neglected to update the in-code
    usage message. Fix this oversight.

> Reported-by: ch3cooli@gmail.com
>
> Signed-off-by: Sidhant Sharma <tigerkid001@gmail.com>

Citing the reporter is a nice touch, but drop the blank line between
it and the sign-off.

> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 71bb770..33d2d37 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -10,7 +10,7 @@
>  #include "refs.h"
>
>  static const char * const worktree_usage[] = {
> -       N_("git worktree add [<options>] <path> <branch>"),
> +       N_("git worktree add [<options>] <path> [<branch>]"),
>         N_("git worktree prune [<options>]"),
>         NULL
>  };
> --
> 2.6.2
