Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEDA1D6DA8
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054077; cv=none; b=kCIF7OULtoKTNLfV9bAmnsFY0CNoyQobWMdPI2tC7Zt2tapfAFy64EQo6BYLr4NxDuv1j1vatN0gJFFeUBoM+WBMCl4LHOkrUD6S9L9z3Ujx5TLFdcxO4DLDQ6vKH2GAWG9l6Rs4XBpKiRnzWZfSVynf0vdP9LVWPRlr9xGZ7Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054077; c=relaxed/simple;
	bh=Phc5hS9Ti2m+Ynwhi1XGduuU6vd3ydpUjmvLAmIgTRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0y+lgkEiSnlAld11BzGFsYTjn4DTJeOeY1H5XIyKq+GLtGickBQyifoNuHzeQQqqg6KMR9ZOdYwLfYKOyFPaaftKdhP2dvrqyka0a3ufvDkiaBkhXk6wtDe2CDMKwnfGNQIcWXAdfTThcdirCiQ7Hb77G3z6BNofHZbaLlZDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=K3iZGXyn; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="K3iZGXyn"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6eea47d51aeso21981417b3.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 14:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732054075; x=1732658875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ec9dSvR1nUEtHxP8lHIiu4AkBAEkg4ijb3RcNk5UjQ=;
        b=K3iZGXynRXZf+tjRRyxPpnFihpdsgvFRbUgws8QzXg3lkCKvdj/e1ZcFqRynXqBU//
         h/Pf9f9t5BEelzBO0sZXQiSRpAsuzDd6Ryaw65dq0VFoFnUh/wMRXx7fUQQgw516TrWD
         1m+Hb8TNtATrFbTOKQU4EynLeg10aPuCOJOlFocZS2SB8na2Ofxprg2263IYolcJ6JUp
         i5VVq6Dbb006M5UNOz4AWdrBy+Ej0Hen1jYsd11F0JLzEb6n9cudp4O79wtxdjVUHhFD
         35KWCSS5rqposS2OUVpKM0U66a62EFbxxQvlBb7Tu3V7De6M3JyEUeb0LmnBqDr1TCk8
         Unpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732054075; x=1732658875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ec9dSvR1nUEtHxP8lHIiu4AkBAEkg4ijb3RcNk5UjQ=;
        b=R5c+S8dMrp0HF6a5SdBWyJbiMG9TubmatrfVH1ntcWK4DapGY/ccI4lET/RgxR5mTI
         O7AZ0S2NazGUenzWDqNaNY/mQxGcS9kT+UcyTfpGriuZOuEK3XNiZp5A48XsxD+VM+i8
         rgJtX48pFTG3y3nns37YxVv1BpZ/9H9jGzk1mPenHjDCPDRXpWWQ0cA3oqHgwSlhXxTv
         GMockF5bE2aaQZfvifUk42m7OBHSA0aLz2nSKp5XbIZ7RE0JbFHFQRoMJqZW26Ohby/L
         LZab5sL0ahwOT6TlPlBETlyQsGkRnNQe0xVpWQRcHQ4kPkNaszaYSrVnh/if3LZY1DD9
         85yg==
X-Gm-Message-State: AOJu0YxdD8zBHxMYt4iK/gJZpkV/vhkNtdLNSAWKUDcD0L4vXdRPD+Ju
	YBMzLzIOy4Q9rya3wzgS81KeG/Fem+0eC/4ubo6P3VNUsAEqT4BrQLYP8/0f/3RF2z17I0B9PnI
	Y
X-Google-Smtp-Source: AGHT+IHoDMadRrkO+C1/ba+Od+w4HP1767p3lBDX1ZyZwbhH/nYoIaVAyWz0/+0EYNwOeF47jx9mDA==
X-Received: by 2002:a05:690c:9987:b0:6e5:bf26:578 with SMTP id 00721157ae682-6eebd121400mr7604837b3.17.1732054075169;
        Tue, 19 Nov 2024 14:07:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee71381201sm19420027b3.128.2024.11.19.14.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 14:07:54 -0800 (PST)
Date: Tue, 19 Nov 2024 17:07:53 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/13] pack-bitmap.c: use `ewah_or_iterator` for type
 bitmap iterators
Message-ID: <87cb011e7fc283ef34f4554122fb901c1cd87294.1732054032.git.me@ttaylorr.com>
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

Now that we have initialized arrays for each bitmap layer's type bitmaps
in the previous commit, adjust existing callers to use them in
preparation for multi-layered bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 348488e2d9e..83696d834f6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1622,25 +1622,29 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
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
+				      bitmap_git->base_nr);
 		break;
 
 	case OBJ_TREE:
-		ewah_iterator_init(it, bitmap_git->trees);
+		ewah_or_iterator_init(it, bitmap_git->trees_all,
+				      bitmap_git->base_nr);
 		break;
 
 	case OBJ_BLOB:
-		ewah_iterator_init(it, bitmap_git->blobs);
+		ewah_or_iterator_init(it, bitmap_git->blobs_all,
+				      bitmap_git->base_nr);
 		break;
 
 	case OBJ_TAG:
-		ewah_iterator_init(it, bitmap_git->tags);
+		ewah_or_iterator_init(it, bitmap_git->tags_all,
+				      bitmap_git->base_nr);
 		break;
 
 	default:
@@ -1657,7 +1661,7 @@ static void show_objects_for_type(
 	size_t i = 0;
 	uint32_t offset;
 
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t filter;
 
 	struct bitmap *objects = bitmap_git->result;
@@ -1665,7 +1669,7 @@ static void show_objects_for_type(
 	init_type_iterator(&it, bitmap_git, object_type);
 
 	for (i = 0; i < objects->word_alloc &&
-			ewah_iterator_next(&filter, &it); i++) {
+			ewah_or_iterator_next(&filter, &it); i++) {
 		eword_t word = objects->words[i] & filter;
 		size_t pos = (i * BITS_IN_EWORD);
 
@@ -1707,6 +1711,8 @@ static void show_objects_for_type(
 			show_reach(&oid, object_type, 0, hash, pack, ofs);
 		}
 	}
+
+	ewah_or_iterator_free(&it);
 }
 
 static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
@@ -1758,7 +1764,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 {
 	struct eindex *eindex = &bitmap_git->ext_index;
 	struct bitmap *tips;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t mask;
 	uint32_t i;
 
@@ -1775,7 +1781,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	 * packfile.
 	 */
 	for (i = 0, init_type_iterator(&it, bitmap_git, type);
-	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
+	     i < to_filter->word_alloc && ewah_or_iterator_next(&mask, &it);
 	     i++) {
 		if (i < tips->word_alloc)
 			mask &= ~tips->words[i];
@@ -1795,6 +1801,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
+	ewah_or_iterator_free(&it);
 	bitmap_free(tips);
 }
 
@@ -1852,14 +1859,14 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
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
@@ -1887,6 +1894,7 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
+	ewah_or_iterator_free(&it);
 	bitmap_free(tips);
 }
 
@@ -2506,12 +2514,12 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
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
@@ -2523,6 +2531,8 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 			count++;
 	}
 
+	ewah_or_iterator_free(&it);
+
 	return count;
 }
 
@@ -3051,13 +3061,13 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
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
@@ -3098,6 +3108,8 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 		}
 	}
 
+	ewah_or_iterator_free(&it);
+
 	return total;
 }
 
-- 
2.47.0.301.g77ddd1170f9

