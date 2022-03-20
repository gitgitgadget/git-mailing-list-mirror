Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43314C433EF
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 07:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244975AbiCTHRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 03:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244963AbiCTHRd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 03:17:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DAEC6257
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b19so16865366wrh.11
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 00:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hiQ5WX0jcODcj04j+PrFFWVvlhk66JiPT7wxH3YR6go=;
        b=SbiK8Pe7ygkcup830ImSor3woAFE1A34FiOXxVN224mvNb3PRD0SpL0UTK+XtA5S2J
         xNPo2TwSwY9c8vzYHj6Xh4/hnoTL/Hbus7Cnb8XtqNWgIKIyBgQanfjEPFETCtLydnCm
         wTu97sXur22xRECdYfjoA9onUx2+iIr30G6iXsb+i/Vnxc6Kp97O/01RH0l1AQkR2wui
         s2U5xsX0Ubal3eCxp+Ua62GR8C6u6y9C8sVy2iVOG1TrZ3u3JpuqfHY7qCu6PFjJbSWq
         Lah8WgY75MuvQTdAyCYXyNplQN4VBqXi2MAAwDEpwV9FPNH9Iooo7AOBphrF7H37z6ey
         08Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hiQ5WX0jcODcj04j+PrFFWVvlhk66JiPT7wxH3YR6go=;
        b=0FTQlTPP4iMfbxgBQ0VJ+Vf/HQOVz6sTX722E1RxZKbLTPmpjAah0xN0kaH1DLEb6K
         3c8/4BepId855+O/zns5mzkIJjSkbU34YNJzT7pfe8XdX80V4PLgFtupY+I9M1XbI6pd
         uEzIoEC167l0cg2ESpthf4jtIJaLMEItMzZ7cGdAXRs3/Mf3Be6/q/uYcixHdysjsAzn
         aZUnFfddH2ste8HgPD8mY0E2g0eRZqnHkSoivtULyOQa88htpvYleLii8Ik8xUiRbqpn
         hpaVN3lOM6D7WEXAKsOmWtHTtfntnoD2VD8J4Cr7ZSdCA7qjtQO+5tcwcT7lZizPWqOB
         hgPw==
X-Gm-Message-State: AOAM531XoDvOznPThnr+G+RWzQUuR8iFjhGus+zWDbkjPIJp2OWEkSXf
        +1hM+YgI+wdk0Rj5QI4xKxsijKKBS00=
X-Google-Smtp-Source: ABdhPJwg9GeoEmtCy/H7R+/ZrFl+pSaAxv9yfFUuJA225i4u5iMZCA0mj8UlxcRNUdZ9SK3YHrNnyQ==
X-Received: by 2002:a05:6000:1d8b:b0:203:df82:ff8d with SMTP id bk11-20020a0560001d8b00b00203df82ff8dmr13864053wrb.623.1647760569098;
        Sun, 20 Mar 2022 00:16:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm14356537wmj.5.2022.03.20.00.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 00:16:08 -0700 (PDT)
Message-Id: <624244078c7adc2186941fbfa08cb3afecdece4c.1647760561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 07:16:00 +0000
Subject: [PATCH v2 7/7] core.fsyncmethod: performance tests for add and stash
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
