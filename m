Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427996;
	b=JhnuHr1C/EldS8Pxzg9H5qMD2oB261a/vmOVZbWi4u1wr/f2Zn1xj0mlUJ1llHhx2O41
	 YnVsJzQAbCcYgFT6X8i1nI3PHiFo76eIBxld6KB7cA/ZwIY1/wpRb0gFiimd67JB3wqey
	 +75n/qkC0++3nlp6kr0DWwg5A9Tsxy/hOPTaqJ0xccC9kBUPXuX3IgYSaY+ytRFD9puz7
	 1SBq7vsiTkHDO5wKf7KWRsw3jYkJjpItg6X7HqNJVUcw41lqD5lEahCu6CERRIE8iYnKO
	 rhGUdSQv93bvlSr6BsU3TVk7HSAnKBS82Eio+kJ2QaedPah2Ngp+fGxhxPvLKOBqXyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=xtyG/kk/QtCEmkM7tSVAqXNUtYV5W5Tao7LYvp6gi/8=;
	b=YcyIo4P1lrDWvcHmdaiY6u+qN+Vl0yy4yEW9oZiauHBLMgTdZY5jm9xtzTtEhQu0AZ/e
	 6NTE3gRKunndV7sVQAFq+ZTNXg39eCQjDcK7Hdrrjn90wRmW5tdbulcttNpyELZLswUco
	 89+LLf143cnQn5FfuWguei3E9MSPU+ChOJjuFEZYBEHnAAsvb+dknjroejPjLaDBUt+ic
	 n1efPYfeC9A2FCic6PG5MVHRxmkyCIwjPvhc3c/k8FlN1AdpzoxogJ275JxW/2aC/c6Lc
	 S5EczmYnt8CrirCm3bKqh9cCFar+XIs7zYfORMklYc/AXFVJVCkmxaxs3jD30TyK/HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VChidt2G;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3902606A324
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 20:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3902606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VChidt2G
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91ecdaf14beso33988456d6.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794427995; x=1795032795; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xtyG/kk/QtCEmkM7tSVAqXNUtYV5W5Tao7LYvp6gi/8=;
        b=VChidt2G/QNb/jnnD1jUxBBoSn7ire4P8QZv+PpZO2D8t7udRwdUPrpQiHCFC1YLxK
         crx67tNlbRuSqTuvkFoQB5Ud/1TgZzX9rPlL1KWlGq+Vs+xr5xIv4gfT0fqP/zIHHdww
         2z+nO9EXSMM9FEeh0rqrmvMJGjHQf3BfRK1n4rMeA7hoS5L1Qr7W7nK+XynrhVNCDRKX
         mKi2YrvT45YFYikae4AU4aqydEvobwybFA0WomrhULnHhPZl9c5ioiq7HDQ7xqsGHSm9
         TyqoNeSdmFF8f+6idEXZ1KZrny8vJliTslXCdlNT4GjVFeJCelkKMhlFX8fZU2/72OfQ
         84+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794427995; x=1795032795;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xtyG/kk/QtCEmkM7tSVAqXNUtYV5W5Tao7LYvp6gi/8=;
        b=ktI1Xacf+/1UJQi5lSp/xthqOX7yxR6Zw0ju2hx/CzcmcqoLHb13085qd8I6hbEbXI
         1LWRl5ZPBo3IM0F5AgX+4xmwsFkDFf4nqncvjyd6rbt6CfNU6T+61JLyn65s0BIHyPeU
         6Upv/k+PtBG3F1lmCoGuwsb0swKt526C1tofyGFlbb01GCr1aEIfVF1a+0+BIJkHzRHA
         9PliTCO0TI6G3Oyr3KaevZ2QRFJPZS4Djk+JtL24n8jYpJdcGa5IFPz9t97T7sCvSB7J
         MU8Fyx/+q5tcJvJGQHMZ0gr083Gts0ZLEjyrYcWfqsDtpA2xZ3rrso4xjercDbHRaFTI
         635Q==
X-Gm-Message-State: APuU4Z/JybXnU6sPyVm4sHDXRUKPRGEuxuFrwLAIyziAdx54ChD9W5if
	5d/cWjnx886BIsBzoK+21rawz0erV//FV4vWbY9Wy/XnIme1bZoNS546IfjU9ONQ
X-Gm-Gg: AYBFou349tC8qEVOD1Li6cE1O/JIDdlu71QrsGrkOGP7YjdbFRvsI07VYGdONGz3aXJ
	5ueMAjVEn2FiEuC/q/+v5yr79nBQ6Bixv3a8BTvs0UM5V+bi5lYz1gh4J5Zqc10yJ0QtlAwslNW
	P0C0W0PZgcxBDlVMApWiFZ9sWZyxFMI3N7/PV+x/XNO5TjqeVgwUYZpx5vIrmEdhCyFQ4OdPUsB
	iRv5sh9tUN7PRMlr1IoIbrTQIUyeJ5VMlge8rMCaPdrDnd8V9xGJWEyOF8LYNEz6ASh7+AbgqFT
	VSDB9QjgsjyqfSMxrwJrlkodrwlouSBZUlBPDFGw7ShhQHWgp/xK6UCgdz+5NNGLkJwaAnU1aW7
	VXnZC1qHCssxnSfL8Sq3ngqd3fOoZbZ9/PvfLdxNDlrreKSgfZuswEsluVOOQXY+RVGxC1CIrpU
	Hs6+fEffcXfAcU0aIlA2/vAATH90VBWMkPsRhYzEQDaXagME2aW5Uf3ZeVsGkYvhOp2ZsnhWJc1
	2ziKIXGnS0ryKsqwPq0YB64s52SvnFQjuR6jZp0keU28LbKhSjOPkKe/2jUOuEA2OiIyNqcHRHq
	lExIwrpVU7mTBCCsMnUZ2QjFPL5XOuhD
X-Received: by 2002:a05:6214:dab:b0:91b:9061:b7f7 with SMTP id 6a1803df08f44-91f040696a7mr63830626d6.20.1794427994614;
        Wed, 11 Nov 2026 12:13:14 -0800 (PST)
Received: from [127.0.0.1] ([20.15.103.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef0318890sm53891876d6.4.2026.11.11.12.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:13:14 -0800 (PST)
Message-Id: <pull.2293.v3.git.1794427993457.gitgitgadget@gmail.com>
In-Reply-To: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 20:13:13 +0000
Subject: [PATCH v3] doc: git-diff: rewrite EXAMPLES section
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Jeff King <peff@peff.net>,
    Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

The top piece of feedback users always give about man pages is always
that they want better examples that are relevant to them.

The EXAMPLES section's structure has remained mostly unchanged since
2007, which was before we knew how people were going to use `git diff`.
Update it with ways of using `git diff` that are popular with Git
users, gathered by asking Mastodon users for their most commonly used
incantations. Keep the example that was added since 2007
(`git diff AUTO_MERGE`), rewording it to use the more familiar term
"merge conflict" instead of "textual conflict".

Add a note about the EXAMPLES section in the DESCRIPTION since otherwise
readers are unlikely to know it's there. `git diff` is a command where
it's more important than usual to have examples because the command has
so many different forms.

Some design choices:

- Mention both `git diff --staged` and `git diff --cached`, because
  "staged" is the term the Git user interface uses and several users
  said they find it easier to understand. Add an entry for --staged
  saying that it's a synonym. Like with `git switch`, and `git checkout`
  it's useful to leave the older version for folks who are used to using
  `git diff --cached` since we've seen that many people who are used to
  using a command don't see any value in changing how they use it.
- Use a definition list for the examples instead of the footnote style,
  so that the description and the example are right next to each other
  and it's easier to read.
- Use `--merge-base` instead of `...` since several users said they
  find .. vs ... confusing. It's much more obvious what --merge-base
  does.
- Link the options in the examples to make them faster to look up
- Use sub-subsection headings for the different parts to make
  them more visually distinct and easy to scan.

Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: git-diff: rewrite EXAMPLES section
    
    changes in v2:
    
     * Switch from tables to a definition list, to avoid wrapping but still
       staying relatively compact.
     * Mention git diff --cached alongside git diff --staged so folks can
       use whichever version they prefer, and update the commit message with
       some notes about that. It's an example of one of many situations in
       Git where what's best to recommend for new users and what's best for
       long-term users is not necessarily the same.
     * Put back AUTO_MERGE (thanks to Junio for pointing out that it was
       added much more recently than all the rest of the examples)
    
    changes in v3:
    
     * Remove the changes to --cached/--staged in the SYNOPSIS and
       DESCRIPTION.
     * Squash the formatting changes from Junio for the links.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2293%2Fjvns%2Fdiff-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2293/jvns/diff-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2293

Range-diff vs v2:

 1:  ec565ce334 ! 1:  899def065e doc: git-diff: rewrite EXAMPLES section
     @@ Documentation/diff-options.adoc: diff" algorithm internally.
       
       include::diff-algorithm-option.adoc[]
       
     -+[[stat]]
     - `--stat[=<width>[,<name-width>[,<count>]]]`::
     +-`--stat[=<width>[,<name-width>[,<count>]]]`::
     ++`--stat[=<width>[,<name-width>[,<count>]]]`[[stat]]::
       	Generate a diffstat. By default, as much space as necessary
       	will be used for the filename part, and the rest for the graph
     + 	part. Maximum width defaults to terminal width, or 80 columns
      @@ Documentation/diff-options.adoc: Without this option, pathnames with "unusual" characters are quoted as
       explained for the configuration variable `core.quotePath` (see
       linkgit:git-config[1]).
       
     -+[[name_only]]
     - `--name-only`::
     +-`--name-only`::
     ++`--name-only`[[name_only]]::
       	Show only the name of each changed file in the post-image tree.
       	The file names are often encoded in UTF-8.
       	For more information see the discussion about encoding in the linkgit:git-log[1]
       	manual page.
       
     -+[[name_status]]
     - `--name-status`::
     +-`--name-status`::
     ++`--name-status`[[name_status]]::
       	Show only the name(s) and status of each changed file. See the description
       	of the `--diff-filter` option on what the status letters mean.
     -@@ Documentation/diff-options.adoc: endif::git-diff[]
     - 	Ignore changes in amount of whitespace.  This ignores whitespace
     - 	at line end, and considers all other sequences of one or
     - 	more whitespace characters to be equivalent.
     -+[[ignore_all_space]]
     - `ignore-all-space`::
     - 	Ignore whitespace when comparing lines. This ignores differences
     - 	even if one line has whitespace where the other line has none.
     + 	Just like `--name-only` the file names are often encoded in UTF-8.
      @@ Documentation/diff-options.adoc: endif::git-diff[]
       	used to override configuration settings. It is the same as
       	`--color-moved-ws=no`.
       
     -+[[word_diff]]
     - `--word-diff[=<mode>]`::
     +-`--word-diff[=<mode>]`::
     ++`--word-diff[=<mode>]`[[word_diff]]::
       	By default, words are delimited by whitespace; see
       	`--word-diff-regex` below.  The _<mode>_ defaults to `plain`, and
     + 	must be one of:
     +@@ Documentation/diff-options.adoc: endif::git-format-patch[]
     + 	more whitespace characters to be equivalent.
     + 
     + `-w`::
     +-`--ignore-all-space`::
     ++`--ignore-all-space`[[ignore_all_space]]::
     + 	Ignore whitespace when comparing lines.  This ignores
     + 	differences even if one line has whitespace where the other
     + 	line has none.
      
       ## Documentation/git-diff.adoc ##
     -@@ Documentation/git-diff.adoc: SYNOPSIS
     - --------
     - [synopsis]
     - git diff [<options>] [<commit>] [--] [<path>...]
     --git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
     -+git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]
     - git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
     - git diff [<options>] <commit>...<commit> [--] [<path>...]
     - git diff [<options>] <blob> <blob>
      @@ Documentation/git-diff.adoc: between the index and a tree, changes between two trees, changes resulting
       from a merge, changes between two blob objects, or changes between two
       files on disk.
     @@ Documentation/git-diff.adoc: between the index and a tree, changes between two t
       `git diff [<options>] [--] [<path>...]`::
       
       	This form is to view the changes you made relative to
     -@@ Documentation/git-diff.adoc: files on disk.
     - 	difference. All such pathspecs must be relative as they
     - 	apply to both sides of the diff.
     - 
     --`git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]`::
     -+`git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]`::
     - 
     - 	This form is to view the changes you staged for the next
     - 	commit relative to the named _<commit>_.  Typically you
     -@@ Documentation/git-diff.adoc: files on disk.
     - 	do not give _<commit>_, it defaults to `HEAD`.
     - 	If `HEAD` does not exist (e.g. unborn branches) and
     - 	_<commit>_ is not given, it shows all staged changes.
     --	`--staged` is a synonym of `--cached`.
     -+	`--cached` is a synonym of `--staged`.
     - +
     - If `--merge-base` is given, instead of using _<commit>_, use the merge base
     - of _<commit>_ and `HEAD`.  `git diff --cached --merge-base A` is equivalent to
     --`git diff --cached $(git merge-base A HEAD)`.
     -+`git diff --staged $(git merge-base A HEAD)`.
     - 
     - `git diff [<options>] [--merge-base] <commit> [--] [<path>...]`::
     - 
      @@ Documentation/git-diff.adoc: section "3-Way Merge" for detailed information.
       
       include::diff-format.adoc[]


 Documentation/diff-options.adoc |  10 +--
 Documentation/git-diff.adoc     | 132 ++++++++++++++++----------------
 2 files changed, 70 insertions(+), 72 deletions(-)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index e605d28678..dbac3b8275 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -201,7 +201,7 @@ diff" algorithm internally.
 
 include::diff-algorithm-option.adoc[]
 
-`--stat[=<width>[,<name-width>[,<count>]]]`::
+`--stat[=<width>[,<name-width>[,<count>]]]`[[stat]]::
 	Generate a diffstat. By default, as much space as necessary
 	will be used for the filename part, and the rest for the graph
 	part. Maximum width defaults to terminal width, or 80 columns
@@ -318,13 +318,13 @@ Without this option, pathnames with "unusual" characters are quoted as
 explained for the configuration variable `core.quotePath` (see
 linkgit:git-config[1]).
 
-`--name-only`::
+`--name-only`[[name_only]]::
 	Show only the name of each changed file in the post-image tree.
 	The file names are often encoded in UTF-8.
 	For more information see the discussion about encoding in the linkgit:git-log[1]
 	manual page.
 
-`--name-status`::
+`--name-status`[[name_status]]::
 	Show only the name(s) and status of each changed file. See the description
 	of the `--diff-filter` option on what the status letters mean.
 	Just like `--name-only` the file names are often encoded in UTF-8.
@@ -432,7 +432,7 @@ endif::git-diff[]
 	used to override configuration settings. It is the same as
 	`--color-moved-ws=no`.
 
-`--word-diff[=<mode>]`::
+`--word-diff[=<mode>]`[[word_diff]]::
 	By default, words are delimited by whitespace; see
 	`--word-diff-regex` below.  The _<mode>_ defaults to `plain`, and
 	must be one of:
@@ -783,7 +783,7 @@ endif::git-format-patch[]
 	more whitespace characters to be equivalent.
 
 `-w`::
-`--ignore-all-space`::
+`--ignore-all-space`[[ignore_all_space]]::
 	Ignore whitespace when comparing lines.  This ignores
 	differences even if one line has whitespace where the other
 	line has none.
diff --git a/Documentation/git-diff.adoc b/Documentation/git-diff.adoc
index 272331afba..f7489a0da9 100644
--- a/Documentation/git-diff.adoc
+++ b/Documentation/git-diff.adoc
@@ -23,6 +23,9 @@ between the index and a tree, changes between two trees, changes resulting
 from a merge, changes between two blob objects, or changes between two
 files on disk.
 
+The <<EXAMPLES,EXAMPLES>> section has examples of the most common ways
+to diff.
+
 `git diff [<options>] [--] [<path>...]`::
 
 	This form is to view the changes you made relative to
@@ -160,78 +163,73 @@ section "3-Way Merge" for detailed information.
 
 include::diff-format.adoc[]
 
+[[EXAMPLES]]
 EXAMPLES
 --------
 
-Various ways to check your working tree::
-+
-------------
-$ git diff            <1>
-$ git diff --cached   <2>
-$ git diff HEAD       <3>
-$ git diff AUTO_MERGE <4>
-------------
-+
-<1> Changes in the working tree not yet staged for the next commit.
-<2> Changes between the index and your last commit; what you
-    would be committing if you run `git commit` without `-a` option.
-<3> Changes in the working tree since your last commit; what you
-    would be committing if you run `git commit -a`
-<4> Changes in the working tree you've made to resolve textual
-    conflicts so far.
-
-Comparing with arbitrary commits::
-+
-------------
-$ git diff test            <1>
-$ git diff HEAD -- ./test  <2>
-$ git diff HEAD^ HEAD      <3>
-------------
-+
-<1> Instead of using the tip of the current branch, compare with the
-    tip of "test" branch.
-<2> Instead of comparing with the tip of "test" branch, compare with
-    the tip of the current branch, but limit the comparison to the
-    file "test".
-<3> Compare the version before the last commit and the last commit.
-
-Comparing branches::
-+
-------------
-$ git diff topic master    <1>
-$ git diff topic..master   <2>
-$ git diff topic...master  <3>
-------------
-+
-<1> Changes between the tips of the topic and the master branches.
-<2> Same as above.
-<3> Changes that occurred on the master branch since when the topic
-    branch was started off it.
+Diff uncommitted changes
+~~~~~~~~~~~~~~~~~~~~~~~~
 
-Limiting the diff output::
-+
-------------
-$ git diff --diff-filter=MRC            <1>
-$ git diff --name-status                <2>
-$ git diff arch/i386 include/asm-i386   <3>
-------------
-+
-<1> Show only modification, rename, and copy, but not addition
-    or deletion.
-<2> Show only names and the nature of change, but not actual
-    diff output.
-<3> Limit diff output to named subtrees.
+Show unstaged changes::
+`git diff`
 
-Munging the diff output::
-+
-------------
-$ git diff --find-copies-harder -B -C  <1>
-$ git diff -R                          <2>
-------------
-+
-<1> Spend extra cycles to find renames, copies and complete
-    rewrites (very expensive).
-<2> Output diff in reverse.
+Show staged changes::
+`git diff --staged` or `git diff --cached`
+
+Show all changes since the latest commit::
+`git diff HEAD`
+
+Show changes made to resolve a merge conflict::
+`git diff AUTO_MERGE`
+
+Diff a specific file/directory
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+You can usually put a filename or directory at the end to restrict the
+diff to that file/directory. You don't always need to put a `--`, but it
+makes it unambiguous.
+
+Show how `file.txt` has changed since `main`::
+`git diff main -- file.txt`
+
+Show unstaged changes for `file.txt`::
+`git diff -- file.txt`
+
+Show unstaged changes in `dir/`::
+`git diff -- ./dir`
+
+Diff branches or commits
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Show changes on the `topic` branch since it branched off `main`::
+`git diff --merge-base main topic`
+
+Show changes between the `topic` branch and the `main` branch::
+`git diff main topic`
+
+Show changes between commit `ff11cc` and `HEAD`::
+`git diff ff11cc HEAD`
+
+Options to summarize the output
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Show how many lines in each file were changed::
+`git diff` <<stat,`--stat`>>
+
+Only show names of changed files::
+`git diff` <<name_only,`--name-only`>>
+
+Only show filenames and whether they were modified/deleted/added::
+`git diff` <<name_status,`--name-status`>>
+
+Options to display the diff in another way
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Ignore all whitespace changes::
+`git diff` <<ignore_all_space,`--ignore-all-space`>>
+
+Show which individual words changed instead of the whole line::
+`git diff` <<word_diff,`--word-diff`>>
 
 CONFIGURATION
 -------------

base-commit: 0ffa3e35c7c82ab8d0de226149fb03b3f7674d05
-- 
gitgitgadget
