Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0183E8330
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405512; cv=none; b=i2q8hE5N9anJKPzGALoN3geIuNTH30Z+6VrY0GZpEt86CGbBnC/39ixezNtMAWQJpLrqA6d/rF8fSGxfq6LV79h462cDJmyuEhDJt6HZIxQjVDaMKlS9YNJizZTA7s0uUSBZOg/QfGhwbqTE1K8KbdlXlFKemMm4RSN2E2pgIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405512; c=relaxed/simple;
	bh=1PAInl0IbSOw9vZBUUNeJ5BZ6qEUzfv+aOV4/i8kW4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mO1n4ZNyQpErVcnrzg7abSCoTSnHqb8CtD+T1f5k4gJPjCuTONyI2fXoP8Hbi7BRlQ/07UfUNiQqnjp/Ia0TqtahDLMxN3ys+wEDiCL/EFUUcux7IaMNTBO3m8aptaWrK/nNCf8Gg6S+PMEAmS7wQN+9SzGruxocXZ5/NSRgGTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdhgvRZ6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdhgvRZ6"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68b73f1a8ebso8908522a12.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780405508; x=1781010308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=89nHS7p1QKXh3ZZwqfFB1LpYu4r2iBTnhLEl9xlO2nk=;
        b=SdhgvRZ6vb+gKzNod1uNY85nqvmon7bjpx+fTHXKoPpyg39jZUMEb4LthI7pyHk116
         +4jwgnD1pu4fQD3aGtvyLH/4zEOufC/8iBer1PPvcWVwBAaHpvmraagckXRqhdIAPzQg
         lDvdnHvz4gbXT+9Za6DXOCMDdzoxoodSni4vvNjHPT2osgwRp0Lmy8wQRxu/tlvskk1Q
         KTPUZrKVkR0Z8WlNZ5+tBo8Rda6PvXY0Vq31n/UaGkae8hjpgyLXCYOPm2GwCHYf+3gh
         rffeo460Jd76H3gPem+8YKGgio6y+N7kTLeTCqEg7Qy5vO6Hx7cKH4nIcegnY+pGHo48
         tbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780405508; x=1781010308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89nHS7p1QKXh3ZZwqfFB1LpYu4r2iBTnhLEl9xlO2nk=;
        b=dNwP59hG/fm6HjQ/B0fB5EJoOCHjn6LCURdRA0eCGJhv+GATL+4j3fmbwCYD6wTZe3
         EaHRkrQd1cyZvs3khaRRMq1flOz/yf5vzFyXCMigETS6psOba5g4x2tbUgZ9JkzGUsfk
         z5sTojnMZYgw1M3eKhTZTCe6HHWF28s/a3aBStH9dxMOXZYuwFO+5YAArMiT0+BnDvrK
         2lWO9iceOldqus1QcdWKKeSBCEnb1jcSI0JrK9wuQGEsUgWqVQnmD2y+Y2IM55u0jPMr
         u4+EfqpqWEgcRUczMCk4oM0ypbExJ3zhQe+A1htAaps755GnRImovdC6LjqRagU7LjUb
         rkXw==
X-Forwarded-Encrypted: i=1; AFNElJ/Qkcb+DYWv56Tl+a17WsGOEGz7oCDrz48LfnRYVwBu/OpD6flnPGggUXqVK+HknsdkxF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZRMUnZrqwhzZPSz3mHKUNFT27f1/+THq8rM0rE5wF2rHBpzz
	s2aD3ybuZ/Zv5QPVAGurDStbh2x1Ez0IE6eXdT6CoDQsa6mdFASJsyAk
X-Gm-Gg: Acq92OFcBFZnY9e2e9eiUJ8tZxgj1nKQZJnNu4QcPHQG/DPxquHxnXGdf0opITQOLtC
	KUxUgZ76uarBGp+UdO53ZtXdaKnPGtCtga1sKWssP4w08TuU3hyGIyIbqyo+yQj/mrBPqWiqAvI
	gZNdkdT32d6BAkUqLiCD5qmsqYRv1V7BwoZNZ847yGPRMs/Jm5e5ylNkME9YTNKQ3lFxgmQd/dj
	KDHV9bQyng9AU1P3ZY1epbFe9lYGf9BaLStnrw3vJjxSfqzABtknD2pMBf63pMQNv9Nlj0SELHR
	gTMolrrviavVno8hp0fyVxD2u4pmCx+zdu3rHg2pn0dkipBPN0g/ggNKtLyFCUywLQ3reB5Xctu
	KkalhV9mJnjhfdRhNPiqVoddS/19mFi9lqJlVeBfh+CVRmeqV10g5soQNU1t7vevLMfwxo4IINE
	5eWy8AxUwgQ6WFZ6RO3r769zQ3/5Jy2gqTZqjWz5yKeiWj2N6trNgqAk7ci7LeGTxA/rzL8jnHp
	Cb73WE5824Vhg==
X-Received: by 2002:a17:906:fd8b:b0:bdc:ac75:73b9 with SMTP id a640c23a62f3a-beab66dcc4fmr909825066b.43.1780405507305;
        Tue, 02 Jun 2026 06:05:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bef11b9d682sm120417566b.5.2026.06.02.06.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 06:05:06 -0700 (PDT)
Message-ID: <9b44d867-219a-4ca3-b8ae-67fdac1c72f6@gmail.com>
Date: Tue, 2 Jun 2026 14:05:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v11 0/6] branch: prune-merged
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
 <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

Just a quick note to say I've not forgotten about this, hopefully I 
should have time to review it later in the week now I'm back on the list.

Thanks

Phillip

On 22/05/2026 12:31, Harald Nordgren via GitGitGadget wrote:
> After releasing v10, I hard-reset back to v9 and reworked the series from
> there.
> 
>   * The flags now take a branch, not a remote. --forked and --prune-merged
>     accept a literal upstream short name like origin/main or a wildmatch
>     pattern like origin/*. The old --all-remotes flag is gone, since origin/*
>     covers that case.
>   * The prune guard now compares @{push} against @{upstream}. A branch is
>     spared when these are equal. That is the trunk like case, such as local
>     main tracking and pushing to origin/main, where "fully merged to
>     upstream" cannot be told apart from "just pulled". Only branches that
>     push somewhere other than their upstream, typically fork based topics,
>     are candidates. The earlier <remote>/HEAD by name guard that the reviewer
>     rejected is gone.
>   * New --dry-run for --prune-merged.
> 
> Harald Nordgren (6):
>    branch: add --forked <branch>
>    branch: let delete_branches warn instead of error on bulk refusal
>    branch: prepare delete_branches for a bulk caller
>    branch: add --prune-merged <branch>
>    branch: add branch.<name>.pruneMerged opt-out
>    branch: add --dry-run for --prune-merged
> 
>   Documentation/config/branch.adoc |   7 +
>   Documentation/git-branch.adoc    |  42 ++++
>   builtin/branch.c                 | 303 +++++++++++++++++++++++++--
>   t/t3200-branch.sh                | 347 +++++++++++++++++++++++++++++++
>   4 files changed, 682 insertions(+), 17 deletions(-)
> 
> 
> base-commit: aec3f587505a472db67e9462d0702e7d463a449d
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v11
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v11
> Pull-Request: https://github.com/git/git/pull/2285
> 
> Range-diff vs v10:
> 
>   1:  f2df159830 ! 1:  b9fddd124a branch: add --forked <branch>
>       @@ Metadata
>         ## Commit message ##
>            branch: add --forked <branch>
>        
>       -            git branch --forked <branch>...
>       +    List local branches whose configured upstream
>       +    (branch.<name>.merge resolved against branch.<name>.remote)
>       +    matches any of the given <branch> arguments.
>        
>       -    lists local branches whose configured upstream matches any
>       -    of the given <branch> arguments.
>       +    Each <branch> is interpreted against the local repository, not
>       +    against any specific remote:
>        
>       -    Each <branch> is resolved to the same kind of ref that
>       -    branch.<name>.remote and branch.<name>.merge together point at:
>       -    a remote-tracking branch (e.g. origin/master), or, for branches
>       -    tracking a local upstream, a local branch (e.g. master).
>       -    Shell-style globs are also accepted (e.g. 'origin/*'). Multiple
>       -    arguments are unioned.
>       +      * a literal upstream short name, e.g. "origin/main" or "master"
>       +        for a branch whose upstream is local;
>       +      * a wildmatch pattern, e.g. "origin/*";
>       +      * a bare configured-remote name, e.g. "origin", which resolves
>       +        to whatever refs/remotes/origin/HEAD points at, matching how
>       +        "git checkout -b topic origin" picks a starting point.
>        
>       -    This is the building block for --prune-merged.
>       +    The literal-vs-wildcard distinction is settled at parse time so
>       +    the per-branch matching loop calls wildmatch() only for genuine
>       +    wildcards. Multiple <branch> arguments are unioned. Output is
>       +    sorted by branch name.
>       +
>       +    This is the building block for --prune-merged, which deletes the
>       +    listed branches once they have landed on their upstream.
>        
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>        
>       @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mod
>         	nothing is printed.
>         
>        +`--forked`::
>       -+	List local branches whose configured upstream matches any
>       -+	of the given _<branch>_ arguments. Each argument is either
>       -+	a ref (e.g. `origin/master`, `master`) or a shell-style
>       -+	glob (e.g. `'origin/*'`). Multiple arguments are unioned.
>       ++	List local branches whose configured upstream
>       ++	(`branch.<name>.merge` resolved against `branch.<name>.remote`)
>       ++	matches any of the given _<branch>_ arguments.
>       +++
>       ++Each _<branch>_ is interpreted against the local repository: a literal
>       ++upstream like `origin/main` or a local branch like `master`, or a
>       ++wildmatch pattern like `'origin/*'`.  A bare configured-remote name
>       ++(e.g. `origin`) resolves to the target of `refs/remotes/<remote>/HEAD`,
>       ++to match the way `git checkout -b topic origin` picks a starting
>       ++point.  Multiple _<branch>_ arguments are unioned.
>        +
>         `-v`::
>         `-vv`::
>       @@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
>         	NULL
>         };
>         
>       -@@ builtin/branch.c: static int branch_merged(int kind, const char *name,
>       -
>       - static int check_branch_commit(const char *branchname, const char *refname,
>       - 			       const struct object_id *oid, struct commit *head_rev,
>       --			       int kinds, int force)
>       -+			       int kinds, int force, int warn_only,
>       -+			       int *n_not_merged)
>       - {
>       - 	struct commit *rev = lookup_commit_reference(the_repository, oid);
>       - 	if (!force && !rev) {
>       -@@ builtin/branch.c: static int check_branch_commit(const char *branchname, const char *refname,
>       - 		return -1;
>       - 	}
>       - 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
>       --		error(_("the branch '%s' is not fully merged"), branchname);
>       --		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
>       --				  _("If you are sure you want to delete it, "
>       --				  "run 'git branch -D %s'"), branchname);
>       -+		if (warn_only) {
>       -+			warning(_("the branch '%s' is not fully merged"),
>       -+				branchname);
>       -+		} else {
>       -+			error(_("the branch '%s' is not fully merged"),
>       -+			      branchname);
>       -+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
>       -+					  _("If you are sure you want to delete it, "
>       -+					  "run 'git branch -D %s'"), branchname);
>       -+		}
>       -+		if (n_not_merged)
>       -+			(*n_not_merged)++;
>       - 		return -1;
>       - 	}
>       - 	return 0;
>       -@@ builtin/branch.c: static void delete_branch_config(const char *branchname)
>       - }
>       -
>       - static int delete_branches(int argc, const char **argv, int force, int kinds,
>       --			   int quiet)
>       -+			   int quiet, int warn_only, int *n_not_merged)
>       - {
>       - 	struct commit *head_rev = NULL;
>       - 	struct object_id oid;
>       -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
>       -
>       - 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
>       - 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
>       --					force)) {
>       --			ret = 1;
>       -+					force, warn_only, n_not_merged)) {
>       -+			if (!warn_only)
>       -+				ret = 1;
>       - 			goto next;
>       - 		}
>       -
>        @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const char *newname, int
>         	free_worktrees(worktrees);
>         }
>         
>       ++struct upstream_pattern {
>       ++	char *name;
>       ++	int is_wildcard;
>       ++};
>       ++
>       ++static void upstream_pattern_list_clear(struct upstream_pattern *items,
>       ++					size_t nr)
>       ++{
>       ++	size_t i;
>       ++	for (i = 0; i < nr; i++)
>       ++		free(items[i].name);
>       ++	free(items);
>       ++}
>       ++
>       ++static const char *short_upstream_name(const char *full_ref)
>       ++{
>       ++	const char *short_name = full_ref;
>       ++	(void)(skip_prefix(short_name, "refs/heads/", &short_name) ||
>       ++	       skip_prefix(short_name, "refs/remotes/", &short_name));
>       ++	return short_name;
>       ++}
>       ++
>       ++static int parse_one_forked_arg(const char *arg, struct upstream_pattern *out)
>       ++{
>       ++	struct ref_store *refs = get_main_ref_store(the_repository);
>       ++	struct remote *remote;
>       ++	struct object_id oid;
>       ++	char *full_ref = NULL;
>       ++	struct strbuf head_ref = STRBUF_INIT;
>       ++	const char *resolved;
>       ++
>       ++	if (has_glob_specials(arg)) {
>       ++		out->name = xstrdup(arg);
>       ++		out->is_wildcard = 1;
>       ++		return 0;
>       ++	}
>       ++
>       ++	remote = remote_get(arg);
>       ++	if (remote && remote_is_configured(remote, 0)) {
>       ++		strbuf_addf(&head_ref, "refs/remotes/%s/HEAD", remote->name);
>       ++		resolved = refs_resolve_ref_unsafe(refs, head_ref.buf,
>       ++						   RESOLVE_REF_NO_RECURSE,
>       ++						   NULL, NULL);
>       ++		if (resolved && starts_with(resolved, "refs/remotes/")) {
>       ++			out->name = xstrdup(short_upstream_name(resolved));
>       ++			out->is_wildcard = 0;
>       ++			strbuf_release(&head_ref);
>       ++			return 0;
>       ++		}
>       ++		strbuf_release(&head_ref);
>       ++	}
>       ++
>       ++	if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
>       ++			  &full_ref, 0) == 1 &&
>       ++	    (starts_with(full_ref, "refs/heads/") ||
>       ++	     starts_with(full_ref, "refs/remotes/"))) {
>       ++		out->name = xstrdup(short_upstream_name(full_ref));
>       ++		out->is_wildcard = 0;
>       ++		free(full_ref);
>       ++		return 0;
>       ++	}
>       ++	free(full_ref);
>       ++	return -1;
>       ++}
>       ++
>        +static void parse_forked_args(int argc, const char **argv,
>       -+			      struct string_list *upstream_patterns)
>       ++			      struct upstream_pattern **patterns_out,
>       ++			      size_t *nr_out)
>        +{
>       ++	struct upstream_pattern *patterns;
>        +	int i;
>        +
>       ++	ALLOC_ARRAY(patterns, argc);
>        +	for (i = 0; i < argc; i++) {
>       -+		const char *arg = argv[i];
>       -+		struct object_id oid;
>       -+		char *full_ref = NULL;
>       -+		const char *short_ref;
>       -+
>       -+		if (has_glob_specials(arg)) {
>       -+			string_list_insert(upstream_patterns, arg);
>       -+			continue;
>       ++		if (parse_one_forked_arg(argv[i], &patterns[i]) < 0) {
>       ++			upstream_pattern_list_clear(patterns, i);
>       ++			die(_("'%s' is not a valid branch or pattern"),
>       ++			    argv[i]);
>        +		}
>       ++	}
>       ++	*patterns_out = patterns;
>       ++	*nr_out = argc;
>       ++}
>        +
>       -+		if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
>       -+				  &full_ref, 0) == 1 &&
>       -+		    (skip_prefix(full_ref, "refs/heads/", &short_ref) ||
>       -+		     skip_prefix(full_ref, "refs/remotes/", &short_ref))) {
>       -+			string_list_insert(upstream_patterns, short_ref);
>       -+			free(full_ref);
>       -+			continue;
>       -+		}
>       -+		free(full_ref);
>       ++static int upstream_matches(const char *short_upstream,
>       ++			    const struct upstream_pattern *patterns,
>       ++			    size_t nr)
>       ++{
>       ++	size_t i;
>        +
>       -+		die(_("'%s' is not a valid branch or pattern"), arg);
>       ++	for (i = 0; i < nr; i++) {
>       ++		const struct upstream_pattern *p = &patterns[i];
>       ++		if (p->is_wildcard) {
>       ++			if (!wildmatch(p->name, short_upstream, WM_PATHNAME))
>       ++				return 1;
>       ++		} else if (!strcmp(p->name, short_upstream)) {
>       ++			return 1;
>       ++		}
>        +	}
>       ++	return 0;
>        +}
>        +
>        +struct forked_cb {
>       -+	const struct string_list *upstream_patterns;
>       ++	const struct upstream_pattern *patterns;
>       ++	size_t nr_patterns;
>        +	struct string_list *out;
>        +};
>        +
>       @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
>        +{
>        +	struct forked_cb *cb = cb_data;
>        +	struct branch *branch;
>       -+	const char *upstream, *short_upstream;
>       -+	const struct string_list_item *item;
>       ++	const char *upstream;
>        +
>        +	if (ref->flags & REF_ISSYMREF)
>        +		return 0;
>       @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
>        +	upstream = branch_get_upstream(branch, NULL);
>        +	if (!upstream)
>        +		return 0;
>       -+	short_upstream = upstream;
>       -+	(void)(skip_prefix(short_upstream, "refs/heads/", &short_upstream) ||
>       -+	       skip_prefix(short_upstream, "refs/remotes/", &short_upstream));
>       -+
>       -+	for_each_string_list_item(item, cb->upstream_patterns)
>       -+		if (!wildmatch(item->string, short_upstream, WM_PATHNAME)) {
>       -+			string_list_append(cb->out, ref->name)->util =
>       -+				xstrdup(upstream);
>       -+			return 0;
>       -+		}
>       ++	if (upstream_matches(short_upstream_name(upstream),
>       ++			     cb->patterns, cb->nr_patterns))
>       ++		string_list_append(cb->out, ref->name);
>        +	return 0;
>        +}
>        +
>       -+static void collect_forked_set(int argc, const char **argv,
>       -+			       struct string_list *out)
>       -+{
>       -+	struct string_list upstream_patterns = STRING_LIST_INIT_DUP;
>       -+	struct forked_cb cb = {
>       -+		.upstream_patterns = &upstream_patterns,
>       -+		.out = out,
>       -+	};
>       -+
>       -+	parse_forked_args(argc, argv, &upstream_patterns);
>       -+
>       -+	refs_for_each_branch_ref(get_main_ref_store(the_repository),
>       -+				 collect_forked_branch, &cb);
>       -+
>       -+	string_list_clear(&upstream_patterns, 0);
>       -+}
>       -+
>        +static int list_forked_branches(int argc, const char **argv)
>        +{
>       ++	struct upstream_pattern *patterns = NULL;
>       ++	size_t nr_patterns = 0;
>        +	struct string_list out = STRING_LIST_INIT_DUP;
>        +	struct string_list_item *item;
>       ++	struct forked_cb cb;
>        +
>        +	if (!argc)
>        +		die(_("--forked requires at least one <branch>"));
>        +
>       -+	collect_forked_set(argc, argv, &out);
>       ++	parse_forked_args(argc, argv, &patterns, &nr_patterns);
>       ++	cb.patterns = patterns;
>       ++	cb.nr_patterns = nr_patterns;
>       ++	cb.out = &out;
>       ++
>       ++	refs_for_each_branch_ref(get_main_ref_store(the_repository),
>       ++				 collect_forked_branch, &cb);
>       ++
>       ++	string_list_sort(&out);
>        +	for_each_string_list_item(item, &out)
>        +		puts(item->string);
>        +
>       -+	string_list_clear(&out, 1);
>       ++	upstream_pattern_list_clear(patterns, nr_patterns);
>       ++	string_list_clear(&out, 0);
>        +	return 0;
>        +}
>        +
>       @@ builtin/branch.c: int cmd_branch(int argc,
>         		usage_with_options(builtin_branch_usage, options);
>         
>        @@ builtin/branch.c: int cmd_branch(int argc,
>       - 	if (delete) {
>       - 		if (!argc)
>         			die(_("branch name required"));
>       --		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
>       -+		ret = delete_branches(argc, argv, delete > 1, filter.kind,
>       -+				      quiet, 0, NULL);
>       -+		goto out;
>       + 		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
>       + 		goto out;
>        +	} else if (forked) {
>        +		ret = list_forked_branches(argc, argv);
>       - 		goto out;
>       ++		goto out;
>         	} else if (show_current) {
>         		print_current_branch_name();
>       + 		ret = 0;
>        
>         ## t/t3200-branch.sh ##
>        @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
>       @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
>        +	git clone forked-upstream forked &&
>        +	git -C forked remote add other ../forked-other &&
>        +	git -C forked fetch other &&
>       ++	git -C forked branch local-base &&
>        +	git -C forked branch --track local-one origin/one &&
>        +	git -C forked branch --track local-two origin/two &&
>        +	git -C forked branch --track local-foreign other/foreign &&
>        +	git -C forked branch detached &&
>       -+	git -C forked branch --track topic-on-main main
>       ++	git -C forked branch --track local-trunk local-base
>        +'
>        +
>       -+test_expect_success '--forked <remote-tracking-branch> lists matching branches' '
>       ++test_expect_success '--forked <upstream-tracking-branch> lists matching branches' '
>        +	git -C forked branch --forked origin/one >actual &&
>        +	echo local-one >expect &&
>        +	test_cmp expect actual
>        +'
>        +
>       -+test_expect_success '--forked <local-branch> lists branches tracking that local branch' '
>       -+	git -C forked branch --forked main >actual &&
>       -+	echo topic-on-main >expect &&
>       -+	test_cmp expect actual
>       -+'
>       -+
>       -+test_expect_success '--forked <glob> matches every upstream under the pattern' '
>       ++test_expect_success '--forked <glob> matches by wildmatch' '
>        +	git -C forked branch --forked "origin/*" >actual &&
>        +	cat >expect <<-\EOF &&
>        +	local-one
>       @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
>        +	test_cmp expect actual
>        +'
>        +
>       ++test_expect_success '--forked <local-branch> matches branches with local upstream' '
>       ++	git -C forked branch --forked local-base >actual &&
>       ++	echo local-trunk >expect &&
>       ++	test_cmp expect actual
>       ++'
>       ++
>       ++test_expect_success '--forked <remote> resolves via refs/remotes/<remote>/HEAD' '
>       ++	test_when_finished "git -C forked symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main" &&
>       ++	git -C forked symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/one &&
>       ++	git -C forked branch --forked origin >actual &&
>       ++	echo local-one >expect &&
>       ++	test_cmp expect actual
>       ++'
>       ++
>        +test_expect_success '--forked unions multiple <branch> arguments' '
>        +	git -C forked branch --forked origin/one other/foreign >actual &&
>        +	cat >expect <<-\EOF &&
>       @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
>        +'
>        +
>        +test_expect_success '--forked combines literal and glob arguments' '
>       -+	git -C forked branch --forked main "other/*" >actual &&
>       ++	git -C forked branch --forked local-base "other/*" >actual &&
>        +	cat >expect <<-\EOF &&
>        +	local-foreign
>       -+	topic-on-main
>       ++	local-trunk
>        +	EOF
>        +	test_cmp expect actual
>        +'
>   -:  ---------- > 2:  b666d09bf5 branch: let delete_branches warn instead of error on bulk refusal
>   -:  ---------- > 3:  6e6580270e branch: prepare delete_branches for a bulk caller
>   2:  718e28c7e0 ! 4:  e7e03c1338 branch: add --prune-merged <branch>
>       @@ Commit message
>        
>                    git branch --prune-merged <branch>...
>        
>       -    deletes the local branches that --forked <branch> would list,
>       -    but only those whose tip is reachable from their configured
>       -    upstream: the work has already landed on the upstream the
>       -    branch tracks, so the local copy is no longer needed.
>       +    deletes the local branches that "--forked <branch>" would list,
>       +    restricted to those whose tip is reachable from their configured
>       +    upstream: the work has already landed on the upstream they track,
>       +    so the local copy is no longer needed.
>        
>       -    The following branches are always preserved:
>       +    Reachability is read from the local refs only -- nothing is
>       +    fetched. Users who want fresh upstream refs run "git fetch" first;
>       +    the deletion path stays a separate, idempotent step that also
>       +    works offline.
>        
>       -    * the currently checked-out branch in any worktree;
>       -    * any local branch whose name matches the default branch of
>       -      any configured remote (the target of
>       -      refs/remotes/<remote>/HEAD) -- typically 'main' or
>       -      'master';
>       -    * any branch whose upstream no longer resolves locally.
>       +    Three classes of branches are spared:
>        
>       -    Reachability is read from whatever branch.<name>.merge
>       -    resolves to locally, which is usually a remote-tracking ref
>       -    but may also be a local branch. When the upstream is a
>       -    remote-tracking ref, the natural workflow is
>       +      * any branch checked out in any worktree;
>       +      * any branch whose upstream no longer resolves locally (its
>       +        disappearance is not, on its own, evidence of integration);
>       +      * any branch whose push destination equals its upstream
>       +        (<branch>@{push} == <branch>@{upstream}). Such a branch
>       +        cannot be distinguished from a freshly pulled trunk that
>       +        just looks "fully merged" -- e.g. local "main" tracking and
>       +        pushing to "origin/main" right after a pull. Only branches
>       +        that push somewhere other than their upstream (typically
>       +        topics in a fork-based workflow) are treated as candidates.
>        
>       -            git fetch <remote>
>       -            git branch --prune-merged <upstream-pattern>
>       -
>       -    so the upstream reflects the current state before pruning.
>       +    Deletion goes through the existing delete_branches() in warn-only
>       +    mode and with the HEAD-fallback disabled: a branch that is not
>       +    yet fully merged to its upstream is reported as a one-line warning
>       +    and skipped, so a single un-mergeable topic does not abort the
>       +    whole sweep, and there is no fallback to "merged into the
>       +    currently checked out branch" -- we only act on upstream-merged
>       +    status.
>        
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>        
>       @@ Documentation/git-branch.adoc: git branch (-c|-C) [<old-branch>] <new-branch>
>         
>         DESCRIPTION
>         -----------
>       -@@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mode.
>       - 	a ref (e.g. `origin/master`, `master`) or a shell-style
>       - 	glob (e.g. `'origin/*'`). Multiple arguments are unioned.
>       +@@ Documentation/git-branch.adoc: wildmatch pattern like `'origin/*'`.  A bare configured-remote name
>       + to match the way `git checkout -b topic origin` picks a starting
>       + point.  Multiple _<branch>_ arguments are unioned.
>         
>        +`--prune-merged`::
>       -+	Delete the local branches that `--forked` would list for
>       -+	the same _<branch>_ arguments, but only those whose tip is
>       -+	reachable from their configured upstream.
>       ++	Delete the local branches that `--forked` would list for the
>       ++	same _<branch>_ arguments, but only those whose tip is
>       ++	reachable from their configured upstream.  In other words,
>       ++	the work on the branch has already landed on the upstream it
>       ++	tracks, so the local copy is no longer needed.
>        ++
>       -+For arguments that refer to remote-tracking branches, run
>       -+`git fetch` first so reachability is checked against the
>       -+current upstream state; refs are read locally.
>       ++Reachability is checked against whatever the upstream refs say
>       ++locally; nothing is fetched.  Run `git fetch` first if you want
>       ++the upstream refs refreshed.
>        ++
>       -+The following branches are always preserved:
>       ++A branch is left alone if any of the following holds:
>       ++its upstream no longer resolves locally; it is checked out in any
>       ++worktree; or its push destination (`<branch>@{push}`) equals its
>       ++upstream (`<branch>@{upstream}`), so it cannot be distinguished
>       ++from a freshly pulled trunk that just looks "fully merged".
>        ++
>       -+--
>       -+* the currently checked-out branch in any worktree;
>       -+* any local branch whose name matches the default branch of
>       -+  any configured remote (the target of
>       -+  `refs/remotes/<remote>/HEAD`) -- typically `main` or
>       -+  `master`;
>       -+* any branch whose upstream no longer resolves locally.
>       -+--
>       ++Branches refused by the "fully merged" safety check are listed as
>       ++warnings and skipped; pass them to `git branch -D` explicitly if
>       ++you want them gone.
>        +
>         `-v`::
>         `-vv`::
>         `--verbose`::
>        
>         ## builtin/branch.c ##
>       -@@
>       - #include "branch.h"
>       - #include "path.h"
>       - #include "string-list.h"
>       -+#include "strvec.h"
>       - #include "column.h"
>       - #include "utf8.h"
>       - #include "ref-filter.h"
>       -@@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
>       - 	N_("git branch [<options>] [-r | -a] [--points-at]"),
>       - 	N_("git branch [<options>] [-r | -a] [--format]"),
>       - 	N_("git branch [<options>] --forked <branch>..."),
>       -+	N_("git branch [<options>] --prune-merged <branch>..."),
>       - 	NULL
>       - };
>       -
>       -@@ builtin/branch.c: static int branch_merged(int kind, const char *name,
>       - 	 * any of the following code, but during the transition period,
>       - 	 * a gentle reminder is in order.
>       - 	 */
>       --	if (head_rev != reference_rev) {
>       --		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
>       -+	if (head_rev && head_rev != reference_rev) {
>       -+		int expect = repo_in_merge_bases(the_repository, rev, head_rev);
>       - 		if (expect < 0)
>       - 			exit(128);
>       - 		if (expect == merged)
>        @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref, void *cb_data)
>         	return 0;
>         }
>         
>       -+static int collect_default_branch_name(struct remote *remote, void *cb_data)
>       -+{
>       -+	struct string_list *protected = cb_data;
>       -+	struct ref_store *refs = get_main_ref_store(the_repository);
>       -+	struct strbuf head = STRBUF_INIT;
>       -+	const char *target;
>       -+
>       -+	strbuf_addf(&head, "refs/remotes/%s/HEAD", remote->name);
>       -+	target = refs_resolve_ref_unsafe(refs, head.buf,
>       -+					 RESOLVE_REF_NO_RECURSE, NULL, NULL);
>       -+	if (target) {
>       -+		const char *leaf = strrchr(target, '/');
>       -+		if (leaf)
>       -+			string_list_insert(protected, leaf + 1);
>       -+	}
>       -+	strbuf_release(&head);
>       -+	return 0;
>       +-static int list_forked_branches(int argc, const char **argv)
>       ++static void collect_forked_set(int argc, const char **argv,
>       ++			       struct string_list *out)
>       + {
>       + 	struct upstream_pattern *patterns = NULL;
>       + 	size_t nr_patterns = 0;
>       +-	struct string_list out = STRING_LIST_INIT_DUP;
>       +-	struct string_list_item *item;
>       + 	struct forked_cb cb;
>       +
>       +-	if (!argc)
>       +-		die(_("--forked requires at least one <branch>"));
>       +-
>       + 	parse_forked_args(argc, argv, &patterns, &nr_patterns);
>       + 	cb.patterns = patterns;
>       + 	cb.nr_patterns = nr_patterns;
>       +-	cb.out = &out;
>       ++	cb.out = out;
>       +
>       + 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
>       + 				 collect_forked_branch, &cb);
>       +
>       +-	string_list_sort(&out);
>       ++	string_list_sort(out);
>       ++
>       ++	upstream_pattern_list_clear(patterns, nr_patterns);
>        +}
>        +
>       - static void collect_forked_set(int argc, const char **argv,
>       - 			       struct string_list *out)
>       - {
>       -@@ builtin/branch.c: static int list_forked_branches(int argc, const char **argv)
>       ++static int list_forked_branches(int argc, const char **argv)
>       ++{
>       ++	struct string_list out = STRING_LIST_INIT_DUP;
>       ++	struct string_list_item *item;
>       ++
>       ++	if (!argc)
>       ++		die(_("--forked requires at least one <branch>"));
>       ++
>       ++	collect_forked_set(argc, argv, &out);
>       + 	for_each_string_list_item(item, &out)
>       + 		puts(item->string);
>       +
>       +-	upstream_pattern_list_clear(patterns, nr_patterns);
>       + 	string_list_clear(&out, 0);
>         	return 0;
>         }
>         
>       @@ builtin/branch.c: static int list_forked_branches(int argc, const char **argv)
>        +{
>        +	struct ref_store *refs = get_main_ref_store(the_repository);
>        +	struct string_list candidates = STRING_LIST_INIT_DUP;
>       -+	struct string_list protected_default_names = STRING_LIST_INIT_DUP;
>        +	struct strvec deletable = STRVEC_INIT;
>       -+	struct strbuf buf = STRBUF_INIT;
>        +	struct string_list_item *item;
>       -+	int n_not_merged = 0;
>        +	int ret = 0;
>        +
>        +	if (!argc)
>        +		die(_("--prune-merged requires at least one <branch>"));
>        +
>        +	collect_forked_set(argc, argv, &candidates);
>       -+	for_each_remote(collect_default_branch_name, &protected_default_names);
>        +
>        +	for_each_string_list_item(item, &candidates) {
>        +		const char *short_name = item->string;
>       -+		const char *upstream = item->util;
>       -+
>       -+		strbuf_reset(&buf);
>       -+		strbuf_addf(&buf, "refs/heads/%s", short_name);
>       -+		if (branch_checked_out(buf.buf))
>       ++		struct branch *branch = branch_get(short_name);
>       ++		const char *upstream, *push;
>       ++		struct strbuf full = STRBUF_INIT;
>       ++		int skip;
>       ++
>       ++		strbuf_addf(&full, "refs/heads/%s", short_name);
>       ++		skip = !!branch_checked_out(full.buf);
>       ++		strbuf_release(&full);
>       ++		if (skip)
>        +			continue;
>        +
>       -+		if (string_list_has_string(&protected_default_names,
>       -+					   short_name))
>       ++		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
>       ++		if (!upstream || !refs_ref_exists(refs, upstream))
>        +			continue;
>       -+
>       -+		if (!refs_ref_exists(refs, upstream))
>       ++		push = branch ? branch_get_push(branch, NULL) : NULL;
>       ++		if (!push || !strcmp(push, upstream))
>        +			continue;
>        +
>        +		strvec_push(&deletable, short_name);
>        +	}
>       -+	strbuf_release(&buf);
>        +
>        +	if (deletable.nr)
>        +		ret = delete_branches(deletable.nr, deletable.v,
>       -+				      0, FILTER_REFS_BRANCHES, quiet,
>       -+				      1, &n_not_merged);
>       -+
>       -+	if (n_not_merged && !quiet)
>       -+		fprintf(stderr,
>       -+			Q_("Skipped %d branch that is not fully merged; "
>       -+			   "delete it with 'git branch -D' if you are sure.\n",
>       -+			   "Skipped %d branches that are not fully merged; "
>       -+			   "delete them with 'git branch -D' if you are sure.\n",
>       -+			   n_not_merged),
>       -+			n_not_merged);
>       ++				      0, /* force */
>       ++				      FILTER_REFS_BRANCHES,
>       ++				      quiet,
>       ++				      1, /* warn_only */
>       ++				      1, /* no_head_fallback */
>       ++				      0  /* dry_run */);
>        +
>        +	strvec_clear(&deletable);
>       -+	string_list_clear(&candidates, 1);
>       -+	string_list_clear(&protected_default_names, 0);
>       ++	string_list_clear(&candidates, 0);
>        +	return ret;
>        +}
>        +
>       @@ builtin/branch.c: int cmd_branch(int argc,
>         		OPT_BOOL(0, "forked", &forked,
>         			N_("list local branches whose upstream matches the given <branch>...")),
>        +		OPT_BOOL(0, "prune-merged", &prune_merged,
>       -+			N_("delete local branches whose upstream matches the given <branch>... and that are merged into it")),
>       ++			N_("delete local branches whose upstream matches the given <branch>... and is merged")),
>         		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
>         		OPT_MERGED(&filter, N_("print only branches that are merged")),
>         		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <branch>'
>        +	git -C pm-upstream branch one HEAD~ &&
>        +	git -C pm-upstream branch two HEAD &&
>        +	git -C pm-upstream branch wip main &&
>       -+	git -C pm-upstream checkout main
>       ++	git -C pm-upstream checkout main &&
>       ++	test_create_repo pm-fork
>        +'
>        +
>        +test_expect_success '--prune-merged deletes branches integrated into upstream' '
>        +	test_when_finished "rm -rf pm-merged" &&
>        +	git clone pm-upstream pm-merged &&
>       ++	git -C pm-merged remote add fork ../pm-fork &&
>       ++	test_config -C pm-merged remote.pushDefault fork &&
>       ++	test_config -C pm-merged push.default current &&
>        +	git -C pm-merged branch one one-commit &&
>        +	git -C pm-merged branch --set-upstream-to=origin/next one &&
>        +	git -C pm-merged branch two two-commit &&
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <branch>'
>        +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two
>        +'
>        +
>       -+test_expect_success '--prune-merged with a literal upstream argument' '
>       ++test_expect_success '--prune-merged accepts a literal upstream' '
>        +	test_when_finished "rm -rf pm-literal" &&
>        +	git clone pm-upstream pm-literal &&
>       ++	git -C pm-literal remote add fork ../pm-fork &&
>       ++	test_config -C pm-literal remote.pushDefault fork &&
>       ++	test_config -C pm-literal push.default current &&
>        +	git -C pm-literal branch one one-commit &&
>        +	git -C pm-literal branch --set-upstream-to=origin/next one &&
>       -+	git -C pm-literal branch keepme one-commit &&
>       -+	git -C pm-literal branch --set-upstream-to=origin/main keepme &&
>        +
>        +	git -C pm-literal branch --prune-merged origin/next &&
>        +
>       -+	test_must_fail git -C pm-literal rev-parse --verify refs/heads/one &&
>       -+	git -C pm-literal rev-parse --verify refs/heads/keepme
>       ++	test_must_fail git -C pm-literal rev-parse --verify refs/heads/one
>        +'
>        +
>        +test_expect_success '--prune-merged unions multiple <branch> arguments' '
>        +	test_when_finished "rm -rf pm-union" &&
>        +	git clone pm-upstream pm-union &&
>       ++	git -C pm-union remote add fork ../pm-fork &&
>       ++	test_config -C pm-union remote.pushDefault fork &&
>       ++	test_config -C pm-union push.default current &&
>        +	git -C pm-union branch one one-commit &&
>        +	git -C pm-union branch --set-upstream-to=origin/next one &&
>        +	git -C pm-union branch two base &&
>        +	git -C pm-union branch --set-upstream-to=origin/main two &&
>       ++	git -C pm-union checkout --detach &&
>        +
>        +	git -C pm-union branch --prune-merged origin/next origin/main &&
>        +
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <branch>'
>        +	test_must_fail git -C pm-union rev-parse --verify refs/heads/two
>        +'
>        +
>       -+test_expect_success '--prune-merged with a local-branch argument' '
>       -+	test_create_repo pm-local &&
>       ++test_expect_success '--prune-merged accepts a local upstream' '
>        +	test_when_finished "rm -rf pm-local" &&
>       -+	test_commit -C pm-local base &&
>       -+	git -C pm-local branch topic base &&
>       -+	git -C pm-local config branch.topic.remote . &&
>       -+	git -C pm-local config branch.topic.merge refs/heads/main &&
>       -+	git -C pm-local checkout --detach &&
>       -+
>       -+	git -C pm-local branch --prune-merged main &&
>       -+
>       -+	test_must_fail git -C pm-local rev-parse --verify refs/heads/topic &&
>       -+	git -C pm-local rev-parse --verify refs/heads/main
>       ++	git clone pm-upstream pm-local &&
>       ++	git -C pm-local remote add fork ../pm-fork &&
>       ++	test_config -C pm-local remote.pushDefault fork &&
>       ++	test_config -C pm-local push.default current &&
>       ++	git -C pm-local checkout -b trunk &&
>       ++	git -C pm-local branch one one-commit &&
>       ++	git -C pm-local branch --set-upstream-to=trunk one &&
>       ++	git -C pm-local merge --ff-only one-commit &&
>       ++
>       ++	git -C pm-local branch --prune-merged trunk &&
>       ++
>       ++	test_must_fail git -C pm-local rev-parse --verify refs/heads/one
>        +'
>        +
>       -+test_expect_success '--prune-merged spares branches with un-integrated commits' '
>       ++test_expect_success '--prune-merged warns instead of erroring on un-integrated commits' '
>        +	test_when_finished "rm -rf pm-unmerged" &&
>        +	git clone pm-upstream pm-unmerged &&
>       ++	git -C pm-unmerged remote add fork ../pm-fork &&
>       ++	test_config -C pm-unmerged remote.pushDefault fork &&
>       ++	test_config -C pm-unmerged push.default current &&
>        +	git -C pm-unmerged checkout -b wip origin/wip &&
>        +	git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
>        +	test_commit -C pm-unmerged local-only &&
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <branch>'
>        +
>        +	git -C pm-unmerged branch --prune-merged "origin/*" 2>err &&
>        +	test_grep "not fully merged" err &&
>       -+	test_grep "Skipped 1 branch" err &&
>       -+	test_grep "git branch -D" err &&
>        +	test_grep ! "If you are sure you want to delete it" err &&
>        +	git -C pm-unmerged rev-parse --verify refs/heads/wip
>        +'
>        +
>       ++test_expect_success '--prune-merged is silent about not-merged-to-HEAD' '
>       ++	test_when_finished "rm -rf pm-nohead" &&
>       ++	git clone pm-upstream pm-nohead &&
>       ++	git -C pm-nohead remote add fork ../pm-fork &&
>       ++	test_config -C pm-nohead remote.pushDefault fork &&
>       ++	test_config -C pm-nohead push.default current &&
>       ++	git -C pm-nohead branch topic one-commit &&
>       ++	git -C pm-nohead branch --set-upstream-to=origin/next topic &&
>       ++
>       ++	git -C pm-nohead branch --prune-merged "origin/*" 2>err &&
>       ++
>       ++	test_grep ! "not yet merged to HEAD" err &&
>       ++	test_must_fail git -C pm-nohead rev-parse --verify refs/heads/topic
>       ++'
>       ++
>        +test_expect_success '--prune-merged skips branches whose upstream is gone' '
>        +	test_when_finished "rm -rf pm-upstream-gone" &&
>        +	git clone pm-upstream pm-upstream-gone &&
>       ++	git -C pm-upstream-gone remote add fork ../pm-fork &&
>       ++	test_config -C pm-upstream-gone remote.pushDefault fork &&
>       ++	test_config -C pm-upstream-gone push.default current &&
>        +	git -C pm-upstream-gone branch one one-commit &&
>        +	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
>        +
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <branch>'
>        +test_expect_success '--prune-merged never deletes the checked-out branch' '
>        +	test_when_finished "rm -rf pm-head" &&
>        +	git clone pm-upstream pm-head &&
>       ++	git -C pm-head remote add fork ../pm-fork &&
>       ++	test_config -C pm-head remote.pushDefault fork &&
>       ++	test_config -C pm-head push.default current &&
>        +	git -C pm-head checkout -b one one-commit &&
>        +	git -C pm-head branch --set-upstream-to=origin/next one &&
>        +
>       @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <branch>'
>        +	git -C pm-head rev-parse --verify refs/heads/one
>        +'
>        +
>       -+test_expect_success '--prune-merged spares the local default branch' '
>       -+	test_when_finished "rm -rf pm-default" &&
>       -+	git clone pm-upstream pm-default &&
>       -+	git -C pm-default checkout --detach &&
>       -+	git -C pm-default branch --prune-merged "origin/*" &&
>       -+	git -C pm-default rev-parse --verify refs/heads/main
>       ++test_expect_success '--prune-merged spares branches that push back to their upstream' '
>       ++	test_when_finished "rm -rf pm-push-eq" &&
>       ++	git clone pm-upstream pm-push-eq &&
>       ++	git -C pm-push-eq checkout --detach &&
>       ++
>       ++	git -C pm-push-eq branch --prune-merged "origin/*" &&
>       ++
>       ++	git -C pm-push-eq rev-parse --verify refs/heads/main
>        +'
>        +
>       -+test_expect_success '--prune-merged protects the default branch by name only' '
>       -+	test_when_finished "rm -rf pm-default-alias" &&
>       -+	git clone pm-upstream pm-default-alias &&
>       -+	git -C pm-default-alias branch --track trunk origin/main &&
>       -+	git -C pm-default-alias checkout --detach &&
>       -+	git -C pm-default-alias branch --prune-merged "origin/*" &&
>       -+	git -C pm-default-alias rev-parse --verify refs/heads/main &&
>       -+	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
>       ++test_expect_success '--prune-merged spares a per-branch pushRemote==upstream remote' '
>       ++	test_when_finished "rm -rf pm-push-branch" &&
>       ++	git clone pm-upstream pm-push-branch &&
>       ++	git -C pm-push-branch remote add fork ../pm-fork &&
>       ++	test_config -C pm-push-branch remote.pushDefault fork &&
>       ++	test_config -C pm-push-branch push.default current &&
>       ++	test_config -C pm-push-branch branch.main.pushRemote origin &&
>       ++	git -C pm-push-branch checkout --detach &&
>       ++
>       ++	git -C pm-push-branch branch --prune-merged "origin/*" &&
>       ++
>       ++	git -C pm-push-branch rev-parse --verify refs/heads/main
>        +'
>        +
>       -+test_expect_success '--prune-merged with literal arg also protects default-name' '
>       -+	test_when_finished "rm -rf pm-literal-default" &&
>       -+	git clone pm-upstream pm-literal-default &&
>       -+	git -C pm-literal-default checkout --detach &&
>       -+	git -C pm-literal-default branch --prune-merged origin/main &&
>       -+	git -C pm-literal-default rev-parse --verify refs/heads/main
>       ++test_expect_success '--prune-merged prunes when @{push} differs from @{upstream}' '
>       ++	test_when_finished "rm -rf pm-push-diff" &&
>       ++	git clone pm-upstream pm-push-diff &&
>       ++	git -C pm-push-diff remote add fork ../pm-fork &&
>       ++	test_config -C pm-push-diff remote.pushDefault fork &&
>       ++	test_config -C pm-push-diff push.default current &&
>       ++	git -C pm-push-diff branch topic one-commit &&
>       ++	git -C pm-push-diff branch --set-upstream-to=origin/next topic &&
>       ++	git -C pm-push-diff checkout --detach &&
>       ++
>       ++	git -C pm-push-diff branch --prune-merged "origin/*" &&
>       ++
>       ++	test_must_fail git -C pm-push-diff rev-parse --verify refs/heads/topic
>        +'
>        +
>        +test_expect_success '--prune-merged requires at least one <branch>' '
>       -+	test_must_fail git -C pm-upstream branch --prune-merged 2>err &&
>       ++	test_must_fail git -C forked branch --prune-merged 2>err &&
>        +	test_grep "at least one <branch>" err
>        +'
>        +
>   3:  6e38d7af3a ! 5:  75b6d2366a branch: add branch.<name>.pruneMerged opt-out
>       @@ Metadata
>         ## Commit message ##
>            branch: add branch.<name>.pruneMerged opt-out
>        
>       -    Setting branch.<name>.pruneMerged=false exempts that branch
>       -    from --prune-merged. Useful for topic branches you intend to
>       -    develop further after an initial round has been merged
>       +    Setting branch.<name>.pruneMerged=false exempts that branch from
>       +    "git branch --prune-merged". Useful for a topic branch you want
>       +    to develop further after an initial round has been merged
>            upstream.
>        
>       -    Explicit deletion via 'git branch -d' is unaffected.
>       +    Unless --quiet is given, the skip is reported per branch so the
>       +    user knows why their topic was preserved.
>       +
>       +    Explicit deletion via "git branch -d" continues to consult the
>       +    normal merge check and is not affected by this setting.
>        
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>        
>       @@ Documentation/config/branch.adoc: for details).
>        +
>        +`branch.<name>.pruneMerged`::
>        +	If set to `false`, branch _<name>_ is exempt from
>       -+	`git branch --prune-merged`. Defaults to true. Explicit
>       -+	deletion via `git branch -d` is unaffected.
>       ++	`git branch --prune-merged`.  Useful for a topic branch you
>       ++	intend to develop further after an initial round has been
>       ++	merged upstream.  Defaults to true.  Explicit deletion via
>       ++	`git branch -d` is unaffected.
>        
>         ## Documentation/git-branch.adoc ##
>       -@@ Documentation/git-branch.adoc: The following branches are always preserved:
>       -   any configured remote (the target of
>       -   `refs/remotes/<remote>/HEAD`) -- typically `main` or
>       -   `master`;
>       -+* any branch with `branch.<name>.pruneMerged` set to `false`;
>       - * any branch whose upstream no longer resolves locally.
>       - --
>       -
>       +@@ Documentation/git-branch.adoc: the upstream refs refreshed.
>       + +
>       + A branch is left alone if any of the following holds:
>       + its upstream no longer resolves locally; it is checked out in any
>       +-worktree; or its push destination (`<branch>@{push}`) equals its
>       ++worktree; its push destination (`<branch>@{push}`) equals its
>       + upstream (`<branch>@{upstream}`), so it cannot be distinguished
>       +-from a freshly pulled trunk that just looks "fully merged".
>       ++from a freshly pulled trunk that just looks "fully merged"; or
>       ++`branch.<name>.pruneMerged` is set to `false`.
>       + +
>       + Branches refused by the "fully merged" safety check are listed as
>       + warnings and skipped; pass them to `git branch -D` explicitly if
>        
>         ## builtin/branch.c ##
>        @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int quiet)
>       - 	for_each_string_list_item(item, &candidates) {
>       - 		const char *short_name = item->string;
>       - 		const char *upstream = item->util;
>       -+		int prune_allowed = 1;
>       + 		struct branch *branch = branch_get(short_name);
>       + 		const char *upstream, *push;
>       + 		struct strbuf full = STRBUF_INIT;
>       ++		struct strbuf key = STRBUF_INIT;
>       + 		int skip;
>       ++		int opt_out;
>         
>       - 		strbuf_reset(&buf);
>       - 		strbuf_addf(&buf, "refs/heads/%s", short_name);
>       + 		strbuf_addf(&full, "refs/heads/%s", short_name);
>       + 		skip = !!branch_checked_out(full.buf);
>        @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int quiet)
>       - 		if (!refs_ref_exists(refs, upstream))
>       + 		if (!push || !strcmp(push, upstream))
>         			continue;
>         
>       -+		strbuf_reset(&buf);
>       -+		strbuf_addf(&buf, "branch.%s.prunemerged", short_name);
>       -+		if (!repo_config_get_bool(the_repository, buf.buf,
>       -+					  &prune_allowed) &&
>       -+		    !prune_allowed) {
>       ++		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
>       ++		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
>       ++		    !opt_out) {
>        +			if (!quiet)
>       -+				fprintf(stderr, _("Skipping '%s' "
>       -+						  "(branch.%s.pruneMerged is false)\n"),
>       ++				fprintf(stderr,
>       ++					_("Skipping '%s' (branch.%s.pruneMerged is false)\n"),
>        +					short_name, short_name);
>       ++			strbuf_release(&key);
>        +			continue;
>        +		}
>       ++		strbuf_release(&key);
>        +
>         		strvec_push(&deletable, short_name);
>         	}
>       - 	strbuf_release(&buf);
>       +
>        
>         ## t/t3200-branch.sh ##
>        @@ t/t3200-branch.sh: test_expect_success '--prune-merged requires at least one <branch>' '
>       @@ t/t3200-branch.sh: test_expect_success '--prune-merged requires at least one <br
>        +test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
>        +	test_when_finished "rm -rf pm-optout" &&
>        +	git clone pm-upstream pm-optout &&
>       ++	git -C pm-optout remote add fork ../pm-fork &&
>       ++	test_config -C pm-optout remote.pushDefault fork &&
>       ++	test_config -C pm-optout push.default current &&
>        +	git -C pm-optout branch one one-commit &&
>        +	git -C pm-optout branch --set-upstream-to=origin/next one &&
>        +	git -C pm-optout branch two two-commit &&
>        +	git -C pm-optout branch --set-upstream-to=origin/next two &&
>       -+	git -C pm-optout config branch.one.pruneMerged false &&
>       ++	test_config -C pm-optout branch.one.pruneMerged false &&
>        +
>        +	git -C pm-optout branch --prune-merged "origin/*" 2>err &&
>        +
>       @@ t/t3200-branch.sh: test_expect_success '--prune-merged requires at least one <br
>        +	git clone pm-upstream pm-optout-d &&
>        +	git -C pm-optout-d branch one one-commit &&
>        +	git -C pm-optout-d branch --set-upstream-to=origin/next one &&
>       -+	git -C pm-optout-d config branch.one.pruneMerged false &&
>       ++	test_config -C pm-optout-d branch.one.pruneMerged false &&
>        +
>        +	git -C pm-optout-d branch -d one &&
>        +	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
>   4:  c68d162e22 ! 6:  a1a42a6b19 branch: add --dry-run for --prune-merged
>       @@ Metadata
>         ## Commit message ##
>            branch: add --dry-run for --prune-merged
>        
>       -    With --dry-run, --prune-merged prints the branches it would
>       -    delete and exits without touching any ref. Useful for
>       -    sanity-checking a glob like 'origin/*' before letting it run.
>       +    With --dry-run, --prune-merged prints the local branches it would
>       +    delete -- one "Would delete branch <name>" line per candidate --
>       +    and exits without touching any ref.
>       +
>       +    This is the natural sanity check before letting a broad pattern
>       +    like 'origin/*' run for real: the @{push}-vs-@{upstream} and
>       +    unmerged filtering still applies, so the dry-run output is
>       +    exactly the set that the live run would delete.
>       +
>       +    --dry-run is only meaningful in combination with --prune-merged
>       +    and is rejected otherwise.
>        
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>        
>       @@ Documentation/git-branch.adoc: git branch (-c|-C) [<old-branch>] <new-branch>
>         
>         DESCRIPTION
>         -----------
>       -@@ Documentation/git-branch.adoc: The following branches are always preserved:
>       - * any branch whose upstream no longer resolves locally.
>       - --
>       +@@ Documentation/git-branch.adoc: Branches refused by the "fully merged" safety check are listed as
>       + warnings and skipped; pass them to `git branch -D` explicitly if
>       + you want them gone.
>         
>        +`--dry-run`::
>       -+	With `--prune-merged`, print the branches that would be
>       -+	deleted instead of deleting them.
>       ++	With `--prune-merged`, print which branches would be
>       ++	deleted and exit without touching any ref.  Useful for
>       ++	sanity-checking a wide pattern like `'origin/*'` before
>       ++	committing to the deletion.
>        +
>         `-v`::
>         `-vv`::
>         `--verbose`::
>        
>         ## builtin/branch.c ##
>       -@@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
>       - 	N_("git branch [<options>] [-r | -a] [--points-at]"),
>       - 	N_("git branch [<options>] [-r | -a] [--format]"),
>       - 	N_("git branch [<options>] --forked <branch>..."),
>       --	N_("git branch [<options>] --prune-merged <branch>..."),
>       -+	N_("git branch [<options>] --prune-merged [--dry-run] <branch>..."),
>       - 	NULL
>       - };
>       -
>       -@@ builtin/branch.c: static void delete_branch_config(const char *branchname)
>       - }
>       -
>       - static int delete_branches(int argc, const char **argv, int force, int kinds,
>       --			   int quiet, int warn_only, int *n_not_merged)
>       -+			   int quiet, int warn_only, int dry_run,
>       -+			   int *n_not_merged)
>       - {
>       - 	struct commit *head_rev = NULL;
>       - 	struct object_id oid;
>       -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
>       - 			goto next;
>       - 		}
>       -
>       -+		if (dry_run) {
>       -+			printf(_("Would delete branch '%s'\n"),
>       -+			       name + branch_name_pos);
>       -+			goto next;
>       -+		}
>       -+
>       - 		item = string_list_append(&refs_to_delete, name);
>       - 		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
>       - 				    : (flags & REF_ISSYMREF) ? target
>        @@ builtin/branch.c: static int list_forked_branches(int argc, const char **argv)
>         	return 0;
>         }
>         
>        -static int prune_merged_branches(int argc, const char **argv, int quiet)
>       -+static int prune_merged_branches(int argc, const char **argv,
>       -+				 int dry_run, int quiet)
>       ++static int prune_merged_branches(int argc, const char **argv, int quiet,
>       ++				 int dry_run)
>         {
>         	struct ref_store *refs = get_main_ref_store(the_repository);
>         	struct string_list candidates = STRING_LIST_INIT_DUP;
>        @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int quiet)
>       - 	if (deletable.nr)
>       - 		ret = delete_branches(deletable.nr, deletable.v,
>       - 				      0, FILTER_REFS_BRANCHES, quiet,
>       --				      1, &n_not_merged);
>       -+				      1, dry_run, &n_not_merged);
>       + 				      quiet,
>       + 				      1, /* warn_only */
>       + 				      1, /* no_head_fallback */
>       +-				      0  /* dry_run */);
>       ++				      dry_run);
>         
>       - 	if (n_not_merged && !quiet)
>       - 		fprintf(stderr,
>       + 	strvec_clear(&deletable);
>       + 	string_list_clear(&candidates, 0);
>        @@ builtin/branch.c: int cmd_branch(int argc,
>         	    unset_upstream = 0, show_current = 0, edit_description = 0;
>         	int forked = 0;
>       @@ builtin/branch.c: int cmd_branch(int argc,
>        @@ builtin/branch.c: int cmd_branch(int argc,
>         			N_("list local branches whose upstream matches the given <branch>...")),
>         		OPT_BOOL(0, "prune-merged", &prune_merged,
>       - 			N_("delete local branches whose upstream matches the given <branch>... and that are merged into it")),
>       + 			N_("delete local branches whose upstream matches the given <branch>... and is merged")),
>        +		OPT_BOOL(0, "dry-run", &dry_run,
>       -+			N_("with --prune-merged, only print what would be deleted")),
>       ++			N_("with --prune-merged, only print which branches would be deleted")),
>         		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
>         		OPT_MERGED(&filter, N_("print only branches that are merged")),
>         		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
>        @@ builtin/branch.c: int cmd_branch(int argc,
>       - 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
>       - 			     0);
>       + 	if (noncreate_actions > 1)
>       + 		usage_with_options(builtin_branch_usage, options);
>         
>        +	if (dry_run && !prune_merged)
>        +		die(_("--dry-run requires --prune-merged"));
>        +
>       - 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
>       - 	    !show_current && !unset_upstream && !forked && !prune_merged &&
>       - 	    argc == 0)
>       + 	if (recurse_submodules_explicit) {
>       + 		if (!submodule_propagate_branches)
>       + 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
>        @@ builtin/branch.c: int cmd_branch(int argc,
>       - 		if (!argc)
>       - 			die(_("branch name required"));
>       - 		ret = delete_branches(argc, argv, delete > 1, filter.kind,
>       --				      quiet, 0, NULL);
>       -+				      quiet, 0, 0, NULL);
>       - 		goto out;
>       - 	} else if (forked) {
>         		ret = list_forked_branches(argc, argv);
>         		goto out;
>         	} else if (prune_merged) {
>        -		ret = prune_merged_branches(argc, argv, quiet);
>       -+		ret = prune_merged_branches(argc, argv, dry_run, quiet);
>       ++		ret = prune_merged_branches(argc, argv, quiet, dry_run);
>         		goto out;
>         	} else if (show_current) {
>         		print_current_branch_name();
>       @@ t/t3200-branch.sh: test_expect_success 'branch -d still deletes a pruneMerged=fa
>         	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
>         '
>         
>       -+test_expect_success '--prune-merged --dry-run prints but does not delete' '
>       -+	test_when_finished "rm -rf pm-dryrun" &&
>       -+	git clone pm-upstream pm-dryrun &&
>       -+	git -C pm-dryrun branch one one-commit &&
>       -+	git -C pm-dryrun branch --set-upstream-to=origin/next one &&
>       ++test_expect_success '--prune-merged --dry-run lists but does not delete' '
>       ++	test_when_finished "rm -rf pm-dry" &&
>       ++	git clone pm-upstream pm-dry &&
>       ++	git -C pm-dry remote add fork ../pm-fork &&
>       ++	test_config -C pm-dry remote.pushDefault fork &&
>       ++	test_config -C pm-dry push.default current &&
>       ++	git -C pm-dry branch one one-commit &&
>       ++	git -C pm-dry branch --set-upstream-to=origin/next one &&
>       ++	git -C pm-dry branch two two-commit &&
>       ++	git -C pm-dry branch --set-upstream-to=origin/next two &&
>       ++
>       ++	git -C pm-dry branch --prune-merged --dry-run "origin/*" >actual &&
>       ++	test_grep "Would delete branch one " actual &&
>       ++	test_grep "Would delete branch two " actual &&
>        +
>       -+	git -C pm-dryrun branch --prune-merged --dry-run "origin/*" >out &&
>       -+	test_grep "Would delete branch .one." out &&
>       -+	git -C pm-dryrun rev-parse --verify refs/heads/one
>       ++	git -C pm-dry rev-parse --verify refs/heads/one &&
>       ++	git -C pm-dry rev-parse --verify refs/heads/two
>        +'
>        +
>       -+test_expect_success '--prune-merged --dry-run skips un-integrated branches' '
>       -+	test_when_finished "rm -rf pm-dryrun-unmerged" &&
>       -+	git clone pm-upstream pm-dryrun-unmerged &&
>       -+	git -C pm-dryrun-unmerged checkout -b wip origin/next &&
>       -+	git -C pm-dryrun-unmerged branch --set-upstream-to=origin/next wip &&
>       -+	test_commit -C pm-dryrun-unmerged local-only &&
>       -+	git -C pm-dryrun-unmerged checkout - &&
>       -+	git -C pm-dryrun-unmerged branch merged one-commit &&
>       -+	git -C pm-dryrun-unmerged branch --set-upstream-to=origin/next merged &&
>       ++test_expect_success '--prune-merged --dry-run only lists branches the live run would delete' '
>       ++	test_when_finished "rm -rf pm-dry-mixed" &&
>       ++	git clone pm-upstream pm-dry-mixed &&
>       ++	git -C pm-dry-mixed remote add fork ../pm-fork &&
>       ++	test_config -C pm-dry-mixed remote.pushDefault fork &&
>       ++	test_config -C pm-dry-mixed push.default current &&
>       ++	git -C pm-dry-mixed checkout -b wip origin/next &&
>       ++	git -C pm-dry-mixed branch --set-upstream-to=origin/next wip &&
>       ++	test_commit -C pm-dry-mixed local-only &&
>       ++	git -C pm-dry-mixed checkout - &&
>       ++	git -C pm-dry-mixed branch merged one-commit &&
>       ++	git -C pm-dry-mixed branch --set-upstream-to=origin/next merged &&
>        +
>       -+	git -C pm-dryrun-unmerged branch --prune-merged --dry-run "origin/*" \
>       -+		>out 2>err &&
>       -+	test_grep "Would delete branch .merged." out &&
>       -+	test_grep ! "Would delete branch .wip." out &&
>       -+	test_grep "not fully merged" err &&
>       -+	git -C pm-dryrun-unmerged rev-parse --verify refs/heads/wip &&
>       -+	git -C pm-dryrun-unmerged rev-parse --verify refs/heads/merged
>       ++	git -C pm-dry-mixed branch --prune-merged --dry-run "origin/*" >out &&
>       ++	test_grep "Would delete branch merged" out &&
>       ++	test_grep ! "Would delete branch wip" out &&
>       ++	git -C pm-dry-mixed rev-parse --verify refs/heads/wip &&
>       ++	git -C pm-dry-mixed rev-parse --verify refs/heads/merged
>        +'
>        +
>       -+test_expect_success '--dry-run requires --prune-merged' '
>       -+	test_must_fail git -C pm-upstream branch --dry-run 2>err &&
>       ++test_expect_success '--dry-run without --prune-merged is rejected' '
>       ++	test_must_fail git -C forked branch --dry-run 2>err &&
>        +	test_grep "requires --prune-merged" err
>        +'
>        +
> 

