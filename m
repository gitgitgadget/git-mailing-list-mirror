Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD49C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 23:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiKCXFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 19:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiKCXFG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 19:05:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D86DF13
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 16:05:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k8so4885857wrh.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 16:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D974zv1IGlEZeh+8MXjYMZ76BSH79SkJr+0VkSUuDz8=;
        b=N8o37F/DGkS6Bm8kJxH53VyPxIxBuMSUeu66MVDz5vVEDNJ9EsHVn3NiurxUX9zr+4
         uXlqG8SiR83Co7DQo6211fGXgayOfBO5a/1TZGHYfi/Xym18wlkmye3v8BWf7CITpKjj
         9f/5BIM5YbpP/MhGKAk70roK+zTGx+lls8pulCukNKSiQc1BdK9VsBetj6bkiQiplbTy
         VydT3MWQ85Ez25prCdELuR+QPwYp412N84mOiROEPpYa2hhiMw+fQaRAQOXqTSo9SD8u
         KZoAOX3Ilx06g/PTlwQM1vLybC8E1pj5sYHB9zT7X9/0m7fypuu5fCE84WRNV2ozcf9d
         zdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D974zv1IGlEZeh+8MXjYMZ76BSH79SkJr+0VkSUuDz8=;
        b=RkJ2r1hDc889FJL3TMHvINJIpb44fvj/0VyikkdreXlVA7z9RbI7nmeczgdZkF0vN9
         +4wJWq7zbkVjKkAHG6dM38LLcX9+zlomwPo7ZAI+c1WQMGk9p9KJKLtMMe1dLaKOtOls
         LwTEJh8VYWW3UwHHmLqsitLb1TvNyuuxm1SVLbCJ6uggdF5KHLwtZmfYLOPnf/sbVyRR
         RmNS//c+NdLy5F7Stwa7mKwXZFvd609VCeHUDVSyoLQchFM1nQx2aVUteM8wGilk3Rfb
         /XwPEYpogIP3fyCabGaIUeMW1IQV2GmAQiEu96t5K3PkZh1i4jVQQ5yZQE48HVsuIfSd
         Z3Pw==
X-Gm-Message-State: ACrzQf2huOceki7cmSua2PUu3TudYKJHVYYKRxoyuv51jVJ4WL4y1yRd
        HrIuN4Dfrc87YcChq7cx+TCobpivHFc=
X-Google-Smtp-Source: AMsMyM4YO6mKUi3iGeCygjvzGhSEOKSfbtoHTwalvzBUHx57EUXiea0BkeUHlMoY4KJtfLvbnVOv5Q==
X-Received: by 2002:adf:de8d:0:b0:236:6087:e07e with SMTP id w13-20020adfde8d000000b002366087e07emr20489652wrl.533.1667516704085;
        Thu, 03 Nov 2022 16:05:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b003c6f426467fsm1129073wmq.40.2022.11.03.16.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 16:05:03 -0700 (PDT)
Message-Id: <33e9b2afd91f4376ef9a64fd267fa61f1a8de07f.1667516701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1368.v4.git.git.1667516701.gitgitgadget@gmail.com>
References: <pull.1368.v3.git.git.1667177791591.gitgitgadget@gmail.com>
        <pull.1368.v4.git.git.1667516701.gitgitgadget@gmail.com>
From:   "Anh Le via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Nov 2022 23:05:00 +0000
Subject: [PATCH v4 1/2] index: add trace2 region for clear skip worktree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, Anh Le <anh@canva.com>,
        Anh Le <anh@canva.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Anh Le <anh@canva.com>

When using sparse checkout, clear_skip_worktree_from_present_files() must
enumerate index entries to find ones with the SKIP_WORKTREE bit to
determine whether those index entries exist on disk (in which case their
SKIP_WORKTREE bit should be removed).

In a large repository, this may take considerable time depending on the
size of the index.

Add a trace2 region to surface this information, keeping a count of how
many paths have been checked. Separately, keep counts after a full index is
materialized.

Signed-off-by: Anh Le <anh@canva.com>
---
 sparse-index.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index e4a54ce1943..8713a15611d 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -493,24 +493,40 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
 	int dir_found = 1;
 
 	int i;
+	int path_count[2] = {0, 0};
+	int restarted = 0;
 
 	if (!core_apply_sparse_checkout ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
 
+	trace2_region_enter("index", "clear_skip_worktree_from_present_files",
+			    istate->repo);
 restart:
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 
-		if (ce_skip_worktree(ce) &&
-		    path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
-			if (S_ISSPARSEDIR(ce->ce_mode)) {
-				ensure_full_index(istate);
-				goto restart;
+		if (ce_skip_worktree(ce)) {
+			path_count[restarted]++;
+			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
+				if (S_ISSPARSEDIR(ce->ce_mode)) {
+					ensure_full_index(istate);
+					restarted = 1;
+					goto restart;
+				}
+				ce->ce_flags &= ~CE_SKIP_WORKTREE;
 			}
-			ce->ce_flags &= ~CE_SKIP_WORKTREE;
 		}
 	}
+
+	if (path_count[0])
+		trace2_data_intmax("index", istate->repo,
+				   "sparse_path_count", path_count[0]);
+	if (restarted)
+		trace2_data_intmax("index", istate->repo,
+				   "sparse_path_count_full", path_count[1]);
+	trace2_region_leave("index", "clear_skip_worktree_from_present_files",
+			    istate->repo);
 }
 
 /*
-- 
gitgitgadget

