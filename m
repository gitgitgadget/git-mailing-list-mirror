Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DFF9201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932670AbdBVOH1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:07:27 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36606 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932722AbdBVOHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:07:22 -0500
Received: by mail-pg0-f67.google.com with SMTP id z128so541813pgb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AEzSKmhZ62X5FjbcSWzCndNsK0rTBuuwgJjWVVGLCMo=;
        b=D7AskxhiRdjWnoeyAC7jxqrj/6VpBWVuIbR9eEXlbMe6EziCNzpcApLY9OdqJrzu23
         fsQHX2ZF3WvR1utDgQja915k9gCONmg2hB0oY9NUbwwhAWA9U4isBhjNM1K6sR0HdLsN
         TbuwUOyNdO775yqulekQ95TLvK8XW/fmGJNDI2iLKcwadZ/fJl/B4a53u7jjdYftshq0
         1eTJxCbr8puKnbzTR8p2y7FMWnCVcdBtotWUJj+bOo29kHNYwlh1MljVuT/rYj5SzowA
         /9qMUKIQGzJEk8t7cvKnAvAc1/YVH6MhO5VyZPcKSztFcDPDOyqW7jpOJ/Yd/LmLQ8as
         jJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AEzSKmhZ62X5FjbcSWzCndNsK0rTBuuwgJjWVVGLCMo=;
        b=ciL+E9PH9dN3mNkB8uZuwYPcH0LuO9ml5BlegnQa4LlDKdiFwZtzfUX6MqehWSl7OP
         JQFaPt4GBo/F5yO3nWdlH0TLJBrdeHtyi3Aev9o06IFtt+FaNhKhyjvPKA3cHpyPtSvn
         vgKwbFqhgJxIox1826MOAJV1qSqwj270Nwz6I9ycTRWVICvyhO8wccNo2Mb+JkZt/NwS
         G5ZtMEEePdjO68IO7YZwdVhxhkDBY82yMG65sz2q7gqGSmvbj4KykG4berfaSkslvii4
         uyXnMQWwnKapTlBXomf2yEk9i5GcjtsWREiM6gWf19TNtAYMBQAiOGtRoiR6V7yaHYG7
         VczA==
X-Gm-Message-State: AMke39lBUzQU9pINXyoPIbpAEc+U+WpoJubSq1nSFInwE6uwAfZcTDjo7YLJB8caD8cvYQ==
X-Received: by 10.84.215.215 with SMTP id g23mr48354708plj.159.1487772437049;
        Wed, 22 Feb 2017 06:07:17 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id n79sm4112393pfj.31.2017.02.22.06.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:07:16 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:07:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 14/24] path.c: move some code out of strbuf_git_path_submodule()
Date:   Wed, 22 Feb 2017 21:04:40 +0700
Message-Id: <20170222140450.30886-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

refs is learning to avoid path rewriting that is done by
strbuf_git_path_submodule(). Factor out this code so it could be reused
by refs*

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 path.c      | 34 +++++++---------------------------
 submodule.c | 31 +++++++++++++++++++++++++++++++
 submodule.h |  1 +
 3 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/path.c b/path.c
index efcedafba..3451d2916 100644
--- a/path.c
+++ b/path.c
@@ -475,35 +475,16 @@ const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
 static int do_submodule_path(struct strbuf *buf, const char *path,
 			     const char *fmt, va_list args)
 {
-	const char *git_dir;
 	struct strbuf git_submodule_common_dir = STRBUF_INIT;
 	struct strbuf git_submodule_dir = STRBUF_INIT;
-	const struct submodule *sub;
-	int err = 0;
+	int ret;
 
-	strbuf_addstr(buf, path);
-	strbuf_complete(buf, '/');
-	strbuf_addstr(buf, ".git");
-
-	git_dir = read_gitfile(buf->buf);
-	if (git_dir) {
-		strbuf_reset(buf);
-		strbuf_addstr(buf, git_dir);
-	}
-	if (!is_git_directory(buf->buf)) {
-		gitmodules_config();
-		sub = submodule_from_path(null_sha1, path);
-		if (!sub) {
-			err = SUBMODULE_PATH_ERR_NOT_CONFIGURED;
-			goto cleanup;
-		}
-		strbuf_reset(buf);
-		strbuf_git_path(buf, "%s/%s", "modules", sub->name);
-	}
-
-	strbuf_addch(buf, '/');
-	strbuf_addbuf(&git_submodule_dir, buf);
+	ret = submodule_to_gitdir(&git_submodule_dir, path);
+	if (ret)
+		goto cleanup;
 
+	strbuf_complete(&git_submodule_dir, '/');
+	strbuf_addbuf(buf, &git_submodule_dir);
 	strbuf_vaddf(buf, fmt, args);
 
 	if (get_common_dir_noenv(&git_submodule_common_dir, git_submodule_dir.buf))
@@ -514,8 +495,7 @@ static int do_submodule_path(struct strbuf *buf, const char *path,
 cleanup:
 	strbuf_release(&git_submodule_dir);
 	strbuf_release(&git_submodule_common_dir);
-
-	return err;
+	return ret;
 }
 
 char *git_pathdup_submodule(const char *path, const char *fmt, ...)
diff --git a/submodule.c b/submodule.c
index 3b98766a6..36b8d1d11 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1514,3 +1514,34 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		strbuf_release(&sb);
 	}
 }
+
+int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
+{
+	const struct submodule *sub;
+	const char *git_dir;
+	int ret = 0;
+
+	strbuf_reset(buf);
+	strbuf_addstr(buf, submodule);
+	strbuf_complete(buf, '/');
+	strbuf_addstr(buf, ".git");
+
+	git_dir = read_gitfile(buf->buf);
+	if (git_dir) {
+		strbuf_reset(buf);
+		strbuf_addstr(buf, git_dir);
+	}
+	if (!is_git_directory(buf->buf)) {
+		gitmodules_config();
+		sub = submodule_from_path(null_sha1, submodule);
+		if (!sub) {
+			ret = -1;
+			goto cleanup;
+		}
+		strbuf_reset(buf);
+		strbuf_git_path(buf, "%s/%s", "modules", sub->name);
+	}
+
+cleanup:
+	return ret;
+}
diff --git a/submodule.h b/submodule.h
index 05ab674f0..fc3d0303e 100644
--- a/submodule.h
+++ b/submodule.h
@@ -81,6 +81,7 @@ extern int push_unpushed_submodules(struct sha1_array *commits,
 				    int dry_run);
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 extern int parallel_submodules(void);
+int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
-- 
2.11.0.157.gd943d85

