Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1829AAF3
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759698711; cv=none; b=ZYYPYB9562NAWP1FQ6WTNVgnl7jIxIWkoHnRiJQspgEJBU7+Db5BJvbx1S2VkHwPSEqEicRfqrTRiEr8SQC2GwZrmJS4X+M2WYgPZtSIdk0PFto+swUriuwzr5EbtmJLS8m7pBbml+qcTwuEcvE+Bw4as7dTCcyF1tToNWfEkks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759698711; c=relaxed/simple;
	bh=YCVYDs8kXcjER8AtwLkrVUqErUGxTbKDYzLCCK1T8CQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Xrps6xzrP2iDQQnoar5RPJybffstJuATeV7cskaIX0ghNS0W8M4p4QEwtlzmWdbs/sbZHVYCTP+4WkO+YXUqzyvIqQURSKp5x0pGCH+TGWvg/YdNJER56uxIqZ9Ok7vph9wa9kx5hjDjTNlQjLH+Ofjd7aAwSXjh7iTBbtn0oSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkSpem9M; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkSpem9M"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-42f67e91ae7so15528865ab.0
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759698708; x=1760303508; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHpdDT1jLNfHw8iweh3SFnIFNq05xOkGQnC+/STmiuc=;
        b=GkSpem9MNm/RdLOrvcrEklpvze5TwMLSTGiLzHtafqTFZMUrcNocdnGi4pqdZYBrk7
         8Ejwt5rm6b9lXhZn5MtUcsIq+pyK+bq8vKYYPK5CZwNS0LnHfx4Kh85e9ERzHXtZVYAX
         pjZmTPE3eyglkMy9dWVPUkEEs0tNsHB1HCfPMrawZ2ayxRT1pUejdNGoMoy+QKw1nAUF
         heYcremby2uD4CNCCCDpp/hgW3JGgoEsO+8CIc029Ak1xK1eMSj9z/OW8KUVpcEy9rHF
         AZD5Ywn3CvBXqckqE09jcqfDyEh0+/656buqOLcNDLEe+MFxuR+OfpjsU0KsCL1WktQz
         up8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759698708; x=1760303508;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHpdDT1jLNfHw8iweh3SFnIFNq05xOkGQnC+/STmiuc=;
        b=qyEC4K+tGdlV0IxDBKI08fiXzbIWm/sAnKQ4HaCRTtQUOpC69dOx3MDoerxB5112ba
         aQHR92w9w28PC2E4f+7Y55+LR4DNhjAv3hItudQ4K29h6rS4uCo1/Jj5wk4m2+nzFxtu
         HKJQgeZzy+I4PW5R9BUwjIoLS3NHUvcTX1KY6vWV+DLbYzbMCdBP9Qc5jGrLhpslyH7P
         8LOYd/6oCxeW9XdCB74672PdJKMXsQdpHS2PKU7ZPm/TdUa6//C96yH27MCKAhghpaSS
         MnMmWZhTCVlZsWPj6DoimY8+cXZr3zSwN7ZHnLtNP5a7sJTNQ59vcOp+EAIgRQ11HekS
         mjyA==
X-Gm-Message-State: AOJu0YxuXBzRHFGo/XOjPkmBvGxswTPvq85fBUt1hqKsOOABzdaasRGe
	jww9m1R8mUFv1Wjl5uidm9ZiAXcSqYp8rcoglhx0R7nFCab8Wb+q9iRpOXEEbD5Z
X-Gm-Gg: ASbGncsOfEtsG7DxFzxWuHCS0AW4BZxx7fYxOS0lsmVutG5OWfRZjdlKz3ztibR8wZF
	Ct1MOzregA34nEz7vUEAfElnDhTHtYpljA8RUBeuLgHxfeFhliBAPftiFH6jbGtC+8dXm694Bpn
	Jg8+CZ4reKCofvSwfuMAEtNj/Tsg06CGHDfIBS1AFRkVCUT3YwDpK09dNaOXgOxn+gtnAhGQ9iG
	CbboaHHa4R0hFehfm8JsWYaR6EXcCYHwx3onJqXegHIMUe1H08doWFUL9o2IzMOug1Lq9QfmH4i
	I3G2sdyzDpfMAeS79JPiaq0+w7GvSCEnlUci/cRmg434CuLy1b6hWHOgCgdU5Cy8pIVfhBsN+kd
	UDQ+Ob2r6uFOA3Qy5DWhP4TborE2VAZa3JmF0BjQG+sa6zRR9m402NrgpmrA=
X-Google-Smtp-Source: AGHT+IGXB1TieYerK3M1b2qoroSySq4/E6ElHVAV7zyoOElvYj+Wl16zVeXBXBnddObo5GfLnrJBSQ==
X-Received: by 2002:a05:6e02:1aa7:b0:42b:2a51:f50a with SMTP id e9e14a558f8ab-42e7adb9792mr144918245ab.31.1759698707854;
        Sun, 05 Oct 2025 14:11:47 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b294f91sm45132135ab.34.2025.10.05.14.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 14:11:46 -0700 (PDT)
Message-Id: <3f3e5a87e834a6cd1d5d7769bdd2c0dcfaa4b6ae.1759698702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1969.git.1759698702.gitgitgadget@gmail.com>
References: <pull.1969.git.1759698702.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Oct 2025 21:11:40 +0000
Subject: [PATCH 1/3] doc: convert git-stash.adoc to synopis style
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

Also do not refer to the man page in the description of settings when this
description is already in the man page.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/stash.adoc |  29 ++++---
 Documentation/git-stash.adoc    | 134 ++++++++++++++++----------------
 2 files changed, 85 insertions(+), 78 deletions(-)

diff --git a/Documentation/config/stash.adoc b/Documentation/config/stash.adoc
index e556105a15..7fc32027f7 100644
--- a/Documentation/config/stash.adoc
+++ b/Documentation/config/stash.adoc
@@ -1,19 +1,28 @@
-stash.index::
+ifndef::git-stash[]
+:see-show: See the description of the 'show' command in linkgit:git-stash[1].
+endif::git-stash[]
+
+ifdef::git-stash[]
+:see-show:
+endif::git-stash[]
+
+`stash.index`::
 	If this is set to true, `git stash apply` and `git stash pop` will
-	behave as if `--index` was supplied. Defaults to false. See the
-	descriptions in linkgit:git-stash[1].
+	behave as if `--index` was supplied. Defaults to false.
+ifndef::git-stash[]
+See the descriptions in linkgit:git-stash[1].
+endif::git-stash[]
 
-stash.showIncludeUntracked::
+`stash.showIncludeUntracked`::
 	If this is set to true, the `git stash show` command will show
-	the untracked files of a stash entry.  Defaults to false. See
-	the description of the 'show' command in linkgit:git-stash[1].
+	the untracked files of a stash entry. Defaults to false. {see-show}
 
-stash.showPatch::
+`stash.showPatch`::
 	If this is set to true, the `git stash show` command without an
 	option will show the stash entry in patch form.  Defaults to false.
-	See the description of the 'show' command in linkgit:git-stash[1].
+	{see-show}
 
-stash.showStat::
+`stash.showStat`::
 	If this is set to true, the `git stash show` command without an
 	option will show a diffstat of the stash entry.  Defaults to true.
-	See the description of the 'show' command in linkgit:git-stash[1].
+	{see-show}
diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index e2300a19a2..235d57ddd8 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -7,24 +7,24 @@ git-stash - Stash the changes in a dirty working directory away
 
 SYNOPSIS
 --------
-[verse]
-'git stash' list [<log-options>]
-'git stash' show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
-'git stash' drop [-q | --quiet] [<stash>]
-'git stash' pop [--index] [-q | --quiet] [<stash>]
-'git stash' apply [--index] [-q | --quiet] [<stash>]
-'git stash' branch <branchname> [<stash>]
-'git stash' [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
+[synopsis]
+git stash list [<log-options>]
+git stash show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
+git stash drop [-q | --quiet] [<stash>]
+git stash pop [--index] [-q | --quiet] [<stash>]
+git stash apply [--index] [-q | --quiet] [<stash>]
+git stash branch <branchname> [<stash>]
+git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
 	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	     [--] [<pathspec>...]]
-'git stash' save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
-	     [-u | --include-untracked] [-a | --all] [<message>]
-'git stash' clear
-'git stash' create [<message>]
-'git stash' store [(-m | --message) <message>] [-q | --quiet] <commit>
-'git stash' export (--print | --to-ref <ref>) [<stash>...]
-'git stash' import <commit>
+git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
+           [-u | --include-untracked] [-a | --all] [<message>]
+git stash clear
+git stash create [<message>]
+git stash store [(-m | --message) <message>] [-q | --quiet] <commit>
+git stash export (--print | --to-ref <ref>) [<stash>...]
+git stash import <commit>
 
 DESCRIPTION
 -----------
@@ -38,7 +38,7 @@ The modifications stashed away by this command can be listed with
 `git stash list`, inspected with `git stash show`, and restored
 (potentially on top of a different commit) with `git stash apply`.
 Calling `git stash` without any arguments is equivalent to `git stash push`.
-A stash is by default listed as "WIP on 'branchname' ...", but
+A stash is by default listed as "WIP on '<branchname>' ...", but
 you can give a more descriptive message on the command line when
 you create one.
 
@@ -47,16 +47,16 @@ stashes are found in the reflog of this reference and can be named using
 the usual reflog syntax (e.g. `stash@{0}` is the most recently
 created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
 is also possible). Stashes may also be referenced by specifying just the
-stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
+stash index (e.g. the integer `<n>` is equivalent to `stash@{<n>}`).
 
 COMMANDS
 --------
 
-push [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [(-m|--message) <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]::
+`push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-u | --include-untracked] [ -a | --all] [-q | --quiet] [(-m|--message) <message>] [--pathspec-from-file=<file> [--pathspec-file-nul]] [--] [<pathspec>...]`::
 
 	Save your local modifications to a new 'stash entry' and roll them
-	back to HEAD (in the working tree and in the index).
-	The <message> part is optional and gives
+	back to `HEAD` (in the working tree and in the index).
+	The _<message>_ part is optional and gives
 	the description along with the stashed state.
 +
 For quickly making a snapshot, you can omit "push".  In this mode,
@@ -65,14 +65,14 @@ subcommand from making an unwanted stash entry.  The two exceptions to this
 are `stash -p` which acts as alias for `stash push -p` and pathspec elements,
 which are allowed after a double hyphen `--` for disambiguation.
 
-save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+`save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-u | --include-untracked] [-a | --all] [-q | --quiet] [<message>]`::
 
 	This option is deprecated in favour of 'git stash push'.  It
 	differs from "stash push" in that it cannot take pathspec.
 	Instead, all non-option arguments are concatenated to form the stash
 	message.
 
-list [<log-options>]::
+`list [<log-options>]`::
 
 	List the stash entries that you currently have.  Each 'stash entry' is
 	listed with its name (e.g. `stash@{0}` is the latest entry, `stash@{1}` is
@@ -88,7 +88,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
 The command takes options applicable to the 'git log'
 command to control what is shown and how. See linkgit:git-log[1].
 
-show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]::
+`show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]`::
 
 	Show the changes recorded in the stash entry as a diff between the
 	stashed contents and the commit back when the stash entry was first
@@ -96,12 +96,12 @@ show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]::
 	By default, the command shows the diffstat, but it will accept any
 	format known to 'git diff' (e.g., `git stash show -p stash@{1}`
 	to view the second most recent entry in patch form).
-	If no `<diff-option>` is provided, the default behavior will be given
+	If no _<diff-option>_ is provided, the default behavior will be given
 	by the `stash.showStat`, and `stash.showPatch` config variables. You
 	can also use `stash.showIncludeUntracked` to set whether
 	`--include-untracked` is enabled by default.
 
-pop [--index] [-q|--quiet] [<stash>]::
+`pop [--index] [-q | --quiet] [<stash>]`::
 
 	Remove a single stashed state from the stash list and apply it
 	on top of the current working tree state, i.e., do the inverse
@@ -112,19 +112,19 @@ Applying the state can fail with conflicts; in this case, it is not
 removed from the stash list. You need to resolve the conflicts by hand
 and call `git stash drop` manually afterwards.
 
-apply [--index] [-q|--quiet] [<stash>]::
+`apply [--index] [-q | --quiet] [<stash>]`::
 
 	Like `pop`, but do not remove the state from the stash list. Unlike `pop`,
 	`<stash>` may be any commit that looks like a commit created by
 	`stash push` or `stash create`.
 
-branch <branchname> [<stash>]::
+`branch <branchname> [<stash>]`::
 
-	Creates and checks out a new branch named `<branchname>` starting from
-	the commit at which the `<stash>` was originally created, applies the
-	changes recorded in `<stash>` to the new working tree and index.
-	If that succeeds, and `<stash>` is a reference of the form
-	`stash@{<revision>}`, it then drops the `<stash>`.
+	Creates and checks out a new branch named _<branchname>_ starting from
+	the commit at which the _<stash>_ was originally created, applies the
+	changes recorded in _<stash>_ to the new working tree and index.
+	If that succeeds, and _<stash>_ is a reference of the form
+	`stash@{<revision>}`, it then drops the _<stash>_.
 +
 This is useful if the branch on which you ran `git stash push` has
 changed enough that `git stash apply` fails due to conflicts. Since
@@ -132,54 +132,51 @@ the stash entry is applied on top of the commit that was HEAD at the
 time `git stash` was run, it restores the originally stashed state
 with no conflicts.
 
-clear::
+`clear`::
 	Remove all the stash entries. Note that those entries will then
 	be subject to pruning, and may be impossible to recover (see
-	'Examples' below for a possible strategy).
-
-drop [-q|--quiet] [<stash>]::
+	'EXAMPLES' below for a possible strategy).
 
+`drop [-q | --quiet] [<stash>]`::
 	Remove a single stash entry from the list of stash entries.
 
-create::
-
+`create`::
 	Create a stash entry (which is a regular commit object) and
 	return its object name, without storing it anywhere in the ref
 	namespace.
 	This is intended to be useful for scripts.  It is probably not
 	the command you want to use; see "push" above.
 
-store::
+`store`::
 
 	Store a given stash created via 'git stash create' (which is a
 	dangling merge commit) in the stash ref, updating the stash
 	reflog.  This is intended to be useful for scripts.  It is
 	probably not the command you want to use; see "push" above.
 
-export ( --print | --to-ref <ref> ) [<stash>...]::
+`export ( --print | --to-ref <ref> ) [<stash>...]`::
 
 	Export the specified stashes, or all of them if none are specified, to
 	a chain of commits which can be transferred using the normal fetch and
 	push mechanisms, then imported using the `import` subcommand.
 
-import <commit>::
-
+`import <commit>`::
 	Import the specified stashes from the specified commit, which must have been
 	created by `export`, and add them to the list of stashes.  To replace the
 	existing stashes, use `clear` first.
 
 OPTIONS
 -------
--a::
---all::
+`-a`::
+`--all`::
 	This option is only valid for `push` and `save` commands.
 +
 All ignored and untracked files are also stashed and then cleaned
 up with `git clean`.
 
--u::
---include-untracked::
---no-include-untracked::
+`-u`::
+`--include-untracked`::
+`--no-include-untracked`::
 	When used with the `push` and `save` commands,
 	all untracked files are also stashed and then cleaned up with
 	`git clean`.
@@ -187,12 +184,12 @@ up with `git clean`.
 When used with the `show` command, show the untracked files in the stash
 entry as part of the diff.
 
---only-untracked::
+`--only-untracked`::
 	This option is only valid for the `show` command.
 +
 Show only the untracked files in the stash entry as part of the diff.
 
---index::
+`--index`::
 	This option is only valid for `pop` and `apply` commands.
 +
 Tries to reinstate not only the working tree's changes, but also
@@ -200,15 +197,15 @@ the index's ones. However, this can fail, when you have conflicts
 (which are stored in the index, where you therefore can no longer
 apply the changes as they were originally).
 
--k::
---keep-index::
---no-keep-index::
+`-k`::
+`--keep-index`::
+`--no-keep-index`::
 	This option is only valid for `push` and `save` commands.
 +
 All changes already added to the index are left intact.
 
--p::
---patch::
+`-p`::
+`--patch`::
 	This option is only valid for `push` and `save` commands.
 +
 Interactively select hunks from the diff between HEAD and the
@@ -224,8 +221,8 @@ The `--patch` option implies `--keep-index`.  You can use
 
 include::diff-context-options.adoc[]
 
--S::
---staged::
+`-S`::
+`--staged`::
 	This option is only valid for `push` and `save` commands.
 +
 Stash only the changes that are currently staged. This is similar to
@@ -234,49 +231,49 @@ of current branch.
 +
 The `--patch` option has priority over this one.
 
---pathspec-from-file=<file>::
+`--pathspec-from-file=<file>`::
 	This option is only valid for `push` command.
 +
-Pathspec is passed in `<file>` instead of commandline args. If
-`<file>` is exactly `-` then standard input is used. Pathspec
+Pathspec is passed in _<file>_ instead of commandline args. If
+_<file>_ is exactly `-` then standard input is used. Pathspec
 elements are separated by LF or CR/LF. Pathspec elements can be
 quoted as explained for the configuration variable `core.quotePath`
 (see linkgit:git-config[1]). See also `--pathspec-file-nul` and
 global `--literal-pathspecs`.
 
---pathspec-file-nul::
+`--pathspec-file-nul`::
 	This option is only valid for `push` command.
 +
 Only meaningful with `--pathspec-from-file`. Pathspec elements are
 separated with NUL character and all other characters are taken
 literally (including newlines and quotes).
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	This option is only valid for `apply`, `drop`, `pop`, `push`,
 	`save`, `store` commands.
 +
 Quiet, suppress feedback messages.
 
---print::
+`--print`::
 	This option is only valid for the `export` command.
 +
 Create the chain of commits representing the exported stashes without
 storing it anywhere in the ref namespace and print the object ID to
 standard output.  This is designed for scripts.
 
---to-ref::
+`--to-ref`::
 	This option is only valid for the `export` command.
 +
 Create the chain of commits representing the exported stashes and store
 it to the specified ref.
 
-\--::
+`--`::
 	This option is only valid for `push` command.
 +
 Separates pathspec from options for disambiguation purposes.
 
-<pathspec>...::
+`<pathspec>...`::
 	This option is only valid for `push` command.
 +
 The new stash entry records the modified states only for the files
@@ -286,11 +283,11 @@ too, leaving files that do not match the pathspec intact.
 +
 For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
-<stash>::
+_<stash>_::
 	This option is only valid for `apply`, `branch`, `drop`, `pop`,
 	`show`, and `export` commands.
 +
-A reference of the form `stash@{<revision>}`. When no `<stash>` is
+A reference of the form `stash@{<revision>}`. When no _<stash>_ is
 given, the latest stash is assumed (that is, `stash@{0}`).
 
 DISCUSSION
@@ -419,6 +416,7 @@ CONFIGURATION
 
 include::includes/cmd-config-section-all.adoc[]
 
+:git-stash: 1
 include::config/stash.adoc[]
 
 
-- 
gitgitgadget

