Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B51F20136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934170AbdBQOGW (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:06:22 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35211 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934043AbdBQOGU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:06:20 -0500
Received: by mail-pg0-f68.google.com with SMTP id y6so3940501pgy.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ur3Q5FNV10I5w3E8FzAceEjR9hNHAnCX+Hi7BALXsog=;
        b=SOLC0XEkfwQFYAfiVpzgPem28X4gv6e1lGbCrywUpjuJPfis+v1PbkiSlwi9iTCwLm
         ODm5kpyOzsRJwRfttGZmvPGmCcMjAe5ZLe4U4c6ltpXWl4cM3FZRBiny24SPuRR3G/Tf
         lhFIdEludnk96rY2+vDkZGzBszKq6gNKRJ8baU1nd5eT+1dKBwUN8S/DxKKpoyiSbn+h
         9sopCMIICtrAJfjOBpl2nc4DHKiBffuKPO0AlW+z7ZK8/TmWW/Kmh/5Bju3LYZR8lm+t
         0IBEPMlvRhrD7fxxFSXnyeyyDCImJt9UsmU3hON9B4fYwPYdMfb4szjuW/nKgafXyViN
         BinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ur3Q5FNV10I5w3E8FzAceEjR9hNHAnCX+Hi7BALXsog=;
        b=F1DGT90NYTJFZ5eQ5Rpw4mEO4/NKFcv2ox2sq9dijiVlT/7ttv0NttMIrp35xDBFGf
         2/wbObdFh0Q5f3T60r4SaxU/zyPFPSWAqbiWh38VJo32+oeIk6as0J6AXL9NEj5eHQoa
         bE4tMfW57Nkez+EGwJa9j80WfMSddItUe7fAOLWvv1h0lmmQbBFnfoEs+/Yro441xcSx
         kfAEf7ilgzMjcHwzJrB3XF2kegO75lTvCg+MJXsGh9Ji69JMJFNYy52kMR69wAXrKR9t
         V2BRJ9Yjd1Vhp1sGl7Ox5UcG6vdBsn1B07ca46aOuiOOHlNEqBzys/ANiKR7KLuur5V8
         2CCg==
X-Gm-Message-State: AMke39mYWwKWKMtgxnPoKrxv+3z5zqoUmUoD5JaazhxJaqQxsgKZ66jZkSJfDOTa870mHg==
X-Received: by 10.98.37.132 with SMTP id l126mr9706199pfl.45.1487340380084;
        Fri, 17 Feb 2017 06:06:20 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id c2sm20010963pfl.61.2017.02.17.06.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:06:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:06:14 +0700
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
Subject: [PATCH v3 13/16] path.c: move some code out of strbuf_git_path_submodule()
Date:   Fri, 17 Feb 2017 21:04:33 +0700
Message-Id: <20170217140436.17336-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217140436.17336-1-pclouds@gmail.com>
References: <20170216114818.6080-1-pclouds@gmail.com>
 <20170217140436.17336-1-pclouds@gmail.com>
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
index ece17315d..3ce589d55 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1335,3 +1335,34 @@ void prepare_submodule_repo_env(struct argv_array *out)
 	}
 	argv_array_push(out, "GIT_DIR=.git");
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
index 23d76682b..2728494ce 100644
--- a/submodule.h
+++ b/submodule.h
@@ -70,6 +70,7 @@ extern int push_unpushed_submodules(struct sha1_array *commits,
 				    int dry_run);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 int parallel_submodules(void);
+int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
-- 
2.11.0.157.gd943d85

