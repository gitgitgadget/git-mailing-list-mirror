Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B96217F4C
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892023; cv=none; b=qD78ao9y/3uMs4zCwR7z5bcjnjyoJsYjwIXsGG1QyPkicSMvLgxc0uuue5IjANlGzdYZsrMfJ93oDkTXH+8JNhRXnIQSx6KUzQ7lIi6bcp+HpeIxqw5OugR25kkghnYaVr5kF9d6ikgNAT0F4B2Ovl+T0H6Qy0zCqVij9+DlMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892023; c=relaxed/simple;
	bh=iMcCtohqgJr3y9VVjaj13pw6eNr7SFLkdcLnp9PH2Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/X+vwJDi9OV1sZ+bPfOcltAud6cHXlBSRPnxYAOy035He1eUkbSkUX/GlQawzMYv9MNOVGcV2La+7IL/+jOvWl98NjICrqwzrMFBUygagRi5m2rZmbQiTc3yVryTtSHENcX/n+2Sn6ufg02YAePlt7tnSjJNA0zCZNhZizLtJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MueBnHK7; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MueBnHK7"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e5b7cd1ef5so24499617b3.1
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 14:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729892021; x=1730496821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKV6ZKqIWJgtZAYSwbctNwT0fBO49XGgaoeNMcJzKD0=;
        b=MueBnHK7t3k6oJPpzI4c+wGWLUWEQBxsdnIdf+dqp9+0c4LLV4drQY24OtC9RxMdjG
         NYCD2qtcwZU+obM5KiYofVrDluu1GuIfIX1+oix3gnVCnbl6P8WeAo+ce2NNonCrkbP+
         AWbie+mbkEQuWSQ7XWq+g+7z2UczVemzJOQmJB1eOi1z/TNBO3TPT7g2c4dLwLvJ69kx
         2xbidTeL4BnwdKi3TwWypxTKW0B+dGfCYTcr1OvRCL3+ql4C/vajRgg+qdEw426W9B1c
         OJx2ZQeZOzlRm15zSISoBiuyuyPnl16LBuelsgKM8qFppu8CZncwLX3Ib+UwfqbuI6GP
         jnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729892021; x=1730496821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKV6ZKqIWJgtZAYSwbctNwT0fBO49XGgaoeNMcJzKD0=;
        b=joyjeMh0lVO4W+7bvf9uFrU+8QReqkB7un1R20d0JKxPkQIV1zA1nfWMjIrOxvH7ai
         R1vJCs1Mhv0z3El5Z6A2PufraMFU3dlaNWkLaxGs8OMOT+gA3apK9Bu8xnDouoBauCQC
         3rIhRkZgZuMUy9vxEnDksvrB+4gRWyO3WA3jE38lXbEaFl1JFhSN8+3uT01AoFIdAzdw
         7gnbfJs1/BuYi72sXvJYx1NBsQv6v/6hAUzck8Gw0fqKySmN8uSkgTy9oot4Ubzwqfr/
         S7TvaaF3IQ3pqDZODw+qIta9PKQVVAFhpvTpi7zA1GcpXpepMY4y5MTXDP/00Ctt1mPa
         NKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVImNhZZJdBVmpwJk/cG2Yp5UA0OcjuAXBg8z3ftBUQ2VudJrykM01QZ9Z1XgDjeAh+lbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGaO7qqzNskAXGUMt/UwhIWZNece60Z123HHB50kFShfrSovA2
	yALk855j/TBH85mlKPoWwZf2uxg0GmXefp0CSvD5OKUioAKA3l6WeTLPmYMgM9Y=
X-Google-Smtp-Source: AGHT+IG0xRGL5hqDtS20bm7D7Hmh4IQblO8/ESYTBsmpD0JAtufq26Hmi5fw1f9Utx8KiSdFEGbCsQ==
X-Received: by 2002:a05:690c:4b09:b0:6e3:b6c:d114 with SMTP id 00721157ae682-6e9d8ad309bmr12773717b3.38.1729892020743;
        Fri, 25 Oct 2024 14:33:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c19665sm4396327b3.67.2024.10.25.14.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:33:40 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:33:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 10/11] packfile: use object_id in find_pack_entry_one()
Message-ID: <ZxwOs23zYByRmMap@nand.local>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
 <20241025070606.GJ2110355@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025070606.GJ2110355@coredump.intra.peff.net>

On Fri, Oct 25, 2024 at 03:06:06AM -0400, Jeff King wrote:
> The one exception is get_delta_base() in packfile.c, when we are chasing
> a REF_DELTA from inside the pack (and thus we have a pointer directly to
> the mmap'd pack memory, not a struct). We can just bump the hashcpy()
> from inside find_pack_entry_one() to this one caller that needs it.

Makes sense.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 0fc0680b40..0800714267 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1556,7 +1556,7 @@ static int want_object_in_pack_one(struct packed_git *p,
>  	if (p == *found_pack)
>  		offset = *found_offset;
>  	else
> -		offset = find_pack_entry_one(oid->hash, p);
> +		offset = find_pack_entry_one(oid, p);

This and all of the similar changes that follow it are trivially correct
and pleasing to read.

> diff --git a/packfile.c b/packfile.c
> index c51eab15a5..005ca670b4 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1239,7 +1239,9 @@ off_t get_delta_base(struct packed_git *p,
>  		*curpos += used;
>  	} else if (type == OBJ_REF_DELTA) {
>  		/* The base entry _must_ be in the same pack */
> -		base_offset = find_pack_entry_one(base_info, p);
> +		struct object_id oid;
> +		hashcpy(oid.hash, base_info, the_repository->hash_algo);
> +		base_offset = find_pack_entry_one(&oid, p);

Here's the one that needed to turn its bare hash into an object_id that
it can pass a pointer to. And...

> @@ -1971,20 +1973,18 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
>  	}
>  }
>
> -off_t find_pack_entry_one(const unsigned char *sha1,
> -				  struct packed_git *p)
> +off_t find_pack_entry_one(const struct object_id *oid,
> +			  struct packed_git *p)
>  {
>  	const unsigned char *index = p->index_data;
> -	struct object_id oid;
>  	uint32_t result;
>
>  	if (!index) {
>  		if (open_pack_index(p))
>  			return 0;
>  	}
>
> -	hashcpy(oid.hash, sha1, the_repository->hash_algo);

...here's the original location of that hashcpy() that moved to its only
useful caller in get_delta_base(). Makes sense.

The remaining conversions are trivial.

Thanks,
Taylor
