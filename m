Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C9C433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526FD61244
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbhJDN5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbhJDN4s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AE9C0617B1
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:46:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 66so16168017pgc.9
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yFEN24KoOqcXVFg5Y8xfyVdXDDwup78pT10YFgS2AmA=;
        b=kNftLNtAUcCX3WJ9wWyUxAqLWHLR6lGHUXXrpysbCmyRKYg7MYpdu7dY7MSg3ijpVi
         xdAbbPj0X2AYz3EtkNzfENrB1KRZxMw6Q+QFPaF5BFEdS2jxNs0If8GURJkf96D6hOq/
         +Fs2PwTqpUy6uwXBbDcEX/mEJXskEez6Q9XEy/V5p4xHC5u4r6GFgNZ/+ATpHOTIotp2
         xGcziwPsx/GdNs723l9KD5H512ZfCItf87ZNvoI7pdR9l6MOgcCKkuoe8oomXkPWsUdq
         j7VLYjWqZQN+HZQ21gOl5lQbbx0DKlZOjxaRjAUUUbnlKLToIuvD1mVH8Pt4ld0fy0HN
         /dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yFEN24KoOqcXVFg5Y8xfyVdXDDwup78pT10YFgS2AmA=;
        b=oI2WVmxSQzYVl7EyRXXCG+X+d7l8whSRjkBNVSMFJPDEzyqYkLdj4bg0wt7yVF5JaH
         aKjFoRzrvWJHHx1+be06aM43Er3m5Uz0OTfo4vHPL10xCBQL8sLdCOYxt3aaPu5/mEV8
         WbNpwIM7o4bE2OqaDtGRQ71GiIHap1CIk0WNXFEjloImbJ3icpDfghD3U6J/Ahta23lD
         q+OzqWt0cjxlLj/2j+4jkrXGqe4c456OZpi/98sB3e/PqvUfA5OoFaEUmc8DfTcdoS5h
         j6nv1zD+VEW7PAfcjefXYCuXXoZ1dSsmJhpoARdjP+pCLo0b2YJeD5ljtbB+8zWq8Gsc
         B3Zg==
X-Gm-Message-State: AOAM531mPtLBr5CRShzZ62rSsdGPQOaVWf9BEXA4mRKxQjRwB7+17Afg
        5xXQ3AMb+Qj2RP45mkmKHOdWyfKT7XGMmX5wN9k=
X-Google-Smtp-Source: ABdhPJzB+CGNB8BiFlNaa3n8MgwilijHdBEoUURMcSFiFdzBgs/9S0YhYz1zO7Ls91KbDWKt7bXAkD5XaQkFMIdHo5o=
X-Received: by 2002:a62:7c04:0:b0:44b:e071:2089 with SMTP id
 x4-20020a627c04000000b0044be0712089mr24955525pfc.80.1633355209639; Mon, 04
 Oct 2021 06:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com> <patch-07.10-646e610d8dd-20211004T002226Z-avarab@gmail.com>
In-Reply-To: <patch-07.10-646e610d8dd-20211004T002226Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 06:45:00 -0700
Message-ID: <CABPp-BHQVimcO_E=OPjojJCQ_wfV6+Wy+-2QMTAqnYDk1z3PYQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] unpack-trees API: rename clear_unpack_trees_porcelain()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Since a preceding commit we've been using
> clear_unpack_trees_porcelain() to call dir_clear(). So it's no longer
> a function that corresponds to setup_unpack_trees_porcelain(), as it
> was when it was added in 1c41d2805e4 (unpack_trees_options: free
> messages when done, 2018-05-21).
>
> Instead it's similar to strbuf_release() and other similar generic
> "free" functions. Let's rename it to avoid any future confusion on the
> topic.
>
> Let's also update the API documentation for it to note this, and to
> cover e.g. the code added around update_sparsity() in
> 4ee5d50fc39 (sparse-checkout: use improved unpack_trees porcelain
> messages, 2020-03-27).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/checkout.c        | 2 +-
>  builtin/sparse-checkout.c | 2 +-
>  merge-ort.c               | 2 +-
>  merge-recursive.c         | 2 +-
>  merge.c                   | 4 ++--
>  reset.c                   | 2 +-
>  unpack-trees.c            | 2 +-
>  unpack-trees.h            | 8 +++++---
>  8 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index d4b88affba7..482d17676a0 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -757,7 +757,7 @@ static int merge_working_tree(const struct checkout_o=
pts *opts,
>                 init_tree_desc(&trees[1], tree->buffer, tree->size);
>
>                 ret =3D unpack_trees(2, trees, &topts);
> -               clear_unpack_trees_porcelain(&topts);
> +               unpack_trees_options_release(&topts);
>                 if (ret =3D=3D -1) {
>                         /*
>                          * Unpack couldn't do a trivial merge; either
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 4c3c29fb580..b1221fd01d3 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -219,7 +219,7 @@ static int update_working_directory(struct pattern_li=
st *pl)
>
>         setup_unpack_trees_porcelain(&o, "sparse-checkout");
>         result =3D update_sparsity(&o);
> -       clear_unpack_trees_porcelain(&o);
> +       unpack_trees_options_release(&o);
>
>         if (result =3D=3D UPDATE_SPARSITY_WARNINGS)
>                 /*
> diff --git a/merge-ort.c b/merge-ort.c
> index e526b78b88d..0a5937364c9 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4054,7 +4054,7 @@ static int checkout(struct merge_options *opt,
>         init_tree_desc(&trees[1], next->buffer, next->size);
>
>         ret =3D unpack_trees(2, trees, &unpack_opts);
> -       clear_unpack_trees_porcelain(&unpack_opts);
> +       unpack_trees_options_release(&unpack_opts);
>         return ret;
>  }
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index a77f66b006c..316cb2ca907 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -441,7 +441,7 @@ static int unpack_trees_start(struct merge_options *o=
pt,
>  static void unpack_trees_finish(struct merge_options *opt)
>  {
>         discard_index(&opt->priv->orig_index);
> -       clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
> +       unpack_trees_options_release(&opt->priv->unpack_opts);
>         unpack_trees_options_init(&opt->priv->unpack_opts);
>  }
>
> diff --git a/merge.c b/merge.c
> index 9cb32990dd9..2f618425aff 100644
> --- a/merge.c
> +++ b/merge.c
> @@ -95,10 +95,10 @@ int checkout_fast_forward(struct repository *r,
>
>         if (unpack_trees(nr_trees, t, &opts)) {
>                 rollback_lock_file(&lock_file);
> -               clear_unpack_trees_porcelain(&opts);
> +               unpack_trees_options_release(&opts);
>                 return -1;
>         }
> -       clear_unpack_trees_porcelain(&opts);
> +       unpack_trees_options_release(&opts);
>
>         if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
>                 return error(_("unable to write new index file"));
> diff --git a/reset.c b/reset.c
> index d13984ab781..f4bf3fbfac0 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -133,7 +133,7 @@ int reset_head(struct repository *r, struct object_id=
 *oid, const char *action,
>  leave_reset_head:
>         strbuf_release(&msg);
>         rollback_lock_file(&lock);
> -       clear_unpack_trees_porcelain(&unpack_tree_opts);
> +       unpack_trees_options_release(&unpack_tree_opts);
>         while (nr)
>                 free((void *)desc[--nr].buffer);
>         return ret;
> diff --git a/unpack-trees.c b/unpack-trees.c
> index e7365322e82..bea598c9ece 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -193,7 +193,7 @@ void unpack_trees_options_init(struct unpack_trees_op=
tions *o)
>         memcpy(o, &blank, sizeof(*o));
>  }
>
> -void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
> +void unpack_trees_options_release(struct unpack_trees_options *opts)
>  {
>         strvec_clear(&opts->msgs_to_free);
>         dir_clear(&opts->dir);
> diff --git a/unpack-trees.h b/unpack-trees.h
> index 40c4841748d..a8d1f083b33 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -41,10 +41,12 @@ enum unpack_trees_error_types {
>  void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>                                   const char *cmd);
>
> -/*
> - * Frees resources allocated by setup_unpack_trees_porcelain().
> +/**
> + * Frees resources allocated by function that take the "struct
> + * unpack_trees_options". Always call this after using unpack_trees(),
> + * update_sparsity() etc.
>   */
> -void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
> +void unpack_trees_options_release(struct unpack_trees_options *opts);
>
>  struct unpack_trees_options {
>         unsigned int reset,
> --
> 2.33.0.1404.g83021034c5d

Makes sense.
