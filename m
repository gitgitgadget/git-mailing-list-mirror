Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A41411EF
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423392; cv=none; b=aCaWg6l5L1TjPFmw4BQ2IYn3ITYvz22Lqb6Au9GlWWoUDZcdxvhVj158Po9X8pDQBiOzrDAdYfp3CfJMwN2UuGKrrjD54TeXRl1InOSTFK7Von1GmupgD/zcWBqGZCqrJ5QR/zoMU/cdlWGi3+cZo8+Jiir4A62suE5BlkH1f40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423392; c=relaxed/simple;
	bh=R2R3PYNmR8O1rtREDVem/efjKmPJyiGIPUVZ9rL5wdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEoUacioXkzCBcqsTvfX/mmEQJDxdU9twQrsNppdk3Z9swZ4e3teS9X797kALSXpmCVDiJAMN1vpQLaI44dTOXcBiJDOj2V0FqKbKgbHNJ66Z9zd8LWOU+rOdgAzIEnXqTbp3pVYHfUwNmVr/DZDts92P0GKKGCJ6B3k8aEB3/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=yGlih9Ru; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yGlih9Ru"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b4043b7b3so29331026d6.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423390; x=1715028190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/G0CuWAteRaKdhzIRJGhjRw3j94B2GZN9Bg+THSA5jU=;
        b=yGlih9Ru9fAURzzyfWnLpw4fQPhd6WjrXpcl+BCJ+3i4uGcjUPxPSu35YP9rnrBdHE
         u1C/3iV1/BooHNtg47H74FC7XQhiZZZGxzktm7PLn5qcMvMjb8ASklR47YmeWUnULMOX
         NfV1ejHNfF7/9cFlRHq+lXpJHqlOdFAE7X3bFjA56KnpGmXUVZE/hJ5GqVJNC5pe7T8R
         KSGx68IoXd5x9v3MYjK4LD+Vv7yXJYSqXD8cOE6q9vHzNCSR/+8WGwEe3ecm8e1+ljDr
         eqnrSgwiufVWGQxUCCCTCHeH/v+AvpcIqXdXHgwC5RZhoa/Fat2yPBlVecp8/vaTAYJF
         iXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423390; x=1715028190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/G0CuWAteRaKdhzIRJGhjRw3j94B2GZN9Bg+THSA5jU=;
        b=DoHRxfLa6GN7RL7NXb41YSs2uTr/X5WDHL3Wc6MnjD39bh39S7hjDLD95MhVN6gp+J
         A5I7Wu/oNjHwMY9yUX9NtZ2ngwyL9DBtDxbMUB3zaPAT70r/e9jgAlp/ctiDCwhDgqYS
         OEmepl4VKxXt97YB3s5MNbBSOoWfBGRpExMJxyJFi3UNjJdVXxhovgKKLHA+J/yJXrsA
         DdQsNxtqlqwnYkxnQ6k9B8ZPLee4I3dP/KeK2cHjMGL6rVWVYUnxUAfEHAFt7QJaXrU0
         Pg9rScK4ZztzqqM3Se4uNpFQrrImWwIzV/p60UYDTrUPYYtiywMxX2UOG3grBe6SKQ0O
         g67A==
X-Gm-Message-State: AOJu0Yx5OmaAkBPYSkuQEEz9eAq6uO4HTl8iQV+q4onLwNf0lgR50phO
	4e0PJel+IHIJVAMXAPLnD7LA5SPGZ61koBo1EjFH4i0GNrTyDTmfnEu9x0/Ieuo5/TnzugAiKQO
	+qjk=
X-Google-Smtp-Source: AGHT+IGzTxYsC3+bbyL13olmrCn0CIvNoob9x04f3zwMRQEC8kLWnMtlNivk677IzhUepP0MZUJEIw==
X-Received: by 2002:a05:6214:21cd:b0:6a0:cc66:3c74 with SMTP id d13-20020a05621421cd00b006a0cc663c74mr5538036qvh.18.1714423389947;
        Mon, 29 Apr 2024 13:43:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a8-20020a0ce388000000b0069b2064b988sm10788557qvl.131.2024.04.29.13.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:43:09 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:43:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/23] pack-bitmap: move some initialization to
 `bitmap_writer_init()`
Message-ID: <3d7d930b1c5c4d122d8731ef0dc3fc90115573a2.1714422410.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1714422410.git.me@ttaylorr.com>

The pack-bitmap-writer machinery uses a oidmap (backed by khash.h) to
map from commits selected for bitmaps (by OID) to a bitmapped_commit
structure (containing the bitmap itself, among other things like its XOR
offset, etc.)

This map was initialized at the end of `bitmap_writer_build()`. New
entries are added in `pack-bitmap-write.c::store_selected()`, which is
called by the bitmap_builder machinery (which is responsible for
traversing history and generating the actual bitmaps).

Reorganize when this field is initialized and when entries are added to
it so that we can quickly determine whether a commit is a candidate for
pseudo-merge selection, or not (since it was already selected to receive
a bitmap, and thus is ineligible for pseudo-merge inclusion).

The changes are as follows:

  - Introduce a new `bitmap_writer_init()` function which initializes
    the `writer.bitmaps` field (instead of waiting until the end of
    `bitmap_writer_build()`).

  - Add map entries in `push_bitmapped_commit()` (which is called via
    `bitmap_writer_select_commits()`) with OID keys and NULL values to
    track whether or not we *expect* to write a bitmap for some given
    commit.

  - Validate that a NULL entry is found matching the given key when we
    store a selected bitmap.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  1 +
 midx-write.c           |  1 +
 pack-bitmap-write.c    | 23 ++++++++++++++++++-----
 pack-bitmap.h          |  1 +
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5060ce2dfba..2958cdda499 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1339,6 +1339,7 @@ static void write_pack_file(void)
 				    hash_to_hex(hash));
 
 			if (write_bitmap_index) {
+				bitmap_writer_init(the_repository);
 				bitmap_writer_set_checksum(hash);
 				bitmap_writer_build_type_index(
 					&to_pack, written_list, nr_written);
diff --git a/midx-write.c b/midx-write.c
index 469cceaa583..ed5f8b72b9c 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -819,6 +819,7 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[i] = &pdata->objects[i].idx;
 
+	bitmap_writer_init(the_repository);
 	bitmap_writer_show_progress(flags & MIDX_PROGRESS);
 	bitmap_writer_build_type_index(pdata, index, pdata->nr_objects);
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c35bc81d00f..9bc41a9e145 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -46,6 +46,11 @@ struct bitmap_writer {
 
 static struct bitmap_writer writer;
 
+void bitmap_writer_init(struct repository *r)
+{
+	writer.bitmaps = kh_init_oid_map();
+}
+
 void bitmap_writer_show_progress(int show)
 {
 	writer.show_progress = show;
@@ -117,11 +122,20 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 
 static inline void push_bitmapped_commit(struct commit *commit)
 {
+	int hash_ret;
+	khiter_t hash_pos;
+
 	if (writer.selected_nr >= writer.selected_alloc) {
 		writer.selected_alloc = (writer.selected_alloc + 32) * 2;
 		REALLOC_ARRAY(writer.selected, writer.selected_alloc);
 	}
 
+	hash_pos = kh_put_oid_map(writer.bitmaps, commit->object.oid, &hash_ret);
+	if (!hash_ret)
+		die(_("duplicate entry when writing bitmap index: %s"),
+		    oid_to_hex(&commit->object.oid));
+	kh_value(writer.bitmaps, hash_pos) = NULL;
+
 	writer.selected[writer.selected_nr].commit = commit;
 	writer.selected[writer.selected_nr].bitmap = NULL;
 	writer.selected[writer.selected_nr].flags = 0;
@@ -466,14 +480,14 @@ static void store_selected(struct bb_commit *ent, struct commit *commit)
 {
 	struct bitmapped_commit *stored = &writer.selected[ent->idx];
 	khiter_t hash_pos;
-	int hash_ret;
 
 	stored->bitmap = bitmap_to_ewah(ent->bitmap);
 
-	hash_pos = kh_put_oid_map(writer.bitmaps, commit->object.oid, &hash_ret);
-	if (hash_ret == 0)
-		die("Duplicate entry when writing index: %s",
+	hash_pos = kh_get_oid_map(writer.bitmaps, commit->object.oid);
+	if (hash_pos == kh_end(writer.bitmaps))
+		die(_("attempted to store non-selected commit: '%s'"),
 		    oid_to_hex(&commit->object.oid));
+
 	kh_value(writer.bitmaps, hash_pos) = stored;
 }
 
@@ -488,7 +502,6 @@ int bitmap_writer_build(struct packing_data *to_pack)
 	uint32_t *mapping;
 	int closed = 1; /* until proven otherwise */
 
-	writer.bitmaps = kh_init_oid_map();
 	writer.to_pack = to_pack;
 
 	if (writer.show_progress)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 3f96608d5c1..dae2d68a338 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -97,6 +97,7 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *, const struct object_i
 
 off_t get_disk_usage_from_bitmap(struct bitmap_index *, struct rev_info *);
 
+void bitmap_writer_init(struct repository *r);
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(const unsigned char *sha1);
 void bitmap_writer_build_type_index(struct packing_data *to_pack,
-- 
2.45.0.23.gc6f94b99219

