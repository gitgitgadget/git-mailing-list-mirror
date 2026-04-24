Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189331E84E
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065025; cv=none; b=U30U5AidO0xcNUKn/EXp3Xg8x7qb4GFV7iGrswG5dsVFtCyS5Mpl9+BFVI9TxoIXcB6kyxcAgqctSf+1YHTJAuYm2paufR5QcUOPWHH4hxydG96FcBB8LMX+qAdNlAK5pR6dBFoVEpREaLFKxxbCa2CySncWPCcPjU4+5fdjgCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065025; c=relaxed/simple;
	bh=BgcKVl0LKboCITzyO/sFHlcQG+XLZ/YLp0z/+DznvJ4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sTw2CtXrWi41FJZi8m43yLowgm8YLA14ip0MCftrreQ2iLO3Xa1v0Fst12ebZhrPOj6MXNTOEkV6H/GSFh0Lx7NZTsHp40cZ9WLU7t60x0SO0IjcMj3YfkMN34wrY4mACpp9PmOZL19zOm8wqkmvPg04ZKJTv/Az9/uqOtaKUAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KND+KF4l; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KND+KF4l"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2de831d2b20so1602322eec.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065022; x=1777669822; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqYbhiLPdvNlrbdNIHuSXnNX/EmFBKqVJIpOcnZfOt8=;
        b=KND+KF4lelpzIgZJbLh377d4k03TXb69akPo3wPhSGy1s9a/uejrWCugPz4svIUyk/
         nNOuePBqD9Xmjj/JqxueUFQGGNCfi7tanK2O2I0B4Zu7Hfb5+2JtjDJFKLDfIvahlsFM
         gNsqWjpg6SqR7zvmZl5JvpZff6XQEOkZJgb8ykocg7+BLDtd1N67S124XZQlIVckwTe2
         ZT9IpM4aaHZ8RF/oL7ax4EV+22l5w2m/KqOAlTHxp0jNsMV8GKNfiIg0a7b1a9trj3VL
         d8GQgojDyjfSesyOmzRccfIZcXqGPO1t0KnFlo/d0e+SypCoW9/QDY4KlYivx1nOj72b
         V94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065022; x=1777669822;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nqYbhiLPdvNlrbdNIHuSXnNX/EmFBKqVJIpOcnZfOt8=;
        b=ZABbCQ8/zop429C8I4papnvDnTA5XJvhqWX+fi/NmRw0Rg2PRf1LIuK4DYws3GiCey
         X6CO0Lb0ncbKaAUaTruaaWcIGThmcD7CEUluFj2UtpaDSVzfnrApWaZnorOeknz6jUE1
         EY/67hxxep9prLmGPelMvob8S7mfFyQnDvVM1ecMcw9uz7rANaBuYlx7SlEwXYXZXK9T
         MRrgGOcAmZ9txwfLOckCp6Uj4PsM53GT9iMER3l1L0WA0OwVWpnz/03njyQUyU8kkA2I
         CM8Gn+A95XWsvRwLtW4rIawuPUZszKGqlJQPX5hdMZJUDoxG6ScWmZeDhUc5UnWpiWM1
         8QGg==
X-Gm-Message-State: AOJu0YxtSRWH1q3JYSJkugJl5ajxBDwqL6AvT6WBYom0TUiuGd82Pqa3
	SZnhjMmm/j/Wijdlx3FJ285jwl/BoZuEtz+s0cq6hMUETNub0xJQsA29lqUyPQ==
X-Gm-Gg: AeBDieuxL7iJPGwWe4DskKKiQCsanoW08IyP4FTnCvpHPlPZ8qPwXBRtQ1YRQEhHBLD
	XgFKQ3skNpJUFWW0I2Lvg2iDGD+a+yftpmtlsCSsRlyoK681dToWWq7gob8BmbBke0LxtMeTn6N
	OVw853oa/LiVPKvg77RkjRlK5UziBJL0hPiCM/4wr6Z57YoEffrLkyD2ASnuV8foX4usk2ATpim
	g0zOyX+Wcv6DDRgWds89Kwy2fu1C+36Mjerr8wW/q4kIOuYDdQagrbOyJli13lhYO85w0KnKKhP
	aVeR9GHCRzepsO/EN5zUMbVABFI+GzvJ40cnPC4Ouig7hQYAB84hr7we1mW8AzNJA8jk1WqUgr9
	KBn3c2Q8V4Ab+M8I6oP9kHAwD0swbQ57qKtjR+sOit/vbmlinIT9NC/h/HIKVDIlYWErMDOP/KS
	zWSAGhYxueCTKw+v2XBu2ryuX0Lr3h/cXrBlzIrpc=
X-Received: by 2002:a05:693c:300c:b0:2dd:c066:bfe with SMTP id 5a478bee46e88-2e478a331bfmr21637844eec.21.1777065021707;
        Fri, 24 Apr 2026 14:10:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm33782329eec.28.2026.04.24.14.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:10:21 -0700 (PDT)
Message-Id: <96b14db827e51966aceb6513f7d16ed526274ec2.1777065012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
References: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
	<pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 21:10:12 +0000
Subject: [PATCH v15 5/5] checkout -m: autostash when switching branches
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
 Documentation/git-checkout.adoc |  58 ++++++------
 Documentation/git-switch.adoc   |  33 +++----
 builtin/checkout.c              | 160 ++++++++++++++------------------
 sequencer.c                     |  14 ++-
 t/t3420-rebase-autostash.sh     |  16 ++--
 t/t7201-co.sh                   |  61 +++++++++++-
 t/t7600-merge.sh                |   3 +-
 xdiff-interface.c               |  12 +++
 xdiff-interface.h               |   1 +
 9 files changed, 211 insertions(+), 147 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index 43ccf47cf6..70dd211ee3 100644
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
@@ -578,39 +577,44 @@ $ git checkout mytopic
 error: You have local changes to 'frotz'; not switching branches.
 ------------
 
-You can give the `-m` flag to the command, which would try a
-three-way merge:
+You can give the `-m` flag to the command, which would carry your local
+changes to the new branch:
 
 ------------
 $ git checkout -m mytopic
-Auto-merging frotz
+Switched to branch 'mytopic'
 ------------
 
-After this three-way merge, the local modifications are _not_
+After the switch, the local modifications are reapplied and are _not_
 registered in your index file, so `git diff` would show you what
 changes you made since the tip of the new branch.
 
 === 3. Merge conflict
 
-When a merge conflict happens during switching branches with
-the `-m` option, you would see something like this:
+When the `--merge` (`-m`) option is in effect and the locally
+modified files overlap with files that need to be updated by the
+branch switch, the changes are stashed and reapplied after the
+switch.  If this process results in conflicts, a stash entry is saved
+and made available in `git stash list`:
 
 ------------
 $ git checkout -m mytopic
-Auto-merging frotz
-ERROR: Merge conflict in frotz
-fatal: merge program failed
-------------
+Your local changes are stashed, however, applying it to carry
+forward your local changes resulted in conflicts:
 
-At this point, `git diff` shows the changes cleanly merged as in
-the previous example, as well as the changes in the conflicted
-files.  Edit and resolve the conflict and mark it resolved with
-`git add` as usual:
+ - You can try resolving them now.  If you resolved them
+   successfully, discard the stash entry with "git stash drop".
 
+ - Alternatively you can "git reset --hard" if you do not want
+   to deal with them right now, and later "git stash pop" to
+   recover your local changes.
 ------------
-$ edit frotz
-$ git add frotz
-------------
+
+You can try resolving the conflicts now.  Edit the conflicting files
+and mark them resolved with `git add` as usual, then run `git stash
+drop` to discard the stash entry.  Alternatively, you can clear the
+working tree with `git reset --hard` and recover your local changes
+later with `git stash pop`.
 
 CONFIGURATION
 -------------
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index 87707e9265..ee58a4d0fd 100644
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
@@ -217,15 +218,15 @@ $ git switch mytopic
 error: You have local changes to 'frotz'; not switching branches.
 ------------
 
-You can give the `-m` flag to the command, which would try a three-way
-merge:
+You can give the `-m` flag to the command, which would carry your local
+changes to the new branch:
 
 ------------
 $ git switch -m mytopic
-Auto-merging frotz
+Switched to branch 'mytopic'
 ------------
 
-After this three-way merge, the local modifications are _not_
+After the switch, the local modifications are reapplied and are _not_
 registered in your index file, so `git diff` would show you what
 changes you made since the tip of the new branch.
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index c80c62b37b..d02183b245 100644
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
@@ -755,7 +757,7 @@ static void setup_branch_path(struct branch_info *branch)
 
 static void init_topts(struct unpack_trees_options *topts, int merge,
 		       int show_progress, int overwrite_ignore,
-		       struct commit *old_commit)
+		       struct commit *old_commit, bool show_unpack_errors)
 {
 	memset(topts, 0, sizeof(*topts));
 	topts->head_idx = -1;
@@ -767,7 +769,7 @@ static void init_topts(struct unpack_trees_options *topts, int merge,
 	topts->initial_checkout = is_index_unborn(the_repository->index);
 	topts->update = 1;
 	topts->merge = 1;
-	topts->quiet = merge && old_commit;
+	topts->quiet = merge && old_commit && !show_unpack_errors;
 	topts->verbose_update = show_progress;
 	topts->fn = twoway_merge;
 	topts->preserve_ignored = !overwrite_ignore;
@@ -776,7 +778,8 @@ static void init_topts(struct unpack_trees_options *topts, int merge,
 static int merge_working_tree(const struct checkout_opts *opts,
 			      struct branch_info *old_branch_info,
 			      struct branch_info *new_branch_info,
-			      int *writeout_error)
+			      int *writeout_error,
+			      bool show_unpack_errors)
 {
 	int ret;
 	struct lock_file lock_file = LOCK_INIT;
@@ -827,7 +830,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 		/* 2-way merge to the new branch */
 		init_topts(&topts, opts->merge, opts->show_progress,
-			   opts->overwrite_ignore, old_branch_info->commit);
+			   opts->overwrite_ignore, old_branch_info->commit,
+			   show_unpack_errors);
 		init_checkout_metadata(&topts.meta, new_branch_info->refname,
 				       new_branch_info->commit ?
 				       &new_branch_info->commit->object.oid :
@@ -853,90 +857,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
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
 
@@ -1181,6 +1103,10 @@ static int switch_branches(const struct checkout_opts *opts,
 	struct object_id rev;
 	int flag, writeout_error = 0;
 	int do_merge = 1;
+	int created_autostash = 0;
+	struct strbuf old_commit_shortname = STRBUF_INIT;
+	struct strbuf autostash_msg = STRBUF_INIT;
+	const char *stash_label_base = NULL;
 
 	trace2_cmd_mode("branch");
 
@@ -1218,11 +1144,49 @@ static int switch_branches(const struct checkout_opts *opts,
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
+					 &writeout_error, false);
+		if (ret == MERGE_WORKING_TREE_UNPACK_FAILED && opts->merge) {
+			strbuf_addf(&autostash_msg,
+				    "autostash while switching to '%s'",
+				    new_branch_info->name);
+			create_autostash_ref(the_repository,
+					     "CHECKOUT_AUTOSTASH_HEAD",
+					     autostash_msg.buf, true);
+			created_autostash = 1;
+			ret = merge_working_tree(opts, &old_branch_info, new_branch_info,
+						 &writeout_error, true);
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
 
@@ -1231,8 +1195,22 @@ static int switch_branches(const struct checkout_opts *opts,
 
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
index 9bcf7c0b40..b3293ead8d 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -102,7 +102,7 @@ test_expect_success 'checkout -m with dirty tree' '
 
 	test "$(git symbolic-ref HEAD)" = "refs/heads/side" &&
 
-	printf "M\t%s\n" one >expect.messages &&
+	printf "The following paths have local changes:\nM\t%s\n" one >expect.messages &&
 	test_cmp expect.messages messages &&
 
 	fill "M	one" "A	three" "D	two" >expect.main &&
@@ -210,6 +210,65 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
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
+	git show --format=%B --diff-merges=1 refs/stash >actual &&
+	sed /^index/d actual >actual.trimmed &&
+	cat >expect <<-EOF &&
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
+	test_grep "would be overwritten by checkout" err &&
+	test_grep "another-file.t" err
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
