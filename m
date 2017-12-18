Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3CFA1F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934252AbdLRSBf (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:01:35 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:46550 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752904AbdLRSBa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:01:30 -0500
Received: by mail-io0-f193.google.com with SMTP id x129so10737051iod.13
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 10:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZufHvXlb7b3D5tJCj3Hc8sbiYOY9jJzLS4PkjFS9l4U=;
        b=aoO4k+YP6EqFT4/vrLyr7SIc3+irD4D/0QhAF5qJWxCWp2c8lIcPWVglMFuy1Rb+Uy
         UfpT8HL/DM/6/kYKBjpiy1xJMjKbyDpCrLiTX/lsE/x65jlN99OyREVOdcqM0bOkndSk
         3h5GbbcwPfv7S4aMoHWMvBSln2wr7z3aFJD8l62ZRh6nWHDqZF/DgbpDoRd8ZOAygWnY
         ntXd+mGcr94rxGfFH6kAi87QmGl2+uS9eW2zuZg7JYlNXjV1Zcy0YLqKxyScKwRmIwKO
         6NBeRIfE9ZLqVuDzF42o1UCpATU7iUI0E7aE4n70eKB9tocSwSa+vpymE3g6ApF9X9rf
         /dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZufHvXlb7b3D5tJCj3Hc8sbiYOY9jJzLS4PkjFS9l4U=;
        b=hZW1vAkZgfYdB7RJuOpb4qmAXzUXjMiOJrwCO9OgLDmm1W3H5j9BIumCL1RaETQ+u+
         HGBFLUePbcaGQOTWwyhtMmHBJKptAr9hahpy0Kjtlj5Fg8Mjx0Rjzo8F+K+0kEFv5GDu
         uOUAd+0vaP0STME5k3uHcGlJFR8zqgNpw9V0QjcFlI3s93mrpGPoMuNTOKTG/8eNPEwi
         5GAghFjErn0XxAs6i594nuOPQdeCFmG/1/8nCMhbvR+YnYCBTGesThB1bpotNRVBZg6k
         W0zai8JBN5e9w3d7KIpreY2jsrgspo3U7fuehjumiKy4RadaQedaCk4XrCSvQ8gHyM0P
         5YyA==
X-Gm-Message-State: AKGB3mIbUwZ7HAAbExQdQ2Rg4lkIcDIX9R9NOHB76dH2g7sYYd1sXQcN
        P9Po8vOBe1tgXks7RI6G8d/81g==
X-Google-Smtp-Source: ACJfBouc9ZGF1MnICexpL5FAzAnj9fOIK1jfVN/cX/m1TCK2X5Ghx8u5yQ6fPYKOBMlhKUPjWWnbmw==
X-Received: by 10.107.201.78 with SMTP id z75mr733602iof.123.1513620089123;
        Mon, 18 Dec 2017 10:01:29 -0800 (PST)
Received: from google.com ([2620:0:100e:422:1d4c:2092:ef96:42])
        by smtp.gmail.com with ESMTPSA id a132sm6851255ioe.40.2017.12.18.10.01.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 10:01:27 -0800 (PST)
Date:   Mon, 18 Dec 2017 10:01:26 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/3] repository: fix repo_read_index with submodules
Message-ID: <20171218180126.GA147973@google.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
 <20171217225122.28941-1-t.gummerer@gmail.com>
 <20171217225122.28941-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171217225122.28941-2-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/17, Thomas Gummerer wrote:
> repo_read_index calls read_index_from, which takes an path argument for
> the location of the index file.  For the split index however it relies

> on the current working directory to construct the path using git_path.

This line isn't actually true and should probably be fixed.  git_path
doesn't rely on the CWD but rather it relies on the gitdir of the main
repository (the_repository).

> 
> repo_read_index calls read_index_from with the full path for the index
> file, however it doesn't change the cwd, so when split index mode is
> turned on, read_index_from can't find the file for the split index.
> 
> For example t3007-ls-files-recurse-submodules.sh was broken with
> GIT_TEST_SPLIT_INDEX set in 188dce131f ("ls-files: use repository
> object", 2017-06-22), and t7814-grep-recurse-submodules.sh was also
> broken in a similar manner, probably by introducing struct repository
> there, although I didn't track down the exact commit for that.
> 
> Fix this by introducing a new read_index_for_repo function, which knows
> about the correct paths for the submodules.
> 
> The alternative would have been to make the callers pass in the base
> path for the split index, however that ended up being more complicated,
> and I think we want to converge towards using struct repository for
> things like these anyway.
> 
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  cache.h      |  1 +
>  read-cache.c | 16 ++++++++++++++--
>  repository.c |  2 +-
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index cb5db7bf83..d42bea1ef7 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -614,6 +614,7 @@ extern int read_index_preload(struct index_state *, const struct pathspec *paths
>  extern int do_read_index(struct index_state *istate, const char *path,
>  			 int must_exist); /* for testting only! */
>  extern int read_index_from(struct index_state *, const char *path);
> +extern int read_index_for_repo(const struct repository *);
>  extern int is_index_unborn(struct index_state *);
>  extern int read_index_unmerged(struct index_state *);
>  
> diff --git a/read-cache.c b/read-cache.c
> index 2eb81a66b9..70357febdc 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -20,6 +20,7 @@
>  #include "split-index.h"
>  #include "utf8.h"
>  #include "fsmonitor.h"
> +#include "repository.h"
>  
>  /* Mask for the name length in ce_flags in the on-disk index */
>  
> @@ -1871,7 +1872,8 @@ static void freshen_shared_index(char *base_sha1_hex, int warn)
>  	free(shared_index);
>  }
>  
> -int read_index_from(struct index_state *istate, const char *path)
> +static int do_read_index_from(struct index_state *istate, const char *path,
> +			      const struct repository *repo)
>  {
>  	struct split_index *split_index;
>  	int ret;
> @@ -1896,7 +1898,7 @@ int read_index_from(struct index_state *istate, const char *path)
>  		split_index->base = xcalloc(1, sizeof(*split_index->base));
>  
>  	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
> -	base_path = git_path("sharedindex.%s", base_sha1_hex);
> +	base_path = repo_git_path(repo, "sharedindex.%s", base_sha1_hex);
>  	ret = do_read_index(split_index->base, base_path, 1);
>  	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
>  		die("broken index, expect %s in %s, got %s",
> @@ -1909,6 +1911,16 @@ int read_index_from(struct index_state *istate, const char *path)
>  	return ret;
>  }
>  
> +int read_index_for_repo(const struct repository *repo)
> +{
> +	return do_read_index_from(repo->index, repo->index_file, repo);
> +}

> +
> +int read_index_from(struct index_state *istate, const char *path)
> +{
> +	return do_read_index_from(istate, path, the_repository);
> +}

This looks fine, though I wonder what the point of passing in the index
file even was since we end just ended up reading the 'sharedindex' file based
on the git path. I'm just curious about how this function evolved.

> +
>  int is_index_unborn(struct index_state *istate)
>  {
>  	return (!istate->cache_nr && !istate->timestamp.sec);
> diff --git a/repository.c b/repository.c
> index bb2fae5446..928b1f553d 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -229,5 +229,5 @@ int repo_read_index(struct repository *repo)
>  	if (!repo->index)
>  		repo->index = xcalloc(1, sizeof(*repo->index));
>  
> -	return read_index_from(repo->index, repo->index_file);
> +	return read_index_for_repo(repo);
>  }
> -- 
> 2.15.1.620.gb9897f4670
> 

-- 
Brandon Williams
