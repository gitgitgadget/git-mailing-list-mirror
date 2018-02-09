Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8439D1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbeBILCz (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:02:55 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35742 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbeBILCy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:02:54 -0500
Received: by mail-pl0-f66.google.com with SMTP id j19so1319184pll.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Q9vt2lQa6/dXEZd8O7Bsy//KlQunGl9BauY1lXxMzA=;
        b=EIjNnxoXF+uorqxXdYKAJRtgh/TuiCiPYSzStVhpQHuV0IEmLIwLhYxp70ttnDsFlC
         kq5Y5P8MxUVyq2oxE7eHU4TP6x81QAA45yao6brviM0j3qJo7ScOb2LneP7VgSxcdxgt
         FI0ykHhZpszvxFVOAcvsYGmC0Qb72mf7gOztgSsOiGsIbAcboKC4GdI72XdJf60/m5Yn
         Hj/rV1ohd3+nBfCdHAK2100oeL52wA7QnnbiOYKCH7riDCnAxR30+WMiD4beaoUYcM5x
         fhcRMRTxZc/XpH6bn69in1cSPT9BPAQ40RXwRUkJrQCqeTDL51t8ERaZtDmJUsuBXJwf
         ZAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Q9vt2lQa6/dXEZd8O7Bsy//KlQunGl9BauY1lXxMzA=;
        b=siimz2r3jbDrz9cfoM9Vfimw6b5+f+TgQ1CHAfpmtwm3mLg6lAfVoUXZFdqSMAEPmt
         IAGNUlg+0059Z6FCxl7/DTEa45BQO/2/g6EFBIY1t6RWN0W59Jtpql5NmfE0vGM1FBXs
         xCjCQ29ov4xoB9WCARXZUb9zAoODoiQ1ev2K4M8O3vODsQe2rtKuv1o09ZgzTb3VtQLr
         mefolsEP6bVwHHh+CVskVsl7hRQz4mFhzQSZZSsgb/cJQPMrDLFLQ0S/ZCkSJc/Qyw99
         x/owcmHsji9kiEkUhPGB4BeuanX4er6inkCVPa9I5D6UEHg0S+HEsnDuuAHDS6yKHBBn
         zDAQ==
X-Gm-Message-State: APf1xPABn7zCyUiOKAmxnI6DXpNxZ0/TG5ZAsu+sgFPH+3RY61IygC5X
        m3MwVlGoSEbPyzpGggxPSKxURA==
X-Google-Smtp-Source: AH8x227+pMyvhXItn1wei3kotFduOJ4aUPyFofGhBev3z046ofQzCi4koDYsqNOup7wCpdN8AXTV1g==
X-Received: by 2002:a17:902:4827:: with SMTP id s36-v6mr2256322pld.337.1518174173559;
        Fri, 09 Feb 2018 03:02:53 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id 184sm4939737pfg.87.2018.02.09.03.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:02:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:02:47 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 03/42] parse-options: let OPT__FORCE take optional flags argument
Date:   Fri,  9 Feb 2018 18:01:42 +0700
Message-Id: <20180209110221.27224-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--force option is most likely hidden from command line completion for
safety reasons. This is done by adding an extra flag
PARSE_OPT_NOCOMPLETE. Update OPT__FORCE() to accept additional
flags. Actual flag change comes later depending on individual
commands.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/add.c                | 2 +-
 builtin/branch.c             | 2 +-
 builtin/checkout-index.c     | 2 +-
 builtin/checkout.c           | 2 +-
 builtin/clean.c              | 2 +-
 builtin/fetch.c              | 2 +-
 builtin/mv.c                 | 2 +-
 builtin/notes.c              | 4 ++--
 builtin/pull.c               | 2 +-
 builtin/rm.c                 | 2 +-
 builtin/tag.c                | 2 +-
 builtin/update-server-info.c | 2 +-
 builtin/worktree.c           | 4 +++-
 parse-options.h              | 2 +-
 14 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index bf01d89e28..ac7c1c3277 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -294,7 +294,7 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL('i', "interactive", &add_interactive, N_("interactive picking")),
 	OPT_BOOL('p', "patch", &patch_interactive, N_("select hunks interactively")),
 	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
-	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files")),
+	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files"), 0),
 	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
 	OPT_BOOL(0, "renormalize", &add_renormalize, N_("renormalize EOL of tracked files (implies -u)")),
 	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
diff --git a/builtin/branch.c b/builtin/branch.c
index 8dcc2ed058..b5b62c08ba 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -615,7 +615,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
-		OPT__FORCE(&force, N_("force creation, move/rename, deletion")),
+		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), 0),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index b0e78b819d..a730f6a1aa 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -157,7 +157,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	struct option builtin_checkout_index_options[] = {
 		OPT_BOOL('a', "all", &all,
 			N_("check out all files in the index")),
-		OPT__FORCE(&force, N_("force overwrite of existing files")),
+		OPT__FORCE(&force, N_("force overwrite of existing files"), 0),
 		OPT__QUIET(&quiet,
 			N_("no warning for existing files and files not in index")),
 		OPT_BOOL('n', "no-create", &not_new,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c54c78df54..2a96358eb7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1118,7 +1118,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			    2),
 		OPT_SET_INT('3', "theirs", &opts.writeout_stage, N_("checkout their version for unmerged files"),
 			    3),
-		OPT__FORCE(&opts.force, N_("force checkout (throw away local modifications)")),
+		OPT__FORCE(&opts.force, N_("force checkout (throw away local modifications)"), 0),
 		OPT_BOOL('m', "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
 		OPT_BOOL(0, "overwrite-ignore", &opts.overwrite_ignore, N_("update ignored files (default)")),
 		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
diff --git a/builtin/clean.c b/builtin/clean.c
index 189e20628c..3c4ca9a2ff 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -909,7 +909,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("do not print names of files removed")),
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
-		OPT__FORCE(&force, N_("force")),
+		OPT__FORCE(&force, N_("force"), 0),
 		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
 		OPT_BOOL('d', NULL, &remove_directories,
 				N_("remove whole directories")),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7bbcd26faf..6a603174fb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -115,7 +115,7 @@ static struct option builtin_fetch_options[] = {
 		 N_("append to .git/FETCH_HEAD instead of overwriting")),
 	OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
 		   N_("path to upload pack on remote end")),
-	OPT__FORCE(&force, N_("force overwrite of local branch")),
+	OPT__FORCE(&force, N_("force overwrite of local branch"), 0),
 	OPT_BOOL('m', "multiple", &multiple,
 		 N_("fetch from multiple remotes")),
 	OPT_SET_INT('t', "tags", &tags,
diff --git a/builtin/mv.c b/builtin/mv.c
index cf3684d907..b88023a733 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -122,7 +122,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	struct option builtin_mv_options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT__DRY_RUN(&show_only, N_("dry run")),
-		OPT__FORCE(&force, N_("force move/rename even if target exists")),
+		OPT__FORCE(&force, N_("force move/rename even if target exists"), 0),
 		OPT_BOOL('k', NULL, &ignore_errors, N_("skip move/rename errors")),
 		OPT_END(),
 	};
diff --git a/builtin/notes.c b/builtin/notes.c
index 7c81761645..b52e71c73e 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -413,7 +413,7 @@ static int add(int argc, const char **argv, const char *prefix)
 			parse_reuse_arg},
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
-		OPT__FORCE(&force, N_("replace existing notes")),
+		OPT__FORCE(&force, N_("replace existing notes"), 0),
 		OPT_END()
 	};
 
@@ -484,7 +484,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	const char *rewrite_cmd = NULL;
 	struct option options[] = {
-		OPT__FORCE(&force, N_("replace existing notes")),
+		OPT__FORCE(&force, N_("replace existing notes"), 0),
 		OPT_BOOL(0, "stdin", &from_stdin, N_("read objects from stdin")),
 		OPT_STRING(0, "for-rewrite", &rewrite_cmd, N_("command"),
 			   N_("load rewriting config for <command> (implies "
diff --git a/builtin/pull.c b/builtin/pull.c
index 511dbbe0f6..652239aae9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -193,7 +193,7 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "upload-pack", &opt_upload_pack, N_("path"),
 		N_("path to upload pack on remote end"),
 		0),
-	OPT__FORCE(&opt_force, N_("force overwrite of local branch")),
+	OPT__FORCE(&opt_force, N_("force overwrite of local branch"), 0),
 	OPT_PASSTHRU('t', "tags", &opt_tags, NULL,
 		N_("fetch all tags and associated objects"),
 		PARSE_OPT_NOARG),
diff --git a/builtin/rm.c b/builtin/rm.c
index 4a2fcca27b..6e0c7f5ac6 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -242,7 +242,7 @@ static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__QUIET(&quiet, N_("do not list removed files")),
 	OPT_BOOL( 0 , "cached",         &index_only, N_("only remove from the index")),
-	OPT__FORCE(&force, N_("override the up-to-date check")),
+	OPT__FORCE(&force, N_("override the up-to-date check"), 0),
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
 				N_("exit with a zero status even if nothing matched")),
diff --git a/builtin/tag.c b/builtin/tag.c
index a7e6a5b0f2..98d3956bbe 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -391,7 +391,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			N_("how to strip spaces and #comments from message")),
 		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
 					N_("use another key to sign the tag")),
-		OPT__FORCE(&force, N_("replace the tag if exists")),
+		OPT__FORCE(&force, N_("replace the tag if exists"), 0),
 		OPT_BOOL(0, "create-reflog", &create_reflog, N_("create a reflog")),
 
 		OPT_GROUP(N_("Tag listing options")),
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index 873070e517..4321a34456 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -12,7 +12,7 @@ int cmd_update_server_info(int argc, const char **argv, const char *prefix)
 {
 	int force = 0;
 	struct option options[] = {
-		OPT__FORCE(&force, N_("update the info files from scratch")),
+		OPT__FORCE(&force, N_("update the info files from scratch"), 0),
 		OPT_END()
 	};
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7cef5b120b..4d3422f62e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -365,7 +365,9 @@ static int add(int ac, const char **av, const char *prefix)
 	const char *branch;
 	const char *opt_track = NULL;
 	struct option options[] = {
-		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
+		OPT__FORCE(&opts.force,
+			   N_("checkout <branch> even if already checked out in other worktree"),
+			   0),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
 			   N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
diff --git a/parse-options.h b/parse-options.h
index 05a6839019..3c32401736 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -248,7 +248,7 @@ extern int parse_opt_passthru_argv(const struct option *, const char *, int);
 	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, N_("be more quiet"), \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
 #define OPT__DRY_RUN(var, h)  OPT_BOOL('n', "dry-run", (var), (h))
-#define OPT__FORCE(var, h)    OPT_COUNTUP('f', "force",   (var), (h))
+#define OPT__FORCE(var, h, f) OPT_COUNTUP_F('f', "force",   (var), (h), (f))
 #define OPT__ABBREV(var)  \
 	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
 	  N_("use <n> digits to display SHA-1s"),	\
-- 
2.16.1.207.gedba492059

