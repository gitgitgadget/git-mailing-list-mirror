Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC826299
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835791; cv=none; b=uJzmPFtTpJ+btWk5GnMoEOlNgSjPdyS+3fo/Av+WACL85gYhMoSNGAA47Qo+RpT6AX44bEsQXHsOLibGFtgeucfqW94ASSNlXx1Mu+wXvLqYSzDNOQ4qYGABgV1PGT2Y9Wibjke108ITue6CMG3Uzk/Mx7D++HcxeHpUTsHNo2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835791; c=relaxed/simple;
	bh=fqFb6UAVv+9VVLXv4L/g3zU94GSX6GRD5NXA7B/Fshs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFMqp4D2MPSCkDYrRVnOr6+uJcKEaSYvKFfD4jPyTQmCXNDm0kb8ebJgeVJr8MISYZm58jg+ip8jbt36WKObVccVQHn1fiYh43u4jUCr8h8hHK7OP4M7GWCfB8BXhtaHR5xRdISd2PwHEqckaoGE0iQ09Mi2nkElNut7OjSJW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBOhQDiU; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBOhQDiU"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3f0cbfae787so1882417fac.3
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 13:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765835789; x=1766440589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCZt4GycOEEERN/4uRHMjkkPa8t8dvUjEs3oC0patMw=;
        b=hBOhQDiUKRFpo7zYHHm27t0HsuWcrO6tZ0qHmNC48iR7ktOfynAIfv/RblFEORVNMR
         shxhwcdOYYB1okpc7OvW6ETjf43F3et+/BIyWx0jfFLBFyMqzcCtvgphFWNTwjQrlgal
         qt5UwgYSF07NiJ5LKZiGdc/vzA2BCVLrVaNNeAbV7xlepCBD8+pHXdpsCNLWTHBYnRQy
         PZP31uW9Bvv/SDbw+0UyB8hXHWSko42VNgTBpj0nXnaNKYHCxhveCHRtY8dIgdDYsbwm
         BH4eSzMC1IrohMNO/lIQTzm0ZSoxxhlV7ycM1Kw18Kh5zRSE1lb461Y+hqD5oVrGo7ij
         EfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765835789; x=1766440589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCZt4GycOEEERN/4uRHMjkkPa8t8dvUjEs3oC0patMw=;
        b=VJQNWBRhOhF5dbUxd22ia734/5nOLHce9dkpNzsZhyx20RWMbjLi8VbGWQQ/vsgoHB
         XgorkOgnsL774r5O0EA4mjLNNtCneEOEQaYpAh4MNcB0owAfcFkmmyxDEafefJ5/Gh3j
         4q+Mu6FgpjatAw6jgxuUg3fgCLYVw6X8ObsYzBHq6hecuzw/64fcNMsh/vlWf1/MKDCR
         kSL9098sRDAPNkTyKQV+C1/T0SbdjzCUeWNxpLGBtwYD4vV0R9JtMhRUQanPD4dHDAOi
         N/O9dxIAIql7Tety7HwpOrHJ1GsbxA6Nk5D/oSCRT+tBBwsmqR2ok0D3K8m71UER/nbj
         MF4Q==
X-Gm-Message-State: AOJu0YxWy50c4iztExLsLDuXZsXQaI7qEalja90paH+tPdvnxpeuOpsO
	khe5a0PSB4D+QZ/yw1XuD9lbOtDrXkt3qmP0tl2AQ+AwECucEWk5LzK+4R6WeA==
X-Gm-Gg: AY/fxX5IciUTI794HGsOhLxePQ+0MftYUlrymMJWmzbBL8M6Iy+1JBb79nsgkELP/zH
	kHhPwJg78gJHEdcXcBDAzdgW6R4PwBXpAOdogEs17UNGy2ZuxHO+vGlN4gW9weewYG2DgnENExg
	a8uaWQOiDlAOaD29dHxoU+4Rbu4pj/f1czyC/guT4IAgF5rJCjYnYrP831p7pRcJU00r9WbVK/b
	hzZEKhK3tpsQ9Rd63Dxh7OAnzUGOV6209mDAAJ8kaLzeadAGHYXXPg2NDUrw6NKIlR9LKis/PrM
	/Jg0Dfbw2HoBiu/2MVQP4NOrM9+xDha3VA0lwfU3NvLyillDAsLgXI9MCZ7KZXzVo5CqV9ePBRK
	b/ji45OlKXvGVlj6rHod+YUDKBcGTVFj65viviWlToSCUAkGkvstGc0u+S0OVfwz1ylEkPIpOer
	4bL1mQ
X-Google-Smtp-Source: AGHT+IFeW06E8pI7UDjAy5hUoVjdB9OBHWEcm1rMGtZtRwput/owFpg+oPfpOCIkweKhhiQkEZ3XOw==
X-Received: by 2002:a05:6820:6acf:b0:65b:257b:a898 with SMTP id 006d021491bc7-65b455ff127mr4717916eaf.29.1765835789118;
        Mon, 15 Dec 2025 13:56:29 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b35f2b1e5sm8486313eaf.3.2025.12.15.13.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 13:56:28 -0800 (PST)
Date: Mon, 15 Dec 2025 15:56:25 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/10] packfile: refactor kept-pack cache to work with
 packfile stores
Message-ID: <6sverdiyw6y4k5yiocp2v7yhogfvfpmajyiujbmfhzd3n3gb72@wni25ru2m236>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
 <20251215-b4-pks-pack-store-via-source-v1-3-433aac465295@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-3-433aac465295@pks.im>

On 25/12/15 08:36AM, Patrick Steinhardt wrote:
> The kept pack cache is a cache of packfiles that are marked as kept
> either via an accompanying ".kept" file or via an in-memory flag. The
> cache can be retrieved via `kept_pack_cache()`, where one needs to pass
> in a repository.
> 
> Ultimately though the kept-pack cache is a property of the packfile
> store, and this causes problems in a subsequent commit where we want to
> move down the packfile store to be a per-object-source entity.

Looking at the existing code, the `kept_cache` is already part of the
packfile store, but the interface to access it, `kept_pack_cache()`,
goes through `struct repository`. Refining this interface to go through
the packfile store makes sense.

> Prepare for this and refactor the kept-pack cache to work on top of a
> packfile store instead.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/packfile.h b/packfile.h
> index 33cc1c1654..701a3b4946 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -210,6 +210,19 @@ struct packed_git *packfile_store_load_pack(struct packfile_store *store,
>  int packfile_store_freshen_object(struct packfile_store *store,
>  				  const struct object_id *oid);
>  
> +enum kept_pack_type {
> +	KEPT_PACK_ON_DISK = (1 << 0),
> +	KEPT_PACK_IN_CORE = (1 << 1),
> +};

Looks like while we are here we are renaming some existing flags and
storing them in an enum instead. Makes sense, but maybe we should also
explicitly mention this in the commit message since much of the fallout
in the diff relates to this change.

> +
> +/*
> + * Retrieve the cache of kept packs from the given packfile store. Accepts a
> + * combination of `kept_pack_type` flags. The cache is computed on demand and
> + * will be recomputed whenever the flags change.
> + */
> +struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *store,
> +						       unsigned flags);

Now the kept cache is accessed through the packfile store instead of the
repository. Make sense.

Since we are also changing the name from `kept_pack_cache()`, there are
some comments in "packfile.h" that are now outdated. We may want to
update them here.

The other changes in this patch simply update in accordance to this new
interface and all look correct.

-Justin
