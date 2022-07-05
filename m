Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EC1C43334
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 01:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiGEBeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 21:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiGEBdz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 21:33:55 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DFDEE2B
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 18:33:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so8844180wmp.3
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 18:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J9irV6+lWGaE2bC66wA0a6Clv4zJssHzOG5L5msFJh0=;
        b=hFHQtW5cPtW3/VPokJ3wjFlBvThkpBiUC47UkAp01TXG6VlIu+jgRL6jSmHW4HQB4v
         EToIAi7wJrz+Ye2whiMsMAteGMSIu61YT/cCEwibmdP94QkM/TFSE5E1SGgHcEg5XSdA
         HFippl5+HUKe7dlko3TxLpuNEQ55Uq8tghk8Eo7sxYRGiSZnDLMiT/jc76YH0c6J+Kuk
         V4ncJyHOkQOJXJkwWmuuLgOHJ/OTwYSzGZ0M8hn+f3vEnsh8OyAelxVMaUDRfcHOyLuI
         ZeCAtOpaU0cWRd9Yo6M/yEkMa7kl7mcgp0SYBMVAJS/0w4Yphdgcm1IhusBuzX6Q8Nzw
         jwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J9irV6+lWGaE2bC66wA0a6Clv4zJssHzOG5L5msFJh0=;
        b=z/88IgyhCfQeJVavzrLIFFzmAAaI0wTQc3RW9yPXabzA2X9pNiwMG2XBbB6u3gOUP6
         TtS99sDS4Q9XHByU2joKju11BPoxXFYa3u3vi3Kq0ZamcDZ3oJCrX9RhswklYTN2hvtd
         dtI67eU2afz5BShzZpvFVmd1iphRtss2nO3R2DobTLzXcRbUOMWMv/rMJzqBSZxuIKHW
         pJtCWtInVGo56af4ixrRPBGHhpGzxgH8gFV29fuv5cd8Zayxh0/c586JWgJlyTYTbiv6
         GkXtVuyyCFFVT+K81FSkFYoWSvZI8FVQVjoe1SjlYz9PZoRZzhz18f9kHkDxxp/xBcns
         k2kA==
X-Gm-Message-State: AJIora91eWKreMSE/tSu23+YEfk3bhMDNXt0UXZF26b63Fm5+pv5Nhpw
        zxvos7+veiv8LOG27h0oyjXJcKNPmA0=
X-Google-Smtp-Source: AGRyM1tTlKetN/kuJkpqTejUqTdc2dOIH3kTBnuD/DCg5HzCB+BjAc/U9AqH/waU5ddA/p4A3IpLUw==
X-Received: by 2002:a05:600c:793:b0:3a1:8c6b:5b36 with SMTP id z19-20020a05600c079300b003a18c6b5b36mr21474456wmo.136.1656984832646;
        Mon, 04 Jul 2022 18:33:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4-20020adff944000000b0021b956da1dcsm31440171wrr.113.2022.07.04.18.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 18:33:51 -0700 (PDT)
Message-Id: <9d813116112fb3d841480baad8d939aa7c714811.1656984823.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v4.git.1656984823.gitgitgadget@gmail.com>
References: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
        <pull.1268.v4.git.1656984823.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jul 2022 01:33:42 +0000
Subject: [PATCH v4 4/5] merge-ort: shuffle the computation and cleanup of
 potential collisions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Run compute_collisions() for renames on both sides of history before
any calls to collect_renames(), and do not free the computed collisions
until after both calls to collect_renames().  This is just a code
reorganization at this point that doesn't make sense on its own, but
will permit us to use the computed collision info from both sides
within each call to collect_renames() in a subsequent commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 1514dd173c0..a37c1c19aca 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2335,7 +2335,8 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	}
 
 	new_path = handle_path_level_conflicts(opt, path, side_index,
-					       rename_info, collisions);
+					       rename_info,
+					       &collisions[side_index]);
 	*clean_merge &= (new_path != NULL);
 
 	return new_path;
@@ -3044,16 +3045,15 @@ static int detect_regular_renames(struct merge_options *opt,
 static int collect_renames(struct merge_options *opt,
 			   struct diff_queue_struct *result,
 			   unsigned side_index,
+			   struct strmap *collisions,
 			   struct strmap *dir_renames_for_side,
 			   struct strmap *rename_exclusions)
 {
 	int i, clean = 1;
-	struct strmap collisions;
 	struct diff_queue_struct *side_pairs;
 	struct rename_info *renames = &opt->priv->renames;
 
 	side_pairs = &renames->pairs[side_index];
-	compute_collisions(&collisions, dir_renames_for_side, side_pairs);
 
 	for (i = 0; i < side_pairs->nr; ++i) {
 		struct diff_filepair *p = side_pairs->queue[i];
@@ -3069,7 +3069,7 @@ static int collect_renames(struct merge_options *opt,
 						      side_index,
 						      dir_renames_for_side,
 						      rename_exclusions,
-						      &collisions,
+						      collisions,
 						      &clean);
 
 		possibly_cache_new_pair(renames, p, side_index, new_path);
@@ -3095,7 +3095,6 @@ static int collect_renames(struct merge_options *opt,
 		result->queue[result->nr++] = p;
 	}
 
-	free_collisions(&collisions);
 	return clean;
 }
 
@@ -3106,6 +3105,7 @@ static int detect_and_process_renames(struct merge_options *opt,
 {
 	struct diff_queue_struct combined = { 0 };
 	struct rename_info *renames = &opt->priv->renames;
+	struct strmap collisions[3];
 	int need_dir_renames, s, i, clean = 1;
 	unsigned detection_run = 0;
 
@@ -3155,12 +3155,22 @@ static int detect_and_process_renames(struct merge_options *opt,
 	ALLOC_GROW(combined.queue,
 		   renames->pairs[1].nr + renames->pairs[2].nr,
 		   combined.alloc);
+	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
+		int other_side = 3 - i;
+		compute_collisions(&collisions[i],
+				   &renames->dir_renames[other_side],
+				   &renames->pairs[i]);
+	}
 	clean &= collect_renames(opt, &combined, MERGE_SIDE1,
+				 collisions,
 				 &renames->dir_renames[2],
 				 &renames->dir_renames[1]);
 	clean &= collect_renames(opt, &combined, MERGE_SIDE2,
+				 collisions,
 				 &renames->dir_renames[1],
 				 &renames->dir_renames[2]);
+	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++)
+		free_collisions(&collisions[i]);
 	STABLE_QSORT(combined.queue, combined.nr, compare_pairs);
 	trace2_region_leave("merge", "directory renames", opt->repo);
 
-- 
gitgitgadget

