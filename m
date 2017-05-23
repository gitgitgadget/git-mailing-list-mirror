Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62ADE20281
	for <e@80x24.org>; Tue, 23 May 2017 18:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761669AbdEWSka (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 14:40:30 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34626 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbdEWSk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 14:40:29 -0400
Received: by mail-pf0-f170.google.com with SMTP id 9so122639652pfj.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 11:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0yCLl1aZQfhAAfNrcTTVvNT9nQ/dtS/ZVhIwFjgTxs4=;
        b=NiSnnzAFmmBToEq79dbrIOp85lAUrs+4cExfGgbT6svAMhte99+3gEXUI6fQWDkQoG
         tEdjJfUuXpsxXOY9nmZ6cBpv68F1sAzolQ6aOlqQFL2j7Ck15gd1oqXENySzlDPK7zYF
         nrl3hXQKMLJjrO4M52v2Vvw0qgSRI43MXwa8gESn0FUcno/RYm1rSkf1mbfDmLEZxAlQ
         4Jfdbk0upcRh7vJlWo6SNiaFCMY+3KJKw/48TzgUGFs1VbSu45ZomL0JxlGGcO3hysrb
         6jefUD5r56zggg3NUzem7NTJRtmlEdo9sBDaW437AH89Pk4vwqShu8Mesxxc1uRHaa1M
         eEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0yCLl1aZQfhAAfNrcTTVvNT9nQ/dtS/ZVhIwFjgTxs4=;
        b=UGO0/WovwHZBokQqPu3Z66uOep5x2e9t1iLX3htmOMmALo14268vzTBXrRJFSr9wgb
         AYLRm1B4xwg3WYIOOuqbpcwCwlSK7OgLPHZCMhbHFFQqns3CIjRlmt0y33Yw/ngrj7hd
         F5UMoHEWCqqimjZpWhhZQYg0bEG6PrhZBXZupxoin7l2ejqPVguzyLFjdWhc4oOSmA70
         pYetjpDoXKByCqD0CCDSC1fCLJAKa0fIYe442b4/At6Xi0zvE9hCcnfvdwKMIDVriqgU
         p73r9rr5jWGqQuQ8BwVJIknX0PiYCMIpZYSDKxmCEV+wm2FGfk0V6DrW973/Bph6hA7y
         TrpA==
X-Gm-Message-State: AODbwcDnmALmDUc2Q5XYtt+ffrXVrZa0V9gggvMbtKqSpHg2kY9ksTvu
        L4ehFEV/pLdx2db1SVjQRw==
X-Received: by 10.84.143.195 with SMTP id 61mr37718280plz.158.1495564828206;
        Tue, 23 May 2017 11:40:28 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6539:887d:745f:6fdf])
        by smtp.gmail.com with ESMTPSA id c7sm3494417pfk.103.2017.05.23.11.40.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 11:40:27 -0700 (PDT)
Date:   Tue, 23 May 2017 11:40:26 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCHv2 1/6] submodule.c: add has_submodules to check if we
 have any submodules
Message-ID: <20170523184026.GD115919@google.com>
References: <20170522194806.13568-1-sbeller@google.com>
 <20170522194806.13568-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170522194806.13568-2-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/22, Stefan Beller wrote:
> When submodules are involved, it often slows down the process, as most
> submodule related handling is either done via a child process or by
> iterating over the index finding all gitlinks.
> 
> For most commands that may interact with submodules, we need have a
> quick check if we do have any submodules at all, such that we can
> be fast in the case when no submodules are in use.  For this quick
> check introduce a function that checks with different heuristics if
> we do have submodules around, checking if
> * anything related to submodules is configured,
> * absorbed git dirs for submodules are present,
> * the '.gitmodules' file exists
> * gitlinks are recorded in the index.
> 
> Each heuristic has advantages and disadvantages.
> For example in a later patch, when we first use this function in
> git-clone, we'll just check for the existence of the '.gitmodules'
> file, because at the time of running the clone command there will
> be no absorbed git dirs or submodule configuration around.
> 
> Checking for any configuration related to submodules would be useful
> in a later stage (after cloning) to see if the submodules are actually
> in use.
> 
> Checking for absorbed git directories is good to see if the user has
> actually cloned submodules already (i.e. not just initialized them by
> configuring them).
> 
> The heuristic for checking the configuration requires this patch
> to have have a global state, whether the submodule config has already
> been read, and if there were any submodule related keys. Make
> 'submodule_config' private to the submodule code, and introduce
> 'load_submodule_config' that will take care of this global state.

It doesn't look like any patches actually use this helper, is this
intended?

> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/checkout.c          |  2 +-
>  builtin/fetch.c             |  3 +-
>  builtin/read-tree.c         |  3 +-
>  builtin/reset.c             |  3 +-
>  builtin/submodule--helper.c | 10 ++----
>  submodule.c                 | 80 ++++++++++++++++++++++++++++++++++++---------
>  submodule.h                 |  8 ++++-
>  unpack-trees.c              |  3 +-
>  8 files changed, 79 insertions(+), 33 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index bfa5419f33..2787b343b1 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1215,7 +1215,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
> -		git_config(submodule_config, NULL);
> +		load_submodule_config();
>  		if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
>  			set_config_update_recurse_submodules(recurse_submodules);
>  	}
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 4ef7a08afc..4b5f172623 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1343,8 +1343,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  			int arg = parse_fetch_recurse_submodules_arg("--recurse-submodules-default", recurse_submodules_default);
>  			set_config_fetch_recurse_submodules(arg);
>  		}
> -		gitmodules_config();
> -		git_config(submodule_config, NULL);
> +		load_submodule_config();
>  	}
>  
>  	if (all) {
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index 23e212ee8c..2f7f085b82 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -176,8 +176,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>  	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
>  
>  	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT) {
> -		gitmodules_config();
> -		git_config(submodule_config, NULL);
> +		load_submodule_config();
>  		set_config_update_recurse_submodules(RECURSE_SUBMODULES_ON);
>  	}
>  
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 5ce27fcaed..319d8c1201 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -320,8 +320,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
>  
>  	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT) {
> -		gitmodules_config();
> -		git_config(submodule_config, NULL);
> +		load_submodule_config();
>  		set_config_update_recurse_submodules(RECURSE_SUBMODULES_ON);
>  	}
>  
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 85aafe46a4..92e13abe2d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1013,9 +1013,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>  	if (pathspec.nr)
>  		suc.warn_if_uninitialized = 1;
>  
> -	/* Overlay the parsed .gitmodules file with .git/config */
> -	gitmodules_config();
> -	git_config(submodule_config, NULL);
> +	load_submodule_config();
>  
>  	if (max_jobs < 0)
>  		max_jobs = parallel_submodules();
> @@ -1057,9 +1055,8 @@ static int resolve_relative_path(int argc, const char **argv, const char *prefix
>  static const char *remote_submodule_branch(const char *path)
>  {
>  	const struct submodule *sub;
> -	gitmodules_config();
> -	git_config(submodule_config, NULL);
>  
> +	load_submodule_config();
>  	sub = submodule_from_path(null_sha1, path);
>  	if (!sub)
>  		return NULL;
> @@ -1129,8 +1126,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, embed_gitdir_options,
>  			     git_submodule_helper_usage, 0);
>  
> -	gitmodules_config();
> -	git_config(submodule_config, NULL);
> +	load_submodule_config();
>  
>  	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
>  		return 1;
> diff --git a/submodule.c b/submodule.c
> index 20ed5b5681..dda5ed210f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -24,6 +24,12 @@ static int initialized_fetch_ref_tips;
>  static struct sha1_array ref_tips_before_fetch;
>  static struct sha1_array ref_tips_after_fetch;
>  
> +static enum {
> +	SUBMODULE_CONFIG_NOT_READ = 0,
> +	SUBMODULE_CONFIG_NO_CONFIG,
> +	SUBMODULE_CONFIG_EXISTS,
> +} submodule_config_reading;
> +
>  /*
>   * The following flag is set if the .gitmodules file is unmerged. We then
>   * disable recursion for all submodules where .git/config doesn't have a
> @@ -83,6 +89,64 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
>  	return 0;
>  }
>  
> +static int submodule_config(const char *var, const char *value, void *cb)
> +{
> +	if (!strcmp(var, "submodule.fetchjobs")) {
> +		submodule_config_reading = SUBMODULE_CONFIG_EXISTS;
> +		parallel_jobs = git_config_int(var, value);
> +		if (parallel_jobs < 0)
> +			die(_("negative values not allowed for submodule.fetchJobs"));
> +		return 0;
> +	} else if (starts_with(var, "submodule.")) {
> +		submodule_config_reading = SUBMODULE_CONFIG_EXISTS;
> +		return parse_submodule_config_option(var, value);
> +	} else if (!strcmp(var, "fetch.recursesubmodules")) {
> +		submodule_config_reading = SUBMODULE_CONFIG_EXISTS;
> +		config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
> +		return 0;
> +	}
> +	return 0;
> +}
> +
> +void load_submodule_config(void)
> +{
> +	submodule_config_reading = SUBMODULE_CONFIG_NO_CONFIG;
> +
> +	gitmodules_config();
> +	git_config(submodule_config, NULL);
> +}
> +
> +int has_submodules(unsigned what_to_check)
> +{
> +	if (what_to_check & SUBMODULE_CHECK_ANY_CONFIG) {
> +		if (submodule_config_reading == SUBMODULE_CONFIG_NOT_READ)
> +			load_submodule_config();
> +		if (submodule_config_reading == SUBMODULE_CONFIG_EXISTS)
> +			return 1;
> +	}
> +
> +	if ((what_to_check & SUBMODULE_CHECK_ABSORBED_GIT_DIRS) &&
> +	    file_exists(git_path("modules")))
> +		return 1;
> +
> +	if ((what_to_check & SUBMODULE_CHECK_GITMODULES_IN_WT) &&
> +	    (!is_bare_repository() && file_exists(".gitmodules")))
> +		return 1;
> +
> +	if (what_to_check & SUBMODULE_CHECK_GITLINKS_IN_TREE) {
> +		int i;
> +
> +		if (read_cache() < 0)
> +			die(_("index file corrupt"));
> +
> +		for (i = 0; i < active_nr; i++)
> +			if (S_ISGITLINK(active_cache[i]->ce_mode))
> +				return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Try to remove the "submodule.<name>" section from .gitmodules where the given
>   * path is configured. Return 0 only if a .gitmodules file was found, a section
> @@ -152,22 +216,6 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
>  	}
>  }
>  
> -int submodule_config(const char *var, const char *value, void *cb)
> -{
> -	if (!strcmp(var, "submodule.fetchjobs")) {
> -		parallel_jobs = git_config_int(var, value);
> -		if (parallel_jobs < 0)
> -			die(_("negative values not allowed for submodule.fetchJobs"));
> -		return 0;
> -	} else if (starts_with(var, "submodule."))
> -		return parse_submodule_config_option(var, value);
> -	else if (!strcmp(var, "fetch.recursesubmodules")) {
> -		config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
> -		return 0;
> -	}
> -	return 0;
> -}
> -
>  void gitmodules_config(void)
>  {
>  	const char *work_tree = get_git_work_tree();
> diff --git a/submodule.h b/submodule.h
> index 8a8bc49dc9..5ec72fbb16 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -1,6 +1,12 @@
>  #ifndef SUBMODULE_H
>  #define SUBMODULE_H
>  
> +#define SUBMODULE_CHECK_ANY_CONFIG		(1<<0)
> +#define SUBMODULE_CHECK_ABSORBED_GIT_DIRS	(1<<1)
> +#define SUBMODULE_CHECK_GITMODULES_IN_WT	(1<<2)
> +#define SUBMODULE_CHECK_GITLINKS_IN_TREE 	(1<<3)
> +int has_submodules(unsigned what_to_check);
> +
>  struct diff_options;
>  struct argv_array;
>  struct sha1_array;
> @@ -37,7 +43,7 @@ extern int remove_path_from_gitmodules(const char *path);
>  extern void stage_updated_gitmodules(void);
>  extern void set_diffopt_flags_from_submodule_config(struct diff_options *,
>  		const char *path);
> -extern int submodule_config(const char *var, const char *value, void *cb);
> +extern void load_submodule_config(void);
>  extern void gitmodules_config(void);
>  extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
>  extern int is_submodule_initialized(const char *path);
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 4b3f9518e5..e3174b3b66 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -291,8 +291,7 @@ static void reload_gitmodules_file(struct index_state *index,
>  			else if (r == 0) {
>  				submodule_free();
>  				checkout_entry(ce, state, NULL);
> -				gitmodules_config();
> -				git_config(submodule_config, NULL);
> +				load_submodule_config();
>  			} else
>  				break;
>  		}
> -- 
> 2.13.0.18.g7d86cc8ba0
> 

-- 
Brandon Williams
