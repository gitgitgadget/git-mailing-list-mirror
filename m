Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9DAE1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 21:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbeCUV5e (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 17:57:34 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37871 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753772AbeCUV5c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 17:57:32 -0400
Received: by mail-pg0-f65.google.com with SMTP id n11so2470952pgp.4
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qC3XRuIjafIxQcQ4dpxXUeU3YyCvdvM8QShjYuifsPg=;
        b=V/rotowLwmCGJTnKg0SZ32CtuPsWKQN18AYd9AM2MB5mOSKyv+/2bgKHZaPA/uI2Mb
         rChH13M0yFhKvb4b0+c6/oN3NMwLcqHuVMV6RwauY4AxrpZ5yyTJx3HF6SthaPd4SuqG
         GgUR12KMp723LfmpgLUowDQR8BxDcn6C6se0Zde7LZ8ni9V7aneAgUjcfd7cQ1i3ULF2
         nm8SmKUbx5FEonJxJhIp+XI3+9BGL1khGKzlF37fo/9KEKvu/lpmkU6t7pYg3nY8Xn0R
         ueXHNUrwpF4Za/ArL+3dH8UIgeEFxfGNEKSSNbuZIYiHrSTGq6MIyl7bpxDngXfeV6I8
         2V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qC3XRuIjafIxQcQ4dpxXUeU3YyCvdvM8QShjYuifsPg=;
        b=UmVZe45rvJ5qLPt4cwokhGShmC1dj0nW6U3wgwCdf1KY5ax8P90qSUzCY6/kDcrjSF
         5xvzTKqlC5MqltxasadlSyFt1Jv74DbJPfR7I1yX9h1hXK+NX77n4TUCbgXbd7ogrWv4
         RX2yyoBKmlFyAipkWyUIU429sphc7KBUrnvYnivjouBDU6tSEduOf0empoFZBdtxNR56
         RB2JbrY/PTMRumTwCCRWAfXIHSsDevUUJTSDtO3TKJ6xB6XFONS0OF4g3a7r0sokcblD
         8P5Vu/mkO5jABd++rndAdR12iK7AOEsYZw5GR+1wAflb3yNWN8lBWCBjAJK4L5ZLk2rX
         CZEw==
X-Gm-Message-State: AElRT7Hru6mCctgbOUF2ual3ikaLNZYVOG+DlAJPSlSv3vDrfyLHc4xW
        bqt4HCFk/hsCx8VrVu4c3Fv/7g==
X-Google-Smtp-Source: AG47ELshAv3UQwE1KeIQATijJvy72ah6/woHWBDp9uQOsD8NEi2WUqdy1Iml909jhiBt9cKyQSivpQ==
X-Received: by 10.99.120.197 with SMTP id t188mr16148367pgc.358.1521669451947;
        Wed, 21 Mar 2018 14:57:31 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id d15sm11057637pfj.121.2018.03.21.14.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 14:57:31 -0700 (PDT)
Date:   Wed, 21 Mar 2018 14:57:30 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 03/44] repository.c: delete dead functions
Message-ID: <20180321215730.GC18406@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-4-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180303113637.26518-4-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  repository.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
> 
> diff --git a/repository.c b/repository.c
> index bb53b54b6d..e65f4138a7 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -15,31 +15,6 @@ void initialize_the_repository(void)
>  	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
>  }
>  
> -static char *git_path_from_env(const char *envvar, const char *git_dir,
> -			       const char *path, int fromenv)
> -{
> -	if (fromenv) {
> -		const char *value = getenv(envvar);
> -		if (value)
> -			return xstrdup(value);
> -	}
> -
> -	return xstrfmt("%s/%s", git_dir, path);
> -}
> -
> -static int find_common_dir(struct strbuf *sb, const char *gitdir, int fromenv)
> -{
> -	if (fromenv) {
> -		const char *value = getenv(GIT_COMMON_DIR_ENVIRONMENT);
> -		if (value) {
> -			strbuf_addstr(sb, value);
> -			return 1;
> -		}
> -	}
> -
> -	return get_common_dir_noenv(sb, gitdir);
> -}
> -
>  static void expand_base_dir(char **out, const char *in,
>  			    const char *base_dir, const char *def_in)
>  {
> -- 
> 2.16.1.435.g8f24da2e1a
> 

This patch needs to be squashed into the previous one, the build breaks
otherwise (unless built with -Werror=unused-function).

-- 
Brandon Williams
