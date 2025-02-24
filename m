Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B381A29A
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405626; cv=none; b=Wue9P+kgY4RsKBrtHQb12B7sPZPnjMCwIa5fUfo3J/p0G7B9bvtyPrajP6gS3naRzCskgzYzcEZCHrBkagt9n3F8fsEQ7GbI4gIrXyBTPptYi8S719usfrHh4o/U6rG1+WyeY20EChYTfjU9VcIzBR3naQ4tQtvAUmWq7fUU7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405626; c=relaxed/simple;
	bh=aP6B9zroCy67XLXgI3Xq9tQ9OQL9pH7iThpMz8cwDkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iod9EsY0U1rD3pJA9ClGIKH8btjms7VmF65mTQXtp4b/KnH3kVdQoknIztRYwXQJoDOGWAmwkp3M/G85BlQnjKODkWCkcg6QaOMNBbPIJ646tObrL+rbVj1ycKFk5ljSr+I0bSd8I4cVtuWRjoU4FCAC1tvRkcVEv4fjmi6CK/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbELie3w; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbELie3w"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2212a930001so5978055ad.0
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 06:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740405625; x=1741010425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=orTso0HuKCvLOSMUuiytV/+jq7FK56ZlasiaCQDYYZw=;
        b=PbELie3wtfuaNLEXYDEe1ejheFrg/bZZ5clKoAJcqherim6sqJU/VemOTX23Ao9Nfc
         85eMK9pVPZ3Bp4qOgdSz2w2knhrN0dC0nzIdM568MS/mqL0lKjP5AGwySzWNFPYP9ijR
         V+y3cyH7ZRqKH4R3qC/hlX65VeP5lsyPPs6MIXsrUOiXd+I1maT8Ft4+RO31/sP7vFXz
         7eQcusJYPoyXLbym86g0hiuA4iVRP1AlcuyG9XDwq/iIiUhJOFF12PlEw13mZuXGEhrc
         2Rx7mRib6DpPZftVq3++sKWT6pSFG1fTZu0w7DHqvzy3ZXGsxOPM0xANfDt8D4y1tKO0
         3xWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740405625; x=1741010425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orTso0HuKCvLOSMUuiytV/+jq7FK56ZlasiaCQDYYZw=;
        b=o38KRVoFX4impO26ZZU9VjIugGalBEEBcxMOKeOyHnJVtPXeZ6rsVIi18kBOq+UKcv
         aaYhrFgJ8q0cmJI8hRxQzvF9rJO5HkCWmZDI8hd7p4kxwUeqAXK2IHBx0ECyK7KWGjo6
         w+QnUV2WY9cgQTWakPXpUGjCi6oXCZe4G+NFZWJu+HKMIG3y8H9NHxlMFnERsRVW0GO0
         C0IW2Vxv9fskOQsIK2BTc0L4rj5p3woUN9VrjZEMFdBUlAN9ZweqrB19u37NCa+XLRQd
         cFtm5EW0EuMQeShP+R9eAMkN0qZR8iFEUWv8cVD2xURVGvoMGKjmaWOhojahNJY+PXMN
         ajSg==
X-Gm-Message-State: AOJu0Yx14R2dW0ShsLZWtcibA0UXh2zKg9N9ieZfNBGAE099sLNCoMEG
	W63j3STT+5sDLifAhui9bm+8kC6HzK1f45Fx9hQSphR4mTkXnDOn
X-Gm-Gg: ASbGnctVB5HZ/beZ9X66WR9/EkfHRpMdhfQ9CE/kcgcXn0UI9rzX0vYN1tlh+/4B4AZ
	Srhx00XvqxbIPZcYidmPsDj/Kho/bAk3PQtxbuKMxVhPUvxZQzTfNsO0lVA4m0u7z8OM6UvRljn
	tzkc7uzpKV4ek46xn0cALFE07C6+6GqQavvDX0m+eur8oYTwh/JmXiIKO9ZG5pTOyA4AXafTAo6
	FCQMX7jYW/Q30ZQBFpixURzvTJJ+Yi3gW552BvnjDQIg3bFjdsxytjjtSbuijsdchUfSTrRPmsO
	q1aW5DTdRBj4pUhmXsT6dQ==
X-Google-Smtp-Source: AGHT+IHgQyD5II81l+uhipXpM7Gas9/ICMH+/EWD6SUBb7qoQ6Rx/qlgZm1wW+HAGnS1CzYggdStww==
X-Received: by 2002:a17:902:e74c:b0:220:ff3f:6cba with SMTP id d9443c01a7336-221a1142769mr228912105ad.38.1740405622081;
        Mon, 24 Feb 2025 06:00:22 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73413894baesm8513181b3a.153.2025.02.24.06.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:00:21 -0800 (PST)
Date: Mon, 24 Feb 2025 22:00:28 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 12/16] refs/iterator: implement seeking for reftable
 iterators
Message-ID: <Z7x7fDiW0iN7qGIg@ArchLinux>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-12-e696e7220b22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-pks-update-ref-optimization-v2-12-e696e7220b22@pks.im>

On Wed, Feb 19, 2025 at 02:23:39PM +0100, Patrick Steinhardt wrote:
> Implement seeking of reftable iterators. As the low-level reftable
> iterators already support seeking this change is straight-forward. Two
> notes though:
> 
>   - We do not support seeking on reflog iterators.
> 
>   - We start to check whether `reftable_stack_init_ref_iterator()` is
>     successful.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 06543f79c64..b0c09f34433 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -547,7 +547,7 @@ struct reftable_ref_iterator {
>  	struct reftable_ref_record ref;
>  	struct object_id oid;
>  
> -	const char *prefix;
> +	char *prefix;
>  	size_t prefix_len;
>  	char **exclude_patterns;
>  	size_t exclude_patterns_index;
> @@ -718,6 +718,20 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
>  	return ITER_OK;
>  }
>  
> +static int reftable_ref_iterator_seek(struct ref_iterator *ref_iterator,
> +				      const char *prefix)
> +{
> +	struct reftable_ref_iterator *iter =
> +		(struct reftable_ref_iterator *)ref_iterator;
> +
> +	free(iter->prefix);
> +	iter->prefix = xstrdup_or_null(prefix);
> +	iter->prefix_len = prefix ? strlen(prefix) : 0;
> +	iter->err = reftable_iterator_seek_ref(&iter->iter, prefix);

Should we rename this function `reftable_iterator_seek_ref` by the way?
It is a little strange that we have two functions which are so similar:

1. reftable_ref_iterator_seek
2. reftable_iterator_seek_ref

However, don't worth a reroll.

> +
> +	return iter->err;
> +}
> +
>  static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
>  				      struct object_id *peeled)
>  {
> @@ -744,10 +758,12 @@ static void reftable_ref_iterator_release(struct ref_iterator *ref_iterator)
>  			free(iter->exclude_patterns[i]);
>  		free(iter->exclude_patterns);
>  	}
> +	free(iter->prefix);
>  }
>  
>  static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
>  	.advance = reftable_ref_iterator_advance,
> +	.seek = reftable_ref_iterator_seek,
>  	.peel = reftable_ref_iterator_peel,
>  	.release = reftable_ref_iterator_release,
>  };
> @@ -806,8 +822,6 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
>  
>  	iter = xcalloc(1, sizeof(*iter));
>  	base_ref_iterator_init(&iter->base, &reftable_ref_iterator_vtable);
> -	iter->prefix = prefix;
> -	iter->prefix_len = prefix ? strlen(prefix) : 0;

We don't assign `iter->prefix` and `iter->prefix_len` here. This is
because we want to use the new defined function
`reftable_ref_iterator_seek`. In the fist glance, I am worried that
"iter->prefix" might not be `NULL`. However, because we use `xcalloc`,
"iter->prefix" would be `NULL` by default.

Thanks,
Jialuo
