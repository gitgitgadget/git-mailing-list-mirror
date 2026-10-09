Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61EA4D9F63
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547229; cv=none; b=uKvvH0otpzBHRQpdjTOjCl6NrHXIv6AiKEHVk/ebOzCvzgrsaq5DGY2eaUCfJDdrCseiRTU1RB6w4ibzl7N44WmTcI9Q0ozyi27Q+v76diHW5X9oUPx4d1wVxlKDM9gVgs4DQnXNbEYzYzvsZmZB9sRaZ3LOJy8FYWukwZyYUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547229; c=relaxed/simple;
	bh=g5L+TdGhM7kiKpvoWxQHPfzNGvCA9WXP8yRZ1KLJ80I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B8wz8esj6gAV5HOCN/ZPiO2pg8YcJkC2+Z1wpnh0wNhGGvl08lzibLSsF8J5dmYYL/yk0b54Hy7LxZa4ck2K5cx0t2qaxP9lPeeifLje2VJZvnpaR6Bwv6c8pm4i++4e6Wu8Rne+kPINxCr2yKf5dMOlAstMhV6TiObkdaWnTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tqayau1H; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqayau1H"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7fccba9c675so1879555a34.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547220; x=1792152020; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I5GHsg0noH+hWn+QRRhKjsN0jcEKv4tTLeGwHYzMHfw=;
        b=Tqayau1H6VJ80VbQf35kGMzwgJHFeHVwyVOk3vND5pCaT6S0sWtbUwMOKERUJvQmFf
         b0eEpKEATaQdYwarjadn0pRkw2GyuONutoMAYzHqi4MxICrvdbtVt8UMKElkDybfKcvW
         93Dy7KSY+rIevCzGpHVy49EpcQvfg0dxJPMb6gOQTRPoOye2LOI2zR7cfYR7b7oxODmY
         G4uLyiuubVFd43m6JDsvvzC7tyYkjKTMkNPiXqVjkY5YJTcHCBGdT5PMsuSWAQdKJb4I
         T++YdNVLw0DK0FHBF08f7XCJJLOLVt2N8EWq22s1xwzMw//iZzhIAb974KMSNTFtWt+n
         qB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547220; x=1792152020;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I5GHsg0noH+hWn+QRRhKjsN0jcEKv4tTLeGwHYzMHfw=;
        b=y4XqByTVnjcDB8d78Xt2CGu+2LnSBE3QT2wzRc5nBxvi6EFEZXEUhTVYi+LjM6UkQZ
         7q6juxyfuT+PD/yxlGna1ScXcmm5jsOE66T3SPLm6+aYn9iohx0StwAzdNsBqIyfoBML
         sjxuEy+EVlxdWE+PRLTbZl+It08bGpU9JFejVjVpAZB31rtgigYkNI40mj0xGC+mYxhO
         c3PbeF1dNhvvKQfl7z+BSZ3LOQHbosjhgKaqTq0eazdg845cOKRSNIs0W4PCkzeY0vEQ
         vkWtAK+oyLiG+oICawwGbKuKE0SxMWFFQqPtsrt0muuNku2Ny2HxMCvY7/76sree/X9q
         2fBA==
X-Gm-Message-State: AFuF++ko70/DzZot1LA7mmxKy7yERR2PtK2Q6ClS9zuOitmHa0IFOget
	TRUUIdkWzesZd+VvfC4bYg46bPMsJ4B/leaFPLELZAXWsZ6gjddT9oPDkdGbjQ==
X-Gm-Gg: AYBFou3REs/5/oRuh0vQL+DHt5BF6fVLuWDoFhOA1NZtuCMqCWk0GCKV56m6xnErtxO
	9TiFb1R5COGzRDNf3o7h9a3GAVtCjE16u0HOZX+fwmTZUJsOwz7WkzlWiG51RNa923qBpFUcCtU
	oWvnqnuVM+UXok5PQvsWgfDzqVMUplAg7oYBeDTrYRu/OjxPkzjJHZpO3BR55E1CNnNvubm6wUv
	Wu87bNOBRv+6NlGcG17zFJJdFlqU7v+dVkftj6ppm7dGqYv04rgLqh6/4y6v0oki6m3X5RnL9Nb
	ahEf6DgZlseAHDFC6Hhf+ut/9qYtsmQneAtX84cRFDSexAQdseBZ9G7RuYWtYBGCRyBKDGHZXK/
	lZHD+RyV/6aNADMqfnTwjZzhJpxkQLVG1hSaPX5TIOa8NX06MI8P5CxzmyzKl1cs5g6c0XEQSaa
	iHUAlr2H8Xso+LOeO0/tVb4alQdaacd8+4H30IOLYFqWtLJRzWNi+EsaV9jMtUDJf+v/CcIv5C0
	ds=
X-Received: by 2002:a05:6808:1583:b0:4ec:1bf1:fa82 with SMTP id 5614622812f47-50b6865d010mr1393093b6e.46.1791547219459;
        Fri, 09 Oct 2026 05:00:19 -0700 (PDT)
Received: from [127.0.0.1] ([172.171.13.148])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c0c5fe916sm1720535b6e.1.2026.10.09.05.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:00:17 -0700 (PDT)
Message-Id: <ab0344f947c252b1b7c8bb386586b8641223ba38.1791547213.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 12:00:08 +0000
Subject: [PATCH v2 1/6] doc: add new gitmergeconflicts man page
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

Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Reviewed-by: D. Ben Knoble <ben.knoble+github@gmail.com>
Reviewed-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Julia Evans <julia@jvns.ca>
---
 .gitattributes                       |   1 +
 Documentation/Makefile               |   1 +
 Documentation/gitmergeconflicts.adoc | 333 +++++++++++++++++++++++++++
 Documentation/meson.build            |   1 +
 command-list.txt                     |   1 +
 5 files changed, 337 insertions(+)
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
index 0000000000..5b0ba1a1de
--- /dev/null
+++ b/Documentation/gitmergeconflicts.adoc
@@ -0,0 +1,333 @@
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
+cherry-pick`, `git pull`, or `git revert`. All of those commands use
+the same merge algorithm, and the process for resolving a merge conflict
+is always very similar.
+
+The most common ways to handle a merge conflict are:
+
+* Resolve the conflict. (see <<resolve,HOW TO RESOLVE A MERGE CONFLICT>>
+  below for details)
+* Or stop the operation and return your branch to its original state
+  with the appropriate `--abort` command, for example `git merge --abort`
+  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
+  for how to find the command to run.
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
+[[markers]]
+MERGE CONFLICT MARKERS
+----------------------
+
+When there's a merge conflict, Git will update the conflicted file
+to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
+For example, here's a merge conflict where both sides edited a list of
+fruits in different ways:
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
+    "mango",
+=======
+    "banana",
+    "mango",
+>>>>>>> add-fruit
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
+* You can set the configuration option `merge.conflictstyle=diff3`.
+  See <<diff3,DIFF3 AND ZDIFF3>> below for more.
+
+* `git log --merge -p <filename>`  will list all commits which
+  caused the merge conflict for `<filename>`, and the diff
+  of how they changed the file.
+
+* Look at the original files.  `git show :1:filename` shows the
+  common ancestor, `git show :2:filename` shows the "ours"
+  version, and `git show :3:filename` shows the "theirs"
+  version.
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
+* there's one file left with conflicts in it: `fruits.py`
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
+DIFF3 AND ZDIFF3
+----------------
+
+By default, Git doesn't include the original code when formatting
+a merge conflict. To include the original code, you can set the
+configuration option `merge.conflictstyle` to `diff3` or `zdiff3`.
+This extra context can make it much easier to understand what's
+happening in a merge conflict.
+
+Here's an example of what a merge conflict would look like when using
+`diff3`. It shows, in order, the "ours" side of the conflict, the
+original code (`"mangoooo"`), and the "theirs" side of the
+conflict. With this view, you can see that both sides fixed the spelling
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
+Here's the same example using `zdiff3`. `zdiff3` takes lines that are
+shared between both sides (the `"mango"` line) and moves them outside
+the conflicted area. This makes the conflicted area shorter, but the
+downside is that it's impossible to tell if `"mango"` was part of the
+original list of fruits or not.
+
+----
+FRUITS = [
+    "apple",
+<<<<<<< HEAD
+    "cherry",
+||||||| 1c22e48
+    "mangoooo",
+=======
+    "banana",
+>>>>>>> add-fruit
+    "mango",
+    "orange",
+]
+----
+
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

