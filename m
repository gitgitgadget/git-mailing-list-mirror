Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE75470E91
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 08:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942341; cv=none; b=qQ0ESeFtT9Nbmj0EcRjPabaAeXl9MFCz05N1GK+D+wDkIZGsfN9IuzW1VOQT3FQjLQNPyE3GtO8oAK+RWVOrKq0A9qgVkzndopZSv9Ya+6Esqq5H19InTuUHlk5PVcwh+a2dfPom8e4VJn0rX5cyf/wnAudwLyDfM8cmUMb4nto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942341; c=relaxed/simple;
	bh=QsLmeRfJqYhgz2sI4452aiJkWDs49YLJzLj91otVfFQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GM1ABZihOo2cPpoDcUNgfXDF4+1IgkyJF4kbBCWkOT99PRC5pnz+GUeSgGUwDODeqU+t+EbjlfLsSdY6rmST9UQAEls2H1BM1w5M83qBDAoR7xxxr18njK3HapI5f+d81/vV/CjgMAFyEJLJlNzYPIBtHxUOFNqLGqcqu/guxMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnJSKYz6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnJSKYz6"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2dd020a2e44so2370105ad.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 01:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788942339; x=1789547139; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oN4ubroksXkxZcDoIYkNH4cJesg+gkdfrBspLR06Qkk=;
        b=NnJSKYz6IVGclzKuu7MKFI6EchBtGxX3WyZm8bLj6rVxFcoSvMFMGjaEWFvnFZAMWK
         jKCqpl8WLjUMpyJjSmuRxvFz4wGdb52bkOCXolkiGWkGaOc85yDcZZkk6Yr20azKXhpr
         +cpYenj/gg1OhzlI1zLmxmaI9DU1dHAhR97mZwlA1x29B2CXb5zAuP057wu7OWpTOVwg
         a5EBqv5gOeu4jUCuCgEuI4gtr0+pacR+joU16gRCT4IDQsDQ0cG4hQIiS42FKFgBeUF4
         eY9yN/F3Ouw8ooDkyUNg3r9DbBVDhx8FNIUVHHo5ZoiZKGYSs7ED2RclGGHSkNd16YPZ
         +16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788942339; x=1789547139;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oN4ubroksXkxZcDoIYkNH4cJesg+gkdfrBspLR06Qkk=;
        b=kdQ9f7bSBcPhmF/eKZoEMpn1V7XUplPUZKcaUkntQU2/gZkrDa1fuIjLZbotUzrY7S
         MZjMKtxctLDRi4+8N5gzBYi2lHIaOCKFCXxnaQJdS+xoBQfjo6mLZA9m3OQLNiFGai2W
         XoPQO+90lLXNnNCNRXMy1eg4/ottamWYKU/LLB0j0ndWWUi48fprl8bUUetygN/XjeZP
         vdP5BfOzGheYsTnYEZ+MhTFAjouPmkyvGlE1QVZnOWrGdCRUTP+EietiKjSJqFDl5M8j
         esnPfj0PEF7TaM7GuUzXDwafA85G4xX/Xb53cxeDfR1QQ/e2ql2O8i/oJiBD3OoTVB8q
         3noQ==
X-Gm-Message-State: AFuF++nr3acHF1V0lhg6fTzJ25AWDslmlrvM+LSKMUItyuLZPY2nTcxe
	GkGD175hemabbijfxfrtuTxsum+cgW5C+2iDJBdW0BpS+k1U3zJL3Dk17cjU8Q==
X-Gm-Gg: AYBFou33MRq4ucJhGDZtgx0NMbVhzRw4h2EeO7bNK8FK9iD1U4y+scoCQMZ3Rwljbqu
	699i8kmZEWAlDlHD8h0029bwRPqNXGJf+qLclGHcoj3xSAzaJAg7zGVqFH6E8cw/4mdkLZCyyVb
	46CvGO2el/vQakNAe4POy7IHvamL2a3EYXdj32d2CN/Q85CsdUsEcC7Ib+/g4xkY/dnnvfM38if
	LEsRu2EB9O08jSjGNWXni7onFwOhteI45rVJI9jrUvxquv7r67+mdbIUsH8G8RNTRH/SpLPpE50
	jArW28itjrK/Ys2yOhWkM7ab3b0htUc8+kVLbZDR+DosPBhajfceyrj6OsJEasuGHwb+ISmF8W4
	W+uzDZT1/+9BzRkQoidCGWSkUSnXCwlFZBavM4UYu2snfMoudTbiGdYRRHaiWwUPUZGYFkcF1BD
	xHNkVK+Q6Z3ecZQxXhujQWp216wVkQWmczu9kkN3/UZnsvEadkEb97uEp5Z0sW6NdOyjXNnB4=
X-Received: by 2002:a17:90b:274c:b0:398:9be9:ab92 with SMTP id 98e67ed59e1d1-39b2629b27fmr52758055a91.23.1788942338628;
        Wed, 09 Sep 2026 01:25:38 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.2.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b9f68e4sm45947636eec.24.2026.09.09.01.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:25:38 -0700 (PDT)
Message-Id: <031b3bd498bd5efee7e0d9752a6dd36fe7a55360.1788942331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.v4.git.1788942331.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
	<pull.2217.v4.git.1788942331.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 08:25:31 +0000
Subject: [PATCH v4 3/3] sequencer: disable auto maintenance in spawned
 commands
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

Sequencer-spawned commands like 'commit' and 'merge' run
background auto maintenance, which interferes with ongoing
operations (e.g. 'rerere gc' holding MERGE_RR.lock or repacks
deleting active packs).

Pass maintenance.auto=false via GIT_CONFIG_PARAMETERS to the
spawned commit, merge and exec commands. Appending it after the
user's own settings ensures it wins, and the environment reaches
whatever they spawn in turn.

Auto maintenance now runs exactly once when the sequence
completes. Commands run manually by the user while stopped are
unaffected and continue to run auto maintenance normally.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 sequencer.c                     | 38 ++++++++++++++++++++++++++++++---
 t/t3418-rebase-continue.sh      | 11 +++++++---
 t/t3510-cherry-pick-sequence.sh | 14 +++++++++---
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..e99ef09f02 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -234,6 +234,11 @@ struct replay_ctx {
 	 * Whether message contains a commit message.
 	 */
 	unsigned have_message :1;
+	/*
+	 * GIT_CONFIG_PARAMETERS for the commands we spawn, with auto
+	 * maintenance turned off. Built on first use.
+	 */
+	char *config_parameters;
 };
 
 struct replay_ctx* replay_ctx_new(void)
@@ -407,6 +412,7 @@ static void replay_ctx_release(struct replay_ctx *ctx)
 {
 	strbuf_release(&ctx->current_fixups);
 	strbuf_release(&ctx->message);
+	free(ctx->config_parameters);
 }
 
 void replay_opts_release(struct replay_opts *opts)
@@ -1107,6 +1113,27 @@ static int run_command_silent_on_success(struct child_process *cmd)
 	return rc;
 }
 
+/*
+ * Don't let the commands we spawn run auto maintenance. It would race
+ * us for MERGE_RR.lock or delete packs we still have open. Our caller
+ * runs it once the sequence is done.
+ */
+static void disable_auto_maintenance(struct replay_opts *opts,
+				     struct child_process *cmd)
+{
+	if (!opts->ctx->config_parameters) {
+		const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
+		struct strbuf buf = STRBUF_INIT;
+
+		if (old && *old)
+			strbuf_addstr(&buf, old);
+		git_config_append_parameter(&buf, "maintenance.auto", "false");
+		opts->ctx->config_parameters = strbuf_detach(&buf, NULL);
+	}
+	strvec_pushf(&cmd->env, "%s=%s", CONFIG_DATA_ENVIRONMENT,
+		     opts->ctx->config_parameters);
+}
+
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
@@ -1148,6 +1175,7 @@ static int run_git_commit(const char *defmsg,
 			     author_date_from_env(&cmd.env));
 	if (opts->ignore_date)
 		strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
+	disable_auto_maintenance(opts, &cmd);
 
 	strvec_push(&cmd.args, "commit");
 
@@ -3924,16 +3952,18 @@ static int error_failed_squash(struct repository *r,
 	return error_with_patch(r, commit, subject, subject_len, opts, 1, 1);
 }
 
-static int do_exec(struct repository *r, const char *command_line, int quiet)
+static int do_exec(struct repository *r, const char *command_line,
+		   struct replay_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int dirty, status;
 
-	if (!quiet)
+	if (!opts->quiet)
 		fprintf(stderr, _("Executing: %s\n"), command_line);
 	cmd.use_shell = 1;
 	strvec_push(&cmd.args, command_line);
 	strvec_push(&cmd.env, "GIT_CHERRY_PICK_HELP");
+	disable_auto_maintenance(opts, &cmd);
 	status = run_command(&cmd);
 
 	/* force re-reading of the cache */
@@ -4342,6 +4372,7 @@ static int do_merge(struct repository *r,
 				     author_date_from_env(&cmd.env));
 		if (opts->ignore_date)
 			strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
+		disable_auto_maintenance(opts, &cmd);
 
 		cmd.git_cmd = 1;
 		strvec_push(&cmd.args, "merge");
@@ -5158,7 +5189,7 @@ static int pick_commits(struct repository *r,
 			if (!opts->verbose)
 				term_clear_line();
 			*end_of_arg = '\0';
-			res = do_exec(r, arg, opts->quiet);
+			res = do_exec(r, arg, opts);
 			*end_of_arg = saved;
 
 			if (res) {
@@ -5329,6 +5360,7 @@ static int continue_single_pick(struct repository *r, struct replay_opts *opts)
 		return error(_("no cherry-pick or revert in progress"));
 
 	cmd.git_cmd = 1;
+	disable_auto_maintenance(opts, &cmd);
 	strvec_push(&cmd.args, "commit");
 
 	/*
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 025787b5f2..16def261b0 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -398,13 +398,18 @@ test_orig_head --merge
 test_expect_success 'rebase runs auto maintenance once it is done' '
 	git checkout -b auto-maintenance topic &&
 	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
-		git rebase -x false main &&
+		git rebase -x "git commit --allow-empty -m exec && false" main &&
 	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
 	echo resolved >F2 &&
 	git add F2 &&
-	test_must_fail git rebase --continue &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
+		git rebase --continue &&
+	test_subcommand_flex git commit <mid.txt &&
+	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/end.txt" git rebase --continue &&
-	test_subcommand_flex git maintenance run --auto <end.txt
+	test_subcommand_flex git maintenance run --auto <end.txt &&
+	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
+	test_line_count = 1 maintenance
 '
 
 test_done
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 2bea55c3b6..1e3fa1803c 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -723,8 +723,11 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
 
 test_expect_success 'cherry-pick runs auto maintenance once it is done' '
 	pristine_detach base &&
-	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick picked &&
+	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick --edit picked &&
+	test_subcommand_flex git commit <single.txt &&
 	test_subcommand_flex git maintenance run --auto <single.txt &&
+	grep "\"child_start\".*\"maintenance\"" single.txt >maintenance &&
+	test_line_count = 1 maintenance &&
 	GIT_TRACE2_EVENT="$(pwd)/sequence.txt" \
 		git cherry-pick anotherpick yetanotherpick &&
 	test_subcommand_flex git maintenance run --auto <sequence.txt &&
@@ -739,9 +742,14 @@ test_expect_success 'cherry-pick runs auto maintenance once a stopped sequence i
 	test_subcommand_flex ! git maintenance run --auto <stop.txt &&
 	echo resolved >foo &&
 	git add foo &&
-	test_must_fail git cherry-pick --continue &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
+		git cherry-pick --continue &&
+	test_subcommand_flex git commit <mid.txt &&
+	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/end.txt" git cherry-pick --skip &&
-	test_subcommand_flex git maintenance run --auto <end.txt
+	test_subcommand_flex git maintenance run --auto <end.txt &&
+	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
+	test_line_count = 1 maintenance
 '
 
 test_done
-- 
gitgitgadget
