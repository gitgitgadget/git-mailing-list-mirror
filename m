Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93A11DFE2B
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505872; cv=none; b=ceR+RD6qekPn+XfbOL69+Cm8z/Z4KBGuyM6HLgq2IhDS777ShnLH+qSvvfWGxZ99q2ePGvz89eknTTEJdebZeiagA5sGdgEiFgsY1Z6jZ2MbrUwYAirgNbgK9bEnt1SiW3y39njxp17rKgtRJ5xckvjdxo1dvKmoIQLVS9OCyvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505872; c=relaxed/simple;
	bh=4Yw2pzGR0wOeq8aVIy6qUhcZZRmfYt79+Ng9IcpXeTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOzrrmk6PUwnF1bbiVm4Nh5kPbTdzVVHRMlCK1TCrmEUooGYVRhF9rYkmT9lOt2BkswK8yO1NGd2627xvzZ8M3go0htHsizC3C5x3DH25pI6Q/EhfgeXdFOTTuMwj9lcoQXlx1ZCHWZEOOWIgIkXWKEYjLOZmM8O16SIt+ZJCpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZoZ5WvtI; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZoZ5WvtI"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6dbb24ee34dso2225017b3.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 13:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728505869; x=1729110669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ4CWK6MEGYelnnHf5BZR9q0ny8i9QOTMIHGQ3r9LF8=;
        b=ZoZ5WvtIJ7R0EUtwg3BJ1RMOSGlFC9CHy6/+R6jiKidpFxy8vJ5qOYMiTBqg+2uCRJ
         aL7MtoAvE/YGoouxnR+pmNGnH2HJSBJbreCzI6xlstrq6JD06k4/DRwnyNqVecQsA5f2
         2y+2DrdXDrmGL9DGBUWPxyYVaQKdhpTADgtuRleM7uSN84kabfdJ71eWQW9IG/LBeB94
         FuIAQdHkkHjygFDExn659htLucBFTUNu/ag0w3Egrvksi9E/42MEAu4brb1ybcsL/6++
         kc2QmeD0bmKtmNinH96ILqpdO0PnM4dn4balVmd5D2Lt+GUFa6FP6YDyxCcUkUNuXN9I
         ov+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728505869; x=1729110669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZ4CWK6MEGYelnnHf5BZR9q0ny8i9QOTMIHGQ3r9LF8=;
        b=fywnL3U9aB6T+1uQlRESR5KLfBdR7AQ/XaT0Vur2ZIBdz/IY3fIdZzBT7JnyzQ9D57
         OQNjPY6cP4F7sHNVekkYlQZI74c28Y1VQCswryoK4VnBfZXFTQse1OdTukgNDnRJVOyl
         TVKP2KOjBt4DSC+Y3Zns6Axjt21o6EPs0VPwRwKEdE02sgxvKj3PJYkRzNpDbj5RwaQV
         847+vZwpCc/y4YtJE7hZmfWrpJlmwycVmPxLy0qfIjEvdxG+F0ovXqtpGSLVpQwXIum0
         refQ/osAqOToOJRpSuxdrpCdGJiKpza0mlzw47EZaCe03DiJHnlBTxpathqpKnv6itmX
         ofEw==
X-Gm-Message-State: AOJu0YyY4fMG+ta7AjJmzOgLRhx3JL+9Q4rsw05P5rYKfePuegvkBI83
	2tLDhbdv6M+nJTBxIwvkw8+BTjGsV9Zhjdw+8Ss3Pmnz+mRLKksyI5gMzRozf2iOtqgvh7oOKnI
	bdgE=
X-Google-Smtp-Source: AGHT+IF5WwZj2e6CmXZc6hvjSYKjx34/pGzy7pRHLXUjytW8UaNMIaQ5Y9cz3S7YSlQ5cMzuF8K03w==
X-Received: by 2002:a05:690c:f03:b0:6e2:1626:fc24 with SMTP id 00721157ae682-6e32e1d7532mr17341687b3.7.1728505869453;
        Wed, 09 Oct 2024 13:31:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e32d5ebeacsm2030567b3.6.2024.10.09.13.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 13:31:08 -0700 (PDT)
Date: Wed, 9 Oct 2024 16:31:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 03/11] pack-bitmap.c: delay calling 'offset_to_pack_pos()'
Message-ID: <6118055b55c801f964b5a4b5d001196c00b757ab.1728505840.git.me@ttaylorr.com>
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

When handling single object reuse from a single-pack bitmap, we first
convert the base object's offset into a pack-relative position. Then,
we check if the base object's offset occurs after the delta object's
offset. If that's the case, then we kick the delta'd object back to
the slow path.

But there are a couple of oddities here:

  - However unlikely it is that we'll find a delta/base pair with
    base_offset >= offset, it doesn't make sense to convert the base's
    offset to a pack-relative position if we're going to throw out the
    reuse opportunity anyway.

  - We "convert" the base object's position into bitmap order by
    offsetting it by 'pack->bitmap_pos'. But this makes no sense,
    since single-pack bitmaps have only one pack (by definition), and
    that pack's first object occurs at bit position 0.

Let's clean up this part of 'try_partial_reuse()' by (a) first seeing
if we can reuse the delta before converting its base object's offset
into a pack position, and (b) avoid an unnecessary conversion with
'pack->bitmap_pos'.

(b) allows us to avoid the intermediate 'base_pos' variable, and
instead write directly into 'base_bitmap_pos', which we also change
here for further clarity.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5c5c26efe0d..faabc0ba0e9 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2102,11 +2102,6 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 				return 0;
 			}
 		} else {
-			uint32_t base_pos;
-
-			if (offset_to_pack_pos(pack->p, base_offset,
-					       &base_pos) < 0)
-				return 0;
 			/*
 			 * We assume delta dependencies always point backwards.
 			 * This lets us do a single pass, and is basically
@@ -2124,7 +2119,9 @@ static int try_partial_reuse(struct bitmap_index *bitmap_git,
 			 */
 			if (base_offset >= offset)
 				return 0;
-			base_bitmap_pos = pack->bitmap_pos + base_pos;
+			if (offset_to_pack_pos(pack->p, base_offset,
+					       &base_bitmap_pos) < 0)
+				return 0;
 		}
 
 		/*
-- 
2.47.0.11.g487258bca34

