Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55A2C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiCAJqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiCAJp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:45:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3568BF27
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:45:14 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d3so19543822wrf.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 01:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5Rztmub3nTrhvZW929P/kcvbagUqoyoY6U6mpxfjlXU=;
        b=X8DseIgXWh7Ow6jthT30pGoTvzEDYegN8QLkH6tZj8zMy0HaMSHp2MaDoA3agb8C7P
         Girx5fX7LzlibSk2fPMKyKEDOaZZYgQai+vTDnsnmnxXKvgjlD6PV4laC95vjNZlOcxf
         1XUHcZFJ1OPd2KkdCI6/wAoJ2E+xFLUIFVJOH2TlQCCnJbqd4WWuIJarvKYz6OJSqwgu
         WGO1tofknGSnKxdJH0WYygMECIm1KuknM9M30W6chQpdpiLm2tn5PAuUVi+hn6Ax2pUJ
         rMkgHx9R9WMVyyCGrr5cbI2rKyiVqMIJw0MFT3z1f73Y76TKznJpBL75fmYWsSMQkETB
         viNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5Rztmub3nTrhvZW929P/kcvbagUqoyoY6U6mpxfjlXU=;
        b=jQbGmwHJFi382VVb4yF4xCnaOi+2fVjkK9aAA+nZ0fziiXRwaSovzeSWTAm5+EF7Db
         Dnor9wyu6bsdKgzQ9I4bD9HD0kt3PuE5dZJFNo6x47uhIelzm0kKzauKtt6i76Dq5Aat
         tpuwmn1JV31af5Lrj8HQDznweOIpc+T8GG8NkqFRIJEshw1OgojVWYbfFvlULDkUUDzW
         1Ag/H7ek5CI9FZmrwVpMRXhsZGTivHFTPQ6PEmT6HZz7IYHesTh+p9bvwWgNgIshL5Mz
         9cf5/KLJosHQ5tT6bsH77ttSvmE4SYE5gueGKKuB8zs/4oCRK1T9WCCBYhnAfrfXQJVa
         8Y2g==
X-Gm-Message-State: AOAM531v3cZXuVRPf3pg/pNdBthacIOePawn2ghQ3t2GleBFAXdNvIms
        v4ZxRiFzouOuYQo7dolJouLsKPPa568=
X-Google-Smtp-Source: ABdhPJymQ6YVdKlegBKw2WV0/kpNq+KLmv8yMShlqhg07bEMDqgU4c3GbyMfc2WnuyMldW7dce0Urw==
X-Received: by 2002:a5d:410c:0:b0:1ef:766b:ef5b with SMTP id l12-20020a5d410c000000b001ef766bef5bmr13760419wrp.183.1646127913103;
        Tue, 01 Mar 2022 01:45:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600011cf00b001edc2966dd4sm12862546wrx.47.2022.03.01.01.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 01:45:12 -0800 (PST)
Message-Id: <3e3c9c7faace505958aa01ff82bef5fad3204c67.1646127910.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
        <pull.1166.v2.git.1646127910.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 09:45:10 +0000
Subject: [PATCH v2 2/2] t7063: mtime-mangling instead of delays in untracked
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
 t/t7063-status-untracked-cache.sh | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index a0c123b0a77..eae57dc78a6 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -24,6 +24,12 @@ sync_mtime () {
 	find . -type d -exec ls -ld {} + >/dev/null
 }
 
+chmtime_worktree_root () {
+	# chmtime doesnt handle relative paths on windows, so need
+	# to "hardcode" a reference to the worktree folder name.
+	test-tool -C .. chmtime $1 worktree
+}
+
 avoid_racy() {
 	sleep 1
 }
@@ -90,6 +96,9 @@ test_expect_success 'setup' '
 	cd worktree &&
 	mkdir done dtwo dthree &&
 	touch one two three done/one dtwo/two dthree/three &&
+	test-tool chmtime =-300 one two three done/one dtwo/two dthree/three &&
+	test-tool chmtime =-300 done dtwo dthree &&
+	chmtime_worktree_root =-300 &&
 	git add one two done/one &&
 	: >.git/info/exclude &&
 	git update-index --untracked-cache &&
@@ -142,7 +151,6 @@ two
 EOF
 
 test_expect_success 'status first time (empty cache)' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
@@ -166,7 +174,6 @@ test_expect_success 'untracked cache after first status' '
 '
 
 test_expect_success 'status second time (fully populated cache)' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
@@ -190,8 +197,8 @@ test_expect_success 'untracked cache after second status' '
 '
 
 test_expect_success 'modify in root directory, one dir invalidation' '
-	avoid_racy &&
 	: >four &&
+	test-tool chmtime =-240 four &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../actual &&
@@ -241,7 +248,6 @@ EOF
 '
 
 test_expect_success 'new .gitignore invalidates recursively' '
-	avoid_racy &&
 	echo four >.gitignore &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
@@ -292,7 +298,6 @@ EOF
 '
 
 test_expect_success 'new info/exclude invalidates everything' '
-	avoid_racy &&
 	echo three >>.git/info/exclude &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
@@ -520,14 +525,14 @@ test_expect_success 'create/modify files, some of which are gitignored' '
 	echo three >done/three && # three is gitignored
 	echo four >done/four && # four is gitignored at a higher level
 	echo five >done/five && # five is not gitignored
-	echo test >base && #we need to ensure that the root dir is touched
-	rm base &&
+	test-tool chmtime =-180 done/two done/three done/four done/five done &&
+	# we need to ensure that the root dir is touched (in the past);
+	chmtime_worktree_root =-180 &&
 	sync_mtime
 '
 
 test_expect_success 'test sparse status with untracked cache' '
 	: >../trace.output &&
-	avoid_racy &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
 	iuc status --porcelain >../status.iuc &&
@@ -570,7 +575,6 @@ EOF
 '
 
 test_expect_success 'test sparse status again with untracked cache' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
@@ -597,11 +601,11 @@ EOF
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
@@ -651,7 +655,6 @@ EOF
 '
 
 test_expect_success 'test sparse status again with untracked cache and subdir' '
-	avoid_racy &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status --porcelain >../status.actual &&
-- 
gitgitgadget
