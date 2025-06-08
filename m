Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B21F4C85
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749373793; cv=none; b=sDiLEhwIrse9NOIQ+BkFhCaPeVbGFnptvLcEq9gKI3aXgsP6OgiEO5OYHx6J/y/F7URqm/k651cLquUk6lmnnTfLEyP/bGq7eUDGtXS3LQNpV6nn4yD/QUcjt+cqOf0Y94Ycg/cSnMzKjdx/85uJsU9oeUDKdfAAtlFE3OhIztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749373793; c=relaxed/simple;
	bh=wq0mNY8ggTPJaK3nkURLICZ5n2hFoQofBU5GvQ4ryXk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=SvK7418OW7s+3D4WwGgpSFRg765/GNTQwjIqmxbOjP4lF+HvA/FyFDoFluKUHhvAvNTgemGJRLjqwCSEtrLgOXaMy/fHUNbepBQVEFjrxFVQXiRSk6v3j9VDmJdAGyznTe9H0lmQPmEef3v/TUakcG3EeB52VssuAe0JwUTReK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcd6/vvj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcd6/vvj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so22702615e9.1
        for <git@vger.kernel.org>; Sun, 08 Jun 2025 02:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749373790; x=1749978590; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B68+PmD463ok3WslIDaIPfVJjqONSoI490P06Nq8W9A=;
        b=kcd6/vvjQmLx0nhXlk84gBhwli/pM5VSRhE2w5dWEXKC77uZO+rDvw3VXWMBtilVAu
         pyV34g7lOHF6Blqwz57wiYuwTA1Krl/8WINSsCIgeSbEkcu+aKNreFiYHKRPpFU+Ho2P
         m9JLcM8R4w2lDT9IThRsTJiKWQoXBs0WEHPO551ASMjimWaOjCFEEKILzAnFLX9onfTN
         +9TZUHte90Lq1NsgMi177TXe3KOXKYy3vRmzZFy7FIoXpdbJgT3vj8NUoLXa35oZp4Sl
         RfqKHLEt6Hxk0mMWz06H55ws8UgiaQTheF+GHTyRoDggwmWOoWC++UEnou8akyfaEgqL
         zEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749373790; x=1749978590;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B68+PmD463ok3WslIDaIPfVJjqONSoI490P06Nq8W9A=;
        b=l2LDWJ7mlxC0tU8n5rGMo95ddpMbGUPQFg04FgfgdlFgFAt25Gi7c1owoVzOOCsm1V
         D6V1obvGbQBZYw3oAd/YTHlu5imhBMqMcFtK2ZGDLYLPYWxwV9FcYFonOyrJDw5nHFG7
         LJ6elEc6oE9pHXtLyFYDT9SqrlsWWSogSQ7Md8VUCHVcn1SBF+KsipsoJQcfdY2eCwGe
         wEicGJt+zJLNTIff7smFO0WEAXVQ8mV/gOOOX2u1TignkxUYsHZwou3lEdhNyTZ8/xpA
         jwyXi3Y6uTcTJ+g7wMUgNzbyL8hXvtQx1kQnvKrTVNLze4+YUz4QOStBP+XSX/npgcT9
         YDaQ==
X-Gm-Message-State: AOJu0YwxUO02WQAKIhKio1myldQYUIlVZVFzf7NywuF9rMrpEaliHKX9
	AA41P0WOe5L/k88SCKSB2Gf8L7/7fSxAvaWG7hlo4uDHao9PyF14BsC3cSui/A==
X-Gm-Gg: ASbGncuJbVodW79FwgX4D++2Tp8iktIdOi3+8o1tt7JQsjYE9FPZkJSLN44qYbtRLaI
	HUFLdXLr4SkVIfAXkCFaO7+2Oh9o0FzI5BYsroOTlCOC/DOdeUiJsCV0k7gWdfs+Ob1hONAo9MX
	L6UnDNgmkkB0oFHzoT5eP5yyowQYF57NmmlXecy2TTHoIO6iQ7FZILWpblfr7Q9Zz+JcGXj/wH8
	fmIlWE2tJcaKEUhtG3o23QvQDtKn1Wc+xeDcq1LaBJFm8lYPaIPN0usTqqp1Dob4/C5AK63Xwzz
	8mnH0ljj69+AbDzb8XRFkirRXcCxJSFwPg8k62AyJM0yTxcqN67Y4+iglwqwqnxm2JQx2ItjIQ=
	=
X-Google-Smtp-Source: AGHT+IGNDTsah5/Fxf9FRP8HoUfHhQD+nXSADnale4tYh3zVPsuNx8SaGA1lf0yHH5/lelL1FLdg+g==
X-Received: by 2002:a05:600c:6212:b0:43d:5ec:b2f4 with SMTP id 5b1f17b1804b1-45201350ea1mr108619445e9.10.1749373789537;
        Sun, 08 Jun 2025 02:09:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45307b9d827sm30599585e9.22.2025.06.08.02.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 02:09:48 -0700 (PDT)
Message-Id: <1ce06a184817d0493f4e56725aeb8ed5ccae1ba4.1749373787.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Jun 2025 09:09:38 +0000
Subject: [PATCH 1/9] doc: convert git-log to new documentation format
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
 Documentation/git-log.adoc | 83 ++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
index ae8a7e2d6389..654c3d397dff 100644
--- a/Documentation/git-log.adoc
+++ b/Documentation/git-log.adoc
@@ -8,8 +8,8 @@ git-log - Show commit logs
 
 SYNOPSIS
 --------
-[verse]
-'git log' [<options>] [<revision-range>] [[--] <path>...]
+[synopsis]
+git log [<options>] [<revision-range>] [[--] <path>...]
 
 DESCRIPTION
 -----------
@@ -27,27 +27,32 @@ each commit introduces are shown.
 OPTIONS
 -------
 
---follow::
+`--follow`::
 	Continue listing the history of a file beyond renames
 	(works only for a single file).
 
---no-decorate::
---decorate[=short|full|auto|no]::
-	Print out the ref names of any commits that are shown. If 'short' is
-	specified, the ref name prefixes 'refs/heads/', 'refs/tags/' and
-	'refs/remotes/' will not be printed. If 'full' is specified, the
-	full ref name (including prefix) will be printed. If 'auto' is
-	specified, then if the output is going to a terminal, the ref names
-	are shown as if 'short' were given, otherwise no ref names are
-	shown. The option `--decorate` is short-hand for `--decorate=short`.
-	Default to configuration value of `log.decorate` if configured,
-	otherwise, `auto`.
-
---decorate-refs=<pattern>::
---decorate-refs-exclude=<pattern>::
+`--no-decorate`::
+`--decorate[=(short|full|auto|no)]`::
+	Print out the ref names of any commits that are shown. Possible values
+	are:
++
+----
+`short`;; the ref name prefixes `refs/heads/`, `refs/tags/` and
+	`refs/remotes/` are not printed.
+`full`;; the full ref name (including prefix) is printed.
+`auto`:: if the output is going to a terminal, the ref names
+	are shown as if `short` were given, otherwise no ref names are
+	shown.
+----
++
+The option `--decorate` is short-hand for `--decorate=short`. Default to
+configuration value of `log.decorate` if configured, otherwise, `auto`.
+
+`--decorate-refs=<pattern>`::
+`--decorate-refs-exclude=<pattern>`::
 	For each candidate reference, do not use it for decoration if it
-	matches any patterns given to `--decorate-refs-exclude` or if it
-	doesn't match any of the patterns given to `--decorate-refs`. The
+	matches any of _<pattern>_ given to `--decorate-refs-exclude` or if it
+	doesn't match any of _<pattern>_ given to `--decorate-refs`. The
 	`log.excludeDecoration` config option allows excluding refs from
 	the decorations, but an explicit `--decorate-refs` pattern will
 	override a match in `log.excludeDecoration`.
@@ -56,51 +61,51 @@ If none of these options or config settings are given, then references are
 used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
 `refs/stash/`, or `refs/tags/`.
 
---clear-decorations::
+`--clear-decorations`::
 	When specified, this option clears all previous `--decorate-refs`
 	or `--decorate-refs-exclude` options and relaxes the default
 	decoration filter to include all references. This option is
 	assumed if the config value `log.initialDecorationSet` is set to
 	`all`.
 
---source::
+`--source`::
 	Print out the ref name given on the command line by which each
 	commit was reached.
 
---[no-]mailmap::
---[no-]use-mailmap::
+`--[no-]mailmap`::
+`--[no-]use-mailmap`::
 	Use mailmap file to map author and committer names and email
 	addresses to canonical real names and email addresses. See
 	linkgit:git-shortlog[1].
 
---full-diff::
+`--full-diff`::
 	Without this flag, `git log -p <path>...` shows commits that
 	touch the specified paths, and diffs about the same specified
 	paths.  With this, the full diff is shown for commits that touch
-	the specified paths; this means that "<path>..." limits only
+	the specified paths; this means that "`<path>...`" limits only
 	commits, and doesn't limit diff for those commits.
 +
 Note that this affects all diff-based output types, e.g. those
 produced by `--stat`, etc.
 
---log-size::
-	Include a line ``log size <number>'' in the output for each commit,
-	where <number> is the length of that commit's message in bytes.
+`--log-size`::
+	Include a line `log size <number>` in the output for each commit,
+	where _<number>_ is the length of that commit's message in bytes.
 	Intended to speed up tools that read log messages from `git log`
 	output by allowing them to allocate space in advance.
 
 include::line-range-options.adoc[]
 
-<revision-range>::
+_<revision-range>_::
 	Show only commits in the specified revision range.  When no
-	<revision-range> is specified, it defaults to `HEAD` (i.e. the
+	_<revision-range>_ is specified, it defaults to `HEAD` (i.e. the
 	whole history leading to the current commit).  `origin..HEAD`
 	specifies all the commits reachable from the current commit
 	(i.e. `HEAD`), but not from `origin`. For a complete list of
-	ways to spell <revision-range>, see the 'Specifying Ranges'
+	ways to spell _<revision-range>_, see the 'Specifying Ranges'
 	section of linkgit:gitrevisions[7].
 
-[--] <path>...::
+`[--] <path>...`::
 	Show only commits that are enough to explain how the files
 	that match the specified paths came to be.  See 'History
 	Simplification' below for details and other simplification
@@ -145,14 +150,14 @@ EXAMPLES
 
 `git log --since="2 weeks ago" -- gitk`::
 
-	Show the changes during the last two weeks to the file 'gitk'.
+	Show the changes during the last two weeks to the file `gitk`.
 	The `--` is necessary to avoid confusion with the *branch* named
-	'gitk'
+	`gitk`
 
 `git log --name-status release..test`::
 
-	Show the commits that are in the "test" branch but not yet
-	in the "release" branch, along with the list of paths
+	Show the commits that are in the "`test`" branch but not yet
+	in the "`release`" branch, along with the list of paths
 	each commit modifies.
 
 `git log --follow builtin/rev-list.c`::
@@ -164,7 +169,7 @@ EXAMPLES
 `git log --branches --not --remotes=origin`::
 
 	Shows all commits that are in any of local branches but not in
-	any of remote-tracking branches for 'origin' (what you have that
+	any of remote-tracking branches for `origin` (what you have that
 	origin doesn't).
 
 `git log master --not --remotes=*/master`::
@@ -200,11 +205,11 @@ CONFIGURATION
 See linkgit:git-config[1] for core variables and linkgit:git-diff[1]
 for settings related to diff generation.
 
-format.pretty::
+`format.pretty`::
 	Default for the `--format` option.  (See 'Pretty Formats' above.)
 	Defaults to `medium`.
 
-i18n.logOutputEncoding::
+`i18n.logOutputEncoding`::
 	Encoding to use when displaying logs.  (See 'Discussion' above.)
 	Defaults to the value of `i18n.commitEncoding` if set, and UTF-8
 	otherwise.
-- 
gitgitgadget

