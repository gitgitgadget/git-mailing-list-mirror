Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8F3803EF
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782755356; cv=none; b=FHpyNP9xQ7ZQ9yHyyfZajUMbpF7ZTibWt+wekgAaXS3CBQnVGKBADRWT3M067o2sw0U0KVFxv4yrAtTKmbLIX3d6ysbPgOO+qoIjXwYqjp8X43hnQosdOnh0qfrctOMAkctAGYHgcipkBVej5X0CtRG+tIU6UykuNIsGczL7K/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782755356; c=relaxed/simple;
	bh=PkQHdJuWpyYaH0SJ15OtJxD3F6NB7Avk4qS6lqK6C74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+ELUazMUySF4XJSQeE2wQ92cy8EmuzAz6KgwYDJURaB2TmXbaMAQ7Mv/+5iV8VONyLdOoNHBR3pj7OmQCDmrZ3f67+wx1NamgM794KrzlJWkWEt2AogDZjiNG5L0NxPwadncvPHdVpqoTQJ+C68PtBMolh9zdmozLhYioi5SIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rthxenui; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rthxenui"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e943356247so2889438a34.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 10:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782755352; x=1783360152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IiuEy7ZUcXmy8GkhRd1IQ7NBulObs3MlpSKfQFQvdaA=;
        b=rthxenuiIaS9/WkKG1KabnEC9aFI4YnUcSc7O8fw7elD43Rks0SWgp4WnwX1sQsSTv
         aY7CYLrsqzwrbwqGPS0ux6zPUJQA4vbnUDz2FROCK2bPykxBvNynOnn2qJ19O7NcYBLf
         Yun74xTUAEMeizOitOPHfkiOTy2aDQeyVXInkLbkiqgvNo2s7kyForgOdU86JpBBdn4b
         OhXXwBv0k1gheuF9yIyYU1OiA34gMG6qMEGR1/W4MI4nr2sfwPkdijzSaQYwTlIlKGyX
         OHBIA1X7CZvmVuNVs2+5C2xorWVn6EHYgOFQkGZVWlJ3CdGjBFF+T8BNSzAV6Dz9O5Vd
         4R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782755352; x=1783360152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiuEy7ZUcXmy8GkhRd1IQ7NBulObs3MlpSKfQFQvdaA=;
        b=Z2VW3wTl++YmqYCYWq152IauuRyiTHgIfPvs29T0zXfsjNiMUNKdF0/WOxhM6H+bYo
         mc70b/OJ7ALPGM2sYHgKifi786T1f8lqeTPF9xycbEW7YmWMD6pjebFZYRQHpUNIsqf1
         /N3BwwK6DzbuJQObsGtpPhzlvA5dYcSE6v2O6VElnspsEcQIen/B0HRzIMOMmLiGqIO3
         BDuSk0wDMixdWVN1GxjfhyrSZj9f+aqr19MfgloPrOVmOIEz6AcGScH661tRS8PjppxD
         kY18a7CruV9XQh9Huc+FeRk2Wm0NfGmtJ0eXOZgSWqiuMZWRP+bs8sAW2K/bIQbByHNZ
         pX8w==
X-Gm-Message-State: AOJu0Yz4Kv/WqltQvRiQOek+W2gb+BMZ52IXn1sMJlNabicWpPOAroYd
	Tff4DP97NcYR5AclczgX3atxHYXwe7sIkw8Cq59696rCADo2uxwFeDU7N8Bd5w==
X-Gm-Gg: AfdE7cn4XojCKfkzipiL1wgPsiz2NGKTvS6bi+qVry2iO5F7bXw/nCMM3cR44vYW0To
	pv2lkWbxZnVAqtOxPoSShoPQbImXu0/sUz86qD7gw9O9Wj2BbdOl/6gbh+2aJ9rCb9BBnR3nEfm
	whyifSJcqul9A8eXcKnfFlGTbNLuKaN8KF1kYTExFOdQgepAgKYM8a+YuR2cB03sjrX17xFVzJb
	ObKarOZmnEn5g4e84IzP+5kzxdvIECt9sDTjKBeQU570Vk+aGj32zX54cNBNN6xOJV9yuzZ/Zk2
	MMDBAmPLvyZFKr8gz/5TtP12icwp5vwMm7LdXVKQgWEmC08j2XCWM18XrzD5MnOrH91rnkVwLqs
	pBY9IKLK0gwcFsAsW7D793OD6CRhROS0UGtxiNdhtmvNgxIXOpyTXj1Ey33rj0VA8osCkfvbq/a
	BYiX8cAA==
X-Received: by 2002:a05:6830:4126:b0:7e9:b4d1:78b1 with SMTP id 46e09a7af769-7e9ec80cf59mr371821a34.31.1782755351651;
        Mon, 29 Jun 2026 10:49:11 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ebfdaa63sm331775a34.10.2026.06.29.10.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:49:11 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:49:08 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] odb: add `source` field to struct object_info_source
Message-ID: <akKtc4ybxFRVJmNv@denethor>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
 <20260624-b4-pks-odb-drop-whence-v1-3-8d1877b790ac@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-b4-pks-odb-drop-whence-v1-3-8d1877b790ac@pks.im>

On 26/06/24 02:19PM, Patrick Steinhardt wrote:
> The previous commit introduced `struct object_info_source` as an opt-in
> container for backend-specific information, but for now we only moved
> preexisting data into this structure. Most importantly, the caller has
> no way yet to learn about which source an object was actually looked up
> from. Instead, callers have to rely on the `whence` enum to distinguish
> the object type, but cannot use that enum to tell the object source.
> 
> Add a `struct odb_source *source` field to the structure and populate it
> from each backend's lookup path.

Makes sense.

> The `whence` enum is still set and used by callers; it will be removed
> in a subsequent commit now that `sourcep->source` can identify the
> backend on its own.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.h                 | 3 +++
>  odb/source-inmemory.c | 3 +++
>  odb/source-loose.c    | 2 ++
>  packfile.c            | 6 +++++-
>  4 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/odb.h b/odb.h
> index 770900289a..330a55879e 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -253,6 +253,9 @@ int odb_pretend_object(struct object_database *odb,
>   * more about how exactly it is stored.
>   */
>  struct object_info_source {
> +	/* The source that this object has been looked up from. */
> +	struct odb_source *source;

Here we add the `struct odb_source` so we can begin recording it.

> +
>  	/*
>  	 * Backend-specific information about the specific object. This can be
>  	 * used for example to uniquely identify a given object in case it
> diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> index e004566d76..2328e62687 100644
> --- a/odb/source-inmemory.c
> +++ b/odb/source-inmemory.c
> @@ -52,6 +52,9 @@ static void populate_object_info(struct odb_source_inmemory *source,
>  		*oi->contentp = xmemdupz(object->buf, object->size);
>  	if (oi->mtimep)
>  		*oi->mtimep = 0;
> +	if (oi->sourcep)
> +		oi->sourcep->source = &source->base;

Here we set the source for the in-memory backend.

> +
>  	oi->whence = OI_CACHED;
>  }
>  
> diff --git a/odb/source-loose.c b/odb/source-loose.c
> index 66e6bb8d3f..5c4e9892b5 100644
> --- a/odb/source-loose.c
> +++ b/odb/source-loose.c
> @@ -196,6 +196,8 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
>  			oi->typep = NULL;
>  		if (oi->delta_base_oid)
>  			oidclr(oi->delta_base_oid, loose->base.odb->repo->hash_algo);
> +		if (oi->sourcep && !ret)
> +			oi->sourcep->source = &loose->base;

Here it is set for the loose backend.

>  		if (!ret)
>  			oi->whence = OI_LOOSE;
>  	}
> diff --git a/packfile.c b/packfile.c
> index 688c410b35..fa22095b75 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1324,7 +1324,7 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
>  	hashmap_add(&delta_base_cache, &ent->ent);
>  }
>  
> -int packed_object_info_with_index_pos(struct odb_source_packed *source UNUSED,
> +int packed_object_info_with_index_pos(struct odb_source_packed *source,
>  				      struct packed_git *p, off_t obj_offset,
>  				      uint32_t *maybe_index_pos, struct object_info *oi)
>  {
> @@ -1424,6 +1424,10 @@ int packed_object_info_with_index_pos(struct odb_source_packed *source UNUSED,
>  	oi->whence = OI_PACKED;
>  
>  	if (oi->sourcep) {
> +		if (!source)
> +			BUG("cannot request source without an owning source");
> +		oi->sourcep->source = &source->base;

And here it is set for the packed backend. Looks good.

Naive question: I understand that some `packed_info_object()` callers
may not have the `struct odb_source` on hand, but when the `struct
packed_git` is intially setup, is it not always known the ODB source it
comes from? It makes me wonder if the ODB source should also be recorded
when `struct packed_git` is initialized.

-Justin
