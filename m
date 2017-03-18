Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBB802095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbdCRCHQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:07:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33784 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbdCRCHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:07:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id p189so4798980pfp.0
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 19:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rxIb+IoP17ShGayUI3qlQoLipKM3Mb+H+WPqPe1dOgI=;
        b=ukMsJZBkV5S2aZ+CV8XSOkLSSy7F2nagHgZW7EcNr3nsWi/psPO2zwb1c06eiliI7Z
         ZxRltg8OzBnckY68jiGPoSKS4J6cu21ZTDBkswPPJStj6/QG8TPlELjgyeO6GcH48Rro
         PhaqTu7LjVDtQsUWBnJnXI4/vY1OcZCYPoDoBAt5urJ8vsWD2Q/VryFBuu1V2fbNh6/t
         9yoC3pQ6ORl2vwCh1qAZq/Kc5vLTS9JlKlWhFTwHq3owz50daChuSqPayCGVxisaKBln
         qp55G/QsLXGIgojtAiC+XpExYGs8i4hnVzhv+GI9vnpeY3FwKDA1GXZmTR8Gq5E4P6Eu
         1EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxIb+IoP17ShGayUI3qlQoLipKM3Mb+H+WPqPe1dOgI=;
        b=YmjxWyTBv5h4F9WmUyjPYimFLjkqIGYSw8+CkpyeWIeOaUUDPXyslFNoROSaSga0xd
         xgspQIY0B2r+F/9piirXwdx9nNX71eN/aQ01Kn3Lqe/1EBkBMNGcBfJiYvSKJ9aBELSF
         jLalmbXqaJAQn4/B6eBeTmWf8R/g9YfE3wSgR8v3w8PPk9bwWgf71SydR7xksL4581lF
         VHZiOmdemfeSwckZt/9pLPNnwRJM7nzw+/Zxn4HBpMG8Lk9vaIO/HgNM7tkKZbugNzyA
         CWxadGAr9QITpuQoPgCqcXREyKf7tOCwrHJojHC9QQECTQmjO3CcxSfjzzy7D6WVtUhK
         ApsA==
X-Gm-Message-State: AFeK/H1pyPSm0osMF4dnh4YNOgK+EP+6wLW3bySOkFChRC88k4Qu9Dqwez95bczAPNUEIg==
X-Received: by 10.98.192.151 with SMTP id g23mr20220389pfk.254.1489802742824;
        Fri, 17 Mar 2017 19:05:42 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id y9sm19120145pfi.39.2017.03.17.19.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 19:05:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 09:05:36 +0700
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
Subject: [PATCH v6 16/27] path.c: move some code out of strbuf_git_path_submodule()
Date:   Sat, 18 Mar 2017 09:03:26 +0700
Message-Id: <20170318020337.22767-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318020337.22767-1-pclouds@gmail.com>
References: <20170222140450.30886-1-pclouds@gmail.com>
 <20170318020337.22767-1-pclouds@gmail.com>
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
 path.c      | 35 +++++++----------------------------
 submodule.c | 36 ++++++++++++++++++++++++++++++++++++
 submodule.h |  1 +
 3 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/path.c b/path.c
index efcedafba6..03e7e33b6e 100644
--- a/path.c
+++ b/path.c
@@ -471,39 +471,19 @@ const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
 }
 
 /* Returns 0 on success, negative on failure. */
-#define SUBMODULE_PATH_ERR_NOT_CONFIGURED -1
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
@@ -514,8 +494,7 @@ static int do_submodule_path(struct strbuf *buf, const char *path,
 cleanup:
 	strbuf_release(&git_submodule_dir);
 	strbuf_release(&git_submodule_common_dir);
-
-	return err;
+	return ret;
 }
 
 char *git_pathdup_submodule(const char *path, const char *fmt, ...)
diff --git a/submodule.c b/submodule.c
index 3200b7bb2b..3c445f274e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1596,3 +1596,39 @@ const char *get_superproject_working_tree(void)
 
 	return ret;
 }
+
+/*
+ * Given a submodule path (as in the index), return the repository
+ * path of that submodule in 'buf'. Return -1 on error or when the
+ * submodule is not initialized.
+ */
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
index c8a0c9cb29..bddbba7f32 100644
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

