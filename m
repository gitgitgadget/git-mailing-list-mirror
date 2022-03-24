Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3847DC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345265AbiCXFAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 01:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345810AbiCXFA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 01:00:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1E82C669
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b19so4913833wrh.11
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fVqX14TjGWGRDpi6324fkA+5n46rvcugh6p5qU84Jk8=;
        b=c1GRz33kgKHa1NefEII5us34Nzpe3VR7AWNdOpWXed56B2gpHUIwR450FxUeQnHD7x
         3ArYnkqJ6KdesAdgnaKYNVTEozczipk+6r2uZNxH+8OiNvQLLbkKAV0KrWLgcymV59AQ
         g9idETfaN8LkkSTpBUMKt9M8Sq5ntfVD4vLj8d2CQPqbTKUtFZa02QHaznRLpsNfCVnk
         qpXN1aGYZBaimWy9/5+yujZ4O1N9C6+RI2tmbwg7IFOCInGdjKaE1wVwCwvgv67DpixG
         c74L8kHTr7C5ytwQoHzaYNv2OBmj0mgBL6VXkFdDtJ4jeEjKXMiFRVU0sY/660UNh5vu
         qbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fVqX14TjGWGRDpi6324fkA+5n46rvcugh6p5qU84Jk8=;
        b=Iaw8K/9QY6FBZ9CMBNkv3GVRxiLBuXRuLMIpvQ1hM/WnK+jmP+oRxUIs2+6T+9ez1Z
         RlOvzqUBO6px504DRgx2cpkvxj5fqPzNyTdJ65GyLHgICZGPKjxboXNbMkWAG0SCHUHS
         0WkgThchuU7+DyS/ZdNaRM1E1vZGTg4LU3fGby9c4qPMpG7IQvG+ZbcQJKr2ng5M78m4
         xTmkWtE86eS0D+stOO09nugizLmYInMsbyhZVfeGkxQbe+NtLDIK1WXQhnAGENfjLBFH
         ugsJlVBCkVhLwwsiW+GjhVpDr62ku45/T4WJPWyZzKqM2/LTbpgO56kGdPdI80BLCSpT
         srhQ==
X-Gm-Message-State: AOAM532JBb7IoXLv24+PiV4EAItFUbJ+2lnebSeIC4rHRj2imxxCwALH
        clAJcYjNDBWaAdSMgKX3eBmZddwrpmo=
X-Google-Smtp-Source: ABdhPJy+aEqQ4NRSB4f/5nWz0Z1L1FeRv+mArvjaSVtV4aGqhg6vQZt9llLjXaD9fy9wg0hCJhzVyA==
X-Received: by 2002:a5d:48d1:0:b0:1e3:2401:f229 with SMTP id p17-20020a5d48d1000000b001e32401f229mr2851546wrs.694.1648097921990;
        Wed, 23 Mar 2022 21:58:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d63c5000000b002040822b680sm2301091wrw.81.2022.03.23.21.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 21:58:41 -0700 (PDT)
Message-Id: <b5f371e97fee69d87da1dccd3180de0691c15834.1648097906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 04:58:24 +0000
Subject: [PATCH v3 09/11] core.fsyncmethod: tests for batch mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Add test cases to exercise batch mode for:
 * 'git add'
 * 'git stash'
 * 'git update-index'
 * 'git unpack-objects'

These tests ensure that the added data winds up in the object database.

In this change we introduce a new test helper lib-unique-files.sh. The
goal of this library is to create a tree of files that have different
oids from any other files that may have been created in the current test
repo. This helps us avoid missing validation of an object being added
due to it already being in the repo.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/lib-unique-files.sh  | 32 ++++++++++++++++++++++++++++++++
 t/t3700-add.sh         | 28 ++++++++++++++++++++++++++++
 t/t3903-stash.sh       | 20 ++++++++++++++++++++
 t/t5300-pack-object.sh | 41 +++++++++++++++++++++++++++--------------
 4 files changed, 107 insertions(+), 14 deletions(-)
 create mode 100644 t/lib-unique-files.sh

diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
new file mode 100644
index 00000000000..74efca91dd7
--- /dev/null
+++ b/t/lib-unique-files.sh
@@ -0,0 +1,32 @@
+# Helper to create files with unique contents
+
+# Create multiple files with unique contents within this test run. Takes the
+# number of directories, the number of files in each directory, and the base
+# directory.
+#
+# test_create_unique_files 2 3 my_dir -- Creates 2 directories with 3 files
+#					 each in my_dir, all with contents
+#					 different from previous invocations
+#					 of this command in this run.
+
+test_create_unique_files () {
+	test "$#" -ne 3 && BUG "3 param"
+
+	local dirs="$1" &&
+	local files="$2" &&
+	local basedir="$3" &&
+	local counter=0 &&
+	test_tick &&
+	local basedata=$basedir$test_tick &&
+	rm -rf "$basedir" &&
+	for i in $(test_seq $dirs)
+	do
+		local dir=$basedir/dir$i &&
+		mkdir -p "$dir" &&
+		for j in $(test_seq $files)
+		do
+			counter=$((counter + 1)) &&
+			echo "$basedata.$counter">"$dir/file$j.txt"
+		done
+	done
+}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index b1f90ba3250..8979c8a5f03 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -8,6 +8,8 @@ test_description='Test of git add, including the -- option.'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+. $TEST_DIRECTORY/lib-unique-files.sh
+
 # Test the file mode "$1" of the file "$2" in the index.
 test_mode_in_index () {
 	case "$(git ls-files -s "$2")" in
@@ -34,6 +36,32 @@ test_expect_success \
     'Test that "git add -- -q" works' \
     'touch -- -q && git add -- -q'
 
+BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
+
+test_expect_success 'git add: core.fsyncmethod=batch' "
+	test_create_unique_files 2 4 files_base_dir1 &&
+	GIT_TEST_FSYNC=1 git $BATCH_CONFIGURATION add -- ./files_base_dir1/ &&
+	git ls-files --stage files_base_dir1/ |
+	test_parse_ls_files_stage_oids >added_files_oids &&
+
+	# We created 2 subdirs with 4 files each (8 files total) above
+	test_line_count = 8 added_files_oids &&
+	git cat-file --batch-check='%(objectname)' <added_files_oids >added_files_actual &&
+	test_cmp added_files_oids added_files_actual
+"
+
+test_expect_success 'git update-index: core.fsyncmethod=batch' "
+	test_create_unique_files 2 4 files_base_dir2 &&
+	find files_base_dir2 ! -type d -print | xargs git $BATCH_CONFIGURATION update-index --add -- &&
+	git ls-files --stage files_base_dir2 |
+	test_parse_ls_files_stage_oids >added_files2_oids &&
+
+	# We created 2 subdirs with 4 files each (8 files total) above
+	test_line_count = 8 added_files2_oids &&
+	git cat-file --batch-check='%(objectname)' <added_files2_oids >added_files2_actual &&
+	test_cmp added_files2_oids added_files2_actual
+"
+
 test_expect_success \
 	'git add: Test that executable bit is not used if core.filemode=0' \
 	'git config core.filemode 0 &&
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 4abbc8fccae..20e94881964 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -9,6 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. $TEST_DIRECTORY/lib-unique-files.sh
 
 test_expect_success 'usage on cmd and subcommand invalid option' '
 	test_expect_code 129 git stash --invalid-option 2>usage &&
@@ -1410,6 +1411,25 @@ test_expect_success 'stash handles skip-worktree entries nicely' '
 	git rev-parse --verify refs/stash:A.t
 '
 
+
+BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
+
+test_expect_success 'stash with core.fsyncmethod=batch' "
+	test_create_unique_files 2 4 files_base_dir &&
+	GIT_TEST_FSYNC=1 git $BATCH_CONFIGURATION stash push -u -- ./files_base_dir/ &&
+
+	# The files were untracked, so use the third parent,
+	# which contains the untracked files
+	git ls-tree -r stash^3 -- ./files_base_dir/ |
+	test_parse_ls_tree_oids >stashed_files_oids &&
+
+	# We created 2 dirs with 4 files each (8 files total) above
+	test_line_count = 8 stashed_files_oids &&
+	git cat-file --batch-check='%(objectname)' <stashed_files_oids >stashed_files_actual &&
+	test_cmp stashed_files_oids stashed_files_actual
+"
+
+
 test_expect_success 'git stash succeeds despite directory/file change' '
 	test_create_repo directory_file_switch_v1 &&
 	(
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index a11d61206ad..f8a0f309e2d 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -161,22 +161,27 @@ test_expect_success 'pack-objects with bogus arguments' '
 '
 
 check_unpack () {
+	local packname="$1" &&
+	local object_list="$2" &&
+	local git_config="$3" &&
 	test_when_finished "rm -rf git2" &&
-	git init --bare git2 &&
-	git -C git2 unpack-objects -n <"$1".pack &&
-	git -C git2 unpack-objects <"$1".pack &&
-	(cd .git && find objects -type f -print) |
-	while read path
-	do
-		cmp git2/$path .git/$path || {
-			echo $path differs.
-			return 1
-		}
-	done
+	git $git_config init --bare git2 &&
+	(
+		git $git_config -C git2 unpack-objects -n <"$packname".pack &&
+		git $git_config -C git2 unpack-objects <"$packname".pack &&
+		git $git_config -C git2 cat-file --batch-check="%(objectname)"
+	) <"$object_list" >current &&
+	cmp "$object_list" current
 }
 
 test_expect_success 'unpack without delta' '
-	check_unpack test-1-${packname_1}
+	check_unpack test-1-${packname_1} obj-list
+'
+
+BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
+
+test_expect_success 'unpack without delta (core.fsyncmethod=batch)' '
+	check_unpack test-1-${packname_1} obj-list "$BATCH_CONFIGURATION"
 '
 
 test_expect_success 'pack with REF_DELTA' '
@@ -185,7 +190,11 @@ test_expect_success 'pack with REF_DELTA' '
 '
 
 test_expect_success 'unpack with REF_DELTA' '
-	check_unpack test-2-${packname_2}
+	check_unpack test-2-${packname_2} obj-list
+'
+
+test_expect_success 'unpack with REF_DELTA (core.fsyncmethod=batch)' '
+       check_unpack test-2-${packname_2} obj-list "$BATCH_CONFIGURATION"
 '
 
 test_expect_success 'pack with OFS_DELTA' '
@@ -195,7 +204,11 @@ test_expect_success 'pack with OFS_DELTA' '
 '
 
 test_expect_success 'unpack with OFS_DELTA' '
-	check_unpack test-3-${packname_3}
+	check_unpack test-3-${packname_3} obj-list
+'
+
+test_expect_success 'unpack with OFS_DELTA (core.fsyncmethod=batch)' '
+       check_unpack test-3-${packname_3} obj-list "$BATCH_CONFIGURATION"
 '
 
 test_expect_success 'compare delta flavors' '
-- 
gitgitgadget

