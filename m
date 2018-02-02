Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDF511F576
	for <e@80x24.org>; Fri,  2 Feb 2018 09:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeBBJPr (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 04:15:47 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37283 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeBBJPm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 04:15:42 -0500
Received: by mail-qt0-f196.google.com with SMTP id d54so30045966qtd.4
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 01:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=K+8A63GRxM6/DKqxcrvhT5EuUXxhfXpLve4MjNVvPZY=;
        b=aQRtA37bxcD5asOBLU1jaUk5oKe5lJUtD2G2IaHBKWP46xGU9B+HvC4np2W5oRzY+x
         jN0RV7E78UY+LMot1wmiut0IYsRr6zCnUL5lJb0kzNLoTj12pTiyLMX0drtBReJm7gqq
         2z1NyDqYNXnotriYEr+Xjjyrwmv7IuTR8mFWmCwAOPI3lP6OSQq8TNmh7YcSdOYnEJOT
         2wnmvXy31QyO2eaKfmbtEcqcpsSbSckXtoE+U3981w0CnPqCJDUkaOM7jg0nUygUXuf0
         Dw9+cTLHgzA1Z5DzdTkLHtpCNwp215DTgJarAVoMPfZKwUjV0eH6j6UsW6yuu7t6A3cM
         nf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=K+8A63GRxM6/DKqxcrvhT5EuUXxhfXpLve4MjNVvPZY=;
        b=MuCbPXOHb6OdKqe9bSgJMsMjgNyr4219nQsDgWKqLCgIoO12SyVxL7+WZem1OhBFIx
         bKY8TGkwPa5Frf3928nN5Fw1DqFDNBKeZFENtbQVa0oSv4dQcRhOG8rk4L7de0e16pps
         VFSMzcjXzHYU1p1r9xvKzrVcXLTbbNcqHaBsCT+VmucCqBot7JUsG2++dZlenOMc18z/
         Qadt/F4bjp0UfC7NyPaF+ALQdHcTcGwgur/zzaXdUUBf+OAye/a45VeElzd608shmYAt
         28hAEG0i5u3Eofhz1mU8pXrycSTqpyvG9geRUHoEXa6sHhCevbwCYCDZ74NKFwiubvDP
         WuQQ==
X-Gm-Message-State: AKwxytdIl8djL91cmInjiJ1eGw7KztbOuEIEhjYDmH7Vc4Fh/IpqjMaa
        w0TRAt57+BAkEFhroIJP+2kbKBMy6JX0cx3d75jVbw==
X-Google-Smtp-Source: AH8x225xcKJkVjhRHHGkDEZwDU15KCcNM9xnhzw5WYdjwjE0x2YeZuTpMERzPL+OJEDrXGpng+w2GWrmCA+Pfsp5BMg=
X-Received: by 10.200.82.21 with SMTP id r21mr9022825qtn.75.1517562941143;
 Fri, 02 Feb 2018 01:15:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 2 Feb 2018 01:15:40 -0800 (PST)
In-Reply-To: <20180124095357.19645-4-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-4-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Feb 2018 04:15:40 -0500
X-Google-Sender-Auth: rWgRelnaDb4sP96lMbPMd3YlbD8
Message-ID: <CAPig+cQeQRppb2y4YyQnqWWnCO0TXE-PjfTAhxakCJNk45ec1w@mail.gmail.com>
Subject: Re: [PATCH 3/7] worktree move: new command
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 4:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> This command allows to relocate linked worktrees. Main worktree cannot
> (yet) be moved.
> [...]
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.=
txt
> @@ -79,6 +80,11 @@ files from being pruned automatically. This also preve=
nts it from
> +move::
> +
> +Move a working tree to a new location. Note that the main working tree
> +cannot be moved.
> +
> @@ -281,7 +287,6 @@ performed manually, such as:
>  - `remove` to remove a linked working tree and its administrative files =
(and
>    warn if the working tree is dirty)
> -- `mv` to move or rename a working tree and update its administrative fi=
les

A couple other places in this document ought to be updated.
Specifically, in DESCRIPTION:

    If you move a linked working tree, you need to manually update the
    administrative files so that they do not get pruned automatically.
    See section "DETAILS" for more information.

which can probably be dropped in its entirety. And, in DETAILS:

    If you move a linked working tree, you need to update the 'gitdir'
    file...

should probably be reworded to

    If you _manually_ move a linked working tree, you need to update
    the 'gitdir' file...

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -605,6 +606,53 @@ static int unlock_worktree(int ac, const char **av, =
const char *prefix)
> +static int move_worktree(int ac, const char **av, const char *prefix)
> +{
> +       [...]
> +       worktrees =3D get_worktrees(0);
> +       wt =3D find_worktree(worktrees, prefix, av[0]);
> +       if (!wt)
> +               die(_("'%s' is not a working tree"), av[0]);

This is still leaking 'worktrees'[1]. You probably want
free_worktrees() immediately after the find_worktree() invocation.

> +       if (is_main_worktree(wt))
> +               die(_("'%s' is a main working tree"), av[0]);
> +       reason =3D is_worktree_locked(wt);
> +       if (reason) {
> +               if (*reason)
> +                       die(_("cannot move a locked working tree, lock re=
ason: %s"),
> +                           reason);
> +               die(_("cannot move a locked working tree"));
> +       }
> +       if (validate_worktree(wt, &errmsg))
> +               die(_("validation failed, cannot move working tree:\n%s")=
,
> +                   errmsg.buf);

Minor: All the other error messages are presented on a single line.
Despite this error message potentially being quite long, it worries me
a bit that presenting it on two lines could complicate scripted
clients if they need to collect the error message for special
handling.

> diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
> @@ -59,4 +59,35 @@ test_expect_success 'unlock worktree twice' '
> +test_expect_success 'move locked worktree' '
> +       git worktree lock source &&
> +       test_must_fail git worktree move source destination &&
> +       git worktree unlock source
> +'

Also from [1], wrapping 'unlock' inside a test_when_finished()
invocation seems potentially desirable.

> +test_expect_success 'move worktree' '
> +       toplevel=3D"$(pwd)" &&
> +       git worktree move source destination &&
> +       test_path_is_missing source &&
> +       git worktree list --porcelain | grep "^worktree" >actual &&
> +       cat <<-EOF >expected &&
> +       worktree $toplevel
> +       worktree $toplevel/destination
> +       worktree $toplevel/elsewhere
> +       EOF
> +       test_cmp expected actual &&

This seems somewhat fragile. If someone inserts a test before this one
which adds another worktree, then this test would break. Perhaps the
filtering of the --porcelain output could be more strict? (Not
necessarily worth a re-roll, though.)

> +       git -C destination log --format=3D%s >actual2 &&
> +       echo init >expected2 &&
> +       test_cmp expected2 actual2
> +'

[1]: https://public-inbox.org/git/CAPig+cRqgzB4tiTb=3DfHuFBTqo3QEGM3m378PvO=
se06KdreKo2Q@mail.gmail.com/
