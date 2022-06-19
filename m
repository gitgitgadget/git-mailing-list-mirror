Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF89C433EF
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 06:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiFSGul (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiFSGuc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 02:50:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06C0B1C2
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c21so10623100wrb.1
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eMYu1f5s0ZlNeir2jCvyf9PKMMh08qeDUrXCYegKz+U=;
        b=e/pbqeqpvijHazW7v0MP1NM2CAGX5kNmlhqQQ1JjdB7xN3U5D997SHP87rz3JJYvkW
         IbhAsRxknpEiwusQmnVlbzbsRVZ+CzA5qrjzEWf9hEbUm6eBiueLb1YSvbaqsfjd+Njq
         ayM42POnqnBPC3AdCxx2792ia1aRocCO0IQKzJxmt1Y3L6K2MHUQoQeLmWLaFyNfzfMq
         txzPWoPmmkR5QhbwBtfgGO6nxb6OlVvQ+O/P6uNnvtsQBd+ZTQ7s8IEzQtQY9364W+RS
         8UrhMIqTH1BBGrsRbK9kVSHGwjI/GDGHnXLOMjIWLterdncj5yRh+5HSj9akWuYsTlPQ
         ggdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eMYu1f5s0ZlNeir2jCvyf9PKMMh08qeDUrXCYegKz+U=;
        b=bS66/Yqp8u1LnUWjxja7E1D/7LxpQ3W8SulEnNc8785TuPQ9WW7M2znMTtv8knRQOe
         UJdhop2K7GCtDJYAR+qDVN/A8IINIkl4R9atmLsyN6vao8sL3OU9vavCJkc6Dok6xJUX
         xpwdWiQy5DhN+wFS2F8xyXrIumA5UPXVLYeeDHgGlv2OYrFbgQcU+VMdDPdC0U46x1rv
         OUWyYKela38CE337JJOe5EVUa2hNUVoBwY1NSJYl4lzXVIfntRQGxPdJYXHnmz0nxt29
         XwTZINnW+yO36pQ0lzKTTIWrazVGA5xIKkKIzWOTnW2U5UTpsjRMdhL2XjCcFi3fegFk
         5p5g==
X-Gm-Message-State: AJIora+1+zUUVrSMKVM2iShP3onKBqfCtTiDWFWrs0CZvztGQkmpiMSL
        EaW8wyCRmrSO3wqJLq5EI770ZmxCzpThgQ==
X-Google-Smtp-Source: AGRyM1ssFNPQiifym60Z+hcMQG506BAa+ZhFrciGhvVElh59OZvbQnrXGGuWno3J9spnW8sOk059yw==
X-Received: by 2002:a5d:4d8f:0:b0:210:3e14:ff27 with SMTP id b15-20020a5d4d8f000000b002103e14ff27mr16614772wru.81.1655621429016;
        Sat, 18 Jun 2022 23:50:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b0021b5861eaf7sm6629098wrr.3.2022.06.18.23.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 23:50:27 -0700 (PDT)
Message-Id: <6147e72c3097fec85d6202a600d06b1ad222b49a.1655621424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Jun 2022 06:50:19 +0000
Subject: [PATCH v2 1/6] t6424: make sure a failed merge preserves local
 changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

We do make sure that an attempt to merge with various forms of local
changes will "fail", but the point of stopping the merge is so that
we refrain from discarding uncommitted local changes that could be
precious.  Add a few more checks for each case to make sure the
local changes are left intact.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6424-merge-unrelated-index-changes.sh | 32 ++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 89dd544f388..b6e424a427b 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -71,7 +71,9 @@ test_expect_success 'ff update' '
 	git merge E^0 &&
 
 	test_must_fail git rev-parse HEAD:random_file &&
-	test "$(git diff --name-only --cached E)" = "random_file"
+	test "$(git diff --name-only --cached E)" = "random_file" &&
+	test_path_is_file random_file &&
+	git rev-parse --verify :random_file
 '
 
 test_expect_success 'ff update, important file modified' '
@@ -83,6 +85,8 @@ test_expect_success 'ff update, important file modified' '
 	git add subdir/e &&
 
 	test_must_fail git merge E^0 &&
+	test_path_is_file subdir/e &&
+	git rev-parse --verify :subdir/e &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -93,6 +97,8 @@ test_expect_success 'resolve, trivial' '
 	touch random_file && git add random_file &&
 
 	test_must_fail git merge -s resolve C^0 &&
+	test_path_is_file random_file &&
+	git rev-parse --verify :random_file &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -103,6 +109,8 @@ test_expect_success 'resolve, non-trivial' '
 	touch random_file && git add random_file &&
 
 	test_must_fail git merge -s resolve D^0 &&
+	test_path_is_file random_file &&
+	git rev-parse --verify :random_file &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -113,6 +121,8 @@ test_expect_success 'recursive' '
 	touch random_file && git add random_file &&
 
 	test_must_fail git merge -s recursive C^0 &&
+	test_path_is_file random_file &&
+	git rev-parse --verify :random_file &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -145,9 +155,12 @@ test_expect_success 'recursive, when file has staged changes not matching HEAD n
 	mkdir subdir &&
 	test_seq 1 10 >subdir/a &&
 	git add subdir/a &&
+	git rev-parse --verify :subdir/a >expect &&
 
 	# We have staged changes; merge should error out
 	test_must_fail git merge -s recursive E^0 2>err &&
+	git rev-parse --verify :subdir/a >actual &&
+	test_cmp expect actual &&
 	test_i18ngrep "changes to the following files would be overwritten" err
 '
 
@@ -158,9 +171,12 @@ test_expect_success 'recursive, when file has staged changes matching what a mer
 	mkdir subdir &&
 	test_seq 1 11 >subdir/a &&
 	git add subdir/a &&
+	git rev-parse --verify :subdir/a >expect &&
 
 	# We have staged changes; merge should error out
 	test_must_fail git merge -s recursive E^0 2>err &&
+	git rev-parse --verify :subdir/a >actual &&
+	test_cmp expect actual &&
 	test_i18ngrep "changes to the following files would be overwritten" err
 '
 
@@ -171,7 +187,9 @@ test_expect_success 'octopus, unrelated file touched' '
 	touch random_file && git add random_file &&
 
 	test_must_fail git merge C^0 D^0 &&
-	test_path_is_missing .git/MERGE_HEAD
+	test_path_is_missing .git/MERGE_HEAD &&
+	git rev-parse --verify :random_file &&
+	test_path_exists random_file
 '
 
 test_expect_success 'octopus, related file removed' '
@@ -181,6 +199,8 @@ test_expect_success 'octopus, related file removed' '
 	git rm b &&
 
 	test_must_fail git merge C^0 D^0 &&
+	test_path_is_missing b &&
+	test_must_fail git rev-parse --verify :b &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -189,8 +209,12 @@ test_expect_success 'octopus, related file modified' '
 	git checkout B^0 &&
 
 	echo 12 >>a && git add a &&
+	git rev-parse --verify :a >expect &&
 
 	test_must_fail git merge C^0 D^0 &&
+	test_path_is_file a &&
+	git rev-parse --verify :a >actual &&
+	test_cmp expect actual &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -201,6 +225,8 @@ test_expect_success 'ours' '
 	touch random_file && git add random_file &&
 
 	test_must_fail git merge -s ours C^0 &&
+	test_path_is_file random_file &&
+	git rev-parse --verify :random_file &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
@@ -211,6 +237,8 @@ test_expect_success 'subtree' '
 	touch random_file && git add random_file &&
 
 	test_must_fail git merge -s subtree E^0 &&
+	test_path_is_file random_file &&
+	git rev-parse --verify :random_file &&
 	test_path_is_missing .git/MERGE_HEAD
 '
 
-- 
gitgitgadget

