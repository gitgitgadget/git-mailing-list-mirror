Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DF3C43217
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 01:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiKJB6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 20:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiKJB5y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 20:57:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA652E697
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 17:57:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o4so317042wrq.6
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 17:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9D6pDzcfKa+C9JuV33FlqQspXTfBgY5IZLMOQAlznk=;
        b=FkAb2pCEAjiGtRjg44dJxCWmMZY5eliUBZ3HC/7dGkKwM7CaZMXYQknRIAl7A0Plty
         6b0wZhwar05NKTZn9ujLhRdp41vWDaQaZImk4XdHnA2zIXSjPx/eim0hCpeMIm3Axe7Y
         AUs90wymtdMI5R3eyTW5mKHyccmjn1jwSlVXiGsQmsTqV4b0B6eqOHVXbsBIod+k/XQW
         YguhlSV20FpjNgvTO4Rs2CgPD/BB4a9GUddAEj14WnLPySbVhF6yf9aEZwaTRn9Z5+ex
         +wydSmNIjutDqBEZ0T5A3Z1diCbbERjmV9qonVC5uD84vuInTrTlKnfLy/t2XYsRx0Zm
         qyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9D6pDzcfKa+C9JuV33FlqQspXTfBgY5IZLMOQAlznk=;
        b=U6NdBhPHxMY+gjkftNnNKNWUJb8rZH9EGz0whTdsGcXoPtLlsKzBdtAnNCPoE/Hj3j
         VsRh4HrhA2lyvI+LR+0N9w9jXRblnKWM/WmU5aSiRrfc32ob3Y+Zd4DncafpQBRPURd4
         +py3i5tUeDbtEGr6QY51vuXanvknB6bHj3Rh/0h1YVAlc44bYmktGOgqIpKJV/11LppM
         yzek7M2MJQ2kHzBgx0f7pHLN1+ZDcXFS78lWFndDNCPUZjMitg2jQFqt8nm9NCX9bLhx
         jnIbslgTHZ7yFf3JTEWTsDaWhVVRJGh3rfa/cEMYxdtiya4H/NQlEfoqsydZySGSzMeG
         NVew==
X-Gm-Message-State: ACrzQf1EkZyJcd9YEkEJKgCj+7BXV9YECM3BUe+cv5NclE/2mTb1gjmT
        qEH5Vd0cPxvaCn3qVQl4YNlqs/55COo=
X-Google-Smtp-Source: AMsMyM4nlvLCXJtp84lG9CbcruN3B/BSYWe0XjVPqFmZAyl3VPUygEO2f2jqe1644OljSfKQofjlUw==
X-Received: by 2002:a5d:4692:0:b0:235:b188:3ec with SMTP id u18-20020a5d4692000000b00235b18803ecmr40282958wrq.210.1668045443339;
        Wed, 09 Nov 2022 17:57:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b003a2f2bb72d5sm4137248wmo.45.2022.11.09.17.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 17:57:22 -0800 (PST)
Message-Id: <5a646bc47c911bb6b58e00574ac30afab1eec00b.1668045438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
        <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 01:57:16 +0000
Subject: [PATCH v2 4/5] read-tree: use 'skip_cache_tree_update' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

When running 'read-tree' with a single tree and no prefix,
'prime_cache_tree()' is called after the tree is unpacked. In that
situation, skip a redundant call to 'cache_tree_update()' in
'unpack_trees()' by enabling the 'skip_cache_tree_update' unpack option.

Removing the redundant cache tree update provides a substantial performance
improvement to 'git read-tree <tree-ish>', as shown by a test added to
'p0006-read-tree-checkout.sh':

Test                          before            after
----------------------------------------------------------------------
read-tree br_ballast_plus_1   3.94(1.80+1.57)   3.00(1.14+1.28) -23.9%

Note that the 'read-tree' in 't1022-read-tree-partial-clone.sh' is updated
to read two trees, rather than one. The test was first introduced in
d3da223f221 (cache-tree: prefetch in partial clone read-tree, 2021-07-23) to
exercise the 'cache_tree_update()' code path, as used in 'git merge'. Since
this patch drops the call to 'cache_tree_update()' in single-tree 'git
read-tree', change the test to use the two-tree variant so that
'cache_tree_update()' is called as intended.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/read-tree.c                | 4 ++++
 t/perf/p0006-read-tree-checkout.sh | 8 ++++++++
 t/t1022-read-tree-partial-clone.sh | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index f4cbe460b97..45c6652444b 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -249,6 +249,10 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (opts.debug_unpack)
 		opts.fn = debug_merge;
 
+	/* If we're going to prime_cache_tree later, skip cache tree update */
+	if (nr_trees == 1 && !opts.prefix)
+		opts.skip_cache_tree_update = 1;
+
 	cache_tree_free(&active_cache_tree);
 	for (i = 0; i < nr_trees; i++) {
 		struct tree *tree = trees[i];
diff --git a/t/perf/p0006-read-tree-checkout.sh b/t/perf/p0006-read-tree-checkout.sh
index c481c012d2f..325566e18eb 100755
--- a/t/perf/p0006-read-tree-checkout.sh
+++ b/t/perf/p0006-read-tree-checkout.sh
@@ -49,6 +49,14 @@ test_perf "read-tree br_base br_ballast ($nr_files)" '
 	git read-tree -n -m br_base br_ballast
 '
 
+test_perf "read-tree br_ballast_plus_1 ($nr_files)" '
+	# Run read-tree 100 times for clearer performance results & comparisons
+	for i in  $(test_seq 100)
+	do
+		git read-tree -n -m br_ballast_plus_1 || return 1
+	done
+'
+
 test_perf "switch between br_base br_ballast ($nr_files)" '
 	git checkout -q br_base &&
 	git checkout -q br_ballast
diff --git a/t/t1022-read-tree-partial-clone.sh b/t/t1022-read-tree-partial-clone.sh
index a9953b6a71c..da539716359 100755
--- a/t/t1022-read-tree-partial-clone.sh
+++ b/t/t1022-read-tree-partial-clone.sh
@@ -19,7 +19,7 @@ test_expect_success 'read-tree in partial clone prefetches in one batch' '
 	git -C server config uploadpack.allowfilter 1 &&
 	git -C server config uploadpack.allowanysha1inwant 1 &&
 	git clone --bare --filter=blob:none "file://$(pwd)/server" client &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client read-tree $TREE &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client read-tree $TREE $TREE &&
 
 	# "done" marks the end of negotiation (once per fetch). Expect that
 	# only one fetch occurs.
-- 
gitgitgadget

