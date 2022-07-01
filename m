Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4FFC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 05:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiGAFXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 01:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiGAFX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 01:23:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6B6205FF
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:23:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v9so1518634wrp.7
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YViNupEtiXbkg+Bk11DwGwiBbv9XytGRmPVUgM1L+YM=;
        b=A5a+t3xORi3p572cXPumJ1I+7SY+UTZDl0UcMVMbvMPSsCEzAD/viLjuHOq2BsXTFu
         5E7X6R+ImJjuYXgJkXwe0Qtnt/iU4q91HMfYAjwcShraw499vFsAkhe6ZE/2Gd4xjBHa
         uOEHFmfDXP3dIearKSrST41MkIQQUbKkyOnaYx2ZtFgyKwFZR4uV5W4X4wpfjWR85+Vr
         XIOf0d0tqsA+O9+dl9cGbHjCNM7YT0IxuZpEkSJ0liFvAsYCvwH3GTlaae2GnCzI+ekG
         9kUGpLWAEw89Jz5FzTYe4U8YZT0nJMW54T1XgurBKKuBUtTt81xtNqMGTwr0V1pbxPTn
         seLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YViNupEtiXbkg+Bk11DwGwiBbv9XytGRmPVUgM1L+YM=;
        b=TJD/ZTqzbKn3PCDaH/egwVilQv6P0Sen8S1J1zu0qXicunHpUoG3lM4nfGxj/+ec39
         uOU0E9sDJQurmLFdmgG93ckhtmngKYRS3m/w0tSmHhaACaXBH6xqmV/jWSfZDqZE4mgY
         DSvgFPNPmTl2868R9k+ndT2suoscUyJDYYU49Qcz1bbXsOqrKld8//vo3xRBVCbutNPQ
         2w2nJm/ZKFIbmrjXw0CNmmTPGJrRhv7ikiClBa8Dbs5G9uuDyv73Ll1+TPyvSiRysCoq
         cYR+44IvmacczgKTJVyix6d29B48rz5GVf7a3WksNMqjvxEgBWDlvcoNTieu+yqINH+y
         Brgg==
X-Gm-Message-State: AJIora8CQwpsJyqTcnqJVPqZX5UV4oeFNOafOBRQRGNixbjwYPTlVn4o
        vmbGBxChH33KGSXKabenU7LBecmY1NI=
X-Google-Smtp-Source: AGRyM1uuH8qRNTR+WYjQMsoAz0SiJtpE/OSGM+k0rY5+8tX5l/ZXYtYu9+KiLRV8pc8TAJd4bsPKaQ==
X-Received: by 2002:adf:eacd:0:b0:21b:b032:6b4a with SMTP id o13-20020adfeacd000000b0021bb0326b4amr11467916wrn.177.1656653006429;
        Thu, 30 Jun 2022 22:23:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003973c54bd69sm5214217wma.1.2022.06.30.22.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 22:23:25 -0700 (PDT)
Message-Id: <d3eac3d0bf6539d81751813d89ec5158dcb57338.1656653000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
References: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
        <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jul 2022 05:23:19 +0000
Subject: [PATCH v3 4/5] merge-ort: shuffle the computation and cleanup of
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
index 1514dd173c0..b496f0e3803 100644
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
+	for (int i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
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
+	for (int i = MERGE_SIDE1; i <= MERGE_SIDE2; i++)
+		free_collisions(&collisions[i]);
 	STABLE_QSORT(combined.queue, combined.nr, compare_pairs);
 	trace2_region_leave("merge", "directory renames", opt->repo);
 
-- 
gitgitgadget

