Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646A220248
	for <e@80x24.org>; Tue, 16 Apr 2019 10:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfDPKSv (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 06:18:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52858 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfDPKSv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 06:18:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so24607802wma.2
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=+gHGWD9SuswT4U3a2aQ9IFC4ovD9X1Pa41eHChHPR8o=;
        b=s6ptRWwNsUN8+Ga4qs+3+hbJ/nLfPFK2hccgmMM207Di/PJL+rXvVU9r6WUe5HUkC2
         RkCUE6YQ1vr27EA/jidSi9Zi4so316mLJJ8VsmcnjuuozKHN5gAsn/chctVGAEC0Ziz8
         dU//FhxJ8MHr/lNxtU4/Sc/o7SQApLypDVqHEHtvFjX/eUIM45hn87N0zpd2V56TSyCS
         EaE/v95wQvu1KzNEwiOmx+1NjaaHpqMOBiB/T+wb2BpLf1rXZPiFf61B7xuagZwJeai7
         08KsqR78yOWtUMoVqRC8Q6RHmi/dH9ADlVZ4tHiFdILuaBDpoRNXk47wSj9fdIaga1j7
         yAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=+gHGWD9SuswT4U3a2aQ9IFC4ovD9X1Pa41eHChHPR8o=;
        b=lZNNUPZtZzrXCk3TbuPtEUnU1ZOsAipf4//DlPOFxVXc4NM2k1vyGrs/aTcg3/8Hwx
         DCBeMJGjkaQuxYHFHsVU9L+jH8bqnBUqRm8MrDDYcFu2+VEsW+iockQxTEYPiDI2K6G1
         DS+bRB8jUbbevGZZ2T0rbqxPC6xCRIUEWSm5T5Jz4zKo+TVod/qZlXmpByotjwX7R2HI
         dQAVfDp/Qi2emrFJXjKJofG8bAzIYtOG0mfGx5I52hmIx0sB6ygh+JZMJh/0tF90i4uh
         iyt96MUO+5WS27+KyKqll08lYNOxkDoH+CSp1yIwW8bk1qLaqcMUWa89feSSavwglv3E
         GUbw==
X-Gm-Message-State: APjAAAVQKw4+r0uycfIJfT2eNNyaPzWS3t0FykOI7+PZ5ysgjrqVs10c
        6RarNV0s3eF/aMk6CT2xCaoGTLzMwHU=
X-Google-Smtp-Source: APXvYqz7K1d4P+aeJF+mDk0x++MI4s+ecez7EHUTL+jIzoLw5FXTcuJGh6hgGpFR+N4Mtpx1OBZLKQ==
X-Received: by 2002:a7b:c769:: with SMTP id x9mr26913957wmk.103.1555409929303;
        Tue, 16 Apr 2019 03:18:49 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id t74sm3220118wmt.3.2019.04.16.03.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 03:18:48 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/2] A couple of cherry-pick related fixes
Date:   Tue, 16 Apr 2019 11:18:40 +0100
Message-Id: <20190416101842.16556-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329163009.493-1-phillip.wood123@gmail.com>
References: <20190329163009.493-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've updated the first patch as per Junio's suggestions and added
tests for revert as well as cherry-pick. I've also changed the second
patch to avoid printing the oid of the origin of the commit that's
just been created and added tests for revert as well as
cherry-pick. In the end I didn't add any messages when we remove
.git/sequencer as we don't say anything when we remove
CHERRY_PICK_HEAD at the moment. Duy mentioned this, I could add this
if there is a strong demand for it.

Phillip Wood (2):
  commit/reset: try to clean up sequencer state
  fix cherry-pick/revert status after commit

 branch.c                        |  4 +-
 builtin/commit.c                |  3 +-
 sequencer.c                     | 86 +++++++++++++++++++++++++++++++++
 sequencer.h                     |  3 ++
 t/t3507-cherry-pick-conflict.sh | 39 +++++++++++++++
 t/t7512-status-help.sh          | 36 ++++++++++++++
 wt-status.c                     | 39 +++++++++++++--
 7 files changed, 201 insertions(+), 9 deletions(-)

Range-diff against v1:
1:  9b310618ed ! 1:  e963e02628 commit/reset: try to clean up sequencer state
    @@ -32,10 +32,7 @@
      {
     -	unlink(git_path_cherry_pick_head(r));
     -	unlink(git_path_revert_head(r));
    -+	if (!unlink(git_path_cherry_pick_head(r)))
    -+		sequencer_post_commit_cleanup();
    -+	if (!unlink(git_path_revert_head(r)))
    -+		sequencer_post_commit_cleanup();
    ++	sequencer_post_commit_cleanup(r);
      	unlink(git_path_merge_head(r));
      	unlink(git_path_merge_rr(r));
      	unlink(git_path_merge_msg(r));
    @@ -49,21 +46,10 @@
      
     -	unlink(git_path_cherry_pick_head(the_repository));
     -	unlink(git_path_revert_head(the_repository));
    -+	if (!unlink(git_path_cherry_pick_head(the_repository)))
    -+		sequencer_post_commit_cleanup();
    -+	if (!unlink(git_path_revert_head(the_repository)))
    -+		sequencer_post_commit_cleanup();
    ++	sequencer_post_commit_cleanup(the_repository);
      	unlink(git_path_merge_head(the_repository));
      	unlink(git_path_merge_msg(the_repository));
      	unlink(git_path_merge_mode(the_repository));
    -@@
    - 	if (amend && !no_post_rewrite) {
    - 		commit_post_rewrite(the_repository, current_head, &oid);
    - 	}
    -+
    - 	if (!quiet) {
    - 		unsigned int flags = 0;
    - 
     
      diff --git a/sequencer.c b/sequencer.c
      --- a/sequencer.c
    @@ -72,27 +58,55 @@
      	return len;
      }
      
    -+void sequencer_post_commit_cleanup(void)
    ++static int have_finished_the_last_pick(void)
     +{
    -+	struct replay_opts opts = REPLAY_OPTS_INIT;
     +	struct strbuf buf = STRBUF_INIT;
     +	const char *eol;
     +	const char *todo_path = git_path_todo_file();
    ++	int ret = 0;
     +
     +	if (strbuf_read_file(&buf, todo_path, 0) < 0) {
     +		if (errno == ENOENT) {
    -+			return;
    ++			return 0;
     +		} else {
     +			error_errno("unable to open '%s'", todo_path);
    -+			return;
    ++			return 0;
     +		}
     +	}
     +	/* If there is only one line then we are done */
     +	eol = strchr(buf.buf, '\n');
     +	if (!eol || !eol[1])
    -+		sequencer_remove_state(&opts);
    ++		ret = 1;
     +
     +	strbuf_release(&buf);
    ++
    ++	return ret;
    ++}
    ++
    ++void sequencer_post_commit_cleanup(struct repository *r)
    ++{
    ++	struct replay_opts opts = REPLAY_OPTS_INIT;
    ++	int need_cleanup = 0;
    ++
    ++	if (file_exists(git_path_cherry_pick_head(r))) {
    ++		unlink(git_path_cherry_pick_head(r));
    ++		opts.action = REPLAY_PICK;
    ++		need_cleanup = 1;
    ++	}
    ++
    ++	if (file_exists(git_path_revert_head(r))) {
    ++		unlink(git_path_revert_head(r));
    ++		opts.action = REPLAY_REVERT;
    ++		need_cleanup = 1;
    ++	}
    ++
    ++	if (!need_cleanup)
    ++		return;
    ++
    ++	if (!have_finished_the_last_pick())
    ++		return;
    ++
    ++	sequencer_remove_state(&opts);
     +}
     +
      static int read_populate_todo(struct repository *r,
    @@ -106,7 +120,7 @@
      void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
      int write_basic_state(struct replay_opts *opts, const char *head_name,
      		      const char *onto, const char *orig_head);
    -+void sequencer_post_commit_cleanup(void);
    ++void sequencer_post_commit_cleanup(struct repository *r);
     
      diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
      --- a/t/t3507-cherry-pick-conflict.sh
    @@ -115,7 +129,7 @@
      
      	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
      '
    -+test_expect_success 'successful final commit clears sequencer state' '
    ++test_expect_success 'successful final commit clears cherry-pick state' '
     +	pristine_detach initial &&
     +
     +	test_must_fail git cherry-pick base picked-signed &&
    @@ -125,7 +139,7 @@
     +	test_must_fail test_path_exists .git/sequencer
     +'
     +
    -+test_expect_success 'reset after final pick clears sequencer state' '
    ++test_expect_success 'reset after final pick clears cherry-pick state' '
     +	pristine_detach initial &&
     +
     +	test_must_fail git cherry-pick base picked-signed &&
    @@ -137,3 +151,30 @@
      
      test_expect_success 'failed cherry-pick produces dirty index' '
      	pristine_detach initial &&
    +@@
    + 	test_cmp_rev picked REVERT_HEAD
    + '
    + 
    ++test_expect_success 'successful final commit clears revert state' '
    ++       pristine_detach picked-signed &&
    ++
    ++       test_must_fail git revert picked-signed base &&
    ++       echo resolved >foo &&
    ++       test_path_is_file .git/sequencer/todo &&
    ++       git commit -a &&
    ++       test_must_fail test_path_exists .git/sequencer
    ++'
    ++
    ++test_expect_success 'reset after final pick clears revert state' '
    ++       pristine_detach picked-signed &&
    ++
    ++       test_must_fail git revert picked-signed base &&
    ++       echo resolved >foo &&
    ++       test_path_is_file .git/sequencer/todo &&
    ++       git reset &&
    ++       test_must_fail test_path_exists .git/sequencer
    ++'
    ++
    + test_expect_success 'revert conflict, diff3 -m style' '
    + 	pristine_detach initial &&
    + 	git config merge.conflictstyle diff3 &&
2:  edb1bfb3d6 ! 2:  ee7db0cfe0 fix cherry-pick/revert status after commit
    @@ -2,9 +2,9 @@
     
         fix cherry-pick/revert status after commit
     
    -    If the user commits a conflict resolution using 'git commit' during a
    -    sequence of picks then 'git status' missed the fact that a
    -    cherry-pick/revert is still in progress.
    +    If the user commits a conflict resolution using `git commit` in the
    +    middle of a sequence of cherry-picks/reverts then `git status` missed
    +    the fact that a cherry-pick/revert is still in progress.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
    @@ -15,8 +15,7 @@
      	return !item->commit;
      }
      
    -+int sequencer_get_last_command(struct repository *r, enum replay_action *action,
    -+			       struct object_id *oid)
    ++int sequencer_get_last_command(struct repository *r, enum replay_action *action)
     +{
     +	struct todo_item item;
     +	char *eol;
    @@ -43,7 +42,6 @@
     +	else
     +		goto fail;
     +
    -+	oidcpy(oid, &item.commit->object.oid);
     +	ret = 0;
     +
     + fail:
    @@ -62,9 +60,9 @@
     @@
      int write_basic_state(struct replay_opts *opts, const char *head_name,
      		      const char *onto, const char *orig_head);
    - void sequencer_post_commit_cleanup(void);
    -+int sequencer_get_last_command(struct repository* r, enum replay_action *action,
    -+			       struct object_id *oid);
    + void sequencer_post_commit_cleanup(struct repository *r);
    ++int sequencer_get_last_command(struct repository* r,
    ++			       enum replay_action *action);
     
      diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
      --- a/t/t7512-status-help.sh
    @@ -77,13 +75,12 @@
     +	git reset --hard cherry_branch &&
     +	test_when_finished "git cherry-pick --abort" &&
     +	test_must_fail git cherry-pick cherry_branch_second one_cherry &&
    -+	TO_CHERRY_PICK=$(git rev-parse --short CHERRY_PICK_HEAD) &&
     +	echo end >main.txt &&
     +	git commit -a &&
     +	cat >expected <<EOF &&
     +On branch cherry_branch
    -+You are currently cherry-picking commit $TO_CHERRY_PICK.
    -+  (all conflicts fixed: run "git cherry-pick --continue")
    ++Cherry-pick currently in progress.
    ++  (run "git cherry-pick --continue" to continue)
     +  (use "git cherry-pick --abort" to cancel the cherry-pick operation)
     +
     +nothing to commit (use -u to show untracked files)
    @@ -95,6 +92,31 @@
      test_expect_success 'status showing detached at and from a tag' '
      	test_commit atag tagging &&
      	git checkout atag &&
    +@@
    + 	test_i18ncmp expected actual
    + '
    + 
    ++test_expect_success 'status while reverting after committing conflict resolution' '
    ++	test_when_finished "git revert --abort" &&
    ++	git reset --hard new &&
    ++	test_must_fail git revert old new &&
    ++	echo reverted >to-revert.txt &&
    ++	git commit -a &&
    ++	cat >expected <<EOF &&
    ++On branch master
    ++Revert currently in progress.
    ++  (run "git revert --continue" to continue)
    ++  (use "git revert --abort" to cancel the revert operation)
    ++
    ++nothing to commit (use -u to show untracked files)
    ++EOF
    ++	git status --untracked-files=no >actual &&
    ++	test_i18ncmp expected actual
    ++'
    ++
    + test_expect_success 'prepare for different number of commits rebased' '
    + 	git reset --hard master &&
    + 	git checkout -b several_commits &&
     
      diff --git a/wt-status.c b/wt-status.c
      --- a/wt-status.c
    @@ -107,6 +129,55 @@
      
      static const char cut_line[] =
      "------------------------ >8 ------------------------\n";
    +@@
    + static void show_cherry_pick_in_progress(struct wt_status *s,
    + 					 const char *color)
    + {
    +-	status_printf_ln(s, color, _("You are currently cherry-picking commit %s."),
    +-			find_unique_abbrev(&s->state.cherry_pick_head_oid, DEFAULT_ABBREV));
    ++	if (is_null_oid(&s->state.cherry_pick_head_oid))
    ++		status_printf_ln(s, color,
    ++			_("Cherry-pick currently in progress."));
    ++	else
    ++		status_printf_ln(s, color,
    ++			_("You are currently cherry-picking commit %s."),
    ++			find_unique_abbrev(&s->state.cherry_pick_head_oid,
    ++					   DEFAULT_ABBREV));
    ++
    + 	if (s->hints) {
    + 		if (has_unmerged(s))
    + 			status_printf_ln(s, color,
    + 				_("  (fix conflicts and run \"git cherry-pick --continue\")"));
    ++		else if (is_null_oid(&s->state.cherry_pick_head_oid))
    ++			status_printf_ln(s, color,
    ++				_("  (run \"git cherry-pick --continue\" to continue)"));
    + 		else
    + 			status_printf_ln(s, color,
    + 				_("  (all conflicts fixed: run \"git cherry-pick --continue\")"));
    +@@
    + static void show_revert_in_progress(struct wt_status *s,
    + 				    const char *color)
    + {
    +-	status_printf_ln(s, color, _("You are currently reverting commit %s."),
    +-			 find_unique_abbrev(&s->state.revert_head_oid, DEFAULT_ABBREV));
    ++	if (is_null_oid(&s->state.revert_head_oid))
    ++		status_printf_ln(s, color,
    ++			_("Revert currently in progress."));
    ++	else
    ++		status_printf_ln(s, color,
    ++			_("You are currently reverting commit %s."),
    ++			find_unique_abbrev(&s->state.revert_head_oid,
    ++					   DEFAULT_ABBREV));
    + 	if (s->hints) {
    + 		if (has_unmerged(s))
    + 			status_printf_ln(s, color,
    + 				_("  (fix conflicts and run \"git revert --continue\")"));
    ++		else if (is_null_oid(&s->state.revert_head_oid))
    ++			status_printf_ln(s, color,
    ++				_("  (run \"git revert --continue\" to continue)"));
    + 		else
    + 			status_printf_ln(s, color,
    + 				_("  (all conflicts fixed: run \"git revert --continue\")"));
     @@
      {
      	struct stat st;
    @@ -120,13 +191,13 @@
      		oidcpy(&state->revert_head_oid, &oid);
      	}
     -
    -+	if (!sequencer_get_last_command(r, &action, &oid)) {
    ++	if (!sequencer_get_last_command(r, &action)) {
     +		if (action == REPLAY_PICK) {
     +			state->cherry_pick_in_progress = 1;
    -+			oidcpy(&state->cherry_pick_head_oid, &oid);
    ++			oidcpy(&state->cherry_pick_head_oid, &null_oid);
     +		} else {
     +			state->revert_in_progress = 1;
    -+			oidcpy(&state->revert_head_oid, &oid);
    ++			oidcpy(&state->revert_head_oid, &null_oid);
     +		}
     +	}
      	if (get_detached_from)
--
2.21.0

