Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791751DFE2B
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505869; cv=none; b=HSVTrxajdSEIj6jnaNAq7pfb5z5ryYTgRIIElCC7FYe33QUM8PTFc8CepmLY6VO+fFQZkaEPkLtJ7t+c1XHDpFpy9Ssb8I2KYkUGtu35KRjcTy40r1ZEE6KEcjwowkYvOa4JujkZuLjMViOGigEBQuoiSuMgoz2/CHuK/5OpHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505869; c=relaxed/simple;
	bh=DVx7x+Zdb3aUIQzTYhR9tZXixJHgHLyflV7H8HMldoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvwBTPi99hf+UnH/ppNrmRA9FKMnoz4RiRfRMp7b1IH2XeXqHFBTSwWBpibpokmZdov3zmbNpo8bsEiCUwHqGszbor6+Z5xYgjJGCqnV8eLBdjot3KMjZAya5urHGCMdw2tjj4Xc1Yh14eXbr/SI1h2QmPo/E0E785Ni6RcoksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2UJPWpUE; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2UJPWpUE"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e2d2447181so2661517b3.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728505866; x=1729110666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ItJ59+OwnJ7j6SYldlZucWMJGrgH1cP8nZP9IDzUP7A=;
        b=2UJPWpUErKucaMHs4H7ReBrDaiSBG0XMVS1F91SX1B412Oa4vi03fnna+dNaHDcF5U
         pvzXub3otMT9ujVrealgxtxnaDc29t8n7o5ULHvznuQ1Sekg/OU/65bsBe6O35LKIe8L
         E9EQUy6XW2Mi3Rr4pzd69EnUizRWOH8BpgjDMboVeWbjeeRby1P8yGHKhnMFcMgXQkon
         sYItQxxhbgfkf+HEWCcIhwqvzBtO9mShZPrWsDg/uOXwpAW0I+Bx8sKt1v/uyCKe1eVU
         o+IjhZw8Q22M1r2ZjJcZQkumoHBJWDZzU5NsIWh+ajQ6nP/JubhGp1Hku6RYT0L/EkvU
         Fu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505866; x=1729110666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItJ59+OwnJ7j6SYldlZucWMJGrgH1cP8nZP9IDzUP7A=;
        b=uSiUkMXq8pcpK7jFHVQYzhMmE91e5iJ8tH987FEydavQiK0cRb4hFbjM6TE9SLK0Vm
         L7yriFbRZs6M/fuQxPBg37ZTmkbFCXzwWGS56FaDi7Exvq9y9yokvCJ72sTADvtced5C
         knFs5QaBlC6dbDlZxuvquHvgkph8HUuC3QDy1B073i0nuRhuLC/yT7AgOqUYlyCQHFDl
         cRbxW6nD+sQZ2AL+BYLCPVkd6QSEI19EF/plrW90Wt8cSqCme9tDanYhG1ngViwDHA/0
         BbaYNK8war1Z77+lqP9EVmJkpGvjsmCokRist40vqJprp3qkCMasWVnXhXpKZHtv7HiD
         fUWw==
X-Gm-Message-State: AOJu0Yx6TavsAJpcIaly5EzMaofzR1WFlphkNFwT4CzVkqfiDrxdpenu
	a3Q8JNc+UbZSJyOBZHqImdvLv7KPNkSObcVzev3E0Rf9EFzsrFsBi/CJGsq1ifk2bqfKhhn9qv9
	HzvU=
X-Google-Smtp-Source: AGHT+IHYOIUkT/jVpy2orFmeLQWLdMBZfcLwOUx6mwnID17+MyONq8Ez+u7GKwu+Z/2D6OuT35MrYg==
X-Received: by 2002:a05:690c:89:b0:6db:4536:8591 with SMTP id 00721157ae682-6e322491490mr41404597b3.28.1728505866135;
        Wed, 09 Oct 2024 13:31:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d926dd83sm19693347b3.20.2024.10.09.13.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:31:05 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:31:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 02/11] pack-bitmap.c: avoid unnecessary `offset_to_pack_pos()`
Message-ID: <010316f1eb49b46db1ed0b8df10402d3a49013f8.1728505840.git.me@ttaylorr.com>
References: <cover.1728505840.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728505840.git.me@ttaylorr.com>

In `try_partial_reuse()`, for any object which is either an OFS_DELTA
or REF_DELTA, we need to determine the bitmap position for its base.

We handle the case of single- and multi-pack bitmaps separately:

  - For multi-pack bitmaps, we look to see if the MIDX selected the
    base we're looking at to represent that object. If the base object
    was selected from a different pack in the MIDX, we won't reuse the
    delta.

  - For single-pack bitmaps, we convert the base object's offset into
    a pack-relative position (identified here as 'base_pos') by
    calling `offset_to_pack_pos()`.

But we also call `offset_to_pack_pos()` before handling each case
above separately. For the MIDX case, this is unnecessary, since we
don't need to lookup the base object's pack-relative position;
instead, we just care whether the selected copy of that base is from
the same pack we're currently operating on.

For the non-MIDX case, we end up calling offset_to_pack_pos() again,
yielding the same result, making the earlier call wasteful. This
behavior dates back to 519e17ff75 (pack-bitmap: prepare to mark
objects from multiple packs for reuse, 2023-12-14).

Let's correct that by avoiding the unconditional call to
'offset_to_pack_pos()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 706ff26a7b1..5c5c26efe0d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2069,7 +2069,6 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 
 	if (type == OBJ_REF_DELTA || type == OBJ_OFS_DELTA) {
 		off_t base_offset;
-		uint32_t base_pos;
 		uint32_t base_bitmap_pos;
 
 		/*
@@ -2085,8 +2084,6 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 		if (!base_offset)
 			return 0;
 
-		offset_to_pack_pos(pack->p, base_offset, &base_pos);
-
 		if (bitmap_is_midx(bitmap_git)) {
 			/*
 			 * Cross-pack deltas are rejected for now, but could
@@ -2105,6 +2102,8 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 				return 0;
 			}
 		} else {
+			uint32_t base_pos;
+
 			if (offset_to_pack_pos(pack->p, base_offset,
 					       &base_pos) < 0)
 				return 0;
-- 
2.47.0.11.g487258bca34

