Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018411;
	b=4fP9CZJL3SUfnUqYkoevlBgXC9LCDWji+qmjheQ3G+mxbVjTHS3X4lLhfl0T9eCgPDyX
	 MEP00qFPe7JxCXoj6ARnYdXxrmb6/fGwv4jElXyxhbfHKZCL+c9sJ5FZ137vcYeD49Oxc
	 fjlo1JDAsxQs26fOQydgy4yaehcnOO1/sORCABE1AcfGU82iN3e9QJ8EeGnypp3GUQoSn
	 5Dz/Sp9GQp2lYoBvnb+nT3fD8j+5Sb6RahTpqYv5yFAjCdughx6Zzrtbk/nOEuQwDuF9v
	 VW8AbeoojU6qURhNFcv3DlXFyBwQn/KIpRaZyZM3ANRZAR0F35sg5sS/5WYGH0SI84w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=T7S8diiA/DmsuYNjXa9n2P00Y/X47ue8rqEhzCok4QI=;
	b=FtHsuQnU0vjKNOABqdRfLSYrQJHieInhN3pjqMXKlR4ysZJRnFmOWjDEiqWQ/dq06uiG
	 ZFbBwa38RTkLgn1NHsw+7fMkMrTDJvwxQQ5EYH6TP+CC2l23iYNsxfpvzzSXqbeh6Bvi8
	 0iT2BvK0lwPJN83zrn2whUMgFHSNoMTrZqqPJjIQ0UXiW/cPULo8c0bkHYWEAx7Nq+H+8
	 Eb/r/Bvj7lseJhKlTQARp13HB1JXbms5UbqUYNGLWZP80hLqPQYH7g0Z0Fhu+iPI17gLA
	 fvBKbjMT+HLNREfT87updZTQxSNn1DplV6jktG95eFaKvZlXQ5Qi9xEQlAL4lpLdI8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EpW+qroi;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE6606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0DE6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EpW+qroi
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso4496268a12.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793018409; x=1793623209; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T7S8diiA/DmsuYNjXa9n2P00Y/X47ue8rqEhzCok4QI=;
        b=EpW+qroio0OcYaBZUVtKpYIdN5Jvw6QVlDKAhqJZ8fYYL/ateZgQvFCRcOeuVG77NM
         2OYO258o2oJiL09RGiD4DSbDckVXyA2jj1b42Y+2jcWvI8u4Sj1eSoLr3dQG+fKf1FDm
         AUdzrSx4x79mcuDx2aMrWu+omcp9A8Ddv7nr4BzC++ZMbHKj8J91ph65SWht8SE0wWNB
         /aMs/2xKer5nXfNSznmYKYvD0nVdp0cT0Mlk/4q8rEIYHue2z6dQFsPsCSnst7h3Skxj
         Q0h3gO5jxWtnb0wyxg3Am3vKsnH78lX1lqntV4wAY/Yv27P0ByUmOfLFhOzeHhJKXmWn
         +24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793018409; x=1793623209;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T7S8diiA/DmsuYNjXa9n2P00Y/X47ue8rqEhzCok4QI=;
        b=1kq3zA42Kll8yzxC3Th6Tb0lgV1dsURb9yEF63Q/aicxO+HGQWrIm1n9I9pfV3PAuC
         TO8YctwcQVMx5zENGpfQ5fUG/kg37V+k+TM1+S8EfJwHm54rB0ITIoPFtX8Xw2tEK3bI
         7VSxazaQD8OlbRJZLDLo0alnYGocmKrAEULHURJGA6GZyZzDSWXqX2J2wjpWOJTCCRO8
         5IkPU4jpKa2M8oDJBykhtKlYVcsUYmL0q0u2evesfSjdvzXWxd6Aq7xcFy+Jy8zE4Su/
         uiBDygAdWdcTk5lvibFkkEXUtVIH4djCtB9+GH3c/UI9Q1wH3zzZDpBjcPeF3Lyypss0
         1kwg==
X-Gm-Message-State: AFq9FYKQPYdsQD5OOER7KyHIj5Dsr0Y+o5T7Ser0QZe5sk9JVn7vfypp
	ioyVQtKAIprXblAd2B27U5HmF5fSRGl/yOrIBHrCmvtqhFUWAP6Sj2QkzlF/GpcjOcw=
X-Gm-Gg: AYBFou3cMl0psYBdjLMfcVZP1GWnZflnfmVvVeOGDAMRFe7Ty6j3ZLJkIvNEdPv4Ql+
	NBbodVpeYR6EQ9M1BEfdM/BPUYugO3sKskm0fQWlzIoJWEmx5rsXKl5RyOFEIh15vFQ+bDCP3nA
	IvyLlKA4vwwDTG3EvNHz882Cq+s7Qv2jqdcSvJL6tSk9GzqeaLwymI3gn0wCwkL+d/RFNAVL5nE
	7VP2XmGCGcuEcsLu1OaKpZm3jKk9oVS8MP+9PZFacu2znG/HpD0Wjx6/uePTUhtNSlnuwsLRjiz
	pnKm3OTeRjDiA+MZPpVLEq7ZtAQ6HEAiSmzdxCY4l0WC2dESCeELj8PPbg6PksakRR97101nm2Y
	j6/ZNMqdQayeYWpwE7Wqj7q+WaSXPf2J03+zldVx6tCTjQsEkxO/YUBWB7gDtlWAa6nvr4b6OrB
	SuIIyoK33A9Qio8Mg5GWNkzj2CiHYXIAMkQM6fV5XFifi/cHex4nCvn9K/Dj4qJN84CHnVLx6rI
	TH59cjjSghVd+gLGC79iJhT3PyE/SZDjFa6Q1AhIB2sqJsPgDD2geNO1PDz
X-Received: by 2002:a05:6402:1259:b0:6b4:201f:17d6 with SMTP id 4fb4d7f45d1cf-6b442ff2b29mr5637731a12.16.1793018408112;
        Mon, 26 Oct 2026 05:40:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.191.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b44584ad9fsm3742124a12.0.2026.10.26.05.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:40:07 -0700 (PDT)
Message-Id: <8b526e2bd7a8f4f3ce030f3f0b0b50b3fab02f14.1793018405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v5.git.1793018405.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v5.git.1793018405.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 12:40:00 +0000
Subject: [PATCH v5 1/6] doc: add new gitmergeconflicts man page
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
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
  which can result in conflicts.
- Sometimes we use "ours" and "theirs" to refer to the two sides of
  the merge conflicts and sometimes we use HEAD and MERGE_HEAD. It should
  be consistent. Also the terms "ours" and "theirs" are not explained.
  Similarly, it says "The part before the `=======` is typically your
  side...", but doesn't explain what "typically" means.
- It introduces the merge format using an analogy to RCS, which very few
  Git users have ever used.
- In "The only clean-ups you need are to reset the index file to the
  `HEAD` commit to reverse 2. and to clean up working tree changes made
  by 2. and 3.", it's not clear to users what "2" and "3" are supposed
  to mean.
- It uses a cultural reference ("Conflict resolution is hard; let's go
  shopping.") which is confusing or unfamiliar to some people. I think it
  would be clearer for users to use a code example instead.
- It doesn't explain the difference between diff3 and zdiff3.
- It sometimes uses the term "area" and sometimes uses the term "hunk".

Also document the unified `--abort`, `--continue` workflow in one
place, since it's a really nice example of a place Git has a consistent
interface between similar commands.

Only discuss merge, rebase, cherry-pick, and revert for now even though
there are other ways that merge conflicts can happen to avoid getting
into the difference between applying a patch and doing a 3-way merge.

Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Julia Evans <julia@jvns.ca>
---
 .gitattributes                       |   1 +
 Documentation/Makefile               |   1 +
 Documentation/gitmergeconflicts.adoc | 339 +++++++++++++++++++++++++++
 Documentation/meson.build            |   1 +
 command-list.txt                     |   1 +
 5 files changed, 343 insertions(+)
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
index 0000000000..99052ab506
--- /dev/null
+++ b/Documentation/gitmergeconflicts.adoc
@@ -0,0 +1,339 @@
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
+* Or (if you're in a multi-step operation like a rebase) skip the problematic
+  commit with the appropriate `--skip` command.
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
+Even if Git successfully merges both sides with no conflicts, it's
+possible to end up with code that doesn't work. For example, this can
+happen if one side renames a function, and the other side adds a call to
+the old function. This is called a "semantic merge conflict".
+
+[[markers]]
+MERGE CONFLICT MARKERS
+----------------------
+
+When there's a merge conflict, Git will update the conflicted file
+to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
+For example, here's a merge conflict where both sides edited a list of
+fruits in different ways -- one side has "cherry" and the other side
+has "banana":
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
+The lines from one side of the merge conflict is between `<<<<<<<` and
+`=======`, and the lines from the other side is between `=======` and
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
+1. Run `git status` to get a list of files with merge conflicts.
+2. For each one, find the conflict markers
+   (the `<<<<<<<`, `=======`, `>>>>>>>`) and edit the file to
+   fix the conflict.
+3. Run `git add FILENAME` for each file to mark the conflict as resolved.
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
+* `git log --merge --patch <filename>`  will list all commits which
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
+----
+FRUITS = [
+    "apple",
+<<<<<<< HEAD
+    "cherry",
+    "mango",
+||||||| 1c22e48
+    "banana",
+    "cherry",
+    "mangoooo",
+=======
+    "banana",
+    "mango",
+>>>>>>> add-fruit
+    "orange",
+]
+----
+
+With this view, you can see that both sides fixed a spelling
+mistake in "mango", and each removed one fruit from the list.
+This makes it more clear how to resolve the merge conflict: since one
+side removed `banana` and one side removed `cherry`, it would probably
+make sense to remove both from the list, like this:
+
+----
+FRUITS = [
+    "apple",
+    "mango",
+    "orange",
+]
+----
+
+[NOTE]
+`zdiff3` is an alternative to `diff3` that makes the merge conflict
+shorter by making it more ambiguous. See linkgit:git-config[1] for more.
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

