Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8CE1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 21:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753767AbeCUV7N (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 17:59:13 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36404 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753534AbeCUV7M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 17:59:12 -0400
Received: by mail-pl0-f65.google.com with SMTP id 61-v6so3993294plf.3
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QI/hCMQ/TOlsgfGfMvlmjgDOBmaJOOQ5bJYVANjlijU=;
        b=aSxRtvtv8neK2zwoGWjwD89wa2bWPIUG6r+3CbJKowHVneCfhPd8Wiwl5nd6N5zMO8
         tDj1TIuOwuWCS/IbaMrX8aJlcOERq4+ZzUcoEZWUYpC4KMTq9eWJkvfQ27RYPg9SAbHu
         vDrSCYlSdV4XmR6hb4z9TttUYCvxW09wHYat8Vy3iWw+wTa6DIAk+FOJ+zTu568xOpcV
         2zWyTwzQtfnceFeIX08M4v/ghz2axSz44H1VjPFw2SXQiUehlj12qquNlZjO2+QYz+jS
         mb3NU07adaGzQaVMgS5kt8Yx7l4cPWHEfWGZd0EsTCkeKaJNVXcxzRzV+6JwYFFqSriY
         nU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QI/hCMQ/TOlsgfGfMvlmjgDOBmaJOOQ5bJYVANjlijU=;
        b=g+SMTFSB81IGqjyJXRpH4P5IeEAQU0r4oQ62yOZLdqTIeNSyB071sQyOC9gbHL61YS
         iqh4GE3BWqWWXlQfU6xZ9dXv8IY5PubQDgqi+hiPopLAqHX1rtgwa0nlhw/MYGm5xIbE
         Lg/PechI3qDtlZgKokR3oiaGa38XCnFuy8SSTthfULV1M/cIcLvUv8Xk9hqts/WwOOP7
         IJ5V+sO5DmGPFqzFaP7inkXQwBah233jqSxAXm+16xqhAkgIWEYkcO/tbfpZbZGta+Kc
         X7NR70LE2TCfvXTjRY3pA/cS1ubst5tZt5A3Uay5+9Eo0OIJHCaw++QGiglzxvHvGEpm
         tY8Q==
X-Gm-Message-State: AElRT7EPXeNrpR3aQXJNdQRd40uaMPlgYlzpff2h/skrf9PxePNSUWxc
        1/TbrupOt+p3ZuvapnjRVA1wOg==
X-Google-Smtp-Source: AG47ELscT5JE2N3g57F1cIj1xZyiIQmP3rOVrhD/6vEQqAe0wA3RENNBouGQ3rMvuYXIsartQIXEow==
X-Received: by 2002:a17:902:9308:: with SMTP id bc8-v6mr18372071plb.189.1521669551617;
        Wed, 21 Mar 2018 14:59:11 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id v8sm9967433pfa.32.2018.03.21.14.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 14:59:10 -0700 (PDT)
Date:   Wed, 21 Mar 2018 14:59:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 04/44] sha1_file.c: move delayed getenv(altdb) back to
 setup_git_env()
Message-ID: <20180321215909.GD18406@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-5-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180303113637.26518-5-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Nguyễn Thái Ngọc Duy wrote:
> getenv() is supposed to work on the main repository only. This delayed
> getenv() code in sha1_file.c makes it more difficult to convert
> sha1_file.c to a generic object store that could be used by both
> submodule and main repositories.
> 
> Move the getenv() back in setup_git_env() where other env vars are
> also fetched.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Looks good

> ---
>  environment.c | 1 +
>  repository.c  | 3 +++
>  repository.h  | 4 ++++
>  sha1_file.c   | 6 +-----
>  4 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/environment.c b/environment.c
> index da3f7daa09..a5eaa97fb1 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -174,6 +174,7 @@ void setup_git_env(const char *git_dir)
>  	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
>  	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
>  	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
> +	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
>  	repo_set_gitdir(the_repository, git_dir, &args);
>  	argv_array_clear(&to_free);
>  
> diff --git a/repository.c b/repository.c
> index e65f4138a7..04d85a2869 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -60,6 +60,8 @@ void repo_set_gitdir(struct repository *repo,
>  	repo_set_commondir(repo, o->commondir);
>  	expand_base_dir(&repo->objectdir, o->object_dir,
>  			repo->commondir, "objects");
> +	free(repo->alternate_db);
> +	repo->alternate_db = xstrdup_or_null(o->alternate_db);
>  	expand_base_dir(&repo->graft_file, o->graft_file,
>  			repo->commondir, "info/grafts");
>  	expand_base_dir(&repo->index_file, o->index_file,
> @@ -215,6 +217,7 @@ void repo_clear(struct repository *repo)
>  	FREE_AND_NULL(repo->gitdir);
>  	FREE_AND_NULL(repo->commondir);
>  	FREE_AND_NULL(repo->objectdir);
> +	FREE_AND_NULL(repo->alternate_db);
>  	FREE_AND_NULL(repo->graft_file);
>  	FREE_AND_NULL(repo->index_file);
>  	FREE_AND_NULL(repo->worktree);
> diff --git a/repository.h b/repository.h
> index 84aeac2825..2bfbf762f3 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -26,6 +26,9 @@ struct repository {
>  	 */
>  	char *objectdir;
>  
> +	/* Path to extra alternate object database if not NULL */
> +	char *alternate_db;
> +
>  	/*
>  	 * Path to the repository's graft file.
>  	 * Cannot be NULL after initialization.
> @@ -93,6 +96,7 @@ struct set_gitdir_args {
>  	const char *object_dir;
>  	const char *graft_file;
>  	const char *index_file;
> +	const char *alternate_db;
>  };
>  
>  extern void repo_set_gitdir(struct repository *repo,
> diff --git a/sha1_file.c b/sha1_file.c
> index 831d9e7343..4af422e3cf 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -667,15 +667,11 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
>  
>  void prepare_alt_odb(void)
>  {
> -	const char *alt;
> -
>  	if (alt_odb_tail)
>  		return;
>  
> -	alt = getenv(ALTERNATE_DB_ENVIRONMENT);
> -
>  	alt_odb_tail = &alt_odb_list;
> -	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
> +	link_alt_odb_entries(the_repository->alternate_db, PATH_SEP, NULL, 0);
>  
>  	read_info_alternates(get_object_directory(), 0);
>  }
> -- 
> 2.16.1.435.g8f24da2e1a
> 

-- 
Brandon Williams
