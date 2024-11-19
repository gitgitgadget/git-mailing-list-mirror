Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C781D47DC
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054059; cv=none; b=VuoY5/byTsRvQmGLNyQZ/agZbo77fgvMp6F+FuIIksRww8/bjC/2JIkrRO5WIXWRI/kgVt8I6AvdbkL5R8Iy0NscU51UD+KXKrEcnCzaU9llVvgbB4Ia2oqX0cP4Fv2uUgA3thttfHLGrf1N6g4q7P8yTGt5OMu1X14SDtO8oaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054059; c=relaxed/simple;
	bh=7mzbZ3j8yAoOh6Ty5Gk63/0Y0S6UaFxrI2I7wJU5HZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5ueV/Cn84iIUk3iLvtGtIN5vvEASRzmigkQcFmYff12lHNw3oOhYE38n8ka0th6CTwtIxMGqw71uw66aTRK2nMbEdx1HwgS4QFL2GTKWHk5jnLgskUIoehQNjl7auYWCk4W0dgm+X2z0epAMo1yx82sKv/mE5GRmEO2Uv6OO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QQacbOOx; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QQacbOOx"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6eeb2680092so11902697b3.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054056; x=1732658856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NkTTCTVp9ddpJzKX3JdGkLamJsl5sQkwOUoLGaitR2E=;
        b=QQacbOOxLFyo+MFvXRINzvzYjACp2hEzBTqeH0VfR0b7pm9j5F79VpiuEuSrIM6bpH
         qw56Fab5lvcT6tg6oC/tEG27ed62MUDkksr+qNqTAKNQXDBnAE4BTg2EHWpGnaz1cvqs
         jSuQMQ7oO6Wuavs9HLFZYEKuILg/LpPFutdk+qWFD1dXzDg/IezgM+rm04t0kW4EUQME
         kfYFkduCk/N0194ciAglhdKVKnt+dio/11OcsrRskVMCLHSJUvtfUJHrcTLD9XVzQRWs
         ETd3ActgTu1uB+f5XEflI3X5pyIAqxVML+bwYllPhP+OCcOP69ispXzq8gLG3MhCJXYQ
         yTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054056; x=1732658856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkTTCTVp9ddpJzKX3JdGkLamJsl5sQkwOUoLGaitR2E=;
        b=qBv7dP+L6KdbM/2g/4KXPVmIk0EE8lWSgknvb7v+7qiYcvnrWfsYez4+or/QaHrt6q
         /ObWhGsIO773OySbszMFWc8sCrCda4SpLuCFzdPCVWgHwoNikpjtUitNm44S184LoZvb
         4frFz9Pj8EuzpL4OYawnBu1EsDpfp4RICdUJatRVNNAQbB58eHqba908G01bSmKBqDmo
         DB7bmKZj3eNcLKgwc8h6POp2Tz4ckeIOBG9ywX9JsL0to+DLhe71z2A3iIGhG0cnbkRd
         8YIYLT3qb1QPftwllpwtSrd6vGjCGdqS1UIdpPbtDugEvfwQtFyqr1v4bEhwKBpXa6aB
         0FSw==
X-Gm-Message-State: AOJu0YyfVOiCYgYo5/uNLN2yrYft66/71VfxovMPYiFue/iNA9lz1YUH
	I/gLBdGcW2Y5+xgaB970mitaDiqhVA/EHqsaqgaTLp2YL+z3Sfx0OBBF5tFpip25qfbEVqeB0FO
	z
X-Google-Smtp-Source: AGHT+IH342u94Rou5qO3L3j8oItEDMvLm+p+2A7/7gZ/kKFL5QY1LLlpiFq+Qv2IF252DBgV/cgbYA==
X-Received: by 2002:a05:690c:688c:b0:6ee:988b:16d4 with SMTP id 00721157ae682-6eebd2a5e8emr7104137b3.29.1732054056663;
        Tue, 19 Nov 2024 14:07:36 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee71379f3dsm19239417b3.120.2024.11.19.14.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:36 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:35 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 06/13] pack-bitmap.c: support bitmap pack-reuse with
 incremental MIDXs
Message-ID: <c8401fa0fbdbf1fe1422cb3105aab2cb8058f331.1732054032.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1732054032.git.me@ttaylorr.com>

In a similar fashion as previous commits in the first phase of
incremental MIDXs, enumerate not just the packs in the current
incremental MIDX layer, but previous ones as well.

Likewise, in reuse_partial_packfile_from_bitmap(), when reusing only a
single pack from a MIDX, use the oldest layer's preferred pack as it is
likely to contain the most amount of reusable sections.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index c2c824347a6..1dddb242434 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2323,7 +2323,8 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		multi_pack_reuse = 0;
 
 	if (multi_pack_reuse) {
-		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
+		struct multi_pack_index *m = bitmap_git->midx;
+		for (i = 0; i < m->num_packs + m->num_packs_in_base; i++) {
 			struct bitmapped_pack pack;
 			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
 				warning(_("unable to load pack: '%s', disabling pack-reuse"),
@@ -2347,14 +2348,18 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 		uint32_t pack_int_id;
 
 		if (bitmap_is_midx(bitmap_git)) {
+			struct multi_pack_index *m = bitmap_git->midx;
 			uint32_t preferred_pack_pos;
 
-			if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0) {
+			while (m->base_midx)
+				m = m->base_midx;
+
+			if (midx_preferred_pack(m, &preferred_pack_pos) < 0) {
 				warning(_("unable to compute preferred pack, disabling pack-reuse"));
 				return;
 			}
 
-			pack = bitmap_git->midx->packs[preferred_pack_pos];
+			pack = nth_midxed_pack(m, preferred_pack_pos);
 			pack_int_id = preferred_pack_pos;
 		} else {
 			pack = bitmap_git->pack;
-- 
2.47.0.301.g77ddd1170f9

