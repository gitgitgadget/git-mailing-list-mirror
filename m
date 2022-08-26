Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D5DECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 03:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbiHZDt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 23:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiHZDt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 23:49:26 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40FFA0639
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 20:49:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m16so316488wru.9
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 20:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=S3zMgZg4mosO1tFDxcH9Atc43naiumv32Lq/ReKH90c=;
        b=YA/w8flmkcNvKvpo/6ttLtEPnY6VA6O2QUlctZAPhkyPTbHBZIgZdQZ8fuIeBiEeq+
         cjGOObrCB9mUc+jgpcp/E/jBIJPNC9AdO/xxL+sn0viuWAhVLJm2mMDP1dBcZMJa/6h7
         5mnWvVuzrucjOIUZBCCmrO4edf4vNmywa+GzYxZVHxg/URCUY+WPg+mWGlb2tVhC2GF9
         R3DcWzTTvf+EeMCbRUqH64jvJz4CgEUgV0XkNUxwCAuIoXqxgjmcuiC56kghaMpzu3kL
         UJBmKNZYGo7Ma2C4H1OMZZbuSHqg5xQ07V1msRqaoT4M3mseUfAdYnVZfNe538EvAsva
         KBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=S3zMgZg4mosO1tFDxcH9Atc43naiumv32Lq/ReKH90c=;
        b=sBInmdMFVjeoSQVjkAZZw+Em9xEWNo6KQZtVuAqaAAbh0UTcMrKJeo0OX1UcqpMOXS
         SueyuHSb6s0W//zE2vtc/ObIQf7Z7ox/+hpFtuWuBrA4H1W6wwC9eFnRduKskHW49wIf
         pQl39SQe1n53C6A+e0/L4XT8KlXVnfYRDAfnMHe+udzCNa3gm7mG5/AgMZYpGFjVeyhQ
         xo60hhC3kJLY1Ir58VENsLiKdOHJ290WgUl2n6z3KOtZp1tYy8cRVU6AC7j2fydPwGOG
         21m0hNqXdoYPkNgm0fUMjYxECeIx2QBOMFufCiBnqS5gdmcmYh5kXqhD4xDmRFcZxEte
         L3Hg==
X-Gm-Message-State: ACgBeo1CDjb2ALu69Iq2Z9IYkODjjqAN0NYFzGYKDLVlnru0VBi0riY6
        fHDpp9CjpOf4Ui3fGYm9SZXI4fTcYZ0=
X-Google-Smtp-Source: AA6agR5k6ktPtqhS5evZJM03E+RwOpfTsZrm4HZmRReJowU/HZKSI31LAk8MGbTrLnh7Nk4yy2Lyqg==
X-Received: by 2002:adf:fbd2:0:b0:21e:7f74:5df1 with SMTP id d18-20020adffbd2000000b0021e7f745df1mr3718646wrs.43.1661485761461;
        Thu, 25 Aug 2022 20:49:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a7bc5c9000000b003a327b98c0asm1056100wmk.22.2022.08.25.20.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 20:49:20 -0700 (PDT)
Message-Id: <pull.1303.v2.git.git.1661485759789.gitgitgadget@gmail.com>
In-Reply-To: <pull.1303.git.git.1661034837118.gitgitgadget@gmail.com>
References: <pull.1303.git.git.1661034837118.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Aug 2022 03:49:19 +0000
Subject: [PATCH v2] t64xx: convert 'test_create_repo' to 'git init'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Convert the merge-specific tests (those in the t64xx range) over to
using 'git init' instead of 'test_create_repo'.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    t64xx: convert 'test_create_repo' to 'git init'
    
    As promised[1].
    
    This patch merges cleanly with main & next & seen, and there are no
    current in-flight topics that add a test_create_repo call to the t64xx
    range of tests. This patch also gets rid of 37% of the test_create_repo
    calls in the entire testsuite.
    
    Changes since v1:
    
     * Tweaked commit message
     * Added Dscho's Reviewed-by
    
    [1]
    https://lore.kernel.org/git/CABPp-BEcojvfeuhp7rSi-O+9oEu4KpwPDwbKS-MiD1qCKde-CA@mail.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1303%2Fnewren%2Fnuke_test_create_repo_in_merge_tests-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1303/newren/nuke_test_create_repo_in_merge_tests-v2
Pull-Request: https://github.com/git/git/pull/1303

Range-diff vs v1:

 1:  ad1c38cc1eb ! 1:  cd2ebd98e3c t64??: convert 'test_create_repo' to 'git init'
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    t64??: convert 'test_create_repo' to 'git init'
     +    t64xx: convert 'test_create_repo' to 'git init'
      
     -    As promised[1], convert the merge-specific tests over to using 'git
     -    init' instead of 'test_create_repo'.
     -
     -    [1] https://lore.kernel.org/git/CABPp-BEcojvfeuhp7rSi-O+9oEu4KpwPDwbKS-MiD1qCKde-CA@mail.gmail.com/
     +    Convert the merge-specific tests (those in the t64xx range) over to
     +    using 'git init' instead of 'test_create_repo'.
      
     +    Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## t/t6400-merge-df.sh ##


 t/t6400-merge-df.sh                      |   2 +-
 t/t6406-merge-attr.sh                    |   4 +-
 t/t6416-recursive-corner-cases.sh        |  38 +++----
 t/t6421-merge-partial-clone.sh           |   2 +-
 t/t6422-merge-rename-corner-cases.sh     |  38 +++----
 t/t6423-merge-rename-directories.sh      | 138 +++++++++++------------
 t/t6426-merge-skip-unneeded-updates.sh   |  16 +--
 t/t6427-diff3-conflict-markers.sh        |  10 +-
 t/t6428-merge-conflicts-sparse.sh        |   2 +-
 t/t6429-merge-sequence-rename-caching.sh |  14 +--
 t/t6437-submodule-merge.sh               |   8 +-
 11 files changed, 136 insertions(+), 136 deletions(-)

diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 57a67cf3627..3de4ef6bd9e 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -126,7 +126,7 @@ test_expect_success 'Simple merge in repo with interesting pathnames' '
 	#     foo/bar-2/baz
 	# The fact that foo/bar-2 appears between foo/bar and foo/bar/baz
 	# can trip up some codepaths, and is the point of this test.
-	test_create_repo name-ordering &&
+	git init name-ordering &&
 	(
 		cd name-ordering &&
 
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 99abefd44b9..8650a88c40a 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -162,8 +162,8 @@ test_expect_success 'custom merge backend' '
 '
 
 test_expect_success 'up-to-date merge without common ancestor' '
-	test_create_repo repo1 &&
-	test_create_repo repo2 &&
+	git init repo1 &&
+	git init repo2 &&
 	test_tick &&
 	(
 		cd repo1 &&
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index 690c8482b13..17b54d625d0 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -19,7 +19,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 #
 
 test_expect_success 'setup basic criss-cross + rename with no modifications' '
-	test_create_repo basic-rename &&
+	git init basic-rename &&
 	(
 		cd basic-rename &&
 
@@ -85,7 +85,7 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
 #
 
 test_expect_success 'setup criss-cross + rename merges with basic modification' '
-	test_create_repo rename-modify &&
+	git init rename-modify &&
 	(
 		cd rename-modify &&
 
@@ -160,7 +160,7 @@ test_expect_success 'merge criss-cross + rename merges with basic modification'
 #
 
 test_expect_success 'setup differently handled merges of rename/add conflict' '
-	test_create_repo rename-add &&
+	git init rename-add &&
 	(
 		cd rename-add &&
 
@@ -324,7 +324,7 @@ test_expect_success 'git detects differently handled merges conflict, swapped' '
 # Merging commits D & E should result in modify/delete conflict.
 
 test_expect_success 'setup criss-cross + modify/delete resolved differently' '
-	test_create_repo modify-delete &&
+	git init modify-delete &&
 	(
 		cd modify-delete &&
 
@@ -499,7 +499,7 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete, rev
 #
 
 test_expect_success 'setup differently handled merges of directory/file conflict' '
-	test_create_repo directory-file &&
+	git init directory-file &&
 	(
 		cd directory-file &&
 
@@ -867,7 +867,7 @@ test_expect_failure 'merge of D2 & E4 merges a2s & reports conflict for a/file'
 # but that may cancel out at the final merge stage".
 
 test_expect_success 'setup rename/rename(1to2)/modify followed by what looks like rename/rename(2to1)/modify' '
-	test_create_repo rename-squared-squared &&
+	git init rename-squared-squared &&
 	(
 		cd rename-squared-squared &&
 
@@ -944,7 +944,7 @@ test_expect_success 'handle rename/rename(1to2)/modify followed by what looks li
 # content merge handled.
 
 test_expect_success 'setup criss-cross + rename/rename/add-source + modify/modify' '
-	test_create_repo rename-rename-add-source &&
+	git init rename-rename-add-source &&
 	(
 		cd rename-rename-add-source &&
 
@@ -1032,7 +1032,7 @@ test_expect_failure 'detect rename/rename/add-source for virtual merge-base' '
 # base of B & C needs to not delete B:c for that to work, though...
 
 test_expect_success 'setup criss-cross+rename/rename/add-dest + simple modify' '
-	test_create_repo rename-rename-add-dest &&
+	git init rename-rename-add-dest &&
 	(
 		cd rename-rename-add-dest &&
 
@@ -1111,7 +1111,7 @@ test_expect_success 'virtual merge base handles rename/rename(1to2)/add-dest' '
 # git detect it?
 
 test_expect_success 'setup symlink modify/modify' '
-	test_create_repo symlink-modify-modify &&
+	git init symlink-modify-modify &&
 	(
 		cd symlink-modify-modify &&
 
@@ -1178,7 +1178,7 @@ test_expect_merge_algorithm failure success 'check symlink modify/modify' '
 # git detect it?
 
 test_expect_success 'setup symlink add/add' '
-	test_create_repo symlink-add-add &&
+	git init symlink-add-add &&
 	(
 		cd symlink-add-add &&
 
@@ -1244,11 +1244,11 @@ test_expect_merge_algorithm failure success 'check symlink add/add' '
 # git detect it?
 
 test_expect_success 'setup submodule modify/modify' '
-	test_create_repo submodule-modify-modify &&
+	git init submodule-modify-modify &&
 	(
 		cd submodule-modify-modify &&
 
-		test_create_repo submod &&
+		git init submod &&
 		(
 			cd submod &&
 			touch file-A &&
@@ -1332,11 +1332,11 @@ test_expect_merge_algorithm failure success 'check submodule modify/modify' '
 # git detect it?
 
 test_expect_success 'setup submodule add/add' '
-	test_create_repo submodule-add-add &&
+	git init submodule-add-add &&
 	(
 		cd submodule-add-add &&
 
-		test_create_repo submod &&
+		git init submod &&
 		(
 			cd submod &&
 			touch file-A &&
@@ -1419,11 +1419,11 @@ test_expect_merge_algorithm failure success 'check submodule add/add' '
 # This is an obvious add/add conflict for 'path'.  Can git detect it?
 
 test_expect_success 'setup conflicting entry types (submodule vs symlink)' '
-	test_create_repo submodule-symlink-add-add &&
+	git init submodule-symlink-add-add &&
 	(
 		cd submodule-symlink-add-add &&
 
-		test_create_repo path &&
+		git init path &&
 		(
 			cd path &&
 			touch file-B &&
@@ -1494,7 +1494,7 @@ test_expect_merge_algorithm failure success 'check conflicting entry types (subm
 # This is an obvious add/add mode conflict.  Can git detect it?
 
 test_expect_success 'setup conflicting modes for regular file' '
-	test_create_repo regular-file-mode-conflict &&
+	git init regular-file-mode-conflict &&
 	(
 		cd regular-file-mode-conflict &&
 
@@ -1571,7 +1571,7 @@ test_expect_failure 'check conflicting modes for regular file' '
 #   to ensure that we handle it as well as practical.
 
 test_expect_success 'setup nested conflicts' '
-	test_create_repo nested_conflicts &&
+	git init nested_conflicts &&
 	(
 		cd nested_conflicts &&
 
@@ -1757,7 +1757,7 @@ test_expect_success 'check nested conflicts' '
 #   have three levels of conflict markers.  Can we distinguish all three?
 
 test_expect_success 'setup virtual merge base with nested conflicts' '
-	test_create_repo virtual_merge_base_has_nested_conflicts &&
+	git init virtual_merge_base_has_nested_conflicts &&
 	(
 		cd virtual_merge_base_has_nested_conflicts &&
 
diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index 36bcd7c3280..5413e5dd9d6 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -31,7 +31,7 @@ test_description="limiting blob downloads when merging with partial clones"
 
 test_setup_repo () {
 	test -d server && return
-	test_create_repo server &&
+	git init server &&
 	(
 		cd server &&
 
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 9b65768aed6..346253c7c88 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -11,7 +11,7 @@ TEST_PASSES_SANITIZE_LEAK=true
 . "$TEST_DIRECTORY"/lib-merge.sh
 
 test_setup_rename_delete_untracked () {
-	test_create_repo rename-delete-untracked &&
+	git init rename-delete-untracked &&
 	(
 		cd rename-delete-untracked &&
 
@@ -56,7 +56,7 @@ test_expect_success "Does git preserve Gollum's precious artifact?" '
 # We should be able to merge B & C cleanly
 
 test_setup_rename_modify_add_source () {
-	test_create_repo rename-modify-add-source &&
+	git init rename-modify-add-source &&
 	(
 		cd rename-modify-add-source &&
 
@@ -96,7 +96,7 @@ test_expect_failure 'rename/modify/add-source conflict resolvable' '
 '
 
 test_setup_break_detection_1 () {
-	test_create_repo break-detection-1 &&
+	git init break-detection-1 &&
 	(
 		cd break-detection-1 &&
 
@@ -144,7 +144,7 @@ test_expect_failure 'conflict caused if rename not detected' '
 '
 
 test_setup_break_detection_2 () {
-	test_create_repo break-detection-2 &&
+	git init break-detection-2 &&
 	(
 		cd break-detection-2 &&
 
@@ -192,7 +192,7 @@ test_expect_failure 'missed conflict if rename not detected' '
 #   Commit C: rename a->b, add unrelated a
 
 test_setup_break_detection_3 () {
-	test_create_repo break-detection-3 &&
+	git init break-detection-3 &&
 	(
 		cd break-detection-3 &&
 
@@ -268,7 +268,7 @@ test_expect_failure 'detect rename/add-source and preserve all data, merge other
 '
 
 test_setup_rename_directory () {
-	test_create_repo rename-directory-$1 &&
+	git init rename-directory-$1 &&
 	(
 		cd rename-directory-$1 &&
 
@@ -386,7 +386,7 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
 '
 
 test_setup_rename_directory_2 () {
-	test_create_repo rename-directory-2 &&
+	git init rename-directory-2 &&
 	(
 		cd rename-directory-2 &&
 
@@ -445,7 +445,7 @@ test_expect_success 'disappearing dir in rename/directory conflict handled' '
 #   Commit B: modify a, add different b
 
 test_setup_rename_with_content_merge_and_add () {
-	test_create_repo rename-with-content-merge-and-add-$1 &&
+	git init rename-with-content-merge-and-add-$1 &&
 	(
 		cd rename-with-content-merge-and-add-$1 &&
 
@@ -570,7 +570,7 @@ test_expect_success 'handle rename-with-content-merge vs. add, merge other way'
 #   * Nothing else should be present.  Is anything?
 
 test_setup_rename_rename_2to1 () {
-	test_create_repo rename-rename-2to1 &&
+	git init rename-rename-2to1 &&
 	(
 		cd rename-rename-2to1 &&
 
@@ -642,7 +642,7 @@ test_expect_success 'handle rename/rename (2to1) conflict correctly' '
 #   Commit B: rename a->b
 #   Commit C: rename a->c
 test_setup_rename_rename_1to2 () {
-	test_create_repo rename-rename-1to2 &&
+	git init rename-rename-1to2 &&
 	(
 		cd rename-rename-1to2 &&
 
@@ -700,7 +700,7 @@ test_expect_success 'merge has correct working tree contents' '
 # Merging of B & C should NOT be clean; there's a rename/rename conflict
 
 test_setup_rename_rename_1to2_add_source_1 () {
-	test_create_repo rename-rename-1to2-add-source-1 &&
+	git init rename-rename-1to2-add-source-1 &&
 	(
 		cd rename-rename-1to2-add-source-1 &&
 
@@ -748,7 +748,7 @@ test_expect_failure 'detect conflict with rename/rename(1to2)/add-source merge'
 '
 
 test_setup_rename_rename_1to2_add_source_2 () {
-	test_create_repo rename-rename-1to2-add-source-2 &&
+	git init rename-rename-1to2-add-source-2 &&
 	(
 		cd rename-rename-1to2-add-source-2 &&
 
@@ -794,7 +794,7 @@ test_expect_failure 'rename/rename/add-source still tracks new a file' '
 '
 
 test_setup_rename_rename_1to2_add_dest () {
-	test_create_repo rename-rename-1to2-add-dest &&
+	git init rename-rename-1to2-add-dest &&
 	(
 		cd rename-rename-1to2-add-dest &&
 
@@ -874,7 +874,7 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 #   Expected: CONFLICT (rename/add/delete), two-way merged bar
 
 test_setup_rad () {
-	test_create_repo rad &&
+	git init rad &&
 	(
 		cd rad &&
 		echo "original file" >foo &&
@@ -946,7 +946,7 @@ test_expect_merge_algorithm failure success 'rad-check: rename/add/delete confli
 #   Expected: CONFLICT (rename/rename/delete/delete), two-way merged baz
 
 test_setup_rrdd () {
-	test_create_repo rrdd &&
+	git init rrdd &&
 	(
 		cd rrdd &&
 		echo foo >foo &&
@@ -1022,7 +1022,7 @@ test_expect_merge_algorithm failure success 'rrdd-check: rename/rename(2to1)/del
 #             multi-way merged contents found in two, four, six
 
 test_setup_mod6 () {
-	test_create_repo mod6 &&
+	git init mod6 &&
 	(
 		cd mod6 &&
 		test_seq 11 19 >one &&
@@ -1160,7 +1160,7 @@ test_conflicts_with_adds_and_renames() {
 	#      tree
 	test_setup_collision_conflict () {
 	#test_expect_success "setup simple $sideL/$sideR conflict" '
-		test_create_repo simple_${sideL}_${sideR} &&
+		git init simple_${sideL}_${sideR} &&
 		(
 			cd simple_${sideL}_${sideR} &&
 
@@ -1308,7 +1308,7 @@ test_conflicts_with_adds_and_renames add    add
 #   So, we have four different conflicting files that all end up at path
 #   'three'.
 test_setup_nested_conflicts_from_rename_rename () {
-	test_create_repo nested_conflicts_from_rename_rename &&
+	git init nested_conflicts_from_rename_rename &&
 	(
 		cd nested_conflicts_from_rename_rename &&
 
@@ -1417,7 +1417,7 @@ test_expect_success 'check nested conflicts from rename/rename(2to1)' '
 #   Expected: CONFLICT(rename/rename) message, three unstaged entries in the
 #             index, and contents of orig-[AB] at path orig-[AB]
 test_setup_rename_rename_1_to_2_binary () {
-	test_create_repo rename_rename_1_to_2_binary &&
+	git init rename_rename_1_to_2_binary &&
 	(
 		cd rename_rename_1_to_2_binary &&
 
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 99baf77cbfd..a4941878fe2 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -40,7 +40,7 @@ test_description="recursive merge with directory renames"
 #   Expected: y/{b,c,d,e/f}
 
 test_setup_1a () {
-	test_create_repo 1a &&
+	git init 1a &&
 	(
 		cd 1a &&
 
@@ -106,7 +106,7 @@ test_expect_success '1a: Simple directory rename detection' '
 #   Expected: y/{b,c,d,e}
 
 test_setup_1b () {
-	test_create_repo 1b &&
+	git init 1b &&
 	(
 		cd 1b &&
 
@@ -169,7 +169,7 @@ test_expect_success '1b: Merge a directory with another' '
 #   Expected: y/{b,c,d}  (because x/d -> z/d -> y/d)
 
 test_setup_1c () {
-	test_create_repo 1c &&
+	git init 1c &&
 	(
 		cd 1c &&
 
@@ -232,7 +232,7 @@ test_expect_success '1c: Transitive renaming' '
 #         y/wham_1 & z/wham_2 should too...giving us a conflict.
 
 test_setup_1d () {
-	test_create_repo 1d &&
+	git init 1d &&
 	(
 		cd 1d &&
 
@@ -328,7 +328,7 @@ test_expect_success '1d: Directory renames cause a rename/rename(2to1) conflict'
 #   Expected: y/{newb,newc,d}
 
 test_setup_1e () {
-	test_create_repo 1e &&
+	git init 1e &&
 	(
 		cd 1e &&
 
@@ -387,7 +387,7 @@ test_expect_success '1e: Renamed directory, with all files being renamed too' '
 #   Expected: y/{b,c}, x/{d,e,f,g}
 
 test_setup_1f () {
-	test_create_repo 1f &&
+	git init 1f &&
 	(
 		cd 1f &&
 
@@ -476,7 +476,7 @@ test_expect_success '1f: Split a directory into two other directories' '
 #   Commit B: z/{b,c,d}
 #   Expected: y/b, w/c, z/d, with warning about z/ -> (y/ vs. w/) conflict
 test_setup_2a () {
-	test_create_repo 2a &&
+	git init 2a &&
 	(
 		cd 2a &&
 
@@ -538,7 +538,7 @@ test_expect_success '2a: Directory split into two on one side, with equal number
 #   Commit B: z/{b,c}, x/d
 #   Expected: y/b, w/c, x/d; No warning about z/ -> (y/ vs. w/) conflict
 test_setup_2b () {
-	test_create_repo 2b &&
+	git init 2b &&
 	(
 		cd 2b &&
 
@@ -620,7 +620,7 @@ test_expect_success '2b: Directory split into two on one side, with equal number
 #   Commit B: y/{b,c}, x/d
 #   Expected: y/{b,c}, x/d
 test_setup_3a () {
-	test_create_repo 3a &&
+	git init 3a &&
 	(
 		cd 3a &&
 
@@ -684,7 +684,7 @@ test_expect_success '3a: Avoid implicit rename if involved as source on other si
 #         end up with CONFLICT:(z/d -> y/d vs. x/d vs. w/d), i.e. a
 #         rename/rename/rename(1to3) conflict, which is just weird.
 test_setup_3b () {
-	test_create_repo 3b &&
+	git init 3b &&
 	(
 		cd 3b &&
 
@@ -807,7 +807,7 @@ test_expect_success '3b: Avoid implicit rename if involved as source on current
 #   NOTE: Even though most files from z moved to y, we don't want f to follow.
 
 test_setup_4a () {
-	test_create_repo 4a &&
+	git init 4a &&
 	(
 		cd 4a &&
 
@@ -896,7 +896,7 @@ test_expect_success '4a: Directory split, with original directory still present'
 #         index.
 
 test_setup_5a () {
-	test_create_repo 5a &&
+	git init 5a &&
 	(
 		cd 5a &&
 
@@ -971,7 +971,7 @@ test_expect_success '5a: Merge directories, other side adds files to original an
 #         back to git behavior without the directory rename detection.
 
 test_setup_5b () {
-	test_create_repo 5b &&
+	git init 5b &&
 	(
 		cd 5b &&
 
@@ -1048,7 +1048,7 @@ test_expect_success '5b: Rename/delete in order to get add/add/add conflict' '
 #             though, because it doesn't have anything in the way.
 
 test_setup_5c () {
-	test_create_repo 5c &&
+	git init 5c &&
 	(
 		cd 5c &&
 
@@ -1138,7 +1138,7 @@ test_expect_success '5c: Transitive rename would cause rename/rename/rename/add/
 #         directory rename detection for z/f -> y/f.
 
 test_setup_5d () {
-	test_create_repo 5d &&
+	git init 5d &&
 	(
 		cd 5d &&
 
@@ -1239,7 +1239,7 @@ test_expect_success '5d: Directory/file/file conflict due to directory rename' '
 #         it is also involved in a rename/delete conflict.
 
 test_setup_6a () {
-	test_create_repo 6a &&
+	git init 6a &&
 	(
 		cd 6a &&
 
@@ -1337,7 +1337,7 @@ test_expect_success '6a: Tricky rename/delete' '
 #         the behavior on testcases 6b2 and 8e, and introduced this 6b1 testcase.
 
 test_setup_6b1 () {
-	test_create_repo 6b1 &&
+	git init 6b1 &&
 	(
 		cd 6b1 &&
 
@@ -1415,7 +1415,7 @@ test_expect_merge_algorithm failure success '6b1: Same renames done on both side
 #         the z/ -> y/ rename.
 
 test_setup_6b2 () {
-	test_create_repo 6b2 &&
+	git init 6b2 &&
 	(
 		cd 6b2 &&
 
@@ -1479,7 +1479,7 @@ test_expect_merge_algorithm failure success '6b2: Same rename done on both sides
 #         "accidentally detect a rename" and give us y/{b,c,d}.
 
 test_setup_6c () {
-	test_create_repo 6c &&
+	git init 6c &&
 	(
 		cd 6c &&
 
@@ -1542,7 +1542,7 @@ test_expect_success '6c: Rename only done on same side' '
 #         doesn't "accidentally detect a rename" and give us y/{b,c,d}.
 
 test_setup_6d () {
-	test_create_repo 6d &&
+	git init 6d &&
 	(
 		cd 6d &&
 
@@ -1605,7 +1605,7 @@ test_expect_success '6d: We do not always want transitive renaming' '
 #         add/add conflict on y/d_1 vs y/d_2.
 
 test_setup_6e () {
-	test_create_repo 6e &&
+	git init 6e &&
 	(
 		cd 6e &&
 
@@ -1700,7 +1700,7 @@ test_expect_success '6e: Add/add from one side' '
 #   NOTE: There's a rename of z/ here, y/ has more renames, so z/d -> y/d.
 
 test_setup_7a () {
-	test_create_repo 7a &&
+	git init 7a &&
 	(
 		cd 7a &&
 
@@ -1772,7 +1772,7 @@ test_expect_success '7a: rename-dir vs. rename-dir (NOT split evenly) PLUS add-o
 #   Expected: y/{b,c}, CONFLICT(rename/rename(2to1): x/d_1, w/d_2 -> y_d)
 
 test_setup_7b () {
-	test_create_repo 7b &&
+	git init 7b &&
 	(
 		cd 7b &&
 
@@ -1861,7 +1861,7 @@ test_expect_success '7b: rename/rename(2to1), but only due to transitive rename'
 #         nor CONFLiCT x/d -> w/d vs. y/d vs. z/d)
 
 test_setup_7c () {
-	test_create_repo 7c &&
+	git init 7c &&
 	(
 		cd 7c &&
 
@@ -1926,7 +1926,7 @@ test_expect_success '7c: rename/rename(1to...2or3); transitive rename may add co
 #   NOTE: z->y so NOT CONFLICT(delete x/d vs rename to z/d)
 
 test_setup_7d () {
-	test_create_repo 7d &&
+	git init 7d &&
 	(
 		cd 7d &&
 
@@ -2027,7 +2027,7 @@ test_expect_success '7d: transitive rename involved in rename/delete; how is it
 #         how it's resolved.
 
 test_setup_7e () {
-	test_create_repo 7e &&
+	git init 7e &&
 	(
 		cd 7e &&
 
@@ -2137,7 +2137,7 @@ test_expect_success '7e: transitive rename in rename/delete AND dirs in the way'
 # we potentially could.
 
 test_setup_8a () {
-	test_create_repo 8a &&
+	git init 8a &&
 	(
 		cd 8a &&
 
@@ -2216,7 +2216,7 @@ test_expect_success '8a: Dual-directory rename, one into the others way' '
 # e_1 and e_2.
 
 test_setup_8b () {
-	test_create_repo 8b &&
+	git init 8b &&
 	(
 		cd 8b &&
 
@@ -2290,7 +2290,7 @@ test_expect_success '8b: Dual-directory rename, one into the others way, with co
 #         notes in 8d.
 
 test_setup_8c () {
-	test_create_repo 8c &&
+	git init 8c &&
 	(
 		cd 8c &&
 
@@ -2370,7 +2370,7 @@ test_expect_success '8c: modify/delete or rename+modify/delete' '
 #   differently.
 
 test_setup_8d () {
-	test_create_repo 8d &&
+	git init 8d &&
 	(
 		cd 8d &&
 
@@ -2453,7 +2453,7 @@ test_expect_success '8d: rename/delete...or not?' '
 #        the behavior, and predict it without computing as many details.
 
 test_setup_8e () {
-	test_create_repo 8e &&
+	git init 8e &&
 	(
 		cd 8e &&
 
@@ -2537,7 +2537,7 @@ test_expect_success '8e: Both sides rename, one side adds to original directory'
 #         of that could take the new file in commit B at z/i to x/w/i or x/i.
 
 test_setup_9a () {
-	test_create_repo 9a &&
+	git init 9a &&
 	(
 		cd 9a &&
 
@@ -2609,7 +2609,7 @@ test_expect_success '9a: Inner renamed directory within outer renamed directory'
 #   Expected: y/{b,c,d_merged}
 
 test_setup_9b () {
-	test_create_repo 9b &&
+	git init 9b &&
 	(
 		cd 9b &&
 
@@ -2697,7 +2697,7 @@ test_expect_success '9b: Transitive rename with content merge' '
 #         history for any implicit directory renames.
 
 test_setup_9c () {
-	test_create_repo 9c &&
+	git init 9c &&
 	(
 		cd 9c &&
 
@@ -2786,7 +2786,7 @@ test_expect_success '9c: Doubly transitive rename?' '
 #   testcases and simplifies things for the user.
 
 test_setup_9d () {
-	test_create_repo 9d &&
+	git init 9d &&
 	(
 		cd 9d &&
 
@@ -2861,7 +2861,7 @@ test_expect_success '9d: N-way transitive rename?' '
 #             dir1/yo, dir2/yo, dir3/yo, dirN/yo
 
 test_setup_9e () {
-	test_create_repo 9e &&
+	git init 9e &&
 	(
 		cd 9e &&
 
@@ -2954,7 +2954,7 @@ test_expect_success '9e: N-to-1 whammo' '
 #   Expected: priority/{a,b}/$more_files, priority/c
 
 test_setup_9f () {
-	test_create_repo 9f &&
+	git init 9f &&
 	(
 		cd 9f &&
 
@@ -3027,7 +3027,7 @@ test_expect_success '9f: Renamed directory that only contained immediate subdirs
 # viewpoint...
 
 test_setup_9g () {
-	test_create_repo 9g &&
+	git init 9g &&
 	(
 		cd 9g &&
 
@@ -3096,7 +3096,7 @@ test_expect_failure '9g: Renamed directory that only contained immediate subdirs
 #   NOTE: If we applied the z/ -> y/ rename to z/d, then we'd end up with
 #         a rename/rename(1to2) conflict (z/d -> y/d vs. x/d)
 test_setup_9h () {
-	test_create_repo 9h &&
+	git init 9h &&
 	(
 		cd 9h &&
 
@@ -3177,7 +3177,7 @@ test_expect_success '9h: Avoid dir rename on merely modified path' '
 #       ERROR_MSG(untracked working tree files would be overwritten by merge)
 
 test_setup_10a () {
-	test_create_repo 10a &&
+	git init 10a &&
 	(
 		cd 10a &&
 
@@ -3243,7 +3243,7 @@ test_expect_success '10a: Overwrite untracked with normal rename/delete' '
 #       ERROR_MSG(refusing to lose untracked file at 'y/d')
 
 test_setup_10b () {
-	test_create_repo 10b &&
+	git init 10b &&
 	(
 		cd 10b &&
 
@@ -3334,7 +3334,7 @@ test_expect_success '10b: Overwrite untracked with dir rename + delete' '
 #             ERROR_MSG(Refusing to lose untracked file at y/c)
 
 test_setup_10c () {
-	test_create_repo 10c_$1 &&
+	git init 10c_$1 &&
 	(
 		cd 10c_$1 &&
 
@@ -3472,7 +3472,7 @@ test_expect_success '10c2: Overwrite untracked with dir rename/rename(1to2), oth
 #             ERROR_MSG(Refusing to lose untracked file at y/wham)
 
 test_setup_10d () {
-	test_create_repo 10d &&
+	git init 10d &&
 	(
 		cd 10d &&
 
@@ -3568,7 +3568,7 @@ test_expect_success '10d: Delete untracked with dir rename/rename(2to1)' '
 #   Expected: y/{a,b,c} + untracked z/c
 
 test_setup_10e () {
-	test_create_repo 10e &&
+	git init 10e &&
 	(
 		cd 10e &&
 
@@ -3650,7 +3650,7 @@ test_expect_merge_algorithm failure success '10e: Does git complain about untrac
 #             z/c with uncommitted mods on top of A:z/c_v1
 
 test_setup_11a () {
-	test_create_repo 11a &&
+	git init 11a &&
 	(
 		cd 11a &&
 
@@ -3728,7 +3728,7 @@ test_expect_success '11a: Avoid losing dirty contents with simple rename' '
 
 
 test_setup_11b () {
-	test_create_repo 11b &&
+	git init 11b &&
 	(
 		cd 11b &&
 
@@ -3810,7 +3810,7 @@ test_expect_success '11b: Avoid losing dirty file involved in directory rename'
 #             y/c left untouched (still has uncommitted mods)
 
 test_setup_11c () {
-	test_create_repo 11c &&
+	git init 11c &&
 	(
 		cd 11c &&
 
@@ -3883,7 +3883,7 @@ test_expect_success '11c: Avoid losing not-uptodate with rename + D/F conflict'
 #             y/{a,c~HEAD,c/d}, x/b, now-untracked z/c_v1 with uncommitted mods
 
 test_setup_11d () {
-	test_create_repo 11d &&
+	git init 11d &&
 	(
 		cd 11d &&
 
@@ -3968,7 +3968,7 @@ test_expect_success '11d: Avoid losing not-uptodate with rename + D/F conflict'
 #             y/c has dirty file from before merge
 
 test_setup_11e () {
-	test_create_repo 11e &&
+	git init 11e &&
 	(
 		cd 11e &&
 
@@ -4060,7 +4060,7 @@ test_expect_success '11e: Avoid deleting not-uptodate with dir rename/rename(1to
 #             ERROR_MSG(Refusing to lose dirty file at y/wham)
 
 test_setup_11f () {
-	test_create_repo 11f &&
+	git init 11f &&
 	(
 		cd 11f &&
 
@@ -4155,7 +4155,7 @@ test_expect_success '11f: Avoid deleting not-uptodate with dir rename/rename(2to
 #   Expected: node1/{leaf1,leaf2,leaf5,node2/{leaf3,leaf4,leaf6}}
 
 test_setup_12a () {
-	test_create_repo 12a &&
+	git init 12a &&
 	(
 		cd 12a &&
 
@@ -4238,7 +4238,7 @@ test_expect_success '12a: Moving one directory hierarchy into another' '
 #             node2/node1/{leaf1, leaf2}
 
 test_setup_12b1 () {
-	test_create_repo 12b1 &&
+	git init 12b1 &&
 	(
 		cd 12b1 &&
 
@@ -4327,7 +4327,7 @@ test_expect_merge_algorithm failure success '12b1: Moving two directory hierarch
 #         even simple rules give weird results when given weird inputs.
 
 test_setup_12b2 () {
-	test_create_repo 12b2 &&
+	git init 12b2 &&
 	(
 		cd 12b2 &&
 
@@ -4402,7 +4402,7 @@ test_expect_success '12b2: Moving two directory hierarchies into each other' '
 #         each side of the merge.
 
 test_setup_12c1 () {
-	test_create_repo 12c1 &&
+	git init 12c1 &&
 	(
 		cd 12c1 &&
 
@@ -4492,7 +4492,7 @@ test_expect_merge_algorithm failure success '12c1: Moving one directory hierarch
 #         on each side of the merge.
 
 test_setup_12c2 () {
-	test_create_repo 12c2 &&
+	git init 12c2 &&
 	(
 		cd 12c2 &&
 
@@ -4584,7 +4584,7 @@ test_expect_success '12c2: Moving one directory hierarchy into another w/ conten
 #   Expected: subdir/foo, bar
 
 test_setup_12d () {
-	test_create_repo 12d &&
+	git init 12d &&
 	(
 		cd 12d &&
 
@@ -4642,7 +4642,7 @@ test_expect_success '12d: Rename/merge subdir into the root, variant 1' '
 #   Expected: foo, bar
 
 test_setup_12e () {
-	test_create_repo 12e &&
+	git init 12e &&
 	(
 		cd 12e &&
 
@@ -4743,7 +4743,7 @@ test_expect_success '12e: Rename/merge subdir into the root, variant 2' '
 #      pick and re-applying them in the subsequent one.
 
 test_setup_12f () {
-	test_create_repo 12f &&
+	git init 12f &&
 	(
 		cd 12f &&
 
@@ -4902,7 +4902,7 @@ test_expect_merge_algorithm failure success '12f: Trivial directory resolve, cac
 #   Expected: newfile_{merged}, newdir/{a_B,b_B,c_A}
 
 test_setup_12g () {
-	test_create_repo 12g &&
+	git init 12g &&
 	(
 		cd 12g &&
 
@@ -4973,7 +4973,7 @@ test_expect_success '12g: Testcase with two kinds of "relevant" renames' '
 #   Expected: newdir/{alpha_2, b}
 
 test_setup_12h () {
-	test_create_repo 12h &&
+	git init 12h &&
 	(
 		cd 12h &&
 
@@ -5032,7 +5032,7 @@ test_expect_failure '12h: renaming a file within a renamed directory' '
 #                source/bar vs. source/subdir/bar
 
 test_setup_12i () {
-	test_create_repo 12i &&
+	git init 12i &&
 	(
 		cd 12i &&
 
@@ -5090,7 +5090,7 @@ test_expect_success '12i: Directory rename causes rename-to-self' '
 #   Expected: {foo, bar, baz_2}, with conflicts on bar vs. subdir/bar
 
 test_setup_12j () {
-	test_create_repo 12j &&
+	git init 12j &&
 	(
 		cd 12j &&
 
@@ -5148,7 +5148,7 @@ test_expect_success '12j: Directory rename to root causes rename-to-self' '
 #   Expected: dirA/{foo, bar, baz_2}, with conflicts on dirA/bar vs. dirB/bar
 
 test_setup_12k () {
-	test_create_repo 12k &&
+	git init 12k &&
 	(
 		cd 12k &&
 
@@ -5218,7 +5218,7 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 #   is needed for there to be a sub1/ -> sub3/ rename.
 
 test_setup_12l () {
-	test_create_repo 12l_$1 &&
+	git init 12l_$1 &&
 	(
 		cd 12l_$1 &&
 
@@ -5322,7 +5322,7 @@ test_expect_merge_algorithm failure success '12l (A into B): Rename into each ot
 #   Expected: y/{b,c,d,e/f}, with notices/conflicts for both y/d and y/e/f
 
 test_setup_13a () {
-	test_create_repo 13a_$1 &&
+	git init 13a_$1 &&
 	(
 		cd 13a_$1 &&
 
@@ -5409,7 +5409,7 @@ test_expect_success '13a(info): messages for newly added files' '
 #             one about content, and one about file location
 
 test_setup_13b () {
-	test_create_repo 13b_$1 &&
+	git init 13b_$1 &&
 	(
 		cd 13b_$1 &&
 
@@ -5496,7 +5496,7 @@ test_expect_success '13b(info): messages for transitive rename with conflicted c
 #             shown in testcase 13d.
 
 test_setup_13c () {
-	test_create_repo 13c_$1 &&
+	git init 13c_$1 &&
 	(
 		cd 13c_$1 &&
 
@@ -5584,7 +5584,7 @@ test_expect_success '13c(info): messages for rename/rename(1to1) via transitive
 #               No conflict in where a/y ends up, so put it in d/y.
 
 test_setup_13d () {
-	test_create_repo 13d_$1 &&
+	git init 13d_$1 &&
 	(
 		cd 13d_$1 &&
 
@@ -5710,7 +5710,7 @@ test_expect_success '13d(info): messages for rename/rename(1to1) via dual transi
 #          least avoids hitting a BUG().
 #
 test_setup_13e () {
-	test_create_repo 13e &&
+	git init 13e &&
 	(
 		cd 13e &&
 
diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-unneeded-updates.sh
index 7b5f1c1dcd1..2bb8e7f09bb 100755
--- a/t/t6426-merge-skip-unneeded-updates.sh
+++ b/t/t6426-merge-skip-unneeded-updates.sh
@@ -38,7 +38,7 @@ test_description="merge cases"
 #   Expected: b_2
 
 test_setup_1a () {
-	test_create_repo 1a_$1 &&
+	git init 1a_$1 &&
 	(
 		cd 1a_$1 &&
 
@@ -136,7 +136,7 @@ test_expect_success '1a-R: Modify(A)/Modify(B), change on B subset of A' '
 #   Expected: c_2
 
 test_setup_2a () {
-	test_create_repo 2a_$1 &&
+	git init 2a_$1 &&
 	(
 		cd 2a_$1 &&
 
@@ -229,7 +229,7 @@ test_expect_success '2a-R: Modify/rename, merge into rename side' '
 #   Expected: c_2
 
 test_setup_2b () {
-	test_create_repo 2b_$1 &&
+	git init 2b_$1 &&
 	(
 		cd 2b_$1 &&
 
@@ -336,7 +336,7 @@ test_expect_success '2b-R: Rename+Mod(A)/Mod(B), B mods subset of A' '
 #         not make that particular mistake.
 
 test_setup_2c () {
-	test_create_repo 2c &&
+	git init 2c &&
 	(
 		cd 2c &&
 
@@ -437,7 +437,7 @@ test_expect_success '2c: Modify b & add c VS rename b->c' '
 #   Expected: bar/{bq_2, whatever}
 
 test_setup_3a () {
-	test_create_repo 3a_$1 &&
+	git init 3a_$1 &&
 	(
 		cd 3a_$1 &&
 
@@ -537,7 +537,7 @@ test_expect_success '3a-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 #   Expected: bar/{bq_2, whatever}
 
 test_setup_3b () {
-	test_create_repo 3b_$1 &&
+	git init 3b_$1 &&
 	(
 		cd 3b_$1 &&
 
@@ -642,7 +642,7 @@ test_expect_success '3b-R: bq_1->foo/bq_2 on A, foo/->bar/ on B' '
 #   Expected: b_2 for merge, b_4 in working copy
 
 test_setup_4a () {
-	test_create_repo 4a &&
+	git init 4a &&
 	(
 		cd 4a &&
 
@@ -714,7 +714,7 @@ test_expect_merge_algorithm failure success '4a: Change on A, change on B subset
 #   Expected: c_2
 
 test_setup_4b () {
-	test_create_repo 4b &&
+	git init 4b &&
 	(
 		cd 4b &&
 
diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
index a9ee4cb207a..dd5fe6a4021 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -19,7 +19,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 #
 
 test_expect_success 'setup no merge base' '
-	test_create_repo no_merge_base &&
+	git init no_merge_base &&
 	(
 		cd no_merge_base &&
 
@@ -55,7 +55,7 @@ test_expect_success 'check no merge base' '
 #
 
 test_expect_success 'setup unique merge base' '
-	test_create_repo unique_merge_base &&
+	git init unique_merge_base &&
 	(
 		cd unique_merge_base &&
 
@@ -116,7 +116,7 @@ test_expect_success 'check unique merge base' '
 #
 
 test_expect_success 'setup multiple merge bases' '
-	test_create_repo multiple_merge_bases &&
+	git init multiple_merge_bases &&
 	(
 		cd multiple_merge_bases &&
 
@@ -190,7 +190,7 @@ test_expect_success 'check multiple merge bases' '
 '
 
 test_expect_success 'rebase --merge describes parent of commit being picked' '
-	test_create_repo rebase &&
+	git init rebase &&
 	(
 		cd rebase &&
 		test_commit base file &&
@@ -212,7 +212,7 @@ test_expect_success 'rebase --apply describes fake ancestor base' '
 '
 
 test_setup_zdiff3 () {
-	test_create_repo zdiff3 &&
+	git init zdiff3 &&
 	(
 		cd zdiff3 &&
 
diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sparse.sh
index 064be1b629e..9919c3fa7cd 100755
--- a/t/t6428-merge-conflicts-sparse.sh
+++ b/t/t6428-merge-conflicts-sparse.sh
@@ -29,7 +29,7 @@ test_description="merge cases"
 # Testcase basic, conflicting changes in 'numerals'
 
 test_setup_numerals () {
-	test_create_repo numerals_$1 &&
+	git init numerals_$1 &&
 	(
 		cd numerals_$1 &&
 
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index e1ce9199164..7a630d970c6 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -35,7 +35,7 @@ test_description="remember regular & dir renames in sequence of merges"
 # preventing us from finding new renames.
 #
 test_expect_success 'caching renames does not preclude finding new ones' '
-	test_create_repo caching-renames-and-new-renames &&
+	git init caching-renames-and-new-renames &&
 	(
 		cd caching-renames-and-new-renames &&
 
@@ -106,7 +106,7 @@ test_expect_success 'caching renames does not preclude finding new ones' '
 # should be able to only run rename detection on the upstream side one
 # time.)
 test_expect_success 'cherry-pick both a commit and its immediate revert' '
-	test_create_repo pick-commit-and-its-immediate-revert &&
+	git init pick-commit-and-its-immediate-revert &&
 	(
 		cd pick-commit-and-its-immediate-revert &&
 
@@ -162,7 +162,7 @@ test_expect_success 'cherry-pick both a commit and its immediate revert' '
 # could cause a spurious rename/add conflict.
 #
 test_expect_success 'rename same file identically, then reintroduce it' '
-	test_create_repo rename-rename-1to1-then-add-old-filename &&
+	git init rename-rename-1to1-then-add-old-filename &&
 	(
 		cd rename-rename-1to1-then-add-old-filename &&
 
@@ -229,7 +229,7 @@ test_expect_success 'rename same file identically, then reintroduce it' '
 # cached, the directory rename could put newfile in the wrong directory.
 #
 test_expect_success 'rename same file identically, then add file to old dir' '
-	test_create_repo rename-rename-1to1-then-add-file-to-old-dir &&
+	git init rename-rename-1to1-then-add-file-to-old-dir &&
 	(
 		cd rename-rename-1to1-then-add-file-to-old-dir &&
 
@@ -311,7 +311,7 @@ test_expect_success 'rename same file identically, then add file to old dir' '
 # should avoid the need to re-detect upstream renames.)
 #
 test_expect_success 'cached dir rename does not prevent noticing later conflict' '
-	test_create_repo dir-rename-cache-not-occluding-later-conflict &&
+	git init dir-rename-cache-not-occluding-later-conflict &&
 	(
 		cd dir-rename-cache-not-occluding-later-conflict &&
 
@@ -365,7 +365,7 @@ test_expect_success 'cached dir rename does not prevent noticing later conflict'
 
 # Helper for the next two tests
 test_setup_upstream_rename () {
-	test_create_repo $1 &&
+	git init $1 &&
 	(
 		cd $1 &&
 
@@ -537,7 +537,7 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
 
 # Helper for the next two tests
 test_setup_topic_rename () {
-	test_create_repo $1 &&
+	git init $1 &&
 	(
 		cd $1 &&
 
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index c253bf759ab..744c7b8bf87 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -310,7 +310,7 @@ test_expect_success 'recursive merge with submodule' '
 #   Expected: path/ is submodule and file contents for B's path are somewhere
 
 test_expect_success 'setup file/submodule conflict' '
-	test_create_repo file-submodule &&
+	git init file-submodule &&
 	(
 		cd file-submodule &&
 
@@ -325,7 +325,7 @@ test_expect_success 'setup file/submodule conflict' '
 		git commit -m B &&
 
 		git checkout A &&
-		test_create_repo path &&
+		git init path &&
 		test_commit -C path world &&
 		git submodule add ./path &&
 		git commit -m A
@@ -385,7 +385,7 @@ test_expect_success 'file/submodule conflict; merge --abort works afterward' '
 #     under the submodule to be treated as untracked or in the way.
 
 test_expect_success 'setup directory/submodule conflict' '
-	test_create_repo directory-submodule &&
+	git init directory-submodule &&
 	(
 		cd directory-submodule &&
 
@@ -408,7 +408,7 @@ test_expect_success 'setup directory/submodule conflict' '
 		git commit -m B2 &&
 
 		git checkout A &&
-		test_create_repo path &&
+		git init path &&
 		test_commit -C path hello world &&
 		git submodule add ./path &&
 		git commit -m A

base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
-- 
gitgitgadget
