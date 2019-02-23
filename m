Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13EC320248
	for <e@80x24.org>; Sat, 23 Feb 2019 21:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfBWVfe (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 16:35:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35472 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBWVfd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 16:35:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so5963851wrx.2
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 13:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uGth4Wbg6+su8liLT/K1a0SE0y79NXttJz8ZNR7SaHk=;
        b=D35kKz8P0QlZqpL66zplLvf24aqohT30obrIUDNLRKoqZjGyEAMMiyShG9Y/M0Okye
         MEaYJwXBqwLTzWquHhtVSo/bRe9OFGJPcABuy/dlMxeJ/9rKzlYKdtPfRRdqnGhULZAN
         1gCZadsUSf5nhs+xFmXNqmUwWeulz6hPjOczlI7wcJCh9SVPUBfI4YZgYuzGhMioWvu1
         1+KzMp/dBoU2bltq3G9U6+z8yjadg6fnXHmnTtzEWnhKeV3H8xHVPO7sRJx46vwoXgtS
         u3kXk7dXkVHo2D65Kwcs3u4fwFpEvkoQwxK9miG2dSwg0XkZVu48CQ2KDDOkudWNZlzf
         nWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uGth4Wbg6+su8liLT/K1a0SE0y79NXttJz8ZNR7SaHk=;
        b=QKwTdDYDD7ALzgTlTLUHNIeUMQ4ZqiFJDaiYXPsZPItxfgbAL3zHOQ88i+z6l0qt+h
         +u0n0MvU8T3wEz/LcG6Htah2q9mk1qIJrD9CCi79tsPsCKniB6bRLBVbv7MTRvUSRyYH
         kKhVpE5rK3QPnW2/+G4efQPL/TLVVaimhZIY9XtlQHNpOKu+6ai6jJurPyhloJzUQ+iu
         pjxZ0gd27h18xepTYfUhW2uaqOdGZxt+wHbS+yxH77PlwG9JULx8aEdyz//7WVHAzH8P
         90allQQHK81DwrAHTM8yoS/dgs3SozUZgHJLpvxDSEjc710r4guJx9ZQ88LSNRTMxZCq
         25ug==
X-Gm-Message-State: AHQUAuZ9TSxS9LLj9hX0ZW3h1fnjtFpyRCA2AF8L9vYbZvZTahv5kHEN
        5AZ045mcEApXD1mU/luZFvE=
X-Google-Smtp-Source: AHgI3IY4q8V711waa9N9ZqgHyv+o0pz0XJBosMH53WzocUqqYBEJ2bzUL2GEwVy6OyFpAncf+fvifQ==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr7639876wrn.276.1550957730589;
        Sat, 23 Feb 2019 13:35:30 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id h71sm6285446wme.20.2019.02.23.13.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 13:35:28 -0800 (PST)
Date:   Sat, 23 Feb 2019 21:35:27 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [GSoC][PATCH 1/3] dir-iterator: add pedantic option to
 dir_iterator_begin
Message-ID: <20190223213527.GP6085@hank.intra.tgummerer.com>
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
 <20190223190309.6728-2-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190223190309.6728-2-matheus.bernardino@usp.br>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/23, Matheus Tavares wrote:
> Add the pedantic option to dir-iterator's initialization function,
> dir_iterator_begin. When this option is set to true,
> dir_iterator_advance will immediately return ITER_ERROR when failing to
> fetch the next entry. When set to false, dir_iterator_advance will emit
> a warning and keep looking for the next entry.
> 
> Also adjust refs/files-backend.c to the new dir_iterator_begin
> signature.

Thanks, this makes sense to me.  This commit message describes what we
are doing in this patch, but not why we are doing it.  From previously
reviewing this series, I know this is going to be used in a subsequent
patch, but it is nice to give reviewers and future readers of this
patch that context as well.  Just something like "This behaviour is
going to be used in a subsequent patch." should be enough here.

A few comments inline.

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
> Changes in v2:
>  - Added in v2
> 
>  dir-iterator.c       | 23 +++++++++++++++++++++--
>  dir-iterator.h       | 16 +++++++++++++---
>  refs/files-backend.c |  2 +-
>  3 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/dir-iterator.c b/dir-iterator.c
> index f2dcd82fde..070a656555 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -48,6 +48,13 @@ struct dir_iterator_int {
>  	 * that will be included in this iteration.
>  	 */
>  	struct dir_iterator_level *levels;
> +
> +	/*
> +	 * Boolean value to define dir-iterator's behaviour when failing to
> +	 * fetch next entry. See comments on dir_iterator_begin at
> +	 * dir-iterator.h
> +	 */
> +	int pedantic;
>  };
>  
>  int dir_iterator_advance(struct dir_iterator *dir_iterator)
> @@ -71,6 +78,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  
>  			level->dir = opendir(iter->base.path.buf);
>  			if (!level->dir && errno != ENOENT) {
> +				if (iter->pedantic)
> +					goto error_out;

I think we should also print an error here.  The caller doesn't have
any context on what went wrong, and will probably just 'die()' if an
error is encountered.  I think it would make sense to call
'error(...)' here before 'goto error_out;' to give a useful error
message here.

>  				warning("error opening directory %s: %s",
>  					iter->base.path.buf, strerror(errno));
>  				/* Popping the level is handled below */
> @@ -122,6 +131,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			if (!de) {
>  				/* This level is exhausted; pop up a level. */
>  				if (errno) {
> +					if (iter->pedantic)
> +						goto error_out;
>  					warning("error reading directory %s: %s",
>  						iter->base.path.buf, strerror(errno));
>  				} else if (closedir(level->dir))
> @@ -139,10 +150,13 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  
>  			strbuf_addstr(&iter->base.path, de->d_name);
>  			if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
> -				if (errno != ENOENT)
> +				if (errno != ENOENT) {
> +					if (iter->pedantic)
> +						goto error_out;
>  					warning("error reading path '%s': %s",
>  						iter->base.path.buf,
>  						strerror(errno));
> +				}
>  				continue;
>  			}
>  
> @@ -159,6 +173,10 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
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
> @@ -182,7 +200,7 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
>  	return ITER_DONE;
>  }
>  
> -struct dir_iterator *dir_iterator_begin(const char *path)
> +struct dir_iterator *dir_iterator_begin(const char *path, int pedantic)

Thinking about the future evolution of this interface, it might make
more sense to have that second parameter be a "struct
dir_iterator_opts".  For now it would just have one member "pedantic",
but in the future we could add additional options there instead of
adding additional parameters.

For now there are not many callers of the dir iterator API, so adding
a parameter is not a huge problem.  However we will most likely add
more callers in the future, so changing all of them becomes more and
more costly.

It also becomes a problem for integrating these patches, in the case
where a topic in flight adds a new use of this API.  In that case the
breakage wouldn't be noticed on merges, as there would be no merge
conflicts, however it would break the build, which makes the
maintainers job harder.

We could of course add new functions in the future, rather than
changing dir_iterator_begin, however just having one function, that
allows combining different options sounds like the better choice to me
here.

>  {
>  	struct dir_iterator_int *iter = xcalloc(1, sizeof(*iter));
>  	struct dir_iterator *dir_iterator = &iter->base;
> @@ -195,6 +213,7 @@ struct dir_iterator *dir_iterator_begin(const char *path)
>  
>  	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
>  
> +	iter->pedantic = pedantic;
>  	iter->levels_nr = 1;
>  	iter->levels[0].initialized = 0;
>  
> diff --git a/dir-iterator.h b/dir-iterator.h
> index 970793d07a..50ca8e1a27 100644
> --- a/dir-iterator.h
> +++ b/dir-iterator.h
> @@ -19,7 +19,7 @@
>   * A typical iteration looks like this:
>   *
>   *     int ok;
> - *     struct iterator *iter = dir_iterator_begin(path);
> + *     struct iterator *iter = dir_iterator_begin(path, 0);
>   *
>   *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
>   *             if (want_to_stop_iteration()) {
> @@ -65,9 +65,15 @@ struct dir_iterator {
>   * The iteration includes all paths under path, not including path
>   * itself and not including "." or ".." entries.
>   *
> - * path is the starting directory. An internal copy will be made.
> + * Parameters are:
> + * - path is the starting directory. An internal copy will be made.
> + * - pedantic is a boolean value. If true, dir-iterator will free
> + *   resources and return ITER_ERROR immediately, in case of an error
> + *   while trying to fetch the next entry in dir_iterator_advance. If
> + *   false, it will just emit a warning and keep looking for the next
> + *   entry.
>   */
> -struct dir_iterator *dir_iterator_begin(const char *path);
> +struct dir_iterator *dir_iterator_begin(const char *path, int pedantic);
>  
>  /*
>   * Advance the iterator to the first or next item and return ITER_OK.
> @@ -76,6 +82,10 @@ struct dir_iterator *dir_iterator_begin(const char *path);
>   * dir_iterator and associated resources and return ITER_ERROR. It is
>   * a bug to use iterator or call this function again after it has
>   * returned ITER_DONE or ITER_ERROR.
> + *
> + * Note that whether dir_iterator_advance will return ITER_ERROR when
> + * failing to fetch the next entry or keep going is defined by the
> + * 'pedantic' option at dir-iterator's initialization.
>   */
>  int dir_iterator_advance(struct dir_iterator *iterator);
>  
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index dd8abe9185..c3d3b6c454 100644
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
