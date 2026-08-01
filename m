Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC8134EF1F
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567223; cv=none; b=Il86JiZHFEegAZgYPhUuomgrCia/sY+vMqcXpALzl821+YWW//hbKT4DClW8fXcJooTXfSbMksL97KV0eas5POXTjbwrfu3kxi0kY8qOdI+cRAOifgu4I0patmgYiJ1bomvgJb01my0zGoHnkbP7lveRGqu5hJQ5yFw+wiwLdeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567223; c=relaxed/simple;
	bh=O5o0kzRdqiZcyq+hCZDBdWjBWFWiUacnaDWNrDRSTuA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=it8f+sHg+8nTjI0gDXwsf6FoADPxANWoasKlDCVHmVxHUoDa3DX4NlPXeMcoLQIjniXDoSMM4bJpQqKVXjiK6K/llfwbfK0gllIT+OAvsdfFcma4aAtQWA48aJWLBspP93DeRw4itFiIKil9xnmZSqBQuDojmRe0kGxqINQ64Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sommmawp; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sommmawp"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1614223a91.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785567220; x=1786172020; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IaeKIr8AlKatd7c5z6oZkUw77z4Kr8Bjyq02RvShZYE=;
        b=sommmawpnIHE8pSI4jVZG5NbVju4Yj96iHaMhCmEupOvqxNoNthA5jhDQXIDGrYreC
         QEa4v8vfjpp1J6dYZ5UnabazDFsCuWEKWpJnPKrNeXMs87VLuxKXdWp9v4cem73f6pXG
         x2zyAwifqktaeo3kho2rA+WcgcC38I9KxWsVJBl19NBzDYpechrY8snzgoc767aU4wTI
         dAeXQrgojfXk1W8p40Xge3Ha0KXEfCcLsqQfkHrtnZ8CHZQDcE9MVUJVQIfIr9HVc3xy
         kOJjh6GdAjhPMpmZwb6xCD5sN0tj4SR4JO3C1rw826N2Ha4ZvnhK96TyXB6emiJnjg2b
         H/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785567220; x=1786172020;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IaeKIr8AlKatd7c5z6oZkUw77z4Kr8Bjyq02RvShZYE=;
        b=jMT1J9WvY6uVzHXc+8ZOHSRHCtexPlaoyAlv/M8uOy4XQ/jbkQW/kujQCNYoIRWcVS
         RdQs2bhtSVvNUGYwXwq6KKH4ewl7VRlCIDw9ykkyS6rhprE7oISNFkwBitcVX1d6PAPn
         f6vrTc3zvoWBiW0x6sGXVeW+e4rulSsakHEbr0HoIelpzKWXV3AnSjtOU9uz3/yIXojr
         fhMaWtgYZfG7MtbLfx82gB1nhaVpbhBsJx9QhqYCVgd26XD10Wb5pexH57h3H3p1Vt7D
         OTfPeys5BJdQ7N5sJx8B/hjej3G/54CuYL3IReriSKAa876z2MiASXg7SiSGVcYtd62Q
         wzTg==
X-Gm-Message-State: AOJu0YxuFxfbV5RFJzjLK7D+7rL72QNWdWc5rzFJq8E8j60PKVasAY3N
	NGawGkA1AIhGEugph8ws3NJhGdCLnTUyE7AfopzOi6Qp8/YuI3v3P2sXSGdW0OGd
X-Gm-Gg: AR+sD13IiBNDtmdQBVKGVPa6IGNwlKCr1g0rtf8y5HHnG6lGsx2BF/TNyPfHbL+bOmO
	90WE+DaIXmUCVpphE81ydqcrtKsw0FdDZJw7219ra2ii6mxljGFbIvAF/cO06NhNFkq0Pm19RFy
	7O1GsTQsLMc6S0uxOXbly2m6L75Hf/Y6fQxUlbvzaUE+TEAbUyl8DWTxyx9v2M16HnzK48uKFOU
	OQThHafqEX0CZhHMi27DtdwJOPXscitEi+Y51BM1PH+boEF3EZ+lM5x75vHd4j7uRupPdBOiY98
	jAmsF77+zgiyQ1OvVdyywujQ75VLlVA9s4fSRH5uvnpa5gJkL6ITVrvpCF6KuPveO9nuYUuzi5j
	2tmRDR7sPDIRSnrqFOxmVqt4g7oqjKrQH33mdRDLexO+YzxRUprs79nM7k+AC7cQuxb+6oPiQX4
	9c7TjylQvAYnDsgtQoiBSJgFt8QBAkU452boGVMN81Qq3Q6ATZTWYjGpuzFccoC4Q=
X-Received: by 2002:a17:90b:48d1:b0:37e:1430:769b with SMTP id 98e67ed59e1d1-38fbc51c244mr2324667a91.24.1785567219124;
        Fri, 31 Jul 2026 23:53:39 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.138.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2ce28c7sm1683886a91.16.2026.07.31.23.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:53:38 -0700 (PDT)
Message-Id: <7abda3643cd8811dd2259040f2ce7a1cafe5373b.1785567209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
References: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
	<pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Aug 2026 06:53:29 +0000
Subject: [PATCH v11 4/4] history: add squash subcommand to fold a range
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
every commit in the range into one commit, preserving the authorship of
the oldest commit and taking the tree of the tip, then replays commits
above the range. The editor opens with every folded message in the same
template used by "git rebase -i --autosquash". With --no-edit, the
oldest message is kept, or the last amend! replacement that targets it.

A fixup!, squash! or amend! commit is refused unless its target is also
in the range, so the fold does not silently absorb a marker intended for
another commit. As an exception, a range made up entirely of markers for
one target is combined, allowing a batch of related fixups to be
consolidated.

The range is read like the arguments to "git rev-list", so several
revisions such as "HEAD~3..HEAD ^topic" may be given, and rev-list
options are accepted too. Walk-order options needed by the fold are
restored after setup_revisions(), with a warning when an option changed
them. The selected graph must have one actual boundary and one actual
tip and must not reach a root. A merge inside the range is folded when
all selected history reaches the same boundary; otherwise the range has
more than one base and is rejected.

By default the command refuses when a local branch points inside the
range, because that branch cannot be replayed as a descendant of the
result. Tags and remote-tracking refs are left unchanged. Use
--update-refs=head to leave interior branches unchanged as well.

Inspired-by: Sergey Chernov <serega.morph@gmail.com>
Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  57 ++-
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 504 ++++++++++++++++++++
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 758 +++++++++++++++++++++++++++++++
 7 files changed, 1324 insertions(+), 2 deletions(-)
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
index 28b477cd37..12cf06c2c5 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -12,6 +12,7 @@ git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(
 git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
 git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
 git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
+git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>
 
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
@@ -113,6 +117,49 @@ linkgit:gitglossary[7].
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
+An editor opens pre-filled with the messages of all the folded commits so
+you can combine them. With `--no-edit`, the oldest commit's message is
+preserved instead, except that an `amend!` commit targeting it replaces its
+message. A merge commit inside the range is folded like any other, but the
+range must have a single base and a single tip. A range that reaches more
+than one entry point (for example a side branch that forked before the range
+and was later merged into it), or that selects two unmerged tips, is rejected.
++
+A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
+targets is also in the range, so the fold does not silently absorb a
+marker meant for a commit outside it. As an exception, a range made up entirely
+of markers for one target is combined into a single commit. With `--no-edit`,
+the last `amend!` message is used if there is one.
++
+The template mirrors `git rebase -i --autosquash`: each `fixup!`, `squash!`,
+or `amend!` is grouped under the commit it targets rather than shown in
+commit order. A `fixup!` message is dropped (commented out in full), a
+`squash!` keeps its body with only the marker subject commented, and an
+`amend!` replaces its target's message, unless a `squash!` folded into that
+target first, in which case it keeps its body like a `squash!`.
++
+A local branch that points at a commit inside the range cannot be rewritten
+as a descendant of the result, so with the default `--update-refs=branches`
+the command refuses. Rerun with `--update-refs=head` to rewrite only the
+current branch and leave such branches pointing at the old commits. Tags and
+remote-tracking refs are always left unchanged.
+
 OPTIONS
 -------
 
@@ -122,6 +169,12 @@ OPTIONS
 	objects will be written into the repository, so applying these printed
 	ref updates is generally safe.
 
+`--edit`::
+`--no-edit`::
+	For `squash`, open an editor to combine the messages of the folded commits.
+	This is the default; use `--no-edit` to keep the selected message
+	without opening an editor.
+
 `--reedit-message`::
 	Open an editor to modify the target commit's message.
 
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
index b592b98393..43714fcb56 100644
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
+	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -1004,6 +1007,505 @@ out:
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
+	struct commit_list *boundaries = NULL, *commits = NULL, *iter,
+		**commits_tail = &commits;
+	struct oidset selected = OIDSET_INIT, has_children = OIDSET_INIT;
+	struct strvec args = STRVEC_INIT;
+	bool reaches_root = false;
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
+	/* A squash range must name a bottom revision to reparent onto. */
+	for (i = 0; i < revs.cmdline.nr; i++)
+		if (revs.cmdline.rev[i].flags & BOTTOM)
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
+	/* Set boundary commits aside for the base check below. */
+	while ((commit = get_revision(&revs))) {
+		if (commit->object.flags & BOUNDARY) {
+			commit_list_insert(commit, &boundaries);
+			continue;
+		}
+		if (!oldest)
+			oldest = commit;
+		oidset_insert(&selected, &commit->object.oid);
+		commits_tail = commit_list_append(commit, commits_tail);
+	}
+
+	if (!oldest) {
+		ret = error(_("the revision range is empty"));
+		goto out;
+	} else if (!commits->next) {
+		ret = error(_("the revision range holds a single commit; "
+			      "nothing to squash"));
+		goto out;
+	}
+
+	/*
+	 * Find the selected commits that have selected children. The only
+	 * remaining commit must be the tip whose tree becomes the result.
+	 */
+	for (iter = commits; iter; iter = iter->next) {
+		struct commit_list *p;
+
+		if (!iter->item->parents)
+			reaches_root = true;
+		for (p = iter->item->parents; p; p = p->next)
+			if (oidset_contains(&selected, &p->item->object.oid))
+				oidset_insert(&has_children,
+					      &p->item->object.oid);
+	}
+	if (reaches_root) {
+		ret = error(_("the revision range reaches a root commit; "
+			      "cannot squash"));
+		goto out;
+	}
+	for (iter = commits; iter; iter = iter->next) {
+		if (oidset_contains(&has_children, &iter->item->object.oid))
+			continue;
+		if (tip) {
+			ret = error(_("the revision range has more than one tip; "
+				      "cannot squash"));
+			goto out;
+		}
+		tip = iter->item;
+	}
+
+	/* The range must reach exactly one commit outside it. */
+	if (!boundaries) {
+		ret = error(_("the revision range has no base; cannot squash"));
+		goto out;
+	}
+	base = boundaries->item;
+	for (iter = boundaries; iter; iter = iter->next) {
+		if (iter->item != base) {
+			ret = error(_("the revision range has more than one base; "
+				      "cannot squash"));
+			goto out;
+		}
+	}
+
+	for (iter = commits; iter; iter = iter->next)
+		if (iter->item != tip)
+			oidset_insert(interior_out, &iter->item->object.oid);
+
+	*base_out = base;
+	*oldest_out = oldest;
+	*tip_out = tip;
+	ret = 0;
+
+out:
+	commit_list_free(boundaries);
+	commit_list_free(commits);
+	oidset_clear(&selected);
+	oidset_clear(&has_children);
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
+			*amend_source = last_amend;
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
+static bool amend_replaces_target(struct todo_list *todo, int target)
+{
+	int i;
+
+	for (i = target + 1; i < todo->nr &&
+			     todo->items[i].command != TODO_PICK; i++) {
+		if (todo->items[i].command == TODO_SQUASH)
+			return false;
+		if (todo->items[i].flags & TODO_REPLACE_FIXUP_MSG)
+			return true;
+	}
+	return false;
+}
+
+static int build_squash_message(struct repository *repo,
+				struct commit *base,
+				struct commit *tip,
+				struct strbuf *out)
+{
+	struct rev_info revs;
+	struct commit *commit;
+	struct strvec args = STRVEC_INIT;
+	struct todo_list todo = TODO_LIST_INIT;
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	int i, nr_commits, ret;
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
+
+	while ((commit = get_revision(&revs)))
+		strbuf_addf(&todo.buf, "pick %s\n",
+			    oid_to_hex(&commit->object.oid));
+
+	if (todo_list_parse_insn_buffer(repo, &opts, todo.buf.buf, &todo) < 0 ||
+	    todo_list_rearrange_squash(&todo) < 0) {
+		ret = error(_("could not prepare the squash message"));
+		goto out;
+	}
+
+	nr_commits = todo.nr;
+	for (i = 0; i < nr_commits; i++) {
+		struct todo_item *item = &todo.items[i];
+		const char *message, *body;
+		size_t commented_len;
+		bool skip, squashing;
+
+		squashing = item->command == TODO_SQUASH ||
+			    (item->flags & TODO_REPLACE_FIXUP_MSG);
+		if (item->command == TODO_PICK)
+			skip = amend_replaces_target(&todo, i);
+		else
+			skip = !squashing;
+
+		message = repo_logmsg_reencode(repo, item->commit, NULL, NULL);
+		find_commit_subject(message, &body);
+
+		if (skip)
+			commented_len = strlen(body);
+		else if (squashing)
+			commented_len = squash_subject_comment_len(body, 1);
+		else
+			commented_len = 0;
+
+		if (!i)
+			add_squash_combination_header(out, nr_commits);
+		strbuf_addch(out, '\n');
+		add_squash_message_header(out, i + 1, skip);
+		strbuf_addstr(out, "\n\n");
+		strbuf_add_commented_lines(out, body, commented_len, comment_line_str);
+		strbuf_addstr(out, body + commented_len);
+		strbuf_complete_line(out);
+
+		repo_unuse_commit_buffer(repo, item->commit, message);
+	}
+
+	ret = 0;
+
+out:
+	todo_list_release(&todo);
+	replay_opts_release(&opts);
+	reset_revision_walk();
+	release_revisions(&revs);
+	strvec_clear(&args);
+	return ret;
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
+	int edit = 1;
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
+			       N_("control which refs should be updated"),
+			       PARSE_OPT_NONEG, parse_ref_action),
+		OPT_BOOL('n', "dry-run", &dry_run,
+			 N_("perform a dry-run without updating any refs")),
+		OPT_BOOL('e', "edit", &edit,
+			 N_("edit the commit message")),
+		OPT_END(),
+	};
+	struct strbuf reflog_msg = STRBUF_INIT;
+	struct strbuf message = STRBUF_INIT;
+	struct oidset interior = OIDSET_INIT;
+	struct commit *base = NULL, *oldest = NULL, *tip = NULL, *rewritten,
+		*amend_source = NULL;
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
+	ret = reject_dangling_fixups(repo, base, tip, &amend_source);
+	if (ret < 0)
+		goto out;
+	if (!edit && amend_source) {
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
+		refs_for_each_branch_ref(get_main_ref_store(repo),
+					 find_interior_ref, &cb);
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
+	if (edit) {
+		ret = build_squash_message(repo, base, tip, &message);
+		if (ret < 0)
+			goto out;
+		message_template = message.buf;
+		flags |= COMMIT_TREE_EDIT_MESSAGE;
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
+	ret = commit_tree_ext(repo, "squash", oldest, message_template,
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
@@ -1192,6 +1694,7 @@ int cmd_history(int argc,
 		GIT_HISTORY_FIXUP_USAGE,
 		GIT_HISTORY_REWORD_USAGE,
 		GIT_HISTORY_SPLIT_USAGE,
+		GIT_HISTORY_SQUASH_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
@@ -1200,6 +1703,7 @@ int cmd_history(int argc,
 		OPT_SUBCOMMAND("fixup", &fn, cmd_history_fixup),
 		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
+		OPT_SUBCOMMAND("squash", &fn, cmd_history_squash),
 		OPT_END(),
 	};
 
diff --git a/t/meson.build b/t/meson.build
index d8161c368b..797c5a75d1 100644
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
index 0000000000..0461046d85
--- /dev/null
+++ b/t/t3455-history-squash.sh
@@ -0,0 +1,758 @@
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
+	GIT_AUTHOR_NAME=Squasher GIT_AUTHOR_EMAIL=squash@example.com \
+		test_commit --no-tag one other x &&
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
+	git history squash --no-edit start..HEAD ^keep &&
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
+test_expect_success 'refuses a range with more than one tip' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag main-one file b &&
+	test_commit --no-tag main-two file c &&
+	git checkout -b other-tip start &&
+	test_commit --no-tag other-tip other d &&
+	git checkout "$main" &&
+	main_before=$(git rev-parse HEAD) &&
+	other_before=$(git rev-parse other-tip) &&
+
+	test_must_fail git history squash ^start HEAD other-tip 2>err &&
+	test_grep "more than one tip" err &&
+	test_cmp_rev "$main_before" HEAD &&
+	test_cmp_rev "$other_before" other-tip &&
+
+	git branch -D other-tip
+'
+
+test_expect_success 'refuses a range that reaches a root commit' '
+	git reset --hard three &&
+	root=$(printf "unrelated root\n" |
+		git commit-tree "$(git rev-parse HEAD^{tree})") &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash --ancestry-path="$root" \
+		^start HEAD "$root" 2>err &&
+	test_grep "reaches a root commit" err &&
+	test_cmp_rev "$head_before" HEAD
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
+	git history squash --no-edit start..off-history &&
+
+	check_commit_count start..off-history 1 &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git branch -D off-history
+'
+
+test_expect_success 'squashes a range preserving its tree and oldest authorship' '
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
+	git log -1 --format="%an <%ae>" >actual &&
+	echo "Squasher <squash@example.com>" >expect &&
+	test_cmp expect actual &&
+	git reflog >reflog &&
+	test_grep "squash: updating" reflog
+'
+
+test_expect_success 'sanitizes rev-list walk options, before and after --' '
+	git reset --hard three &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit --date-order start.. 2>err &&
+	test_grep "ignoring rev-list options" err &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
+
+	git reset --hard three &&
+	git history squash --no-edit -- --reverse start.. 2>err &&
+	test_grep "ignoring rev-list options" err &&
+	test_cmp_rev start HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
+'
+
+test_expect_success 'squashes an interior range and replays descendants verbatim' '
+	git reset --hard three &&
+	final_tree=$(git rev-parse HEAD^{tree}) &&
+
+	git history squash --no-edit start..@~1 &&
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
+	git history squash --no-edit "$root.." &&
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
+	git history squash --no-edit start.. &&
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
+	git history squash --no-edit start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	check_log_subjects -1 <<-\EOF
+	fixup! base
+	EOF
+'
+
+test_expect_success 'combining below-range markers offers every message' '
+	git reset --hard start &&
+	stage_file b && git commit -m "fixup! base" &&
+	stage_file c &&
+	commit_with_message "amend! base\n\namended body\n" &&
+
+	git history squash start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	check_log_messages -1 <<-\EOF
+	fixup! base
+
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
+test_expect_success 'does not discard squash! or amend! message bodies' '
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
+	marker-oldest
+
+	earlier message
+
+	amended subject
+
+	amended body
+
+	wrong message
+
+	EOF
+'
+
+test_expect_success '--no-edit keeps the selected message without an editor' '
+	git reset --hard start &&
+	test_commit --no-tag no-edit-target file b &&
+	git commit --allow-empty -m "squash! no-edit-target" &&
+	commit_with_message "amend! no-edit-target\n\namended subject\n\namended body\n" &&
+
+	write_script editor <<-\EOF &&
+	exit 1
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash --no-edit start.. &&
+
+	check_log_messages -1 <<-\EOF &&
+	amended subject
+
+	amended body
+
+	EOF
+	test_set_editor :
+'
+
+test_expect_success 'edits every message and aborts on an empty result' '
+	git reset --hard start &&
+	stage_file b &&
+	git commit -m "re-one subject" -m "re-one body line" &&
+	test_commit --no-tag re-two file c &&
+	test_commit re-three file d &&
+	head_before=$(git rev-parse HEAD) &&
+
+	write_script empty-editor <<-\EOF &&
+	>"$1"
+	EOF
+	test_set_editor "$(pwd)/empty-editor" &&
+	test_must_fail git history squash start.. 2>err &&
+	test_grep "Aborting commit due to empty commit message" err &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited &&
+	echo combined >"$1"
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 3 commits.
+	# This is the 1st commit message:
+
+	re-one subject
+
+	re-one body line
+
+	# This is the commit message #2:
+
+	re-two
+
+	# This is the commit message #3:
+
+	re-three
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited &&
+	check_log_subjects -1 <<-\EOF
+	combined
+	EOF
+'
+
+test_expect_success 'handles fixup!, squash! and amend! messages like rebase' '
+	git reset --hard start &&
+	test_commit --no-tag mark-base file b &&
+	stage_file c &&
+	commit_with_message "fixup! mark-base\n\nfixup body\n" &&
+	stage_file d &&
+	commit_with_message "squash! mark-base\n\nsquash remark\n" &&
+	stage_file e &&
+	commit_with_message "amend! mark-base\n\namended message\n" &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 4 commits.
+	# This is the 1st commit message:
+
+	mark-base
+
+	# The commit message #2 will be skipped:
+
+	# fixup! mark-base
+	#
+	# fixup body
+
+	# This is the commit message #3:
+
+	# squash! mark-base
+
+	squash remark
+
+	# This is the commit message #4:
+
+	# amend! mark-base
+
+	amended message
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited &&
+	check_log_messages -1 <<-\EOF
+	mark-base
+
+	squash remark
+
+	amended message
+
+	EOF
+'
+
+test_expect_success 'groups fixups under their targets in the editor' '
+	git reset --hard start &&
+	test_commit --no-tag alpha file a1 &&
+	test_commit --no-tag beta file b1 &&
+	stage_file a2 &&
+	commit_with_message "fixup! alpha\n" &&
+	stage_file b2 &&
+	commit_with_message "fixup! beta\n" &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 4 commits.
+	# This is the 1st commit message:
+
+	alpha
+
+	# The commit message #2 will be skipped:
+
+	# fixup! alpha
+
+	# This is the commit message #3:
+
+	beta
+
+	# The commit message #4 will be skipped:
+
+	# fixup! beta
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited
+'
+
+test_expect_success 'lets amend! replace its target message in the editor' '
+	git reset --hard start &&
+	test_commit --no-tag mark-base file b &&
+	stage_file c &&
+	commit_with_message "amend! mark-base\n\namended message\n" &&
+	stage_file d &&
+	commit_with_message "squash! mark-base\n\nsquash remark\n" &&
+
+	write_script editor <<-\EOF &&
+	cat "$1" >edited
+	EOF
+	test_set_editor "$(pwd)/editor" &&
+	git history squash start.. &&
+
+	cat >expect <<-EOF &&
+	# This is a combination of 3 commits.
+	# The 1st commit message will be skipped:
+
+	# mark-base
+
+	# This is the commit message #2:
+
+	# amend! mark-base
+
+	amended message
+
+	# This is the commit message #3:
+
+	# squash! mark-base
+
+	squash remark
+
+	# Please enter the commit message for the squash changes. Lines starting
+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+	# Changes to be committed:
+	#	modified:   file
+	#
+	EOF
+	test_cmp expect edited &&
+	check_log_messages -1 <<-\EOF
+	amended message
+
+	squash remark
+
+	EOF
+'
+
+test_expect_success 'handles branches pointing at the squashed range' '
+	git reset --hard three &&
+	git branch -f other HEAD &&
+	git branch -f mid HEAD~1 &&
+	other_before=$(git rev-parse other) &&
+	mid_before=$(git rev-parse mid) &&
+	head_before=$(git rev-parse HEAD) &&
+
+	test_must_fail git history squash start.. 2>err &&
+	test_grep "error: .* points into the squashed range" err &&
+	test_grep "hint: .*--update-refs=head" err &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	test_must_fail git -c advice.historyUpdateRefs=false \
+		history squash start.. 2>err &&
+	test_grep "points into the squashed range" err &&
+	test_grep ! "hint:" err &&
+	test_cmp_rev "$head_before" HEAD &&
+
+	git history squash --no-edit --update-refs=head start.. &&
+
+	check_commit_count start..HEAD 1 &&
+	test_cmp_rev "$other_before" other &&
+	test_cmp_rev "$mid_before" mid &&
+
+	git branch -D other mid
+'
+
+test_expect_success 'leaves tags and remote-tracking refs unchanged' '
+	git reset --hard three &&
+	git tag -f mark HEAD~1 &&
+	git update-ref refs/remotes/origin/mark HEAD~1 &&
+	mark_before=$(git rev-parse mark) &&
+
+	git history squash --no-edit start.. &&
+
+	test_cmp_rev "$mark_before" mark &&
+	test_cmp_rev "$mark_before" refs/remotes/origin/mark &&
+
+	git tag -d mark &&
+	git update-ref -d refs/remotes/origin/mark
+'
+
+test_expect_success 'handles a branch pointing at an internal merge' '
+	git reset --hard start &&
+	main=$(git symbolic-ref --short HEAD) &&
+	test_commit --no-tag before-side file b &&
+	git checkout -b inner-side &&
+	test_commit --no-tag on-inner-side inner x &&
+	git checkout "$main" &&
+	test_commit --no-tag after-side file c &&
+	git merge --no-ff -m merge inner-side &&
+	git branch -D inner-side &&
+	git branch at-merge HEAD &&
+	test_commit --no-tag after-merge file d &&
+	head_before=$(git rev-parse HEAD) &&
+	tip_tree=$(git rev-parse HEAD^{tree}) &&
+
+	test_must_fail git history squash start.. 2>err &&
+	test_grep "at-merge" err &&
+	test_grep "points into the squashed range" err &&
+	test_cmp_rev "$head_before" HEAD &&
+	git branch -D at-merge &&
+
+	git history squash --no-edit start.. &&
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
+	git history squash --no-edit start.. &&
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
+	git history squash --no-edit start.. &&
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
+	git history squash --no-edit "$base.." &&
+
+	check_commit_count "$base..HEAD" 1 &&
+	test_cmp_rev "$base" HEAD^ &&
+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
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
+	git history squash --no-edit start.. &&
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
+	git history squash --no-edit start.. &&
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
+	test_must_fail git history squash --no-edit start..desc-tip 2>err &&
+	test_grep "merge commits is not supported" err &&
+	test_cmp_rev "$head_before" HEAD
+'
+
+test_done
-- 
gitgitgadget
