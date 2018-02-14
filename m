Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37241F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162584AbeBNTCL (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:02:11 -0500
Received: from mail-yw0-f201.google.com ([209.85.161.201]:36835 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162565AbeBNTBz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:55 -0500
Received: by mail-yw0-f201.google.com with SMTP id w130so4925856ywa.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=glHKQ0bvVAt+7/PF2trem9ONQbj58N8M6jdAhZd2vc8=;
        b=K36nkEBvVWDTQzFcuV1mSTBBah24cKtjNqNYLc1Dw2+L2A9cWbcO/zU0yZZzdUB8S1
         qOnwiWMKW7GlmjJcmPYDm3EcWl2uQMm0zR3Vq7TqjECH2yE0rjfZzSxym91mZRB4Mnq0
         +Zi8n6dM5wqC63xSFD2H7muckAXWuQj3CFNCju9gxhJevRvL66xTXlpePTmpflETfmAk
         f8Sfn0hdahldGEQd0vWjizCwfKyl281plEVdlg0ckzVTgBXOxu3j+4XOzwBkozruA8T0
         xjQmwCnyhCm1tQqA5AVnKvpc9THAO1BzBHYt0NstP5RSdC6gDwfUl4ZeUCeCUw5sGE88
         ZHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=glHKQ0bvVAt+7/PF2trem9ONQbj58N8M6jdAhZd2vc8=;
        b=jpw5YApm350+DWbrmxQyaeSS4ZEK7ZX+gCsMfTTf2CVYOV/7dGqOd8rQYBJAS7Ken6
         oMQN74/fRRkn/arHHZg91rj8OYOWLQFVajY/MjyaLaycOvQjTHreQjYbxnu5G7G2cmjD
         rXTRrE4p2iOkdSrufgcNSBqrHlNgcprtthkV0UT3gidVTEj5/YDtND3boO7yk2YRbS1/
         BG/3udQ3fZwQIFZx8Wl/Jr267FriM4QhOv7t6OG2JtKLlonHBmgfLGPVRquj6GdkIKVo
         Be3kxNgVLhblTCaTdXii43PQFo/26uI1DyQc7fe4ZU82e8f7jy0kPNwXuVw8UwDYQh3d
         Kg6Q==
X-Gm-Message-State: APf1xPC1vTA47IrUKXvupAeQMGJSmn59x61rfBKKCQWiNU3VaWTlcyUp
        iKM91XHJkZ/Kf1sxaLL1FrFU+JPtvuTbYLm7mA6SYFVd5oMbMnCt45JI2B7dq8Z4aaGWPfy7i1I
        gfm/F931NSfscSkeU3+DTbocMmJsgquhYVLqiI4uiYO15TnmodWlBia494Q==
X-Google-Smtp-Source: AH8x226gTbloPUe6pgKWncJREE47t3JsWIXTMs2a23rLYQTnRFy3e5ZpP4vko1kjTmq+K67zgWJcVXtSRVA=
MIME-Version: 1.0
X-Received: by 10.37.211.145 with SMTP id e139mr3050586ybf.32.1518634914670;
 Wed, 14 Feb 2018 11:01:54 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:49 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-28-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 27/37] submodule: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 30 +++++++++++++++---------------
 submodule.h |  2 +-
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/submodule.c b/submodule.c
index cd18400e8..12a2503fd 100644
--- a/submodule.c
+++ b/submodule.c
@@ -590,7 +590,7 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		struct object_id *one, struct object_id *two,
 		unsigned dirty_submodule)
 {
-	const struct object_id *old = the_hash_algo->empty_tree, *new = the_hash_algo->empty_tree;
+	const struct object_id *old_oid = the_hash_algo->empty_tree, *new_oid = the_hash_algo->empty_tree;
 	struct commit *left = NULL, *right = NULL;
 	struct commit_list *merge_bases = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -605,9 +605,9 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		goto done;
 
 	if (left)
-		old = one;
+		old_oid = one;
 	if (right)
-		new = two;
+		new_oid = two;
 
 	cp.git_cmd = 1;
 	cp.dir = path;
@@ -630,7 +630,7 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 		argv_array_pushf(&cp.args, "--dst-prefix=%s%s/",
 				 o->b_prefix, path);
 	}
-	argv_array_push(&cp.args, oid_to_hex(old));
+	argv_array_push(&cp.args, oid_to_hex(old_oid));
 	/*
 	 * If the submodule has modified content, we will diff against the
 	 * work tree, under the assumption that the user has asked for the
@@ -638,7 +638,7 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	 * haven't yet been committed to the submodule yet.
 	 */
 	if (!(dirty_submodule & DIRTY_SUBMODULE_MODIFIED))
-		argv_array_push(&cp.args, oid_to_hex(new));
+		argv_array_push(&cp.args, oid_to_hex(new_oid));
 
 	prepare_submodule_repo_env(&cp.env_array);
 	if (start_command(&cp))
@@ -1578,8 +1578,8 @@ static void submodule_reset_index(const char *path)
  * pass NULL for old or new respectively.
  */
 int submodule_move_head(const char *path,
-			 const char *old,
-			 const char *new,
+			 const char *old_head,
+			 const char *new_head,
 			 unsigned flags)
 {
 	int ret = 0;
@@ -1600,7 +1600,7 @@ int submodule_move_head(const char *path,
 	else
 		error_code_ptr = NULL;
 
-	if (old && !is_submodule_populated_gently(path, error_code_ptr))
+	if (old_head && !is_submodule_populated_gently(path, error_code_ptr))
 		return 0;
 
 	sub = submodule_from_path(&null_oid, path);
@@ -1608,14 +1608,14 @@ int submodule_move_head(const char *path,
 	if (!sub)
 		die("BUG: could not get submodule information for '%s'", path);
 
-	if (old && !(flags & SUBMODULE_MOVE_HEAD_FORCE)) {
+	if (old_head && !(flags & SUBMODULE_MOVE_HEAD_FORCE)) {
 		/* Check if the submodule has a dirty index. */
 		if (submodule_has_dirty_index(sub))
 			return error(_("submodule '%s' has dirty index"), path);
 	}
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
-		if (old) {
+		if (old_head) {
 			if (!submodule_uses_gitfile(path))
 				absorb_git_dir_into_superproject("", path,
 					ABSORB_GITDIR_RECURSE_SUBMODULES);
@@ -1629,7 +1629,7 @@ int submodule_move_head(const char *path,
 			submodule_reset_index(path);
 		}
 
-		if (old && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
+		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
 			char *gitdir = xstrfmt("%s/modules/%s",
 				    get_git_common_dir(), sub->name);
 			connect_work_tree_and_git_dir(path, gitdir);
@@ -1658,9 +1658,9 @@ int submodule_move_head(const char *path,
 		argv_array_push(&cp.args, "-m");
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
-		argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
+		argv_array_push(&cp.args, old_head ? old_head : EMPTY_TREE_SHA1_HEX);
 
-	argv_array_push(&cp.args, new ? new : EMPTY_TREE_SHA1_HEX);
+	argv_array_push(&cp.args, new_head ? new_head : EMPTY_TREE_SHA1_HEX);
 
 	if (run_command(&cp)) {
 		ret = -1;
@@ -1668,7 +1668,7 @@ int submodule_move_head(const char *path,
 	}
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
-		if (new) {
+		if (new_head) {
 			child_process_init(&cp);
 			/* also set the HEAD accordingly */
 			cp.git_cmd = 1;
@@ -1677,7 +1677,7 @@ int submodule_move_head(const char *path,
 
 			prepare_submodule_repo_env(&cp.env_array);
 			argv_array_pushl(&cp.args, "update-ref", "HEAD",
-					 "--no-deref", new, NULL);
+					 "--no-deref", new_head, NULL);
 
 			if (run_command(&cp)) {
 				ret = -1;
diff --git a/submodule.h b/submodule.h
index b9b7ef003..9589f1312 100644
--- a/submodule.h
+++ b/submodule.h
@@ -117,7 +117,7 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 #define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
 extern int submodule_move_head(const char *path,
 			       const char *old,
-			       const char *new,
+			       const char *new_head,
 			       unsigned flags);
 
 /*
-- 
2.16.1.291.g4437f3f132-goog

