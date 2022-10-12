Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E3EC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJLJfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJLJfS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:35:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E623B727
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b4so25393978wrs.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Vs9/BgekW42B2KT13h7dukeeQ3kthly3gT7JySaOCI=;
        b=lJ+TmGzgYEl1471TDgRT1ZhePLGZxy3TY6zqLly4Ko5ZyLuEcmnAdNj3dzpuP8/KIR
         ZK37cD1NSvWwXHeqShWk2C+Ge+QgitZKevaGhP2FWniNxX4dcTulQlh0lnQ/ktP3c4ZX
         Mbr2bCR80RaOe2jP+kHBgo5YTyB9sppSPzjyEjaFz3RB0deYTAjVRBmozEq8h1nv5Xn+
         2hlnS/dM+TZvNWcZ7jk2b/ZM/fNZJbbgpAW10HCfSeNMm7JOgQq03zCuj9rRxD/SjTFw
         YfFCC8VpkVn7Gcds+YeSoH6SIKouE9SOiSSSaKJegDmjdeCjuARclv5sbBIyk5NU0GJh
         qGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Vs9/BgekW42B2KT13h7dukeeQ3kthly3gT7JySaOCI=;
        b=xfeEeaVVS8T0iJp5CANPM3yU2QylkUMJLlX4ghbAHKIjf99V+0mBCGih8z6C+vh5Og
         JqGyo+wo26K+e9WghMQ10ctfsLxK7IEt0l1DjUsmSGe4ipf8j7GYB3lmlDKxx+IIbjSr
         S2qNsjyD+4/HAj87NQVhHYMCm8HrWQEyN5BgRgh+uXT/e7r84nirjlbFoZxDpfOt26+K
         pMW0pDTxZPcf7COBh6qj+8cVyVyXEYUFQRw6nUMSP44JMY/B/FgwLXLWovPH2QEBovXg
         FPdyD3dHIyvmgoZ1HiGPMVr6T+YGF2RSISGHXlwB55NKCwLdbpapg82K1wIWYy6ZCy9u
         B6Jw==
X-Gm-Message-State: ACrzQf1jSt2uP/NLbPSaIVUcbvPJ3xNzH2xMqKfHEz4CAbyAy0ihVfir
        y9fnL0pA94DZ1qikE2xm6SVfelCsbhM=
X-Google-Smtp-Source: AMsMyM7WD6uZoahQKB64OuT1n1TlP6krC7/EnT3MWfGKSJhSwdqdNIHN4jkBEDga0ka3gZRchbOgSw==
X-Received: by 2002:a5d:54ce:0:b0:22e:2ecf:7c2a with SMTP id x14-20020a5d54ce000000b0022e2ecf7c2amr17398093wrv.181.1665567314013;
        Wed, 12 Oct 2022 02:35:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5-20020adff005000000b002206203ed3dsm13115575wro.29.2022.10.12.02.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:35:13 -0700 (PDT)
Message-Id: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 09:35:04 +0000
Subject: [PATCH v3 0/8] rebase: make reflog messages independent of the backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes some bugs in the reflog messages when rebasing and changes
the reflog messages of "rebase --apply" to match "rebase --merge" with the
aim of making the reflog easier to parse.

Thanks to everyone who commented on V2, I've added the review club
participants that I've got address for to the cc list. I've rebased onto
pw/rebase-keep-base-fixes.

Change since V2:

 * Patch 1: Reworded the commit message to address the concerns in [1,2]
   about the behavior when head_name is NULL. There is also a small change
   due to being rebased.

 * Patch 2: Unchanged. There wasn't much love for parameterized tests in
   review club but we want to ensure both backends produce the same messages
   I think this is the safest way to achieve that. Using separate tests
   makes it too easy to introduce subtle differences in the testing of the
   two backends.

 * Patch 3: Added a note to the commit message to address the concerns in
   [1] about not resetting GIT_REFLOG_ACTION when we return early.

 * Patches 4 & 5: Unchanged.

 * Patch 6: Reworded the commit message to make a stronger argument for this
   change. There are concerns about backwards compatibility in [1,3,4] but
   (i) we have made similar changes in the past without complaints and (ii)
   we're changing the message to an existing format. There is also a small
   change due to being rebased.

 * Patches 7 & 8: Small changes due to rebase.

[1]
https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w/edit?pli=1#heading=h.t6g5l2t5ibzw
[2] https://lore.kernel.org/git/xmqq35i7r4rj.fsf@gitster.g/ [3]
https://lore.kernel.org/git/xmqq4k2nmmeg.fsf@gitster.g/ [4]
https://lore.kernel.org/git/220420.865yn4833u.gmgdl@evledraar.gmail.com/

V2 Cover Letter:

Thanks to Christian and Elijah for their comments on V1.

I've updated commit message for patch 1 to try and be clearer about the
removal of a call to strbuf_release() and spilt out the test changes from
the old patch 2 into a separate preparatory patch.

V1 Cover Letter:

This is a series of rebase reflog related patches with the aim of unifying
the reflog messages from the two rebase backends.

 * improve rebase reflog test coverage
 * rebase --merge: fix reflog messages for --continue and --skip
 * rebase --apply: respect GIT_REFLOG_ACTION
 * rebase --abort: improve reflog message
 * unify reflog messages between the two rebase backends

This series is based on pw/use-inprocess-checkout-in-rebase

Phillip Wood (8):
  rebase --apply: remove duplicated code
  t3406: rework rebase reflog tests
  rebase --merge: fix reflog when continuing
  rebase --merge: fix reflog message after skipping
  rebase --apply: respect GIT_REFLOG_ACTION
  rebase --apply: make reflog messages match rebase --merge
  rebase --abort: improve reflog message
  rebase: cleanup action handling

 builtin/rebase.c          | 146 ++++++++++++------------------
 sequencer.c               |   5 ++
 t/t3406-rebase-message.sh | 185 +++++++++++++++++++++++++++++++-------
 3 files changed, 215 insertions(+), 121 deletions(-)


base-commit: 0203c679871112c78adc6428a8ed6c04c30ccad9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1150%2Fphillipwood%2Fwip%2Frebase-reflog-fixes-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1150/phillipwood/wip/rebase-reflog-fixes-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1150

Range-diff vs v2:

 1:  a4320f2fcf3 ! 1:  a84cf971a75 rebase --apply: remove duplicated code
     @@ Metadata
       ## Commit message ##
          rebase --apply: remove duplicated code
      
     -    When we are reattaching HEAD after a fast-forward we can use
     -    move_to_original_branch() rather than open coding a copy of that
     -    code. The old code appears to handle the case where the rebase is
     -    started from a detached HEAD but in fact in that case there is nothing
     -    to do as we have already updated HEAD.
     +    Use move_to_original_branch() when reattaching HEAD after a fast-forward
     +    rather than open coding a copy of that code. move_to_original_branch()
     +    does not call reset_head() if head_name is NULL but there should be no
     +    user visible changes even though we currently call reset_head() in that
     +    case. The reason for this is that the reset_head() call does not add a
     +    message to the reflog because we're not changing the commit that HEAD
     +    points to and so lock_ref_for_update() elides the update. When head_name
     +    is not NULL then reset_head() behaves like "git symbolic-ref" and so the
     +    reflog is updated.
      
          Note that the removal of "strbuf_release(&msg)" is safe as there is an
          identical call just above this hunk which can be seen by viewing the
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       	 * we just fast-forwarded.
       	 */
      -	strbuf_reset(&msg);
     - 	if (oideq(&merge_base, &options.orig_head)) {
     + 	if (oideq(&branch_base, &options.orig_head->object.oid)) {
       		printf(_("Fast-forwarded %s to %s.\n"),
       			branch_name, options.onto_name);
      -		strbuf_addf(&msg, "rebase finished: %s onto %s",
 2:  0904b50a377 = 2:  b9255ad35d2 t3406: rework rebase reflog tests
 3:  6c15f00e170 ! 3:  ea4da25a19c rebase --merge: fix reflog when continuing
     @@ Commit message
          in pick_commits(). Both of these will be fixed in a future series that
          stops the sequencer calling setenv().
      
     +    If we fail to commit the staged changes then we error out so
     +    GIT_REFLOG_ACTION does not need to be reset in that case.
     +
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## builtin/rebase.c ##
 4:  d3afa85ffc5 = 4:  225ff4baef7 rebase --merge: fix reflog message after skipping
 5:  afa67abe01a = 5:  1094681eb11 rebase --apply: respect GIT_REFLOG_ACTION
 6:  95161f21e00 ! 6:  a5338e6bdd8 rebase --apply: make reflog messages match rebase --merge
     @@ Commit message
          rebase --apply: make reflog messages match rebase --merge
      
          The apply backend creates slightly different reflog messages to the
     -    merge backend when starting and finishing a rebase and when picking
     -    commits. The choice of backend is really an implementation detail so
     -    it is confusing to have the same command create different messages
     -    depending on which backend is selected. Change the apply backend so
     -    the reflog messages from the two backends match as closely as
     -    possible. Note that there is still a difference when committing a
     -    conflict resolution - the merge backend will use "(continue)" rather
     -    than "(pick)" in that case as it does not know which command created
     -    the conflict that it is committing.
     +    merge backend when starting or finishing a rebase and when picking
     +    commits. These differences make it harder than it needs to be to parse
     +    the reflog (I have a script that reads the finishing messages from
     +    rebase and it is a pain to have to accommodate two different message
     +    formats). While it is possible to determine the backend used for a
     +    rebase from the reflog messages, the differences are not designed for
     +    that purpose. c2417d3af7 (rebase: drop '-i' from the reflog for
     +    interactive-based rebases, 2020-02-15) removed the clear distinction
     +    between the reflog messages of the two backends without complaint.
     +
     +    As the merge backend is the default it is likely to be the format most
     +    common in existing reflogs. For that reason the apply backend is changed
     +    to format its reflog messages to match the merge backend as closely as
     +    possible. Note that there is still a difference as when committing a
     +    conflict resolution the apply backend will use "(pick)" rather than
     +    "(continue)" because it is not currently possible to change the message
     +    for a single commit.
     +
     +    In addition to c2417d3af7 we also changed the reflog messages in
     +    68aa495b59 (rebase: implement --merge via the interactive machinery,
     +    2018-12-11) and 2ac0d6273f (rebase: change the default backend from "am"
     +    to "merge", 2020-02-15). This commit makes the same change to "git
     +    rebase --apply" that 2ac0d6273f made to "git rebase" without any backend
     +    specific options. As the messages are changed to use an existing format
     +    any scripts that can parse the reflog messages of the default rebase
     +    backend should be unaffected by this change.
     +
     +    There are existing tests for the messages from both backends which are
     +    adjusted to ensure that they do not get out of sync in the future.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ builtin/rebase.c: static int run_am(struct rebase_options *opts)
       	am.git_cmd = 1;
       	strvec_push(&am.args, "am");
      -
     -+	strvec_pushf(&am.env_array, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",
     ++	strvec_pushf(&am.env, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",
      +		     getenv(GIT_REFLOG_ACTION_ENVIRONMENT));
       	if (opts->action && !strcmp("continue", opts->action)) {
       		strvec_push(&am.args, "--resolved");
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      +	strbuf_addf(&msg, "%s (start): checkout %s",
       		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
       	ropts.oid = &options.onto->object.oid;
     - 	ropts.orig_head = &options.orig_head,
     + 	ropts.orig_head = &options.orig_head->object.oid,
      
       ## t/t3406-rebase-message.sh ##
      @@ t/t3406-rebase-message.sh: test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
 7:  d2c1dfbcd5e ! 7:  aa808725fb8 rebase --abort: improve reflog message
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      +		strbuf_addf(&head_msg, "%s (abort): returning to %s",
      +			    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
      +			    options.head_name ? options.head_name
     -+					      : oid_to_hex(&options.orig_head));
     - 		ropts.oid = &options.orig_head;
     ++					      : oid_to_hex(&options.orig_head->object.oid));
     + 		ropts.oid = &options.orig_head->object.oid;
      +		ropts.head_msg = head_msg.buf;
       		ropts.branch = options.head_name;
       		ropts.flags = RESET_HEAD_HARD;
      -		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
       		if (reset_head(the_repository, &ropts) < 0)
       			die(_("could not move back to %s"),
     - 			    oid_to_hex(&options.orig_head));
     + 			    oid_to_hex(&options.orig_head->object.oid));
      
       ## t/t3406-rebase-message.sh ##
      @@ t/t3406-rebase-message.sh: test_reflog () {
 8:  b0d21affa78 ! 8:  f9c8664b883 rebase: cleanup action handling
     @@ builtin/rebase.c: static int run_sequencer_rebase(struct rebase_options *opts,
       	return ret;
      @@ builtin/rebase.c: static int run_am(struct rebase_options *opts)
       	strvec_push(&am.args, "am");
     - 	strvec_pushf(&am.env_array, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",
     + 	strvec_pushf(&am.env, GIT_REFLOG_ACTION_ENVIRONMENT "=%s (pick)",
       		     getenv(GIT_REFLOG_ACTION_ENVIRONMENT));
      -	if (opts->action && !strcmp("continue", opts->action)) {
      +	if (opts->action == ACTION_CONTINUE) {
     @@ builtin/rebase.c: static int run_specific_rebase(struct rebase_options *opts, en
       	else
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       	struct strbuf buf = STRBUF_INIT;
     - 	struct object_id merge_base;
     + 	struct object_id branch_base;
       	int ignore_whitespace = 0;
      -	enum action action = ACTION_NONE;
       	const char *gpg_sign = NULL;
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       			    ACTION_SHOW_CURRENT_PATCH),
       		OPT_CALLBACK_F(0, "apply", &options, NULL,
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 	if (preserve_merges_selected)
     - 		die(_("--preserve-merges was replaced by --rebase-merges"));
     + 	} else if (is_directory(merge_dir())) {
     + 		strbuf_reset(&buf);
     + 		strbuf_addf(&buf, "%s/rewritten", merge_dir());
     +-		if (!(action == ACTION_ABORT) && is_directory(buf.buf)) {
     ++		if (!(options.action == ACTION_ABORT) && is_directory(buf.buf)) {
     + 			die(_("`rebase --preserve-merges` (-p) is no longer supported.\n"
     + 			"Use `git rebase --abort` to terminate current rebase.\n"
     + 			"Or downgrade to v2.33, or earlier, to complete the rebase."));
     +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 			"Note: Your `pull.rebase` configuration may also be set to 'preserve',\n"
     + 			"which is no longer supported; use 'merges' instead"));
       
      -	if (action != ACTION_NONE && total_argc != 2) {
      +	if (options.action != ACTION_NONE && total_argc != 2) {
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       	}
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
       	if (options.root && options.fork_point > 0)
     - 		die(_("cannot combine '--root' with '--fork-point'"));
     + 		die(_("options '%s' and '%s' cannot be used together"), "--root", "--fork-point");
       
      -	if (action != ACTION_NONE && !in_progress)
      +	if (options.action != ACTION_NONE && !in_progress)

-- 
gitgitgadget
