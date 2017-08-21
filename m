Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28830208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 21:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbdHUVQb (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 17:16:31 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:36804 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753695AbdHUVQa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 17:16:30 -0400
Received: by mail-yw0-f174.google.com with SMTP id y64so13586445ywf.3
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 14:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eQNwZk4qbuz8Mp8P2CniVr48GnnJgzlr45zxjfXDY1Q=;
        b=p1pB2HmAyen4oLMy21ItT4Ygpz5QkLUg9qzx1fFBvZS6g94q5NEdzzAYZaT6QAxZI+
         0VkZ0HCrM0BcfaYQCcLLAkahyC88MxcKUIcvwp+fyMoc9j+yZuhG2X4yKtreIVgQg7pl
         QnUM5rAUbUe7Y6Hg+qctYMNPtlR+Urja4hrohehvJI4cNnREcHTsG9OUVCU2zokbL1CW
         /HUOifwsH2pUEBaXfCCUB8SmEG/3KoTlOSHCxSyLDEPfm0y1hb3r5QG2nw70NYqdac1O
         DDrknXgv4uJzUtWtpXmtQRPuCLVeceKIWYf1Ho2NLOtJv2vFnvPyXsHMC0WNJDXS2Ybf
         h9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eQNwZk4qbuz8Mp8P2CniVr48GnnJgzlr45zxjfXDY1Q=;
        b=clhyVqXmbXe5uBb7l3MNLaXXu3OWkSXNLq6YuIrfSRmRbdbTSJaDCOZ+tkvRftsjvj
         bfJyejCZL55xPh2qyPPWeeJ2LnFmRvqFXAGCVSLvaKIIGctuo2Bsk6hu+8jyQKycG/dj
         o+HtRBfLyWNZc7UcLCSKdUnBiTAn0SSnIWku3jTbjx95o/fPGUnH/XvGRo8Fw/6keOE8
         YG/IY20sQzJFRbDB8kboaEStU3md7DQTVq+ax+T/QKRxvL5x4hl9YtfF0ZWa11FZAMFo
         zFftIGEPzE4EAuU+S6+Bv1P1088oOoMiSRY85G4eYB1+9xg2Ya8fuk6LK/Tkq67zd9pt
         XyKQ==
X-Gm-Message-State: AHYfb5iOUPWcV05urjX14VWkw/XbvqEKLCawuDc/IKiu9ThEvrskGyPI
        PWn0yZPxR5rjS+9CcviKeHohqEC6ON5q
X-Received: by 10.37.183.130 with SMTP id n2mr15320248ybh.353.1503350189663;
 Mon, 21 Aug 2017 14:16:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 21 Aug 2017 14:16:29 -0700 (PDT)
In-Reply-To: <20170821000022.26729-6-sandals@crustytoothpaste.net>
References: <20170821000022.26729-1-sandals@crustytoothpaste.net> <20170821000022.26729-6-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Aug 2017 14:16:29 -0700
Message-ID: <CAGZ79kZrFDNfZYK_CL_rwn6pqB8no3+SFM_4H+RjURRz=R+Fag@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] Integrate hash algorithm support with repo setup
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 20, 2017 at 5:00 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> In future versions of Git, we plan to support an additional hash
> algorithm.  Integrate the enumeration of hash algorithms with repository
> setup, and store a pointer to the enumerated data in struct repository.
> Of course, we currently only support SHA-1, so hard-code this value in
> read_repository_format.  In the future, we'll enumerate this value from
> the configuration.
>
> Add a constant, current_hash, which points to the hash_algo structure
> pointer in the repository global.  Include repository.h in cache.h since
> we now need to have access to these struct and variable definitions.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

The new code seems to fit in nicely with the repository struct.

In another series I also included repository.h in cache.h
(not yet sent out), so I think that is a good idea.

> ---
>  cache.h      | 4 ++++
>  repository.c | 7 +++++++
>  repository.h | 5 +++++
>  setup.c      | 2 ++
>  4 files changed, 18 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index 375a7fb15e..d759824803 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -13,6 +13,7 @@
>  #include "hash.h"
>  #include "path.h"
>  #include "sha1-array.h"
> +#include "repository.h"
>
>  #ifndef platform_SHA_CTX
>  /*
> @@ -112,6 +113,8 @@ struct git_hash_algo {
>  };
>  extern const struct git_hash_algo hash_algos[1];
>
> +#define current_hash the_repository->hash_algo
> +
>  #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
>  #define DTYPE(de)      ((de)->d_type)
>  #else
> @@ -894,6 +897,7 @@ struct repository_format {
>         int version;
>         int precious_objects;
>         int is_bare;
> +       int hash_algo;
>         char *work_tree;
>         struct string_list unknown_extensions;
>  };
> diff --git a/repository.c b/repository.c
> index 1617467568..37764f627a 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -62,6 +62,11 @@ void repo_set_gitdir(struct repository *repo, const char *path)
>         repo_setup_env(repo);
>  }
>
> +void repo_set_hash_algo(struct repository *repo, int hash_algo)
> +{
> +       repo->hash_algo = &hash_algos[hash_algo];
> +}
> +
>  /*
>   * Attempt to resolve and set the provided 'gitdir' for repository 'repo'.
>   * Return 0 upon success and a non-zero value upon failure.
> @@ -134,6 +139,8 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
>         if (read_and_verify_repository_format(&format, repo->commondir))
>                 goto error;
>
> +       repo->hash_algo = &hash_algos[format.hash_algo];
> +
>         if (worktree)
>                 repo_set_worktree(repo, worktree);
>
> diff --git a/repository.h b/repository.h
> index 417787f3ef..f171172150 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -4,6 +4,7 @@
>  struct config_set;
>  struct index_state;
>  struct submodule_cache;
> +struct git_hash_algo;
>
>  struct repository {
>         /* Environment */
> @@ -67,6 +68,9 @@ struct repository {
>          */
>         struct index_state *index;
>
> +       /* Repository's current hash algorithm. */
> +       const struct git_hash_algo *hash_algo;
> +
>         /* Configurations */
>         /*
>          * Bit used during initialization to indicate if repository state (like
> @@ -86,6 +90,7 @@ extern struct repository *the_repository;
>
>  extern void repo_set_gitdir(struct repository *repo, const char *path);
>  extern void repo_set_worktree(struct repository *repo, const char *path);
> +extern void repo_set_hash_algo(struct repository *repo, int algo);
>  extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
>  extern int repo_submodule_init(struct repository *submodule,
>                                struct repository *superproject,
> diff --git a/setup.c b/setup.c
> index 115e70a4e8..289e24811c 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -491,6 +491,7 @@ int read_repository_format(struct repository_format *format, const char *path)
>         memset(format, 0, sizeof(*format));
>         format->version = -1;
>         format->is_bare = -1;
> +       format->hash_algo = GIT_HASH_SHA1;
>         string_list_init(&format->unknown_extensions, 1);
>         git_config_from_file(check_repo_format, path, format);
>         return format->version;
> @@ -1125,6 +1126,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>                         repo_set_gitdir(the_repository, gitdir);
>                         setup_git_env();
>                 }
> +               repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
>         }
>
>         strbuf_release(&dir);
