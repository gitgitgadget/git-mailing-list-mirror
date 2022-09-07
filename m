Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F80C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiIGOh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGOh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:37:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CFB7697E
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:37:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so9643707wmb.4
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Do8pv0Vpgzmsl33t7UwdTkGnHPp1TrHWFp3cK5q3Vzw=;
        b=KiPW3ECnHf7fFBlW3CVQGI7uD6iaBWUFT5nqVZKYoLk5UwlrDZ0g+76j8Gj2rTWeYB
         PiY9KDTbveeDEQHEzFFh50BLm5omfLyblDdgvhO2hkmUeBk6cH53ADU8NNTQEvjwtA5+
         PVNGY0w9MZBtGEV6yV4SdLDhcC5YkTddyo6nHdmQW+oNXewT6OjPRsA5d53C3DVwjMXd
         5JUqgfmi6czrtCHTKDkjE5k6ivSnhATvPt75UllrA3e2zBdB89b4nRQjLeWp/cc71uuF
         K8WaSzyNzpEORpnSR12co29bHO9p86ZVzr8EbnNiruLbl/KCW12LoZH7MytqDwt6YNv4
         qZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Do8pv0Vpgzmsl33t7UwdTkGnHPp1TrHWFp3cK5q3Vzw=;
        b=67E4lyTK0T4X8xEb1BfeoYCMGOZq8efdAbmydZhxxp73qqGJXGwohPa92fB9EfYW6k
         WWwGwhwufQlGAwJZ8kZ1zd/bzORGBfCjAvvDPPWsai5Zk6p9GfwNJ3Gc5Yyyn20Bv3m2
         giqNUM4XYQil26hPaU5ADcV9NyEeYt30D7ssyK3Avq+4kiy3pwMiP20d+y4NgnZ6qqO0
         TiStpEY9oQzxICapIqvKPBxixLb4ywIPZFqbefEYaqmlShvxjsatROpV47QHTv0JU8p2
         BR0/WW+F974nHxBKsd7Usj1TrQNz6xuZeypTYoVfbWFsyd/ZI56NzKYwtOGQIVgZmZh9
         6I2Q==
X-Gm-Message-State: ACgBeo2jBj5sBa2Wab5Zk/G80/Rb2MNnkMdnqwiIUklsLUkyIlQqqpvd
        je+M2UDEaJUZDQd5/FRqAdw5owlCS7M=
X-Google-Smtp-Source: AA6agR64uZ9QXRziFehDh9N5QjaeQO544bVENAaYemd/x+zCzdcqBuaX2BbA+TdoTy2zDSYP3MGSNw==
X-Received: by 2002:a05:600c:4ca3:b0:3a6:1616:e591 with SMTP id g35-20020a05600c4ca300b003a61616e591mr2217754wmp.99.1662561472185;
        Wed, 07 Sep 2022 07:37:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a846a014c1sm27798027wms.23.2022.09.07.07.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:37:51 -0700 (PDT)
Message-Id: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Sep 2022 14:37:43 +0000
Subject: [PATCH v2 0/7] rebase --keep-base: imply --reapply-cherry-picks and --no-fork-point
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A while a go Philippe reported [1] that he was surprised 'git rebase
--keep-base' removed commits that had been cherry-picked upstream even
though to branch was not being rebased. I think it is also surprising if
'--keep-base' changes the base of the branch without '--fork-point' being
explicitly given on the command line. This series therefore changes the
default behavior of '--keep-base' to imply '--reapply-cherry-picks' and
'--no-fork-point' so that the base of the branch is unchanged and no commits
are removed.

Thanks to everyone who commented for their reviews, the changes since V1
are:

 * Patch 1: new patch to tighten a couple of existing tests
 * Patch 2: reworded commit message in response to Junio's comments
 * Patch 3: fixed a typo in the commit message spotted by Elijah and tidied
   code formatting
 * Patch 4: new patch to rename a variable suggested by Junio
 * Patch 5: clarified commit message and removed some redundant code spotted
   by Junio
 * Patch 6: improved --reapply-cherry-picks documentation to mention
   --keep-base and vice-versa suggested by Philippe
 * Patch 7: expanded the commit message and documentation in response to
   Junio's comments

[1]
https://lore.kernel.org/git/0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com/

Phillip Wood (7):
  t3416: tighten two tests
  t3416: set $EDITOR in subshell
  rebase: store orig_head as a commit
  rebase: rename merge_base to branch_base
  rebase: factor out branch_base calculation
  rebase --keep-base: imply --reapply-cherry-picks
  rebase --keep-base: imply --no-fork-point

 Documentation/git-rebase.txt     |  32 ++++----
 builtin/rebase.c                 | 129 ++++++++++++++++++-------------
 t/t3416-rebase-onto-threedots.sh |  62 +++++++++++----
 t/t3431-rebase-fork-point.sh     |   2 +-
 4 files changed, 142 insertions(+), 83 deletions(-)


base-commit: afa70145a25e81faa685dc0b465e52b45d2444bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1323%2Fphillipwood%2Fwip%2Frebase--keep-base-tweaks-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1323/phillipwood/wip/rebase--keep-base-tweaks-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1323

Range-diff vs v1:

 -:  ----------- > 1:  12fb0ac6d5d t3416: tighten two tests
 1:  c1d91a2b190 ! 2:  d6f2f716c77 t3416: set $EDITOR in subshell
     @@ Metadata
       ## Commit message ##
          t3416: set $EDITOR in subshell
      
     -    As $EDITOR is exported setting it in one test affects all subsequent
     -    tests. Avoid this by always setting it in a subshell and remove a
     -    couple of unnecessary call to set_fake_editor.
     +    As $EDITOR is exported, setting it in one test affects all subsequent
     +    tests. Avoid this by always setting it in a subshell. Also remove a
     +    couple of unnecessary call to set_fake_editor where the editor does
     +    not change the todo list.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ t/t3416-rebase-onto-threedots.sh: test_expect_success 'rebase -i --onto main...'
       	git rev-parse HEAD^1 >actual &&
       	git rev-parse C^0 >expect &&
       	test_cmp expect actual
     -@@ t/t3416-rebase-onto-threedots.sh: test_expect_success 'rebase -i --onto main...side' '
     +@@ t/t3416-rebase-onto-threedots.sh: test_expect_success 'rebase --onto main...side requires a single merge-base' '
       	git checkout side &&
       	git reset --hard K &&
       
      -	set_fake_editor &&
     - 	test_must_fail git rebase -i --onto main...side J
     + 	test_must_fail git rebase -i --onto main...side J 2>err &&
     + 	grep "need exactly one merge base" err
       '
     - 
      @@ t/t3416-rebase-onto-threedots.sh: test_expect_success 'rebase -i --keep-base main from topic' '
       	git checkout topic &&
       	git reset --hard G &&
     @@ t/t3416-rebase-onto-threedots.sh: test_expect_success 'rebase -i --keep-base mai
       	git rev-parse C >base.expect &&
       	git merge-base main HEAD >base.actual &&
       	test_cmp base.expect base.actual &&
     -@@ t/t3416-rebase-onto-threedots.sh: test_expect_success 'rebase -i --keep-base main from side' '
     +@@ t/t3416-rebase-onto-threedots.sh: test_expect_success 'rebase --keep-base requires a single merge base' '
       	git checkout side &&
       	git reset --hard K &&
       
      -	set_fake_editor &&
     - 	test_must_fail git rebase -i --keep-base main
     + 	test_must_fail git rebase -i --keep-base main 2>err &&
     + 	grep "need exactly one merge base with branch" err
       '
       
      +# This must be the last test in this file
 2:  cced4a48360 ! 3:  9daee95d434 rebase: store orig_head as a commit
     @@ Commit message
          rebase: store orig_head as a commit
      
          Using a struct commit rather than a struct oid to hold orig_head means
     -    that we error out straight away if branch being rebased does not point
     -    to a commit. It also simplifies the code than handles finding the
     -    merge base and fork point as it not longer has to convert from an oid
     -    to a commit.
     +    that we error out straight away if the branch being rebased does not
     +    point to a commit. It also simplifies the code that handles finding
     +    the merge base and fork point as it no longer has to convert from an
     +    oid to a commit.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      -			get_fork_point(options.upstream_name, head);
      -	}
      +			get_fork_point(options.upstream_name, options.orig_head);
     -+
       
       	if (repo_read_index(the_repository) < 0)
       		die(_("could not read index"));
 -:  ----------- > 4:  cca933a5f1d rebase: rename merge_base to branch_base
 3:  019158db9d2 ! 5:  fc45b996d34 rebase: factor out merge_base calculation
     @@ Metadata
      Author: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## Commit message ##
     -    rebase: factor out merge_base calculation
     +    rebase: factor out branch_base calculation
      
     -    Separate out calculating the merge base between onto and head from the
     -    check for whether we can fast-forward or not. This means we can skip
     -    the fast-forward checks when the rebase is forced and avoid
     -    calculating the merge-base twice when --keep-base is given.
     +    Separate out calculating the merge base between 'onto' and 'HEAD' from
     +    the check for whether we can fast-forward or not. This means we can skip
     +    the fast-forward checks when the rebase is forced and avoid calculating
     +    the merge-base between 'HEAD' and 'onto' when --keep-base is given.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     -    ---
     -    Note the unnecessary braces around "if (keep_base)" are added here
     -    reduce the churn on the next commit.
      
       ## builtin/rebase.c ##
      @@ builtin/rebase.c: static int can_fast_forward(struct commit *onto, struct commit *upstream,
     @@ builtin/rebase.c: static int can_fast_forward(struct commit *onto, struct commit
       
      -	merge_bases = get_merge_bases(onto, head);
      -	if (!merge_bases || merge_bases->next) {
     --		oidcpy(merge_base, null_oid());
     -+	if (is_null_oid(merge_base))
     +-		oidcpy(branch_base, null_oid());
     ++	if (is_null_oid(branch_base))
       		goto done;
      -	}
       
     --	oidcpy(merge_base, &merge_bases->item->object.oid);
     - 	if (!oideq(merge_base, &onto->object.oid))
     +-	oidcpy(branch_base, &merge_bases->item->object.oid);
     + 	if (!oideq(branch_base, &onto->object.oid))
       		goto done;
       
     +@@ builtin/rebase.c: static int can_fast_forward(struct commit *onto, struct commit *upstream,
     + 	if (!upstream)
     + 		goto done;
     + 
     +-	free_commit_list(merge_bases);
     + 	merge_bases = get_merge_bases(upstream, head);
     + 	if (!merge_bases || merge_bases->next)
     + 		goto done;
      @@ builtin/rebase.c: done:
       	return res && is_linear_history(onto, head);
       }
       
     -+static void fill_merge_base(struct rebase_options *options,
     -+			    struct object_id *merge_base)
     ++static void fill_branch_base(struct rebase_options *options,
     ++			    struct object_id *branch_base)
      +{
      +	struct commit_list *merge_bases = NULL;
      +
      +	merge_bases = get_merge_bases(options->onto, options->orig_head);
      +	if (!merge_bases || merge_bases->next)
     -+		oidcpy(merge_base, null_oid());
     ++		oidcpy(branch_base, null_oid());
      +	else
     -+		oidcpy(merge_base, &merge_bases->item->object.oid);
     ++		oidcpy(branch_base, &merge_bases->item->object.oid);
      +
      +	free_commit_list(merge_bases);
      +}
     @@ builtin/rebase.c: done:
       {
       	struct rebase_options *opts = opt->value;
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 		if (!options.onto)
       			die(_("Does not point to a valid commit '%s'"),
       				options.onto_name);
     ++		fill_branch_base(&options, &branch_base);
       	}
      -
     -+	if (keep_base) {
     -+		oidcpy(&merge_base, &options.onto->object.oid);
     -+	} else {
     -+		fill_merge_base(&options, &merge_base);
     -+	}
       	if (options.fork_point > 0)
       		options.restrict_revision =
       			get_fork_point(options.upstream_name, options.orig_head);
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       	 * in which case we could fast-forward without replacing the commits
       	 * with new commits recreated by replaying their changes.
      -	 *
     --	 * Note that can_fast_forward() initializes merge_base, so we have to
     +-	 * Note that can_fast_forward() initializes branch_base, so we have to
      -	 * call it before checking allow_preemptive_ff.
       	 */
      -	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
     --		    options.orig_head, &merge_base) &&
     +-		    options.orig_head, &branch_base) &&
      -	    allow_preemptive_ff) {
      +	if (allow_preemptive_ff &&
      +	    can_fast_forward(options.onto, options.upstream, options.restrict_revision,
     -+			     options.orig_head, &merge_base)) {
     ++			     options.orig_head, &branch_base)) {
       		int flag;
       
       		if (!(options.flags & REBASE_FORCE)) {
 4:  9cd4c372ee4 ! 6:  faad7eaf0d6 rebase --keep-base: imply --reapply-cherry-picks
     @@ Documentation/git-rebase.txt: leave out at most one of A and B, in which case it
       +
       This option is useful in the case where one is developing a feature on
       top of an upstream branch. While the feature is being worked on, the
     + upstream branch may advance and it may not be the best idea to keep
     +-rebasing on top of the upstream but to keep the base commit as-is.
     ++rebasing on top of the upstream but to keep the base commit as-is. As
     ++the base commit is unchanged this option implies `--reapply-cherry-picks`
     ++to avoid losing commits.
     + +
     + Although both this option and `--fork-point` find the merge base between
     + `<upstream>` and `<branch>`, this option uses the merge base as the _starting
     +@@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
     + Note that commits which start empty are kept (unless `--no-keep-empty`
     + is specified), and commits which are clean cherry-picks (as determined
     + by `git log --cherry-mark ...`) are detected and dropped as a
     +-preliminary step (unless `--reapply-cherry-picks` is passed).
     ++preliminary step (unless `--reapply-cherry-picks` or `--keep-base` is
     ++passed).
     + +
     + See also INCOMPATIBLE OPTIONS below.
     + 
     +@@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
     + 	upstream changes, the behavior towards them is controlled by
     + 	the `--empty` flag.)
     + +
     +-By default (or if `--no-reapply-cherry-picks` is given), these commits
     +-will be automatically dropped.  Because this necessitates reading all
     +-upstream commits, this can be expensive in repos with a large number
     +-of upstream commits that need to be read.  When using the 'merge'
     +-backend, warnings will be issued for each dropped commit (unless
     +-`--quiet` is given). Advice will also be issued unless
     +-`advice.skippedCherryPicks` is set to false (see linkgit:git-config[1]).
     ++
     ++In the absence of `--keep-base` (or if `--no-reapply-cherry-picks` is
     ++given), these commits will be automatically dropped.  Because this
     ++necessitates reading all upstream commits, this can be expensive in
     ++repositories with a large number of upstream commits that need to be
     ++read. When using the 'merge' backend, warnings will be issued for each
     ++dropped commit (unless `--quiet` is given). Advice will also be issued
     ++unless `advice.skippedCherryPicks` is set to false (see
     ++linkgit:git-config[1]).
     ++
     + +
     + `--reapply-cherry-picks` allows rebase to forgo reading all upstream
     + commits, potentially improving performance.
      
       ## builtin/rebase.c ##
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
       	}
      +	/*
     -+	 * --keep-base defaults to --reapply-cherry-picks as it is confusing if
     -+	 * commits disappear when using this option.
     ++	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
     ++	 * commits when using this option.
      +	 */
      +	if (options.reapply_cherry_picks < 0)
      +		options.reapply_cherry_picks = keep_base;
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       
       	if (gpg_sign)
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 				options.onto_name);
     + 		fill_branch_base(&options, &branch_base);
       	}
     - 	if (keep_base) {
     - 		oidcpy(&merge_base, &options.onto->object.oid);
     -+		if (options.reapply_cherry_picks)
     -+			options.upstream = options.onto;
     - 	} else {
     - 		fill_merge_base(&options, &merge_base);
     - 	}
     ++	if (keep_base && options.reapply_cherry_picks)
     ++		options.upstream = options.onto;
     ++
     + 	if (options.fork_point > 0)
     + 		options.restrict_revision =
     + 			get_fork_point(options.upstream_name, options.orig_head);
      
       ## t/t3416-rebase-onto-threedots.sh ##
     -@@ t/t3416-rebase-onto-threedots.sh: test_expect_success 'rebase -i --keep-base main from side' '
     - 	test_must_fail git rebase -i --keep-base main
     +@@ t/t3416-rebase-onto-threedots.sh: test_expect_success 'rebase --keep-base requires a single merge base' '
     + 	grep "need exactly one merge base with branch" err
       '
       
      +test_expect_success 'rebase --keep-base keeps cherry picks' '
 5:  68bcd10949e ! 7:  6410b101d7f rebase --keep-base: imply --no-fork-point
     @@ Commit message
          changes the base of the branch without --fork-point being explicitly
          given on the command line.
      
     +    The combination of --keep-base with an explicit --fork-point is still
     +    supported even though --fork-point means we do not keep the same base
     +    if the upstream branch has been rewound.  We do this in case anyone is
     +    relying on this behavior which is tested in t3431[1]
     +
     +    [1] https://lore.kernel.org/git/20200715032014.GA10818@generichostname/
     +
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## Documentation/git-rebase.txt ##
     @@ Documentation/git-rebase.txt: leave out at most one of A and B, in which case it
       +
       This option is useful in the case where one is developing a feature on
       top of an upstream branch. While the feature is being worked on, the
     +@@ Documentation/git-rebase.txt: When `--fork-point` is active, 'fork_point' will be used instead of
     + <branch>` command (see linkgit:git-merge-base[1]).  If 'fork_point'
     + ends up being empty, the `<upstream>` will be used as a fallback.
     + +
     +-If `<upstream>` is given on the command line, then the default is
     +-`--no-fork-point`, otherwise the default is `--fork-point`. See also
     +-`rebase.forkpoint` in linkgit:git-config[1].
     ++If `<upstream>` or `--keep-base` is given on the command line, then
     ++the default is `--no-fork-point`, otherwise the default is
     ++`--fork-point`. See also `rebase.forkpoint` in linkgit:git-config[1].
     + +
     + If your branch was based on `<upstream>` but `<upstream>` was rewound and
     + your branch contains commits which were dropped, this option can be used
      
       ## builtin/rebase.c ##
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       		if (options.root)
       			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
      +		/*
     -+		 * --keep-base ignores config.forkPoint as it is confusing if
     -+		 * the branch base changes when using this option.
     ++		 * --keep-base defaults to --no-fork-point to keep the
     ++		 * base the same.
      +		 */
      +		if (options.fork_point < 0)
      +			options.fork_point = 0;
       	}
       	/*
     - 	 * --keep-base defaults to --reapply-cherry-picks as it is confusing if
     + 	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
      
       ## t/t3431-rebase-fork-point.sh ##
      @@ t/t3431-rebase-fork-point.sh: test_rebase () {

-- 
gitgitgadget
