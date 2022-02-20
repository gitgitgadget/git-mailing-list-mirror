Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608F1C433FE
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 17:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbiBTRy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 12:54:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbiBTRyy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 12:54:54 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C370527F2
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:33 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h6so23248890wrb.9
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 09:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M3yfAW+FMygRnAbUO3SWrYQH55uT4SNwhA5DqD8nFTc=;
        b=MLIBCiauXYpI3hQzFqU7lTJcRSsJgdNpuLoraPxvr1OyUpe2ZLIumoIrwC/YRVyP7q
         yXJ7IQoKK+OakVDTzPHZg32lgmq+4YGJVq7X8vhkIQM/zOnZOobixWFm8ut6mMgNKcsn
         C07aw/O6VT7aG4+p83SCWf7YuEanhbADghoOTvbHSw9skxm/4GWs2jpbK2tp+5A6vto2
         nIJwZHSdBL1Z+S7dWK7vRP6QfJPBimrN4fajju5BZYyrc2GxK4dSRE9n3+HCpDXkuIai
         vLm2u3zu2idAjO/AkCDVLmz3FD4+zSemSkKZ2LFzGcw7NVh6xyTwNSUWZsGVeWRosn4D
         Zpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M3yfAW+FMygRnAbUO3SWrYQH55uT4SNwhA5DqD8nFTc=;
        b=Crc//RqbL8lhd5koV/ljF5fypw4vfxe+TPNeV0Dn6Y4/MvQiUeaJ2IA5Rsh8TY1fda
         vY9j+TQR5JjDTA2kHxAxPs98jT4l3r7ji6R7cho7IIXJ6d6R6L39RmqMdZLOYri+af3X
         3H4SlcL4AtvH8n+yg5C2bAAzv7M/Tq5Kwx1snouRf/Tvqf6H88iMe7xA9G35B0kyWny+
         QVoRno4lBK5eTYdsBzKcC6wB0HyLkmmT6egcFgP7bG+diRVZBtCVxksAWTBF8YZF+mmv
         +BcCb3e4CZ5m14Ga6fraA60c7KA12Vjctlq9sDhexbfR+vdZk9njc466Hbad1JgN8nk/
         wZow==
X-Gm-Message-State: AOAM533sY1OfH3UykpuNeG2//s8CDrc3LhEysYeINa88ML+EybjBkDg5
        PiSZtGB6ffdtSMeqDuRMgc6juZFk4qk=
X-Google-Smtp-Source: ABdhPJzy2T9mG3OOhCnbsWPLv7JbNuFTFha+tOpYBYlaNwnEVUH+ZFhRivhqx/h3QsOOEm2i+qsNlQ==
X-Received: by 2002:a5d:64e6:0:b0:1e4:a576:5800 with SMTP id g6-20020a5d64e6000000b001e4a5765800mr12732434wri.49.1645379671618;
        Sun, 20 Feb 2022 09:54:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm5204380wmk.38.2022.02.20.09.54.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 09:54:31 -0800 (PST)
Message-Id: <ccc5b1ef9fb4dbeedfbc1ad8f0da36299bf48b56.1645379667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 17:54:19 +0000
Subject: [PATCH 03/11] worktree: extract copy_sparse_checkout()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:sunshine@sunshineco.com" 
        <[sunshine@sunshineco.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        "Elijah Newren [ ]" <newren@gmail.com>,
        "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
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

