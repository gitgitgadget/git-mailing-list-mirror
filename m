Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C5761F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 16:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbeK1DwL (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 22:52:11 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45178 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731584AbeK1DwK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 22:52:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so20674431ljd.12
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 08:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wtYrwDueT/P6NEPuBMCbkLY85cAWutlZ9KEXhLKIDo=;
        b=bto5sCvFagRcj3D2ug3V00XVorVKKothDQQqx15FDeQc32agOd5wD1fhz/eJKLJ2ek
         ome+S7La9WnefUi7gi+n07TmdlySToADm+5NxfDw4tqjo7shbqpZesM9tKE/MWfuO4Fs
         TEI1M6191Zjfe3ABoQmA77nABOPpjpXuZZgesN4+ZXQKq6fwzclqxv2w7rv/x1mvJsx3
         2OU0r8tFa6sdbVtRCZHf6roJ3u7G90cHfkruc2JzRD391FETrgbZxrZXVGWuGjBoVmuh
         fwMSVuJA3NJXyQf0kPQHrlu5NykKAOzjrfeJ+T9AfYVR+KjNME6k+5jcILtkh++70Xyd
         LkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wtYrwDueT/P6NEPuBMCbkLY85cAWutlZ9KEXhLKIDo=;
        b=pW40pt06pBfSfTwWMlJvj9KduIJP6C8flY4U+yShZd/U+yi5JBKn30Qk7BISNGaaGT
         e70ugSjtmJEwPFiCtifICJKGXlMAToMuE/CZzp/HyMBNLtibr4JF+cf6VdaMyaQbtvsd
         Q4MGU1xuQkkNS4M0h3iQp1vkhut7lqgJjrPLiEpEFT54aOoaiyW2mGqaWk6aGRjqFHzH
         JADl6vN/UdlxJ8We2uXskSuBodRabzHTkSj0RIMkwK7p0gtmz4KQx9N7zwA17sL6/Ovw
         YU2JqOal3vzBYZQnF3yf88xOHx791oitZ2/53lMO6JUzccXnT0wGIbslJNpaffsXEchr
         N1dQ==
X-Gm-Message-State: AA+aEWbz4odWDpacLZN8cvZPaPokQqiTeWm2Z0a8lq6w1n6BuIdUa6/k
        CTTMWDMO2FtWAG3Yi7BdfRA=
X-Google-Smtp-Source: AFSGD/WHgnL3VY/EyKyo15TNyusq5ERaXDNR2WVDKS/o4Pc4CgJRHAyUPHrJkWho33lPqO7S9R9h3Q==
X-Received: by 2002:a2e:97d7:: with SMTP id m23-v6mr22168899ljj.18.1543337616328;
        Tue, 27 Nov 2018 08:53:36 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm694016lfe.42.2018.11.27.08.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:53:35 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>, t.gummerer@gmail.com
Subject: [PATCH v2 7/7] Suggest other commands instead of "git checkout"
Date:   Tue, 27 Nov 2018 17:52:11 +0100
Message-Id: <20181127165211.24763-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181127165211.24763-1-pclouds@gmail.com>
References: <20181120174554.GA29910@duynguyen.home>
 <20181127165211.24763-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The assumption made is here

- "git checkout" is a horrible monster that should only be touched
  with a two-meter pole

- there are other commands that can achieve the same thing

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
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
 advice.c                               |  2 +-
 sha1-name.c                            |  2 +-
 wt-status.c                            |  2 +-
 22 files changed, 88 insertions(+), 87 deletions(-)

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
index 837707a8fd..e49dbbec83 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -26,7 +26,7 @@ effect of some earlier commits (often only a faulty one).  If you want to
 throw away all uncommitted changes in your working directory, you
 should see linkgit:git-reset[1], particularly the `--hard` option.  If
 you want to extract specific files as they were in another commit, you
-should see linkgit:git-checkout[1], specifically the `git checkout
+should see linkgit:git-checkout[1], specifically the `git checkout-files
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
index 592e06d839..0ad4869f2c 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -47,8 +47,8 @@ disambiguating `--` at appropriate places.
    things:
 +
 --------------------------------
-$ git checkout -- *.c
-$ git checkout -- \*.c
+$ git checkout-files -- *.c
+$ git checkout-files -- \*.c
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
index 9f2528fc8c..861b2bb616 100644
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
+$ git checkout-files -- curses/ux_audio_oss.c <2>
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
index e0976f6017..125213d951 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -376,7 +376,7 @@ Changes to be committed:
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
-  (use "git checkout -- <file>..." to discard changes in working directory)
+  (use "git checkout-files -- <file>..." to discard changes in working directory)
 
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
index eff7890274..56397e93d4 100644
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
+$ git checkout-files HEAD^ path/to/file
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
index 5f35656409..1befdb2163 100644
--- a/advice.c
+++ b/advice.c
@@ -195,7 +195,7 @@ void detach_advice(const char *new_name)
 	"state without impacting any branches by performing another checkout.\n\n"
 	"If you want to create a new branch to retain commits you create, you may\n"
 	"do so (now or later) by using -b with the checkout command again. Example:\n\n"
-	"  git checkout -b <new-branch-name>\n\n");
+	"  git branch <new-branch-name>\n\n");
 
 	fprintf(stderr, fmt, new_name);
 }
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
index a24711374c..6266683926 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -224,7 +224,7 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
 		status_printf_ln(s, c, _("  (use \"git add <file>...\" to update what will be committed)"));
 	else
 		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" to update what will be committed)"));
-	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
+	status_printf_ln(s, c, _("  (use \"git checkout-files <file>...\" to discard changes in working directory)"));
 	if (has_dirty_submodules)
 		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
 	status_printf_ln(s, c, "%s", "");
-- 
2.19.1.1327.g328c130451.dirty

