Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 353A81F576
	for <e@80x24.org>; Fri,  2 Feb 2018 08:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbeBBIXs (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 03:23:48 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:37666 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeBBIXq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 03:23:46 -0500
Received: by mail-qk0-f170.google.com with SMTP id y80so22892289qkb.4
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 00:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9LrVOZgd/4U7Th5ixmvb7+2D6LAy77fWRAxCM1dHt4w=;
        b=jdXC9GkGIHiEhZGvecXQ3CJJyF2BqpkjyhUA9sLLneyCW18/f8v8MxC5mX2hcXxvTC
         1+DyGjtnHmotaIyb8ZRBhi//oIwft8FWjaGPaHgLBN4jGsKJZXJ9LwS4H9vNzL4lfOnx
         Hl2vx8Ps9+w7+RxZqqblJ2dhMaLbPF4ovxN48IILUgPixBDAifL/SuNM1UIsOCaYUptu
         t4s96uY2aODAt2P1HIAF+29jWdYBHy2eDGMNyFJxm/3pMY3xZo+h/3SuoAA0OTJreXqd
         uz94YdUeo0CY7EOFXPRiTPa8Ddxy6+BaXFUoTUhUpbtAwI71lRRv2J85kF/Fw1WW/zde
         c66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9LrVOZgd/4U7Th5ixmvb7+2D6LAy77fWRAxCM1dHt4w=;
        b=chQFMO/Zuu7f/66FcS3jPe//+/l6G9waF3DmtBAp4gY+2ZdtKuQMYo/cPc2gPBTuyf
         oivClkhp/tXaZxYlvzJBuMQE2TgVSL1Dr7G6S1EAYoQNSmcYRGaG0pCgC+Z0cyQQEtBF
         X5RgmWEu3+vvWy4/5fsrN/At8tZGbIMEBLehqVYotlx96t+1pMfdhjS4/6LGgFvWiL+k
         5gjnY6ACMwWVT15rnnDlHvsSQHys6BCk1uZCp9FPXUqciUDmAGe9E2GmGMqaCOnJz+0r
         /7PsIc4t2q6mWGmFU3VT94ECcuep3G5HiYhCLaPMwIduHBpOPyOTFrnDpqkvwzx3qsTw
         r6GA==
X-Gm-Message-State: AKwxytdNBO8Bwdo0YLg1EEHzB+CzfRD2T3lozbzf1cwKZjdT0mXetmYk
        6u346DDAVLoJb9dcdMHo8/wuD2h3rRK2H7nWMU4=
X-Google-Smtp-Source: AH8x225dpZ6IwopVjUZJvH+Mdoq/u+I+KE28KTOJHRUWKZle4JcC6vY9EDlfXb5BDuCelmMiLWToEWiSnptEDqFngms=
X-Received: by 10.55.177.135 with SMTP id a129mr29826871qkf.112.1517559825841;
 Fri, 02 Feb 2018 00:23:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 2 Feb 2018 00:23:45 -0800 (PST)
In-Reply-To: <20180124095357.19645-3-pclouds@gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-3-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Feb 2018 03:23:45 -0500
X-Google-Sender-Auth: R1ftFHKY18pgrfziMp-sRaMk7cM
Message-ID: <CAPig+cQzdFhUzwDykO8su=ne0qZr6=51vTxXbMYYnceuH_N=iw@mail.gmail.com>
Subject: Re: [PATCH 2/7] worktree.c: add update_worktree_location()
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
> diff --git a/worktree.c b/worktree.c
> @@ -326,6 +326,24 @@ int validate_worktree(const struct worktree *wt, str=
uct strbuf *errmsg)
> +void update_worktree_location(struct worktree *wt, const char *path_)
> +{
> +       struct strbuf path =3D STRBUF_INIT;
> +
> +       if (is_main_worktree(wt))
> +               die("BUG: can't relocate main worktree");
> +
> +       strbuf_add_absolute_path(&path, path_);
> +       if (fspathcmp(wt->path, path.buf)) {
> +               write_file(git_common_path("worktrees/%s/gitdir",
> +                                          wt->id),
> +                          "%s/.git", real_path(path.buf));

For the path stored in 'worktrees/<id>/gitdir' (and in wt->path), this
and other worktree-related code sometimes treats it only as "absolute
path" and sometimes as "real path". As a reviewer, I'm having trouble
understanding the logic of why, how, and when this distinction is
made. Can you explain a bit to help clarify when "absolute path" is
good enough and when "real path" is needed?

> +               free(wt->path);
> +               wt->path =3D strbuf_detach(&path, NULL);
> +       }
> +       strbuf_release(&path);
> +}
