Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21EA61F403
	for <e@80x24.org>; Mon, 18 Jun 2018 18:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935791AbeFRSyB (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 14:54:01 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36870 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935752AbeFRSx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 14:53:59 -0400
Received: by mail-pg0-f66.google.com with SMTP id r21-v6so7944553pgv.4
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=r2t+Cm0EHfW7zWCFkPsfpUzsCVmUN1cekzd81O3o918=;
        b=fNH7ghuPlV8FFG4g1xhmwUTa0sPKgVBhhU824S/hy5OGosV9AeOVNV8u2HjhL57mqI
         wWRXMiOJl2mYkAlnj/AQW902o2Di3N+f0B3XckQtdD4NxIV4xckHhWem4x2wDa4UbLPu
         Nb+c3ww22fyklmanHmYNEXnjM6clwaJ5lHIVK7/325URcKjabSYlMGIA0kMzDJEPvdQN
         JmlYsXmWMi6TTCh+y04voVE9A7pA7ftmYYBIRXq5Ha4oKnKCSJTuB7wmoFrRTJazHNE0
         hrS09HwzKLwYgdHmQ4h+MDFkHJrqhGbZbhpt67QXT/F38eZvSmvE8HQBBojnt2byb23b
         EATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=r2t+Cm0EHfW7zWCFkPsfpUzsCVmUN1cekzd81O3o918=;
        b=agQsxYOPkQYEWhOQx0/BMwbgOrbDTCmm4FyITFchIvYb7jE0FU+5lTSfIHBcPdWTxb
         jDPhP1JjetP/1PEHOvMddA7LDo8UheriyC2j+5fgZybuJb84DNb6rdL2Kv6C9knDvjiy
         jKoBF5T8gXPaddBMdAkdq6/Njoo8/QDvCjEwMAXcGcU0xtYvH32pun2uaIDDOmG2HuWs
         C0SDd3Xh2oNu5SB6rwY4cPCgs90ZNWbdDHMZlKZZEY4ZoqYFrcgNJxLp23hQrb52yN/e
         CJzuyu2a6US90Q6eq7wxIQ1JNduFLwCBGWFSFrCgGz6V98cyi9r+N0Xh/pGsEWHSJn9n
         MGCw==
X-Gm-Message-State: APt69E1MFyv85aqSwSULn9S61foBdJ5vHh9TxKtEeZolXaZrQAIroXwu
        pIH3gYlArD/oe59ccGO8IT3OjA==
X-Google-Smtp-Source: ADUXVKIx0cXq+kfF4mzSo7dRikO/3KOJ3KJybeo0cUSEavKJ8knI3DQ5+GlgfECPhp66vj4etWoYGQ==
X-Received: by 2002:a63:a042:: with SMTP id u2-v6mr12331077pgn.413.1529348038971;
        Mon, 18 Jun 2018 11:53:58 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id z19-v6sm22603604pfe.163.2018.06.18.11.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 11:53:57 -0700 (PDT)
Date:   Mon, 18 Jun 2018 11:53:56 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 15/15] cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS
 switch
Message-ID: <20180618185356.GD73085@google.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
 <20180616054157.32433-16-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180616054157.32433-16-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/16, Nguyễn Thái Ngọc Duy wrote:
> From now on, by default index compat macros are off because they could
> hide the_index dependency. Only those in builtin can use it (and even
> so should be avoided if possible).

This is awesome! Now there aren't any compat macros left in the lib code
and the next set of patches has a good base to work from the eliminate
the_index (which I assume based on other mails from you will become part
of the new USE_THE_INDEX_COMPATIBILITY_MACROS macro once its eliminated
from the lib code).

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  attr.c                               | 1 -
>  builtin/add.c                        | 1 +
>  builtin/am.c                         | 1 +
>  builtin/check-attr.c                 | 1 +
>  builtin/check-ignore.c               | 1 +
>  builtin/checkout-index.c             | 1 +
>  builtin/checkout.c                   | 1 +
>  builtin/clean.c                      | 1 +
>  builtin/commit.c                     | 1 +
>  builtin/describe.c                   | 1 +
>  builtin/diff-files.c                 | 1 +
>  builtin/diff-index.c                 | 1 +
>  builtin/diff-tree.c                  | 1 +
>  builtin/diff.c                       | 1 +
>  builtin/fsck.c                       | 1 +
>  builtin/ls-files.c                   | 1 -
>  builtin/merge-index.c                | 1 +
>  builtin/merge-ours.c                 | 1 +
>  builtin/merge.c                      | 1 +
>  builtin/mv.c                         | 1 +
>  builtin/pull.c                       | 1 +
>  builtin/read-tree.c                  | 1 +
>  builtin/reset.c                      | 1 +
>  builtin/rev-parse.c                  | 1 +
>  builtin/rm.c                         | 1 +
>  builtin/submodule--helper.c          | 1 +
>  builtin/update-index.c               | 1 +
>  cache.h                              | 2 +-
>  convert.c                            | 1 -
>  dir.c                                | 1 -
>  name-hash.c                          | 1 -
>  pathspec.c                           | 1 -
>  read-cache.c                         | 1 -
>  submodule.c                          | 1 -
>  t/helper/test-dump-untracked-cache.c | 1 +
>  t/helper/test-tool.h                 | 2 ++
>  tree.c                               | 1 -
>  unpack-trees.c                       | 1 -
>  38 files changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/attr.c b/attr.c
> index 067fb9e0c0..d16625661d 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -7,7 +7,6 @@
>   * an insanely large number of attributes.
>   */
>  
> -#define NO_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "exec-cmd.h"
> diff --git a/builtin/add.c b/builtin/add.c
> index 8a155dd41e..b93193c3fe 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (C) 2006 Linus Torvalds
>   */
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "builtin.h"
> diff --git a/builtin/am.c b/builtin/am.c
> index 2fc2d1e82c..28af59d183 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -3,6 +3,7 @@
>   *
>   * Based on git-am.sh by Junio C Hamano.
>   */
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "builtin.h"
> diff --git a/builtin/check-attr.c b/builtin/check-attr.c
> index 91444dc044..d9cebd5382 100644
> --- a/builtin/check-attr.c
> +++ b/builtin/check-attr.c
> @@ -1,3 +1,4 @@
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "cache.h"
>  #include "config.h"
> diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
> index ec9a959e08..599097304b 100644
> --- a/builtin/check-ignore.c
> +++ b/builtin/check-ignore.c
> @@ -1,3 +1,4 @@
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "cache.h"
>  #include "config.h"
> diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
> index a730f6a1aa..e38ad42dbf 100644
> --- a/builtin/checkout-index.c
> +++ b/builtin/checkout-index.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2005 Linus Torvalds
>   *
>   */
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "config.h"
>  #include "lockfile.h"
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2e1d2376d2..2250611407 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1,3 +1,4 @@
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "config.h"
>  #include "checkout.h"
> diff --git a/builtin/clean.c b/builtin/clean.c
> index fad533a0a7..2258379ecc 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -6,6 +6,7 @@
>   * Based on git-clean.sh by Pavel Roskin
>   */
>  
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "cache.h"
>  #include "config.h"
> diff --git a/builtin/commit.c b/builtin/commit.c
> index a842fea666..98a5b4a8c8 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -5,6 +5,7 @@
>   * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
>   */
>  
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "lockfile.h"
> diff --git a/builtin/describe.c b/builtin/describe.c
> index cf1ae77d7c..4ca234972e 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -1,3 +1,4 @@
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "lockfile.h"
> diff --git a/builtin/diff-files.c b/builtin/diff-files.c
> index e88493ffe5..af706b4fce 100644
> --- a/builtin/diff-files.c
> +++ b/builtin/diff-files.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (C) Linus Torvalds, 2005
>   */
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "diff.h"
> diff --git a/builtin/diff-index.c b/builtin/diff-index.c
> index 522f4fdffd..c026ffb95e 100644
> --- a/builtin/diff-index.c
> +++ b/builtin/diff-index.c
> @@ -1,3 +1,4 @@
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "diff.h"
> diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> index 473615117e..bd2264ed5c 100644
> --- a/builtin/diff-tree.c
> +++ b/builtin/diff-tree.c
> @@ -1,3 +1,4 @@
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "diff.h"
> diff --git a/builtin/diff.c b/builtin/diff.c
> index bfefff3a84..17d7d5c9f5 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (c) 2006 Junio C Hamano
>   */
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "lockfile.h"
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 3ad4f160f9..33cb71d269 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -1,3 +1,4 @@
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "cache.h"
>  #include "repository.h"
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 88bb2019ad..dbf5d13d91 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -5,7 +5,6 @@
>   *
>   * Copyright (C) Linus Torvalds, 2005
>   */
> -#define NO_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "repository.h"
>  #include "config.h"
> diff --git a/builtin/merge-index.c b/builtin/merge-index.c
> index c99443b095..38ea6ad6ca 100644
> --- a/builtin/merge-index.c
> +++ b/builtin/merge-index.c
> @@ -1,3 +1,4 @@
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "run-command.h"
>  
> diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
> index c84c6e05e9..7c4a80ed3b 100644
> --- a/builtin/merge-ours.c
> +++ b/builtin/merge-ours.c
> @@ -7,6 +7,7 @@
>   *
>   * Pretend we resolved the heads, but declare our tree trumps everybody else.
>   */
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "git-compat-util.h"
>  #include "builtin.h"
>  #include "diff.h"
> diff --git a/builtin/merge.c b/builtin/merge.c
> index b00d6f4821..1b540e2194 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -6,6 +6,7 @@
>   * Based on git-merge.sh by Junio C Hamano.
>   */
>  
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "parse-options.h"
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 80bb967a63..be15ba7044 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (C) 2006 Johannes Schindelin
>   */
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "config.h"
>  #include "pathspec.h"
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 1f2ecf3a88..1c3657dee2 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -5,6 +5,7 @@
>   *
>   * Fetch one or more remote refs and merge it/them into the current HEAD.
>   */
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "builtin.h"
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index ebc43eb805..ae6ca3a8c5 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) Linus Torvalds, 2005
>   */
>  
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "lockfile.h"
> diff --git a/builtin/reset.c b/builtin/reset.c
> index a862c70fab..dd60eec9d6 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -7,6 +7,7 @@
>   *
>   * Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
>   */
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "config.h"
>  #include "lockfile.h"
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 4f49e96bfd..b5f8d6a83d 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (C) Linus Torvalds, 2005
>   */
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "commit.h"
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 65b448ef8e..e5b77e429d 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (C) Linus Torvalds 2006
>   */
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "config.h"
>  #include "lockfile.h"
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index bd250ca216..8abe15144b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1,3 +1,4 @@
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
>  #include "repository.h"
>  #include "cache.h"
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index a8709a26ec..36e837248f 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (C) Linus Torvalds, 2005
>   */
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "lockfile.h"
> diff --git a/cache.h b/cache.h
> index 89a107a7f7..b3a6d14a36 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -339,7 +339,7 @@ extern void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
>  extern void free_name_hash(struct index_state *istate);
>  
>  
> -#ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
> +#ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
>  #define active_cache (the_index.cache)
>  #define active_nr (the_index.cache_nr)
>  #define active_alloc (the_index.cache_alloc)
> diff --git a/convert.c b/convert.c
> index 64d0d30e08..0895dc5994 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -1,4 +1,3 @@
> -#define NO_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "attr.h"
> diff --git a/dir.c b/dir.c
> index ccf8b4975e..473c47eb2f 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -7,7 +7,6 @@
>   * Copyright (C) Linus Torvalds, 2005-2006
>   *		 Junio Hamano, 2005-2006
>   */
> -#define NO_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "dir.h"
> diff --git a/name-hash.c b/name-hash.c
> index 163849831c..12eaa62980 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -5,7 +5,6 @@
>   *
>   * Copyright (C) 2008 Linus Torvalds
>   */
> -#define NO_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  
>  struct dir_entry {
> diff --git a/pathspec.c b/pathspec.c
> index 27cd606786..6997707477 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -1,4 +1,3 @@
> -#define NO_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "dir.h"
> diff --git a/read-cache.c b/read-cache.c
> index 372588260e..2a84ad0797 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3,7 +3,6 @@
>   *
>   * Copyright (C) Linus Torvalds, 2005
>   */
> -#define NO_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "tempfile.h"
> diff --git a/submodule.c b/submodule.c
> index 939d6870ec..c6ae29379d 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1,4 +1,3 @@
> -#define NO_THE_INDEX_COMPATIBILITY_MACROS
>  
>  #include "cache.h"
>  #include "repository.h"
> diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
> index bd92fb305a..56a5ce8abb 100644
> --- a/t/helper/test-dump-untracked-cache.c
> +++ b/t/helper/test-dump-untracked-cache.c
> @@ -1,3 +1,4 @@
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "dir.h"
>  
> diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
> index 7116ddfb94..a7ff69e9f3 100644
> --- a/t/helper/test-tool.h
> +++ b/t/helper/test-tool.h
> @@ -1,6 +1,8 @@
>  #ifndef __TEST_TOOL_H__
>  #define __TEST_TOOL_H__
>  
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS
> +
>  int cmd__chmtime(int argc, const char **argv);
>  int cmd__config(int argc, const char **argv);
>  int cmd__ctype(int argc, const char **argv);
> diff --git a/tree.c b/tree.c
> index 244eb5e665..b5ed7bc22b 100644
> --- a/tree.c
> +++ b/tree.c
> @@ -1,4 +1,3 @@
> -#define NO_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "cache-tree.h"
>  #include "tree.h"
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3a85a02a77..fd09e812a2 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1,4 +1,3 @@
> -#define NO_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "argv-array.h"
>  #include "repository.h"
> -- 
> 2.18.0.rc0.333.g22e6ee6cdf
> 

-- 
Brandon Williams
