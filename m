Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2912063DF
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983515; cv=none; b=LavtWZqXmLCGEuh/jCst/zzchMnqH99aD+ZZrnPqe0M6exohLyE+AW2AOUvUjtkqBGCxTcGlnFmrxQ4M+29znwSU7vwID4uKUpkiZFfSON1/UsXrwggfFrrrTnDjarjh9zx5ppZH7goNUUF7p8dJy58gmvq12st3VpTm8ncsQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983515; c=relaxed/simple;
	bh=7sc2VSCzxXbXT6QmOm74NwQsLWnqG2atM0MFXsJUaEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is73EcHN8odFhuXciCucF9RV+1eBVW/gXBTeuaeQiCrUQx9I05EpUQMjSUSya3hO9+ulfiGhiIt8LZfDtoyfBqadrQrGvo0Q0zA/T6KQbxf2yhzCTyyo2ZcG8Ca3O8x3zjUQbgBCFJEw60HC+dR/4QkQGx0w73wQ89tqluEgN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ICQZHTU5; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ICQZHTU5"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6eaddbfcbc9so35576766d6.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983513; x=1742588313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YszKF+95vQrFZZnSop7aU9GmTIFgsPqtQnZGrY/czpk=;
        b=ICQZHTU56c7MguRpzyxRy+h98VXfhLn3J5WxfrLU9aODUghir+pJs5cmKZNMBLaea/
         ZBynLBrijlLESdeg69qXDqo8+wCA7aGNSyC85nts0Ebb8L8wAW7hjoQ5/pC8x97MoHrA
         egObIo5Hq/UTCoidN9zwV3AVCJqSj1koLTCypGw4mwYUGvAdR77syqhdORgVgDth0FEH
         buDvKkv2xagHdS5SXvzUpfZq3NnQdmsStxwrRonumzsnmMdYvRnHV/+snY3kmgkGHPRb
         rgIDCfpOr9Aqa0cluIyu+kpldCvZi11IbQQlwEkm/wtzJALTIGKO71M+wnPGM0OBQZgf
         mQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983513; x=1742588313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YszKF+95vQrFZZnSop7aU9GmTIFgsPqtQnZGrY/czpk=;
        b=R1LFzhc0hLsxjlD3Twr+bspFHZ945OLaSPBMVawu/2RpnPURIv+cF/h5nAYl5qvYG9
         BKr26DbX/ahgsh4SklvDS4LE4mpGi0PUly303roNBW4XKduTWzVeYxgg0HJiJ+hTDPs0
         TFFIE+qoSY1sU9Ulc7f79B2AhgMw1zioOtVI6TcLkrlPn5Lx0QMmTJwa/G5DaqPGEXge
         BfLPSlsbNS/by05fXamYcT4Xa7DY4UHdDATx9y7WPfgwj5vE8/+GicLZMW8u7ef4i/Qq
         rE71nYHw0tY2V47iHGnLUy5zbFUXO0KHc9CI4J2/GrIk49g/c9BYf48dfQy4yKITvpC5
         OAuQ==
X-Gm-Message-State: AOJu0YxvxUFFiuB5C+Gu17QwytARWG7zH3LOnxSEBJU5IqPz/IASPMOt
	JupMzVSb56ak+UNGhZeerbVo9DZY36NQhRfmeY9twUNlf/oBx/OHu08pPVeyM1NqEFHvB6X+I+s
	VL4c=
X-Gm-Gg: ASbGncv6vIm2RhKgbfPgkxejVTrh89G2jsMWaOQJ8umUcObId9emusrvZvN+GR+tpXt
	Ux+mHjnEt0Kd7gu6clkB6DkE8FCmRBsgzNDQD6+W/A/8n+0vUOkXGlqmSkQq2DZxDMLxSL0BQlt
	TvWr0AWY0sD5iP7DMEvEh5sVMv/Q7UkhVm67GZ3QD8Sro9ZZ/+BTAiIqd16LWQEjMfFxHQ3IyXd
	Dpkg2+mGiNNT0TNUW63W7WYbYQxVHF3DCPIAaxYeRPT5Y/F96NVmtc0uAJwKRNuLIEwJjdY6qOd
	U5PYpIGjWdNMAa0KASyfzMHLU2bgOkEkfSL5GPwsN0E0R+ulTkrAz1EXlzcJ4tQPuVZ22PV0+LD
	3eedr2iUqQVGATQhg
X-Google-Smtp-Source: AGHT+IFPzikp+5vyue8enY8067dXbNuVpGcRxzuSytrLMjH8xk+PM3GmUcJy+btVzPgrVbNXWC+8Lg==
X-Received: by 2002:ad4:5aaf:0:b0:6d4:25c4:e775 with SMTP id 6a1803df08f44-6eaeaa0646emr55717466d6.15.1741983512809;
        Fri, 14 Mar 2025 13:18:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade23190csm27727826d6.31.2025.03.14.13.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:32 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:18:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 04/13] pack-bitmap.c: teach `bitmap_for_commit()` about
 incremental MIDXs
Message-ID: <832fd0e8dc3a37e36b3d59085e448f8de84ce4b4.1741983492.git.me@ttaylorr.com>
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
index 72fb11d014..615d5de85e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -941,18 +941,21 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
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
2.49.0.13.gd0d564685b

