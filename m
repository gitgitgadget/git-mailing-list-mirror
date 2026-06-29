Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1E46AF24
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753929; cv=none; b=j7P99/o5ZgnS2jiMrHuos1ECXGU1KBIZQ5ZEcnx9dFLpiLceHieJ4aaCUuRY5+r0AHLFZss6XCGIIKNVrEqABTvoOaFcK7Q+McEDpVatt9+ASgMZSqoBItWdqqulXIIk+kAe5v6WaTwy2EwkJII3aehJlHRtm0HuzZXDZavGOII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753929; c=relaxed/simple;
	bh=s9tCBFVAwP3X+fBL7iAFDe2JhPg3awhlsOT816qRXSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrL/tj/2y04JKdci5ZghnJVsWFpZfVSPU20wJhcGmKetE9yeKFCjh5WurKcuhkJgWmdGDMDeGuvgFXg6M3S/FmAuJhSqxD48SrQf3gRWYLL5pxZ3qSeR2iVvWBmiUk0vb+igM2tjeHLprVhPg9YbpXqg0eLUPmOa7XLWLAREVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7P5WNbR; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7P5WNbR"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-489f0c807c5so2358661b6e.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 10:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782753927; x=1783358727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWnlqfjPurkr9P0Q7FDITdJIeulKpC1ZF/4Fs+bly9U=;
        b=Q7P5WNbRJJ612kdX4x/O+FaaYtXZVsCPPtWnPo9+SgCJVTtElKDq76csvlXTpaF56+
         eJ1eqC+S3+T07MncaMO+UVFvgBAnk4uuPK+VlRzgqNvVAyz9bARLIxsJdywUzLREfWpY
         9bMnjlgbXmQIKMNe1UEq9zUiksXD1XULOiVbPnFQnYYEp8c0FHyjaz5M/cpkUMx1sj6Q
         /iGlhaxl6TNzpT08X1VY84+++nkLWJXYjCg57AnFV2NrvCWgy3V7IXEFIYHY0V/zeWg3
         ae/9Dm9wZlezJiPMMEmn/UYtmryMwGxdnJXctMJgRUXMzpGGMgWHGsLxZUEtUUKx2ZhU
         IELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782753927; x=1783358727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWnlqfjPurkr9P0Q7FDITdJIeulKpC1ZF/4Fs+bly9U=;
        b=CnUwADpL6iAv66xbP6K4ui7qtJ2qNLRY7bc+4ac16+adMNe6lBZLzAuwWhrZMSo/JC
         9IiIYunxHB6fmjoWIndlci7iGH7OsKMrYbGMn1HyK2YsHpaF2pqNWd4C32Vblbl8GL5j
         XRb6ltJMhSsFlQfqtVvbLHVxz/fEV2KNBrOb0Ew7ObFrcnV4yW6YgzBZ0SQZ8XBmqoKX
         TpdZtYwEbfBjsx2MIAvB/hn1WPAT6AI0WWMIZqKs6ZaDjSuzG0mIMADvMKwDOTSWxFr0
         bQ5M5AukqkNIrzxltdM6qboDEhMTqq5tKicXa+DUoSEHlpmly0yW6w4jUIzAGcr5HwsA
         2C6w==
X-Gm-Message-State: AOJu0YxkAvD12KLUDJn5mg/xfGZEy0xy5gnq4ZCSju8cMKm84VTNVJl0
	UkqnoftDEpeaM2PMUWyHtG3jZddYUU1TtZ1F4za2PPY8K4jcgncyHPgewzlq+g==
X-Gm-Gg: AfdE7cmk54EjuDtPkD5BqIWMB1MbLyI9IPNkoUbih6NIhFaKn9WFhx2zyfM90qfgKeH
	uvog8feanOixM8jozS0dGtJMeeXLXo54PEK2RTy/6CvcT5xDVUB6pD/UvA6d+G9wUfyfFxNkAm3
	fxcH06PBQRdD5G5VzyTlhOQTvqyJ3f+LPdd5IsHvxGfLzHjRTiRvdW+ePH+K+7rohahI0yvKoGs
	nrgvUmXXxVRXDFWnzYlRgLphrgcxTQkvPid9Pl6am6fYUmrmxi0fO3gVuZcETDYixgwlvbfUIeV
	aA6Ix8ivroUksM6kimE3rdJmi1g971G8L/VLuRqs0F87wZm80IeBpOeAcUJBD1RStrdP9yayqer
	vhPpZ8ufXWVZGg4O/3zIsZrBTwXRsE3BAjd0OciC7JO1hGceMcT8vBgPPl5u4KfW3r1LrtPyhuX
	bZgDXX9w==
X-Received: by 2002:a05:6808:c2f8:b0:490:72d7:6efc with SMTP id 5614622812f47-495eb8ad9dfmr118321b6e.17.1782753926753;
        Mon, 29 Jun 2026 10:25:26 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-495e092b61bsm1097323b6e.5.2026.06.29.10.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:25:25 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:25:21 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] odb: make backend-specific fields optional
Message-ID: <akKmwPGSAGEGKZjL@denethor>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
 <20260624-b4-pks-odb-drop-whence-v1-2-8d1877b790ac@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-b4-pks-odb-drop-whence-v1-2-8d1877b790ac@pks.im>

On 26/06/24 02:19PM, Patrick Steinhardt wrote:
> The `struct object_info` carries two pieces of information
> about how an object was looked up:
> 
>   - The `whence` enum identifying the backend.
> 
>   - The backend-tagged union `u` exposing backend-specific details
>     (currently only the packed-source case, which records the owning
>     pack, offset and packed object type).
> 
> The union is populated unconditionally, even though most callers don't
> care about provenance at all.
> 
> Split the backend-specific union out into a new public type, `struct
> object_info_source`, and make the object info structure carry it via
> just another opt-in request pointer. As with all the other requestable
> information, callers that need source info allocate a `struct
> object_info_source` on the stack and point `sourcep` at it; callers that
> don't care about it simply leave the field as a `NULL` pointer. Adapt
> callers accordingly.

Since not all callers may require this information, requiring callers to
explicitly request it seems reasonable to me.

> Note that the `whence` enum is strictly-speaking also backend-specific
> information, so it would be another good candidate to be moved into the
> `struct object_info_source`. For now though it is left alone, as it will
> be replaced by a `struct odb_source` pointer in a subsequent commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/cat-file.c     |  8 +++++--
>  builtin/index-pack.c   |  8 +++++--
>  builtin/pack-objects.c | 15 +++++++++----
>  odb.c                  |  3 ++-
>  odb.h                  | 60 +++++++++++++++++++++++++++++++++-----------------
>  packfile.c             | 33 ++++++++++++++-------------
>  reachable.c            |  5 ++++-
>  7 files changed, 87 insertions(+), 45 deletions(-)
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 8726485f1f..adc626ce30 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -835,7 +835,8 @@ static int batch_one_object_oi(const struct object_id *oid,
>  {
>  	struct for_each_object_payload *payload = _payload;
>  	if (oi && oi->whence == OI_PACKED)
> -		return payload->callback(oid, oi->u.packed.pack, oi->u.packed.offset,
> +		return payload->callback(oid, oi->sourcep->u.packed.pack,
> +					 oi->sourcep->u.packed.offset,
>  					 payload->payload);

We update callsites now that object source info is stored differently in
`struct object_info`.

>  	return payload->callback(oid, NULL, 0, payload->payload);
>  }
> @@ -906,7 +907,10 @@ static void batch_each_object(struct batch_options *opt,
>  						&payload, flags);
>  		}
>  	} else {
> -		struct object_info oi = { 0 };
> +		struct object_info_source oi_source;
> +		struct object_info oi = {
> +			.sourcep = &oi_source,
> +		};

Caller that wish to know information regarding the source of the object
are required to explicitly request it. Makes sense.

[snip]
>  struct object_info {
>  	/* Request */
>  	enum object_type *typep;
> @@ -269,32 +301,20 @@ struct object_info {
>  	 */
>  	time_t *mtimep;
>  
> +	/*
> +	 * Backend-specific information that tells the caller where exactly an
> +	 * object was looked up from. This information should help disambiguate
> +	 * object lookups in case the same object exists in multiple sources,
> +	 * or multiple times in the same source.
> +	 */
> +	struct object_info_source *sourcep;

To me, the name `sourcep` makes me think a pointer to `struct
odb_source`. This did confuse me slightly when initially reading, but
I'm not sure it's worth it to be overly verbose here.

[snip]
> diff --git a/packfile.c b/packfile.c
> index 2b741d7a76..688c410b35 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1422,22 +1422,25 @@ int packed_object_info_with_index_pos(struct odb_source_packed *source UNUSED,
>  	}
>  
>  	oi->whence = OI_PACKED;
> -	oi->u.packed.offset = obj_offset;
> -	oi->u.packed.pack = p;
>  
> -	switch (type) {
> -	case OBJ_NONE:
> -		oi->u.packed.type = PACKED_OBJECT_TYPE_UNKNOWN;
> -		break;
> -	case OBJ_REF_DELTA:
> -		oi->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
> -		break;
> -	case OBJ_OFS_DELTA:
> -		oi->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
> -		break;
> -	default:
> -		oi->u.packed.type = PACKED_OBJECT_TYPE_FULL;
> -		break;
> +	if (oi->sourcep) {
> +		oi->sourcep->u.packed.offset = obj_offset;
> +		oi->sourcep->u.packed.pack = p;
> +
> +		switch (type) {
> +		case OBJ_NONE:
> +			oi->sourcep->u.packed.type = PACKED_OBJECT_TYPE_UNKNOWN;
> +			break;
> +		case OBJ_REF_DELTA:
> +			oi->sourcep->u.packed.type = PACKED_OBJECT_TYPE_REF_DELTA;
> +			break;
> +		case OBJ_OFS_DELTA:
> +			oi->sourcep->u.packed.type = PACKED_OBJECT_TYPE_OFS_DELTA;
> +			break;
> +		default:
> +			oi->sourcep->u.packed.type = PACKED_OBJECT_TYPE_FULL;
> +			break;
> +		}

Source information is no longer unconditionally set.

Overall, this patch looks good.

-Justin
