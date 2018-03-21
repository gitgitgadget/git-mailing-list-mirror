Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41411F404
	for <e@80x24.org>; Wed, 21 Mar 2018 21:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753806AbeCUV7x (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 17:59:53 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36222 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753797AbeCUV7v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 17:59:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id 68so2535777pfx.3
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 14:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/mtrfALH399L+vC3elV6u5RsDPzdlvGcZevLt3NZISs=;
        b=PgltQ7k62pGD14nwIaFxj3Wb+2FxqYyPxJl4Oil7+JKQecru+DDgUqR6s3WuX08Hjb
         X/iMLlnqenQLTI4jlXcwBW6PQK43AcBsShx1wkL8RfW+hDNWLcrKN+lvSSQYLnNd530C
         Gm2vfLBfx2npb39ZMlbv9GXFTMfLxhFIESDkZnCLHwfoLNOCcNNfXx7wQ9eqCyAMWT0N
         L5eQeuUNi+ScUB/ag8hicUl5Sqvgjqo3BoFLLNztK0p/cVpKq1u+ib1izGfXI3pC/FUa
         JiKEfF8ZW1MmwU6K2QZTbiiNmCjxyE8mMQGD5HqdlgZWDYHoiWwd4mx/9JQx7wyJqBYT
         R6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/mtrfALH399L+vC3elV6u5RsDPzdlvGcZevLt3NZISs=;
        b=WuMh+ms+dr6HG9FUG8fkq57aSx8WlIMkYYyoieSOPOi6IWkxWNWD4wEpthDDJGZpTc
         87heiP2Jtx18vveoLEVzUuaQNnWRfRDAkRog7hUJP2MuZvC2CtRyjGXF4HnKOaZ4oo2E
         SiujwwNRNYiXdsgEkNiRftSMqtBRJS2d1hYkwEdXDdSwfZ9BMv+8U6POEvSoq9aJjexg
         wsSb0g6G29GTE/0vNXXdrQzIm0xHqwuGA9gTCOVKaXgkMXFR1LeX/5Vq2EZIP3TK2Uhu
         KbHXIfArvjIZrGzFHB5ZLYUnSz9GT/UnmmEAH4cyVEgFG38At2dIisNqvhAiRsKkk8vq
         jyeg==
X-Gm-Message-State: AElRT7F7K6xlqi4IR32bYRv7oXp2ss/YeKQlqoOlMkSlTQqLImDyuhaW
        nSyjfNLOOT2caDw7vPQQ617Oww==
X-Google-Smtp-Source: AG47ELtsE/PAJq3xgFsngbWc1LB0TEzQk2ZiOiZSJ7h57XRgCJowjngRhYry5J+Vy4cJowXtOtAU3A==
X-Received: by 10.99.39.131 with SMTP id n125mr15990130pgn.292.1521669591221;
        Wed, 21 Mar 2018 14:59:51 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 9sm10613307pfq.63.2018.03.21.14.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 14:59:50 -0700 (PDT)
Date:   Wed, 21 Mar 2018 14:59:49 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 05/44] repository: delete ignore_env member
Message-ID: <20180321215949.GE18406@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-6-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180303113637.26518-6-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Nguyễn Thái Ngọc Duy wrote:
> This variable was added because the repo_set_gitdir() was created to
> cover both submodule and main repos, but these two are initialized a
> bit differently so ignore_env == 0 means main repo, while ignore_env
> != 0 is submodules.
> 
> Since the difference part (env variables) has been moved out of
> repo_set_gitdir(), this function works the same way for both repo
> types and ignore_env is not needed anymore.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Sweet! Thanks for getting rid of this.

> ---
>  repository.c | 2 --
>  repository.h | 9 ---------
>  2 files changed, 11 deletions(-)
> 
> diff --git a/repository.c b/repository.c
> index 04d85a2869..62f52f47fc 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -140,8 +140,6 @@ static int repo_init(struct repository *repo,
>  	struct repository_format format;
>  	memset(repo, 0, sizeof(*repo));
>  
> -	repo->ignore_env = 1;
> -
>  	if (repo_init_gitdir(repo, gitdir))
>  		goto error;
>  
> diff --git a/repository.h b/repository.h
> index 2bfbf762f3..e7127baffb 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -75,15 +75,6 @@ struct repository {
>  	const struct git_hash_algo *hash_algo;
>  
>  	/* Configurations */
> -	/*
> -	 * Bit used during initialization to indicate if repository state (like
> -	 * the location of the 'objectdir') should be read from the
> -	 * environment.  By default this bit will be set at the begining of
> -	 * 'repo_init()' so that all repositories will ignore the environment.
> -	 * The exception to this is 'the_repository', which doesn't go through
> -	 * the normal 'repo_init()' process.
> -	 */
> -	unsigned ignore_env:1;
>  
>  	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
>  	unsigned different_commondir:1;
> -- 
> 2.16.1.435.g8f24da2e1a
> 

-- 
Brandon Williams
