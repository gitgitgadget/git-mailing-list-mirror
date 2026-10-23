Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764299;
	b=yRhhPa2ynLBBZ2sGgql1QuaJhz2Se+TGSJ+HkvvkVSutSQp7BvqiUaUXm2LMIYpqRogD
	 dZ9hJx552yfebf1x5L/Yk/U6oeyMAixfIqHzxmSQy6Fhb6hv8+3QvDC+xQr1Wshpq17Wm
	 DjL8IM7pAzeLcBP4Q6HFHpDODmfVDd9LaQaI1c6piamxgDdcZgEdGXryTgbUffu3aUqyV
	 45qpKwsNn7LXRgZw3IP8+/ICEZMxc/CBsjux72q8ZpinvWIi/v5fO2d8wxF+E2HjpFhBP
	 cvdEIgDEt51oFYG9O2Mdrn3SnQB9EYctrgk4pqpv2pFgOD6P/llW2vOqYGwCFFtLnWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=/YLONk2Z52R3GkkDxbLb3rEWh8/jenWSixEXuPR22s4=;
	b=oqFReEWDfG8k/bqoAzfmrlNg49higwBWMuhJKYKEJtp39WvfHmtep4k2S+HDCz5Hk26Q
	 xqp11TEAhaWanzIcD3riMlIzvn28g8kbGuWo9lpUu7s6no7uhA7FqJS5curBtBJrPlbWo
	 cuGT76oG50CPJ491gvi2am1cXwRk82CPxjSewkkKhhn+K/q8bYKNWdwvIHu3ln7LlIk1i
	 y5Y1eJSARNOO/isVsEK3so3k72gHQHAM91tTDF/we1y/qgat+e6bvHcnwk26FFvyo46n3
	 octMM85TD3K9pUv4KAHvBOmlIOwFkM7o20kEewRxyxaDUHTkj8OVxHMmA7W0vgn0Vrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LWrFbDmd;
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1218606A325
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1218606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LWrFbDmd
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-677bc4704cbso922350d50.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792764297; x=1793369097; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/YLONk2Z52R3GkkDxbLb3rEWh8/jenWSixEXuPR22s4=;
        b=LWrFbDmdRNYBmApK3LScBxAvS1JOV8h15FfRnmr9ItSC4zofAKG7un4uZ2UdBQ4h88
         NsbC3LVCeWx2HWq15EvPgtXKYK0L8qRi0jQzUv/skBugmfJURtCPxIY0xIoqKrOn5HQL
         AVP0Tc4xjIEV7zDE+TDYwuhM1dO7jrWLZeKgZsy0L9UXCDOdDbRGQIRlAEKAX9UGk02M
         05/41e/PeEO2qB/ehfw2cCUidCohg+TbCrJPjRoVSym9UPqqFlkyqdUeUdm2Y5aE+CVk
         nbDef9CXpOahy6knSKgY7BZQlsKPMuAXDXW5vydBnTtsw0SbEPdzlj7w+3O2IQbIZops
         2Luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764297; x=1793369097;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/YLONk2Z52R3GkkDxbLb3rEWh8/jenWSixEXuPR22s4=;
        b=torCyIgb63IRJ600IsbDE2Rx2o70Uvrc/xXxDY2+su5BkLttmsXrVck3yiUrxeqWDY
         sW4CmWlQt2NgzsMYuaHja1N+wlTk6WVKkqzBsrPB6pfaX4lJCpr8Tz1LeGG5CFk5tbOD
         PR1L1pmEpMKNKy5SfqCrOKkNgR0hJ2QBB27OCMalit/3wnKvmcdBqXHSXy0ZJzuOJy1H
         +NCxbMcACUtTJqSSZY3d2MksC4B2yiDcoIF/8w5o83SR9cQXuoz+Mu4021eOLLV8fYS1
         lWEWTORfnFmNs4DRxzlz8hdEiRFTy/sEwWPEYZgaIhY/lRBsjU7ClbS9ZwWn02yLZ/XG
         NFQQ==
X-Gm-Message-State: AFq9FYLhTawy0XgrfgNTiyQDXavbhsIdR49hVxZtp1+aNkxeoa7Xdf0v
	kssIhPMtN4pIB4K4g6e0qJ17Vno1s/AeFBjaxxXT094ribdO+HPLAF91l9zlAWkirlg=
X-Gm-Gg: AYBFou0DS/E7qbdX51RqD9nhn8AM/E/yczI3OlKtmoz8pvLPZJ/otmqNDi5Va69JhNm
	FgRcHIDiLVx7BXO5sv/R2mVAuT4BrFrjFZ4ueaTNXWlaRmuBXZCj6dCNj5QgZ9+TWpOtbKaItVk
	gv5T0kE5Eu2Jrt3O7S1PM+kBBM2fxpaA28lILDFqdMvHXxLUm8Oxv6bu+SIeeYNfLI66aIllI8+
	124i2b2IVw8n7k35hXcN6GrVXgcJtNwufsyVdNNn5LK+vGWK4LX0MV2tSDChmz7NwtwJeVcQPjt
	rEoLZuhgtQFX/9RybGayXQHufYT7U96SScQnxOn3nk/stpCyQW1ANc3ogiPj48YqVhl+nVXkajT
	49b5yiicuiclDktQL3iKakqqrnwVRk0mL/UGPM31e2RcDIfP/3jCFavZsijSzlNacliUfVZfNpi
	jmz4Y/Ge5Bqpt7U6QOKLpiPsjHFi1fNey+a+0bqJM514Q06REhpMo2Xb33RjO7owodc3jmQudwP
	xKcvlG41O73dnifv7MoYjlg79+elG3BLpDj3O8dbn4WuBb+y/2XIoavmg==
X-Received: by 2002:a05:690e:4887:10b0:679:bad8:7dc2 with SMTP id 956f58d0204a3-67a35bc5a53mr754702d50.45.1792764297205;
        Fri, 23 Oct 2026 07:04:57 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.174.58])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c44f597dbsm2762526d6.0.2026.10.23.07.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:04:55 -0700 (PDT)
Message-Id: <486a77dbd78e111f66f8878594a30974c2abe53f.1792764293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 14:04:48 +0000
Subject: [PATCH v4 1/6] doc: add new gitmergeconflicts man page
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

Things to potentially improve in future docs revisions:

- The explanation of zdiff3 is unsatisfying. It would be good if we
  could have a clear example of a case where zdiff3 is helpful and a
  case where it's harmful, and if we could give a better sense for
  the reasons why users are actually choosing zdiff3 over diff3
  (or the reverse) in real life.

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
index 0000000000..bcf7d66c62
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
+	"banana",
+	"cherry",
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
+mistake in "mango", and each removed one fruit to the list.
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

