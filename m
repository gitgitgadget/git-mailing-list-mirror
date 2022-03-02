Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3C1C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 06:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbiCBGGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 01:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239640AbiCBGGL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 01:06:11 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682D9B12DB
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 22:05:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ay10so1000668wrb.6
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 22:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T/T4aWmJixlES1DO3pnbI01kRsytk4GnW0hV4zHqsgE=;
        b=WKW7cfQQ5RpnsPllCNijZ4FGNAOM0cOKQKb7uw2cOYn81zkLx4rpmA8NXViEA0VF7Z
         vf/0mkO12x+orf+YNvNqgmqWgFvAw4Zjv0qscDG8Q2VKEJSyaVOh+XjECDU/l15+JM/N
         h/kdD/X73GVkzCp76T/nKAr4i42CzQvliBYNAomVMBgBGJQDvUfodQ/7xENPRjiQqxOZ
         fD+/XPoFiQrlE3DJcmq1j7GZmHrcFJalf3H5YNlVTCRlzUNnLc0WVltuKxF9qEF1ekgz
         C8UiCyw0Azqm/+2aoMe14AzbL+RWK+gZ2rpt8JRILCtfbeXP16UNljiBQfXTAw7qSAGZ
         1a3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T/T4aWmJixlES1DO3pnbI01kRsytk4GnW0hV4zHqsgE=;
        b=L1eO6+CZv65hwx3aYsI2I6pN5moHjWatEBYloo7BwWSJ0IV2cvrh4vEbIP/nnniaeO
         RA0Zh8B4zZ9wexTNRZLzHT+h9MKZzLLRlRtugIb6lWJJhAluyjQHhuMM6RIayqiL7L5v
         z5uHpb8dYQ4HB+s3ogpNFSDdLl9apvp4eLekPsgGtfaa93+AND/yG4C3a6ZnqVaNw4dc
         2XD/sMtbXsIkK4k+xIS8Vbce1YusnoUtCRZzCzGDT1uepAUN3/klrWHgLkDyqD2Z989n
         LoL1YouBfrh4e7t8xcmnwh8gUhomH8i5qLmMORcvURJvi9GXjesAGfiFtC4j72euqGYt
         43Pw==
X-Gm-Message-State: AOAM530Yvfev1qLVJacnoB0FvuB96i03n+m9P5oiKnqovLqhLlurfAB3
        GfYMGoGp76ix4MnGfwY0jBriX0bjjoE=
X-Google-Smtp-Source: ABdhPJzo7ppixSgusGrf/1c60wOXasxwKSBzftmxspP8GGF7v3Xm1G720/KhXUp3fdiOCkJ2U+EwuQ==
X-Received: by 2002:a5d:5255:0:b0:1ed:f971:5497 with SMTP id k21-20020a5d5255000000b001edf9715497mr20740134wrc.528.1646201127822;
        Tue, 01 Mar 2022 22:05:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b001efd62a840dsm9471449wri.111.2022.03.01.22.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 22:05:27 -0800 (PST)
Message-Id: <dceb2857609fad8a8f93e489adc478ab0eb71c51.1646201124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.v3.git.1646201124.gitgitgadget@gmail.com>
References: <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
        <pull.1166.v3.git.1646201124.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Mar 2022 06:05:24 +0000
Subject: [PATCH v3 2/2] t7063: mtime-mangling instead of delays in untracked
 cache testing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>,
        Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

The untracked cache test uses an avoid_racy function to deal with
an mtime-resolution challenge in testing: If an untracked cache
entry's mtime falls in the same second as the mtime of the index
the untracked cache was stored in, then it cannot be trusted.

Explicitly delaying tests is a simple effective strategy to
avoid these issues, but should be avoided where possible.

Switch from a delay-based strategy to instead backdating
all file changes using test-tool chmtime, where that is an
option, to shave 9 seconds off the test run time.

Don't update test cases that delay for other reasons, for now at
least (4 seconds).

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t7063-status-untracked-cache.sh | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index a0c123b0a77..ca90ee805e7 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -90,6 +90,9 @@ test_expect_success 'setup' '
 	cd worktree &&
 	mkdir done dtwo dthree &&
 	touch one two three done/one dtwo/two dthree/three &&
+	test-tool chmtime =-300 one two three done/one dtwo/two dthree/three &&
+	test-tool chmtime =-300 done dtwo dthree &&
+	test-tool chmtime =-300 . &&
 	git add one two done/one &&
 	: >.git/info/exclude &&
 	git update-index --untracked-cache &&
@@ -142,7 +145,6 @@ two
 EOF
 
 test_expect_success 'status first time (empty cache)' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
@@ -166,7 +168,6 @@ test_expect_success 'untracked cache after first status' '
 '
 
 test_expect_success 'status second time (fully populated cache)' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
@@ -190,8 +191,8 @@ test_expect_success 'untracked cache after second status' '
 '
 
 test_expect_success 'modify in root directory, one dir invalidation' '
-	avoid_racy &&
 	: >four &&
+	test-tool chmtime =-240 four &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
@@ -241,7 +242,6 @@ EOF
 '
 
 test_expect_success 'new .gitignore invalidates recursively' '
-	avoid_racy &&
 	echo four >.gitignore &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
@@ -292,7 +292,6 @@ EOF
 '
 
 test_expect_success 'new info/exclude invalidates everything' '
-	avoid_racy &&
 	echo three >>.git/info/exclude &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
@@ -520,14 +519,14 @@ test_expect_success 'create/modify files, some of which are gitignored' '
 	echo three >done/three && # three is gitignored
 	echo four >done/four && # four is gitignored at a higher level
 	echo five >done/five && # five is not gitignored
-	echo test >base && #we need to ensure that the root dir is touched
-	rm base &&
+	test-tool chmtime =-180 done/two done/three done/four done/five done &&
+	# we need to ensure that the root dir is touched (in the past);
+	test-tool chmtime =-180 . &&
 	sync_mtime
 '
 
 test_expect_success 'test sparse status with untracked cache' '
 	: >../trace.output &&
-	avoid_racy &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
 	iuc status --porcelain >../status.iuc &&
@@ -570,7 +569,6 @@ EOF
 '
 
 test_expect_success 'test sparse status again with untracked cache' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
@@ -597,11 +595,11 @@ EOF
 test_expect_success 'set up for test of subdir and sparse checkouts' '
 	mkdir done/sub &&
 	mkdir done/sub/sub &&
-	echo "sub" > done/sub/sub/file
+	echo "sub" > done/sub/sub/file &&
+	test-tool chmtime =-120 done/sub/sub/file done/sub/sub done/sub done
 '
 
 test_expect_success 'test sparse status with untracked cache and subdir' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
@@ -651,7 +649,6 @@ EOF
 '
 
 test_expect_success 'test sparse status again with untracked cache and subdir' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
-- 
gitgitgadget
