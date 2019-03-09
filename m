Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CC020248
	for <e@80x24.org>; Sat,  9 Mar 2019 18:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCISNv (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 13:13:51 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39855 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCISNv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 13:13:51 -0500
Received: by mail-vk1-f196.google.com with SMTP id i68so169877vke.6
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 10:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dN4EkumAEJkL8wrVcHTs1Ru3GdkOw9+IWKrezlcnED4=;
        b=ljAvrN0+Nmh4sGuseuQwWrjWJncX8lTKJEbtFk/Vt2/X90TJIugPP4bovP1ktOnAMM
         jNn8dBdFF56QJPgxbjthTcbX9MlAq3aifXwZUzK7LWErv5tg3fMyvp4BLOl3ZreNJvGM
         mVeH4IlpH/uinXLQUBGm3bhLZIPbBpYQ4ct7KVhvmivpGyZy3prl3YOZWFrw5vpoznB+
         SHdxnJgO5cQ6wqDPjC4Eb2EXvSXGSTSXtEiWDjpfJpxYRu4fpkJ4Azk0g630Ouw0IbIu
         32Lwr8PfxvYomduZy+07RzdBvYKcl+9YT9XbpSKst2zp7vH2QFXSgOQMJsSjHF2I+yfw
         mMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dN4EkumAEJkL8wrVcHTs1Ru3GdkOw9+IWKrezlcnED4=;
        b=VT/TE69tHQZHkMXccvx5Pe5iUROcWt8ienyQOyrMhXr2E+WEqFTY/1UxituEb8cuP/
         jqwAKS2atc7i0OgJjav9HdBujLnsKhakjEd2uO/vYqg3CJL3p1Iyxct1c/x/4KhMk2uM
         9p4sJ7VcbTJdKEz8dUT1TFhOIWT7h6QYWRfcr/01qaA7APbPkCUSfJdTrMhombch8LHy
         sGvFah5s9nxla8i1H/NPlo0YILV8SfKZVVSFERE9N3A08Syp8m531F/zFcZgXUeLX7dk
         2WOYLIGY2y4AqjXv9PFFLBeYr9BhTJP3XnXs5pIBOOYedV+MKJuyGC3QobS8yXhLfmD5
         xvRw==
X-Gm-Message-State: APjAAAWXHIYp+xluSr1LnZUPMU0YVSFfdwYoWRBhh5A+d+mKBdcBgPdM
        9t6r4GJLKN1TrNmCEddPKOE2UdOsC8qZ/wuz1hk=
X-Google-Smtp-Source: APXvYqy9Wvoq/cTiQEVJtHhcT//VEZ60tdZoaJOdFqaoEnKyKT6EZasvtrrb4DH2IKD5G2Ih2SOlrmzwoxxPHcqEhXE=
X-Received: by 2002:a1f:a0d7:: with SMTP id j206mr12351103vke.37.1552155229396;
 Sat, 09 Mar 2019 10:13:49 -0800 (PST)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-3-pclouds@gmail.com>
In-Reply-To: <20190308101655.9767-3-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Mar 2019 10:13:38 -0800
Message-ID: <CABPp-BHwp_36Pc-xbCC0_t=uO3td1fn0KYjQ9N2esznJpRt3ig@mail.gmail.com>
Subject: Re: [PATCH v1 02/11] restore: take tree-ish from --source option instead
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
> This is another departure from 'git checkout' syntax, which uses -- to
> separate ref and pathspec. The observation is restore (or "git
> checkout ,, <pathspec>") is most often used to restore some files from
> the index. If this is correct, we can simplify it by taking a way the
> ref, so that we can write
>
>     git restore some-file
>
> without worrying about some-file being a ref and whether we need to do
>
>     git restore -- some-file
>
> for safety. If the source of the restore comes from a tree, it will be
> in the form of an option with value, e.g.
>
>     git restore --source=3Dthis-tree some-file
>
> This is of course longer to type than using "--". But hopefully it
> will not be used as often, and it is clearly easier to understand.
>
> dwim_new_local_branch is no longer set (or unset) in cmd_restore_files()
> because it's irrelevant because we don't really care about dwim-ing.
> With accept_ref being unset, dwim can't happen.

Nice.  :-)

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/checkout.c | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 11dd2ae44c..838343d6aa 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -38,7 +38,7 @@ static const char * const switch_branch_usage[] =3D {
>  };
>
>  static const char * const restore_files_usage[] =3D {

restore_files_usage or restore_usage?

> -       N_("git restore [<options>] [<branch>] -- <file>..."),
> +       N_("git restore [<options>] [--source=3D<branch>] <file>..."),
>         NULL,
>  };
>
> @@ -57,6 +57,7 @@ struct checkout_opts {
>         int count_checkout_paths;
>         int overlay_mode;
>         int dwim_new_local_branch;
> +       int accept_ref;
>         int accept_pathspec;
>         int switch_branch_doing_nothing_is_ok;
>         int only_merge_on_switching_branches;
> @@ -72,6 +73,7 @@ struct checkout_opts {
>         int branch_exists;
>         const char *prefix;
>         struct pathspec pathspec;
> +       const char *from_treeish;
>         struct tree *source_tree;
>  };
>
> @@ -1324,6 +1326,7 @@ static int checkout_main(int argc, const char **arg=
v, const char *prefix,
>  {
>         struct branch_info new_branch_info;
>         int dwim_remotes_matched =3D 0;
> +       int parseopt_flags =3D 0;
>
>         memset(&new_branch_info, 0, sizeof(new_branch_info));
>         opts->overwrite_ignore =3D 1;
> @@ -1335,8 +1338,13 @@ static int checkout_main(int argc, const char **ar=
gv, const char *prefix,
>
>         opts->track =3D BRANCH_TRACK_UNSPECIFIED;
>
> -       argc =3D parse_options(argc, argv, prefix, options, usagestr,
> -                            PARSE_OPT_KEEP_DASHDASH);
> +       if (!opts->accept_pathspec && !opts->accept_ref)
> +               BUG("make up your mind, you need to take _something_");

hehe.  I secretly hope that someone eventually hits that, preferably
another git developer making some changes and not an end user, though.


> +       if (opts->accept_pathspec && opts->accept_ref)
> +               parseopt_flags =3D PARSE_OPT_KEEP_DASHDASH;
> +
> +       argc =3D parse_options(argc, argv, prefix, options,
> +                            usagestr, parseopt_flags);
>
>         if (opts->show_progress < 0) {
>                 if (opts->quiet)
> @@ -1393,7 +1401,7 @@ static int checkout_main(int argc, const char **arg=
v, const char *prefix,
>          * including "last branch" syntax and DWIM-ery for names of
>          * remote branches, erroring out for invalid or ambiguous cases.
>          */
> -       if (argc) {
> +       if (argc && opts->accept_ref) {
>                 struct object_id rev;
>                 int dwim_ok =3D
>                         !opts->patch_mode &&
> @@ -1405,6 +1413,18 @@ static int checkout_main(int argc, const char **ar=
gv, const char *prefix,
>                                              &dwim_remotes_matched);
>                 argv +=3D n;
>                 argc -=3D n;
> +       } else if (!opts->accept_ref && opts->from_treeish) {
> +               struct object_id rev;
> +
> +               if (get_oid_mb(opts->from_treeish, &rev))

Going on a slight tangent from your series: get_oid_mb really deserves
a comment somewhere that "mb" is "merge base".  I had to spelunk
through history to find it...

> +                       die(_("could not resolve %s"), opts->from_treeish=
);
> +
> +               setup_new_branch_info_and_source_tree(&new_branch_info,
> +                                                     opts, &rev,
> +                                                     opts->from_treeish)=
;
> +
> +               if (!opts->source_tree)
> +                       die(_("reference is not a tree: %s"), opts->from_=
treeish);
>         }
>
>         if (argc) {
> @@ -1488,6 +1508,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
>         opts.dwim_new_local_branch =3D 1;
>         opts.switch_branch_doing_nothing_is_ok =3D 1;
>         opts.only_merge_on_switching_branches =3D 0;
> +       opts.accept_ref =3D 1;
>         opts.accept_pathspec =3D 1;
>         opts.implicit_detach =3D 1;
>
> @@ -1519,6 +1540,7 @@ int cmd_switch(int argc, const char **argv, const c=
har *prefix)
>
>         memset(&opts, 0, sizeof(opts));
>         opts.dwim_new_local_branch =3D 0;
> +       opts.accept_ref =3D 1;
>         opts.accept_pathspec =3D 0;
>         opts.switch_branch_doing_nothing_is_ok =3D 0;
>         opts.only_merge_on_switching_branches =3D 1;
> @@ -1537,15 +1559,19 @@ int cmd_switch(int argc, const char **argv, const=
 char *prefix)
>  int cmd_restore(int argc, const char **argv, const char *prefix)
>  {
>         struct checkout_opts opts;
> -       struct option *options =3D NULL;
> +       struct option *options;
> +       struct option restore_options[] =3D {
> +               OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>=
",
> +                          N_("where the checkout from")),
> +               OPT_END()
> +       };
>         int ret;
>
>         memset(&opts, 0, sizeof(opts));
> -       opts.dwim_new_local_branch =3D 1;
> -       opts.switch_branch_doing_nothing_is_ok =3D 0;
> +       opts.accept_ref =3D 0;
>         opts.accept_pathspec =3D 1;
>
> -       options =3D parse_options_dup(options);
> +       options =3D parse_options_dup(restore_options);
>         options =3D add_common_options(&opts, options);
>         options =3D add_checkout_path_options(&opts, options);
>
> --
> 2.21.0.rc1.337.gdf7f8d0522
>
