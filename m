Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430D2066E5
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983541; cv=none; b=QbQZPrMGZussW81gyz9GPCZrY9iRt+dKyXoyLdy/IhiQ55pyK0H9/XJ24pAvmrheulNnsMGEt4QQ0cKhncnca3RszLmVTHg7y6ezHFj9HztaqydJxaeCVyRi+0zS25BfGMNqZ5JHbS6duD9clarI2p9mxq3WNB8ggmyucECbsY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983541; c=relaxed/simple;
	bh=/bu6KGzgR8fHXsbbS4P3fTttwzBY9K58GIjhsPqtaU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPLWlAtVhbE7eVTRg+fD7fEbQEzZt7J0GPv9sNyFQCH85uYX/df5ftNUywpbog+VZJAFh81bOCsmu8zCHcmQ2HKqF/s2cDNcmqRyK2bM8VlZtgh0jhpR3c1fPOHI6DnZ4NRUsCPDVSXAvXk1WOV4YzPM1f6CEHSkSNJewU+GX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iVmVQMTo; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iVmVQMTo"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476a720e806so22307841cf.0
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741983538; x=1742588338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aQyAqbdmyme6Qp/tL9FNrqeA6P9nUXQjtQWkQCnZUsQ=;
        b=iVmVQMTo5Rur2qTTTRq/mReq97AS4guifHcP/qY685redzIXDNd5Kk6xdcgx6+V9bx
         9WcAhkavFl2ePlEznGVKbtuWJGwtnO7IQ22xQ7mjRkJ9bZryuLo0eCx9DHa3LbVQupVZ
         xdi+hRwB/MYBHJjvh84JyP33lalPjNL85BmxD2A6LeCHUkd+Lhc+1IY7oKO45DL1DBAY
         TimLaLe7BmA/NPwKWKGBTuyJoB9vFOS2lpUug2nPmK9zOGxo5W6NJIp1SpdkXwKxn5Ss
         /86fpqy2rs2N5g7ZY03aq4gguyjq9LEMG8lFwS9ppiPGFJnri41uyiJEG25AYAQG80E4
         Tx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741983538; x=1742588338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQyAqbdmyme6Qp/tL9FNrqeA6P9nUXQjtQWkQCnZUsQ=;
        b=hrMKSta8dmGM3ujBtfRSnqQPqwM7Q2p7C0VHS8vyL5k4VWozgCQpDTWRknTXv7GgRO
         WugOkhfWdvveaNAU37EZvD/LeClwQoU0rZzUar2130pOUHqWFSNiMV677VyETymzobMU
         Ww0VhN6OK785XfUF1okGV2Rf9f9b/k2ZVU4Rgz5ULcS7+B7GETie7ozEr3eFxM97p3+M
         +gwIm1iKAzprSl4u26Wol9sBrbYjicgd6EELHypWN74ibTliip/nCmBo6zVfRm7oY7RY
         AosiE+rMaTrOueJikLYCHvVq4V3DjtxUIEJEPcqJAvVea8RvDc2hlxUD6rFRV+IywPC1
         FVpQ==
X-Gm-Message-State: AOJu0Yyg5Nj5AeSOtT7MSWiAEmpQBic59buzO4A7fofZB03ciQbrBoVU
	TvzwiJAdThvxymdLU61ofiI8j1O4Iwp2sOFHg4srMLIC4MCalFIGzqk6Wvt0poC9ogBfKpgK9vH
	ld7Q=
X-Gm-Gg: ASbGncvRDG+YjPHLpeOrVpjBvjJVTXe+q8HbghAsxik8Uc5/Uz/sCvHz1F6sIS2T7Rn
	kV+hTUfMNd6hapEX8vdvJ/ufGklKQz33ktNwPVB06wPuHq0Ae8uJclpNY58BIaxnajT5FY+/6NY
	sNnPVrxbBGOMp6oAQe7+k9C+6xgg9YbpIEoGrKLC1QCD/Vf0BSR2AFODIirQvl7jm/y9fRpSgtk
	foslIa6cWtBGbJ5B7y0tLpXJVTyBCN5op5pt+IFTlD8Grm6rRz9loySWxV7FkbltyrYBlJI4SNJ
	H4GLQVv38uGgQyWByHSSBVy7C6+zhWaTAX2XfANTAzDQjruBhelm546U5QquCyQYXpzc5Vce8Ot
	E/iC3lKPqryHEmJCIn5/6Eo0DfIU=
X-Google-Smtp-Source: AGHT+IHvCrSQO307EtKOR/giHS5+84aUWBZOggS+lxuQ6LXNdU1CsbCLSuiGG+f7VE7npxuYP8G2yQ==
X-Received: by 2002:a05:622a:178c:b0:476:790c:73a7 with SMTP id d75a77b69052e-476c81c3807mr50601361cf.40.1741983538277;
        Fri, 14 Mar 2025 13:18:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb6370aasm27057511cf.20.2025.03.14.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 13:18:58 -0700 (PDT)
Date: Fri, 14 Mar 2025 16:18:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 12/13] pack-bitmap.c: use `ewah_or_iterator` for type
 bitmap iterators
Message-ID: <a1cf65bedc94ab6e318ff81a6d48eb30b6fc7868.1741983492.git.me@ttaylorr.com>
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

Now that we have initialized arrays for each bitmap layer's type bitmaps
in the previous commit, adjust existing callers to use them in
preparation for multi-layered bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3517972892..5e6d4ace58 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1629,25 +1629,29 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 	}
 }
 
-static void init_type_iterator(struct ewah_iterator *it,
+static void init_type_iterator(struct ewah_or_iterator *it,
 			       struct bitmap_index *bitmap_git,
 			       enum object_type type)
 {
 	switch (type) {
 	case OBJ_COMMIT:
-		ewah_iterator_init(it, bitmap_git->commits);
+		ewah_or_iterator_init(it, bitmap_git->commits_all,
+				      bitmap_git->base_nr + 1);
 		break;
 
 	case OBJ_TREE:
-		ewah_iterator_init(it, bitmap_git->trees);
+		ewah_or_iterator_init(it, bitmap_git->trees_all,
+				      bitmap_git->base_nr + 1);
 		break;
 
 	case OBJ_BLOB:
-		ewah_iterator_init(it, bitmap_git->blobs);
+		ewah_or_iterator_init(it, bitmap_git->blobs_all,
+				      bitmap_git->base_nr + 1);
 		break;
 
 	case OBJ_TAG:
-		ewah_iterator_init(it, bitmap_git->tags);
+		ewah_or_iterator_init(it, bitmap_git->tags_all,
+				      bitmap_git->base_nr + 1);
 		break;
 
 	default:
@@ -1664,7 +1668,7 @@ static void show_objects_for_type(
 	size_t i = 0;
 	uint32_t offset;
 
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t filter;
 
 	struct bitmap *objects = bitmap_git->result;
@@ -1672,7 +1676,7 @@ static void show_objects_for_type(
 	init_type_iterator(&it, bitmap_git, object_type);
 
 	for (i = 0; i < objects->word_alloc &&
-			ewah_iterator_next(&filter, &it); i++) {
+			ewah_or_iterator_next(&filter, &it); i++) {
 		eword_t word = objects->words[i] & filter;
 		size_t pos = (i * BITS_IN_EWORD);
 
@@ -1714,6 +1718,8 @@ static void show_objects_for_type(
 			show_reach(&oid, object_type, 0, hash, pack, ofs);
 		}
 	}
+
+	ewah_or_iterator_free(&it);
 }
 
 static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
@@ -1765,7 +1771,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 {
 	struct eindex *eindex = &bitmap_git->ext_index;
 	struct bitmap *tips;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t mask;
 	uint32_t i;
 
@@ -1782,7 +1788,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	 * packfile.
 	 */
 	for (i = 0, init_type_iterator(&it, bitmap_git, type);
-	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
+	     i < to_filter->word_alloc && ewah_or_iterator_next(&mask, &it);
 	     i++) {
 		if (i < tips->word_alloc)
 			mask &= ~tips->words[i];
@@ -1802,6 +1808,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
+	ewah_or_iterator_free(&it);
 	bitmap_free(tips);
 }
 
@@ -1861,14 +1868,14 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 {
 	struct eindex *eindex = &bitmap_git->ext_index;
 	struct bitmap *tips;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t mask;
 	uint32_t i;
 
 	tips = find_tip_objects(bitmap_git, tip_objects, OBJ_BLOB);
 
 	for (i = 0, init_type_iterator(&it, bitmap_git, OBJ_BLOB);
-	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
+	     i < to_filter->word_alloc && ewah_or_iterator_next(&mask, &it);
 	     i++) {
 		eword_t word = to_filter->words[i] & mask;
 		unsigned offset;
@@ -1896,6 +1903,7 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
+	ewah_or_iterator_free(&it);
 	bitmap_free(tips);
 }
 
@@ -2527,12 +2535,12 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 	struct eindex *eindex = &bitmap_git->ext_index;
 
 	uint32_t i = 0, count = 0;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t filter;
 
 	init_type_iterator(&it, bitmap_git, type);
 
-	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
+	while (i < objects->word_alloc && ewah_or_iterator_next(&filter, &it)) {
 		eword_t word = objects->words[i++] & filter;
 		count += ewah_bit_popcount64(word);
 	}
@@ -2544,6 +2552,8 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 			count++;
 	}
 
+	ewah_or_iterator_free(&it);
+
 	return count;
 }
 
@@ -3076,13 +3086,13 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 {
 	struct bitmap *result = bitmap_git->result;
 	off_t total = 0;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t filter;
 	size_t i;
 
 	init_type_iterator(&it, bitmap_git, object_type);
 	for (i = 0; i < result->word_alloc &&
-			ewah_iterator_next(&filter, &it); i++) {
+			ewah_or_iterator_next(&filter, &it); i++) {
 		eword_t word = result->words[i] & filter;
 		size_t base = (i * BITS_IN_EWORD);
 		unsigned offset;
@@ -3123,6 +3133,8 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 		}
 	}
 
+	ewah_or_iterator_free(&it);
+
 	return total;
 }
 
-- 
2.49.0.13.gd0d564685b

