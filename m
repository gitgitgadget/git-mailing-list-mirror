Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15701D5ADE
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 02:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002508; cv=none; b=M9KlIJgTTMQPeZvKcvLSdmp2SPMHYkjWkUe4gp6htbSIrAYM+4fDKLMomk5h6pHu3bCt0799TXhqNmkvEVdqySivkWDz+CvsqTS8NwwpTmoxI2tfn8yGF8uQbqwVFqXEjO1Pbv0jgYFhMvpNxUzRSD5aBLSD89Z0QRYHDz9noCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002508; c=relaxed/simple;
	bh=O/2lABz6HBpfVc9uwpBEQM5NYriUH9zeejzfCGFkp5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dr8dynrUXvT8pHrC6Vw+25ddUL3Mlqp+FpRHP1KKYABPVR6S8BBtXTps9E4rI5YqCUmG8F+kgJdslGwringi+2oUr7m7VqFcDMH297lp7SOa0D8zBGxlgiAT3fMO7PxD13QgF/Cz/KaM1Czazt5XJz+kTLQjCmOikAJz7V/WEf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=BJPIRv8v; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="BJPIRv8v"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d71bcab6fso3472367b3.0
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 18:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1763002505; x=1763607305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8t7YxX41b4vObprGHSfgrEvJOv9XsjP/nNYX9ORcsU=;
        b=BJPIRv8v3JEYgkKpz7cOKgEzwE4oqaUVPXFc5ZTKXVUB72dC3rlP3Jqs2ROVLXwCOL
         H8jEOVV3jQ75UmE9OhwybahLIWDqYneAV3hZ4y+dwmQ5Ek7gDcbXrI0bYdiWeOqo5Pru
         momAxMrMIVFKwFC4UXrGSuIKx6046mAU++NsIlAjPckl1010/5+qp6hsthwhPexam1LW
         eCJUoT86n2+gJw/fBqdXDoHaehfRxFzKsIWijP20dhFJQM15fYJkS+tAu57nOvtnWvUi
         oamB2DX3nWwvlrkPd/JywuIlySoQAMf0aDBCOGDrgIvfcmxdblBop6uPolGKYkCyVfAk
         TfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763002505; x=1763607305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8t7YxX41b4vObprGHSfgrEvJOv9XsjP/nNYX9ORcsU=;
        b=RyEhjI87mDa86Qj8i4/tGMR0LQc5So7C56cvY2+aZMqtBG8FczQT8z8XJe5NhZWy65
         eshUnzWv6DEVbTuQ/tVpY7i5/a/7PaZl77gkuiKPq5RB8AOHaxHw13RNMo/oEZoYcZtB
         6MNqSJwycoppaARWa1BMNjuwArjjgnZdv+TxGlZ9HdKo26H7GuDrJ9qgf9NuFfIyurdy
         t9BDPoOOeHuf+ElusyQhq+WG3krvdHZQk9qpqxl/UOBkAMt/86EbRzGd7i2BgOyEjoJG
         F1YI8nqkXP4SCsZmlR+7YLZgNG5x48tYWUZnNcJsI6qp4Av1dZdXgSGgmfktwheJU9LQ
         QX4g==
X-Gm-Message-State: AOJu0YxdqXhs0h+4uE7yhDnqdonDC1OMrn7q6hmd6Gy7TIXZCP0p7Fm7
	G+kWx1iy0yH3cRGqAPqpQmKFq5EK+Pa1rhbZq4P1mDjj7LDR1FQlcsXRaEdpH+41MpA=
X-Gm-Gg: ASbGncvTMeE+WLx1wSOvfUnGfPrxawA3BlvxKOhFJ4qrS3QzlXXLghzV8m+gnTSHrYI
	oH/Jq05pduLWHES80hDgs0fCcJMxxWMhNRg7IFP8fhLjN2tedAAeqdVF6UUCdabPrYVMuxgVsQK
	v0GQ7DynufN3ipoorB06sR4QJAazCL30H9KkZsnybqdaxTsyOKFVAkGx8slMJZWi96ylbCMhpTQ
	9rHQfYv88wgUW6ZOSItOb7NLCAHsbLgSrx1y2BHPndpnRN9/h2n8x7N2NkPKuHo51PVI5jZH8cG
	0ZmKfT5lthhHzud/sm/vby2yO9HaP5iWSPqiDC+NS2TwVOkfmgHnvnhjgrUrQumHv9k+X/SVf2F
	yGyb1cXhxnJJP2UJkFs0u6bokONk8FA/20PoF/cjQ3ML1ZZawkIMurBxyHvr8tnTM6ho11/x8IT
	b8RfotESZCs2+3p+HUFJVYdI6WCzLaBuyHWELMwo3CAzJmCc4=
X-Google-Smtp-Source: AGHT+IFMsgy8N6UCQ9qRlxhYkI6RjTLQQwU/ntaAm4rDXGVg9S1cndQJzkGVYTCcPffxrOXR6+ADjQ==
X-Received: by 2002:a05:690e:2582:b0:63f:7d36:ac28 with SMTP id 956f58d0204a3-64101b80eeemr4128855d50.59.1763002504561;
        Wed, 12 Nov 2025 18:55:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6410eaf02b7sm271867d50.26.2025.11.12.18.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 18:55:04 -0800 (PST)
Date: Wed, 12 Nov 2025 21:55:03 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, correctmost <cmlists@sent.com>
Subject: Re: [PATCH 2/9] pack-bitmap: handle name-hash lookups in incremental
 bitmaps
Message-ID: <aRVIh9R8Pnuk+yS0@nand.local>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112080151.GB979063@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112080151.GB979063@coredump.intra.peff.net>

On Wed, Nov 12, 2025 at 03:01:51AM -0500, Jeff King wrote:
> As always with the midx and bitmap code, I am left unsure of which
> ordering it is correct to use (pseudo-pack order, or lexical oid order,
> or how each splits across incremental files). I _think_ this is right
> because it's matching the ordering that is already used for a single
> midx. But clearly this area is under-tested, since even when we did not
> go off the end of the array we were probably passing back junk
> name-hashes (either from the .bitmap file's trailing checksum, or
> zero-padding at the end of the mapped page).

Yeah, this is the right order. "index_pos" is a good hint that this is
in lexical order. bitmap_writer_finish() has some oid_pos() lookups that
use index directly without sorting, so bitmap_writer_finish() expects
this array in lexical order.

Commit c528e17966 (pack-bitmap: write multi-pack bitmaps, 2021-08-31)
has a comment in (what is now) midx-write.c explaining this assumption
in bitmap_writer_finish(), but it should probably be documented
explicitly in pack-bitmap.h.

> So it might be worth adding more tests here, but I know this incremental
> bitmap code is a big work in progress. So I contented myself with the
> reproduction above, and anything else can go onto the incremental todo
> pile. :)

Yeah, I agree. The only hash-cache test that I could think of is from
t5326, which tests that we can propagate existing name-hash values from
a pack bitmap in to a MIDX one. We probably need an equivalent for when
writing an incremental MIDX/bitmap too. #leftoverbits

>  pack-bitmap.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 291e1a9cf4..710b86a451 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -213,6 +213,26 @@ static uint32_t bitmap_num_objects(struct bitmap_index *index)
>  	return index->pack->num_objects;
>  }
>
> +static uint32_t bitmap_name_hash(struct bitmap_index *index, uint32_t pos)
> +{
> +	if (bitmap_is_midx(index)) {
> +		while (index && pos < index->midx->num_objects_in_base)
> +			index = index->base;

Looks good. It's too bad that we have to reimplement something very
similar to midx_for_object(), but I agree with what you wrote in the
patch message and this faithfully captures that. It might be worth doing
something like:

    while (index && pos < index->midx->num_objects_in_base) {
        ASSERT(bitmap_is_midx(index));
        index = index->base;
    }

, which should never trigger, but is a good sanity check. Definitely not
worth re-rolling IMHO.

> +
> +		if (!index)
> +			BUG("NULL base bitmap for object position: %"PRIu32, pos);
> +
> +		pos -= index->midx->num_objects_in_base;
> +		if (pos >= index->midx->num_objects)
> +			BUG("out-of-bounds midx bitmap object at %"PRIu32, pos);

midx_for_object() spells this portion slightly differently, but what you
have here is still good.

> +	}
> +
> +	if (!index->hashes)
> +		return 0;
> +
> +	return get_be32(index->hashes + pos);

We *could* double check that that offset is within bounds of
index->map_size, and I think that is ultimately worth doing at some
point. But I think that stopping where you did makes sense, since it
does the minimal thing to fix this bug.

Thanks,
Taylor
