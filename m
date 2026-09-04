Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F8B3B841D
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537091; cv=none; b=VRQkFP4EITDH79r4p8xMizP7bY9QaLK3/07utfraaPJD7lljUjwSuv6lIArTsoOHv7MCpcti42BbMTpdbkKIT6F577inmeBMl1iv9d1whzmWP2+oLWxlUbJ8Z6hmkIKUtKshzRYnOK/7w/v2RyVQLH3jldVbXux9Cq57i2/NQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537091; c=relaxed/simple;
	bh=bAJVYJxLP/uLLa5jXMt89hGM/lEdobabFjtxZZvf4PE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Bb21etZNuilKDFipk5YgXNwu31gLjH0bWOBYHmhyFmbLgLYD2/AViqNiex6d9eG/1w0av8kJbltMOCAHCNB1alCKgalhcuWa4IBNe+4lSAx+uvdC9CoB1eBmgEYCj50n6j3Kh+0xf8NHpAGxwGtDUvUA3uiimsqdG9uY8P/WHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0686AuZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0686AuZ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d91518a63fso8939185ad.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788537088; x=1789141888; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1u/t9Np7RFNVrjCfdp3dAOHtsCRzk8wk9Lh5iiUS6Dc=;
        b=C0686AuZg+TOWz5rbn4Src8vqhfKecAxOdiuitPN/Hgo4KkNKPPN+B3SXlb9udcobq
         JACFmsIwiksIHXAlhNUrLC4rFw8kEIieCcrJxnSAjJT3XRinMNm5HO+qPlY1Y043ZsIn
         KfZ6RyeAXwah2O+U6Tav90iEbJZ4iKd512layHJ+flUcXzrD38ZMYLpoDfCAs5M+3vkK
         e6oUqF1i96cUbtQpc6XDh35Tu+DQzxWhdn5chC6Xq2OacHnGBNt06tQ3TmxFF1EpqCKY
         B3qoOQWX5vvzZ46jM08CxXrYNc4LTGpuYWfMh/S96TYARwQXP3XvE/HTzldOHVTnTmH8
         q0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788537088; x=1789141888;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1u/t9Np7RFNVrjCfdp3dAOHtsCRzk8wk9Lh5iiUS6Dc=;
        b=jj7NtyKrVPkADfzyqDVELiJibJaQjGWFFN6uy+Jmj0bm6GPLgpG+1jWE12pwrxOn3J
         6Xh5zjxCnOmtCKSxk4Hj/3fh7WyEXSVXHKMUr91uGs0mF58D0mCFDEFme++CIrpB/kpu
         OoLKaxbCu0wG7DYxmUiF6qIM8Lv0+JJeY2ojoeMscfEHYkHmJL5BYLCB9fF9WVVQrOba
         v+WR3LcWVWRFMwBQ8Ha5ROBNdU47DjYSXeQ1hai6zPqFIoEFE2IEPCsLybkuzYfUlbXU
         K/KKeRlUQKPzYzDtBDSbFWEn4xm8RTSeVgBSz5rY4HB2ATh7sUz97f4ju4n2GfspPAWS
         1loA==
X-Gm-Message-State: AFuF++npWrBASd7Weo7oqjzQ50pHJXOzI42xEIXxD3Ot4ogfrOwIMT3g
	8maUWwsEEZN20xMzbgkLqrZ3Mu78BTOBdU+OeIvXfoB0TySzanp32c+QS/zpIQ==
X-Gm-Gg: AYBFou3mNIBlFULkHLGNVhy9UykyVTqVh3Tqlib4swuESkPQBpHiHHloWP8kV4b7euk
	uE/XL56/+9LXgUab39ZRsP3xeB1hHNHO/04TkrbgD2mSEJ6/X42Xtz9qcXKXVTgius1GNjuF898
	75whVOjjdnhcnRVLR6FEptHCO1ZN1aLWBoWjZs2LpyAMMCNJMYXcg4UHZvLGQj3lN1pvBih/kUb
	De0OGJg0MJoVHIrAgMgOeRNcUBCRXYhR/KQIQ8O37aJbBDVv4VyTah5lXTUr8PSwV8JyMzU+OrN
	NRwVHIHbrQi7ZPwPO9PYnJPrbqYYdPIgZl29IfNxaQZp4uvzBzFyCcaYnEW2YG29bD8bTJ8ht7g
	39UcBaUpUS/3MY/CsMmXZI9QzRaVzQvpcBEh2c+/KjH3nRrPqSC+3ThHC5MyVx9UdnSspmC6eXl
	ZMs0/2dIrVdEvrOtYMmyhFnLAm/MV/AnlTl2ytcvz+6OgMRAAl4DHvVVVJhhSi1wK0M+MO1eZkI
	g==
X-Received: by 2002:a17:90b:394e:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-39b26272d76mr10576604a91.12.1788537088070;
        Fri, 04 Sep 2026 08:51:28 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.247.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm8730320eec.1.2026.09.04.08.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:51:27 -0700 (PDT)
Message-Id: <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Sep 2026 15:51:23 +0000
Subject: [PATCH v2 0/3] sequencer: leave auto maintenance to the end of a sequence
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Thomas Bachem <mail@thomasbachem.com>

Changes since v1:

 * Cherry-pick and revert end their sequences with auto maintenance too, and
   keep it out of the "git commit" they spawn, so the three commands now
   behave the same (Phillip).
 * The GIT_CONFIG_PARAMETERS value comes from a helper split out of
   git_config_push_split_parameter() in config.c (new patch 1), built once
   per run and kept in replay_ctx (Phillip).
 * Commit messages rewritten, much shorter (Junio, Phillip).

Based on master. Independent of the rerere lock fix in [1].

[1] <pull.2214.v2.git.1788507876543.gitgitgadget@gmail.com>

Thomas Bachem (3):
  config: add git_config_append_parameter()
  sequencer: run auto maintenance once a sequence is done
  sequencer: keep auto maintenance out of the commands a sequence spawns

 config.c                        | 20 ++++++++----
 config.h                        | 10 ++++++
 sequencer.c                     | 57 +++++++++++++++++++++++++++++----
 t/t3418-rebase-continue.sh      | 26 +++++++++++++++
 t/t3510-cherry-pick-sequence.sh | 27 ++++++++++++++++
 5 files changed, 127 insertions(+), 13 deletions(-)


base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2217%2Fthomasbachem%2Frebase-auto-maintenance-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2217/thomasbachem/rebase-auto-maintenance-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2217

Range-diff vs v1:

 -:  ---------- > 1:  ef8087e80d config: add git_config_append_parameter()
 1:  3415a4dcbf ! 2:  baab8d4876 sequencer: run auto maintenance once a rebase is done
     @@ Metadata
      Author: Thomas Bachem <mail@thomasbachem.com>
      
       ## Commit message ##
     -    sequencer: run auto maintenance once a rebase is done
     +    sequencer: run auto maintenance once a sequence is done
      
     -    The apply backend runs "git maintenance run --auto" from
     -    finish_rebase() once it has applied its patches, and so does "git am"
     -    on its own. The merge backend reaches finish_rebase() only on the
     -    paths both backends share in builtin/rebase.c: an abort, a branch
     -    that is already up to date, and a fast-forward. A rebase that
     -    replays commits never runs maintenance at its end. It creates most
     -    of its commits in process, and only the "git commit" it spawns for a
     -    resolved, reworded or squashed pick, the "git merge" a "rebase -r"
     -    spawns for an octopus merge or with a strategy, and whatever an exec
     -    command runs kick maintenance off, in the middle of the rebase. Run
     -    it where the sequencer finishes a rebase, after the autostash is
     -    applied, as finish_rebase() does, so that both backends end a rebase
     -    the same way, and so that the next commit can keep it out of the
     -    commands a rebase spawns. builtin/rebase.c could run it instead once
     -    run_sequencer_rebase() returns, but the sequencer is where the rebase
     -    finishes, and the autostash and the state cleanup that surround the
     -    run in finish_rebase() are there as well. prepare_auto_maintenance()
     -    closes the object database before the spawn, so the sequencer holds
     -    nothing a repack would need to replace.
     +    The apply backend of "git rebase" runs "git maintenance run --auto"
     +    from finish_rebase() once it has applied its patches. The merge
     +    backend, "git cherry-pick" and "git revert" do not run it when they
     +    finish. They create their commits in process, and only the "git
     +    commit" they spawn for an edited message or a resolved conflict, the
     +    "git merge" a "rebase -r" spawns and an exec command start it, in the
     +    middle of the sequence.
     +
     +    Run it where the sequencer finishes, so that every sequence ends the
     +    way the apply backend does, and so that the next commit can keep it
     +    out of the commands a sequence spawns.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
      
       ## sequencer.c ##
      @@ sequencer.c: cleanup_head_ref:
     - 			run_hooks_opt(r, "post-rewrite", &hook_opt);
     + 			return -1;
     + 	}
     + 
     ++	/*
     ++	 * We ignore errors in 'git maintenance run --auto', since the
     ++	 * user should see them.
     ++	 */
     ++	run_auto_maintenance(r, opts->quiet);
     ++
     + 	/*
     + 	 * Sequence of picks finished successfully; cleanup by
     + 	 * removing the .git/sequencer directory
     +@@ sequencer.c: int sequencer_continue(struct repository *r, struct replay_opts *opts)
     + 			res = -1;
     + 			goto release_todo_list;
       		}
     - 		apply_autostash(rebase_path_autostash());
     -+		/*
     -+		 * We ignore errors in 'git maintenance run --auto', since the
     -+		 * user should see them.
     -+		 */
     -+		run_auto_maintenance(r, opts->quiet);
     +-	} else if (!file_exists(get_todo_path(opts)))
     +-		return continue_single_pick(r, opts);
     +-	else if ((res = read_populate_todo(r, &todo_list, opts)))
     ++	} else if (!file_exists(get_todo_path(opts))) {
     ++		res = continue_single_pick(r, opts);
     ++		if (!res)
     ++			run_auto_maintenance(r, opts->quiet);
     ++		return res;
     ++	} else if ((res = read_populate_todo(r, &todo_list, opts))) {
     + 		goto release_todo_list;
     ++	}
     + 
     + 	if (!is_rebase_i(opts)) {
     + 		/* Verify that the conflict has been resolved */
     +@@ sequencer.c: int sequencer_pick_revisions(struct repository *r,
     + 			BUG("unexpected extra commit from walk");
     + 
     + 		res = single_pick(r, cmit, opts);
     ++		if (!res)
     ++			run_auto_maintenance(r, opts->quiet);
     + 		goto out;
     + 	}
       
     - 		if (!opts->quiet) {
     - 			if (!opts->verbose)
      
       ## t/t3418-rebase-continue.sh ##
      @@ t/t3418-rebase-continue.sh: test_orig_head () {
     @@ t/t3418-rebase-continue.sh: test_orig_head () {
      +'
      +
       test_done
     +
     + ## t/t3510-cherry-pick-sequence.sh ##
     +@@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'commit descriptions in insn sheet are optional' '
     + 	test_line_count = 4 commits
     + '
     + 
     ++test_expect_success 'cherry-pick runs auto maintenance once it is done' '
     ++	pristine_detach base &&
     ++	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick picked &&
     ++	test_subcommand_flex git maintenance run --auto <single.txt &&
     ++	GIT_TRACE2_EVENT="$(pwd)/sequence.txt" \
     ++		git cherry-pick anotherpick yetanotherpick &&
     ++	grep "\"child_start\".*\"maintenance\"" sequence.txt >maintenance &&
     ++	test_line_count = 1 maintenance
     ++'
     ++
     + test_done
 2:  06d2f0f484 ! 3:  9a6fc0427a sequencer: keep auto maintenance out of the commands a rebase spawns
     @@ Metadata
      Author: Thomas Bachem <mail@thomasbachem.com>
      
       ## Commit message ##
     -    sequencer: keep auto maintenance out of the commands a rebase spawns
     +    sequencer: keep auto maintenance out of the commands a sequence spawns
      
     -    The commands a rebase with the merge backend spawns, the "git commit"
     -    for a resolved, reworded or squashed pick, the "git merge" of a
     -    "rebase -r" for an octopus merge or with a strategy, and whatever an
     -    exec command runs, each kick off "git maintenance run --auto --detach",
     -    a background process the rebase then races for the repository: the
     -    "rerere gc" spawned by the commit of one "git rebase --continue" holds
     -    MERGE_RR.lock while the next pick wants it, and a repack wants to
     -    delete packs the sequencer still had open, which 65cda10d5b
     +    The "git commit" and "git merge" the sequencer spawns, and the git
     +    commands an exec runs, each start "git maintenance run --auto
     +    --detach", which then works in the background against the sequence
     +    itself. A "rerere gc" started by the commit of one "git rebase
     +    --continue" holds MERGE_RR.lock when the next pick needs it, and a
     +    repack deletes packs the sequencer still has open, which 65cda10d5b
          (sequencer: release the ODB before spawning git commit, 2026-08-12)
     -    had to fix for Windows.
     +    had to work around.
      
     -    Nothing a rebase creates is old enough to be pruned by the time it
     -    ends, and repacking what it created can wait until then, so
     -    maintenance in the middle of a rebase has nothing to do that a run at
     -    its end cannot, and a rebase to get in the way of. Pass
     -    maintenance.auto=false and gc.auto=0 to the commands a rebase spawns,
     -    through GIT_CONFIG_PARAMETERS so that the shell of an exec command
     -    passes them on too, appended to whatever -c the user gave, since the
     -    last entry wins. What the user runs while the rebase is stopped, say
     -    "git commit --amend" at an edit, is not the rebase's to control and
     -    still runs it. "git commit" and "git merge" could skip it themselves
     -    while a rebase is in progress, which would cover that too, but that
     -    spreads the rebase's business over every command that runs
     -    maintenance and defers theirs for as long as a rebase is left lying
     -    around, so keep the decision with the rebase, in what it spawns. Both
     -    backends run maintenance once the rebase is done, the merge backend
     -    since the previous commit, so nothing is lost.
     -
     -    Cherry-pick and revert are left alone: they never ran maintenance at
     -    the end of a sequence, and the "git commit" they spawn for a
     -    --continue or an edited message is the only place they run it at all.
     +    The loose objects a sequence creates wait for the run at its end that
     +    the previous commit added. Whether a sequence can be long enough to
     +    suffer from them before that remains to be seen. Pass
     +    maintenance.auto=false and gc.auto=0 to the spawned commands through
     +    GIT_CONFIG_PARAMETERS, which the shell of an exec command hands on to
     +    whatever it runs, appended after the user's own -c settings so that
     +    ours win, and built once per run. A command the user runs while the
     +    sequence is stopped, like "git commit --amend" at an edit, is not the
     +    sequencer's to control and still runs maintenance.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
      
       ## sequencer.c ##
     +@@ sequencer.c: struct replay_ctx {
     + 	 * Whether message contains a commit message.
     + 	 */
     + 	unsigned have_message :1;
     ++	/*
     ++	 * The GIT_CONFIG_PARAMETERS value that keeps auto maintenance out
     ++	 * of the commands we spawn, built on first use.
     ++	 */
     ++	struct strbuf config_parameters;
     + };
     + 
     + struct replay_ctx* replay_ctx_new(void)
     +@@ sequencer.c: struct replay_ctx* replay_ctx_new(void)
     + 
     + 	strbuf_init(&ctx->current_fixups, 0);
     + 	strbuf_init(&ctx->message, 0);
     ++	strbuf_init(&ctx->config_parameters, 0);
     + 
     + 	return ctx;
     + }
     +@@ sequencer.c: static void replay_ctx_release(struct replay_ctx *ctx)
     + {
     + 	strbuf_release(&ctx->current_fixups);
     + 	strbuf_release(&ctx->message);
     ++	strbuf_release(&ctx->config_parameters);
     + }
     + 
     + void replay_opts_release(struct replay_opts *opts)
      @@ sequencer.c: static int run_command_silent_on_success(struct child_process *cmd)
       	return rc;
       }
       
      +/*
     -+ * A rebase runs auto maintenance once it is done, not from every command
     ++ * A sequence runs auto maintenance once it is done, not from every command
      + * it spawns along the way: their background "rerere gc" or repack would
     -+ * race the rebase for locks and files it still holds.
     ++ * race the sequencer for locks and files it still holds.
      + */
     -+static void disable_auto_maintenance(struct child_process *cmd)
     ++static void disable_auto_maintenance(struct replay_opts *opts,
     ++				     struct child_process *cmd)
      +{
     -+	struct strbuf value = STRBUF_INIT;
     -+	const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
     ++	struct strbuf *params = &opts->ctx->config_parameters;
      +
     -+	if (old && *old)
     -+		strbuf_addf(&value, "%s ", old);
     -+	sq_quote_buf(&value, "maintenance.auto");
     -+	strbuf_addch(&value, '=');
     -+	sq_quote_buf(&value, "false");
     -+	strbuf_addch(&value, ' ');
     -+	sq_quote_buf(&value, "gc.auto");
     -+	strbuf_addch(&value, '=');
     -+	sq_quote_buf(&value, "0");
     -+	strvec_pushf(&cmd->env, "%s=%s", CONFIG_DATA_ENVIRONMENT, value.buf);
     -+	strbuf_release(&value);
     ++	if (!params->len) {
     ++		const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
     ++
     ++		if (old && *old)
     ++			strbuf_addstr(params, old);
     ++		git_config_append_parameter(params, "maintenance.auto", "false");
     ++		git_config_append_parameter(params, "gc.auto", "0");
     ++	}
     ++	strvec_pushf(&cmd->env, "%s=%s", CONFIG_DATA_ENVIRONMENT, params->buf);
      +}
      +
       /*
     @@ sequencer.c: static int run_git_commit(const char *defmsg,
       			     author_date_from_env(&cmd.env));
       	if (opts->ignore_date)
       		strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
     -+	if (is_rebase_i(opts))
     -+		disable_auto_maintenance(&cmd);
     ++	disable_auto_maintenance(opts, &cmd);
       
       	strvec_push(&cmd.args, "commit");
       
     -@@ sequencer.c: static int do_exec(struct repository *r, const char *command_line, int quiet)
     +@@ sequencer.c: static int error_failed_squash(struct repository *r,
     + 	return error_with_patch(r, commit, subject, subject_len, opts, 1, 1);
     + }
     + 
     +-static int do_exec(struct repository *r, const char *command_line, int quiet)
     ++static int do_exec(struct repository *r, const char *command_line,
     ++		   struct replay_opts *opts)
     + {
     + 	struct child_process cmd = CHILD_PROCESS_INIT;
     + 	int dirty, status;
     + 
     +-	if (!quiet)
     ++	if (!opts->quiet)
     + 		fprintf(stderr, _("Executing: %s\n"), command_line);
       	cmd.use_shell = 1;
       	strvec_push(&cmd.args, command_line);
       	strvec_push(&cmd.env, "GIT_CHERRY_PICK_HELP");
     -+	disable_auto_maintenance(&cmd);
     ++	disable_auto_maintenance(opts, &cmd);
       	status = run_command(&cmd);
       
       	/* force re-reading of the cache */
     @@ sequencer.c: static int do_merge(struct repository *r,
       				     author_date_from_env(&cmd.env));
       		if (opts->ignore_date)
       			strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
     -+		disable_auto_maintenance(&cmd);
     ++		disable_auto_maintenance(opts, &cmd);
       
       		cmd.git_cmd = 1;
       		strvec_push(&cmd.args, "merge");
     +@@ sequencer.c: static int pick_commits(struct repository *r,
     + 			if (!opts->verbose)
     + 				term_clear_line();
     + 			*end_of_arg = '\0';
     +-			res = do_exec(r, arg, opts->quiet);
     ++			res = do_exec(r, arg, opts);
     + 			*end_of_arg = saved;
     + 
     + 			if (res) {
     +@@ sequencer.c: static int continue_single_pick(struct repository *r, struct replay_opts *opts)
     + 		return error(_("no cherry-pick or revert in progress"));
     + 
     + 	cmd.git_cmd = 1;
     ++	disable_auto_maintenance(opts, &cmd);
     + 	strvec_push(&cmd.args, "commit");
     + 
     + 	/*
      
       ## t/t3418-rebase-continue.sh ##
      @@ t/t3418-rebase-continue.sh: test_expect_success 'rebase runs auto maintenance at its end' '
     @@ t/t3418-rebase-continue.sh: test_expect_success 'rebase runs auto maintenance at
      +'
      +
       test_done
     +
     + ## t/t3510-cherry-pick-sequence.sh ##
     +@@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'cherry-pick runs auto maintenance once it is done' '
     + 	test_line_count = 1 maintenance
     + '
     + 
     ++test_expect_success 'cherry-pick spawns no auto maintenance before it is done' '
     ++	pristine_detach initial &&
     ++	test_must_fail git cherry-pick base..anotherpick &&
     ++	echo resolved >foo &&
     ++	git add foo &&
     ++	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
     ++		git cherry-pick --continue &&
     ++	test_subcommand_flex git commit <mid.txt &&
     ++	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
     ++	echo d >foo &&
     ++	git add foo &&
     ++	GIT_TRACE2_EVENT="$(pwd)/end.txt" git cherry-pick --continue &&
     ++	test_subcommand_flex git commit <end.txt &&
     ++	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
     ++	test_line_count = 1 maintenance
     ++'
     ++
     + test_done

-- 
gitgitgadget
