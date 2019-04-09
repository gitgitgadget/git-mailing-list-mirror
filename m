Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27F720248
	for <e@80x24.org>; Tue,  9 Apr 2019 02:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDICHx (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 22:07:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37735 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfDICHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 22:07:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so8358435pgc.4
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 19:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aFUcGv4j/mwOvw53iC4bpyA0FOmn5MpJK8pwAdkRolo=;
        b=YNATiFKBoi56tVFuuf1LZvDCSwz9BVXwrKaw8wp08roh4l/JdS+u9TptD2PdF5un1h
         4tMnNrpxE5yC+7on0UXDaR9XutOBI3EI4uodP1SLCYhi2TgRFtI896FYyj5rn5oWqo73
         9SFKS8rCc1cVzesjkc/CQr9wZ+bQzoACBUiv82qpjTsJ/8fzwaHzKF0YV5m70M1u7Jzg
         O5GUPhXwSjE+9E5k1UDeRoKFEa95Gs13I8sgzaR7dhjjK+aXH0Ux6p7+g/xrcR+Sgg1p
         AtxMkKen/efqJzLh7br8Cy6TGR18qq52V5oF6rtU1h4xDqZm4u7o1DkheceGHnEimJj4
         mkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aFUcGv4j/mwOvw53iC4bpyA0FOmn5MpJK8pwAdkRolo=;
        b=eAMSvL0gCHL5ZmIkrVEv0CH/pBXH7EdxcfsnthoiSSG/03/CDRHcyj4pHNQmPjSDwW
         sGroTaSbXer49qmwK1uczluLkXd9S2Kv+Myf87kC/oFNbs0AJWg+XlANpmB5I0CI/Xdq
         MOyvqhP3TNW1iW9TQL55e2bJ/Wv9DNOC7U+ziRBnw7c/JsZYOQGBug2pUkjJp6pXb/g2
         +ZVWwyxyjREt0LbffmVnB+0sIn3h089CTAd8EYcFGEVXp6AIvgWVT9pRMt53QSPSI4Vu
         WIWLSX3V2H9wXVslzttTdZzPumURqRH5RYE73l5TjATsynYs3ACvWj383ed2Hin2EbWY
         2TsA==
X-Gm-Message-State: APjAAAUX7SswFmrzNLdB/Baht3ytcH4hb4HsLkRSEvkM279JRFQQLvFM
        deYw6InxOgn7xCbptiiZunvcIg==
X-Google-Smtp-Source: APXvYqwREQfzNldVmduhpeMje3nFvNFXlD8qKNVjvDqGAtSup+jydLZXOupcyT3cFhJJmKM6ULR4+g==
X-Received: by 2002:a63:6844:: with SMTP id d65mr32288358pgc.393.1554775672072;
        Mon, 08 Apr 2019 19:07:52 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d869:cd1a:616d:3c11])
        by smtp.gmail.com with ESMTPSA id g64sm71669201pfg.13.2019.04.08.19.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 19:07:51 -0700 (PDT)
Date:   Mon, 8 Apr 2019 19:07:49 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [PATCH][RFC] read-cache: read_index_from() accepts repo as arg
Message-ID: <20190409020749.GC81620@Taylors-MBP.hsd1.wa.comcast.net>
References: <20190407073712.1642-1-jkapil.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407073712.1642-1-jkapil.cs@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kapil,

On Sun, Apr 07, 2019 at 01:07:12PM +0530, Kapil Jain wrote:
> Signed-off-by: Kapil Jain <jkapil.cs@gmail.com>
> ---
>
> In read-cache, the read_index_from() function had a TODO task,
> this patch completes that. There are some other functions in the same file
> where this exact TODO needs to be done, will proceed to do them once this patch is accepted.
>
> running test gave 256 not okays, each had a label as `# TODO known breakage`, which i think
> are not concerned to this patch.

Please make sure to wrap your commit messages at 72 characters per-line.
Incidentally, I just wrote another email about this same topic [1],
which has some good advice for how to do this in an automated way.

>  apply.c            | 2 +-
>  builtin/worktree.c | 2 +-
>  cache-tree.c       | 2 +-
>  cache.h            | 4 ++--
>  read-cache.c       | 4 ++--
>  repository.c       | 2 +-
>  revision.c         | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index f15afa9f6a..3b4d128149 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4021,7 +4021,7 @@ static int read_apply_cache(struct apply_state *state)
>  {
>  	if (state->index_file)
>  		return read_index_from(state->repo->index, state->index_file,
> -				       get_git_dir());
> +				       get_git_dir(), state->repo);
>  	else
>  		return repo_read_index(state->repo);
>  }
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 6cc094a453..874adebd2c 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -737,7 +737,7 @@ static void validate_no_submodules(const struct worktree *wt)
>  		 */
>  		found_submodules = 1;
>  	} else if (read_index_from(&istate, worktree_git_path(wt, "index"),
> -				   get_worktree_git_dir(wt)) > 0) {
> +				   get_worktree_git_dir(wt), the_repository) > 0) {
>  		for (i = 0; i < istate.cache_nr; i++) {
>  			struct cache_entry *ce = istate.cache[i];
>  			int err;
> diff --git a/cache-tree.c b/cache-tree.c
> index b13bfaf71e..84f19b224e 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -616,7 +616,7 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
>
>  	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
>
> -	entries = read_index_from(index_state, index_path, get_git_dir());
> +	entries = read_index_from(index_state, index_path, get_git_dir(), the_repository);
>  	if (entries < 0) {
>  		ret = WRITE_TREE_UNREADABLE_INDEX;
>  		goto out;
> diff --git a/cache.h b/cache.h
> index ac92421f3a..3850c82fc9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -420,7 +420,7 @@ extern struct index_state the_index;
>  #define active_cache_tree (the_index.cache_tree)
>
>  #define read_cache() repo_read_index(the_repository)
> -#define read_cache_from(path) read_index_from(&the_index, (path), (get_git_dir()))
> +#define read_cache_from(path) read_index_from(&the_index, (path), (get_git_dir()), the_repository)
>  #define read_cache_preload(pathspec) repo_read_index_preload(the_repository, (pathspec), 0)
>  #define is_cache_unborn() is_index_unborn(&the_index)
>  #define read_cache_unmerged() repo_read_index_unmerged(the_repository)
> @@ -678,7 +678,7 @@ extern void preload_index(struct index_state *index,
>  extern int do_read_index(struct index_state *istate, const char *path,
>  			 int must_exist); /* for testting only! */
>  extern int read_index_from(struct index_state *, const char *path,
> -			   const char *gitdir);
> +			   const char *gitdir, const struct repository *repo);
>  extern int is_index_unborn(struct index_state *);
>
>  /* For use with `write_locked_index()`. */
> diff --git a/read-cache.c b/read-cache.c
> index 4dc6de1b55..0444703284 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2256,7 +2256,7 @@ static void freshen_shared_index(const char *shared_index, int warn)
>  }
>
>  int read_index_from(struct index_state *istate, const char *path,
> -		    const char *gitdir)
> +		    const char *gitdir, const struct repository *repo)
>  {
>  	struct split_index *split_index;
>  	int ret;
> @@ -2292,7 +2292,7 @@ int read_index_from(struct index_state *istate, const char *path,
>  		split_index->base = xcalloc(1, sizeof(*split_index->base));
>
>  	base_oid_hex = oid_to_hex(&split_index->base_oid);
> -	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
> +	base_path = xstrfmt("%s/sharedindex.%s", repo->gitdir, base_oid_hex);
>  	trace2_region_enter_printf("index", "shared/do_read_index",
>  				   the_repository, "%s", base_path);
>  	ret = do_read_index(split_index->base, base_path, 1);
> diff --git a/repository.c b/repository.c
> index 682c239fe3..8ac2b65f61 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -264,7 +264,7 @@ int repo_read_index(struct repository *repo)
>  	if (!repo->index)
>  		repo->index = xcalloc(1, sizeof(*repo->index));
>
> -	return read_index_from(repo->index, repo->index_file, repo->gitdir);
> +	return read_index_from(repo->index, repo->index_file, repo->gitdir, repo);
>  }
>
>  int repo_hold_locked_index(struct repository *repo,
> diff --git a/revision.c b/revision.c
> index eb8e51bc63..247a4d5704 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1556,7 +1556,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
>
>  		if (read_index_from(&istate,
>  				    worktree_git_path(wt, "index"),
> -				    get_worktree_git_dir(wt)) > 0)
> +				    get_worktree_git_dir(wt), the_repository) > 0)
>  			do_add_index_objects_to_pending(revs, &istate, flags);
>  		discard_index(&istate);
>  	}
> --
> 2.20.1
>
Thanks,
Taylor

[1]: https://public-inbox.org/git/20190409020004.GA81620@Taylors-MBP.hsd1.wa.comcast.net/
