Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3B26F46E
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897549; cv=none; b=oPsenbs8hFQMJJk4FhdrL21t9muV0vsxQDusqZSYITGvTHetb9x5RvVapF6Ox5UvpLe0jOS0xcM4oelBcB6jSExu2bMvXXUuANGPExoNIQUqo3lCLqHZp+/P2vpoD82+SaMVwkJNdcz2ShUmMEn9wpO/ESv64gNS+EqVC83+VCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897549; c=relaxed/simple;
	bh=rOXwZNW4FY0RZu5PnsiXJqJaSJ8IkO0IhOMXee0UM/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXUGQrbmaz882vB/8s5MSYx9xPaoTxamT6HoRKGfx91YMZe7id61gO4YHzk6C9Yg3Bz7GFrvxBbMVihHVyIlgkgUnlN5hwVTzlol68tED8Fl74l+8rlCDM2kprlMfWqsCTqmoT6myVvJQNpyoJH3l0AsPtlaER9Dvsd60XXI87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGStNXaP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGStNXaP"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220c4159f87so76466005ad.0
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 08:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739897546; x=1740502346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6PE3v2AwDTg4cdH+EAvCYUFEbFAKeLGtYD1hjmjGLZk=;
        b=YGStNXaPzIriPYKSFg0iTDpTOBcbBJBu3m34BLkbhOwJt25fYX4TG2sRem+qeXoyC/
         x6F3wuCX+IB8Etqo8/iRYwn4wMttE4gLSLeyUa4pt4L71KEXNlsgpMlizP2TR5W1vPvf
         nEFio2Gj/aLPKLDKSKfAZk1Zww0oBR3w/0s4N8QcfMi74apYr1oMZY2ThsWHDbXjzKNp
         GrA3gaHW36rcZoRseFScpaN9rDM3bVl9xWcvY2JsV5WtV22EwUbMY8k/xhKhncKyxCIl
         YM45lUsiuDqys1EUzCFrvJvhIo/eYN7szV2D5CgcIdwhSDYDL8GCkVl4fRrBdF+0T6Tr
         qFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739897546; x=1740502346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PE3v2AwDTg4cdH+EAvCYUFEbFAKeLGtYD1hjmjGLZk=;
        b=k81BfmTfOStz98Fy/D4PDwShvkrF3asL9X8uGjv6nnzNqt9FgxUCmuT/D4jWk8WDWk
         AiGpUcZAvaoCrYcBLLQoY0ir+7+vT4HelExBJQX6Afgbtq4Flgc6Cm+nnYyDB4hL0iBC
         COYZ1Rl+fTqKpeFJQACVXJ8OpqPiSik68R2B4xwtYo5OLQquWjUHmI6YHuaL2fgsVBRL
         yI0xQcvDKb9f8R7G2rfCJqzpTeFRdosAfJGKtLeRAe5p4jF2Z4N4BVDVL1oZliNrs1hk
         o9Jzq3eMo9EL2D9sQzQ1hX6cKNpH3YdANkq7UWEGPvxVcK2CMBCftNHVZ9tANuijjImu
         JMRg==
X-Gm-Message-State: AOJu0Yz55FbQN4AXCjEkKB4u0ovKgc3rcFO1ealKe7ijoF/QLEmgntAo
	FhBw43FzA+5OUjHnwClaVwLZTHo9fgNwstGOAP/JntRZXdC7cjU3
X-Gm-Gg: ASbGncuRfQ5q6UDnoQtSBUyVvSFRurQkBZRmq5arRFEOvqhr2xrruNgpPleBxd4SFi8
	z1cq6mKxqg1cgDDESu9yjgQgrO7GG+Eu1JGbimvS8C5oXnHQIT0bML2EyaOoe7B2TGnjsQbbo32
	h2TWSigSj6HcIVsiz+HSTd84z4ScPqibd0aHaOfeurhG6GmKY9mVV4x9SYJkTlzimhT0aur5jzR
	VaGgj+OThxYjDo6VjkJBW1Cqef5uZYC7AXICjjd6F9d4mKYRNTAu0xm0GCrLHCEgIvdEVo08/zB
	c4aHOt0DywU=
X-Google-Smtp-Source: AGHT+IEeTDoFiEewEvusAVfr/ogQ9tKOqiucWSQiw8qmg6JC88NHyJLl7mpq9z91OObKUJuC2gPvkw==
X-Received: by 2002:a05:6a21:8902:b0:1ee:afa2:4e85 with SMTP id adf61e73a8af0-1eeafa251d8mr12348544637.28.1739897545502;
        Tue, 18 Feb 2025 08:52:25 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73270398dc4sm5698919b3a.95.2025.02.18.08.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:52:24 -0800 (PST)
Date: Wed, 19 Feb 2025 00:52:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/14] refs/iterator: separate lifecycle from iteration
Message-ID: <Z7S6xzmPb3lK-SdT@ArchLinux>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250217-pks-update-ref-optimization-v1-7-a2b6d87a24af@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-pks-update-ref-optimization-v1-7-a2b6d87a24af@pks.im>

On Mon, Feb 17, 2025 at 04:50:21PM +0100, Patrick Steinhardt wrote:
> The ref and reflog iterators have their lifecycle attached to iteration:
> once the iterator reaches its end, it is automatically released and the
> caller doesn't have to care about that anymore. When the iterator should
> be released before it has been exhausted, callers must explicitly abort
> the iterator via `ref_iterator_abort()`.
> 
> This lifecycle is somewhat unusual in the Git codebase and creates two
> problems:
> 
>   - Callsites need to be very careful about when exactly they call
>     `ref_iterator_abort()`, as calling the function is only valid when
>     the iterator itself still is. This leads to somewhat awkward calling
>     patterns in some situations.
> 

In what situations, the iterator has been disappeared when we call
`ref_iterator_abort`? Why is this awkward? When reading, I am really
curious about this.

>   - It is impossible to reuse iterators and re-seek them to a different
>     prefix. This feature isn't supported by any iterator implementation
>     except for the reftable iterators anyway, but if it was implemented
>     it would allow us to optimize cases where we need to search for
>     specific references repeatedly by reusing internal state.
> 

So, the reason why we cannot reuse the iterator is that we will
deallocate the iterator? So, below we want to detangle the lifecycle. I
don't know whether my understanding is correct.

> Detangle the lifecycle from iteration so that we don't deallocate the
> iterator anymore once it is exhausted. Instead, callers are now expected
> to always call a newly introduce `ref_iterator_free()` function that
> deallocates the iterator and its internal state.
> 

A design question: why do not just introduce a variable, for example,
`unsigned int free` to indicate whether we need to free the iterator?

> While at it, drop the return value of `ref_iterator_abort()`, which
> wasn't really required by any of the iterator implementations anyway.
> Furthermore, stop calling `base_ref_iterator_free()` in any of the
> backends, but instead call it in `ref_iterator_free()`.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c              |  2 +
>  dir-iterator.c               | 24 +++++------
>  dir-iterator.h               | 13 ++----
>  refs.c                       |  7 +++-
>  refs/debug.c                 |  9 ++---
>  refs/files-backend.c         | 36 +++++------------
>  refs/iterator.c              | 95 ++++++++++++++------------------------------
>  refs/packed-backend.c        | 27 ++++++-------
>  refs/ref-cache.c             |  9 ++---
>  refs/refs-internal.h         | 31 +++++----------
>  refs/reftable-backend.c      | 34 ++++------------
>  t/helper/test-dir-iterator.c |  1 +
>  12 files changed, 99 insertions(+), 189 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index fd001d800c6..ac3e84b2b18 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -426,6 +426,8 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>  		strbuf_setlen(src, src_len);
>  		die(_("failed to iterate over '%s'"), src->buf);
>  	}
> +
> +	dir_iterator_free(iter);

Here, we explicitly free the iterator. This is a must, because we will
never free the iterator anymore.

>  }
>  
>  static void clone_local(const char *src_repo, const char *dest_repo)
> diff --git a/dir-iterator.c b/dir-iterator.c
> index de619846f29..857e1d9bdaf 100644
> --- a/dir-iterator.c
> +++ b/dir-iterator.c
> @@ -193,9 +193,9 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  
>  	if (S_ISDIR(iter->base.st.st_mode) && push_level(iter)) {
>  		if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
> -			goto error_out;
> +			return ITER_ERROR;

Here, we just return `ITER_ERROR` instead of going `error_out` label
which will call `dir_iterator_abort` function to free the iterator, we
should make the caller free.

>  		if (iter->levels_nr == 0)
> -			goto error_out;
> +			return ITER_ERROR;
>  	}
>  
>  	/* Loop until we find an entry that we can give back to the caller. */
> @@ -211,11 +211,11 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  			int ret = next_directory_entry(level->dir, iter->base.path.buf, &de);
>  			if (ret < 0) {
>  				if (iter->flags & DIR_ITERATOR_PEDANTIC)
> -					goto error_out;
> +					return ITER_ERROR;
>  				continue;
>  			} else if (ret > 0) {
>  				if (pop_level(iter) == 0)
> -					return dir_iterator_abort(dir_iterator);
> +					return ITER_DONE;

Instead of calling `dir_iterator_abort`, we just return `ITER_DONE`.
However, this does not make sense. We break the semantics of
`ITER_DONE`. Let me cite the comment from "iterator.h":

    /*
     * The iterator is exhausted and has been freed.
     */
    #define ITER_DONE -1

However, we don't free the iterator here.

>  				continue;
>  			}
>  
> @@ -223,7 +223,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  		} else {
>  			if (level->entries_idx >= level->entries.nr) {
>  				if (pop_level(iter) == 0)
> -					return dir_iterator_abort(dir_iterator);
> +					return ITER_DONE;
>  				continue;
>  			}
>  
> @@ -232,22 +232,21 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  
>  		if (prepare_next_entry_data(iter, name)) {
>  			if (errno != ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
> -				goto error_out;
> +				return ITER_ERROR;
>  			continue;
>  		}
>  
>  		return ITER_OK;
>  	}
> -
> -error_out:
> -	dir_iterator_abort(dir_iterator);
> -	return ITER_ERROR;
>  }
>  
> -int dir_iterator_abort(struct dir_iterator *dir_iterator)
> +void dir_iterator_free(struct dir_iterator *dir_iterator)

We rename `dir_iterator_abort` to `dir_iterator_free`. And we drop the
return value.

>  {
>  	struct dir_iterator_int *iter = (struct dir_iterator_int *)dir_iterator;
>  
> +	if (!iter)
> +		return;
> +

Make sense, because we have no idea whether the `dir_iterator` is
exhausted. So we need to check whether it is valid.

>  	for (; iter->levels_nr; iter->levels_nr--) {
>  		struct dir_iterator_level *level =
>  			&iter->levels[iter->levels_nr - 1];
> @@ -266,7 +265,6 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
>  	free(iter->levels);
>  	strbuf_release(&iter->base.path);
>  	free(iter);
> -	return ITER_DONE;

I am confused that why we don't provide `dir_iterator_release` for dir
iterator? For other ref related iterators, we will rename "*abort" to
"*release" and drop the operation to free the iterator. However, for dir
iterator, we rename its "*abort" to "*free".

I think this does not make sense. It causes inconsistency. Although dir
iterator does _not_ have "peel" method. But it does have "advance" and
"abort" methods just like ref iterators.

I think you have already considered this problem. I guess that's the
reason why in the below comment you typed `dir_iterator_release` instead
of `dir_iterator_free`.

>  }
>  
>  struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
> @@ -301,7 +299,7 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags)
>  	return dir_iterator;
>  
>  error_out:
> -	dir_iterator_abort(dir_iterator);
> +	dir_iterator_free(dir_iterator);
>  	errno = saved_errno;
>  	return NULL;
>  }
> diff --git a/dir-iterator.h b/dir-iterator.h
> index 6d438809b6e..01f51f6bac1 100644
> --- a/dir-iterator.h
> +++ b/dir-iterator.h
> @@ -27,10 +27,8 @@
>   *             goto error_handler;
>   *
>   *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
> - *             if (want_to_stop_iteration()) {
> - *                     ok = dir_iterator_abort(iter);
> + *             if (want_to_stop_iteration())
>   *                     break;
> - *             }

Is this correct? If `want_to_stop_iteration()` is true, the `ok` will be
`ITER_OK` and then it breaks the loop to jump to check whether the `ok`
is `ITER_DONE`. Of course it is not, it will call `handle_error`. At
least, we should assign `ok = ITER_DONE`.

>   *
>   *             // Access information about the current path:
>   *             if (S_ISDIR(iter->st.st_mode))
> @@ -39,6 +37,7 @@
>   *
>   *     if (ok != ITER_DONE)
>   *             handle_error();
> + *     dir_iterator_release(iter);

I think this is a typo. Should `dir_iterator_release` be
`dir_iterator_free`?

>   *
>   * Callers are allowed to modify iter->path while they are working,
>   * but they must restore it to its original contents before calling
> @@ -107,11 +106,7 @@ struct dir_iterator *dir_iterator_begin(const char *path, unsigned int flags);
>   */
>  int dir_iterator_advance(struct dir_iterator *iterator);
>  
> -/*
> - * End the iteration before it has been exhausted. Free the
> - * dir_iterator and any associated resources and return ITER_DONE. On
> - * error, free the dir_iterator and return ITER_ERROR.
> - */
> -int dir_iterator_abort(struct dir_iterator *iterator);
> +/* Free the dir_iterator and any associated resources. */
> +void dir_iterator_free(struct dir_iterator *iterator);
>  
>  #endif
> diff --git a/refs.c b/refs.c
> index eaf41421f50..8eff60a2186 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2476,6 +2476,7 @@ int refs_verify_refnames_available(struct ref_store *refs,
>  {
>  	struct strbuf dirname = STRBUF_INIT;
>  	struct strbuf referent = STRBUF_INIT;
> +	struct ref_iterator *iter = NULL;
>  	struct strset dirnames;
>  	int ret = -1;
>  
> @@ -2552,7 +2553,6 @@ int refs_verify_refnames_available(struct ref_store *refs,
>  		strbuf_addch(&dirname, '/');
>  
>  		if (!initial_transaction) {
> -			struct ref_iterator *iter;
>  			int ok;
>  
>  			iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
> @@ -2564,12 +2564,14 @@ int refs_verify_refnames_available(struct ref_store *refs,
>  
>  				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
>  					    iter->refname, refname);
> -				ref_iterator_abort(iter);
>  				goto cleanup;
>  			}
>  
>  			if (ok != ITER_DONE)
>  				BUG("error while iterating over references");
> +
> +			ref_iterator_free(iter);
> +			iter = NULL;
>  		}
>  
>  		extra_refname = find_descendant_ref(dirname.buf, extras, skip);
> @@ -2586,6 +2588,7 @@ int refs_verify_refnames_available(struct ref_store *refs,
>  	strbuf_release(&referent);
>  	strbuf_release(&dirname);
>  	strset_clear(&dirnames);
> +	ref_iterator_free(iter);
>  	return ret;
>  }
>  
> diff --git a/refs/debug.c b/refs/debug.c
> index fbc4df08b43..a9786da4ba1 100644
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -179,19 +179,18 @@ static int debug_ref_iterator_peel(struct ref_iterator *ref_iterator,
>  	return res;
>  }
>  
> -static int debug_ref_iterator_abort(struct ref_iterator *ref_iterator)
> +static void debug_ref_iterator_release(struct ref_iterator *ref_iterator)

Here, we rename "*abort" to "*release" for debug ref and call the
corresponding `release` method.

>  {
>  	struct debug_ref_iterator *diter =
>  		(struct debug_ref_iterator *)ref_iterator;
> -	int res = diter->iter->vtable->abort(diter->iter);
> -	trace_printf_key(&trace_refs, "iterator_abort: %d\n", res);
> -	return res;
> +	diter->iter->vtable->release(diter->iter);
> +	trace_printf_key(&trace_refs, "iterator_abort\n");
>  }
>  
>  static struct ref_iterator_vtable debug_ref_iterator_vtable = {
>  	.advance = debug_ref_iterator_advance,
>  	.peel = debug_ref_iterator_peel,
> -	.abort = debug_ref_iterator_abort,
> +	.release = debug_ref_iterator_release,
>  };
>  
>  static struct ref_iterator *
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 29f08dced40..9511b6f3448 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -919,10 +919,6 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  		return ITER_OK;
>  	}
>  
> -	iter->iter0 = NULL;
> -	if (ref_iterator_abort(ref_iterator) != ITER_DONE)
> -		ok = ITER_ERROR;
> -

We don't abort the iterator in `advance`. Is this because we want to
reuse this iterator?

>  	return ok;
>  }
>  

[snip]

> @@ -935,23 +931,17 @@ static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
>  	return ref_iterator_peel(iter->iter0, peeled);
>  }
>  
> -int ref_iterator_abort(struct ref_iterator *ref_iterator)
> +void ref_iterator_free(struct ref_iterator *ref_iterator)
>  {
> -	return ref_iterator->vtable->abort(ref_iterator);
> +	if (ref_iterator) {
> +		ref_iterator->vtable->release(ref_iterator);
> +		/* Help make use-after-free bugs fail quickly: */
> +		ref_iterator->vtable = NULL;
> +		free(ref_iterator);
> +	}
>  }
>  

So, when calling `ref_iterator_free`, we will call corresponding
"release" method to release the resources associated and then we free
the iterator. Would this be too complicated? From my view, we could just
make the `ref_iterator_abort` name unchanged but add a new variable such
as "unsigned int free_iterator". And we change each "abort" callback to
avoid free the iterator. This would be much simpler.

[snip]

> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 02f09e4df88..6457e02c1ea 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -409,7 +409,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  		if (++level->index == level->dir->nr) {
>  			/* This level is exhausted; pop up a level */
>  			if (--iter->levels_nr == 0)
> -				return ref_iterator_abort(ref_iterator);
> +				return ITER_DONE;

As I have said, simply return `ITER_DONE` breaks the semantics of the
`ITER_DONE`.

>  
>  			continue;
>  		}
> @@ -452,21 +452,18 @@ static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
>  	return peel_object(iter->repo, ref_iterator->oid, peeled) ? -1 : 0;
>  }
>  
> -static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
> +static void cache_ref_iterator_release(struct ref_iterator *ref_iterator)
>  {
>  	struct cache_ref_iterator *iter =
>  		(struct cache_ref_iterator *)ref_iterator;
> -
>  	free((char *)iter->prefix);
>  	free(iter->levels);
> -	base_ref_iterator_free(ref_iterator);
> -	return ITER_DONE;
>  }
>  
>  static struct ref_iterator_vtable cache_ref_iterator_vtable = {
>  	.advance = cache_ref_iterator_advance,
>  	.peel = cache_ref_iterator_peel,
> -	.abort = cache_ref_iterator_abort
> +	.release = cache_ref_iterator_release,
>  };
>  
>  struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index aaab711bb96..27ff822cf43 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -273,11 +273,11 @@ enum do_for_each_ref_flags {
>   * the next reference and returns ITER_OK. The data pointed at by
>   * refname and oid belong to the iterator; if you want to retain them
>   * after calling ref_iterator_advance() again or calling
> - * ref_iterator_abort(), you must make a copy. When the iteration has
> + * ref_iterator_free(), you must make a copy. When the iteration has
>   * been exhausted, ref_iterator_advance() releases any resources
>   * associated with the iteration, frees the ref_iterator object, and
>   * returns ITER_DONE. If you want to abort the iteration early, call
> - * ref_iterator_abort(), which also frees the ref_iterator object and
> + * ref_iterator_free(), which also frees the ref_iterator object and
>   * any associated resources. If there was an internal error advancing
>   * to the next entry, ref_iterator_advance() aborts the iteration,
>   * frees the ref_iterator, and returns ITER_ERROR.
> @@ -292,10 +292,8 @@ enum do_for_each_ref_flags {
>   *     struct ref_iterator *iter = ...;
>   *
>   *     while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
> - *             if (want_to_stop_iteration()) {
> - *                     ok = ref_iterator_abort(iter);
> + *             if (want_to_stop_iteration())
>   *                     break;
> - *             }

I also think here we have problem, at least we should set `ok =
ITER_DONE`.

>   *
>   *             // Access information about the current reference:
>   *             if (!(iter->flags & REF_ISSYMREF))
> @@ -307,6 +305,7 @@ enum do_for_each_ref_flags {
>   *
>   *     if (ok != ITER_DONE)
>   *             handle_error();
> + *     ref_iterator_free(iter);
>   */
>  struct ref_iterator {
>  	struct ref_iterator_vtable *vtable;
> @@ -333,12 +332,8 @@ int ref_iterator_advance(struct ref_iterator *ref_iterator);
>  int ref_iterator_peel(struct ref_iterator *ref_iterator,
>  		      struct object_id *peeled);
>  
> -/*
> - * End the iteration before it has been exhausted, freeing the
> - * reference iterator and any associated resources and returning
> - * ITER_DONE. If the abort itself failed, return ITER_ERROR.
> - */
> -int ref_iterator_abort(struct ref_iterator *ref_iterator);
> +/* Free the reference iterator and any associated resources. */
> +void ref_iterator_free(struct ref_iterator *ref_iterator);
>  
>  /*
>   * An iterator over nothing (its first ref_iterator_advance() call
> @@ -438,13 +433,6 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
>  void base_ref_iterator_init(struct ref_iterator *iter,
>  			    struct ref_iterator_vtable *vtable);
>  
> -/*
> - * Base class destructor for ref_iterators. Destroy the ref_iterator
> - * part of iter and shallow-free the object. This is meant to be
> - * called only by the destructors of derived classes.
> - */
> -void base_ref_iterator_free(struct ref_iterator *iter);
> -

OK, here we delete `base_ref_iterator_free`. Because we will use
`ref_iterator_free`.

>  /* Virtual function declarations for ref_iterators: */
>  
>  /*
> @@ -463,15 +451,14 @@ typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
>  
>  /*
>   * Implementations of this function should free any resources specific
> - * to the derived class, then call base_ref_iterator_free() to clean
> - * up and free the ref_iterator object.
> + * to the derived class.
>   */
> -typedef int ref_iterator_abort_fn(struct ref_iterator *ref_iterator);
> +typedef void ref_iterator_release_fn(struct ref_iterator *ref_iterator);

So here why we name this function to `release` is that we want to
release any resource related to iterator but we don't free iterator
itself.

[snip]


---

Some my thinking after reading this whole patch:

1. We somehow misuses the "ITER_DONE". We either need to adjust its
meaning (we just delete the iterator is freed part) or introduces a new
state to represent that the iteration is done but we don't release its
resource and free the iterator itself.

2. I don't think we need to make things complicated. From my
understanding, the motivation here is that we don't want to `advance`
callback to call `abort` callback. I want to ask an _important_ question
here: what is the motivation we rename `abort` to `release` in the first
place? As far as I know, we only call this callback in the newly created
"ref_iterator_free". Although release may be more accurate, this change
truly causes overhead of this patch.

3. If the motivation is that we don't want to `advance` callback to call
`abort` callback. I think we could just let the user call `abort`
callback for the following two situations:

    1. We have exhausted the iteration. It returns `ITER_OK`.
    2. We encountered the error, it returns `ITER_ERROR`.

And we give the freedom to the caller. It's their duty to call
`ref_iterator_abort` which cleans the resource and free the iterator.

Writing here, I have always thought that there is a situation that we
just want to release the resources but not want to free the iterator
itself. That's why I am wondering why just add a new variable to do.
However, if we just want to make the lifecycle out, we just delete each
"abort" code where it frees the iterator. And we free the iterator in
the "ref_iterator_abort". Should this be enough?

Thanks,
Jialuo
