Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C273F6C4F
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997032; cv=none; b=DmH12gRdWes/Dyzeg9uzOQmQuR8e/O7u8jCwfntjunGv6cheTypWRHUSCMizM8MGqGThYF35ntx2iCr31njgSaJPUJAzBxBMaNL851KpKeeJn3o+zH+B3hzZekZgSO24fCu0LESyIS3dSJ1fPkjgO9Zkk+DU83HXikjBoeDDIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997032; c=relaxed/simple;
	bh=r7oNYX0fMCsk0FebUkP2cMF8d6ZDpGNrfgEHOLbh0p8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VUbrfwEY5LIa5gs1rX8fyc/3Hv/6CUfCgDU33i3bCF+S+F6t3rfeDwg/BJlbg/TzF4UJnbZ+yVkoQbIxXK39xcTVwwNsRcJhyj3RqJTWRaZWleBvtBrSfad2wD8wnAf44imHZqZtrlCcH8M4cUXbuAYe7OceKc0YPvQwdJXtHcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhn31K0q; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhn31K0q"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-307631dbfedso11549689eec.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780997029; x=1781601829; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W4XlY0bLyW/x6v7yla44HLhqJ7a517HSevs4Rgn13bE=;
        b=qhn31K0qHdIqPzrZZmrudYr4gyEKiC+U0pDyR0zwAKhSORnRudP3WqzQGqCRESHjOr
         PLOtNmabCDQfrGr+24vgK9N5SO/yfQXpFPB5wa1dALjtEYVBggM2uDvcZ9qIfjp7SCj1
         +LlsW2GNpr6wwDzz9zEDrPw2OwLSDKqYxSKzd9w2NpEgwdebItG2j6kfcOFHdFIbUsb1
         bqyRRIipoXjo+VzNsM8tO5+gWTBgIZfohJEaU51xO056LOYdBLxu92ovrUVWD1Z9Zl7y
         ksUKt+FT72pAX1BKVw/aV+vs0GMyRh4eyg3NYe9LHDNNutlSiThKoNP9i7mkin5IZAFM
         vyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997029; x=1781601829;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4XlY0bLyW/x6v7yla44HLhqJ7a517HSevs4Rgn13bE=;
        b=bJprrQLiZbSeLMPQQ8tdu9W7JK8quA3LU7obXrvArMoSviHB/gdO1HzrBcLA5dnZQt
         bKAYahYrsWkgm7NqM0oFSQNOhy+U6TmEsalGZpRMw03Zzob+CLfmZbRZckpJ81SWxHzV
         Ju2JbpvMuuVv5xOUf5SwYsFoL1Vfq3nTBlVEopc3/b4upN3knJGYNlHgArEFp07/3vaI
         qTAafZ88NlJ3dcLgkDL9bBqeSWW+T5X5JhUhkHPyDLf1ibwFXvGbV3RYR2sfJzXzzKFX
         Fb+DsMtLVcJN5tseuwvwypE51W8q8o6b4GDHLD1gT0igKHkeEAmU+BjFnmRjlrh9oaKd
         m1AQ==
X-Gm-Message-State: AOJu0Yyvy/FNiNdnArGo/RrG91+PeCwZHBC6AkbYujx9PAxKpqpB+ncY
	6dkMJXVP/soJ9diEHun4Z9/ONZdWu53zcXwQd5kT2JXGyBUgfRgWeDHpQTDbjHug
X-Gm-Gg: Acq92OEPHTwjZ7FybesLw06MCmr8KdeNWpzERppVwHkNlxIc0qcy/agdmhPS61I+71A
	W9ZTiATvkfUjbIGZKM3cD+KdsH7BHUS4QpEJa2fmDYdtVboijn/iKheNbWxUJQ96Jm3rVIJbkiN
	HjakPkbNIw6WcBYkN7UdCtiEhfMEsZHFUPx0cu6pcWEqCgS6HutFwVTysOMiFtNeI5CkVV+QfXV
	DC6nRpSCFMtQ1JOnybdeQ8G34F6DzXKmBIL75cP79DrdpaIBTiO33X3OjUntRmIqmPguWl+XXNc
	cGRQaUwOK8qeoIj5tOKWwchDhgTz9GwY7hqJB3lKDILi8Fou68N9VvFESjOLgLhKsminyc5xjXX
	qOYcYOFVQr4bZIofmZl/Q/DdNkhyFWI7PXlOxHBxlD25aY7ofsrk4G6LkaeF5uLLTdjWoRPQ4gH
	VOxjIBeQuzNC0R7mdh8Jg53XbBYFNeiOC54ZU8
X-Received: by 2002:a05:7300:7493:b0:2e7:c701:aa85 with SMTP id 5a478bee46e88-307d62db622mr1610878eec.17.1780997029358;
        Tue, 09 Jun 2026 02:23:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.74.227])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dba046esm18517616eec.9.2026.06.09.02.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:23:48 -0700 (PDT)
Message-Id: <pull.2324.git.git.1780997009796.gitgitgadget@gmail.com>
From: "Lei Zhu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Jun 2026 09:23:29 +0000
Subject: [PATCH] switch: add --ensure option
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
Cc: Lei Zhu <korov9.c@gmail.com>,
    Korov <korov9.c@gmail.com>

From: Korov <korov9.c@gmail.com>

Add a new `git switch --ensure` (`-e`) option that behaves like an
idempotent form of branch switching.

Users who often switch between topic branches may not know whether the
local branch already exists. Without this option, they need to check
for the branch first and then choose between `git switch <branch>` and
`git switch -c <branch>`. The new option folds that workflow into a
single command.

When the target branch does not exist, `git switch -e <branch>`
behaves like `git switch -c <branch>`, including existing `--track`
and `--no-track` handling.

When the target branch already exists, `git switch -e <branch>`
switches to it without resetting the branch tip. If `--track` is
given, update the branch's upstream configuration using the explicit
start-point, or the current branch when no start-point is provided.
Fail in detached HEAD state when no start-point is available for
tracking setup.

Document the new option and add tests covering create-branch tracking,
existing-branch tracking updates, and detached-HEAD failure cases.

Signed-off-by: Korov <korov9.c@gmail.com>
---
    switch: add --ensure option
    
    Add a new git switch --ensure (-e) option that behaves like an
    idempotent form of branch switching.
    
    Users who often switch between topic branches may not know whether the
    local branch already exists. Without this option, they need to check for
    the branch first and then choose between git switch <branch> and git
    switch -c <branch>. The new option folds that workflow into a single
    command.
    
    When the target branch does not exist, git switch -e <branch> behaves
    like git switch -c <branch>, including existing --track and --no-track
    handling.
    
    When the target branch already exists, git switch -e <branch> switches
    to it without resetting the branch tip. If --track is given, update the
    branch's upstream configuration using the explicit start-point, or the
    current branch when no start-point is provided. Fail in detached HEAD
    state when no start-point is available for tracking setup.
    
    Document the new option and add tests covering create-branch tracking,
    existing-branch tracking updates, and detached-HEAD failure cases.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2324%2FKorov%2Fdev3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2324/Korov/dev3-v1
Pull-Request: https://github.com/git/git/pull/2324

 Documentation/git-switch.adoc | 16 +++++++
 builtin/checkout.c            | 86 ++++++++++++++++++++++++++++++++++-
 t/t2060-switch.sh             | 46 +++++++++++++++++++
 3 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index d6c4f229a5..a0ac31fa23 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -11,6 +11,7 @@ SYNOPSIS
 git switch [<options>] [--no-guess] <branch>
 git switch [<options>] --detach [<start-point>]
 git switch [<options>] (-c|-C) <new-branch> [<start-point>]
+git switch [<options>] -e <branch> [<start-point>]
 git switch [<options>] --orphan <new-branch>
 
 DESCRIPTION
@@ -81,6 +82,21 @@ $ git branch -f _<new-branch>_
 $ git switch _<new-branch>_
 ------------
 
+`-e <branch>`::
+`--ensure <branch>`::
+	Switch to _<branch>_ if it already exists, or create it from
+	_<start-point>_ before switching to it if it does not.
++
+When _<branch>_ does not already exist, this behaves like
+`git switch -c <branch> [<start-point>]`, including any `--track`
+or `--no-track` options.
++
+When _<branch>_ already exists, the branch tip is not changed. If
+`--track[=(direct|inherit)]` is given, the existing branch's upstream
+configuration is updated using _<start-point>_ when one is provided,
+or the current branch when _<start-point>_ is omitted. This form fails
+when `HEAD` is detached and no _<start-point>_ is given.
+
 `-d`::
 `--detach`::
 	Switch to a commit for inspection and discardable
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b78b3a1d16..f56935bfe2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -81,6 +81,8 @@ struct checkout_opts {
 	const char *new_branch;
 	const char *new_branch_force;
 	const char *new_orphan_branch;
+	const char *ensure_branch;
+	const char *ensure_branch_start;
 	int new_branch_log;
 	enum branch_track track;
 	struct diff_options diff_options;
@@ -988,6 +990,15 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		free(new_branch_info->refname);
 		new_branch_info->name = xstrdup(opts->new_branch);
 		setup_branch_path(new_branch_info);
+	} else if (opts->ensure_branch && opts->branch_exists &&
+		   opts->track != BRANCH_TRACK_UNSPECIFIED) {
+		const char *tracking_source = opts->ensure_branch_start ?
+			opts->ensure_branch_start :
+			old_branch_info->name;
+		dwim_and_setup_tracking(the_repository, opts->ensure_branch,
+					tracking_source, opts->track,
+					opts->quiet);
+		remote_state_clear(the_repository->remote_state);
 	}
 
 	old_desc = old_branch_info->name;
@@ -1927,6 +1938,52 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		die(_("options '-%c', '-%c', and '%s' cannot be used together"),
 			cb_option, toupper(cb_option), "--orphan");
 
+	if (opts->ensure_branch) {
+		struct strbuf ref = STRBUF_INIT;
+		int exists;
+
+		if (opts->new_branch || opts->new_branch_force || opts->new_orphan_branch)
+			die(_("'%s' cannot be used with '%s'"), "-e", "-c/-C/--orphan");
+		if (opts->force_detach)
+			die(_("'%s' cannot be used with '%s'"), "-e", "--detach");
+
+		exists = validate_branchname(opts->ensure_branch, &ref);
+		strbuf_release(&ref);
+
+		/* Save an explicit start point for tracking setup. */
+		if (argc > 0 && opts->track != BRANCH_TRACK_UNSPECIFIED)
+			opts->ensure_branch_start = argv[0];
+
+		if (exists) {
+			/*
+			 * Branch exists: just switch to it, don't reset.
+			 * We'll set up tracking after the switch if --track was given.
+			 */
+			opts->branch_exists = 1;
+		} else {
+			/* Branch doesn't exist: create it like -c */
+			opts->new_branch = opts->ensure_branch;
+		}
+	}
+
+	if (opts->ensure_branch && opts->branch_exists &&
+	    opts->track != BRANCH_TRACK_UNSPECIFIED &&
+	    !opts->ensure_branch_start) {
+		struct object_id head_oid;
+		char *head = refs_resolve_refdup(get_main_ref_store(the_repository),
+						 "HEAD", 0, &head_oid, NULL);
+		const char *branch;
+
+		if (!head)
+			die(_("failed to resolve HEAD as a valid ref"));
+		if (!strcmp(head, "HEAD"))
+			die(_("cannot set up tracking information; starting point '%s' is not a branch"),
+			    "HEAD");
+		if (!skip_prefix(head, "refs/heads/", &branch))
+			die(_("HEAD not found below refs/heads!"));
+		free(head);
+	}
+
 	if (opts->overlay_mode == 1 && opts->patch_mode)
 		die(_("options '%s' and '%s' cannot be used together"), "-p", "--overlay");
 
@@ -1961,8 +2018,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	if (opts->new_orphan_branch)
 		opts->new_branch = opts->new_orphan_branch;
 
-	/* --track without -c/-C/-b/-B/--orphan should DWIM */
-	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
+	/* --track without -c/-C/-b/-B/--orphan/-e should DWIM */
+	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch &&
+	    !(opts->ensure_branch && opts->branch_exists)) {
 		const char *argv0 = argv[0];
 		if (!argc || !strcmp(argv0, "--"))
 			die(_("--track needs a branch name"));
@@ -2012,6 +2070,28 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			die(_("reference is not a tree: %s"), opts->from_treeish);
 	}
 
+	/*
+	 * Handle -e with existing branch: set up new_branch_info to switch
+	 * to the existing branch.
+	 */
+	if (opts->ensure_branch && opts->branch_exists) {
+		struct object_id rev;
+
+		branch_info_release(&new_branch_info);
+		memset(&new_branch_info, 0, sizeof(new_branch_info));
+		new_branch_info.name = xstrdup(opts->ensure_branch);
+		setup_branch_path(&new_branch_info);
+
+		if (new_branch_info.path &&
+		    !refs_read_ref(get_main_ref_store(the_repository),
+				   new_branch_info.path, &rev)) {
+			new_branch_info.commit = lookup_commit_reference_gently(
+				the_repository, &rev, 1);
+			if (new_branch_info.commit)
+				parse_commit_or_die(new_branch_info.commit);
+		}
+	}
+
 	if (argc) {
 		parse_pathspec(&opts->pathspec, 0,
 			       opts->patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
@@ -2150,6 +2230,8 @@ int cmd_switch(int argc,
 			   N_("create and switch to a new branch")),
 		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and switch to a branch")),
+		OPT_STRING('e', "ensure", &opts.ensure_branch, N_("branch"),
+			   N_("create if needed and switch to branch")),
 		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
 			 N_("second guess 'git switch <no-such-branch>'")),
 		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index c91c4db936..c0bff7caab 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -146,6 +146,52 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
 	test_cmp_config "" --default "" branch.main2.merge
 '
 
+test_expect_success 'switch -e --track creates branch from current branch' '
+	test_when_finished "
+		git switch main || :
+		git branch -D ensure-new-current || :
+	" &&
+	git switch main &&
+	git switch -e ensure-new-current --track &&
+	test_cmp_rev refs/heads/main refs/heads/ensure-new-current &&
+	test_cmp_config . branch.ensure-new-current.remote &&
+	test_cmp_config refs/heads/main branch.ensure-new-current.merge
+'
+
+test_expect_success 'switch -e --track creates branch from remote-tracking branch' '
+	test_when_finished "
+		git switch main || :
+		git branch -D ensure-new || :
+	" &&
+	git switch -e ensure-new --track origin/foo &&
+	test_cmp_rev refs/remotes/origin/foo refs/heads/ensure-new &&
+	test_cmp_config origin branch.ensure-new.remote &&
+	test_cmp_config refs/heads/foo branch.ensure-new.merge
+'
+
+test_expect_success 'switch -e --track uses current branch for existing branch' '
+	test_when_finished "
+		git switch main || :
+		git branch -D ensure-existing source-for-track || :
+	" &&
+	git switch -c source-for-track main &&
+	git branch ensure-existing main &&
+	git switch -e ensure-existing --track &&
+	test_cmp_config . branch.ensure-existing.remote &&
+	test_cmp_config refs/heads/source-for-track branch.ensure-existing.merge
+'
+
+test_expect_success 'switch -e --track fails from detached HEAD without start-point' '
+	test_when_finished "
+		git switch main || :
+		git branch -D detached-target || :
+	" &&
+	git branch detached-target main &&
+	git switch --detach main &&
+	test_must_fail git switch -e detached-target --track 2>stderr &&
+	test_grep "cannot set up tracking information; starting point '\''HEAD'\'' is not a branch" stderr
+'
+
 test_expect_success 'switch back when temporarily detached and checked out elsewhere ' '
 	test_when_finished "
 		git worktree remove wt1 ||:

base-commit: 600fe743028cbfb640855f659e9851522214bc0b
-- 
gitgitgadget
