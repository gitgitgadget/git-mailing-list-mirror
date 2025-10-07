Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40835957
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860320; cv=none; b=riuyyd7taPnbc/iykuuLYpbF4FdO0snSjoir3Kke7hDEP46gqIx/+sPqWrC8Vza2ZyoDwYOGF0+FwsATmQ47U9jnJ0CiQDSX+ObZ/6YHcc8z5bd+pr7rNjquQgaJ7vDwPJJmt0RZjXf9f9MkaAhB5JpnG8o4tZ5pfToR7cZ9pso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860320; c=relaxed/simple;
	bh=2nXc8AMWp+lLgdEaDpT644mNJXNKLb3j2kG85jVprTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjDzxzKmK7wWB9FaxX0I/umn4VE9Mxob+oz/z30alukAs66ObmHGpah1/e8wJODOkgZPdQtYwz41HTC59LJI0sojFFWTm5xhUrHoXAmBWX0jhTw6pB+iPKo1Xl/VEv4FN1O9TdXFRWjzfrNqNlHJzkUIbwQ7KWgbMbZqrBSECfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceMLIYva; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceMLIYva"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7a7d79839b2so5165682a34.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759860317; x=1760465117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCeG3z+IV8KZI3TXhZhgvobekHjpyJh7P5/qom6TnEc=;
        b=ceMLIYvaoj0m/e0YxxxuVt+Cnd3kp69gBvl2OPS6Dt64t6tkLWvoYbiLcyG/Xb5tZi
         klciOf9gbBlRpAVl5CQww0eHIBwxj3QFFRSWA49WYAR5JymqQ2nB6D1apI7xhss+mbSP
         DfedjMUwf1lWbnkRBcJ/mvupNbahfkzXwGJ3TbzyxnYy1Oxio/y7DQFHXuN/2NQIoDE7
         sKtPg6XPv/kzCVLdsQfL+iCy4A+BTcoZFRyc2epZ4Y8x1jjeEIDWuyLmZVlbsy+RSapk
         QyCMxu4VzGnompYeWAr9rlQ181TYoJmsW3jCNLOEt5j0qDgCEnhUHxxaFMqw8Klc8tYW
         rV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759860318; x=1760465118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCeG3z+IV8KZI3TXhZhgvobekHjpyJh7P5/qom6TnEc=;
        b=qE/UZd1lfP4pHm8IZmv+VND91D2xoC9kec8vvMI/XKcs9+b1r1SWXW8S0U6vXXJfz+
         Mad9p5EZF6xg7KINS3ExsEktkwg+DayEaz3b7h/+YdjdvbLWelq7bYYPD7M0fBcdxNtq
         d0uS+1gGgJuEtL8Phn7bVrJfZm8FXe6T4oSnJC7wFTtGlHYn3hBfmkkeeUEG4FiyNEaJ
         ftm16YInp02IIUhmcS89vtqTbHERjBQn/E1L0K2mTK/IYW4ENA+NUYygwuEwsCQf6FHi
         dO3XQkvjjgSFObPYX2nzuOM+3oa2uKx62DTkWWeIFb4AJSYlfbmk9gaZHDZq5Z4A67gm
         xzWg==
X-Gm-Message-State: AOJu0YzzuQpvBAa5r53JHtrCCdd+gjeQ1lpfGIMdTgelxzYRRgmxfAOy
	URfomQCSVdTas1KPYilx3MCXj9zPyBX5Sgkn1nb0DlAhSNp1XmHCKD7cxSnvRA==
X-Gm-Gg: ASbGncsoGa8fGmiB01q8Nvz2uQnUEhwI0smuilJHg7IS3g3Se8SBjum8ICfViWc+pg9
	1mOz1UBVNTZdWVCodx61Cfj8E9KrRa+ykhwM5WfSRFoORdboYTIyzxoKsb0pLatQT8ZBGLGX5r+
	G7C5riW2QqvvDbA0dW6HlTAeGfphLfeUveH/kqy08BwMwiZA+AukmyHUdn5AMRbFP1A7hzo/pyP
	MheRx2hNFfF9hXsb/KIfguYrOlff/I3oasW+LYs+X6lWdEy9BOZoBeTr8UuhZbLb5NVBcQo0ri3
	jOhbi09zEkxdVwE1Oh5OvTgFFr1+p0u/C6V3Ey+wKBH5pdQDlWDadBTpfcfnn0riAbPaL3LJsEy
	53KFDwt+TZ6AVD/gwaZntdLgLNsZEEqdmOA0+7ZNpA5xKQ7qPLqE=
X-Google-Smtp-Source: AGHT+IEYM10ldFKzS5Yulm+mpYcGzq1y1akkYuicwYf/3NXw/PQARPDPRN33e3sSCM0PiD2zpMT9Hw==
X-Received: by 2002:a05:6830:d8d:b0:744:f0db:a19d with SMTP id 46e09a7af769-7c0df816f02mr508341a34.33.1759860317539;
        Tue, 07 Oct 2025 11:05:17 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-64e5b04ccabsm3060807eaf.22.2025.10.07.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:05:17 -0700 (PDT)
Date: Tue, 7 Oct 2025 13:05:15 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/13] refs: introduce wrapper struct for `each_ref_fn`
Message-ID: <jrst5hft3o7ee72hrmswhrnz46rgvjihdxgfsougg5u5vs6os4@2prgx3uw6qp7>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-1-916cc7c6886b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-1-916cc7c6886b@pks.im>

On 25/10/07 12:58PM, Patrick Steinhardt wrote:
> The `each_ref_fn` callback function type is used across our code base
> for several different functions that iterate through reference. There's
> a bunch of callbacks implementing this type, which makes any changes to
> the callback signature extremely noisy. An example of the required churn
> is e8207717f1 (refs: add referent to each_ref_fn, 2024-08-09): adding a
> single argument required us to change 48 files.
> 
> It was already proposed back then [1] that we might want to introduce a
> wrapper structure to alleviate the pain going forward. While this of
> course requires the same kind of global refactoring as just introducing
> a new parameter, it at least allows us to more change the callback type
> afterwards by just extending the wrapper structure.
> 
> One counterargument to this refactoring is that it makes the structure
> more opaque. While it is obvious which callsites need to be fixed up
> when we change the function type, it's not obvious anymore once we use
> a structure. That being said, we only have a handful of sites that
> actually need to populate this wrapper structure: our ref backends and
> "refs/iterator.c".

It looks like we also populate `stuct reference` in a couple other spots
where we invoke the callback explicitly.

> Introduce this wrapper structure so that we can adapt the iterator
> interfaces more readily.
> 
> [1]: <ZmarVcF5JjsZx0dl@tanuki>
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/refs.h b/refs.h
> index 4e6bd63aa86..2b24a3d9974 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -355,14 +355,32 @@ struct ref_transaction;
>   */
>  #define REF_BAD_NAME 0x08
>  
> +/* A reference passed to `for_each_ref()`-style callbacks. */
> +struct reference {
> +	/* The fully-qualified name of the reference. */
> +	const char *name;
> +
> +	/* The target of a symbolic ref. `NULL` for direct references. */
> +	const char *target;
> +
> +	/*
> +	 * The object ID of a reference. Either the direct object ID or the
> +	 * resolved object ID in the case of a symbolic ref. May be the zero
> +	 * object ID in case the symbolic ref cannot be resolved.
> +	 */
> +	const struct object_id *oid;
> +
> +	/* A bitfield of `REF_` flags. */
> +	int flags;

I was considering for a little while whether it would make sense for all
the arguments to be moved here, or if ones such as flags should remain.
Since all these fields directly relate to the reference though, I think
it does make sense to relocate all of them.

> +};

Ok, so now all the explicit callback arguments are contained in `struct
reference` here. Going forward this certainly would reduce churn if need
need to add additional fields here. Overall, this seems sensible to me.

> +
>  /*
>   * The signature for the callback function for the for_each_*()
>   * functions below.  The memory pointed to by the refname and oid
>   * arguments is only guaranteed to be valid for the duration of a
>   * single callback invocation.
>   */

Should we update this comment now that these fields are contained the
wrapper struct?

[snip]
> diff --git a/refs/iterator.c b/refs/iterator.c
> index 17ef841d8a3..7f2e718f1c9 100644
> --- a/refs/iterator.c
> +++ b/refs/iterator.c
> @@ -476,7 +476,14 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
>  
>  	current_ref_iter = iter;
>  	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
> -		retval = fn(iter->refname, iter->referent, iter->oid, iter->flags, cb_data);
> +		struct reference ref = {
> +			.name = iter->refname,
> +			.target = iter->referent,
> +			.oid = iter->oid,
> +			.flags = iter->flags,
> +		};

Now we wire up the new wrapper struct instead of passing explicit
arguments. Looks good.

> +
> +		retval = fn(&ref, cb_data);
>  		if (retval)
>  			goto out;
>  	}

-Justin
