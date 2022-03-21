Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB94C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 06:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344557AbiCUGSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 02:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244484AbiCUGSv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 02:18:51 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265B18A6C9
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 23:17:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so1268732wrc.13
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 23:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ea+eyGFSE2Q0PgL72OjXNdm/bo2XfQEH87WcGkwPRew=;
        b=pQja1Mlb5y3hEJ02uXBmecNoVZh7cy4dlHtq39RxEPLc99/xBACUezAq3ZUA34D/5O
         Vl3mNEEV1cwfhwtrdoh+jdiN2lu1z3+G67fctYE/4wTWzEsxC1F6amrQCo5VuXQPmbWU
         CCVag2AU8BZKwTQfJ+bKH+LbB714K0YaaRJzqAltOi5IK8SiqJRX+RKQ9kBrSAoZ+7Yc
         MRONriMOA6xEQzMPPMlhMM7c79gGcVrYjROeBQ6ECfQ3t+s1YdEqce4M0u8OIO+P1H8u
         qEf0SRz+jB6SCoJ0+eDG1A/Yqs9qeaRZCFy1g0/BEnHe/aXOuJJHmrTpZT3ydF+QWmVC
         ujaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ea+eyGFSE2Q0PgL72OjXNdm/bo2XfQEH87WcGkwPRew=;
        b=SaOzurq94KJ67acHieVXgtqdNSGix5N32Zsb3O+D3hVkazTMMRMyrY+ed0F9edUmvf
         u//tgFZy0yUCSiz2JHS7ztvwZL7AkqtfUz9JvhasBL9+fbvFEXBZZpQaWb0jU9FwPBpx
         Qbsmbf+ce+QK/p+xKtZ7tBSsv2/LYstNjrvr9twoNahaZWjJizOR+w0wYfcSxGxafO/J
         CT/LPjATK56WkyBLn1osSfcIVCOm67+fo9g4u7+x1RrjavQjFhto/8W4iPX4hrAeDXC7
         h01KULaSiibpx7uxgyrAFg3V1ATWMQ1l4hYi0X27A3sAQ1OvQfhivuplyXw/HGFx8K2m
         JpSg==
X-Gm-Message-State: AOAM530iPmQXGW1mbMDAL27fQKbmjvus3g1GLUQdE2ifYc5YHuTJ8etX
        Rd98VNqdeeMlalHtz7K+JkgZYAnbi2I=
X-Google-Smtp-Source: ABdhPJxRSQCvteJzRSYd9J6NjMOLPWVCogOxjt3Mxg+pWC4/6gf5CnOgfh1cGECh+jVJq6Mn635kCw==
X-Received: by 2002:adf:de10:0:b0:203:e060:7bab with SMTP id b16-20020adfde10000000b00203e0607babmr16816936wrm.444.1647843444162;
        Sun, 20 Mar 2022 23:17:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0038c6ec42c38sm12602863wmq.6.2022.03.20.23.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 23:17:23 -0700 (PDT)
Message-Id: <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
In-Reply-To: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
References: <pull.1161.v3.git.1646032466.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 06:17:22 +0000
Subject: [PATCH v4] merge: new autosetupmerge option 'simple' for matching
 branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

With the default push.default option, "simple", beginners are
protected from accidentally pushing to the "wrong" branch in
centralized workflows: if the remote tracking branch they would push
to does not have the same name as the local branch, and they try to do
a "default push", they get an error and explanation with options.

There is a particular centralized workflow where this often happens:
a user branches to a new local feature branch from an existing
upstream branch, eg with "checkout -b feature1 origin/master". With
the default branch.autosetupmerge configuration (value "true"), git
will automatically add origin/master as the remote tracking branch.

When the user pushes with "git push", they get an error, and (amongst
other things) a suggestion to run "git push origin HEAD". Eventually
they figure out to add "-u" to change the tracking branch, or they set
push.default to "current", or some tooling does one or the other of
these things for them.

When one of their coworkers works on the same branch, they don't get
any of that weirdness. They just "git checkout feature1" and
everything works exactly as they expect, with the shared remote branch
set up as remote tracking branch, and push and pull working out of the
box.

The "stable state" for this way of working is that local branches have
the same-name remote tracking branch (origin/feature1 in this
example), and multiple people can work on that remote feature branch
at the same time, trusting "git pull" to merge or rebase as required
for them to be able to push their interim changes to that same feature
branch on that same remote.

(merging from the upstream "master" branch, and merging back to it,
are separate more involved processes in this flow).

There is a problem in this flow/way of working, however, which is that
the first user, when they first branched from origin/master, ended up
with the "wrong" remote tracking branch (different from the stable
state). For a while, before they pushed (and maybe longer, if they
don't use -u/--set-upstream), their "git pull" wasn't getting other
users' changes to the feature branch - it was getting any changes from
the remote "master" branch instead (a completely different class of
changes!)

Any experienced git user will presumably say "well yeah, that's what
it means to have the remote tracking branch set to origin/master!" -
but that user didn't *ask* to have the remote master branch added as
remote tracking branch - that just happened automatically when they
branched their feature branch. They didn't necessarily even notice or
understand the meaning of the "set up to track 'origin/master'"
message when they created the branch - especially if they are using a
GUI.

Looking at how to fix this, you might think "OK, so disable auto setup
of remote tracking - set branch.autosetupmerge to false" - but that
will inconvenience the *second* user in this story - the one who just
wanted to start working on the feature branch. The first and second
users swap roles at different points in time of course - they should
both have a sane configuration that does the right thing in both
situations.

Make these flows painless by introducing a new branch.autosetupmerge
option called "simple", to match the same-name "push.default" option
that makes similar assumptions.

This new option automatically sets up tracking in a *subset* of the
current default situations: when the original ref is a remote tracking
branch *and* has the same branch name on the remote (as the new local
branch name).

With this new configuration, in the example situation above, the first
user does *not* get origin/master set up as the tracking branch for
the new local branch. If they "git pull" in their new local-only
branch, they get an error explaining there is no upstream branch -
which makes sense and is helpful. If they "git push", they get an
error explaining how to push *and* suggesting they specify
--set-upstream - which is exactly the right thing to do for them.

This new option is likely not appropriate for users intentionally
implementing a "triangular workflow" with a shared upstream tracking
branch, that they "git pull" in and a "private" feature branch that
they push/force-push to just for remote safe-keeping until they are
ready to push up to the shared branch explicitly/separately. Such
users are likely to prefer keeping the current default
merge.autosetupmerge=true behavior, and change their push.default to
"current".

Also extend the existing branch tests with three new cases testing
this option - the obvious matching-name and non-matching-name cases,
and also a non-matching-ref-type case. The matching-name case needs to
temporarily create an independent repo to fetch from, as the general
strategy of using the local repo as the remote in these tests
precludes locally branching with the same name as in the "remote".

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    adding new branch.autosetupmerge option "simple"
    
    This patchset introduces a new option to the branch.autosetupmerge
    setting, "simple", which is intended to be consistent with and
    complementary to the push.default "simple" option.
    
    The push.defaut option "simple" helps produce predictable/understandable
    behavior for beginners, where they don't accidentally push to the
    "wrong" branch in centralized workflows. If they create a local branch
    with a different name and then try to do a plain push, it will helpfully
    fail and explain why.
    
    However, such users can often find themselves confused by the behavior
    of git after they first branch, and before they push. At that stage,
    their upstream tracking branch is the original remote branch, and pull
    will be bringing in "upstream changes" - eg all changes to "main", in a
    typical project where that's where they branched from. On the other
    hand, once they push their new branch (dealing with the initial error,
    following instructions to push to the right name), subsequent "pull"
    calls will behave as expected, only bring in any changes to that new
    branch they pushed.
    
    The new option introduced here, with push.default set to simple, ensures
    that push/pull behavior is generally consistent - tracking will be
    automatically set up for branches that push will work for (and pull will
    be consistent for) only.
    
    Changes since v3:
    
     * squashed new-tests commit into main changes, as per Ævar's advice
     * added some hopefully-helpful comments in some prior existing code
     * improved tests to use better idioms following Ævar and Eric's advice

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1161%2FTaoK%2Ffeature-branch-autosetupmerge-simple-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1161/TaoK/feature-branch-autosetupmerge-simple-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1161

Range-diff vs v3:

 1:  0b5d4789512 ! 1:  eca8ab2eb7b merge: new autosetupmerge option 'simple' for matching branches
     @@ Commit message
          merge.autosetupmerge=true behavior, and change their push.default to
          "current".
      
     +    Also extend the existing branch tests with three new cases testing
     +    this option - the obvious matching-name and non-matching-name cases,
     +    and also a non-matching-ref-type case. The matching-name case needs to
     +    temporarily create an independent repo to fetch from, as the general
     +    strategy of using the local repo as the remote in these tests
     +    precludes locally branching with the same name as in the "remote".
     +
          Signed-off-by: Tao Klerks <tao@klerks.biz>
      
       ## Documentation/config/branch.txt ##
     @@ Documentation/git-branch.txt: The exact upstream branch is chosen depending on t
       how the `branch.<name>.remote` and `branch.<name>.merge` options are used.
      
       ## branch.c ##
     +@@ branch.c: static int find_tracked_branch(struct remote *remote, void *priv)
     + 			free(tracking->spec.src);
     + 			string_list_clear(tracking->srcs, 0);
     + 		}
     ++		/* remote_find_tracking() searches by src if present */
     + 		tracking->spec.src = NULL;
     + 	}
     +-
     + 	return 0;
     + }
     + 
      @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
     + 
     + 	if (!tracking.matches)
     + 		switch (track) {
     ++		/* If ref is not remote, still use local */
     + 		case BRANCH_TRACK_ALWAYS:
     + 		case BRANCH_TRACK_EXPLICIT:
     + 		case BRANCH_TRACK_OVERRIDE:
     ++		/* Remote matches not evaluated */
     + 		case BRANCH_TRACK_INHERIT:
     + 			break;
     ++		/* Otherwise, if no remote don't track */
     + 		default:
       			goto cleanup;
       		}
       
      +	/*
     -+	 * This check does not apply to the BRANCH_TRACK_INHERIT
     -+	 * option; you can inherit one or more tracking entries
     -+	 * and the tracking.matches counter is not incremented.
     ++	 * This check does not apply to BRANCH_TRACK_INHERIT;
     ++	 * that supports multiple entries in tracking_srcs but
     ++	 * leaves tracking.matches at 0.
      +	 */
       	if (tracking.matches > 1)
       		die(_("not tracking: ambiguous information for ref %s"),
     @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
      +		 * Only track if remote branch name matches.
      +		 * Reaching into items[0].string is safe because
      +		 * we know there is at least one and not more than
     -+		 * one entry (because not BRANCH_TRACK_INHERIT).
     ++		 * one entry (because only BRANCH_TRACK_INHERIT can
     ++		 * produce more than one entry).
      +		 */
      +		const char *tracked_branch;
      +		if (!skip_prefix(tracking.srcs->items[0].string,
     @@ config.c: static int git_default_branch_config(const char *var, const char *valu
       		}
       		git_branch_track = git_config_bool(var, value);
       		return 0;
     +
     + ## t/t3200-branch.sh ##
     +@@ t/t3200-branch.sh: test_expect_success 'branch from tag w/--track causes failure' '
     + 	test_must_fail git branch --track my11 foobar
     + '
     + 
     ++test_expect_success 'simple tracking works when remote branch name matches' '
     ++	test_when_finished "rm -rf otherserver" &&
     ++	git init otherserver &&
     ++	test_commit -C otherserver my_commit 1 &&
     ++	git -C otherserver branch feature &&
     ++	test_config branch.autosetupmerge simple &&
     ++	test_config remote.otherserver.url otherserver &&
     ++	test_config remote.otherserver.fetch refs/heads/*:refs/remotes/otherserver/* &&
     ++	git fetch otherserver &&
     ++	git branch feature otherserver/feature &&
     ++	test_cmp_config otherserver branch.feature.remote &&
     ++	test_cmp_config refs/heads/feature branch.feature.merge
     ++'
     ++
     ++test_expect_success 'simple tracking skips when remote branch name does not match' '
     ++	test_config branch.autosetupmerge simple &&
     ++	test_config remote.local.url . &&
     ++	test_config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
     ++	git fetch local &&
     ++	git branch my-other local/main &&
     ++	test_cmp_config "" --default "" branch.my-other.remote &&
     ++	test_cmp_config "" --default "" branch.my-other.merge
     ++'
     ++
     ++test_expect_success 'simple tracking skips when remote ref is not a branch' '
     ++	test_config branch.autosetupmerge simple &&
     ++	test_config remote.localtags.url . &&
     ++	test_config remote.localtags.fetch refs/tags/*:refs/remotes/localtags/* &&
     ++	git tag mytag12 main &&
     ++	git fetch localtags &&
     ++	git branch mytag12 localtags/mytag12 &&
     ++	test_cmp_config "" --default "" branch.mytag12.remote &&
     ++	test_cmp_config "" --default "" branch.mytag12.merge
     ++'
     ++
     + test_expect_success '--set-upstream-to fails on multiple branches' '
     + 	echo "fatal: too many arguments to set new upstream" >expect &&
     + 	test_must_fail git branch --set-upstream-to main a b c 2>err &&
 2:  d5b18c7949f < -:  ----------- t3200: tests for new branch.autosetupmerge option "simple"


 Documentation/config/branch.txt |  4 +++-
 Documentation/git-branch.txt    | 18 ++++++++++-------
 branch.c                        | 25 ++++++++++++++++++++++-
 branch.h                        |  1 +
 config.c                        |  3 +++
 t/t3200-branch.sh               | 35 +++++++++++++++++++++++++++++++++
 6 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 1e0c7af014b..8df10d07129 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -9,7 +9,9 @@ branch.autoSetupMerge::
 	automatic setup is done when the starting point is either a
 	local branch or remote-tracking branch; `inherit` -- if the starting point
 	has a tracking configuration, it is copied to the new
-	branch. This option defaults to true.
+	branch; `simple` -- automatic setup is done only when the starting point
+	is a remote-tracking branch and the new branch has the same name as the
+	remote branch. This option defaults to true.
 
 branch.autoSetupRebase::
 	When a new branch is created with 'git branch', 'git switch' or 'git checkout'
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index c8b4f9ce3c7..ae82378349d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -221,13 +221,17 @@ The exact upstream branch is chosen depending on the optional argument:
 itself as the upstream; `--track=inherit` means to copy the upstream
 configuration of the start-point branch.
 +
-`--track=direct` is the default when the start point is a remote-tracking branch.
-Set the branch.autoSetupMerge configuration variable to `false` if you
-want `git switch`, `git checkout` and `git branch` to always behave as if `--no-track`
-were given. Set it to `always` if you want this behavior when the
-start-point is either a local or remote-tracking branch. Set it to
-`inherit` if you want to copy the tracking configuration from the
-branch point.
+The branch.autoSetupMerge configuration variable specifies how `git switch`,
+`git checkout` and `git branch` should behave when neither `--track` nor
+`--no-track` are specified:
++
+The default option, `true`, behaves as though `--track=direct`
+were given whenever the start-point is a remote-tracking branch.
+`false` behaves as if `--no-track` were given. `always` behaves as though
+`--track=direct` were given. `inherit` behaves as though `--track=inherit`
+were given. `simple` behaves as though `--track=direct` were given only when
+the start-point is a remote-tracking branch and the new branch has the same
+name as the remote branch.
 +
 See linkgit:git-pull[1] and linkgit:git-config[1] for additional discussion on
 how the `branch.<name>.remote` and `branch.<name>.merge` options are used.
diff --git a/branch.c b/branch.c
index 6b31df539a5..86ea91e76f8 100644
--- a/branch.c
+++ b/branch.c
@@ -30,9 +30,9 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 			free(tracking->spec.src);
 			string_list_clear(tracking->srcs, 0);
 		}
+		/* remote_find_tracking() searches by src if present */
 		tracking->spec.src = NULL;
 	}
-
 	return 0;
 }
 
@@ -243,19 +243,42 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 
 	if (!tracking.matches)
 		switch (track) {
+		/* If ref is not remote, still use local */
 		case BRANCH_TRACK_ALWAYS:
 		case BRANCH_TRACK_EXPLICIT:
 		case BRANCH_TRACK_OVERRIDE:
+		/* Remote matches not evaluated */
 		case BRANCH_TRACK_INHERIT:
 			break;
+		/* Otherwise, if no remote don't track */
 		default:
 			goto cleanup;
 		}
 
+	/*
+	 * This check does not apply to BRANCH_TRACK_INHERIT;
+	 * that supports multiple entries in tracking_srcs but
+	 * leaves tracking.matches at 0.
+	 */
 	if (tracking.matches > 1)
 		die(_("not tracking: ambiguous information for ref %s"),
 		    orig_ref);
 
+	if (track == BRANCH_TRACK_SIMPLE) {
+		/*
+		 * Only track if remote branch name matches.
+		 * Reaching into items[0].string is safe because
+		 * we know there is at least one and not more than
+		 * one entry (because only BRANCH_TRACK_INHERIT can
+		 * produce more than one entry).
+		 */
+		const char *tracked_branch;
+		if (!skip_prefix(tracking.srcs->items[0].string,
+				 "refs/heads/", &tracked_branch) ||
+		    strcmp(tracked_branch, new_ref))
+			return;
+	}
+
 	if (tracking.srcs->nr < 1)
 		string_list_append(tracking.srcs, orig_ref);
 	if (install_branch_config_multiple_remotes(config_flags, new_ref,
diff --git a/branch.h b/branch.h
index 04df2aa5b51..560b6b96a8f 100644
--- a/branch.h
+++ b/branch.h
@@ -12,6 +12,7 @@ enum branch_track {
 	BRANCH_TRACK_EXPLICIT,
 	BRANCH_TRACK_OVERRIDE,
 	BRANCH_TRACK_INHERIT,
+	BRANCH_TRACK_SIMPLE,
 };
 
 extern enum branch_track git_branch_track;
diff --git a/config.c b/config.c
index e78397725c9..8de87400085 100644
--- a/config.c
+++ b/config.c
@@ -1686,6 +1686,9 @@ static int git_default_branch_config(const char *var, const char *value)
 		} else if (value && !strcmp(value, "inherit")) {
 			git_branch_track = BRANCH_TRACK_INHERIT;
 			return 0;
+		} else if (value && !strcmp(value, "simple")) {
+			git_branch_track = BRANCH_TRACK_SIMPLE;
+			return 0;
 		}
 		git_branch_track = git_config_bool(var, value);
 		return 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7a0ff75ba86..7a5a44a1ebf 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -886,6 +886,41 @@ test_expect_success 'branch from tag w/--track causes failure' '
 	test_must_fail git branch --track my11 foobar
 '
 
+test_expect_success 'simple tracking works when remote branch name matches' '
+	test_when_finished "rm -rf otherserver" &&
+	git init otherserver &&
+	test_commit -C otherserver my_commit 1 &&
+	git -C otherserver branch feature &&
+	test_config branch.autosetupmerge simple &&
+	test_config remote.otherserver.url otherserver &&
+	test_config remote.otherserver.fetch refs/heads/*:refs/remotes/otherserver/* &&
+	git fetch otherserver &&
+	git branch feature otherserver/feature &&
+	test_cmp_config otherserver branch.feature.remote &&
+	test_cmp_config refs/heads/feature branch.feature.merge
+'
+
+test_expect_success 'simple tracking skips when remote branch name does not match' '
+	test_config branch.autosetupmerge simple &&
+	test_config remote.local.url . &&
+	test_config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	git fetch local &&
+	git branch my-other local/main &&
+	test_cmp_config "" --default "" branch.my-other.remote &&
+	test_cmp_config "" --default "" branch.my-other.merge
+'
+
+test_expect_success 'simple tracking skips when remote ref is not a branch' '
+	test_config branch.autosetupmerge simple &&
+	test_config remote.localtags.url . &&
+	test_config remote.localtags.fetch refs/tags/*:refs/remotes/localtags/* &&
+	git tag mytag12 main &&
+	git fetch localtags &&
+	git branch mytag12 localtags/mytag12 &&
+	test_cmp_config "" --default "" branch.mytag12.remote &&
+	test_cmp_config "" --default "" branch.mytag12.merge
+'
+
 test_expect_success '--set-upstream-to fails on multiple branches' '
 	echo "fatal: too many arguments to set new upstream" >expect &&
 	test_must_fail git branch --set-upstream-to main a b c 2>err &&

base-commit: 74cc1aa55f30ed76424a0e7226ab519aa6265061
-- 
gitgitgadget
