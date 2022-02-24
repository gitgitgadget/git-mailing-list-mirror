Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0BFC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 22:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbiBXWfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbiBXWfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 17:35:14 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE10F1E3770
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s1so1770945wrg.10
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 14:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Gl8Ky/hGrIT7Vpt1VCymg9PVQ9UsiYvNL+d+J0ivp5I=;
        b=eFGNGgKZ1jHeV9amQGAnPeScsqgFN60F8DzUgcUva0wyhxtXg2AOhneZNrtH1xzHeh
         lhbzpWo/jfM+KHhxrK2C4TPGEu3N+0rCbM/KZ3/Be1XnnWTBgto4uuZIgqicFXEtDmxF
         X2KYLoHhs1eWtJMmCt+XZtktcEM29RiougSk82Ns4yvvsfLNI0kVhn/L1bZKSYtq78iD
         BbX+X1/3DllD+n32WQwxV3L/CPwJQOdessfvUPUWwM0ze6VA9QnousS8u3fJHciOOr3F
         s3nB/RrCJ1tTdMVi/Nw9fBLNaTGJzC0N9yqJX2a6h+IpYpO3nC9PKTrmL4npTItqVaNg
         AXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Gl8Ky/hGrIT7Vpt1VCymg9PVQ9UsiYvNL+d+J0ivp5I=;
        b=gikVzZPkPtGg4Au6HB9MuHRVzEaWjSXJtNIQLU2/MLSiQ1/WucOSL15AQhwBk/0zZZ
         vycBUm6h5ghNMhCAJyTrKXdL1WYQ9l3IPBOTu4QBCRUBYMP/CX0gB0tlZeX9RwuDjXZl
         th+sU9RPKxL5BZjjTuJpz8KINh9e45a2a+e/R8EuXZfMB25VsNIX2oYu8uyagb1jHfSf
         cybqke6bH5LvMXfpp6ySX76lNaeUnUHHcsMbxN1oK4v3XwdG6SGI1PTenPi0Ce9BN0fU
         Mmv38m0w5wsrKkVyck7qPFAQqYjEWLiGGvtONYlmwl6InguHVrIQ+7Fsm8PkDRtSv56M
         GDUw==
X-Gm-Message-State: AOAM530oAA9ltdV2KsoblITjWvwwp8KrAxSwv4z6XRw9WWa7t7uFo8aY
        MAFKRLLY2qWlheXhvzGQh3l+Hoywr7s=
X-Google-Smtp-Source: ABdhPJwXDWBC+I1JV1gt2MGOYU0qeSi1hSXw+DTAVU0tZH2SLG/op0ItVPNHLye4RXBZtrOZWA+NrA==
X-Received: by 2002:a05:6000:1e15:b0:1ed:9f23:1dba with SMTP id bj21-20020a0560001e1500b001ed9f231dbamr3875506wrb.449.1645742077299;
        Thu, 24 Feb 2022 14:34:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14-20020adfed4e000000b001e3323611e5sm578666wro.26.2022.02.24.14.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:34:36 -0800 (PST)
Message-Id: <ffe0b6aff2baee238f77ae57561a62ea5473321f.1645742073.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
        <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 22:34:29 +0000
Subject: [PATCH v2 3/7] read-tree: expand sparse checkout test coverage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add tests focused on how 'git read-tree' behaves in sparse checkouts. Extra
emphasis is placed on interactions with files outside the sparse cone, e.g.
merges with out-of-cone conflicts.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 85 ++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 2a7106b9495..382716cfca9 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -117,6 +117,7 @@ test_perf_on_all git diff
 test_perf_on_all git diff --cached
 test_perf_on_all git blame $SPARSE_CONE/a
 test_perf_on_all git blame $SPARSE_CONE/f3/a
+test_perf_on_all git read-tree -mu HEAD
 test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index b1dcaa0e642..9d58da4e925 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -819,6 +819,91 @@ test_expect_success 'update-index --cacheinfo' '
 	test_cmp expect sparse-checkout-out
 '
 
+test_expect_success 'read-tree --merge with files outside sparse definition' '
+	init_repos &&
+
+	test_all_match git checkout -b test-branch update-folder1 &&
+	for MERGE_TREES in "base HEAD update-folder2" \
+			   "update-folder1 update-folder2" \
+			   "update-folder2"
+	do
+		# Clean up and remove on-disk files
+		test_all_match git reset --hard HEAD &&
+		test_sparse_match git sparse-checkout reapply &&
+
+		# Although the index matches, without --no-sparse-checkout, outside-of-
+		# definition files will not exist on disk for sparse checkouts
+		test_all_match git read-tree -mu $MERGE_TREES &&
+		test_all_match git status --porcelain=v2 &&
+		test_path_is_missing sparse-checkout/folder2 &&
+		test_path_is_missing sparse-index/folder2 &&
+
+		test_all_match git read-tree --reset -u HEAD &&
+		test_all_match git status --porcelain=v2 &&
+
+		test_all_match git read-tree -mu --no-sparse-checkout $MERGE_TREES &&
+		test_all_match git status --porcelain=v2 &&
+		test_cmp sparse-checkout/folder2/a sparse-index/folder2/a &&
+		test_cmp sparse-checkout/folder2/a full-checkout/folder2/a || return 1
+	done
+'
+
+test_expect_success 'read-tree --merge with edit/edit conflicts in sparse directories' '
+	init_repos &&
+
+	# Merge of multiple changes to same directory (but not same files) should
+	# succeed
+	test_all_match git read-tree -mu base rename-base update-folder1 &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset --hard &&
+
+	test_all_match git read-tree -mu rename-base update-folder2 &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset --hard &&
+
+	test_all_match test_must_fail git read-tree -mu base update-folder1 rename-out-to-in &&
+	test_all_match test_must_fail git read-tree -mu rename-out-to-in update-folder1
+'
+
+test_expect_success 'read-tree --prefix outside sparse definition' '
+	init_repos &&
+
+	# Cannot read-tree --prefix with a single argument when files exist within
+	# prefix
+	test_all_match test_must_fail git read-tree --prefix=folder1/ -u update-folder1 &&
+
+	test_all_match git read-tree --prefix=folder2/0 -u rename-base &&
+	test_path_is_missing sparse-checkout/folder2 &&
+	test_path_is_missing sparse-index/folder2 &&
+
+	test_all_match git read-tree --reset -u HEAD &&
+	test_all_match git read-tree --prefix=folder2/0 -u --no-sparse-checkout rename-base &&
+	test_cmp sparse-checkout/folder2/0/a sparse-index/folder2/0/a &&
+	test_cmp sparse-checkout/folder2/0/a full-checkout/folder2/0/a
+'
+
+test_expect_success 'read-tree --merge with directory-file conflicts' '
+	init_repos &&
+
+	test_all_match git checkout -b test-branch rename-base &&
+
+	# Although the index matches, without --no-sparse-checkout, outside-of-
+	# definition files will not exist on disk for sparse checkouts
+	test_sparse_match git read-tree -mu rename-out-to-out &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_path_is_missing sparse-checkout/folder2 &&
+	test_path_is_missing sparse-index/folder2 &&
+
+	test_sparse_match git read-tree --reset -u HEAD &&
+	test_sparse_match git status --porcelain=v2 &&
+
+	test_sparse_match git read-tree -mu --no-sparse-checkout rename-out-to-out &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_cmp sparse-checkout/folder2/0/1 sparse-index/folder2/0/1
+'
+
 test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-- 
gitgitgadget

