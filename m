Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EAEC433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 05:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbiC3FIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242767AbiC3FHr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 01:07:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C08866CA9
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so2704275wmb.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 22:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ws+waIF2WcOuQF4QexmvEEe26McYMmSbQKCcdTaB9zw=;
        b=pig1jJoN3XpM+REuvdNkUz0gWfRMV+hbtilTeKsN7uMFLj2s6UdTM111iT+EcAqXoz
         VnbznXxkjR0xRXt/P9kNcWO3j03Ex09kx4Jvxfz7tMRGa/UinxZYnSYlIZvMz7CqEdHq
         aEeVYUhXXtS1ELBaxD0oVvtQw4JJsNAMVFTO4o7yzzUWMs98j8X+jGLhXKAx7JTqT8RD
         9158Rit1oxufxHZtC40x4Bzlpbr7sZPXqTKYVLWRdQAbOXJ+HIrwIBCLi8QsIwIW3lfY
         atvmMqQa/hBg9jJNPlVzxEXveVd+MaZCRvFt3Df/YweMw1dADLyPK/xRbiwx4PmfCQME
         ee1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ws+waIF2WcOuQF4QexmvEEe26McYMmSbQKCcdTaB9zw=;
        b=htG+1q8OMzAYgPHVmhPydKFbgz3hgYq6EQK1xCy8tQbghTAWHk1t2vzJsE8VIuyZ5N
         aF+SWVlSpSVnJJoZQbsruSBgUNfeHq5cV2TIup+2Y32F+hrPcx7zrJPvy5siJY0q/+oG
         cEb3d6Dr2yOhAQ9mmCZjHJEtmbzFEnloEsvlrQ0BDrQQMYRWt72CsG9NXxuMjFnl7VL/
         WybbbE5G/YulAK9iLDcjHwgmBNPEk7acrPcVObiXIuXBNGtQqnuLSd326VWRBWhv5TwE
         61bqf9ejjqCJXFQz389u1Z8nRvPtCiNJqM+d8SLqGkNa54/9Qgmdun0E4J/1DfXlsWqn
         WDDw==
X-Gm-Message-State: AOAM533NmluY8UTEvAsHgT5/gXcfMurDkCAOBTyIHGM/H5dXXGunbVEb
        NyOGWdyzmGPpV/m/S++CJQw5CWcVxYQ=
X-Google-Smtp-Source: ABdhPJxdLjVWDpzowHsSd0DL2OM4+Jzo7MFUFIpmCjjXoWNuQVnmpwK3R0HUAQ8n9LAeXsN/x41sEw==
X-Received: by 2002:a05:600c:207:b0:38c:c815:8043 with SMTP id 7-20020a05600c020700b0038cc8158043mr2674655wmi.35.1648616748648;
        Tue, 29 Mar 2022 22:05:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c404800b0038cc9c7670bsm3685715wmm.3.2022.03.29.22.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 22:05:48 -0700 (PDT)
Message-Id: <26be6ecb28bc1f76fba380fdd10acf59820df997.1648616734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Mar 2022 05:05:31 +0000
Subject: [PATCH v5 13/14] core.fsyncmethod: performance tests for batch mode
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

Add basic performance tests for git commands that can add data to the
object database. We cover:
* git add
* git stash
* git update-index (via git stash)
* git unpack-objects
* git commit --all

We cover all currently available fsync methods as well.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/perf/p0008-odb-fsync.sh | 81 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100755 t/perf/p0008-odb-fsync.sh

diff --git a/t/perf/p0008-odb-fsync.sh b/t/perf/p0008-odb-fsync.sh
new file mode 100755
index 00000000000..87092c2627e
--- /dev/null
+++ b/t/perf/p0008-odb-fsync.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+#
+# This test measures the performance of adding new files to the object
+# database. The test was originally added to measure the effect of the
+# core.fsyncMethod=batch mode, which is why we are testing different values of
+# that setting explicitly and creating a lot of unique objects.
+
+test_description="Tests performance of adding things to the object database"
+
+. ./perf-lib.sh
+
+. $TEST_DIRECTORY/lib-unique-files.sh
+
+test_perf_fresh_repo
+test_checkout_worktree
+
+dir_count=10
+files_per_dir=50
+total_files=$((dir_count * files_per_dir))
+
+populate_files () {
+	test_create_unique_files $dir_count $files_per_dir files
+}
+
+setup_repo () {
+	(rm -rf .git || 1) &&
+	git init &&
+	test_commit first &&
+	populate_files
+}
+
+test_perf_fsync_cfgs () {
+	local method cfg &&
+	for method in none fsync batch writeout-only
+	do
+		case $method in
+		none)
+			cfg="-c core.fsync=none"
+			;;
+		*)
+			cfg="-c core.fsync=loose-object -c core.fsyncMethod=$method"
+		esac &&
+
+		# Set GIT_TEST_FSYNC=1 explicitly since fsync is normally
+		# disabled by t/test-lib.sh.
+		if ! test_perf "$1 (fsyncMethod=$method)" \
+						--setup "$2" \
+						"GIT_TEST_FSYNC=1 git $cfg $3"
+		then
+			break
+		fi
+	done
+}
+
+test_perf_fsync_cfgs "add $total_files files" \
+	"setup_repo" \
+	"add -- files"
+
+test_perf_fsync_cfgs "stash $total_files files" \
+	"setup_repo" \
+	"stash push -u -- files"
+
+test_perf_fsync_cfgs "unpack $total_files files" \
+	"
+	setup_repo &&
+	git -c core.fsync=none add -- files &&
+	git -c core.fsync=none commit -q -m second &&
+	echo HEAD | git pack-objects -q --stdout --revs >test_pack.pack &&
+	setup_repo
+	" \
+	"unpack-objects -q <test_pack.pack"
+
+test_perf_fsync_cfgs "commit $total_files files" \
+	"
+	setup_repo &&
+	git -c core.fsync=none add -- files &&
+	populate_files
+	" \
+	"commit -q -a -m test"
+
+test_done
-- 
gitgitgadget

