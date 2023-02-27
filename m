Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E216EC7EE23
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 15:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjB0P2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjB0P2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 10:28:34 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E4DBDF5
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:28 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h14so6653159wru.4
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecsu1e8JznAMHuK6DT0D0241DAYP1YyqQzs56RCk4Sg=;
        b=nbmPjER+hKn7ILAKa8uXcJabfyc1eze4JdxtRPiOMa3bC0+8Gps2K2DPDpt29Iytgy
         DF/TAhpCYT15fkDn1SpMjgtLvVDKJ9fE442SpOLVZ/P7ftDgXax8rseOJTprugC/16lw
         rxBH89zCq9osUhabhVW1WKCeqHN/V/NLMmJr/jqTR4tHMOnpznnhYQdIKw442mtDNSYF
         JCXXPDuh5eRDOkz1t7z56T0pKHN2lHSlp2WwkFxXVyOG2QcRjmX+I9oacA5nTDRDAob4
         2vVvB5vwC5SQTvxye7kGCOwWb0AG+1bJflzHYoMWSlvhd6el+LQEq2vx16kzj6s0wrhU
         jBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecsu1e8JznAMHuK6DT0D0241DAYP1YyqQzs56RCk4Sg=;
        b=Mg7ojhdsxGdec936zyMYU/mQCHiOOxPZFu76e8BSTBhM3A9Gk4JiZzqY3CmbBvtcPk
         YsPsN5lYCxXDl6GwRHcjb7bywkjp657zTF72dEOzEiPN+UTN1ZXpSD7kAPrNoK/UiJsu
         2fPBLA9X4QuQhCW3iKqSBkJz9S2ajgZBg1ipJqNVpdzggmMfCBPHyhbnfVInNrGtYx68
         kYquUCtI0BwsXkbwuaWppjf9o3EA4Pab5vlitjOE7BMVZdLABcZUBroFVlExlUrl0L4Y
         sC5e0JuL8VAhKQtT+/dzZeTc1UL+WQDFyn5nH8T13YwQRSzVlCXE+pcnAUBooJveMiV0
         oBjA==
X-Gm-Message-State: AO0yUKXkfEBtUZ6wu43ac0C8CfZQ5UqhVRw5vs0BGsP5oxNx9Rtf9LcJ
        NXBtMAVVmvuT+XsLCUkbqGX7EjI6frQ=
X-Google-Smtp-Source: AK7set+UgZmIBfM7cPFRdfBkhr8t0W+zYm9JAOBXY/bxG/NC8p3ABRcmh4lVulCo0dsBiSV9Dh62ZA==
X-Received: by 2002:a5d:60ca:0:b0:2c7:e909:5fcf with SMTP id x10-20020a5d60ca000000b002c7e9095fcfmr8378164wrt.3.1677511706497;
        Mon, 27 Feb 2023 07:28:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4-20020adff7c4000000b002c4084d3472sm7291571wrq.58.2023.02.27.07.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:28:26 -0800 (PST)
Message-Id: <4e86e39506c65e5a84fcd655a632ddae21be51d0.1677511700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
References: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
        <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 15:28:13 +0000
Subject: [PATCH v3 06/13] unpack-trees: clean up some flow control
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The update_sparsity() function was introduced in commit 7af7a25853
("unpack-trees: add a new update_sparsity() function", 2020-03-27).
Prior to that, unpack_trees() was used, but that had a few bugs because
the needs of the caller were different, and different enough that
unpack_trees() could not easily be modified to handle both usecases.

The implementation detail that update_sparsity() was written by copying
unpack_trees() and then streamlining it, and then modifying it in the
needed ways still shows through in that there are leftover vestiges in
both functions that are no longer needed.  Clean them up.  In
particular:

  * update_sparsity() allows a pattern list to be passed in, but
    unpack_trees() never should use a different pattern list.  Add a
    check and a BUG() if this gets violated.
  * update_sparsity() has a check early on that will BUG() if
    o->skip_sparse_checkout is set; as such, there's no need to check
    for that condition again later in the code.  We can simply remove
    the check and its corresponding goto label.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 4518d33ed99..bad3120a76e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1873,6 +1873,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 	if (o->dir)
 		BUG("o->dir is for internal use only");
+	if (o->pl)
+		BUG("o->pl is for internal use only");
 
 	trace_performance_enter();
 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
@@ -1899,7 +1901,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
-	if (!o->skip_sparse_checkout && !o->pl) {
+	if (!o->skip_sparse_checkout) {
 		memset(&pl, 0, sizeof(pl));
 		free_pattern_list = 1;
 		populate_from_existing_patterns(o, &pl);
@@ -2113,8 +2115,6 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 		memset(&pl, 0, sizeof(pl));
 		free_pattern_list = 1;
 		populate_from_existing_patterns(o, &pl);
-		if (o->skip_sparse_checkout)
-			goto skip_sparse_checkout;
 	}
 
 	/* Expand sparse directories as needed */
@@ -2142,7 +2142,6 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 			ret = UPDATE_SPARSITY_WARNINGS;
 	}
 
-skip_sparse_checkout:
 	if (check_updates(o, o->src_index))
 		ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;
 
-- 
gitgitgadget

