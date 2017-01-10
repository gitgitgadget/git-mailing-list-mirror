Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F322205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 11:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935879AbdAJL1z (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 06:27:55 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35174 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935155AbdAJL1y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 06:27:54 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so9680207pfa.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 03:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKge2qBbFNwgnHzaFG6V3zLzUgW4P9RXXt+XBeMqdMU=;
        b=vfPMEKoTRS/SxUKL/osyUUkOidGeT649W8Hwjd6fJ0CN060vBQGvx1ZAsAdSnPSzQs
         GXd6q3hXdbtVSo+GVO/5eoY0h2lbC7r4obkceTRaD2nSpSms0mJaTRxBGBzuyw5VXd5V
         Enq+ZE+jx8vTI2cWFdXhShUkFZkEe8jJJ7Rw5SLSaBXoJq48IPyS3gFSipuzLQe0uLBp
         Ued6sUIhckn1ve9dZuZG3usRy/LSOrs1hSpvPGe9XMN2HXC+8kr1H+6ExM7+3HGjh52n
         Cs7ghHQDhTYRXqv9CPLXzGuveUsKAD2hUmCz2Q2WEfKPgtohdtEgQGeSGso7hrqMvgkv
         q5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKge2qBbFNwgnHzaFG6V3zLzUgW4P9RXXt+XBeMqdMU=;
        b=r2WlKzNaVhVbVnuJRRbG/PxTgeVBcg+R0rb9f9Xa0wLGpX/fiC5lelj2zqTY8AmUck
         NDZZ5E8Pj9AA0jrjj9WQGzQVQQy1aD/beKCtYc9TNz5TxOadaPjTAcwlPdFT5AaIug41
         sYL9U0ZW2BE5IGQuK+2kxScQDtWrO/QVcLMoLpeceTvoEuNPKeCwEGqoBZjQrgHbp1+b
         PViUe4NVdaHiTOAGDt9WDqND1aPwc03m0uFQdPSFHYny1TPp3dsoHgppL3vYIkzlcMmd
         YNOc4+a3JXc2w7O4nUNmZXj3ssZ2rgDpAzUUjpHzgZ+xhrBM4NWm5s7t3EcmQ6TEi8ky
         vFyQ==
X-Gm-Message-State: AIkVDXL3VjE3dC0t42JPNr2O3spopDid7kIJeMX5EcE1ClsRwFaSAdg3OFlGT/pAIDAz+w==
X-Received: by 10.98.107.136 with SMTP id g130mr3230591pfc.20.1484047673530;
        Tue, 10 Jan 2017 03:27:53 -0800 (PST)
Received: from ash ([115.73.174.142])
        by smtp.gmail.com with ESMTPSA id u78sm4934913pfa.53.2017.01.10.03.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 03:27:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 10 Jan 2017 18:27:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
        Jens.Lehmann@web.de, larsxschneider@gmail.com, sbeller@google.com,
        mhagger@alum.mit.edu, max@max630.net,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 3/4] config: automatically migrate to new config layout when --worktree is used
Date:   Tue, 10 Jan 2017 18:25:23 +0700
Message-Id: <20170110112524.12870-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170110112524.12870-1-pclouds@gmail.com>
References: <20170110112524.12870-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not fun to ask the user to set extensions.worktreeConfig manually.
It's error-prone too. So we do it automatically whenever anybody sets a
per-worktree config with "git config" (support for builtin commands is
coming later).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-worktree.txt |  6 ++++++
 builtin/config.c               |  3 ++-
 worktree.c                     | 40 ++++++++++++++++++++++++++++++++++++++++
 worktree.h                     |  6 ++++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 329a673..f5aad0a 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -167,6 +167,12 @@ want to share to all working directories:
    you are sure you always use sparse checkout for all working
    directories.
 
+When `git config --worktree` is used to set a configuration variable
+in multiple working directory setup, `extensions.worktreeConfig` will
+be automatically set. The two variables `core.worktree` and
+`core.bare` if present will be moved to `config.worktree` of the main
+working tree.
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
diff --git a/builtin/config.c b/builtin/config.c
index 7d390af..9dafefd 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -533,7 +533,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (repository_format_worktree_config)
 			given_config_source.file = git_pathdup("config.worktree");
 		else if (worktrees[0] && worktrees[1]) {
-			die("BUG: migration is not supported yet");
+			migrate_worktree_config();
+			given_config_source.file = git_pathdup("config.worktree");
 		} else
 			given_config_source.file = git_pathdup("config");
 		free_worktrees(worktrees);
diff --git a/worktree.c b/worktree.c
index eb61212..d8c9d85 100644
--- a/worktree.c
+++ b/worktree.c
@@ -380,3 +380,43 @@ const struct worktree *find_shared_symref(const char *symref,
 
 	return existing;
 }
+
+void migrate_worktree_config(void)
+{
+	struct strbuf worktree_path = STRBUF_INIT;
+	struct strbuf main_path = STRBUF_INIT;
+	struct repository_format format;
+
+	assert(repository_format_worktree_config == 0);
+
+	strbuf_git_common_path(&worktree_path, "config.worktree");
+	strbuf_git_path(&main_path, "config");
+
+	read_repository_format(&format, main_path.buf);
+	assert(format.worktree_config == 0);
+
+	if (format.is_bare >= 0) {
+		git_config_set_in_file(worktree_path.buf,
+				       "core.bare", "true");
+		git_config_set_in_file(main_path.buf,
+				       "core.bare", NULL);
+	}
+	if (format.work_tree) {
+		git_config_set_in_file(worktree_path.buf,
+				       "core.worktree",
+				       format.work_tree);
+		git_config_set_in_file(main_path.buf,
+				       "core.worktree", NULL);
+	}
+
+	git_config_set_in_file(main_path.buf,
+			       "extensions.worktreeConfig", "true");
+	if (format.version == 0)
+		git_config_set_in_file(main_path.buf,
+				       "core.repositoryFormatVersion", "1");
+
+	repository_format_worktree_config = 1;
+
+	strbuf_release(&main_path);
+	strbuf_release(&worktree_path);
+}
diff --git a/worktree.h b/worktree.h
index d59ce1f..cf82676 100644
--- a/worktree.h
+++ b/worktree.h
@@ -76,4 +76,10 @@ extern const char *worktree_git_path(const struct worktree *wt,
 				     const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
+/*
+ * Called to add extensions.worktreeConfig to $GIT_DIR/config and move
+ * main worktree specific config variables to $GIT_DIR/config.worktree.
+ */
+extern void migrate_worktree_config(void);
+
 #endif
-- 
2.8.2.524.g6ff3d78

