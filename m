Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61FE1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 20:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeB0UKt (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 15:10:49 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35620 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbeB0UKt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 15:10:49 -0500
Received: by mail-pg0-f66.google.com with SMTP id l131so33665pga.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 12:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/DxPKPUZBQrXRSlMsm0+OqJJh70j+U8kb4T+a72yNqY=;
        b=kmljznl1g6gwALpME3tJbwb7a6yDPwdzxtgnuookuL0RCJbZEn2DKaq96f1HtQAsgN
         q5OIDUeXH3U7SfePszxMaNYyFD9+XjgUgbOr0xrJ1a09qUO/plxNRCc1yp6nmQjmFV8t
         P1uC2fjQ2UFDghS63MC4s8yp/dCG/9GwVymP1du5y8J3KSiT4YfbFUYbypPYlXQILB1t
         WpWvg8zixj7Ua/EJwhktQk3uffVjCxPupAiS7CN9ARmJUtSRgYD/xI9RgM215ywIDZ4Y
         pzdy5tOi8jWahR9qlm5O6oT+oTF/JJ+M3r8qslpL12DhOwxigP8559rl1Ddwyy4x8Pz0
         VGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/DxPKPUZBQrXRSlMsm0+OqJJh70j+U8kb4T+a72yNqY=;
        b=JjFU05zXrszscwT+esmtGFFvgKssU/mlX77b9Nez0z975zEDarA1DeCcU7WJ1a6am+
         mf6eGOQGYakBIEzz3gGdJv6vIwyJDN7uxuWi0ZL/dLNW9HdxPc8VhR6XeJwPprMymjh9
         +lZMOx63B4SZ/X6z4RGQAs5W2WmaZE5H4W93R9MqxEgcEEsaEIlRpeCGYooNLT9Uvf01
         OZuMILbihp6lLXBgjJ7XxSLaPlpL1MNSNogGGZglT55zBNsTDMP72b4E9lcAo/27WcTm
         6RG9wBVNYgoprVz2Dv7rjHGCTjqVlDyeIhYy1n6N9Oo6Mg7ax+5y9hjQIaodG61ftil/
         PoAA==
X-Gm-Message-State: APf1xPA1dSMxjY/ba4zgXLbHK5DpNG8+WRdEu/rYmMcN9SeEjzZMXD2d
        0E9rLuGGzlTr+tD/zfbjnemCNw==
X-Google-Smtp-Source: AH8x224xam46q65ARjTkwKUSdDHs3V/o4v8y2xXE7NK7//YAvc+vJV64aLBycJu8m2HR2rHS7bqbeA==
X-Received: by 10.99.7.15 with SMTP id 15mr11790606pgh.388.1519762248525;
        Tue, 27 Feb 2018 12:10:48 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id f82sm1862267pfd.175.2018.02.27.12.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 12:10:47 -0800 (PST)
Date:   Tue, 27 Feb 2018 12:10:46 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        sbeller@google.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 2/4] repository.c: delete dead functions
Message-ID: <20180227201046.GK209668@google.com>
References: <20180226103030.26900-1-pclouds@gmail.com>
 <20180227095846.9238-1-pclouds@gmail.com>
 <20180227095846.9238-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180227095846.9238-3-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/27, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

These could technically be removed in the previous patch, it may make
understanding what is happening in the previous patch a bit clearer too.

> ---
>  repository.c | 45 ---------------------------------------------
>  1 file changed, 45 deletions(-)
> 
> diff --git a/repository.c b/repository.c
> index 343efe7282..7654b8ada9 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -16,51 +16,6 @@ static struct repository the_repo = {
>  };
>  struct repository *the_repository = &the_repo;
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
> -static void repo_setup_env(struct repository *repo)
> -{
> -	struct strbuf sb = STRBUF_INIT;
> -
> -	repo->different_commondir = find_common_dir(&sb, repo->gitdir,
> -						    !repo->ignore_env);
> -	free(repo->commondir);
> -	repo->commondir = strbuf_detach(&sb, NULL);
> -	raw_object_store_clear(&repo->objects);
> -	repo->objects.objectdir =
> -		git_path_from_env(DB_ENVIRONMENT, repo->commondir,
> -				  "objects", !repo->ignore_env);
> -	free(repo->graft_file);
> -	repo->graft_file = git_path_from_env(GRAFT_ENVIRONMENT, repo->commondir,
> -					     "info/grafts", !repo->ignore_env);
> -	free(repo->index_file);
> -	repo->index_file = git_path_from_env(INDEX_ENVIRONMENT, repo->gitdir,
> -					     "index", !repo->ignore_env);
> -}
> -
>  static void expand_base_dir(char **out, const char *in,
>  			    const char *base_dir, const char *def_in)
>  {
> -- 
> 2.16.1.435.g8f24da2e1a
> 

-- 
Brandon Williams
