Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3069EC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA7A6138B
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbhJDRAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbhJDQ7v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:59:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBC7C061787
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 09:57:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r18so4648292wrg.6
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=THp3oyYMQZ0IyvYbWDVtqI55HStotyepThNgwaAMuqY=;
        b=DlsRgTF0HIe9FWtKkEJmZde0Maiso7nen6Wx76tg9HsV577g4tqa2qmlQfeD4hPneD
         P8BS8JXfQOa5FsKBhZY8/Nq/cga05AUJ2jPUEoMm2vgc+8nfaMcGDJHezv35CzNVBS9w
         P8gnyj3vWtmNT8YcMwJXidt8PIZjisIg/HzqyG6n239syX8i5OSaOcnVQJ8ntpLYUdvr
         jT+/AdKaJ+HDmJJ/JD7HDWZtHNygRmiiO2KfV5AswflJEv6gMKckO7VO+5zFv/OH6kvI
         BYootW4rdu5uk+oLDOq++LNeOqi00R98Ico5DPuDt8uHYphw9iQ/vNrEJHtKPjVyYahD
         M5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=THp3oyYMQZ0IyvYbWDVtqI55HStotyepThNgwaAMuqY=;
        b=yPtaJd3kX2Mz0Lv20eOyQaSUVuBrl46FaC8ubAFwn/Tq3MD806BfLeVK8YJ7X/1Nvl
         lsKMxjq0Xlp9vpm6+OkZa/qnQ6E5K59AeRdzE8wgJ7sJBhvkvq17YYWU+RKghsQVwfYD
         5o2G1El32eD8purnjsV3CRlyXxqCeW7JjpwSiMY7h7/nkqHYdb3As4OnrhwBsM/Uj5OO
         YUbjRbOKcZsSq/jFnI6bFlGuvO4M5Re+8q9/YrT6cUfqGmlbCaEnOdahBYb8vFfs7R4M
         xbNTIdQbNcIYBZSspz+/g+jlp9lJHyJOOcWtyKO9OgQ1VahYzzm0WnhA/rtTPmrXMsoe
         8uHw==
X-Gm-Message-State: AOAM531OwPXFvUNqH/QjrwYy/cuBxRV5GdcXcPKZtdsRfguxn3e06aoT
        ZcpYOMalHofCAv1vTAqqcc0LM5tanGg=
X-Google-Smtp-Source: ABdhPJyaRpALayhoqVpVkOpjB8XB8K3UWG/6T6l5fgopPikjAo+gbWT9IAfdkIfz6wiiDRya90jXAA==
X-Received: by 2002:adf:8b86:: with SMTP id o6mr4191965wra.193.1633366675353;
        Mon, 04 Oct 2021 09:57:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm1274715wrh.76.2021.10.04.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:57:54 -0700 (PDT)
Message-Id: <f4fa20f591e580107b961aa1ca46d844603559d6.1633366668.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
References: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
        <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Oct 2021 16:57:47 +0000
Subject: [PATCH v8 9/9] core.fsyncobjectfiles: performance tests for add and
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
        Elijah Newren <newren@gmail.com>,
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
