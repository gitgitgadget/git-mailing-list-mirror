Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AE7C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 02:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DE7611CC
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 02:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbhJFCR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 22:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhJFCR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 22:17:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EF5C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 19:16:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l7so3885294edq.3
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 19:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLNm7DwSWGzZnCNyG9bwr1OutNzHQ4k39+Bj1D/wwPw=;
        b=AVRtKOFTxXW9k7STv9Gs01M4KrCZt1GFDWFauo332F0duCzSF7ARAjohIwl+6U96lc
         3vMXrLZ8XARVJvrEZMAxfoS3VnloHF9VLejgXcs3YwvRyEXKyIRF2uMISWkISt9P2FKo
         c6hitNEVYlKXf/s2WFbqbZNApeTvrZYetn3yCkbG2QI29ktxODseLyvcxKCjD6aNt0/Y
         b09zuBVyVa1khVIySSPLMdZr3+3cmUINgvEtzcYWGLW/jv4W16RNqNsa7dhy9hrhbfra
         8MVWz09X7mi2YRyP4Xeozyji7ewFyDnGid0vtkuQ5DjgF1aqxR9c/65/Iq41isR6jLAN
         ClZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLNm7DwSWGzZnCNyG9bwr1OutNzHQ4k39+Bj1D/wwPw=;
        b=SoJZRjoWUCsz4rfvtD1o/618jmsEBIMXZWBDVEpnMrl+95ft4IIPTpDez/83/H0h3B
         i1UHly/834xzVV0lcu2fo4UntBmbmYUi0A3CSylHWhB62HKG9GY3Lkhm6KWkx1omUfbx
         49jiWtl/UZePJZlnA2mPLjt9Ohjo4rdw0aNbpTvnPnGhqAuOX6lJbgJMjy3p42gQPwr8
         hOviUzRBC6DvxYeJ/nGQBW6OfsUlow/Y8rsF9mggQ0LjWg49Bk0CHJL1utkYoUVVLGC0
         IFVCvFyGR96iclXeUedNPldkM01zEoCeYCH35GAVCpTdTWk5PuO6sQBN3qM3oxBB7h8o
         6R9Q==
X-Gm-Message-State: AOAM531gix5ErnsjhMaxHcNSb5EsNob7QfJwRkb8JobHrcGk9yyoV57G
        YMhke7KSM9YjY9Ow71gCWJo8ytrAqXNFtnNeyMc=
X-Google-Smtp-Source: ABdhPJw82PkuXHFWvzRr9u/cLCKKIaUehQFjbgVYzNrUV/sCbAMF1PK7+1eTbxzMrR5EJlsaIL9XPXzDB9S8LFVqJLA=
X-Received: by 2002:a17:906:544f:: with SMTP id d15mr29425253ejp.520.1633486566301;
 Tue, 05 Oct 2021 19:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com> <49813c8d9ed94fd56f30eb204d346eb5a30473ca.1633440057.git.gitgitgadget@gmail.com>
In-Reply-To: <49813c8d9ed94fd56f30eb204d346eb5a30473ca.1633440057.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Oct 2021 19:15:55 -0700
Message-ID: <CABPp-BHKjLVpL_U5viVA++hCZmGKBHxnubGCk=1YhTkpFc-E-Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] reset: integrate with sparse index
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 5, 2021 at 6:21 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> `reset --soft` does not modify the index, so no compatibility changes are
> needed for it to function without expanding the index. For all other reset
> modes (`--mixed`, `--hard`, `--keep`, `--merge`), the full index is
> explicitly expanded with `ensure_full_index` to maintain current behavior.

"to maintain current behavior"?  You are changing code here, which
suggests some kind of behavior is changing, but that description seems
to be claiming the opposite.  Is it some kind of preventative change
to add ensure_full_index calls in an additional place, with a later
patch in the series intending to remove the other one(s), so you're
making sure that later changes won't cause unwanted behavioral
changes?  Or was something else meant here?

If the above wasn't what you meant, but you're adding
ensure_full_index calls, does that suggest that we had some important
code paths that were not protected by such calls?  I thought Stolee
said we had them all covered (at least to the best of our knowledge),
so I'm curious if we just discovered we missed some.  If so, are there
other codepaths like this one where we missed protective
ensure_full_index calls?

> Additionally, the `read_cache()` check verifying an uncorrupted index is
> moved after argument parsing and preparing the repo settings. The index is
> not used by the preceding argument handling, but `read_cache()` does need to
> be run after enabling sparse index for the command and before resetting.

This seems to be discussing what code changes are being made, but not
why.  I'm guessing at the reasoning, but is it something along the
lines of:

"""
Also, make sure to read_cache() after setting
command_requires_full_index = 0, so that we don't unnecessarily expand
the index as part of our early index-corruption check.
"""

?

>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/reset.c | 10 +++++++---
>  cache-tree.c    |  1 +
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 3b75d3b2f20..e1f2a2bb2c4 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -184,6 +184,7 @@ static int read_from_tree(const struct pathspec *pathspec,
>         opt.flags.override_submodule_config = 1;
>         opt.repo = the_repository;
>
> +       ensure_full_index(&the_index);
>         if (do_diff_cache(tree_oid, &opt))
>                 return 1;
>         diffcore_std(&opt);
> @@ -261,9 +262,6 @@ static void parse_args(struct pathspec *pathspec,
>         }
>         *rev_ret = rev;
>
> -       if (read_cache() < 0)
> -               die(_("index file corrupt"));
> -
>         parse_pathspec(pathspec, 0,
>                        PATHSPEC_PREFER_FULL |
>                        (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
> @@ -409,6 +407,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>         if (intent_to_add && reset_type != MIXED)
>                 die(_("-N can only be used with --mixed"));
>
> +       prepare_repo_settings(the_repository);
> +       the_repository->settings.command_requires_full_index = 0;
> +
> +       if (read_cache() < 0)
> +               die(_("index file corrupt"));
> +
>         /* Soft reset does not touch the index file nor the working tree
>          * at all, but requires them in a good order.  Other resets reset
>          * the index file to the tree object we are switching to. */
> diff --git a/cache-tree.c b/cache-tree.c
> index 90919f9e345..9be19c85b66 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -776,6 +776,7 @@ void prime_cache_tree(struct repository *r,
>         cache_tree_free(&istate->cache_tree);
>         istate->cache_tree = cache_tree();
>
> +       ensure_full_index(istate);
>         prime_cache_tree_rec(r, istate->cache_tree, tree);
>         istate->cache_changed |= CACHE_TREE_CHANGED;
>         trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
> --
> gitgitgadget
>
