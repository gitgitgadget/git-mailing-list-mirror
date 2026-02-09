Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E03815D8
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770667071; cv=none; b=axbIKjVd1ibeKkTnJNWuOL84ygKDo75WTTIn8jhRncfu2ESvHnDL/jcAuMDoJf94Pvna9toCN28+wvaKI95RcqJT8DGabPAmmFtihQUC3OJ3sjeYjs3MMf5CbythFlsEZkb3Zuvsdt8OvyP+7bvd+f5ii0fZRlh2rC144hZhBSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770667071; c=relaxed/simple;
	bh=/Zrbai8nXBDkKoZDczjA9DdTCOBnSdTTc5NZGAfSNVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/iuuvIe6BZ/wABrwVVDRNIyISep4AGnnDF08Yr40YQiW4lBRitkYKqsDJo4kM8rguPF/xONlDq/E6y+cPO7xbIkvGSm5sT8Vx1Qjb1jtZQbkxmoymTl4JSyZkaTYv6ARgVKEcUx8Y0VylgCzP8Iw7sBe8W3sdjQwMqIKgUhIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJvgb6Yq; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJvgb6Yq"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-4044854464fso2990970fac.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 11:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770667070; x=1771271870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8++GIw3syBJT2Z/R+7tW9U4mj9Jv4RMZTyA3kcs1iQk=;
        b=DJvgb6Yq+gcSFCGBqbU8nVgIEtQISkbvint83xr6RL4dmFcwzHgrg5LF296ypdQPLu
         qX4fjMkunhlK109vbssY+oj7ZREe1yGPHPYmuAK95hO8KZ/Cp9DUlPHwYPOC0CA9aFy7
         nGslnAPcqrjpz9HQFatqAHYvHBlh1KCvFkt8XoxKLvnTIlRG8bJkuYHvRGtc/KCvBJcR
         Gs6DR5b+cCLVIg30Ioc/uZI+3r9Be/FllAy2kD+qC8qyXKe63HePfoRUevOXtU809u6l
         wj6ycH37YOjN7JhaNYBcnGT3DNaHm6mx2GDreZdmJGZajZVuEdeB8YfwuCS4QAgkJYYj
         G+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770667070; x=1771271870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8++GIw3syBJT2Z/R+7tW9U4mj9Jv4RMZTyA3kcs1iQk=;
        b=WSKxCsrQK65hatT2WteI5BA+061VvAQ9/O8LYA48uudo8KgElh/zmnkGqOypurSwax
         mUJTphijXAywIfUCFylBOkE8P382SRSeYCAhd0kfW5jNistlawscxbyjiBbm9As2BUzZ
         gr8fF5ZAGvwWEuURMCkWXDfX/BivO2vuQXZ8HI0IspFkUnm3D5QlP0rgRQasBaC4FtOg
         qCExnZDGpU4/NUXZtXIPzX24YPlVnTGkLQmNn64PCMpki3MBpa41ToCvtCU6NBkc89Xp
         Shh2F373mP5Ydi76nlk6bXS0xdVsIm/IVcHvFRfv6Tnx/5JdHzWzZaRltFCIVAC4Asn5
         idwA==
X-Gm-Message-State: AOJu0Yx6UgxClB7y0UIqXSouGc7sCBaxys0X6aTu29kJ16+FZqd3Byly
	DqtEqkhog/+QUEqDytJbvSgW2osUlfNWx24n88hgqpshOov/DCjugQVATIUtH4Rl
X-Gm-Gg: AZuq6aIKyv4ErhlHt5H325hjsAsah5lAy9qtNb8GERV7IbZRYAyp00ixqRQs4Og3fWh
	0I04LVwuP6ApfaSb2WzWbxOvkYO4khU+eqNwcUhOUM6615ijH1/YzEDDwQ/hKS7y9XKF8ew7hIV
	kVPV0pHHZHdoCt7XeWo8fmbYu61ITNMxTyAOk6aLfvj43gOwy6envliQC/+2b6wI4hUIfWsflQS
	tc0CuIFog/1YwFRpTaBrOxTo3+6KhQEF2D1oLgfZeNS9M9tpDNV54+Jphq/SKiKRgkw9oE/6RXs
	qfUFQ6t/TxEmSiQdnA1HFsDuVVN9dmEW87JOenSElnHLC6Uk6sp9cXf1k2uBf30cBY/+pk6vZK3
	fwCwEGoE2AUI/ZCyJPZ7o59R4nuzVS2MhqZOUDMDnNUBL+P/8d4Dq9XOIfXAZ00Au04CkHfW1Co
	t+5ZqH
X-Received: by 2002:a05:6870:d28f:b0:3f5:694f:9366 with SMTP id 586e51a60fabf-40a97779e73mr6914240fac.30.1770667069696;
        Mon, 09 Feb 2026 11:57:49 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a992ede02sm7747318fac.4.2026.02.09.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 11:57:47 -0800 (PST)
Date: Mon, 9 Feb 2026 13:57:44 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] builtin/backfill: fix flags passed to
 `odb_has_object()`
Message-ID: <aYo5M7YLqroH4fab@denethor>
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
 <20260126-b4-pks-read-object-info-flags-v1-1-e682a003b17c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-b4-pks-read-object-info-flags-v1-1-e682a003b17c@pks.im>

On 26/01/26 01:17PM, Patrick Steinhardt wrote:
> The function `fill_missing_blobs()` receives an array of object IDs and
> verifies for each of them whether the corresponding object exists. If it
> doesn't exist, we add it to a set of objects and then batch-fetch all of
> the objects at once.
> 
> The check for whether or not we already have the object is broken
> though: we pass `OBJECT_INFO_FOR_PREFETCH`, but `odb_has_object()`
> expects us to pass `HAS_OBJECT_*` flags.

Ok so the flag we are passing to `odb_has_object()` here is not from the
expected set.

> The flag expands to:
> 
>   - `OBJECT_INFO_QUICK`, which asks the object database to not reprepare
>     in case the object wasn't found. This makes sense, as we'd otherwise
>     reprepare the object database as many times as we have missing
>     objects.
> 
>   - `OBJECT_INFO_SKIP_FETCH_OBJECT`, which asks the object database to
>     not fetch the object in case it's missing. Again, this makes sense,
>     as we want to batch-fetch the objects.
> 
> This shows that we indeed want the equivalent of this flag, but of
> course represented as `HAS_OBJECT_*` flags.
> 
> Luckily, the code is already working correctly. The `OBJECT_INFO` flag
> expands to `(1 << 3) | (1 << 4)`, none of which are valid `HAS_OBJECT`
> flags. And if no flags are passed, `odb_has_object()` ends up calling
> `odb_read_object_info_extended()` with exactly the above two flags that
> we wanted to set in the first place.

Lucky indeed.

> Of course, this is pure luck, and this can break any moment. So let's
> fix this and correct the code to not pass any flags at all.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/backfill.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index e80fc1b694..d8cb3b0eba 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -67,8 +67,7 @@ static int fill_missing_blobs(const char *path UNUSED,
>  		return 0;
>  
>  	for (size_t i = 0; i < list->nr; i++) {
> -		if (!odb_has_object(ctx->repo->objects, &list->oid[i],
> -				    OBJECT_INFO_FOR_PREFETCH))
> +		if (!odb_has_object(ctx->repo->objects, &list->oid[i], 0))

By passing 0 as the flag value here, the underlying
`odb_read_object_info_extended()` gets both the `OBJECT_INFO_QUICK` and
`OBJECT_INFO_SKIP_FETCH_OBJECT` flags set. This is exactly what we want
so there is no need to add an additional `HAS_OBJECT_*` flag. Looks
good.

-Justin
