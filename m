Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6CD37204D
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782635359; cv=none; b=s/UKERDL7YONY/WE6VTQM2PxKHZbfo0vUcsO/jgGR+l4mQjGYflhbO2rTBfy9IUiD+uo3yXBE/2CZqmeog2zzcwFPUllAWAvw6lEKhtVenrz9NYxqMfaOAdCuVNiCGZZjBpqAGlDy4jEK8L9OTm0AR+keMbI+tf4CLLPxZz55sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782635359; c=relaxed/simple;
	bh=rtSZOqziN2bXh9AgTU/2gv7VLiTWU8L+aphnynspfXU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GhzJiRzdb6s78khz5vft4N9oXrprvGsN3el7B0mpghAODRkGII3tITuwbqFLPXIcV3u88oV9r9VXLAqLLV0zGnhzgTnkOtxaEwqmGkFZKI39vou4F15IN1YxJptoOdcNkMLF7HBNwMq1W8TJgdNwVVFVe4Mido0pVP6Iywj9T/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2i82gdx; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2i82gdx"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-139b914bab6so3228217c88.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782635356; x=1783240156; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTlRL2HeRdxdbpMq4E+tBGHNECWlRoNMbO+5hdLGB6c=;
        b=B2i82gdx/K0J9fhbFZlK3iagDkCZMYo6Pf3c41cGiLtr8KmpklPZwt2hZ6KpLOhX5L
         alG/TztCqPwfpyEjC/wRxKnK/1QwYTHk6i936XEKFiBBlUWFsF4U/QU4dsCg2XquUxu/
         bCfbhR+oNAQwesNdGWGEIE7WFcWrO77uauhBnmPwWUC3RJXKQbG9ebv8P7n7KY4ukIVP
         Xxxn88oNhXuUJ0B+6wRKDt+ruQs9RRHhbHzKPll2wUwCUe9BbvUZIi7oZuV12yv3jNk2
         TZJoHejWUp+Qi3H5NCXFwL1zQTeZZQ8XPRw40qdXOjCsxaQEuXAVYyfwaV7pXSAto5U1
         u5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782635356; x=1783240156;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTlRL2HeRdxdbpMq4E+tBGHNECWlRoNMbO+5hdLGB6c=;
        b=qxNaEAh85mlS7o0UA0dC9zJqAbwplO9Cy+kyU4RixCecMQeohvRqzuHkF+HTuQMkAc
         /mvgl08JBBdL23Zc00+G4Jmw1ZhZvhvqBtUKxZ1TBBY1OU9yMyq42w4eq0Hxgoxetfz1
         xBKTkQzddQm85hHaWLbaQWO1hyyf+gUGaf1mejPooSMAzDORs86bUpaUW5mr7UQls15i
         QhcQWSxxs1Y3jk3E+bsrzciTOnPLNgv01M49HmCmyIqjt9lLkoybN3HX//U74U67lUO6
         WyxqlLD5+UINFZNrIc0tYvD9Fput1XLPhbrRzTHLA6LtnqYvHDWMEYzxXwxmjqcWFPcJ
         CiNQ==
X-Gm-Message-State: AOJu0YyC6cwP3fvBZ2XJdhhSQVVpeLdWn5ULvc28T/gDIs9LIPIj5xNF
	u1M3BDFsu/IjpjNj2TVfAqLzllYZWs+cnUIJrmalMgAo031BqMrUQfH8qA4GsVmQ
X-Gm-Gg: AfdE7ck+ZxGHGWb0LOdMK+q5A7DMkXW8j9n4IkM+DZiLWjghSX9IXpFoYh1DIhmzlm/
	GX6yxa7D3RakPNIQMbRCT2jxHLc17dqzyQe7s6A3MIPfLDVMFQYJpn2OlvN5sRkzpdnNuW8NCOL
	6Kbut8UvJmZU1wHxO4EM6OZc12JuqMSkcc5lbV/5JxCBwscGOF2AECX33C5uquy9ilZeoZGe0MA
	LmzcAyoFXDDGkLBZ0/oDJnJ7NzVBdqZ8j+3oLuGI3EPl7j4cfjueB5CN2rk20oZF9dFPPrITiAr
	lsOpA4FuE+hO6SLFfRAlo436jBZLswwJW82RuLN28nhtXa9+yleFGJRhbwix9//JyrKho72GQxi
	wReDsHQjRretAzyWra2dQAhDlzuozvkZHhOU8YTlui5stNoKrm4EbMYBo7Spc2+EMq3dXLn4tvY
	X0DlBcrdltjPP3WA==
X-Received: by 2002:a05:7022:6896:b0:139:ed5a:eef0 with SMTP id a92af1059eb24-139ed5b059fmr5824142c88.47.1782635356143;
        Sun, 28 Jun 2026 01:29:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.186.0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f77602sm31082302c88.8.2026.06.28.01.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 01:29:15 -0700 (PDT)
Message-Id: <811e393ab48e2f79e6f8c78d883a5b92311791b3.1782635349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
References: <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
	<pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 08:29:08 +0000
Subject: [PATCH v6 3/4] history: add squash subcommand to fold a range
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Folding a series of commits into one required either an interactive
rebase where each commit after the first was hand-edited to "fixup", or
a "git reset --soft" to the merge base followed by "git commit --amend".

Add "git history squash <revision-range>" to do this directly. It folds
every commit in the range into the oldest one, keeping that commit's
message and authorship and taking the tree of the newest commit, then
replays the commits above the range on top. fixup!, squash! and amend!
commits are folded like any other and are not interpreted, so the
squashed message comes from the oldest commit, or from an editor with
--reedit-message.

The range is read like the arguments to "git rev-list", so several
arguments such as "@~3.. ^topic" are allowed. A merge inside the range
is folded when its other parent is reachable from the base, otherwise
the range has more than one base and is rejected. By default the command
also refuses when a ref points at a commit that the fold would discard.
Use --update-refs=head to rewrite only the current branch instead.

Inspired-by: Sergey Chernov <serega.morph@gmail.com>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  28 ++
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 224 ++++++++++++++
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 513 +++++++++++++++++++++++++++++++
 7 files changed, 772 insertions(+)
 create mode 100755 t/t3455-history-squash.sh

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 257db58918..f4d692d136 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -55,6 +55,10 @@ all advice messages.
 	forceDeleteBranch::
 		Shown when the user tries to delete a not fully merged
 		branch without the force option set.
+	historyUpdateRefs::
+		Shown when `git history squash` refuses because a ref points
+		into the range being folded, to tell the user about
+		`--update-refs=head`.
 	ignoredHook::
 		Shown when a hook is ignored because the hook is not
 		set as executable.
diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 2ba8121795..123ad5d4bc 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -11,6 +11,7 @@ SYNOPSIS
 git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
 git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
 git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
+git history squash <revision-range> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]
 
 DESCRIPTION
 -----------
@@ -97,6 +98,33 @@ linkgit:gitglossary[7].
 It is invalid to select either all or no hunks, as that would lead to
 one of the commits becoming empty.
 
+`squash <revision-range>`::
+	Fold all commits in _<revision-range>_ into the oldest commit of that
+	range. The resulting commit keeps the oldest commit's message and
+	authorship and takes the tree of the range's newest commit, so the
+	whole range collapses into a single commit. Commits above the range
+	are replayed on top of the result.
++
+The range is given in the usual `<base>..<tip>` form, where _<base>_ is
+the commit just below the oldest commit to squash. For example, `git
+history squash @~3..` folds the three most recent commits into one, and
+`git history squash @~5..@~2` squashes an interior range while leaving
+the two newest commits in place. _<revision-range>_ is read like the
+arguments to linkgit:git-rev-list[1], so several arguments may be given,
+for example `@~3.. ^topic` to additionally exclude what is already on
+`topic`.
++
+The oldest commit's message and authorship are preserved by default,
+unless you specify `--reedit-message`. A merge commit inside the range is
+folded like any other, but the range must have a single base, so a range
+that reaches more than one entry point (for example a side branch that
+forked before the range and was later merged into it) is rejected.
++
+The folded commits disappear from the history, so with the default
+`--update-refs=branches` the command refuses when another ref points at
+one of them. Rerun with `--update-refs=head` to rewrite only the current
+branch and leave those refs pointing at the old commits.
+
 OPTIONS
 -------
 
diff --git a/advice.c b/advice.c
index 0018501b7b..5c6ff95e31 100644
--- a/advice.c
+++ b/advice.c
@@ -58,6 +58,7 @@ static struct {
 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates" },
 	[ADVICE_FORCE_DELETE_BRANCH]			= { "forceDeleteBranch" },
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated" },
+	[ADVICE_HISTORY_UPDATE_REFS]			= { "historyUpdateRefs" },
 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook" },
 	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity" },
 	[ADVICE_MERGE_CONFLICT]				= { "mergeConflict" },
diff --git a/advice.h b/advice.h
index 8def280688..911b4e4643 100644
--- a/advice.h
+++ b/advice.h
@@ -25,6 +25,7 @@ enum advice_type {
 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
 	ADVICE_FORCE_DELETE_BRANCH,
 	ADVICE_GRAFT_FILE_DEPRECATED,
+	ADVICE_HISTORY_UPDATE_REFS,
 	ADVICE_IGNORED_HOOK,
 	ADVICE_IMPLICIT_IDENTITY,
 	ADVICE_MERGE_CONFLICT,
diff --git a/builtin/history.c b/builtin/history.c
index 305bde3102..5a1b42c063 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "advice.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "commit-reach.h"
@@ -30,6 +31,8 @@
 	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
 #define GIT_HISTORY_SPLIT_USAGE \
 	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
+#define GIT_HISTORY_SQUASH_USAGE \
+	N_("git history squash <revision-range> [--dry-run] [--update-refs=(branches|head)] [--reedit-message]")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -973,6 +976,225 @@ out:
 	return ret;
 }
 
+/*
+ * Resolve a "<base>..<tip>" revision range into the base commit just outside
+ * the range (which becomes the parent of the squashed commit), the oldest
+ * commit contained in the range (whose message the squash reuses), and the
+ * range tip (whose tree becomes the result). A merge inside the range is fine,
+ * but the range must have a single base and must not reach a root commit.
+ */
+static int resolve_squash_range(struct repository *repo,
+				const char **argv,
+				struct commit **base_out,
+				struct commit **oldest_out,
+				struct commit **tip_out,
+				struct oidset *interior_out)
+{
+	struct rev_info revs;
+	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
+	struct commit_list *boundaries = NULL, *b;
+	struct strvec args = STRVEC_INIT;
+	size_t i;
+	int ret;
+
+	repo_init_revisions(repo, &revs, NULL);
+	strvec_push(&args, "ignored");
+	strvec_push(&args, "--reverse");
+	strvec_push(&args, "--topo-order");
+	strvec_push(&args, "--boundary");
+	strvec_push(&args, "--ancestry-path");
+	strvec_pushv(&args, argv);
+	setup_revisions_from_strvec(&args, &revs, NULL);
+	if (args.nr != 1) {
+		ret = error(_("unrecognized argument: %s"), args.v[1]);
+		goto out;
+	}
+
+	/*
+	 * A squash needs a base to reparent onto, so the range has to exclude
+	 * something, as in "<base>..<tip>". A revision range with no such
+	 * bottom commit cannot be squashed.
+	 */
+	for (i = 0; i < revs.cmdline.nr; i++)
+		if (revs.cmdline.rev[i].flags & UNINTERESTING)
+			break;
+	if (i == revs.cmdline.nr) {
+		ret = error(_("not a '<base>..<tip>' revision range"));
+		goto out;
+	}
+
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+
+	while ((commit = get_revision(&revs))) {
+		if (commit->object.flags & BOUNDARY) {
+			commit_list_insert(commit, &boundaries);
+			continue;
+		}
+		if (!oldest)
+			oldest = commit;
+		if (tip)
+			oidset_insert(interior_out, &tip->object.oid);
+		tip = commit;
+	}
+
+	if (!oldest) {
+		ret = error(_("the revision range is empty"));
+		goto out;
+	}
+
+	if (oldest == tip) {
+		ret = error(_("the revision range holds a single commit; "
+			      "nothing to squash"));
+		goto out;
+	}
+
+	if (!oldest->parents)
+		BUG("an in-range commit must have a parent");
+	base = oldest->parents->item;
+
+	/*
+	 * A boundary other than the base is an in-range commit reaching a
+	 * commit outside the range, so the range has more than one base.
+	 */
+	for (b = boundaries; b; b = b->next) {
+		if (b->item != base) {
+			ret = error(_("the revision range has more than one base; "
+				      "cannot squash"));
+			goto out;
+		}
+	}
+
+	*base_out = base;
+	*oldest_out = oldest;
+	*tip_out = tip;
+	ret = 0;
+
+out:
+	commit_list_free(boundaries);
+	reset_revision_walk();
+	release_revisions(&revs);
+	strvec_clear(&args);
+	return ret;
+}
+
+struct interior_ref_cb {
+	const struct oidset *interior;
+	const char *name;
+};
+
+static int find_interior_ref(const struct reference *ref, void *cb_data)
+{
+	struct interior_ref_cb *data = cb_data;
+
+	if (oidset_contains(data->interior, ref->oid)) {
+		data->name = xstrdup(ref->name);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int cmd_history_squash(int argc,
+			      const char **argv,
+			      const char *prefix,
+			      struct repository *repo)
+{
+	const char * const usage[] = {
+		GIT_HISTORY_SQUASH_USAGE,
+		NULL,
+	};
+	enum ref_action action = REF_ACTION_DEFAULT;
+	enum commit_tree_flags flags = 0;
+	int dry_run = 0;
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
+			       N_("control which refs should be updated"),
+			       PARSE_OPT_NONEG, parse_ref_action),
+		OPT_BOOL('n', "dry-run", &dry_run,
+			 N_("perform a dry-run without updating any refs")),
+		OPT_BIT(0, "reedit-message", &flags,
+			N_("open an editor to modify the commit message"),
+			COMMIT_TREE_EDIT_MESSAGE),
+		OPT_END(),
+	};
+	struct strbuf reflog_msg = STRBUF_INIT;
+	struct oidset interior = OIDSET_INIT;
+	struct commit *base, *oldest, *tip, *rewritten;
+	const struct object_id *base_tree_oid, *tip_tree_oid;
+	struct commit_list *parents = NULL;
+	struct rev_info revs = { 0 };
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (!argc) {
+		ret = error(_("command expects a revision range"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	if (action == REF_ACTION_DEFAULT)
+		action = REF_ACTION_BRANCHES;
+
+	ret = resolve_squash_range(repo, argv, &base, &oldest, &tip,
+				   &interior);
+	if (ret < 0)
+		goto out;
+
+	if (action == REF_ACTION_BRANCHES) {
+		struct interior_ref_cb cb = { .interior = &interior };
+
+		refs_for_each_ref(get_main_ref_store(repo),
+				  find_interior_ref, &cb);
+		if (cb.name) {
+			ret = error(_("'%s' points into the squashed range"),
+				    cb.name);
+			advise_if_enabled(ADVICE_HISTORY_UPDATE_REFS,
+					  _("Use --update-refs=head to rewrite only "
+					    "the current branch and leave such refs "
+					    "untouched."));
+			free((char *)cb.name);
+			goto out;
+		}
+	}
+
+	ret = setup_revwalk(repo, action, tip, &revs);
+	if (ret < 0)
+		goto out;
+
+	base_tree_oid = &repo_get_commit_tree(repo, base)->object.oid;
+	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
+	commit_list_append(base, &parents);
+
+	ret = commit_tree_ext(repo, "squash", oldest, NULL, parents,
+			      base_tree_oid, tip_tree_oid, &rewritten, flags);
+	if (ret < 0) {
+		ret = error(_("failed writing squashed commit"));
+		goto out;
+	}
+
+	strbuf_addf(&reflog_msg, "squash: updating %s", argv[0]);
+
+	ret = handle_reference_updates(&revs, action, tip, rewritten,
+				       reflog_msg.buf, dry_run,
+				       REPLAY_EMPTY_COMMIT_ABORT);
+	if (ret < 0) {
+		ret = error(_("failed replaying descendants"));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	strbuf_release(&reflog_msg);
+	oidset_clear(&interior);
+	commit_list_free(parents);
+	release_revisions(&revs);
+	return ret;
+}
+
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
@@ -982,6 +1204,7 @@ int cmd_history(int argc,
 		GIT_HISTORY_FIXUP_USAGE,
 		GIT_HISTORY_REWORD_USAGE,
 		GIT_HISTORY_SPLIT_USAGE,
+		GIT_HISTORY_SQUASH_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -989,6 +1212,7 @@ int cmd_history(int argc,
 		OPT_SUBCOMMAND("fixup", &fn, cmd_history_fixup),
 		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
+		OPT_SUBCOMMAND("squash", &fn, cmd_history_squash),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 3219264fe7..63ea26b8ed 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -399,6 +399,7 @@ integration_tests = [
   't3451-history-reword.sh',
   't3452-history-split.sh',
   't3453-history-fixup.sh',
+  't3455-history-squash.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
new file mode 100755
index 0000000000..94ee54eb24
--- /dev/null
+++ b/t/t3455-history-squash.sh
@@ -0,0 +1,513 @@
+#!/bin/sh
+
+test_description='tests for git-history squash subcommand'
+
+. ./test-lib.sh
+
+test_expect_success 'setup linear history touching two files' '
+	test_commit base file a &&
+	git tag start &&
+	test_commit --no-tag one other x &&
+	test_commit --no-tag two file c &&
+	test_commit three file d
+'
+
+test_expect_success 'errors on missing range argument' '
+	test_must_fail git history squash 2>err &&
+	test_grep "expects a revision range" err
+'
+
+test_expect_success 'errors on an empty range' '
+	test_must_fail git history squash HEAD..HEAD 2>err &&
+	test_grep "the revision range is empty" err
+'
+
+test_expect_success 'errors on a single revision that is not a range' '
+	test_must_fail git history squash HEAD 2>err &&
+	test_grep "not a .*range" err &&
+	test_must_fail git history squash HEAD~1 2>err &&
+	test_grep "not a .*range" err
+'
+
+test_expect_success 'errors on a range holding a single commit' '
+	git reset --hard three &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash "HEAD^!" 2>err &&
+	test_grep "single commit; nothing to squash" err &&
+	test_cmp_rev "$head_before" HEAD
+'
+
+test_expect_success 'accepts multiple revision arguments with an exclusion' '
+	git reset --hard three &&
+	git branch -f keep HEAD~2 &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start..HEAD ^keep &&
+
+	git log --format="%s" start..HEAD >actual &&
+	cat >expect <<-\EOF &&
+	two
+	one
+	EOF
+	test_cmp expect actual &&
+	test_cmp_rev keep HEAD~1 &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+
+	git branch -D keep
+'
+
+test_expect_success 'squashes a branch the current branch is not on' '
+	git reset --hard three &&
+	main=$(git symbolic-ref --short HEAD) &&
+	head_before=$(git rev-parse HEAD) &&
+	git checkout -b off-history start &&
+	test_commit --no-tag off-one off a &&
+	test_commit --no-tag off-two off b &&
+	git checkout "$main" &&
+
+	git history squash start..off-history &&
+
+	git rev-list --count start..off-history >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git branch -D off-history
+'
+
+test_expect_success 'squashes a range into a single commit without changing the tree' '
+	git reset --hard three &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start.. &&
+
+	git rev-list --count start..HEAD >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	git log --format="%s" -1 >subject &&
+	echo one >expect &&
+	test_cmp expect subject &&
+	git reflog >reflog &&
+	test_grep "squash: updating" reflog
+'
+
+test_expect_success 'squashes an interior range and replays descendants verbatim' '
+	git reset --hard three &&
+	final_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start..@~1 &&
+
+	git log --format="%s" start..HEAD >actual &&
+	cat >expect <<-\EOF &&
+	three
+	one
+	EOF
+	test_cmp expect actual &&
+
+	test_cmp_rev start HEAD~2 &&
+	test "$final_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'squashes when the base is the root commit' '
+	git reset --hard three &&
+	root=$(git rev-list --max-parents=0 HEAD) &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash "$root.." &&
+
+	git rev-list --count "$root..HEAD" >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test_cmp_rev "$root" HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+
+test_expect_success 'reuses the message of a fixup! commit in the range' '
+	git reset --hard start &&
+	test_commit --no-tag reg1 file b &&
+	git commit --allow-empty -m "fixup! reg1" &&
+	test_commit reg2 file c &&
+
+	git history squash start.. &&
+
+	git log --format="%s" -1 >actual &&
+	echo reg1 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'keeps the oldest message even if it is a fixup!' '
+	git reset --hard start &&
+	test_commit --no-tag "fixup! something" file b &&
+	test_commit tail file c &&
+
+	git history squash start.. &&
+
+	git log --format="%s" -1 >actual &&
+	echo "fixup! something" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'preserves authorship of the oldest commit' '
+	git reset --hard start &&
+	GIT_AUTHOR_NAME=Squasher GIT_AUTHOR_EMAIL=squash@example.com \
+		test_commit --no-tag oldest file b &&
+	test_commit newest file c &&
+
+	git history squash start.. &&
+
+	git log -1 --format="%an <%ae>" >actual &&
+	echo "Squasher <squash@example.com>" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--dry-run predicts the rewrite without performing it' '
+	git reset --hard three &&
+	head_before=$(git rev-parse HEAD) &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --dry-run start.. >out &&
+	predicted=$(awk "/^update refs\/heads\// {print \$3}" out) &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git history squash start.. &&
+	test "$predicted" = "$(git rev-parse HEAD)" &&
+	git rev-list --count start..HEAD >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success '--update-refs=head only moves HEAD' '
+	git reset --hard three &&
+	git branch -f other HEAD &&
+	other_before=$(git rev-parse other) &&
+
+	git history squash --update-refs=head start.. &&
+
+	git rev-list --count start..HEAD >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test_cmp_rev "$other_before" other
+'
+
+test_expect_success 'refuses to fold a range a ref points into' '
+	git reset --hard three &&
+	git branch -f mid HEAD~1 &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash start.. 2>err &&
+	test_grep "error: .* points into the squashed range" err &&
+	test_grep "hint: .*--update-refs=head" err &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git branch -D mid
+'
+
+test_expect_success 'advice.historyUpdateRefs silences the hint' '
+	git reset --hard three &&
+	git branch -f mid HEAD~1 &&
+
+	test_must_fail git -c advice.historyUpdateRefs=false \
+		history squash start.. 2>err &&
+	test_grep "points into the squashed range" err &&
+	test_grep ! "hint:" err &&
+
+	git branch -D mid
+'
+
+test_expect_success '--update-refs=head folds past a ref pointing into the range' '
+	git reset --hard three &&
+	git branch -f mid HEAD~1 &&
+	mid_before=$(git rev-parse mid) &&
+
+	git history squash --update-refs=head start.. &&
+
+	git rev-list --count start..HEAD >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test_cmp_rev "$mid_before" mid &&
+
+	git branch -D mid
+'
+
+test_expect_success 'refuses to fold a range a tag points into' '
+	git reset --hard three &&
+	git tag -f mark HEAD~1 &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash start.. 2>err &&
+	test_grep "refs/tags/mark" err &&
+	test_grep "points into the squashed range" err &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git tag -d mark
+'
+
+test_expect_success 'squashes a range whose internal merge has a single base' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag before-side file b &&
+	git checkout -b inner-side &&
+	test_commit --no-tag on-inner-side inner x &&
+	git checkout "$main" &&
+	test_commit --no-tag after-side file c &&
+	git merge --no-ff -m merge inner-side &&
+	git branch -D inner-side &&
+	test_commit --no-tag after-merge file d &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start.. &&
+
+	git rev-list --count start..HEAD >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	git log --format="%s" -1 >subject &&
+	echo before-side >expect &&
+	test_cmp expect subject &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file inner
+'
+
+test_expect_success 'folds a merge of a branch that forked at the base' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b base-fork-side &&
+	test_commit --no-tag base-fork-side side x &&
+	git checkout "$main" &&
+	test_commit --no-tag base-fork-main file b &&
+	git merge --no-ff -m "merge base-fork-side" base-fork-side &&
+	git branch -D base-fork-side &&
+	test_commit --no-tag base-fork-tail file c &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start.. &&
+
+	git rev-list --count start..HEAD >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file side
+'
+
+test_expect_success 'refuses a merge whose other parent is outside the range' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b outside-parent &&
+	test_commit --no-tag outside-parent outside x &&
+	git checkout "$main" &&
+	test_commit --no-tag outside-main file b &&
+	base=$(git rev-parse HEAD) &&
+	test_commit --no-tag outside-mid file c &&
+	git merge --no-ff -m "merge outside-parent" outside-parent &&
+	git branch -D outside-parent &&
+	merged=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash "$base.." 2>err &&
+	test_grep "more than one base" err &&
+	test_cmp_rev "$merged" HEAD
+'
+
+test_expect_success 'folds a range whose tip is a merge commit' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag tipmerge-base file b &&
+	git checkout -b tipmerge-side &&
+	test_commit --no-tag tipmerge-side side x &&
+	git checkout "$main" &&
+	test_commit --no-tag tipmerge-main file c &&
+	git merge --no-ff -m "merge tipmerge-side" tipmerge-side &&
+	git branch -D tipmerge-side &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start.. &&
+
+	git rev-list --count start..HEAD >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file side
+'
+
+test_expect_success 'folds a range whose base is a merge commit' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b basemerge-side &&
+	test_commit --no-tag basemerge-side side x &&
+	git checkout "$main" &&
+	test_commit --no-tag basemerge-main file b &&
+	git merge --no-ff -m "merge basemerge-side" basemerge-side &&
+	git branch -D basemerge-side &&
+	base=$(git rev-parse HEAD) &&
+	test_commit --no-tag basemerge-one file c &&
+	test_commit --no-tag basemerge-two file d &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash "$base.." &&
+
+	git rev-list --count "$base..HEAD" >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test_cmp_rev "$base" HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'refuses to squash a range with more than one base' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b forked-before &&
+	test_commit forked-side fside x &&
+	git checkout "$main" &&
+	test_commit forked-base file b &&
+	base=$(git rev-parse HEAD) &&
+	test_commit forked-main file c &&
+	git merge --no-ff -m merge forked-before &&
+	merged=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash "$base.." 2>err &&
+	test_grep "more than one base" err &&
+	test_cmp_rev "$merged" HEAD
+'
+
+test_expect_success 'folds a range with two interior merges' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag two-merge-a file a1 &&
+	git checkout -b two-merge-s1 &&
+	test_commit --no-tag two-merge-s1 s1 x &&
+	git checkout "$main" &&
+	git merge --no-ff -m "merge s1" two-merge-s1 &&
+	test_commit --no-tag two-merge-b file b1 &&
+	git checkout -b two-merge-s2 &&
+	test_commit --no-tag two-merge-s2 s2 y &&
+	git checkout "$main" &&
+	git merge --no-ff -m "merge s2" two-merge-s2 &&
+	git branch -D two-merge-s1 two-merge-s2 &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start.. &&
+
+	git rev-list --count start..HEAD >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file s1 &&
+	test_path_is_file s2
+'
+
+test_expect_success 'folds a range with a nested merge' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b nested-outer &&
+	test_commit --no-tag nested-outer outer x &&
+	git checkout -b nested-inner &&
+	test_commit --no-tag nested-inner inner y &&
+	git checkout nested-outer &&
+	git merge --no-ff -m "merge inner" nested-inner &&
+	git checkout "$main" &&
+	test_commit --no-tag nested-main file b1 &&
+	git merge --no-ff -m "merge outer" nested-outer &&
+	git branch -D nested-outer nested-inner &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start.. &&
+
+	git rev-list --count start..HEAD >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file outer &&
+	test_path_is_file inner
+'
+
+test_expect_success 'folds a range with an octopus merge' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag octo-base file a1 &&
+	git checkout -b octo-1 &&
+	test_commit --no-tag octo-1 o1 x &&
+	git checkout "$main" &&
+	git checkout -b octo-2 &&
+	test_commit --no-tag octo-2 o2 y &&
+	git checkout "$main" &&
+	git merge --no-ff -m octopus octo-1 octo-2 &&
+	git branch -D octo-1 octo-2 &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start.. &&
+
+	git rev-list --count start..HEAD >count &&
+	echo 1 >expect &&
+	test_cmp expect count &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	test_path_is_file o1 &&
+	test_path_is_file o2
+'
+
+test_expect_success 'refuses an octopus merge with an arm forked before the base' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	git checkout -b octo-pre &&
+	test_commit octo-pre-side pside x &&
+	git checkout "$main" &&
+	test_commit octo-pre-main file b1 &&
+	octo_base=$(git rev-parse HEAD) &&
+	git checkout -b octo-within &&
+	test_commit --no-tag octo-within wside y &&
+	git checkout "$main" &&
+	git merge --no-ff -m octopus octo-pre octo-within &&
+	merged=$(git rev-parse HEAD) &&
+	git branch -D octo-pre octo-within &&
+
+	test_must_fail git history squash "$octo_base.." 2>err &&
+	test_grep "more than one base" err &&
+	test_cmp_rev "$merged" HEAD
+'
+
+test_expect_success 'refuses when a descendant above the range is a merge' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag desc-one file b &&
+	test_commit --no-tag desc-two file c &&
+	git tag desc-tip &&
+	git checkout -b desc-above &&
+	test_commit --no-tag desc-above above x &&
+	git checkout "$main" &&
+	test_commit --no-tag desc-main file d &&
+	git merge --no-ff -m "merge desc-above" desc-above &&
+	git branch -D desc-above &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash start..desc-tip 2>err &&
+	test_grep "merge commits is not supported" err &&
+	test_cmp_rev "$head_before" HEAD
+'
+
+test_expect_success 'refuses to fold a range a ref points into at a merge' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag refmerge-base file b &&
+	git checkout -b refmerge-side &&
+	test_commit --no-tag refmerge-side side x &&
+	git checkout "$main" &&
+	test_commit --no-tag refmerge-main file c &&
+	git merge --no-ff -m "interior merge" refmerge-side &&
+	git branch -D refmerge-side &&
+	git branch at-merge HEAD &&
+	test_commit --no-tag refmerge-tail file d &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash start.. 2>err &&
+	test_grep "at-merge" err &&
+	test_grep "points into the squashed range" err &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git branch -D at-merge
+'
+
+test_done
-- 
gitgitgadget

