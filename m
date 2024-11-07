Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C6B192B73
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731021193; cv=none; b=mmtH1VUSclxhb8aMy4ruAcWYI+DFURPxyjUgtGsxgO045L+b0+tliCt0yd3837HIa8OItKktI8Crvb4m+Gm/yIvHEvbH6GCiYHjH8/ROyM8XCUxm9y9xT3lb1P4OwxkNosyrbvxLZJyqmbbZUpsxGHKWvAjZWTeKmcQkG/5lrgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731021193; c=relaxed/simple;
	bh=MV1mMKJTW9yHW/paIByqteb1bxAw26eDQseocUG6i0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYz4oVxjaNBjhgdpETD1OgP8U5ffdhZN5XYzCVdYLjlaE8eB99EzvayuX+LyYijzrRu0eCJ8w8keNhkS2S3NrJmMcbtIa/ugdcq4feb+EntP+w7YHZwf+DfkpqBpOEIfP5KXhmctXkpVQMV9LoqRdBYKNlHcIXUTnEGpw/x4W+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXSsYP7Y; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXSsYP7Y"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7180e07185bso754104a34.3
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 15:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731021191; x=1731625991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6MScF8g9nELwUhuWVGDB/2C4fP6vAdh4m0w2ClFNqZI=;
        b=NXSsYP7YYDnaNMyvMXgav1s4apj//wVz+N4+XUsYJr9gy97/cW/JlnaFrPpM3EDbFB
         dawn13iykDugcM0F1z6gO8PaVuuAvfWOTLonqRYnkjTBIgeLXc0jwlq+yFJ3XutEDj3l
         heRhxAcvmBXcsj3xvuYgoWbnhXiqoSSce8d7EQ+R/D0vVReR77wYRbo4VGEl1tiPUceP
         RqE7ojLX9B2lTek4R3h1hDxpjWxMPDE3WsS+/cGHfOSjugbKvw0zhnml3hJupKg4mMZR
         GLugLgjFO9mtfXsvRpebGwSzeIynheVm3YMgUUghy35EXiQc2N33lS1jB7q127/X0T+v
         Swkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731021191; x=1731625991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MScF8g9nELwUhuWVGDB/2C4fP6vAdh4m0w2ClFNqZI=;
        b=dTQhXnHtJoCG21xX6DCdDUMWV1kr7IbJFlNq+xeXESN9TT+qyeliNENHGfYJEqUY5b
         EaNtg/79VHNMDvGjlpniWwDITvAwyW0t8T34wkHZyoRP2ZUxyqTc75rRg4PKLz3n65u4
         9cBgW+1U+1xlsDJuCpo6h4uTb/DwXqSKwr2iKMs7Fxc4uQnU8RUcMSchuR2f4QC2lqGj
         fSgGSjXx9ZWqUrtIv2r6QS30cJ+mqUKWtE5P04OCdP3PgEDKYkKiRSl01Dba4NtVs1vz
         pf661YAek19/J7mdGGvx1YQIFuhnCi6bAzh98CTXucPt05bsbUV/hCh9TsDcQO1Iq7V2
         wlHw==
X-Gm-Message-State: AOJu0Yw7SUjqwHOVbvKbq/SoR96oK/FNOLKbls/WhQ/+ei8arW+BgXiz
	AxjTE9q37mCQFOHv9kdINDAX51warwQWDoleIQubMhavv82lDhOezjlRIQ==
X-Google-Smtp-Source: AGHT+IEBpmY34u0VS8OMi4n3X8NGMWmkWPFSHuA/R3ILZh38Qg5FlSQE+hTjvL2cKE03BYFvwCNZhg==
X-Received: by 2002:a05:6830:6389:b0:710:fa7e:e002 with SMTP id 46e09a7af769-71a1c1cfedemr1065252a34.5.1731021190753;
        Thu, 07 Nov 2024 15:13:10 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a1080ec9csm511353a34.19.2024.11.07.15.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:13:10 -0800 (PST)
Date: Thu, 7 Nov 2024 17:11:28 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH 2/7] reftable: explicitly handle hash format IDs
Message-ID: <yvdvlf45g4ahqa3uey4zj4evissv2tfkwiy5o3e3vbqtwmc7o4@utqagwvv6yhe>
References: <cover.1729677003.git.ps@pks.im>
 <c1bd8e2b3c4c524a21f68e822812e41179827e4d.1729677003.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1bd8e2b3c4c524a21f68e822812e41179827e4d.1729677003.git.ps@pks.im>

On 24/10/23 11:55AM, Patrick Steinhardt wrote:
> diff --git a/reftable/basics.h b/reftable/basics.h
> index 7aa46d7c30d..86141602e74 100644
> --- a/reftable/basics.h
> +++ b/reftable/basics.h
> @@ -150,4 +150,11 @@ int common_prefix_size(struct reftable_buf *a, struct reftable_buf *b);
>  
>  int hash_size(uint32_t id);
>  
> +/*
> + * Format IDs that identify the hash function used by a reftable. Note that
> + * these constants end up on disk and thus mustn't change.
> + */
> +#define REFTABLE_FORMAT_ID_SHA1   ((uint32_t) 0x73686131)
> +#define REFTABLE_FORMAT_ID_SHA256 ((uint32_t) 0x73323536)

This context is provided in the comments for `GIT_*_FORMAT_ID`, but now
that they being decoupled it might be nice to mention here that they
stand for "sha1" and "s256" respectively.

> +
>  #endif
> diff --git a/reftable/reader.c b/reftable/reader.c
> index 90dc950b577..64eb6938efe 100644
> --- a/reftable/reader.c
> +++ b/reftable/reader.c
> @@ -109,16 +109,18 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
>  	if (r->version == 1) {
>  		r->hash_id = GIT_SHA1_FORMAT_ID;
>  	} else {
> -		r->hash_id = get_be32(f);
> -		switch (r->hash_id) {
> -		case GIT_SHA1_FORMAT_ID:
> +		switch (get_be32(f)) {
> +		case REFTABLE_FORMAT_ID_SHA1:
> +			r->hash_id = GIT_SHA1_FORMAT_ID;
>  			break;
> -		case GIT_SHA256_FORMAT_ID:
> +		case REFTABLE_FORMAT_ID_SHA256:
> +			r->hash_id = GIT_SHA256_FORMAT_ID;
>  			break;
>  		default:
>  			err = REFTABLE_FORMAT_ERROR;
>  			goto done;
>  		}

Instead of directly mapping `hash_id` to `GIT_*_FORMAT_ID`, we use the
newly defined constants to map to the corresponding format. As an
internal identifier, the format ID can now be freely changed without
risk of affecting how on-disk reftable headers are parsed. Makes sense
to me and seems like a good change.

-Justin
