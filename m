Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83BBC433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 12:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbiFTMdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242746AbiFTMdX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 08:33:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6186407
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso5618499wmc.4
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Aau4V7jULEjonH1fV+eoCMGtH3S5VuUSfqMYvIszRwE=;
        b=It7hEgypbVTPkbfrssjM3QqBvwb/lgB6kii/HE73Y2UTJuqpQ29SObuznePFi1iCKC
         ZKMf822aRGegckxhSVqpaJchwZA2VCLQ86EGz5ZFyRqqiU5t2qBxYnKtolYSTVZNwAN+
         x+HpgEUnkPbdZ4ZszRDpY2ZDn1lbqrbTWIRZ31/W6Eo/Wn0ofB6C68Rq0/lJErCNINnY
         wULAOef2CmMlUrcvGa9jhiXKLfZ+iTEFi5JmkfoH81xYpPSZGPcQVi6myEoD7qKO6nrL
         HyDlG70J0BAiaCO6CoDnBNGfglpngBTVinYNXwGQ4kX4W7SPK2VcW5IHYCz35fkqYBu/
         zxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Aau4V7jULEjonH1fV+eoCMGtH3S5VuUSfqMYvIszRwE=;
        b=OCFdAbO1b/wNp3xWyCvGuY/wakmANCFuq2gXdarKNkdcHirt3Oa6zXaz3lXbu6m+kI
         sHAIwSM/VTM9emyXWSOUv6MlvbW/wrVWMBWdjkTGV2KxhigfPbT6PfEWEsT1HZEFF7NK
         Ln8KtFGCv4gT6MEIizdmQkK6duKMq+4CMlrQWy1RK5mqgXq82a5Ha3azENYEtsdJP4k7
         CAJ2MWLTCb4XKuWdfb07Ft7ezjJGp6ImrDaQt8lUZerYZjqe+eHViwsf0v2aCZpIowf1
         ceMHQs2SD7mJ/R7M5xY4gviS1XuQfjoRMdJ9N4RvLhJOcLn+8kJcqbhFKzKfwYMxXMTr
         OLZA==
X-Gm-Message-State: AJIora9zylzTQC41MmTJQPrEadYp2EHNgTnYqd29x0fzM78QqosoW0O8
        3HyMd+xazFrc9Z6C021BrMPeh9WofV2KpQ==
X-Google-Smtp-Source: AGRyM1sU4lfbccgeVU2e7f/84WBgyLlzkVd3xac+2Qn/hJbNqgX2eJnV62TvDz0n32L5krw5MQEcBA==
X-Received: by 2002:a05:600c:2189:b0:39c:4bfe:880e with SMTP id e9-20020a05600c218900b0039c4bfe880emr24019079wme.78.1655728400249;
        Mon, 20 Jun 2022 05:33:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6-20020a5d6206000000b0021350f7b22esm14136172wru.109.2022.06.20.05.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:33:19 -0700 (PDT)
Message-Id: <ed91ebf69a84405f16a4390e6fd208251b8ec53e.1655728395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Jun 2022 12:33:11 +0000
Subject: [PATCH 3/6] pack-bitmap-write.c: write lookup table extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Teach git to write bitmap lookup table extension. The table has the
following information:

    - `N` no of Object ids of each bitmapped commits

    - A list of offset, xor-offset pair; the i'th pair denotes the
      offsets and xor-offsets of i'th commit in the previous list.

    - 4-byte integer denoting the flags

Co-authored-by: Taylor Blau <ttaylorr@github.com>
Mentored-by: Taylor Blau <ttaylorr@github.com>
Co-mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 pack-bitmap-write.c | 59 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c43375bd344..9e88a64dd65 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -650,7 +650,8 @@ static const struct object_id *oid_access(size_t pos, const void *table)
 
 static void write_selected_commits_v1(struct hashfile *f,
 				      struct pack_idx_entry **index,
-				      uint32_t index_nr)
+				      uint32_t index_nr,
+				      off_t *offsets)
 {
 	int i;
 
@@ -663,6 +664,9 @@ static void write_selected_commits_v1(struct hashfile *f,
 		if (commit_pos < 0)
 			BUG("trying to write commit not in index");
 
+		if (offsets)
+			offsets[i] = hashfile_total(f);
+
 		hashwrite_be32(f, commit_pos);
 		hashwrite_u8(f, stored->xor_offset);
 		hashwrite_u8(f, stored->flags);
@@ -671,6 +675,49 @@ static void write_selected_commits_v1(struct hashfile *f,
 	}
 }
 
+static int table_cmp(const void *_va, const void *_vb)
+{
+	return oidcmp(&writer.selected[*(uint32_t*)_va].commit->object.oid,
+		      &writer.selected[*(uint32_t*)_vb].commit->object.oid);
+}
+
+static void write_lookup_table(struct hashfile *f,
+			       off_t *offsets)
+{
+	uint32_t i;
+	uint32_t flags = 0;
+	uint32_t *table, *table_inv;
+
+	ALLOC_ARRAY(table, writer.selected_nr);
+	ALLOC_ARRAY(table_inv, writer.selected_nr);
+
+	for (i = 0; i < writer.selected_nr; i++)
+		table[i] = i;
+	QSORT(table, writer.selected_nr, table_cmp);
+	for (i = 0; i < writer.selected_nr; i++)
+		table_inv[table[i]] = i;
+
+	for (i = 0; i < writer.selected_nr; i++) {
+		struct bitmapped_commit *selected = &writer.selected[table[i]];
+		struct object_id *oid = &selected->commit->object.oid;
+
+		hashwrite(f, oid->hash, the_hash_algo->rawsz);
+	}
+	for (i = 0; i < writer.selected_nr; i++) {
+		struct bitmapped_commit *selected = &writer.selected[table[i]];
+
+		hashwrite_be32(f, offsets[table[i]]);
+		hashwrite_be32(f, selected->xor_offset
+			       ? table_inv[table[i] - selected->xor_offset]
+			       : 0xffffffff);
+	}
+
+	hashwrite_be32(f, flags);
+
+	free(table);
+	free(table_inv);
+}
+
 static void write_hash_cache(struct hashfile *f,
 			     struct pack_idx_entry **index,
 			     uint32_t index_nr)
@@ -695,6 +742,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 {
 	static uint16_t default_version = 1;
 	static uint16_t flags = BITMAP_OPT_FULL_DAG;
+	off_t *offsets = NULL;
 	struct strbuf tmp_file = STRBUF_INIT;
 	struct hashfile *f;
 
@@ -715,8 +763,14 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 	dump_bitmap(f, writer.trees);
 	dump_bitmap(f, writer.blobs);
 	dump_bitmap(f, writer.tags);
-	write_selected_commits_v1(f, index, index_nr);
 
+	if (options & BITMAP_OPT_LOOKUP_TABLE)
+		CALLOC_ARRAY(offsets, index_nr);
+
+	write_selected_commits_v1(f, index, index_nr, offsets);
+
+	if (options & BITMAP_OPT_LOOKUP_TABLE)
+		write_lookup_table(f, offsets);
 	if (options & BITMAP_OPT_HASH_CACHE)
 		write_hash_cache(f, index, index_nr);
 
@@ -730,4 +784,5 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 		die_errno("unable to rename temporary bitmap file to '%s'", filename);
 
 	strbuf_release(&tmp_file);
+	free(offsets);
 }
-- 
gitgitgadget

