Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1E21F516
	for <e@80x24.org>; Fri, 22 Jun 2018 16:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933860AbeFVQzT (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 12:55:19 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43947 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933549AbeFVQzR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 12:55:17 -0400
Received: by mail-pl0-f65.google.com with SMTP id c41-v6so3753743plj.10
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l9x6O/oGCELzKelFSL1JXMx2PIx1dFBZJpuzRocsW9M=;
        b=D2S+0mme2HJP/Jyr6PAELzsMYjazC+Njc+3Z0TneosGTwPjD04euWOIl7blqVmmxyw
         apDjDIosfW4RnoSKPS5ls3+9eKmg/omoMOKDbDAimZ1z9s8eV+uoQoTC6HjSdQSC8MPh
         hsxCoyV44fP8azgNc1uXrYGwVm8bPjn0gJe/6CaFbRm0q2UdF4mi3FSdzjPEjLZcLCuo
         FbcWsqJ0OTwcfrpAuaZ6xF5+wtjUUAldZLBjiUobWer1rMY2j2acSEOe7KhVfyTtIHlb
         SLIEBtWuH91jq94C1s5vwpEMnPOOkI2gZscXf6t2UnsVZsvVg61lzXj03tMLysF0vQtP
         uoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l9x6O/oGCELzKelFSL1JXMx2PIx1dFBZJpuzRocsW9M=;
        b=Bv+Uj8+fB5HQXnFEyzoLbuY8GycfZtoNV2s/11HSCV5+1GWdz7FPmJxCz30kzQL8dY
         gfaDMwNYT+ocv247SuJaeXWj7QL2bYs6nIlFH+5ps9/SQLO10GXiKRFRWo5SjBep+Jit
         ZoU4xQaGmHghclvhD1pDLxZP2gsJlnBWF5GXNNYfqoXEMmsT8pBVql6fX/EHFzz7Fsbq
         IWwAWzFLt8Zl8ShjCBJ8I9hd44YpIsYdVnPkXGkM41zIwiCUPRtMgMpyOuDMHVJHPLDL
         yrJ/C9Kq9Db56pexeQKe0arTHVstOgC/jH/Ke+TcVypqiuUuQwsbKmP0/03I/FlmqCJo
         e7Vw==
X-Gm-Message-State: APt69E3teeh8AW5zKl8LULWeo+u5FlhJ3tjxNN/ZXubk/v7Iyl+EBYd6
        M9O1LczGF6eUPM3j3zRw/c5SjQ==
X-Google-Smtp-Source: ADUXVKLgRqNFxtmLpEzrjV2SfJQaVjKqnknSG3iZZhnBxX1chaswvUFaQja9mZ5Lj+gQ3ipjMlcCrw==
X-Received: by 2002:a17:902:b48f:: with SMTP id y15-v6mr2486684plr.261.1529686517018;
        Fri, 22 Jun 2018 09:55:17 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id k84-v6sm23825240pfh.110.2018.06.22.09.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 09:55:15 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:55:14 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/7] submodule-config: reuse config_from_gitmodules in
 repo_read_gitmodules
Message-ID: <20180622165514.GC244185@google.com>
References: <20180622162656.19338-1-ao2@ao2.it>
 <20180622162656.19338-7-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180622162656.19338-7-ao2@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/22, Antonio Ospite wrote:
> Reuse config_from_gitmodules in repo_read_gitmodules to remove some
> duplication and also have a single point where the .gitmodules file is
> read.
> 
> The change does not introduce any new behavior, the same gitmodules_cb
> config callback is still used which only deals with configuration
> specific to submodules.
> 
> The config_from_gitmodules function is moved up in the file —unchanged—
> before its users to avoid a forward declaration.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>  submodule-config.c | 50 +++++++++++++++++++---------------------------
>  1 file changed, 21 insertions(+), 29 deletions(-)
> 
> diff --git a/submodule-config.c b/submodule-config.c
> index e50c944eb..ce204fb53 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -591,6 +591,23 @@ static void submodule_cache_check_init(struct repository *repo)
>  	submodule_cache_init(repo->submodule_cache);
>  }
>  
> +/*
> + * Note: This function is private for a reason, the '.gitmodules' file should
> + * not be used as as a mechanism to retrieve arbitrary configuration stored in
> + * the repository.
> + *
> + * Runs the provided config function on the '.gitmodules' file found in the
> + * working directory.
> + */
> +static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
> +{
> +	if (repo->worktree) {
> +		char *file = repo_worktree_path(repo, GITMODULES_FILE);
> +		git_config_from_file(fn, file, data);
> +		free(file);
> +	}
> +}
> +
>  static int gitmodules_cb(const char *var, const char *value, void *data)
>  {
>  	struct repository *repo = data;
> @@ -608,19 +625,11 @@ void repo_read_gitmodules(struct repository *repo)
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

So the check for the repo's worktree has been pushed into
config_from_gitmodules().  This looks like the right thing to do in
order to get to a world where you'd rather read the gitmodules file from
the index instead of the worktree.

>  
>  	repo->submodule_cache->gitmodules_read = 1;
>  }
> @@ -672,23 +681,6 @@ void submodule_free(struct repository *r)
>  		submodule_cache_clear(r->submodule_cache);
>  }
>  
> -/*
> - * Note: This function is private for a reason, the '.gitmodules' file should
> - * not be used as as a mechanism to retrieve arbitrary configuration stored in
> - * the repository.
> - *
> - * Runs the provided config function on the '.gitmodules' file found in the
> - * working directory.
> - */
> -static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
> -{
> -	if (repo->worktree) {
> -		char *file = repo_worktree_path(repo, GITMODULES_FILE);
> -		git_config_from_file(fn, file, data);
> -		free(file);
> -	}
> -}
> -
>  struct fetch_config {
>  	int *max_children;
>  	int *recurse_submodules;
> -- 
> 2.18.0
> 

-- 
Brandon Williams
