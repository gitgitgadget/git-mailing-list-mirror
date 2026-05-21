Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC34356761
	for <git@vger.kernel.org>; Thu, 21 May 2026 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403212; cv=none; b=SZJxXkFupsYzZ8ltVGb5yIv1EpABjULNVramjx8cOWoDRKS7xLc7FnBP1ZereTTJcxwflFt0rWcn+wAgFBYzqY61ved//f+GjeaDmYAcEoqtpKjlbh784F4W025FaY7ghdDzgSlstLDEnQhovgOVw9VatDXTBcqt7deSnRfIaBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403212; c=relaxed/simple;
	bh=0PZ5tiv3eM/WWao0MKxRsh6xaE/6BSnZSxVm7z7Ygg4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EG3dEtFcBZejpdbEymcEOOw0TCpl6EkrI/QXSWzFaB1jK4RT2FyeM2c7xrJ1rek0UO1qMYPm1b+gpWuU77VLh+zWfbAS+I3aVPB+8U97i2STV9Ef7cNI09SagyYgzLStHKRqgleP7N3GTY6Ga3JGwN93FYJU19IKxw+y/uAlMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWSmTt1q; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWSmTt1q"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1331e851faaso3552640c88.1
        for <git@vger.kernel.org>; Thu, 21 May 2026 15:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779403207; x=1780008007; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCNYB0FeXNeV+UAOP7FzcUf9oA7cNIBR4pLk0Vv/khA=;
        b=KWSmTt1qW9dXUBVAFU+oWTYAyVb5Id3POkmWH34jPZuAKRjoPHmEQ0DdPJdhYASwoX
         +J09/QzKgH/dhQ9TxDe4i3CuYBHmhBx36d0Iz0jRs/GjfviTwz0o4TJnpTt7bLD6V9Fw
         NonLqFYJPCLpociOv5HDSaxyySat9J3C6bnmUb2w8OJdj1NyBfP5guQKSKJnVWRIL5Tj
         fDJInjX+1gpmOQ12PbUZ9mdtTVN5B25LO2aAy83/PrjUO3E6dERYqyDuqfhPCMNm8fgE
         1fxmN8jwBCTDEzNoO4wGxA9CjfEM6ratzwqqtBhWeFWzL1Mu9SF1nMelPayzPCXO8skJ
         h1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779403207; x=1780008007;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yCNYB0FeXNeV+UAOP7FzcUf9oA7cNIBR4pLk0Vv/khA=;
        b=DK9cmZOeAtukXDz71x6w8exus1mYKkxveFFHpQvY2WXKd/ML8zLnZEnyrX6lZLCwDz
         2MTArP70iJ10QzEgMLVT5ErhEU774xV7OAIvwNdkqa5habmKHhAwVuDIonw+zHoqTpoz
         60/tMciwp5YrZp14GW0smj+sbpXoczajj7779OFD2mFDPDkECAGFKPDA61a6EItsygjI
         vIaiv7YWxMXFxxEVHY/YK7Tbs84C88Z85jFRpSSyZ80unkUYbGfDUnArLjzHRa3EO6bg
         77gIgMid31miJdF+vYsuIW6622AonsXDqgKs3fmB9jDyFnNxoPLz9LlFZm0VXYgvetJb
         +Mpg==
X-Gm-Message-State: AOJu0Yy5z0kA4GA6mhLyXMtJiMNXmvu2shURdBj6Oyj1f3mv2SHoFUAV
	Rrsk7HQPOIBhBLICanCuU4kwKVZdw4q/6rnPodn9oJyV6UH0zC6J8NdTwVBPtg==
X-Gm-Gg: Acq92OEDNCIeocyBRRKpn1SFCyal34wXKgt6vXYLLSix8RODID3xqJZYNAPbwGPg6LL
	01D7LunJMCi8rAoHln7UPbjsISCSoLZ1kNdMsZVRsu/ZHulFwHo5NDVQHyypHcmKjLTocGX6ele
	VZUJIskA7WKzDkn6jOpf016wYF6uni3IQXuZ/rJVaGXKn6DyiaRIjpFTeqk89ZOjdDBtNjmTWrf
	Tng9f7Rr6urUq9wstjppmGBQv2i63n31wJAWWNFmQWSJZ/w4ccwaHp9NNxV/7b70Z5WQ6XfK2Zj
	+w4li89dbd2QqOIJIrTAQutDisry/6HaR4CJFncRn0tZzrsF4CWTim5CleW4WsZl97HL40OTykg
	XnNVfzg7Ll3zo0FpSz4bRkxJqVguSELGdyUL/WWv6z31Fb3oG3fnaAHrsKwcGNymERizuAn/Qut
	Avx+ZqCY9Eta5ox7xpmlyESaNTRQ==
X-Received: by 2002:a05:7022:b904:b0:12c:9037:5115 with SMTP id a92af1059eb24-136614d3abemr200784c88.13.1779403206772;
        Thu, 21 May 2026 15:40:06 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.62.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13662755287sm334923c88.11.2026.05.21.15.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:40:06 -0700 (PDT)
Message-Id: <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 May 2026 22:40:00 +0000
Subject: [PATCH v10 0/4] branch: prune-merged
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

 * --forked / --prune-merged now take a branch glob instead of a remote name
   — origin, origin/*, origin/release-* all work. This replaces the
   remote-only form and subsumes the old --all-remotes flag, which has been
   dropped.
 * New --dry-run for --prune-merged.

Harald Nordgren (4):
  branch: add --forked <branch>
  branch: add --prune-merged <branch>
  branch: add branch.<name>.pruneMerged opt-out
  branch: add --dry-run for --prune-merged

 Documentation/config/branch.adoc |   5 +
 Documentation/git-branch.adoc    |  33 ++++
 builtin/branch.c                 | 253 +++++++++++++++++++++++++--
 t/t3200-branch.sh                | 282 +++++++++++++++++++++++++++++++
 4 files changed, 560 insertions(+), 13 deletions(-)


base-commit: aec3f587505a472db67e9462d0702e7d463a449d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v10
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v9:

 1:  9324b26091 ! 1:  f2df159830 branch: add --forked <remote>
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: add --forked <remote>
     +    branch: add --forked <branch>
      
     -    List local branches whose configured upstream falls within any of
     -    the given <remote> arguments. <remote> may be either a configured
     -    remote name (matching all of its remote-tracking branches) or a
     -    single remote-tracking branch. Multiple <remote> arguments are
     -    unioned.
     +            git branch --forked <branch>...
      
     -    This is the building block for --prune-merged, which deletes the
     -    listed branches.
     +    lists local branches whose configured upstream matches any
     +    of the given <branch> arguments.
     +
     +    Each <branch> is resolved to the same kind of ref that
     +    branch.<name>.remote and branch.<name>.merge together point at:
     +    a remote-tracking branch (e.g. origin/master), or, for branches
     +    tracking a local upstream, a local branch (e.g. master).
     +    Shell-style globs are also accepted (e.g. 'origin/*'). Multiple
     +    arguments are unioned.
     +
     +    This is the building block for --prune-merged.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
     -+git branch --forked <remote>...
     ++git branch --forked <branch>...
       
       DESCRIPTION
       -----------
     @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mod
       	nothing is printed.
       
      +`--forked`::
     -+	List local branches that fork from any of the given _<remote>_
     -+	arguments, that is, those whose configured upstream
     -+	(`branch.<name>.merge`) is one of those remotes' remote-tracking
     -+	branches.
     -++
     -+Each _<remote>_ may be either the name of a configured remote
     -+(e.g. `origin`, meaning any branch tracking a
     -+`refs/remotes/origin/*` ref) or a specific remote-tracking branch
     -+(e.g. `origin/master`). Multiple _<remote>_ arguments are unioned.
     ++	List local branches whose configured upstream matches any
     ++	of the given _<branch>_ arguments. Each argument is either
     ++	a ref (e.g. `origin/master`, `master`) or a shell-style
     ++	glob (e.g. `'origin/*'`). Multiple arguments are unioned.
      +
       `-v`::
       `-vv`::
       `--verbose`::
      
       ## builtin/branch.c ##
     +@@
     + #include "help.h"
     + #include "advice.h"
     + #include "commit-reach.h"
     ++#include "wildmatch.h"
     + 
     + static const char * const builtin_branch_usage[] = {
     + 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
      @@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
       	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
       	N_("git branch [<options>] [-r | -a] [--points-at]"),
       	N_("git branch [<options>] [-r | -a] [--format]"),
     -+	N_("git branch [<options>] --forked <remote>..."),
     ++	N_("git branch [<options>] --forked <branch>..."),
       	NULL
       };
       
     +@@ builtin/branch.c: static int branch_merged(int kind, const char *name,
     + 
     + static int check_branch_commit(const char *branchname, const char *refname,
     + 			       const struct object_id *oid, struct commit *head_rev,
     +-			       int kinds, int force)
     ++			       int kinds, int force, int warn_only,
     ++			       int *n_not_merged)
     + {
     + 	struct commit *rev = lookup_commit_reference(the_repository, oid);
     + 	if (!force && !rev) {
     +@@ builtin/branch.c: static int check_branch_commit(const char *branchname, const char *refname,
     + 		return -1;
     + 	}
     + 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
     +-		error(_("the branch '%s' is not fully merged"), branchname);
     +-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
     +-				  _("If you are sure you want to delete it, "
     +-				  "run 'git branch -D %s'"), branchname);
     ++		if (warn_only) {
     ++			warning(_("the branch '%s' is not fully merged"),
     ++				branchname);
     ++		} else {
     ++			error(_("the branch '%s' is not fully merged"),
     ++			      branchname);
     ++			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
     ++					  _("If you are sure you want to delete it, "
     ++					  "run 'git branch -D %s'"), branchname);
     ++		}
     ++		if (n_not_merged)
     ++			(*n_not_merged)++;
     + 		return -1;
     + 	}
     + 	return 0;
     +@@ builtin/branch.c: static void delete_branch_config(const char *branchname)
     + }
     + 
     + static int delete_branches(int argc, const char **argv, int force, int kinds,
     +-			   int quiet)
     ++			   int quiet, int warn_only, int *n_not_merged)
     + {
     + 	struct commit *head_rev = NULL;
     + 	struct object_id oid;
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     + 
     + 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
     + 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
     +-					force)) {
     +-			ret = 1;
     ++					force, warn_only, n_not_merged)) {
     ++			if (!warn_only)
     ++				ret = 1;
     + 			goto next;
     + 		}
     + 
      @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const char *newname, int
       	free_worktrees(worktrees);
       }
       
      +static void parse_forked_args(int argc, const char **argv,
     -+			      struct string_list *remote_names,
     -+			      struct string_list *tracking_refs)
     ++			      struct string_list *upstream_patterns)
      +{
      +	int i;
      +
      +	for (i = 0; i < argc; i++) {
      +		const char *arg = argv[i];
     -+		struct remote *remote;
      +		struct object_id oid;
      +		char *full_ref = NULL;
     ++		const char *short_ref;
      +
     -+		remote = remote_get(arg);
     -+		if (remote && remote_is_configured(remote, 0)) {
     -+			string_list_insert(remote_names, remote->name);
     ++		if (has_glob_specials(arg)) {
     ++			string_list_insert(upstream_patterns, arg);
      +			continue;
      +		}
      +
      +		if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
      +				  &full_ref, 0) == 1 &&
     -+		    starts_with(full_ref, "refs/remotes/")) {
     -+			string_list_insert(tracking_refs, full_ref);
     ++		    (skip_prefix(full_ref, "refs/heads/", &short_ref) ||
     ++		     skip_prefix(full_ref, "refs/remotes/", &short_ref))) {
     ++			string_list_insert(upstream_patterns, short_ref);
      +			free(full_ref);
      +			continue;
      +		}
      +		free(full_ref);
      +
     -+		die(_("'%s' is neither a configured remote nor a "
     -+		      "remote-tracking branch"), arg);
     ++		die(_("'%s' is not a valid branch or pattern"), arg);
      +	}
      +}
      +
     -+static int branch_is_forked(const char *short_name,
     -+			    const struct string_list *remote_names,
     -+			    const struct string_list *tracking_refs)
     -+{
     -+	struct branch *branch = branch_get(short_name);
     -+	const char *upstream;
     -+
     -+	if (!branch || !branch->remote_name)
     -+		return 0;
     -+
     -+	if (string_list_has_string(remote_names, branch->remote_name))
     -+		return 1;
     -+
     -+	upstream = branch_get_upstream(branch, NULL);
     -+	if (upstream && string_list_has_string(tracking_refs, upstream))
     -+		return 1;
     -+
     -+	return 0;
     -+}
     -+
      +struct forked_cb {
     -+	const struct string_list *remote_names;
     -+	const struct string_list *tracking_refs;
     ++	const struct string_list *upstream_patterns;
      +	struct string_list *out;
      +};
      +
      +static int collect_forked_branch(const struct reference *ref, void *cb_data)
      +{
      +	struct forked_cb *cb = cb_data;
     ++	struct branch *branch;
     ++	const char *upstream, *short_upstream;
     ++	const struct string_list_item *item;
      +
      +	if (ref->flags & REF_ISSYMREF)
      +		return 0;
     -+	if (branch_is_forked(ref->name, cb->remote_names, cb->tracking_refs))
     -+		string_list_append(cb->out, ref->name);
     ++	branch = branch_get(ref->name);
     ++	if (!branch)
     ++		return 0;
     ++	upstream = branch_get_upstream(branch, NULL);
     ++	if (!upstream)
     ++		return 0;
     ++	short_upstream = upstream;
     ++	(void)(skip_prefix(short_upstream, "refs/heads/", &short_upstream) ||
     ++	       skip_prefix(short_upstream, "refs/remotes/", &short_upstream));
     ++
     ++	for_each_string_list_item(item, cb->upstream_patterns)
     ++		if (!wildmatch(item->string, short_upstream, WM_PATHNAME)) {
     ++			string_list_append(cb->out, ref->name)->util =
     ++				xstrdup(upstream);
     ++			return 0;
     ++		}
      +	return 0;
      +}
      +
     -+static int list_forked_branches(int argc, const char **argv)
     ++static void collect_forked_set(int argc, const char **argv,
     ++			       struct string_list *out)
      +{
     -+	struct string_list remote_names = STRING_LIST_INIT_NODUP;
     -+	struct string_list tracking_refs = STRING_LIST_INIT_DUP;
     -+	struct string_list out = STRING_LIST_INIT_DUP;
     -+	struct string_list_item *item;
     ++	struct string_list upstream_patterns = STRING_LIST_INIT_DUP;
      +	struct forked_cb cb = {
     -+		.remote_names = &remote_names,
     -+		.tracking_refs = &tracking_refs,
     -+		.out = &out,
     ++		.upstream_patterns = &upstream_patterns,
     ++		.out = out,
      +	};
      +
     -+	if (!argc)
     -+		die(_("--forked requires at least one <remote>"));
     -+
     -+	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
     ++	parse_forked_args(argc, argv, &upstream_patterns);
      +
      +	refs_for_each_branch_ref(get_main_ref_store(the_repository),
      +				 collect_forked_branch, &cb);
      +
     -+	string_list_sort(&out);
     ++	string_list_clear(&upstream_patterns, 0);
     ++}
     ++
     ++static int list_forked_branches(int argc, const char **argv)
     ++{
     ++	struct string_list out = STRING_LIST_INIT_DUP;
     ++	struct string_list_item *item;
     ++
     ++	if (!argc)
     ++		die(_("--forked requires at least one <branch>"));
     ++
     ++	collect_forked_set(argc, argv, &out);
      +	for_each_string_list_item(item, &out)
      +		puts(item->string);
      +
     -+	string_list_clear(&remote_names, 0);
     -+	string_list_clear(&tracking_refs, 0);
     -+	string_list_clear(&out, 0);
     ++	string_list_clear(&out, 1);
      +	return 0;
      +}
      +
     @@ builtin/branch.c: int cmd_branch(int argc,
       		OPT_BOOL(0, "edit-description", &edit_description,
       			 N_("edit the description for the branch")),
      +		OPT_BOOL(0, "forked", &forked,
     -+			N_("list local branches forked from the given <remote>s")),
     ++			N_("list local branches whose upstream matches the given <branch>...")),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
       		OPT_MERGED(&filter, N_("print only branches that are merged")),
       		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
     @@ builtin/branch.c: int cmd_branch(int argc,
       		usage_with_options(builtin_branch_usage, options);
       
      @@ builtin/branch.c: int cmd_branch(int argc,
     + 	if (delete) {
     + 		if (!argc)
       			die(_("branch name required"));
     - 		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
     - 		goto out;
     +-		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
     ++		ret = delete_branches(argc, argv, delete > 1, filter.kind,
     ++				      quiet, 0, NULL);
     ++		goto out;
      +	} else if (forked) {
      +		ret = list_forked_branches(argc, argv);
     -+		goto out;
     + 		goto out;
       	} else if (show_current) {
       		print_current_branch_name();
     - 		ret = 0;
      
       ## t/t3200-branch.sh ##
      @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +	git -C forked branch --track local-one origin/one &&
      +	git -C forked branch --track local-two origin/two &&
      +	git -C forked branch --track local-foreign other/foreign &&
     -+	git -C forked branch detached
     ++	git -C forked branch detached &&
     ++	git -C forked branch --track topic-on-main main
     ++'
     ++
     ++test_expect_success '--forked <remote-tracking-branch> lists matching branches' '
     ++	git -C forked branch --forked origin/one >actual &&
     ++	echo local-one >expect &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success '--forked <local-branch> lists branches tracking that local branch' '
     ++	git -C forked branch --forked main >actual &&
     ++	echo topic-on-main >expect &&
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success '--forked <remote-name> lists branches tracking that remote' '
     -+	git -C forked branch --forked origin >actual &&
     ++test_expect_success '--forked <glob> matches every upstream under the pattern' '
     ++	git -C forked branch --forked "origin/*" >actual &&
      +	cat >expect <<-\EOF &&
      +	local-one
      +	local-two
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success '--forked <remote-tracking-branch> lists only matching branches' '
     -+	git -C forked branch --forked origin/one >actual &&
     -+	echo local-one >expect &&
     ++test_expect_success '--forked unions multiple <branch> arguments' '
     ++	git -C forked branch --forked origin/one other/foreign >actual &&
     ++	cat >expect <<-\EOF &&
     ++	local-foreign
     ++	local-one
     ++	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success '--forked unions multiple <remote> arguments' '
     -+	git -C forked branch --forked origin/one other >actual &&
     ++test_expect_success '--forked combines literal and glob arguments' '
     ++	git -C forked branch --forked main "other/*" >actual &&
     ++	cat >expect <<-\EOF &&
     ++	local-foreign
     ++	topic-on-main
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success '--forked "*/*" covers every remote-tracking upstream' '
     ++	git -C forked branch --forked "*/*" >actual &&
      +	cat >expect <<-\EOF &&
      +	local-foreign
      +	local-one
     ++	local-two
     ++	main
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success '--forked rejects unknown remote/ref' '
     ++test_expect_success '--forked rejects unknown branch/pattern' '
      +	test_must_fail git -C forked branch --forked nope 2>err &&
     -+	test_grep "neither a configured remote nor a remote-tracking branch" err
     ++	test_grep "not a valid branch or pattern" err
      +'
      +
     -+test_expect_success '--forked requires at least one <remote>' '
     ++test_expect_success '--forked requires at least one <branch>' '
      +	test_must_fail git -C forked branch --forked 2>err &&
     -+	test_grep "at least one <remote>" err
     ++	test_grep "at least one <branch>" err
      +'
      +
       test_done
 2:  2a13e5d4bc < -:  ---------- branch: let delete_branches warn instead of error on bulk refusal
 3:  f87e96e99d ! 2:  718e28c7e0 branch: add --prune-merged <remote>
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: add --prune-merged <remote>
     +    branch: add --prune-merged <branch>
      
     -    Delete the local branches that --forked <remote> would list, but
     -    only those whose tip is reachable from their configured upstream
     -    remote-tracking branch (branch.<name>.merge): the work has already
     -    landed on the upstream it tracks, so the local copy is no longer
     -    needed.
     +            git branch --prune-merged <branch>...
      
     -    A branch whose upstream no longer resolves locally is left alone --
     -    its disappearance is not, on its own, evidence that the work was
     -    integrated. With --force, skip the reachability check and delete
     -    every branch in the candidate set. The currently checked-out
     -    branch in any worktree is always preserved, as is the local branch
     -    that mirrors <remote>'s default branch.
     +    deletes the local branches that --forked <branch> would list,
     +    but only those whose tip is reachable from their configured
     +    upstream: the work has already landed on the upstream the
     +    branch tracks, so the local copy is no longer needed.
      
     -    Reachability is read from whatever the remote-tracking refs say
     -    locally, so the natural workflow is
     +    The following branches are always preserved:
     +
     +    * the currently checked-out branch in any worktree;
     +    * any local branch whose name matches the default branch of
     +      any configured remote (the target of
     +      refs/remotes/<remote>/HEAD) -- typically 'main' or
     +      'master';
     +    * any branch whose upstream no longer resolves locally.
     +
     +    Reachability is read from whatever branch.<name>.merge
     +    resolves to locally, which is usually a remote-tracking ref
     +    but may also be a local branch. When the upstream is a
     +    remote-tracking ref, the natural workflow is
      
                  git fetch <remote>
     -            git branch --prune-merged <remote>
     +            git branch --prune-merged <upstream-pattern>
      
     -    with no implicit cleanup driven by fetch itself.
     +    so the upstream reflects the current state before pruning.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc
      @@ Documentation/git-branch.adoc: git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
     - git branch --forked <remote>...
     -+git branch --prune-merged <remote>...
     + git branch --forked <branch>...
     ++git branch --prune-merged <branch>...
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-branch.adoc: Each _<remote>_ may be either the name of a configured remote
     - `refs/remotes/origin/*` ref) or a specific remote-tracking branch
     - (e.g. `origin/master`). Multiple _<remote>_ arguments are unioned.
     +@@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mode.
     + 	a ref (e.g. `origin/master`, `master`) or a shell-style
     + 	glob (e.g. `'origin/*'`). Multiple arguments are unioned.
       
      +`--prune-merged`::
      +	Delete the local branches that `--forked` would list for
     -+	the same _<remote>_ arguments, but only those whose tip is
     -+	reachable from their configured upstream remote-tracking
     -+	branch (`branch.<name>.merge`). In other words: the work on
     -+	the branch has already landed on the upstream it tracks, so
     -+	the local copy is no longer needed.
     ++	the same _<branch>_ arguments, but only those whose tip is
     ++	reachable from their configured upstream.
     +++
     ++For arguments that refer to remote-tracking branches, run
     ++`git fetch` first so reachability is checked against the
     ++current upstream state; refs are read locally.
      ++
     -+Run `git fetch` first so the upstream remote-tracking branches
     -+reflect the current state of _<remote>_; reachability is checked
     -+against whatever the remote-tracking refs say locally.
     ++The following branches are always preserved:
      ++
     -+A branch whose upstream no longer resolves locally is left alone
     -+(its disappearance is not, on its own, evidence that the work was
     -+integrated). The currently checked-out branch in any worktree is
     -+always preserved, as is the local branch that mirrors _<remote>_'s
     -+default branch.
     ++--
     ++* the currently checked-out branch in any worktree;
     ++* any local branch whose name matches the default branch of
     ++  any configured remote (the target of
     ++  `refs/remotes/<remote>/HEAD`) -- typically `main` or
     ++  `master`;
     ++* any branch whose upstream no longer resolves locally.
     ++--
      +
       `-v`::
       `-vv`::
     @@ builtin/branch.c
       #include "column.h"
       #include "utf8.h"
       #include "ref-filter.h"
     +@@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
     + 	N_("git branch [<options>] [-r | -a] [--points-at]"),
     + 	N_("git branch [<options>] [-r | -a] [--format]"),
     + 	N_("git branch [<options>] --forked <branch>..."),
     ++	N_("git branch [<options>] --prune-merged <branch>..."),
     + 	NULL
     + };
     + 
      @@ builtin/branch.c: static int branch_merged(int kind, const char *name,
       	 * any of the following code, but during the transition period,
       	 * a gentle reminder is in order.
     @@ builtin/branch.c: static int branch_merged(int kind, const char *name,
       		if (expect < 0)
       			exit(128);
       		if (expect == merged)
     -@@ builtin/branch.c: static void delete_branch_config(const char *branchname)
     - 	strbuf_release(&buf);
     - }
     - 
     --static int delete_branches(int argc, const char **argv, int force, int kinds,
     -+static int delete_branches(int argc, const char **argv,
     -+			   int no_head_fallback,
     -+			   int force, int kinds,
     - 			   int quiet, int warn_only, int *n_not_merged)
     - {
     - 	struct commit *head_rev = NULL;
     -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     - 	}
     - 	branch_name_pos = strcspn(fmt, "%");
     - 
     --	if (!force)
     -+	if (!force && !no_head_fallback)
     - 		head_rev = lookup_commit_reference(the_repository, &head_oid);
     - 
     - 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
     -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     - 		}
     - 
     - 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
     --		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
     --					force, warn_only, n_not_merged)) {
     -+		    check_branch_commit(bname.buf, name, &oid, head_rev,
     -+					kinds, force, warn_only, n_not_merged)) {
     - 			if (!warn_only)
     - 				ret = 1;
     - 			goto next;
      @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref, void *cb_data)
       	return 0;
       }
       
     --static int list_forked_branches(int argc, const char **argv)
     -+static void collect_default_branch_refs(const struct string_list *remote_names,
     -+					struct string_list *out)
     ++static int collect_default_branch_name(struct remote *remote, void *cb_data)
      +{
     ++	struct string_list *protected = cb_data;
      +	struct ref_store *refs = get_main_ref_store(the_repository);
     -+	struct string_list_item *item;
     -+
     -+	for_each_string_list_item(item, remote_names) {
     -+		struct strbuf head = STRBUF_INIT;
     -+		const char *target;
     -+
     -+		strbuf_addf(&head, "refs/remotes/%s/HEAD", item->string);
     -+		target = refs_resolve_ref_unsafe(refs, head.buf,
     -+						 RESOLVE_REF_NO_RECURSE,
     -+						 NULL, NULL);
     -+		if (target && starts_with(target, "refs/remotes/"))
     -+			string_list_insert(out, target);
     -+		strbuf_release(&head);
     ++	struct strbuf head = STRBUF_INIT;
     ++	const char *target;
     ++
     ++	strbuf_addf(&head, "refs/remotes/%s/HEAD", remote->name);
     ++	target = refs_resolve_ref_unsafe(refs, head.buf,
     ++					 RESOLVE_REF_NO_RECURSE, NULL, NULL);
     ++	if (target) {
     ++		const char *leaf = strrchr(target, '/');
     ++		if (leaf)
     ++			string_list_insert(protected, leaf + 1);
      +	}
     ++	strbuf_release(&head);
     ++	return 0;
      +}
      +
     -+static void collect_forked_set(int argc, const char **argv,
     -+			       struct string_list *protected_default_refs,
     -+			       struct string_list *out)
     + static void collect_forked_set(int argc, const char **argv,
     + 			       struct string_list *out)
       {
     - 	struct string_list remote_names = STRING_LIST_INIT_NODUP;
     - 	struct string_list tracking_refs = STRING_LIST_INIT_DUP;
     --	struct string_list out = STRING_LIST_INIT_DUP;
     --	struct string_list_item *item;
     - 	struct forked_cb cb = {
     - 		.remote_names = &remote_names,
     - 		.tracking_refs = &tracking_refs,
     --		.out = &out,
     -+		.out = out,
     - 	};
     - 
     --	if (!argc)
     --		die(_("--forked requires at least one <remote>"));
     --
     - 	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
     - 
     - 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
     - 				 collect_forked_branch, &cb);
     - 
     --	string_list_sort(&out);
     --	for_each_string_list_item(item, &out)
     --		puts(item->string);
     -+	string_list_sort(out);
     -+
     -+	if (protected_default_refs)
     -+		collect_default_branch_refs(&remote_names, protected_default_refs);
     - 
     - 	string_list_clear(&remote_names, 0);
     - 	string_list_clear(&tracking_refs, 0);
     -+}
     -+
     -+static int list_forked_branches(int argc, const char **argv)
     -+{
     -+	struct string_list out = STRING_LIST_INIT_DUP;
     -+	struct string_list_item *item;
     -+
     -+	if (!argc)
     -+		die(_("--forked requires at least one <remote>"));
     -+
     -+	collect_forked_set(argc, argv, NULL, &out);
     -+	for_each_string_list_item(item, &out)
     -+		puts(item->string);
     -+
     - 	string_list_clear(&out, 0);
     +@@ builtin/branch.c: static int list_forked_branches(int argc, const char **argv)
       	return 0;
       }
       
      +static int prune_merged_branches(int argc, const char **argv, int quiet)
      +{
     ++	struct ref_store *refs = get_main_ref_store(the_repository);
      +	struct string_list candidates = STRING_LIST_INIT_DUP;
     -+	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
     ++	struct string_list protected_default_names = STRING_LIST_INIT_DUP;
      +	struct strvec deletable = STRVEC_INIT;
     ++	struct strbuf buf = STRBUF_INIT;
      +	struct string_list_item *item;
      +	int n_not_merged = 0;
      +	int ret = 0;
      +
      +	if (!argc)
     -+		die(_("--prune-merged requires at least one <remote>"));
     ++		die(_("--prune-merged requires at least one <branch>"));
      +
     -+	collect_forked_set(argc, argv, &protected_default_refs, &candidates);
     ++	collect_forked_set(argc, argv, &candidates);
     ++	for_each_remote(collect_default_branch_name, &protected_default_names);
      +
      +	for_each_string_list_item(item, &candidates) {
      +		const char *short_name = item->string;
     -+		struct strbuf full = STRBUF_INIT;
     -+		struct branch *branch;
     -+		const char *upstream;
     ++		const char *upstream = item->util;
      +
     -+		strbuf_addf(&full, "refs/heads/%s", short_name);
     -+		if (branch_checked_out(full.buf)) {
     -+			strbuf_release(&full);
     ++		strbuf_reset(&buf);
     ++		strbuf_addf(&buf, "refs/heads/%s", short_name);
     ++		if (branch_checked_out(buf.buf))
      +			continue;
     -+		}
     -+		strbuf_release(&full);
     -+
     -+		branch = branch_get(short_name);
     -+		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
     -+		if (!upstream ||
     -+		    !refs_ref_exists(get_main_ref_store(the_repository),
     -+				     upstream))
     ++
     ++		if (string_list_has_string(&protected_default_names,
     ++					   short_name))
     ++			continue;
     ++
     ++		if (!refs_ref_exists(refs, upstream))
      +			continue;
     -+		if (string_list_has_string(&protected_default_refs, upstream)) {
     -+			const char *leaf = strrchr(upstream, '/');
     -+			if (leaf && !strcmp(leaf + 1, short_name))
     -+				continue;
     -+		}
      +
      +		strvec_push(&deletable, short_name);
      +	}
     ++	strbuf_release(&buf);
      +
      +	if (deletable.nr)
      +		ret = delete_branches(deletable.nr, deletable.v,
     -+				      1, 0,
     -+				      FILTER_REFS_BRANCHES, quiet,
     ++				      0, FILTER_REFS_BRANCHES, quiet,
      +				      1, &n_not_merged);
      +
      +	if (n_not_merged && !quiet)
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +			n_not_merged);
      +
      +	strvec_clear(&deletable);
     -+	string_list_clear(&candidates, 0);
     -+	string_list_clear(&protected_default_refs, 0);
     ++	string_list_clear(&candidates, 1);
     ++	string_list_clear(&protected_default_names, 0);
      +	return ret;
      +}
      +
     @@ builtin/branch.c: int cmd_branch(int argc,
      @@ builtin/branch.c: int cmd_branch(int argc,
       			 N_("edit the description for the branch")),
       		OPT_BOOL(0, "forked", &forked,
     - 			N_("list local branches forked from the given <remote>s")),
     + 			N_("list local branches whose upstream matches the given <branch>...")),
      +		OPT_BOOL(0, "prune-merged", &prune_merged,
     -+			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
     ++			N_("delete local branches whose upstream matches the given <branch>... and that are merged into it")),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
       		OPT_MERGED(&filter, N_("print only branches that are merged")),
       		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
     @@ builtin/branch.c: int cmd_branch(int argc,
       		usage_with_options(builtin_branch_usage, options);
       
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 	if (delete) {
     - 		if (!argc)
     - 			die(_("branch name required"));
     --		ret = delete_branches(argc, argv, delete > 1, filter.kind,
     -+		ret = delete_branches(argc, argv, 0, delete > 1, filter.kind,
     - 				      quiet, 0, NULL);
     - 		goto out;
       	} else if (forked) {
       		ret = list_forked_branches(argc, argv);
       		goto out;
     @@ builtin/branch.c: int cmd_branch(int argc,
       		ret = 0;
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>' '
     - 	test_grep "at least one <remote>" err
     +@@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <branch>' '
     + 	test_grep "at least one <branch>" err
       '
       
      +test_expect_success '--prune-merged: setup' '
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>'
      +	git -C pm-merged branch two two-commit &&
      +	git -C pm-merged branch --set-upstream-to=origin/next two &&
      +
     -+	git -C pm-merged branch --prune-merged origin &&
     ++	git -C pm-merged branch --prune-merged "origin/*" &&
      +
      +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/one &&
      +	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two
      +'
      +
     ++test_expect_success '--prune-merged with a literal upstream argument' '
     ++	test_when_finished "rm -rf pm-literal" &&
     ++	git clone pm-upstream pm-literal &&
     ++	git -C pm-literal branch one one-commit &&
     ++	git -C pm-literal branch --set-upstream-to=origin/next one &&
     ++	git -C pm-literal branch keepme one-commit &&
     ++	git -C pm-literal branch --set-upstream-to=origin/main keepme &&
     ++
     ++	git -C pm-literal branch --prune-merged origin/next &&
     ++
     ++	test_must_fail git -C pm-literal rev-parse --verify refs/heads/one &&
     ++	git -C pm-literal rev-parse --verify refs/heads/keepme
     ++'
     ++
     ++test_expect_success '--prune-merged unions multiple <branch> arguments' '
     ++	test_when_finished "rm -rf pm-union" &&
     ++	git clone pm-upstream pm-union &&
     ++	git -C pm-union branch one one-commit &&
     ++	git -C pm-union branch --set-upstream-to=origin/next one &&
     ++	git -C pm-union branch two base &&
     ++	git -C pm-union branch --set-upstream-to=origin/main two &&
     ++
     ++	git -C pm-union branch --prune-merged origin/next origin/main &&
     ++
     ++	test_must_fail git -C pm-union rev-parse --verify refs/heads/one &&
     ++	test_must_fail git -C pm-union rev-parse --verify refs/heads/two
     ++'
     ++
     ++test_expect_success '--prune-merged with a local-branch argument' '
     ++	test_create_repo pm-local &&
     ++	test_when_finished "rm -rf pm-local" &&
     ++	test_commit -C pm-local base &&
     ++	git -C pm-local branch topic base &&
     ++	git -C pm-local config branch.topic.remote . &&
     ++	git -C pm-local config branch.topic.merge refs/heads/main &&
     ++	git -C pm-local checkout --detach &&
     ++
     ++	git -C pm-local branch --prune-merged main &&
     ++
     ++	test_must_fail git -C pm-local rev-parse --verify refs/heads/topic &&
     ++	git -C pm-local rev-parse --verify refs/heads/main
     ++'
     ++
      +test_expect_success '--prune-merged spares branches with un-integrated commits' '
      +	test_when_finished "rm -rf pm-unmerged" &&
      +	git clone pm-upstream pm-unmerged &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>'
      +	test_commit -C pm-unmerged local-only &&
      +	git -C pm-unmerged checkout - &&
      +
     -+	git -C pm-unmerged branch --prune-merged origin 2>err &&
     ++	git -C pm-unmerged branch --prune-merged "origin/*" 2>err &&
      +	test_grep "not fully merged" err &&
      +	test_grep "Skipped 1 branch" err &&
      +	test_grep "git branch -D" err &&
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>'
      +	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
      +
      +	git -C pm-upstream-gone update-ref -d refs/remotes/origin/next &&
     -+	git -C pm-upstream-gone branch --prune-merged origin &&
     ++	git -C pm-upstream-gone branch --prune-merged "origin/*" &&
      +
      +	git -C pm-upstream-gone rev-parse --verify refs/heads/one
      +'
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>'
      +	git -C pm-head checkout -b one one-commit &&
      +	git -C pm-head branch --set-upstream-to=origin/next one &&
      +
     -+	git -C pm-head branch --prune-merged origin &&
     ++	git -C pm-head branch --prune-merged "origin/*" &&
      +
      +	git -C pm-head rev-parse --verify refs/heads/one
      +'
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>'
      +	test_when_finished "rm -rf pm-default" &&
      +	git clone pm-upstream pm-default &&
      +	git -C pm-default checkout --detach &&
     -+	git -C pm-default branch --prune-merged origin &&
     ++	git -C pm-default branch --prune-merged "origin/*" &&
      +	git -C pm-default rev-parse --verify refs/heads/main
      +'
      +
     -+test_expect_success '--prune-merged protects only the default branch by name, not by upstream' '
     ++test_expect_success '--prune-merged protects the default branch by name only' '
      +	test_when_finished "rm -rf pm-default-alias" &&
      +	git clone pm-upstream pm-default-alias &&
      +	git -C pm-default-alias branch --track trunk origin/main &&
      +	git -C pm-default-alias checkout --detach &&
     -+	git -C pm-default-alias branch --prune-merged origin &&
     ++	git -C pm-default-alias branch --prune-merged "origin/*" &&
      +	git -C pm-default-alias rev-parse --verify refs/heads/main &&
      +	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
      +'
     ++
     ++test_expect_success '--prune-merged with literal arg also protects default-name' '
     ++	test_when_finished "rm -rf pm-literal-default" &&
     ++	git clone pm-upstream pm-literal-default &&
     ++	git -C pm-literal-default checkout --detach &&
     ++	git -C pm-literal-default branch --prune-merged origin/main &&
     ++	git -C pm-literal-default rev-parse --verify refs/heads/main
     ++'
     ++
     ++test_expect_success '--prune-merged requires at least one <branch>' '
     ++	test_must_fail git -C pm-upstream branch --prune-merged 2>err &&
     ++	test_grep "at least one <branch>" err
     ++'
      +
       test_done
 4:  19b6d94fa7 ! 3:  6e38d7af3a branch: add branch.<name>.pruneMerged opt-out
     @@ Metadata
       ## Commit message ##
          branch: add branch.<name>.pruneMerged opt-out
      
     -    Setting branch.<name>.pruneMerged=false exempts that branch from
     -    --prune-merged, even with --force. Useful for keeping a topic
     -    branch around between rounds.
     +    Setting branch.<name>.pruneMerged=false exempts that branch
     +    from --prune-merged. Useful for topic branches you intend to
     +    develop further after an initial round has been merged
     +    upstream.
      
          Explicit deletion via 'git branch -d' is unaffected.
      
     @@ Documentation/config/branch.adoc: for details).
      +
      +`branch.<name>.pruneMerged`::
      +	If set to `false`, branch _<name>_ is exempt from
     -+	`git branch --prune-merged`.
     -+	Useful for topic branches you intend to develop further after
     -+	an initial round has been merged upstream. Defaults to true.
     -+	Explicit deletion via `git branch -d` is unaffected.
     ++	`git branch --prune-merged`. Defaults to true. Explicit
     ++	deletion via `git branch -d` is unaffected.
      
       ## Documentation/git-branch.adoc ##
     -@@ Documentation/git-branch.adoc: against whatever the remote-tracking refs say locally.
     - A branch whose upstream no longer resolves locally is left alone
     - (its disappearance is not, on its own, evidence that the work was
     - integrated). The currently checked-out branch in any worktree is
     --always preserved, as is the local branch that mirrors _<remote>_'s
     -+always preserved, as is any branch with `branch.<name>.pruneMerged`
     -+set to `false`, and the local branch that mirrors _<remote>_'s
     - default branch.
     +@@ Documentation/git-branch.adoc: The following branches are always preserved:
     +   any configured remote (the target of
     +   `refs/remotes/<remote>/HEAD`) -- typically `main` or
     +   `master`;
     ++* any branch with `branch.<name>.pruneMerged` set to `false`;
     + * any branch whose upstream no longer resolves locally.
     + --
       
     - `-v`::
      
       ## builtin/branch.c ##
      @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int quiet)
       	for_each_string_list_item(item, &candidates) {
       		const char *short_name = item->string;
     - 		struct strbuf full = STRBUF_INIT;
     -+		struct strbuf key = STRBUF_INIT;
     - 		struct branch *branch;
     - 		const char *upstream;
     -+		int opt_out = 0;
     + 		const char *upstream = item->util;
     ++		int prune_allowed = 1;
       
     - 		strbuf_addf(&full, "refs/heads/%s", short_name);
     - 		if (branch_checked_out(full.buf)) {
     - 			strbuf_release(&full);
     -+			strbuf_release(&key);
     - 			continue;
     - 		}
     - 		strbuf_release(&full);
     + 		strbuf_reset(&buf);
     + 		strbuf_addf(&buf, "refs/heads/%s", short_name);
      @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int quiet)
     - 		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
     - 		if (!upstream ||
     - 		    !refs_ref_exists(get_main_ref_store(the_repository),
     --				     upstream))
     -+				     upstream)) {
     -+			strbuf_release(&key);
     + 		if (!refs_ref_exists(refs, upstream))
       			continue;
     -+		}
     - 		if (string_list_has_string(&protected_default_refs, upstream)) {
     - 			const char *leaf = strrchr(upstream, '/');
     --			if (leaf && !strcmp(leaf + 1, short_name))
     -+			if (leaf && !strcmp(leaf + 1, short_name)) {
     -+				strbuf_release(&key);
     - 				continue;
     -+			}
     -+		}
     -+
     -+		strbuf_addf(&key, "branch.%s.prunemerged", short_name);
     -+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
     -+		    !opt_out) {
     + 
     ++		strbuf_reset(&buf);
     ++		strbuf_addf(&buf, "branch.%s.prunemerged", short_name);
     ++		if (!repo_config_get_bool(the_repository, buf.buf,
     ++					  &prune_allowed) &&
     ++		    !prune_allowed) {
      +			if (!quiet)
      +				fprintf(stderr, _("Skipping '%s' "
      +						  "(branch.%s.pruneMerged is false)\n"),
      +					short_name, short_name);
     -+			strbuf_release(&key);
      +			continue;
     - 		}
     -+		strbuf_release(&key);
     - 
     ++		}
     ++
       		strvec_push(&deletable, short_name);
       	}
     + 	strbuf_release(&buf);
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--prune-merged protects only the default branch by name, no
     - 	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
     +@@ t/t3200-branch.sh: test_expect_success '--prune-merged requires at least one <branch>' '
     + 	test_grep "at least one <branch>" err
       '
       
      +test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
     @@ t/t3200-branch.sh: test_expect_success '--prune-merged protects only the default
      +	git -C pm-optout branch --set-upstream-to=origin/next two &&
      +	git -C pm-optout config branch.one.pruneMerged false &&
      +
     -+	git -C pm-optout branch --prune-merged origin 2>err &&
     ++	git -C pm-optout branch --prune-merged "origin/*" 2>err &&
      +
      +	git -C pm-optout rev-parse --verify refs/heads/one &&
      +	test_must_fail git -C pm-optout rev-parse --verify refs/heads/two &&
 5:  6ae95d3f98 ! 4:  c68d162e22 branch: add --all-remotes flag
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: add --all-remotes flag
     +    branch: add --dry-run for --prune-merged
      
     -    Combined with --forked or --prune-merged, --all-remotes acts on
     -    every configured remote, in addition to any explicit <remote>
     -    arguments. Used alone, it errors out.
     +    With --dry-run, --prune-merged prints the branches it would
     +    delete and exits without touching any ref. Useful for
     +    sanity-checking a glob like 'origin/*' before letting it run.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/git-branch.adoc ##
     -@@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
     - git branch (-c|-C) [<old-branch>] <new-branch>
     +@@ Documentation/git-branch.adoc: git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
     --git branch --forked <remote>...
     --git branch --prune-merged <remote>...
     -+git branch --forked (<remote>... | --all-remotes)
     -+git branch --prune-merged (<remote>... | --all-remotes)
     + git branch --forked <branch>...
     +-git branch --prune-merged <branch>...
     ++git branch --prune-merged [--dry-run] <branch>...
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-branch.adoc: always preserved, as is any branch with `branch.<name>.pruneMerged`
     - set to `false`, and the local branch that mirrors _<remote>_'s
     - default branch.
     +@@ Documentation/git-branch.adoc: The following branches are always preserved:
     + * any branch whose upstream no longer resolves locally.
     + --
       
     -+`--all-remotes`::
     -+	With `--forked` or `--prune-merged`, act on every
     -+	configured remote in addition to any explicit _<remote>_
     -+	arguments.
     ++`--dry-run`::
     ++	With `--prune-merged`, print the branches that would be
     ++	deleted instead of deleting them.
      +
       `-v`::
       `-vv`::
       `--verbose`::
      
       ## builtin/branch.c ##
     -@@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const char *newname, int
     - 	free_worktrees(worktrees);
     +@@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
     + 	N_("git branch [<options>] [-r | -a] [--points-at]"),
     + 	N_("git branch [<options>] [-r | -a] [--format]"),
     + 	N_("git branch [<options>] --forked <branch>..."),
     +-	N_("git branch [<options>] --prune-merged <branch>..."),
     ++	N_("git branch [<options>] --prune-merged [--dry-run] <branch>..."),
     + 	NULL
     + };
     + 
     +@@ builtin/branch.c: static void delete_branch_config(const char *branchname)
       }
       
     -+static int collect_remote_name(struct remote *remote, void *cb_data)
     -+{
     -+	struct string_list *remote_names = cb_data;
     -+	string_list_insert(remote_names, remote->name);
     -+	return 0;
     -+}
     -+
     - static void parse_forked_args(int argc, const char **argv,
     - 			      struct string_list *remote_names,
     - 			      struct string_list *tracking_refs)
     -@@ builtin/branch.c: static void collect_default_branch_refs(const struct string_list *remote_names,
     - 	}
     - }
     - 
     --static void collect_forked_set(int argc, const char **argv,
     -+static void collect_forked_set(int argc, const char **argv, int all_remotes,
     - 			       struct string_list *protected_default_refs,
     - 			       struct string_list *out)
     - {
     -@@ builtin/branch.c: static void collect_forked_set(int argc, const char **argv,
     - 	};
     - 
     - 	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
     -+	if (all_remotes)
     -+		for_each_remote(collect_remote_name, &remote_names);
     - 
     - 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
     - 				 collect_forked_branch, &cb);
     -@@ builtin/branch.c: static void collect_forked_set(int argc, const char **argv,
     - 	string_list_clear(&tracking_refs, 0);
     - }
     - 
     --static int list_forked_branches(int argc, const char **argv)
     -+static int list_forked_branches(int argc, const char **argv, int all_remotes)
     + static int delete_branches(int argc, const char **argv, int force, int kinds,
     +-			   int quiet, int warn_only, int *n_not_merged)
     ++			   int quiet, int warn_only, int dry_run,
     ++			   int *n_not_merged)
       {
     - 	struct string_list out = STRING_LIST_INIT_DUP;
     - 	struct string_list_item *item;
     - 
     --	if (!argc)
     --		die(_("--forked requires at least one <remote>"));
     -+	if (!argc && !all_remotes)
     -+		die(_("--forked requires at least one <remote> or --all-remotes"));
     - 
     --	collect_forked_set(argc, argv, NULL, &out);
     -+	collect_forked_set(argc, argv, all_remotes, NULL, &out);
     - 	for_each_string_list_item(item, &out)
     - 		puts(item->string);
     - 
     + 	struct commit *head_rev = NULL;
     + 	struct object_id oid;
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     + 			goto next;
     + 		}
     + 
     ++		if (dry_run) {
     ++			printf(_("Would delete branch '%s'\n"),
     ++			       name + branch_name_pos);
     ++			goto next;
     ++		}
     ++
     + 		item = string_list_append(&refs_to_delete, name);
     + 		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
     + 				    : (flags & REF_ISSYMREF) ? target
      @@ builtin/branch.c: static int list_forked_branches(int argc, const char **argv)
       	return 0;
       }
       
      -static int prune_merged_branches(int argc, const char **argv, int quiet)
      +static int prune_merged_branches(int argc, const char **argv,
     -+				 int all_remotes, int quiet)
     ++				 int dry_run, int quiet)
       {
     + 	struct ref_store *refs = get_main_ref_store(the_repository);
       	struct string_list candidates = STRING_LIST_INIT_DUP;
     - 	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
      @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int quiet)
     - 	int n_not_merged = 0;
     - 	int ret = 0;
     - 
     --	if (!argc)
     --		die(_("--prune-merged requires at least one <remote>"));
     -+	if (!argc && !all_remotes)
     -+		die(_("--prune-merged requires at least one <remote> or --all-remotes"));
     - 
     --	collect_forked_set(argc, argv, &protected_default_refs, &candidates);
     -+	collect_forked_set(argc, argv, all_remotes, &protected_default_refs,
     -+			   &candidates);
     - 
     - 	for_each_string_list_item(item, &candidates) {
     - 		const char *short_name = item->string;
     + 	if (deletable.nr)
     + 		ret = delete_branches(deletable.nr, deletable.v,
     + 				      0, FILTER_REFS_BRANCHES, quiet,
     +-				      1, &n_not_merged);
     ++				      1, dry_run, &n_not_merged);
     + 
     + 	if (n_not_merged && !quiet)
     + 		fprintf(stderr,
      @@ builtin/branch.c: int cmd_branch(int argc,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
       	int forked = 0;
       	int prune_merged = 0;
     -+	int all_remotes = 0;
     ++	int dry_run = 0;
       	const char *new_upstream = NULL;
       	int noncreate_actions = 0;
       	/* possible options */
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 			N_("list local branches forked from the given <remote>s")),
     + 			N_("list local branches whose upstream matches the given <branch>...")),
       		OPT_BOOL(0, "prune-merged", &prune_merged,
     - 			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
     -+		OPT_BOOL_F(0, "all-remotes", &all_remotes,
     -+			N_("with --forked or --prune-merged, act on every configured remote"),
     -+			PARSE_OPT_NONEG),
     + 			N_("delete local branches whose upstream matches the given <branch>... and that are merged into it")),
     ++		OPT_BOOL(0, "dry-run", &dry_run,
     ++			N_("with --prune-merged, only print what would be deleted")),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
       		OPT_MERGED(&filter, N_("print only branches that are merged")),
       		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
     @@ builtin/branch.c: int cmd_branch(int argc,
       	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
       			     0);
       
     -+	if (all_remotes && !forked && !prune_merged)
     -+		die(_("--all-remotes requires --forked or --prune-merged"));
     -+
     ++	if (dry_run && !prune_merged)
     ++		die(_("--dry-run requires --prune-merged"));
      +
       	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
       	    !show_current && !unset_upstream && !forked && !prune_merged &&
       	    argc == 0)
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 				      quiet, 0, NULL);
     + 		if (!argc)
     + 			die(_("branch name required"));
     + 		ret = delete_branches(argc, argv, delete > 1, filter.kind,
     +-				      quiet, 0, NULL);
     ++				      quiet, 0, 0, NULL);
       		goto out;
       	} else if (forked) {
     --		ret = list_forked_branches(argc, argv);
     -+		ret = list_forked_branches(argc, argv, all_remotes);
     + 		ret = list_forked_branches(argc, argv);
       		goto out;
       	} else if (prune_merged) {
      -		ret = prune_merged_branches(argc, argv, quiet);
     -+		ret = prune_merged_branches(argc, argv, all_remotes, quiet);
     ++		ret = prune_merged_branches(argc, argv, dry_run, quiet);
       		goto out;
       	} else if (show_current) {
       		print_current_branch_name();
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <remote>' '
     - 	test_grep "at least one <remote>" err
     - '
     - 
     -+test_expect_success '--forked --all-remotes covers every configured remote' '
     -+	git -C forked branch --forked --all-remotes >actual &&
     -+	cat >expect <<-\EOF &&
     -+	local-foreign
     -+	local-one
     -+	local-two
     -+	main
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success '--forked --all-remotes still validates explicit <remote>' '
     -+	test_must_fail git -C forked branch --forked nope --all-remotes 2>err &&
     -+	test_grep "neither a configured remote nor a remote-tracking branch" err
     -+'
     -+
     -+test_expect_success '--all-remotes alone is rejected' '
     -+	test_must_fail git -C forked branch --all-remotes 2>err &&
     -+	test_grep "requires --forked or --prune-merged" err
     -+'
     -+
     - test_expect_success '--prune-merged: setup' '
     - 	test_create_repo pm-upstream &&
     - 	test_commit -C pm-upstream base &&
      @@ t/t3200-branch.sh: test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
       	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
       '
       
     -+test_expect_success '--prune-merged --all-remotes covers every configured remote' '
     -+	test_when_finished "rm -rf pm-allremotes pm-other" &&
     -+	git clone pm-upstream pm-allremotes &&
     -+	test_create_repo pm-other &&
     -+	test_commit -C pm-other other-base &&
     -+	git -C pm-other checkout -b stable &&
     -+	test_commit -C pm-other foreign-commit &&
     -+	git -C pm-other branch foreign HEAD &&
     -+	git -C pm-other checkout main &&
     ++test_expect_success '--prune-merged --dry-run prints but does not delete' '
     ++	test_when_finished "rm -rf pm-dryrun" &&
     ++	git clone pm-upstream pm-dryrun &&
     ++	git -C pm-dryrun branch one one-commit &&
     ++	git -C pm-dryrun branch --set-upstream-to=origin/next one &&
      +
     -+	git -C pm-allremotes remote add other ../pm-other &&
     -+	git -C pm-allremotes fetch other &&
     -+	git -C pm-allremotes branch one one-commit &&
     -+	git -C pm-allremotes branch --set-upstream-to=origin/next one &&
     -+	git -C pm-allremotes branch foreign other/foreign &&
     -+	git -C pm-allremotes branch --set-upstream-to=other/stable foreign &&
     ++	git -C pm-dryrun branch --prune-merged --dry-run "origin/*" >out &&
     ++	test_grep "Would delete branch .one." out &&
     ++	git -C pm-dryrun rev-parse --verify refs/heads/one
     ++'
     ++
     ++test_expect_success '--prune-merged --dry-run skips un-integrated branches' '
     ++	test_when_finished "rm -rf pm-dryrun-unmerged" &&
     ++	git clone pm-upstream pm-dryrun-unmerged &&
     ++	git -C pm-dryrun-unmerged checkout -b wip origin/next &&
     ++	git -C pm-dryrun-unmerged branch --set-upstream-to=origin/next wip &&
     ++	test_commit -C pm-dryrun-unmerged local-only &&
     ++	git -C pm-dryrun-unmerged checkout - &&
     ++	git -C pm-dryrun-unmerged branch merged one-commit &&
     ++	git -C pm-dryrun-unmerged branch --set-upstream-to=origin/next merged &&
      +
     -+	git -C pm-allremotes branch --prune-merged --all-remotes &&
     ++	git -C pm-dryrun-unmerged branch --prune-merged --dry-run "origin/*" \
     ++		>out 2>err &&
     ++	test_grep "Would delete branch .merged." out &&
     ++	test_grep ! "Would delete branch .wip." out &&
     ++	test_grep "not fully merged" err &&
     ++	git -C pm-dryrun-unmerged rev-parse --verify refs/heads/wip &&
     ++	git -C pm-dryrun-unmerged rev-parse --verify refs/heads/merged
     ++'
      +
     -+	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/one &&
     -+	test_must_fail git -C pm-allremotes rev-parse --verify refs/heads/foreign
     ++test_expect_success '--dry-run requires --prune-merged' '
     ++	test_must_fail git -C pm-upstream branch --dry-run 2>err &&
     ++	test_grep "requires --prune-merged" err
      +'
      +
       test_done

-- 
gitgitgadget
