Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C151E3DC8
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914420; cv=none; b=sDov0zsurVwyUTEKvSCWEyV1fCu9r7Pp2LiTf2rJj0qL56z6lVHLCwQDemcSpbSsnyg1aEQM5o2Dd/nAQJav6K8VwLpMMnOyKlD/v8627z8bLFzK8QvtpsscJ5LSbooYxLqWd/QnANJZVcE7kj0GPG5VcYfLNpRzgLfEqAvYvh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914420; c=relaxed/simple;
	bh=rm/qwvO1xjx7m+wN6f0VjZ4GFyd6nyn7jD5B3Codr7w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=O9dr8SygCTOTM2Q10RL6sa5Fkwtb3zXTuAzLNpdlN2uu2Gg+zrNIg4tX4E6FjGAfgrBLkeFOGMwSvAtHhJIBZy48pTAjF3pASkC1nlK6E7ioKblmQwzF8BSd876eCvlUjE7jNpxZfGaWMrK8UHYgoNZJdIfPXYx3CFyOBuwf5AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXPLdyrY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXPLdyrY"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4537fdec33bso22099295e9.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751914416; x=1752519216; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSsLs8SOT6SV/JMMHXjxTtBPaLyVLjNwekcPZu3xVCE=;
        b=mXPLdyrYGRgGOTK9iyOK8jYBmGH9AzleDuXCyUhtdWQhOxJIcjSJqryeduWWMUFIDH
         3/3+vUSsCqPk0BX+VG0ofR4UbQi2LjI/BvqArFYHA6/85pIkAY1wMu0JkqSD/xHs+7VJ
         c5v03sW2gFVnPZDYVj2xeg86Lm0M8OPM82IUK+ZEIInuF5PZHsQL3MbTpwqedwEGFc0U
         F5zhnoSLl2Lo28a4aynWeG+KKaAOzIn9QZ0od/bpWMDMUlwhOTbGKvRl1KRLnJxVVyjI
         ZuAjWgVMvVQtnPATZ7SziYgo7w3agLb0IONHyYdyGXJdnwktxp0Q4/n/LsgXDrv5qsf4
         1LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751914416; x=1752519216;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSsLs8SOT6SV/JMMHXjxTtBPaLyVLjNwekcPZu3xVCE=;
        b=xC6avooeAQ3uFAgTzJDY+lNiC99fLzsstX/o8UYh6QJUcTQqnUh9qeULFQywUr1izv
         VM7+qS7FRaB7E8h6qbeoGLyqYQEC6OyZVleMv3Otd0oHm6zfA35c6wNwGipzI2m6mk67
         zgq6MshEsVoglKftMDwtLiXeiBZsAJfobr/A5E6FCTB6wMy4QXJPoRyOwSELEIzp3YUi
         m8yrzgnjW6UmLm9bJqzFzgS1STYStvkX51s/hMNwyo4SjWofajsBpqKKe48gKgCuiNl+
         yTboS1DcsNnM0tRFD6r6hO7NQRTqBaWdGLU340GfxyNrrNqRCZ9/93Byf96QUNk27KcR
         2cmw==
X-Gm-Message-State: AOJu0YwQLCKJfHMZVwmRqGliNXKEHFE7rUNRod2nj1JrvQVcOFpz7qor
	Bs29TQ2M6L4haF2jgSOzJXFic1mt34ldoFGKXPlusK0i2TSfdkpTeRZ25hkw3g==
X-Gm-Gg: ASbGncv4kPZoLS/BVdWS+xxkta3DjHTvlKHd9fNPCN5vMDn1pq0PeHSNkANoOqV13AB
	cpBgPs7pZXsgYiQ0m+RolhFVdDAW78t4roYc9uoBRWFkEAGCrUg7VOYYb3hWRKko6Cyqu9vKcng
	KvNUJqDqGjujMji8UYSYU7Lk6mhOwSuE5Vn/aNvbKvqBsK/ABsjKBJI2XM+sZw1oO7HeWO8Phze
	D+igOWJcW/0ToiHg3yzIFhsHofkACDd/+DMXhZmOIlbG9yuHOYAn7bT9dQ7Kiog9n+oVhsnlZMa
	+8zmOeYiIvnb7opyDJcsN2u8YnfNR5kp2gSNm2f8x+vvQ2JTOXdoogCpfjIV+VI=
X-Google-Smtp-Source: AGHT+IHuYz0+zKLLRBDOBVY0b1foVSQhLBXp+vDKAWY1cQBW3jLsTqcFbw/dMrs4X2O17Ls9jAPQiA==
X-Received: by 2002:a05:600c:4706:b0:454:a37a:db67 with SMTP id 5b1f17b1804b1-454b4ead1c5mr140574935e9.17.1751914416034;
        Mon, 07 Jul 2025 11:53:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd397053sm364285e9.3.2025.07.07.11.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:53:35 -0700 (PDT)
Message-Id: <10ea4ad1cbe237754008ed0409aedb4d576eb0d8.1751914412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
References: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
	<pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Jul 2025 18:53:24 +0000
Subject: [PATCH v3 1/9] doc: convert git-log to new documentation format
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

We also transform inline descriptions of possible values of option
--decorate into a list, which is more readable and extensible.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-log.adoc | 86 ++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 40 deletions(-)

diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
index ae8a7e2d6389..b6f3d92c435f 100644
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
@@ -27,28 +27,34 @@ each commit introduces are shown.
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
-	`log.excludeDecoration` config option allows excluding refs from
+	matches any of the _<pattern>_ parameters given to
+	`--decorate-refs-exclude` or if it doesn't match any of the
+	_<pattern>_ parameters given to `--decorate-refs`.
+	The `log.excludeDecoration` config option allows excluding refs from
 	the decorations, but an explicit `--decorate-refs` pattern will
 	override a match in `log.excludeDecoration`.
 +
@@ -56,51 +62,51 @@ If none of these options or config settings are given, then references are
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
@@ -145,14 +151,14 @@ EXAMPLES
 
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
@@ -164,7 +170,7 @@ EXAMPLES
 `git log --branches --not --remotes=origin`::
 
 	Shows all commits that are in any of local branches but not in
-	any of remote-tracking branches for 'origin' (what you have that
+	any of remote-tracking branches for `origin` (what you have that
 	origin doesn't).
 
 `git log master --not --remotes=*/master`::
@@ -200,11 +206,11 @@ CONFIGURATION
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

