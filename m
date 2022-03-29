Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2793DC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 00:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiC2Aom (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiC2Ao3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 20:44:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B3523D595
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u16so22608474wru.4
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a7p2DJpF/8OqyPWu9AK9ER57ip84thiO0tcgOwjKq/8=;
        b=UaOvOGo+Outp+b0MLN3yWRh8OVkPD6Mg1Wf0++oKC8neSQi8SdNWRa+SjHT+v0Lbc/
         ttYIkHJn+zOp3V7T+hNNYc4Ou1G6qqpLXSfkVQQdSlURfbVKqUyweKUmvCKbnNuMlOQU
         2OXm2aJn/1ve4bS5cG9rgwd/fgExhugsdDbsKFOEJYEtSwaOrGz2YthZpIOKgBVwq2yz
         O4HMl3uaWLPLHzT8lhaWPwAMDZOA1CI/8S+Btm9B32CSlP1gS0ZeOkuj3MFcSf2IyjmJ
         B9Pu/y4MtnbOL1KveQPv2GgRkaq8rSAO1NY0T+LVf7PubI29h1hL5yK4+zNpQ++9JgTQ
         +lfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a7p2DJpF/8OqyPWu9AK9ER57ip84thiO0tcgOwjKq/8=;
        b=n80iQ66J++eh7zfozvqq2w0OX3qdrCeL+IVGFwd74HXwkPtC+346LRmJBmQmHMKWAY
         8I8JdDSOfUBQl+uT2Al/t/B+XiFqs2Y9tIHAt1syi4Jr4LBS53v1RKHvIaSjyrFpVwvo
         n4sUDVf7z0W5kJg0rnMnBNqEWBXOnHT6uydqXEnFaYOalhdQWVF5chPmmK1wOSxNfCTb
         iXZv0fqdVQ61mIpOQySzvvCQ4M2sJ/bRrhY2j2hKoyog6XJfU++AL9k8yc8JlSJw32Wt
         L3HlSP6Jc3N285+1FUy57Bzt8FNk6DGR4YYQNsKsTnm77A36pkDT6oA4RanCUwn4FR4d
         fQwQ==
X-Gm-Message-State: AOAM530Qlcz5NDXiWPl7Uuvyjv4EIlYHXNNI5mkebuwEWQM1cCXzstV7
        1Fd6qeVEHVuHbdJJlprREU3cZlfTPjc=
X-Google-Smtp-Source: ABdhPJznK39knALDQ1eOeJHEPiFKN47ytw17eqXtLPqi23FgV9sDsL5qYOeNQFTp3wGrjGtvOD2d/Q==
X-Received: by 2002:a05:6000:168e:b0:204:f90:de02 with SMTP id y14-20020a056000168e00b002040f90de02mr27629126wrd.108.1648514565094;
        Mon, 28 Mar 2022 17:42:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm1161723wmq.27.2022.03.28.17.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:42:44 -0700 (PDT)
Message-Id: <fdf90d45f52d72cf2ff7fe6b620853da9fafc1b3.1648514553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 00:42:29 +0000
Subject: [PATCH v4 12/13] core.fsyncmethod: performance tests for add and
 stash
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

Add basic performance tests for "git add" and "git stash" of a lot of
new objects with various fsync settings. This shows the benefit of batch
mode relative to full fsync.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/perf/p3700-add.sh | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100755 t/perf/p3700-add.sh

diff --git a/t/perf/p3700-add.sh b/t/perf/p3700-add.sh
new file mode 100755
index 00000000000..ef6024f9897
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
+test_description="Tests performance of adding things to the object database"
+
+# Fsync is normally turned off for the test suite.
+GIT_TEST_FSYNC=1
+export GIT_TEST_FSYNC
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
+for mode in false true batch
+do
+	case $mode in
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
+	test_perf "add $total_files files (object_fsyncing=$mode)" \
+		--setup "
+		(rm -rf .git || 1) &&
+		git init &&
+		test_create_unique_files $dir_count $files_per_dir files_$mode
+	" "
+		git $FSYNC_CONFIG add files_$mode
+	"
+
+	test_perf "stash $total_files files (object_fsyncing=$mode)" \
+		--setup "
+		(rm -rf .git || 1) &&
+		git init &&
+		test_commit first &&
+		test_create_unique_files $dir_count $files_per_dir stash_files_$mode
+	" "
+		git $FSYNC_CONFIG stash push -u -- stash_files_$mode
+	"
+done
+
+test_done
-- 
gitgitgadget

