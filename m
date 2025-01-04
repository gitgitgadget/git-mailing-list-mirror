Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0F1B6541
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735996607; cv=none; b=FswUs/9HZa8mbT3QgJ9ueBenoyTPsc0lYimA0r3wxRf1Xbzb4lQUWurruHYe162qBw6EaqABwkdtq72BsC0Ap9hX4GJxS09jBnKGMHiv+yH4vF1vpcOxuIPHl6RX3Gq14kwXoOVq47wMq1s2vCb82Y8rKgYU+B1igqQ4YC6IHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735996607; c=relaxed/simple;
	bh=tKg1zWXysSdouCopuivYCuX7c0HV1IzcgCFVUApFgjc=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=jMi+FZ4MF0ADVttpOqEnH3jO4yLkodkCm1U32Y83gksMpUfH8Qx5rKSUmeeYp+MswzC30Yh2C5sYPD6W1wxFiwKYc9uSVUORuxS2R6NPPWGYkNWewxPIliFG2rhRSWCOkiHpDSh6vgyNWyLLRwsofhSxbvLbwUpFaGg2pNaL3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM5g6Bt8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM5g6Bt8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361815b96cso86088035e9.1
        for <git@vger.kernel.org>; Sat, 04 Jan 2025 05:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735996603; x=1736601403; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9tJHJjO8qPM76QH3TO8eSVzJCoYGIIXacDGCIKdnOwM=;
        b=MM5g6Bt8Hnw7/2E0PV0tL2ghdX0wxnhFS7y+fzk/trD8wKHBhbguI9CPnUGmZQBFzG
         MJPVCe7a2WgAB/03fyiu+4lGwmfsR5IlEgttM5Eble1wCHnB8g4Ap3f1ewBULYG0zK5F
         xxmJUHWxJOxXsKDUX0SyywZ+qAGDASmQCJVooOVK1jgi4TK11BCpPF/tiEGP6OHM20ID
         ctoF3bZtzsjVWHxv06VGdR/5XxLUg29bKEinPFj2C68xpUhnykR8Zoyu8wnAbMW8flsr
         AufpDnGhqvgijKXBFmqAAYwZRYwpxI9BWy7R8snFQSK1CL7IZx3P1Wrs1E8+i4rfPve5
         xsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735996603; x=1736601403;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tJHJjO8qPM76QH3TO8eSVzJCoYGIIXacDGCIKdnOwM=;
        b=AeDa1tTkNCciFA3BsOABJVlN72RksLdh2As5z7G4krSRa3YxA6mlO6UCM/B1rluDDE
         4m8ZksxV3jCrvyfqrxFpmX9QZUlK6Qz4FsQjNeZ/T05QLeadmLCatzFIBq0Tq/1jLdjO
         WFgKK1EBYYa73a34/LHsbdE/9LCUPb/gTrFvOiBoLHDANHnlnfcmyP82u+e5nhJpwpG5
         kOTHDvUUZYr0bCQJPI0QN+KzJ/lmfm4KifonssZd2fKc+hpUWukZCk/bC6MwqxNudzUF
         ZVkzgHyIOqig2uvAkZ4GoAWHeZobn9eIWIg1ZTC5JyLEtpcpUqHRhz1R4yIKk7xjOu5d
         Vfgw==
X-Gm-Message-State: AOJu0Yy+ZliWZaRLeCKSHlfSvcujEqWOAnPtCdjhP4XiLtiHwa4LE33F
	zJrVhEknhB/wo8yqk26E1BugGiz9Yft14eOgGI4Ii0lUpfpcaVMcxLoUeg==
X-Gm-Gg: ASbGncvqQtQVYVvokEyNJT/9cEn/mFhv8VgDakhA7MFdwm0FVTSUqR1qSz1tGJSoGnZ
	iZL0FrksBy6wuQAn+icipRmzXY54dX9VSFx2L3FyVROz60eWf1ggcJzxU8lDYZM5zo6zBGBQvEi
	PFjzD/k9XaJwgTUjSB2ZePDvfWEJO4I3yYIfZt1uoc1zzdIQg91n66Oax1qecpmWYhKFcOosAmp
	CprDVqlFQfZeGIl3Thjo5XmQVbIRsJ0heKq5ZH/ntpXM5qjM25jWjQzGA==
X-Google-Smtp-Source: AGHT+IF0eUlyZpXcC9haEaA555TlnuobzKQRPYuI2cZ1HVyjS4vGMPQMqc3qdYOAuFgUqPHKza4boA==
X-Received: by 2002:a05:600c:1987:b0:434:fbcd:1382 with SMTP id 5b1f17b1804b1-43668643a39mr424555405e9.11.1735996602515;
        Sat, 04 Jan 2025 05:16:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b0532a6sm529399915e9.1.2025.01.04.05.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 05:16:41 -0800 (PST)
Message-Id: <pull.1847.git.1735996601092.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Jan 2025 13:16:40 +0000
Subject: [PATCH] doc: git-restore: migrate to new style format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

The git-restore manpage was converted to the new documentation
format:

- switching the synopsis to a 'synopsis' block which will
  automatically format placeholders in italics and keywords in
  monospace
- use _<placeholder>_ instead of <placeholder> in the description
- use `backticks for keywords and more complex option
descriptions`. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
    doc: git-restore: migrate to new style format

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1847%2Fjnavila%2Fdoc-git-restore-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1847/jnavila/doc-git-restore-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1847

 Documentation/git-restore.txt | 109 +++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 55 deletions(-)

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 975825b44aa..541a39b5d28 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -7,10 +7,10 @@ git-restore - Restore working tree files
 
 SYNOPSIS
 --------
-[verse]
-'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] [--] <pathspec>...
-'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] --pathspec-from-file=<file> [--pathspec-file-nul]
-'git restore' (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [--] [<pathspec>...]
+[synopsis]
+git restore [<options>] [--source=<tree>] [--staged] [--worktree] [--] <pathspec>...
+git restore [<options>] [--source=<tree>] [--staged] [--worktree] --pathspec-from-file=<file> [--pathspec-file-nul]
+git restore (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -32,8 +32,8 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 OPTIONS
 -------
--s <tree>::
---source=<tree>::
+`-s <tree>`::
+`--source=<tree>`::
 	Restore the working tree files with the content from the given
 	tree. It is common to specify the source tree by naming a
 	commit, branch or tag associated with it.
@@ -41,79 +41,79 @@ OPTIONS
 If not specified, the contents are restored from `HEAD` if `--staged` is
 given, otherwise from the index.
 +
-As a special case, you may use `"A...B"` as a shortcut for the
-merge base of `A` and `B` if there is exactly one merge base. You can
-leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
+As a special case, you may use `"<refA>...<refB>"` as a shortcut for the
+merge base of _<refA>_ and _<refB>_ if there is exactly one merge base. You can
+leave out at most one of _<refA>__ and _<refB>_, in which case it defaults to `HEAD`.
 
--p::
---patch::
+`-p`::
+`--patch`::
 	Interactively select hunks in the difference between the
-	restore source and the restore location. See the ``Interactive
-	Mode'' section of linkgit:git-add[1] to learn how to operate
+	restore source and the restore location. See the "Interactive
+	Mode" section of linkgit:git-add[1] to learn how to operate
 	the `--patch` mode.
 +
 Note that `--patch` can accept no pathspec and will prompt to restore
 all modified paths.
 
--W::
---worktree::
--S::
---staged::
+`-W`::
+`--worktree`::
+`-S`::
+`--staged`::
 	Specify the restore location. If neither option is specified,
 	by default the working tree is restored. Specifying `--staged`
 	will only restore the index. Specifying both restores both.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Quiet, suppress feedback messages. Implies `--no-progress`.
 
---progress::
---no-progress::
+`--progress`::
+`--no-progress`::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag enables progress reporting even if not
 	attached to a terminal, regardless of `--quiet`.
 
---ours::
---theirs::
+`--ours`::
+`--theirs`::
 	When restoring files in the working tree from the index, use
-	stage #2 ('ours') or #3 ('theirs') for unmerged paths.
+	stage #2 (`ours`) or #3 (`theirs`) for unmerged paths.
 	This option cannot be used when checking out paths from a
 	tree-ish (i.e. with the `--source` option).
 +
-Note that during `git rebase` and `git pull --rebase`, 'ours' and
-'theirs' may appear swapped. See the explanation of the same options
+Note that during `git rebase` and `git pull --rebase`, `ours` and
+`theirs` may appear swapped. See the explanation of the same options
 in linkgit:git-checkout[1] for details.
 
--m::
---merge::
+`-m`::
+`--merge`::
 	When restoring files on the working tree from the index,
 	recreate the conflicted merge in the unmerged paths.
 	This option cannot be used when checking out paths from a
 	tree-ish (i.e. with the `--source` option).
 
---conflict=<style>::
+`--conflict=<style>`::
 	The same as `--merge` option above, but changes the way the
 	conflicting hunks are presented, overriding the
 	`merge.conflictStyle` configuration variable.  Possible values
-	are "merge" (default), "diff3", and "zdiff3".
+	are `merge` (default), `diff3`, and `zdiff3`.
 
---ignore-unmerged::
+`--ignore-unmerged`::
 	When restoring files on the working tree from the index, do
 	not abort the operation if there are unmerged entries and
 	neither `--ours`, `--theirs`, `--merge` or `--conflict` is
 	specified. Unmerged paths on the working tree are left alone.
 
---ignore-skip-worktree-bits::
+`--ignore-skip-worktree-bits`::
 	In sparse checkout mode, the default is to only update entries
-	matched by `<pathspec>` and sparse patterns in
-	$GIT_DIR/info/sparse-checkout. This option ignores the sparse
+	matched by _<pathspec>_ and sparse patterns in
+	`$GIT_DIR/info/sparse-checkout`. This option ignores the sparse
 	patterns and unconditionally restores any files in
-	`<pathspec>`.
+	_<pathspec>_.
 
---recurse-submodules::
---no-recurse-submodules::
-	If `<pathspec>` names an active submodule and the restore location
+`--recurse-submodules`::
+`--no-recurse-submodules`::
+	If _<pathspec>_ names an active submodule and the restore location
 	includes the working tree, the submodule will only be updated if
 	this option is given, in which case its working tree will be
 	restored to the commit recorded in the superproject, and any local
@@ -122,30 +122,29 @@ in linkgit:git-checkout[1] for details.
 	not be updated. Just like linkgit:git-checkout[1], this will detach
 	`HEAD` of the submodule.
 
---overlay::
---no-overlay::
-	In overlay mode, the command never removes files when
-	restoring. In no-overlay mode, tracked files that do not
-	appear in the `--source` tree are removed, to make them match
-	`<tree>` exactly. The default is no-overlay mode.
-
---pathspec-from-file=<file>::
-	Pathspec is passed in `<file>` instead of commandline args. If
-	`<file>` is exactly `-` then standard input is used. Pathspec
-	elements are separated by LF or CR/LF. Pathspec elements can be
+`--overlay`::
+`--no-overlay`::
+	In overlay mode, never remove files when restoring. In no-overlay mode,
+	remove tracked files that do not appear in the `--source` tree, to make
+	them match _<tree>_ exactly. The default is no-overlay mode.
+
+`--pathspec-from-file=<file>`::
+	Pathspec is passed in _<file>_ instead of commandline args. If
+	_<file>_ is exactly `-` then standard input is used. Pathspec
+	elements are separated by _LF_ or _CR_/_LF_. Pathspec elements can be
 	quoted as explained for the configuration variable `core.quotePath`
 	(see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 	global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	Only meaningful with `--pathspec-from-file`. Pathspec elements are
-	separated with NUL character and all other characters are taken
+	separated with _NUL_ character and all other characters are taken
 	literally (including newlines and quotes).
 
-\--::
+`--`::
 	Do not interpret any more arguments as options.
 
-<pathspec>...::
+`<pathspec>...`::
 	Limits the paths affected by the operation.
 +
 For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
@@ -154,7 +153,7 @@ EXAMPLES
 --------
 
 The following sequence switches to the `master` branch, reverts the
-`Makefile` to two revisions back, deletes hello.c by mistake, and gets
+`Makefile` to two revisions back, deletes `hello.c` by mistake, and gets
 it back from the index.
 
 ------------
@@ -165,7 +164,7 @@ $ git restore hello.c                     <2>
 ------------
 
 <1> take a file out of another commit
-<2> restore hello.c from the index
+<2> restore `hello.c` from the index
 
 If you want to restore _all_ C source files to match the version in
 the index, you can say

base-commit: 1b4e9a5f8b5f048972c21fe8acafe0404096f694
-- 
gitgitgadget
