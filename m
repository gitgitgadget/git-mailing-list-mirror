Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CCDC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 21:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiIZVz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiIZVzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 17:55:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC8FA1D40
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 14:55:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c11so12190520wrp.11
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=G+57+2YTNgzswYMY49pstT0q25MoZCT1l9IyXDYoM6A=;
        b=TifPY5NduUdZhRqWN/KSPoGZlfTfIa9Yg4NHhCfvmEy9gIxaiMr46usnFL324uvbFV
         rqW7whM4hjCGaGNK8MA97NRPBAn9SWTRRy9+5eXCzcVEtV2WhNHUbYpLMR2blPFO8PxN
         g2Au144HXo3yjVDDfQ0gnTUE+9ghDeJ/bHE7Xmk1isGaBmz5NWzWKTAN/SleS+te+wCW
         WkSg8f3IGbIKKyuRifJIJcl/7SdgOGEVRscX/XZPcumg3nHcacuh2koZP2xli6db9EuZ
         TmaD8LGL5PxvgUEND7oDZRDKwjLDRxQl23jsHR+we6r3QqR+q65pVXVB4ppfHex0PI09
         vzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=G+57+2YTNgzswYMY49pstT0q25MoZCT1l9IyXDYoM6A=;
        b=72ekGrST2yhTLvLMswCFlJHw1nl+uJEJ76/UJw4tYSUWcTu5RYFEVhiQ87Q7EcUbMt
         ThI95ZYp3gvvgJj99jfdMa2S8rnHWt03byEB2AWYCH14FgwWKJwHsAyAZp8NZk63+DRq
         MlyEonllwzlUxM66vjcngJUlLcpNqYm9yPB9f4uK8I1/1OJ85eV9paOTlPFbbs79FA95
         u8XvR5z3RRu8Cd/8R0Wt0IqdfyBq1KDy/6F/CkmLfJ5rv/nu+xDP+LCZdBcJgowfaBRO
         KMwuJNOcIys24cHp/dXfjaHjjyYhkv/w4YLkAmSNwShOZHKKLtguuDnCuNjaSAA6vF+E
         BibQ==
X-Gm-Message-State: ACrzQf3L78+eeNdevo4LHW8NyVpbGBa43pkVlpJy2c1Ca430ycmc3Vv5
        FztmJuOtA+9DLxUhOH90kb/ww+QWDqQ=
X-Google-Smtp-Source: AMsMyM5rnjzeOikd1k/h0Ph2QEMqLyl8OEMYq2OnlDtPcqdNo9omVAH4sCeZ7bjlKzhgC8f8hUE1bg==
X-Received: by 2002:adf:e192:0:b0:228:d066:a844 with SMTP id az18-20020adfe192000000b00228d066a844mr15494521wrb.54.1664229350694;
        Mon, 26 Sep 2022 14:55:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c425500b003b49aa8083esm11676434wmm.42.2022.09.26.14.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:55:49 -0700 (PDT)
Message-Id: <ab6df092eba04854b2fe333d6344fd008c4e9021.1664229348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
References: <pull.1362.v3.git.1663875999939.gitgitgadget@gmail.com>
        <pull.1362.v4.git.1664229348.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Sep 2022 21:55:47 +0000
Subject: [PATCH v4 1/2] merge-ort: fix segmentation fault in read-only
 repositories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

If the blob/tree objects cannot be written, we really need the merge
operations to fail, and not to continue (and then try to access the tree
object which is however still set to `NULL`).

Let's stop ignoring the return value of `write_object_file()` and
`write_tree()` and set `clean = -1` in the error case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-ort.c                      | 66 ++++++++++++++++++++------------
 t/t4301-merge-tree-write-tree.sh |  9 +++++
 2 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 99dcee2db8a..f3bdce1041a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3571,15 +3571,15 @@ static int tree_entry_order(const void *a_, const void *b_)
 				 b->string, strlen(b->string), bmi->result.mode);
 }
 
-static void write_tree(struct object_id *result_oid,
-		       struct string_list *versions,
-		       unsigned int offset,
-		       size_t hash_size)
+static int write_tree(struct object_id *result_oid,
+		      struct string_list *versions,
+		      unsigned int offset,
+		      size_t hash_size)
 {
 	size_t maxlen = 0, extra;
 	unsigned int nr;
 	struct strbuf buf = STRBUF_INIT;
-	int i;
+	int i, ret = 0;
 
 	assert(offset <= versions->nr);
 	nr = versions->nr - offset;
@@ -3605,8 +3605,10 @@ static void write_tree(struct object_id *result_oid,
 	}
 
 	/* Write this object file out, and record in result_oid */
-	write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
+	if (write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid))
+		ret = -1;
 	strbuf_release(&buf);
+	return ret;
 }
 
 static void record_entry_for_tree(struct directory_versions *dir_metadata,
@@ -3625,13 +3627,13 @@ static void record_entry_for_tree(struct directory_versions *dir_metadata,
 			   basename)->util = &mi->result;
 }
 
-static void write_completed_directory(struct merge_options *opt,
-				      const char *new_directory_name,
-				      struct directory_versions *info)
+static int write_completed_directory(struct merge_options *opt,
+				     const char *new_directory_name,
+				     struct directory_versions *info)
 {
 	const char *prev_dir;
 	struct merged_info *dir_info = NULL;
-	unsigned int offset;
+	unsigned int offset, ret = 0;
 
 	/*
 	 * Some explanation of info->versions and info->offsets...
@@ -3717,7 +3719,7 @@ static void write_completed_directory(struct merge_options *opt,
 	 * strcmp here.)
 	 */
 	if (new_directory_name == info->last_directory)
-		return;
+		return 0;
 
 	/*
 	 * If we are just starting (last_directory is NULL), or last_directory
@@ -3739,7 +3741,7 @@ static void write_completed_directory(struct merge_options *opt,
 		 */
 		string_list_append(&info->offsets,
 				   info->last_directory)->util = (void*)offset;
-		return;
+		return 0;
 	}
 
 	/*
@@ -3769,8 +3771,9 @@ static void write_completed_directory(struct merge_options *opt,
 		 */
 		dir_info->is_null = 0;
 		dir_info->result.mode = S_IFDIR;
-		write_tree(&dir_info->result.oid, &info->versions, offset,
-			   opt->repo->hash_algo->rawsz);
+		if (write_tree(&dir_info->result.oid, &info->versions, offset,
+			       opt->repo->hash_algo->rawsz) < 0)
+			ret = -1;
 	}
 
 	/*
@@ -3798,6 +3801,8 @@ static void write_completed_directory(struct merge_options *opt,
 	/* And, of course, we need to update last_directory to match. */
 	info->last_directory = new_directory_name;
 	info->last_directory_len = strlen(info->last_directory);
+
+	return ret;
 }
 
 /* Per entry merge function */
@@ -4214,8 +4219,8 @@ static void prefetch_for_content_merges(struct merge_options *opt,
 	oid_array_clear(&to_fetch);
 }
 
-static void process_entries(struct merge_options *opt,
-			    struct object_id *result_oid)
+static int process_entries(struct merge_options *opt,
+			   struct object_id *result_oid)
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
@@ -4224,11 +4229,12 @@ static void process_entries(struct merge_options *opt,
 	struct directory_versions dir_metadata = { STRING_LIST_INIT_NODUP,
 						   STRING_LIST_INIT_NODUP,
 						   NULL, 0 };
+	int ret = 0;
 
 	trace2_region_enter("merge", "process_entries setup", opt->repo);
 	if (strmap_empty(&opt->priv->paths)) {
 		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
-		return;
+		return 0;
 	}
 
 	/* Hack to pre-allocate plist to the desired size */
@@ -4270,8 +4276,11 @@ static void process_entries(struct merge_options *opt,
 		 */
 		struct merged_info *mi = entry->util;
 
-		write_completed_directory(opt, mi->directory_name,
-					  &dir_metadata);
+		if (write_completed_directory(opt, mi->directory_name,
+					      &dir_metadata) < 0) {
+			ret = -1;
+			goto cleanup;
+		}
 		if (mi->clean)
 			record_entry_for_tree(&dir_metadata, path, mi);
 		else {
@@ -4291,12 +4300,16 @@ static void process_entries(struct merge_options *opt,
 		fflush(stdout);
 		BUG("dir_metadata accounting completely off; shouldn't happen");
 	}
-	write_tree(result_oid, &dir_metadata.versions, 0,
-		   opt->repo->hash_algo->rawsz);
+	if (write_tree(result_oid, &dir_metadata.versions, 0,
+		       opt->repo->hash_algo->rawsz) < 0)
+		ret = -1;
+cleanup:
 	string_list_clear(&plist, 0);
 	string_list_clear(&dir_metadata.versions, 0);
 	string_list_clear(&dir_metadata.offsets, 0);
 	trace2_region_leave("merge", "process_entries cleanup", opt->repo);
+
+	return ret;
 }
 
 /*** Function Grouping: functions related to merge_switch_to_result() ***/
@@ -4928,15 +4941,18 @@ redo:
 	}
 
 	trace2_region_enter("merge", "process_entries", opt->repo);
-	process_entries(opt, &working_tree_oid);
+	if (process_entries(opt, &working_tree_oid) < 0)
+		result->clean = -1;
 	trace2_region_leave("merge", "process_entries", opt->repo);
 
 	/* Set return values */
 	result->path_messages = &opt->priv->conflicts;
 
-	result->tree = parse_tree_indirect(&working_tree_oid);
-	/* existence of conflicted entries implies unclean */
-	result->clean &= strmap_empty(&opt->priv->conflicted);
+	if (result->clean >= 0) {
+		result->tree = parse_tree_indirect(&working_tree_oid);
+		/* existence of conflicted entries implies unclean */
+		result->clean &= strmap_empty(&opt->priv->conflicted);
+	}
 	if (!opt->priv->call_depth) {
 		result->priv = opt->priv;
 		result->_properly_initialized = RESULT_INITIALIZED;
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 28ca5c38bb5..013b77144bd 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -810,4 +810,13 @@ test_expect_success 'can override merge of unrelated histories' '
 	test_cmp expect actual
 '
 
+test_expect_success SANITY 'merge-ort fails gracefully in a read-only repository' '
+	git init --bare read-only &&
+	git push read-only side1 side2 side3 &&
+	test_when_finished "chmod -R u+w read-only" &&
+	chmod -R a-w read-only &&
+	test_must_fail git -C read-only merge-tree side1 side3 &&
+	test_must_fail git -C read-only merge-tree side1 side2
+'
+
 test_done
-- 
gitgitgadget

