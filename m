Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20ECB1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 20:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeB0UOs (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 15:14:48 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36994 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbeB0UOr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 15:14:47 -0500
Received: by mail-pl0-f65.google.com with SMTP id ay8-v6so56970plb.4
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 12:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=p3rG8qfnKaRQ0fMK9/cCuFKrUPL2dvVrpETFJJI2ky0=;
        b=fJl0+5PA3U94KezmH2Oi0haTJtQyZUFzrenUqis7zGYHVLKioQK15H3JKtOrGuIM+C
         UhBhhR+xx7N4z6L7Z9bEV57ddnYqPT9rGZvjyjG3cNejYDgm0d0TOpnQCwR3iJCMNi1G
         NVtcn2wBNCsIou95KScFDPbbh9F+pb4PDfG7bYUNA97H94Q4F+QpqBWhtS0X3VONrmpq
         XVjV2LDcbX1sSXm/7EWNPfnapuM5I40mjVlkG37axgRsGMNXy85dc4iLsvPRiiyoUMb1
         uoD2tmKc9H3AVwI+0cacG3Erc7hjbpn2SnqZjt8hncr36IF0Cxf5HaiwcGGg1Zo/epEa
         azVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=p3rG8qfnKaRQ0fMK9/cCuFKrUPL2dvVrpETFJJI2ky0=;
        b=edrNrtpnzJieP2dMxf/1PdtAichZMjhA5Cmr5xirWkGEeffmL+A9QI5MS0dQKB3mGe
         YJ5r2JIyt8A/6lr/06NbWK7j0Wfp3NufcIYBW+fzBNdIQcrbIjGH+Ku4ZxJ3vw7MdLli
         n9XTklTtXWnPDNywO0ImstWbIXrSrlb0tM805b93d0om76q+K6oX0c+pnHp1zx2TbqWX
         uUNSzSLkv4EIvWPQjJky6PzSBnsamtbzjii7Jse3EgpMNxSnmM5/yIsoiiVu46W78Ij2
         ZPHDeFD6vrPCq7JmCNgGIRgKdLoGe7pjB5xtE624p8yaUMZs1fkbOoHeLlg/J9yP/Hnn
         ipmQ==
X-Gm-Message-State: APf1xPDVoqsPh87l9U9h+QhYGx9vWoyyhF8agGtMrduNIz5A543X1iR/
        muj9xxizfAJ8ys4znmZjaQZzqw==
X-Google-Smtp-Source: AH8x226g1AF9TyjUjLr8yqCfjDMso/Peh9dA1k6/Y3PjfAL4Ky6Zk8hsYzEu8c+ivqLEcVZbHQOXDQ==
X-Received: by 2002:a17:902:6782:: with SMTP id g2-v6mr15575421plk.19.1519762487268;
        Tue, 27 Feb 2018 12:14:47 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id d77sm26437285pfe.20.2018.02.27.12.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 12:14:46 -0800 (PST)
Date:   Tue, 27 Feb 2018 12:14:45 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        sbeller@google.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 4/4] repository: delete ignore_env member
Message-ID: <20180227201445.GM209668@google.com>
References: <20180226103030.26900-1-pclouds@gmail.com>
 <20180227095846.9238-1-pclouds@gmail.com>
 <20180227095846.9238-5-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180227095846.9238-5-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Nguyễn Thái Ngọc Duy wrote:
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
> ---
>  repository.c | 4 +---
>  repository.h | 9 ---------
>  2 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/repository.c b/repository.c
> index e326f0fcbc..c555dacad2 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -12,7 +12,7 @@ static struct repository the_repo = {
>  	NULL, NULL, NULL,
>  	&the_index,
>  	&hash_algos[GIT_HASH_SHA1],
> -	0, 0
> +	0
>  };
>  struct repository *the_repository = &the_repo;
>  
> @@ -139,8 +139,6 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
>  	struct repository_format format;
>  	memset(repo, 0, sizeof(*repo));
>  
> -	repo->ignore_env = 1;
> -
>  	INIT_LIST_HEAD(&repo->objects.packed_git_mru);
>  
>  	if (repo_init_gitdir(repo, gitdir))
> diff --git a/repository.h b/repository.h
> index b1da2a6384..07e8971428 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -73,15 +73,6 @@ struct repository {
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

Nice, glad to see this get a bit less complicated.  I'm also very glad I
didn't end up using this variable when doing anything else but
initializing a repo object otherwise you would have had a bit more
difficult time getting rid of it :)

Thanks!

>  
>  	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
>  	unsigned different_commondir:1;
> -- 
> 2.16.1.435.g8f24da2e1a
> 

-- 
Brandon Williams
