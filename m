Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B92C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 07:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiB1HPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 02:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiB1HPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 02:15:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F25387AC
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 23:14:30 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i20so5100018wmc.3
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 23:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N5C8OwfGhmtzvJeebXh5go4bJIdHtYb/EeLBRI1BZbo=;
        b=QxfW7ibpb3yMBt13d7i8WjvXRF3oucCYdUxTRJIckAeLx39ULVOanxvgoOHNHhvSVe
         nwgXfTBPe+IPZiAHUYhKo28QHDB7+4/NWXxSfk928hFfm23Up8P51iD7Hvl3vrFLWy+z
         WSYINcDHi+BXwMXgsuliiyy2oH/by2+JPARK7B4AOSMizE3g23ZAoXdhTc7tJUjsEQc8
         uRizf/dPJu0HZQcfM2eodQaPF4uu272nbTTJ8MFjUjOR8pcaiLTa2XuLGuYm6aT85cvc
         Hbx3FcNz4GlGip5B+FJER2AihFGNAZ1WEDl9VxnftK+XsYvb1bapuNKmpuLIQ8LPOvWB
         tbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N5C8OwfGhmtzvJeebXh5go4bJIdHtYb/EeLBRI1BZbo=;
        b=TqqiFto7sFsTuHlJ9As3MLemsnuZSjUUIc1j0pHRStY1yIlbrNZXEtg74tvunKCeJH
         JqK0X1ax9RCN0AIZ6kUuVt6aFLDcR3cuidYFRWc5GWC4J2J9Y7YVQW8cYk9fV9gC7tlm
         TeHBrHOEJyh1P10ox0gjNIDHwi4eYLxvJJYz7ooEXYmtaDJ6l461hBM8fGyxFwfLbI0o
         OpQy4Ayf1DZaSwoCySRVoJLvqlSbs6GI8u9Sn+YQdY7UDI1zKHtc3jbgQsIzcfCMPjVO
         zxirlBZC0Ary1gosf0iZpvBQN1Mbztcc9H4k7idNJBrbnBMnFpl77D5ktav0PJfU8Fnd
         5FRQ==
X-Gm-Message-State: AOAM532EPtbo/hK/feTdyBv7+q1JhOKpPeLj6oxrtQPZoCgjfhLVnRnJ
        eWbOpUM47geWY6RKxwocUlCGCOQ/oCo=
X-Google-Smtp-Source: ABdhPJwpn97jw0Y+5aclHGsDCuI5oRqElagId0Fhus94FNymO0MPnRM1ud7b/72hxUd67A5boa3dQw==
X-Received: by 2002:a05:600c:a06:b0:37b:fdd8:4f8 with SMTP id z6-20020a05600c0a0600b0037bfdd804f8mr12282044wmp.41.1646032468308;
        Sun, 27 Feb 2022 23:14:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm9464674wrm.82.2022.02.27.23.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 23:14:27 -0800 (PST)
Message-Id: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
References: <pull.1161.v2.git.1645815142.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Feb 2022 07:14:24 +0000
Subject: [PATCH v3 0/2] adding new branch.autosetupmerge option "simple"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1161%2FTaoK%2Ffeature-branch-autosetupmerge-simple-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1161/TaoK/feature-branch-autosetupmerge-simple-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1161

Range-diff vs v2:

 1:  890e016bfc0 ! 1:  0b5d4789512 merge: new autosetupmerge option 'simple' for matching branches
     @@ Metadata
       ## Commit message ##
          merge: new autosetupmerge option 'simple' for matching branches
      
     -    This commit introduces a new option to the branch.autosetupmerge
     -    setting, "simple", which is intended to be consistent with and
     -    complementary to the push.default "simple" option.
     -
     -    The push.defaut option "simple" helps produce
     -    predictable/understandable behavior for beginners, where they don't
     -    accidentally push to the "wrong" branch in centralized workflows. If
     -    they create a local branch with a different name and then try to do a
     -    plain push, it will helpfully fail and explain why.
     -
     -    However, such users can often find themselves confused by the behavior
     -    of git after they first branch, and before they push. At that stage,
     -    their upstream tracking branch is the original remote branch, and pull
     -    will be bringing in "upstream changes" - eg all changes to "main", in
     -    a typical project where that's where they branched from.
     -    On the other hand, once they push their new branch (dealing with the
     -    initial error, following instructions to push to the right name),
     -    subsequent "pull" calls will behave as expected, only bring in any
     -    changes to that new branch they pushed.
     -
     -    The new option introduced here, with push.default set to simple,
     -    ensures that push/pull behavior is generally consistent - tracking
     -    will be automatically set up for branches that push will work for
     -    (and pull will be consistent for) only.
     +    With the default push.default option, "simple", beginners are
     +    protected from accidentally pushing to the "wrong" branch in
     +    centralized workflows: if the remote tracking branch they would push
     +    to does not have the same name as the local branch, and they try to do
     +    a "default push", they get an error and explanation with options.
     +
     +    There is a particular centralized workflow where this often happens:
     +    a user branches to a new local feature branch from an existing
     +    upstream branch, eg with "checkout -b feature1 origin/master". With
     +    the default branch.autosetupmerge configuration (value "true"), git
     +    will automatically add origin/master as the remote tracking branch.
     +
     +    When the user pushes with "git push", they get an error, and (amongst
     +    other things) a suggestion to run "git push origin HEAD". Eventually
     +    they figure out to add "-u" to change the tracking branch, or they set
     +    push.default to "current", or some tooling does one or the other of
     +    these things for them.
     +
     +    When one of their coworkers works on the same branch, they don't get
     +    any of that weirdness. They just "git checkout feature1" and
     +    everything works exactly as they expect, with the shared remote branch
     +    set up as remote tracking branch, and push and pull working out of the
     +    box.
     +
     +    The "stable state" for this way of working is that local branches have
     +    the same-name remote tracking branch (origin/feature1 in this
     +    example), and multiple people can work on that remote feature branch
     +    at the same time, trusting "git pull" to merge or rebase as required
     +    for them to be able to push their interim changes to that same feature
     +    branch on that same remote.
     +
     +    (merging from the upstream "master" branch, and merging back to it,
     +    are separate more involved processes in this flow).
     +
     +    There is a problem in this flow/way of working, however, which is that
     +    the first user, when they first branched from origin/master, ended up
     +    with the "wrong" remote tracking branch (different from the stable
     +    state). For a while, before they pushed (and maybe longer, if they
     +    don't use -u/--set-upstream), their "git pull" wasn't getting other
     +    users' changes to the feature branch - it was getting any changes from
     +    the remote "master" branch instead (a completely different class of
     +    changes!)
     +
     +    Any experienced git user will presumably say "well yeah, that's what
     +    it means to have the remote tracking branch set to origin/master!" -
     +    but that user didn't *ask* to have the remote master branch added as
     +    remote tracking branch - that just happened automatically when they
     +    branched their feature branch. They didn't necessarily even notice or
     +    understand the meaning of the "set up to track 'origin/master'"
     +    message when they created the branch - especially if they are using a
     +    GUI.
     +
     +    Looking at how to fix this, you might think "OK, so disable auto setup
     +    of remote tracking - set branch.autosetupmerge to false" - but that
     +    will inconvenience the *second* user in this story - the one who just
     +    wanted to start working on the feature branch. The first and second
     +    users swap roles at different points in time of course - they should
     +    both have a sane configuration that does the right thing in both
     +    situations.
     +
     +    Make these flows painless by introducing a new branch.autosetupmerge
     +    option called "simple", to match the same-name "push.default" option
     +    that makes similar assumptions.
     +
     +    This new option automatically sets up tracking in a *subset* of the
     +    current default situations: when the original ref is a remote tracking
     +    branch *and* has the same branch name on the remote (as the new local
     +    branch name).
     +
     +    With this new configuration, in the example situation above, the first
     +    user does *not* get origin/master set up as the tracking branch for
     +    the new local branch. If they "git pull" in their new local-only
     +    branch, they get an error explaining there is no upstream branch -
     +    which makes sense and is helpful. If they "git push", they get an
     +    error explaining how to push *and* suggesting they specify
     +    --set-upstream - which is exactly the right thing to do for them.
     +
     +    This new option is likely not appropriate for users intentionally
     +    implementing a "triangular workflow" with a shared upstream tracking
     +    branch, that they "git pull" in and a "private" feature branch that
     +    they push/force-push to just for remote safe-keeping until they are
     +    ready to push up to the shared branch explicitly/separately. Such
     +    users are likely to prefer keeping the current default
     +    merge.autosetupmerge=true behavior, and change their push.default to
     +    "current".
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
 2:  c16a8fe01e7 ! 2:  d5b18c7949f t3200: tests for new branch.autosetupmerge option "simple"
     @@ Metadata
       ## Commit message ##
          t3200: tests for new branch.autosetupmerge option "simple"
      
     -    In the previous commit a new autosetupmerge option was
     -    introduced. Here the existing branch tests are extended
     -    with three new cases testing this option - the obvious
     -    matching-name and non-matching-name cases, and also a
     -    non-matching-ref-type case.
     +    In the previous commit a new autosetupmerge option was introduced.
      
     -    The matching-name case needs to temporarily create
     -    an independent repo to fetch from, as the general
     -    strategy of using the local repo as the remote in these
     -    tests precludes locally branching with the same
     +    Extend the existing branch tests with three new cases testing this
     +    option - the obvious matching-name and non-matching-name cases, and
     +    also a non-matching-ref-type case.
     +
     +    The matching-name case needs to temporarily create an independent
     +    repo to fetch from, as the general strategy of using the local repo as
     +    the remote in these tests precludes locally branching with the same
          name as in the "remote".
      
          Signed-off-by: Tao Klerks <tao@klerks.biz>

-- 
gitgitgadget
