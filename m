Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43F824A3
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408550; cv=none; b=MHpJ8RewA0zBKNjRktFl2Cl755hrdJBp5czkqBWHUltfR6EjkbmNRnVKMqjG1r3ss9WELpwHpKUi5LfEXftiPXcBm/q4r0ePoWbrH0PEUU6QpyFomtFIQMoeH8TbyidVmBjpAwuT8kaZmHwI3FtKKbeCLtZ7OQ1CQ+VrrYCUz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408550; c=relaxed/simple;
	bh=iZv2wKu5D2qTgMa1He2rMqoyZEqUBS6HnHr90cHeBXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Um/P4RKQe3sJXYrdPxtwWr4DRPCpVwtSsNt3kMgLa4JsRJ+WEMYAXwEQHvcZhBG6SZYqIjDDUhrgJhYRn0i5tIEC/awkmSKrHv4eHu+bNvSQEay1LSnUCSZADApVBysL1gr8L92iDYy0OiUdqW4GiByo1iL6XyYfysutvmq+eaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQfWNESi; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQfWNESi"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220d398bea9so70359065ad.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740408548; x=1741013348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PoAuzVE+1AnxRu2S96ynCj9TvFW4rDbugBw9L0HhHgA=;
        b=mQfWNESiuMmB+MDYDj1dteEmkTncDJP705qXUc8fnhcIJ1jnmL/LHLxD5vg9xs0q/A
         j9FPnwb8B/B95dLmK/zoznbZ7giGqIYBKKHpbR+NEQbSsZKuPzvLW68OYUkB+cHd4mtl
         IedNzLvm5Y+nb7ZqEG92xadimJ6AhpDXCDcatDSP+Pjb3YHZszM9x3kWuRfsOrvpthdl
         3TRzpxKjQQe8CtmZKki3q5zKIUF9xzgmmraaE6ADyJLRDjijzW5THjTfRx1M0i+A37Cr
         3WhuY7H9tiZE/8MYfLYPo+k1kXZxYtTae50BFh7QalpZdJ0cVZt8nhQ58BkODJs4LCir
         YJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740408548; x=1741013348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoAuzVE+1AnxRu2S96ynCj9TvFW4rDbugBw9L0HhHgA=;
        b=KnA72PCLdqO5/GuUfjZtrNRxMElDGV/S/ZzBLEYywiq3U28j8ieH0r4lvUXqCpZHW7
         /9aPzf58Xt9FQ+BprjN8Rc+RatfxUW+xeXxiuMYXE5bOQVg9PJ4AXpxEXnpeH3Z0QANz
         /uuNmcr/IDVEwlH69iFPdSIsTz8ggnLXou5dhJDhmOX1lLIIBZW50YIa63HfUFN170Xv
         TmnFFS0EpXoUljgW0QhsZ+o+SNRiuT17UoAtcZyp5Pc+BwtAKXcizH+b61tcgyRyQG7A
         Z6FSt7NkAAn7Fi4D58t6K4Xv4ILiiIo6yWBMVlysblLoPiaw9a5yxxLBGKFukkjsE/AJ
         A/YA==
X-Gm-Message-State: AOJu0YxIJcrcFfV9XikdEnXjEyvCLBeSbnmpos4KhGmm6Kl1QxEySoaZ
	4kFu3ggyso7Gmlhymr1pRtd1yprtw84hKBZ/LEbTNmB08sHKlLd9tj3pDA==
X-Gm-Gg: ASbGncuDshua/eEz1gn4yj3nJTr55U1liqL4I3IolpvQpZwrnyWULmuPkgARAYcRSi5
	V8plfA4YcYNALqcp2uQEESkkiaGqeizxvYUf2MIFfE0WjGXaQj8ykXyt+4HgcuVlGroDSKJfm8M
	BjSIt837vLExPBoOD3lIaawNWcFrAHsJpaUXndxQeMZs67zUH+qnVifZhTCOKBp8EkoWpFMmwBU
	LzNrXwf+oYkkzdRkWwdTqRJ+1pU5IzEVFr2fyc8vI4wPauGvjm5lBA8SHUznV5M2D5F9cFxyXIj
	JdRx9CjhZvrhnBkQcxX5qQ==
X-Google-Smtp-Source: AGHT+IG15P0OsBhmCOFFMdlgPhN0GjJBRyUSEyoDu4u60q5hqdJ0w4q2l4WRyTgdnvbP3WysK5PFKg==
X-Received: by 2002:a05:6a00:188b:b0:732:2923:b71a with SMTP id d2e1a72fcca58-73426d727fdmr20625388b3a.19.1740408548388;
        Mon, 24 Feb 2025 06:49:08 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7327a324673sm14882966b3a.23.2025.02.24.06.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:49:07 -0800 (PST)
Date: Mon, 24 Feb 2025 22:49:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 13/16] refs/iterator: implement seeking for ref-cache
 iterators
Message-ID: <Z7yG6q44rBccInPt@ArchLinux>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-13-e696e7220b22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-pks-update-ref-optimization-v2-13-e696e7220b22@pks.im>

On Wed, Feb 19, 2025 at 02:23:40PM +0100, Patrick Steinhardt wrote:
> Implement seeking of ref-cache iterators. This is done by splitting most
> of the logic to seek iterators out of `cache_ref_iterator_begin()` and
> putting it into `cache_ref_iterator_seek()` so that we can reuse the
> logic.
> 
> Note that we cannot use the optimization anymore where we return an
> empty ref iterator when there aren't any references, as otherwise it
> wouldn't be possible to reseek the iterator to a different prefix that
> may exist. This shouldn't be much of a performance corncern though as we
> now start to bail out early in case `advance()` sees that there are no
> more directories to be searched.
> 

Bit: corncern/concern. Don't worth a reroll.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/ref-cache.c | 74 ++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 48 insertions(+), 26 deletions(-)
> 
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 6457e02c1ea..b54547d71ee 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -362,9 +362,7 @@ struct cache_ref_iterator {
>  	struct ref_iterator base;
>  
>  	/*
> -	 * The number of levels currently on the stack. This is always
> -	 * at least 1, because when it becomes zero the iteration is
> -	 * ended and this struct is freed.
> +	 * The number of levels currently on the stack.
>  	 */

So, this value could be zero? We want to use this to optimize because
that we don't return the empty ref iterator any more.

>  	size_t levels_nr;
>  
> @@ -389,6 +387,9 @@ struct cache_ref_iterator {
>  	struct cache_ref_iterator_level *levels;
>  
>  	struct repository *repo;
> +	struct ref_cache *cache;
> +
> +	int prime_dir;

The reason why we needs to add these two states is that when using
`cache_ref_iterator_begin`, we need to pass `ref_cache` and
`prime_dir`. So, we need to store the state when reusing the ref
iterator.

>  };
>  
>  static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
> @@ -396,6 +397,9 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  	struct cache_ref_iterator *iter =
>  		(struct cache_ref_iterator *)ref_iterator;
>  
> +	if (!iter->levels_nr)
> +		return ITER_DONE;
> +

Ok, we will check whether the cache ref iterator is exhausted.

>  	while (1) {
>  		struct cache_ref_iterator_level *level =
>  			&iter->levels[iter->levels_nr - 1];
> @@ -444,6 +448,40 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  	}
>  }
>  
> +static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
> +				   const char *prefix)
> +{
> +	struct cache_ref_iterator *iter =
> +		(struct cache_ref_iterator *)ref_iterator;
> +	struct ref_dir *dir;
> +
> +	dir = get_ref_dir(iter->cache->root);
> +	if (prefix && *prefix)
> +		dir = find_containing_dir(dir, prefix);
> +
> +	if (dir) {
> +		struct cache_ref_iterator_level *level;
> +
> +		if (iter->prime_dir)
> +			prime_ref_dir(dir, prefix);
> +		iter->levels_nr = 1;
> +		level = &iter->levels[0];
> +		level->index = -1;
> +		level->dir = dir;
> +
> +		if (prefix && *prefix) {
> +			iter->prefix = xstrdup(prefix);

Should we free the original `iter->prefix` before we assign the new
`prefix`? I have seen this pattern in previous patch. If the caller
calls this function multiple times, there would be memory leak.

> +			level->prefix_state = PREFIX_WITHIN_DIR;
> +		} else {
> +			level->prefix_state = PREFIX_CONTAINS_DIR;
> +		}
> +	} else {
> +		iter->levels_nr = 0;
> +	}

When we cannot find the dir, we set the `iter->levels_nr = 0`. Could we
first check

    if (!dir) {
	iter->levels_nr = 0;
	return 0;
    }

And thus we could avoid indentation. However, it seems that we always
return 0. So, maybe we should not change.

> +
> +	return 0;

I know your motivation that you want to normally return the ref iterator
thus we can reuse later. The original behavior is that we return an
empty ref iterator but empty ref iterator cannot be reused. So, we will
always get the cache ref iterator. If the level is 0, we still have a
valid cache ref iterator. Make sense.

> +}
> +

Thanks,
Jialuo
