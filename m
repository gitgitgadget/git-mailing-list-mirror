Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1A4C433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiCAU1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbiCAU0p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:26:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987008EB43
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:24:39 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d17so22276450wrc.9
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 12:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=c9yWbLZW8HFt+k72kqua9y2FZXPRLsuIJ24GnVy1oak=;
        b=NNJZWWziRx6oScGpfr9mS3TZ02AnTjoqckdL0kVHufFbBNJnaOju6C09lnWQlrS8cD
         36OH1Ls7wUe1grmAZiEfYmckFtgTzgXS1CKr/OxecaMY3MGeB37ZDU8K/27reQMZ8bRy
         iHqn7TViVKV3UYHX/K1XvyQ7fVTxG2g5B9NCuRPVEzuXWalfs95pk0b96AbKmvbsd+Av
         fu8fxBp5ZEXu+6p+vCWxf+JFPaFkxkHeDE9kMnsbEFkW1I5I1lYUjcJVKndSKl3vu+LE
         ucS8GJ0UipHjW2Do396N8GWLl4MgmgTrQJn/xrpVASoGVNJNqqn6Job8xwRMafGYSRp1
         dWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=c9yWbLZW8HFt+k72kqua9y2FZXPRLsuIJ24GnVy1oak=;
        b=BiPqm109v7eyu2CitJ00ZCZD0dzJosvnxo6VuVrqnRfbGEJ2cfDnm/rAcraAYnjm/J
         PEZMVXhJCGwOuuvdIDmX/4dkzV3/GpxhEqCLK/Vr2TN0rypTKtOfS+8CQPMBSEHUeOHw
         hlBYLewdFjLnj3rM4mFStEzfTUQpWapeHChAuuADzWuxWoGjDl+9ubTVKYb0fohS/Xy+
         Bxkbo9NpPgjU6IKkcsvUaTMHcFNGJs+/haIfSVeUKfxov/9Optu87MH+ICb3Sd7W+rIm
         PPtoGD88wv5SWpkCYHUwy13HvBoNiao1bDuhZJ4iUF9M+VnIIAQKpvdY42JEdr4ynmak
         mmdA==
X-Gm-Message-State: AOAM5334FuDAU5a5UBAdXCm/VbWcopwaZKhAFi7gIxbcy30nMC1UqvYy
        tqi2LfhxBZRUS0uwRQHsdB+3FVCsmfQ=
X-Google-Smtp-Source: ABdhPJzb6MpHfEOt2RjotYZRymtZzH9scTfNO4YT/hwkSQbS3NjQ6GT+0oTMVpsNex9KFChBje+6GA==
X-Received: by 2002:adf:ef81:0:b0:1f0:95f:30a7 with SMTP id d1-20020adfef81000000b001f0095f30a7mr3779828wro.636.1646166275918;
        Tue, 01 Mar 2022 12:24:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6043000000b001f0247bbdf7sm956647wrt.64.2022.03.01.12.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 12:24:35 -0800 (PST)
Message-Id: <90ebcb7b8ff4b4f1ba09abcbe636d639fa597e74.1646166271.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
References: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
        <pull.1157.v3.git.1646166271.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 20:24:27 +0000
Subject: [PATCH v3 4/8] read-tree: expand sparse checkout test coverage
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add tests focused on how 'git read-tree' behaves in sparse checkouts. Extra
emphasis is placed on interactions with files outside the sparse cone, e.g.
merges with out-of-cone conflicts.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 87 ++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

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
index b1dcaa0e642..9bb5aeb979c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -819,6 +819,93 @@ test_expect_success 'update-index --cacheinfo' '
 	test_cmp expect sparse-checkout-out
 '
 
+for MERGE_TREES in "base HEAD update-folder2" \
+		   "update-folder1 update-folder2" \
+		   "update-folder2"
+do
+	test_expect_success "'read-tree -mu $MERGE_TREES' with files outside sparse definition" '
+		init_repos &&
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
+		test_cmp sparse-checkout/folder2/a full-checkout/folder2/a
+
+	'
+done
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
+test_expect_success 'read-tree --prefix' '
+	init_repos &&
+
+	# If files differing between the index and target <commit-ish> exist
+	# inside the prefix, `read-tree --prefix` should fail
+	test_all_match test_must_fail git read-tree --prefix=deep/ deepest &&
+	test_all_match test_must_fail git read-tree --prefix=folder1/ update-folder1 &&
+
+	# If no differing index entries exist matching the prefix,
+	# `read-tree --prefix` updates the index successfully
+	test_all_match git rm -rf deep/deeper1/deepest/ &&
+	test_all_match git read-tree --prefix=deep/deeper1/deepest -u deepest &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git rm -rf --sparse folder1/ &&
+	test_all_match git read-tree --prefix=folder1/ -u update-folder1 &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git rm -rf --sparse folder2/0 &&
+	test_all_match git read-tree --prefix=folder2/0/ -u rename-out-to-out &&
+	test_all_match git status --porcelain=v2
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

