Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A7D20966
	for <e@80x24.org>; Sun, 26 Mar 2017 02:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdCZCol (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 22:44:41 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34481 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbdCZCoj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 22:44:39 -0400
Received: by mail-pf0-f195.google.com with SMTP id o126so4076025pfb.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 19:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8YJekJ+dwFjv8LMV2PLoILCR+0Z9scu4uBxaQNsTHMY=;
        b=qmD3y48xdgEIMQvlwflHAbrnRqheCAoHKXdIanmdU4xxirb5gD0D4uwE+dhKiS26mt
         bkffIxar4YDePOrGd+hlAmzq34WEJYaltYDHsfy+q8Umc5bcnVKt981xpHlFhG+cs5D9
         aIwnRroRuUsmxTALGN24ZuxLhEKWBlDVC5CRMtYm51O75mr89Bgtv1jZ5CCW+ZYSXQjO
         sOwsOQ3OHCeil/a591DFTNGNjW1SkE0RHi0o2IdXuqqw/K9mmqDRyOVVpenQZ0OIrMqS
         0IlGhcMplFIQRQPyhFm4lAz4GiWFTlL+giXCaFZ52+HF9QB1yFisx6D32/ubZl8Ips9g
         hhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8YJekJ+dwFjv8LMV2PLoILCR+0Z9scu4uBxaQNsTHMY=;
        b=LagWiXvGGz6mLpdTWjPRbjhKmSg5J55cRQrj0TA0/gxv47tqLIG79CQ3HO9RS9LiFl
         b49paxSUkS1bXsBGaPpUGWBmtKP/LyOFc3Afwxn7jQNEgwzfTGTpzV7soOilnlwu+onq
         E5BzN2H8dAjVuY2XMZfSIuvhl3TODd88mRVRzkPB/Hj2fOID/+qbiutlZRQ1JPr2bpa6
         Y/GkgK82gNq0sYhteopECgOXtb53k1TazutExbD2luPtKJrS4D9vKu2/UxwJpizhIF3m
         cwPmLZ14khslt5rm3O9s2syipq9ST4QrFgban1QKddZ341B+ZCVtME+I6AtnIaF+6kBf
         oBAw==
X-Gm-Message-State: AFeK/H2lmYSK0ZJbjIzGQyhtyzPdjKxAkHPGnfeCxJ9BzFhvFFAz6zIIVKBVlJCIa21wBA==
X-Received: by 10.98.214.3 with SMTP id r3mr17158823pfg.255.1490496278447;
        Sat, 25 Mar 2017 19:44:38 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id c16sm12842536pfl.7.2017.03.25.19.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2017 19:44:37 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 26 Mar 2017 09:44:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v7 17/28] path.c: move some code out of strbuf_git_path_submodule()
Date:   Sun, 26 Mar 2017 09:42:30 +0700
Message-Id: <20170326024241.31984-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170326024241.31984-1-pclouds@gmail.com>
References: <20170318020337.22767-1-pclouds@gmail.com>
 <20170326024241.31984-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

refs is learning to avoid path rewriting that is done by
strbuf_git_path_submodule(). Factor out this code so it could be reused
by refs_* functions.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 path.c      | 35 +++++++----------------------------
 submodule.c | 31 +++++++++++++++++++++++++++++++
 submodule.h |  6 ++++++
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
index 3200b7bb2b..a31f68812c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1596,3 +1596,34 @@ const char *get_superproject_working_tree(void)
 
 	return ret;
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
index c8a0c9cb29..fce2fb64d2 100644
--- a/submodule.h
+++ b/submodule.h
@@ -81,6 +81,12 @@ extern int push_unpushed_submodules(struct sha1_array *commits,
 				    int dry_run);
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 extern int parallel_submodules(void);
+/*
+ * Given a submodule path (as in the index), return the repository
+ * path of that submodule in 'buf'. Return -1 on error or when the
+ * submodule is not initialized.
+ */
+int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
-- 
2.11.0.157.gd943d85

