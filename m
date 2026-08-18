Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076546C831
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052878; cv=none; b=CJevbph+7kxH7fZuuqDnDLd5RQrzMZOTg0PwnSYYzDf/cT+MFtV2n3gZ1IWutkYJfzUQipQJ3u/dokK56JJGDi3bZRoyPcZh1E6LlehFKIetqD5DN3lkSjAqVaPmJzLwHYxizV8aHbQZJCz8RGtLT27KbRrxZ8edL//a7L2AXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052878; c=relaxed/simple;
	bh=ii1z+Pfj5nsf7jNoDXldSnbFs7Xuva8A5Cj5gGgjDe4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jBCGLEVqkCU3SHSLJRVSrRuCA/On8ryPz6sAjuhrje/X0haJM49s/wFBGRR6L9LuAW7PYHxsisR/vGoxt5tmLxfX7jhXCYFSKm6iyEL8PpKGcdcDFVQvCUym/iy1w0FFMSyPBnKRb427Bw2DNxRsXQnOrMFR6C/IuvdYBI9vE40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtmtKy5S; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtmtKy5S"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c4436d02cso15261021cf.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 04:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787052875; x=1787657675; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N4vXU8AcXGOLSYyiyk8ygjYQrxQSD2KoarLhTUQcPJ8=;
        b=KtmtKy5SCNY/KPUKslTzfoY2u6PlwvzVLNgWKv5WN+0FV+M9kLbFF9e1mKJqtc6lKq
         S35UJE9bu4Nh57yn1EBkUKuch5I/drsRrQ/FQl6qD5NJVQOjeab478BTCWP6pX/cdGGD
         clDiVVqvtMH0TQRCy7c6afpmTZYlmAGU+/QJyBAAM1tWFJMT3KRKvkRIkF9VDP8070pi
         AyOBoyLqs4hP6q7HWChfv341aW6C2G8W1SqV5qswGP9403yISnkQGxSVxfDRNEoYWjKb
         JBOSP8lXVJmAI8ejLlwQ2/cxjhT5DSBZolIRbJg1ZZE/feQ1pdEMIW8Q4jFpe+vy6j1c
         2cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787052875; x=1787657675;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N4vXU8AcXGOLSYyiyk8ygjYQrxQSD2KoarLhTUQcPJ8=;
        b=oRYK+/sTjZmadFFFxvb/1dMpH5ciqTfb6+/cRuI1aFPPQSRXat2gURNEB1CQnpJhUT
         ti3F3/9D1iMLdT2Zbhpvg9Ux+G0XkYKwBLwwWf68TztOZh4/Lzkl7v9kfzTTzd2ufffQ
         xO5iCXLjucRm3yr1pFewyEWQfhAR3wHv0ZVUp2L5glAb/GRE9ELIPBbr6clCVtyPs/xb
         srFSJGO/CGtDx1YbtasNPnVeqx+8BnXn7/0Vyrms7NcD27huhhJrvRvT3MO/7rLbqoE0
         HfzhuzZO6c1Rch51qRZIcJrWMsvi+HGLUZLodUYyBamMI5o/TpYMSSXEAzlQ7VUrfdK5
         8cPw==
X-Gm-Message-State: AOJu0Yz7cDIfEA/Jtn8F6Dimh8C1bcPWb0Q1c5CjUp1pn6vtUy8UICYn
	nsZwJghZ7DnA3REA3iTH2LWiursM8vSe5x6l9rlakYS0EObMBO8ZY/cLRuh8RQ==
X-Gm-Gg: AR+sD13Q2sAsaGmrLfoD31Kcl+vhogNbt1gToEDnpGRbdIpH4hoqWjC9yL/6L7w6h7Q
	XqHdDuT/yWSaSmZUXkCM7rFJmHjcimIfBx2y/NjGCFlwZDCaz5FMxrPXbkNgfDz69oYQhJ1QHZo
	BGZGbwt6B9lu9oyXuFej19HWpVxdnCAI9dw0s86JnRmKlxVeji3H7GL0kXgbj2feRkKrzlG+XHR
	bPK3FwBiltRNcms1Zvh2DymOfI/iJD7ODxZY8vN+ub0NdE9XxoW+Qzhj+Y/OTOM7mx94Dr8Hec4
	JXcEzTLb55oqQloN3vWJ/EfuayL/3T3XNnpH2G5xvH+XtZO2O55579CIuOBLodWuYkFhyhhrctr
	5WivuKIzGLZAZoPV9rH4CYYg6uYWkA1mZDTKWVyiWeWVpvoxLCWNXltFe8XbK9kGSVYaAxCsGWE
	bAIdlt8vEzDa/y08vnKmVNtVg4Jj7f+E2YyErdlHC77KJu4BMXU8IPqDjvKQcf
X-Received: by 2002:a05:622a:4185:b0:528:3882:386a with SMTP id d75a77b69052e-52d8534fbbcmr399936491cf.11.1787052874845;
        Tue, 18 Aug 2026 04:34:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.94.54.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db613ca70sm36238831cf.13.2026.08.18.04.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:34:34 -0700 (PDT)
Message-Id: <pull.2384.git.git.1787052873141.gitgitgadget@gmail.com>
From: "Artur Bieniek via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Aug 2026 11:34:33 +0000
Subject: [PATCH] pull: add --hard mode
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
Cc: Artur Bieniek <abieniek@antmicro.com>,
    Artur Bieniek <ar2rekb@gmail.com>

From: Artur Bieniek <ar2rekb@gmail.com>

Add --hard as an explicit alternative to merge and rebase. After
fetching, require a single integration candidate and reset the current
branch, index, and working tree to it.

Preserve quiet and submodule recursion behavior, and reject options
that cannot be honored by a hard reset. Document the destructive
semantics and cover them in tests.

Signed-off-by: Artur Bieniek <ar2rekb@gmail.com>
---
    [RFC] Add git pull --hard mode

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2384%2FArturBieniek4%2Fpull-hard-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2384/ArturBieniek4/pull-hard-v1
Pull-Request: https://github.com/git/git/pull/2384

 Documentation/git-pull.adoc | 10 +++++-
 builtin/pull.c              | 68 ++++++++++++++++++++++++++++++++-----
 t/t5521-pull-options.sh     | 31 +++++++++++++++++
 t/t5572-pull-submodule.sh   | 18 ++++++++++
 4 files changed, 118 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 88f4fd3926..3a103a1630 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -24,7 +24,7 @@ with no arguments this defaults to the <<UPSTREAM-BRANCHES,upstream>>
 for the current branch.
 Then it integrates that branch into the current branch.
 
-There are 4 main options for integrating the remote branch:
+There are 5 main options for integrating the remote branch:
 
 1. `git pull --ff-only` will only do "fast-forward" updates: it
    fails if your local branch has diverged from the remote branch.
@@ -32,6 +32,7 @@ There are 4 main options for integrating the remote branch:
 2. `git pull --rebase` runs `git rebase`
 3. `git pull --no-rebase` runs `git merge`.
 4. `git pull --squash` runs `git merge --squash`
+5. `git pull --hard` runs `git reset --hard` to the fetched branch.
 
 You can also set the configuration options `pull.rebase`, `pull.squash`,
 or `pull.ff` with your preferred behaviour.
@@ -119,6 +120,13 @@ unless you have read linkgit:git-rebase[1] carefully.
 `--no-rebase`::
 	This is shorthand for `--rebase=false`.
 
+`--hard`::
+	Reset the current branch, index, and working tree to the fetched branch.
+	The pull must select exactly one branch. Local commits and changes to
+	tracked files are discarded. Untracked files or directories in the way
+	of writing tracked files may also be deleted. This option cannot be
+	combined with merge or rebase options, or with `--append`.
+
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/pull.c b/builtin/pull.c
index db3ee0aab3..8324f06084 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -91,6 +91,7 @@ static char *opt_ff;
 static const char *opt_verify_signatures;
 static const char *opt_verify;
 static int opt_autostash = -1;
+static int opt_hard;
 static int config_rebase_autostash;
 static int config_pull_autostash = -1;
 static int check_trust_level = 1;
@@ -318,7 +319,9 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 	const char *remote = curr_branch ? curr_branch->remote_name : NULL;
 
 	if (*refspecs) {
-		if (opt_rebase)
+		if (opt_hard)
+			fprintf_ln(stderr, _("There is no candidate for resetting to among the refs that you just fetched."));
+		else if (opt_rebase)
 			fprintf_ln(stderr, _("There is no candidate for rebasing against among the refs that you just fetched."));
 		else
 			fprintf_ln(stderr, _("There are no candidates for merging among the refs that you just fetched."));
@@ -331,7 +334,9 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			repo);
 	} else if (!curr_branch) {
 		fprintf_ln(stderr, _("You are not currently on a branch."));
-		if (opt_rebase)
+		if (opt_hard)
+			fprintf_ln(stderr, _("Please specify which branch you want to reset to."));
+		else if (opt_rebase)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -346,7 +351,9 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 			remote_name = _("<remote>");
 
 		fprintf_ln(stderr, _("There is no tracking information for the current branch."));
-		if (opt_rebase)
+		if (opt_hard)
+			fprintf_ln(stderr, _("Please specify which branch you want to reset to."));
+		else if (opt_rebase)
 			fprintf_ln(stderr, _("Please specify which branch you want to rebase against."));
 		else
 			fprintf_ln(stderr, _("Please specify which branch you want to merge with."));
@@ -358,7 +365,11 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
 		fprintf(stderr, "\n");
 		fprintf_ln(stderr, "    git branch --set-upstream-to=%s/%s %s\n",
 				remote_name, _("<branch>"), curr_branch->name);
-	} else
+	} else if (opt_hard)
+		fprintf_ln(stderr, _("Your configuration specifies to reset to the ref '%s'\n"
+			"from the remote, but no such ref was fetched."),
+			curr_branch->merge[0]->src);
+	else
 		fprintf_ln(stderr, _("Your configuration specifies to merge with the ref '%s'\n"
 			"from the remote, but no such ref was fetched."),
 			curr_branch->merge[0]->src);
@@ -570,6 +581,23 @@ static int run_merge(void)
 	return run_command(&cmd);
 }
 
+static int run_reset(const struct object_id *oid)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	strvec_pushl(&cmd.args, "reset", "--hard", NULL);
+	if (opt_verbosity < 0)
+		strvec_push(&cmd.args, "--quiet");
+	if (recurse_submodules == RECURSE_SUBMODULES_ON ||
+	    recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
+		strvec_push(&cmd.args, "--recurse-submodules");
+	else if (recurse_submodules == RECURSE_SUBMODULES_OFF)
+		strvec_push(&cmd.args, "--no-recurse-submodules");
+	strvec_push(&cmd.args, oid_to_hex(oid));
+	cmd.git_cmd = 1;
+	return run_command(&cmd);
+}
+
 /**
  * Returns remote's upstream branch for the current branch. If remote is NULL,
  * the current branch's configured default remote is used. Returns NULL if
@@ -925,6 +953,8 @@ int cmd_pull(int argc,
 			PARSE_OPT_NOARG),
 		OPT_BOOL(0, "autostash", &opt_autostash,
 			N_("automatically stash/stash pop before and after")),
+		OPT_BOOL(0, "hard", &opt_hard,
+			N_("reset hard to the fetched branch")),
 		OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
 			N_("merge strategy to use"),
 			0),
@@ -1022,6 +1052,16 @@ int cmd_pull(int argc,
 	}
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
+	if (opt_hard &&
+	    (opt_rebase >= 0 || opt_diffstat || opt_log || opt_signoff ||
+	     opt_squash || opt_commit || opt_edit || cleanup_arg || opt_ff ||
+	     opt_verify_signatures || opt_verify || opt_autostash >= 0 ||
+	     opt_strategies.nr || opt_strategy_opts.nr || opt_gpg_sign ||
+	     opt_allow_unrelated_histories))
+		die(_("--hard cannot be combined with merge or rebase options"));
+	die_for_incompatible_opt2(opt_hard, "--hard",
+				  opt_append && !strcmp(opt_append, "--append"),
+				  "--append");
 	if (opt_autostash == -1)
 		opt_autostash = config_pull_autostash;
 
@@ -1037,7 +1077,7 @@ int cmd_pull(int argc,
 
 	parse_repo_refspecs(argc, argv, &repo, &refspecs);
 
-	if (!opt_ff) {
+	if (!opt_hard && !opt_ff) {
 		opt_ff = xstrdup_or_null(config_get_ff());
 		/*
 		 * A subtle point: opt_ff was set on the line above via
@@ -1056,13 +1096,15 @@ int cmd_pull(int argc,
 		}
 	}
 
-	if (opt_rebase < 0)
+	if (opt_hard)
+		opt_rebase = REBASE_FALSE;
+	else if (opt_rebase < 0)
 		opt_rebase = config_get_rebase(&rebase_unspecified);
 
-	if (repo_read_index_unmerged(the_repository))
+	if (!opt_hard && repo_read_index_unmerged(the_repository))
 		die_resolve_conflict("pull");
 
-	if (file_exists(git_path_merge_head(the_repository)))
+	if (!opt_hard && file_exists(git_path_merge_head(the_repository)))
 		die_conclude_merge();
 
 	if (repo_get_oid(the_repository, "HEAD", &orig_head))
@@ -1090,6 +1132,16 @@ int cmd_pull(int argc,
 	if (opt_dry_run)
 		return 0;
 
+	if (opt_hard) {
+		get_merge_heads(&merge_heads);
+		if (!merge_heads.nr)
+			die_no_merge_candidates(repo, refspecs);
+		if (merge_heads.nr > 1)
+			die(_("Cannot hard reset to multiple branches."));
+		ret = run_reset(merge_heads.oid);
+		goto cleanup;
+	}
+
 	if (repo_get_oid(the_repository, "HEAD", &curr_head))
 		oidclr(&curr_head, the_repository->hash_algo);
 
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 5e420c208c..31bb76b465 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -117,6 +117,37 @@ test_expect_success 'git pull --force' '
 	)
 '
 
+test_expect_success 'git pull --hard' '
+	test_when_finished "rm -rf hard-parent hard" &&
+	git init hard-parent &&
+	test_commit -C hard-parent base &&
+	git clone hard-parent hard &&
+	test_commit -C hard local &&
+	test_commit -C hard-parent upstream obstruct upstream &&
+	git -C hard-parent branch side &&
+	(
+		cd hard &&
+		echo dirty >base.t &&
+		mkdir obstruct &&
+		echo untracked >obstruct/file &&
+		test_must_fail git pull --hard --ff-only 2>err &&
+		test_grep "cannot be combined" err &&
+		test_must_fail git pull --hard -a 2>err &&
+		test_grep "options .*--hard.* and .*--append.*" err &&
+		test_must_fail git pull --hard origin main side 2>err &&
+		test_grep "Cannot hard reset to multiple branches" err &&
+		git pull --hard &&
+		test_cmp_rev HEAD origin/main &&
+		test_path_is_missing local.t &&
+		test_path_is_file obstruct &&
+		git diff --quiet &&
+		git diff --cached --quiet &&
+		git pull -q --hard >out 2>quiet-err &&
+		test_must_be_empty out &&
+		test_must_be_empty quiet-err
+	)
+'
+
 test_expect_success 'git pull --all' '
 	mkdir clonedmulti &&
 	(cd clonedmulti && git init &&
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 42d14328b6..f2df277b79 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -106,6 +106,24 @@ test_expect_success " --[no-]recurse-submodule and submodule.recurse" '
 	test_path_is_file super/sub/merge_strategy_4.t
 '
 
+test_expect_success 'pull --hard honors submodule recursion' '
+	test_commit -C child hard_recurse &&
+	git -C parent submodule update --remote &&
+	git -C parent add sub &&
+	git -C parent commit -m "update submodule" &&
+
+	git -C super pull --hard --recurse-submodules &&
+	test_path_is_file super/sub/hard_recurse.t &&
+
+	test_commit -C child hard_no_recurse &&
+	git -C parent submodule update --remote &&
+	git -C parent add sub &&
+	git -C parent commit -m "update submodule" &&
+
+	git -C super -c submodule.recurse=true pull --hard --no-recurse-submodules &&
+	test_path_is_missing super/sub/hard_no_recurse.t
+'
+
 test_expect_success "fetch.recurseSubmodules option triggers recursive fetch (but not recursive update)" '
 	test_commit -C child merge_strategy_5 &&
 	# Omit the parent commit, otherwise this passes with the

base-commit: 745601a9a94110d74769ab605ccd4f61339758d2
-- 
gitgitgadget
