Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0082066C6
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983528; cv=none; b=UeQHEa50Cddq4GcZzokAlqaL2VkOJmEnFDy6PWVkC9Piyzepuc+yvpsOxNYh/15UPrqmsqOEJzZn4c+AvL5fJ7DhmL47y2FfDcz/Cnr15xapXuYXCap8GbiAxzr4D+StsQSmcTw5aAM/ZZGur3XOZr5D1GMH1AVKROZ8/R36eOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983528; c=relaxed/simple;
	bh=1vQrmlJMOKmMotEtkcskNoJ0KE6x8lYNw5gNtttKdBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsOxf9DbVmqHA12ZrnAf+uvxTDXRL5MO4P1rBiZBhWazfa8JEL7YxOT5QOI2YMuHE8DKN3w1+W6lvxJOMTsq3asXoyIsJyQCl0W4T25ToW5b4Av6OBAWMma88xJzgIb9bz17PSTDlRGPu9Yh2I+tYxJGJya50FuiFK2Q6xAT2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CsGUmGTy; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CsGUmGTy"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8ec399427so20224586d6.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983526; x=1742588326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODHPTAPMWIatEvoJRULe6xD/J8KK9pnjKVoT3acMt+c=;
        b=CsGUmGTyKfU9VLjstETqoUQlZpisvLNR5y+LtE+mt2yiLzuGZvOTR9c1H1SefxPCRD
         bqWHs2rRgDYrx8J2k4erXV8VkB7HRH39ybcpK5/R/TleaYeRIX+n8XYTcLg9mS31hMmK
         fhX9xOhBl1F4fYSr/kh8EjBbNY19w02GAqMZ7CdQ7/043FNp56cv19u/trxvLZndzRsB
         ApbFbQh7x6OW/TYZHv5+acpDKtPtAAD1VUChtky0RdcyglSCfWuC9/WhelzHJiD0YrjU
         5kMYr8CxrZ0aUM0OWiVxwenVukGp0moysFF/aenSz3lrLnwod6a2DFrmbBrQAGEYSMfi
         9KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983526; x=1742588326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODHPTAPMWIatEvoJRULe6xD/J8KK9pnjKVoT3acMt+c=;
        b=hlKWqRky+WQ/Kcy3KrXwMoU+k2isodiv174/Z6qx0sGRMfRvLBuVLgEJ3VtxEwAnZS
         npJrupeelO4OJEL3JL5ofQN1kxuesIkjwbxrFhkaHuMWwndNcCLwCntEPDZY4PT77m36
         TGTicx9V9JBrsQ1Wbdswnnee3K/zXbx8wteqXpALj9AQv5KjsRSR3Xt0/YzCnKyYcemv
         9EfofCMW8DA70Lr6Py6Uogw/Ct6CfQuQ0phVyOQirYeY3KD6EVN0fCcqOjrqTSJWYOhp
         PKSRoXkB8VzZ6J49u9ouDb30xuFeKxJGaxJKqUIE22zBOgoilN2EDOvyYFQVVvPv5wQB
         Ddsg==
X-Gm-Message-State: AOJu0Yz79Gt/3WDCxSfCfdmwRvA9K0OG1HJLI8f7TXXqGeut/0juWYph
	4SNL7LVvpTJzRoyHkDLgJOzThajQaZ2N0PGcvObi8aGqIEupxGbC1Ek5LG35wvHfmo5ViFJ4ha5
	G6+A=
X-Gm-Gg: ASbGnctBELHDmyRhHl2GZXrNo8iknHASFW4GIlHuLmCoeUCfVIJ58cPPLCjDaleq+rf
	Kx32mrQLyaH60z4kka+bn+4LA6lOEdI/ZeNeR2Hj4TbOHzUOnSd95vE8YrJvUslbE9vo9UiKsi1
	Rv7gXQfUW1H0lxdvPCEm1J1D5DicJoGaSvtg0WbOS89gmCfhKWTkfHa1nS4P7oJqiM5PE0PUmq0
	39Sqmqmt1oAT8sXaUAIc6Tj+yDDlfEoSxwKdeOdDhk8PJ7vyarI5uQfSapkt++To4FwmFPP6boo
	6KDMid2FcwbjLOuYD4H9CU6S6WDb6/PYZZgNeYPFX3mgpQwWb9Kb86EYRlYJFCQPfPdjSkpVl6r
	W0+w1/t496Jme7sCj
X-Google-Smtp-Source: AGHT+IGo+0YZ4hzdoR/RTwNrey3GUcXKusEaMDZ9zWF4CtS+e7NvuJyLL94luCiRaIdEPRaEploMZA==
X-Received: by 2002:a05:6214:5289:b0:6e4:2dd7:5c88 with SMTP id 6a1803df08f44-6eaeab04210mr43265606d6.38.1741983525851;
        Fri, 14 Mar 2025 13:18:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade2342eesm27669716d6.38.2025.03.14.13.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:45 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:18:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 08/13] pack-bitmap.c: compute disk-usage with incremental
 MIDXs
Message-ID: <c1eefeae993f2c8778dd0ec9626f977dbb2011a2.1741983492.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1741983492.git.me@ttaylorr.com>

In a similar fashion as previous commits, use nth_midxed_pack() instead
of accessing the MIDX's ->packs array directly to support incremental
MIDXs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index bb09ce3cf5..8442f8e55f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1778,7 +1778,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 			uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
 			uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
 
-			pack = bitmap_git->midx->packs[pack_id];
+			pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 			ofs = nth_midxed_offset(bitmap_git->midx, midx_pos);
 		} else {
 			pack = bitmap_git->pack;
@@ -3047,7 +3047,7 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 				off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
 
 				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
-				struct packed_git *pack = bitmap_git->midx->packs[pack_id];
+				struct packed_git *pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 
 				if (offset_to_pack_pos(pack, offset, &pack_pos) < 0) {
 					struct object_id oid;
-- 
2.49.0.13.gd0d564685b

