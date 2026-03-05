Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD50336682E
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716039; cv=pass; b=YpFGUjkA/RkLoJJ4qrlpTJeU9PTesbYrK5kbZ2NH0wg5jSVFMjhOGAu6Mqd7g7pK0ZegVPCl2sLToMJCOi11stkTOYFyI0sddGT8wJadX0u9hBOZE7Pn0yM/W8KakwB4jbqcnbe+19XBps1qrsh6ranZAyPGmry+gZc63iOp0rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716039; c=relaxed/simple;
	bh=Bv79wPeWZ/GdCCCWxRMPhwRPn+/8p8eoUczSvnEkUWs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=L7IPWlh97Ye2Tt2r4UKWWASf97WlLBi9htRLPQZdjN30a+r7v3lDLG1SDKz/7LZc/ByIczFOJFPg2e+NPfq6PwtS7jdIubjVywLh/XO7DMejhbAppJtXVYWZvAPbtXEWuoATWLeNDb9ysD2q/tD5OASReZ87mZKw8cEJarZnVYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5fi2xQl; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5fi2xQl"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94d5f90c8b6so4563217241.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 05:07:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772716037; cv=none;
        d=google.com; s=arc-20240605;
        b=Db7BJDWXwjCC4JHIDWAVGWanOhxCtj7vuEiMOCUj3zhHVtJVtoo491Nnw3HmDRBEo4
         9TXGXz1X6LAEzB8ZhVg+9bisIjDW3b54RbILqv4W5aCFKbos5KCXs20jcHktV54cZ3MF
         S6oJ5p9Uemkg4hn0wCvZe8CB8LeOtY+4+tGCroRsQgIQr6geuTgreoEanpURSdHgwJX3
         ZS20jM+3c1wxgam7/xPMQSuDADZD4WgfRZr4mNq/GKO6ZGg0bDS0gF0+Q9ZpJQbPtjsl
         +JGzPe/+OLrw8YKS+DrF2l7HUa9yWyWYDIzNAJzjQLqR5xs7TGBYNtL002uFdo5VJTfj
         7Plw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=61AfB4CK9E2VjhLBr9aTYVZm7rk/i+X9V5DpN1B+xIk=;
        fh=xaxYIZZAA7/rWfEtkuKdEaGj6wxLkwaFEJviDJDCjBA=;
        b=a+1b+z32vU6qeogsYQ8SlkiSEMzCA3kTFdQ70E2ijhxMEEd1pY2D2VNGWX0pMNnyCN
         gnf6LT6CpGpbgwem2LAjaBB8W7vx768KJo1iPAsyvHndz0UNiR3R3EvHcOOw3aOxPaHN
         Tz8wchqUl281yP6QjFYhHbH2Xa0JjwMZCwVjAjZsK8yQOurRDKWwftG2m9DtMlTzUMS+
         p2IlyycZdSlb9Is4ht5LxE6KLgkkewRILEQLN1u14EKvFoLMjRhDF5/yaUV2M9A34wN9
         qzBzEpsKwwJSrh9L+JlLcOKZIxFa7Hs+6hZDqeJ/T/tqsxTNxlfrAyy6uvUQzrLgf5n9
         fNnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772716037; x=1773320837; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61AfB4CK9E2VjhLBr9aTYVZm7rk/i+X9V5DpN1B+xIk=;
        b=N5fi2xQlXLp9oloDQJssmEj52Mr4+2hxtI7sm0rofOQDf9lrDjS4IyZ9GWqkdb7Mle
         1uLB6FX6YOz+n9NqQOwoecDtHNdant6UUIh1yQLsOsrN48hvkPhqNfS4sBqSnf69LSXL
         0VJp6PexXRFi6pV4ZvfEH3LRoYEEXxd0NgCd30QLF+++wKZyIjRLC9MchmSICrvfTv3G
         GdzUc87ttWcTwNptXtNn0ozioTkWzra8LaGICAF1n5EUu9iZgJRx9MVEE19+FsUt+/VL
         ZhUu10htRELKck7dJxZkkY3cndwxMIx2+/ywQ1f8KUCR30WHR2rQ8+4n+0Fly4LzBLSh
         AJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772716037; x=1773320837;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61AfB4CK9E2VjhLBr9aTYVZm7rk/i+X9V5DpN1B+xIk=;
        b=NGEvkvkKGwgYBgA67RBAyPE0VZQ27PO4Qeb0sugrzxlgjxij1PGlxLtWvpUd9f9MPC
         bJJN9C/e0tgKmwOhwMjhOtQOrxZrr2LU6nxLc4h22jThXfQDNdEvvkUJzWe6yr7nXlfl
         YVPu+cmypKbmeeuMRrrnmDLTpEa8U+nf26RI4qcIWOoc010x17RSjdYzLJokBGzmwB6s
         F9mj6Aq5gift/wFycMYlRnQviB3M8ebr0pD7xsG2eexKMSiQc3roQTvur9WLvdzra3Bf
         VsBXojSAHtzwhoGQ1jjBrnWRTTFu/rgxSs8/uN+4XAcyQStXjKFyxDGWpakgHTzWbrSD
         6K+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7zETEbOf/hUinCtQew/Xw2QC5eB+1lkmmsPpCI745Hg7iOVgxofBT1wwEkO42brtcR6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLUyhLe48fnFG1b4seEZ9hUQiFU/vX+vbfH5rC1dp2H3tC2tv
	en9TvWRtyRYkoTIvVam9jNrah8L62MWUnKOwrmptolh2k6+bbmOSEfi3eALrypS7oVKZIYQQTiF
	2ZQKF77sd9T984EI7rFQanFcpbf1p/wDfI8o2
X-Gm-Gg: ATEYQzx5IRbg8nhCp68uSiOXsG3pSIL1BcT39mxFbtW3nDdwngs2nX5W1pYbSuKCFVE
	Zg9Mir3P2vZUaJ3PLbj05/u5fZyzoQoJp3QBze3eRWEIqESo5eMuYes4nj8sxixfZ2xaKLaJPP0
	Cb6ISEPSGZZpMkWKDpU6FGqCKgvwKfuSceiJAMly0yTi9/k1qLpOqmFbxI2BVmcR3mWn1DMNf2G
	mPm6rEN3bG2b339BNK4i1pnz05GIpu+vSzPqvsrwrpYBs2JaaBAs8uhqWR+QNqukGGvjn5UcgDN
	13rClNV/r2mg+bH2LKalg8WVT5I32No1aamI4p216g==
X-Received: by 2002:a05:6102:cd2:b0:5fc:2b29:b005 with SMTP id
 ada2fe7eead31-5ffaaf469b2mr2430458137.24.1772716036723; Thu, 05 Mar 2026
 05:07:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 13:07:15 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Mar 2026 13:07:15 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-11-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im> <20260223-b4-pks-odb-source-pluggable-v1-11-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Mar 2026 13:07:15 +0000
X-Gm-Features: AaiRm52R3vtDI5m_O4NN_RIgdOZMNP6VPKp8yxx_kTCmjuj1gEu4pkuicpy4tZM
Message-ID: <CAOLa=ZS9ODS1EdZMDW7aRjp+9yk1E0mW15wabPNzTmBxOtwOgQ@mail.gmail.com>
Subject: Re: [PATCH 11/17] odb/source: make `for_each_object()` function pluggable
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a83b56064c469d95"

--000000000000a83b56064c469d95
Content-Type: text/plain; charset="UTF-8"

[snip]

> diff --git a/odb/source.h b/odb/source.h
> index edb425fdef..35aa78e140 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -53,6 +53,18 @@ struct object_id;
>  struct object_info;
>  struct odb_read_stream;
>
> +/*
> + * A callback function that can be used to iterate through objects. If given,
> + * the optional `oi` parameter will be populated the same as if you would call
> + * `odb_read_object_info()`.
> + *
> + * Returning a non-zero error code will cause iteration to abort. The error
> + * code will be propagated.
> + */
> +typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
> +				      struct object_info *oi,
> +				      void *cb_data);
> +
>  /*
>   * The source is the part of the object database that stores the actual
>   * objects. It thus encapsulates the logic to read and write the specific
> @@ -151,6 +163,27 @@ struct odb_source {
>  	int (*read_object_stream)(struct odb_read_stream **out,
>  				  struct odb_source *source,
>  				  const struct object_id *oid);
> +
> +	/*
> +	 * This callback is expected to iterate over all objects stored in this

This isn't a callback though, this is a function which calls the
callback, right?

> +	 * source and invoke the callback function for each of them. It is
> +	 * valid to yield the same object multiple time. A non-zero exit code
> +	 * from the object callback shall abort iteration.
> +	 *
> +	 * The optional `oi` structure shall be populated similar to how an individual
> +	 * call to `odb_source_read_object_info()` would have behaved. If the caller
> +	 * passes a `NULL` pointer then the object itself shall not be read.
> +	 *

Nit: here and below, we talk about the `oi` structure, but that's in the
callback function, maybe we should clarify that.

> +	 * The callback is expected to return a negative error code in case the
> +	 * iteration has failed to read all objects, 0 otherwise. When the
> +	 * callback function returns a non-zero error code then that error code
> +	 * should be returned.
> +	 */
> +	int (*for_each_object)(struct odb_source *source,
> +			       const struct object_info *request,
> +			       odb_for_each_object_cb cb,
> +			       void *cb_data,
> +			       unsigned flags);
>  };
>
>  /*
> @@ -233,4 +266,30 @@ static inline int odb_source_read_object_stream(struct odb_read_stream **out,
>  	return source->read_object_stream(out, source, oid);
>  }
>
> +/*
> + * Iterate through all objects contained in the given source and invoke the
> + * callback function for each of them. Returning a non-zero code from the
> + * callback function aborts iteration. There is no guarantee that objects
> + * are only iterated over once.
> + *
> + * The optional `oi` structure shall be populated similar to how an individual
> + * call to `odb_source_read_object_info()` would have behaved. If the caller
> + * passes a `NULL` pointer then the object itself shall not be read.
> + *
> + * The flags is a bitfield of `ODB_FOR_EACH_OBJECT_*` flags. Not all flags may
> + * apply to a specific backend, so whether or not they are honored is defined
> + * by the implementation.
> + *
> + * Returns 0 when all objects have been iterated over, a negative error code in
> + * case iteration has failed, or a non-zero value returned from the callback.
> + */
> +static inline int odb_source_for_each_object(struct odb_source *source,
> +					     const struct object_info *request,
> +					     odb_for_each_object_cb cb,
> +					     void *cb_data,
> +					     unsigned flags)
> +{
> +	return source->for_each_object(source, request, cb, cb_data, flags);
> +}
> +
>  #endif
>
> --
> 2.53.0.536.g309c995771.dirty

--000000000000a83b56064c469d95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3fe676a4181cd20c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tcGdBSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNU1QQy80a0puSXJxN2MvSlREK3JOR0pCekVHcFJWVgpkS2s0UmVmS0ky
NG01VW5aZGc0RHlTYzdIU1g5MmRWVWRIandSUytlZlY2VkFHb1VuenJXTnA3VGJESkR3SXdhCktU
bXdQcjlGYmkxeVVIbFFYeVVWUzJNOFpMNGRWdzlSbmZOL0NFTEhUdDhHMDRrK3lHTXRzVmNicjJV
TE02ZUwKaGk4Zmw4dVo0UmRzZmdoc3NxaGdJeEFBQ0tMMVVIbm11MmpvVUI0NjJ5UHFWMWhkTWYx
VEY5Wm5pSU5ZMjFLOQpFNXBYM3p0dS92bS9RdkczUjhBVnMxc0h3NjY3UUFNZ2pqSVVWZ1hVNVlK
Nm5zMVJPd1lhWVFEdnBsblU4ZmcvClM5QmRENFhYNGVFeHRYbUpGZW5rR2VOWlBRMjVxd1NuV2xZ
am5ZcTVsZnkyK0Y5SWxLZlZiRFZKakRLeHJablEKM05ZaTZyTUJDK2Rkb1JCbTN1VVdCSnlUSDFS
dmxpMFhGWWFYZUN5c3pPUXVFYWwyVk1kdWZtbmpRcGxFbHpHYQpqdzkxblRTMVJRVHN6UVpjVlJ0
c2JBN0JCMjNSN0RoRWtQY3QzSU1HZDF6SVI1bXllK3UrWEVRekoxdjVQbkdjCitvWks4QVRwT2o2
SWdPZE9rWjFadW9iU2RlYmhpY0tMZjY2bTVsWT0KPXdCWVYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a83b56064c469d95--
