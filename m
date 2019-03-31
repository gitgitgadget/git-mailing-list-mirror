Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EFAA20248
	for <e@80x24.org>; Sun, 31 Mar 2019 18:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbfCaSMP (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 14:12:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41157 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfCaSMP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 14:12:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so8935182wrq.8
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O5Ulm4zlyFTgGfCQAOxGohzhu/fNSg97ds/Q1kF3jd0=;
        b=sANRAyS+uef1E/IyMcgVv3mD/3NBQojUogIQM2hLPvJqyTLykplta1BmBkWdM9XA5A
         047snaeiEfAWl7Hkw3/axLm1IEh3JePmEW+KpY2VvX2pqDxzfnLBnqo/1byH6rK6s+bq
         6yWxXxb0/BG8FhrYBQejorolLZkjAtEXjS7SwKHSSNz9SlzHu1cRxX95tv62aDZq0/Bx
         l/UrSQQKV06mkpYLQeZOGhLnMBWQ1iU97b68zPwpmVHGAbsbNuJ1sn9svaqiFAcukhje
         oFMZ2GF3gffEQc58Yax++weYzce1nhoht9hOU/OQGDSBudjUFiojbPmuv6PUkr5ZrwEL
         l+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O5Ulm4zlyFTgGfCQAOxGohzhu/fNSg97ds/Q1kF3jd0=;
        b=EE7XIpkqlbPvGz/uJIVWV57kJMR5psy2hpjlO0gM252zQfpe021WG5u6jzZq9EKoQG
         uwdQuvx//4AUTBEmr6FMK4tGfZSOT9XP4KNas7EiV4xRcggs5/yI/3oMlUNqPoQ/66GT
         k3S3ncPtrmxk9C4O25XZouFZP2XWVemZ5NOb1Rn+luO1gwPb++2snhJsziqyuCoq4cC8
         FKyDnddIuBj5dtO9i/Arfwmc+lp99qGyvvFyFuLKHKUJ20Kix1HRDhqPlAYeOQ1OMSQS
         OQTkodnxkEmkUQLvekJx1OHxli+qyP6nuF08wgN/7Bgxrr0oK1cxNlv/i4W4RckRqtGH
         MlsA==
X-Gm-Message-State: APjAAAX+E/2yPdKr32NdvU4JTkIYKgNW4x3cwniRTMVEyRehxWubLVd+
        qQfdObmAx2hR/nE2NUd4YZ0=
X-Google-Smtp-Source: APXvYqwPH3HHq9B/YqAzlHIJqQOCm2XY4iKumYYrY8xbj/rGLCwQAKSv95kVRAz33mMCMXXj73q3oQ==
X-Received: by 2002:adf:ee07:: with SMTP id y7mr36938070wrn.219.1554055932970;
        Sun, 31 Mar 2019 11:12:12 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id o130sm12708507wmo.43.2019.03.31.11.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 11:12:11 -0700 (PDT)
Date:   Sun, 31 Mar 2019 19:12:09 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [GSoC][PATCH v5 3/7] dir-iterator: add flags parameter to
 dir_iterator_begin
Message-ID: <20190331181209.GT32487@hank.intra.tgummerer.com>
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br>
 <20190330224907.3277-4-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330224907.3277-4-matheus.bernardino@usp.br>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30, Matheus Tavares wrote:
> Add the possibility of giving flags to dir_iterator_begin to initialize
> a dir-iterator with special options.
> 
> Currently possible flags are DIR_ITERATOR_PEDANTIC, which makes
> dir_iterator_advance abort immediately in the case of an error while
> trying to fetch next entry; and DIR_ITERATOR_FOLLOW_SYMLINKS, which
> makes the iteration follow symlinks to directories and include its
> contents in the iteration. These new flags will be used in a subsequent
> patch.
> 
> Also adjust refs/files-backend.c to the new dir_iterator_begin
> signature.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  dir-iterator.c       | 28 +++++++++++++++++++++++++---
>  dir-iterator.h       | 39 +++++++++++++++++++++++++++++++++------
>  refs/files-backend.c |  2 +-
>  3 files changed, 59 insertions(+), 10 deletions(-)
> 
> diff --git a/dir-iterator.c b/dir-iterator.c
> index f2dcd82fde..17aca8ea41 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -48,12 +48,16 @@ struct dir_iterator_int {
>  	 * that will be included in this iteration.
>  	 */
>  	struct dir_iterator_level *levels;
> +
> +	/* Combination of flags for this dir-iterator */
> +	unsigned flags;
>  };
>  
>  int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  {
>  	struct dir_iterator_int *iter =
>  		(struct dir_iterator_int *)dir_iterator;
> +	int ret;

Minor nit: I'd define this variable closer to where it is actually
used, inside the second 'while(1)' loop in this function.  That would
make it clearer that it's only used there and not in other places in
the function as well, which I had first expected when I read this.

>  	while (1) {
>  		struct dir_iterator_level *level =
> @@ -71,6 +75,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  
>  			level->dir = opendir(iter->base.path.buf);
>  			if (!level->dir && errno != ENOENT) {
> +				if (iter->flags & DIR_ITERATOR_PEDANTIC)
> +					goto error_out;
>  				warning("error opening directory %s: %s",
>  					iter->base.path.buf, strerror(errno));
>  				/* Popping the level is handled below */
> @@ -122,6 +128,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			if (!de) {
>  				/* This level is exhausted; pop up a level. */
>  				if (errno) {
> +					if (iter->flags & DIR_ITERATOR_PEDANTIC)
> +						goto error_out;
>  					warning("error reading directory %s: %s",
>  						iter->base.path.buf, strerror(errno));
>  				} else if (closedir(level->dir))
> @@ -138,11 +146,20 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  				continue;
>  
>  			strbuf_addstr(&iter->base.path, de->d_name);
> -			if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
> -				if (errno != ENOENT)
> +
> +			if (iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS)
> +				ret = stat(iter->base.path.buf, &iter->base.st);
> +			else
> +				ret = lstat(iter->base.path.buf, &iter->base.st);
> +
> +			if (ret < 0) {
> +				if (errno != ENOENT) {
> +					if (iter->flags & DIR_ITERATOR_PEDANTIC)
> +						goto error_out;
>  					warning("error reading path '%s': %s",
>  						iter->base.path.buf,
>  						strerror(errno));
> +				}
>  				continue;
>  			}
>  
> @@ -159,6 +176,10 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			return ITER_OK;
>  		}
>  	}
> +
> +error_out:
> +	dir_iterator_abort(dir_iterator);
> +	return ITER_ERROR;
>  }
>  
>  int dir_iterator_abort(struct dir_iterator *dir_iterator)
> @@ -182,7 +203,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
>  	return ITER_DONE;
>  }
>  
> -struct dir_iterator *dir_iterator_begin(const char *path)
> +struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags)
>  {
>  	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
>  	struct dir_iterator *dir_iterator = &iter->base;
> @@ -195,6 +216,7 @@ struct dir_iterator *dir_iterator_begin(const char *path)
>  
>  	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
>  
> +	iter->flags = flags;
>  	iter->levels_nr = 1;
>  	iter->levels[0].initialized = 0;
>  
> diff --git a/dir-iterator.h b/dir-iterator.h
> index 970793d07a..93646c3bea 100644
> --- a/dir-iterator.h
> +++ b/dir-iterator.h
> @@ -19,7 +19,7 @@
>   * A typical iteration looks like this:
>   *
>   *     int ok;
> - *     struct iterator *iter = dir_iterator_begin(path);
> + *     struct iterator *iter = dir_iterator_begin(path, 0);

Outside of this context, we already mentione errorhandling when
'ok != ITER_DONE' in his example.  This still can't happen with the
way the dir iterator is used here, but it serves as a reminder if
people are using the DIR_ITERATOR_PEDANTIC flag.  Good.

>   *
>   *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
>   *             if (want_to_stop_iteration()) {
> @@ -40,6 +40,20 @@
>   * dir_iterator_advance() again.
>   */
>  
> +/*
> + * Flags for dir_iterator_begin:
> + *
> + * - DIR_ITERATOR_PEDANTIC: override dir-iterator's default behavior
> + *   in case of an error while trying to fetch the next entry, which is
> + *   to emit a warning and keep going. With this flag, resouces are
> + *   freed and ITER_ERROR is return immediately.
> + *
> + * - DIR_ITERATOR_FOLLOW_SYMLINKS: make dir-iterator follow symlinks to
> + *   directories, i.e., iterate over linked directories' contents.
> + */
> +#define DIR_ITERATOR_PEDANTIC (1 << 0)
> +#define DIR_ITERATOR_FOLLOW_SYMLINKS (1 << 1)
> +
>  struct dir_iterator {
>  	/* The current path: */
>  	struct strbuf path;
> @@ -54,20 +68,28 @@ struct dir_iterator {
>  	/* The current basename: */
>  	const char *basename;
>  
> -	/* The result of calling lstat() on path: */
> +	/*
> +	 * The result of calling lstat() on path or stat(), if the
> +	 * DIR_ITERATOR_FOLLOW_SYMLINKS flag was set at
> +	 * dir_iterator's initialization.
> +	 */
>  	struct stat st;
>  };
>  
>  /*
> - * Start a directory iteration over path. Return a dir_iterator that
> - * holds the internal state of the iteration.
> + * Start a directory iteration over path with the combination of
> + * options specified by flags. Return a dir_iterator that holds the
> + * internal state of the iteration.
>   *
>   * The iteration includes all paths under path, not including path
>   * itself and not including "." or ".." entries.
>   *
> - * path is the starting directory. An internal copy will be made.
> + * Parameters are:
> + *  - path is the starting directory. An internal copy will be made.
> + *  - flags is a combination of the possible flags to initialize a
> + *    dir-iterator or 0 for default behaviour.
>   */
> -struct dir_iterator *dir_iterator_begin(const char *path);
> +struct dir_iterator *dir_iterator_begin(const char *path, unsigned flags);
>  
>  /*
>   * Advance the iterator to the first or next item and return ITER_OK.
> @@ -76,6 +98,11 @@ struct dir_iterator *dir_iterator_begin(const char *path);
>   * dir_iterator and associated resources and return ITER_ERROR. It is
>   * a bug to use iterator or call this function again after it has
>   * returned ITER_DONE or ITER_ERROR.
> + *
> + * Note that whether dir-iterator will return ITER_ERROR when failing
> + * to fetch the next entry or just emit a warning and try to fetch the
> + * next is defined by the 'pedantic' option at dir-iterator's
> + * initialization.

I feel like at this point we are repeating documentation that already
exists for the flags.  Should we ever find a reason to return
ITER_ERROR without the pedantic flag, this comment is likely to become
out of date.  I think not adding this note is probably better in this
case.

>   */
>  int dir_iterator_advance(struct dir_iterator *iterator);
>  
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index ef053f716c..2ce9783097 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2143,7 +2143,7 @@ static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
>  
>  	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 0);
>  	strbuf_addf(&sb, "%s/logs", gitdir);
> -	iter->dir_iterator = dir_iterator_begin(sb.buf);
> +	iter->dir_iterator = dir_iterator_begin(sb.buf, 0);
>  	iter->ref_store = ref_store;
>  	strbuf_release(&sb);
>  
> -- 
> 2.20.1
> 
