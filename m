Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E3B01F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfA3JuK (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:50:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33702 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfA3JuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:50:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so11203622pfb.0
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kvscB238c8KgWV+arqviP3xXbH6wyylQdQjJbXKx1iI=;
        b=S8GHWFuiJ3FTjt555vOh2RwwC5svMcRtGEhQ/4GuO4FA9vFUyepn1vLtgWFTLLGmth
         TVIOTpbgQCpFY9eLumYLktUqhPr3InLrfGlA/90QpgDM8sWNRquoBWeIS0yv2ap0wxMi
         jR8z51j4EBM1bCgEU4C4QHFmpRg8+rAXqyEj/FLSyqdNcg7ITSHP85dzJU/oB114cW7S
         AroAT6TxJQqzOs9UV7gZtHc0aYjDm99wHzjBFRejbUKZk0fg5TS/Xv270ryUAATzIhU9
         16XMvNCDZv5KS2pn0/YPuEAT0xPT2bXJwIESmLKf6ZAM3iVRrNQewinoUYxy07lRYC41
         FOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kvscB238c8KgWV+arqviP3xXbH6wyylQdQjJbXKx1iI=;
        b=UIp5pxt8v6VubAUjjZIsPJDkirdv4bKrAWC6ddlTTgUU865o7Ywx+TBVvcTy5GwKn2
         QYWm9b82idThA7TxmNTdTdbJXACQNK8YdpJD1mzCpKONg0ZYBWah1LjBLByIjiU+Nq19
         n92GKWm6GclwcA4tE/F+70RqEaO6czEHnwZu//mWdWOqM41pwdDtlfKatt/sRzDP4h03
         UQ4/eECdQlHCjzTnP6xVpF7Tw/AXbwafzk89cDqvTFT3ZPu5fUrBYY+f380A8iIm3sQh
         krpgtmYo9xrcY721B0SDV0SngiX6tLCmw8lkK9pjox0Tz7++j6R1O9Bw+7764xhE1TPb
         tB8g==
X-Gm-Message-State: AJcUukeARLZ094Khi2tWBl83eySpZRY6khRlOA9r8m3Ve+MFiKuLUr7z
        6RO6Jqvf0B2nkGqzBJD297SN/U7R
X-Google-Smtp-Source: ALg8bN6FsxJuok0SG9uWe7d8wVSfNUo7hR3xF44VgJW64FRxzXULerAlD1EsWjO+V4YvOIZRg93jiw==
X-Received: by 2002:a65:520a:: with SMTP id o10mr27803690pgp.276.1548841807715;
        Wed, 30 Jan 2019 01:50:07 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id a18sm1227986pgj.30.2019.01.30.01.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:50:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:50:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/19] doc: promote "git switch"
Date:   Wed, 30 Jan 2019 16:48:31 +0700
Message-Id: <20190130094831.10420-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new command "git switch" is added to avoid the confusion of
one-command-do-all "git checkout" for new users. They are also helpful
to avoid ambiguation context.

For these reasons, promote it everywhere possible. This includes
documentation, suggestions/advice from other commands...

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-branch.txt           |  8 ++--
 Documentation/git-check-ref-format.txt |  3 +-
 Documentation/git-format-patch.txt     |  2 +-
 Documentation/git-merge-base.txt       |  2 +-
 Documentation/git-rebase.txt           |  2 +-
 Documentation/git-remote.txt           |  2 +-
 Documentation/git-rerere.txt           | 10 ++---
 Documentation/git-reset.txt            | 20 +++++-----
 Documentation/git-stash.txt            |  9 +++--
 Documentation/gitcore-tutorial.txt     | 18 ++++-----
 Documentation/giteveryday.txt          | 24 ++++++------
 Documentation/gittutorial.txt          |  4 +-
 Documentation/revisions.txt            |  2 +-
 Documentation/user-manual.txt          | 52 +++++++++++++-------------
 advice.c                               | 11 ++++--
 builtin/clone.c                        |  2 +-
 sha1-name.c                            |  2 +-
 t/t2020-checkout-detach.sh             |  4 +-
 18 files changed, 91 insertions(+), 86 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index bf5316ffa9..94c1f24414 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -48,7 +48,7 @@ The command's second form creates a new branch head named <branchname>
 which points to the current `HEAD`, or <start-point> if given.
 
 Note that this will create the new branch, but it will not switch the
-working tree to it; use "git checkout <newbranch>" to switch to the
+working tree to it; use "git switch <newbranch>" to switch to the
 new branch.
 
 When a local branch is started off a remote-tracking branch, Git sets up the
@@ -194,7 +194,7 @@ This option is only applicable in non-verbose mode.
 +
 This behavior is the default when the start point is a remote-tracking branch.
 Set the branch.autoSetupMerge configuration variable to `false` if you
-want `git checkout` and `git branch` to always behave as if `--no-track`
+want `git switch`, `git checkout` and `git branch` to always behave as if `--no-track`
 were given. Set it to `always` if you want this behavior when the
 start-point is either a local or remote-tracking branch.
 
@@ -293,7 +293,7 @@ Start development from a known tag::
 $ git clone git://git.kernel.org/pub/scm/.../linux-2.6 my2.6
 $ cd my2.6
 $ git branch my2.6.14 v2.6.14   <1>
-$ git checkout my2.6.14
+$ git switch my2.6.14
 ------------
 +
 <1> This step and the next one could be combined into a single step with
@@ -319,7 +319,7 @@ NOTES
 -----
 
 If you are creating a branch that you want to checkout immediately, it is
-easier to use the git checkout command with its `-b` option to create
+easier to use the "git switch" command with its `-c` option to create
 a branch and check it out with a single command.
 
 The options `--contains`, `--no-contains`, `--merged` and `--no-merged`
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index d9de992585..ee6a4144fb 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -88,7 +88,8 @@ but it is explicitly forbidden at the beginning of a branch name).
 When run with `--branch` option in a repository, the input is first
 expanded for the ``previous checkout syntax''
 `@{-n}`.  For example, `@{-1}` is a way to refer the last thing that
-was checked out using "git checkout" operation. This option should be
+was checked out using "git switch" or "git checkout" operation.
+This option should be
 used by porcelains to accept this syntax anywhere a branch name is
 expected, so they can act as if you typed the branch name. As an
 exception note that, the ``previous checkout operation'' might result
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 27304428a1..3d42853529 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -421,7 +421,7 @@ One way to test if your MUA is set up correctly is:
 * Apply it:
 
     $ git fetch <project> master:test-apply
-    $ git checkout test-apply
+    $ git switch test-apply
     $ git reset --hard
     $ git am a.patch
 
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 9f07f4f6ed..261d5c1164 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -149,7 +149,7 @@ instead.
 Discussion on fork-point mode
 -----------------------------
 
-After working on the `topic` branch created with `git checkout -b
+After working on the `topic` branch created with `git switch -c
 topic origin/master`, the history of remote-tracking branch
 `origin/master` may have been rewound and rebuilt, leading to a
 history of this shape:
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 4dd5853d6e..420777c10b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 If <branch> is specified, 'git rebase' will perform an automatic
-`git checkout <branch>` before doing anything else.  Otherwise
+`git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
 
 If <upstream> is not specified, the upstream configured in
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 0cad37fb81..9659abbf8e 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -230,7 +230,7 @@ $ git branch -r
   staging/master
   staging/staging-linus
   staging/staging-next
-$ git checkout -b staging staging/master
+$ git switch -c staging staging/master
 ...
 ------------
 
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index df310d2a58..fe4434ad9d 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -91,7 +91,7 @@ For such a test, you need to merge master and topic somehow.
 One way to do it is to pull master into the topic branch:
 
 ------------
-	$ git checkout topic
+	$ git switch topic
 	$ git merge master
 
               o---*---o---+ topic
@@ -113,10 +113,10 @@ the upstream might have been advanced since the test merge `+`,
 in which case the final commit graph would look like this:
 
 ------------
-	$ git checkout topic
+	$ git switch topic
 	$ git merge master
 	$ ... work on both topic and master branches
-	$ git checkout master
+	$ git switch master
 	$ git merge topic
 
               o---*---o---+---o---o topic
@@ -136,11 +136,11 @@ merges, you could blow away the test merge, and keep building on
 top of the tip before the test merge:
 
 ------------
-	$ git checkout topic
+	$ git switch topic
 	$ git merge master
 	$ git reset --hard HEAD^ ;# rewind the test merge
 	$ ... work on both topic and master branches
-	$ git checkout master
+	$ git switch master
 	$ git merge topic
 
               o---*---o-------o---o topic
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 9f69ae8b69..020ba838c9 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -149,9 +149,9 @@ See also the `--amend` option to linkgit:git-commit[1].
 Undo a commit, making it a topic branch::
 +
 ------------
-$ git branch topic/wip     <1>
-$ git reset --hard HEAD~3  <2>
-$ git checkout topic/wip   <3>
+$ git branch topic/wip          <1>
+$ git reset --hard HEAD~3       <2>
+$ git switch topic/wip          <3>
 ------------
 +
 <1> You have made some commits, but realize they were premature
@@ -232,13 +232,13 @@ working tree are not in any shape to be committed yet, but you
 need to get to the other branch for a quick bugfix.
 +
 ------------
-$ git checkout feature ;# you were working in "feature" branch and
-$ work work work       ;# got interrupted
+$ git switch feature  ;# you were working in "feature" branch and
+$ work work work      ;# got interrupted
 $ git commit -a -m "snapshot WIP"                 <1>
-$ git checkout master
+$ git switch master
 $ fix fix fix
 $ git commit ;# commit with real log
-$ git checkout feature
+$ git switch feature
 $ git reset --soft HEAD^ ;# go back to WIP state  <2>
 $ git reset                                       <3>
 ------------
@@ -279,18 +279,18 @@ reset it while keeping the changes in your working tree.
 +
 ------------
 $ git tag start
-$ git checkout -b branch1
+$ git switch -c branch1
 $ edit
 $ git commit ...                            <1>
 $ edit
-$ git checkout -b branch2                   <2>
+$ git switch -c branch2                     <2>
 $ git reset --keep start                    <3>
 ------------
 +
 <1> This commits your first edits in `branch1`.
 <2> In the ideal world, you could have realized that the earlier
     commit did not belong to the new topic when you created and switched
-    to `branch2` (i.e. `git checkout -b branch2 start`), but nobody is
+    to `branch2` (i.e. `git switch -c branch2 start`), but nobody is
     perfect.
 <3> But you can use `reset --keep` to remove the unwanted commit after
     you switched to `branch2`.
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 7ef8c47911..ebb6282db3 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -235,12 +235,12 @@ return to your original branch to make the emergency fix, like this:
 +
 ----------------------------------------------------------------
 # ... hack hack hack ...
-$ git checkout -b my_wip
+$ git switch -c my_wip
 $ git commit -a -m "WIP"
-$ git checkout master
+$ git switch master
 $ edit emergency fix
 $ git commit -a -m "Fix in a hurry"
-$ git checkout my_wip
+$ git switch my_wip
 $ git reset --soft HEAD^
 # ... continue hacking ...
 ----------------------------------------------------------------
@@ -293,7 +293,8 @@ SEE ALSO
 linkgit:git-checkout[1],
 linkgit:git-commit[1],
 linkgit:git-reflog[1],
-linkgit:git-reset[1]
+linkgit:git-reset[1],
+linkgit:git-switch[1]
 
 GIT
 ---
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index e29a9effcc..6bd0f192cc 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -741,7 +741,7 @@ used earlier, and create a branch in it. You do that by simply just
 saying that you want to check out a new branch:
 
 ------------
-$ git checkout -b mybranch
+$ git switch -c mybranch
 ------------
 
 will create a new branch based at the current `HEAD` position, and switch
@@ -755,7 +755,7 @@ just telling 'git checkout' what the base of the checkout would be.
 In other words, if you have an earlier tag or branch, you'd just do
 
 ------------
-$ git checkout -b mybranch earlier-commit
+$ git switch -c mybranch earlier-commit
 ------------
 
 and it would create the new branch `mybranch` at the earlier commit,
@@ -765,7 +765,7 @@ and check out the state at that time.
 You can always just jump back to your original `master` branch by doing
 
 ------------
-$ git checkout master
+$ git switch master
 ------------
 
 (or any other branch-name, for that matter) and if you forget which
@@ -794,7 +794,7 @@ $ git branch <branchname> [startingpoint]
 
 which will simply _create_ the branch, but will not do anything further.
 You can then later -- once you decide that you want to actually develop
-on that branch -- switch to that branch with a regular 'git checkout'
+on that branch -- switch to that branch with a regular 'git switch'
 with the branchname as the argument.
 
 
@@ -808,7 +808,7 @@ being the same as the original `master` branch, let's make sure we're in
 that branch, and do some work there.
 
 ------------------------------------------------
-$ git checkout mybranch
+$ git switch mybranch
 $ echo "Work, work, work" >>hello
 $ git commit -m "Some work." -i hello
 ------------------------------------------------
@@ -825,7 +825,7 @@ does some work in the original branch, and simulate that by going back
 to the master branch, and editing the same file differently there:
 
 ------------
-$ git checkout master
+$ git switch master
 ------------
 
 Here, take a moment to look at the contents of `hello`, and notice how they
@@ -958,7 +958,7 @@ to the `master` branch. Let's go back to `mybranch`, and run
 'git merge' to get the "upstream changes" back to your branch.
 
 ------------
-$ git checkout mybranch
+$ git switch mybranch
 $ git merge -m "Merge upstream changes." master
 ------------
 
@@ -1133,9 +1133,9 @@ Remember, before running 'git merge', our `master` head was at
 work." commit.
 
 ------------
-$ git checkout mybranch
+$ git switch mybranch
 $ git reset --hard master^2
-$ git checkout master
+$ git switch master
 $ git reset --hard master^
 ------------
 
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index 9f2528fc8c..38015026bb 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -41,7 +41,7 @@ following commands.
 
   * linkgit:git-log[1] to see what happened.
 
-  * linkgit:git-checkout[1] and linkgit:git-branch[1] to switch
+  * linkgit:git-switch[1] and linkgit:git-branch[1] to switch
     branches.
 
   * linkgit:git-add[1] to manage the index file.
@@ -80,7 +80,7 @@ $ git tag v2.43 <2>
 Create a topic branch and develop.::
 +
 ------------
-$ git checkout -b alsa-audio <1>
+$ git switch -c alsa-audio <1>
 $ edit/compile/test
 $ git checkout -- curses/ux_audio_oss.c <2>
 $ git add curses/ux_audio_alsa.c <3>
@@ -90,7 +90,7 @@ $ git commit -a -s <5>
 $ edit/compile/test
 $ git diff HEAD^ <6>
 $ git commit -a --amend <7>
-$ git checkout master <8>
+$ git switch master <8>
 $ git merge alsa-audio <9>
 $ git log --since='3 days ago' <10>
 $ git log v2.43.. curses/ <11>
@@ -148,11 +148,11 @@ Clone the upstream and work on it.  Feed changes to upstream.::
 ------------
 $ git clone git://git.kernel.org/pub/scm/.../torvalds/linux-2.6 my2.6
 $ cd my2.6
-$ git checkout -b mine master <1>
+$ git switch -c mine master <1>
 $ edit/compile/test; git commit -a -s <2>
 $ git format-patch master <3>
 $ git send-email --to="person <email@example.com>" 00*.patch <4>
-$ git checkout master <5>
+$ git switch master <5>
 $ git pull <6>
 $ git log -p ORIG_HEAD.. arch/i386 include/asm-i386 <7>
 $ git ls-remote --heads http://git.kernel.org/.../jgarzik/libata-dev.git <8>
@@ -194,7 +194,7 @@ satellite$ edit/compile/test/commit
 satellite$ git push origin <4>
 
 mothership$ cd frotz
-mothership$ git checkout master
+mothership$ git switch master
 mothership$ git merge satellite/master <5>
 ------------
 +
@@ -216,7 +216,7 @@ machine into the master branch.
 Branch off of a specific tag.::
 +
 ------------
-$ git checkout -b private2.6.14 v2.6.14 <1>
+$ git switch -c private2.6.14 v2.6.14 <1>
 $ edit/compile/test; git commit -a
 $ git checkout master
 $ git cherry-pick v2.6.14..private2.6.14 <2>
@@ -274,14 +274,14 @@ $ mailx <3>
 & s 2 3 4 5 ./+to-apply
 & s 7 8 ./+hold-linus
 & q
-$ git checkout -b topic/one master
+$ git switch -c topic/one master
 $ git am -3 -i -s ./+to-apply <4>
 $ compile/test
-$ git checkout -b hold/linus && git am -3 -i -s ./+hold-linus <5>
-$ git checkout topic/one && git rebase master <6>
-$ git checkout pu && git reset --hard next <7>
+$ git switch -c hold/linus && git am -3 -i -s ./+hold-linus <5>
+$ git switch topic/one && git rebase master <6>
+$ git switch pu && git reset --hard next <7>
 $ git merge topic/one topic/two && git merge hold/linus <8>
-$ git checkout maint
+$ git switch maint
 $ git cherry-pick master~4 <9>
 $ compile/test
 $ git tag -s -m "GIT 0.99.9x" v0.99.9x <10>
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 242de31cb6..e6ad6b5f8d 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -207,7 +207,7 @@ automatically.  The asterisk marks the branch you are currently on;
 type
 
 ------------------------------------------------
-$ git checkout experimental
+$ git switch experimental
 ------------------------------------------------
 
 to switch to the experimental branch.  Now edit a file, commit the
@@ -216,7 +216,7 @@ change, and switch back to the master branch:
 ------------------------------------------------
 (edit file)
 $ git commit -a
-$ git checkout master
+$ git switch master
 ------------------------------------------------
 
 Check that the change you made is no longer visible, since it was
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 72daa20e76..a1c7a65da6 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -115,7 +115,7 @@ Here's an example to make it more clear:
 ------------------------------
 $ git config push.default current
 $ git config remote.pushdefault myfork
-$ git checkout -b mybranch origin/master
+$ git switch -c mybranch origin/master
 
 $ git rev-parse --symbolic-full-name @{upstream}
 refs/remotes/origin/master
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index eff7890274..766e64d0e1 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -122,10 +122,10 @@ Tags are expected to always point at the same version of a project,
 while heads are expected to advance as development progresses.
 
 Create a new branch head pointing to one of these versions and check it
-out using linkgit:git-checkout[1]:
+out using linkgit:git-switch[1]:
 
 ------------------------------------------------
-$ git checkout -b new v2.6.13
+$ git switch -c new v2.6.13
 ------------------------------------------------
 
 The working directory then reflects the contents that the project had
@@ -282,10 +282,10 @@ a summary of the commands:
 	this command will fail with a warning.
 `git branch -D <branch>`::
 	delete the branch `<branch>` irrespective of its merged status.
-`git checkout <branch>`::
+`git switch <branch>`::
 	make the current branch `<branch>`, updating the working
 	directory to reflect the version referenced by `<branch>`.
-`git checkout -b <new> <start-point>`::
+`git switch -c <new> <start-point>`::
 	create a new branch `<new>` referencing `<start-point>`, and
 	check it out.
 
@@ -302,22 +302,22 @@ ref: refs/heads/master
 Examining an old version without creating a new branch
 ------------------------------------------------------
 
-The `git checkout` command normally expects a branch head, but will also
+The `git switch` command normally expects a branch head, but will also
 accept an arbitrary commit; for example, you can check out the commit
 referenced by a tag:
 
 ------------------------------------------------
-$ git checkout v2.6.17
+$ git switch --detach v2.6.17
 Note: checking out 'v2.6.17'.
 
 You are in 'detached HEAD' state. You can look around, make experimental
 changes and commit them, and you can discard any commits you make in this
-state without impacting any branches by performing another checkout.
+state without impacting any branches by performing another switch.
 
 If you want to create a new branch to retain commits you create, you may
-do so (now or later) by using -b with the checkout command again. Example:
+do so (now or later) by using -c with the switch command again. Example:
 
-  git checkout -b new_branch_name
+  git switch -c new_branch_name
 
 HEAD is now at 427abfa Linux v2.6.17
 ------------------------------------------------
@@ -373,7 +373,7 @@ You might want to build on one of these remote-tracking branches
 on a branch of your own, just as you would for a tag:
 
 ------------------------------------------------
-$ git checkout -b my-todo-copy origin/todo
+$ git switch -c my-todo-copy origin/todo
 ------------------------------------------------
 
 You can also check out `origin/todo` directly to examine it or
@@ -2211,8 +2211,8 @@ $ git branch --track release origin/master
 These can be easily kept up to date using linkgit:git-pull[1].
 
 -------------------------------------------------
-$ git checkout test && git pull
-$ git checkout release && git pull
+$ git switch test && git pull
+$ git switch release && git pull
 -------------------------------------------------
 
 Important note!  If you have any local changes in these branches, then
@@ -2264,7 +2264,7 @@ tested changes
 2) help future bug hunters that use `git bisect` to find problems
 
 -------------------------------------------------
-$ git checkout -b speed-up-spinlocks v2.6.35
+$ git switch -c speed-up-spinlocks v2.6.35
 -------------------------------------------------
 
 Now you apply the patch(es), run some tests, and commit the change(s).  If
@@ -2279,7 +2279,7 @@ When you are happy with the state of this change, you can merge it into the
 "test" branch in preparation to make it public:
 
 -------------------------------------------------
-$ git checkout test && git merge speed-up-spinlocks
+$ git switch test && git merge speed-up-spinlocks
 -------------------------------------------------
 
 It is unlikely that you would have any conflicts here ... but you might if you
@@ -2291,7 +2291,7 @@ see the value of keeping each patch (or patch series) in its own branch.  It
 means that the patches can be moved into the `release` tree in any order.
 
 -------------------------------------------------
-$ git checkout release && git merge speed-up-spinlocks
+$ git switch release && git merge speed-up-spinlocks
 -------------------------------------------------
 
 After a while, you will have a number of branches, and despite the
@@ -2512,7 +2512,7 @@ Suppose that you create a branch `mywork` on a remote-tracking branch
 `origin`, and create some commits on top of it:
 
 -------------------------------------------------
-$ git checkout -b mywork origin
+$ git switch -c mywork origin
 $ vi file.txt
 $ git commit
 $ vi otherfile.txt
@@ -2552,7 +2552,7 @@ commits without any merges, you may instead choose to use
 linkgit:git-rebase[1]:
 
 -------------------------------------------------
-$ git checkout mywork
+$ git switch mywork
 $ git rebase origin
 -------------------------------------------------
 
@@ -3668,13 +3668,13 @@ change within the submodule, and then update the superproject to reference the
 new commit:
 
 -------------------------------------------------
-$ git checkout master
+$ git switch master
 -------------------------------------------------
 
 or
 
 -------------------------------------------------
-$ git checkout -b fix-up
+$ git switch -c fix-up
 -------------------------------------------------
 
 then
@@ -4194,7 +4194,7 @@ start.
 A good place to start is with the contents of the initial commit, with:
 
 ----------------------------------------------------
-$ git checkout e83c5163
+$ git switch --detach e83c5163
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
+$ git switch test	        # switch working directory to branch "test"
+$ git branch new		# create branch "new" starting at current HEAD
+$ git branch -d new		# delete branch "new"
 -----------------------------------------------
 
 Instead of basing a new branch on current HEAD (the default), use:
@@ -4456,7 +4456,7 @@ $ git branch new test~10 # ten commits before tip of branch "test"
 Create and switch to a new branch at the same time:
 
 -----------------------------------------------
-$ git checkout -b new v2.6.15
+$ git switch -c new v2.6.15
 -----------------------------------------------
 
 Update and examine branches from the repository you cloned from:
@@ -4467,7 +4467,7 @@ $ git branch -r		# list
   origin/master
   origin/next
   ...
-$ git checkout -b masterwork origin/master
+$ git switch -c masterwork origin/master
 -----------------------------------------------
 
 Fetch a branch from a different repository, and give it a new
diff --git a/advice.c b/advice.c
index 567209aa79..835219b51b 100644
--- a/advice.c
+++ b/advice.c
@@ -191,13 +191,16 @@ void NORETURN die_conclude_merge(void)
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
+	"  git switch -c <new-branch-name>\n\n");
 
 	fprintf(stderr, fmt, new_name);
 }
diff --git a/builtin/clone.c b/builtin/clone.c
index 7c7f98c72c..b06f0ed735 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -491,7 +491,7 @@ static enum {
 static const char junk_leave_repo_msg[] =
 N_("Clone succeeded, but checkout failed.\n"
    "You can inspect what was checked out with 'git status'\n"
-   "and retry the checkout with 'git checkout -f HEAD'\n");
+   "and retry the checkout with 'git switch -f HEAD'\n");
 
 static void remove_junk(void)
 {
diff --git a/sha1-name.c b/sha1-name.c
index a656481c6a..e5f0832995 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -745,7 +745,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 	"because it will be ignored when you just specify 40-hex. These refs\n"
 	"may be created by mistake. For example,\n"
 	"\n"
-	"  git checkout -b $br $(git rev-parse ...)\n"
+	"  git switch -c $br $(git rev-parse ...)\n"
 	"\n"
 	"where \"$br\" is somehow empty and a 40-hex ref is created. Please\n"
 	"examine these refs and maybe delete them. Turn this message off by\n"
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 1fa670625c..50f7d6c15c 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -204,7 +204,7 @@ test_expect_success 'describe_detached_head prints no SHA-1 ellipsis when not as
 	If you want to create a new branch to retain commits you create, you may
 	do so (now or later) by using -b with the checkout command again. Example:
 
-	  git checkout -b <new-branch-name>
+	  git switch -c <new-branch-name>
 
 	HEAD is now at \$commit three
 	EOF
@@ -280,7 +280,7 @@ test_expect_success 'describe_detached_head does print SHA-1 ellipsis when asked
 	If you want to create a new branch to retain commits you create, you may
 	do so (now or later) by using -b with the checkout command again. Example:
 
-	  git checkout -b <new-branch-name>
+	  git switch -c <new-branch-name>
 
 	HEAD is now at \$commit... three
 	EOF
-- 
2.20.1.682.gd5861c6d90

