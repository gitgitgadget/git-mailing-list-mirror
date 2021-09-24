Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E769BC433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C6361050
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346191AbhIXUO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348389AbhIXUNw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 16:13:52 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1B5C06161E
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c21so1123960wrb.13
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=THp3oyYMQZ0IyvYbWDVtqI55HStotyepThNgwaAMuqY=;
        b=OIJ1R/Jm67Mlk9N3HCbJ/F/TnBOnwW4ZXqB2HLl2ns4kwGmdpQ7U8meAyd+u6wN4QI
         nN2xn1xBVPU2hpSMnkoqcva5MVComt2kIXymt7nYO7/UAyYAvjsYk6S/zqL02mScEtY1
         PAPLW5PK5bdOdEiBabKjgI2cqqe5N6QL5sqaYK9H7UyWr+UMGrwxzS89WBcI41dncTvh
         kDMpVt5rT5tlnjYnagRrzRpNRIRyA189Z5Hg7O9PCBFmN4o7/HSD3l/npSSc+KCMPVZE
         JjSjErINNozc6oTuXYmLrkKEGjENof7H9id117u0jZNHOJUxZZflZpUr6KEErrXzQKY/
         hoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=THp3oyYMQZ0IyvYbWDVtqI55HStotyepThNgwaAMuqY=;
        b=xzyttnUmQghiJMSTXX8KzganUYnBPw6/C10hRi7V4tFRP2jHBCPXrx6RY+G/hBk1rt
         Y4DjQW3DezKYO8NqnUT2Y5kIQAFnvE7PTg+hDT/dVxck56A08j14nLreLeQmObtO/db6
         8bVGlnBb22UYvVYzPPGPtYYy9iRK3jmPj2kj8IixZiAyRWM4h56ZBDcAAr4uGooWTCqO
         lTYqvAHdAgmMVh4kKMC8o4QQJTGIXCV4GHI+3GNQ1z1x8vuAUvx/I4W2a+ygW6lQ2L3B
         F+abE8Xl9XZloxf8+nvtNpxIi5XLGzaeJbLkGuJWysciDuHNoTP9UoFxw7qZoEK0N+8o
         bfEg==
X-Gm-Message-State: AOAM531Dj+gU94yrLWcTkgOJkuJSpZYrIS8A+bASheXbKvjyhDZ/y3MC
        hrZN3EwJLgyiRpE37rp0Dn6+8yIGia0=
X-Google-Smtp-Source: ABdhPJxC/6A85AXjIikb9dP80qTM9F0cHmrRxExUhHO8RucYLJHvZV4p9e4nsYEzlGP5z0yuwn7fBA==
X-Received: by 2002:a05:6000:186d:: with SMTP id d13mr13767455wri.169.1632514337267;
        Fri, 24 Sep 2021 13:12:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5sm9000152wra.87.2021.09.24.13.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:12:17 -0700 (PDT)
Message-Id: <6543564376a7b06809d51dedbbf4571c359ace3b.1632514331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
References: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
        <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 20:12:11 +0000
Subject: [PATCH v5 7/7] core.fsyncobjectfiles: performance tests for add and
 stash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Add a basic performance test for "git add" and "git stash" of a lot of
new objects with various fsync settings.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/perf/p3700-add.sh   | 43 ++++++++++++++++++++++++++++++++++++++++
 t/perf/p3900-stash.sh | 46 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100755 t/perf/p3700-add.sh
 create mode 100755 t/perf/p3900-stash.sh

diff --git a/t/perf/p3700-add.sh b/t/perf/p3700-add.sh
new file mode 100755
index 00000000000..e93c08a2e70
--- /dev/null
+++ b/t/perf/p3700-add.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+#
+# This test measures the performance of adding new files to the object database
+# and index. The test was originally added to measure the effect of the
+# core.fsyncObjectFiles=batch mode, which is why we are testing different values
+# of that setting explicitly and creating a lot of unique objects.
+
+test_description="Tests performance of add"
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
+# the tet once.
+if test "${GIT_PERF_REPEAT_COUNT-1}" -ne 1
+then
+	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
+	GIT_PERF_REPEAT_COUNT=1
+fi
+
+for m in false true batch
+do
+	test_expect_success "create the files for core.fsyncObjectFiles=$m" '
+		git reset --hard &&
+		# create files across directories
+		test_create_unique_files $dir_count $files_per_dir files
+	'
+
+	test_perf "add $total_files files (core.fsyncObjectFiles=$m)" "
+		git -c core.fsyncobjectfiles=$m add files
+	"
+done
+
+test_done
diff --git a/t/perf/p3900-stash.sh b/t/perf/p3900-stash.sh
new file mode 100755
index 00000000000..c9fcd0c03eb
--- /dev/null
+++ b/t/perf/p3900-stash.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# This test measures the performance of adding new files to the object database
+# and index. The test was originally added to measure the effect of the
+# core.fsyncObjectFiles=batch mode, which is why we are testing different values
+# of that setting explicitly and creating a lot of unique objects.
+
+test_description="Tests performance of stash"
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
+# the tet once.
+if test "${GIT_PERF_REPEAT_COUNT-1}" -ne 1
+then
+	echo "warning: Setting GIT_PERF_REPEAT_COUNT=1" >&2
+	GIT_PERF_REPEAT_COUNT=1
+fi
+
+for m in false true batch
+do
+	test_expect_success "create the files for core.fsyncObjectFiles=$m" '
+		git reset --hard &&
+		# create files across directories
+		test_create_unique_files $dir_count $files_per_dir files
+	'
+
+	# We only stash files in the 'files' subdirectory since
+	# the perf test infrastructure creates files in the
+	# current working directory that need to be preserved
+	test_perf "stash 500 files (core.fsyncObjectFiles=$m)" "
+		git -c core.fsyncobjectfiles=$m stash push -u -- files
+	"
+done
+
+test_done
-- 
gitgitgadget
