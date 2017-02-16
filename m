Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A7972013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756256AbdBPAis (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:38:48 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33883 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756103AbdBPAid (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:38:33 -0500
Received: by mail-pf0-f178.google.com with SMTP id e4so799334pfg.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TUOLXw6cqDPRnLoCwDcMGql2vKRr0tnoqDLzJocr5qU=;
        b=fZtl2Gu+5ePA9tN47H4l6lizS2Mb3miNW/aGN1jmQj/qmk94Ay4NsjZsaGUbcaDHu0
         2MlkzcKcwQ/Qa/KrliUnyT3ioSdyexITNprFslxKyIsfogZIYWvYwTwkZhnPAnkOf49g
         PFb6n+BZdI7sMSKlpevqnJfCShWKBTFmT6gW48bwWksvcnu2vCxoonTmxrUIKc4kYu36
         YO1iNDNZoMzPiKEl20CJwQABxXkz5E/dYbdpT6TjvuCPIWI0LcB3xh+sQ3xVrC3QfvOW
         ST74xeHg10s5VVKmjGTe1Ky9dV0z+33TEj8v040QKJGyEi0cNgecU79/5S+yopEFXb15
         5Fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TUOLXw6cqDPRnLoCwDcMGql2vKRr0tnoqDLzJocr5qU=;
        b=OTTxkK/DnsvkHMnhcHr7DeaIrQi7RzZN0bpBdugka6k8+xwDw4l98k0+bpicZLgtZ/
         PDOgJ6d6y+J/JooleNQ8wgzEJyQRn0qoyu8tk3cesDq9xQQWtHuNd9FCZ1zLQq+87yML
         NKuBPMKgm6XaoQfVZBSIoAMPZwB76ZO1Meypgom8CwczeKt+m5u+5wGqnkCv03GY2Gat
         nU+3UvBxUDbhzruEz1ymOV980Q8dpTcZFSZH3YRZACxk6zX8PkoRSp2IdFPv8PkEGvBd
         rYu03Lx11M3sALUklQajFMwWKBp8Bo6QEu2dxSqFRmj9CXDcfuDkGGnI+XGcZ+FtCEiX
         NAYA==
X-Gm-Message-State: AMke39lRhpiW3lLYwQXR4lg91R9OGCkBUf+WqCZrUl1mUApyawCslnTX0S8SZC9+K/FTB4ae
X-Received: by 10.84.236.9 with SMTP id q9mr43479610plk.96.1487205512431;
        Wed, 15 Feb 2017 16:38:32 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2ca1:506:4965:89ed])
        by smtp.gmail.com with ESMTPSA id p14sm9536266pfl.75.2017.02.15.16.38.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:38:31 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/15] update submodules: add submodule_go_from_to
Date:   Wed, 15 Feb 2017 16:38:06 -0800
Message-Id: <20170216003811.18273-11-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170216003811.18273-1-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
 <20170216003811.18273-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later patches we introduce the options and flag for commands
that modify the working directory, e.g. git-checkout.

This piece of code will be used universally for
all these working tree modifications as it
* supports dry run to answer the question:
  "Is it safe to change the submodule to this new state?"
  e.g. is it overwriting untracked files or are there local
  changes that would be overwritten?
* supports a force flag that can be used for resetting
  the tree.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 submodule.h |   5 ++
 2 files changed, 156 insertions(+)

diff --git a/submodule.c b/submodule.c
index b262c5b0ad..84cc62f3bb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1250,6 +1250,157 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	return ret;
 }
 
+static int submodule_has_dirty_index(const struct submodule *sub)
+{
+	ssize_t len;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	int ret = 0;
+
+	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "diff-index", "--cached", "HEAD", NULL);
+	cp.no_stdin = 1;
+	cp.out = -1;
+	cp.dir = sub->path;
+	if (start_command(&cp))
+		die("could not recurse into submodule %s", sub->path);
+
+	len = strbuf_read(&buf, cp.out, 1024);
+	if (len > 2)
+		ret = 1;
+
+	close(cp.out);
+	if (finish_command(&cp))
+		die("could not recurse into submodule %s", sub->path);
+
+	strbuf_release(&buf);
+	return ret;
+}
+
+void submodule_clean_index(const char *path)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+
+	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
+	argv_array_pushl(&cp.args, "read-tree", "-u", "--reset", NULL);
+
+	argv_array_push(&cp.args, EMPTY_TREE_SHA1_HEX);
+
+	if (run_command(&cp))
+		die("could not clean submodule index");
+}
+
+/**
+ * Moves a submodule at a given path from a given head to another new head.
+ * For edge cases (a submodule coming into existence or removing a submodule)
+ * pass NULL for old or new respectively.
+ *
+ * TODO: move dryrun and forced to flags.
+ */
+int submodule_go_from_to(const char *path,
+			 const char *old,
+			 const char *new,
+			 int dry_run,
+			 int force)
+{
+	int ret = 0;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	const struct submodule *sub;
+
+	sub = submodule_from_path(null_sha1, path);
+
+	if (!sub)
+		die("BUG: could not get submodule information for '%s'", path);
+
+	if (!dry_run) {
+		if (old) {
+			if (!submodule_uses_gitfile(path))
+				absorb_git_dir_into_superproject("", path,
+					ABSORB_GITDIR_RECURSE_SUBMODULES);
+		} else {
+			struct strbuf sb = STRBUF_INIT;
+			strbuf_addf(&sb, "%s/modules/%s",
+				    get_git_common_dir(), sub->name);
+			connect_work_tree_and_git_dir(path, sb.buf);
+			strbuf_release(&sb);
+
+			/* make sure the index is clean as well */
+			submodule_clean_index(path);
+		}
+	}
+
+	if (old && !force) {
+		/* Check if the submodule has a dirty index. */
+		if (submodule_has_dirty_index(sub)) {
+			/* print a thing here? */
+			return -1;
+		}
+	}
+
+	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
+
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+
+	argv_array_pushf(&cp.args, "--super-prefix=%s/", path);
+	argv_array_pushl(&cp.args, "read-tree", NULL);
+
+	if (dry_run)
+		argv_array_push(&cp.args, "-n");
+	else
+		argv_array_push(&cp.args, "-u");
+
+	if (force)
+		argv_array_push(&cp.args, "--reset");
+	else
+		argv_array_push(&cp.args, "-m");
+
+	argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
+	argv_array_push(&cp.args, new ? new : EMPTY_TREE_SHA1_HEX);
+
+	if (run_command(&cp)) {
+		ret = -1;
+		goto out;
+	}
+
+	if (!dry_run) {
+		if (new) {
+			struct child_process cp1 = CHILD_PROCESS_INIT;
+			/* also set the HEAD accordingly */
+			cp1.git_cmd = 1;
+			cp1.no_stdin = 1;
+			cp1.dir = path;
+
+			argv_array_pushl(&cp1.args, "update-ref", "HEAD",
+					 new ? new : EMPTY_TREE_SHA1_HEX, NULL);
+
+			if (run_command(&cp1)) {
+				ret = -1;
+				goto out;
+			}
+		} else {
+			struct strbuf sb = STRBUF_INIT;
+
+			strbuf_addf(&sb, "%s/.git", path);
+			unlink_or_warn(sb.buf);
+			strbuf_release(&sb);
+
+			if (is_empty_dir(path))
+				rmdir_or_warn(path);
+		}
+	}
+out:
+	return ret;
+}
+
 static int find_first_merges(struct object_array *result, const char *path,
 		struct commit *a, struct commit *b)
 {
diff --git a/submodule.h b/submodule.h
index 46d9f0f293..3336607bfc 100644
--- a/submodule.h
+++ b/submodule.h
@@ -102,6 +102,11 @@ extern int push_unpushed_submodules(struct sha1_array *commits,
 extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 extern int parallel_submodules(void);
 
+extern int submodule_go_from_to(const char *path,
+				const char *old,
+				const char *new,
+				int dry_run, int force);
+
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
  * a submodule by clearing any repo-specific envirionment variables, but
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

