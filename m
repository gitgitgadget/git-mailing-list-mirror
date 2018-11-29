Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAC87211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeK3JG0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46516 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeK3JGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id v15-v6so3127614ljh.13
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=maCwBE2ggNz841uJEXNgt841cKqEClMxyofHxOnisY8=;
        b=ajgc7Ps87DFcLiEp3dHYkuTlCFsO1i3OTcwfGXT6O0VryZuh/3XxgPrp8xiT75TTPM
         9ltsjlOMwBWKAifdeyHXvrCfltf+0B4H0VMmahwmkqP5ZzgGtJwd6Z9X/nzIX7HjmO4+
         rwkYNK4UsEn112tOn3va+tOZVOPf9QyNA8hfX9tUHzaQ5zWCP9z+ZUx3mm+YLH38cv3I
         Vduhu8J0EIIP8WdrNhsPyolEaoMgaacV8wfd+tbstItmNfMfnSR12lZuQyetsAbmoTPI
         iOjK1LKkt/qRdU5fulTC+sIn7wpvP5tuasJeMeb1UXkjOuFuatFLclVM8KqHnMTUJbeG
         BDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=maCwBE2ggNz841uJEXNgt841cKqEClMxyofHxOnisY8=;
        b=JEkaFZhlKzieUr3niXae1O0Va2ZUh6I7k3n/CZN++nUioP6o4xrzbh3vQ2wxjTTnw5
         YyrmNdP1otVES/cxeNbRasUd9KAyZCULjWk4foDltI1KmIZitLtTGD9zRAAAys3ZTxCy
         YwUghB+8OnzfurO2YM/NXXMdLBla4utelWg1OxSjSN7HoG6uyn2DUSvgf46FVabxDEM1
         51qfeeIqz2WlXVfeqYPEsGJxhzg+lt7v6p7TN96s9klnJimtAr20LSsgOClcsHaSallx
         JPUR9hHjrm+01ya1IugIqmBTaWlGJxFJbDd05RD5rZkkQ7YHhX+kOd+NmKNgQaahIPMt
         fqJQ==
X-Gm-Message-State: AA+aEWbNlNiN5Y5eJ4ifSp0E7MEcRM6kJoYMhX2uoeY3YPRaQmySUHoo
        C5A1m4OWLHtzEAW6UPCkNhY=
X-Google-Smtp-Source: AFSGD/VIxuIp6/4XeiK1McVR+s9nnHmzv4Avn5ZIW9RR7eou0Y1EcN8REHrBDNS9mah7wAGDZ/2GyQ==
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr2383217ljj.161.1543528768447;
        Thu, 29 Nov 2018 13:59:28 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:27 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 14/14] doc: promote "git switch-branch" and "git restore-files"
Date:   Thu, 29 Nov 2018 22:58:49 +0100
Message-Id: <20181129215850.7278-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The two new commands "git switch-branch" and "git restore-files" are
added to avoid the confusion of one-command-do-all "git checkout" for
new users. They are also helpful to avoid ambiguation context.

For these reasons, promote them everywhere possible. This includes
documentation, suggestions/advice from other commands...

"git checkout" is also removed from "git help" (i.e. it's no longer
considered a commonly used command)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config/advice.txt        | 10 +++--
 Documentation/config/checkout.txt      |  5 ++-
 Documentation/git-branch.txt           |  8 ++--
 Documentation/git-check-ref-format.txt |  2 +-
 Documentation/git-format-patch.txt     |  2 +-
 Documentation/git-merge-base.txt       |  2 +-
 Documentation/git-rebase.txt           |  2 +-
 Documentation/git-remote.txt           |  2 +-
 Documentation/git-rerere.txt           | 10 ++---
 Documentation/git-reset.txt            | 18 ++++-----
 Documentation/git-revert.txt           |  2 +-
 Documentation/git-stash.txt            |  6 +--
 Documentation/gitattributes.txt        |  2 +-
 Documentation/gitcli.txt               |  4 +-
 Documentation/gitcore-tutorial.txt     | 18 ++++-----
 Documentation/giteveryday.txt          | 24 ++++++------
 Documentation/githooks.txt             |  5 ++-
 Documentation/gittutorial-2.txt        |  2 +-
 Documentation/gittutorial.txt          |  4 +-
 Documentation/revisions.txt            |  2 +-
 Documentation/user-manual.txt          | 54 +++++++++++++-------------
 advice.c                               | 11 ++++--
 command-list.txt                       |  2 +-
 sha1-name.c                            |  2 +-
 wt-status.c                            |  2 +-
 25 files changed, 104 insertions(+), 97 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 57fcd4c862..bffc503385 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -35,7 +35,8 @@ advice.*::
 		state in the output of linkgit:git-status[1], in
 		the template shown when writing commit messages in
 		linkgit:git-commit[1], and in the help message shown
-		by linkgit:git-checkout[1] when switching branch.
+		by linkgit:git-switch-branch[1] or
+		linkgit:git-checkout[1] when switching branch.
 	statusUoption::
 		Advise to consider using the `-u` option to linkgit:git-status[1]
 		when the command takes more than 2 seconds to enumerate untracked
@@ -55,9 +56,10 @@ advice.*::
 		your information is guessed from the system username and
 		domain name.
 	detachedHead::
-		Advice shown when you used linkgit:git-checkout[1] to
-		move to the detach HEAD state, to instruct how to create
-		a local branch after the fact.
+		Advice shown when you used
+		linkgit:git-switch-branch[1] or linkgit:git-checkout[1]
+		to move to the detach HEAD state, to instruct how to
+		create a local branch after the fact.
 	checkoutAmbiguousRemoteBranchName::
 		Advice shown when the argument to
 		linkgit:git-checkout[1] ambiguously resolves to a
diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index c4118fa196..81b0d47ced 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -8,8 +8,9 @@ checkout.defaultRemote::
 	disambiguation. The typical use-case is to set this to
 	`origin`.
 +
-Currently this is used by linkgit:git-checkout[1] when 'git checkout
-<something>' will checkout the '<something>' branch on another remote,
+Currently this is used by linkgit:git-switch-branch[1] and
+linkgit:git-checkout[1] when 'git checkout <something>'
+will checkout the '<something>' branch on another remote,
 and by linkgit:git-worktree[1] when 'git worktree add' refers to a
 remote branch. This setting might be used for other checkout-like
 commands or functionality in the future.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index bf5316ffa9..1564df47d2 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -48,7 +48,7 @@ The command's second form creates a new branch head named <branchname>
 which points to the current `HEAD`, or <start-point> if given.
 
 Note that this will create the new branch, but it will not switch the
-working tree to it; use "git checkout <newbranch>" to switch to the
+working tree to it; use "git switch-branch <newbranch>" to switch to the
 new branch.
 
 When a local branch is started off a remote-tracking branch, Git sets up the
@@ -194,7 +194,7 @@ This option is only applicable in non-verbose mode.
 +
 This behavior is the default when the start point is a remote-tracking branch.
 Set the branch.autoSetupMerge configuration variable to `false` if you
-want `git checkout` and `git branch` to always behave as if `--no-track`
+want `git switch-branch` and `git branch` to always behave as if `--no-track`
 were given. Set it to `always` if you want this behavior when the
 start-point is either a local or remote-tracking branch.
 
@@ -293,7 +293,7 @@ Start development from a known tag::
 $ git clone git://git.kernel.org/pub/scm/.../linux-2.6 my2.6
 $ cd my2.6
 $ git branch my2.6.14 v2.6.14   <1>
-$ git checkout my2.6.14
+$ git switch-branch my2.6.14
 ------------
 +
 <1> This step and the next one could be combined into a single step with
@@ -319,7 +319,7 @@ NOTES
 -----
 
 If you are creating a branch that you want to checkout immediately, it is
-easier to use the git checkout command with its `-b` option to create
+easier to use the "git switch-branch" command with its `-b` option to create
 a branch and check it out with a single command.
 
 The options `--contains`, `--no-contains`, `--merged` and `--no-merged`
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index d9de992585..38c2169d7a 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -88,7 +88,7 @@ but it is explicitly forbidden at the beginning of a branch name).
 When run with `--branch` option in a repository, the input is first
 expanded for the ``previous checkout syntax''
 `@{-n}`.  For example, `@{-1}` is a way to refer the last thing that
-was checked out using "git checkout" operation. This option should be
+was checked out using "git switch-branch" operation. This option should be
 used by porcelains to accept this syntax anywhere a branch name is
 expected, so they can act as if you typed the branch name. As an
 exception note that, the ``previous checkout operation'' might result
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index aba4c5febe..0ceaa1173c 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -416,7 +416,7 @@ One way to test if your MUA is set up correctly is:
 * Apply it:
 
     $ git fetch <project> master:test-apply
-    $ git checkout test-apply
+    $ git switch-branch test-apply
     $ git reset --hard
     $ git am a.patch
 
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 9f07f4f6ed..1b25e5d530 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -149,7 +149,7 @@ instead.
 Discussion on fork-point mode
 -----------------------------
 
-After working on the `topic` branch created with `git checkout -b
+After working on the `topic` branch created with `git switch-branch -b
 topic origin/master`, the history of remote-tracking branch
 `origin/master` may have been rewound and rebuilt, leading to a
 history of this shape:
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 80793bad8d..fe10880633 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 If <branch> is specified, 'git rebase' will perform an automatic
-`git checkout <branch>` before doing anything else.  Otherwise
+`git switch-branch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
 
 If <upstream> is not specified, the upstream configured in
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 0cad37fb81..044bbdb27c 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -230,7 +230,7 @@ $ git branch -r
   staging/master
   staging/staging-linus
   staging/staging-next
-$ git checkout -b staging staging/master
+$ git switch-branch -b staging staging/master
 ...
 ------------
 
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index df310d2a58..fe9d21b395 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -91,7 +91,7 @@ For such a test, you need to merge master and topic somehow.
 One way to do it is to pull master into the topic branch:
 
 ------------
-	$ git checkout topic
+	$ git switch-branch topic
 	$ git merge master
 
               o---*---o---+ topic
@@ -113,10 +113,10 @@ the upstream might have been advanced since the test merge `+`,
 in which case the final commit graph would look like this:
 
 ------------
-	$ git checkout topic
+	$ git switch-branch topic
 	$ git merge master
 	$ ... work on both topic and master branches
-	$ git checkout master
+	$ git switch-branch master
 	$ git merge topic
 
               o---*---o---+---o---o topic
@@ -136,11 +136,11 @@ merges, you could blow away the test merge, and keep building on
 top of the tip before the test merge:
 
 ------------
-	$ git checkout topic
+	$ git switch-branch topic
 	$ git merge master
 	$ git reset --hard HEAD^ ;# rewind the test merge
 	$ ... work on both topic and master branches
-	$ git checkout master
+	$ git switch-branch master
 	$ git merge topic
 
               o---*---o-------o---o topic
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 2dac95c71a..ca46b4c967 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -149,9 +149,9 @@ See also the --amend option to linkgit:git-commit[1].
 Undo a commit, making it a topic branch::
 +
 ------------
-$ git branch topic/wip     <1>
-$ git reset --hard HEAD~3  <2>
-$ git checkout topic/wip   <3>
+$ git branch topic/wip          <1>
+$ git reset --hard HEAD~3       <2>
+$ git switch-branch topic/wip   <3>
 ------------
 +
 <1> You have made some commits, but realize they were premature
@@ -232,13 +232,13 @@ working tree are not in any shape to be committed yet, but you
 need to get to the other branch for a quick bugfix.
 +
 ------------
-$ git checkout feature ;# you were working in "feature" branch and
+$ git switch-branch feature ;# you were working in "feature" branch and
 $ work work work       ;# got interrupted
 $ git commit -a -m "snapshot WIP"                 <1>
-$ git checkout master
+$ git switch-branch master
 $ fix fix fix
 $ git commit ;# commit with real log
-$ git checkout feature
+$ git switch-branch feature
 $ git reset --soft HEAD^ ;# go back to WIP state  <2>
 $ git reset                                       <3>
 ------------
@@ -279,18 +279,18 @@ reset it while keeping the changes in your working tree.
 +
 ------------
 $ git tag start
-$ git checkout -b branch1
+$ git switch-branch -b branch1
 $ edit
 $ git commit ...                            <1>
 $ edit
-$ git checkout -b branch2                   <2>
+$ git switch-branch -b branch2              <2>
 $ git reset --keep start                    <3>
 ------------
 +
 <1> This commits your first edits in branch1.
 <2> In the ideal world, you could have realized that the earlier
     commit did not belong to the new topic when you created and switched
-    to branch2 (i.e. "git checkout -b branch2 start"), but nobody is
+    to branch2 (i.e. "git switch-branch -b branch2 start"), but nobody is
     perfect.
 <3> But you can use "reset --keep" to remove the unwanted commit after
     you switched to "branch2".
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 837707a8fd..07ef83866b 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -26,7 +26,7 @@ effect of some earlier commits (often only a faulty one).  If you want to
 throw away all uncommitted changes in your working directory, you
 should see linkgit:git-reset[1], particularly the `--hard` option.  If
 you want to extract specific files as they were in another commit, you
-should see linkgit:git-checkout[1], specifically the `git checkout
+should see linkgit:git-checkout[1], specifically the `git restore-files
 <commit> -- <filename>` syntax.  Take care with these alternatives as
 both will discard uncommitted changes in your working directory.
 
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 7ef8c47911..ea226979b1 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -235,12 +235,12 @@ return to your original branch to make the emergency fix, like this:
 +
 ----------------------------------------------------------------
 # ... hack hack hack ...
-$ git checkout -b my_wip
+$ git switch-branch -b my_wip
 $ git commit -a -m "WIP"
-$ git checkout master
+$ git switch-branch master
 $ edit emergency fix
 $ git commit -a -m "Fix in a hurry"
-$ git checkout my_wip
+$ git switch-branch my_wip
 $ git reset --soft HEAD^
 # ... continue hacking ...
 ----------------------------------------------------------------
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b8392fc330..df62bd8019 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -112,7 +112,7 @@ Checking-out and checking-in
 
 These attributes affect how the contents stored in the
 repository are copied to the working tree files when commands
-such as 'git checkout' and 'git merge' run.  They also affect how
+such as 'git switch-branch' and 'git merge' run.  They also affect how
 Git stores the contents you prepare in the working tree in the
 repository upon 'git add' and 'git commit'.
 
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 592e06d839..491eb91c2e 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -47,8 +47,8 @@ disambiguating `--` at appropriate places.
    things:
 +
 --------------------------------
-$ git checkout -- *.c
-$ git checkout -- \*.c
+$ git restore-files -- *.c
+$ git restore-files -- \*.c
 --------------------------------
 +
 The former lets your shell expand the fileglob, and you are asking
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index e29a9effcc..49a8b5aa52 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -741,7 +741,7 @@ used earlier, and create a branch in it. You do that by simply just
 saying that you want to check out a new branch:
 
 ------------
-$ git checkout -b mybranch
+$ git branch mybranch
 ------------
 
 will create a new branch based at the current `HEAD` position, and switch
@@ -755,7 +755,7 @@ just telling 'git checkout' what the base of the checkout would be.
 In other words, if you have an earlier tag or branch, you'd just do
 
 ------------
-$ git checkout -b mybranch earlier-commit
+$ git switch-branch -b mybranch earlier-commit
 ------------
 
 and it would create the new branch `mybranch` at the earlier commit,
@@ -765,7 +765,7 @@ and check out the state at that time.
 You can always just jump back to your original `master` branch by doing
 
 ------------
-$ git checkout master
+$ git switch-branch master
 ------------
 
 (or any other branch-name, for that matter) and if you forget which
@@ -794,7 +794,7 @@ $ git branch <branchname> [startingpoint]
 
 which will simply _create_ the branch, but will not do anything further.
 You can then later -- once you decide that you want to actually develop
-on that branch -- switch to that branch with a regular 'git checkout'
+on that branch -- switch to that branch with a regular 'git switch-branch
 with the branchname as the argument.
 
 
@@ -808,7 +808,7 @@ being the same as the original `master` branch, let's make sure we're in
 that branch, and do some work there.
 
 ------------------------------------------------
-$ git checkout mybranch
+$ git switch-branch mybranch
 $ echo "Work, work, work" >>hello
 $ git commit -m "Some work." -i hello
 ------------------------------------------------
@@ -825,7 +825,7 @@ does some work in the original branch, and simulate that by going back
 to the master branch, and editing the same file differently there:
 
 ------------
-$ git checkout master
+$ git switch-branch master
 ------------
 
 Here, take a moment to look at the contents of `hello`, and notice how they
@@ -958,7 +958,7 @@ to the `master` branch. Let's go back to `mybranch`, and run
 'git merge' to get the "upstream changes" back to your branch.
 
 ------------
-$ git checkout mybranch
+$ git switch-branch mybranch
 $ git merge -m "Merge upstream changes." master
 ------------
 
@@ -1133,9 +1133,9 @@ Remember, before running 'git merge', our `master` head was at
 work." commit.
 
 ------------
-$ git checkout mybranch
+$ git switch-branch mybranch
 $ git reset --hard master^2
-$ git checkout master
+$ git switch-branch master
 $ git reset --hard master^
 ------------
 
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index 9f2528fc8c..9d64544bb9 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -80,9 +80,9 @@ $ git tag v2.43 <2>
 Create a topic branch and develop.::
 +
 ------------
-$ git checkout -b alsa-audio <1>
+$ git branch alsa-audio <1>
 $ edit/compile/test
-$ git checkout -- curses/ux_audio_oss.c <2>
+$ git restore-files -- curses/ux_audio_oss.c <2>
 $ git add curses/ux_audio_alsa.c <3>
 $ edit/compile/test
 $ git diff HEAD <4>
@@ -90,7 +90,7 @@ $ git commit -a -s <5>
 $ edit/compile/test
 $ git diff HEAD^ <6>
 $ git commit -a --amend <7>
-$ git checkout master <8>
+$ git switch-branch master <8>
 $ git merge alsa-audio <9>
 $ git log --since='3 days ago' <10>
 $ git log v2.43.. curses/ <11>
@@ -148,11 +148,11 @@ Clone the upstream and work on it.  Feed changes to upstream.::
 ------------
 $ git clone git://git.kernel.org/pub/scm/.../torvalds/linux-2.6 my2.6
 $ cd my2.6
-$ git checkout -b mine master <1>
+$ git switch-branch -b mine master <1>
 $ edit/compile/test; git commit -a -s <2>
 $ git format-patch master <3>
 $ git send-email --to="person <email@example.com>" 00*.patch <4>
-$ git checkout master <5>
+$ git switch-branch master <5>
 $ git pull <6>
 $ git log -p ORIG_HEAD.. arch/i386 include/asm-i386 <7>
 $ git ls-remote --heads http://git.kernel.org/.../jgarzik/libata-dev.git <8>
@@ -194,7 +194,7 @@ satellite$ edit/compile/test/commit
 satellite$ git push origin <4>
 
 mothership$ cd frotz
-mothership$ git checkout master
+mothership$ git switch-branch master
 mothership$ git merge satellite/master <5>
 ------------
 +
@@ -216,7 +216,7 @@ machine into the master branch.
 Branch off of a specific tag.::
 +
 ------------
-$ git checkout -b private2.6.14 v2.6.14 <1>
+$ git switch-branch -b private2.6.14 v2.6.14 <1>
 $ edit/compile/test; git commit -a
 $ git checkout master
 $ git cherry-pick v2.6.14..private2.6.14 <2>
@@ -274,14 +274,14 @@ $ mailx <3>
 & s 2 3 4 5 ./+to-apply
 & s 7 8 ./+hold-linus
 & q
-$ git checkout -b topic/one master
+$ git switch-branch -b topic/one master
 $ git am -3 -i -s ./+to-apply <4>
 $ compile/test
-$ git checkout -b hold/linus && git am -3 -i -s ./+hold-linus <5>
-$ git checkout topic/one && git rebase master <6>
-$ git checkout pu && git reset --hard next <7>
+$ git switch-branch -b hold/linus && git am -3 -i -s ./+hold-linus <5>
+$ git switch-branch topic/one && git rebase master <6>
+$ git switch-branch pu && git reset --hard next <7>
 $ git merge topic/one topic/two && git merge hold/linus <8>
-$ git checkout maint
+$ git switch-branch maint
 $ git cherry-pick master~4 <9>
 $ compile/test
 $ git tag -s -m "GIT 0.99.9x" v0.99.9x <10>
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 959044347e..3939ec774a 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -166,7 +166,7 @@ worktree.  The hook is given three parameters: the ref of the previous HEAD,
 the ref of the new HEAD (which may or may not have changed), and a flag
 indicating whether the checkout was a branch checkout (changing branches,
 flag=1) or a file checkout (retrieving a file from the index, flag=0).
-This hook cannot affect the outcome of `git checkout`.
+This hook cannot affect the outcome of `git switch-branch` or `git checkout`.
 
 It is also run after linkgit:git-clone[1], unless the `--no-checkout` (`-n`) option is
 used. The first parameter given to the hook is the null-ref, the second the
@@ -402,7 +402,8 @@ exit with a zero status.
 For example, the hook can simply run `git read-tree -u -m HEAD "$1"`
 in order to emulate `git fetch` that is run in the reverse direction
 with `git push`, as the two-tree form of `git read-tree -u -m` is
-essentially the same as `git checkout` that switches branches while
+essentially the same as `git switch-branch` or `git checkout`
+that switches branches while
 keeping the local changes in the working tree that do not interfere
 with the difference between the branches.
 
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index e0976f6017..1ec14da6b4 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -376,7 +376,7 @@ Changes to be committed:
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git restore-files -- <file>..." to discard changes in working directory)
 
 	modified:   file.txt
 
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 242de31cb6..396e55c191 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -207,7 +207,7 @@ automatically.  The asterisk marks the branch you are currently on;
 type
 
 ------------------------------------------------
-$ git checkout experimental
+$ git switch-branch experimental
 ------------------------------------------------
 
 to switch to the experimental branch.  Now edit a file, commit the
@@ -216,7 +216,7 @@ change, and switch back to the master branch:
 ------------------------------------------------
 (edit file)
 $ git commit -a
-$ git checkout master
+$ git switch-branch master
 ------------------------------------------------
 
 Check that the change you made is no longer visible, since it was
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 72daa20e76..f55502cd50 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -115,7 +115,7 @@ Here's an example to make it more clear:
 ------------------------------
 $ git config push.default current
 $ git config remote.pushdefault myfork
-$ git checkout -b mybranch origin/master
+$ git switch-branch -b mybranch origin/master
 
 $ git rev-parse --symbolic-full-name @{upstream}
 refs/remotes/origin/master
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index eff7890274..e3ff98077d 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -125,7 +125,7 @@ Create a new branch head pointing to one of these versions and check it
 out using linkgit:git-checkout[1]:
 
 ------------------------------------------------
-$ git checkout -b new v2.6.13
+$ git switch-branch -b new v2.6.13
 ------------------------------------------------
 
 The working directory then reflects the contents that the project had
@@ -282,10 +282,10 @@ a summary of the commands:
 	this command will fail with a warning.
 `git branch -D <branch>`::
 	delete the branch `<branch>` irrespective of its merged status.
-`git checkout <branch>`::
+`git switch-branch <branch>`::
 	make the current branch `<branch>`, updating the working
 	directory to reflect the version referenced by `<branch>`.
-`git checkout -b <new> <start-point>`::
+`git switch-branch -b <new> <start-point>`::
 	create a new branch `<new>` referencing `<start-point>`, and
 	check it out.
 
@@ -302,12 +302,12 @@ ref: refs/heads/master
 Examining an old version without creating a new branch
 ------------------------------------------------------
 
-The `git checkout` command normally expects a branch head, but will also
+The `git switch-branch` command normally expects a branch head, but will also
 accept an arbitrary commit; for example, you can check out the commit
 referenced by a tag:
 
 ------------------------------------------------
-$ git checkout v2.6.17
+$ git switch-branch v2.6.17
 Note: checking out 'v2.6.17'.
 
 You are in 'detached HEAD' state. You can look around, make experimental
@@ -317,7 +317,7 @@ state without impacting any branches by performing another checkout.
 If you want to create a new branch to retain commits you create, you may
 do so (now or later) by using -b with the checkout command again. Example:
 
-  git checkout -b new_branch_name
+  git switch-branch -b new_branch_name
 
 HEAD is now at 427abfa Linux v2.6.17
 ------------------------------------------------
@@ -373,7 +373,7 @@ You might want to build on one of these remote-tracking branches
 on a branch of your own, just as you would for a tag:
 
 ------------------------------------------------
-$ git checkout -b my-todo-copy origin/todo
+$ git switch-branch -b my-todo-copy origin/todo
 ------------------------------------------------
 
 You can also check out `origin/todo` directly to examine it or
@@ -1523,12 +1523,12 @@ Checking out an old version of a file
 
 In the process of undoing a previous bad change, you may find it
 useful to check out an older version of a particular file using
-linkgit:git-checkout[1].  We've used `git checkout` before to switch
+linkgit:git-checkout[1].  We've used `git switch-branch` before to switch
 branches, but it has quite different behavior if it is given a path
 name: the command
 
 -------------------------------------------------
-$ git checkout HEAD^ path/to/file
+$ git restore-files HEAD^ path/to/file
 -------------------------------------------------
 
 replaces path/to/file by the contents it had in the commit HEAD^, and
@@ -2211,8 +2211,8 @@ $ git branch --track release origin/master
 These can be easily kept up to date using linkgit:git-pull[1].
 
 -------------------------------------------------
-$ git checkout test && git pull
-$ git checkout release && git pull
+$ git switch-branch test && git pull
+$ git switch-branch release && git pull
 -------------------------------------------------
 
 Important note!  If you have any local changes in these branches, then
@@ -2264,7 +2264,7 @@ tested changes
 2) help future bug hunters that use `git bisect` to find problems
 
 -------------------------------------------------
-$ git checkout -b speed-up-spinlocks v2.6.35
+$ git switch-branch -b speed-up-spinlocks v2.6.35
 -------------------------------------------------
 
 Now you apply the patch(es), run some tests, and commit the change(s).  If
@@ -2279,7 +2279,7 @@ When you are happy with the state of this change, you can merge it into the
 "test" branch in preparation to make it public:
 
 -------------------------------------------------
-$ git checkout test && git merge speed-up-spinlocks
+$ git switch-branch test && git merge speed-up-spinlocks
 -------------------------------------------------
 
 It is unlikely that you would have any conflicts here ... but you might if you
@@ -2291,7 +2291,7 @@ see the value of keeping each patch (or patch series) in its own branch.  It
 means that the patches can be moved into the `release` tree in any order.
 
 -------------------------------------------------
-$ git checkout release && git merge speed-up-spinlocks
+$ git switch-branch release && git merge speed-up-spinlocks
 -------------------------------------------------
 
 After a while, you will have a number of branches, and despite the
@@ -2358,7 +2358,7 @@ Here are some of the scripts that simplify all this even further.
 
 case "$1" in
 test|release)
-	git checkout $1 && git pull . origin
+	git switch-branch $1 && git pull . origin
 	;;
 origin)
 	before=$(git rev-parse refs/remotes/origin/master)
@@ -2400,7 +2400,7 @@ test|release)
 		echo $1 already merged into $2 1>&2
 		exit 1
 	fi
-	git checkout $2 && git pull . $1
+	git switch-branch $2 && git pull . $1
 	;;
 *)
 	usage
@@ -2512,7 +2512,7 @@ Suppose that you create a branch `mywork` on a remote-tracking branch
 `origin`, and create some commits on top of it:
 
 -------------------------------------------------
-$ git checkout -b mywork origin
+$ git switch-branch -b mywork origin
 $ vi file.txt
 $ git commit
 $ vi otherfile.txt
@@ -2552,7 +2552,7 @@ commits without any merges, you may instead choose to use
 linkgit:git-rebase[1]:
 
 -------------------------------------------------
-$ git checkout mywork
+$ git switch-branch mywork
 $ git rebase origin
 -------------------------------------------------
 
@@ -3668,13 +3668,13 @@ change within the submodule, and then update the superproject to reference the
 new commit:
 
 -------------------------------------------------
-$ git checkout master
+$ git switch-branch master
 -------------------------------------------------
 
 or
 
 -------------------------------------------------
-$ git checkout -b fix-up
+$ git switch-branch -b fix-up
 -------------------------------------------------
 
 then
@@ -4194,7 +4194,7 @@ start.
 A good place to start is with the contents of the initial commit, with:
 
 ----------------------------------------------------
-$ git checkout e83c5163
+$ git switch-branch e83c5163
 ----------------------------------------------------
 
 The initial revision lays the foundation for almost everything Git has
@@ -4437,10 +4437,10 @@ Managing branches
 -----------------
 
 -----------------------------------------------
-$ git branch	     # list all local branches in this repo
-$ git checkout test  # switch working directory to branch "test"
-$ git branch new     # create branch "new" starting at current HEAD
-$ git branch -d new  # delete branch "new"
+$ git branch			# list all local branches in this repo
+$ git switch-branch test	# switch working directory to branch "test"
+$ git branch new		# create branch "new" starting at current HEAD
+$ git branch -d new		# delete branch "new"
 -----------------------------------------------
 
 Instead of basing a new branch on current HEAD (the default), use:
@@ -4456,7 +4456,7 @@ $ git branch new test~10 # ten commits before tip of branch "test"
 Create and switch to a new branch at the same time:
 
 -----------------------------------------------
-$ git checkout -b new v2.6.15
+$ git switch-branch -b new v2.6.15
 -----------------------------------------------
 
 Update and examine branches from the repository you cloned from:
@@ -4467,7 +4467,7 @@ $ git branch -r		# list
   origin/master
   origin/next
   ...
-$ git checkout -b masterwork origin/master
+$ git switch-branch -b masterwork origin/master
 -----------------------------------------------
 
 Fetch a branch from a different repository, and give it a new
diff --git a/advice.c b/advice.c
index 5f35656409..578ea31c7e 100644
--- a/advice.c
+++ b/advice.c
@@ -189,13 +189,16 @@ void NORETURN die_conclude_merge(void)
 void detach_advice(const char *new_name)
 {
 	const char *fmt =
-	_("Note: checking out '%s'.\n\n"
+	_("Note: checking out '%s'.\n"
+	"\n"
 	"You are in 'detached HEAD' state. You can look around, make experimental\n"
 	"changes and commit them, and you can discard any commits you make in this\n"
-	"state without impacting any branches by performing another checkout.\n\n"
+	"state without impacting any branches by performing another checkout.\n"
+	"\n"
 	"If you want to create a new branch to retain commits you create, you may\n"
-	"do so (now or later) by using -b with the checkout command again. Example:\n\n"
-	"  git checkout -b <new-branch-name>\n\n");
+	"do so (now or later) by using -b with the checkout command again. Example:\n"
+	"\n"
+	"  git switch-branch -b <new-branch-name>\n\n");
 
 	fprintf(stderr, fmt, new_name);
 }
diff --git a/command-list.txt b/command-list.txt
index 4638802754..d1fb1d551d 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -59,7 +59,7 @@ git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
 git-check-ignore                        purehelpers
 git-check-mailmap                       purehelpers
-git-checkout                            mainporcelain           history
+git-checkout                            mainporcelain
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
 git-cherry                              plumbinginterrogators          complete
diff --git a/sha1-name.c b/sha1-name.c
index faa60f69e3..4e4e14a45c 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -771,7 +771,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 	"because it will be ignored when you just specify 40-hex. These refs\n"
 	"may be created by mistake. For example,\n"
 	"\n"
-	"  git checkout -b $br $(git rev-parse ...)\n"
+	"  git switch-branch -b $br $(git rev-parse ...)\n"
 	"\n"
 	"where \"$br\" is somehow empty and a 40-hex ref is created. Please\n"
 	"examine these refs and maybe delete them. Turn this message off by\n"
diff --git a/wt-status.c b/wt-status.c
index a24711374c..c615cac607 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -224,7 +224,7 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
 		status_printf_ln(s, c, _("  (use \"git add <file>...\" to update what will be committed)"));
 	else
 		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" to update what will be committed)"));
-	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
+	status_printf_ln(s, c, _("  (use \"git restore-files <file>...\" to discard changes in working directory)"));
 	if (has_dirty_submodules)
 		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
 	status_printf_ln(s, c, "%s", "");
-- 
2.20.0.rc1.380.g3eb999425c.dirty

