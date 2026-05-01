Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81BF20299B
	for <git@vger.kernel.org>; Fri,  1 May 2026 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777671343; cv=none; b=gcNGR0AAZnaNbjRhSSJ3kA+fvuXIP+aIUrOPF5ccEe6OdDbdkfnu+nXW2SY2n2tDAzJMaegc5v+TSkPZ3rpbQLfF3e/B+V1d6QRwXz/pq4n8HOnUf5KRpZU2Ll3WCUtR0VuJG1j82xH/TTaj+8djQ2agumvYd7kdJdyqSdjWVec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777671343; c=relaxed/simple;
	bh=Z4UAbYvK9EHdLmXGVGv2Lue6rqs917Ww/d3z5S3YCJA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=oivbznTNWL3UeICt/7xkfNSI426SDLZJX00apGxWTROyahfU/JtvlVlE3do8QoYZadorxRllga954Ge0oqze0CCpirY8qGNuHSYuCm7EqSpsrh41w2v4KujY2AhRjl8Gp269t/MtDXYH5ruSCzjUdtwH3e9P/RqQ8Cl6DsZN3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joR77bde; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joR77bde"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ea8563c693so268390785a.2
        for <git@vger.kernel.org>; Fri, 01 May 2026 14:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777671339; x=1778276139; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FBLoSRbWO8JDRJ87v+c0vSlHmKDiLRJmXVjsbcecKfg=;
        b=joR77bdevIOXvAK07qKIh+cNeR/edJ59F+RL/wgQis3LXdx9iVEzhNuG/Usqs0KOJm
         tFOuutBJkM/lHeRBFOaOHfuB4ixvDoSH8gMRvfkvGLoipMY2CKj47gIEVx+uMbZr2bK0
         87+hyi8fUHjI2lzDYVaATWySZK/rWz5dTsI0mScKVEwNRz9DW2Dp76XzWYt2fVirbpUo
         lqP0Jrc/yVAgcyXVCwCUhdK7q9uhZkDWAyMLOu4U2g19oNSKgPqHSwRQXFibFWB0cJG6
         7l06yhjY0CkfuhuBSzIjEM1xL0wO3VYLvUwB8P2zwUMlAXvWPwbweUTp6UKAkzstqcfJ
         eSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777671339; x=1778276139;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBLoSRbWO8JDRJ87v+c0vSlHmKDiLRJmXVjsbcecKfg=;
        b=sMV0Wh+ObsiicKHFxfPF/KKE1KBdEEFPEXXahlnj+qEicSgeuW03FZBVjCNVfFyYrF
         LUIV90pcwt6CZMGANsZKLgn2/91EdRmpQ3mWmd1I1xD6CGnckxSaA61uEfIpQSYJYCgT
         YEEwlP1R5/zbpEKB+DjYPrzw3HT2igXJBNwv4CkuxC0Me5gG+0dVvf4vDPyHp0DHvusV
         E39v6YWhf9PP+Ddv2jEbDaRu8jGkqf/9IKHkDFje+0kuS7F33HnuE8QOV843loiS2Gjh
         I96+iDyptxc9dwIXYlDBLlcmQdOKhQL1k0FK/pXjWzPsqAuqcL/OdtqV9PE1Xwnjtc32
         Sw6g==
X-Gm-Message-State: AOJu0Yw7tzX+Sx+qjQUHw2qpYvaeYwAmyd6fp5ofYy6cMfYG3j48Fg0I
	hGGcPkpA9zjtSXUwBjfxjc6X3bM0VAz9VmtdhFCKgEf6JbFFTA52zE76ETArGQ==
X-Gm-Gg: AeBDietOVkJ8KgQkVVDvAGVhpRL3lsg4hkaFZ0vKbWwD+1iEmf4ySMSpKhUKGwhXEIP
	g5t56UPeRgP2Swyuo+0pRyCJLg9rVe90YokNVCRPLJ86q6RFdHOL2KAOGfD/yFFYSs4+uBE5vKO
	v5RYz/oO9JGSAErxFPgZ0oA4eI/oUrhm/jA9kCUL79M/iYMD3jLJFGdEq2cm0ybs2zST4R8oUiB
	ShlwI0iGLK4EN7YdDI2b23FQBUeCYqp+dkfUAaVSaRFC4rJanR3t/KPtFLyylhAv6FjeizH+jqS
	xq/rPmUacmX5kYDtFRm6HnsnzSTtQYjodwuz/xfTyooT3zfXoN96soTKY5I26hEu1TNoIDS6mrs
	7V/NLM/EJQ6hCcIxGnpDThjyw1VrZ87xt3Qkb5B9I/xzDKLclPugYxhW39dO8sJZwkHmc7z62uo
	uKYfXpgHW/OkfvUQHK4sIc5R88SYxk8Rr8QdA=
X-Received: by 2002:a05:620a:4706:b0:8cd:b70b:fd00 with SMTP id af79cd13be357-8fd161c91fbmr185510685a.16.1777671339198;
        Fri, 01 May 2026 14:35:39 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.79.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29383f59sm268624785a.3.2026.05.01.14.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 14:35:38 -0700 (PDT)
Message-Id: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 May 2026 21:35:37 +0000
Subject: [PATCH] fetch: add fetch.pruneLocalBranches config
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

Introduce a tri-state config option that, when --prune (or
fetch.prune / remote.<name>.prune) removes a remote-tracking
ref, also deletes local branches whose configured upstream is
that ref.

Values:
- false (default): no change in behavior.
- safe: delete only if the local tip is reachable from the
  upstream tip, preserving any unpushed work.
- force: delete unconditionally; recoverable only via reflog.

The currently checked-out branch is always preserved.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    fetch: add fetch.pruneBranches config

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v1
Pull-Request: https://github.com/git/git/pull/2285

 Documentation/config/fetch.adoc  |  39 +++++++
 Documentation/config/remote.adoc |   7 ++
 Documentation/fetch-options.adoc |   9 ++
 Documentation/git-fetch.adoc     |   6 ++
 builtin/fetch.c                  | 172 ++++++++++++++++++++++++++++++-
 remote.c                         |  16 +++
 remote.h                         |  10 ++
 t/t5510-fetch.sh                 |  84 +++++++++++++++
 8 files changed, 339 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
index cd40db0cad..5a60507a84 100644
--- a/Documentation/config/fetch.adoc
+++ b/Documentation/config/fetch.adoc
@@ -50,6 +50,45 @@
 	refs. See also `remote.<name>.pruneTags` and the PRUNING
 	section of linkgit:git-fetch[1].
 
+`fetch.pruneBranches`::
+	When set in addition to `fetch.prune` (or `--prune`), also
+	delete local branches whose configured upstream
+	(`branch.<name>.merge`) is one of the remote-tracking refs
+	just removed by pruning. This is useful for cleaning up topic
+	branches whose upstream counterpart has been merged and then
+	removed. The same effect can be requested per-invocation with
+	`--prune-branches[=<mode>]`, or per-remote with
+	`remote.<name>.pruneBranches`.
++
+The currently checked-out branch (in any worktree) is never
+deleted. The value is one of:
++
+--
+`false` (the default);;
+	Do not delete any local branches. Equivalent to leaving
+	the option unset.
+`safe`;;
+	Delete a local branch only if its tip is an ancestor of
+	the upstream remote-tracking ref's last-known position.
+	In other words, only delete the branch if it contains no
+	commits that the upstream did not also have at the moment
+	it was deleted. This catches the common case of a branch
+	that was pushed and then squash- or rebase-merged
+	upstream (the local branch has no extra commits beyond
+	what was pushed), but preserves any branch with unpushed
+	local work.
+`force`;;
+	Delete the local branch unconditionally, even if it
+	contains unpushed commits. Use with care: if a remote
+	branch is deleted for any reason other than that its
+	contents were merged, the corresponding local commits
+	will only be retrievable through the reflog.
+--
++
+This option has no effect unless pruning is also enabled, since
+local branches are only considered for deletion when their
+upstream remote-tracking ref is being pruned in the same fetch.
+
 `fetch.all`::
 	If true, fetch will attempt to update all available remotes.
 	This behavior can be overridden by passing `--no-all` or by
diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 91e46f66f5..60fd5841c6 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -87,6 +87,13 @@ remote.<name>.pruneTags::
 See also `remote.<name>.prune` and the PRUNING section of
 linkgit:git-fetch[1].
 
+remote.<name>.pruneBranches::
+	When pruning is active for this remote and this is set to `safe`
+	or `force`, also delete local branches whose upstream
+	remote-tracking ref is being pruned. Overrides
+	`fetch.pruneBranches` settings, if any. See `fetch.pruneBranches`
+	for the meaning of the values.
+
 remote.<name>.promisor::
 	When set to true, this remote will be used to fetch promisor
 	objects.
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 81a9d7f9bb..0764f67cc3 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -185,6 +185,15 @@ See the PRUNING section below for more details.
 +
 See the PRUNING section below for more details.
 
+`--prune-branches[=(safe|force)]`::
+	When pruning, also delete local branches whose configured
+	upstream (`branch.<name>.merge`) is one of the remote-tracking
+	refs being pruned. With no value or `safe`, refuse to delete a
+	branch with unpushed commits; with `force`, delete it
+	regardless. The currently checked-out branch is never
+	deleted. See `fetch.pruneBranches` in linkgit:git-config[1] for
+	details.
+
 endif::git-pull[]
 
 ifndef::git-pull[]
diff --git a/Documentation/git-fetch.adoc b/Documentation/git-fetch.adoc
index db03541915..a50b9672a1 100644
--- a/Documentation/git-fetch.adoc
+++ b/Documentation/git-fetch.adoc
@@ -179,6 +179,12 @@ It's reasonable to e.g. configure `fetch.pruneTags=true` in
 run, without making every invocation of `git fetch` without `--prune`
 an error.
 
+Local branches whose upstream remote-tracking ref is being pruned can
+also be deleted automatically with `--prune-branches[=<mode>]` (or its
+config equivalents `fetch.pruneBranches` and `remote.<name>.pruneBranches`).
+See linkgit:git-config[1] for the data-loss tradeoff between the
+`safe` and `force` modes.
+
 Pruning tags with `--prune-tags` also works when fetching a URL
 instead of a named remote. These will all prune tags not found on
 origin:
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a22c319467..c6c2f00be0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -82,6 +82,21 @@ static int prune = -1; /* unspecified */
 static int prune_tags = -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
 
+static int prune_branches = PRUNE_BRANCHES_UNSPECIFIED;
+
+static int parse_prune_branches_opt(const struct option *opt,
+				    const char *arg, int unset)
+{
+	int *v = opt->value;
+	if (unset)
+		*v = PRUNE_BRANCHES_OFF;
+	else if (arg)
+		*v = parse_prune_branches_value(opt->long_name, arg);
+	else
+		*v = PRUNE_BRANCHES_SAFE;
+	return 0;
+}
+
 static int append, dry_run, force, keep, update_head_ok;
 static int write_fetch_head = 1;
 static int verbosity, deepen_relative, set_upstream, refetch;
@@ -105,6 +120,7 @@ struct fetch_config {
 	int all;
 	int prune;
 	int prune_tags;
+	enum prune_branches_mode prune_branches;
 	int show_forced_updates;
 	int recurse_submodules;
 	int parallel;
@@ -131,6 +147,11 @@ static int git_fetch_config(const char *k, const char *v,
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.prunebranches")) {
+		fetch_config->prune_branches = parse_prune_branches_value(k, v);
+		return 0;
+	}
+
 	if (!strcmp(k, "fetch.showforcedupdates")) {
 		fetch_config->show_forced_updates = git_config_bool(k, v);
 		return 0;
@@ -1445,7 +1466,8 @@ out:
 static int prune_refs(struct display_state *display_state,
 		      struct refspec *rs,
 		      struct ref_transaction *transaction,
-		      struct ref *ref_map)
+		      struct ref *ref_map,
+		      struct ref **stale_refs_out)
 {
 	int result = 0;
 	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
@@ -1487,7 +1509,126 @@ static int prune_refs(struct display_state *display_state,
 cleanup:
 	string_list_clear(&refnames, 0);
 	strbuf_release(&err);
-	free_refs(stale_refs);
+	if (!result && stale_refs_out)
+		*stale_refs_out = stale_refs;
+	else
+		free_refs(stale_refs);
+	return result;
+}
+
+struct prune_branches_cb {
+	struct string_list *pruned_refs;
+	struct string_list *to_delete;
+	struct string_list *skipped_unmerged;
+	enum prune_branches_mode mode;
+};
+
+static int collect_branches_to_prune(const struct reference *ref, void *cb_data)
+{
+	struct prune_branches_cb *cb = cb_data;
+	const char *short_name = ref->name;
+	char *full_ref = xstrfmt("refs/heads/%s", short_name);
+	const char *upstream;
+	struct string_list_item *pruned;
+	int result = 0;
+
+	if (ref->flags & REF_ISSYMREF)
+		goto out;
+	if (branch_checked_out(full_ref))
+		goto out;
+
+	upstream = branch_get_upstream(branch_get(short_name), NULL);
+	if (!upstream)
+		goto out;
+
+	pruned = string_list_lookup(cb->pruned_refs, upstream);
+	if (!pruned)
+		goto out;
+
+	if (cb->mode == PRUNE_BRANCHES_SAFE) {
+		struct commit *local = lookup_commit_reference(the_repository,
+							       ref->oid);
+		struct commit *up = lookup_commit_reference(the_repository,
+							    pruned->util);
+		int reachable = local && up &&
+			repo_in_merge_bases(the_repository, local, up);
+
+		if (reachable < 0) {
+			result = -1;
+			goto out;
+		}
+		if (!reachable) {
+			string_list_append(cb->skipped_unmerged, short_name);
+			goto out;
+		}
+	}
+
+	string_list_append(cb->to_delete, full_ref);
+
+out:
+	free(full_ref);
+	return result;
+}
+
+static int do_prune_branches(struct display_state *display_state,
+			     struct ref *stale_refs,
+			     enum prune_branches_mode mode)
+{
+	struct string_list pruned_refs = STRING_LIST_INIT_NODUP;
+	struct string_list to_delete = STRING_LIST_INIT_DUP;
+	struct string_list skipped_unmerged = STRING_LIST_INIT_DUP;
+	struct prune_branches_cb cb = {
+		.pruned_refs = &pruned_refs,
+		.to_delete = &to_delete,
+		.skipped_unmerged = &skipped_unmerged,
+		.mode = mode,
+	};
+	struct ref *ref;
+	struct string_list_item *item;
+	int result = 0;
+
+	if (!stale_refs)
+		return 0;
+
+	for (ref = stale_refs; ref; ref = ref->next)
+		string_list_append(&pruned_refs, ref->name)->util = &ref->new_oid;
+	string_list_sort(&pruned_refs);
+
+	if (refs_for_each_branch_ref(get_main_ref_store(the_repository),
+				     collect_branches_to_prune, &cb)) {
+		result = -1;
+		goto cleanup;
+	}
+
+	if (!dry_run && to_delete.nr)
+		result = refs_delete_refs(get_main_ref_store(the_repository),
+					  "fetch: prune branches",
+					  &to_delete, REF_NO_DEREF);
+
+	if (verbosity >= 0) {
+		const struct object_id *zero = null_oid(the_repository->hash_algo);
+		for_each_string_list_item(item, &to_delete) {
+			const char *short_name;
+			if (skip_prefix(item->string, "refs/heads/", &short_name))
+				display_ref_update(display_state, '-',
+						   _("[deleted local]"), NULL,
+						   _("(none)"), short_name,
+						   zero, zero,
+						   transport_summary_width(NULL));
+		}
+	}
+	for_each_string_list_item(item, &skipped_unmerged)
+		warning(_("not deleting local branch '%s' that is not "
+			  "fully merged into its upstream;\n"
+			  "         set fetch.pruneBranches=force to "
+			  "delete anyway, or delete manually with "
+			  "'git branch -D %s'"),
+			item->string, item->string);
+
+cleanup:
+	string_list_clear(&pruned_refs, 0);
+	string_list_clear(&to_delete, 0);
+	string_list_clear(&skipped_unmerged, 0);
 	return result;
 }
 
@@ -1945,19 +2086,28 @@ static int do_fetch(struct transport *transport,
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 	if (prune) {
+		struct ref *stale_refs = NULL;
+		struct ref **stale_refs_out = prune_branches != PRUNE_BRANCHES_OFF
+			? &stale_refs : NULL;
 		/*
 		 * We only prune based on refspecs specified
 		 * explicitly (via command line or configuration); we
 		 * don't care whether --tags was specified.
 		 */
 		if (rs->nr) {
-			retcode = prune_refs(&display_state, rs, transaction, ref_map);
+			retcode = prune_refs(&display_state, rs, transaction,
+					     ref_map, stale_refs_out);
 		} else {
 			retcode = prune_refs(&display_state, &transport->remote->fetch,
-					     transaction, ref_map);
+					     transaction, ref_map, stale_refs_out);
 		}
 		if (retcode != 0)
 			retcode = 1;
+		else if (stale_refs &&
+			 do_prune_branches(&display_state, stale_refs,
+					   prune_branches))
+			retcode = 1;
+		free_refs(stale_refs);
 	}
 
 	/*
@@ -2419,6 +2569,16 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 			prune_tags = PRUNE_TAGS_BY_DEFAULT;
 	}
 
+	if (prune_branches == PRUNE_BRANCHES_UNSPECIFIED) {
+		/* no command line request */
+		if (remote->prune_branches >= 0)
+			prune_branches = remote->prune_branches;
+		else if (config->prune_branches >= 0)
+			prune_branches = config->prune_branches;
+		else
+			prune_branches = PRUNE_BRANCHES_OFF;
+	}
+
 	maybe_prune_tags = prune_tags_ok && prune_tags;
 	if (maybe_prune_tags && remote_via_config)
 		refspec_append(&remote->fetch, TAG_REFSPEC);
@@ -2469,6 +2629,7 @@ int cmd_fetch(int argc,
 		.display_format = DISPLAY_FORMAT_FULL,
 		.prune = -1,
 		.prune_tags = -1,
+		.prune_branches = PRUNE_BRANCHES_UNSPECIFIED,
 		.show_forced_updates = 1,
 		.recurse_submodules = RECURSE_SUBMODULES_DEFAULT,
 		.parallel = 1,
@@ -2520,6 +2681,9 @@ int cmd_fetch(int argc,
 			 N_("prune remote-tracking branches no longer on remote")),
 		OPT_BOOL('P', "prune-tags", &prune_tags,
 			 N_("prune local tags no longer on remote and clobber changed tags")),
+		OPT_CALLBACK_F(0, "prune-branches", &prune_branches, N_("mode"),
+			       N_("delete local branches whose upstream was pruned ('safe' or 'force')"),
+			       PARSE_OPT_OPTARG, parse_prune_branches_opt),
 		OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_cli, N_("on-demand"),
 			    N_("control recursive fetching of submodules"),
 			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
diff --git a/remote.c b/remote.c
index a664cd166a..1e2b4803e7 100644
--- a/remote.c
+++ b/remote.c
@@ -148,6 +148,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	CALLOC_ARRAY(ret, 1);
 	ret->prune = -1;  /* unspecified */
 	ret->prune_tags = -1;  /* unspecified */
+	ret->prune_branches = -1;  /* unspecified */
 	ret->name = xstrndup(name, len);
 	refspec_init_push(&ret->push);
 	refspec_init_fetch(&ret->fetch);
@@ -423,6 +424,19 @@ out:
 }
 #endif /* WITH_BREAKING_CHANGES */
 
+int parse_prune_branches_value(const char *k, const char *v)
+{
+	if (v) {
+		if (!strcasecmp(v, "safe"))
+			return PRUNE_BRANCHES_SAFE;
+		if (!strcasecmp(v, "force"))
+			return PRUNE_BRANCHES_FORCE;
+	}
+	if (git_parse_maybe_bool(v) == 0)
+		return PRUNE_BRANCHES_OFF;
+	die(_("invalid value for '%s': '%s'"), k, v);
+}
+
 static int handle_config(const char *key, const char *value,
 			 const struct config_context *ctx, void *cb)
 {
@@ -507,6 +521,8 @@ static int handle_config(const char *key, const char *value,
 		remote->prune = git_config_bool(key, value);
 	else if (!strcmp(subkey, "prunetags"))
 		remote->prune_tags = git_config_bool(key, value);
+	else if (!strcmp(subkey, "prunebranches"))
+		remote->prune_branches = parse_prune_branches_value(key, value);
 	else if (!strcmp(subkey, "url")) {
 		if (!value)
 			return config_error_nonbool(key);
diff --git a/remote.h b/remote.h
index fc052945ee..5b750c8229 100644
--- a/remote.h
+++ b/remote.h
@@ -28,6 +28,15 @@ enum {
 #endif /* WITH_BREAKING_CHANGES */
 };
 
+enum prune_branches_mode {
+	PRUNE_BRANCHES_UNSPECIFIED = -1,
+	PRUNE_BRANCHES_OFF = 0,
+	PRUNE_BRANCHES_SAFE,
+	PRUNE_BRANCHES_FORCE,
+};
+
+int parse_prune_branches_value(const char *k, const char *v);
+
 struct rewrite {
 	const char *base;
 	size_t baselen;
@@ -102,6 +111,7 @@ struct remote {
 	int mirror;
 	int prune;
 	int prune_tags;
+	int prune_branches;
 
 	/**
 	 * The configured helper programs to run on the remote side, for
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 6fe21e2b3a..5a2ff40132 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -386,6 +386,90 @@ test_expect_success REFFILES 'fetch --prune fails to delete branches' '
 	)
 '
 
+test_expect_success 'fetch.pruneBranches: setup parent' '
+	git init -b main prune-branches-parent &&
+	test_commit -C prune-branches-parent base
+'
+
+test_expect_success 'fetch.pruneBranches=safe deletes merged local branch' '
+	git -C prune-branches-parent branch doomed base &&
+	git clone prune-branches-parent prune-branches-safe &&
+	git -C prune-branches-safe checkout -b doomed --track origin/doomed &&
+	git -C prune-branches-safe checkout -b stay &&
+	git -C prune-branches-parent branch -D doomed &&
+	git -C prune-branches-safe -c fetch.pruneBranches=safe fetch --prune origin &&
+	test_must_fail git -C prune-branches-safe rev-parse refs/remotes/origin/doomed &&
+	test_must_fail git -C prune-branches-safe rev-parse refs/heads/doomed
+'
+
+test_expect_success 'fetch.pruneBranches=safe keeps unmerged local branch' '
+	git -C prune-branches-parent branch doomed base &&
+	git clone prune-branches-parent prune-branches-safe-unmerged &&
+	git -C prune-branches-safe-unmerged checkout -b doomed --track origin/doomed &&
+	test_commit -C prune-branches-safe-unmerged local-only &&
+	git -C prune-branches-safe-unmerged checkout -b stay &&
+	git -C prune-branches-parent branch -D doomed &&
+	git -C prune-branches-safe-unmerged -c fetch.pruneBranches=safe fetch --prune origin 2>err &&
+	test_must_fail git -C prune-branches-safe-unmerged rev-parse refs/remotes/origin/doomed &&
+	git -C prune-branches-safe-unmerged rev-parse refs/heads/doomed &&
+	test_grep "not fully merged" err
+'
+
+test_expect_success 'fetch.pruneBranches=force deletes unmerged local branch' '
+	git -C prune-branches-parent branch doomed base &&
+	git clone prune-branches-parent prune-branches-force &&
+	git -C prune-branches-force checkout -b doomed --track origin/doomed &&
+	test_commit -C prune-branches-force local-only-force &&
+	git -C prune-branches-force checkout -b stay &&
+	git -C prune-branches-parent branch -D doomed &&
+	git -C prune-branches-force -c fetch.pruneBranches=force fetch --prune origin &&
+	test_must_fail git -C prune-branches-force rev-parse refs/remotes/origin/doomed &&
+	test_must_fail git -C prune-branches-force rev-parse refs/heads/doomed
+'
+
+test_expect_success 'fetch.pruneBranches=force never deletes checked-out branch' '
+	git -C prune-branches-parent branch doomed base &&
+	git clone prune-branches-parent prune-branches-checked-out &&
+	git -C prune-branches-checked-out checkout -b doomed --track origin/doomed &&
+	git -C prune-branches-parent branch -D doomed &&
+	git -C prune-branches-checked-out -c fetch.pruneBranches=force fetch --prune origin &&
+	test_must_fail git -C prune-branches-checked-out rev-parse refs/remotes/origin/doomed &&
+	git -C prune-branches-checked-out rev-parse refs/heads/doomed
+'
+
+test_expect_success '--prune-branches deletes merged local branch' '
+	git -C prune-branches-parent branch doomed base &&
+	git clone prune-branches-parent prune-branches-cli &&
+	git -C prune-branches-cli checkout -b doomed --track origin/doomed &&
+	git -C prune-branches-cli checkout -b stay &&
+	git -C prune-branches-parent branch -D doomed &&
+	git -C prune-branches-cli fetch --prune --prune-branches origin &&
+	test_must_fail git -C prune-branches-cli rev-parse refs/heads/doomed
+'
+
+test_expect_success '--no-prune-branches overrides fetch.pruneBranches' '
+	git -C prune-branches-parent branch doomed base &&
+	git clone prune-branches-parent prune-branches-no-cli &&
+	git -C prune-branches-no-cli checkout -b doomed --track origin/doomed &&
+	git -C prune-branches-no-cli checkout -b stay &&
+	git -C prune-branches-no-cli config fetch.pruneBranches force &&
+	git -C prune-branches-parent branch -D doomed &&
+	git -C prune-branches-no-cli fetch --prune --no-prune-branches origin &&
+	git -C prune-branches-no-cli rev-parse refs/heads/doomed
+'
+
+test_expect_success 'remote.<name>.pruneBranches overrides fetch.pruneBranches' '
+	git -C prune-branches-parent branch doomed base &&
+	git clone prune-branches-parent prune-branches-per-remote &&
+	git -C prune-branches-per-remote checkout -b doomed --track origin/doomed &&
+	git -C prune-branches-per-remote checkout -b stay &&
+	git -C prune-branches-per-remote config fetch.pruneBranches force &&
+	git -C prune-branches-per-remote config remote.origin.pruneBranches false &&
+	git -C prune-branches-parent branch -D doomed &&
+	git -C prune-branches-per-remote fetch --prune origin &&
+	git -C prune-branches-per-remote rev-parse refs/heads/doomed
+'
+
 test_expect_success 'fetch --atomic works with a single branch' '
 	test_when_finished "rm -rf atomic" &&
 

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
