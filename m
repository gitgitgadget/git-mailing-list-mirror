Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6A01F576
	for <e@80x24.org>; Fri,  2 Feb 2018 09:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeBBJfV (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 04:35:21 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:46382 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeBBJfS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 04:35:18 -0500
Received: by mail-qt0-f179.google.com with SMTP id h4so2369772qtn.13
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 01:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=qqyGcpoeaanmKebsvnQhMQqPaQ2ECS+5HWHLpBzVotE=;
        b=SmjX73DLLcG4AuA9YbkJTBjHxsN0Mjx6eyhFSCtskujaMiRo9Ayw7GIUBtDEN6rPy8
         kHgVHcEI75FmgsiYQNQ7IG/98f6biUJVD4lI39Tsa/mpo01izHe2357moxpXuMd4B4Ek
         ePZfEWIxbIz4LJGh9OrD/hHBVU5NEODPoySW5uYblE7NeWO00EVC6giNyFaajJgPOOwu
         l+PD5E5I7vD4IY+wNoxvxmEFqrJcKveeu7mi4C3LMNYwxiG985a7rRq3lc7sOBE/TEYo
         Csv9y3zH+PwhQK/Q4etAmBCyiEVSI0ql1dAdHlfv0dWFxHNwJZPy0wDPDPJU5azaecKM
         8w6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=qqyGcpoeaanmKebsvnQhMQqPaQ2ECS+5HWHLpBzVotE=;
        b=TNHH/CTkKH8kirc4ygsCwcq3npxU0hX3/wj/C+odRD2slsRW0aWk19UNx3nM33obmv
         pzDfJDI+Zd6fIX2fmnScYomWjNg0ejY4hnxkhva4k1wxm+Nz1Ezc054/VwAlBM7g4JM/
         86mJRgE2npszFLEuxN00pvnZLXLFx8qYTAjEzFUmelt8XE1eRF8ZeeWI6B1M2QJHiD/D
         EPuj5tJq+8xBrquzXrQ92T9k/LPr8yu7y3FN0XirQmgVWiAoVUsb98wULysdpQnIXnkc
         BdoHJf1XsUPOki4f0d0LSlD3zkaOcSxIKJpOM4yWFrBTtlxBtep2S4y7nWqTyrPsV7mo
         i6lA==
X-Gm-Message-State: AKwxyteH0ytjyxoT7fJRbaSdn3p36d/nkKdvLxYNe8ikCWvtOFyqZUZE
        2mo0dkvWLUUBVFwEKQ0GwsAegELWA2sXbrIdXy0=
X-Google-Smtp-Source: AH8x225dik/zp/apSLHz/bilNlFnHOi2Uo+dusZjmzuHjJGhb30XZTfITzbHwt6p59StHKaznAhFXr8wZg1Bpfv3vs8=
X-Received: by 10.200.45.109 with SMTP id o42mr3005952qta.277.1517564117512;
 Fri, 02 Feb 2018 01:35:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 2 Feb 2018 01:35:17 -0800 (PST)
In-Reply-To: <20180124095357.19645-5-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-5-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Feb 2018 04:35:17 -0500
X-Google-Sender-Auth: xkXgZHOc9dAHYB-x6B-F3XA_h0o
Message-ID: <CAPig+cTAmzAK2vQHuPHJJMT+Q2fiD4P--qv_rSrc2gKbFFhPTg@mail.gmail.com>
Subject: Re: [PATCH 4/7] worktree move: accept destination as directory
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
> Similar to "mv a b/", which is actually "mv a b/a", we extract basename
> of source worktree and create a directory of the same name at
> destination if dst path is a directory.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -624,8 +624,6 @@ static int move_worktree(int ac, const char **av, con=
st char *prefix)
>         path =3D prefix_filename(prefix, av[1]);
>         strbuf_addstr(&dst, path);
>         free(path);
> -       if (file_exists(dst.buf))
> -               die(_("target '%s' already exists"), av[1]);

Nit: The distance between this "removed" conditional and the code
inserted below hampered review a bit since it made it slightly more
onerous to check for unwanted logic changes. Had patch 3/7 located
this conditional below the is_main_worktree() check (where the new
code is inserted below), this 'if' would have merely mutated into an
'else if' but not otherwise moved, thus review would have been
simplified. (Not itself worth a re-roll.)

>         worktrees =3D get_worktrees(0);
>         wt =3D find_worktree(worktrees, prefix, av[0]);
> @@ -633,6 +631,20 @@ static int move_worktree(int ac, const char **av, co=
nst char *prefix)
>                 die(_("'%s' is not a working tree"), av[0]);
>         if (is_main_worktree(wt))
>                 die(_("'%s' is a main working tree"), av[0]);
> +
> +       if (is_directory(dst.buf)) {
> +               const char *sep =3D find_last_dir_sep(wt->path);
> +
> +               if (!sep)
> +                       die(_("could not figure out destination name from=
 '%s'"),
> +                           wt->path);
> +               strbuf_addstr(&dst, sep);

Do we know at this point whether 'dst' has a terminating "/"? If it
does, then this addstr() could result in "//" in the path which might
be problematic on Windows.

> +               if (file_exists(dst.buf))
> +                       die(_("target '%s' already exists"), dst.buf);
> +       } else if (file_exists(dst.buf)) {
> +               die(_("target '%s' already exists"), av[1]);
> +       }

I wonder if it makes sense to collapse the duplicated
file_exists()/"target already exists" code?

    if (is_directory(...)) {
        ...
        strbuf_addstr(&dst, sep);
    }
    if (file_exists(dst.buf))
        die(_("target '%s' already exists"), dst.buf);

It changes the error message slightly for the non-directory case but
simplifies the code a bit.

>         reason =3D is_worktree_locked(wt);
>         if (reason) {
>                 if (*reason)

Perhaps add a test to t2028-worktree-move.sh to show that this new
behavior works?
