Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D3A01F404
	for <e@80x24.org>; Wed, 21 Mar 2018 21:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753827AbeCUVqN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 17:46:13 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34195 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753824AbeCUVqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 17:46:09 -0400
Received: by mail-pl0-f66.google.com with SMTP id u11-v6so3974213plq.1
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 14:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e9IA8/rHbbbND4ZZEwOwQoz0/AnlUVBEp6w6ER+Hd9w=;
        b=GoZ/kXtbN6iLvoCrfSYi0HJbLwKF6Avw1EqgCzzAv1oAckl2bev+9GnZztbSWFKlGI
         Mew67Zm5A1BsTmgTbeNQOHHyXr6Cxm+dR5LxsbW8WS9naEwdxeH0hihX7FL3/x3ed+hO
         c2jfA4d88KcYtIa03iplmpGEeRB8bSyFcMOaikA8mZr/ozyrAFuFlh1/UENTOAOOnJBr
         gweuKMpOaNdOyH6aXTSSUdSmFr2J+pIZewTwGmcfInv9M/zJVpihcQaRWFiHXuIbMGek
         GGc2efjd+FCW7r4fP7fpbRZC+aNivt9Qzo+ADc+8loUGy9kNOutgPLf3Dkro35L6kz0l
         I6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e9IA8/rHbbbND4ZZEwOwQoz0/AnlUVBEp6w6ER+Hd9w=;
        b=S9SUwDzna6DQpQY61/NgXVEJr+Bu9dZYZ90JTtnm1zj55y3f1HbWOu/mSonPQ/XC6h
         EFo7NvTKvSKHgHl3vNMZadeo3V8f5aBcH/h3ZjBRiFu0vZt73IIz0qznN2zTq41EfHFq
         l2GeJmv2keef0Sh72ZFgrJRNm0YVmbmyIjvx6lKw10tcmNKZS63JSLlc4lvTBVKj87wT
         JGwA6kH4BwcDuixdd/aY0V/NBzVyLxQrUt2RS0/28YeOmOynt9QdXh0gQwqIPlk6ebQw
         DjVyy9AXcKsqrN0Nq1B+wV/EtIX13SPsnaL+rFKeEnKifVg4cJs/4s3exNFdMPcWqRNm
         GgNg==
X-Gm-Message-State: AElRT7HdXYcGmOXP/nVF1SRqpVw423lyOikmB3L/ZGn4T3hjiWWCWNIY
        30SvuDOS2dX2yQQ2pACRl3EKBg==
X-Google-Smtp-Source: AG47ELstz1HvoXPSevAtkbnAzan5uoORG1DgeGJX8QkiRQTEbCvYMGauOKiEgVl6BWCcsxdsxlge+w==
X-Received: by 2002:a17:902:bd4b:: with SMTP id b11-v6mr22162885plx.225.1521668768295;
        Wed, 21 Mar 2018 14:46:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id a3sm10375480pfh.120.2018.03.21.14.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 14:46:07 -0700 (PDT)
Date:   Wed, 21 Mar 2018 14:46:06 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/44] repository: initialize the_repository in main()
Message-ID: <20180321214606.GA18406@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180303113637.26518-2-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Nguyễn Thái Ngọc Duy wrote:
> This simplifies initialization of struct repository and anything
> inside. Easier to read. Easier to add/remove fields.
> 
> Everything will go through main() common-main.c so this should cover all
> programs, including t/helper.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  common-main.c |  2 ++
>  repository.c  | 18 +++++++++++++-----
>  repository.h  |  2 +-
>  3 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/common-main.c b/common-main.c
> index 6a689007e7..7d716d5a54 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -34,6 +34,8 @@ int main(int argc, const char **argv)
>  
>  	git_setup_gettext();
>  
> +	initialize_the_repository();
> +
>  	attr_start();
>  
>  	git_extract_argv0_path(argv[0]);
> diff --git a/repository.c b/repository.c
> index 4ffbe9bc94..0eddf28fcd 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -4,10 +4,16 @@
>  #include "submodule-config.h"
>  
>  /* The main repository */
> -static struct repository the_repo = {
> -	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, &the_index, &hash_algos[GIT_HASH_SHA1], 0, 0
> -};
> -struct repository *the_repository = &the_repo;
> +static struct repository the_repo;
> +struct repository *the_repository;
> +
> +void initialize_the_repository(void)
> +{
> +	the_repository = &the_repo;
> +
> +	the_repo.index = &the_index;
> +	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
> +}

Nice, one place to do all the crazy initialization for the_repo.  I
wanted to do something like this when I introduced the repository but I
shied away from it because it didn't seem like the right thing to do at
the time.  Now that its grown a bit, its definitely the right move until
using the repository object is ubiquitous enough that the setup code can
produce a repository struct instead of relying on a global one.

>  
>  static char *git_path_from_env(const char *envvar, const char *git_dir,
>  			       const char *path, int fromenv)
> @@ -128,7 +134,9 @@ static int read_and_verify_repository_format(struct repository_format *format,
>   * Initialize 'repo' based on the provided 'gitdir'.
>   * Return 0 upon success and a non-zero value upon failure.
>   */
> -int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
> +static int repo_init(struct repository *repo,
> +		     const char *gitdir,
> +		     const char *worktree)
>  {
>  	struct repository_format format;
>  	memset(repo, 0, sizeof(*repo));
> diff --git a/repository.h b/repository.h
> index 0329e40c7f..40c1c81bdc 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -91,7 +91,7 @@ extern struct repository *the_repository;
>  extern void repo_set_gitdir(struct repository *repo, const char *path);
>  extern void repo_set_worktree(struct repository *repo, const char *path);
>  extern void repo_set_hash_algo(struct repository *repo, int algo);
> -extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);

I had to double check that this was ok, it indeed is as repo_init is
only used in repository.c.

> +extern void initialize_the_repository(void);
>  extern int repo_submodule_init(struct repository *submodule,
>  			       struct repository *superproject,
>  			       const char *path);
> -- 
> 2.16.1.435.g8f24da2e1a
> 

-- 
Brandon Williams
