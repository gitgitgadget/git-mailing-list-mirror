Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A614F100
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755695; cv=none; b=f5pBw+f9kK3SNAbV9Mrd9G78h/pr0qRI6YfylRKasgdlrExqVpqbxnbUGOLRSxjXAm9l9W4ZcFSbCva3exAazgyGDOd4JOheK0LctO4xWv43fMe10QS57jY2SSfVXv/nD/L01yA8XbdTbSG3ymbWkIsdHEqw+czsvvveidX6TnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755695; c=relaxed/simple;
	bh=xzI/Uud9Z0WlQdTf+8ebH6i9bjeXNBU0aFD7QhFZigQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZ389Fh/+pvDhGzyR1HB+j4Nijn7HDYiTkm4AAfFXnbWM566W/miiTidFL7cuAM6yHyHVcrLqlnKLViACKDE+QcKCm9QHRTyp1RuNpo4ZTnaETlto3pvvpXv2uwPIR8vnPRIrwfVEdTf+QPwzkJcyuH7uJP1vIiHdQr2u1j5PFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jx07P7E7; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jx07P7E7"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-64b417e1511so13487047b3.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723755692; x=1724360492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUlApPl07OkhfjwTTTVSsr4uQ1Aev+3QtfB5OTDai5E=;
        b=jx07P7E75W2qAChStNzqGKyUubclp1zNDFMCvYxosKGQJrHcHkvc6/4BfjbezZc+2A
         IOETORTCOv7YP1Drdy5vGz1GgWfR6wjHwxx4Awy/2IXDSBJuHpFq7c2LmsPTIqB5NPY2
         srSlWGh4u+k0D1X72NDWJW62qdgMYvND9tMOLASHrn1Bq94RjYanAyKWg68e+OoeYe8o
         NRFUvt/MJiMiLHUOyy2qz311BWiiNuqNsiBoCuaFgDanjbbT9TkKa7C1Kz5GtZVrB/Pe
         d2u2OOXAQtbVFRZO+DlHltEPTVbNG/1xiDiDgavYYxoKpsNYr91NZ4091RgnMkMCMDtA
         LJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755692; x=1724360492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUlApPl07OkhfjwTTTVSsr4uQ1Aev+3QtfB5OTDai5E=;
        b=h+aSWzLbUM47Gz9vXxP2ZqHUkCt/8JVE/hoUZ2DGT1POZ5HoH+Xmr4aZnFpgUmdxTF
         JSD0b/0d6w6+6ce4zGqrh2P6lueTZ2wlXbJjrQnysr5IRk9J4+iZXaYSKC7WVG6zPbn+
         MbRz/D9xYdO0tc0WFtEqVL1rcg3JEO+mR9rVfz0LnTF0e96kolTDCySkCG0kgu5sFP3g
         gy9IMw2REqsOB2IrCixCRrqexITz65laTJzQwCGxLtHZa6WvXdBmExGIexn7Mck4nH/2
         pAAFwgXISIh5GLJbBlT9J+qBmO/Wl2aBWpmgjhyn5V2CIQxVsJa6gfuGZ6zYfY8F3z4p
         n2Og==
X-Gm-Message-State: AOJu0YxnjK6W0auMVuK5phb2LZ3pSdWpbGT9aNP2nkHRyWZHVDIN89K8
	EI65WhgTznJO83PtKRHeCHKr2n+uwul044hVohVA75qP05yHus/UbH1yPtkK8MZ3l42zUXDu1In
	d
X-Google-Smtp-Source: AGHT+IEhDkwFKQrDR/sHZbQhOKfwNprkTH/HdNhVR0hT7rzzOMWeONaUyxg2NuVTLg1TEqCBln9E8Q==
X-Received: by 2002:a05:690c:4606:b0:6b0:9be1:ecde with SMTP id 00721157ae682-6b1bbf24f09mr7555387b3.27.1723755692543;
        Thu, 15 Aug 2024 14:01:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9e1d9607sm3808007b3.140.2024.08.15.14.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:01:32 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:01:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/13] pack-bitmap.c: teach `bitmap_for_commit()` about
 incremental MIDXs
Message-ID: <44871306487e5c4c93f619b3c81b651cab3099d6.1723755667.git.me@ttaylorr.com>
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

The pack-bitmap machinery uses `bitmap_for_commit()` to locate the
EWAH-compressed bitmap corresponding to some given commit object.

Teach this function about incremental MIDX bitmaps by teaching it to
recur on earlier bitmap layers when it fails to find a given commit in
the current layer.

The changes to do so are as follows:

  - Avoid initializing hash_pos at its declaration, since
    bitmap_for_commit() is now a recursive function and may receive a
    NULL bitmap_index pointer as its first argument.

  - In cases where we would previously return NULL (to indicate that a
    lookup failed and the given bitmap_index does not contain an entry
    corresponding to the given commit), recursively call the function on
    the previous bitmap layer.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index c27383c027..88623d9e06 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -946,18 +946,21 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit)
 {
-	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
-					   commit->object.oid);
+	khiter_t hash_pos;
+	if (!bitmap_git)
+		return NULL;
+
+	hash_pos = kh_get_oid_map(bitmap_git->bitmaps, commit->object.oid);
 	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
 		struct stored_bitmap *bitmap = NULL;
 		if (!bitmap_git->table_lookup)
-			return NULL;
+			return bitmap_for_commit(bitmap_git->base, commit);
 
 		/* this is a fairly hot codepath - no trace2_region please */
 		/* NEEDSWORK: cache misses aren't recorded */
 		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
 		if (!bitmap)
-			return NULL;
+			return bitmap_for_commit(bitmap_git->base, commit);
 		return lookup_stored_bitmap(bitmap);
 	}
 	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
-- 
2.46.0.86.ge766d390f0.dirty

