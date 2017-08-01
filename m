Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE2E2047F
	for <e@80x24.org>; Tue,  1 Aug 2017 18:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbdHASXi (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 14:23:38 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:38756 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdHASXi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 14:23:38 -0400
Received: by mail-lf0-f54.google.com with SMTP id y15so10401408lfd.5
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4QDZwfkXcCQlOp/n3539c72Y1oaiPVrTmKejsr8TerY=;
        b=H8CYhkgcB3r1u4MhGNdsJVRCv6lzx62PnBwamUEDuymH89jQHvLkdgmzyeeDoHR9da
         pH5bQ9hFO0wsXK4KRU5PjlkpHpjZsPIJ54LeTiwKMjkxesklS0O3K1cHrDnCgFIxs/99
         ETY1iwvWvP2Nf1J1vU2xBktwb0FuqqG5qLjgQTK5eoY3oZCDEHsZWxXqU4PhMEnj790b
         SNJinW1x8GTs8eBNbkBEa8K9wVyQLV+DkqAH3WCrGKC5jXS//X1hmFQaCGP86eBsGlgd
         JED6UnZ/1KERzRxSNyI7vyc1N3n5zO+1zzwSVcy8v0g3cRs5VJhOk6D1OP1ArbOf6n0U
         9+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4QDZwfkXcCQlOp/n3539c72Y1oaiPVrTmKejsr8TerY=;
        b=pQPqNCJ7a38zrBIficVe9Zl6ziHnpczH5lzO/RG/qZmhfwHRryHiz3zS1MD+W+g2Ny
         7dHigLejJQYxn7bVt924bNEWXf1S5x4KXRjzpdgQAleN9jJqoc6MzzMzl6rxyEycu6YQ
         lbYqcW9YEzYxvQkAdwhGAxpF3WGn4+QcDj10DqGC7TsBmCnC39QAsEq7GrC6uGGjztyh
         WVX/8Fm7IJ7oR4oreJKr0rQTFQbwuzee1+wTWoXcxAC3NNUWj8vrJ37LCX4NsKKDclAZ
         SZBUjESMSV/vfEK3stoV2jkhMfT7TBZDm3dW2j1TEJXkuVxX7UqVLdxEwUvidKem0MaK
         uvnw==
X-Gm-Message-State: AIVw111r4BITxNWThjGMUjIR/7Xm1TMulH6tsDMhU5GsivcW3QJqYM9z
        cvVdtqoYgVMMqiWsiQu/0AyL8jvN4g==
X-Received: by 10.25.15.74 with SMTP id e71mr3808327lfi.13.1501611816845; Tue,
 01 Aug 2017 11:23:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.0.131 with HTTP; Tue, 1 Aug 2017 11:23:36 -0700 (PDT)
In-Reply-To: <20160625075433.4608-8-pclouds@gmail.com>
References: <20160625075433.4608-1-pclouds@gmail.com> <20160625075433.4608-8-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 1 Aug 2017 14:23:36 -0400
X-Google-Sender-Auth: kxrn5m8sX0FyrKTmy_5hL556VgA
Message-ID: <CAPig+cRs0V8O7F1N9yQd6vC8nBabfiOEyOSoP61J5o+gB+KXig@mail.gmail.com>
Subject: Re: [PATCH 07/10] worktree.c: add update_worktree_location()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 25, 2016 at 3:54 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/worktree.c b/worktree.c
> +int update_worktree_location(struct worktree *wt, const char *path_)
> +{
> +       struct strbuf path =3D STRBUF_INIT;
> +       int ret =3D 0;
> +
> +       if (is_main_worktree(wt))
> +               return 0;
> +
> +       strbuf_add_absolute_path(&path, path_);
> +       if (fspathcmp(wt->path, path.buf)) {
> +               if (!write_file_gently(git_common_path("worktrees/%s/gitd=
ir",
> +                                                      wt->id),
> +                                      "%s/.git", real_path(path.buf))) {
> +                       free(wt->path);
> +                       wt->path =3D strbuf_detach(&path, NULL);
> +                       ret =3D 0;

Useless assignment?

> +               } else
> +                       ret =3D error_errno(_("failed to update '%s'"),
> +                                         git_common_path("worktrees/%s/g=
itdir",
> +                                                         wt->id));
> +       }
> +       strbuf_release(&path);
> +       return ret;
> +}
