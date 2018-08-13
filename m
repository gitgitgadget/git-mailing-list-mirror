Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3028E1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbeHMUGE (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 16:06:04 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44160 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbeHMUGE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 16:06:04 -0400
Received: by mail-pl0-f66.google.com with SMTP id ba4-v6so7158549plb.11
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VuwHspme+KUTGUn7PfOWM8omhMdGVjq8fiuD/q0HX4A=;
        b=iEIN+vakebBUzg118/IuBpx1JBVR6H8pfcODCsFGAj89dXLcoYhFbacPtpKwB2gDq0
         MdSJ0kQxtKSp48/3sEKfia/DBAI8bSLWz8r3ZNH1h/lg+ZAMBOTIj4RRQ4Bv0xC4R7+3
         YkNyPmXoAChalSyZ2CPuSbcUL6LIZJmn6oLBsxmSze+INkcVvqjH9Nl7A4Vt/1CPYvwo
         D5V5d/cYgtf6AKCu88snky8hyvI6AKPTf1f6Ig57KtKA44YnuunoZb0OZAFRtXy9pdjz
         HVUIK+zeu8tbtR+DvHsd9lmXECnJUWGFGhHw3KvEdr4w2gdgDrcHUcxW4QEylNj8Bz6e
         sZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VuwHspme+KUTGUn7PfOWM8omhMdGVjq8fiuD/q0HX4A=;
        b=cIDDcqrPSW4JlePZg8/t+keJLD9K9/BQBfB6ZiI+RX0yJTYkY0oqEb7FRqQpNybzjg
         EUJDBpXp7poM2ikLDx4WTHBZgtoErDDLQ2IdLewlZrC3hDRoq/rOizIqREhoyaSHgAo6
         3++BRTbVqy+FUueK/e1c802icGiLyq2mIYmUevCfgk7dwsBwsWkuTcgnHPgH12ODAb56
         Mbz5d+E86cAUxFF0bWHKp3IM1z7p6dwjB5DlJeTtn3jT/3/2/P/vh/V1Mt1NJZF859QG
         AhaoO0jdpFxJFvKhwtHwlsTzvPUDZabYOWEuM8BSOmoHQyXYLwWIGbBXzgGH86aSyc6K
         1ykA==
X-Gm-Message-State: AOUpUlErFLzMXI+n2RYYFRs7hesgReoVMj70BIf2lWvZ/1jPGbMax6dH
        av64/kLP2my/PPU+kVRj/fpXoA==
X-Google-Smtp-Source: AA+uWPypL0iKO8jHziM7U0oowzcm3ZB0aR3nQb5RWYoteFyCpZ5y6GmFTcFFeeFvq6pPCGFQ1GEL3A==
X-Received: by 2002:a17:902:bb97:: with SMTP id m23-v6mr11131502pls.215.1534180975330;
        Mon, 13 Aug 2018 10:22:55 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id r64-v6sm32516336pfk.157.2018.08.13.10.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 10:22:54 -0700 (PDT)
Date:   Mon, 13 Aug 2018 10:22:53 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 16/24] attr: remove index from git_attr_set_direction()
Message-ID: <20180813172253.GC240194@google.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
 <20180813161441.16824-17-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180813161441.16824-17-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/13, Nguyễn Thái Ngọc Duy wrote:
> Since attr checking API now take the index, there's no need to set an
> index in advance with this call. Most call sites are straightforward
> because they either pass the_index or NULL (which defaults back to
> the_index previously). There's only one suspicious call site in
> unpack-trees.c where it sets a different index.
> 
> This code in unpack-trees is about to check out entries from the
> new/temporary index after merging is done in it. The attributes will
> be used by entry.c code to do crlf conversion if needed. entry.c now
> respects struct checkout's istate field, and this field is correctly
> set in unpack-trees.c, there should be no regression from this change.

Thanks for fixing this! The API is now that much cleaner :)

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
> index c81e35bf23..aca9179d03 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -274,7 +274,7 @@ int write_archive_entries(struct archiver_args *args,
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
> index 14e9043f9d..f25089b878 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -353,7 +353,7 @@ static int check_updates(struct unpack_trees_options *o)
>  	progress = get_progress(o);
>  
>  	if (o->update)
> -		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
> +		git_attr_set_direction(GIT_ATTR_CHECKOUT);
>  
>  	if (should_update_submodules() && o->update && !o->dry_run)
>  		load_gitmodules_file(index, NULL);
> @@ -413,7 +413,7 @@ static int check_updates(struct unpack_trees_options *o)
>  	stop_progress(&progress);
>  	errs |= finish_delayed_checkout(&state);
>  	if (o->update)
> -		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
> +		git_attr_set_direction(GIT_ATTR_CHECKIN);
>  	return errs != 0;
>  }
>  
> -- 
> 2.18.0.1004.g6639190530
> 

-- 
Brandon Williams
