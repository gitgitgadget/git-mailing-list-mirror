Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E7227BA4
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493413; cv=none; b=ESQfUIlhKug4N/CcmHwEX/YNGjW+Cctw0AnHIIMqyLZWnUHPSgKWw68xmXwBX/pirNDjD/5MA95p1lzfJEygylH87+RtEh8y4WGVIKVLMS1CbgzaZU3/WPVKZ4GpoJu9ysL8E+IqhAmA7kPMe1gDizrRScXwU/HIjerINJmGvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493413; c=relaxed/simple;
	bh=eHl+tUd0SY8aMC9cemyOrg5u0gYKk01mG3U8a5l/Uts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUMCq60qTT1aFbfBOTFDZP9PvCoYHMbF5tBpRW95ppa7/FqpG/MgLeUqaObCTPyhfq52n2fRs+jZvrX3PZlSEYQrR1XEfwlqFMfHZJeeOOPT2QacJgSxyc7ywl5ZI21eA72ycaBjLp5B3MuqoKyQA0uOG27sfEFDEXRtEKW8bYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xKSVVFis; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xKSVVFis"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8f05acc13so11955996d6.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493411; x=1743098211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tpast4GBJZkw6YoFfZudb25tTY1DGiStVgtvFabup4Q=;
        b=xKSVVFisIks8STVygS32xoEll4DF7Xc9kEvy5g/wZL15y7yXkNwJslpNwFZ3MPOJ0Z
         9iKOQo/8/k5NKNOXxmLMDsp1MpGJzTxad2Q3s8i+mcT0AuTOh+ycIL1IiiIizQL+Tkg1
         rImKs2EonXP7QoEzPUQT9XCWevQkibxETd1SiAs1rB/1FF4XGPGE9teOXtIHU1gNTJki
         EviG7U2sQmFxo1kLoYEwl7yXEyi2VEup/Xy5tleL+KRFuTGLD+oTDIiOzUMcUL/xkjrO
         aITRd/07gCFhv2KYspwQoKTYelJ1aalCZliuOTuFDn3NpGXra9kLI/BGaP4lGoegvOvR
         C2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493411; x=1743098211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpast4GBJZkw6YoFfZudb25tTY1DGiStVgtvFabup4Q=;
        b=gY2F9rGsTuH2IUWt2r9MzbqD4yMvAQuYxD2Ysx986PjVy6UqOZKdM3b1wlcMtrD31u
         HGA/AbvrwIRE3PS7K8TiFcJMrwaljqEJ3r/unx1XpQCtAdFRpw/saZL+EeLQ3vSUosJK
         QMbSiwjC6FSUT5CgA0fcNAfcjk/PdxzT2kWRhZWtvfA8X8Jla/ou47S982mlBvOd4auG
         zpNplV7/p88JKI/L4h5GxgL1PoTaro2e32MhVrIz4Zs9Sitc1VThOCDYcaMuj+Z4h7vp
         khaOMmURGsfZc1Ewi91bJCnUPbN/3s0V+wFx01W6Uu/wN+/sHdvio4v2D3K8nYGIMgzb
         /kBw==
X-Gm-Message-State: AOJu0YyLummUD6TPM628dyGJ6XEhkFyCZgXtPzDq3IAfmQ5pVJvWf9wO
	CZcaQ+2QagPVBry8VQfSdKwlwfJFB2PIKjv4hgM6TI4PtxJGn6gMoF3IBQ9tr9RI6muxUNJY6E7
	ldyg=
X-Gm-Gg: ASbGncvbKRWJ+Uyv2sU1Gg6WZBVtHV/CBdKZo0OuuhhA8pUEByHoPbdq7YG3ePYZjHT
	ogATExYsf37LY0ZOsP3+lgPkC+Ty6qMUfIjedp9ej4p7L2Ejt32ZC+Uy/WJnzUWeX46pfmsyn60
	zH5kwBFB+70kS1n0Jj7c+W6yF6Ffibb1JQ7FlULewyI59x5l3YgiaeG6r6KemDfifNWnEeh2Kye
	K7MJq5Q7zbeYbbh5ZLkfACzIs/NE/XuV7jpIbF/N77bjleEhef5ss2JnUxi+w09XUNHCu9L527T
	ZvJEhwpJEwfek67ZTI3ixd+CCMJ7WVf1thQ8hqfER/ycNZ/Q8iJ/i4dSlyj7/FO2CFKZ1atRi8D
	ZUI0k9P5TIhY4L/nLFkB9/6C53gE=
X-Google-Smtp-Source: AGHT+IGSXhSREY4oKrydLB8wPk38yGzAQau6U94xVxx/r9DnX6hwDiFEWmarcCmZdHr1nKZsyHcQ7g==
X-Received: by 2002:a05:6214:1249:b0:6e6:6a82:4989 with SMTP id 6a1803df08f44-6eb3f39353emr4695636d6.44.1742493411087;
        Thu, 20 Mar 2025 10:56:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb3ef33e4bsm1121006d6.53.2025.03.20.10.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:56:50 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 09/14] pack-bitmap.c: compute disk-usage with incremental
 MIDXs
Message-ID: <b1bd60d25ddb86721b64eccc8bca75a50aaf9ff9.1742493373.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1742493373.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742493373.git.me@ttaylorr.com>

In a similar fashion as previous commits, use nth_midxed_pack() instead
of accessing the MIDX's ->packs array directly to support incremental
MIDXs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 65ad631ce1..4086277de8 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1779,7 +1779,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 			uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
 			uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
 
-			pack = bitmap_git->midx->packs[pack_id];
+			pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 			ofs = nth_midxed_offset(bitmap_git->midx, midx_pos);
 		} else {
 			pack = bitmap_git->pack;
@@ -3049,7 +3049,7 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 				off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
 
 				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
-				struct packed_git *pack = bitmap_git->midx->packs[pack_id];
+				struct packed_git *pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 
 				if (offset_to_pack_pos(pack, offset, &pack_pos) < 0) {
 					struct object_id oid;
-- 
2.49.0.14.g88b49c1b34

