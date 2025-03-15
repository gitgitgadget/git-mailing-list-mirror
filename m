Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797E2F3B
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742056321; cv=none; b=J1kZznTL5CG7FSfebTcOgH9JY/PpvsdQEskDq7JXVjdR7rXDnMyJDKyt5L9EbUc7PWhbVGbQhT5gAvcKPUNWFPxI8Q/cH/0nguNVMbim5jR9Gg8e961wtXUsFyf4JnsFhJFmeHZ2ah4unTxIkzypaWbo7acGmAbzye7U+Kh4UAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742056321; c=relaxed/simple;
	bh=uerK8WSD57EMBHAyOG7089aZQtRQ+FadjF7uwM/5ewQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=DwT7s51ZveD+3okpNNE9JXoYzSOrQbQThTZjno8AMi/nmsLWMmrSOjbOsEgzZy/YBArFJIgNSrC4oXGntgu94NIPGy6Ipq+0kUYnkKwhwVqVuEomhU0l7um7Fdsf6dEd1YJRE2UJne0oKsJP5F+Q4S6QrV9ehwaCZcbKY8Nc4HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7aeJ1kc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7aeJ1kc"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394036c0efso4300095e9.2
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742056314; x=1742661114; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcgUefDtBT9R2knRqUtamv3rt7LPhuXmX4BkTU2gk7U=;
        b=N7aeJ1kcnoLa3j+PG+Cl4GRINQ+RoHivaN8XYpI3DV7p2sU5dlWAHxj+NswHgCCOYd
         EAVJNOEmvM9xi7ykHNnswJFeWakqBpYvdIZMKMOxMJ1/E+SPGKbU7nYJ0rJGP8J7v1Dx
         8e2kxHJQPV1Gy3gFJ14jLq1x6p6pEA7HPaDULX0UvTDbx6A85I1CDYlFd6m2zboa9nll
         QgWrXpSH/zplZForVOzvstYDVWxzHlhEZUiGSuL6YtjffBabiriPIHJDMCNAuxc6AbvF
         aZ62ZojjxxKRbePq3GaswdA8M6KNPpXbgYD4BsPadUDMcTLBUpgrytYUh82koU26s70L
         5NsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742056314; x=1742661114;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcgUefDtBT9R2knRqUtamv3rt7LPhuXmX4BkTU2gk7U=;
        b=NnvUGnitz3m0eAp39NBZmP8CCl0jqt/7Q9Hz5s9Y9l8IMEvyXhaGlnHvEIGHWSr/+S
         MZAdf/YF9igmudIyOt+GbvZCTygSyxeNYiwzPmaMSaBkbZyotkC3H9BFr30xL/nAidB8
         l6d+IezSS09Uqtz7pF2zpPS+2EnVZclnuMva3T4wK1I9m1mvBjP6UaDYXGnMLD0FKztk
         oSpGTGA4/bYMuwylqJP6oEQ3G0IQ4tkjgyOa9uA79/9OPpzlwjBYjIOoTbgW1ZAiytkm
         GT7SvyZy5jQNBVjmSjGWXF4BEFq2p2pg08i3EBWoltxxUJ00q7Mu6OE/cFKfpo8fHUbx
         tluQ==
X-Gm-Message-State: AOJu0YzQCylwHBPLvq/TCWOgAF0ULlYwZkf+WkQbMy0evRg9qT697oxN
	1iUEeBDuzS8oRS0JDNnV8REP2Tf3ed5IQN5CHiUVrKJ+XR2jP353FJsVAA==
X-Gm-Gg: ASbGnctL43AELIt31lLFINmwcYi/TARGe9hDPlnHKoOxC9fUGBB9+TwwjAujxPFuvrR
	iTI8i9kkYKGZ7MDRGHctx0QiemcWG7gdn+hrvK0eobrYaUFAqMAihP4SN+CYMHgoY5pMUh7rymq
	p2ocxwcO5IiQeO3KpZVbG9u2S5xHxIN8Vx+edHOu7pWdaGICMRLIwr+SsP7AmkaePTwyRNWjSk9
	Vn18M9i1CJOREMePDL6QOZVvLao8WmJm3SfopMTMC7OVN34tLVdo4hHXOLNvdVoR2EDTQUKuxEw
	IeG9akSrlS8yaOfr9Y2wYaCY0fZeeh/e83l1/ssCmDKr8A==
X-Google-Smtp-Source: AGHT+IHtMZyX4lfQfoJvsqi4qwIbL+Bdlo2PWJY0dk0rH5aSoNLes6Dt+hiKiqXh4ufh75UhNaiu1w==
X-Received: by 2002:a05:600c:458e:b0:43c:eb00:50eb with SMTP id 5b1f17b1804b1-43d1ec644f8mr90090105e9.5.1742056313330;
        Sat, 15 Mar 2025 09:31:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe15488sm55748445e9.16.2025.03.15.09.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 09:31:52 -0700 (PDT)
Message-Id: <b2e7867006e1800eb6dc52902006998afd5800cc.1742056310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1880.git.1742056310.gitgitgadget@gmail.com>
References: <pull.1880.git.1742056310.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 15 Mar 2025 16:31:50 +0000
Subject: [PATCH 2/2] doc: apply new format to git-branch man page
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

- Switch the synopsis to a synopsis block which automatically
  formats placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine applies synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/branch.adoc | 105 +++++------
 Documentation/git-branch.adoc    | 287 +++++++++++++++----------------
 2 files changed, 196 insertions(+), 196 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index 432b9cd2c0e..e35ea7ac640 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -1,41 +1,42 @@
-branch.autoSetupMerge::
-	Tells 'git branch', 'git switch' and 'git checkout' to set up new branches
+`branch.autoSetupMerge`::
+	Tells `git branch`, `git switch` and `git checkout` to set up new branches
 	so that linkgit:git-pull[1] will appropriately merge from the
 	starting point branch. Note that even if this option is not set,
 	this behavior can be chosen per-branch using the `--track`
-	and `--no-track` options. The valid settings are: `false` -- no
-	automatic setup is done; `true` -- automatic setup is done when the
-	starting point is a remote-tracking branch; `always` --
-	automatic setup is done when the starting point is either a
-	local branch or remote-tracking branch; `inherit` -- if the starting point
-	has a tracking configuration, it is copied to the new
-	branch; `simple` -- automatic setup is done only when the starting point
+	and `--no-track` options.  This option defaults to `true`. The valid settings
+	are:
+`false`;; no automatic setup is done
+`true`;; automatic setup is done when the starting point is a remote-tracking branch
+`always`;; automatic setup is done when the starting point is either a
+	local branch or remote-tracking branch
+`inherit`;; if the starting point has a tracking configuration, it is copied to the new
+	branch
+`simple`;; automatic setup is done only when the starting point
 	is a remote-tracking branch and the new branch has the same name as the
-	remote branch. This option defaults to true.
+	remote branch.
 
-branch.autoSetupRebase::
-	When a new branch is created with 'git branch', 'git switch' or 'git checkout'
+`branch.autoSetupRebase`::
+	When a new branch is created with `git branch`, `git switch` or `git checkout`
 	that tracks another branch, this variable tells Git to set
-	up pull to rebase instead of merge (see "branch.<name>.rebase").
-	When `never`, rebase is never automatically set to true.
-	When `local`, rebase is set to true for tracked branches of
-	other local branches.
-	When `remote`, rebase is set to true for tracked branches of
-	remote-tracking branches.
-	When `always`, rebase will be set to true for all tracking
-	branches.
-	See "branch.autoSetupMerge" for details on how to set up a
-	branch to track another branch.
-	This option defaults to never.
+	up pull to rebase instead of merge (see `branch.<name>.rebase`).
+	The valid settings are:
+`never`;; rebase is never automatically set to true.
+`local`;; rebase is set to true for tracked branches of other local branches.
+`remote`;; rebase is set to true for tracked branches of remote-tracking branches.
+`always`;; rebase will be set to true for all tracking branches.
 
-branch.sort::
++
+See `branch.autoSetupMerge` for details on how to set up a branch to track another branch.
+This option defaults to `never`.
+
+`branch.sort`::
 	This variable controls the sort ordering of branches when displayed by
-	linkgit:git-branch[1]. Without the "--sort=<value>" option provided, the
+	linkgit:git-branch[1]. Without the `--sort=<value>` option provided, the
 	value of this variable will be used as the default.
 	See linkgit:git-for-each-ref[1] field names for valid values.
 
-branch.<name>.remote::
-	When on branch <name>, it tells 'git fetch' and 'git push'
+`branch.<name>.remote`::
+	When on branch _<name>_, it tells `git fetch` and `git push`
 	which remote to fetch from or push to.  The remote to push to
 	may be overridden with `remote.pushDefault` (for all branches).
 	The remote to push to, for the current branch, may be further
@@ -46,58 +47,58 @@ branch.<name>.remote::
 	Additionally, `.` (a period) is the current local repository
 	(a dot-repository), see `branch.<name>.merge`'s final note below.
 
-branch.<name>.pushRemote::
-	When on branch <name>, it overrides `branch.<name>.remote` for
+`branch.<name>.pushRemote`::
+	When on branch _<name>_, it overrides `branch.<name>.remote` for
 	pushing.  It also overrides `remote.pushDefault` for pushing
-	from branch <name>.  When you pull from one place (e.g. your
+	from branch _<name>_.  When you pull from one place (e.g. your
 	upstream) and push to another place (e.g. your own publishing
 	repository), you would want to set `remote.pushDefault` to
 	specify the remote to push to for all branches, and use this
 	option to override it for a specific branch.
 
-branch.<name>.merge::
-	Defines, together with branch.<name>.remote, the upstream branch
-	for the given branch. It tells 'git fetch'/'git pull'/'git rebase' which
-	branch to merge and can also affect 'git push' (see push.default).
-	When in branch <name>, it tells 'git fetch' the default
-	refspec to be marked for merging in FETCH_HEAD. The value is
+`branch.<name>.merge`::
+	Defines, together with `branch.<name>.remote`, the upstream branch
+	for the given branch. It tells `git fetch`/`git pull`/`git rebase` which
+	branch to merge and can also affect `git push` (see `push.default`).
+	When in branch _<name>_, it tells `git fetch` the default
+	refspec to be marked for merging in `FETCH_HEAD`. The value is
 	handled like the remote part of a refspec, and must match a
 	ref which is fetched from the remote given by
-	"branch.<name>.remote".
-	The merge information is used by 'git pull' (which first calls
-	'git fetch') to lookup the default branch for merging. Without
-	this option, 'git pull' defaults to merge the first refspec fetched.
+	`branch.<name>.remote`.
+	The merge information is used by `git pull` (which first calls
+	`git fetch`) to lookup the default branch for merging. Without
+	this option, `git pull` defaults to merge the first refspec fetched.
 	Specify multiple values to get an octopus merge.
-	If you wish to setup 'git pull' so that it merges into <name> from
+	If you wish to setup `git pull` so that it merges into <name> from
 	another branch in the local repository, you can point
 	branch.<name>.merge to the desired branch, and use the relative path
-	setting `.` (a period) for branch.<name>.remote.
+	setting `.` (a period) for `branch.<name>.remote`.
 
-branch.<name>.mergeOptions::
-	Sets default options for merging into branch <name>. The syntax and
+`branch.<name>.mergeOptions`::
+	Sets default options for merging into branch _<name>_. The syntax and
 	supported options are the same as those of linkgit:git-merge[1], but
 	option values containing whitespace characters are currently not
 	supported.
 
-branch.<name>.rebase::
-	When true, rebase the branch <name> on top of the fetched branch,
+`branch.<name>.rebase`::
+	When true, rebase the branch _<name>_ on top of the fetched branch,
 	instead of merging the default branch from the default remote when
-	"git pull" is run. See "pull.rebase" for doing this in a non
+	`git pull` is run. See `pull.rebase` for doing this in a non
 	branch-specific manner.
 +
-When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
+When `merges` (or just `m`), pass the `--rebase-merges` option to `git rebase`
 so that the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When the value is `interactive` (or just 'i'), the rebase is run in interactive
+When the value is `interactive` (or just `i`), the rebase is run in interactive
 mode.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
 
-branch.<name>.description::
+`branch.<name>.description`::
 	Branch description, can be edited with
 	`git branch --edit-description`. Branch description is
-	automatically added to the format-patch cover letter or
-	request-pull summary.
+	automatically added to the `format-patch` cover letter or
+	`request-pull` summary.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 7a073a36d6d..50a1e13e1f2 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -7,23 +7,23 @@ git-branch - List, create, or delete branches
 
 SYNOPSIS
 --------
-[verse]
-'git branch' [--color[=<when>] | --no-color] [--show-current]
-	[-v [--abbrev=<n> | --no-abbrev]]
-	[--column[=<options>] | --no-column] [--sort=<key>]
-	[--merged [<commit>]] [--no-merged [<commit>]]
-	[--contains [<commit>]] [--no-contains [<commit>]]
-	[--points-at <object>] [--format=<format>]
-	[(-r | --remotes) | (-a | --all)]
-	[--list] [<pattern>...]
-'git branch' [--track[=(direct|inherit)] | --no-track] [-f]
-	[--recurse-submodules] <branchname> [<start-point>]
-'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
-'git branch' --unset-upstream [<branchname>]
-'git branch' (-m | -M) [<oldbranch>] <newbranch>
-'git branch' (-c | -C) [<oldbranch>] <newbranch>
-'git branch' (-d | -D) [-r] <branchname>...
-'git branch' --edit-description [<branchname>]
+[synopsis]
+git branch [--color[=<when>] | --no-color] [--show-current]
+	   [-v [--abbrev=<n> | --no-abbrev]]
+	   [--column[=<options>] | --no-column] [--sort=<key>]
+	   [--merged [<commit>]] [--no-merged [<commit>]]
+	   [--contains [<commit>]] [--no-contains [<commit>]]
+	   [--points-at <object>] [--format=<format>]
+	   [(-r|--remotes) | (-a|--all)]
+	   [--list] [<pattern>...]
+git branch [--track[=(direct|inherit)] | --no-track] [-f]
+	   [--recurse-submodules] <branch-name> [<start-point>]
+git branch (--set-upstream-to=<upstream>|-u <upstream>) [<branch-name>]
+git branch --unset-upstream [<branch-name>]
+git branch (-m|-M) [<old-branch>] <new-branch>
+git branch (-c|-C) [<old-branch>] <new-branch>
+git branch (-d|-D) [-r] <branch-name>...
+git branch --edit-description [<branch-name>]
 
 DESCRIPTION
 -----------
@@ -49,173 +49,184 @@ With `--contains`, shows only the branches that contain the named commit
 named commit), `--no-contains` inverts it. With `--merged`, only branches
 merged into the named commit (i.e. the branches whose tip commits are
 reachable from the named commit) will be listed.  With `--no-merged` only
-branches not merged into the named commit will be listed.  If the <commit>
+branches not merged into the named commit will be listed.  If the _<commit>_
 argument is missing it defaults to `HEAD` (i.e. the tip of the current
 branch).
 
-The command's second form creates a new branch head named <branchname>
-which points to the current `HEAD`, or <start-point> if given. As a
-special case, for <start-point>, you may use `"A...B"` as a shortcut for
-the merge base of `A` and `B` if there is exactly one merge base. You
-can leave out at most one of `A` and `B`, in which case it defaults to
-`HEAD`.
+The command's second form creates a new branch head named _<branch-name>_
+which points to the current `HEAD`, or _<start-point>_ if given. As a
+special case, for _<start-point>_, you may use `<rev-A>...<rev-B>` as a
+shortcut for the merge base of _<rev-A>_ and _<rev-B>_ if there is exactly
+one merge base. You can leave out at most one of _<rev-A>_ and _<rev-B>_,
+in which case it defaults to `HEAD`.
 
 Note that this will create the new branch, but it will not switch the
-working tree to it; use "git switch <newbranch>" to switch to the
+working tree to it; use `git switch <new-branch>` to switch to the
 new branch.
 
 When a local branch is started off a remote-tracking branch, Git sets up the
 branch (specifically the `branch.<name>.remote` and `branch.<name>.merge`
-configuration entries) so that 'git pull' will appropriately merge from
+configuration entries) so that `git pull` will appropriately merge from
 the remote-tracking branch. This behavior may be changed via the global
 `branch.autoSetupMerge` configuration flag. That setting can be
 overridden by using the `--track` and `--no-track` options, and
 changed later using `git branch --set-upstream-to`.
 
-With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>.
-If <oldbranch> had a corresponding reflog, it is renamed to match
-<newbranch>, and a reflog entry is created to remember the branch
-renaming. If <newbranch> exists, -M must be used to force the rename
+With a `-m` or `-M` option, _<old-branch>_ will be renamed to _<new-branch>_.
+If _<old-branch>_ had a corresponding reflog, it is renamed to match
+_<new-branch>_, and a reflog entry is created to remember the branch
+renaming. If _<new-branch>_ exists, `-M` must be used to force the rename
 to happen.
 
 The `-c` and `-C` options have the exact same semantics as `-m` and
 `-M`, except instead of the branch being renamed, it will be copied to a
 new name, along with its config and reflog.
 
-With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
+With a `-d` or `-D` option, _<branch-name>_ will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
 has a reflog then the reflog will also be deleted.
 
 Use `-r` together with `-d` to delete remote-tracking branches. Note, that it
 only makes sense to delete remote-tracking branches if they no longer exist
-in the remote repository or if 'git fetch' was configured not to fetch
-them again. See also the 'prune' subcommand of linkgit:git-remote[1] for a
+in the remote repository or if `git fetch` was configured not to fetch
+them again. See also the `prune` subcommand of linkgit:git-remote[1] for a
 way to clean up all obsolete remote-tracking branches.
 
 
 OPTIONS
 -------
--d::
---delete::
+`-d`::
+`--delete`::
 	Delete a branch. The branch must be fully merged in its
 	upstream branch, or in `HEAD` if no upstream was set with
 	`--track` or `--set-upstream-to`.
 
--D::
+`-D`::
 	Shortcut for `--delete --force`.
 
---create-reflog::
+`--create-reflog`::
 	Create the branch's reflog.  This activates recording of
 	all changes made to the branch ref, enabling use of date
-	based sha1 expressions such as "<branchname>@\{yesterday}".
+	based sha1 expressions such as `<branch-name>@{yesterday}`.
 	Note that in non-bare repositories, reflogs are usually
 	enabled by default by the `core.logAllRefUpdates` config option.
 	The negated form `--no-create-reflog` only overrides an earlier
 	`--create-reflog`, but currently does not negate the setting of
 	`core.logAllRefUpdates`.
 
--f::
---force::
-	Reset <branchname> to <start-point>, even if <branchname> exists
-	already. Without `-f`, 'git branch' refuses to change an existing branch.
+`-f`::
+`--force`::
+	Reset _<branch-name>_ to _<start-point>_, even if _<branch-name>_ exists
+	already. Without `-f`, `git branch` refuses to change an existing branch.
 	In combination with `-d` (or `--delete`), allow deleting the
 	branch irrespective of its merged status, or whether it even
 	points to a valid commit. In combination with
 	`-m` (or `--move`), allow renaming the branch even if the new
 	branch name already exists, the same applies for `-c` (or `--copy`).
 +
-Note that 'git branch -f <branchname> [<start-point>]', even with '-f',
-refuses to change an existing branch `<branchname>` that is checked out
+Note that `git branch -f <branch-name> [<start-point>]`, even with `-f`,
+refuses to change an existing branch _<branch-name>_ that is checked out
 in another worktree linked to the same repository.
 
--m::
---move::
+`-m`::
+`--move`::
 	Move/rename a branch, together with its config and reflog.
 
--M::
+`-M`::
 	Shortcut for `--move --force`.
 
--c::
---copy::
+`-c`::
+`--copy`::
 	Copy a branch, together with its config and reflog.
 
--C::
+`-C`::
 	Shortcut for `--copy --force`.
 
---color[=<when>]::
+`--color[=<when>]`::
 	Color branches to highlight current, local, and
 	remote-tracking branches.
-	The value must be always (the default), never, or auto.
+	The value must be `always` (the default), `never`, or `auto`.
 
---no-color::
+`--no-color`::
 	Turn off branch colors, even when the configuration file gives the
 	default to color output.
 	Same as `--color=never`.
 
--i::
---ignore-case::
+`-i`::
+`--ignore-case`::
 	Sorting and filtering branches are case insensitive.
 
---omit-empty::
+`--omit-empty`::
 	Do not print a newline after formatted refs where the format expands
 	to the empty string.
 
---column[=<options>]::
---no-column::
+`--column[=<options>]`::
+`--no-column`::
 	Display branch listing in columns. See configuration variable
 	`column.branch` for option syntax. `--column` and `--no-column`
-	without options are equivalent to 'always' and 'never' respectively.
+	without options are equivalent to `always` and `never` respectively.
 +
 This option is only applicable in non-verbose mode.
 
--r::
---remotes::
-	List or delete (if used with -d) the remote-tracking branches.
+`--sort=<key>`::
+	Sort based on _<key>_. Prefix `-` to sort in descending
+	order of the value. You may use the `--sort=<key>` option
+	multiple times, in which case the last key becomes the primary
+	key. The keys supported are the same as those in linkgit:git-for-each-ref[1].
+	Sort order defaults to the value configured for the
+	`branch.sort` variable if it exists, or to sorting based on the
+	full refname (including `refs/...` prefix). This lists
+	detached `HEAD` (if present) first, then local branches and
+	finally remote-tracking branches. See linkgit:git-config[1].
+
+`-r`::
+`--remotes`::
+	List or delete (if used with `-d`) the remote-tracking branches.
 	Combine with `--list` to match the optional pattern(s).
 
--a::
---all::
+`-a`::
+`--all`::
 	List both remote-tracking branches and local branches.
 	Combine with `--list` to match optional pattern(s).
 
--l::
---list::
+`-l`::
+`--list`::
 	List branches.  With optional `<pattern>...`, e.g. `git
 	branch --list 'maint-*'`, list only the branches that match
 	the pattern(s).
 
---show-current::
-	Print the name of the current branch. In detached HEAD state,
+`--show-current`::
+	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
--v::
--vv::
---verbose::
+`-v`::
+`-vv`::
+`--verbose`::
 	When in list mode,
 	show sha1 and commit subject line for each head, along with
 	relationship to upstream branch (if any). If given twice, print
 	the path of the linked worktree (if any) and the name of the upstream
 	branch, as well (see also `git remote show <remote>`).  Note that the
-	current worktree's HEAD will not have its path printed (it will always
+	current worktree's `HEAD` will not have its path printed (it will always
 	be your current directory).
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Be more quiet when creating or deleting a branch, suppressing
 	non-error messages.
 
---abbrev=<n>::
+`--abbrev=<n>`::
 	In the verbose listing that show the commit object name,
-	show the shortest prefix that is at least '<n>' hexdigits
+	show the shortest prefix that is at least _<n>_ hexdigits
 	long that uniquely refers the object.
 	The default value is 7 and can be overridden by the `core.abbrev`
 	config option.
 
---no-abbrev::
+`--no-abbrev`::
 	Display the full sha1s in the output listing rather than abbreviating them.
 
--t::
---track[=(direct|inherit)]::
+`-t`::
+`--track[=(direct|inherit)]`::
 	When creating a new branch, set up `branch.<name>.remote` and
 	`branch.<name>.merge` configuration entries to set "upstream" tracking
 	configuration for the new branch. This
@@ -229,7 +240,7 @@ The exact upstream branch is chosen depending on the optional argument:
 itself as the upstream; `--track=inherit` means to copy the upstream
 configuration of the start-point branch.
 +
-The branch.autoSetupMerge configuration variable specifies how `git switch`,
+The `branch.autoSetupMerge` configuration variable specifies how `git switch`,
 `git checkout` and `git branch` should behave when neither `--track` nor
 `--no-track` are specified:
 +
@@ -238,106 +249,94 @@ were given whenever the start-point is a remote-tracking branch.
 `false` behaves as if `--no-track` were given. `always` behaves as though
 `--track=direct` were given. `inherit` behaves as though `--track=inherit`
 were given. `simple` behaves as though `--track=direct` were given only when
-the start-point is a remote-tracking branch and the new branch has the same
+the _<start-point>_ is a remote-tracking branch and the new branch has the same
 name as the remote branch.
 +
 See linkgit:git-pull[1] and linkgit:git-config[1] for additional discussion on
 how the `branch.<name>.remote` and `branch.<name>.merge` options are used.
 
---no-track::
+`--no-track`::
 	Do not set up "upstream" configuration, even if the
-	branch.autoSetupMerge configuration variable is set.
+	`branch.autoSetupMerge` configuration variable is set.
 
---recurse-submodules::
-	THIS OPTION IS EXPERIMENTAL! Causes the current command to
+`--recurse-submodules`::
+	THIS OPTION IS EXPERIMENTAL! Cause the current command to
 	recurse into submodules if `submodule.propagateBranches` is
 	enabled. See `submodule.propagateBranches` in
 	linkgit:git-config[1]. Currently, only branch creation is
 	supported.
 +
-When used in branch creation, a new branch <branchname> will be created
+When used in branch creation, a new branch _<branch-name>_ will be created
 in the superproject and all of the submodules in the superproject's
-<start-point>. In submodules, the branch will point to the submodule
-commit in the superproject's <start-point> but the branch's tracking
+_<start-point>_. In submodules, the branch will point to the submodule
+commit in the superproject's _<start-point>_ but the branch's tracking
 information will be set up based on the submodule's branches and remotes
 e.g. `git branch --recurse-submodules topic origin/main` will create the
 submodule branch "topic" that points to the submodule commit in the
 superproject's "origin/main", but tracks the submodule's "origin/main".
 
---set-upstream::
+`--set-upstream`::
 	As this option had confusing syntax, it is no longer supported.
 	Please use `--track` or `--set-upstream-to` instead.
 
--u <upstream>::
---set-upstream-to=<upstream>::
-	Set up <branchname>'s tracking information so <upstream> is
-	considered <branchname>'s upstream branch. If no <branchname>
+`-u <upstream>`::
+`--set-upstream-to=<upstream>`::
+	Set up _<branch-name>_'s tracking information so _<upstream>_ is
+	considered _<branch-name>_'s upstream branch. If no _<branch-name>_
 	is specified, then it defaults to the current branch.
 
---unset-upstream::
-	Remove the upstream information for <branchname>. If no branch
+`--unset-upstream`::
+	Remove the upstream information for _<branch-name>_. If no branch
 	is specified it defaults to the current branch.
 
---edit-description::
+`--edit-description`::
 	Open an editor and edit the text to explain what the branch is
 	for, to be used by various other commands (e.g. `format-patch`,
 	`request-pull`, and `merge` (if enabled)). Multi-line explanations
 	may be used.
 
---contains [<commit>]::
-	Only list branches which contain the specified commit (HEAD
+`--contains [<commit>]`::
+	Only list branches which contain _<commit>_ (`HEAD`
 	if not specified). Implies `--list`.
 
---no-contains [<commit>]::
-	Only list branches which don't contain the specified commit
-	(HEAD if not specified). Implies `--list`.
+`--no-contains [<commit>]`::
+	Only list branches which don't contain _<commit>_
+	(`HEAD` if not specified). Implies `--list`.
 
---merged [<commit>]::
-	Only list branches whose tips are reachable from the
-	specified commit (HEAD if not specified). Implies `--list`.
+`--merged [<commit>]`::
+	Only list branches whose tips are reachable from
+	_<commit>_ (`HEAD` if not specified). Implies `--list`.
 
---no-merged [<commit>]::
-	Only list branches whose tips are not reachable from the
-	specified commit (HEAD if not specified). Implies `--list`.
+`--no-merged [<commit>]`::
+	Only list branches whose tips are not reachable from
+	_<commit>_ (`HEAD` if not specified). Implies `--list`.
 
-<branchname>::
+`--points-at <object>`::
+	Only list branches of _<object>_.
+
+`--format <format>`::
+	A string that interpolates `%(fieldname)` from a branch ref being shown
+	and the object it points at.  _<format>_ is the same as
+	that of linkgit:git-for-each-ref[1].
+
+_<branch-name>_::
 	The name of the branch to create or delete.
 	The new branch name must pass all checks defined by
 	linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a branch name.
 
-<start-point>::
+_<start-point>_::
 	The new branch head will point to this commit.  It may be
 	given as a branch name, a commit-id, or a tag.  If this
-	option is omitted, the current HEAD will be used instead.
+	option is omitted, the current `HEAD` will be used instead.
 
-<oldbranch>::
+_<old-branch>_::
 	The name of an existing branch.  If this option is omitted,
 	the name of the current branch will be used instead.
 
-<newbranch>::
+_<new-branch>_::
 	The new name for an existing branch. The same restrictions as for
-	<branchname> apply.
-
---sort=<key>::
-	Sort based on the key given. Prefix `-` to sort in descending
-	order of the value. You may use the --sort=<key> option
-	multiple times, in which case the last key becomes the primary
-	key. The keys supported are the same as those in `git
-	for-each-ref`. Sort order defaults to the value configured for the
-	`branch.sort` variable if it exists, or to sorting based on the
-	full refname (including `refs/...` prefix). This lists
-	detached HEAD (if present) first, then local branches and
-	finally remote-tracking branches. See linkgit:git-config[1].
-
-
---points-at <object>::
-	Only list branches of the given object.
-
---format <format>::
-	A string that interpolates `%(fieldname)` from a branch ref being shown
-	and the object it points at.  The format is the same as
-	that of linkgit:git-for-each-ref[1].
+	_<branch-name>_ apply.
 
 CONFIGURATION
 -------------
@@ -374,7 +373,7 @@ $ git branch -D test                                    <2>
 ------------
 +
 <1> Delete the remote-tracking branches "todo", "html" and "man". The next
-    'fetch' or 'pull' will create them again unless you configure them not to.
+    `git fetch` or `git pullè will create them again unless you configure them not to.
     See linkgit:git-fetch[1].
 <2> Delete the "test" branch even if the "master" branch (or whichever branch
     is currently checked out) does not have all commits from the test branch.
@@ -386,8 +385,8 @@ $ git branch -r -l '<remote>/<pattern>'                 <1>
 $ git for-each-ref 'refs/remotes/<remote>/<pattern>'    <2>
 ------------
 +
-<1> Using `-a` would conflate <remote> with any local branches you happen to
-    have been prefixed with the same <remote> pattern.
+<1> Using `-a` would conflate _<remote>_ with any local branches you happen to
+    have been prefixed with the same _<remote>_ pattern.
 <2> `for-each-ref` can take a wide range of options. See linkgit:git-for-each-ref[1]
 
 Patterns will normally need quoting.
@@ -396,24 +395,24 @@ NOTES
 -----
 
 If you are creating a branch that you want to switch to immediately,
-it is easier to use the "git switch" command with its `-c` option to
+it is easier to use the `git switch` command with its `-c` option to
 do the same thing with a single command.
 
 The options `--contains`, `--no-contains`, `--merged` and `--no-merged`
 serve four related but different purposes:
 
 - `--contains <commit>` is used to find all branches which will need
-  special attention if <commit> were to be rebased or amended, since those
-  branches contain the specified <commit>.
+  special attention if _<commit>_ were to be rebased or amended, since those
+  branches contain the specified _<commit>_.
 
 - `--no-contains <commit>` is the inverse of that, i.e. branches that don't
-  contain the specified <commit>.
+  contain the specified _<commit>_.
 
 - `--merged` is used to find all branches which can be safely deleted,
-  since those branches are fully contained by HEAD.
+  since those branches are fully contained by `HEAD`.
 
 - `--no-merged` is used to find branches which are candidates for merging
-  into HEAD, since those branches are not fully contained by HEAD.
+  into `HEAD`, since those branches are not fully contained by `HEAD`.
 
 include::ref-reachability-filters.adoc[]
 
@@ -422,8 +421,8 @@ SEE ALSO
 linkgit:git-check-ref-format[1],
 linkgit:git-fetch[1],
 linkgit:git-remote[1],
-link:user-manual.html#what-is-a-branch[``Understanding history: What is
-a branch?''] in the Git User's Manual.
+link:user-manual.html#what-is-a-branch["Understanding history: What is
+a branch?"] in the Git User's Manual.
 
 GIT
 ---
-- 
gitgitgadget
