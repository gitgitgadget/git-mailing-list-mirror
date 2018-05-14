Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EC441F406
	for <e@80x24.org>; Mon, 14 May 2018 18:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeENSTc (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 14:19:32 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39756 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeENSTa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 14:19:30 -0400
Received: by mail-pg0-f68.google.com with SMTP id e1-v6so5830017pga.6
        for <git@vger.kernel.org>; Mon, 14 May 2018 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WcRCKRZ7cxCJ3V6eQGmLoXred3xI/1Cth8RnuxA90kA=;
        b=S++yfdKz3+Kuep9mByFygK7O1M/jcUr7Ghpwq4zBxO8wOaZxEuI/MKzbCInXAjlxKn
         HxfYJwrEsrQiZpa6ocyNPT0mqtAzLlDqEdCgwBwFBCSiLCaT/zAwoqnD36gueAU7nZgh
         xfn8g3Jew5JcNV9Iu3Ra/CWbNJfYl5aR7b6nS2Noo3TcLjPgcYHPV9iGx3gNHe9rQlZH
         5P4d+hifFeJXIMEyv6wFNqFDWRUPMg1dZ0blEriHB9WuLreFUTHv9qDNIVO9dOSJL/d5
         7B09maVX06PP70WuTXjHLwfyg0qbCEgpfYYSS9GhhCDFIihKRP/ZkRg2xVOcJhA7y5rl
         LU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WcRCKRZ7cxCJ3V6eQGmLoXred3xI/1Cth8RnuxA90kA=;
        b=keaVkAtSlsOQW44guopapeDtKWEj5jr2GwMu97qdohlYWJP8NBKsrQuwllLv0IBfit
         xfJVqiebZVbqHGYXF6FlMkiraC2gvWkX4bvV0A3GjYkICJUlhUqv4Ppue5vZI4oND2DW
         PP+U0JKXI3PYQ9qDJ3yQihhE9l7xgGj7ew5JgR89pKtbaBe7vpD3BY1SOeeyuz2IY/jX
         UYckD9nGq8ajy0reGfQAtpwnpOSqyOfJB7vHsoZxT7FVdOLLZyBxT20b7aZFMpkwtQiP
         vE4DZLLywTGxeLRpc8pxEIIfWR+RQMwCvnaeWe1ali8KGWudsXvkfkKEz/2Q5TeGOlOl
         Ou2w==
X-Gm-Message-State: ALKqPwf31mUtjoF1/qX3fLdiRjhw3LW4IUbU1mbDL8umgxaqg73BX05Q
        YWGoHi/VSYyEWQHIT518ZU6Cng==
X-Google-Smtp-Source: AB8JxZryUR4/GC4UVW5UHhyiSxtZzUYKvxcmQla1+5uHjo1EUkGyPwRpQQITmRTkrY1K0KWxmsPbqg==
X-Received: by 2002:a63:6584:: with SMTP id z126-v6mr9381272pgb.168.1526321970007;
        Mon, 14 May 2018 11:19:30 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id r84-v6sm19423777pfa.125.2018.05.14.11.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 11:19:29 -0700 (PDT)
Date:   Mon, 14 May 2018 11:19:28 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org,
        Daniel =?iso-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 01/10] config: make config_from_gitmodules generally
 useful
Message-ID: <20180514181928.GA235601@google.com>
References: <20180514105823.8378-1-ao2@ao2.it>
 <20180514105823.8378-2-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514105823.8378-2-ao2@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/14, Antonio Ospite wrote:
> The config_from_gitmodules() function is a good candidate for
> a centralized point where to read the gitmodules configuration file.
> 
> Add a repo argument to it to make the function more general, and adjust
> the current callers in cmd_fetch and update-clone.
> 
> As a proof of the utility of the change, start using the function also
> in repo_read_gitmodules which was basically doing the same operations.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>  builtin/fetch.c             |  2 +-
>  builtin/submodule--helper.c |  2 +-
>  config.c                    | 13 +++++++------
>  config.h                    | 10 +---------
>  submodule-config.c          | 16 ++++------------
>  5 files changed, 14 insertions(+), 29 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7ee83ac0f..a67ee7c39 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1445,7 +1445,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	for (i = 1; i < argc; i++)
>  		strbuf_addf(&default_rla, " %s", argv[i]);
>  
> -	config_from_gitmodules(gitmodules_fetch_config, NULL);
> +	config_from_gitmodules(gitmodules_fetch_config, the_repository, NULL);
>  	git_config(git_fetch_config, NULL);
>  
>  	argc = parse_options(argc, argv, prefix,
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index c2403a915..9e8f2acd5 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1602,7 +1602,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>  	};
>  	suc.prefix = prefix;
>  
> -	config_from_gitmodules(gitmodules_update_clone_config, &max_jobs);
> +	config_from_gitmodules(gitmodules_update_clone_config, the_repository, &max_jobs);
>  	git_config(gitmodules_update_clone_config, &max_jobs);
>  
>  	argc = parse_options(argc, argv, prefix, module_update_clone_options,
> diff --git a/config.c b/config.c
> index 6f8f1d8c1..8ffe29330 100644
> --- a/config.c
> +++ b/config.c
> @@ -2173,17 +2173,18 @@ int git_config_get_pathname(const char *key, const char **dest)
>  }
>  
>  /*
> - * Note: This function exists solely to maintain backward compatibility with
> - * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
> - * NOT be used anywhere else.
> + * Note: Initially this function existed solely to maintain backward
> + * compatibility with 'fetch' and 'update_clone' storing configuration in
> + * '.gitmodules' but it turns out it can be useful as a centralized point to
> + * read the gitmodules config file.

I'm all for what you're trying to accomplish in this patch series but I
think a little more care needs to be taken here.  Maybe about a year ago
I did some refactoring with how the gitmodules file was loaded and it
was decided that allowing arbitrary configuration in the .gitmodules
file was a bad thing, so I tried to make sure that it was very difficult
to sneak in more of that and limiting it to the places where it was
already done (fetch and update_clone).  Now this patch is explicitly
changing the comment on this function to loosen the requirements I made
when it was introduced, which could be problematic in the future.

So here's what I suggest doing:
  1. Move this function from config.{c,h} to submodule-config.{c,h} to
     make it clear who owns this.
  2. Move the gitmodules_set function you created to live in submodule-config.
  3. You can still use this function as the main driver for reading the
     submodule config BUT the comment above the function in both the .c and
     .h files should be adapted so that it is clearly spells out that the
     function is to be used only by the submodule config code (reading it
     in repo_read_gitmodules and reading/writing it in the
     submodule-helper config function you've added) and that the only
     exceptions to this are to maintain backwards compatibility with the
     existing callers and that new callers shouldn't be added.

This is just a long way to say that if new callers to this function are
added in the future that it is made very clear in the code that the
.gitmodules file exists for a specific purpose and that it shouldn't be
exploited to ship config with a repository. (If we end up allowing
config to be shipped with a repository at a later date that will need to
be handled with great care due to security concerns).

Thanks for working on this, the end result is definitely a step in the
direction I've wanted the submodule config to head to.

>   *
>   * Runs the provided config function on the '.gitmodules' file found in the
>   * working directory.
>   */
> -void config_from_gitmodules(config_fn_t fn, void *data)
> +void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
>  {
> -	if (the_repository->worktree) {
> -		char *file = repo_worktree_path(the_repository, GITMODULES_FILE);
> +	if (repo->worktree) {
> +		char *file = repo_worktree_path(repo, GITMODULES_FILE);
>  		git_config_from_file(fn, file, data);
>  		free(file);
>  	}
> diff --git a/config.h b/config.h
> index cdac2fc73..43ce76c0f 100644
> --- a/config.h
> +++ b/config.h
> @@ -215,15 +215,7 @@ extern int repo_config_get_maybe_bool(struct repository *repo,
>  extern int repo_config_get_pathname(struct repository *repo,
>  				    const char *key, const char **dest);
>  
> -/*
> - * Note: This function exists solely to maintain backward compatibility with
> - * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
> - * NOT be used anywhere else.
> - *
> - * Runs the provided config function on the '.gitmodules' file found in the
> - * working directory.
> - */
> -extern void config_from_gitmodules(config_fn_t fn, void *data);
> +extern void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data);
>  
>  extern int git_config_get_value(const char *key, const char **value);
>  extern const struct string_list *git_config_get_value_multi(const char *key);
> diff --git a/submodule-config.c b/submodule-config.c
> index d87c3ff63..f39c71dfb 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -577,19 +577,11 @@ void repo_read_gitmodules(struct repository *repo)
>  {
>  	submodule_cache_check_init(repo);
>  
> -	if (repo->worktree) {
> -		char *gitmodules;
> -
> -		if (repo_read_index(repo) < 0)
> -			return;
> -
> -		gitmodules = repo_worktree_path(repo, GITMODULES_FILE);
> -
> -		if (!is_gitmodules_unmerged(repo->index))
> -			git_config_from_file(gitmodules_cb, gitmodules, repo);
> +	if (repo_read_index(repo) < 0)
> +		return;
>  
> -		free(gitmodules);
> -	}
> +	if (!is_gitmodules_unmerged(repo->index))
> +		config_from_gitmodules(gitmodules_cb, repo, repo);
>  
>  	repo->submodule_cache->gitmodules_read = 1;
>  }
> -- 
> 2.17.0
> 

-- 
Brandon Williams
