Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD4BC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73FD60E75
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344648AbhIXXzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 19:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbhIXXzL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 19:55:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36493C061764
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 16:53:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i24so16135477wrc.9
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=THp3oyYMQZ0IyvYbWDVtqI55HStotyepThNgwaAMuqY=;
        b=WH3Jq0aHPVT5sydxfUXdrRXlgrlzAsk97K7vdGVsueO3h4OjrccC0MimkVaZoyDyrp
         pWOotxkntyQna8JmoUJ1hSo8tiGqpI4xHRAwiuEm9pVXEZJZ9EC8lMDRIORsRC63FBxy
         4mIv/VgmVUx+xGyAaO9syFZ5f4T5I/N2w8fV9IlclKFN0CfqitukzIjgc5TJg3guFBAt
         gh4OU7IC9iRbCbwmQR6vC8QIsOqLLLiKwhsJVjgod6gf6hAOU1Ry4Nwkz0SRHuVIQQUk
         N1kUi3OCz6hBh5P03I7yoQjll83EAFOV22S0CFejtmBWeOBR9tN3zXB8HuPsAEPZ3N5z
         4rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=THp3oyYMQZ0IyvYbWDVtqI55HStotyepThNgwaAMuqY=;
        b=BSSdLQWa8s7leYcykOXICpHDtqkmgbF/O+gASs4UHv2vAHui6IHpe/CBd847ockgq3
         VRkgHtkXS+nPXcJ5ERqNSmZCThr+4bKLfKRe840V2l6iYEVAc1tQSMm0Nlipq55Sfd3H
         yS4t4WgcVsD0pmATEGMPeRGf56pD90kLBdNDu+DI/pGCve8S13aYJQC/S4IspQzSLUX+
         p08WyjFL3tXJnivSI0QvIvYDV32omUu+K8eRb3ai253Oe7Hia6O/iCuE5EYHM1KxDjFt
         QwjjOrTFKpyzGaLjnB9IuDUmxQrj6ZjJo8GuFCDtM63H72v+4PP76wjeVBpM0wCv2dBN
         zHAw==
X-Gm-Message-State: AOAM532lJsfcFORqvRlcMnznqh6ewz81S5LGIFYZkxmZoH/puqH2ixsD
        mScNfSpUxNBzDuHlHvwpbqCuf+Hu6LU=
X-Google-Smtp-Source: ABdhPJwJ8XXpD+jTrTxB/ogFTtmyZKC0RBwR0s0Qpn5Sn4PQcLmz/75lWj4ZArKo9iRc9EdamfxSmA==
X-Received: by 2002:adf:f844:: with SMTP id d4mr14387291wrq.370.1632527614819;
        Fri, 24 Sep 2021 16:53:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x5sm12103892wmk.32.2021.09.24.16.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 16:53:34 -0700 (PDT)
Message-Id: <504bcc95c562c43b149d3dccf95f6a04761a9321.1632527609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
References: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
        <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 23:53:29 +0000
Subject: [PATCH v6 8/8] core.fsyncobjectfiles: performance tests for add and
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
