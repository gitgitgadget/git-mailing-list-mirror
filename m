Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD5FC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241588AbiBWOaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbiBWO3x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:29:53 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763E9B251B
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:25 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u1so39913886wrg.11
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M3yfAW+FMygRnAbUO3SWrYQH55uT4SNwhA5DqD8nFTc=;
        b=T10qMne4e0hMrBwV4S9IsSLHcqiOXdzkVeD3tO+Ww3XHoDbbGD8t1dPO9+a8h9GPHN
         jWKDLpL/rxwOcZXYZMa5y6hh6HX7DYDPlG6zIxHYjW0NtgCWmy2awwEG6jCYpsxcw492
         P86Yttla4jLV/+njIwhKKxhgRRmpZEI7DQtD1h6R7WPjFMUi/u1ZgXFf9lflFM+rQSIO
         sUGMmMW0neIBBYcroP7Ov5EA8JTBFZR29c61kgLq26LV/ntO27G9Ng8tDyo0xgk8GgMY
         5T8Z5jwktsRx6A7VdKtS1XhLRc5ePGx5PRSQjv2mtlAzkmhoHkAp0C9F/FqCM3PEBK7h
         d2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M3yfAW+FMygRnAbUO3SWrYQH55uT4SNwhA5DqD8nFTc=;
        b=U+Fr97ZSSfDTY3bLBcN//+eo0PRshpNIsL6/pQLjPNNayup06gi44fe/ocybJptq8D
         qBeOzpcceMYwVQbgJW/NgFkaHiQV4aRFdWfDV32N/OX6UjQGmrmqjCHuuOIITYtJp60R
         coajoX/Gb3RMEMIDVKzuLm6j5H04/1eOrIDYwQm2tjlEVQbJy7lH3542qtxdg3qAS/FD
         1QOlG5KKA6nlXXtK0hGDjiQOn7r1lgTNNmzv0vjO+0x934DlvQy+hnP0QkVtYPH5Gt7Q
         K9GePN/zHD9ck4FVnKCt5xq13dHdA6IKbETqY9F6E7tHXe63eH6MhwkDx3LPj2WwNCd5
         ZLNQ==
X-Gm-Message-State: AOAM530t2EN0SvAUjydtpPApJryoLxHtXNYJWKtjjc9uGYlCIm6E7ATP
        kkLuwLH756zycgd0OsEyBEUGJZcjnCk=
X-Google-Smtp-Source: ABdhPJz2Q1kunxHvmfBeL9q34/YbFRY0V5fQcDO2B1GR3QzfV3h5e6PEh7zK4qBHFRcsgREJwitdrA==
X-Received: by 2002:a5d:6106:0:b0:1ed:b56f:73f7 with SMTP id v6-20020a5d6106000000b001edb56f73f7mr2429084wrt.601.1645626563775;
        Wed, 23 Feb 2022 06:29:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2sm34404139wry.4.2022.02.23.06.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 06:29:23 -0800 (PST)
Message-Id: <ccc5b1ef9fb4dbeedfbc1ad8f0da36299bf48b56.1645626559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
References: <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
        <pull.1154.v3.git.1645626559.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 14:29:11 +0000
Subject: [PATCH v3 03/11] worktree: extract copy_sparse_checkout()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, newren@gmail.com,
        jn.avila@free.fr, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This logic was introduced by 5325591 (worktree: copy sparse-checkout
patterns and config on add, 2022-02-07), but some feedback came in that
the add_worktree() method was already too complex. It is better to
extract this logic into a helper method to reduce this complexity.

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/worktree.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2771a6dc793..c806aa2b261 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -236,6 +236,22 @@ static void check_candidate_path(const char *path,
 		die(_("'%s' is a missing but already registered worktree;\nuse '%s -f' to override, or 'prune' or 'remove' to clear"), path, cmd);
 }
 
+static void copy_sparse_checkout(const char *worktree_git_dir)
+{
+	char *from_file = git_pathdup("info/sparse-checkout");
+	char *to_file = xstrfmt("%s/info/sparse-checkout", worktree_git_dir);
+
+	if (file_exists(from_file)) {
+		if (safe_create_leading_directories(to_file) ||
+			copy_file(to_file, from_file, 0666))
+			error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
+				from_file, to_file);
+	}
+
+	free(from_file);
+	free(to_file);
+}
+
 static void copy_filtered_worktree_config(const char *worktree_git_dir)
 {
 	char *from_file = git_pathdup("config.worktree");
@@ -379,21 +395,8 @@ static int add_worktree(const char *path, const char *refname,
 	 * If the current worktree has sparse-checkout enabled, then copy
 	 * the sparse-checkout patterns from the current worktree.
 	 */
-	if (core_apply_sparse_checkout) {
-		char *from_file = git_pathdup("info/sparse-checkout");
-		char *to_file = xstrfmt("%s/info/sparse-checkout",
-					sb_repo.buf);
-
-		if (file_exists(from_file)) {
-			if (safe_create_leading_directories(to_file) ||
-			    copy_file(to_file, from_file, 0666))
-				error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
-				      from_file, to_file);
-		}
-
-		free(from_file);
-		free(to_file);
-	}
+	if (core_apply_sparse_checkout)
+		copy_sparse_checkout(sb_repo.buf);
 
 	/*
 	 * If we are using worktree config, then copy all current config
-- 
gitgitgadget

