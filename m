Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3814EC56
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755707; cv=none; b=VlNAWbplwS2pOnogu3mmn7NprF7Txtk/C2CvOi59+ipeMB0+SlEVpoUu6wk72MbSAAxibQ3+BtbS1gYsvCK6obSj+6oZnPpDRbYB+NdJTGuCE3HVxqDXYJUkbIvBPcIKUNtM1g4pX7Z87xuBsFKWoSnVVQmmKmuXZf+wkRI6P/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755707; c=relaxed/simple;
	bh=eM/0xgFO5YXXzInVeE/M5c426U62d6+/sgZyUs+2dGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5J8tWowVdO/8rp3BCftXURhDOBeBg6RPbHQGwWrKa8rOhZHsobt62e9kzFxsf3RPGNa8y7iIZq2KFqX9mOcvn1se27xix00drETNK/MsQEtxLuCGkngvgZbh6q8Vxx3ElS7HbXs2tdMQL9x3GKeMp4fe26z8WddFyqmmaX67SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gKbPNIRi; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gKbPNIRi"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e116b591e15so1425717276.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723755704; x=1724360504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PxIWN2Etecy85LgKdYbI2nyq1L25mosO1gBq/FfF1q0=;
        b=gKbPNIRiF+FmL/kaGRK6y5AMuuxbh25n9fAQ7SlylRJ8hLqaFzCcqqr8uwADuZkFPg
         Ey8ExTFAyx/455+xrLi42bsahWGlfpf8QypCntJjUAPnriwwgm8SX+RAmRxTbJMvDqmV
         dYXLB1Ehm7eIr3BgXV71z9ebgUVGk8IYq1HM9AllzGMSkTF/I8OnFCTDfNXUjSrJfs0s
         ej6ZbvniWi5lvLQagl4rDB+R93YSxndUV+fy+sYetWikj84vJRzkckH1RU+CMaeS1/nk
         sUPI0S1pEKifrtUDcfYYvv7eQBCN9vbjmQa0m040mzkmACspriHPsyqDbPvocnkfK8ze
         bgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755704; x=1724360504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxIWN2Etecy85LgKdYbI2nyq1L25mosO1gBq/FfF1q0=;
        b=uk4OpUzYIdeG3pi/PTRY2SGaU/+JEH6XoqxRpkSvj7Tj/zQMbda7ylVj9rEmLGdW5/
         p1qSHXROcnWMXGHpzh64dqxSX9Q+BWZ5Al1xDbRh4I4VoTbFhda/jiNYWQkB0amnyQKe
         IZ3aaFEr6B4nrMLybTFvVyiV2hhY+6+jmSqf5/5NL7IT7Zh4JMGyVIHCbmGoK/dqSEZs
         N36R47PTATpQ4bFOVTpJ/nqRX6eBg0MTohCGuByKdpPZ/HWr0izjXRXuWE8UcPKLObnQ
         vxT3OEJkJ2caosBRXpXQsenv7rw44jwtAREmvpM9WUrlWmXhYkpoekiwJKtxBVp/mZum
         xNCw==
X-Gm-Message-State: AOJu0Yw5uJ2DMR8tXRqcwjGulkzLSEihuYRMP0hpuJbmmOdYTOlvGXzy
	Iwnl0pl04kPfJZTh8Rja2/GERVGIRBbtXHhP6yW1+FSb3Ahs9cOpm6Mcm8biDZ4I65MwAG4hXPw
	8
X-Google-Smtp-Source: AGHT+IHt457loWs1ur7MfU6ORZxKYXrD+YvwbunGyB/luwJ6EuI4XxdAVXSospbgfcKXthOBgMYp4g==
X-Received: by 2002:a05:6902:160f:b0:e11:7b5b:18d4 with SMTP id 3f1490d57ef6-e1180ec4d76mr1266108276.13.1723755704307;
        Thu, 15 Aug 2024 14:01:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e6fee1sm470446276.33.2024.08.15.14.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:01:44 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:01:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/13] pack-bitmap.c: compute disk-usage with incremental
 MIDXs
Message-ID: <129f55ac285de29b9dc84aa67a58600dcf2ce41c.1723755667.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723755667.git.me@ttaylorr.com>

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5fea2714c1..d3bb78237e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1774,7 +1774,7 @@ static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
 			uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
 			uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
 
-			pack = bitmap_git->midx->packs[pack_id];
+			pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 			ofs = nth_midxed_offset(bitmap_git->midx, midx_pos);
 		} else {
 			pack = bitmap_git->pack;
@@ -3020,7 +3020,7 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 				off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
 
 				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
-				struct packed_git *pack = bitmap_git->midx->packs[pack_id];
+				struct packed_git *pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 
 				if (offset_to_pack_pos(pack, offset, &pack_pos) < 0) {
 					struct object_id oid;
-- 
2.46.0.86.ge766d390f0.dirty

