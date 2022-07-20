Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B11FC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 14:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiGTOFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiGTOFU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 10:05:20 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78084E0D3
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 07:05:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b26so26298108wrc.2
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 07:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JWMGsY31T3LEGQ6YK4QNg917rcyopL0Wjhs3P4Ya9Dc=;
        b=lYgk2mtZwB/myg8uAiwN9m0+pOpsLyvvzNaS2WvNKuSDZA2iEdDJgoPGlKFaMLjvBz
         Y1dzLvpRKu0CJ7ouWLJ4Z1eI6L7Admao9niawqVG1WeFNa/blKVbEMyuO8I1RrFg5rD5
         7ViOuwsmDq+r9ovYQyrJ5mu98wHzzZwxp5x3Sm5MkJ1ORp1EnInV38eKtGtMvWbCET9U
         vakdtaR+QdHWVTIkWG+A773UUTDV9BGU1n8WWkm6rYtHWAclIH+8y0GDCPsvk7oAKYJ3
         ND9kb1BrIwdyA3e3PfuZRL5B7+HyJwJCGQ7hWNgouU+2cZ+a0ycsMyAohBU4QBElBD91
         lDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JWMGsY31T3LEGQ6YK4QNg917rcyopL0Wjhs3P4Ya9Dc=;
        b=sakVoQArhk+9fEcYID2d6m3zWG5Ik1LLmwCQNIGHUSDreyaaTvMBvGz/x6Bq66Ykko
         LkdJ5iwO6fuBz9LvsYq+DrL5ZqAitjssahPxI4PmEqHVlK7a+u8jSP2OBqjW8YNG7oDS
         h5Z8Tl/itrnFyomKQj1dcevQ6v74Za2YxU0CxTt1n4V+BP+4NEtZkkzONhCdqKec4dGB
         VWjZX97u2/+w16WxyKT2dugDJhQU9yvvjC4MdNrGRFTnUZYXyH7UrQJduSa5D3L9q/bo
         mLZvEWdgYWv9SJ1P8+xIb2uMocS4KPocJpLf9uXXUcsEDxINdWzn3QWFppOkygAuDc3y
         tc6g==
X-Gm-Message-State: AJIora8chmeYqJhknmoCujcceptrF+CRd9Qa3qy3Vve2/NCR3sTeFTdR
        2WtwUjkLRVUYN01AhhkYjWt0vm956PI=
X-Google-Smtp-Source: AGRyM1vJPWUoi+5myUVbb4TQ7fhtQpwMjwibP0bVV6rh7rqcnHqqS45E6+8K+7O3VuHnqzS7/vnHmg==
X-Received: by 2002:a05:6000:688:b0:21d:f73d:9c6a with SMTP id bo8-20020a056000068800b0021df73d9c6amr16739276wrb.456.1658325917572;
        Wed, 20 Jul 2022 07:05:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay1-20020a05600c1e0100b003a03ae64f57sm2704431wmb.8.2022.07.20.07.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 07:05:17 -0700 (PDT)
Message-Id: <04244fadf5cd1948885a29decb137ff6e88dc3c2.1658325914.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
References: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
        <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 14:05:09 +0000
Subject: [PATCH v4 2/6] pack-bitmap-write.c: write lookup table extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

The bitmap lookup table extension was documented by an earlier
change, but Git does not yet know how to write that extension.

Teach Git to write bitmap lookup table extension. The table contains
the list of `N` <commit_pos, offset, xor_row>` triplets. These
triplets are sorted according to their commit pos (ascending order).
The meaning of each data in the i'th triplet is given below:

  - commit_pos stores commit position (in the pack-index or midx).
    It is a 4 byte network byte order unsigned integer.

  - offset is the position (in the bitmap file) from which that
    commit's bitmap can be read.

  - xor_row is the position of the triplet in the lookup table
    whose bitmap is used to compress this bitmap, or `0xffffffff`
    if no such bitmap exists.

Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 pack-bitmap-write.c | 112 ++++++++++++++++++++++++++++++++++++++++----
 pack-bitmap.h       |   5 +-
 2 files changed, 107 insertions(+), 10 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c43375bd344..9843790cb60 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -650,20 +650,19 @@ static const struct object_id *oid_access(size_t pos, const void *table)
 
 static void write_selected_commits_v1(struct hashfile *f,
 				      struct pack_idx_entry **index,
-				      uint32_t index_nr)
+				      uint32_t index_nr,
+				      off_t *offsets,
+				      uint32_t *commit_positions)
 {
 	int i;
 
 	for (i = 0; i < writer.selected_nr; ++i) {
 		struct bitmapped_commit *stored = &writer.selected[i];
 
-		int commit_pos =
-			oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
+		if (offsets)
+			offsets[i] = hashfile_total(f);
 
-		if (commit_pos < 0)
-			BUG("trying to write commit not in index");
-
-		hashwrite_be32(f, commit_pos);
+		hashwrite_be32(f, commit_positions[i]);
 		hashwrite_u8(f, stored->xor_offset);
 		hashwrite_u8(f, stored->flags);
 
@@ -671,6 +670,81 @@ static void write_selected_commits_v1(struct hashfile *f,
 	}
 }
 
+static int table_cmp(const void *_va, const void *_vb, void *_data)
+{
+	uint32_t *commit_positions = _data;
+	uint32_t a = commit_positions[*(uint32_t *)_va];
+	uint32_t b = commit_positions[*(uint32_t *)_vb];
+
+	if (a > b)
+		return 1;
+	else if (a < b)
+		return -1;
+
+	return 0;
+}
+
+static void write_lookup_table(struct hashfile *f,
+			       struct pack_idx_entry **index,
+			       uint32_t index_nr,
+			       off_t *offsets,
+			       uint32_t *commit_positions)
+{
+	uint32_t i;
+	uint32_t *table, *table_inv;
+
+	ALLOC_ARRAY(table, writer.selected_nr);
+	ALLOC_ARRAY(table_inv, writer.selected_nr);
+
+	for (i = 0; i < writer.selected_nr; i++)
+		table[i] = i;
+
+	/*
+	 * At the end of this sort table[j] = i means that the i'th
+	 * bitmap corresponds to j'th bitmapped commit (among the selected
+	 * commits) in lex order of OIDs.
+	 */
+	QSORT_S(table, writer.selected_nr, table_cmp, commit_positions);
+
+	/* table_inv helps us discover that relationship (i'th bitmap
+	 * to j'th commit by j = table_inv[i])
+	 */
+	for (i = 0; i < writer.selected_nr; i++)
+		table_inv[table[i]] = i;
+
+	trace2_region_enter("pack-bitmap-write", "writing_lookup_table", the_repository);
+	for (i = 0; i < writer.selected_nr; i++) {
+		struct bitmapped_commit *selected = &writer.selected[table[i]];
+		uint32_t xor_offset = selected->xor_offset;
+		uint32_t xor_row;
+
+		if (xor_offset) {
+			/*
+			 * xor_index stores the index (in the bitmap entries)
+			 * of the corresponding xor bitmap. But we need to convert
+			 * this index into lookup table's index. So, table_inv[xor_index]
+			 * gives us the index position w.r.t. the lookup table.
+			 *
+			 * If "k = table[i] - xor_offset" then the xor base is the k'th
+			 * bitmap. `table_inv[k]` gives us the position of that bitmap
+			 * in the lookup table.
+			 */
+			uint32_t xor_index = table[i] - xor_offset;
+			xor_row = table_inv[xor_index];
+		} else {
+			xor_row = 0xffffffff;
+		}
+
+		hashwrite_be32(f, commit_positions[table[i]]);
+		hashwrite_be64(f, (uint64_t)offsets[table[i]]);
+		hashwrite_be32(f, xor_row);
+	}
+	trace2_region_leave("pack-bitmap-write", "writing_lookup_table", the_repository);
+
+	free(table);
+	free(table_inv);
+}
+
 static void write_hash_cache(struct hashfile *f,
 			     struct pack_idx_entry **index,
 			     uint32_t index_nr)
@@ -695,8 +769,10 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 {
 	static uint16_t default_version = 1;
 	static uint16_t flags = BITMAP_OPT_FULL_DAG;
+	off_t *offsets = NULL;
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct hashfile *f;
+	uint32_t *commit_positions = NULL;
 
 	struct bitmap_disk_header header;
 
@@ -715,7 +791,25 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	dump_bitmap(f, writer.trees);
 	dump_bitmap(f, writer.blobs);
 	dump_bitmap(f, writer.tags);
-	write_selected_commits_v1(f, index, index_nr);
+
+	ALLOC_ARRAY(commit_positions, writer.selected_nr);
+	for (uint32_t i = 0; i < writer.selected_nr; ++i) {
+		struct bitmapped_commit *stored = &writer.selected[i];
+		int commit_pos = oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
+
+		if (commit_pos < 0)
+			BUG(_("trying to write commit not in index"));
+
+		commit_positions[i] = commit_pos;
+	}
+
+	if (options & BITMAP_OPT_LOOKUP_TABLE)
+		CALLOC_ARRAY(offsets, index_nr);
+
+	write_selected_commits_v1(f, index, index_nr, offsets, commit_positions);
+
+	if (options & BITMAP_OPT_LOOKUP_TABLE)
+		write_lookup_table(f, index, index_nr, offsets, commit_positions);
 
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
@@ -730,4 +824,6 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 		die_errno("unable to rename temporary bitmap file to '%s'", filename);
 
 	strbuf_release(&tmp_file);
+	free(offsets);
+	free(commit_positions);
 }
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 3d3ddd77345..67a9d0fc303 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -24,8 +24,9 @@ struct bitmap_disk_header {
 #define NEEDS_BITMAP (1u<<22)
 
 enum pack_bitmap_opts {
-	BITMAP_OPT_FULL_DAG = 1,
-	BITMAP_OPT_HASH_CACHE = 4,
+	BITMAP_OPT_FULL_DAG = 0x1,
+	BITMAP_OPT_HASH_CACHE = 0x4,
+	BITMAP_OPT_LOOKUP_TABLE = 0x10,
 };
 
 enum pack_bitmap_flags {
-- 
gitgitgadget

