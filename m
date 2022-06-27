Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61F1C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 21:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbiF0VVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 17:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbiF0VVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 17:21:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0531D18E05
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 14:21:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso2850816wmq.4
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=i6nJ3ltKQGFUgpnVcrTBfaK/AGtiI0Gb5CcM1yyKHh8=;
        b=PHE0QMQOKsjwvpazfNyLs8sz8WUqmY1KYj27Pm5ejT8ZENZ6KI2d4F6SW6RhvuT1Yi
         dGHXvEXKEeV3vx3pGUjLQKp9tsJISPU9acG6gSHfK0SallkgNzLHfdVwHXyMWbZakt0l
         NClKYmVDnXxe92SGKhqevLsb1AsqSaWhq3TnRFxOS/xwRexur0insxodQkWhyBnd/gGS
         9tReCN7eRvSAz8EonMn2Ifhwi+QR5flygW5vE7Uc8Cde1F+4l9QxT1itekNyHE5hNQ/Z
         UTDh1K6rs1tnIbWIYc/SDJDRwbwWLUt+Ojh+0MH5HssTcfdmfAhCdn+EHG5uz8N/bk5z
         rD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=i6nJ3ltKQGFUgpnVcrTBfaK/AGtiI0Gb5CcM1yyKHh8=;
        b=FcDVrbAezTB8Nfm1zfYc5dDH7fzYgCTdUhUtWBUC5bm7sjARQBSS3WQn8kclfkwOXy
         WP54CelS3Robm7e363x9vdLAN0c8j/TALFyFIX44bNnXTxJOoAP0spt9WWhgLYynxyxb
         4IraLnyq3dH4Vx9XPvwLWwzjV78IGfsHlyhWtKZz+SayGwxckgWyPTQDM5coG5k2nZGP
         jJnodu50LimWKLL35Mt1MH0MOsZH9GPlPje7OJHDjhLm7z0iEawTPuiQsomUE8CNuFb1
         HZ6J26qCJXF9ZAr8qjhUyDhJzWX+2CXCv3WpE3RFcjop7KxvS0SW5W2GpV4RAPLmcEy+
         IDZw==
X-Gm-Message-State: AJIora9OqcqPr0gvtpR1bRoTl+ZOHQh8qcMU8NN9fQ/FNa8XpucopeMu
        6/6dzTorRbqCrLZXH143Nnp2vhnDFOEdbg==
X-Google-Smtp-Source: AGRyM1u3da/0LwU2xaW7TVO0NLC8G/2r3rzKiITVT6G+dS4XJ+iJOwLzpbfPIfUWCAc8+0we+NtkKg==
X-Received: by 2002:a05:600c:1906:b0:39c:7f82:3090 with SMTP id j6-20020a05600c190600b0039c7f823090mr22243373wmq.152.1656364863415;
        Mon, 27 Jun 2022 14:21:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m2-20020a7bcb82000000b0039744bd664esm18751550wmi.13.2022.06.27.14.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 14:21:02 -0700 (PDT)
Message-Id: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 21:21:01 +0000
Subject: [PATCH] git-rebase.txt: use back-ticks consistently
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

While inspecting the 'git rebase' documentation, I noticed that it is
inconsistent with how it uses back-ticks (or other punctuation) for
identifying Git commands, command-line arguments, or values for those
arguments.

Sometimes, an argument (like '--interactive') would appear without any
punctuation, causing the argument to not have any special formatting.
Other times, arguments or 'git rebase' itself would have single-quotes
giving a bold look (in the HTML documentation at least).

By consistently using back-ticks, these types of strings appear in a
monospace font with special highlighting to appear more clearly as text
that exists in a command-line invocation of a Git command.

This rather-large diff is the result of scanning git-rebase.txt and
adding back-ticks as appropriate. Some are adding back-ticks where there
was no punctuation. Others are replacing single quotes.

There are also a few minor cleanups in the process, such as one place
that did not use tabs for the first paragraph in a bulletted list.
Another case still referred to the dashed form, but it was the only use
in the file except for the heading and NAME section.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    git-rebase.txt: use back-ticks consistently
    
    While I noticed this inconsistency when looking at git rebase as part of
    the git rebase --update-refs work, I didn't know the best way to update
    the document from start to finish.
    
    This giant update is probably not the best way to present the change.
    
    I can see splitting it up in a few ways, but I wanted to check to first
    see if that was necessary. If it is, then here are the strategies I
    considered:
    
     1. Focus on type of update. This would mean a change for adding
        back-ticks on all --<option> text, adding back-ticks on all "git
        rebase" instances, adding back-ticks on things like <upstream>, and
        doing other types of changes like whitespace updates or "git-rebase"
        to "git rebase".
    
     2. Focus on the section of the document. This would limit the diff by
        the section size, such as OPTIONS or the discussion on the backends.
    
     3. Focus on the edits that most-recently edited these lines. Doing some
        scripting, I was able to construct this date-sorted list of previous
        edits (by diffing the git blame output before and after this
        change). The most-recent changes before this are:
    
    2005-08-26: 52a22d1e726 ([PATCH] Subject: [PATCH] Add some documentation., 2005-08-26)
    2006-02-21: 69a60af5d0a (git-rebase: Clarify usage statement and copy it into the actual documentation., 2006-02-21)
    2006-04-26: 031321c654d (Add --continue and --abort options to git-rebase., 2006-04-26)
    2006-06-21: 58634dbff82 (rebase: Allow merge strategies to be used when rebasing, 2006-06-21)
    2007-02-05: ea81fcc5762 (Show an example of deleting commits with git-rebase., 2007-02-05)
    2007-02-08: 67dad687ad1 (add -C[NUM] to git-am, 2007-02-08)
    2007-02-17: 5ca2db53763 (Attempt to improve git-rebase lead-in description., 2007-02-17)
    2007-06-25: 1b1dce4bae7 (Teach rebase an interactive mode, 2007-06-25)
    2007-06-25: f09c9b8c5ff (Teach rebase -i about --preserve-merges, 2007-06-25)
    2007-08-31: f0fd889d7ff (rebase -i: mention the option to split commits in the man page, 2007-08-31)
    2007-10-15: ff9054627c4 (git-rebase: document suppression of duplicate commits, 2007-10-15)
    2008-03-10: 702088afc68 (update 'git rebase' documentation, 2008-03-10)
    2008-07-03: 467c0197fd0 (Documentation: more "git-" versus "git " changes, 2008-07-03)
    2008-07-08: 9869099bee3 (Documentation: mention ORIG_HEAD in am, merge, and rebase, 2008-07-08)
    2008-07-21: 51ef1daa4a0 (Rename .git/rebase to .git/rebase-apply, 2008-07-21)
    2008-09-13: 90d1c08efcf (Documentation: new upstream rebase recovery section in git-rebase, 2008-09-13)
    2009-01-02: be496621012 (rebase: update documentation for --root, 2009-01-02)
    2009-03-01: a9c3821ca2f (git-rebase: Add --stat and --no-stat for producing diffstat on rebase, 2009-03-01)
    2009-06-16: 0e987a12fc1 (am, rebase: teach quiet option, 2009-06-16)
    2009-10-07: 6741aa6c399 (Teach 'rebase -i' the command "reword", 2009-10-07)
    2009-11-15: 31ddd1ee0fd (rebase docs: clarify --merge and --strategy, 2009-11-15)
    2009-12-07: 0205e72f088 (Add a command "fixup" to rebase --interactive, 2009-12-07)
    2009-12-08: f59baa502f4 (rebase -i --autosquash: auto-squash commits, 2009-12-08)
    2010-01-10: 0b444cdb19b (Documentation: spell 'git cmd' without dash throughout, 2010-01-10)
    2010-03-24: b499549401c (Teach rebase the --no-ff option., 2010-03-24)
    2010-07-14: dd1e5b313a0 (add configuration variable for --autosquash option of interactive rebase, 2010-07-14)
    2010-11-22: 7baf9c4b707 (rebase: support --verify, 2010-11-22)
    2011-02-09: 15a147e6189 (rebase: use @{upstream} if no upstream specified, 2011-02-09)
    2011-07-13: 5960bc9d63c (rebase: clarify "restore the original branch", 2011-07-13)
    2012-03-23: d3f2475c01d (documentation: fix alphabetic ordered list for git-rebase man page, 2012-03-23)
    2012-06-12: c214538416e (rebase -i: teach "--exec <cmd>", 2012-06-12)
    2012-06-26: df5df20c130 (rebase -i: support --root without --onto, 2012-06-26)
    2012-07-15: edfbbf7eead (doc: A few minor copy edits., 2012-07-15)
    2013-05-12: 587947750bd (rebase: implement --[no-]autostash and rebase.autostash, 2013-05-12)
    2014-09-18: f51a48ec3aa (Documentation/git-rebase.txt: document when --fork-point is auto-enabled, 2014-09-18)
    2015-03-11: da0005b8853 (*config.txt: stick to camelCase naming convention, 2015-03-11)
    2015-06-29: c9266d58948 (git-rebase -i: add command "drop" to remove a commit, 2015-06-29)
    2015-09-10: 82e0668cde0 (Documentation/git-rebase: fix --no-autostash formatting, 2015-09-10)
    2016-06-28: bcf9626a71a (doc: typeset long command-line options as literal, 2016-06-28)
    2016-11-12: 9512177b682 (rebase: add --quit to cleanup rebase, leave everything else untouched, 2016-11-12)
    2017-06-17: e01db917d8e (stash: update documentation to use 'stash entry', 2017-06-17)
    2018-06-25: 5dacd4abdd3 (git-rebase.txt: document incompatible options, 2018-06-25)
    2018-06-27: 0661e49aeb8 (git-rebase.txt: document behavioral differences between modes, 2018-06-27)
    2018-10-12: 71f82465b1c (rebase -i: introduce the 'break' command, 2018-10-12)
    2018-12-03: 6fcbad87d47 (rebase docs: fix incorrect format of the section Behavioral Differences, 2018-12-03)
    2018-12-10: d421afa0c66 (rebase: introduce --reschedule-failed-exec, 2018-12-10)
    2018-12-11: 68aa495b590 (rebase: implement --merge via the interactive machinery, 2018-12-11)
    2019-08-27: 414d924beb4 (rebase: teach rebase --keep-base, 2019-08-27)
    2020-02-15: 10cdb9f38ad (rebase: rename the two primary rebase backends, 2020-02-15)
    2020-02-15: 2ac0d6273fa (rebase: change the default backend from "am" to "merge", 2020-02-15)
    2020-02-15: be50c938dfc (git-rebase.txt: add more details about behavioral differences of backends, 2020-02-15)
    2020-02-15: d48e5e21da9 (rebase (interactive-backend): make --keep-empty the default, 2020-02-15)
    2020-02-15: e98c4269c86 (rebase (interactive-backend): fix handling of commits that become empty, 2020-02-15)
    2020-03-11: 120b1eb7314 (git-rebase.txt: highlight backend differences with commit rewording, 2020-03-11)
    2020-03-28: 344420bf0fb (git-rebase.txt: fix typo, 2020-03-28)
    2020-04-05: f7139e7cc2d (git-rebase.txt: add another hook to the hooks section, and explain more, 2020-04-05)
    2020-04-11: 0fcb4f6b62c (rebase --merge: optionally skip upstreamed commits, 2020-04-11)
    2020-04-11: b9cbd2958f2 (rebase: reinstate --no-keep-empty, 2020-04-11)
    2020-04-27: a35413c3785 (rebase: display an error if --root and --fork-point are both provided, 2020-04-27)
    2020-05-05: c5e786abe32 (Doc: reference the "stash list" in autostash docs, 2020-05-05)
    2020-07-13: ef484add9f6 (rebase -i: add --ignore-whitespace flag, 2020-07-13)
    2021-01-29: 2c0aa2ce2ef (doc/git-rebase: add documentation for fixup [-C|-c] options, 2021-01-29)
    2021-02-10: fa153c1cd7a (doc/rebase -i: fix typo in the documentation of 'fixup' command, 2021-02-10)
    2021-03-15: 00ea64ed7a0 (doc/git-commit: add documentation for fixup=[amend|reword] options, 2021-03-15)
    2021-04-09: e5b32bffd1d (rebase: don't override --no-reschedule-failed-exec with config, 2021-04-09)
    2021-08-04: f5a3c5e6377 (Update docs for change of default merge backend, 2021-08-04)
    2021-12-01: ddfc44a898a (update documentation for new zdiff3 conflictStyle, 2021-12-01)
    2022-04-20: 9e5ebe9668a (rebase: use correct base for --keep-base when a branch is given, 2022-04-20)
    
    
    Of course, maybe it's not worth splitting it up at all. I'm open to
    whatever reviewers recommend.
    
    I look forward to feedback on how to do this better (if it is indeed a
    good idea to do in the first place).
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1270%2Fderrickstolee%2Frebase-docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1270/derrickstolee/rebase-docs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1270

 Documentation/git-rebase.txt | 224 +++++++++++++++++------------------
 1 file changed, 112 insertions(+), 112 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 262fb01aec0..2be0f295632 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -16,40 +16,40 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-If <branch> is specified, 'git rebase' will perform an automatic
+If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
 
-If <upstream> is not specified, the upstream configured in
-branch.<name>.remote and branch.<name>.merge options will be used (see
+If `<upstream>` is not specified, the upstream configured in
+`branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
 branch does not have a configured upstream, the rebase will abort.
 
 All changes made by commits in the current branch but that are not
-in <upstream> are saved to a temporary area.  This is the same set
+in `<upstream>` are saved to a temporary area.  This is the same set
 of commits that would be shown by `git log <upstream>..HEAD`; or by
 `git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
 description on `--fork-point` below); or by `git log HEAD`, if the
 `--root` option is specified.
 
-The current branch is reset to <upstream>, or <newbase> if the
---onto option was supplied.  This has the exact same effect as
-`git reset --hard <upstream>` (or <newbase>).  ORIG_HEAD is set
+The current branch is reset to `<upstream>`, or `<newbase>` if the
+`--onto` option was supplied.  This has the exact same effect as
+`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
 to point at the tip of the branch before the reset.
 
 The commits that were previously saved into the temporary area are
 then reapplied to the current branch, one by one, in order. Note that
-any commits in HEAD which introduce the same textual changes as a commit
-in HEAD..<upstream> are omitted (i.e., a patch already accepted upstream
+any commits in `HEAD` which introduce the same textual changes as a commit
+in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
 with a different commit message or timestamp will be skipped).
 
 It is possible that a merge failure will prevent this process from being
 completely automatic.  You will have to resolve any such merge failure
 and run `git rebase --continue`.  Another option is to bypass the commit
 that caused the merge failure with `git rebase --skip`.  To check out the
-original <branch> and remove the .git/rebase-apply working files, use the
-command `git rebase --abort` instead.
+original `<branch>` and remove the `.git/rebase-apply` working files, use
+the command `git rebase --abort` instead.
 
 Assume the following history exists and the current branch is "topic":
 
@@ -176,11 +176,11 @@ would result in the removal of commits F and G:
 ------------
 
 This is useful if F and G were flawed in some way, or should not be
-part of topicA.  Note that the argument to --onto and the <upstream>
+part of topicA.  Note that the argument to `--onto` and the `<upstream>`
 parameter can be any valid commit-ish.
 
-In case of conflict, 'git rebase' will stop at the first problematic commit
-and leave conflict markers in the tree.  You can use 'git diff' to locate
+In case of conflict, `git rebase` will stop at the first problematic commit
+and leave conflict markers in the tree.  You can use `git diff` to locate
 the markers (<<<<<<) and make edits to resolve the conflict.  For each
 file you edit, you need to tell Git that the conflict has been resolved,
 typically this would be done with
@@ -205,8 +205,8 @@ OPTIONS
 -------
 --onto <newbase>::
 	Starting point at which to create the new commits. If the
-	--onto option is not specified, the starting point is
-	<upstream>.  May be any valid commit, and not just an
+	`--onto` option is not specified, the starting point is
+	`<upstream>`.  May be any valid commit, and not just an
 	existing branch name.
 +
 As a special case, you may use "A\...B" as a shortcut for the
@@ -215,19 +215,19 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 
 --keep-base::
 	Set the starting point at which to create the new commits to the
-	merge base of <upstream> and <branch>. Running
-	'git rebase --keep-base <upstream> <branch>' is equivalent to
+	merge base of `<upstream>` and `<branch>`. Running
+	`git rebase --keep-base <upstream> <branch>` is equivalent to
 	running
-	'git rebase --onto <upstream>...<branch> <upstream> <branch>'.
+	`git rebase --onto <upstream>...<branch> <upstream> <branch>`.
 +
 This option is useful in the case where one is developing a feature on
 top of an upstream branch. While the feature is being worked on, the
 upstream branch may advance and it may not be the best idea to keep
 rebasing on top of the upstream but to keep the base commit as-is.
 +
-Although both this option and --fork-point find the merge base between
-<upstream> and <branch>, this option uses the merge base as the _starting
-point_ on which new commits will be created, whereas --fork-point uses
+Although both this option and `--fork-point` find the merge base between
+`<upstream>` and `<branch>`, this option uses the merge base as the _starting
+point_ on which new commits will be created, whereas `--fork-point` uses
 the merge base to determine the _set of commits_ which will be rebased.
 +
 See also INCOMPATIBLE OPTIONS below.
@@ -238,23 +238,23 @@ See also INCOMPATIBLE OPTIONS below.
 	upstream for the current branch.
 
 <branch>::
-	Working branch; defaults to HEAD.
+	Working branch; defaults to `HEAD`.
 
 --continue::
 	Restart the rebasing process after having resolved a merge conflict.
 
 --abort::
 	Abort the rebase operation and reset HEAD to the original
-	branch. If <branch> was provided when the rebase operation was
-	started, then HEAD will be reset to <branch>. Otherwise HEAD
+	branch. If `<branch>` was provided when the rebase operation was
+	started, then `HEAD` will be reset to `<branch>`. Otherwise `HEAD`
 	will be reset to where it was when the rebase operation was
 	started.
 
 --quit::
-	Abort the rebase operation but HEAD is not reset back to the
+	Abort the rebase operation but `HEAD` is not reset back to the
 	original branch. The index and working tree are also left
 	unchanged as a result. If a temporary stash entry was created
-	using --autostash, it will be saved to the stash list.
+	using `--autostash`, it will be saved to the stash list.
 
 --apply::
 	Use applying strategies to rebase (calling `git-am`
@@ -269,16 +269,16 @@ See also INCOMPATIBLE OPTIONS below.
 	empty after rebasing (because they contain a subset of already
 	upstream changes).  With drop (the default), commits that
 	become empty are dropped.  With keep, such commits are kept.
-	With ask (implied by --interactive), the rebase will halt when
+	With ask (implied by `--interactive`), the rebase will halt when
 	an empty commit is applied allowing you to choose whether to
 	drop it, edit files more, or just commit the empty changes.
-	Other options, like --exec, will use the default of drop unless
-	-i/--interactive is explicitly specified.
+	Other options, like `--exec`, will use the default of drop unless
+	`-i`/`--interactive` is explicitly specified.
 +
-Note that commits which start empty are kept (unless --no-keep-empty
+Note that commits which start empty are kept (unless `--no-keep-empty`
 is specified), and commits which are clean cherry-picks (as determined
 by `git log --cherry-mark ...`) are detected and dropped as a
-preliminary step (unless --reapply-cherry-picks is passed).
+preliminary step (unless `--reapply-cherry-picks` is passed).
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -287,7 +287,7 @@ See also INCOMPATIBLE OPTIONS below.
 	Do not keep commits that start empty before the rebase
 	(i.e. that do not change anything from its parent) in the
 	result.  The default is to keep commits which start empty,
-	since creating such commits requires passing the --allow-empty
+	since creating such commits requires passing the `--allow-empty`
 	override flag to `git commit`, signifying that a user is very
 	intentionally creating such a commit and thus wants to keep
 	it.
@@ -299,7 +299,7 @@ flag exists as a convenient shortcut, such as for cases where external
 tools generate many empty commits and you want them all removed.
 +
 For commits which do not start empty but become empty after rebasing,
-see the --empty flag.
+see the `--empty` flag.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -348,10 +348,10 @@ See also INCOMPATIBLE OPTIONS below.
 	Using merging strategies to rebase (default).
 +
 Note that a rebase merge works by replaying each commit from the working
-branch on top of the <upstream> branch.  Because of this, when a merge
+branch on top of the `<upstream>` branch.  Because of this, when a merge
 conflict happens, the side reported as 'ours' is the so-far rebased
-series, starting with <upstream>, and 'theirs' is the working branch.  In
-other words, the sides are swapped.
+series, starting with `<upstream>`, and 'theirs' is the working branch.
+In other words, the sides are swapped.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -360,9 +360,9 @@ See also INCOMPATIBLE OPTIONS below.
 	Use the given merge strategy, instead of the default `ort`.
 	This implies `--merge`.
 +
-Because 'git rebase' replays each commit from the working branch
-on top of the <upstream> branch using the given strategy, using
-the 'ours' strategy simply empties all patches from the <branch>,
+Because `git rebase` replays each commit from the working branch
+on top of the `<upstream>` branch using the given strategy, using
+the `ours` strategy simply empties all patches from the `<branch>`,
 which makes little sense.
 +
 See also INCOMPATIBLE OPTIONS below.
@@ -371,8 +371,8 @@ See also INCOMPATIBLE OPTIONS below.
 --strategy-option=<strategy-option>::
 	Pass the <strategy-option> through to the merge strategy.
 	This implies `--merge` and, if no strategy has been
-	specified, `-s ort`.  Note the reversal of 'ours' and
-	'theirs' as noted above for the `-m` option.
+	specified, `-s ort`.  Note the reversal of `ours` and
+	`theirs` as noted above for the `-m` option.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -392,11 +392,11 @@ See also INCOMPATIBLE OPTIONS below.
 
 -q::
 --quiet::
-	Be quiet. Implies --no-stat.
+	Be quiet. Implies `--no-stat`.
 
 -v::
 --verbose::
-	Be verbose. Implies --stat.
+	Be verbose. Implies `--stat`.
 
 --stat::
 	Show a diffstat of what changed upstream since the last rebase. The
@@ -411,13 +411,13 @@ See also INCOMPATIBLE OPTIONS below.
 
 --verify::
 	Allows the pre-rebase hook to run, which is the default.  This option can
-	be used to override --no-verify.  See also linkgit:githooks[5].
+	be used to override `--no-verify`.  See also linkgit:githooks[5].
 
 -C<n>::
-	Ensure at least <n> lines of surrounding context match before
+	Ensure at least `<n>` lines of surrounding context match before
 	and after each change.  When fewer lines of surrounding
 	context exist they all must match.  By default no context is
-	ever ignored.  Implies --apply.
+	ever ignored.  Implies `--apply`.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -436,21 +436,21 @@ details).
 
 --fork-point::
 --no-fork-point::
-	Use reflog to find a better common ancestor between <upstream>
-	and <branch> when calculating which commits have been
-	introduced by <branch>.
+	Use reflog to find a better common ancestor between `<upstream>`
+	and `<branch>` when calculating which commits have been
+	introduced by `<branch>`.
 +
-When --fork-point is active, 'fork_point' will be used instead of
-<upstream> to calculate the set of commits to rebase, where
+When `--fork-point` is active, 'fork_point' will be used instead of
+`<upstream>` to calculate the set of commits to rebase, where
 'fork_point' is the result of `git merge-base --fork-point <upstream>
 <branch>` command (see linkgit:git-merge-base[1]).  If 'fork_point'
-ends up being empty, the <upstream> will be used as a fallback.
+ends up being empty, the `<upstream>` will be used as a fallback.
 +
-If <upstream> is given on the command line, then the default is
+If `<upstream>` is given on the command line, then the default is
 `--no-fork-point`, otherwise the default is `--fork-point`. See also
 `rebase.forkpoint` in linkgit:git-config[1].
 +
-If your branch was based on <upstream> but <upstream> was rewound and
+If your branch was based on `<upstream>` but `<upstream>` was rewound and
 your branch contains commits which were dropped, this option can be used
 with `--keep-base` in order to drop those commits from your branch.
 +
@@ -458,24 +458,24 @@ See also INCOMPATIBLE OPTIONS below.
 
 --ignore-whitespace::
 	Ignore whitespace differences when trying to reconcile
-differences. Currently, each backend implements an approximation of
-this behavior:
+	differences. Currently, each backend implements an approximation of
+	this behavior:
 +
-apply backend: When applying a patch, ignore changes in whitespace in
+'apply backend:' When applying a patch, ignore changes in whitespace in
 context lines. Unfortunately, this means that if the "old" lines being
 replaced by the patch differ only in whitespace from the existing
 file, you will get a merge conflict instead of a successful patch
 application.
 +
-merge backend: Treat lines with only whitespace changes as unchanged
+'merge backend:' Treat lines with only whitespace changes as unchanged
 when merging. Unfortunately, this means that any patch hunks that were
 intended to modify whitespace and nothing else will be dropped, even
 if the other side had no changes that conflicted.
 
 --whitespace=<option>::
-	This flag is passed to the 'git apply' program
+	This flag is passed to the `git apply` program
 	(see linkgit:git-apply[1]) that applies the patch.
-	Implies --apply.
+	Implies `--apply`.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -536,8 +536,8 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
 
 -x <cmd>::
 --exec <cmd>::
-	Append "exec <cmd>" after each line creating a commit in the
-	final history. <cmd> will be interpreted as one or more shell
+	Append `exec <cmd>` after each line creating a commit in the
+	final history. `<cmd>` will be interpreted as one or more shell
 	commands. Any command that fails will interrupt the rebase,
 	with exit code 1.
 +
@@ -550,7 +550,7 @@ or by giving more than one `--exec`:
 +
 	git rebase -i --exec "cmd1" --exec "cmd2" --exec ...
 +
-If `--autosquash` is used, "exec" lines will not be appended for
+If `--autosquash` is used, `exec` lines will not be appended for
 the intermediate commits, and will only appear at the end of each
 squash/fixup series.
 +
@@ -560,11 +560,12 @@ without an explicit `--interactive`.
 See also INCOMPATIBLE OPTIONS below.
 
 --root::
-	Rebase all commits reachable from <branch>, instead of
-	limiting them with an <upstream>.  This allows you to rebase
-	the root commit(s) on a branch.  When used with --onto, it
-	will skip changes already contained in <newbase> (instead of
-	<upstream>) whereas without --onto it will operate on every change.
+	Rebase all commits reachable from `<branch>`, instead of
+	limiting them with an `<upstream>`.  This allows you to rebase
+	the root commit(s) on a branch.  When used with `--onto`, it
+	will skip changes already contained in `<newbase>` (instead of
+	`<upstream>`) whereas without `--onto` it will operate on every
+	change.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -643,9 +644,9 @@ In addition, the following pairs of options are incompatible:
 BEHAVIORAL DIFFERENCES
 -----------------------
 
-git rebase has two primary backends: apply and merge.  (The apply
-backend used to be known as the 'am' backend, but the name led to
-confusion as it looks like a verb instead of a noun.  Also, the merge
+`git rebase` has two primary backends: `apply` and `merge`.  (The `apply`
+backend used to be known as the `am` backend, but the name led to
+confusion as it looks like a verb instead of a noun.  Also, the `merge`
 backend used to be known as the interactive backend, but it is now
 used for non-interactive cases as well.  Both were renamed based on
 lower-level functionality that underpinned each.) There are some
@@ -654,19 +655,19 @@ subtle differences in how these two backends behave:
 Empty commits
 ~~~~~~~~~~~~~
 
-The apply backend unfortunately drops intentionally empty commits, i.e.
+The `apply` backend unfortunately drops intentionally empty commits, i.e.
 commits that started empty, though these are rare in practice.  It
 also drops commits that become empty and has no option for controlling
 this behavior.
 
-The merge backend keeps intentionally empty commits by default (though
-with -i they are marked as empty in the todo list editor, or they can
-be dropped automatically with --no-keep-empty).
+The `merge` backend keeps intentionally empty commits by default (though
+with `-i` they are marked as empty in the todo list editor, or they can
+be dropped automatically with `--no-keep-empty`).
 
 Similar to the apply backend, by default the merge backend drops
-commits that become empty unless -i/--interactive is specified (in
+commits that become empty unless `-i`/`--interactive` is specified (in
 which case it stops and asks the user what to do).  The merge backend
-also has an --empty={drop,keep,ask} option for changing the behavior
+also has an `--empty={drop,keep,ask}` option for changing the behavior
 of handling commits that become empty.
 
 Directory rename detection
@@ -674,20 +675,20 @@ Directory rename detection
 
 Due to the lack of accurate tree information (arising from
 constructing fake ancestors with the limited information available in
-patches), directory rename detection is disabled in the apply backend.
+patches), directory rename detection is disabled in the `apply` backend.
 Disabled directory rename detection means that if one side of history
 renames a directory and the other adds new files to the old directory,
 then the new files will be left behind in the old directory without
 any warning at the time of rebasing that you may want to move these
 files into the new directory.
 
-Directory rename detection works with the merge backend to provide you
+Directory rename detection works with the `merge` backend to provide you
 warnings in such cases.
 
 Context
 ~~~~~~~
 
-The apply backend works by creating a sequence of patches (by calling
+The `apply` backend works by creating a sequence of patches (by calling
 `format-patch` internally), and then applying the patches in sequence
 (calling `am` internally).  Patches are composed of multiple hunks,
 each with line numbers, a context region, and the actual changes.  The
@@ -698,11 +699,11 @@ order to apply the changes to the right lines.  However, if multiple
 areas of the code have the same surrounding lines of context, the
 wrong one can be picked.  There are real-world cases where this has
 caused commits to be reapplied incorrectly with no conflicts reported.
-Setting diff.context to a larger value may prevent such types of
+Setting `diff.context` to a larger value may prevent such types of
 problems, but increases the chance of spurious conflicts (since it
 will require more lines of matching context to apply).
 
-The merge backend works with a full copy of each relevant file,
+The `merge` backend works with a full copy of each relevant file,
 insulating it from these types of problems.
 
 Labelling of conflicts markers
@@ -710,30 +711,30 @@ Labelling of conflicts markers
 
 When there are content conflicts, the merge machinery tries to
 annotate each side's conflict markers with the commits where the
-content came from.  Since the apply backend drops the original
+content came from.  Since the `apply` backend drops the original
 information about the rebased commits and their parents (and instead
 generates new fake commits based off limited information in the
 generated patches), those commits cannot be identified; instead it has
-to fall back to a commit summary.  Also, when merge.conflictStyle is
-set to diff3 or zdiff3, the apply backend will use "constructed merge
+to fall back to a commit summary.  Also, when `merge.conflictStyle` is
+set to `diff3` or `zdiff3`, the `apply` backend will use "constructed merge
 base" to label the content from the merge base, and thus provide no
 information about the merge base commit whatsoever.
 
-The merge backend works with the full commits on both sides of history
+The `merge` backend works with the full commits on both sides of history
 and thus has no such limitations.
 
 Hooks
 ~~~~~
 
-The apply backend has not traditionally called the post-commit hook,
-while the merge backend has.  Both have called the post-checkout hook,
-though the merge backend has squelched its output.  Further, both
+The `apply` backend has not traditionally called the post-commit hook,
+while the `merge` backend has.  Both have called the post-checkout hook,
+though the `merge` backend has squelched its output.  Further, both
 backends only call the post-checkout hook with the starting point
 commit of the rebase, not the intermediate commits nor the final
 commit.  In each case, the calling of these hooks was by accident of
 implementation rather than by design (both backends were originally
 implemented as shell scripts and happened to invoke other commands
-like 'git checkout' or 'git commit' that would call the hooks).  Both
+like `git checkout` or `git commit` that would call the hooks).  Both
 backends should have the same behavior, though it is not entirely
 clear which, if any, is correct.  We will likely make rebase stop
 calling either of these hooks in the future.
@@ -741,10 +742,10 @@ calling either of these hooks in the future.
 Interruptability
 ~~~~~~~~~~~~~~~~
 
-The apply backend has safety problems with an ill-timed interrupt; if
+The `apply` backend has safety problems with an ill-timed interrupt; if
 the user presses Ctrl-C at the wrong time to try to abort the rebase,
 the rebase can enter a state where it cannot be aborted with a
-subsequent `git rebase --abort`.  The merge backend does not appear to
+subsequent `git rebase --abort`.  The `merge` backend does not appear to
 suffer from the same shortcoming.  (See
 https://lore.kernel.org/git/20200207132152.GC2868@szeder.dev/ for
 details.)
@@ -756,8 +757,8 @@ When a conflict occurs while rebasing, rebase stops and asks the user
 to resolve.  Since the user may need to make notable changes while
 resolving conflicts, after conflicts are resolved and the user has run
 `git rebase --continue`, the rebase should open an editor and ask the
-user to update the commit message.  The merge backend does this, while
-the apply backend blindly applies the original commit message.
+user to update the commit message.  The `merge` backend does this, while
+the `apply` backend blindly applies the original commit message.
 
 Miscellaneous differences
 ~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -777,23 +778,23 @@ completeness:
   them to stderr.
 
 * State directories: The two backends keep their state in different
-  directories under .git/
+  directories under `.git/`
 
 include::merge-strategies.txt[]
 
 NOTES
 -----
 
-You should understand the implications of using 'git rebase' on a
+You should understand the implications of using `git rebase` on a
 repository that you share.  See also RECOVERING FROM UPSTREAM REBASE
 below.
 
-When the git-rebase command is run, it will first execute a "pre-rebase"
+When the `git rebase` command is run, it will first execute a "pre-rebase"
 hook if one exists.  You can use this hook to do sanity checks and
 reject the rebase if it isn't appropriate.  Please see the template
 pre-rebase hook script for an example.
 
-Upon completion, <branch> will be the current branch.
+Upon completion, `<branch>` will be the current branch.
 
 INTERACTIVE MODE
 ----------------
@@ -848,7 +849,7 @@ not look at them but at the commit names ("deadbee" and "fa1afe1" in this
 example), so do not delete or edit the names.
 
 By replacing the command "pick" with the command "edit", you can tell
-'git rebase' to stop after applying that commit, so that you can edit
+`git rebase` to stop after applying that commit, so that you can edit
 the files and/or the commit message, amend the commit, and continue
 rebasing.
 
@@ -876,14 +877,13 @@ commit, the message from the final one is used.  You can also use
 "fixup -C" to get the same behavior as "fixup -c" except without opening
 an editor.
 
-
-'git rebase' will stop when "pick" has been replaced with "edit" or
+`git rebase` will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
 and/or resolving conflicts you can continue with `git rebase --continue`.
 
 For example, if you want to reorder the last 5 commits, such that what
-was HEAD~4 becomes the new HEAD. To achieve that, you would call
-'git rebase' like this:
+was `HEAD~4` becomes the new `HEAD`. To achieve that, you would call
+`git rebase` like this:
 
 ----------------------
 $ git rebase -i HEAD~5
@@ -903,7 +903,7 @@ like this:
 ------------------
 
 Suppose you want to rebase the side branch starting at "A" to "Q". Make
-sure that the current HEAD is "B", and call
+sure that the current `HEAD` is "B", and call
 
 -----------------------------
 $ git rebase -i -r --onto Q O
@@ -956,23 +956,23 @@ SPLITTING COMMITS
 -----------------
 
 In interactive mode, you can mark commits with the action "edit".  However,
-this does not necessarily mean that 'git rebase' expects the result of this
+this does not necessarily mean that `git rebase` expects the result of this
 edit to be exactly one commit.  Indeed, you can undo the commit, or you can
 add other commits.  This can be used to split a commit into two:
 
 - Start an interactive rebase with `git rebase -i <commit>^`, where
-  <commit> is the commit you want to split.  In fact, any commit range
+  `<commit>` is the commit you want to split.  In fact, any commit range
   will do, as long as it contains that commit.
 
 - Mark the commit you want to split with the action "edit".
 
 - When it comes to editing that commit, execute `git reset HEAD^`.  The
-  effect is that the HEAD is rewound by one, and the index follows suit.
+  effect is that the `HEAD` is rewound by one, and the index follows suit.
   However, the working tree stays the same.
 
 - Now add the changes to the index that you want to have in the first
   commit.  You can use `git add` (possibly interactively) or
-  'git gui' (or both) to do that.
+  `git gui` (or both) to do that.
 
 - Commit the now-current index with whatever commit message is appropriate
   now.
@@ -983,7 +983,7 @@ add other commits.  This can be used to split a commit into two:
 
 If you are not absolutely sure that the intermediate revisions are
 consistent (they compile, pass the testsuite, etc.) you should use
-'git stash' to stash away the not-yet-committed changes
+`git stash` to stash away the not-yet-committed changes
 after each commit, test, and amend the commit if fixes are necessary.
 
 
@@ -1087,12 +1087,12 @@ NOTE: While an "easy case recovery" sometimes appears to be successful
       example, a commit that was removed via `git rebase
       --interactive` will be **resurrected**!
 
-The idea is to manually tell 'git rebase' "where the old 'subsystem'
+The idea is to manually tell `git rebase` "where the old 'subsystem'
 ended and your 'topic' began", that is, what the old merge base
 between them was.  You will have to find a way to name the last commit
 of the old 'subsystem', for example:
 
-* With the 'subsystem' reflog: after 'git fetch', the old tip of
+* With the 'subsystem' reflog: after `git fetch`, the old tip of
   'subsystem' is at `subsystem@{1}`.  Subsequent fetches will
   increase the number.  (See linkgit:git-reflog[1].)
 

base-commit: 9bef0b1e6ec371e786c2fba3edcc06ad040a536c
-- 
gitgitgadget
