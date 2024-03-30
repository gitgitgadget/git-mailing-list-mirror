Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCE8464
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711808846; cv=none; b=U8TDwN6xYBtUun/pqpx3PO0iAs3rAq6GgWVZgxmI+eLoCu++D7j/TVcMjmpjpKB7sj1E1zGK5DcsUIb8rgYPguix2FmHX3Ar26Sk21v4fiKrxXd20tTN1E4MsR6pz7D+GppS7c+oyJbCSOSLEx/1Gm/h+P1U81UVZ4qdUInwzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711808846; c=relaxed/simple;
	bh=0L2LxGZMCIBicRB9a+Ut+mLV1gxE5SfYSStmLe1SA7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of2194W9wSgIAzdAFAzPJsB70xO6GShcG2W2Vbe4cqp4WWVlmLSmc+3i6Kp/yydoSSPPoA1iRO3t1cFreoknqGE0JESgDaqdNkJzOV3Rxfb4nMBxNb9UqKUfxQHAQ8bJD0Y1eJ+1OPiGmwZ+8H6a6mqWzKP8SnkhWQ5V/k29V7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OI4XOSSc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI4XOSSc"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5f034b4dcecso1865892a12.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 07:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711808844; x=1712413644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pt4lcgXHLhFOV/Nqm/sUw+tTAn/kd1Kdm8WbRF+PI7A=;
        b=OI4XOSScp0WwQt9AGq6724hbRot+Xq8sV277iKGqlpgzwBi1fg6Db8P0JKSWgDAw4d
         rzLHSGeOYIr1GOcfvIizjqfu/kJRgph0mLFNSjIoegA7gbYdQhtGBgb4thlt/vR9hwPc
         WXvPSojmp84B+DRHpB4WEwMLUq0AUi7YDzaBcQp+Zjq4YcyvvXaQ/aHDgeZWhphU5rYN
         5lE5DP5Ys5HIT7ow+0WwZJ+bdwuX+PlElQoirRP7vjG99/cF3HtmRc+vTNS0QFu0KP6A
         T82he48NFjQa2uuZxqFL75v+BOV3+o4GcLwLZR8ZD6Vnw6rHNx/X0aWQlAreLzNH4UJs
         pakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711808844; x=1712413644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt4lcgXHLhFOV/Nqm/sUw+tTAn/kd1Kdm8WbRF+PI7A=;
        b=rZZVvm3+LaILYcS222t2tkRLNaa9kCdgjdX1WiB4gXwEiHgi2Ca3HgpsfyX9bN+xSf
         M3Zm/I+mIGLM2O2rZG8eukO8V5eKLiOeNi97q6S0KJO6fksV6NsVwR6TPebaLaYJ2Xbk
         vJMi1rd9/ExMPIRgxPi+sZCcG8bHbmelDDn3mP0SZxDKoTTbK/HRvOuG9KhOxdsZkTRt
         Gpgjt/hCKCz2Nae0pfcJRNZiYO76igwE2fNc5HttzPykLYAihHlbgwgiLNBd4i55CeOx
         gG49gp9g3Z3QR2c/NP0DDfrMl8VgFIlIICwSO381n6t/SBKW6ectKdMenzP8FIUhU5fR
         +tCA==
X-Gm-Message-State: AOJu0YxBNpMo9NzHbj5OnbqihyyUG9JfBNgBl/WzuRpo1imkkY+2ABSG
	ERgla4m2HjZXgC8sdzjsBucx80Bq2LCgYt+5/NKckqOrOTkaoqDK
X-Google-Smtp-Source: AGHT+IGitDo175JEtH1kyTcA73yvcI/yof2ijqUFDfuCQ/TjS8eYCj+UMR1LFLJeDS8WL8rraPjK0Q==
X-Received: by 2002:a17:903:183:b0:1e0:9926:aded with SMTP id z3-20020a170903018300b001e09926adedmr11655730plg.24.1711808844340;
        Sat, 30 Mar 2024 07:27:24 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903244200b001e246cac31dsm1127120pls.188.2024.03.30.07.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 07:27:24 -0700 (PDT)
Date: Sat, 30 Mar 2024 19:57:21 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] read-cache: optionally collect pathspec matching
 info
Message-ID: <gfwbrhhklmus4yyxkn3gi6jrt54azgqexi6kyb6snvs5dxlu4g@7g77due7iiq3>
References: <20240318155219.494206-2-shyamthakkar001@gmail.com>
 <20240329205649.1483032-3-shyamthakkar001@gmail.com>
 <xmqqjzlkwwk9.fsf@gitster.g>
 <xmqqo7awvg2w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo7awvg2w.fsf@gitster.g>

On Fri, 29 Mar 2024, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > A new parameter to run_diff_files() came as a bit of surprise to me.
> >
> > When I responded to the previous round, I somehow thought that we'd
> > add a new member to the rev structure that points at an optional
> > .ps_matched member next to the existing .prune_data member.  
> >
> > That way, it would hopefully be easy for a future code to see if a
> > "diff" invocation, not necessarily run_diff_files() that compares
> > the working tree and the index, consumed all the pathspec elements.
> > If such a new .ps_matched member is initialized to NULL, all the
> > patch noise we see in this patch will become unnecessary, no?
> 
> This is how such a change may look like.  After applying [2/3] and
> [3/3] steps from your series on top of this patch, the updated tests
> in your series (2200 and 7501) seem to still pass.

This seems perfect. I hope you're OK with me using this patch as a base
for patch [2/3] and [3/3]. :)

> ------- >8 ------------- >8 ------------- >8 ------------- >8 -------
> 
> Subject: [PATCH] revision: optionally record matches with pathspec elements
> 
> Unlike "git add" and other end-user facing command, where it is
> diagnosed as an error to give a pathspec with an element that does
> not match any path, the diff machinery does not care if some
> elements of the pathspec does not match.  Given that the diff
> machinery is heavily used in pathspec-limited "git log" machinery,
> and it is common for a path to come and go while traversing the
> project history, this is usually a good thing.
> 
> However, in some cases we would want to know if all the pathspec
> elements matched.  For example, "git add -u <pathspec>" internally
> uses the machinery used by "git diff-files" to decide contents from
> what paths to add to the index, and as an end-user facing command,
> "git add -u" would want to report an unmatched pathspec element.
> 
> Add a new .ps_matched member next to the .prune_data member in
> "struct rev_info" so that we can optionally keep track of the use of
> .prune_data pathspec elements that can be inspected by the caller.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/add.c      |  4 ++--
>  builtin/checkout.c |  3 ++-
>  builtin/commit.c   |  2 +-
>  diff-lib.c         | 11 ++++++++++-
>  read-cache-ll.h    |  4 ++--
>  read-cache.c       |  8 +++++---
>  revision.h         |  1 +
>  7 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index 393c10cbcf..dc4b42d0ad 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -553,8 +553,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		exit_status |= renormalize_tracked_files(&pathspec, flags);
>  	else
>  		exit_status |= add_files_to_cache(the_repository, prefix,
> -						  &pathspec, include_sparse,
> -						  flags);
> +						  &pathspec, NULL,
> +						  include_sparse, flags);
>  
>  	if (add_new_files)
>  		exit_status |= add_files(&dir, flags);
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2e8b0d18f4..56d1828856 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -878,7 +878,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  			 * entries in the index.
>  			 */
>  
> -			add_files_to_cache(the_repository, NULL, NULL, 0, 0);
> +			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
> +					   0);
>  			init_merge_options(&o, the_repository);
>  			o.verbosity = 0;
>  			work = write_in_core_index_as_tree(the_repository);
> diff --git a/builtin/commit.c b/builtin/commit.c
> index b27b56c8be..8f31decc6b 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -444,7 +444,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
>  		repo_hold_locked_index(the_repository, &index_lock,
>  				       LOCK_DIE_ON_ERROR);
>  		add_files_to_cache(the_repository, also ? prefix : NULL,
> -				   &pathspec, 0, 0);
> +				   &pathspec, NULL, 0, 0);
>  		refresh_cache_or_die(refresh_flags);
>  		cache_tree_update(&the_index, WRITE_TREE_SILENT);
>  		if (write_locked_index(&the_index, &index_lock, 0))
> diff --git a/diff-lib.c b/diff-lib.c
> index 1cd790a4d2..683f11e509 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -127,7 +127,16 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>  		if (diff_can_quit_early(&revs->diffopt))
>  			break;
>  
> -		if (!ce_path_match(istate, ce, &revs->prune_data, NULL))
> +		/*
> +		 * NEEDSWORK:
> +		 * Here we filter with pathspec but the result is further
> +		 * filtered out when --relative is in effect.  To end-users,
> +		 * a pathspec element that matched only to paths outside the
> +		 * current directory is like not matching anything at all;
> +		 * the handling of ps_matched[] here may become problematic
> +		 * if/when we add the "--error-unmatch" option to "git diff".
> +		 */
> +		if (!ce_path_match(istate, ce, &revs->prune_data, revs->ps_matched))
>  			continue;
>  
>  		if (revs->diffopt.prefix &&
> diff --git a/read-cache-ll.h b/read-cache-ll.h
> index 2a50a784f0..09414afd04 100644
> --- a/read-cache-ll.h
> +++ b/read-cache-ll.h
> @@ -480,8 +480,8 @@ extern int verify_ce_order;
>  int cmp_cache_name_compare(const void *a_, const void *b_);
>  
>  int add_files_to_cache(struct repository *repo, const char *prefix,
> -		       const struct pathspec *pathspec, int include_sparse,
> -		       int flags);
> +		       const struct pathspec *pathspec, char *ps_matched,
> +		       int include_sparse, int flags);
>  
>  void overlay_tree_on_index(struct index_state *istate,
>  			   const char *tree_name, const char *prefix);
> diff --git a/read-cache.c b/read-cache.c
> index f546cf7875..e1723ad796 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3958,8 +3958,8 @@ static void update_callback(struct diff_queue_struct *q,
>  }
>  
>  int add_files_to_cache(struct repository *repo, const char *prefix,
> -		       const struct pathspec *pathspec, int include_sparse,
> -		       int flags)
> +		       const struct pathspec *pathspec, char *ps_matched,
> +		       int include_sparse, int flags)
>  {
>  	struct update_callback_data data;
>  	struct rev_info rev;
> @@ -3971,8 +3971,10 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
>  
>  	repo_init_revisions(repo, &rev, prefix);
>  	setup_revisions(0, NULL, &rev, NULL);
> -	if (pathspec)
> +	if (pathspec) {
>  		copy_pathspec(&rev.prune_data, pathspec);
> +		rev.ps_matched = ps_matched;
> +	}
>  	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>  	rev.diffopt.format_callback = update_callback;
>  	rev.diffopt.format_callback_data = &data;
> diff --git a/revision.h b/revision.h
> index 94c43138bc..0e470d1df1 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -142,6 +142,7 @@ struct rev_info {
>  	/* Basic information */
>  	const char *prefix;
>  	const char *def;
> +	char *ps_matched; /* optionally record matches of prune_data */
>  	struct pathspec prune_data;
>  
>  	/*
> -- 
> 2.44.0-413-gd6fd04375f
> 
