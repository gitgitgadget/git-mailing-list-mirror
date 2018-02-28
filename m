Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822F01F404
	for <e@80x24.org>; Wed, 28 Feb 2018 18:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932120AbeB1SMF (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 13:12:05 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45544 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeB1SME (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 13:12:04 -0500
Received: by mail-pg0-f66.google.com with SMTP id i133so1234018pgc.12
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 10:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6ykzvpvnBAkLjxp3HPlWiCFjR2a+DgYdfw2APHfkv9w=;
        b=O6NSa+C+t+QpAXBeP7pGpAgYEHmkhQ/5zL/Odesc9n2cmWDgJmpOadbxfgC5zqNEcP
         PihQr24PO8vnC0WA7kY2TxoVHxMFwoMGWIMwxcCSm+MP1EGGTxAC0xJTWFiiMCmoWcoq
         zjD2ZgdBAaMiIde/negXiBT00h9Vxhu34uWz5ZsobwVbqMXhyHM9BlsZ8A/Xm9AQJr8R
         iaL2k87K9+lRvQHQHKqB7gtgQvIh3WULeqLcKZUfzQLubwTEPqH++2/aVOdjm4+2IC66
         P4YhgZWhYZ8yPDZxideBWmfVHTnqUKFdx9kSBvG5wmF31ffDxEONSgrXHNQeLbUksQQP
         5/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6ykzvpvnBAkLjxp3HPlWiCFjR2a+DgYdfw2APHfkv9w=;
        b=ENDfrnk8d8VzegP01VlbO4YQhQxiT0f4AX5dP30OlbEzlKVZhvOapoMRIPkxPwaVlF
         xR4sE76ccT4WQhkQSpMp/vbQdx6as1VbgRXVJr4ZkJhZcgHevs3WEGg0RWQMYyLVW5kc
         A0d3Glm+kr09cf1jXdta6v6IZTNaII/Pa/G8iqu7mDLtT+LsuECmMdfTjm0nyLZBlgBV
         x9bECysro7+EjcW+MdES5w0h48vQjapJ39Aa+2GNJiJlI7YfwEbjZCJ6WZi3GGbU1uPy
         877MMiSsynaJIWMwcCWCDd3H3uFSP3ZcwPbFcBIkUdg56x1JDEbJ96El1kt7HI8y+7P4
         /j/g==
X-Gm-Message-State: APf1xPA2ggvngbdDIUuhtoVi74Olmp9NLdelKa9oP1b7UgmwjUZKLasQ
        cmZC5FrN98ePkLwjS4ZG64KuWA==
X-Google-Smtp-Source: AH8x224zpMFYe+mRhRtWNVVlXWndoMnAE5XyY2SHBprxzulnN+/0OMFxCAsxx2CTX1EkmuWGGGCOBw==
X-Received: by 10.101.96.212 with SMTP id r20mr14951858pgv.139.1519841523646;
        Wed, 28 Feb 2018 10:12:03 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id y124sm3896919pgb.29.2018.02.28.10.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 10:12:02 -0800 (PST)
Date:   Wed, 28 Feb 2018 10:12:01 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        sbeller@google.com, sunshine@sunshineco.com
Subject: Re: [PATCH v3 0/4] Delete ignore_env member in struct repository
Message-ID: <20180228181201.GA87122@google.com>
References: <20180227095846.9238-1-pclouds@gmail.com>
 <20180228013727.13815-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180228013727.13815-1-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/28, Nguyễn Thái Ngọc Duy wrote:
> v3 fixes comment style. Also since Brandon raised a question about
> shared_root, it's obviously not a good name, so I renamed it to
> commondir.

Thanks, its a bit clearer and more consistent with the rest of the
terminology we already have :)

> 
> I still keep the delete patch 2/4, but I move the repo_setup_env()
> deletion back to 1/4 so all env logic is in one patch (the
> introduction of new helper functions in 1/4 and deletion in 2/4 are
> still diff noise if 2/4 is completely merged back).
> 
> Interdiff:
> 
> diff --git a/environment.c b/environment.c
> index 47c6e31559..b2128c1188 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -149,7 +149,8 @@ static char *expand_namespace(const char *raw_namespace)
>  	return strbuf_detach(&buf, NULL);
>  }
>  
> -/* Wrapper of getenv() that returns a strdup value. This value is kept
> +/*
> + * Wrapper of getenv() that returns a strdup value. This value is kept
>   * in argv to be freed later.
>   */
>  static const char *getenv_safe(struct argv_array *argv, const char *name)
> @@ -170,7 +171,7 @@ void setup_git_env(const char *git_dir)
>  	struct set_gitdir_args args = { NULL };
>  	struct argv_array to_free = ARGV_ARRAY_INIT;
>  
> -	args.shared_root = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
> +	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
>  	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
>  	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
>  	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
> diff --git a/repository.c b/repository.c
> index c555dacad2..4f44384dde 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -27,15 +27,15 @@ static void expand_base_dir(char **out, const char *in,
>  }
>  
>  static void repo_set_commondir(struct repository *repo,
> -			       const char *shared_root)
> +			       const char *commondir)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  
>  	free(repo->commondir);
>  
> -	if (shared_root) {
> +	if (commondir) {
>  		repo->different_commondir = 1;
> -		repo->commondir = xstrdup(shared_root);
> +		repo->commondir = xstrdup(commondir);
>  		return;
>  	}
>  
> @@ -58,7 +58,7 @@ void repo_set_gitdir(struct repository *repo,
>  	repo->gitdir = xstrdup(gitfile ? gitfile : root);
>  	free(old_gitdir);
>  
> -	repo_set_commondir(repo, o->shared_root);
> +	repo_set_commondir(repo, o->commondir);
>  	expand_base_dir(&repo->objects.objectdir, o->object_dir,
>  			repo->commondir, "objects");
>  	free(repo->objects.alternate_db);
> diff --git a/repository.h b/repository.h
> index 07e8971428..e05a77a099 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -81,7 +81,7 @@ struct repository {
>  extern struct repository *the_repository;
>  
>  struct set_gitdir_args {
> -	const char *shared_root;
> +	const char *commondir;
>  	const char *object_dir;
>  	const char *graft_file;
>  	const char *index_file;
> 
> Nguyễn Thái Ngọc Duy (4):
>   repository.c: move env-related setup code back to environment.c
>   repository.c: delete dead functions
>   sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
>   repository: delete ignore_env member
> 
>  cache.h        |  2 +-
>  environment.c  | 31 +++++++++++++++++--
>  object-store.h |  5 ++-
>  object.c       |  1 +
>  repository.c   | 84 ++++++++++++++++++++++++--------------------------
>  repository.h   | 21 +++++++------
>  setup.c        |  3 +-
>  sha1_file.c    |  6 +---
>  8 files changed, 87 insertions(+), 66 deletions(-)
> 
> -- 
> 2.16.1.399.g632f88eed1
> 

-- 
Brandon Williams
