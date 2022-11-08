Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B07C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 22:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiKHWor (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 17:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKHWoc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 17:44:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A042A21273
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 14:44:31 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id t4so9689677wmj.5
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 14:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9D6pDzcfKa+C9JuV33FlqQspXTfBgY5IZLMOQAlznk=;
        b=pl+ZJ1xUX0L3auR2rOWWYCIemq05oO/sP1vkcLedTXtq1LkbgrzHhFCXJlVS0kNEnM
         bnylWV/nQJhUSeDf2SwCSgRisranSGr5OfBIosuwpZFI7fr5zLUjK2QaeNxDWK/U54yU
         fiEJUKC1ZhdqRXcvkKLFSJ5ZQyk199iaEoPWZgYJtbSgbdcnlZ+PffXAefXAHOZUuvsh
         JJ58qZr8/9F7E6heM3+vpSkqhF8cbiBr/x/37/sbWIskGZ2I7Btm7lOtN8x2QCLzPLs7
         0ULUur5Q0JMAw3Utrfb2JBknLcRXv3IVU0yXgOIVJruy7Xkdky7iOTNUo5kqoM7lABVh
         aQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9D6pDzcfKa+C9JuV33FlqQspXTfBgY5IZLMOQAlznk=;
        b=XU4o+zVS5XAWXDh+VOZ+lnCryUR34UjtTFuGD553M+TqDeoENB4//FoxR6xE1dQDR4
         /Xaf6tKrixSVGuogxswQ+vcIfFE4/JfGMU9YFNlI/cNGnYn48SxSANAmvCoAe3wnfNwp
         JrUkm9wMM66LhJoxqRXYiQcu5QOGjiRDVHfBIY9awYWI1pjxsTX0W3D1uDpTl7ExR4Gv
         MaC6ZP/ntAo/k8OlPboV+RMMoY6Etv5eWyljyyVbX68ezQb7y7U/4+3caZhguK08fO+M
         mt8P/7YZVTUoWKSDw1Os2eLxDuUI3+O759R9HaZkJJSN0sYkyAhFpYV1phtpsoIENu6T
         JpTA==
X-Gm-Message-State: ANoB5pmWU8EGQvOtUirjT4bd4invyw3OvtM+R619FcwwVtDvez8VClWs
        YOQtjHO2J/3tetOoG1c+B6lIugY6li0=
X-Google-Smtp-Source: AA0mqf5JVT6/EGwVQYdrrS4WjSUdAwMbZvSMr7qyrnreIBIXfo/dPr2WR36/xX3mPMKWJMhPdZPg4A==
X-Received: by 2002:a05:600c:4a11:b0:3cf:b128:39ad with SMTP id c17-20020a05600c4a1100b003cfb12839admr7022676wmp.127.1667947470039;
        Tue, 08 Nov 2022 14:44:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b003cf878c4468sm17473583wms.5.2022.11.08.14.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:44:29 -0800 (PST)
Message-Id: <319f1d71b2e63455f319f1b460515fe0c4af33f6.1667947465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 22:44:24 +0000
Subject: [PATCH 4/5] read-tree: use 'skip_cache_tree_update' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
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

