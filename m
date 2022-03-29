Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A281C433FE
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 00:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiC2Aoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiC2Ao1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 20:44:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1683823D444
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:45 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l9-20020a05600c4f0900b0038ccd1b8642so519547wmq.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9wQouNJeYrigvBznmm6/Kim7Siohd+Q9tteLLEpJ8lg=;
        b=FDPT0PT9aqpF8y5PV8miO9DUzIU+jzjGS5dkcd4uYw6Cr9LlXOSkjzzLnqEZRncVLf
         Psf4TxwARytULDLgJKQU7KeySfneZGfR59Zgyu9u7yobaHkkgYH9wtt4MHZ8C1/CEue3
         r69Q4pAtWFDszJ0DsnH5Bwig/iHKxd8LAyzkjbp+0AaMNAYtg+laEuT6q91BZfwSNAt3
         WLJNRe5sK2YJQgppxTygdQI2EioeNsV7b3Ettn6IGOMc18Q3fV6D+yETqAnWViMBzogC
         EU+uhb/NEyrhgxKurjatiG8QHTdkMdVLPttjJiJ1a0qoJa+xCJLgmeUbr/ZLEkqrXS++
         h0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9wQouNJeYrigvBznmm6/Kim7Siohd+Q9tteLLEpJ8lg=;
        b=pO3JHiYhQhQLw25NZY81SLl5UAzuWHbtFnMVoX/cevGWcam8g/GX4HQNlYwmXQlbqc
         mjKMBjRjR0LqzYkAM3MSrpePgmzx5R8aJkA3PEz5+NqHMI3+4Ok6dTIVQ0jFLq6rvdE2
         rzj0jmdyYAjM+WuPRsHQTR5O4BdKViGnfFFmDy53L1J+A3qVcKLgOJ3yTbrFZRCBAoOj
         FwAbXnO8EeVPsaLBWA27flRVrOi0lZyTJqVoYi/xpsdPSFt7Uo4lSA6Q2wKYf+SoJKT2
         N3w67NpDvPJg97lEnoEsfIwoDlUT6cJ/nkkz2KnJ5RO1FaKw69ZXFEN1oEDjr/4cdKji
         pdbA==
X-Gm-Message-State: AOAM533Lb/1MbRrpCtZXY8gqitP0dANXi0hS6wACB2m5yFZD88mE2Dpf
        E1JxxH5uQUGYfbJihzEXBUmOGASXMXU=
X-Google-Smtp-Source: ABdhPJx+l6CDKZkGec9RHf7DEtBNiKPjguXIlx/WBS1TnAjNXeDTj+axAS3a9zdPQdbskc1unbSgFQ==
X-Received: by 2002:a05:600c:2e45:b0:38c:8854:252f with SMTP id q5-20020a05600c2e4500b0038c8854252fmr2838742wmf.78.1648514563426;
        Mon, 28 Mar 2022 17:42:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000188100b002041a652dfdsm14523546wri.25.2022.03.28.17.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:42:43 -0700 (PDT)
Message-Id: <282fbdef792b7157804a4139dbc61106f31bbaef.1648514553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 00:42:27 +0000
Subject: [PATCH v4 10/13] core.fsyncmethod: tests for batch mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
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
 t/lib-unique-files.sh  | 34 ++++++++++++++++++++++++++++++++++
 t/t3700-add.sh         | 28 ++++++++++++++++++++++++++++
 t/t3903-stash.sh       | 20 ++++++++++++++++++++
 t/t5300-pack-object.sh | 41 +++++++++++++++++++++++++++--------------
 4 files changed, 109 insertions(+), 14 deletions(-)
 create mode 100644 t/lib-unique-files.sh

diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
new file mode 100644
index 00000000000..34c01a65256
--- /dev/null
+++ b/t/lib-unique-files.sh
@@ -0,0 +1,34 @@
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
+	local i &&
+	local j &&
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

