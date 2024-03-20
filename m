Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5AD85C7D
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972324; cv=none; b=mqHRo06q57F/4V94Fjus3bkabh+5R7TXWqPdxJH0FIwt/+zNy1Ih/ulPwZp0eCrUin+6BtYm91W3+S7ICo8/PIz5X09QgDe1161LN1O7i/mnQlh9VArLr2GQpMYL24zW1tuUrye0ooWevOsyVy3eJP3wy5ZUagCd1YVl4sfgkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972324; c=relaxed/simple;
	bh=eS8y1pkAjcpEenIBs0vAWQqqiSlO2LHKEu9rzZENFis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO3e1AY1YgLH/r/uk8d6Ka+Zkc5A0ZcnEF1MjSUrP6/cBtuJPiWTO7pqb0Q/DUTgXXmV8B9p+7ps8Yki12VdDjsVtX9viG6rEDL8ynLDaLIF7c5xoP1+fbJy/3dwwF2I2J2U5dYRWLogb1/uVx5rEBuO/JzqQAEqhl/epEaf2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kSXhtNBe; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kSXhtNBe"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c387e02f23so239766b6e.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972321; x=1711577121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JLnqUlCtra2tsnBHw7g/af4kQDZfKe5SNCJ3sxG7LG0=;
        b=kSXhtNBe6lExHGZiWz8jePbaPzEBd/6yZCvG/aAqCulAOVh6QVQ1Vh9eeOkyxnlPBB
         VRRjDQ3xGdxZy95uTD6cCL79I0Wpeb3eYeFey+aiDibmtFwDtBisAkvGXZ+pJXFGYk0I
         RC2VuO598pSqBakt7Ifl0uU+c5+Cq2rBhx3A5uLXK3RAc0bEA+KxAAZMkD7d+4NVsQQp
         tokZSpvMzz47MEzQQQdv95YE63V0rFq0WL7MuVDNIZYuFU0KaOHLiL6AiQM94vb2yQDr
         Y7KZx8NNzQGH/1LxSiTQRdzM27K97os8w7YdToGgYub1hJSoHLBMTgu1jlKTg+ZNZwlp
         Y2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972321; x=1711577121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLnqUlCtra2tsnBHw7g/af4kQDZfKe5SNCJ3sxG7LG0=;
        b=AJmnN4bwCwVu2b+vA9vEKhiN3B3n1Vls7hbEha1LlH26CQ8sfbjjVgUm9OEqNQCVfE
         +pwgM9nKpdQwcdMvL0ku57R1/+3Mbz6AG+cCWBXLcZdrodHc+qykJz+oo3Q5qt7ufvU+
         depMBNxtnWUdoo59Fr5ZbPtlqMYSGz1ha4ouayGalO9gP+0MxC1CT4hr/H/G54tfJ8US
         53tv54V/PpoGAfxuSof4v8+82ffb+GVOUOikX2fDNhd6OurazZMyQYvEKo8axVQb9pUi
         SP/Zm3MGn6xXxgxT3h0M+3XGaM1406AdwVTdBgrfoWXLAb6OU6p2xyh8f1CpA7BLO1DL
         h26A==
X-Gm-Message-State: AOJu0YyZfjYM5ARn+zdZLzTFRp4wEcfjRZ2xfcx30SmvCqC495xeWnzq
	rICOXe11OKZFwd+t1TZpHECET6A9a1SmeGktW68jMmdOpAKsXYDBjcrdy6xxP2kL42qBBBt9TAS
	KA+g=
X-Google-Smtp-Source: AGHT+IGZn20D7Sg4BMbjnwsH/3gKHGLUIGwNrXEMkMX5FOpJD9W4Eq9cggQJLHC/T2unYMFFbTTllQ==
X-Received: by 2002:a05:6808:bcd:b0:3c3:7e7a:8236 with SMTP id o13-20020a0568080bcd00b003c37e7a8236mr3768207oik.18.1710972321482;
        Wed, 20 Mar 2024 15:05:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ci10-20020a05622a260a00b00430bd60afa5sm5677713qtb.48.2024.03.20.15.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:21 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/24] pack-bitmap-write: support storing pseudo-merge commits
Message-ID: <7acdee2b5f2eddfb143afa2982f40bb0136ccdd1.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

Prepare to write pseudo-merge bitmaps by annotating individual bitmapped
commits (which are represented by the `bitmapped_commit` structure) with
an extra bit indicating whether or not they are a pseudo-merge.

In subsequent commits, pseudo-merge bitmaps will be generated by
allocating a fake commit node with parents covering the full set of
commits represented by the pseudo-merge bitmap. These commits will be
added to the set of "selected" commits as usual, but will be written
specially instead of being included with the rest of the selected
commits.

Mechanically speaking, there are two parts of this change:

  - The bitmapped_commit struct gets a new bit indicating whether it is
    a pseudo-merge, or an ordinary commit selected for bitmaps.

  - A handful of changes to only write out the non-pseudo-merge commits
    when enumerating through the selected array (see the new
    `bitmap_writer_selected_nr()` function). Pseudo-merge commits appear
    after all non-pseudo-merge commits, so it is safe to enumerate
    through the selected array like so:

        for (i = 0; i < bitmap_writer_selected_nr(); i++)
          if (writer.selected[i].pseudo_merge)
            BUG("unexpected pseudo-merge");

    without encountering the BUG().

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 100 +++++++++++++++++++++++++++++---------------
 pack-bitmap.h       |   1 +
 2 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index ad768959633..b1e8a0ad66d 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -24,7 +24,7 @@ struct bitmapped_commit {
 	struct ewah_bitmap *write_as;
 	int flags;
 	int xor_offset;
-	uint32_t commit_pos;
+	unsigned pseudo_merge : 1;
 };
 
 struct bitmap_writer {
@@ -39,6 +39,8 @@ struct bitmap_writer {
 	struct bitmapped_commit *selected;
 	unsigned int selected_nr, selected_alloc;
 
+	uint32_t pseudo_merges_nr;
+
 	struct progress *progress;
 	int show_progress;
 	unsigned char pack_checksum[GIT_MAX_RAWSZ];
@@ -46,6 +48,11 @@ struct bitmap_writer {
 
 static struct bitmap_writer writer;
 
+static inline int bitmap_writer_selected_nr(void)
+{
+	return writer.selected_nr - writer.pseudo_merges_nr;
+}
+
 void bitmap_writer_init(struct repository *r)
 {
 	writer.bitmaps = kh_init_oid_map();
@@ -120,25 +127,30 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
  * Compute the actual bitmaps
  */
 
-static inline void push_bitmapped_commit(struct commit *commit)
+static void bitmap_writer_push_bitmapped_commit(struct commit *commit,
+						unsigned pseudo_merge)
 {
-	int hash_ret;
-	khiter_t hash_pos;
-
 	if (writer.selected_nr >= writer.selected_alloc) {
 		writer.selected_alloc = (writer.selected_alloc + 32) * 2;
 		REALLOC_ARRAY(writer.selected, writer.selected_alloc);
 	}
 
-	hash_pos = kh_put_oid_map(writer.bitmaps, commit->object.oid, &hash_ret);
-	if (!hash_ret)
-		die(_("duplicate entry when writing bitmap index: %s"),
-		    oid_to_hex(&commit->object.oid));
-	kh_value(writer.bitmaps, hash_pos) = NULL;
+	if (!pseudo_merge) {
+		int hash_ret;
+		khiter_t hash_pos = kh_put_oid_map(writer.bitmaps,
+						   commit->object.oid,
+						   &hash_ret);
+
+		if (!hash_ret)
+			die(_("duplicate entry when writing bitmap index: %s"),
+			    oid_to_hex(&commit->object.oid));
+		kh_value(writer.bitmaps, hash_pos) = NULL;
+	}
 
 	writer.selected[writer.selected_nr].commit = commit;
 	writer.selected[writer.selected_nr].bitmap = NULL;
 	writer.selected[writer.selected_nr].flags = 0;
+	writer.selected[writer.selected_nr].pseudo_merge = pseudo_merge;
 
 	writer.selected_nr++;
 }
@@ -168,16 +180,20 @@ static void compute_xor_offsets(void)
 
 	while (next < writer.selected_nr) {
 		struct bitmapped_commit *stored = &writer.selected[next];
-
 		int best_offset = 0;
 		struct ewah_bitmap *best_bitmap = stored->bitmap;
 		struct ewah_bitmap *test_xor;
 
+		if (stored->pseudo_merge)
+			goto next;
+
 		for (i = 1; i <= MAX_XOR_OFFSET_SEARCH; ++i) {
 			int curr = next - i;
 
 			if (curr < 0)
 				break;
+			if (writer.selected[curr].pseudo_merge)
+				continue;
 
 			test_xor = ewah_pool_new();
 			ewah_xor(writer.selected[curr].bitmap, stored->bitmap, test_xor);
@@ -193,6 +209,7 @@ static void compute_xor_offsets(void)
 			}
 		}
 
+next:
 		stored->xor_offset = best_offset;
 		stored->write_as = best_bitmap;
 
@@ -205,7 +222,8 @@ struct bb_commit {
 	struct bitmap *commit_mask;
 	struct bitmap *bitmap;
 	unsigned selected:1,
-		 maximal:1;
+		 maximal:1,
+		 pseudo_merge:1;
 	unsigned idx; /* within selected array */
 };
 
@@ -243,17 +261,18 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 	revs.first_parent_only = 1;
 
 	for (i = 0; i < writer->selected_nr; i++) {
-		struct commit *c = writer->selected[i].commit;
-		struct bb_commit *ent = bb_data_at(&bb->data, c);
+		struct bitmapped_commit *bc = &writer->selected[i];
+		struct bb_commit *ent = bb_data_at(&bb->data, bc->commit);
 
 		ent->selected = 1;
 		ent->maximal = 1;
+		ent->pseudo_merge = bc->pseudo_merge;
 		ent->idx = i;
 
 		ent->commit_mask = bitmap_new();
 		bitmap_set(ent->commit_mask, i);
 
-		add_pending_object(&revs, &c->object, "");
+		add_pending_object(&revs, &bc->commit->object, "");
 	}
 
 	if (prepare_revision_walk(&revs))
@@ -430,8 +449,13 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 		struct commit *c = prio_queue_get(queue);
 
 		if (old_bitmap && mapping) {
-			struct ewah_bitmap *old = bitmap_for_commit(old_bitmap, c);
+			struct ewah_bitmap *old;
 			struct bitmap *remapped = bitmap_new();
+
+			if (commit->object.flags & BITMAP_PSEUDO_MERGE)
+				old = NULL;
+			else
+				old = bitmap_for_commit(old_bitmap, c);
 			/*
 			 * If this commit has an old bitmap, then translate that
 			 * bitmap and add its bits to this one. No need to walk
@@ -450,12 +474,14 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 		 * Mark ourselves and queue our tree. The commit
 		 * walk ensures we cover all parents.
 		 */
-		pos = find_object_pos(&c->object.oid, &found);
-		if (!found)
-			return -1;
-		bitmap_set(ent->bitmap, pos);
-		prio_queue_put(tree_queue,
-			       repo_get_commit_tree(the_repository, c));
+		if (!(c->object.flags & BITMAP_PSEUDO_MERGE)) {
+			pos = find_object_pos(&c->object.oid, &found);
+			if (!found)
+				return -1;
+			bitmap_set(ent->bitmap, pos);
+			prio_queue_put(tree_queue,
+				       repo_get_commit_tree(the_repository, c));
+		}
 
 		for (p = c->parents; p; p = p->next) {
 			pos = find_object_pos(&p->item->object.oid, &found);
@@ -483,6 +509,9 @@ static void store_selected(struct bb_commit *ent, struct commit *commit)
 
 	stored->bitmap = bitmap_to_ewah(ent->bitmap);
 
+	if (ent->pseudo_merge)
+		return;
+
 	hash_pos = kh_get_oid_map(writer.bitmaps, commit->object.oid);
 	if (hash_pos == kh_end(writer.bitmaps))
 		die(_("attempted to store non-selected commit: '%s'"),
@@ -612,7 +641,7 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 
 	if (indexed_commits_nr < 100) {
 		for (i = 0; i < indexed_commits_nr; ++i)
-			push_bitmapped_commit(indexed_commits[i]);
+			bitmap_writer_push_bitmapped_commit(indexed_commits[i], 0);
 		return;
 	}
 
@@ -645,7 +674,7 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 			}
 		}
 
-		push_bitmapped_commit(chosen);
+		bitmap_writer_push_bitmapped_commit(chosen, 0);
 
 		i += next + 1;
 		display_progress(writer.progress, i);
@@ -683,8 +712,11 @@ static void write_selected_commits_v1(struct hashfile *f,
 {
 	int i;
 
-	for (i = 0; i < writer.selected_nr; ++i) {
+	for (i = 0; i < bitmap_writer_selected_nr(); ++i) {
 		struct bitmapped_commit *stored = &writer.selected[i];
+		if (stored->pseudo_merge)
+			BUG("unexpected pseudo-merge among selected: %s",
+			    oid_to_hex(&stored->commit->object.oid));
 
 		if (offsets)
 			offsets[i] = hashfile_total(f);
@@ -718,10 +750,10 @@ static void write_lookup_table(struct hashfile *f,
 	uint32_t i;
 	uint32_t *table, *table_inv;
 
-	ALLOC_ARRAY(table, writer.selected_nr);
-	ALLOC_ARRAY(table_inv, writer.selected_nr);
+	ALLOC_ARRAY(table, bitmap_writer_selected_nr());
+	ALLOC_ARRAY(table_inv, bitmap_writer_selected_nr());
 
-	for (i = 0; i < writer.selected_nr; i++)
+	for (i = 0; i < bitmap_writer_selected_nr(); i++)
 		table[i] = i;
 
 	/*
@@ -729,16 +761,16 @@ static void write_lookup_table(struct hashfile *f,
 	 * bitmap corresponds to j'th bitmapped commit (among the selected
 	 * commits) in lex order of OIDs.
 	 */
-	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);
+	QSORT_S(table, bitmap_writer_selected_nr(), table_cmp, commit_positions);
 
 	/* table_inv helps us discover that relationship (i'th bitmap
 	 * to j'th commit by j = table_inv[i])
 	 */
-	for (i = 0; i < writer.selected_nr; i++)
+	for (i = 0; i < bitmap_writer_selected_nr(); i++)
 		table_inv[table[i]] = i;
 
 	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
-	for (i = 0; i < writer.selected_nr; i++) {
+	for (i = 0; i < bitmap_writer_selected_nr(); i++) {
 		struct bitmapped_commit *selected = &writer.selected[table[i]];
 		uint32_t xor_offset = selected->xor_offset;
 		uint32_t xor_row;
@@ -809,7 +841,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
 	header.version = htons(default_version);
 	header.options = htons(flags | options);
-	header.entry_count = htonl(writer.selected_nr);
+	header.entry_count = htonl(bitmap_writer_selected_nr());
 	hashcpy(header.checksum, writer.pack_checksum);
 
 	hashwrite(f, &header, sizeof(header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz);
@@ -821,9 +853,9 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
 		CALLOC_ARRAY(offsets, index_nr);
 
-	ALLOC_ARRAY(commit_positions, writer.selected_nr);
+	ALLOC_ARRAY(commit_positions, bitmap_writer_selected_nr());
 
-	for (i = 0; i < writer.selected_nr; i++) {
+	for (i = 0; i < bitmap_writer_selected_nr(); i++) {
 		struct bitmapped_commit *stored = &writer.selected[i];
 		int commit_pos = oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index dae2d68a338..ca9acd2f735 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -21,6 +21,7 @@ struct bitmap_disk_header {
 	unsigned char checksum[GIT_MAX_RAWSZ];
 };
 
+#define BITMAP_PSEUDO_MERGE (1u<<21)
 #define NEEDS_BITMAP (1u<<22)
 
 /*
-- 
2.44.0.303.g1dc5e5b124c

