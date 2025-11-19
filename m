Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1029B8E5
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763578874; cv=none; b=FnUccYt6aEDA0rKapaGQtteZT+0iASVU0buzyvAELRlfKPD+yvn14/+gpNlRSqZIod+6G/LA/u0n+6y8nj8Hj5bmZb5R7ETj77LDjeNA7zjToltzPAR3cr7r/RheV/NBEim6wh9S5QourbXzY1eXzi0IyDFb15+IOO46+lGSyRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763578874; c=relaxed/simple;
	bh=PJDXta8LO7QVHG23Var4vMVytndAcjzLVaGoui4rL5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn4aZq8EH12HhpLINvmI671GIVMm88i12HP4OkB6ipTvb2E+hYjMlwxheTjjs/ZxBY8uUBbuWEjvcr29y7fStd8wQFTpBBgQ/7/7U33qCxb+WHIyDkjt3pRgGf+1FTnZtLvsFqYKs9c/CNFPidm4M6RafjzXfsRlXYIy1sBfnM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsnwariI; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsnwariI"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c75dd36b1bso37339a34.2
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 11:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763578867; x=1764183667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsXd/Si6Y89tflHPFmNGjnc0cyZ66r3RPqhFZsJwykA=;
        b=lsnwariIeOhsZrgwE9nERtQU9V6mHNJDwdsaweSKKJ1oenYRQIUDHBM6gJlt/ajYsL
         k/3cvMjOfSVy9KT3N/MABP+G4mLrdWTwglPxkr8pxsGPHyeRjB8ZPjOVSnaFQSFs5KmP
         0LVxubg9zR6VAPLbuk4uGfXTqgm1yqlt8t5LuGoEW+a1+z0pgUMHkxyW6KgwUg+3Vs6f
         hMUIaazBcWYOU8gHvou9TTS7ALikE0HH/i8UZxP1bPl8Sr6ZeG9j5fDk2JL4Nyqo975/
         eSbts1YnoM0Mflq9+PjWMWkGcRl1QTxGxXx6ITiTcUSk8MPRpVaM983cojzGrfKcd/H+
         px6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763578867; x=1764183667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsXd/Si6Y89tflHPFmNGjnc0cyZ66r3RPqhFZsJwykA=;
        b=nFOBSZhZpolNC2fR4ZNVDdSAlLTxUdKu6W6homY9yNxMmqUMV2yQsJhyToUgp1dZhl
         sj/yoj/2JsHZud3QabWPiLWhO+TwzfEnwSKZZ2Mtwoq3+VqEyLoslfUO9in33pwIIpO5
         popJoAACJjHVp7Lb3z2lpO3t9epqXKULKYNZgprbTg5YafSaHoaTSvPdnfBlGAHvV4/N
         uChtJ6eywXgXhT4V5iQoaWEyaxPY+MO2BvqDFVUbtwQW8yqlLiKC2epVO2v8jjAdOhQV
         6OaAzYBoJbTHEdbNRko5oPdO9rttzRWnQv+gmozRXaiESuIthwP4uX7au7/4cQ7LEXri
         WSZA==
X-Gm-Message-State: AOJu0Yy5VLnxNGfxmzNxzBQDdIkQu7lcPxRmJDfo8BDNyZfLRjHK4q4Q
	mTEf8Utoa67pDdxXXdNZ0oaa9bypHbILMS+ZcRYtFQLFxmh3bYtMGZur4f/2sQ==
X-Gm-Gg: ASbGncsYmREatSXSVZ6wDnt/nI62oiLJNsdRbYNfd7x/iU2qK1sBbFTYplCS0a85a3f
	NfQiDjSKXoRb3S93XIclBpRj3H6xrCfUuJiKQcf1mgL6GlSicwvqMFFqCITu89M9BuKk/R3x9h3
	2Gjk7F55PNllFBUFn9Bk0WE1ic8UEbwOXxIHg27u2bByU+Nkn85KGGm+REX25Cyy5sKAc4Fo4vd
	3jj/y6IpO1kVDIl6iMs6jsRcRFjVUmkJ6MedgliBHp8UF5+u/ngQdZOe/cPVqksWAeW9WhsMl6t
	3m6ajYjmOIBSQK6F4tiBTIrunx3NWjkOOUM7cOUn/+qlcLiPv1oEGs9dmkeeywYv9UlAgIQ6N5T
	h2xnyi8Vffmx776qaFlZ1jYtp/gktcz9IaIvG8UrjVtzq1JkGdXTLrR3AlveHnz83gWvT0YbXtf
	SvWEzWAbEX4tX9ceY=
X-Google-Smtp-Source: AGHT+IHJr93ndQltqwKN9PdzWo4R42901Ir7+EsFr+KtJTjxqtgNydMtbwr98M60a1CQ2nWSzwmeIQ==
X-Received: by 2002:a05:6830:25cd:b0:79c:f9ff:43e with SMTP id 46e09a7af769-7c78d2e108emr174673a34.28.1763578866210;
        Wed, 19 Nov 2025 11:01:06 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d305d2csm102040a34.1.2025.11.19.11.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:01:05 -0800 (PST)
Date: Wed, 19 Nov 2025 13:01:03 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/18] streaming: drop the `open()` callback function
Message-ID: <g74hupkwedtclb3gxomhxj6w4rqqzn3tsostdriauvn3gu2cw2@wxgwulitxbtq>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
 <20251119-b4-pks-odb-read-stream-v1-2-adacf03c2ccf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-2-adacf03c2ccf@pks.im>

On 25/11/19 08:47AM, Patrick Steinhardt wrote:
> When creating a read stream we first populate the structure with the
> open callback function and then subsequently call the function. This
> layout is somewhat weird though:
> 
>   - The structure needs to be allocated and partially populated with the
>     open function before we can properly initialize it.
> 
>   - We never use the `open()` callback after having opened it initially.
> 
> Especially the first point creates a problem for us. In subsequent
> commits we'll want to fully move construction of the read source into
> the respective object sources. E.g., the loose object source will be the
> one that is responsible for creating the structure. But this creates a
> problem: if we first need to create the structure so that we can call
> the source-specific callback we cannot fully handle creation of the
> structure in the source itself.
> 
> We could of course work around that and have the loose object source
> create the structure and populate it's `open()` callback, only. But

s/it's/its/

> this doesn't really buy us anything due to the second bullet point
> above.
> 
> Instead, drop the callback entirely and refactor `istream_source()` so
> that we open the streams immediately. This unblocks a subsequent step,
> where we'll also start to allocate the structure in the source-specific
> logic.

Out of curiousity, is there any reason we would ever want to delay
opening the source read stream? If not, then I agree it makes more sense
to just open the stream at time of its initialization.

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  streaming.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/streaming.c b/streaming.c
> index 1fb4b7c1c0..5ce6350123 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -14,10 +14,6 @@
>  #include "replace-object.h"
>  #include "packfile.h"
>  
> -typedef int (*open_istream_fn)(struct odb_read_stream *,
> -			       struct repository *,
> -			       const struct object_id *,
> -			       enum object_type *);
>  typedef int (*close_istream_fn)(struct odb_read_stream *);
>  typedef ssize_t (*read_istream_fn)(struct odb_read_stream *, char *, size_t);
>  
> @@ -34,7 +30,6 @@ struct filtered_istream {
>  };
>  
>  struct odb_read_stream {
> -	open_istream_fn open;
>  	close_istream_fn close;
>  	read_istream_fn read;
>  
> @@ -437,21 +432,25 @@ static int istream_source(struct odb_read_stream *st,
>  
>  	switch (oi.whence) {
>  	case OI_LOOSE:
> -		st->open = open_istream_loose;
> +		if (open_istream_loose(st, r, oid, type) < 0)
> +			break;

Previously, if an error happened when executing the callback,
`open_istream_incore()` would be invoked as a fallback. Now we handle
that here during initialization by breaking early. This preserves the
original behavior. Makes sense. 

>  		return 0;
>  	case OI_PACKED:
> -		if (!oi.u.packed.is_delta &&
> -		    repo_settings_get_big_file_threshold(the_repository) < size) {
> -			st->u.in_pack.pack = oi.u.packed.pack;
> -			st->u.in_pack.pos = oi.u.packed.offset;
> -			st->open = open_istream_pack_non_delta;
> -			return 0;
> -		}
> -		/* fallthru */
> -	default:
> -		st->open = open_istream_incore;
> +		if (oi.u.packed.is_delta ||
> +		    repo_settings_get_big_file_threshold(the_repository) >= size)
> +			break;
> +
> +		st->u.in_pack.pack = oi.u.packed.pack;
> +		st->u.in_pack.pos = oi.u.packed.offset;
> +		if (open_istream_pack_non_delta(st, r, oid, type) < 0)
> +			break;
> +
>  		return 0;
> +	default:
> +		break;
>  	}
> +
> +	return open_istream_incore(st, r, oid, type);
>  }
>  
>  /****************************************************************
> @@ -478,19 +477,14 @@ struct odb_read_stream *open_istream(struct repository *r,
>  {
>  	struct odb_read_stream *st = xmalloc(sizeof(*st));
>  	const struct object_id *real = lookup_replace_object(r, oid);
> -	int ret = istream_source(st, r, real, type);
> +	int ret;
>  
> +	ret = istream_source(st, r, real, type);
>  	if (ret) {
>  		free(st);
>  		return NULL;
>  	}
>  
> -	if (st->open(st, r, real, type)) {
> -		if (open_istream_incore(st, r, real, type)) {
> -			free(st);
> -			return NULL;
> -		}
> -	}

Now that opening the read stream in handled during initialization, we
can drop the explicit call to the open callback.

-Justin
