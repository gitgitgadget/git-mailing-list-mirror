Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4C613A244
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722801947; cv=none; b=FglejzGzUdEI9OjFjBjqEq+IdlcRX9Zs+RtLlxWTSFnO3o/ZcK3YDoguroWY8pcO1D5C9krVlz1uUkHstjHwtTFLmzIYQwK7CO3hd84PH2NKNn5LjRWWMPgmcT5G5gecZIRCgTbOudHMXYi+5imcXRqMXd9AXOjaFJ/o2Lz+5tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722801947; c=relaxed/simple;
	bh=8uBydJKvF8ObTbXAaLqtr1JOR6mexdI9u8Da8vaZvws=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=CtdgBYHjEndLlvATZ02/ZWk9/64aYfhhm/65IhRPAwNBDZLph6TENmtulQ0zMi/LJhHjrhkmgX9l4k7HYaWtPTtQmmFybmA45gSZI91qX/LKkZO9cZp6o78jIMEDU8126uw3PCdfy0mcVx52/I1s8cHlzL39NvI8C2fIeZTACbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhXV46uW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhXV46uW"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so89210375e9.2
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 13:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722801943; x=1723406743; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeCBDq+OjHe9GbLH7ZzNCWXJq69WdpVGYIYtI/kv5+I=;
        b=ZhXV46uWZULA4MgY+6gIU8oqoFtiJv5S0iR7/FTKUp420I33DS1MpeCJoSwGdsYeu7
         obSg8rUcfKxc9yxoAoXj51YFWeAXB7ijdaqoTh/rVzjY2b2rOLJ0GsGrBWrAEOTkwZ7G
         bMAWEzbD6qvKyVoP6y8cvaCRsMttvr2hottyA7p1y32q4ydhguUClnFX+V9EKuklZR90
         Cty2CM7BFEI6AwkOSvR+3xXcOsM/fhj4uW8SRXs6R+BaNWbg9pNne/Dy2ca89Qvwmxrk
         rL4daGRd6vkfyBTrX8+RLzDjHqDTG/OsdUQ0/xJwnCRDseq/oBpq/hUDkecH1rIyG1y+
         KQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722801943; x=1723406743;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeCBDq+OjHe9GbLH7ZzNCWXJq69WdpVGYIYtI/kv5+I=;
        b=QlMAGhK1U73Cnq6O0ZO5VnKscRc/7HthHTUdjbGKWSR3Inj7meWR/85sDtIlJ11h4J
         UqXLtjGRNjrlrjFgvz8U3+ljWiAxEg1DC1dE34vavXrqdfRlwNlqXQ4mh2ocIYBEWt4C
         AR/0gnFWeJ0ouv9MEt2o3WC/GR5WD4vlqUBearKz8O1vC4iXMzPXUwC0x3Uu51nGCFHi
         fQqWv8CwAf+BRr1kZaanVU0Zp9KwUbL3e/gdKXMEfkAF6TVKbPDs9mBwR18upcVzXki6
         fPt0gJtyNOGQZCW1SvuEI/RltWIjZl1E2Ve9GaHI4w7NiGFxVjWktxNjtZQ0OdvwHKZJ
         0eNA==
X-Gm-Message-State: AOJu0YyTqWmDPkey1C/5pxg/0s5fJ0Ewxgj3nDI0JOv2N/62x7g+Uw8e
	mTfNgoC3rzVevwKxxMlres2f9Kfcgu+OxYEiDvfW752D+uPcHRvS/13deQ==
X-Google-Smtp-Source: AGHT+IGTzB0oEI42UsknYqg+RiYIgDtLseh63qh11XcZx5gaWHJjjQloRvqZR/1zhdGAzuwz7zeRhQ==
X-Received: by 2002:a05:600c:524e:b0:426:63f1:9a1b with SMTP id 5b1f17b1804b1-428e6b9547dmr79099825e9.33.1722801942835;
        Sun, 04 Aug 2024 13:05:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e06e98sm110698335e9.15.2024.08.04.13.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 13:05:42 -0700 (PDT)
Message-Id: <acb5bdda9046c5a49c6bb29bd822d8a09356a7ab.1722801936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Aug 2024 20:05:36 +0000
Subject: [PATCH 5/5]  doc: git-diff: apply format changes to config part
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

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/diff.txt | 160 +++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 190bda17e51..bdfc9e3c79a 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -1,18 +1,18 @@
-diff.autoRefreshIndex::
-	When using 'git diff' to compare with work tree
+`diff.autoRefreshIndex`::
+	When using `git diff` to compare with work tree
 	files, do not consider stat-only changes as changed.
 	Instead, silently run `git update-index --refresh` to
 	update the cached stat information for paths whose
 	contents in the work tree match the contents in the
 	index.  This option defaults to true.  Note that this
-	affects only 'git diff' Porcelain, and not lower level
-	'diff' commands such as 'git diff-files'.
+	affects only `git diff` Porcelain, and not lower level
+	`diff` commands such as '`git diff-files`.
 
-diff.dirstat::
+`diff.dirstat`::
 	A comma separated list of `--dirstat` parameters specifying the
 	default behavior of the `--dirstat` option to linkgit:git-diff[1]
 	and friends. The defaults can be overridden on the command line
-	(using `--dirstat=<param1,param2,...>`). The fallback defaults
+	(using ++--dirstat=++__<param1>__++,++__<param2>__...). The fallback defaults
 	(when not changed by `diff.dirstat`) are `changes,noncumulative,3`.
 	The following parameters are available:
 +
@@ -41,7 +41,7 @@ diff.dirstat::
 	Note that when using `cumulative`, the sum of the percentages
 	reported may exceed 100%. The default (non-cumulative) behavior can
 	be specified with the `noncumulative` parameter.
-<limit>;;
+_<limit>_;;
 	An integer parameter specifies a cut-off percent (3% by default).
 	Directories contributing less than this percentage of the changes
 	are not shown in the output.
@@ -52,57 +52,57 @@ directories with less than 10% of the total amount of changed files,
 and accumulating child directory counts in the parent directories:
 `files,10,cumulative`.
 
-diff.statNameWidth::
-	Limit the width of the filename part in --stat output. If set, applies
-	to all commands generating --stat output except format-patch.
+`diff.statNameWidth`::
+	Limit the width of the filename part in `--stat` output. If set, applies
+	to all commands generating `--stat` output except `format-patch`.
 
-diff.statGraphWidth::
-	Limit the width of the graph part in --stat output. If set, applies
-	to all commands generating --stat output except format-patch.
+`diff.statGraphWidth`::
+	Limit the width of the graph part in `--stat` output. If set, applies
+	to all commands generating `--stat` output except `format-patch`.
 
-diff.context::
-	Generate diffs with <n> lines of context instead of the default
-	of 3. This value is overridden by the -U option.
+`diff.context`::
+	Generate diffs with _<n>_ lines of context instead of the default
+	of 3. This value is overridden by the `-U` option.
 
-diff.interHunkContext::
+`diff.interHunkContext`::
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing the hunks that are close to each other.
 	This value serves as the default for the `--inter-hunk-context`
 	command line option.
 
-diff.external::
+`diff.external`::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
-	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF'
+	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF`
 	environment variable.  The command is called with parameters
 	as described under "git Diffs" in linkgit:git[1].  Note: if
 	you want to use an external diff program only on a subset of
 	your files, you might want to use linkgit:gitattributes[5] instead.
 
-diff.trustExitCode::
+`diff.trustExitCode`::
 	If this boolean value is set to true then the
 	`diff.external` command is expected to return exit code
 	0 if it considers the input files to be equal or 1 if it
-	considers them to be different, like `diff(1)`.
-	If it is set to false, which is the default, then the command
-	is expected to return exit code 0 regardless of equality.
+	considers them to be different, like `diff`(1).
+	If it is set to `false`, which is the default, then the command
+	is expected to return exit code `0` regardless of equality.
 	Any other exit code causes Git to report a fatal error.
 
-diff.ignoreSubmodules::
-	Sets the default value of --ignore-submodules. Note that this
-	affects only 'git diff' Porcelain, and not lower level 'diff'
-	commands such as 'git diff-files'. 'git checkout'
-	and 'git switch' also honor
+`diff.ignoreSubmodules`::
+	Sets the default value of `--ignore-submodules`. Note that this
+	affects only `git diff` Porcelain, and not lower level `diff`
+	commands such as `git diff-files`. `git checkout`
+	and `git switch` also honor
 	this setting when reporting uncommitted changes. Setting it to
-	'all' disables the submodule summary normally shown by 'git commit'
-	and 'git status' when `status.submoduleSummary` is set unless it is
-	overridden by using the --ignore-submodules command-line option.
-	The 'git submodule' commands are not affected by this setting.
+	`all` disables the submodule summary normally shown by `git commit`
+	and `git status` when `status.submoduleSummary` is set unless it is
+	overridden by using the `--ignore-submodules` command-line option.
+	The `git submodule` commands are not affected by this setting.
 	By default this is set to untracked so that any untracked
 	submodules are ignored.
 
-diff.mnemonicPrefix::
-	If set, 'git diff' uses a prefix pair that is different from the
+`diff.mnemonicPrefix`::
+	If set, `git diff` uses a prefix pair that is different from the
 	standard "a/" and "b/" depending on what is being compared.  When
 	this configuration is in effect, reverse diff output also swaps
 	the order of the prefixes:
@@ -117,102 +117,102 @@ diff.mnemonicPrefix::
 `git diff --no-index a b`;;
 	compares two non-git things (1) and (2).
 
-diff.noPrefix::
-	If set, 'git diff' does not show any source or destination prefix.
+`diff.noPrefix`::
+	If set, `git diff` does not show any source or destination prefix.
 
-diff.srcPrefix::
-	If set, 'git diff' uses this source prefix. Defaults to "a/".
+`diff.srcPrefix`::
+	If set, `git diff` uses this source prefix. Defaults to "a/".
 
-diff.dstPrefix::
-	If set, 'git diff' uses this destination prefix. Defaults to "b/".
+`diff.dstPrefix`::
+	If set, `git diff` uses this destination prefix. Defaults to "b/".
 
-diff.relative::
-	If set to 'true', 'git diff' does not show changes outside of the directory
+`diff.relative`::
+	If set to `true`, `git diff` does not show changes outside of the directory
 	and show pathnames relative to the current directory.
 
-diff.orderFile::
+`diff.orderFile`::
 	File indicating how to order files within a diff.
-	See the '-O' option to linkgit:git-diff[1] for details.
+	See the `-O` option to linkgit:git-diff[1] for details.
 	If `diff.orderFile` is a relative pathname, it is treated as
 	relative to the top of the working tree.
 
-diff.renameLimit::
+`diff.renameLimit`::
 	The number of files to consider in the exhaustive portion of
-	copy/rename detection; equivalent to the 'git diff' option
+	copy/rename detection; equivalent to the `git diff` option
 	`-l`.  If not set, the default value is currently 1000.  This
 	setting has no effect if rename detection is turned off.
 
-diff.renames::
-	Whether and how Git detects renames.  If set to "false",
-	rename detection is disabled. If set to "true", basic rename
-	detection is enabled.  If set to "copies" or "copy", Git will
+`diff.renames`::
+	Whether and how Git detects renames.  If set to `false`,
+	rename detection is disabled. If set to `true`, basic rename
+	detection is enabled.  If set to `copies` or `copy`, Git will
 	detect copies, as well.  Defaults to true.  Note that this
-	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
+	affects only `git diff` Porcelain like linkgit:git-diff[1] and
 	linkgit:git-log[1], and not lower level commands such as
 	linkgit:git-diff-files[1].
 
-diff.suppressBlankEmpty::
+`diff.suppressBlankEmpty`::
 	A boolean to inhibit the standard behavior of printing a space
-	before each empty output line. Defaults to false.
+	before each empty output line. Defaults to `false`.
 
-diff.submodule::
+`diff.submodule`::
 	Specify the format in which differences in submodules are
-	shown.  The "short" format just shows the names of the commits
-	at the beginning and end of the range. The "log" format lists
+	shown.  The `short` format just shows the names of the commits
+	at the beginning and end of the range. The `log` format lists
 	the commits in the range like linkgit:git-submodule[1] `summary`
-	does. The "diff" format shows an inline diff of the changed
-	contents of the submodule. Defaults to "short".
+	does. The `diff` format shows an inline diff of the changed
+	contents of the submodule. Defaults to `short`.
 
-diff.wordRegex::
+`diff.wordRegex`::
 	A POSIX Extended Regular Expression used to determine what is a "word"
 	when performing word-by-word difference calculations.  Character
 	sequences that match the regular expression are "words", all other
 	characters are *ignorable* whitespace.
 
-diff.<driver>.command::
+++diff.++__<driver>__++.command++::
 	The custom diff driver command.  See linkgit:gitattributes[5]
 	for details.
 
-diff.<driver>.trustExitCode::
+++diff.++__<driver>__++.trustExitCode++::
 	If this boolean value is set to true then the
-	`diff.<driver>.command` command is expected to return exit code
+	++diff.++__<driver>__++.command++ command is expected to return exit code
 	0 if it considers the input files to be equal or 1 if it
-	considers them to be different, like `diff(1)`.
+	considers them to be different, like `diff`(1).
 	If it is set to false, which is the default, then the command
 	is expected to return exit code 0 regardless of equality.
 	Any other exit code causes Git to report a fatal error.
 
-diff.<driver>.xfuncname::
+++diff.++__<driver>__++.xfuncname++::
 	The regular expression that the diff driver should use to
 	recognize the hunk header.  A built-in pattern may also be used.
 	See linkgit:gitattributes[5] for details.
 
-diff.<driver>.binary::
-	Set this option to true to make the diff driver treat files as
+++diff.++__<driver>__++.binary++::
+	Set this option to `true` to make the diff driver treat files as
 	binary.  See linkgit:gitattributes[5] for details.
 
-diff.<driver>.textconv::
+++diff.++__<driver>__++.textconv++::
 	The command that the diff driver should call to generate the
 	text-converted version of a file.  The result of the
 	conversion is used to generate a human-readable diff.  See
 	linkgit:gitattributes[5] for details.
 
-diff.<driver>.wordRegex::
+++diff.++__<driver>__++.wordRegex++::
 	The regular expression that the diff driver should use to
 	split words in a line.  See linkgit:gitattributes[5] for
 	details.
 
-diff.<driver>.cachetextconv::
+++diff.++__<driver>__++.cachetextconv++::
 	Set this option to true to make the diff driver cache the text
 	conversion outputs.  See linkgit:gitattributes[5] for details.
 
 include::../mergetools-diff.txt[]
 
-diff.indentHeuristic::
+`diff.indentHeuristic`::
 	Set this option to `false` to disable the default heuristics
 	that shift diff hunk boundaries to make patches easier to read.
 
-diff.algorithm::
+`diff.algorithm`::
 	Choose a diff algorithm.  The variants are as follows:
 +
 --
@@ -229,23 +229,23 @@ diff.algorithm::
 --
 +
 
-diff.wsErrorHighlight::
+`diff.wsErrorHighlight`::
 	Highlight whitespace errors in the `context`, `old` or `new`
 	lines of the diff.  Multiple values are separated by comma,
 	`none` resets previous values, `default` reset the list to
 	`new` and `all` is a shorthand for `old,new,context`.  The
 	whitespace errors are colored with `color.diff.whitespace`.
-	The command line option `--ws-error-highlight=<kind>`
+	The command line option ++--ws-error-highlight=++__<kind>__
 	overrides this setting.
 
-diff.colorMoved::
-	If set to either a valid `<mode>` or a true value, moved lines
+`diff.colorMoved`::
+	If set to either a valid _<mode>_ or a true value, moved lines
 	in a diff are colored differently, for details of valid modes
-	see '--color-moved' in linkgit:git-diff[1]. If simply set to
-	true the default color mode will be used. When set to false,
+	see `--color-moved` in linkgit:git-diff[1]. If simply set to
+	`true` the default color mode will be used. When set to `false`,
 	moved lines are not colored.
 
-diff.colorMovedWS::
+`diff.colorMovedWS`::
 	When moved lines are colored using e.g. the `diff.colorMoved` setting,
-	this option controls the `<mode>` how spaces are treated.
-	For details of valid modes see '--color-moved-ws' in linkgit:git-diff[1].
+	this option controls the _<mode>_ how spaces are treated.
+	For details of valid modes see `--color-moved-ws` in linkgit:git-diff[1].
-- 
gitgitgadget
