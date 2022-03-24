Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2BEC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346232AbiCXFAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 01:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346052AbiCXFAa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 01:00:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B542DD4C
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j18so4936805wrd.6
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NZ9DwWe8RMi6qei+a97iaf/fWz4PMyQi0ZAFeh+epW8=;
        b=W8xn27m74ZgiygeP4RLKH1B5NnOrlDq0KEDLj9vZlGLH9FD12QAd7y9IkbRehDRHI4
         VLg0gFnogo5uSvW7l2qqcKJ1ihQJGPdLI11CUZYVrkFI8QskDR+gAF5GO7BX+k1+wQcY
         s7pD7JfyTpNjNrFVUtN6jTTw7zVoTzfYPmaHYqhUDMAO6QowgqZtSVheBhTUywDeRPqT
         504R5NyUqDjG+ZiWIbfgI1QpxJ1zELoZYosXpW31Jjk95nqEXStiJv6uaRkVdK3MfXlq
         QdRldRLD7kod5AdXBA13jok4Nh8xBYrryN1AR+1YefwxdJ5Ud/Ie+8sVedRMFViF/PiA
         /17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NZ9DwWe8RMi6qei+a97iaf/fWz4PMyQi0ZAFeh+epW8=;
        b=x3VRgb/Cwpej+0Kl+0Bw5PEY07G3JEf/DJRwqEjEKa/nvLCWIhj8qk8ADKhaS8hHPX
         kGicvW2shUVZaXFS7ERuYgMP/oUpwLZfxZlSmdTi89mRSetdL2JEyB06zXHlO9/JDwzj
         ugsvwWxG86GDCnJRtolyEFicoU1HYoStRA3eGMzYQqHlycuzBYnvwu7qJDX2qFwcFJL4
         DDJeCHThdjSEFm+fX8Ed3jDQt8ig0lPMElYniXWL52RhaAQJHQNXZpR/APPBOFiA/AQQ
         jNppXrTkMJiiWenuyjBtGjQoIpACl7aKI3bczPdB78rVvmBKhnwzoedd4zxUZf5VxX1F
         yk3g==
X-Gm-Message-State: AOAM532vCVuZbq2hTfAgGlXyU5LTjWYDt9Dri99p4/TgYQRswkzOhXuC
        tvb3UTojKSCuepwD7FQrq9Ub4izrwCM=
X-Google-Smtp-Source: ABdhPJx25c/mX4sw29e+3Vac9qU5ofV70qS+/OvAWDN5/NphhdGi/mHcFwdwObIIuk+KCRxhnSN0Gg==
X-Received: by 2002:a05:6000:3cb:b0:205:7b9d:cade with SMTP id b11-20020a05600003cb00b002057b9dcademr2905925wrg.239.1648097923190;
        Wed, 23 Mar 2022 21:58:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0038c6ec42c38sm1137854wmq.6.2022.03.23.21.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 21:58:42 -0700 (PDT)
Message-Id: <b99b32a469c5bee6e1a4d4e2f374d69aff8db63e.1648097906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
References: <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
        <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 04:58:25 +0000
Subject: [PATCH v3 10/11] core.fsyncmethod: performance tests for add and
 stash
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
mode relative to full fsync.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/perf/p3700-add.sh   | 59 ++++++++++++++++++++++++++++++++++++++++
 t/perf/p3900-stash.sh | 62 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)
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
-- 
gitgitgadget

