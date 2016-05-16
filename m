From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/5] worktree: add "lock" command
Date: Sun, 15 May 2016 20:09:00 -0400
Message-ID: <CAPig+cRMxYGx_gR9vei=6bcoXkhm2ntQSdqA3Vq9rtTzDd1RSQ@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160510141729.23063-1-pclouds@gmail.com>
	<20160510141729.23063-4-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 02:09:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b266E-0003UN-Uh
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 02:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbcEPAJ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 20:09:27 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36386 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbcEPAJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2016 20:09:26 -0400
Received: by mail-io0-f170.google.com with SMTP id i75so186970719ioa.3
        for <git@vger.kernel.org>; Sun, 15 May 2016 17:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=Qk2cHZTl9oUa9cw+O8e5W3K9WlA+fL+/pzQhtn5gIxI=;
        b=efmBPUnjd5mK7cOqOMEJvScKC6Z54oJrfKXSeOoay4mhB1AVEcJVAZKsvDhBkk2H4+
         gt0fHU0ypt480bbTkSdMVYfcsJQHZthxQigdBqWP4M3nkTaxSYrdtnND+uDO7FLfcpuF
         3DHVuNRen1uAKwbD1iuAq5MqMATUBOyletjSzU61GrEVxEkIQ2+HCJqVjTs6+bcRmMeJ
         rPURxpHTUUEBV++uE5A98QJ1tY9f3maWly6IsuPmasUuKwGcI/cmuqES4IZdJ8RQ4kTM
         5B0w+ie4j6P8Ns8+IglsU6Q0KNOmsrpOAdGMu7WgvP9eDbgK3ul72HnUQzcJri75174h
         WTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=Qk2cHZTl9oUa9cw+O8e5W3K9WlA+fL+/pzQhtn5gIxI=;
        b=DIvmtb1bQNYkHCCpX7DRVP/nPJlmq+415t3Chi1C5rh12mIluZJMeCYv3Zp5lwBxpB
         fLz9PDWCH4nI0Cnor+qL2ozNlyIM6tVZCHL2zmm3X3RlAZLGDMNKvmDNVjQCx9mj/ks2
         pjZAtqDHILVAgnwucyP21WPwoReT198EAwV7Fgi/KBPYU2gU4Y1svMNnFQPoP/ea9dqB
         ia++C/QiyqBCtdV9Fb7N+qcQwKqxeaGQXkQBB1oLyHFrZRPXMStvRu758zIPFjz2iAmR
         dGD/DtiPgH5nbEjx/oTVspD/EXEO/NUHEt3AzdT9rTLr3LhygHg5Hc/PurOxns2LfvWh
         HsEQ==
X-Gm-Message-State: AOPr4FVvzw9b/U+uP+6i4UVdh9TsMjUj09WnJYmV8PC1ZRGfAcRtP/F8Sk66sUbaEe4BU/o1R/kewouvGb5oFg==
X-Received: by 10.107.132.66 with SMTP id g63mr19651430iod.34.1463357340613;
 Sun, 15 May 2016 17:09:00 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 15 May 2016 17:09:00 -0700 (PDT)
In-Reply-To: <20160510141729.23063-4-pclouds@gmail.com>
X-Google-Sender-Auth: OUUk3Ub4VTOBmNNndJ8a3IXOjP0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294707>

On Tue, May 10, 2016 at 10:17 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-workt=
ree.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>  [verse]
>  'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] <p=
ath> [<branch>]
>  'git worktree list' [--porcelain]
> +'git worktree lock' [--reason <string>] <path>
>  'git worktree prune' [-n] [-v] [--expire <expire>]
>
>  DESCRIPTION

This forgets to update the paragraph in DESCRIPTION which currently
talks about manually creating the 'locked' file. Perhaps it can be
rewritten like this:

    If a linked working tree is stored on a portable device or
    network share which is not always mounted, you can prevent its
    administrative files from being pruned by issuing the `git
    worktree lock` command, optionally specifying `--reason` to
    explain why the working tree is locked.

The DETAILS section might also need a small update. It currently says:

    ...add a file named 'locked'...

but perhaps it should instead say:

    ...use the `git worktree lock` command, which adds a
    file named `locked`,...

> @@ -61,6 +62,12 @@ each of the linked worktrees.  The output details =
include if the worktree is
> +lock::
> +
> +When a worktree is locked, it cannot be pruned, moved or deleted. Fo=
r
> +example, if the worktree is on portable device that is not available
> +when "git worktree <command>" is executed.

The really important reason for locking a worktree is to prevent its
administrative files from being pruned *automatically*. This
description doesn't properly emphasize that point.

Also, bc48328 (Documentation/git-worktree: consistently use term
"linked working tree", 2015-07-20) comprehensively replaced the term
"worktree" with "working tree" and, although some new instances
slipped in with bb9c03b (worktree: add 'list' command, 2015-10-08), we
should probably avoid adding more.

Perhaps the description of "lock" can be rewritten like this:

    If a working tree is on a portable device or network share which
    is not always mounted, lock it to prevent its administrative
    files from being pruned automatically. This also prevents it from
    being moved or deleted. Optionally, specify a reason for the lock
    with `--reason`.

I guess preventing it from being deleted when locked is a safety measur=
e?

> @@ -110,6 +117,9 @@ OPTIONS
>  --expire <time>::
>         With `prune`, only expire unused working trees older than <ti=
me>.
>
> +--reason <string>:
> +       An explanation why the worktree is locked.

=46or consistency with other option descriptions, perhaps:

    With `lock`, an explanation ...

though I don't feel strongly about it.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -459,6 +460,44 @@ static int list(int ac, const char **av, const c=
har *prefix)
> +static int lock_worktree(int ac, const char **av, const char *prefix=
)
> +{
> +       const char *reason =3D "", *old_reason;
> +       struct option options[] =3D {
> +               OPT_STRING(0, "reason", &reason, N_("string"),
> +                          N_("reason for locking")),
> +               OPT_END()
> +       };
> +       struct worktree **worktrees, *wt;
> +       struct strbuf dst =3D STRBUF_INIT;
> +
> +       ac =3D parse_options(ac, av, prefix, options, worktree_usage,=
 0);
> +       if (ac !=3D 1)
> +               usage_with_options(worktree_usage, options);
> +
> +       strbuf_addstr(&dst, prefix_filename(prefix,
> +                                           strlen(prefix),
> +                                           av[0]));
> +
> +       worktrees =3D get_worktrees();
> +       wt =3D find_worktree_by_path(worktrees, dst.buf);
> +       if (!wt)
> +               die(_("'%s' is not a working directory"), av[0]);
> +       if (is_main_worktree(wt))
> +               die(_("'%s' is a main working directory"), av[0]);
> +
> +       old_reason =3D is_worktree_locked(wt);
> +       if (old_reason) {
> +               if (*old_reason)
> +                       die(_("already locked, reason: %s"), old_reas=
on);
> +               die(_("already locked, no reason"));
> +       }

As a convenience, would it make sense to allow a worktree to be
re-locked with a different reason rather than erroring out?

Also, the "no reason" in the error message might be confusing. Perhaps
it would be better to say merely "already locked" in this case.

> +       write_file(git_common_path("worktrees/%s/locked", wt->id),
> +                  "%s", reason);
> +       return 0;
> +}

This is a tangent, but it would be nice for the "git worktree list"
command to show whether a worktree is locked, and the reason (if
available), both in pretty and porcelain formats. (That was another
reason why I suggested to Mike, back when he was adding the "list"
command, that 'struct worktree' should have a 'locked' field and
get_worktrees() should populate it automatically.)

> diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +
> +test_description=3D'test git worktree move, remove, lock and unlock'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +       test_commit init &&
> +       git worktree add source &&
> +       git worktree list --porcelain | grep "^worktree" >actual &&
> +       cat <<-EOF >expected &&
> +       worktree $TRASH_DIRECTORY
> +       worktree $TRASH_DIRECTORY/source
> +       EOF
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'lock main worktree' '
> +       test_must_fail git worktree lock .
> +'
> +
> +test_expect_success 'lock linked worktree' '
> +       git worktree lock --reason hahaha source &&
> +       echo hahaha >expected &&
> +       test_cmp expected .git/worktrees/source/locked
> +'

Would it make sense to also add tests of locking from within the
worktree being locked, and from within a worktree other than the one
being locked (and other than the main one)?

> +test_expect_success 'lock worktree twice' '
> +       test_must_fail git worktree lock source &&
> +       echo hahaha >expected &&
> +       test_cmp expected .git/worktrees/source/locked
> +'
> +
> +test_done
