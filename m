Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B76C77B73
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 17:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDOR3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 13:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjDOR3s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 13:29:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9143935AA
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 10:29:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4edb26f762dso524265e87.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 10:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681579782; x=1684171782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+f/qSTVPskifUoCri9/hlJvfeXo97YObxDrrUX589Y=;
        b=U9E0dsuvZl24J+x1n0LzIwhWNFPvHfYPVZe4ygGTgh4xU2apPv9tv9xrrmkXpT9CSo
         i9Oazdhp2kHv/q/iu8DVv4wDBwsc7BqMW5v0aOgYCMoMjnJrzefRacV3pHZ3zMXf+1EP
         HHelGR96QQH5us3Qc1uLzhL/PEtbJOH3ux8vHV6EnazGX4iadbB3s4L77PPjc75tMJ9y
         qDarCTuOUw8xhUm+w/TRDZDec5wK4kSyW+BBvE4+En2ZBUkOCPfVVleWf7ceKrqhECfC
         w1mV1rkxVERwE2wOABBPvSIGsjxtEVN1qHneKcYiAQWYCM3+2Kg3s8D/IgZIDndmS0h/
         entQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681579782; x=1684171782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+f/qSTVPskifUoCri9/hlJvfeXo97YObxDrrUX589Y=;
        b=A1QhWyolcIu2n9e7V9A5Mm6MHsQvqtmAky18OgQRckDYhTGN9txXxbdc/mu1sXEOhu
         55Y34b+g8drG80gfVKXMuRh6KLUw5tarQ7rqfhfRVdUWnUwjTXp3xef+FOU7VaneMfb6
         wx4keFh5D9Sr1pEQaZaAuFmMV6t6T/0tdp0sqqC89jUvDvnwr/n+l0it/pWgOGYXpzGV
         3DhIJxERs/lhEqkgj0tas2qQaW50FipBUHo746vqZ4K7/n8f0P1emE2nzPcYgF0Ctb1F
         zjNzDGBm1zxgry7Rzkp6Xn62tpgQGRSjWlE1jcTAyJEzvqGvcCS0N8aB3Vrowpr+YzaR
         g3og==
X-Gm-Message-State: AAQBX9crp6h1+8m8Y27Qg7IwE/TaoSbFoQLO3sYgyugqXjpu7UmBxQle
        TV8cnkUB9elpKfyf8ImGt5lzrV+EAuQ=
X-Google-Smtp-Source: AKy350b5HL1cPf5X+cmGs3/PuDN8ZggQmU0oQi8ejKX7mMXV3KS4sQ5Yy6o2vujOUZaWACZRwPvQtg==
X-Received: by 2002:ac2:48ad:0:b0:4eb:10b:a8ed with SMTP id u13-20020ac248ad000000b004eb010ba8edmr663313lfg.64.1681579781802;
        Sat, 15 Apr 2023 10:29:41 -0700 (PDT)
Received: from localhost.localdomain (81-235-255-74-no600.tbcn.telia.com. [81.235.255.74])
        by smtp.gmail.com with ESMTPSA id x2-20020a19f602000000b004d40e22c1eesm1357056lfe.252.2023.04.15.10.29.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 10:29:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] gittutorial: wrap literal examples in backticks
Date:   Sat, 15 Apr 2023 19:29:11 +0200
Message-ID: <280c7d18b99e7cfc882d0dad0de536d4f40d4338.1681579244.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.40.0.406.g2798986c60
In-Reply-To: <cover.1681579244.git.martin.agren@gmail.com>
References: <cover.1681579244.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our coding guidelines prefer literal examples to be wrapped in
`backticks` to typeset them in monospace.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/gittutorial.txt | 128 +++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 33dd5a2cba..c7cadd8aaf 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -49,7 +49,7 @@ $ git config --global user.email you@yourdomain.example.com
 Importing a new project
 -----------------------
 
-Assume you have a tarball project.tar.gz with your initial work.  You
+Assume you have a tarball `project.tar.gz` with your initial work.  You
 can place it under Git revision control as follows.
 
 ------------------------------------------------
@@ -65,10 +65,10 @@ Initialized empty Git repository in .git/
 ------------------------------------------------
 
 You've now initialized the working directory--you may notice a new
-directory created, named ".git".
+directory created, named `.git`.
 
 Next, tell Git to take a snapshot of the contents of all files under the
-current directory (note the '.'), with 'git add':
+current directory (note the `.`), with `git add`:
 
 ------------------------------------------------
 $ git add .
@@ -76,7 +76,7 @@ $ git add .
 
 This snapshot is now stored in a temporary staging area which Git calls
 the "index".  You can permanently store the contents of the index in the
-repository with 'git commit':
+repository with `git commit`:
 
 ------------------------------------------------
 $ git commit
@@ -95,15 +95,15 @@ $ git add file1 file2 file3
 ------------------------------------------------
 
 You are now ready to commit.  You can see what is about to be committed
-using 'git diff' with the --cached option:
+using `git diff` with the `--cached` option:
 
 ------------------------------------------------
 $ git diff --cached
 ------------------------------------------------
 
-(Without --cached, 'git diff' will show you any changes that
+(Without `--cached`, `git diff` will show you any changes that
 you've made but not yet added to the index.)  You can also get a brief
-summary of the situation with 'git status':
+summary of the situation with `git status`:
 
 ------------------------------------------------
 $ git status
@@ -127,7 +127,7 @@ $ git commit
 This will again prompt you for a message describing the change, and then
 record a new version of the project.
 
-Alternatively, instead of running 'git add' beforehand, you can use
+Alternatively, instead of running `git add` beforehand, you can use
 
 ------------------------------------------------
 $ git commit -a
@@ -150,7 +150,7 @@ Git tracks content not files
 
 Many revision control systems provide an `add` command that tells the
 system to start tracking changes to a new file.  Git's `add` command
-does something simpler and more powerful: 'git add' is used both for new
+does something simpler and more powerful: `git add` is used both for new
 and newly modified files, and in both cases it takes a snapshot of the
 given files and stages that content in the index, ready for inclusion in
 the next commit.
@@ -181,7 +181,7 @@ Managing branches
 -----------------
 
 A single Git repository can maintain multiple branches of
-development.  To create a new branch named "experimental", use
+development.  To create a new branch named `experimental`, use
 
 ------------------------------------------------
 $ git branch experimental
@@ -200,8 +200,8 @@ you'll get a list of all existing branches:
 * master
 ------------------------------------------------
 
-The "experimental" branch is the one you just created, and the
-"master" branch is a default branch that was created for you
+The `experimental` branch is the one you just created, and the
+`master` branch is a default branch that was created for you
 automatically.  The asterisk marks the branch you are currently on;
 type
 
@@ -209,8 +209,8 @@ type
 $ git switch experimental
 ------------------------------------------------
 
-to switch to the experimental branch.  Now edit a file, commit the
-change, and switch back to the master branch:
+to switch to the `experimental` branch.  Now edit a file, commit the
+change, and switch back to the `master` branch:
 
 ------------------------------------------------
 (edit file)
@@ -219,9 +219,9 @@ $ git switch master
 ------------------------------------------------
 
 Check that the change you made is no longer visible, since it was
-made on the experimental branch and you're back on the master branch.
+made on the `experimental` branch and you're back on the `master` branch.
 
-You can make a different change on the master branch:
+You can make a different change on the `master` branch:
 
 ------------------------------------------------
 (edit file)
@@ -229,7 +229,7 @@ $ git commit -a
 ------------------------------------------------
 
 at this point the two branches have diverged, with different changes
-made in each.  To merge the changes made in experimental into master, run
+made in each.  To merge the changes made in `experimental` into `master`, run
 
 ------------------------------------------------
 $ git merge experimental
@@ -257,16 +257,16 @@ $ gitk
 
 will show a nice graphical representation of the resulting history.
 
-At this point you could delete the experimental branch with
+At this point you could delete the `experimental` branch with
 
 ------------------------------------------------
 $ git branch -d experimental
 ------------------------------------------------
 
-This command ensures that the changes in the experimental branch are
+This command ensures that the changes in the `experimental` branch are
 already in the current branch.
 
-If you develop on a branch crazy-idea, then regret it, you can always
+If you develop on a branch `crazy-idea`, then regret it, you can always
 delete the branch with
 
 -------------------------------------
@@ -280,7 +280,7 @@ Using Git for collaboration
 ---------------------------
 
 Suppose that Alice has started a new project with a Git repository in
-/home/alice/project, and that Bob, who has a home directory on the
+`/home/alice/project`, and that Bob, who has a home directory on the
 same machine, wants to contribute.
 
 Bob begins with:
@@ -289,7 +289,7 @@ Bob begins with:
 bob$ git clone /home/alice/project myrepo
 ------------------------------------------------
 
-This creates a new directory "myrepo" containing a clone of Alice's
+This creates a new directory `myrepo` containing a clone of Alice's
 repository.  The clone is on an equal footing with the original
 project, possessing its own copy of the original project's history.
 
@@ -302,31 +302,31 @@ bob$ git commit -a
 ------------------------------------------------
 
 When he's ready, he tells Alice to pull changes from the repository
-at /home/bob/myrepo.  She does this with:
+at `/home/bob/myrepo`.  She does this with:
 
 ------------------------------------------------
 alice$ cd /home/alice/project
 alice$ git pull /home/bob/myrepo master
 ------------------------------------------------
 
-This merges the changes from Bob's "master" branch into Alice's
+This merges the changes from Bob's `master` branch into Alice's
 current branch.  If Alice has made her own changes in the meantime,
 then she may need to manually fix any conflicts.
 
-The "pull" command thus performs two operations: it fetches changes
+The `pull` command thus performs two operations: it fetches changes
 from a remote branch, then merges them into the current branch.
 
 Note that in general, Alice would want her local changes committed before
-initiating this "pull".  If Bob's work conflicts with what Alice did since
+initiating this `pull`.  If Bob's work conflicts with what Alice did since
 their histories forked, Alice will use her working tree and the index to
 resolve conflicts, and existing local changes will interfere with the
 conflict resolution process (Git will still perform the fetch but will
 refuse to merge -- Alice will have to get rid of her local changes in
 some way and pull again when this happens).
 
-Alice can peek at what Bob did without merging first, using the "fetch"
+Alice can peek at what Bob did without merging first, using the `fetch`
 command; this allows Alice to inspect what Bob did, using a special
-symbol "FETCH_HEAD", in order to determine if he has anything worth
+symbol `FETCH_HEAD`, in order to determine if he has anything worth
 pulling, like this:
 
 ------------------------------------------------
@@ -335,10 +335,10 @@ alice$ git log -p HEAD..FETCH_HEAD
 ------------------------------------------------
 
 This operation is safe even if Alice has uncommitted local changes.
-The range notation "HEAD..FETCH_HEAD" means "show everything that is reachable
-from the FETCH_HEAD but exclude anything that is reachable from HEAD".
-Alice already knows everything that leads to her current state (HEAD),
-and reviews what Bob has in his state (FETCH_HEAD) that she has not
+The range notation `HEAD..FETCH_HEAD` means "show everything that is reachable
+from the `FETCH_HEAD` but exclude anything that is reachable from `HEAD`".
+Alice already knows everything that leads to her current state (`HEAD`),
+and reviews what Bob has in his state (`FETCH_HEAD`) that she has not
 seen with this command.
 
 If Alice wants to visualize what Bob did since their histories forked
@@ -348,7 +348,7 @@ she can issue the following command:
 $ gitk HEAD..FETCH_HEAD
 ------------------------------------------------
 
-This uses the same two-dot range notation we saw earlier with 'git log'.
+This uses the same two-dot range notation we saw earlier with `git log`.
 
 Alice may want to view what both of them did since they forked.
 She can use three-dot form instead of the two-dot form:
@@ -360,13 +360,13 @@ $ gitk HEAD...FETCH_HEAD
 This means "show everything that is reachable from either one, but
 exclude anything that is reachable from both of them".
 
-Please note that these range notation can be used with both gitk
-and "git log".
+Please note that these range notation can be used with both `gitk`
+and `git log`.
 
 After inspecting what Bob did, if there is nothing urgent, Alice may
 decide to continue working without pulling from Bob.  If Bob's history
 does have something Alice would immediately need, Alice may choose to
-stash her work-in-progress first, do a "pull", and then finally unstash
+stash her work-in-progress first, do a `pull`, and then finally unstash
 her work-in-progress on top of the resulting history.
 
 When you are working in a small closely knit group, it is not
@@ -378,8 +378,8 @@ it easier:
 alice$ git remote add bob /home/bob/myrepo
 ------------------------------------------------
 
-With this, Alice can perform the first part of the "pull" operation
-alone using the 'git fetch' command without merging them with her own
+With this, Alice can perform the first part of the `pull` operation
+alone using the `git fetch` command without merging them with her own
 branch, using:
 
 -------------------------------------
@@ -387,7 +387,7 @@ alice$ git fetch bob
 -------------------------------------
 
 Unlike the longhand form, when Alice fetches from Bob using a
-remote repository shorthand set up with 'git remote', what was
+remote repository shorthand set up with `git remote`, what was
 fetched is stored in a remote-tracking branch, in this case
 `bob/master`.  So after this:
 
@@ -396,10 +396,10 @@ alice$ git log -p master..bob/master
 -------------------------------------
 
 shows a list of all the changes that Bob made since he branched from
-Alice's master branch.
+Alice's `master` branch.
 
 After examining those changes, Alice
-could merge the changes into her master branch:
+could merge the changes into her `master` branch:
 
 -------------------------------------
 alice$ git merge bob/master
@@ -431,12 +431,12 @@ bob$ git config --get remote.origin.url
 /home/alice/project
 -------------------------------------
 
-(The complete configuration created by 'git clone' is visible using
+(The complete configuration created by `git clone` is visible using
 `git config -l`, and the linkgit:git-config[1] man page
 explains the meaning of each option.)
 
-Git also keeps a pristine copy of Alice's master branch under the
-name "origin/master":
+Git also keeps a pristine copy of Alice's `master` branch under the
+name `origin/master`:
 
 -------------------------------------
 bob$ git branch -r
@@ -461,8 +461,8 @@ Exploring history
 -----------------
 
 Git history is represented as a series of interrelated commits.  We
-have already seen that the 'git log' command can list those commits.
-Note that first line of each git log entry also gives a name for the
+have already seen that the `git log` command can list those commits.
+Note that first line of each `git log` entry also gives a name for the
 commit:
 
 -------------------------------------
@@ -474,7 +474,7 @@ Date:   Tue May 16 17:18:22 2006 -0700
     merge-base: Clarify the comments on post processing.
 -------------------------------------
 
-We can give this name to 'git show' to see the details about this
+We can give this name to `git show` to see the details about this
 commit.
 
 -------------------------------------
@@ -513,7 +513,7 @@ You can also give commits names of your own; after running
 $ git tag v2.5 1b2e1d63ff
 -------------------------------------
 
-you can refer to 1b2e1d63ff by the name "v2.5".  If you intend to
+you can refer to `1b2e1d63ff` by the name `v2.5`.  If you intend to
 share this name with other people (for example, to identify a release
 version), you should create a "tag" object, and perhaps sign it; see
 linkgit:git-tag[1] for details.
@@ -532,22 +532,22 @@ $ git reset --hard HEAD^ # reset your current branch and working
 Be careful with that last command: in addition to losing any changes
 in the working directory, it will also remove all later commits from
 this branch.  If this branch is the only branch containing those
-commits, they will be lost.  Also, don't use 'git reset' on a
+commits, they will be lost.  Also, don't use `git reset` on a
 publicly-visible branch that other developers pull from, as it will
 force needless merges on other developers to clean up the history.
-If you need to undo changes that you have pushed, use 'git revert'
+If you need to undo changes that you have pushed, use `git revert`
 instead.
 
-The 'git grep' command can search for strings in any version of your
+The `git grep` command can search for strings in any version of your
 project, so
 
 -------------------------------------
 $ git grep "hello" v2.5
 -------------------------------------
 
-searches for all occurrences of "hello" in v2.5.
+searches for all occurrences of "hello" in `v2.5`.
 
-If you leave out the commit name, 'git grep' will search any of the
+If you leave out the commit name, `git grep` will search any of the
 files it manages in your current directory.  So
 
 -------------------------------------
@@ -557,7 +557,7 @@ $ git grep "hello"
 is a quick way to search just the files that are tracked by Git.
 
 Many Git commands also take sets of commits, which can be specified
-in a number of ways.  Here are some examples with 'git log':
+in a number of ways.  Here are some examples with `git log`:
 
 -------------------------------------
 $ git log v2.5..v2.6            # commits between v2.5 and v2.6
@@ -567,16 +567,16 @@ $ git log v2.5.. Makefile       # commits since v2.5 which modify
 				# Makefile
 -------------------------------------
 
-You can also give 'git log' a "range" of commits where the first is not
+You can also give `git log` a "range" of commits where the first is not
 necessarily an ancestor of the second; for example, if the tips of
-the branches "stable" and "master" diverged from a common
+the branches `stable` and `master` diverged from a common
 commit some time ago, then
 
 -------------------------------------
 $ git log stable..master
 -------------------------------------
 
-will list commits made in the master branch but not in the
+will list commits made in the `master` branch but not in the
 stable branch, while
 
 -------------------------------------
@@ -584,15 +584,15 @@ $ git log master..stable
 -------------------------------------
 
 will show the list of commits made on the stable branch but not
-the master branch.
+the `master` branch.
 
-The 'git log' command has a weakness: it must present commits in a
+The `git log` command has a weakness: it must present commits in a
 list.  When the history has lines of development that diverged and
-then merged back together, the order in which 'git log' presents
+then merged back together, the order in which `git log` presents
 those commits is meaningless.
 
 Most projects with multiple contributors (such as the Linux kernel,
-or Git itself) have frequent merges, and 'gitk' does a better job of
+or Git itself) have frequent merges, and `gitk` does a better job of
 visualizing their history.  For example,
 
 -------------------------------------
@@ -600,7 +600,7 @@ $ gitk --since="2 weeks ago" drivers/
 -------------------------------------
 
 allows you to browse any commits from the last 2 weeks of commits
-that modified files under the "drivers" directory.  (Note: you can
+that modified files under the `drivers` directory.  (Note: you can
 adjust gitk's fonts by holding down the control key while pressing
 "-" or "+".)
 
@@ -612,7 +612,7 @@ of the file:
 $ git diff v2.5:Makefile HEAD:Makefile.in
 -------------------------------------
 
-You can also use 'git show' to see any such file:
+You can also use `git show` to see any such file:
 
 -------------------------------------
 $ git show v2.5:Makefile
@@ -648,7 +648,7 @@ digressions that may be interesting at this point are:
 
   * linkgit:git-bisect[1]: When there is a regression in your
     project, one way to track down the bug is by searching through
-    the history to find the exact commit that's to blame.  Git bisect
+    the history to find the exact commit that's to blame.  `git bisect`
     can help you perform a binary search for that commit.  It is
     smart enough to perform a close-to-optimal search even in the
     case of complex non-linear history with lots of merged branches.
-- 
2.40.0.406.g2798986c60

