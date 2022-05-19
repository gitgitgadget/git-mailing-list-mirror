Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E7EC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiESRyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243441AbiESRxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:53:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AFF11C16
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so8218390wrg.12
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IEpNz3kJwXSXH54uGrN5t4SX/2hfEE+wWeKVcgcKSGA=;
        b=Hgf5kiDTDmoJs5Nuz4rljkdkNDLlZdXFYVvgfdzLsHf1QX37HLedXC5j3hG7rpNbPs
         3h3o4L5hfrBmKlpXZzZjOFhYXv7wXHsEowhd5XAoH3dozDNGnJ25ggjDZvwuC30Q8JEA
         4HjOMV01BulaLhfaajajEGBlbY/8V6DqgVjnzvCI2iCi8pMRk3VRpSY9XCEA4sRNoX1O
         oKNOlnopt9OR4veyzr6ashRijRSlhyqhcHFYiUsSSX2jCPI7Vk1gdJpnybFZ1nP49b1I
         4AeUPDpy8nqzwvs3m19Greyan74fSDxVT9ajxJY5XJaPnPN6yaG1k4yVq8y5UURFKvr1
         ix0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IEpNz3kJwXSXH54uGrN5t4SX/2hfEE+wWeKVcgcKSGA=;
        b=aN4407FnztFK/k8qENdR0QvoRYalfBaFAgcnGLL6eZIFCMw/T0CcxE1bXm08czkTZS
         0mORckXV3Jy2xaufCul1fCyHGRmf/VEox490IJj9K3zN0dPmiB9EKbB33CqHRPa0iRYm
         CvNE2AK5PhGd2sTdT5CWn/ZSgmHKYHfWvQNixRiEZSLULSM+6PoCNh0mLLbXjlCHVPH/
         ihl9nmhgfOo1OW072uU7qcNZ7cccESBt1NC9kTgqziGw02eEDzgaG2Cqx7DQFaw4loE/
         kfTBF8kXLxfaACShbZvKnU1CH5AhsY2UvjwdPIQWOQxAR+SbqzNT8coz2jYLCF49K323
         BdFw==
X-Gm-Message-State: AOAM532EBP0L2FyRVDQSi9os9/1e77rmESJ4irCRWBgYtfFhs9nyBNTt
        2RLIvYruu4nJUl8ZnO2lIxOso4SrgKI=
X-Google-Smtp-Source: ABdhPJwiI4uHJI6OvEpqfzcZVku3W49euedB2oy8aEEsIlIZ1pMMtyV31D5e0OamWY7PRxqlIsNXWw==
X-Received: by 2002:a05:6000:2c4:b0:20c:6c76:14f4 with SMTP id o4-20020a05600002c400b0020c6c7614f4mr5167364wry.56.1652982769361;
        Thu, 19 May 2022 10:52:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020adf8b4f000000b0020c5253d8d3sm246422wra.31.2022.05.19.10.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:52:48 -0700 (PDT)
Message-Id: <ed640e3645ba4f60f06bd335b9ac7bf350dd81f9.1652982759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 17:52:36 +0000
Subject: [PATCH v2 08/10] sparse-index: complete partial expansion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

To complete the implementation of expand_to_pattern_list(), we need to
detect when a sparse directory entry should remain sparse. This avoids a
full expansion, so we now need to use the PARTIALLY_SPARSE mode to
indicate this state.

There still are no callers to this method, but we will add one in the
next change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sparse-index.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 73b82e5017b..a65169030a2 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -297,8 +297,24 @@ void expand_to_pattern_list(struct index_state *istate,
 	 * continue. A NULL pattern set indicates a full expansion to a
 	 * full index.
 	 */
-	if (pl && !pl->use_cone_patterns)
+	if (pl && !pl->use_cone_patterns) {
 		pl = NULL;
+	} else {
+		/*
+		 * We might contract file entries into sparse-directory
+		 * entries, and for that we will need the cache tree to
+		 * be recomputed.
+		 */
+		cache_tree_free(&istate->cache_tree);
+
+		/*
+		 * If there is a problem creating the cache tree, then we
+		 * need to expand to a full index since we cannot satisfy
+		 * the current request as a sparse index.
+		 */
+		if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
+			pl = NULL;
+	}
 
 	if (!istate->repo)
 		istate->repo = the_repository;
@@ -317,8 +333,14 @@ void expand_to_pattern_list(struct index_state *istate,
 	full = xcalloc(1, sizeof(struct index_state));
 	memcpy(full, istate, sizeof(struct index_state));
 
+	/*
+	 * This slightly-misnamed 'full' index might still be sparse if we
+	 * are only modifying the list of sparse directories. This hinges
+	 * on whether we have a non-NULL pattern list.
+	 */
+	full->sparse_index = pl ? PARTIALLY_SPARSE : COMPLETELY_FULL;
+
 	/* then change the necessary things */
-	full->sparse_index = 0;
 	full->cache_alloc = (3 * istate->cache_alloc) / 2;
 	full->cache_nr = 0;
 	ALLOC_ARRAY(full->cache, full->cache_alloc);
@@ -330,11 +352,22 @@ void expand_to_pattern_list(struct index_state *istate,
 		struct cache_entry *ce = istate->cache[i];
 		struct tree *tree;
 		struct pathspec ps;
+		int dtype;
 
 		if (!S_ISSPARSEDIR(ce->ce_mode)) {
 			set_index_entry(full, full->cache_nr++, ce);
 			continue;
 		}
+
+		/* We now have a sparse directory entry. Should we expand? */
+		if (pl &&
+		    path_matches_pattern_list(ce->name, ce->ce_namelen,
+					      NULL, &dtype,
+					      pl, istate) == NOT_MATCHED) {
+			set_index_entry(full, full->cache_nr++, ce);
+			continue;
+		}
+
 		if (!(ce->ce_flags & CE_SKIP_WORKTREE))
 			warning(_("index entry is a directory, but not sparse (%08x)"),
 				ce->ce_flags);
@@ -360,7 +393,7 @@ void expand_to_pattern_list(struct index_state *istate,
 	/* Copy back into original index. */
 	memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
 	memcpy(&istate->dir_hash, &full->dir_hash, sizeof(full->dir_hash));
-	istate->sparse_index = 0;
+	istate->sparse_index = pl ? PARTIALLY_SPARSE : COMPLETELY_FULL;
 	free(istate->cache);
 	istate->cache = full->cache;
 	istate->cache_nr = full->cache_nr;
@@ -374,7 +407,7 @@ void expand_to_pattern_list(struct index_state *istate,
 
 	/* Clear and recompute the cache-tree */
 	cache_tree_free(&istate->cache_tree);
-	cache_tree_update(istate, 0);
+	cache_tree_update(istate, WRITE_TREE_MISSING_OK);
 
 	trace2_region_leave("index",
 			    pl ? "expand_to_pattern_list" : "ensure_full_index",
-- 
gitgitgadget

