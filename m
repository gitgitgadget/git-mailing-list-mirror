Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA33E5EFB
	for <git@vger.kernel.org>; Mon,  4 May 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919255; cv=none; b=L86PuJ+x2WsDBS3dsCJ7LV1I9Rt1bfdsUifrSarsgf0Ij8qYYe6BfSODdS4u8Y2Y4nDA7jv26eYW5/roz2WPI1Q3ib2qQOV1JMF7+52TQ6NS7m9GjNDxrakFgc1nQdaAZbox1FWTkspa5WeDdPuPIrh2wDhEagIHmIWiCsdKmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919255; c=relaxed/simple;
	bh=ZEZsLlA+rppuizu9Il/VktBw8SfkrfGw/GMJBj7C/+A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b1jlckD5zKIZS2IwVzkC3P9ZzgWW0m+khM4poL9/PrgrqNeZPypuIIz4YmlsHWkk6knvK6XpBnmvF/8HJVdXEAEglLi0jG3lpeJ0/fhzgFHqfJDe1ZPgtnvycLyMmMwJEngQpf4YhXwvpReQM/GCWuJZtQdtcvVUJLkaTC68IVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2rJ6m1C; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2rJ6m1C"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-902deb2412fso71670985a.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 11:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777919252; x=1778524052; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LQHs2nxbwIWaSanqZ21k+/44EbhxR+4HfTu/Chgaq4=;
        b=M2rJ6m1CTjb0ZEaMEjPnYqYWAD5LklUq6Zj9LrmyI9LB6rmsFq0iOjgBz/Y+OE8rx2
         w+cstHaOWL4yn6pHfK9TOk8SMs2TamEL1sXOlggYVE9FxkQZeLJE7LfEYHgyGCTgEI7q
         wWOj+nxNCisPM82EXAqEQ4t7LK/nlwzaqvb6fUUYb2uNjsWHiCig5zYC1RKzK1sbVkFv
         qcJsznIfhDvx0bLq2nk6NtGBwFJl5HTGlmNiR+5MV5VMGGW7L2RmmZPCFORdhhXTkTRq
         LQQUQ00KkbS7J7SNj70DAyLtIVv3ceF2A+Tdoq6Rk1iwW04J3vHvN77Seyh2kBuAXSfp
         ndIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919252; x=1778524052;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7LQHs2nxbwIWaSanqZ21k+/44EbhxR+4HfTu/Chgaq4=;
        b=UVN6ld53RlM76YeNIc+/PvvGy8wsdOGpCgi4fO+E8cfTZyHLN0pFn02UdWVNMS5ToB
         LoJ00NjUdpfGC0sNcwomss72o8Ap0APxpL9gOEBQgP251jBldFV+1HJAQNE/pJsUoAnb
         LkjIHX8q9SFzIAR6b/cv5fHjWEUKN0QGLoE2vvZ6luz0BNS6H+1bblJwjDvDkt1HI2pq
         3fK9RvpEqNbnz8eEJAK5F60oOlY9j5lZx4adX53lX7Qr7bSX8Mz3seCmZcgtSgfBZa9q
         KYfiz/VMj0n87PN3JylIP+GFmJp3XHq5xJLKwIZYqoWWHjw6QidJ9ppfa1IBurKwyQtF
         OUhg==
X-Gm-Message-State: AOJu0YzgdTI6Yh1xZRB9f3VgdXjYneJpWT55RNQbR73xJPc/Y25w2dtB
	7NAiZ5W5oqSLB4GYv5BBPRkRvEX/u9aCEwcikRR5qkMnjyVkKYYrMazrlO3V8Q==
X-Gm-Gg: AeBDievHzc0L1Nr3qkq25cvq1np+z23cbnqXKEK2g3H1rQLXPL0iWenyn15QbEWZ47n
	qCRZp9qYh1Mb28MOMvWqkS2bBHMtWKTfw465Vfw1pJ6g6Wach7l8DNlafWvaTYjmFVlsDFkVuLb
	tpibhx30SCIP06RCiHeYopj8NQSoqMKEzwmRPLBWcb1dl3GzIok0/24tSqWCOnIebq9K7Rl0WE4
	cNTyyPyP9ZDpknTlZvWrDyUFtELNort3bODGOFw8EAWXAOsUisxTEQsGo22Bla0CD/vqBnlBC2L
	om8rcB2BklOQEU/H/ANkuvUF4YmIRMlgz9RrhOBAVdeE3VoBRR3FLL69zfNodaeprnoNcXCjNXd
	V8UrASaOYeZyuwl4LX5a60SW+X2R6dV/emJZtrStzDT2JLOM+MLw8J2HhADRYUGAp7+mhs14v/4
	lLMxwiHnOC5ZZfAotX6z80xpMXMJDcKExwIwg=
X-Received: by 2002:a05:620a:1a24:b0:8d6:2958:ec16 with SMTP id af79cd13be357-8fd18836253mr1691052485a.60.1777919251377;
        Mon, 04 May 2026 11:27:31 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.30.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29889603sm1118065985a.11.2026.05.04.11.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:27:30 -0700 (PDT)
Message-Id: <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 18:27:24 +0000
Subject: [PATCH v2 0/6] fetch: add fetch.pruneBranches config
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

 * The whole feature moved out of git fetch and into git branch. git fetch
   --prune-merged now just calls git branch --prune-merged after fetching.
 * The fetch.pruneLocalBranches and remote.<name>.pruneLocalBranches config
   options are gone, replaced by per-branch opt-out via
   branch.<name>.pruneMerged.
 * New git branch --forked <remote> lists local branches whose upstream
   lives on the given remote (read-only building block).
 * New git branch --prune-merged <remote> deletes those branches, but only
   if their tip is reachable from the upstream tracking ref; --force skips
   that safety check.
 * New git branch --all-remotes lets --forked/--prune-merged operate across
   every configured remote at once.
 * The currently checked-out branch in any worktree is always preserved.
 * branch.<name>.pruneMerged=false lets you exempt a branch (e.g. a
   long-running topic branch) even with --force; doesn't affect explicit git
   branch -d.
 * delete_branches() got a warn_only mode so bulk deletion prints a one-line
   warning per skipped branch instead of the noisy four-line hint that git
   branch -d shows.
 * New section in git-branch docs; git-fetch docs trimmed to just mention
   --prune-merged.
 * New tests in t3200-branch.sh for the new branch flags; t5510-fetch.sh
   shrunk since most logic moved.

Harald Nordgren (6):
  branch: add --forked <remote>
  branch: let delete_branches warn instead of error on bulk refusal
  branch: add --prune-merged <remote>
  fetch: add --prune-merged
  branch: add branch.<name>.pruneMerged opt-out
  branch: add --all-remotes flag

 Documentation/config/branch.adoc |   7 +
 Documentation/fetch-options.adoc |   8 +
 Documentation/git-branch.adoc    |  32 ++++
 builtin/branch.c                 | 247 +++++++++++++++++++++++++++++--
 builtin/fetch.c                  |  20 +++
 t/t3200-branch.sh                | 215 +++++++++++++++++++++++++++
 t/t5510-fetch.sh                 |  31 ++++
 7 files changed, 549 insertions(+), 11 deletions(-)


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v2
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v1:

 -:  ---------- > 1:  e9f8d06a2b branch: add --forked <remote>
 -:  ---------- > 2:  cd4a7e47af branch: let delete_branches warn instead of error on bulk refusal
 -:  ---------- > 3:  c0a5f69eb6 branch: add --prune-merged <remote>
 1:  14e3085ed2 ! 4:  e979fd238b fetch: add fetch.pruneLocalBranches config
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    fetch: add fetch.pruneLocalBranches config
     +    fetch: add --prune-merged
      
     -    Introduce a tri-state config option that, when --prune (or
     -    fetch.prune / remote.<name>.prune) removes a remote-tracking
     -    ref, also deletes local branches whose configured upstream is
     -    that ref.
     -
     -    Values:
     -    - false (default): no change in behavior.
     -    - safe: delete only if the local tip is reachable from the
     -      upstream tip, preserving any unpushed work.
     -    - force: delete unconditionally; recoverable only via reflog.
     -
     -    The currently checked-out branch is always preserved.
     +    After a successful fetch from a configured remote, run
     +    'git branch --prune-merged <remote>' to delete local branches
     +    whose push destination ref has just been pruned.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     - ## Documentation/config/fetch.adoc ##
     -@@
     - 	refs. See also `remote.<name>.pruneTags` and the PRUNING
     - 	section of linkgit:git-fetch[1].
     - 
     -+`fetch.pruneBranches`::
     -+	When set in addition to `fetch.prune` (or `--prune`), also
     -+	delete local branches whose configured upstream
     -+	(`branch.<name>.merge`) is one of the remote-tracking refs
     -+	just removed by pruning. This is useful for cleaning up topic
     -+	branches whose upstream counterpart has been merged and then
     -+	removed. The same effect can be requested per-invocation with
     -+	`--prune-branches[=<mode>]`, or per-remote with
     -+	`remote.<name>.pruneBranches`.
     -++
     -+The currently checked-out branch (in any worktree) is never
     -+deleted. The value is one of:
     -++
     -+--
     -+`false` (the default);;
     -+	Do not delete any local branches. Equivalent to leaving
     -+	the option unset.
     -+`safe`;;
     -+	Delete a local branch only if its tip is an ancestor of
     -+	the upstream remote-tracking ref's last-known position.
     -+	In other words, only delete the branch if it contains no
     -+	commits that the upstream did not also have at the moment
     -+	it was deleted. This catches the common case of a branch
     -+	that was pushed and then squash- or rebase-merged
     -+	upstream (the local branch has no extra commits beyond
     -+	what was pushed), but preserves any branch with unpushed
     -+	local work.
     -+`force`;;
     -+	Delete the local branch unconditionally, even if it
     -+	contains unpushed commits. Use with care: if a remote
     -+	branch is deleted for any reason other than that its
     -+	contents were merged, the corresponding local commits
     -+	will only be retrievable through the reflog.
     -+--
     -++
     -+This option has no effect unless pruning is also enabled, since
     -+local branches are only considered for deletion when their
     -+upstream remote-tracking ref is being pruned in the same fetch.
     -+
     - `fetch.all`::
     - 	If true, fetch will attempt to update all available remotes.
     - 	This behavior can be overridden by passing `--no-all` or by
     -
     - ## Documentation/config/remote.adoc ##
     -@@ Documentation/config/remote.adoc: remote.<name>.pruneTags::
     - See also `remote.<name>.prune` and the PRUNING section of
     - linkgit:git-fetch[1].
     - 
     -+remote.<name>.pruneBranches::
     -+	When pruning is active for this remote and this is set to `safe`
     -+	or `force`, also delete local branches whose upstream
     -+	remote-tracking ref is being pruned. Overrides
     -+	`fetch.pruneBranches` settings, if any. See `fetch.pruneBranches`
     -+	for the meaning of the values.
     -+
     - remote.<name>.promisor::
     - 	When set to true, this remote will be used to fetch promisor
     - 	objects.
     -
       ## Documentation/fetch-options.adoc ##
      @@ Documentation/fetch-options.adoc: See the PRUNING section below for more details.
       +
       See the PRUNING section below for more details.
       
     -+`--prune-branches[=(safe|force)]`::
     -+	When pruning, also delete local branches whose configured
     -+	upstream (`branch.<name>.merge`) is one of the remote-tracking
     -+	refs being pruned. With no value or `safe`, refuse to delete a
     -+	branch with unpushed commits; with `force`, delete it
     -+	regardless. The currently checked-out branch is never
     -+	deleted. See `fetch.pruneBranches` in linkgit:git-config[1] for
     -+	details.
     ++`--prune-merged`::
     ++	After a successful fetch, run `git branch --prune-merged
     ++	<remote>` for the fetched remote, deleting local branches
     ++	that fork from this remote and whose tip is reachable from
     ++	their upstream remote-tracking ref. See linkgit:git-branch[1]
     ++	for the exact selection rules. The currently checked-out
     ++	branch is always preserved.
      +
       endif::git-pull[]
       
       ifndef::git-pull[]
      
     - ## Documentation/git-fetch.adoc ##
     -@@ Documentation/git-fetch.adoc: It's reasonable to e.g. configure `fetch.pruneTags=true` in
     - run, without making every invocation of `git fetch` without `--prune`
     - an error.
     - 
     -+Local branches whose upstream remote-tracking ref is being pruned can
     -+also be deleted automatically with `--prune-branches[=<mode>]` (or its
     -+config equivalents `fetch.pruneBranches` and `remote.<name>.pruneBranches`).
     -+See linkgit:git-config[1] for the data-loss tradeoff between the
     -+`safe` and `force` modes.
     -+
     - Pruning tags with `--prune-tags` also works when fetching a URL
     - instead of a named remote. These will all prune tags not found on
     - origin:
     -
       ## builtin/fetch.c ##
      @@ builtin/fetch.c: static int prune = -1; /* unspecified */
       static int prune_tags = -1; /* unspecified */
       #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
       
     -+static int prune_branches = PRUNE_BRANCHES_UNSPECIFIED;
     -+
     -+static int parse_prune_branches_opt(const struct option *opt,
     -+				    const char *arg, int unset)
     -+{
     -+	int *v = opt->value;
     -+	if (unset)
     -+		*v = PRUNE_BRANCHES_OFF;
     -+	else if (arg)
     -+		*v = parse_prune_branches_value(opt->long_name, arg);
     -+	else
     -+		*v = PRUNE_BRANCHES_SAFE;
     -+	return 0;
     -+}
     ++static int prune_merged;
      +
       static int append, dry_run, force, keep, update_head_ok;
       static int write_fetch_head = 1;
       static int verbosity, deepen_relative, set_upstream, refetch;
     -@@ builtin/fetch.c: struct fetch_config {
     - 	int all;
     - 	int prune;
     - 	int prune_tags;
     -+	enum prune_branches_mode prune_branches;
     - 	int show_forced_updates;
     - 	int recurse_submodules;
     - 	int parallel;
     -@@ builtin/fetch.c: static int git_fetch_config(const char *k, const char *v,
     - 		return 0;
     - 	}
     +@@ builtin/fetch.c: static void add_options_to_argv(struct strvec *argv,
     + 		strvec_push(argv, prune ? "--prune" : "--no-prune");
     + 	if (prune_tags != -1)
     + 		strvec_push(argv, prune_tags ? "--prune-tags" : "--no-prune-tags");
     ++	if (prune_merged)
     ++		strvec_push(argv, "--prune-merged");
     + 	if (update_head_ok)
     + 		strvec_push(argv, "--update-head-ok");
     + 	if (force)
     +@@ builtin/fetch.c: static inline void fetch_one_setup_partial(struct remote *remote,
     + 	return;
     + }
       
     -+	if (!strcmp(k, "fetch.prunebranches")) {
     -+		fetch_config->prune_branches = parse_prune_branches_value(k, v);
     -+		return 0;
     -+	}
     -+
     - 	if (!strcmp(k, "fetch.showforcedupdates")) {
     - 		fetch_config->show_forced_updates = git_config_bool(k, v);
     - 		return 0;
     -@@ builtin/fetch.c: out:
     - static int prune_refs(struct display_state *display_state,
     - 		      struct refspec *rs,
     - 		      struct ref_transaction *transaction,
     --		      struct ref *ref_map)
     -+		      struct ref *ref_map,
     -+		      struct ref **stale_refs_out)
     - {
     - 	int result = 0;
     - 	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
     -@@ builtin/fetch.c: static int prune_refs(struct display_state *display_state,
     - cleanup:
     - 	string_list_clear(&refnames, 0);
     - 	strbuf_release(&err);
     --	free_refs(stale_refs);
     -+	if (!result && stale_refs_out)
     -+		*stale_refs_out = stale_refs;
     -+	else
     -+		free_refs(stale_refs);
     -+	return result;
     -+}
     -+
     -+struct prune_branches_cb {
     -+	struct string_list *pruned_refs;
     -+	struct string_list *to_delete;
     -+	struct string_list *skipped_unmerged;
     -+	enum prune_branches_mode mode;
     -+};
     -+
     -+static int collect_branches_to_prune(const struct reference *ref, void *cb_data)
     ++static int prune_merged_for_remote(const struct remote *remote)
      +{
     -+	struct prune_branches_cb *cb = cb_data;
     -+	const char *short_name = ref->name;
     -+	char *full_ref = xstrfmt("refs/heads/%s", short_name);
     -+	const char *upstream;
     -+	struct string_list_item *pruned;
     -+	int result = 0;
     -+
     -+	if (ref->flags & REF_ISSYMREF)
     -+		goto out;
     -+	if (branch_checked_out(full_ref))
     -+		goto out;
     -+
     -+	upstream = branch_get_upstream(branch_get(short_name), NULL);
     -+	if (!upstream)
     -+		goto out;
     ++	struct child_process cmd = CHILD_PROCESS_INIT;
      +
     -+	pruned = string_list_lookup(cb->pruned_refs, upstream);
     -+	if (!pruned)
     -+		goto out;
     -+
     -+	if (cb->mode == PRUNE_BRANCHES_SAFE) {
     -+		struct commit *local = lookup_commit_reference(the_repository,
     -+							       ref->oid);
     -+		struct commit *up = lookup_commit_reference(the_repository,
     -+							    pruned->util);
     -+		int reachable = local && up &&
     -+			repo_in_merge_bases(the_repository, local, up);
     -+
     -+		if (reachable < 0) {
     -+			result = -1;
     -+			goto out;
     -+		}
     -+		if (!reachable) {
     -+			string_list_append(cb->skipped_unmerged, short_name);
     -+			goto out;
     -+		}
     -+	}
     -+
     -+	string_list_append(cb->to_delete, full_ref);
     -+
     -+out:
     -+	free(full_ref);
     -+	return result;
     ++	cmd.git_cmd = 1;
     ++	strvec_pushl(&cmd.args, "branch", "--prune-merged", remote->name, NULL);
     ++	return run_command(&cmd);
      +}
      +
     -+static int do_prune_branches(struct display_state *display_state,
     -+			     struct ref *stale_refs,
     -+			     enum prune_branches_mode mode)
     -+{
     -+	struct string_list pruned_refs = STRING_LIST_INIT_NODUP;
     -+	struct string_list to_delete = STRING_LIST_INIT_DUP;
     -+	struct string_list skipped_unmerged = STRING_LIST_INIT_DUP;
     -+	struct prune_branches_cb cb = {
     -+		.pruned_refs = &pruned_refs,
     -+		.to_delete = &to_delete,
     -+		.skipped_unmerged = &skipped_unmerged,
     -+		.mode = mode,
     -+	};
     -+	struct ref *ref;
     -+	struct string_list_item *item;
     -+	int result = 0;
     -+
     -+	if (!stale_refs)
     -+		return 0;
     -+
     -+	for (ref = stale_refs; ref; ref = ref->next)
     -+		string_list_append(&pruned_refs, ref->name)->util = &ref->new_oid;
     -+	string_list_sort(&pruned_refs);
     -+
     -+	if (refs_for_each_branch_ref(get_main_ref_store(the_repository),
     -+				     collect_branches_to_prune, &cb)) {
     -+		result = -1;
     -+		goto cleanup;
     -+	}
     -+
     -+	if (!dry_run && to_delete.nr)
     -+		result = refs_delete_refs(get_main_ref_store(the_repository),
     -+					  "fetch: prune branches",
     -+					  &to_delete, REF_NO_DEREF);
     + static int fetch_one(struct remote *remote, int argc, const char **argv,
     + 		     int prune_tags_ok, int use_stdin_refspecs,
     + 		     const struct fetch_config *config,
     +@@ builtin/fetch.c: static int fetch_one(struct remote *remote, int argc, const char **argv,
     + 	refspec_clear(&rs);
     + 	transport_disconnect(gtransport);
     + 	gtransport = NULL;
      +
     -+	if (verbosity >= 0) {
     -+		const struct object_id *zero = null_oid(the_repository->hash_algo);
     -+		for_each_string_list_item(item, &to_delete) {
     -+			const char *short_name;
     -+			if (skip_prefix(item->string, "refs/heads/", &short_name))
     -+				display_ref_update(display_state, '-',
     -+						   _("[deleted local]"), NULL,
     -+						   _("(none)"), short_name,
     -+						   zero, zero,
     -+						   transport_summary_width(NULL));
     -+		}
     -+	}
     -+	for_each_string_list_item(item, &skipped_unmerged)
     -+		warning(_("not deleting local branch '%s' that is not "
     -+			  "fully merged into its upstream;\n"
     -+			  "         set fetch.pruneBranches=force to "
     -+			  "delete anyway, or delete manually with "
     -+			  "'git branch -D %s'"),
     -+			item->string, item->string);
     ++	if (!exit_code && prune_merged && remote_via_config &&
     ++	    prune_merged_for_remote(remote))
     ++		exit_code = 1;
      +
     -+cleanup:
     -+	string_list_clear(&pruned_refs, 0);
     -+	string_list_clear(&to_delete, 0);
     -+	string_list_clear(&skipped_unmerged, 0);
     - 	return result;
     + 	return exit_code;
       }
       
     -@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     - 	if (tags == TAGS_DEFAULT && autotags)
     - 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
     - 	if (prune) {
     -+		struct ref *stale_refs = NULL;
     -+		struct ref **stale_refs_out = prune_branches != PRUNE_BRANCHES_OFF
     -+			? &stale_refs : NULL;
     - 		/*
     - 		 * We only prune based on refspecs specified
     - 		 * explicitly (via command line or configuration); we
     - 		 * don't care whether --tags was specified.
     - 		 */
     - 		if (rs->nr) {
     --			retcode = prune_refs(&display_state, rs, transaction, ref_map);
     -+			retcode = prune_refs(&display_state, rs, transaction,
     -+					     ref_map, stale_refs_out);
     - 		} else {
     - 			retcode = prune_refs(&display_state, &transport->remote->fetch,
     --					     transaction, ref_map);
     -+					     transaction, ref_map, stale_refs_out);
     - 		}
     - 		if (retcode != 0)
     - 			retcode = 1;
     -+		else if (stale_refs &&
     -+			 do_prune_branches(&display_state, stale_refs,
     -+					   prune_branches))
     -+			retcode = 1;
     -+		free_refs(stale_refs);
     - 	}
     - 
     - 	/*
     -@@ builtin/fetch.c: static int fetch_one(struct remote *remote, int argc, const char **argv,
     - 			prune_tags = PRUNE_TAGS_BY_DEFAULT;
     - 	}
     - 
     -+	if (prune_branches == PRUNE_BRANCHES_UNSPECIFIED) {
     -+		/* no command line request */
     -+		if (remote->prune_branches >= 0)
     -+			prune_branches = remote->prune_branches;
     -+		else if (config->prune_branches >= 0)
     -+			prune_branches = config->prune_branches;
     -+		else
     -+			prune_branches = PRUNE_BRANCHES_OFF;
     -+	}
     -+
     - 	maybe_prune_tags = prune_tags_ok && prune_tags;
     - 	if (maybe_prune_tags && remote_via_config)
     - 		refspec_append(&remote->fetch, TAG_REFSPEC);
     -@@ builtin/fetch.c: int cmd_fetch(int argc,
     - 		.display_format = DISPLAY_FORMAT_FULL,
     - 		.prune = -1,
     - 		.prune_tags = -1,
     -+		.prune_branches = PRUNE_BRANCHES_UNSPECIFIED,
     - 		.show_forced_updates = 1,
     - 		.recurse_submodules = RECURSE_SUBMODULES_DEFAULT,
     - 		.parallel = 1,
      @@ builtin/fetch.c: int cmd_fetch(int argc,
       			 N_("prune remote-tracking branches no longer on remote")),
       		OPT_BOOL('P', "prune-tags", &prune_tags,
       			 N_("prune local tags no longer on remote and clobber changed tags")),
     -+		OPT_CALLBACK_F(0, "prune-branches", &prune_branches, N_("mode"),
     -+			       N_("delete local branches whose upstream was pruned ('safe' or 'force')"),
     -+			       PARSE_OPT_OPTARG, parse_prune_branches_opt),
     ++		OPT_BOOL(0, "prune-merged", &prune_merged,
     ++			 N_("after pruning, also delete local branches forked from this remote whose tips are reachable from their upstream")),
       		OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_cli, N_("on-demand"),
       			    N_("control recursive fetching of submodules"),
       			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
      
     - ## remote.c ##
     -@@ remote.c: static struct remote *make_remote(struct remote_state *remote_state,
     - 	CALLOC_ARRAY(ret, 1);
     - 	ret->prune = -1;  /* unspecified */
     - 	ret->prune_tags = -1;  /* unspecified */
     -+	ret->prune_branches = -1;  /* unspecified */
     - 	ret->name = xstrndup(name, len);
     - 	refspec_init_push(&ret->push);
     - 	refspec_init_fetch(&ret->fetch);
     -@@ remote.c: out:
     - }
     - #endif /* WITH_BREAKING_CHANGES */
     - 
     -+int parse_prune_branches_value(const char *k, const char *v)
     -+{
     -+	if (v) {
     -+		if (!strcasecmp(v, "safe"))
     -+			return PRUNE_BRANCHES_SAFE;
     -+		if (!strcasecmp(v, "force"))
     -+			return PRUNE_BRANCHES_FORCE;
     -+	}
     -+	if (git_parse_maybe_bool(v) == 0)
     -+		return PRUNE_BRANCHES_OFF;
     -+	die(_("invalid value for '%s': '%s'"), k, v);
     -+}
     -+
     - static int handle_config(const char *key, const char *value,
     - 			 const struct config_context *ctx, void *cb)
     - {
     -@@ remote.c: static int handle_config(const char *key, const char *value,
     - 		remote->prune = git_config_bool(key, value);
     - 	else if (!strcmp(subkey, "prunetags"))
     - 		remote->prune_tags = git_config_bool(key, value);
     -+	else if (!strcmp(subkey, "prunebranches"))
     -+		remote->prune_branches = parse_prune_branches_value(key, value);
     - 	else if (!strcmp(subkey, "url")) {
     - 		if (!value)
     - 			return config_error_nonbool(key);
     -
     - ## remote.h ##
     -@@ remote.h: enum {
     - #endif /* WITH_BREAKING_CHANGES */
     - };
     - 
     -+enum prune_branches_mode {
     -+	PRUNE_BRANCHES_UNSPECIFIED = -1,
     -+	PRUNE_BRANCHES_OFF = 0,
     -+	PRUNE_BRANCHES_SAFE,
     -+	PRUNE_BRANCHES_FORCE,
     -+};
     -+
     -+int parse_prune_branches_value(const char *k, const char *v);
     -+
     - struct rewrite {
     - 	const char *base;
     - 	size_t baselen;
     -@@ remote.h: struct remote {
     - 	int mirror;
     - 	int prune;
     - 	int prune_tags;
     -+	int prune_branches;
     - 
     - 	/**
     - 	 * The configured helper programs to run on the remote side, for
     -
       ## t/t5510-fetch.sh ##
      @@ t/t5510-fetch.sh: test_expect_success REFFILES 'fetch --prune fails to delete branches' '
       	)
       '
       
     -+test_expect_success 'fetch.pruneBranches: setup parent' '
     -+	git init -b main prune-branches-parent &&
     -+	test_commit -C prune-branches-parent base
     ++test_expect_success 'fetch --prune-merged: setup' '
     ++	git init -b main fetch-pm-parent &&
     ++	test_commit -C fetch-pm-parent base
      +'
      +
     -+test_expect_success 'fetch.pruneBranches=safe deletes merged local branch' '
     -+	git -C prune-branches-parent branch doomed base &&
     -+	git clone prune-branches-parent prune-branches-safe &&
     -+	git -C prune-branches-safe checkout -b doomed --track origin/doomed &&
     -+	git -C prune-branches-safe checkout -b stay &&
     -+	git -C prune-branches-parent branch -D doomed &&
     -+	git -C prune-branches-safe -c fetch.pruneBranches=safe fetch --prune origin &&
     -+	test_must_fail git -C prune-branches-safe rev-parse refs/remotes/origin/doomed &&
     -+	test_must_fail git -C prune-branches-safe rev-parse refs/heads/doomed
     -+'
     ++test_expect_success 'fetch --prune-merged deletes merged local branches' '
     ++	test_when_finished "rm -rf fetch-pm-clone" &&
     ++	git -C fetch-pm-parent branch one base &&
     ++	git clone fetch-pm-parent fetch-pm-clone &&
     ++	git -C fetch-pm-clone branch one --track origin/one &&
     ++	git -C fetch-pm-parent branch -D one &&
      +
     -+test_expect_success 'fetch.pruneBranches=safe keeps unmerged local branch' '
     -+	git -C prune-branches-parent branch doomed base &&
     -+	git clone prune-branches-parent prune-branches-safe-unmerged &&
     -+	git -C prune-branches-safe-unmerged checkout -b doomed --track origin/doomed &&
     -+	test_commit -C prune-branches-safe-unmerged local-only &&
     -+	git -C prune-branches-safe-unmerged checkout -b stay &&
     -+	git -C prune-branches-parent branch -D doomed &&
     -+	git -C prune-branches-safe-unmerged -c fetch.pruneBranches=safe fetch --prune origin 2>err &&
     -+	test_must_fail git -C prune-branches-safe-unmerged rev-parse refs/remotes/origin/doomed &&
     -+	git -C prune-branches-safe-unmerged rev-parse refs/heads/doomed &&
     -+	test_grep "not fully merged" err
     -+'
     -+
     -+test_expect_success 'fetch.pruneBranches=force deletes unmerged local branch' '
     -+	git -C prune-branches-parent branch doomed base &&
     -+	git clone prune-branches-parent prune-branches-force &&
     -+	git -C prune-branches-force checkout -b doomed --track origin/doomed &&
     -+	test_commit -C prune-branches-force local-only-force &&
     -+	git -C prune-branches-force checkout -b stay &&
     -+	git -C prune-branches-parent branch -D doomed &&
     -+	git -C prune-branches-force -c fetch.pruneBranches=force fetch --prune origin &&
     -+	test_must_fail git -C prune-branches-force rev-parse refs/remotes/origin/doomed &&
     -+	test_must_fail git -C prune-branches-force rev-parse refs/heads/doomed
     -+'
     -+
     -+test_expect_success 'fetch.pruneBranches=force never deletes checked-out branch' '
     -+	git -C prune-branches-parent branch doomed base &&
     -+	git clone prune-branches-parent prune-branches-checked-out &&
     -+	git -C prune-branches-checked-out checkout -b doomed --track origin/doomed &&
     -+	git -C prune-branches-parent branch -D doomed &&
     -+	git -C prune-branches-checked-out -c fetch.pruneBranches=force fetch --prune origin &&
     -+	test_must_fail git -C prune-branches-checked-out rev-parse refs/remotes/origin/doomed &&
     -+	git -C prune-branches-checked-out rev-parse refs/heads/doomed
     -+'
     -+
     -+test_expect_success '--prune-branches deletes merged local branch' '
     -+	git -C prune-branches-parent branch doomed base &&
     -+	git clone prune-branches-parent prune-branches-cli &&
     -+	git -C prune-branches-cli checkout -b doomed --track origin/doomed &&
     -+	git -C prune-branches-cli checkout -b stay &&
     -+	git -C prune-branches-parent branch -D doomed &&
     -+	git -C prune-branches-cli fetch --prune --prune-branches origin &&
     -+	test_must_fail git -C prune-branches-cli rev-parse refs/heads/doomed
     -+'
     ++	git -C fetch-pm-clone fetch --prune --prune-merged origin &&
      +
     -+test_expect_success '--no-prune-branches overrides fetch.pruneBranches' '
     -+	git -C prune-branches-parent branch doomed base &&
     -+	git clone prune-branches-parent prune-branches-no-cli &&
     -+	git -C prune-branches-no-cli checkout -b doomed --track origin/doomed &&
     -+	git -C prune-branches-no-cli checkout -b stay &&
     -+	git -C prune-branches-no-cli config fetch.pruneBranches force &&
     -+	git -C prune-branches-parent branch -D doomed &&
     -+	git -C prune-branches-no-cli fetch --prune --no-prune-branches origin &&
     -+	git -C prune-branches-no-cli rev-parse refs/heads/doomed
     ++	test_must_fail git -C fetch-pm-clone rev-parse --verify refs/heads/one
      +'
      +
     -+test_expect_success 'remote.<name>.pruneBranches overrides fetch.pruneBranches' '
     -+	git -C prune-branches-parent branch doomed base &&
     -+	git clone prune-branches-parent prune-branches-per-remote &&
     -+	git -C prune-branches-per-remote checkout -b doomed --track origin/doomed &&
     -+	git -C prune-branches-per-remote checkout -b stay &&
     -+	git -C prune-branches-per-remote config fetch.pruneBranches force &&
     -+	git -C prune-branches-per-remote config remote.origin.pruneBranches false &&
     -+	git -C prune-branches-parent branch -D doomed &&
     -+	git -C prune-branches-per-remote fetch --prune origin &&
     -+	git -C prune-branches-per-remote rev-parse refs/heads/doomed
     ++test_expect_success 'fetch --prune-merged skips unmerged local branches' '
     ++	test_when_finished "rm -rf fetch-pm-unmerged" &&
     ++	git -C fetch-pm-parent branch two base &&
     ++	git clone fetch-pm-parent fetch-pm-unmerged &&
     ++	git -C fetch-pm-unmerged checkout -b two --track origin/two &&
     ++	test_commit -C fetch-pm-unmerged unpushed &&
     ++	git -C fetch-pm-unmerged checkout - &&
     ++	git -C fetch-pm-parent branch -D two &&
     ++
     ++	git -C fetch-pm-unmerged fetch --prune --prune-merged origin 2>err &&
     ++	test_grep "not fully merged" err &&
     ++	git -C fetch-pm-unmerged rev-parse --verify refs/heads/two
      +'
      +
       test_expect_success 'fetch --atomic works with a single branch' '
 -:  ---------- > 5:  0bc5ebbe68 branch: add branch.<name>.pruneMerged opt-out
 -:  ---------- > 6:  66dac97626 branch: add --all-remotes flag

-- 
gitgitgadget
