Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1CCC433EF
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 08:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiGDIqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiGDIq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 04:46:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9730ABC2A
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 01:46:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id s1so12389437wra.9
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iWsWbVbKiAMPgQJw4w7yUcaZRq61bkJ/WC0E8Z3RVGI=;
        b=KbHn4pWXBlt6FVefeegV/mW82tMGVd75ccVOqcw4uwny5z86tDRhBT7LHt7gEIKT58
         iE/ocg3RnojhMgEsgRENnKxlAqI5eHEa6/f4SeGUBJIFtFGwckZbgkyFXD3sBOoI7LwW
         twRXv9kiGM8Z7i0dEsFzcyN0vPmSprshAMPSRCM9UKZLPbigi++cv0yYlWZtWA4SQo1b
         MbfpQJYMmyLXoui12D3q3QMjKVGeSz6WXFRrAlXkTupa9LPKzehjoyDI9mkVG34Vr40O
         WnEJbhv6lp3wk7EbvmHAKM9/mm1N5Q0Ha2GK/9iaF2T9M5w6ZFJEVe58NWB//yH+Juoy
         1igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iWsWbVbKiAMPgQJw4w7yUcaZRq61bkJ/WC0E8Z3RVGI=;
        b=L0zkx9s4ZINBLug2uWJ91XxOkN/P5mcWd748jyP/GDAatK1s44eh9aLkzaz+xEaBr2
         LG/mkIW0m1DBxq677RcZWc30CwYXPE7XJU7cZZ35OFbZI++X+5j60ChVv7fXzE0EAGBH
         1HdyrBZPBq3b1ULgFPItgzjDWocKUJp2YmM/sq9tWh9OEDO7fSk4FW5i9Vrq2YbbO5Ih
         CGgvNKMN0Jo1p2VQL0xNg/7ZhwG4DR03jZarHgN8ujNFqgP6W+2NXw16gtJluQ+LUx6L
         XRBZvfGIlfbyp0nyzWezKN/5IpFcWF1zwzXOxfsrHpyL/VhBrGHfoHZ520jocPPi+4dA
         CEuA==
X-Gm-Message-State: AJIora+P8L4YqkVdgl+3jYKxxCjUpsQhvPQj0VRagYEs83NXW6ND0kAh
        xVNhIfzPL2LKhGlML8+YhYeT7Kp98BY=
X-Google-Smtp-Source: AGRyM1tS8cMGHxshZM517OeffRQhFrruVyMOpCazYvSOXryxz48P5mxrm+usfn4ZyAF/SzoyHnxSdQ==
X-Received: by 2002:a05:6000:991:b0:21b:b7b1:ac50 with SMTP id by17-20020a056000099100b0021bb7b1ac50mr25916500wrb.718.1656924382814;
        Mon, 04 Jul 2022 01:46:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b002185d79dc7fsm5990434wrm.75.2022.07.04.01.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:46:21 -0700 (PDT)
Message-Id: <5e9b985e39b0b9edee7af55dd8b0698a20062cf7.1656924376.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
        <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jul 2022 08:46:12 +0000
Subject: [PATCH v3 2/6] pack-bitmap-write.c: write lookup table extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
 pack-bitmap-write.c | 112 ++++++++++++++++++++++++++++++++++++++++++--
 pack-bitmap.h       |   5 +-
 2 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c43375bd344..4a0edd746bc 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -648,9 +648,17 @@ static const struct object_id *oid_access(size_t pos, const void *table)
 	return &index[pos]->oid;
 }
 
+static int commit_bitmap_writer_pos(struct object_id *oid,
+				    struct pack_idx_entry **index,
+				    uint32_t index_nr)
+{
+	return oid_pos(oid, index, index_nr, oid_access);
+}
+
 static void write_selected_commits_v1(struct hashfile *f,
 				      struct pack_idx_entry **index,
-				      uint32_t index_nr)
+				      uint32_t index_nr,
+				      off_t *offsets)
 {
 	int i;
 
@@ -658,11 +666,14 @@ static void write_selected_commits_v1(struct hashfile *f,
 		struct bitmapped_commit *stored = &writer.selected[i];
 
 		int commit_pos =
-			oid_pos(&stored->commit->object.oid, index, index_nr, oid_access);
+			commit_bitmap_writer_pos(&stored->commit->object.oid, index, index_nr);
 
 		if (commit_pos < 0)
 			BUG("trying to write commit not in index");
 
+		if (offsets)
+			offsets[i] = hashfile_total(f);
+
 		hashwrite_be32(f, commit_pos);
 		hashwrite_u8(f, stored->xor_offset);
 		hashwrite_u8(f, stored->flags);
@@ -671,6 +682,92 @@ static void write_selected_commits_v1(struct hashfile *f,
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
+			       off_t *offsets)
+{
+	uint32_t i;
+	uint32_t *table, *table_inv, *commit_positions;
+
+	ALLOC_ARRAY(table, writer.selected_nr);
+	ALLOC_ARRAY(table_inv, writer.selected_nr);
+	ALLOC_ARRAY(commit_positions, writer.selected_nr);
+
+	/* store the index positions of the commits */
+	for (i = 0; i < writer.selected_nr; i++) {
+		int pos = commit_bitmap_writer_pos(&writer.selected[i].commit->object.oid,
+						   index, index_nr);
+		if (pos < 0)
+			BUG(_("trying to write commit not in index"));
+
+		commit_positions[i] = pos;
+	}
+
+	for (i = 0; i < writer.selected_nr; i++)
+		table[i] = i;
+
+	/*
+	 * At the end of this sort table[j] = i means that the i'th
+	 * bitmap corresponds to j'th bitmapped commit in lex order of
+	 * OIDs.
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
+	free(commit_positions);
+}
+
 static void write_hash_cache(struct hashfile *f,
 			     struct pack_idx_entry **index,
 			     uint32_t index_nr)
@@ -695,6 +792,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 {
 	static uint16_t default_version = 1;
 	static uint16_t flags = BITMAP_OPT_FULL_DAG;
+	off_t *offsets = NULL;
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct hashfile *f;
 
@@ -715,7 +813,14 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	dump_bitmap(f, writer.trees);
 	dump_bitmap(f, writer.blobs);
 	dump_bitmap(f, writer.tags);
-	write_selected_commits_v1(f, index, index_nr);
+
+	if (options & BITMAP_OPT_LOOKUP_TABLE)
+		CALLOC_ARRAY(offsets, index_nr);
+
+	write_selected_commits_v1(f, index, index_nr, offsets);
+
+	if (options & BITMAP_OPT_LOOKUP_TABLE)
+		write_lookup_table(f, index, index_nr, offsets);
 
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
@@ -730,4 +835,5 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 		die_errno("unable to rename temporary bitmap file to '%s'", filename);
 
 	strbuf_release(&tmp_file);
+	free(offsets);
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

