Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3C1D364C
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054065; cv=none; b=YbHF0d6QKh2B1IJZ6MdB+iyZLCuACaPzmx4sBB31QB3+QXwOyGiZm5wyqd1A3UqiBzVkAkjv/ggHgINvMP88MmDn8s1SR8pOMsJp1S5vLdqc7I2Mo25NqTqYYETWqxXsndzCa+/qSb94md3UbqEnSN2r4iaBCdDuJgiS9BYOmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054065; c=relaxed/simple;
	bh=WyTBvn/VF1hgCHvszKW1yxpmvt8QhV68Zm1NNqovMjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ6SoNyU9IUqEfpB0hqmHaEnlNB8Unyfw4AuDj2Mhz9Wo03zUFn6vSux6Fs/FVnx4tDWQnvyQV+PNOj+zdWXgn9Lp+0Hn8igXQoc+l7la7JsCfsk/he99oUC5Vx72htPwwQlPWlAnFYv80GcqvSZk2bBA4cpqo9Vq1wn8kt6Pxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=FUwxKyR6; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="FUwxKyR6"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e9ed5e57a7so37922117b3.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054063; x=1732658863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jsxR6nmPVvwLMwLFPaXBy5iADcDqti7zezpV8DCDwYA=;
        b=FUwxKyR6cdru9557Spx+2Yiyed7uhDb9eXfI855M3DFmJXknjC4VLWrC0o4IOPeneS
         xCskoNgnqgRAlFJIwTIdezDf25AmySG16ZoMDs7vv13Bkz7N0F9M34M9Z1FBRTuRWi/0
         Z36Q56Rw9cjPv+4ZmR5Aan99VFpuwqodDUxmPZ1cMjbmouJijI3LjeTiZhNtmmb3cDOZ
         avJW1045JUT0opGXlO8oXylDJHBY/Nl6PHKIRqB3xBYeU6yJ8H9MGES2LGvszKsvnQAG
         4LIIa4wMsJX/DETWq764iCnxUKy4qvGDFRdX4Tb9mI3oy4ADarhM/1YIjSo/mqTMTwzf
         FEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054063; x=1732658863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsxR6nmPVvwLMwLFPaXBy5iADcDqti7zezpV8DCDwYA=;
        b=TsOtLbzn9wPC91+QfdijAdC0PHvvAXtvyXRW5O32NBcJjIv2zz/ivXobFSY6kO9m6f
         /AU4EP/wvfAxfdqBnzCgtaK6IwCrdaCl5ECFNyNgrUpeATFvTmORvafn43htVu4el8Wc
         RfFHBrMAmcj4UVzLCWHTnxCCuZm+nginYF40LJ8PxPL0M4uX7NPQNQWa6BxAPKk4nCYK
         MwMwc57Tnz86ra/qfPiWhRGPQMvefcMtkuJk4N1aSOAgvc4MBOJMV7EHzNYZXyL3mo6c
         WkgddsgLtJ13VCSXAzbOHU2Ixy+LtC4H5TDeTpE50YvaWma13oIZTDKI4cmIxZJffxdq
         DAyQ==
X-Gm-Message-State: AOJu0YwyMpjOglxRk7kbMffwiqA0jZV4cR67WfmyldUkumDuyZxuT0Yo
	4kmkpi5Ogr9ktXuU6FleKN2GWkAuuT5MCZfxc7E/Rq6peV+656BfwL9eCgfDyg4KNIW8n5k53ac
	j9bY=
X-Google-Smtp-Source: AGHT+IEVITTq1QEk1dkIw1ELk71/EREN+Vwh488QamYcqGsHfiS8FjtPxHtMPU8bzJTXnzX2y/lJyg==
X-Received: by 2002:a05:690c:74c6:b0:6db:ddea:eab4 with SMTP id 00721157ae682-6eebd2b2385mr7065137b3.37.1732054062869;
        Tue, 19 Nov 2024 14:07:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7129b41fsm19250037b3.34.2024.11.19.14.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:42 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:41 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/13] pack-bitmap.c: compute disk-usage with incremental
 MIDXs
Message-ID: <75d170ce07832a7f31b85f293044b4b32257162a.1732054032.git.me@ttaylorr.com>
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

In a similar fashion as previous commits, use nth_midxed_pack() instead
of accessing the MIDX's ->packs array directly to support incremental
MIDXs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 02864a0e1f7..b48d6b144d8 100644
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
@@ -3025,7 +3025,7 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 				off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
 
 				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
-				struct packed_git *pack = bitmap_git->midx->packs[pack_id];
+				struct packed_git *pack = nth_midxed_pack(bitmap_git->midx, pack_id);
 
 				if (offset_to_pack_pos(pack, offset, &pack_pos) < 0) {
 					struct object_id oid;
-- 
2.47.0.301.g77ddd1170f9

