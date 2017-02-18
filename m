Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9A4201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 13:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753400AbdBRNeu (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 08:34:50 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34228 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbdBRNet (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 08:34:49 -0500
Received: by mail-pg0-f66.google.com with SMTP id v184so7383674pgv.1
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 05:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AEzSKmhZ62X5FjbcSWzCndNsK0rTBuuwgJjWVVGLCMo=;
        b=Zb69S08kxncNVPZfZLXVqJN/qWZNRwmgtP+LVeWSsNsLyRamLKPX4l9P/ElPlfcDHF
         2lh8d4lxA+2jBMqxhacAIEzADaCvQIxqUBbxnWOEw/v/ldafQ0MGd7KCWiUWHKE/+UgQ
         CYOVzqEq+4yFUn6rXyARbibE7IvOkbk3DtYaUyYwiukP04motvN8LHtOGvb3GL4IEDA9
         +Dx75Ifz1IzjSTuilPbfd8GIeQ9eS6knd0jMDfaqIJ8iQSRfxKdIIDDmcTrGgEkMeS5q
         gYtrVLv0s8df6Qr8wjhZDDtZbS03bNuIkizouiFEu6LXlZiFOH0bCd6E3Zx7wtej5gpH
         WkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AEzSKmhZ62X5FjbcSWzCndNsK0rTBuuwgJjWVVGLCMo=;
        b=EUmdZbt4zCUrRcJtBXmqFTuHsfitiuxCgdSo/HYefIGdmWB1Bhn5nxMaKrXRemg1OM
         HXNGZdjJmzAD+VuP3vTZ7BbOMmdiD4zYvkCONMs9kBcjPdVgeMSYxHXQz758b3awX1yz
         iHiZSCHcc03YWazT6CeyGsaU/QzJGJbeaVYVB4qXqw2bPWN9nZBRzuQesau7RIly+/Ix
         zntCYgIVQ18M//G1gC5+D5hcYd4SsgAP/SFg+CC8MXXylO+T2g7XJpc6O9Bz9WYsEzpS
         QEMvkeYXulPLH7NrshdP34MJyRSKUyHy8dTS5S5zZ5en8xiiHIYJvI1k9eH8bvWW6sAN
         eUFw==
X-Gm-Message-State: AMke39mogaIqLCTS1hi9mCT+IrroMUocRH69pKar4KhdmSaGmS5c0g/pa2o37/ShaPxIqw==
X-Received: by 10.99.238.5 with SMTP id e5mr16128397pgi.49.1487424888533;
        Sat, 18 Feb 2017 05:34:48 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id t12sm25555555pfg.4.2017.02.18.05.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Feb 2017 05:34:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Feb 2017 20:34:41 +0700
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
Subject: [PATCH v4 12/15] path.c: move some code out of strbuf_git_path_submodule()
Date:   Sat, 18 Feb 2017 20:33:00 +0700
Message-Id: <20170218133303.3682-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170218133303.3682-1-pclouds@gmail.com>
References: <20170217140436.17336-1-pclouds@gmail.com>
 <20170218133303.3682-1-pclouds@gmail.com>
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

