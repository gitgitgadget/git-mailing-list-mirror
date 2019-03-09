Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00F520248
	for <e@80x24.org>; Sat,  9 Mar 2019 12:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfCIMfs (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 07:35:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34543 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfCIMfs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 07:35:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id l5so257456lje.1
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 04:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gjjMdkzViXAAJZRRQwQfegvqCV1axqeLkTKT2pj2ebk=;
        b=OIqnC7zkg1t1/ZPPoQxuGBVZ/4dKo1AGMM00qOdDo50FWvtRpikm1gk1ClQIpikG1W
         ovv+FQNzbyIWcBSot5jxjoI7TzDicHwixA9pphzjbTOYvsbZ4yVsi8kdA15NyyoKCMWK
         eOuZkHYez5cq1JHQJ9Vm/b2wxvKj0CPQnZxQjKKNG3hC0vWLxAu9BP229g8SQ8znCzVq
         PGXtoqW1YFpgRQmDKH8UFqDfyseWsd42wRTRwy86o+8RyujAry3KaROp2H7NGmcPUDt1
         Wx5GWwMYerOSBrblq3p+UtqqEXKDksiOEttlshcboTuuXpwxbEQ2Uxjr2hxipEcncwwi
         lwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gjjMdkzViXAAJZRRQwQfegvqCV1axqeLkTKT2pj2ebk=;
        b=anvogETjAyYa20i7sq4NoNNuyvchA5ye7bP3TDm8ijXFJzxmfrrnJwbLkQcCLKl0cs
         Eqe6v+vNMA6zgo8M4c1jvjoKGNannX+zIvYmHDxFnZCdP0Dyw+Q7GgrctP6wj/lISTfZ
         HdPFDuVXa8du1cFKDmwJyFQj1jTKaC4gK1pGCG4xA3IVp4ebcIynxEVBX+wbyCQxBg9k
         vOzLnULHGaXCuV10Un7pc46oIi/vQkFNX1gDEv4hK1D3mYjeMqVQmnzx28bvu8nm2AzM
         nokTpNgnhwJgk/vpWCckxgKqxv8GGsBCjqVHlxjI4cJbW9yWsy3HUgJoNUpCYcn8hS9a
         T+5w==
X-Gm-Message-State: APjAAAVLiwsLIfv7GXK/wvIjQPRMJCQCCnxtT5NANbAIvfYz+vmPSpUr
        sifU6wCM+ps1Uy/XQFXQBhI=
X-Google-Smtp-Source: APXvYqyU7ROPzrn3ivwDuxuRaTR0pENPjjYGTbXGWg9h2n24Wyj1f7vIhW3UwK59gc+WPeV9zDXcOQ==
X-Received: by 2002:a2e:3009:: with SMTP id w9mr11719322ljw.144.1552134944721;
        Sat, 09 Mar 2019 04:35:44 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id p5sm69235ljg.44.2019.03.09.04.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 04:35:43 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 04/21] git-checkout.txt: fix monospace typeset
Date:   Sat,  9 Mar 2019 13:35:18 +0100
Message-Id: <20190309123518.2193053-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308095752.8574-5-pclouds@gmail.com>
References: <20190308095752.8574-5-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 8 Mar 2019 at 10:58, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>  Documentation/git-checkout.txt | 60 +++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
>
>  'git checkout' [<branch>]::
> -       To prepare for working on <branch>, switch to it by updating
> +       To prepare for working on `<branch>`, switch to it by updating
>         the index and the files in the working tree, and by pointing
>         HEAD at the branch. Local modifications to the files in the

You could wrap HEAD in backticks as well: `HEAD`.

> -       Prepare to work on top of <commit>, by detaching HEAD at it
> +       Prepare to work on top of `<commit>`, by detaching HEAD at it

Likewise.

>         (see "DETACHED HEAD" section), and updating the index and the

(but not here)

>  be used to detach HEAD at the tip of the branch (`git checkout
> -<branch>` would check out that branch without detaching HEAD).
> +`<branch>`` would check out that branch without detaching HEAD).

This results in a nesting. I would say this was already correct. (A few
more `HEAD` here.)

> -       Create a new branch named <new_branch> and start it at
> -       <start_point>; see linkgit:git-branch[1] for details.
> +       Create a new branch named `<new_branch>` and start it at
> +       `<start_point>`; see linkgit:git-branch[1] for details.

Lots of changes like this. Good.

>         This is the default behavior of "git checkout <commit>" when

Should be `git checkout <commit>`?

> -       <commit> is not a branch name.  See the "DETACHED HEAD" section
> +       `<commit>` is not a branch name.  See the "DETACHED HEAD" section

Good.

> -that records a set of paths similar to <start_point> by easily running
> +that records a set of paths similar to `<start_point>` by easily running
>  "git commit -a" to make the root commit.

Another opportunity for backticks.

I saw one change that I disagreed with and a few missed opportunities
(IMHO). How about something like the below squashed in? (This is based
on this point in the series.) It might be worth polishing this document
before copying it (or parts of it) in the next commit.

Martin

-- >8 --
Subject: git-checkout.txt: add more backticks for monospacing

Add backticks where we have none, replace single quotes with backticks
and replace double-quotes. Drop double-quotes from nested constructions
such as `"@{-1}"`. Add a missing possessive apostrophe after the word
"submodules" while at it.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-checkout.txt | 106 ++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 1b9d689933..af5906fbf5 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -26,7 +26,7 @@ branch.
 'git checkout' [<branch>]::
 	To prepare for working on `<branch>`, switch to it by updating
 	the index and the files in the working tree, and by pointing
-	HEAD at the branch. Local modifications to the files in the
+	`HEAD` at the branch. Local modifications to the files in the
 	working tree are kept, so that they can be committed to the
 	`<branch>`.
 +
@@ -75,7 +75,7 @@ successful.
 'git checkout' --detach [<branch>]::
 'git checkout' [--detach] <commit>::
 
-	Prepare to work on top of `<commit>`, by detaching HEAD at it
+	Prepare to work on top of `<commit>`, by detaching `HEAD` at it
 	(see "DETACHED HEAD" section), and updating the index and the
 	files in the working tree.  Local modifications to the files
 	in the working tree are kept, so that the resulting working
@@ -83,10 +83,10 @@ successful.
 	modifications.
 +
 When the `<commit>` argument is a branch name, the `--detach` option can
-be used to detach HEAD at the tip of the branch (`git checkout
-`<branch>`` would check out that branch without detaching HEAD).
+be used to detach `HEAD` at the tip of the branch (`git checkout
+<branch>` would check out that branch without detaching `HEAD`).
 +
-Omitting `<branch>` detaches HEAD at the tip of the current branch.
+Omitting `<branch>` detaches `HEAD` at the tip of the current branch.
 
 'git checkout' [<tree-ish>] [--] <pathspec>...::
 
@@ -128,7 +128,7 @@ OPTIONS
 -f::
 --force::
 	When switching branches, proceed even if the index or the
-	working tree differs from HEAD.  This is used to throw away
+	working tree differs from `HEAD`.  This is used to throw away
 	local changes.
 +
 When checking out paths from the index, do not fail upon unmerged
@@ -173,15 +173,15 @@ If no `-b` option is given, the name of the new branch will be
 derived from the remote-tracking branch, by looking at the local part of
 the refspec configured for the corresponding remote, and then stripping
 the initial part up to the "*".
-This would tell us to use "hack" as the local branch when branching
-off of "origin/hack" (or "remotes/origin/hack", or even
-"refs/remotes/origin/hack").  If the given name has no slash, or the above
+This would tell us to use `hack` as the local branch when branching
+off of `origin/hack` (or `remotes/origin/hack`, or even
+`refs/remotes/origin/hack`).  If the given name has no slash, or the above
 guessing results in an empty name, the guessing is aborted.  You can
 explicitly give a name with `-b` in such a case.
 
 --no-track::
 	Do not set up "upstream" configuration, even if the
-	branch.autoSetupMerge configuration variable is true.
+	`branch.autoSetupMerge` configuration variable is true.
 
 -l::
 	Create the new branch's reflog; see linkgit:git-branch[1] for
@@ -190,7 +190,7 @@ explicitly give a name with `-b` in such a case.
 --detach::
 	Rather than checking out a branch to work on it, check out a
 	commit for inspection and discardable experiments.
-	This is the default behavior of "git checkout <commit>" when
+	This is the default behavior of `git checkout <commit>` when
 	`<commit>` is not a branch name.  See the "DETACHED HEAD" section
 	below for details.
 
@@ -202,9 +202,9 @@ explicitly give a name with `-b` in such a case.
 	commits.
 +
 The index and the working tree are adjusted as if you had previously run
-"git checkout <start_point>".  This allows you to start a new history
+`git checkout <start_point>`.  This allows you to start a new history
 that records a set of paths similar to `<start_point>` by easily running
-"git commit -a" to make the root commit.
+`git commit -a` to make the root commit.
 +
 This can be useful when you want to publish the tree from a commit
 without exposing its full history. You might want to do this to publish
@@ -215,14 +215,14 @@ code.
 If you want to start a disconnected history that records a set of paths
 that is totally different from the one of `<start_point>`, then you should
 clear the index and the working tree right after creating the orphan
-branch by running "git rm -rf ." from the top level of the working tree.
+branch by running `git rm -rf .` from the top level of the working tree.
 Afterwards you will be ready to prepare your new files, repopulating the
 working tree, by copying them from elsewhere, extracting a tarball, etc.
 
 --ignore-skip-worktree-bits::
 	In sparse checkout mode, `git checkout -- <paths>` would
 	update only entries matched by `<paths>` and sparse patterns
-	in $GIT_DIR/info/sparse-checkout. This option ignores
+	in `$GIT_DIR/info/sparse-checkout`. This option ignores
 	the sparse patterns and adds back any files in `<paths>`.
 
 -m::
@@ -245,9 +245,9 @@ When checking out paths from the index, this option lets you recreate
 the conflicted merge in the specified paths.
 
 --conflict=<style>::
-	The same as --merge option above, but changes the way the
+	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
-	merge.conflictStyle configuration variable.  Possible values are
+	`merge.conflictStyle` configuration variable.  Possible values are
 	"merge" (default) and "diff3" (in addition to what is shown by
 	"merge" style, shows the original contents).
 
@@ -285,7 +285,7 @@ Note that this option uses the no overlay mode by default (see also
 	will fail unless `-f` is used. If nothing (or `--no-recurse-submodules`)
 	is used, the work trees of submodules will not be updated.
 	Just like linkgit:git-submodule[1], this will detach the
-	submodules HEAD.
+	submodules' `HEAD`.
 
 --no-guess::
 	Do not attempt to create a branch if a remote tracking branch
@@ -303,14 +303,14 @@ Note that this option uses the no overlay mode by default (see also
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
 	branch is checked out. Otherwise, if it refers to a valid
-	commit, your HEAD becomes "detached" and you are no longer on
+	commit, your `HEAD` becomes "detached" and you are no longer on
 	any branch (see below for details).
 +
-You can use the `"@{-N}"` syntax to refer to the N-th last
+You can use the `@{-N}` syntax to refer to the N-th last
 branch/commit checked out using "git checkout" operation. You may
-also specify `-` which is synonymous to `"@{-1}"`.
+also specify `-` which is synonymous to `@{-1}`.
 +
-As a special case, you may use `"A...B"` as a shortcut for the
+As a special case, you may use `A...B` as a shortcut for the
 merge base of `A` and `B` if there is exactly one merge base. You can
 leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
@@ -319,7 +319,7 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
 <start_point>::
 	The name of a commit at which to start the new branch; see
-	linkgit:git-branch[1] for details. Defaults to HEAD.
+	linkgit:git-branch[1] for details. Defaults to `HEAD`.
 
 <tree-ish>::
 	Tree to checkout from (when paths are given). If not specified,
@@ -329,9 +329,9 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
 DETACHED HEAD
 -------------
-HEAD normally refers to a named branch (e.g. 'master'). Meanwhile, each
+`HEAD` normally refers to a named branch (e.g. `master`). Meanwhile, each
 branch refers to a specific commit. Let's look at a repo with three
-commits, one of them tagged, and with branch 'master' checked out:
+commits, one of them tagged, and with branch `master` checked out:
 
 ------------
            HEAD (refers to branch 'master')
@@ -344,10 +344,10 @@ a---b---c  branch 'master' (refers to commit 'c')
 ------------
 
 When a commit is created in this state, the branch is updated to refer to
-the new commit. Specifically, 'git commit' creates a new commit 'd', whose
-parent is commit 'c', and then updates branch 'master' to refer to new
-commit 'd'. HEAD still refers to branch 'master' and so indirectly now refers
-to commit 'd':
+the new commit. Specifically, 'git commit' creates a new commit `d`, whose
+parent is commit `c`, and then updates branch `master` to refer to new
+commit `d`. `HEAD` still refers to branch `master` and so indirectly now refers
+to commit `d`:
 
 ------------
 $ edit; git add; git commit
@@ -364,7 +364,7 @@ a---b---c---d  branch 'master' (refers to commit 'd')
 It is sometimes useful to be able to checkout a commit that is not at
 the tip of any named branch, or even to create a new commit that is not
 referenced by a named branch. Let's look at what happens when we
-checkout commit 'b' (here we show two ways this may be done):
+checkout commit `b` (here we show two ways this may be done):
 
 ------------
 $ git checkout v2.0  # or
@@ -379,9 +379,9 @@ a---b---c---d  branch 'master' (refers to commit 'd')
   tag 'v2.0' (refers to commit 'b')
 ------------
 
-Notice that regardless of which checkout command we use, HEAD now refers
-directly to commit 'b'. This is known as being in detached HEAD state.
-It means simply that HEAD refers to a specific commit, as opposed to
+Notice that regardless of which checkout command we use, `HEAD` now refers
+directly to commit `b`. This is known as being in detached `HEAD` state.
+It means simply that `HEAD` refers to a specific commit, as opposed to
 referring to a named branch. Let's see what happens when we create a commit:
 
 ------------
@@ -398,7 +398,7 @@ a---b---c---d  branch 'master' (refers to commit 'd')
   tag 'v2.0' (refers to commit 'b')
 ------------
 
-There is now a new commit 'e', but it is referenced only by HEAD. We can
+There is now a new commit `e`, but it is referenced only by `HEAD`. We can
 of course add yet another commit in this state:
 
 ------------
@@ -416,7 +416,7 @@ a---b---c---d  branch 'master' (refers to commit 'd')
 ------------
 
 In fact, we can perform all the normal Git operations. But, let's look
-at what happens when we then checkout master:
+at what happens when we then checkout `master`:
 
 ------------
 $ git checkout master
@@ -431,9 +431,9 @@ a---b---c---d  branch 'master' (refers to commit 'd')
 ------------
 
 It is important to realize that at this point nothing refers to commit
-'f'. Eventually commit 'f' (and by extension commit 'e') will be deleted
+`f`. Eventually commit `f` (and by extension commit `e`) will be deleted
 by the routine Git garbage collection process, unless we create a reference
-before that happens. If we have not yet moved away from commit 'f',
+before that happens. If we have not yet moved away from commit `f`,
 any of these will create a reference to it:
 
 ------------
@@ -442,19 +442,19 @@ $ git branch foo        <2>
 $ git tag foo           <3>
 ------------
 
-<1> creates a new branch 'foo', which refers to commit 'f', and then
-    updates HEAD to refer to branch 'foo'. In other words, we'll no longer
-    be in detached HEAD state after this command.
+<1> creates a new branch `foo`, which refers to commit `f`, and then
+    updates `HEAD` to refer to branch `foo`. In other words, we'll no longer
+    be in detached `HEAD` state after this command.
 
-<2> similarly creates a new branch 'foo', which refers to commit 'f',
-    but leaves HEAD detached.
+<2> similarly creates a new branch `foo`, which refers to commit `f`,
+    but leaves `HEAD` detached.
 
-<3> creates a new tag 'foo', which refers to commit 'f',
-    leaving HEAD detached.
+<3> creates a new tag `foo`, which refers to commit `f`,
+    leaving `HEAD` detached.
 
-If we have moved away from commit 'f', then we must first recover its object
+If we have moved away from commit `f`, then we must first recover its object
 name (typically by using git reflog), and then we can create a reference to
-it. For example, to see the last two commits to which HEAD referred, we
+it. For example, to see the last two commits to which `HEAD` referred, we
 can use either of these commands:
 
 ------------
@@ -465,12 +465,12 @@ $ git log -g -2 HEAD
 ARGUMENT DISAMBIGUATION
 -----------------------
 
-When there is only one argument given and it is not `--` (e.g. "git
-checkout abc"), and when the argument is both a valid `<tree-ish>`
-(e.g. a branch "abc" exists) and a valid `<pathspec>` (e.g. a file
+When there is only one argument given and it is not `--` (e.g. `git
+checkout abc`), and when the argument is both a valid `<tree-ish>`
+(e.g. a branch `abc` exists) and a valid `<pathspec>` (e.g. a file
 or a directory whose name is "abc" exists), Git would usually ask
 you to disambiguate.  Because checking out a branch is so common an
-operation, however, "git checkout abc" takes "abc" as a `<tree-ish>`
+operation, however, `git checkout abc` takes "abc" as a `<tree-ish>`
 in such a situation.  Use `git checkout -- <pathspec>` if you want
 to checkout these paths out of the index.
 
@@ -478,7 +478,7 @@ EXAMPLES
 --------
 
 . The following sequence checks out the `master` branch, reverts
-  the `Makefile` to two revisions back, deletes hello.c by
+  the `Makefile` to two revisions back, deletes `hello.c` by
   mistake, and gets it back from the index.
 +
 ------------
@@ -490,7 +490,7 @@ $ git checkout hello.c            <3>
 +
 <1> switch branch
 <2> take a file out of another commit
-<3> restore hello.c from the index
+<3> restore `hello.c` from the index
 +
 If you want to check out _all_ C source files out of the index,
 you can say
@@ -519,7 +519,7 @@ $ git checkout -- hello.c
 $ git checkout mytopic
 ------------
 +
-However, your "wrong" branch and correct "mytopic" branch may
+However, your "wrong" branch and correct `mytopic` branch may
 differ in files that you have modified locally, in which case
 the above checkout would fail like this:
 +
-- 
2.21.0

