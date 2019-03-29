Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56E120248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfC2KkK (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:40:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35293 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbfC2KkK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:40:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so1037676pgf.2
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nff+2rqpHfUyD0VbdqEipBy3BpKHvj+TGygQ3NvZp0w=;
        b=Uo61qGSrSThgJmL/QycjDcTvOjZZqY3qxyGYfDCqsY1ILdO5Z/hatkfnp7itmRP78y
         kf27ampQt5m5Qiik/jSZE6nK71+OMRf7GXL6c44nLlJY4+K/DXmjeIQvHvkxxNkp8QeH
         b1PwN3905IWMsvzMpiILsDcEVasAxj35tf+kc2erOhCtQf+C964Q0x4zpjP9MBpqqe8S
         YgSfCR7sW1fmNR6pzVUbpS9vJE5q/xjxYEwgIMG1ALXs9O05hSxUaFpvrJIfYfLzv2eH
         +tnwn8lvVYyXDLPckr4aonY41CtsIPCkF8D67JF4FpW2DlKQALfGr7fNOsUmjIsmLZfh
         SAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nff+2rqpHfUyD0VbdqEipBy3BpKHvj+TGygQ3NvZp0w=;
        b=tEZ7SjDYNJ2oEVO7AjYP9ARc2m+ZMgxVhnhKSGTVmnAtJdBhqXQVaODeNW6Gco7lHJ
         HFxAGtm1KB96N2jATapXoN90mmucsY382Rucx3uob4uBWrcG30/UArsUdNn7QSef/JnU
         vkefv4YFDBPc7gNHxnmJwZGRlcoMvNecx6iyzxlEIxrnJfR+FdJgvdQBI7Q5skQI3hb+
         4+CXshpKdn8PzjXG1va/BEIGohUC5DaFmM6rh2NqrcGWn3UtqMbyIaXkj3SnhggF26q4
         xFmE8QW6WcMjC9VKjxOuEMsq1Q7wM1BgjWRf45CUl4S2sTK7YR62sYW1vgGWdqhHZNFT
         /ehw==
X-Gm-Message-State: APjAAAW4sI4m5zyxEaO+QdFCrmlNfhDWa/BPg/PW8xod+BBs4ffP9qAB
        aZqQzLeZTW610SQKuEqhcas=
X-Google-Smtp-Source: APXvYqyjCqhBLydvBzFLvwbmSIMH2BE7ocGj2SO6zCiSNQyk882sO69hfEce4sMRtHOkKCUiweJt+g==
X-Received: by 2002:a63:1d26:: with SMTP id d38mr15783058pgd.357.1553856009158;
        Fri, 29 Mar 2019 03:40:09 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id k26sm2794663pfo.111.2019.03.29.03.40.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:40:08 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:40:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 04/27] git-checkout.txt: fix monospace typeset
Date:   Fri, 29 Mar 2019 17:38:56 +0700
Message-Id: <20190329103919.15642-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add backticks where we have none, replace single quotes with backticks
and replace double-quotes. Drop double-quotes from nested constructions
such as `"@{-1}"`.

Helped-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-checkout.txt | 162 ++++++++++++++++-----------------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 5280d1f9ed..bf90966c95 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -24,14 +24,14 @@ also update `HEAD` to set the specified branch as the current
 branch.
 
 'git checkout' [<branch>]::
-	To prepare for working on <branch>, switch to it by updating
+	To prepare for working on `<branch>`, switch to it by updating
 	the index and the files in the working tree, and by pointing
-	HEAD at the branch. Local modifications to the files in the
+	`HEAD` at the branch. Local modifications to the files in the
 	working tree are kept, so that they can be committed to the
-	<branch>.
+	`<branch>`.
 +
-If <branch> is not found but there does exist a tracking branch in
-exactly one remote (call it <remote>) with a matching name, treat as
+If `<branch>` is not found but there does exist a tracking branch in
+exactly one remote (call it `<remote>`) with a matching name, treat as
 equivalent to
 +
 ------------
@@ -47,7 +47,7 @@ branches from there if `<branch>` is ambiguous but exists on the
 'origin' remote. See also `checkout.defaultRemote` in
 linkgit:git-config[1].
 +
-You could omit <branch>, in which case the command degenerates to
+You could omit `<branch>`, in which case the command degenerates to
 "check out the current branch", which is a glorified no-op with
 rather expensive side-effects to show only the tracking information,
 if exists, for the current branch.
@@ -61,7 +61,7 @@ if exists, for the current branch.
 	`--track` without `-b` implies branch creation; see the
 	description of `--track` below.
 +
-If `-B` is given, <new_branch> is created if it doesn't exist; otherwise, it
+If `-B` is given, `<new_branch>` is created if it doesn't exist; otherwise, it
 is reset. This is the transactional equivalent of
 +
 ------------
@@ -75,25 +75,25 @@ successful.
 'git checkout' --detach [<branch>]::
 'git checkout' [--detach] <commit>::
 
-	Prepare to work on top of <commit>, by detaching HEAD at it
+	Prepare to work on top of `<commit>`, by detaching `HEAD` at it
 	(see "DETACHED HEAD" section), and updating the index and the
 	files in the working tree.  Local modifications to the files
 	in the working tree are kept, so that the resulting working
 	tree will be the state recorded in the commit plus the local
 	modifications.
 +
-When the <commit> argument is a branch name, the `--detach` option can
-be used to detach HEAD at the tip of the branch (`git checkout
-<branch>` would check out that branch without detaching HEAD).
+When the `<commit>` argument is a branch name, the `--detach` option can
+be used to detach `HEAD` at the tip of the branch (`git checkout
+<branch>` would check out that branch without detaching `HEAD`).
 +
-Omitting <branch> detaches HEAD at the tip of the current branch.
+Omitting `<branch>` detaches `HEAD` at the tip of the current branch.
 
 'git checkout' [<tree-ish>] [--] <pathspec>...::
 
 	Overwrite paths in the working tree by replacing with the
-	contents in the index or in the <tree-ish> (most often a
-	commit).  When a <tree-ish> is given, the paths that
-	match the <pathspec> are updated both in the index and in
+	contents in the index or in the `<tree-ish>` (most often a
+	commit).  When a `<tree-ish>` is given, the paths that
+	match the `<pathspec>` are updated both in the index and in
 	the working tree.
 +
 The index may contain unmerged entries because of a previous failed merge.
@@ -128,7 +128,7 @@ OPTIONS
 -f::
 --force::
 	When switching branches, proceed even if the index or the
-	working tree differs from HEAD.  This is used to throw away
+	working tree differs from `HEAD`.  This is used to throw away
 	local changes.
 +
 When checking out paths from the index, do not fail upon unmerged
@@ -155,12 +155,12 @@ on your side branch as `theirs` (i.e. "one contributor's work on top
 of it").
 
 -b <new_branch>::
-	Create a new branch named <new_branch> and start it at
-	<start_point>; see linkgit:git-branch[1] for details.
+	Create a new branch named `<new_branch>` and start it at
+	`<start_point>`; see linkgit:git-branch[1] for details.
 
 -B <new_branch>::
-	Creates the branch <new_branch> and start it at <start_point>;
-	if it already exists, then reset it to <start_point>. This is
+	Creates the branch `<new_branch>` and start it at `<start_point>`;
+	if it already exists, then reset it to `<start_point>`. This is
 	equivalent to running "git branch" with "-f"; see
 	linkgit:git-branch[1] for details.
 
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
@@ -190,21 +190,21 @@ explicitly give a name with `-b` in such a case.
 --detach::
 	Rather than checking out a branch to work on it, check out a
 	commit for inspection and discardable experiments.
-	This is the default behavior of "git checkout <commit>" when
-	<commit> is not a branch name.  See the "DETACHED HEAD" section
+	This is the default behavior of `git checkout <commit>` when
+	`<commit>` is not a branch name.  See the "DETACHED HEAD" section
 	below for details.
 
 --orphan <new_branch>::
-	Create a new 'orphan' branch, named <new_branch>, started from
-	<start_point> and switch to it.  The first commit made on this
+	Create a new 'orphan' branch, named `<new_branch>`, started from
+	`<start_point>` and switch to it.  The first commit made on this
 	new branch will have no parents and it will be the root of a new
 	history totally disconnected from all the other branches and
 	commits.
 +
 The index and the working tree are adjusted as if you had previously run
-"git checkout <start_point>".  This allows you to start a new history
-that records a set of paths similar to <start_point> by easily running
-"git commit -a" to make the root commit.
+`git checkout <start_point>`.  This allows you to start a new history
+that records a set of paths similar to `<start_point>` by easily running
+`git commit -a` to make the root commit.
 +
 This can be useful when you want to publish the tree from a commit
 without exposing its full history. You might want to do this to publish
@@ -213,17 +213,17 @@ whose full history contains proprietary or otherwise encumbered bits of
 code.
 +
 If you want to start a disconnected history that records a set of paths
-that is totally different from the one of <start_point>, then you should
+that is totally different from the one of `<start_point>`, then you should
 clear the index and the working tree right after creating the orphan
-branch by running "git rm -rf ." from the top level of the working tree.
+branch by running `git rm -rf .` from the top level of the working tree.
 Afterwards you will be ready to prepare your new files, repopulating the
 working tree, by copying them from elsewhere, extracting a tarball, etc.
 
 --ignore-skip-worktree-bits::
 	In sparse checkout mode, `git checkout -- <paths>` would
-	update only entries matched by <paths> and sparse patterns
-	in $GIT_DIR/info/sparse-checkout. This option ignores
-	the sparse patterns and adds back any files in <paths>.
+	update only entries matched by `<paths>` and sparse patterns
+	in `$GIT_DIR/info/sparse-checkout`. This option ignores
+	the sparse patterns and adds back any files in `<paths>`.
 
 -m::
 --merge::
@@ -245,18 +245,18 @@ When checking out paths from the index, this option lets you recreate
 the conflicted merge in the specified paths.
 
 --conflict=<style>::
-	The same as --merge option above, but changes the way the
+	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
-	merge.conflictStyle configuration variable.  Possible values are
+	`merge.conflictStyle` configuration variable.  Possible values are
 	"merge" (default) and "diff3" (in addition to what is shown by
 	"merge" style, shows the original contents).
 
 -p::
 --patch::
 	Interactively select hunks in the difference between the
-	<tree-ish> (or the index, if unspecified) and the working
+	`<tree-ish>` (or the index, if unspecified) and the working
 	tree.  The chosen hunks are then applied in reverse to the
-	working tree (and if a <tree-ish> was specified, the index).
+	working tree (and if a `<tree-ish>` was specified, the index).
 +
 This means that you can use `git checkout -p` to selectively discard
 edits from your current working tree. See the ``Interactive Mode''
@@ -279,13 +279,13 @@ Note that this option uses the no overlay mode by default (see also
 
 --recurse-submodules::
 --no-recurse-submodules::
-	Using --recurse-submodules will update the content of all initialized
+	Using `--recurse-submodules` will update the content of all initialized
 	submodules according to the commit recorded in the superproject. If
 	local modifications in a submodule would be overwritten the checkout
-	will fail unless `-f` is used. If nothing (or --no-recurse-submodules)
+	will fail unless `-f` is used. If nothing (or `--no-recurse-submodules`)
 	is used, the work trees of submodules will not be updated.
-	Just like linkgit:git-submodule[1], this will detach the
-	submodules HEAD.
+	Just like linkgit:git-submodule[1], this will detach `HEAD` of the
+	submodule.
 
 --no-guess::
 	Do not attempt to create a branch if a remote tracking branch
@@ -296,21 +296,21 @@ Note that this option uses the no overlay mode by default (see also
 	In the default overlay mode, `git checkout` never
 	removes files from the index or the working tree.  When
 	specifying `--no-overlay`, files that appear in the index and
-	working tree, but not in <tree-ish> are removed, to make them
-	match <tree-ish> exactly.
+	working tree, but not in `<tree-ish>` are removed, to make them
+	match `<tree-ish>` exactly.
 
 <branch>::
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
2.21.0.479.g47ac719cd3

