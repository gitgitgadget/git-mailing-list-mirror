Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35F081F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfBULAk (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:00:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42284 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBULAk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:00:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id n74so13577976pfi.9
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZ8PV/fscPbnoSz795aNsuu2RqpozxBHsEzofZr6EbU=;
        b=TIbfFbY2ohK0N/qfmhsfScoCEF5gO8TGsglKPRz/TZWlZpNhfw15rKlGx6f0NJpPuP
         HHnMzRLTk3EbGTwB39oAiPQEPQW+vxQQ9q8pTId5B/AXP+bpzkTk0+pkV+c3/ynnPb4s
         rmSZGf2ypSM9LgtApNjxZs4Uq+1A13AKDLxvrvgWiUzX1K5vLwa1PfrTkD48GcYty8km
         gCxDMNz75TH1NQIz5SIGnzLRTl5gVyLtuEGkqhwWpP/pd9Y6qK5Hs40rlTB2HBYjtsav
         nsY3/aEzoHhenM7EmJ395PKTWDxkkzDFZpw8eCWxPq9ka/lqchrVBPLpFlUi9ln1ldG+
         JIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZ8PV/fscPbnoSz795aNsuu2RqpozxBHsEzofZr6EbU=;
        b=f8Z6j2KQDLh58fmiDPuAr2h2yElK4wx7ioQG0vFx0OTQPVPsrM9m/msVf19d9+qgDs
         Zg21ntnGqeULyRoXdGv4HxkNsYPIsZAsDYzV9oAvc4/V+IeSB6z1ezYQ21jDITsBWHB9
         MgEHR2yruyWSkAh9UJ4LJsMoOxMCnE0Kb9mSuOR0nbNCGaoC1JqkxwP1OxntgA4T341Q
         d+1QhvizBAExa9syvoor/hfPx3zKOB+YUi18RoiC6iENXU0/enF8N/mgEjmFyH8rK54a
         4bZ2PFSMi/IV8QoGFHqwwOLsZ+a14XLhaTz6p2xpprtZLz8yK+yN+tH4Z7/lnnZe0Bem
         ldRA==
X-Gm-Message-State: AHQUAubTf+S7qv6cqzSjCZtJfzF/tCviYN4RrzqKRbVlOQlN0Qjegx9D
        3mWx3O4aivz4u7NxnIfLn4Y=
X-Google-Smtp-Source: AHgI3IatjbzaveBGJZPELBaUA8scAi8GFkkdbA8trxXIFl3zM1UnCw+Yz4dBiFdCgCtx64lAs/KCFw==
X-Received: by 2002:a63:d84b:: with SMTP id k11mr34126614pgj.142.1550746839246;
        Thu, 21 Feb 2019 03:00:39 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l10sm37067966pfc.90.2019.02.21.03.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:00:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:00:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     hi-angel@yandex.ru
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] worktree add: sanitize worktree names
Date:   Thu, 21 Feb 2019 18:00:26 +0700
Message-Id: <20190221110026.23135-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <1550500586.2865.0@yandex.ru>
References: <1550500586.2865.0@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Worktree names are based on $(basename $GIT_WORK_TREE). They aren't
significant until 3a3b9d8cde (refs: new ref types to make per-worktree
refs visible to all worktrees - 2018-10-21), where worktree name could
be part of a refname and must follow refname rules.

Update 'worktree add' code to remove special characters to follow
these rules. The code could replace chars with '-' more than
necessary, but it keeps the code simple. In the future the user will
be able to specify the worktree name by themselves if they're not
happy with this dumb character substitution.

Reported-by: hi-angel@yandex.ru
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c      | 47 ++++++++++++++++++++++++++++++++++++++++-
 t/t2025-worktree-add.sh |  5 +++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3f9907fcc9..ff36838a33 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -262,6 +262,46 @@ static void validate_worktree_add(const char *path, const struct add_opts *opts)
 	free_worktrees(worktrees);
 }
 
+/*
+ * worktree name is part of refname and has to pass
+ * check_refname_component(). Remove unallowed characters to make it
+ * valid.
+ */
+static void sanitize_worktree_name(struct strbuf *name)
+{
+	int i;
+
+	/* no ending with .lock */
+	if (ends_with(name->buf, ".lock"))
+		strbuf_remove(name, name->len - strlen(".lock"),
+			      strlen(".lock"));
+
+	/*
+	 * All special chars replaced with dashes. See
+	 * check_refname_component() for reference.
+	 */
+	for (i = 0; i < name->len; i++) {
+		if (strchr(":?[]\\~ \t@{}*/.", name->buf[i]))
+			name->buf[i] = '-';
+	}
+
+	/* remove consecutive dashes, leading or trailing dashes */
+	for (i = 0; i < name->len; i++) {
+		while (name->buf[i] == '-' &&
+		       (i == 0 ||
+			i == name->len - 1 ||
+			(i < name->len - 1 && name->buf[i + 1] == '-')))
+			strbuf_remove(name, i, 1);
+	}
+
+	/* last resort, should never ever happen in practice */
+	if (name->len == 0)
+		strbuf_addstr(name, "worktree");
+
+	if (check_refname_format(name->buf, REFNAME_ALLOW_ONELEVEL))
+		BUG("worktree name '%s' is not a valid refname", name->buf);
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -275,6 +315,7 @@ static int add_worktree(const char *path, const char *refname,
 	struct strbuf symref = STRBUF_INIT;
 	struct commit *commit = NULL;
 	int is_branch = 0;
+	struct strbuf sb_name = STRBUF_INIT;
 
 	validate_worktree_add(path, opts);
 
@@ -290,7 +331,10 @@ static int add_worktree(const char *path, const char *refname,
 		die(_("invalid reference: %s"), refname);
 
 	name = worktree_basename(path, &len);
-	git_path_buf(&sb_repo, "worktrees/%.*s", (int)(path + len - name), name);
+	strbuf_add(&sb_name, name, path + len - name);
+	sanitize_worktree_name(&sb_name);
+	name = sb_name.buf;
+	git_path_buf(&sb_repo, "worktrees/%s", name);
 	len = sb_repo.len;
 	if (safe_create_leading_directories_const(sb_repo.buf))
 		die_errno(_("could not create leading directories of '%s'"),
@@ -415,6 +459,7 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_release(&symref);
 	strbuf_release(&sb_repo);
 	strbuf_release(&sb_git);
+	strbuf_release(&sb_name);
 	return ret;
 }
 
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 286bba35d8..0d465adb54 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -570,4 +570,9 @@ test_expect_success '"add" an existing locked but missing worktree' '
 	git worktree add --force --force --detach gnoo
 '
 
+test_expect_success 'sanitize generated worktree name' '
+	git worktree add --detach ".  weird*..?.lock" &&
+	test -d .git/worktrees/weird
+'
+
 test_done
-- 
2.21.0.rc1.337.gdf7f8d0522

