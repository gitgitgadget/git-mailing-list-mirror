Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914F4C433FE
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 07:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbiCTHRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 03:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244959AbiCTHRc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 03:17:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43B7C4E29
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:09 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i64-20020a1c3b43000000b0038c99618859so91365wma.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NFCucs1SB7Xx0Io3Hv6AU/pBnfbh/c+oYzyKZHSX2VY=;
        b=jNByf8z6OAYKflCF/3HgYtNc7SoaTbfWUxXVUFs4xCd3u75bbIvys2/xeuI8tbWHxG
         q55NabsBNDgHvGtTt0RtH9tM9IqNwYpaN4SFR/Brj8RpOHt5ax3ljokBM7sKPjsyJK2O
         100eTZ+afTVdOYT4fRLvSglMSRANkOoCaQAZOnK1E1//y9i8qEbprB/BtmipcDDsRMSH
         P25m93OfOrjEo0Dy5slNDs8UjmzTfhkvLEHsZufuPZb3OqKH/rtwfxZ+aFmj5hx+JuWN
         VG3QFTKRzi5Ow4Cpj8sC1ycylQCVfWyzAnzCg1jp+Zo+e+T/qSMyBvoUC9ecS8HiUuLp
         qsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NFCucs1SB7Xx0Io3Hv6AU/pBnfbh/c+oYzyKZHSX2VY=;
        b=W0JUyZHCrKgE8ovEbjQ8JEfosNLUYrnImpt6kEOhhPugmvlXiSeUde1r5cs5sAz/+o
         lgUaPZ0Q2v1dNXtHhIRpA/6VES2S2Z7M412pg7USy6jpOKaj7QGT107CngHmqTxX06zZ
         xGz8hUGXQAFXNtNekJFyME2+gzzy8uibQnpQ5voTHTwEXHvDhlUOIGEHklhvZi/Hg6AY
         laVRWjh5IHNVRdrH6nQC558Om/2TbzrcuDGZQsMssG7XaYPjaycKG0GA3TJJaWGDmqV3
         R4mTRyCzsG9IuVLu6+DrdsArrMeXU4AMk3yRulORHZv6CKTzkZfj3IB398nZ1wFvp76H
         MQXQ==
X-Gm-Message-State: AOAM532D7Nd1MeUs5Eauq4zBpyV6SCQvOqcgvtEECNznxoqrbcoJeZYV
        77R8pgL3ds1LX+1XNIiiK3kqwlj4GZw=
X-Google-Smtp-Source: ABdhPJz+5LI8FP17glc08J9wKEJqeB5ApyBSNSaTM8Z5ujwXAsPQI0QAooXUzpOkOzjo/GTl2YLaHA==
X-Received: by 2002:a05:600c:4ed2:b0:38c:93ad:4825 with SMTP id g18-20020a05600c4ed200b0038c93ad4825mr5912579wmq.181.1647760568127;
        Sun, 20 Mar 2022 00:16:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d46ca000000b00203fd86e198sm3771455wrs.96.2022.03.20.00.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 00:16:07 -0700 (PDT)
Message-Id: <1937746df47eefecfc343e32eb9bf6c0949fb7b9.1647760561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 07:15:59 +0000
Subject: [PATCH v2 6/7] core.fsyncmethod: tests for batch mode
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
repo. This helps us avoid missing validation of an object being added due
to it already being in the repo.

We aren't actually issuing any fsyncs in these tests, since
GIT_TEST_FSYNC is 0, but we still exercise all of the tmp_objdir logic
in bulk-checkin.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/lib-unique-files.sh  | 36 ++++++++++++++++++++++++++++++++++++
 t/t3700-add.sh         | 22 ++++++++++++++++++++++
 t/t3903-stash.sh       | 17 +++++++++++++++++
 t/t5300-pack-object.sh | 32 +++++++++++++++++++++-----------
 4 files changed, 96 insertions(+), 11 deletions(-)
 create mode 100644 t/lib-unique-files.sh

diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
new file mode 100644
index 00000000000..a7de4ca8512
--- /dev/null
+++ b/t/lib-unique-files.sh
@@ -0,0 +1,36 @@
+# Helper to create files with unique contents
+
+
+# Create multiple files with unique contents. Takes the number of
+# directories, the number of files in each directory, and the base
+# directory.
+#
+# test_create_unique_files 2 3 my_dir -- Creates 2 directories with 3 files
+#					 each in my_dir, all with unique
+#					 contents.
+
+test_create_unique_files() {
+	test "$#" -ne 3 && BUG "3 param"
+
+	local dirs=$1
+	local files=$2
+	local basedir=$3
+	local counter=0
+	test_tick
+	local basedata=$test_tick
+
+
+	rm -rf $basedir
+
+	for i in $(test_seq $dirs)
+	do
+		local dir=$basedir/dir$i
+
+		mkdir -p "$dir"
+		for j in $(test_seq $files)
+		do
+			counter=$((counter + 1))
+			echo "$basedata.$counter"  >"$dir/file$j.txt"
+		done
+	done
+}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index b1f90ba3250..1f349f52ad3 100755
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
@@ -34,6 +36,26 @@ test_expect_success \
     'Test that "git add -- -q" works' \
     'touch -- -q && git add -- -q'
 
+BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
+
+test_expect_success 'git add: core.fsyncmethod=batch' "
+	test_create_unique_files 2 4 fsync-files &&
+	git $BATCH_CONFIGURATION add -- ./fsync-files/ &&
+	rm -f fsynced_files &&
+	git ls-files --stage fsync-files/ > fsynced_files &&
+	test_line_count = 8 fsynced_files &&
+	awk -- '{print \$2}' fsynced_files | xargs -n1 git cat-file -e
+"
+
+test_expect_success 'git update-index: core.fsyncmethod=batch' "
+	test_create_unique_files 2 4 fsync-files2 &&
+	find fsync-files2 ! -type d -print | xargs git $BATCH_CONFIGURATION update-index --add -- &&
+	rm -f fsynced_files2 &&
+	git ls-files --stage fsync-files2/ > fsynced_files2 &&
+	test_line_count = 8 fsynced_files2 &&
+	awk -- '{print \$2}' fsynced_files2 | xargs -n1 git cat-file -e
+"
+
 test_expect_success \
 	'git add: Test that executable bit is not used if core.filemode=0' \
 	'git config core.filemode 0 &&
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 55cd77901a8..5a3996b838f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -9,6 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. $TEST_DIRECTORY/lib-unique-files.sh
 
 test_expect_success 'usage on cmd and subcommand invalid option' '
 	test_expect_code 129 git stash --invalid-option 2>usage &&
@@ -1462,6 +1463,22 @@ test_expect_success 'stash handles skip-worktree entries nicely' '
 	git rev-parse --verify refs/stash:A.t
 '
 
+
+BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
+
+test_expect_success 'stash with core.fsyncmethod=batch' "
+	test_create_unique_files 2 4 fsync-files &&
+	git $BATCH_CONFIGURATION stash push -u -- ./fsync-files/ &&
+	rm -f fsynced_files &&
+
+	# The files were untracked, so use the third parent,
+	# which contains the untracked files
+	git ls-tree -r stash^3 -- ./fsync-files/ > fsynced_files &&
+	test_line_count = 8 fsynced_files &&
+	awk -- '{print \$3}' fsynced_files | xargs -n1 git cat-file -e
+"
+
+
 test_expect_success 'git stash succeeds despite directory/file change' '
 	test_create_repo directory_file_switch_v1 &&
 	(
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index a11d61206ad..8e2f73cc68f 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -162,23 +162,25 @@ test_expect_success 'pack-objects with bogus arguments' '
 
 check_unpack () {
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
+	git $2 init --bare git2 &&
+	(
+		git $2 -C git2 unpack-objects -n <"$1".pack &&
+		git $2 -C git2 unpack-objects <"$1".pack &&
+		git $2 -C git2 cat-file --batch-check="%(objectname)"
+	) <obj-list >current &&
+	cmp obj-list current
 }
 
 test_expect_success 'unpack without delta' '
 	check_unpack test-1-${packname_1}
 '
 
+BATCH_CONFIGURATION='-c core.fsync=loose-object -c core.fsyncmethod=batch'
+
+test_expect_success 'unpack without delta (core.fsyncmethod=batch)' '
+	check_unpack test-1-${packname_1} "$BATCH_CONFIGURATION"
+'
+
 test_expect_success 'pack with REF_DELTA' '
 	packname_2=$(git pack-objects --progress test-2 <obj-list 2>stderr) &&
 	check_deltas stderr -gt 0
@@ -188,6 +190,10 @@ test_expect_success 'unpack with REF_DELTA' '
 	check_unpack test-2-${packname_2}
 '
 
+test_expect_success 'unpack with REF_DELTA (core.fsyncmethod=batch)' '
+       check_unpack test-2-${packname_2} "$BATCH_CONFIGURATION"
+'
+
 test_expect_success 'pack with OFS_DELTA' '
 	packname_3=$(git pack-objects --progress --delta-base-offset test-3 \
 			<obj-list 2>stderr) &&
@@ -198,6 +204,10 @@ test_expect_success 'unpack with OFS_DELTA' '
 	check_unpack test-3-${packname_3}
 '
 
+test_expect_success 'unpack with OFS_DELTA (core.fsyncmethod=batch)' '
+       check_unpack test-3-${packname_3} "$BATCH_CONFIGURATION"
+'
+
 test_expect_success 'compare delta flavors' '
 	perl -e '\''
 		defined($_ = -s $_) or die for @ARGV;
-- 
gitgitgadget

