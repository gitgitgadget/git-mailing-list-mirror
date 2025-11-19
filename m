Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD2B301034
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588413; cv=none; b=Zwd6hy+Qml5xbsWuPG0wBuc1sYEjP2nA3+PNJl7EUB796MtluSaWwyLhbM2wYxopjr9aejyxaCy1unHlTYJWRaLzTYMJP+BFOySked6fSKJKid/+MnZ6kjV4gnmvI8/Dl1xvwaw/UsbgNsdCbku8MPF/Wop0nElyslFxSjAyyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588413; c=relaxed/simple;
	bh=UnLFH4RHaWy9vjh3iNDcuKYWcq0fQWyaNrOfHc/o6WA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=MKh/buwSPccUhkdrblzZ28Ps+zOrmjcNFQYli+GVRgaO+PQ/9fz8++AC+itbioNeE/pPRnqjX/gHpz7RzS8PrmTC7GkYuFabaZFQz4YunWFqmMaCVWlHXKCKXl+UKfPMMUjN8P1gh7V+TNmz4OXMyzEMYVRved9lpksEI9zGYfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N77mSYOn; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N77mSYOn"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-948614ceac0so9924839f.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 13:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763588411; x=1764193211; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHadoC9rc9lrfdpfSfUpGNrizrm31pZAEep5XpzUwUI=;
        b=N77mSYOnHQ1Mp3RqV9r+BPrLrB7jbNftdY3rweFIvupYMen0wEpK/FCk3RGiIbOhY9
         CeBpo8REXNJQD2yiGYMC5O9ek6q4IRbsJvlI7MRA80QcFeE5uwYeaEhH/roH55mf7oMV
         kQiuTTRdgicuNGaojvDawcrJDVU5bjbJ058WGdB3Ma5PhkmgAnTeX17qlapu3jg4xQHo
         k4uV8qBSv6NIzuCSJC4iIzodqj/DzqijjcwKh0Khgur1CzBmjnpaGes3bJjbHBCtZtpr
         PPjvNw9w8ew1ANJJJae1dXbSiDuzbR/wmpN4NNlciZZB7zMoyEInJymIUuFcXDbXIDNO
         OiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588411; x=1764193211;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fHadoC9rc9lrfdpfSfUpGNrizrm31pZAEep5XpzUwUI=;
        b=Dx1WDScPYU/5GpEJWdUkHcwaSBMWFponOuIfud4bJiKAj9CLpeetZRP1GgUZfF4VLF
         OQSoC3j674jwwJ0AyBSFgeLFWvyfmpNf5mmDqUfGsnHfXUamnGTVatkPmvxCvgiu1zrK
         Q22ScJF+gVtTEf3azLc1l2DJ5CgKAQlFrwwhZjFFw004M1YbudzYPhGeu0Fv9XuSGthv
         4RemfnM9QFWg/zqB4iiyXlf4wGC0yk61Fr05ohvsl/UdSpAfRdmRvLDuJCx5pYZ2ZfcX
         GOZOBJxklqSKxikfgiR0aYalnGEcqTM/UorClv/80i6ZbrCgfIffSBjiGiST10fr1CCT
         bYog==
X-Gm-Message-State: AOJu0YxYB628MNBAXlxEjXooKyU4OYTgP0N3d8WkovBEOWJSqX2MMmuG
	3uCuB5+oWWmJaGxex2yCA1OthxsamjOvz6cuT5qo0yzyh02cKZpHKcDfhU/KVw==
X-Gm-Gg: ASbGncsdYa1qXhtn9vz/mnOk/Oj7I5af1iwNs6yci2s0dhbr+SaADRc6FW4x+EwU1/8
	7FCmW2q0ncFkS6gcMA0EQRKgXE8FiH04Gvsf/4vvSnil0ZfFAJmYZEsWA08FpNl7e/Vdjp9/AmW
	c01UD4Qg/1WXhmcgzlf8sThbqedLBNXRJ9ahYaUPVFZJ5DFSokuVVxqK0peVanzystJMHd3jkJ1
	mdKtzwkB/a+HhBo0ftJYalUHEy51S4ynSD6mdeBGMdhuitsG4DdSjkcnVpAhjoAJCGBy4vUV2Vt
	BJ25gnMRr1QHvLCSmY7VGNvbgqLmirs/cC3xQ2cw9/KWvgh0WsXK5jG9PNO3Vxo1MNsev5yiUn8
	5MfivpDOUuJP9yydMHbPjREVY/GHquxEpAajVKnpPjhzlWQFraWLyQRvx0PnTK3PP83paB/Q3tb
	4w6oTYgxVGzUYaoLp1ML7jRKI=
X-Google-Smtp-Source: AGHT+IEqhDM+jT1hnyWHIVZ41KsFzuyuVO18rPKyGjt0sxd+AphQ6x068tXl7572BuqFpzO0Zp6ccA==
X-Received: by 2002:a05:6638:c74b:10b0:576:e293:ee7e with SMTP id 8926c6da1cb9f-5b955d8c95emr165795173.11.1763588410533;
        Wed, 19 Nov 2025 13:40:10 -0800 (PST)
Received: from [127.0.0.1] ([64.236.134.50])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b48ebcsm171844173.51.2025.11.19.13.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 13:40:10 -0800 (PST)
Message-Id: <5b1e64bdf83e04998225f1716f927bfc9e77dc80.1763588404.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.git.1763588404.gitgitgadget@gmail.com>
References: <pull.2002.git.1763588404.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Nov 2025 21:40:03 +0000
Subject: [PATCH 2/3] doc: convert git pull to synopsis style
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

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/fetch-options.adoc | 10 +++---
 Documentation/git-pull.adoc      | 61 ++++++++++++++++----------------
 Documentation/merge-options.adoc |  2 +-
 Documentation/urls-remotes.adoc  |  4 +--
 4 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 35a84a1ef2..fcba46ee9e 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -71,7 +71,7 @@ configuration variables documented in linkgit:git-config[1], and the
 
 `--negotiate-only`::
 	Do not fetch anything from the server, and instead print the
-	ancestors of the provided `--negotiation-tip=*` arguments,
+	ancestors of the provided `--negotiation-tip=` arguments,
 	which we have in common with the server.
 +
 This is incompatible with `--recurse-submodules=(yes|on-demand)`.
@@ -126,7 +126,7 @@ ifndef::git-pull[]
 `--auto-gc`::
 `--no-auto-gc`::
 	Run `git maintenance run --auto` at the end to perform automatic
-	repository maintenance if needed. (`--[no-]auto-gc` is a synonym.)
+	repository maintenance if needed.
 	This is enabled by default.
 
 `--write-commit-graph`::
@@ -193,7 +193,7 @@ endif::git-pull[]
 	specified refspec (can be given more than once) to map the
 	refs to remote-tracking branches, instead of the values of
 	`remote.<name>.fetch` configuration variables for the remote
-	repository.  Providing an empty `<refspec>` to the
+	repository.  Providing an empty _<refspec>_ to the
 	`--refmap` option causes Git to ignore the configured
 	refspecs and rely entirely on the refspecs supplied as
 	command-line arguments. See section on "Configured Remote-tracking
@@ -204,7 +204,7 @@ endif::git-pull[]
 	Fetch all tags from the remote (i.e., fetch remote tags
 	`refs/tags/*` into local tags with the same name), in addition
 	to whatever else would otherwise be fetched.  Using this
-	option alone does not subject tags to pruning, even if --prune
+	option alone does not subject tags to pruning, even if `--prune`
 	is used (though tags may be pruned anyway if they are also the
 	destination of an explicit refspec; see `--prune`).
 
@@ -306,7 +306,7 @@ endif::git-pull[]
 `-o <option>`::
 `--server-option=<option>`::
 	Transmit the given string to the server when communicating using
-	protocol version 2.  The given string must not contain a NUL or LF
+	protocol version 2.  The given string must not contain a _NUL_ or _LF_
 	character.  The server's handling of server options, including
 	unknown ones, is server-specific.
 	When multiple `--server-option=<option>` are given, they are all
diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index cd3bbc90e3..248f6c3f39 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -8,8 +8,8 @@ git-pull - Fetch from and integrate with another repository or a local branch
 
 SYNOPSIS
 --------
-[verse]
-'git pull' [<options>] [<repository> [<refspec>...]]
+[synopsis]
+git pull [<options>] [<repository> [<refspec>...]]
 
 
 DESCRIPTION
@@ -43,7 +43,7 @@ want to handle, you can safely abort it with `git merge --abort` or `git
 OPTIONS
 -------
 
-<repository>::
+_<repository>_::
 	The "remote" repository to pull from.  This can be either
 	a URL (see the section <<URLS,GIT URLS>> below) or the name
 	of a remote (see the section <<REMOTES,REMOTES>> below).
@@ -52,29 +52,29 @@ Defaults to the configured upstream for the current branch, or `origin`.
 See <<UPSTREAM-BRANCHES,UPSTREAM BRANCHES>> below for more on how to
 configure upstreams.
 
-<refspec>::
+_<refspec>_::
 	Which branch or other reference(s) to fetch and integrate into the
 	current branch, for example `main` in `git pull origin main`.
 	Defaults to the configured upstream for the current branch.
 +
 This can be a branch, tag, or other collection of reference(s).
-See <<fetch-refspec,<refspec>>> below under "Options related to fetching"
+See <<fetch-refspec,_<refspec>_>> below under "Options related to fetching"
 for the full syntax, and <<DEFAULT-BEHAVIOUR,DEFAULT BEHAVIOUR>> below
 for how `git pull` uses this argument to determine which remote branch
 to integrate.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	This is passed to both underlying git-fetch to squelch reporting of
 	during transfer, and underlying git-merge to squelch output during
 	merging.
 
--v::
---verbose::
-	Pass --verbose to git-fetch and git-merge.
+`-v`::
+`--verbose`::
+	Pass `--verbose` to git-fetch and git-merge.
 
---recurse-submodules[=(yes|on-demand|no)]::
---no-recurse-submodules::
+`--recurse-submodules[=(yes|on-demand|no)]`::
+`--no-recurse-submodules`::
 	This option controls if new commits of populated submodules should
 	be fetched, and if the working trees of active submodules should be
 	updated, too (see linkgit:git-fetch[1], linkgit:git-config[1] and
@@ -91,21 +91,20 @@ Options related to merging
 
 include::merge-options.adoc[]
 
--r::
---rebase[=(false|true|merges|interactive)]::
-	When true, rebase the current branch on top of the upstream
+`-r`::
+`--rebase[=(true|merges|false|interactive)]`::
+`true`;; rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
 	was rebased since last fetched, the rebase uses that information
-	to avoid rebasing non-local changes.
-+
-When set to `merges`, rebase using `git rebase --rebase-merges` so that
+	to avoid rebasing non-local changes. This is the default.
+
+`merges`;; rebase using `git rebase --rebase-merges` so that
 the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
-+
-When false, merge the upstream branch into the current branch.
-+
-When `interactive`, enable the interactive mode of rebase.
+`false`;; merge the upstream branch into the current branch.
+`interactive`;; enable the interactive mode of rebase.
+
 +
 See `pull.rebase`, `branch.<name>.rebase` and `branch.autoSetupRebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
@@ -117,8 +116,8 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
---no-rebase::
-	This is shorthand for --rebase=false.
+`--no-rebase`::
+	This is shorthand for `--rebase=false`.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -178,7 +177,7 @@ uses the refspec from the configuration or
 rules apply:
 
 . If `branch.<name>.merge` configuration for the current
-  branch `<name>` exists, that is the name of the branch at the
+  branch _<name>_ exists, that is the name of the branch at the
   remote site that is merged.
 
 . If the refspec is a globbing one, nothing is merged.
@@ -198,9 +197,9 @@ $ git pull
 $ git pull origin
 ------------------------------------------------
 +
-Normally the branch merged in is the HEAD of the remote repository,
-but the choice is determined by the branch.<name>.remote and
-branch.<name>.merge options; see linkgit:git-config[1] for details.
+Normally the branch merged in is the `HEAD` of the remote repository,
+but the choice is determined by the `branch.<name>.remote` and
+`branch.<name>.merge` options; see linkgit:git-config[1] for details.
 
 * Merge into the current branch the remote branch `next`:
 +
@@ -208,7 +207,7 @@ branch.<name>.merge options; see linkgit:git-config[1] for details.
 $ git pull origin next
 ------------------------------------------------
 +
-This leaves a copy of `next` temporarily in FETCH_HEAD, and
+This leaves a copy of `next` temporarily in `FETCH_HEAD`, and
 updates the remote-tracking branch `origin/next`.
 The same can be done by invoking fetch and merge:
 +
@@ -219,14 +218,14 @@ $ git merge origin/next
 
 
 If you tried a pull which resulted in complex conflicts and
-would want to start over, you can recover with 'git reset'.
+would want to start over, you can recover with `git reset`.
 
 
 include::transfer-data-leaks.adoc[]
 
 BUGS
 ----
-Using --recurse-submodules can only fetch new commits in already checked
+Using `--recurse-submodules` can only fetch new commits in already checked
 out submodules right now. When e.g. upstream added a new submodule in the
 just fetched commits of the superproject the submodule itself cannot be
 fetched, making it impossible to check out that submodule later without
diff --git a/Documentation/merge-options.adoc b/Documentation/merge-options.adoc
index 9d433265b2..952cb85e9a 100644
--- a/Documentation/merge-options.adoc
+++ b/Documentation/merge-options.adoc
@@ -56,7 +56,7 @@ ifdef::git-pull[]
 `--ff-only`::
 	Only update to the new history if there is no divergent local
 	history.  This is the default when no method for reconciling
-	divergent histories is provided (via the --rebase=* flags).
+	divergent histories is provided (via the `--rebase` flags).
 
 `--ff`::
 `--no-ff`::
diff --git a/Documentation/urls-remotes.adoc b/Documentation/urls-remotes.adoc
index 068b3ee4a6..6878bbe093 100644
--- a/Documentation/urls-remotes.adoc
+++ b/Documentation/urls-remotes.adoc
@@ -76,7 +76,7 @@ _<URL>_ is required; `#<head>` is optional.
 
 Depending on the operation, git will use one of the following
 refspecs, if you don't provide one on the command line.
-_<branch> is the name of this file in `$GIT_DIR/branches` and
+_<branch>_ is the name of this file in `$GIT_DIR/branches` and
 _<head>_ defaults to `master`.
 
 git fetch uses:
@@ -111,7 +111,7 @@ Git defaults to using the upstream branch for remote operations, for example:
   'origin/main' have diverged, and have 2 and 3 different commits each
   respectively".
 
-The upstream is stored in `.git/config`, in the "remote" and "merge"
+The upstream is stored in `.git/config`, in the "`remote`" and "`merge`"
 fields. For example, if `main`'s upstream is `origin/main`:
 
 ------------
-- 
gitgitgadget

