Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1D5C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 18:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiBYSxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiBYSxG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 13:53:06 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABF12018E
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 10:52:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b5so5893656wrr.2
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 10:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xpneL0U8NzqPsEwD2PzLaaGGyri8r5IcPGDRIkFK2pw=;
        b=fj7MILKXMvvLq5N8MWw+9whJkoWIapdez4FnQy09d1x1vW3MsCwQFFQ+y5T1yC9IAe
         U9E9wgNzIheIB0l/D3aLB82GX/SU/0Uuf22cRXeKy8pmhRMxcVano2vFUE3b3vOSHGGT
         GET3P5oyHulGDPCFtzolzy8xjxUWWG+LhMQJfEu3wJjsaLFa+DwlmbyKB010HNHLzvUc
         KsCvoZBlMDp0qeoJrnZSULcnRr0a8iX9v1P+IIH7E7QilyrKRdVrx7YcCujDyWYw2aMW
         QNG/JjQ767Yd7KOUpt6hmyvEtuWri6nN3PF80t+PKi57G/XCthEzU8WkMK9ynDkcEZTb
         2khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xpneL0U8NzqPsEwD2PzLaaGGyri8r5IcPGDRIkFK2pw=;
        b=QHN36vountNPSTa+wYaWi53cLEIwgRGqPcF0m9t4EuwH3WqBGLRc6JWDPkQy5lotb5
         rUess4M5mdzJl6Aw2jPHIhFTQjJvJl9j4ieNG0aNTUkxKUfuT2aJDGO5bAxxTEmKoQ+o
         11XQcj8CKNdTXAvHFirdCw2ScTFjdimI/pNFdXNeiykuKwwZP8PSAmJjcleav5csE7JI
         b8E+UrR64Z1UsW/YfQFCYuQSDA//WVB1ZHgNJDez3u/9BSHqhvFkj+wwo1KfAjmUMb9Z
         Lts8ri6vAYkdXy2vk0E1cRZ062YDBO0BAmJ8miH7Dw5lUhKRUJqPU7FfWfW5Q3w1kG76
         l1XQ==
X-Gm-Message-State: AOAM531352JGjjL7ecnijx8Sw4Gdu9NU1ps8ct6DtI37tFCk/Bb3vaLo
        tA9SEMLvUGfravsPGeIgxaXNabvkxZk=
X-Google-Smtp-Source: ABdhPJzPOox42ryTHHIxWjih8gPmnULBjShuz+R3oNRBJfAVvhygZGetY2jOsuloqF8E+ANxOwsjiw==
X-Received: by 2002:a5d:55d0:0:b0:1ed:bda2:4e11 with SMTP id i16-20020a5d55d0000000b001edbda24e11mr7048523wrw.6.1645815144042;
        Fri, 25 Feb 2022 10:52:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b001edc00dbeeasm2789534wrw.69.2022.02.25.10.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:52:23 -0800 (PST)
Message-Id: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
References: <pull.1161.git.1645695940.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 18:52:20 +0000
Subject: [PATCH v2 0/2] adding new branch.autosetupmerge option "simple"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-sending with proposed fixes to concerns raised by Junio.

This patchset introduces a new option to the branch.autosetupmerge setting,
"simple", which is intended to be consistent with and complementary to the
push.default "simple" option.

The push.defaut option "simple" helps produce predictable/understandable
behavior for beginners, where they don't accidentally push to the "wrong"
branch in centralized workflows. If they create a local branch with a
different name and then try to do a plain push, it will helpfully fail and
explain why.

However, such users can often find themselves confused by the behavior of
git after they first branch, and before they push. At that stage, their
upstream tracking branch is the original remote branch, and pull will be
bringing in "upstream changes" - eg all changes to "main", in a typical
project where that's where they branched from. On the other hand, once they
push their new branch (dealing with the initial error, following
instructions to push to the right name), subsequent "pull" calls will behave
as expected, only bring in any changes to that new branch they pushed.

The new option introduced here, with push.default set to simple, ensures
that push/pull behavior is generally consistent - tracking will be
automatically set up for branches that push will work for (and pull will be
consistent for) only.

Tao Klerks (2):
  merge: new autosetupmerge option 'simple' for matching branches
  t3200: tests for new branch.autosetupmerge option "simple"

 Documentation/config/branch.txt |  4 +++-
 Documentation/git-branch.txt    | 18 ++++++++++-------
 branch.c                        | 19 ++++++++++++++++++
 branch.h                        |  1 +
 config.c                        |  3 +++
 t/t3200-branch.sh               | 35 +++++++++++++++++++++++++++++++++
 6 files changed, 72 insertions(+), 8 deletions(-)


base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1161%2FTaoK%2Ffeature-branch-autosetupmerge-simple-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1161/TaoK/feature-branch-autosetupmerge-simple-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1161

Range-diff vs v1:

 1:  89efc1e1564 ! 1:  890e016bfc0 merge: new autosetupmerge option 'simple' for matching branches
     @@ Metadata
       ## Commit message ##
          merge: new autosetupmerge option 'simple' for matching branches
      
     -    The push.defaut option "simple" helps produce
     -    predictable/understandable behavior for beginners,
     -    where they don't accidentally push to the
     -    "wrong" branch in centralized workflows. If they
     -    create a local branch with a different name
     -    and then try to do a plain push, it will
     -    helpfully fail and explain why.
     +    This commit introduces a new option to the branch.autosetupmerge
     +    setting, "simple", which is intended to be consistent with and
     +    complementary to the push.default "simple" option.
      
     -    However, such users can often find themselves
     -    confused by the behavior of git after they first
     -    branch, and before they push. At that stage,
     -    their upstream tracking branch is the original
     -    remote branch, and pull (for example) behaves
     -    very differently to how it later does when they
     -    create their own same-name remote branch.
     +    The push.defaut option "simple" helps produce
     +    predictable/understandable behavior for beginners, where they don't
     +    accidentally push to the "wrong" branch in centralized workflows. If
     +    they create a local branch with a different name and then try to do a
     +    plain push, it will helpfully fail and explain why.
      
     -    This commit introduces a new option to the
     -    branch.autosetupmerge setting, "simple",
     -    which is intended to be consistent with and
     -    complementary to the push.default "simple"
     -    option.
     +    However, such users can often find themselves confused by the behavior
     +    of git after they first branch, and before they push. At that stage,
     +    their upstream tracking branch is the original remote branch, and pull
     +    will be bringing in "upstream changes" - eg all changes to "main", in
     +    a typical project where that's where they branched from.
     +    On the other hand, once they push their new branch (dealing with the
     +    initial error, following instructions to push to the right name),
     +    subsequent "pull" calls will behave as expected, only bring in any
     +    changes to that new branch they pushed.
      
     -    It will set up automatic tracking for a new
     -    branch only if the remote ref is a branch and
     -    that remote branch name matches the new local
     -    branch name. It is a reduction in scope of
     -    the existing default option, "true".
     +    The new option introduced here, with push.default set to simple,
     +    ensures that push/pull behavior is generally consistent - tracking
     +    will be automatically set up for branches that push will work for
     +    (and pull will be consistent for) only.
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
     + ## Documentation/config/branch.txt ##
     +@@ Documentation/config/branch.txt: branch.autoSetupMerge::
     + 	automatic setup is done when the starting point is either a
     + 	local branch or remote-tracking branch; `inherit` -- if the starting point
     + 	has a tracking configuration, it is copied to the new
     +-	branch. This option defaults to true.
     ++	branch; `simple` -- automatic setup is done only when the starting point
     ++	is a remote-tracking branch and the new branch has the same name as the
     ++	remote branch. This option defaults to true.
     + 
     + branch.autoSetupRebase::
     + 	When a new branch is created with 'git branch', 'git switch' or 'git checkout'
     +
     + ## Documentation/git-branch.txt ##
     +@@ Documentation/git-branch.txt: The exact upstream branch is chosen depending on the optional argument:
     + itself as the upstream; `--track=inherit` means to copy the upstream
     + configuration of the start-point branch.
     + +
     +-`--track=direct` is the default when the start point is a remote-tracking branch.
     +-Set the branch.autoSetupMerge configuration variable to `false` if you
     +-want `git switch`, `git checkout` and `git branch` to always behave as if `--no-track`
     +-were given. Set it to `always` if you want this behavior when the
     +-start-point is either a local or remote-tracking branch. Set it to
     +-`inherit` if you want to copy the tracking configuration from the
     +-branch point.
     ++The branch.autoSetupMerge configuration variable specifies how `git switch`,
     ++`git checkout` and `git branch` should behave when neither `--track` nor
     ++`--no-track` are specified:
     +++
     ++The default option, `true`, behaves as though `--track=direct`
     ++were given whenever the start-point is a remote-tracking branch.
     ++`false` behaves as if `--no-track` were given. `always` behaves as though
     ++`--track=direct` were given. `inherit` behaves as though `--track=inherit`
     ++were given. `simple` behaves as though `--track=direct` were given only when
     ++the start-point is a remote-tracking branch and the new branch has the same
     ++name as the remote branch.
     + +
     + See linkgit:git-pull[1] and linkgit:git-config[1] for additional discussion on
     + how the `branch.<name>.remote` and `branch.<name>.merge` options are used.
     +
       ## branch.c ##
      @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
     + 			goto cleanup;
     + 		}
     + 
     ++	/*
     ++	 * This check does not apply to the BRANCH_TRACK_INHERIT
     ++	 * option; you can inherit one or more tracking entries
     ++	 * and the tracking.matches counter is not incremented.
     ++	 */
     + 	if (tracking.matches > 1)
       		die(_("not tracking: ambiguous information for ref %s"),
       		    orig_ref);
       
      +	if (track == BRANCH_TRACK_SIMPLE) {
     -+		// only track if remote branch name matches
     -+		// (tracking.srcs must contain only one entry from find_tracked_branch with this config)
     -+		if (strncmp(tracking.srcs->items[0].string, "refs/heads/", 11))
     -+			return;
     -+		if (strcmp(tracking.srcs->items[0].string + 11, new_ref))
     ++		/*
     ++		 * Only track if remote branch name matches.
     ++		 * Reaching into items[0].string is safe because
     ++		 * we know there is at least one and not more than
     ++		 * one entry (because not BRANCH_TRACK_INHERIT).
     ++		 */
     ++		const char *tracked_branch;
     ++		if (!skip_prefix(tracking.srcs->items[0].string,
     ++				 "refs/heads/", &tracked_branch) ||
     ++		    strcmp(tracked_branch, new_ref))
      +			return;
      +	}
      +
 2:  3fa56f1d2a0 ! 2:  c16a8fe01e7 t3200: tests for new branch.autosetupmerge option "simple"
     @@ Commit message
      
          The matching-name case needs to temporarily create
          an independent repo to fetch from, as the general
     -    strategy in these tests of using the local repo as
     -    the remote precludes locally branching with the same
     -    name as the "remote".
     +    strategy of using the local repo as the remote in these
     +    tests precludes locally branching with the same
     +    name as in the "remote".
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
 3:  39c14906e7b < -:  ----------- branch documentation: new autosetupmerge option "simple"

-- 
gitgitgadget
