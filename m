Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F03C282E7
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 17:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241636AbiHNRAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241836AbiHNQ7p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 12:59:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA89B6349
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 09:55:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e27so1916827wra.11
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=9T1CPmxOfBodrz8wPGdorUScuh/xHb6POfc+zCI05DA=;
        b=pfRTVjRH32Wp0Ns8JCFnmOjltxReJZUr5l8I/Pt4dIeePJfbJvjfIjS6B3EPb3KD22
         rgRq0aRIFgNcEnWnLn7OTg/DooudcgWVsH/YjdLEzNiTeBeBM+HHIhJJDmaZa30s7TAx
         gZqxnTEanUHPNPBWcH46qpHS4Zp8Dp3OZiUngII+dr5y8sti347NkFgUx7w6/QEsoUnr
         FL/9FWdMzQTl58rikBb8pp+5Qi75cVieJ+I3JtQqU/0abFAWz969ZH1vd6ZpS/mtA1FL
         dUgwvgu451Nde7X6PMI87RIk1NgL/qycOT7MOrhVMXKfQcRqDFimE2Gin3vKNQwvcHj8
         qKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=9T1CPmxOfBodrz8wPGdorUScuh/xHb6POfc+zCI05DA=;
        b=77haeYf8g6tHsCe85s29972EPd1Bm2VtkHYXDw4AT8YGTc4L3Zff7CbQzA2fnrizf9
         T00bnudd/mTMPbhxqVTxq9dKToVpfqgfkLwyUMV6+H/XaGC27n4EShJpdQtS4vdl2pCj
         jXhh7wAJs9SRVh0FbXx5ZewT757xlYfRYpus11UR5CxnMlo31ArIIv04TFwLjIS2RV/G
         YjLRHOpbHgePPGovo4ks/UWBaJ99LreTpCxY7yKwwTAR+Ecra/KV3bzAXtC1vz0g4Ygu
         EN/iOhaZa1b131RWHv59A/59whVatoZHMnyKX2ctKaEreP13ubZHfPbjN6MnWYpbY75j
         +Rhg==
X-Gm-Message-State: ACgBeo0RAKfQH8BSh3fKGViGYO/YImlWS1HPCFcV1heg3Q7DD7LlVG3v
        QPfa/kHBYafdthSyh+8Qbn0YuvDaisc=
X-Google-Smtp-Source: AA6agR6vvEsK0VD8ISVrDA3YKwgc9gTiZThBJGW2bHgwzInLlQQn/GbiPjomsbXj3pEGTRxLq9jzFg==
X-Received: by 2002:a5d:4b03:0:b0:220:6b87:8f0f with SMTP id v3-20020a5d4b03000000b002206b878f0fmr6743588wrq.534.1660496118063;
        Sun, 14 Aug 2022 09:55:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600000ce00b0021ee28ff76esm4942218wrx.38.2022.08.14.09.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 09:55:17 -0700 (PDT)
Message-Id: <090becaabe0c47fb5fed4ec5ce7628deeafeded1.1660496112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
References: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
        <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Aug 2022 16:55:08 +0000
Subject: [PATCH v6 3/6] pack-bitmap-write.c: write lookup table extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
 pack-bitmap-write.c | 91 ++++++++++++++++++++++++++++++++++++++++++++-
 pack-bitmap.h       |  5 ++-
 2 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 9b1be59f6d3..2cfc92f2871 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -651,13 +651,17 @@ static const struct object_id *oid_access(size_t pos, const void *table)
 static void write_selected_commits_v1(struct hashfile *f,
 				      struct pack_idx_entry **index,
 				      uint32_t index_nr,
-				      uint32_t *commit_positions)
+				      uint32_t *commit_positions,
+				      off_t *offsets)
 {
 	int i;
 
 	for (i = 0; i < writer.selected_nr; ++i) {
 		struct bitmapped_commit *stored = &writer.selected[i];
 
+		if (offsets)
+			offsets[i] = hashfile_total(f);
+
 		hashwrite_be32(f, commit_positions[i]);
 		hashwrite_u8(f, stored->xor_offset);
 		hashwrite_u8(f, stored->flags);
@@ -666,6 +670,81 @@ static void write_selected_commits_v1(struct hashfile *f,
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
+			       uint32_t *commit_positions,
+			       off_t *offsets)
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
@@ -693,6 +772,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct hashfile *f;
 	uint32_t *commit_positions = NULL;
+	off_t *offsets = NULL;
 	uint32_t i;
 
 	struct bitmap_disk_header header;
@@ -713,6 +793,9 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	dump_bitmap(f, writer.blobs);
 	dump_bitmap(f, writer.tags);
 
+	if (options & BITMAP_OPT_LOOKUP_TABLE)
+		CALLOC_ARRAY(offsets, index_nr);
+
 	ALLOC_ARRAY(commit_positions, writer.selected_nr);
 
 	for (i = 0; i < writer.selected_nr; i++) {
@@ -725,7 +808,10 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 		commit_positions[i] = commit_pos;
 	}
 
-	write_selected_commits_v1(f, index, index_nr, commit_positions);
+	write_selected_commits_v1(f, index, index_nr, commit_positions, offsets);
+
+	if (options & BITMAP_OPT_LOOKUP_TABLE)
+		write_lookup_table(f, index, index_nr, commit_positions, offsets);
 
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
@@ -741,4 +827,5 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 
 	strbuf_release(&tmp_file);
 	free(commit_positions);
+	free(offsets);
 }
diff --git a/pack-bitmap.h b/pack-bitmap.h
index f3a57ca065f..cb065a263cb 100644
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

