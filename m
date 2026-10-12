Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835148E0D3
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816800; cv=none; b=SPfjp+ZFerp8vJ+bwPq0ysGu17HG7q2Z8+pKRdUOb7cuUbBTNNCDX1FU7GjUQU2GJdaenEkd0FKSuWpjbiLYBRbnGlce/LPty6IGxyEnu1dGtebnpwRUxcBxxwH9r9qV0wyMbwKoVXQwLqnP1CFV19e66E8659JHrFtLWeNAmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816800; c=relaxed/simple;
	bh=OFb0Zn9Kksynm0GvGKMohxuGNeYigRqioAmfMFyjba0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rzdMLzmNfW2KXgBQzvfgz/hf5U7WrQXH9WWeCLyCgaizoBlpdSi4p6aWTBM+VZO5hg8soJHhmLADWngrtUp/PJcGtG0jOQlRSaKaLqaMgwz8urFiiXPxoY3xzN6SXUcLDoMdpWaP3R2l9tW3yW98du7WQpvC3+AW8SuygLN944s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIliamD5; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIliamD5"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b0703011c2so13642697b3.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816798; x=1792421598; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hrNT6cwXv2IIRVLA6KzdGkPOpTcwpjcZZQtb2xJafj0=;
        b=gIliamD5iyi/DQ8a7jNur1OKebSprJTScCIfczY5yvOK892yIV6bV6hiNL3nRGXgGL
         EtO2nMg1Tyxk190BoZEMHqjc5IPibi0rkQxX9lR4Almz5eRqAP9O9kuM9laLuUhfm4od
         aM6NuqkF8ibZAGQtu4rCe+baWHj5UJ+3JON3BiR9tEe9fgOo3qk4Wu1LzlhHqKWCLgYq
         RjPot21C8YeiuJt4gEF9+N7xO8eRT6EiRH3U5ZUTOVrBhrYs8pwwIDQ1ZcjgmNyURyga
         3qSUPpDuar/9bqPCc0ynw6ocreX8TWTxpxzZHnzLhCxb8Kn3cYeMyLG/0wzmA0+SF0P1
         DdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816798; x=1792421598;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hrNT6cwXv2IIRVLA6KzdGkPOpTcwpjcZZQtb2xJafj0=;
        b=wItvuTfpseuiPecwFZXyGg65JuW5LtRcjGwap/kWymD80Y76VAulIKWIWszGqGaQMV
         6C5j10a3Q2qTqpwDIwPiVP8l94np14ALMxIjOZd1FhI+5+/CGLAKz50tDCjLaerXdSpt
         KPtqEZJmEpspXNMfBC+St08TH0RECaC/xU5CP6Va40VwVZ9+uFFnbKkFf0wWY1VTX+pE
         pTM53mj08WkDvtoD1BqR0abMh5gkN325pCl2JxBMGt+CnX30R1Q9fK588Uih5rbxXyWv
         8zpNtmOSmoivOEd/LUgQdAH5AoyUO5GIp0ZgwMvgu/y8FAdeykeI5qmCgJ57NXYrIQu9
         B1wA==
X-Gm-Message-State: AFq9FYKb1zn5mKYR5ULkIIUQYyBibMWBDGrG5odoAj2jN84RT9OTosBL
	2X76D8W23a7UIon3R40jthch9Agiv0IV1IrEwVyvO5Tt6MGuGMtCjg03t+fJzrYa
X-Gm-Gg: AYBFou2yIXCxDwMQ5gQAuXz2V2RMp9TwZGZtNWvMAYI1F3RTpEwA16/D82+ExWWy6k5
	P/IUbVxQbyJJT8SwAQEr2PBwDCQuQ/PkcUV/nTAVzjhOvT8EFipEId+F9AZQ53P6cK25P8l8lg0
	G0dJqy8jTc/hpUknMc6EuKu5YaDILILLxERqCpkPrthev/kAwG62KE8WgosTcz+ghcoaLmC2yHn
	7QQ63DyuCqwxrc1FS7YmsrW/9vKhXiIQXevxfXEoPVJIIsMV9ibckj7jiKVL3/MPGgcA4QsgsC0
	3nobVirgolVFFr4q8RJiuengXm5O1vowJQ4NK4VnuHAza0bI+ZHya12r3AVEbf9FX1SCemgdDFd
	tyDvQOOmXyh9cvxA9QzSg6C7W9AyWr6xQvusHI2U4nEEb9WSQtm/amz9szSERWjlmxancDT5lxh
	CIkdOoAP5iEf4n8WGQNsnoT4XaVt1wPXq0LXX3CNwfpE4ZElzmwTv3NsEJFu6xAWuak0tLF1EEp
	alPlSBWJjg=
X-Received: by 2002:a05:690c:85:b0:81f:e7c5:f420 with SMTP id 00721157ae682-8b07edbfb2emr30619227b3.20.1791816797321;
        Mon, 12 Oct 2026 07:53:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.84.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1b7d11sm33917297b3.13.2026.10.12.07.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:53:16 -0700 (PDT)
Message-Id: <7aa0ae7ec3c1d02aa1533c27fa40f4815c03ba6e.1791816795.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 14:53:10 +0000
Subject: [PATCH v3 1/6] doc: add new gitmergeconflicts man page
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Introduce a new page, `gitmergeconflicts`, that explains the process of
handling a merge conflict in a way that addresses the following issues,
which came from feedback from Git users on the current explanation of
merge conflicts in the `git merge` man page:

- The process for resolving a merge conflict is only explained in the
  `git merge` man page, even though there are several other commands
  which can result in conflicts
- Sometimes we use "ours" and "theirs" to refer to the two sides of
  the merge conflicts and sometimes we use HEAD and MERGE_HEAD. It should
  be consistent. Also the terms "ours" and "theirs" are not explained.
  Similarly, it says "The part before the `=======` is typically your
  side...", but doesn't explain what "typically" means.
- It introduces the merge format using an analogy to RCS, which very few
  Git users have ever used
- In "The only clean-ups you need are to reset the index file to the
  `HEAD` commit to reverse 2. and to clean up working tree changes made
  by 2. and 3.", it's not clear to users what "2" and "3" are supposed
  to mean
- It uses a cultural reference ("Conflict resolution is hard; let's go
  shopping.") which is confusing or unfamiliar to some people. I think it
  would be clearer for users to use a code example instead.
- It doesn't explain the difference between diff3 and zdiff3
- It sometimes uses the term "area" and sometimes uses the term "hunk"

Also document the unified `--abort`, `--continue` workflow in one
place, since it's a really nice example of a place Git has a consistent
interface between similar commands.

Only discuss merge, rebase, cherry-pick, and revert for now even though
there are other ways that merge conflicts can happen because it's
awkward to talk about `am`, `apply`, and `checkout -m`.

Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Helped-by: D. Ben Knoble <ben.knoble+github@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Julia Evans <julia@jvns.ca>
Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Julia Evans <julia@jvns.ca>
---
 .gitattributes                       |   1 +
 Documentation/Makefile               |   1 +
 Documentation/gitmergeconflicts.adoc | 330 +++++++++++++++++++++++++++
 Documentation/meson.build            |   1 +
 command-list.txt                     |   1 +
 5 files changed, 334 insertions(+)
 create mode 100644 Documentation/gitmergeconflicts.adoc

diff --git a/.gitattributes b/.gitattributes
index 26490ad60a..0a0fc950b1 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -14,6 +14,7 @@ CODE_OF_CONDUCT.md -whitespace
 /t/oid-info/* text eol=lf
 /Documentation/git-merge.adoc conflict-marker-size=32
 /Documentation/git-merge-file.adoc conflict-marker-size=32
+/Documentation/gitmergeconflicts.adoc conflict-marker-size=32
 /Documentation/gitk.adoc conflict-marker-size=32
 /Documentation/user-manual.adoc conflict-marker-size=32
 /t/t????-*.sh conflict-marker-size=32
diff --git a/Documentation/Makefile b/Documentation/Makefile
index f8dea4b395..bc49641dda 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -58,6 +58,7 @@ MAN7_TXT += gitdiffcore.adoc
 MAN7_TXT += giteveryday.adoc
 MAN7_TXT += gitfaq.adoc
 MAN7_TXT += gitglossary.adoc
+MAN7_TXT += gitmergeconflicts.adoc
 MAN7_TXT += gitpacking.adoc
 MAN7_TXT += gitnamespaces.adoc
 MAN7_TXT += gitremote-helpers.adoc
diff --git a/Documentation/gitmergeconflicts.adoc b/Documentation/gitmergeconflicts.adoc
new file mode 100644
index 0000000000..3c6eaaddf8
--- /dev/null
+++ b/Documentation/gitmergeconflicts.adoc
@@ -0,0 +1,330 @@
+gitmergeconflicts(7)
+====================
+
+NAME
+----
+gitmergeconflicts - Guide to handling merge conflicts
+
+DESCRIPTION
+-----------
+
+Merge conflicts can happen during a `git merge`, `git rebase`, `git
+cherry-pick`, `git pull`, `git revert`, or any other command that does
+a merge. All of those commands use the same merge algorithm, and the
+process for resolving a merge conflict is always very similar.
+
+There are 3 ways to handle a merge conflict:
+
+* Resolve the conflict. (see <<resolve,HOW TO RESOLVE A MERGE CONFLICT>>
+  below for details)
+* Stop the operation and return your branch to its original state
+  with the appropriate `--abort` command, for example `git merge --abort`
+  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
+  for how to find the command to run.
+* Or (if you're in a multi-step rebase or cherry-pick) skip the problematic
+  commit with the appropriate `--skip` command
+
+WHAT IS A MERGE CONFLICT?
+-------------------------
+
+When Git merges two commits together, it looks at the changes that
+each side has made and combines those changes. For example, if one side
+edited lines 1-5 of `hello.py` and the other side edited lines 20-25 of
+the same file, then it can easily combine them since there's no overlap.
+
+But if both sides edited overlapping lines of the same file (for example
+one side edited lines 1-5 and the other edited lines 3-6), Git will
+not try to guess how to combine those changes. This is called a "merge
+conflict".
+
+When this happens, Git shows you both sides' edits and asks you to pick
+how to resolve them. It:
+
+* Stages all of the files which were successfully merged
+* For the files with conflicts, it marks them as conflicted, puts both
+  sides' edits in the file, and leaves <<markers, merge conflict markers>>
+  that you need to resolve.
+
+[NOTE]
+================================
+Even if Git successfully merges both sides with no conflicts, it's
+possible to end up with code that doesn't work. For example, this can
+happen if one side renames a function, and the other side adds a call to
+the old function. This is called a "semantic merge conflict".
+================================
+
+[[markers]]
+MERGE CONFLICT MARKERS
+----------------------
+
+When there's a merge conflict, Git will update the conflicted file
+to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
+For example, here's a merge conflict where both sides edited a list of
+fruits in different ways -- one side added "cherry" and the other side
+added "banana":
+
+----
+FRUITS = [
+    "apple",
+<<<<<<< HEAD
+    "cherry",
+=======
+    "banana",
+>>>>>>> add-fruit
+    "mango",
+    "orange",
+]
+----
+
+The code from one side of the merge conflict is between `<<<<<<<` and
+`=======`, and the code for the other side is between `=======` and
+`>>>>>>>`. See <<ours,"OURS" AND "THEIRS">> below for a full explanation
+of which side is which.
+
+
+[[resolve]]
+HOW TO RESOLVE A MERGE CONFLICT
+-------------------------------
+
+The process for resolving a merge conflict is:
+
+1. Run `git status` to get a list of files with merge conflicts
+2. For each one, find the conflict markers
+   (the `<<<<<<<`, `=======`, `>>>>>>>`) and edit the code to
+   fix the conflict
+3. Run `git add FILENAME` for each file to mark the conflict as resolved
+4. Run the appropriate `--continue` command to continue the operation
+   that was interrupted by the conflict, for example `git merge --continue`
+   or `git rebase --continue`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>>
+   below for how to find the command to run.
++
+Note: During a `git merge`, `git commit` and `git merge --continue` do
+the same thing.
+
+
+[[example]]
+EXAMPLE OF RESOLVING A MERGE CONFLICT
+-------------------------------------
+
+If you see this in your code during a merge conflict:
+
+----
+FRUITS = [
+    "apple",
+<<<<<<< HEAD
+    "cherry",
+=======
+    "banana",
+>>>>>>> add-fruit
+    "mango",
+    "orange",
+]
+----
+
+Then you might edit that part of the code like this,
+which includes the fruits from both sides of the conflict:
+
+----
+FRUITS = [
+    "apple",
+    "banana",
+    "cherry",
+    "mango",
+    "orange",
+]
+----
+
+
+[[tools]]
+TOOLS FOR HANDLING MERGE CONFLICTS
+----------------------------------
+
+Here are some ways to get extra context while handling a merge conflict:
+
+* There are many graphical "merge tools" for Git, which will normally
+  show you the different versions of the code side by side.
+  If you have a mergetool configured, `git mergetool` will launch it.
+  See also `merge.tool` in linkgit:git-config[1] for a list of
+  the mergetools Git supports.
+
+* You can set the configuration variable `merge.conflictstyle=diff3`.
+  See <<diff3,DIFF3>> below for more.
+
+* `git log --merge -p <filename>`  will list all commits which
+  caused the merge conflict for `<filename>`, and the diff
+  of how they changed the file.
+
+* Look at the original files.  `git show :1:filename` shows the
+  common ancestor, `git show :2:filename` shows the "ours"
+  version, and `git show :3:filename` shows the "theirs"
+  version. See <<ours,"OURS" AND "THEIRS">> below for more on
+  "ours" and "theirs".
+
+Here are some ways to track your progress while handling a conflict:
+
+* Use `git status` to get a list of files with conflicts
+
+* Use `git diff --check` to make sure you haven't left any merge
+  conflict markers in a file by accident. It will print "leftover
+  conflict marker" if it finds any.
+
+* Use `git diff AUTO_MERGE` to show what changes you've made so far to
+  resolve the conflicts.
+  See <<automerge,EXAMPLE OF USING `AUTO_MERGE`>> below for more.
+
+[[git_status]]
+EXAMPLE: GIT STATUS OUTPUT
+--------------------------
+
+When you're in a merge conflict, you can find out what commands to run
+to handle the conflict by running `git status`.
+
+For example, this `git status` output tells you that:
+
+* `git rebase --abort` will safely bring your branch back to its
+  original state
+* you should run `git rebase --continue` when you're done resolving all
+  the conflicts
+* the conflicts in `fruits.py` haven't been marked as resolved
+
+----
+$ git status
+You are currently rebasing branch 'main' on '58a9fcc'.
+  (fix conflicts and then run "git rebase --continue")
+  (use "git rebase --skip" to skip this patch)
+  (use "git rebase --abort" to check out the original branch)
+
+Unmerged paths:
+  (use "git restore --staged <file>..." to unstage)
+  (use "git add <file>..." to mark resolution)
+        both modified:   fruits.py
+----
+
+
+[[diff3]]
+DIFF3
+-----
+
+By default, Git doesn't include the original code when formatting
+a merge conflict. To include the original code, you can set the
+configuration option `merge.conflictstyle` to `diff3`.
+This extra context can make it much easier to understand what's
+happening in a merge conflict.
+
+Here's an example of what a merge conflict would look like when using
+`diff3`. There's an extra section (between `|||||||` and `=======`)
+with the original code.
+
+With this view, you can see that both sides fixed a spelling
+mistake in "mango", and each added one fruit to the list.
+
+----
+FRUITS = [
+    "apple",
+<<<<<<< HEAD
+    "cherry",
+    "mango",
+||||||| 1c22e48
+    "mangoooo",
+=======
+    "banana",
+    "mango",
+>>>>>>> add-fruit
+    "orange",
+]
+----
+
+[NOTE]
+================================
+`zdiff3` is an alternative to `diff3` that makes the merge conflict
+shorter by making it more ambiguous.
+================================
+
+[[ours]]
+"OURS" AND "THEIRS"
+-------------------
+
+Sometimes during a merge conflict, Git will use the terms "ours" and
+"theirs" (or "us" and "them"). For example, `git status` might say that
+a file was `deleted by us`.
+
+"Ours" and "theirs" are both commits: "ours" is the current
+`HEAD` commit, and "theirs" is the other side being merged.
+
+The first part of a merge conflict (between `<<<<<<<` and `=======`) is
+from the "ours" side, and the second part (between `=======` and
+`>>>>>>>`) is from the "theirs" side.
+
+----
+FRUITS = [
+    "apple",
+<<<<<<< HEAD
+    "cherry",                      <- ours
+=======
+    "banana",                      <- theirs
+>>>>>>> add-fruit
+    "mango",
+    "orange",
+]
+----
+
+During a rebase, it can seem "upside down" because the "ours" commit is
+from the branch you're rebasing on (for instance `main` in `git rebase
+main`).
+
+These terms in Git all mean the same thing when dealing with a merge
+conflict:
+
+* "common ancestor" and "base". The files from this commit are "in stage 1".
+* "ours", "us", and `HEAD`. The files from this commit are "in stage 2".
+* "theirs", "them". The files from this commit are "in stage 3".
+
+If you're confused about what something like "deleted by us" means, it's
+often easiest to use some of the tools from
+<<tools,TOOLS FOR HANDLING MERGE CONFLICTS>> above to get more context.
+Finding the commit that deleted the file and seeing why is usually more
+helpful than trying to abstractly reason through what "us" means.
+
+[[automerge]]
+EXAMPLE OF USING `AUTO_MERGE`
+-----------------------------
+
+`git diff AUTO_MERGE` will show what changes you've made so far to
+resolve conflicts. `AUTO_MERGE` is a reference that Git creates during a
+merge. It contains the result of running the merge algorithm.
+
+For example, if we resolved the conflict by adding both "banana" and
+"cherry" in order, the diff would look like this:
+
+----
+ FRUITS = [
+     "apple",
+-<<<<<<< HEAD
+-    "cherry",
+-=======
+     "banana",
+->>>>>>> add-fruit
++    "cherry",
+     "mango",
+     "orange",
+ ]
+----
+
+[NOTE]
+`AUTO_MERGE` is only set if you're using the default Git merge algorithm.
+
+
+SEE ALSO
+--------
+
+linkgit:git-revert[1]
+linkgit:git-merge[1]
+linkgit:git-rebase[1]
+linkgit:git-cherry-pick[1]
+linkgit:git-pull[1]
+linkgit:git-diff[1]
+
+GIT
+---
+
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f4854f802d..51647957e0 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -202,6 +202,7 @@ manpages = {
   'gitfaq.adoc' : 7,
   'gitglossary.adoc' : 7,
   'gitpacking.adoc' : 7,
+  'gitmergeconflicts.adoc' : 7,
   'gitnamespaces.adoc' : 7,
   'gitremote-helpers.adoc' : 7,
   'gitrevisions.adoc' : 7,
diff --git a/command-list.txt b/command-list.txt
index 63ae2a67c9..f6e49c3c85 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -232,6 +232,7 @@ githooks                                userinterfaces
 gitignore                               userinterfaces
 gitk                                    mainporcelain
 gitmailmap                              userinterfaces
+gitmergeconflicts                       guide
 gitmodules                              userinterfaces
 gitnamespaces                           guide
 gitprotocol-capabilities                developerinterfaces
-- 
gitgitgadget

