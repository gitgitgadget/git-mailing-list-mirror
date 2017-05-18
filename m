Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F22C201CF
	for <e@80x24.org>; Thu, 18 May 2017 15:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932783AbdERPfP (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 11:35:15 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36443 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932283AbdERPfM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 11:35:12 -0400
Received: by mail-pg0-f54.google.com with SMTP id x64so24460802pgd.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4H+KAwLbvMuR8sObJO+iAIfgIBwuzMPRyF5qzjvZUuk=;
        b=Iba6fFC1pZMB0C6J9zPaHc2xILEvFkLMfhansruVWpN17jWiG2IFRfpxh+d7Aljx5X
         rXVxDWBddBp1a9SKJwu+EmeVZsa7QUGvsPdg7T59o4e+HWUAAfCYLG2fVZdCpFHkpJyO
         7DUZyZjQU+MBL451GgUSfh7wHZzuKrSvj2ZptkKWSghm4zYyEk7d1QBsp1X/TaHJQl6v
         56Boiya3Ti8Cnpy7p8JcpmEXFAcAbnZCZLJzmBWZopsZuIeYQdj3eQjmN12qwoqKkRAe
         +Kub+QWa0Q5DhUMMLysQYlTKiVHDNCal/Yozz9en0MBfPF50ap/kXIzfqr8hngxVLrPY
         gHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4H+KAwLbvMuR8sObJO+iAIfgIBwuzMPRyF5qzjvZUuk=;
        b=AwQ+EEqGnQEXC/xLN2YwDdzM3gS4S/Ck1ft0Uts/kb+BaZg2sFILCsuFHb2hUGod3w
         SbhMim77XngEnEXEY95UDtcbPzzAUP2Ukrko90PYt4AsFT7ZHqTjTOdopixbxhbxPnwz
         c3qSAos1SdEbqvTdCZw8jgLgB6fw8HjlFTCOJQ8WHskARXFtUzrgXMYl03ZhYLfCLpoS
         TogZpmIpOVGw/Yvc3TipXcL91CWAOekzWxM3Bpg1c0WDktCLbGPwkwKnnsxXqGe6bhQo
         jF2v3Mbc9D1qlwq+d9bcsFmMsrZ3MdpRNmGPV9q4XC3RYYrbRqfL6rha2b7C3qis+rwd
         TTKA==
X-Gm-Message-State: AODbwcCNKaRqqU2LHpSLuYdxG0Qkd6EZhPF8U2FLbPr5U7JpZZ3xqjQm
        iA+4Xzv2C+JEyrRo
X-Received: by 10.98.48.131 with SMTP id w125mr5240253pfw.141.1495121711531;
        Thu, 18 May 2017 08:35:11 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1838:1185:c4dc:8c8d])
        by smtp.gmail.com with ESMTPSA id 192sm9979214pfb.10.2017.05.18.08.35.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 08:35:10 -0700 (PDT)
Date:   Thu, 18 May 2017 08:35:08 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] submodule.c: add has_submodules to check if we have
 any submodules
Message-ID: <20170518153508.GA112091@google.com>
References: <20170517213135.20988-1-sbeller@google.com>
 <20170517213135.20988-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517213135.20988-2-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/17, Stefan Beller wrote:
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
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/checkout.c          |  2 +-
>  builtin/fetch.c             |  2 +-
>  builtin/read-tree.c         |  2 +-
>  builtin/reset.c             |  2 +-
>  builtin/submodule--helper.c |  6 ++--
>  submodule.c                 | 78 +++++++++++++++++++++++++++++++++++----------
>  submodule.h                 |  8 ++++-
>  unpack-trees.c              |  2 +-
>  8 files changed, 77 insertions(+), 25 deletions(-)
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
> index 4ef7a08afc..510ef1c9de 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1344,7 +1344,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  			set_config_fetch_recurse_submodules(arg);
>  		}
>  		gitmodules_config();
> -		git_config(submodule_config, NULL);
> +		load_submodule_config();
>  	}
>  
>  	if (all) {
> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index 23e212ee8c..fe2ec60a51 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -177,7 +177,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>  
>  	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT) {
>  		gitmodules_config();
> -		git_config(submodule_config, NULL);
> +		load_submodule_config();
>  		set_config_update_recurse_submodules(RECURSE_SUBMODULES_ON);
>  	}
>  
> diff --git a/builtin/reset.c b/builtin/reset.c
> index 5ce27fcaed..f3aca487d9 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -321,7 +321,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  
>  	if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT) {
>  		gitmodules_config();
> -		git_config(submodule_config, NULL);
> +		load_submodule_config();
>  		set_config_update_recurse_submodules(RECURSE_SUBMODULES_ON);
>  	}
>  
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 85aafe46a4..770a95ca14 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1015,7 +1015,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>  
>  	/* Overlay the parsed .gitmodules file with .git/config */
>  	gitmodules_config();
> -	git_config(submodule_config, NULL);
> +	load_submodule_config();
>  
>  	if (max_jobs < 0)
>  		max_jobs = parallel_submodules();
> @@ -1058,7 +1058,7 @@ static const char *remote_submodule_branch(const char *path)
>  {
>  	const struct submodule *sub;
>  	gitmodules_config();
> -	git_config(submodule_config, NULL);
> +	load_submodule_config();
>  
>  	sub = submodule_from_path(null_sha1, path);
>  	if (!sub)
> @@ -1130,7 +1130,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
>  			     git_submodule_helper_usage, 0);
>  
>  	gitmodules_config();
> -	git_config(submodule_config, NULL);
> +	load_submodule_config();
>  
>  	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
>  		return 1;
> diff --git a/submodule.c b/submodule.c
> index 20ed5b5681..14ea405048 100644
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

Any way we can have this not be a global, but rather a parameter?  You
could pass in a pointer to this value via the callback data parameter in
the submodule_config function.

> +
>  /*
>   * The following flag is set if the .gitmodules file is unmerged. We then
>   * disable recursion for all submodules where .git/config doesn't have a
> @@ -83,6 +89,62 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
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
> @@ -152,22 +214,6 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
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
> index 4b3f9518e5..fe42d03a74 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -292,7 +292,7 @@ static void reload_gitmodules_file(struct index_state *index,
>  				submodule_free();
>  				checkout_entry(ce, state, NULL);
>  				gitmodules_config();
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
