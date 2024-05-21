Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6E14901C
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318144; cv=none; b=J8cZEJSMLABr+LRk/EkLQ+mf93klH398kCXGTy/eYODkgHbLbXokv0OfDJRFJAbl4uVjmzPPeU0xL51EsKekgWkTY5m9hYu+E+wCGFqDpcqREh7d3r23z7aW2QqHBBLm+An+v2EvzMSES4YuwWuJG03jUTwXZh8pMOlScsfHTPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318144; c=relaxed/simple;
	bh=oOPfbLnXz/93bf5uliFqIyy3joKZQahCZ2xtXAUujZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzQQkJ60GMPUsXnHn9Ex96rzDjo7IDZzr32nxu7SpHekTdNPjWedArPYIi8yjVVZJBrTKR50Gg2jL1F94qAa50ycIGg3w3YSxVBLthALhjyBk5+v37C4oUMxFMTD1sQ5MY/pdTFXnI0NNRG8B+z9CgiXFCrqf1ieVthql1MCyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=YRcbMv2m; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="YRcbMv2m"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-792b8d30075so350921785a.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318141; x=1716922941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M81yiR6WqmUQJyuDk+DWkGm6R/Cyxuqu+GvfG19fZKo=;
        b=YRcbMv2mO3SQUQLDPWDu9f9mvAbk+kO3GIcaVVycJCOk15JVDvCvN8CB2Jp9nSFyH9
         ZdjSxbDhHNbH53vc7VGEtKEj5S3pVfAtgQf1C6UUix1ZaH/ppAzBQ7ZOPMi4cgRVZdOe
         BWKnhs7/bNXclsj0rZbMDWL6QmEVOFOWn2yEqItRMn1d699PWRCy+pnr6Yn5UCcl9PNC
         OAbGHYbkgbBMM5WGndNl9BqPA5CdrhYK7Dk9ehiBqMwkQUpPvAfV8FQE4PylX9hXM9HC
         iBC73HYIWYfOrBf+XAVcIPZY0nuezQ+W7D8nbSZIjmXtcRdXTHI4Q/85IMJgyjmriZv1
         VVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318141; x=1716922941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M81yiR6WqmUQJyuDk+DWkGm6R/Cyxuqu+GvfG19fZKo=;
        b=Q6P/fswfBqykPnbmkpF35yah/O5MSTBkxCxJvLD7AVU9eQojLNhqZ67SBz/4gg2FHI
         5b92Nfn+QV8OnFFXdza2QPepSp+XuSlswrHGBU3fbIEJr5HEe7jHkx0J4kcHO0v/fQks
         vMzs0w9+IML/T/w3LX4X2pE2Um7ejDDisJPWHQ5qEHNW3esqYVfLpMWxXYSRzPC802Jx
         JnfebudsIIJqTAfj2HGhnxfCUgKwfzNTol6fNJDNh14FGnPy308/W6/OerdMohaFI0k7
         WMrYKdmaWJ35acSxFWdxQ76mPVrUgCwPAvzjeIh/34xyfL16VGGGjG12S/32WDC7WgUw
         SgEw==
X-Gm-Message-State: AOJu0Yz27+URtWprMQtEZRVS731AreVD5uJq+9ZsT9nJ9zKkg6gFCJQR
	vC/8UTIsbPFCvvWtsMepRDguIYDJoPj4uMdCJhMFKVH0T+LkzCOAd7KM1petIY78QeBOzf+9h9H
	E
X-Google-Smtp-Source: AGHT+IFEquH0rw2fdh7ivCwgZyAURqCuOTHXSQJuGIpXLCtuxMOSmI5Hiiy+6LnYwz/v18826x0Qjw==
X-Received: by 2002:a05:620a:298a:b0:792:cd45:8e2b with SMTP id af79cd13be357-792cd459433mr3866093585a.78.1716318141032;
        Tue, 21 May 2024 12:02:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7948e9baa51sm124636285a.5.2024.05.21.12.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:20 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/30] pack-bitmap-write: support storing pseudo-merge
 commits
Message-ID: <8608dd1860fd332655b7977b30a6cb79e78b692b.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

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
 object.h            |  2 +-
 pack-bitmap-write.c | 96 +++++++++++++++++++++++++++++----------------
 pack-bitmap.h       |  3 ++
 3 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/object.h b/object.h
index 99b9c8f114c..e6f9e89d3c5 100644
--- a/object.h
+++ b/object.h
@@ -81,7 +81,7 @@ void object_array_init(struct object_array *array);
  * reflog.c:                           10--12
  * builtin/show-branch.c:    0-------------------------------------------26
  * builtin/unpack-objects.c:                                 2021
- * pack-bitmap.h:                                                22
+ * pack-bitmap.h:                                              2122
  */
 #define FLAG_BITS  28
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index d8870155831..60eb1e71c98 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -25,8 +25,14 @@ struct bitmapped_commit {
 	int flags;
 	int xor_offset;
 	uint32_t commit_pos;
+	unsigned pseudo_merge : 1;
 };
 
+static inline int bitmap_writer_nr_selected_commits(struct bitmap_writer *writer)
+{
+	return writer->selected_nr - writer->pseudo_merges_nr;
+}
+
 void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r)
 {
 	memset(writer, 0, sizeof(struct bitmap_writer));
@@ -129,27 +135,31 @@ void bitmap_writer_build_type_index(struct bitmap_writer *writer,
  */
 
 static inline void push_bitmapped_commit(struct bitmap_writer *writer,
-					 struct commit *commit)
+					 struct commit *commit,
+					 unsigned pseudo_merge)
 {
-	int hash_ret;
-	khiter_t hash_pos;
-
 	if (writer->selected_nr >= writer->selected_alloc) {
 		writer->selected_alloc = (writer->selected_alloc + 32) * 2;
 		REALLOC_ARRAY(writer->selected, writer->selected_alloc);
 	}
 
-	hash_pos = kh_put_oid_map(writer->bitmaps, commit->object.oid,
-				  &hash_ret);
-	if (!hash_ret)
-		die(_("duplicate entry when writing bitmap index: %s"),
-		    oid_to_hex(&commit->object.oid));
-	kh_value(writer->bitmaps, hash_pos) = NULL;
+	if (!pseudo_merge) {
+		int hash_ret;
+		khiter_t hash_pos = kh_put_oid_map(writer->bitmaps,
+						   commit->object.oid,
+						   &hash_ret);
+
+		if (!hash_ret)
+			die(_("duplicate entry when writing bitmap index: %s"),
+			    oid_to_hex(&commit->object.oid));
+		kh_value(writer->bitmaps, hash_pos) = NULL;
+	}
 
 	writer->selected[writer->selected_nr].commit = commit;
 	writer->selected[writer->selected_nr].bitmap = NULL;
 	writer->selected[writer->selected_nr].write_as = NULL;
 	writer->selected[writer->selected_nr].flags = 0;
+	writer->selected[writer->selected_nr].pseudo_merge = pseudo_merge;
 
 	writer->selected_nr++;
 }
@@ -180,16 +190,20 @@ static void compute_xor_offsets(struct bitmap_writer *writer)
 
 	while (next < writer->selected_nr) {
 		struct bitmapped_commit *stored = &writer->selected[next];
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
+			if (writer->selected[curr].pseudo_merge)
+				continue;
 
 			test_xor = ewah_pool_new();
 			ewah_xor(writer->selected[curr].bitmap, stored->bitmap, test_xor);
@@ -205,6 +219,7 @@ static void compute_xor_offsets(struct bitmap_writer *writer)
 			}
 		}
 
+next:
 		stored->xor_offset = best_offset;
 		stored->write_as = best_bitmap;
 
@@ -217,7 +232,8 @@ struct bb_commit {
 	struct bitmap *commit_mask;
 	struct bitmap *bitmap;
 	unsigned selected:1,
-		 maximal:1;
+		 maximal:1,
+		 pseudo_merge:1;
 	unsigned idx; /* within selected array */
 };
 
@@ -255,17 +271,18 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
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
@@ -444,8 +461,13 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
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
@@ -464,12 +486,14 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 		 * Mark ourselves and queue our tree. The commit
 		 * walk ensures we cover all parents.
 		 */
-		pos = find_object_pos(writer, &c->object.oid, &found);
-		if (!found)
-			return -1;
-		bitmap_set(ent->bitmap, pos);
-		prio_queue_put(tree_queue,
-			       repo_get_commit_tree(the_repository, c));
+		if (!(c->object.flags & BITMAP_PSEUDO_MERGE)) {
+			pos = find_object_pos(writer, &c->object.oid, &found);
+			if (!found)
+				return -1;
+			bitmap_set(ent->bitmap, pos);
+			prio_queue_put(tree_queue,
+				       repo_get_commit_tree(the_repository, c));
+		}
 
 		for (p = c->parents; p; p = p->next) {
 			pos = find_object_pos(writer, &p->item->object.oid,
@@ -499,6 +523,9 @@ static void store_selected(struct bitmap_writer *writer,
 
 	stored->bitmap = bitmap_to_ewah(ent->bitmap);
 
+	if (ent->pseudo_merge)
+		return;
+
 	hash_pos = kh_get_oid_map(writer->bitmaps, commit->object.oid);
 	if (hash_pos == kh_end(writer->bitmaps))
 		die(_("attempted to store non-selected commit: '%s'"),
@@ -631,7 +658,7 @@ void bitmap_writer_select_commits(struct bitmap_writer *writer,
 
 	if (indexed_commits_nr < 100) {
 		for (i = 0; i < indexed_commits_nr; ++i)
-			push_bitmapped_commit(writer, indexed_commits[i]);
+			push_bitmapped_commit(writer, indexed_commits[i], 0);
 		return;
 	}
 
@@ -664,7 +691,7 @@ void bitmap_writer_select_commits(struct bitmap_writer *writer,
 			}
 		}
 
-		push_bitmapped_commit(writer, chosen);
+		push_bitmapped_commit(writer, chosen, 0);
 
 		i += next + 1;
 		display_progress(writer->progress, i);
@@ -701,8 +728,11 @@ static void write_selected_commits_v1(struct bitmap_writer *writer,
 {
 	int i;
 
-	for (i = 0; i < writer->selected_nr; ++i) {
+	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); ++i) {
 		struct bitmapped_commit *stored = &writer->selected[i];
+		if (stored->pseudo_merge)
+			BUG("unexpected pseudo-merge among selected: %s",
+			    oid_to_hex(&stored->commit->object.oid));
 
 		if (offsets)
 			offsets[i] = hashfile_total(f);
@@ -735,10 +765,10 @@ static void write_lookup_table(struct bitmap_writer *writer, struct hashfile *f,
 	uint32_t i;
 	uint32_t *table, *table_inv;
 
-	ALLOC_ARRAY(table, writer->selected_nr);
-	ALLOC_ARRAY(table_inv, writer->selected_nr);
+	ALLOC_ARRAY(table, bitmap_writer_nr_selected_commits(writer));
+	ALLOC_ARRAY(table_inv, bitmap_writer_nr_selected_commits(writer));
 
-	for (i = 0; i < writer->selected_nr; i++)
+	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++)
 		table[i] = i;
 
 	/*
@@ -746,16 +776,16 @@ static void write_lookup_table(struct bitmap_writer *writer, struct hashfile *f,
 	 * bitmap corresponds to j'th bitmapped commit (among the selected
 	 * commits) in lex order of OIDs.
 	 */
-	QSORT_S(table, writer->selected_nr, table_cmp, writer);
+	QSORT_S(table, bitmap_writer_nr_selected_commits(writer), table_cmp, writer);
 
 	/* table_inv helps us discover that relationship (i'th bitmap
 	 * to j'th commit by j = table_inv[i])
 	 */
-	for (i = 0; i < writer->selected_nr; i++)
+	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++)
 		table_inv[table[i]] = i;
 
 	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
-	for (i = 0; i < writer->selected_nr; i++) {
+	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++) {
 		struct bitmapped_commit *selected = &writer->selected[table[i]];
 		uint32_t xor_offset = selected->xor_offset;
 		uint32_t xor_row;
@@ -827,7 +857,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
 	header.version = htons(default_version);
 	header.options = htons(flags | options);
-	header.entry_count = htonl(writer->selected_nr);
+	header.entry_count = htonl(bitmap_writer_nr_selected_commits(writer));
 	hashcpy(header.checksum, writer->pack_checksum);
 
 	hashwrite(f, &header, sizeof(header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz);
@@ -839,7 +869,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
 		CALLOC_ARRAY(offsets, index_nr);
 
-	for (i = 0; i < writer->selected_nr; i++) {
+	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++) {
 		struct bitmapped_commit *stored = &writer->selected[i];
 		int commit_pos = oid_pos(&stored->commit->object.oid, index,
 					 index_nr, oid_access);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index f87e60153dd..6937a0f090f 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -21,6 +21,7 @@ struct bitmap_disk_header {
 	unsigned char checksum[GIT_MAX_RAWSZ];
 };
 
+#define BITMAP_PSEUDO_MERGE (1u<<21)
 #define NEEDS_BITMAP (1u<<22)
 
 /*
@@ -109,6 +110,8 @@ struct bitmap_writer {
 	struct bitmapped_commit *selected;
 	unsigned int selected_nr, selected_alloc;
 
+	uint32_t pseudo_merges_nr;
+
 	struct progress *progress;
 	int show_progress;
 	unsigned char pack_checksum[GIT_MAX_RAWSZ];
-- 
2.45.1.175.gbea44add9db

