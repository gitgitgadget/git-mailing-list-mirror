Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E241411EF
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423399; cv=none; b=g2QqS5HhY9qux9IlLCzhspI6PwGSoyeEUBrFJszuA4IQfYDqRual4NA+BpUS/ZVqikGi70u3L9hNQ9ZacoylvTdEjlLUUo/Qp4nIgdG06KSe1Rx/6loUFWfOlFsQpMn8GFKCPCt4P6AYPkUh/ndGy2xZ328PI04t0YWWv6Ghcxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423399; c=relaxed/simple;
	bh=syWjFrn8ECzEYK9++Z+udP13OjgkpUyW0n6BjqKVB3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaerpeSkRWxlckuBb/3rz0IoiS1cy6Rl/GEyg8C4FedKRrh0ZAxrOyewvtfkhcs51o0Td4ByMuEQsZE+BuM7y4yitpwA6T+T5yoMYywGBwednb+Wmy3dF3iMaHydkxcnl+yPgZdfoRoZlUMI9e2saTqZlFdE21M6l/YjUo2tUAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=eKcaKj6p; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="eKcaKj6p"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c6f6c5bc37so2514905b6e.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423397; x=1715028197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfAXjcEOc8B55XNZDM5wggzSFw6UG91isjhZk5Ttxe8=;
        b=eKcaKj6pyI2AaSzlJTMJ7Sbb3LJssFNeLe244BXCDIsKwfVVmYVMD/BeIEiMttP/05
         LV8mzkd7TOagQO4b++eMlwe6il6auxWP8ZhkaWoDq4VVuoHNw33FSNKQSxe7fBVo9oBy
         HHhFwbVh7mgraSK8ipCGSO476eTdTMkhEqeFo6rdJ8Rq/tmZIb64mqrpQZspHiXLbOP9
         styL556t/5LeNN7K5IzExAoSjoqXUepgw9uUPCCxv8fl6pm/jXMTO67C8C9CQOJlIaOt
         Z9Nsa8Bkz7fo1a5cW0FiSPqR4sEDiU1aFeO8NMYF9rWIWTQFicij6ORjt+uGsb84z2Ge
         zGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423397; x=1715028197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfAXjcEOc8B55XNZDM5wggzSFw6UG91isjhZk5Ttxe8=;
        b=mtLTTo0XypkkyCxgt9sK28G18NQnCo5JVX8fLLKqEugsWwq7rtaeldr7/C9bLEjoeB
         nQKUdV2Dot1j02gTExaGMC6JrsQ/1omZCIQ8buORwLEqIRCSAE0NhGZ+TLn5fWovLGlm
         h0NRnu4DknVcA5aag+obj4W+fr31CJFrsonFwveyiNK0XCOyEmOb5etKPCvw6Z03Nt04
         g1TTrcQsC6AHLEO9lKqePbQaerD86MmChU3xolL386QwV43KaJ1xhOcZG0l2XIDY+BXQ
         05Vtu112fNz4N1JQuixxLLnzlvvcJht0CYVP+y2gfLlLC/DLFTldUfI/5M7s8KROzc6a
         srww==
X-Gm-Message-State: AOJu0Yz/aqW6jk+Zc7RTK6DWPvVOZolXqLhW4drj1H97wXw1IX8wf8db
	m64QowuV4Vw0BzW++mLT9M3wdQqZL+KS1Vu4X+RsW631PcvtxSZIkDdT1N/ih67B4XtChi8jKw3
	0T9c=
X-Google-Smtp-Source: AGHT+IFNx0bbzd6dIiwYvwhvY5zNB3VqSDFjwP3FHOPc9trY6lZux5ebCCiiLFS5pJJvSaWPvgli7A==
X-Received: by 2002:a05:6808:4348:b0:3c8:6957:fbae with SMTP id dx8-20020a056808434800b003c86957fbaemr805714oib.17.1714423396835;
        Mon, 29 Apr 2024 13:43:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o17-20020ae9f511000000b0078f1044bd68sm10536283qkg.50.2024.04.29.13.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:43:16 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:43:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/23] pack-bitmap-write: support storing pseudo-merge
 commits
Message-ID: <ee33a70324589a98c2239530b03cc2d7afbdfb9e.1714422410.git.me@ttaylorr.com>
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
index 9bc41a9e145..fef02cd745a 100644
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
2.45.0.23.gc6f94b99219

