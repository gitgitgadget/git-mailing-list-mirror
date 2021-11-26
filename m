Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EACC433FE
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 22:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245106AbhKZWs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbhKZWqT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 17:46:19 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF1BC0613DD
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:09 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so7686030wme.4
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FDr2oeK9NSnm4r178IXhLhbySWTqD/n48H5jWA31p/s=;
        b=hCYF+RxvUgiM72yFqf2LCUAvWuZhiEGft9xkcSKJiOpm9nKs3DZA4UxlF9nvM2F65Y
         SsRcKQzgKgUyOFZWBU3Le7QYz8j5vvYXzRFzuuv8UlWVN1eG1OowauINoGpwXmyHDmsZ
         VWBlx+BgFLqTMQIwVlSVYmH2N+j50T9iz9TbRH+c4g1BIMEYvsmEueaDdq3XuzCw7Kam
         G3oHpmf6amx3VWNJbxulsaT0I7kP/j6UkumSwKLUmAuN7OOgZ5vXZjkYynwkMsSRFgtQ
         KWsXB5g1KGMfQQwMgFwDU1f32Sle7ukRhLSW7kajkpKFqo1zcyuYU4r4HPr1a3isksDq
         5Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FDr2oeK9NSnm4r178IXhLhbySWTqD/n48H5jWA31p/s=;
        b=JHE3397g7k90RGtkAKneD4DOCUgb+hAcyQdKKNwua49ssVtVf7vTBsU2o7GZn55/tW
         pDQP9TLikaZO3cLZXq5obGteIXPjQ/GUxTNoaZNOvacd79jLvkk9T0q2Nc8f7+Yb8Hyw
         8VZ9+eCikKVEqomomyMEROu6krnO5htElBKA/JqPO4VH4oZ0cRfMxfsZ4rzinFYK4nzj
         Q394KhfxwDMzbQ7G1v5F6q+zTZSVpbiGvj/tg6PkTCPkXhVoaThaxajZXk13AC+Uprr2
         03GWb8YPr93xwW4OLyy/8DK5q0Vz/kP3OmgaJIXbS0YsnK563BEflLTmFrsTyk4QTOb/
         9s9g==
X-Gm-Message-State: AOAM530lpgdjPTmMM8D+WuWBdSI8YlzYWKJos7+Q7J+6DaBGCN825w6x
        UZ/HNS2FzAhbj6PxzfIbMy6JDTnsqwQ=
X-Google-Smtp-Source: ABdhPJykRG0HzqqWR9XxzV+c9gguZiwxj4FPvymEXvp4GeoNr3qzFTXVh3RVFxhRPhfmQlucuHhwsg==
X-Received: by 2002:a05:600c:104b:: with SMTP id 11mr19472496wmx.54.1637966468187;
        Fri, 26 Nov 2021 14:41:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16sm6462339wrx.96.2021.11.26.14.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:41:07 -0800 (PST)
Message-Id: <8a33d74e7cff636c04abf0198bb7d5c72d118d35.1637966463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
        <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Nov 2021 22:40:56 +0000
Subject: [PATCH v3 05/11] symlinks: do not include startup_info->original_cwd
 in dir removal
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

symlinks has a pair of schedule_dir_for_removal() and
remove_scheduled_dirs() functions that ensure that directories made
empty by removing other files also themselves get removed.  However, we
want to exclude startup_info->original_cwd and leave it around.  This
avoids the user getting confused by subsequent git commands (and non-git
commands) that would otherwise report confusing messages about being
unable to read the current working directory.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 symlinks.c           |  8 +++++++-
 t/t2501-cwd-empty.sh | 10 +++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 5232d02020c..c667baa949b 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -279,7 +279,9 @@ static void do_remove_scheduled_dirs(int new_len)
 {
 	while (removal.len > new_len) {
 		removal.buf[removal.len] = '\0';
-		if (rmdir(removal.buf))
+		if ((startup_info->original_cwd &&
+		     !strcmp(removal.buf, startup_info->original_cwd)) ||
+		    rmdir(removal.buf))
 			break;
 		do {
 			removal.len--;
@@ -293,6 +295,10 @@ void schedule_dir_for_removal(const char *name, int len)
 {
 	int match_len, last_slash, i, previous_slash;
 
+	if (startup_info->original_cwd &&
+	    !strcmp(name, startup_info->original_cwd))
+		return;	/* Do not remove the current working directory */
+
 	match_len = last_slash = i =
 		longest_path_match(name, len, removal.buf, removal.len,
 				   &previous_slash);
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 886a391a63d..496f4c6a6e9 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -102,7 +102,7 @@ test_required_dir_removal () {
 }
 
 test_expect_success 'checkout does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git checkout init
+	test_incidental_dir_removal success git checkout init
 '
 
 test_expect_success 'checkout fails if cwd needs to be removed' '
@@ -110,7 +110,7 @@ test_expect_success 'checkout fails if cwd needs to be removed' '
 '
 
 test_expect_success 'reset --hard does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git reset --hard init
+	test_incidental_dir_removal success git reset --hard init
 '
 
 test_expect_success 'reset --hard fails if cwd needs to be removed' '
@@ -118,7 +118,7 @@ test_expect_success 'reset --hard fails if cwd needs to be removed' '
 '
 
 test_expect_success 'merge does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git merge reverted
+	test_incidental_dir_removal success git merge reverted
 '
 
 # This file uses some simple merges where
@@ -151,7 +151,7 @@ test_expect_success 'merge fails if cwd needs to be removed' '
 '
 
 test_expect_success 'cherry-pick does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git cherry-pick reverted
+	test_incidental_dir_removal success git cherry-pick reverted
 '
 
 test_expect_success 'cherry-pick fails if cwd needs to be removed' '
@@ -167,7 +167,7 @@ test_expect_success 'rebase fails if cwd needs to be removed' '
 '
 
 test_expect_success 'revert does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git revert HEAD
+	test_incidental_dir_removal success git revert HEAD
 '
 
 test_expect_success 'revert fails if cwd needs to be removed' '
-- 
gitgitgadget

