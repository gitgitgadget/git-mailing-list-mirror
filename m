Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E62020136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755034AbdBPLuO (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:50:14 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34844 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755022AbdBPLuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:50:11 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so1486107pfx.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ur3Q5FNV10I5w3E8FzAceEjR9hNHAnCX+Hi7BALXsog=;
        b=XQRGH5eR2eW4rsJI8OcKLxvHw84OEBmX3Ra6uP8natSGnOQs9AYis7uaszuxtFb/3r
         P7q76QY8BnRDcf2FRzhLYPRcRbXJ9SIpG+FfnGuw5OrVtvNM4GythdUmJgmbqbQ6FKWi
         zZAY0qB6xhp3eqLI0+Kz4zqqJiETv6UaaBs+Py9ATPmKdYTXDaM5s1rQJPpK4UK7uUNM
         JHD8sizpt1RlveZXnqv/wQWwNnpOFa8X/ZoamvkB4Y86yLPQh+KNi9m9m64nIckM8nBd
         f6nApWHaRMYbSiOQseOUHnELN6kPB1gH8/MuFO7E0R7nKupKdhBoKLrAewGzByMeLIdO
         rp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ur3Q5FNV10I5w3E8FzAceEjR9hNHAnCX+Hi7BALXsog=;
        b=B74y23j3g+ftzWz/OdxSh7llh8fzRXkK/jr9EV4GhOUlYXGn41l2mKqgxYISIz3Mv1
         x8QMHAVLNimkdc3VsyU2JxiRyl91x6riUWa5FYLdpGQoB6DmkE0ugrghtz+zZUC1jrQg
         62JRYJ8K+p4MK8WOgzMWkL5Q1GMFeZ9iYLaLfLGxNY8TJ6YvSGKrx2TVEnnfh/ZAlBpq
         iTPYyVrVmsMLrANRM3FyxspCEriGYCuTGDgJlC8FPDFpjyb+KHHEBZAdNYkCzwDPM4is
         waLZMOco4hgAG//BwWqs8pBCPGq3FQtQZCVSIyaWgijlaBCrk9pkIshoylNts4JHOux6
         2hUQ==
X-Gm-Message-State: AMke39nnTFYR1jO4aUP2O1u2vEQuvxB6EOiP2sLfH95wfAFFORMEcF6REfiZzapw8dGdaA==
X-Received: by 10.98.1.213 with SMTP id 204mr2132986pfb.61.1487245806090;
        Thu, 16 Feb 2017 03:50:06 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id z77sm13334526pfk.47.2017.02.16.03.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:50:05 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:50:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 13/16] path.c: move some code out of strbuf_git_path_submodule()
Date:   Thu, 16 Feb 2017 18:48:15 +0700
Message-Id: <20170216114818.6080-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170216114818.6080-1-pclouds@gmail.com>
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

