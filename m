Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5868C433FE
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351977AbiCOVcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351954AbiCOVcV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:32:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F025BE4A
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso1843674wms.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hiQ5WX0jcODcj04j+PrFFWVvlhk66JiPT7wxH3YR6go=;
        b=HshSyYVg3CTO3VmZtMjK93mc9NWTRALN52LWSYB0q3yfUW/oqZvrwj1WTYT+AbU3dz
         fCBOX0CxKKsZL5XqE8rE2NLViXFQFGdlZDPNyMy2SKZRxu7yc2yLZg/7JnG8K73/z6A/
         4KZKNwTGMq/Xbdzpk08+Jrk5bh+bllV4lxb8VrQ7yisYUYEbj/2HV8fdveWAnvAu+3x9
         sfF/lRG0tyjcbC18wrS3QYarvnzDaShr8wHM44DKtquLkItQIpzNkQ7N0O88TKdVY3rs
         kjM5nzG4ER1x+L4+YkxQb3IY8yIc3eTfdao7LKAhLgfR4BF94h4MRUOHQL1qU8ylLKTP
         hhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hiQ5WX0jcODcj04j+PrFFWVvlhk66JiPT7wxH3YR6go=;
        b=nxdhpTiP9q21nH3ASUedaWfKZ6c9iKizP5LLM9DI3sz8wltsnIgz9zfOU6GRqPp8VK
         hKelb9XBm1cTQgPCrSlyr2xNtklCagbWKODfZVZuFbQUy3rrLFoV8Mjfi54gE5hPYDqm
         F2AmrxBlepdnUeKLo5iWnA2UHtCzO6RQs2EbEb2FvZHuqD801vpNX17HGVYydBOUeZ3m
         CrMRxVq9Qfs3AWzD3dQsEJtgnnPG8acN45omoSYDGqNtADH4d1/Stso/Zm90DXTy52+4
         iIeuH02cUr0CfZBid4kG+bc+WPAXq0tzveMrr5XcgG9Scu38NfNkou1C2FcCE4VC10pg
         TC6A==
X-Gm-Message-State: AOAM5303+RiOuPvyp8pQY1MEc+oh2k8Xos+0zj6CE/nOESDNpDWnHsmG
        PbawJhsWUax+qzxdM2cJs/DGIik8RBo=
X-Google-Smtp-Source: ABdhPJylvMugWe4Xc1W6wLSQoiLObYYz2J5WT1i6wbPBZBBDOv9kKPi+xvM90jBP8mytLUOzxbAlEQ==
X-Received: by 2002:a05:600c:4142:b0:389:a592:10ce with SMTP id h2-20020a05600c414200b00389a59210cemr4953489wmm.148.1647379866627;
        Tue, 15 Mar 2022 14:31:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b00389efe9c512sm3706686wmq.23.2022.03.15.14.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 14:31:06 -0700 (PDT)
Message-Id: <876741f1ef9a5b8af28f73948a3e9ddc16d88c6d.1647379859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Mar 2022 21:30:59 +0000
Subject: [PATCH 7/7] core.fsyncmethod: performance tests for add and stash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Add basic performance tests for "git add" and "git stash" of a lot of
new objects with various fsync settings. This shows the benefit of batch
mode relative to an ordinary stash command.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/perf/p3700-add.sh   | 59 ++++++++++++++++++++++++++++++++++++++++
 t/perf/p3900-stash.sh | 62 +++++++++++++++++++++++++++++++++++++++++++
 t/perf/perf-lib.sh    |  4 +--
 3 files changed, 123 insertions(+), 2 deletions(-)
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh

diff --git a/t/perf/p3700-add.sh b/t/perf/p3700-add.sh
new file mode 100755
index 00000000000..2ea78c9449d
--- /dev/null
+++ b/t/perf/p3700-add.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+#
+# This test measures the performance of adding new files to the object database
+# and index. The test was originally added to measure the effect of the
+# core.fsyncMethod=batch mode, which is why we are testing different values
+# of that setting explicitly and creating a lot of unique objects.
+
+test_description="Tests performance of add"
+
+# Fsync is normally turned off for the test suite.
+GIT_TEST_FSYNC=1
+export GIT_TEST_FSYNC
+
+. ./perf-lib.sh
+
+. $TEST_DIRECTORY/lib-unique-files.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+dir_count=10
+files_per_dir=50
+total_files=$((dir_count * files_per_dir))
+
+# We need to create the files each time we run the perf test, but
+# we do not want to measure the cost of creating the files, so run
+# the test once.
+if test "${GIT_PERF_REPEAT_COUNT-1}" -ne 1
+then
+	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
+	GIT_PERF_REPEAT_COUNT=1
+fi
+
+for m in false true batch
+do
+	test_expect_success "create the files for object_fsyncing=$m" '
+		git reset --hard &&
+		# create files across directories
+		test_create_unique_files $dir_count $files_per_dir files
+	'
+
+	case $m in
+	false)
+		FSYNC_CONFIG='-c core.fsync=-loose-object -c core.fsyncmethod=fsync'
+		;;
+	true)
+		FSYNC_CONFIG='-c core.fsync=loose-object -c core.fsyncmethod=fsync'
+		;;
+	batch)
+		FSYNC_CONFIG='-c core.fsync=loose-object -c core.fsyncmethod=batch'
+		;;
+	esac
+
+	test_perf "add $total_files files (object_fsyncing=$m)" "
+		git $FSYNC_CONFIG add files
+	"
+done
+
+test_done
diff --git a/t/perf/p3900-stash.sh b/t/perf/p3900-stash.sh
new file mode 100755
index 00000000000..3526f06cef4
--- /dev/null
+++ b/t/perf/p3900-stash.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+#
+# This test measures the performance of adding new files to the object database
+# and index. The test was originally added to measure the effect of the
+# core.fsyncMethod=batch mode, which is why we are testing different values
+# of that setting explicitly and creating a lot of unique objects.
+
+test_description="Tests performance of stash"
+
+# Fsync is normally turned off for the test suite.
+GIT_TEST_FSYNC=1
+export GIT_TEST_FSYNC
+
+. ./perf-lib.sh
+
+. $TEST_DIRECTORY/lib-unique-files.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+dir_count=10
+files_per_dir=50
+total_files=$((dir_count * files_per_dir))
+
+# We need to create the files each time we run the perf test, but
+# we do not want to measure the cost of creating the files, so run
+# the test once.
+if test "${GIT_PERF_REPEAT_COUNT-1}" -ne 1
+then
+	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
+	GIT_PERF_REPEAT_COUNT=1
+fi
+
+for m in false true batch
+do
+	test_expect_success "create the files for object_fsyncing=$m" '
+		git reset --hard &&
+		# create files across directories
+		test_create_unique_files $dir_count $files_per_dir files
+	'
+
+	case $m in
+	false)
+		FSYNC_CONFIG='-c core.fsync=-loose-object -c core.fsyncmethod=fsync'
+		;;
+	true)
+		FSYNC_CONFIG='-c core.fsync=loose-object -c core.fsyncmethod=fsync'
+		;;
+	batch)
+		FSYNC_CONFIG='-c core.fsync=loose-object -c core.fsyncmethod=batch'
+		;;
+	esac
+
+	# We only stash files in the 'files' subdirectory since
+	# the perf test infrastructure creates files in the
+	# current working directory that need to be preserved
+	test_perf "stash $total_files files (object_fsyncing=$m)" "
+		git $FSYNC_CONFIG stash push -u -- files
+	"
+done
+
+test_done
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 932105cd12c..d270d1d962a 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -98,8 +98,8 @@ test_perf_create_repo_from () {
 	mkdir -p "$repo/.git"
 	(
 		cd "$source" &&
-		{ cp -Rl "$objects_dir" "$repo/.git/" 2>/dev/null ||
-			cp -R "$objects_dir" "$repo/.git/"; } &&
+		{ cp -Rl "$objects_dir" "$repo/.git/" ||
+			cp -R "$objects_dir" "$repo/.git/" 2>/dev/null;} &&
 
 		# common_dir must come first here, since we want source_git to
 		# take precedence and overwrite any overlapping files
-- 
gitgitgadget
