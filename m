Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4310E1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 16:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932928AbeFFQ6e (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 12:58:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34780 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932200AbeFFQ6d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 12:58:33 -0400
Received: by mail-pl0-f67.google.com with SMTP id g20-v6so4199109plq.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C2GbuDg5kp/JRD+Hz/bmPBYG0b+04allpnDX0Bpbnag=;
        b=nAN5+4hSLskzWkg7G9xVOAL3L/jEV/kYEWfWb6fbi7T4BTrvSXFka6nuqfdkzdK3yz
         I4xQwlCc1KRdfXqtQfjc276nWz6CuTavmRda1hY1MUpqkrcEDF/YoSQmCaqLG4bHOmad
         AGoi+RhZOU6GZ5bIxvOkzJn4/nC/GlO2Uz96w9toKNIp5Fsl9NnTv4vTLCoVDCyi9f13
         /rJYxbbTZj43g1l9zwLCUPe5eMuGm6wijpnZmdKwD+gtdHPZarhoSO3FOkNNeKzhOOX7
         VNIqXFXbIhHbRDe6nR2g2hxLc+hLZcTG26+HkExMaSOOFpjpZ8rkbOe965IDZqpsI4O2
         UzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C2GbuDg5kp/JRD+Hz/bmPBYG0b+04allpnDX0Bpbnag=;
        b=gn7ZcDPMwFqEOgTkRty/Nh5ZasdDEE3LZ/asChRkmZlcyd1lGukefgMGSb6so0/u4n
         4Y172adeH4jyTNR4ghUGLn8U4IL9nvZiEJC/8AL+bFPU14HMZvRgd7Yc+McOOBVTolk+
         H9Emz1LTm1AnQk+ldOFiOjCeDxs4ZKNrEWsBaZ0jZsvyTBFrGPwiNAxyYG9xK+KQAcmY
         /SUSqaw+pKEmK89YOsMjeE7WWZEgDviVf4zxhvAif3iQelUZLmczDnewKdrsN80EJ6Vc
         Jcm984tWgw9ASkAtCUrlyYPojFWzKYgOt01JBDNwNkcMz4z0ZW0v0DOqXBZK/jHDxvqV
         aCIw==
X-Gm-Message-State: APt69E3UYUZyTunUG1zRHeNKqA6TAOwJAcxZ/iQf3Y9+zh1/HeqOOY2k
        xpsK3XfEie2y8c1chlkRVnCo3Ys8hwc=
X-Google-Smtp-Source: ADUXVKKXNuRx52RmDosTe7g8vXRsYXGGFdCXV6hpRbTs6yboapixBMIQiQrcLGY6+C6sZQ1MhOyT5w==
X-Received: by 2002:a17:902:7105:: with SMTP id a5-v6mr4082943pll.171.1528304312781;
        Wed, 06 Jun 2018 09:58:32 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id m83-v6sm38336996pfi.188.2018.06.06.09.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 09:58:31 -0700 (PDT)
Date:   Wed, 6 Jun 2018 09:58:30 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v3 15/20] attr: remove index from git_attr_set_direction()
Message-ID: <20180606165830.GI158365@google.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
 <20180606073933.14755-16-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180606073933.14755-16-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06, Nguyễn Thái Ngọc Duy wrote:
> Since attr checking API now take the index, there's no need to set an
> index in advance with this call. Most call sites are straightforward
> because they either pass the_index or NULL (which defaults back to
> the_index previously). There's only one suspicious call site in
> unpack-trees.c where it sets a different index.
> 
> This code in unpack-trees is about to checking out entries from the
> new/temporary index after merging is done in it. The attributes will
> be used by entry.c code to do crlf conversion if needed. entry.c now
> respects struct checkout's istate field, and this field is correctly
> set in unpack-trees.c, there should be no regression from this change.

Nice! Much cleaner.

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  archive.c            |  2 +-
>  attr.c               | 15 +++------------
>  attr.h               |  3 +--
>  builtin/check-attr.c |  2 +-
>  unpack-trees.c       |  4 ++--
>  5 files changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/archive.c b/archive.c
> index 1b44503ebb..d1d0a0d6b3 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -273,7 +273,7 @@ int write_archive_entries(struct archiver_args *args,
>  		init_tree_desc(&t, args->tree->buffer, args->tree->size);
>  		if (unpack_trees(1, &t, &opts))
>  			return -1;
> -		git_attr_set_direction(GIT_ATTR_INDEX, &the_index);
> +		git_attr_set_direction(GIT_ATTR_INDEX);
>  	}
>  
>  	err = read_tree_recursive(args->tree, "", 0, 0, &args->pathspec,
> diff --git a/attr.c b/attr.c
> index 863fad3bd1..98e4953f6e 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -708,10 +708,8 @@ static struct attr_stack *read_attr_from_array(const char **list)
>   * another thread could potentially be calling into the attribute system.
>   */
>  static enum git_attr_direction direction;
> -static const struct index_state *use_index;
>  
> -void git_attr_set_direction(enum git_attr_direction new_direction,
> -			    const struct index_state *istate)
> +void git_attr_set_direction(enum git_attr_direction new_direction)
>  {
>  	if (is_bare_repository() && new_direction != GIT_ATTR_INDEX)
>  		BUG("non-INDEX attr direction in a bare repo");
> @@ -720,7 +718,6 @@ void git_attr_set_direction(enum git_attr_direction new_direction,
>  		drop_all_attr_stacks();
>  
>  	direction = new_direction;
> -	use_index = istate;
>  }
>  
>  static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
> @@ -750,17 +747,11 @@ static struct attr_stack *read_attr_from_index(const struct index_state *istate,
>  	struct attr_stack *res;
>  	char *buf, *sp;
>  	int lineno = 0;
> -	const struct index_state *to_read_from;
>  
> -	/*
> -	 * Temporary workaround for c24f3abace (apply: file commited
> -	 * with CRLF should roundtrip diff and apply - 2017-08-19)
> -	 */
> -	to_read_from = use_index ? use_index : istate;
> -	if (!to_read_from)
> +	if (!istate)
>  		return NULL;
>  
> -	buf = read_blob_data_from_index(to_read_from, path, NULL);
> +	buf = read_blob_data_from_index(istate, path, NULL);
>  	if (!buf)
>  		return NULL;
>  
> diff --git a/attr.h b/attr.h
> index 3daca3c0cb..01dab4a126 100644
> --- a/attr.h
> +++ b/attr.h
> @@ -77,8 +77,7 @@ enum git_attr_direction {
>  	GIT_ATTR_CHECKOUT,
>  	GIT_ATTR_INDEX
>  };
> -void git_attr_set_direction(enum git_attr_direction new_direction,
> -			    const struct index_state *istate);
> +void git_attr_set_direction(enum git_attr_direction new_direction);
>  
>  void attr_start(void);
>  
> diff --git a/builtin/check-attr.c b/builtin/check-attr.c
> index f7b59993d3..c05573ff9c 100644
> --- a/builtin/check-attr.c
> +++ b/builtin/check-attr.c
> @@ -120,7 +120,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (cached_attrs)
> -		git_attr_set_direction(GIT_ATTR_INDEX, NULL);
> +		git_attr_set_direction(GIT_ATTR_INDEX);
>  
>  	doubledash = -1;
>  	for (i = 0; doubledash < 0 && i < argc; i++) {
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3ace82ca27..8cb407173e 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -361,7 +361,7 @@ static int check_updates(struct unpack_trees_options *o)
>  	progress = get_progress(o);
>  
>  	if (o->update)
> -		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
> +		git_attr_set_direction(GIT_ATTR_CHECKOUT);
>  
>  	if (should_update_submodules() && o->update && !o->dry_run)
>  		load_gitmodules_file(index, NULL);
> @@ -421,7 +421,7 @@ static int check_updates(struct unpack_trees_options *o)
>  	stop_progress(&progress);
>  	errs |= finish_delayed_checkout(&state);
>  	if (o->update)
> -		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
> +		git_attr_set_direction(GIT_ATTR_CHECKIN);
>  	return errs != 0;
>  }
>  
> -- 
> 2.18.0.rc0.333.g22e6ee6cdf
> 

-- 
Brandon Williams
