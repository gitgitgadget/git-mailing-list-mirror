Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C3F920248
	for <e@80x24.org>; Sat,  9 Mar 2019 18:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCISiI (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 13:38:08 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39841 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCISiH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 13:38:07 -0500
Received: by mail-vs1-f68.google.com with SMTP id w14so479794vso.6
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 10:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TiNZohXnV0eKP5+1AV/idhaONWUHv6A+rwP2zzUH1hg=;
        b=f1t4qOJKxpqJnpXFvFkEQjMd9NhbRKHgb49/fzCLQTedlRZfB2NOBjftMEF12wDRV2
         YWvD8XdgtGzgbV3e+xTq+1hzJUfhJ75miDaMUDgb65cBSsRr+qLuqhUhq2u8RBh5xD74
         ph7Td0qqHP6OX3SNRncRD/ITNM0jpYMTY4w2TLhQphz20w9fJzEjt1auw6ImugqsjRKr
         PeDVZ5YiHLhmNL+R1VLTKUYfiX4RWj8udJ0QH7ECPjAbGcS5j9We9wvO2NdeuT32X4Zl
         frFRqR2jPuEvGm9rhz+cQb9rVvFPSCdyqFv95eHwY1gwqrxRI1c4aM8UT1hiRE7C5Txr
         wzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TiNZohXnV0eKP5+1AV/idhaONWUHv6A+rwP2zzUH1hg=;
        b=SbnS9SNjVNs68E2vtYFMEl+m5/GozU8MCBAISsAaHYUI3UqwWC/Uba7VczojVfM6zU
         toitjSDzuubU1XN+MM9T264bOE/AlWeR/HdTaxtFf8rF+M01tz/Ap1lKwx3StllIRKf7
         tLGrifxOm6UyjtX+/1nhuMnU9OnXx1as9/p56d6BDHUZkrcqkvl9hBprC7Tp2k/5RyD/
         zZ0Tfn0lJtoY13Qqz4tgDzzSqRZ2Sha/q2Ms90O1t0vbRAGSPFAC0StAfCi0CqNKvIJi
         lNP29TqG1rGbk7ytMvbX55PXGIbc6CoFEYoo9LB/3GKuhwaqHcqMlqx/RsvausibV114
         H2qw==
X-Gm-Message-State: APjAAAVw7L9K2Fs1aSusfieJ8jHFmZ7V1/ve8wJDY63HmMS6Cd7Cr10s
        3hnJ82VBr5f6AbWQeP8cChhr9MJLOhrwnZ9SLRI=
X-Google-Smtp-Source: APXvYqwyTUY+R35g6rEXWQQ6NhCMxVhokcgisspCBMvY5k3SUzD0aMskrRlSx2QO/CDEx81LsXLocxz7ArJmPNMRevc=
X-Received: by 2002:a67:3052:: with SMTP id w79mr12871642vsw.116.1552156686244;
 Sat, 09 Mar 2019 10:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-5-pclouds@gmail.com>
In-Reply-To: <20190308101655.9767-5-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Mar 2019 10:37:55 -0800
Message-ID: <CABPp-BGG-QcUp+RWVTVBXfQqRJ1n8sc_nFNK1Pr-y=x-aAqODw@mail.gmail.com>
Subject: Re: [PATCH v1 04/11] restore: disable overlay mode by default
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 2:17 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
>
> Overlay mode is considered confusing when the command is about
> restoring files on worktree. Disable it by default. The user can still
> turn it on, or use 'git checkout' which still has overlay mode on by
> default.
>
> While at there make the check in checkout_branch() stricter. Neither
> --overlay or --no-overlay should be accepted in branch switching mode.

s/While at there/While at it,/ ?

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/checkout.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index c52ce13d2a..9e59bf792f 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1196,9 +1196,9 @@ static int checkout_branch(struct checkout_opts *op=
ts,
>                 die(_("'%s' cannot be used with switching branches"),
>                     "--patch");
>
> -       if (!opts->overlay_mode)
> +       if (opts->overlay_mode !=3D -1)
>                 die(_("'%s' cannot be used with switching branches"),
> -                   "--no-overlay");
> +                   "--[no]-overlay");
>
>         if (opts->writeout_stage)
>                 die(_("'%s' cannot be used with switching branches"),
> @@ -1313,7 +1313,6 @@ static struct option *add_checkout_path_options(str=
uct checkout_opts *opts,
>                 OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunk=
s interactively")),
>                 OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_sk=
ipworktree,
>                          N_("do not limit pathspecs to sparse entries onl=
y")),
> -               OPT_BOOL(0, "overlay", &opts->overlay_mode, N_("use overl=
ay mode (default)")),
>                 OPT_END()
>         };
>         struct option *newopts =3D parse_options_concat(prevopts, options=
);
> @@ -1333,7 +1332,6 @@ static int checkout_main(int argc, const char **arg=
v, const char *prefix,
>         opts->overwrite_ignore =3D 1;
>         opts->prefix =3D prefix;
>         opts->show_progress =3D -1;
> -       opts->overlay_mode =3D -1;
>
>         git_config(git_checkout_config, opts);
>
> @@ -1505,6 +1503,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
>                 OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create refl=
og for new branch")),
>                 OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
>                          N_("second guess 'git checkout <no-such-branch>'=
 (default)")),
> +               OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overla=
y mode (default)")),
>                 OPT_END()
>         };
>         int ret;
> @@ -1517,6 +1516,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
>         opts.accept_pathspec =3D 1;
>         opts.implicit_detach =3D 1;
>         opts.empty_pathspec_ok =3D 1;
> +       opts.overlay_mode =3D -1;
>
>         options =3D parse_options_dup(checkout_options);
>         options =3D add_common_options(&opts, options);
> @@ -1551,6 +1551,7 @@ int cmd_switch(int argc, const char **argv, const c=
har *prefix)
>         opts.switch_branch_doing_nothing_is_ok =3D 0;
>         opts.only_merge_on_switching_branches =3D 1;
>         opts.implicit_detach =3D 0;
> +       opts.overlay_mode =3D -1;
>
>         options =3D parse_options_dup(switch_options);
>         options =3D add_common_options(&opts, options);
> @@ -1569,6 +1570,7 @@ int cmd_restore(int argc, const char **argv, const =
char *prefix)
>         struct option restore_options[] =3D {
>                 OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>=
",
>                            N_("where the checkout from")),
> +               OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overla=
y mode")),
>                 OPT_END()
>         };
>         int ret;
> @@ -1577,6 +1579,7 @@ int cmd_restore(int argc, const char **argv, const =
char *prefix)
>         opts.accept_ref =3D 0;
>         opts.accept_pathspec =3D 1;
>         opts.empty_pathspec_ok =3D 0;
> +       opts.overlay_mode =3D 0;
>
>         options =3D parse_options_dup(restore_options);
>         options =3D add_common_options(&opts, options);
> --
> 2.21.0.rc1.337.gdf7f8d0522

The rest all looks good.
