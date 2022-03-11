Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08B8C433FE
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 17:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348478AbiCKR0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 12:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiCKRZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 12:25:59 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAD417B89F
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 09:24:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so5737619wmp.5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 09:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rKNUCV/5Ks6CSibs0iMSAoXXSZ/6cZj+F0wDRcgBfP8=;
        b=bkKTvcM1rhHJ7CYlZ88PoyVTXejw8lYEh24ns01/a2ZJFHZDVkELIpzcROIA1CX5zx
         vnWnjLleW1MvCARV4WUIsoCdzKE7lMZpjUEDRcVg9RAkOCHDlz2iC7RpzAR9alupMoA9
         VJBfGDZYeOx8GNZkOBLrCMPXB7SXd6aZthTSmAUaFO2P7S0OCWBkensdKNxAWR8SUu4h
         JWhnRctr472GGxqOA/R1U2XKIHZ1YyX4NWJP6VM33OrL/kDCa555d6n6OuJwxeDzM74u
         m8gKJAYiKOlj81q/sXWMocuJpbyFYd0xw7nDNCGY8YLxgyYbuixLxAGyhOV0Pkg5svMl
         tG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rKNUCV/5Ks6CSibs0iMSAoXXSZ/6cZj+F0wDRcgBfP8=;
        b=UHg9hH2EHT4jUvX8c/Sf2y9VWb9HPyFa5K4q8g9hxVYYlQTicgD5pgrAYPaZAng6vV
         p6/y4NPvPimdj44cs+o3IEo4YOLUigXaZqnaNF6oz3NB0ZXEBNoL4G2ApFiKvKA06H/o
         o971l+T7CR+lLa13GVkKnIa/KsWMs2ILAEcapsmJ0pjzZIQIg+d/Yij89+f72d1XUi2y
         JqlJG5Mgn/gj0MFHippdTTkFI2XdsSYg1PCTXPnz8sJA+mLVdYgeRgNmuMEnMbxsLBsI
         QS5tO5WEWqZnbKkKRLAaiPKGBItoq7/rfutllRcgLOd757rtJvp3eATQyj+2WFaC9XaL
         b2Tg==
X-Gm-Message-State: AOAM5310PGMKoihxqabd2Nr6RhB8gJVRoYqoToVwPd59vMnJ+AtO4A89
        0qDBr+rs4TjZIGhcJ38M2h+Ymb3BPW0=
X-Google-Smtp-Source: ABdhPJycVh8nkptiEqSjzK5CWa4al96PVUvms7WHHZfTZeHBugkRqYP+rojoFCwe0wP5jUi6kireSw==
X-Received: by 2002:a05:600c:1591:b0:388:7d62:1d1b with SMTP id r17-20020a05600c159100b003887d621d1bmr8543127wmf.66.1647019493768;
        Fri, 11 Mar 2022 09:24:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12-20020adfb34c000000b001f1e13df54dsm7119894wrd.89.2022.03.11.09.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:24:53 -0800 (PST)
Message-Id: <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 17:24:50 +0000
Subject: [PATCH v2 0/2] rebase: update HEAD when is an oid
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes a bug [1] reported by Michael McClimon where rebase with oids will
erroneously update the branch HEAD points to.

 1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/

This patch has two parts:

 * updates rebase setup test to add some tags we will use, while swapping
   out manual commit creation with the test_commit helper
 * sets RESET_HARD_DETACH flag if branch is not a valid refname

changes since v1:

 * only set RESET_HEAD_DETACH if is not a valid branch
 * updated tests to use existing setup

John Cai (2):
  rebase: use test_commit helper in setup
  rebase: set REF_HEAD_DETACH in checkout_up_to_date()

 builtin/rebase.c  |  5 ++++-
 reset.c           |  3 +++
 t/t3400-rebase.sh | 18 +++++++++++-------
 3 files changed, 18 insertions(+), 8 deletions(-)


base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1226%2Fjohn-cai%2Fjc%2Ffix-rebase-oids-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1226/john-cai/jc/fix-rebase-oids-v2
Pull-Request: https://github.com/git/git/pull/1226

Range-diff vs v1:

 -:  ----------- > 1:  f3f084adfa6 rebase: use test_commit helper in setup
 1:  2538fd986d2 ! 2:  0e3c73375c1 rebase: set REF_HEAD_DETACH in checkout_up_to_date()
     @@ Commit message
          git rebase $(git rev-parse main) $(git rev-parse topic)
      
          Instead of HEAD being set to $(git rev-parse topic), rebase erroneously
     -    dereferences HEAD and sets main to $(git rev-parse topic). This bug was
     -    reported by Michael McClimon. See [1].
     +    dereferences HEAD and sets main to $(git rev-parse topic). See [1] for
     +    the original bug report.
      
     -    This is happening because on a fast foward with an oid as a <branch>,
     -    update_refs() will only call update_ref() with REF_NO_DEREF if
     -    RESET_HEAD_DETACH is set. This change was made in 176f5d96 (built-in rebase
     -    --autostash: leave the current branch alone if possible,
     -    2018-11-07). In rebase, we are not setting the RESET_HEAD_DETACH flag,
     -    which means that the update_ref() call ends up dereferencing
     -    HEAD and updating it to the oid used as <branch>.
     +    The callstack from checkout_up_to_date() is the following:
     +
     +    cmd_rebase() -> checkout_up_to_date() -> reset_head() -> update_refs()
     +     -> update_ref()
     +
     +    When <branch> is not a valid branch but a sha, rebase sets the head_name
     +    of rebase_options to NULL. This value gets passed down this call chain
     +    through the branch member of reset_head_opts also getting set to NULL
     +    all the way to update_refs(). update_refs() checks ropts.branch to
     +    decide whether or not to switch brancheds. If ropts.branch is NULL, it
     +    calls update_ref() to update HEAD. At this point however, from rebase's
     +    point of view, we want a detached HEAD. But, since checkout_up_to_date()
     +    does not set the RESET_HEAD_DETACH flag, the update_ref() call will
     +    deference HEAD and update the branch its pointing to, which in the above
     +    example is main.
      
          The correct behavior is that git rebase should update HEAD to $(git
          rev-parse topic) without dereferencing it.
      
          Fix this bug by adding the RESET_HEAD_DETACH flag in checkout_up_to_date
     -    so that once reset_head() calls update_refs(), it calls update_ref() with
     -    REF_NO_DEREF which updates HEAD directly intead of deferencing it and
     -    updating the branch that HEAD points to.
     +    if <branch> is not a valid branch. so that once reset_head() calls
     +    update_refs(), it calls update_ref() with REF_NO_DEREF which updates
     +    HEAD directly intead of deferencing it and updating the branch that HEAD
     +    points to.
      
          Also add a test to ensure this behavior.
      
          1. https://lore.kernel.org/git/xmqqsfrpbepd.fsf@gitster.g/
      
     +    Reported-by: Michael McClimon <michael@mcclimon.org>
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## builtin/rebase.c ##
      @@ builtin/rebase.c: static int checkout_up_to_date(struct rebase_options *options)
     + 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
       		    options->switch_to);
       	ropts.oid = &options->orig_head;
     - 	ropts.branch = options->head_name;
     --	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
     -+	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK | RESET_HEAD_DETACH;
     +-	ropts.branch = options->head_name;
     + 	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
     ++	if (options->head_name)
     ++		ropts.branch = options->head_name;
     ++	else
     ++		ropts.flags |=  RESET_HEAD_DETACH;
       	ropts.head_msg = buf.buf;
       	if (reset_head(the_repository, &ropts) < 0)
       		ret = error(_("could not switch to %s"), options->switch_to);
      
     + ## reset.c ##
     +@@ reset.c: int reset_head(struct repository *r, const struct reset_head_opts *opts)
     + 	if (opts->branch_msg && !opts->branch)
     + 		BUG("branch reflog message given without a branch");
     + 
     ++	if (switch_to_branch && opts->flags & RESET_HEAD_DETACH)
     ++		BUG("attempting to detach HEAD when branch is given");
     ++
     + 	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
     + 		ret = -1;
     + 		goto leave_reset_head;
     +
       ## t/t3400-rebase.sh ##
     -@@ t/t3400-rebase.sh: test_expect_success 'rebase when inside worktree subdirectory' '
     - 	)
     +@@ t/t3400-rebase.sh: test_expect_success 'switch to branch not checked out' '
     + 	git rebase main other
       '
       
     -+test_expect_success 'rebase with oids' '
     -+	git init main-wt &&
     -+	(
     -+		cd main-wt &&
     -+		>file &&
     -+		git add file &&
     -+		git commit -m initial &&
     -+		git checkout -b side &&
     -+		echo >>file &&
     -+		git commit -a -m side &&
     -+		git checkout main &&
     -+		git tag hold &&
     -+		git checkout -B main hold &&
     -+		git rev-parse main >pre &&
     -+		git rebase $(git rev-parse main) $(git rev-parse side) &&
     -+		git rev-parse main >post &&
     -+		test "$(git rev-parse side)" = "$(cat .git/HEAD)" &&
     -+		test_cmp pre post
     -+	)
     ++test_expect_success 'switch to non-branch detaches HEAD' '
     ++	git checkout main &&
     ++	old_main=$(git rev-parse HEAD) &&
     ++	git rebase First Second^0 &&
     ++	test_cmp_rev HEAD Second &&
     ++	test_cmp_rev main $old_main &&
     ++	test_must_fail git symbolic-ref HEAD
      +'
      +
     - test_done
     + test_expect_success 'refuse to switch to branch checked out elsewhere' '
     + 	git checkout main &&
     + 	git worktree add wt &&

-- 
gitgitgadget
