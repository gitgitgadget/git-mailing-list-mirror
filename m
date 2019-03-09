Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40D4A20248
	for <e@80x24.org>; Sat,  9 Mar 2019 18:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCISfy (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 13:35:54 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41305 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfCISfy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 13:35:54 -0500
Received: by mail-vs1-f68.google.com with SMTP id m20so475911vsq.8
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 10:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=naqvYvXbsw6MNntwqu+B4o6rILRhgzFfrV6dlbUx6Ew=;
        b=lPLYIteCUdyEeq976+9HAySz1BEnaC4Glnl9vSnZ0DsKBPr7GOq+eIQym90+wCjIem
         kHDXMn5oGTUBn6ozkwuNoZ5LQVgImtWpbMeoTCub4vhIZCweLqOW8+2dVufKZ0wiYMY3
         sRsWrDVjytaDI9bbZCm2f1P4zP9d1VqtSWbKrWLaTlDeB5/HcwwySdOpR/gjPtjTunNw
         jAWuu5S0Xj5/d/oTIkV2ZWeL1k/kSldxTuq+2MZA+eeRODMiQPw3+sgSp9o1DTn9QsOH
         gY7e3I6/gyF/FQdHLdE4zrF71gNR1jn+VJKtQpP+czHOQZapqy/3rgm6SaRJLEPHkkoL
         hypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=naqvYvXbsw6MNntwqu+B4o6rILRhgzFfrV6dlbUx6Ew=;
        b=OWciA4ApbrK5Xi8a2yfv/R3/XGB8vokkjHAKzXW8nOFxPw7g52zqjYQTGZmWERF6sF
         DhBsKG/USllMdHaiXrPATgUGK3aJyFb/QcI1LCVVKZKzFdENQJYUpKzlpQ08PG6zw5ka
         7UCObUVAqLqkCFyGHUwSZJF5MaD3Szn2UKGW5Jpi6/BiSPTyBh8A2YDbCpiMeP3FMRhS
         BRiFeePtsA2iMaejkPzRz/Cv9TSUU4JHbwWozR3u83UZrHKtpNULKZAP/szNxf2ikahf
         B+EiTqsFHqsmgxKRv4ETiySlgdTHMh7iQodOidOs1HzrVsieW7EDgYwhXZtfbkW8FoOm
         pAoQ==
X-Gm-Message-State: APjAAAVBb+iA72SttVFl0JkAHHwIj01wo4ey/FA1YRCw0PSqwai2m61t
        900OxNX0NC1ex8wEqjRIYspuk2NVesii4FFwGWA=
X-Google-Smtp-Source: APXvYqwve9cj3VoDNJZ5t5vGjWCgHVduQyDqYqW8vSLnM1YdXUGc7NL15dpxlRJsx3cCFUoZ96X7Np8HEwQsEs56IsY=
X-Received: by 2002:a67:f8cc:: with SMTP id c12mr12773516vsp.136.1552156552603;
 Sat, 09 Mar 2019 10:35:52 -0800 (PST)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-4-pclouds@gmail.com>
In-Reply-To: <20190308101655.9767-4-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Mar 2019 10:35:41 -0800
Message-ID: <CABPp-BFo2XMg4VMBE=5XmtJq+bmAyBFD6e5ofwvjQndJy=Vr3A@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] restore: make pathspec mandatory
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
> "git restore" without arguments does not make much sense when
> it's about restoring files (what files now?). We could default to
> either
>
>     git restore .
>
> or
>
>     git restore :/
>
> Neither is intuitive. Make the user always give pathspec, force the
> user to think the scope of restore they want because this is a
> destructive operation.
>
> "git restore -p" without pathspec is an exception to this
> because it really is a separate mode. It will be treated as running
> patch mode on the whole worktree.

This all sounds very good.

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  builtin/checkout.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 838343d6aa..c52ce13d2a 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -61,6 +61,7 @@ struct checkout_opts {
>         int accept_pathspec;
>         int switch_branch_doing_nothing_is_ok;
>         int only_merge_on_switching_branches;
> +       int empty_pathspec_ok;
>
>         const char *new_branch;
>         const char *new_branch_force;
> @@ -1427,6 +1428,10 @@ static int checkout_main(int argc, const char **ar=
gv, const char *prefix,
>                         die(_("reference is not a tree: %s"), opts->from_=
treeish);
>         }
>
> +       if (opts->accept_pathspec && !opts->empty_pathspec_ok && !argc &&
> +           !opts->patch_mode)  /* patch mode is special */
> +               die(_("pathspec is required"));

Maybe
   die(_("you must specify path(s) to restore"));
?  While "pathspec" is something we use in a few places, I don't think
users intuitively know what it is.  Also, I just looked up the manpage
again, and it looks like you use "pathspec" in the restore manpage,
but don't define it.

> +
>         if (argc) {
>                 parse_pathspec(&opts->pathspec, 0,
>                                opts->patch_mode ? PATHSPEC_PREFIX_ORIGIN =
: 0,
> @@ -1511,6 +1516,7 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
>         opts.accept_ref =3D 1;
>         opts.accept_pathspec =3D 1;
>         opts.implicit_detach =3D 1;
> +       opts.empty_pathspec_ok =3D 1;
>
>         options =3D parse_options_dup(checkout_options);
>         options =3D add_common_options(&opts, options);
> @@ -1570,6 +1576,7 @@ int cmd_restore(int argc, const char **argv, const =
char *prefix)
>         memset(&opts, 0, sizeof(opts));
>         opts.accept_ref =3D 0;
>         opts.accept_pathspec =3D 1;
> +       opts.empty_pathspec_ok =3D 0;
>
>         options =3D parse_options_dup(restore_options);
>         options =3D add_common_options(&opts, options);
> --
> 2.21.0.rc1.337.gdf7f8d0522
