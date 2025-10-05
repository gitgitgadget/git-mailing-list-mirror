Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D429AB03
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759698715; cv=none; b=tHzsi/3s9A9MmgRfpc1q2P+M9o2Xmt0tLQ/6YF9lYL+G1U+FeaHVkVrfh7l1Vx5P+nB7y2djUtdoxE5aiSn1dIGVRvLzr4vjzYx7KlLX59Op2h/Ryku+EF0E42Smn2VT5W5COhOf/2p6pB2Xz7m91giF81QPGbONT+H/6aMlwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759698715; c=relaxed/simple;
	bh=lYPVbeNoCSOQEM0lmpvJ2Pmo54R5Ff9rjHWfEWkGALk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=u5ZRVdDOoXBpuaoyfo7O4Q0kUfxWM/EeAktvZio6cz+X065eI8swTEU8k3GpmKlI8GmBz43G56L+t5SAyzSfAXVGC4eNCxKOtMqTQhKZZTKuGACVll0nexEpY+hKG4WFk4J3Pl0G9LNBTbtdtkpjaOb0++RD+BVezRbuznmAGm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hozJJoRE; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hozJJoRE"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-42e6df6fe53so16984485ab.2
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759698712; x=1760303512; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCFd0dG5bHvudKcPA6RYiu4KCBjnTRMpAbgD5OQBNOY=;
        b=hozJJoREGPpiubbLzjONgaGQd3S6SF1KYrX92BXE6qPoi5jVO8VR8WNIox5NsdBMt3
         xedLTDvzXZxA1AoCliIyhJkiEmm8nF3Sg0LjUXQEfVS7XfMJVfL83T8IiFeoAdQdDDlQ
         5/74WmHLS+Uf4BL2NfoNnkfzkIQQd/nSP9vHVuAkI5FGrzRbipPtNV/OEk3OlQ3tdFuD
         MiGCe+sB99ClwDlnYUItJpR6DamWoMHqE1KIMpc4VAiN+/Mxe3PHPJpS7I/3B3rROyUN
         fbbWaadUVanW6BAaMBgWuXaNLfUAhxmfDZzjbfMjR73eadBK31c0HTWoLccOJTtMoiHo
         59wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759698712; x=1760303512;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCFd0dG5bHvudKcPA6RYiu4KCBjnTRMpAbgD5OQBNOY=;
        b=QwgJGdE6oQIM2k9aGJE8cZma8E3ZNDWOzF3XICW+x5cd2MeLIjfhsEZM3UklqnsPjg
         3qde5EtNmNSoiIKdl0cQbibAx1Nn5yMYcZZSAsRDgq0fxxJML0l1gCvIpoEF+M9a4ZM7
         wrUNiydjJmHtGlLl+4t0tycD4y5m9hLXsL8HU84IH2KMYnQbUJvebLlv07msOEm2Ke1y
         nowGvM3flXqgC0X5QfFKJ9RjDawrjRlvG73AHwrgbkxCPiyDC5BEu/Z241qkgjYEWdl/
         q6jK8m8xOdDquxzp2RWhB/S4ydm/6AT83iZJbF5Ytrx48iI+5ydb8STCrXw7ht5cjhS8
         inIw==
X-Gm-Message-State: AOJu0YyWzUJ4TykWMShPt5ysrvwmIgpSpCR/xmSRLOs8fcIudkfGoh/z
	1+2Cqbt8QRVJPTe33B5iKX3SmgDRpw+XmUmonQmv0DP7F5WlOS/v5HQh5xihOaCE
X-Gm-Gg: ASbGnct0ZJ9z/JQuBXkSkp5yXp1ipvE1O/JXFkpyZA6EihNVu7X8HRG5lPSiMe41liu
	mJ92wyB3INZU5ailHwz3jjBsAVVb5a5b/GGnvecajWuidkxrtQgD5AE/r41D14H2MmfCdngxRjv
	oDaFbWYFSKezsbYuhfjCcE8Iy9eAX5mOMMSRe2zEK52bAQo4jbcEGp0s6YVioa11skiB1PKvN/b
	AdXppKGUonpOar1r8R98xDT9ILiKpYJHIhYSW6jzbmk6rruRrSYTlJf75+o0FShwH9dHX5H3vhx
	oE2KslB27NF7jrj+UZiitWCQecZDxki1bNPJIfx8NL4YkktNPuolUWiWxqEdHbVQXH/hJb3UkiA
	GWO5zIO0B8X5A15epyPRzTZA3fIx0dWAAC4zPin+0DtJbzM4gRL2rVm0nMSFNbrT6dS9B4Q==
X-Google-Smtp-Source: AGHT+IGvmUNl+ekieR7opyg3lTRAdyeMdFcjsYvmx8c+Nd7hIKAdVgOYvVeyBC61gwjUHdR0teoTzQ==
X-Received: by 2002:a05:6e02:1c0b:b0:427:6510:650a with SMTP id e9e14a558f8ab-42e7ad9cd38mr155469205ab.25.1759698711832;
        Sun, 05 Oct 2025 14:11:51 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f4e59sm45020365ab.1.2025.10.05.14.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 14:11:50 -0700 (PDT)
Message-Id: <c62b65c2cee52a2470847e4d4f3032e08df01066.1759698702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1969.git.1759698702.gitgitgadget@gmail.com>
References: <pull.1969.git.1759698702.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Oct 2025 21:11:42 +0000
Subject: [PATCH 3/3] doc: convert git worktree to synopsis style
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

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Also add the config section in the manual page and do not refer to the man
page in the description of settings when this description is already in the
man page.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/worktree.adoc |  14 +--
 Documentation/git-worktree.adoc    | 161 +++++++++++++++--------------
 2 files changed, 91 insertions(+), 84 deletions(-)

diff --git a/Documentation/config/worktree.adoc b/Documentation/config/worktree.adoc
index 9e3f84f748..a248076ea5 100644
--- a/Documentation/config/worktree.adoc
+++ b/Documentation/config/worktree.adoc
@@ -1,4 +1,4 @@
-worktree.guessRemote::
+`worktree.guessRemote`::
 	If no branch is specified and neither `-b` nor `-B` nor
 	`--detach` is used, then `git worktree add` defaults to
 	creating a new branch from HEAD.  If `worktree.guessRemote` is
@@ -6,14 +6,14 @@ worktree.guessRemote::
 	branch whose name uniquely matches the new branch name.  If
 	such a branch exists, it is checked out and set as "upstream"
 	for the new branch.  If no such match can be found, it falls
-	back to creating a new branch from the current HEAD.
+	back to creating a new branch from the current `HEAD`.
 
-worktree.useRelativePaths::
-	Link worktrees using relative paths (when "true") or absolute
-	paths (when "false"). This is particularly useful for setups
+`worktree.useRelativePaths`::
+	Link worktrees using relative paths (when "`true`") or absolute
+	paths (when "`false`"). This is particularly useful for setups
 	where the repository and worktrees may be moved between
-	different locations or environments. Defaults to "false".
+	different locations or environments. Defaults to "`false`".
 +
-Note that setting `worktree.useRelativePaths` to "true" implies enabling the
+Note that setting `worktree.useRelativePaths` to "`true`" implies enabling the
 `extensions.relativeWorktrees` config (see linkgit:git-config[1]),
 thus making it incompatible with older versions of Git.
diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index 389e669ac0..f272f79783 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -8,16 +8,16 @@ git-worktree - Manage multiple working trees
 
 SYNOPSIS
 --------
-[verse]
-'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]]
-		   [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
-'git worktree list' [-v | --porcelain [-z]]
-'git worktree lock' [--reason <string>] <worktree>
-'git worktree move' <worktree> <new-path>
-'git worktree prune' [-n] [-v] [--expire <expire>]
-'git worktree remove' [-f] <worktree>
-'git worktree repair' [<path>...]
-'git worktree unlock' <worktree>
+[synopsis]
+git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]
+		 [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
+git worktree list [-v | --porcelain [-z]]
+git worktree lock [--reason <string>] <worktree>
+git worktree move <worktree> <new-path>
+git worktree prune [-n] [-v] [--expire <expire>]
+git worktree remove [-f] <worktree>
+git worktree repair [<path>...]
+git worktree unlock <worktree>
 
 DESCRIPTION
 -----------
@@ -37,7 +37,7 @@ zero or more linked worktrees. When you are done with a linked worktree,
 remove it with `git worktree remove`.
 
 In its simplest form, `git worktree add <path>` automatically creates a
-new branch whose name is the final component of `<path>`, which is
+new branch whose name is the final component of _<path>_, which is
 convenient if you plan to work on a new topic. For instance, `git
 worktree add ../hotfix` creates new branch `hotfix` and checks it out at
 path `../hotfix`. To instead work on an existing branch in a new worktree,
@@ -63,16 +63,16 @@ locked.
 
 COMMANDS
 --------
-add <path> [<commit-ish>]::
+`add <path> [<commit-ish>]`::
 
-Create a worktree at `<path>` and checkout `<commit-ish>` into it. The new worktree
+Create a worktree at _<path>_ and checkout _<commit-ish>_ into it. The new worktree
 is linked to the current repository, sharing everything except per-worktree
-files such as `HEAD`, `index`, etc. As a convenience, `<commit-ish>` may
+files such as `HEAD`, `index`, etc. As a convenience, _<commit-ish>_ may
 be a bare "`-`", which is synonymous with `@{-1}`.
 +
-If `<commit-ish>` is a branch name (call it `<branch>`) and is not found,
+If _<commit-ish>_ is a branch name (call it _<branch>_) and is not found,
 and neither `-b` nor `-B` nor `--detach` are used, but there does
-exist a tracking branch in exactly one remote (call it `<remote>`)
+exist a tracking branch in exactly one remote (call it _<remote>_)
 with a matching name, treat as equivalent to:
 +
 ------------
@@ -81,32 +81,32 @@ $ git worktree add --track -b <branch> <path> <remote>/<branch>
 +
 If the branch exists in multiple remotes and one of them is named by
 the `checkout.defaultRemote` configuration variable, we'll use that
-one for the purposes of disambiguation, even if the `<branch>` isn't
+one for the purposes of disambiguation, even if the _<branch>_ isn't
 unique across all remotes. Set it to
 e.g. `checkout.defaultRemote=origin` to always checkout remote
-branches from there if `<branch>` is ambiguous but exists on the
+branches from there if _<branch>_ is ambiguous but exists on the
 `origin` remote. See also `checkout.defaultRemote` in
 linkgit:git-config[1].
 +
-If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
+If _<commit-ish>_ is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, the new worktree is associated with a branch (call
-it `<branch>`) named after `$(basename <path>)`.  If `<branch>` doesn't
+it _<branch>_) named after `$(basename <path>)`.  If _<branch>_ doesn't
 exist, a new branch based on `HEAD` is automatically created as if
-`-b <branch>` was given.  If `<branch>` does exist, it will be checked out
+`-b <branch>` was given.  If _<branch>_ does exist, it will be checked out
 in the new worktree, if it's not checked out anywhere else, otherwise the
 command will refuse to create the worktree (unless `--force` is used).
 +
-If `<commit-ish>` is omitted, neither `--detach`, or `--orphan` is
+If _<commit-ish>_ is omitted, neither `--detach`, or `--orphan` is
 used, and there are no valid local branches (or remote branches if
 `--guess-remote` is specified) then, as a convenience, the new worktree is
-associated with a new unborn branch named `<branch>` (after
+associated with a new unborn branch named _<branch>_ (after
 `$(basename <path>)` if neither `-b` or `-B` is used) as if `--orphan` was
 passed to the command. In the event the repository has a remote and
 `--guess-remote` is used, but no remote or local branches exist, then the
 command fails with a warning reminding the user to fetch from their remote
 first (or override by using `-f/--force`).
 
-list::
+`list`::
 
 List details of each worktree.  The main worktree is listed first,
 followed by each of the linked worktrees.  The output details include
@@ -115,32 +115,32 @@ branch currently checked out (or "detached HEAD" if none), "locked" if
 the worktree is locked, "prunable" if the worktree can be pruned by the
 `prune` command.
 
-lock::
+`lock`::
 
 If a worktree is on a portable device or network share which is not always
 mounted, lock it to prevent its administrative files from being pruned
 automatically. This also prevents it from being moved or deleted.
 Optionally, specify a reason for the lock with `--reason`.
 
-move::
+`move`::
 
 Move a worktree to a new location. Note that the main worktree or linked
 worktrees containing submodules cannot be moved with this command. (The
 `git worktree repair` command, however, can reestablish the connection
 with linked worktrees if you move the main worktree manually.)
 
-prune::
+`prune`::
 
 Prune worktree information in `$GIT_DIR/worktrees`.
 
-remove::
+`remove`::
 
 Remove a worktree. Only clean worktrees (no untracked files and no
 modification in tracked files) can be removed. Unclean worktrees or ones
 with submodules can be removed with `--force`. The main worktree cannot be
 removed.
 
-repair [<path>...]::
+`repair [<path>...]`::
 
 Repair worktree administrative files, if possible, if they have become
 corrupted or outdated due to external factors.
@@ -154,72 +154,72 @@ Similarly, if the working tree for a linked worktree is moved without
 using `git worktree move`, the main worktree (or bare repository) will be
 unable to locate it. Running `repair` within the recently-moved worktree
 will reestablish the connection. If multiple linked worktrees are moved,
-running `repair` from any worktree with each tree's new `<path>` as an
+running `repair` from any worktree with each tree's new _<path>_ as an
 argument, will reestablish the connection to all the specified paths.
 +
 If both the main worktree and linked worktrees have been moved or copied manually,
-then running `repair` in the main worktree and specifying the new `<path>`
+then running `repair` in the main worktree and specifying the new _<path>_
 of each linked worktree will reestablish all connections in both
 directions.
 
-unlock::
+`unlock`::
 
 Unlock a worktree, allowing it to be pruned, moved or deleted.
 
 OPTIONS
 -------
 
--f::
---force::
+`-f`::
+`--force`::
 	By default, `add` refuses to create a new worktree when
-	`<commit-ish>` is a branch name and is already checked out by
-	another worktree, or if `<path>` is already assigned to some
-	worktree but is missing (for instance, if `<path>` was deleted
+	_<commit-ish>_ is a branch name and is already checked out by
+	another worktree, or if _<path>_ is already assigned to some
+	worktree but is missing (for instance, if _<path>_ was deleted
 	manually). This option overrides these safeguards. To add a missing but
 	locked worktree path, specify `--force` twice.
 +
 `move` refuses to move a locked worktree unless `--force` is specified
 twice. If the destination is already assigned to some other worktree but is
-missing (for instance, if `<new-path>` was deleted manually), then `--force`
+missing (for instance, if _<new-path>_ was deleted manually), then `--force`
 allows the move to proceed; use `--force` twice if the destination is locked.
 +
 `remove` refuses to remove an unclean worktree unless `--force` is used.
 To remove a locked worktree, specify `--force` twice.
 
--b <new-branch>::
--B <new-branch>::
-	With `add`, create a new branch named `<new-branch>` starting at
-	`<commit-ish>`, and check out `<new-branch>` into the new worktree.
-	If `<commit-ish>` is omitted, it defaults to `HEAD`.
+`-b <new-branch>`::
+`-B <new-branch>`::
+	With `add`, create a new branch named _<new-branch>_ starting at
+	_<commit-ish>_, and check out _<new-branch>_ into the new worktree.
+	If _<commit-ish>_ is omitted, it defaults to `HEAD`.
 	By default, `-b` refuses to create a new branch if it already
-	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
-	`<commit-ish>`.
+	exists. `-B` overrides this safeguard, resetting _<new-branch>_ to
+	_<commit-ish>_.
 
--d::
---detach::
+`-d`::
+`--detach`::
 	With `add`, detach `HEAD` in the new worktree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
---checkout::
---no-checkout::
-	By default, `add` checks out `<commit-ish>`, however, `--no-checkout` can
+`--checkout`::
+`--no-checkout`::
+	By default, `add` checks out _<commit-ish>_, however, `--no-checkout` can
 	be used to suppress checkout in order to make customizations,
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
 
---guess-remote::
---no-guess-remote::
-	With `worktree add <path>`, without `<commit-ish>`, instead
+`--guess-remote`::
+`--no-guess-remote`::
+	With `worktree add <path>`, without _<commit-ish>_, instead
 	of creating a new branch from `HEAD`, if there exists a tracking
-	branch in exactly one remote matching the basename of `<path>`,
+	branch in exactly one remote matching the basename of _<path>_,
 	base the new branch on the remote-tracking branch, and mark
 	the remote-tracking branch as "upstream" from the new branch.
 +
 This can also be set up as the default behaviour by using the
 `worktree.guessRemote` config option.
 
---relative-paths::
---no-relative-paths::
+`--relative-paths`::
+`--no-relative-paths`::
 	Link worktrees using relative paths or absolute paths (default).
 	Overrides the `worktree.useRelativePaths` config option, see
 	linkgit:git-config[1].
@@ -227,60 +227,60 @@ This can also be set up as the default behaviour by using the
 With `repair`, the linking files will be updated if there's an absolute/relative
 mismatch, even if the links are correct.
 
---track::
---no-track::
-	When creating a new branch, if `<commit-ish>` is a branch,
+`--track`::
+`--no-track`::
+	When creating a new branch, if _<commit-ish>_ is a branch,
 	mark it as "upstream" from the new branch.  This is the
-	default if `<commit-ish>` is a remote-tracking branch.  See
+	default if _<commit-ish>_ is a remote-tracking branch.  See
 	`--track` in linkgit:git-branch[1] for details.
 
---lock::
+`--lock`::
 	Keep the worktree locked after creation. This is the
 	equivalent of `git worktree lock` after `git worktree add`,
 	but without a race condition.
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	With `prune`, do not remove anything; just report what it would
 	remove.
 
---orphan::
+`--orphan`::
 	With `add`, make the new worktree and index empty, associating
-	the worktree with a new unborn branch named `<new-branch>`.
+	the worktree with a new unborn branch named _<new-branch>_.
 
---porcelain::
+`--porcelain`::
 	With `list`, output in an easy-to-parse format for scripts.
 	This format will remain stable across Git versions and regardless of user
 	configuration.  It is recommended to combine this with `-z`.
 	See below for details.
 
--z::
-	Terminate each line with a NUL rather than a newline when
+`-z`::
+	Terminate each line with a _NUL_ rather than a newline when
 	`--porcelain` is specified with `list`. This makes it possible
 	to parse the output when a worktree path contains a newline
 	character.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	With `add`, suppress feedback messages.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	With `prune`, report all removals.
 +
 With `list`, output additional information about worktrees (see below).
 
---expire <time>::
-	With `prune`, only expire unused worktrees older than `<time>`.
+`--expire <time>`::
+	With `prune`, only expire unused worktrees older than _<time>_.
 +
 With `list`, annotate missing worktrees as prunable if they are older than
-`<time>`.
+_<time>_.
 
---reason <string>::
+`--reason <string>`::
 	With `lock` or with `add --lock`, an explanation why the worktree
 	is locked.
 
-<worktree>::
+_<worktree>_::
 	Worktrees can be identified by path, either relative or absolute.
 +
 If the last path components in the worktree's path is unique among
@@ -522,6 +522,13 @@ $ popd
 $ git worktree remove ../temp
 ------------
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.adoc[]
+
+include::config/worktree.adoc[]
+
 BUGS
 ----
 Multiple checkout in general is still experimental, and the support
-- 
gitgitgadget
