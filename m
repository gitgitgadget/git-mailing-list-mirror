Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC523CF1FB
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536033; cv=none; b=lfgGgofa/lOVOgc4yo2/Kbp5L7Rv3xHr3ad7Doh3GMCsWU09j5zZkrs5CgEHuh6w6zLAHYstDTbO3aqLuplVHP3EHuCU8DaEmYbeYinIVOThXIXGoqA0Q/gSFtucQRZ2gWlEwTKt4prgBg4F+0nfE0H47Y/bG/Duc2/nZZvOMCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536033; c=relaxed/simple;
	bh=Q76umaL24CsipIQiaJF3Oh++cRxDEun1bzayz1I5L7g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VZ1KTiMz3x32HSelNOCAOUbds4eKDFIM5RdoTx8wJk5mmc3IASg4PgC5d2LR2B+OxNNdDotF977pQtwfLoX0omEXKU/1MRfoTGhZ6GanQ+/RqRu/lBAnwhMgu8347fnvemL8qY12/ig2cnW6Qkg2UwdKLm1mTghKogcjS2m2B58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0ZwYZg+; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0ZwYZg+"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90004d2f7b7so131161496d6.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784536029; x=1785140829; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OElQxEHMGDU06ZdPf2mNT+bOHl/px2ecGAv0jbBcSLc=;
        b=q0ZwYZg+nA7Bq46lcAjQYy1A6LU3675TO99lMU2ah29TXFIJRUy7lRHjPcK5OsDACY
         1Q/KtKE0Ppg1wX78Dmo6u5MsB8cRgynyQgUPf/2vc+mjwwBLOO3bs8BYsukZhkeJrJdW
         JeTPOMpyCUTz954UPaB9fQo1Yonk5TIR71vE1umQskKrAr+VM91HFi9MGUzUFGADbi6H
         buxq+7HgoX8ZdJy0yGnkEanEX+H5pd1EdYRx05GV2TBKp4nA1pNqVtUMt11UFx7Qeu2B
         29zg6UNR3Zd4aD3jL2OPp1sz2puXCWknO3+nHDX7rCa5ET+pTJpEbW34gp7eFQq8PrqF
         WWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784536029; x=1785140829;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OElQxEHMGDU06ZdPf2mNT+bOHl/px2ecGAv0jbBcSLc=;
        b=ix7dppdxGEMeiNgOrzbsEp9xlYi4OKvGkczwbI3u4wEcrLqRwiKywupxmVk2czPx+a
         7gazs1IqzMVIbI1L93wiAeisoOB2Qz3hivqaXBCqPOqLLHfqV+A48GbBnq2bb5wERrx8
         GRBSA/5MYL+96hAyt3akaJyaizmHGQuC+MOSd/udZ5oxLigJwer0R9vW3qTuQ0Xvydv1
         152PB0eE7WTnvId4PPpjJYuSSzJZUNMxRwK3DLHEYG0atLh+wKYWGvQrIuZ+pJzixbbW
         5++szBQtl7yPiwYMJTbv0wCUkoiIECpKE4wd3dTS7UPamNMaIjcRHcX1oTBkZigbUlIR
         s6Kg==
X-Gm-Message-State: AOJu0YzTB0NbbA01UmyGtgaq6bY638BhRIZ73A1lMAM7yUfie1P6hq1W
	T9MhMu/jOoHfUpewU/9RD6YelgZIzcliXQTzZUR5n/z0QrvBnbKFgibFYUfRtA==
X-Gm-Gg: AfdE7cls6j9Gv6mRo5dtoCNDnb+RFZz0es/NP1iWd+bERbFyTx9K20D5viFIUwYIpD2
	GUhVxOTuAw7OCpWb33X6c5AzqSb7fmLRdmka+7lFoCSh7oDUdkgVnnK299Plf7U3yAkYaqDHh+p
	868FilXPnqDklZx+4tGnUM6mmReZKzAeB9donwegmFuILbIXU5QuQKSrD5ePScBrsABQFYqiUyi
	JxQv1S+Vn4iQLOkHIFaTImC39s5F68a/axuVsjUsgN0kfLcc3zNhHIjlKgTzSLufcy8hTdkRjZc
	sH2O3rMUVgziXa5f7X6q7FQvXCS674MXRrIXmG8pQellxh8eu3RqaCh/5ao9OHM6xaViUNiFBMT
	c7BY6h65KkDt+jtjb96bC1khuJ/ryXc5UHh2TaWO/o5t+5y4Q4yNqO9qmaVpHQvIEk+Vj4sh2jP
	OWmpT2l4A=
X-Received: by 2002:a05:6214:4807:b0:8e9:f5de:d619 with SMTP id 6a1803df08f44-907784da90fmr140996896d6.56.1784536029129;
        Mon, 20 Jul 2026 01:27:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.110.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907785931e0sm87220596d6.21.2026.07.20.01.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:27:08 -0700 (PDT)
Message-Id: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
References: <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
	<pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 08:27:02 +0000
Subject: [PATCH v10 3/5] history: add squash subcommand to fold a range
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
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Folding a series of commits into one required either an interactive
rebase where each commit after the first was hand-edited to "fixup", or
a "git reset --soft" to the merge base followed by "git commit --amend".

Add "git history squash <revision-range>" to do this directly. It folds
every commit in the range into the oldest one, keeping that commit's
authorship and taking the tree of the newest commit, then replays the
commits above the range on top. The squashed message comes from the
oldest commit by default, or from the body of the last amend! commit
targeting it. An editor opens with the selected message when
--reedit-message is given. A fixup!, squash! or amend! commit is refused
unless the commit it targets is also in the range, so the fold does not
silently absorb a marker meant for a commit outside it. The check runs
the range through todo_list_rearrange_squash(), which leaves such a
marker as a plain pick. Markers whose target is in the range fold in as
usual. As an exception, a range made up entirely of markers for one
target is combined anyway, taking its message from the last amend! if
there is one, so a batch of fixups for the same commit can be collapsed.

The range is read like the arguments to "git rev-list", so several
revisions such as "HEAD~3..HEAD ^topic" may be given, and rev-list
options are accepted too. As "git replay" does, the walk options the fold
relies on are forced after setup_revisions() and a warning is printed if
an option changed them, so the first commit returned is the range's
oldest and its parent is the base regardless of what the user passed
(including after a "--"). A merge inside the range is folded when its
other parent is reachable from the base, otherwise the range has more
than one base and is rejected. By default the command also refuses when a
ref points at a commit that the fold would discard. Use --update-refs=head
to rewrite only the current branch instead.

Inspired-by: Sergey Chernov <serega.morph@gmail.com>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  45 ++-
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 374 ++++++++++++++++++++
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 569 +++++++++++++++++++++++++++++++
 7 files changed, 992 insertions(+), 3 deletions(-)
 create mode 100755 t/t3455-history-squash.sh

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 81f80a9274..e2a3487778 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -59,6 +59,10 @@ all advice messages.
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
index 28b477cd37..e1e930f355 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -12,6 +12,7 @@ git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(
 git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
 git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
 git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
+git history squash [--dry-run] [--update-refs=(branches|head)] [--reedit-message] <revision-range>
 
 DESCRIPTION
 -----------
@@ -43,8 +44,11 @@ at once.
 LIMITATIONS
 -----------
 
-This command does not (yet) work with histories that contain merges. You
-should use linkgit:git-rebase[1] with the `--rebase-merges` flag instead.
+This command does not (yet) replay merge commits onto the rewritten
+history: if a commit that would be replayed is a merge, the operation is
+rejected, and you should use linkgit:git-rebase[1] with the
+`--rebase-merges` flag instead. The `squash` subcommand can still fold a
+merge that lies inside the range, as long as the range has a single base.
 
 Furthermore, the command does not support operations that can result in merge
 conflicts. This limitation is by design as history rewrites are not intended to
@@ -113,6 +117,41 @@ linkgit:gitglossary[7].
 It is invalid to select either all or no hunks, as that would lead to
 one of the commits becoming empty.
 
+`squash <revision-range>`::
+	Fold all commits in _<revision-range>_ into the oldest commit of that
+	range. The resulting commit keeps the oldest commit's authorship and
+	takes the tree of the range's newest commit, so the whole range
+	collapses into a single commit. Commits above the range are replayed
+	on top of the result.
++
+The range is given in the usual `<base>..<tip>` form, where _<base>_ is
+the commit just below the oldest commit to squash. For example, `git
+history squash HEAD~3..HEAD` folds the three most recent commits into
+one, and `git history squash HEAD~5..HEAD~2` squashes an interior range
+while leaving the two newest commits in place. Several revisions may be
+given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
+already on `topic`. Rev-list options may also be given, but any that would
+change how the range is walked are overridden with a warning.
++
+The oldest commit's message is preserved by default, except that an `amend!`
+commit targeting it replaces its message. Specify `--reedit-message` to edit
+the resulting message. A merge commit inside the range is folded like any
+other, but the range must have a single base, so a range that reaches more
+than one entry point (for example a side branch that forked before the range
+and was later merged into it) is rejected.
++
+A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
+targets is also in the range, so the fold does not silently absorb a
+marker meant for a commit outside it. As an exception, a range made up entirely
+of markers for one target is combined into a single commit, keeping the last
+`amend!` message if there is one.
++
+A branch or tag that points at a commit inside the range would be left
+dangling once those commits are folded away, so with the default
+`--update-refs=branches` the command refuses. Rerun with
+`--update-refs=head` to rewrite only the current branch and leave such
+refs pointing at the old commits.
+
 OPTIONS
 -------
 
@@ -123,7 +162,7 @@ OPTIONS
 	ref updates is generally safe.
 
 `--reedit-message`::
-	Open an editor to modify the target commit's message.
+	Open an editor to modify the rewritten commit's message.
 
 `--empty=(drop|keep|abort)`::
 	Control what happens when a commit becomes empty as a result of the
diff --git a/advice.c b/advice.c
index 63bf8b0c5f..401d047391 100644
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
index 66f6cd6a77..3f0b4f0485 100644
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
index b592b98393..423c8beaaf 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "advice.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "commit-reach.h"
@@ -34,6 +35,8 @@
 	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
 #define GIT_HISTORY_SPLIT_USAGE \
 	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
+#define GIT_HISTORY_SQUASH_USAGE \
+	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--reedit-message] <revision-range>")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -1004,6 +1007,375 @@ out:
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
+	revs.reverse = 1;
+	revs.topo_order = 1;
+	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+	revs.simplify_history = 0;
+	revs.boundary = 1;
+
+	strvec_push(&args, "ignored");
+	strvec_push(&args, "--ancestry-path");
+	strvec_pushv(&args, argv);
+	setup_revisions_from_strvec(&args, &revs, NULL);
+	if (args.nr != 1) {
+		ret = error(_("unrecognized argument: %s"), args.v[1]);
+		goto out;
+	}
+
+	if (revs.reverse != 1 || revs.topo_order != 1 ||
+	    revs.sort_order != REV_SORT_IN_GRAPH_ORDER ||
+	    revs.simplify_history != 0 || revs.boundary != 1) {
+		warning(_("ignoring rev-list options that would change how the "
+			  "range is walked"));
+		revs.reverse = 1;
+		revs.topo_order = 1;
+		revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+		revs.simplify_history = 0;
+		revs.boundary = 1;
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
+	/*
+	 * Set boundary commits aside for the base check below, and put every
+	 * in-range commit but the tip into the interior set. A ref pointing
+	 * at an interior commit would dangle once the range is folded away.
+	 */
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
+	} else if (oldest == tip) {
+		ret = error(_("the revision range holds a single commit; "
+			      "nothing to squash"));
+		goto out;
+	} else if (!oldest->parents) {
+		BUG("an in-range commit must have a parent");
+	}
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
+static const char *autosquash_target(const char *subject)
+{
+	const char *rest;
+
+	while (skip_prefix(subject, "fixup! ", &rest) ||
+	       skip_prefix(subject, "squash! ", &rest) ||
+	       skip_prefix(subject, "amend! ", &rest))
+		subject = rest;
+	return subject;
+}
+
+static int reject_dangling_fixups(struct repository *repo,
+				  struct commit *base,
+				  struct commit *tip,
+				  struct commit *oldest,
+				  struct commit **msg_source,
+				  struct commit **amend_source)
+{
+	struct todo_list todo = TODO_LIST_INIT;
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	struct rev_info revs;
+	struct commit *commit, *last_amend = NULL;
+	struct strvec args = STRVEC_INIT;
+	char *dangling_subject = NULL, *dangling_target = NULL;
+	bool mixed_target = false, all_fixups_one_target;
+	bool past_oldest_group = false;
+	int i, ret, nr_dangling = 0;
+
+	*msg_source = oldest;
+	*amend_source = NULL;
+
+	repo_init_revisions(repo, &revs, NULL);
+	strvec_push(&args, "ignored");
+	strvec_push(&args, "--reverse");
+	strvec_push(&args, "--topo-order");
+	strvec_pushf(&args, "%s..%s", oid_to_hex(&base->object.oid),
+		     oid_to_hex(&tip->object.oid));
+	setup_revisions_from_strvec(&args, &revs, NULL);
+
+	if (prepare_revision_walk(&revs) < 0) {
+		ret = error(_("error preparing revisions"));
+		goto out;
+	}
+	while ((commit = get_revision(&revs)))
+		strbuf_addf(&todo.buf, "pick %s\n",
+			    oid_to_hex(&commit->object.oid));
+
+	if (todo_list_parse_insn_buffer(repo, &opts, todo.buf.buf, &todo) < 0 ||
+	    todo_list_rearrange_squash(&todo) < 0) {
+		ret = error(_("could not check the range for fixups"));
+		goto out;
+	}
+
+	for (i = 0; i < todo.nr; i++) {
+		const char *message, *subject_start, *target;
+		char *subject;
+		size_t sublen;
+
+		message = repo_logmsg_reencode(repo, todo.items[i].commit,
+					       NULL, NULL);
+		sublen = find_commit_subject(message, &subject_start);
+
+		if (todo.items[i].command != TODO_PICK) {
+			if (!past_oldest_group &&
+			    starts_with(subject_start, "amend! "))
+				*amend_source = todo.items[i].commit;
+			repo_unuse_commit_buffer(repo, todo.items[i].commit, message);
+			continue;
+		}
+		if (i)
+			past_oldest_group = true;
+
+		subject = xmemdupz(subject_start, sublen);
+		target = autosquash_target(subject);
+		if (target != subject) {
+			nr_dangling++;
+			if (!dangling_target) {
+				dangling_target = xstrdup(target);
+				dangling_subject = xstrdup(subject);
+			} else if (strcmp(dangling_target, target)) {
+				mixed_target = true;
+			}
+			if (starts_with(subject, "amend! "))
+				last_amend = todo.items[i].commit;
+		}
+		free(subject);
+		repo_unuse_commit_buffer(repo, todo.items[i].commit, message);
+	}
+
+	all_fixups_one_target = nr_dangling == todo.nr && !mixed_target;
+	if (nr_dangling && !all_fixups_one_target) {
+		ret = error(_("cannot squash '%s': its target is not in the "
+			      "range"), dangling_subject);
+	} else {
+		if (last_amend)
+			*msg_source = last_amend;
+		ret = 0;
+	}
+
+out:
+	free(dangling_subject);
+	free(dangling_target);
+	todo_list_release(&todo);
+	replay_opts_release(&opts);
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
+	struct strbuf message = STRBUF_INIT;
+	struct oidset interior = OIDSET_INIT;
+	struct commit *base, *oldest, *tip, *rewritten, *msg_source,
+		*amend_source;
+	const struct object_id *base_tree_oid, *tip_tree_oid;
+	const char *message_template = NULL;
+	struct commit_list *parents = NULL;
+	struct rev_info revs = { 0 };
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage,
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
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
+	ret = reject_dangling_fixups(repo, base, tip, oldest, &msg_source,
+				     &amend_source);
+	if (ret < 0)
+		goto out;
+	if (amend_source) {
+		const char *amend_message, *body;
+
+		amend_message = repo_logmsg_reencode(repo, amend_source,
+						     NULL, NULL);
+		find_commit_subject(amend_message, &body);
+		body = skip_blank_lines(body + commit_subject_length(body));
+		strbuf_addstr(&message, body);
+		message_template = message.buf;
+		repo_unuse_commit_buffer(repo, amend_source, amend_message);
+	}
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
+	ret = commit_tree_ext(repo, "squash", msg_source, message_template,
+			      parents,
+			      base_tree_oid, tip_tree_oid, &rewritten, flags);
+	if (ret < 0) {
+		ret = error(_("failed writing squashed commit"));
+		goto out;
+	}
+
+	strbuf_addstr(&reflog_msg, "squash: updating ");
+	strbuf_join_argv(&reflog_msg, argc, argv, ' ');
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
+	strbuf_release(&message);
+	oidset_clear(&interior);
+	commit_list_free(parents);
+	release_revisions(&revs);
+	return ret;
+}
+
 static int update_worktree(struct repository *repo,
 			   const struct commit *old_head,
 			   const struct commit *new_head,
@@ -1192,6 +1564,7 @@ int cmd_history(int argc,
 		GIT_HISTORY_FIXUP_USAGE,
 		GIT_HISTORY_REWORD_USAGE,
 		GIT_HISTORY_SPLIT_USAGE,
+		GIT_HISTORY_SQUASH_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -1200,6 +1573,7 @@ int cmd_history(int argc,
 		OPT_SUBCOMMAND("fixup", &fn, cmd_history_fixup),
 		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
+		OPT_SUBCOMMAND("squash", &fn, cmd_history_squash),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 8ae6ab6c5f..89cff16405 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -405,6 +405,7 @@ integration_tests = [
   't3452-history-split.sh',
   't3453-history-fixup.sh',
   't3454-history-drop.sh',
+  't3455-history-squash.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
new file mode 100755
index 0000000000..9c362f3094
--- /dev/null
+++ b/t/t3455-history-squash.sh
@@ -0,0 +1,569 @@
+#!/bin/sh
+
+test_description='tests for git-history squash subcommand'
+
+. ./test-lib.sh
+
+stage_file () {
+	printf "%s\n" "$1" >file &&
+	git add file
+}
+
+commit_with_message () {
+	printf "%b" "$1" >msg &&
+	git commit --allow-empty -qF msg
+}
+
+check_commit_count () {
+	git rev-list --count "$1" >actual &&
+	echo "$2" >expect &&
+	test_cmp expect actual
+}
+
+check_log_subjects () {
+	git log --format="%s" "$1" >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+check_log_messages () {
+	git log --format="%B" "$1" >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
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
+	git reflog -1 --format=%gs >actual &&
+	echo "squash: updating start..HEAD ^keep" >expect &&
+	test_cmp expect actual &&
+
+	check_log_subjects start..HEAD <<-\EOF &&
+	two
+	one
+	EOF
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
+	check_commit_count start..off-history 1 &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git branch -D off-history
+'
+
+test_expect_success 'squashes a range into a single commit without changing the tree' '
+	git reset --hard three &&
+	head_before=$(git rev-parse HEAD) &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --dry-run start.. >out &&
+	predicted=$(awk "/^update refs\/heads\// {print \$3}" out) &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git history squash start.. &&
+
+	test "$predicted" = "$(git rev-parse HEAD)" &&
+	check_commit_count start..HEAD 1 &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+	check_log_subjects -1 <<-\EOF &&
+	one
+	EOF
+	git reflog >reflog &&
+	test_grep "squash: updating" reflog
+'
+
+test_expect_success 'sanitizes rev-list walk options, before and after --' '
+	git reset --hard three &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --date-order start.. 2>err &&
+	test_grep "ignoring rev-list options" err &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+
+	git reset --hard three &&
+	git history squash -- --reverse start.. 2>err &&
+	test_grep "ignoring rev-list options" err &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'squashes an interior range and replays descendants verbatim' '
+	git reset --hard three &&
+	final_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash start..@~1 &&
+
+	check_log_subjects start..HEAD <<-\EOF &&
+	three
+	one
+	EOF
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
+	check_commit_count "$root..HEAD" 1 &&
+	test_cmp_rev "$root" HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+
+test_expect_success 'folds fixups whose target is in the range' '
+	git reset --hard start &&
+	test_commit --no-tag target file b &&
+	git commit --allow-empty -m "fixup! target" &&
+	git commit --allow-empty -m "fixup! target" &&
+	test_commit --no-tag later file c &&
+
+	git history squash start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	check_log_subjects -1 <<-\EOF
+	target
+	EOF
+'
+
+test_expect_success 'refuses a below-range fixup! after an in-range commit' '
+	git reset --hard start &&
+	test_commit --no-tag inside file b &&
+	test_commit --no-tag "fixup! outside" file c &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash start.. 2>err &&
+	test_grep "target is not in the range" err &&
+	test_cmp_rev "$head_before" HEAD
+'
+
+test_expect_success 'combines a run of fixups for one commit below the range' '
+	git reset --hard start &&
+	stage_file b && git commit -m "fixup! base" &&
+	stage_file c && git commit -m "fixup! base" &&
+
+	git history squash start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	check_log_subjects -1 <<-\EOF
+	fixup! base
+	EOF
+'
+
+test_expect_success 'combining below-range fixups keeps the last amend! message' '
+	git reset --hard start &&
+	stage_file b && git commit -m "fixup! base" &&
+	stage_file c &&
+	commit_with_message "amend! base\n\namended body\n" &&
+
+	git history squash start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	check_log_messages -1 <<-\EOF
+	amend! base
+
+	amended body
+
+	EOF
+'
+
+test_expect_success 'refuses fixups for two different commits below the range' '
+	git reset --hard start &&
+	stage_file b && git commit -m "fixup! aaa" &&
+	stage_file c && git commit -m "fixup! bbb" &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash start.. 2>err &&
+	test_grep "target is not in the range" err &&
+	test_cmp_rev "$head_before" HEAD
+'
+
+test_expect_success 'the last amend! for the oldest commit replaces its message' '
+	git reset --hard start &&
+	test_commit --no-tag marker-oldest file b &&
+	git commit --allow-empty -m "squash! marker-oldest" &&
+	commit_with_message "amend! marker-oldest\n\nearlier message\n" &&
+	commit_with_message \
+		"amend! marker-oldest\n\namended subject\n\namended body\n" &&
+	test_commit --no-tag marker-later file c &&
+	commit_with_message "amend! marker-later\n\nwrong message\n" &&
+
+	git history squash start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	check_log_messages -1 <<-\EOF
+	amended subject
+
+	amended body
+
+	EOF
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
+test_expect_success '--update-refs=head only moves HEAD' '
+	git reset --hard three &&
+	git branch -f other HEAD &&
+	other_before=$(git rev-parse other) &&
+
+	git history squash --update-refs=head start.. &&
+
+	check_commit_count start..HEAD 1 &&
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
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git -c advice.historyUpdateRefs=false \
+		history squash start.. 2>err &&
+	test_grep "points into the squashed range" err &&
+	test_grep ! "hint:" err &&
+	test_cmp_rev "$head_before" HEAD &&
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
+	check_commit_count start..HEAD 1 &&
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
+	check_commit_count start..HEAD 1 &&
+	check_log_subjects -1 <<-\EOF &&
+	before-side
+	EOF
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
+	check_commit_count start..HEAD 1 &&
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
+	check_commit_count start..HEAD 1 &&
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
+	check_commit_count "$base..HEAD" 1 &&
+	test_cmp_rev "$base" HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
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
+	check_commit_count start..HEAD 1 &&
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
+	check_commit_count start..HEAD 1 &&
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
+	check_commit_count start..HEAD 1 &&
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

