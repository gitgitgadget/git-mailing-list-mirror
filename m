Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCB32692B
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401566; cv=none; b=r6REppc5Ja72qc6sxx/K8F8FNwSpNKl7gZBEXSxFA1uI1btp1Fxei/VcfRwrNc2I2FvYoXjLYtS3DxKcwHYdVHyvy5zvIhilYzlMUKddSF+Ym/RNXLi+h/wGscawbzzjI2lNhI8ayCMVOrO1Giop3Abl6wYytP+afo60YFB1Uk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401566; c=relaxed/simple;
	bh=Jm+Jy+VZbEdgRncRZFMF8FV4QRTG5swdIazjOALEJVk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N6+YwFRTFdlav43DXkm9tj6rXH6LeWRyq3AZP3CUCh1GlJt0wYiedJV/MMI74muhFcKU2yPxuKFLXAhUe4VjLgchKdH3jh8e3aY1Qnx8RZtFKhitXiIlurqteUcmI8USvGjX1k1JqY2z5IkCo1w8Q99QVXHpKcTSs4Rc3fSY7v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5gNH7cQ; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5gNH7cQ"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c19d23b19so15375558c88.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777401563; x=1778006363; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdc13SioscLVSpbe6EqUjgeUMHmGlh1vPjjavadQaHM=;
        b=Q5gNH7cQ6Kj1+6+Xio23kwJzRceHMVl1fPzUM1c4yZM4F36S+w8XxMwB3cLu9Q9iBR
         ubTLwmI6offexbQUo0SKhsXeJ1k8V6T3Vqdq7P6t6ex9295jhL3sfGYdYYiEK++PeW62
         EBqbpsfkQtburJjnt2jsVk6VSf9sSCQYFpqxb7N77IYQhduBh+4AGJGmaU+mhzrAkX7Q
         FniuOixP4vcACpP0r33eP8yA4N6Fmnw3hyGc1arEU3LAPsbl7q4NNgv/tw2S5/VZ6ILm
         9aLBVQvG3Apd2dcL/yaPBb6gWyhKL4CG8P8cHVmPN9T/dGfU/ncsBuu6MY7+bZHN2nP/
         AGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777401563; x=1778006363;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rdc13SioscLVSpbe6EqUjgeUMHmGlh1vPjjavadQaHM=;
        b=LEDYbvk2Ej0qCJ82FOiGq7k/mbIMySocDXSDXzE2Tbm3CoejT9ECaqAy7oKK4NJCfo
         sEL8KhplkFFR+Je3MdKy2i7lATlZ50PhklOHtbzoBhbeY+YYSAQQFNdjYWeqZ+iNqbVu
         /EcWbN/QL5v8MpqprjviKogZuX6IZe/uvlqzYjy2jeWS6OeKUh0dV1WXqk4xdUYFAGoO
         1zxoR6NCWzS/V04IYYxWl+g4W1sjzgO/uCf8wcwYVbW5b84o8LxZK6d6iOV67kDh3FnO
         IePzTWeaRXbq7/6XKXJFOwH6Lyly4FcWeIz7HwhzbagW/9JEXGmqlJOGG9nX83atfF7l
         iB5Q==
X-Gm-Message-State: AOJu0YzwZmeXuj+lAu8VSX31VJ+ABsGIJKqYpsm6kJJVacBvr+Nfi2u8
	PRa1IUe2Aed4VQq1y3ABE5jWPgmpx7HXWLiECT7TCLu1KsiAumthJNZDocuJ1Jj/
X-Gm-Gg: AeBDievIE8L/D11QN+S0Y7k/BMD55jmFKCk0w+ZFw3DjDWh7eNYT/72wvkHIHTU9BAH
	01/6QhFLCp+4UpwIw5FNI+UCL7WXCcEVi/Hu1dSJAQOwysOXkoKEbWJqxXbhNVTFfR6P7DJIZ6A
	heL8DamK4zemS/NfqkKMQfLkosZA4yqVxTrKHPJ7NCxRadKAWyL9RBnZ5mRZPaakyigvux6fQpE
	YQGGckVRD9KpRbRfNjnQd79atq1uhGa6nsDSydh/r3Q7jER7h54STvF2JYcUFja6JStJHUWsUAp
	RBnxhsc6XejgT4oreEBLLJNX2AoPt2GNGKaPYE775eaSz7RdYC9n+UIaTRBYSebEG3M9ShepVWQ
	Ya48zv/L8tjJrsfpqkz9tuGyqWwerYV71LFWb6BGIoL39MwakE2s1PRxX4f0tghBKsqQRQke7jY
	FDo+WbIqyRVx24EV2q7neNV3rwaZWYR7DyK+nHWHv+I5Nddug=
X-Received: by 2002:a05:7022:6b98:b0:12d:ce34:3f97 with SMTP id a92af1059eb24-12de2a69acfmr165428c88.31.1777401562984;
        Tue, 28 Apr 2026 11:39:22 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.83.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd9b1bfcsm2588587c88.12.2026.04.28.11.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 11:39:22 -0700 (PDT)
Message-Id: <07d25fda91a1bbb3e13005d5462d1879303b15c0.1777401552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
References: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
	<pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 18:39:12 +0000
Subject: [PATCH v16 5/5] checkout -m: autostash when switching branches
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When switching branches with "git checkout -m", the attempted merge
of local modifications may cause conflicts with the changes made on
the other branch, which the user may not want to (or may not be able
to) resolve right now.  Because there is no easy way to recover from
this situation, we discouraged users from using "checkout -m" unless
they are certain their changes are trivial and within their ability
to resolve conflicts.

Teach the -m flow to create a temporary stash before switching and
reapply it after.  On success, the stash is silently applied and
the list of locally modified paths is shown, same as a successful
"git checkout" without "-m".

If reapplying causes conflicts, the stash is kept and the user is
told they can resolve and run "git stash drop", or run "git reset
--hard" and later "git stash pop" to recover their changes.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-checkout.adoc |  55 ++++++-----
 Documentation/git-switch.adoc   |  36 +++----
 builtin/checkout.c              | 161 ++++++++++++++------------------
 sequencer.c                     |  14 ++-
 t/t3420-rebase-autostash.sh     |  16 ++--
 t/t7201-co.sh                   |  71 +++++++++++++-
 t/t7600-merge.sh                |   3 +-
 xdiff-interface.c               |  12 +++
 xdiff-interface.h               |   1 +
 9 files changed, 219 insertions(+), 150 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 43ccf47cf6..a8b3b8c2e2 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -251,20 +251,19 @@ working tree, by copying them from elsewhere, extracting a tarball, etc.
 	are different between the current branch and the branch to
 	which you are switching, the command refuses to switch
 	branches in order to preserve your modifications in context.
-	However, with this option, a three-way merge between the current
-	branch, your working tree contents, and the new branch
-	is done, and you will be on the new branch.
-+
-When a merge conflict happens, the index entries for conflicting
-paths are left unmerged, and you need to resolve the conflicts
-and mark the resolved paths with `git add` (or `git rm` if the merge
-should result in deletion of the path).
+	With this option, the conflicting local changes are
+	automatically stashed before the switch and reapplied
+	afterwards.  If the local changes do not overlap with the
+	differences between branches, the switch proceeds without
+	stashing.  If reapplying the stash results in conflicts, the
+	entry is saved to the stash list.  Resolve the conflicts
+	and run `git stash drop` when done, or clear the working
+	tree (e.g. with `git reset --hard`) before running `git stash
+	pop` later to re-apply your changes.
 +
 When checking out paths from the index, this option lets you recreate
 the conflicted merge in the specified paths.  This option cannot be
 used when checking out paths from a tree-ish.
-+
-When switching branches with `--merge`, staged changes may be lost.
 
 `--conflict=<style>`::
 	The same as `--merge` option above, but changes the way the
@@ -578,38 +577,36 @@ $ git checkout mytopic
 error: You have local changes to 'frotz'; not switching branches.
 ------------
 
-You can give the `-m` flag to the command, which would try a
-three-way merge:
+You can give the `-m` flag to the command, which will carry your local
+changes to the new branch:
 
 ------------
 $ git checkout -m mytopic
-Auto-merging frotz
+Applied autostash.
+Switched to branch 'mytopic'
+The following paths have local changes:
+M	frotz
 ------------
 
-After this three-way merge, the local modifications are _not_
+After the switch, the local modifications are reapplied and are _not_
 registered in your index file, so `git diff` would show you what
 changes you made since the tip of the new branch.
 
 === 3. Merge conflict
 
-When a merge conflict happens during switching branches with
-the `-m` option, you would see something like this:
+When the `--merge` (`-m`) option is given and the local changes
+overlap with the changes in the branch we're switching to, the
+changes are stashed and reapplied after the switch.  If this
+process results in conflicts, the stash entry is saved and a
+message is printed:
 
 ------------
 $ git checkout -m mytopic
-Auto-merging frotz
-ERROR: Merge conflict in frotz
-fatal: merge program failed
-------------
-
-At this point, `git diff` shows the changes cleanly merged as in
-the previous example, as well as the changes in the conflicted
-files.  Edit and resolve the conflict and mark it resolved with
-`git add` as usual:
-
-------------
-$ edit frotz
-$ git add frotz
+Your local changes are stashed, however applying them
+resulted in conflicts.  You can either resolve the conflicts
+and then discard the stash with "git stash drop", or, if you
+do not want to resolve them now, run "git reset --hard" and
+apply the local changes later by running "git stash pop".
 ------------
 
 CONFIGURATION
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 87707e9265..d6c4f229a5 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -123,18 +123,19 @@ variable.
 
 `-m`::
 `--merge`::
-	If you have local modifications to one or more files that are
-	different between the current branch and the branch to which
-	you are switching, the command refuses to switch branches in
-	order to preserve your modifications in context.  However,
-	with this option, a three-way merge between the current
-	branch, your working tree contents, and the new branch is
-	done, and you will be on the new branch.
-+
-When a merge conflict happens, the index entries for conflicting
-paths are left unmerged, and you need to resolve the conflicts
-and mark the resolved paths with `git add` (or `git rm` if the merge
-should result in deletion of the path).
+	If you have local modifications to one or more files that
+	are different between the current branch and the branch to
+	which you are switching, the command normally refuses to
+	switch branches in order to preserve your modifications in
+	context.  However, with this option, the conflicting local
+	changes are automatically stashed before the switch and
+	reapplied afterwards.  If the local changes do not overlap
+	with the differences between branches, the switch proceeds
+	without stashing.  If reapplying the stash results in
+	conflicts, the entry is saved to the stash list.  Resolve
+	the conflicts and run `git stash drop` when done, or clear
+	the working tree (e.g. with `git reset --hard`) before
+	running `git stash pop` later to re-apply your changes.
 
 `--conflict=<style>`::
 	The same as `--merge` option above, but changes the way the
@@ -217,15 +218,18 @@ $ git switch mytopic
 error: You have local changes to 'frotz'; not switching branches.
 ------------
 
-You can give the `-m` flag to the command, which would try a three-way
-merge:
+You can give the `-m` flag to the command, which will carry your local
+changes to the new branch:
 
 ------------
 $ git switch -m mytopic
-Auto-merging frotz
+Applied autostash.
+Switched to branch 'mytopic'
+The following paths have local changes:
+M	frotz
 ------------
 
-After this three-way merge, the local modifications are _not_
+After the switch, the local modifications are reapplied and are _not_
 registered in your index file, so `git diff` would show you what
 changes you made since the tip of the new branch.
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c80c62b37b..3e9c456fad 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -17,7 +17,6 @@
 #include "merge-ll.h"
 #include "lockfile.h"
 #include "mem-pool.h"
-#include "merge-ort-wrappers.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
@@ -30,6 +29,7 @@
 #include "repo-settings.h"
 #include "resolve-undo.h"
 #include "revision.h"
+#include "sequencer.h"
 #include "setup.h"
 #include "submodule.h"
 #include "symlinks.h"
@@ -99,6 +99,8 @@ struct checkout_opts {
 	.auto_advance = 1, \
 }
 
+#define MERGE_WORKING_TREE_UNPACK_FAILED (-2)
+
 struct branch_info {
 	char *name; /* The short name used */
 	char *path; /* The full name of a real branch */
@@ -753,9 +755,9 @@ static void setup_branch_path(struct branch_info *branch)
 	branch->path = strbuf_detach(&buf, NULL);
 }
 
-static void init_topts(struct unpack_trees_options *topts, int merge,
+static void init_topts(struct unpack_trees_options *topts,
 		       int show_progress, int overwrite_ignore,
-		       struct commit *old_commit)
+		       bool quiet)
 {
 	memset(topts, 0, sizeof(*topts));
 	topts->head_idx = -1;
@@ -767,7 +769,7 @@ static void init_topts(struct unpack_trees_options *topts, int merge,
 	topts->initial_checkout = is_index_unborn(the_repository->index);
 	topts->update = 1;
 	topts->merge = 1;
-	topts->quiet = merge && old_commit;
+	topts->quiet = quiet;
 	topts->verbose_update = show_progress;
 	topts->fn = twoway_merge;
 	topts->preserve_ignored = !overwrite_ignore;
@@ -776,6 +778,7 @@ static void init_topts(struct unpack_trees_options *topts, int merge,
 static int merge_working_tree(const struct checkout_opts *opts,
 			      struct branch_info *old_branch_info,
 			      struct branch_info *new_branch_info,
+			      bool quiet,
 			      int *writeout_error)
 {
 	int ret;
@@ -826,8 +829,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		}
 
 		/* 2-way merge to the new branch */
-		init_topts(&topts, opts->merge, opts->show_progress,
-			   opts->overwrite_ignore, old_branch_info->commit);
+		init_topts(&topts, opts->show_progress,
+			   opts->overwrite_ignore, quiet);
 		init_checkout_metadata(&topts.meta, new_branch_info->refname,
 				       new_branch_info->commit ?
 				       &new_branch_info->commit->object.oid :
@@ -853,90 +856,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		ret = unpack_trees(2, trees, &topts);
 		clear_unpack_trees_porcelain(&topts);
 		if (ret == -1) {
-			/*
-			 * Unpack couldn't do a trivial merge; either
-			 * give up or do a real merge, depending on
-			 * whether the merge flag was used.
-			 */
-			struct tree *work;
-			struct tree *old_tree;
-			struct merge_options o;
-			struct strbuf sb = STRBUF_INIT;
-			struct strbuf old_commit_shortname = STRBUF_INIT;
-
-			if (!opts->merge) {
-				rollback_lock_file(&lock_file);
-				return 1;
-			}
-
-			/*
-			 * Without old_branch_info->commit, the below is the same as
-			 * the two-tree unpack we already tried and failed.
-			 */
-			if (!old_branch_info->commit) {
-				rollback_lock_file(&lock_file);
-				return 1;
-			}
-			old_tree = repo_get_commit_tree(the_repository,
-							old_branch_info->commit);
-
-			if (repo_index_has_changes(the_repository, old_tree, &sb))
-				die(_("cannot continue with staged changes in "
-				      "the following files:\n%s"), sb.buf);
-			strbuf_release(&sb);
-
-			/* Do more real merge */
-
-			/*
-			 * We update the index fully, then write the
-			 * tree from the index, then merge the new
-			 * branch with the current tree, with the old
-			 * branch as the base. Then we reset the index
-			 * (but not the working tree) to the new
-			 * branch, leaving the working tree as the
-			 * merged version, but skipping unmerged
-			 * entries in the index.
-			 */
-
-			add_files_to_cache(the_repository, NULL, NULL, NULL, 0,
-					0, 0);
-			init_ui_merge_options(&o, the_repository);
-			o.verbosity = 0;
-			work = write_in_core_index_as_tree(the_repository,
-							   the_repository->index);
-
-			ret = reset_tree(new_tree,
-					 opts, 1,
-					 writeout_error, new_branch_info);
-			if (ret) {
-				rollback_lock_file(&lock_file);
-				return ret;
-			}
-			o.ancestor = old_branch_info->name;
-			if (!old_branch_info->name) {
-				strbuf_add_unique_abbrev(&old_commit_shortname,
-							 &old_branch_info->commit->object.oid,
-							 DEFAULT_ABBREV);
-				o.ancestor = old_commit_shortname.buf;
-			}
-			o.branch1 = new_branch_info->name;
-			o.branch2 = "local";
-			o.conflict_style = opts->conflict_style;
-			ret = merge_ort_nonrecursive(&o,
-						     new_tree,
-						     work,
-						     old_tree);
-			if (ret < 0)
-				die(NULL);
-			ret = reset_tree(new_tree,
-					 opts, 0,
-					 writeout_error, new_branch_info);
-			strbuf_release(&o.obuf);
-			strbuf_release(&old_commit_shortname);
-			if (ret) {
-				rollback_lock_file(&lock_file);
-				return ret;
-			}
+			rollback_lock_file(&lock_file);
+			return MERGE_WORKING_TREE_UNPACK_FAILED;
 		}
 	}
 
@@ -1181,6 +1102,10 @@ static int switch_branches(const struct checkout_opts *opts,
 	struct object_id rev;
 	int flag, writeout_error = 0;
 	int do_merge = 1;
+	int created_autostash = 0;
+	struct strbuf old_commit_shortname = STRBUF_INIT;
+	struct strbuf autostash_msg = STRBUF_INIT;
+	const char *stash_label_base = NULL;
 
 	trace2_cmd_mode("branch");
 
@@ -1218,11 +1143,49 @@ static int switch_branches(const struct checkout_opts *opts,
 			do_merge = 0;
 	}
 
+	if (old_branch_info.name) {
+		stash_label_base = old_branch_info.name;
+	} else if (old_branch_info.commit) {
+		strbuf_add_unique_abbrev(&old_commit_shortname,
+					 &old_branch_info.commit->object.oid,
+					 DEFAULT_ABBREV);
+		stash_label_base = old_commit_shortname.buf;
+	}
+
 	if (do_merge) {
-		ret = merge_working_tree(opts, &old_branch_info, new_branch_info, &writeout_error);
+		ret = merge_working_tree(opts, &old_branch_info, new_branch_info,
+					 opts->merge, &writeout_error);
+		if (ret == MERGE_WORKING_TREE_UNPACK_FAILED && opts->merge) {
+			strbuf_addf(&autostash_msg,
+				    "autostash while switching to '%s'",
+				    new_branch_info->name);
+			create_autostash_ref(the_repository,
+					     "CHECKOUT_AUTOSTASH_HEAD",
+					     autostash_msg.buf, true);
+			created_autostash = 1;
+			ret = merge_working_tree(opts, &old_branch_info, new_branch_info,
+						 false, &writeout_error);
+		}
+		if (created_autostash) {
+			if (opts->conflict_style >= 0) {
+				struct strbuf cfg = STRBUF_INIT;
+				strbuf_addf(&cfg, "merge.conflictStyle=%s",
+					    conflict_style_name(opts->conflict_style));
+				git_config_push_parameter(cfg.buf);
+				strbuf_release(&cfg);
+			}
+			apply_autostash_ref(the_repository,
+					    "CHECKOUT_AUTOSTASH_HEAD",
+					    new_branch_info->name,
+					    "local",
+					    stash_label_base,
+					    autostash_msg.buf);
+		}
 		if (ret) {
 			branch_info_release(&old_branch_info);
-			return ret;
+			strbuf_release(&old_commit_shortname);
+			strbuf_release(&autostash_msg);
+			return ret < 0 ? 1 : ret;
 		}
 	}
 
@@ -1231,8 +1194,22 @@ static int switch_branches(const struct checkout_opts *opts,
 
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
+	if (created_autostash) {
+		discard_index(the_repository->index);
+		if (repo_read_index(the_repository) < 0)
+			die(_("index file corrupt"));
+
+		if (!opts->quiet && new_branch_info->commit) {
+			printf(_("The following paths have local changes:\n"));
+			show_local_changes(&new_branch_info->commit->object,
+					   &opts->diff_options);
+		}
+	}
+
 	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
 	branch_info_release(&old_branch_info);
+	strbuf_release(&old_commit_shortname);
+	strbuf_release(&autostash_msg);
 
 	return ret || writeout_error;
 }
diff --git a/sequencer.c b/sequencer.c
index 7c0376d9e4..746f85a442 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4765,15 +4765,19 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
 		strvec_push(&store.args, stash_oid);
 		if (run_command(&store))
 			ret = error(_("cannot store %s"), stash_oid);
+		else if (attempt_apply)
+			fprintf(stderr,
+				_("Your local changes are stashed, however applying them\n"
+				  "resulted in conflicts.  You can either resolve the conflicts\n"
+				  "and then discard the stash with \"git stash drop\", or, if you\n"
+				  "do not want to resolve them now, run \"git reset --hard\" and\n"
+				  "apply the local changes later by running \"git stash pop\".\n"));
 		else
 			fprintf(stderr,
-				_("%s\n"
+				_("Autostash exists; creating a new stash entry.\n"
 				  "Your changes are safe in the stash.\n"
 				  "You can run \"git stash pop\" or"
-				  " \"git stash drop\" at any time.\n"),
-				attempt_apply ?
-				_("Applying autostash resulted in conflicts.") :
-				_("Autostash exists; creating a new stash entry."));
+				  " \"git stash drop\" at any time.\n"));
 	}
 
 	return ret;
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index ad3ba6a984..f0bbc476ff 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -61,18 +61,22 @@ create_expected_failure_apply () {
 	First, rewinding head to replay your work on top of it...
 	Applying: second commit
 	Applying: third commit
-	Applying autostash resulted in conflicts.
-	Your changes are safe in the stash.
-	You can run "git stash pop" or "git stash drop" at any time.
+	Your local changes are stashed, however applying them
+	resulted in conflicts.  You can either resolve the conflicts
+	and then discard the stash with "git stash drop", or, if you
+	do not want to resolve them now, run "git reset --hard" and
+	apply the local changes later by running "git stash pop".
 	EOF
 }
 
 create_expected_failure_merge () {
 	cat >expected <<-EOF
 	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
-	Applying autostash resulted in conflicts.
-	Your changes are safe in the stash.
-	You can run "git stash pop" or "git stash drop" at any time.
+	Your local changes are stashed, however applying them
+	resulted in conflicts.  You can either resolve the conflicts
+	and then discard the stash with "git stash drop", or, if you
+	do not want to resolve them now, run "git reset --hard" and
+	apply the local changes later by running "git stash pop".
 	Successfully rebased and updated refs/heads/rebased-feature-branch.
 	EOF
 }
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 9bcf7c0b40..7613b1d2a4 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -102,7 +102,10 @@ test_expect_success 'checkout -m with dirty tree' '
 
 	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
 
-	printf "M\t%s\n" one >expect.messages &&
+	cat >expect.messages <<-\EOF &&
+	The following paths have local changes:
+	M	one
+	EOF
 	test_cmp expect.messages messages &&
 
 	fill "M	one" "A	three" "D	two" >expect.main &&
@@ -210,6 +213,72 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 	test_cmp expect two
 '
 
+test_expect_success 'checkout -m with mixed staged and unstaged changes' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 0 x y z >same &&
+	git add same &&
+	fill 1 2 3 4 5 6 7 >one &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep "Applied autostash" actual &&
+	fill 0 x y z >expect &&
+	test_cmp expect same &&
+	fill 1 2 3 4 5 6 7 >expect &&
+	test_cmp expect one
+'
+
+test_expect_success 'checkout -m creates a recoverable stash on conflict' '
+	git checkout -f main &&
+	git clean -f &&
+
+	fill 1 2 3 4 5 >one &&
+	test_must_fail git checkout side 2>stderr &&
+	test_grep "Your local changes" stderr &&
+	git checkout -m side >actual 2>&1 &&
+	test_grep "resulted in conflicts" actual &&
+	test_grep "git stash drop" actual &&
+	test_grep "git stash pop" actual &&
+	test_grep "The following paths have local changes" actual &&
+	git log -p -1 --format="%gs%n%B" -g --diff-merges=1 refs/stash >actual &&
+	sed /^index/d actual >actual.trimmed &&
+	cat >expect <<-EOF &&
+	autostash while switching to ${SQ}side${SQ}
+	On main: autostash while switching to ${SQ}side${SQ}
+
+	diff --git a/one b/one
+	--- a/one
+	+++ b/one
+	@@ -3,6 +3,3 @@
+	 3
+	 4
+	 5
+	-6
+	-7
+	-8
+	EOF
+	test_cmp expect actual.trimmed &&
+	git stash drop &&
+	git reset --hard
+'
+
+test_expect_success 'checkout -m which would overwrite untracked file' '
+	git checkout -f --detach main &&
+	test_commit another-file &&
+	git checkout HEAD^ &&
+	>another-file.t &&
+	fill 1 2 3 4 5 >one &&
+	test_must_fail git checkout -m @{-1} 2>err &&
+	q_to_tab >expect <<-\EOF &&
+	error: The following untracked working tree files would be overwritten by checkout:
+	Qanother-file.t
+	Please move or remove them before you switch branches.
+	Aborting
+	Applied autostash.
+	EOF
+	test_cmp expect err
+'
+
 test_expect_success 'switch to another branch while carrying a deletion' '
 	git checkout -f main &&
 	git reset --hard &&
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 9838094b66..f877d9a433 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -914,7 +914,8 @@ test_expect_success 'merge with conflicted --autostash changes' '
 	git diff >expect &&
 	test_when_finished "test_might_fail git stash drop" &&
 	git merge --autostash c3 2>err &&
-	test_grep "Applying autostash resulted in conflicts." err &&
+	test_grep "applying them" err &&
+	test_grep "resulted in conflicts" err &&
 	git show HEAD:file >merge-result &&
 	test_cmp result.1-9 merge-result &&
 	git stash show -p >actual &&
diff --git a/xdiff-interface.c b/xdiff-interface.c
index f043330f2a..5ee2b96d0a 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -325,6 +325,18 @@ int parse_conflict_style_name(const char *value)
 		return -1;
 }
 
+const char *conflict_style_name(int style)
+{
+	switch (style) {
+	case XDL_MERGE_DIFF3:
+		return "diff3";
+	case XDL_MERGE_ZEALOUS_DIFF3:
+		return "zdiff3";
+	default:
+		return "merge";
+	}
+}
+
 int git_xmerge_style = -1;
 
 int git_xmerge_config(const char *var, const char *value,
diff --git a/xdiff-interface.h b/xdiff-interface.h
index fbc4ceec40..ce54e1c0e0 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -55,6 +55,7 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
 void xdiff_clear_find_func(xdemitconf_t *xecfg);
 struct config_context;
 int parse_conflict_style_name(const char *value);
+const char *conflict_style_name(int style);
 int git_xmerge_config(const char *var, const char *value,
 		      const struct config_context *ctx, void *cb);
 extern int git_xmerge_style;
-- 
gitgitgadget
