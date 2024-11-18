Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307611E8823
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731967564; cv=none; b=Ld2BX910t3UE+mOvhasFZreTmoYuf8n+nMy4Jwl1Eaxep4q8iUEpvYk4c3+T3d4KUmJfWIHbicGYjrSSvwZVz6KCF4fwG/RVXW79tECXHJDFrtDXHJE+dmfObJlXhCfRTG86RHMqEjYuQktrRzCtyYdqwCB0z7sz99VIpdhjcDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731967564; c=relaxed/simple;
	bh=eQaEgQYeAqAI9z/Ci4lldUMZfuqLo3ac4TPkBRZHgAc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=QrwXNd/mqTJiC8YNiVRQNNMCTIul2CVgqAullNppz7tyTc8fiRdXkO8wnHWnxIIXHJkN72Is1Pbjcgnw6aZUvJqbyibFtKDcQwKF0rCMV78hUewmYQXOrDcxfDTjw3cZqqPLJoJKAi/jIGEqchw76mvh/Kaaxow5+pYRfbuP+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDOBCCFe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDOBCCFe"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38232cebb0cso1961493f8f.1
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 14:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731967560; x=1732572360; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhumRkH1SLeEL/3fwKGELzg0e35VskpZ+nrbAYgQBGk=;
        b=WDOBCCFeJohlHkDG1QT2AztlSwDwPQkEGOyttlWNkF+I2sIN2bjkKbCKlTXNQn4gPH
         nFJ2fZHY+BZAgnNiloWKReu6ZVUiiuE7oeXIeWp5oiXb6B6Qd4PnPVJUnxBn9IOhf4sm
         QxQjDe+AHnKaEPdcOXeuLFiKHC52Peu+u6ZJfqgkQpvqDYFIbjLkWtA6BeVJRqxz6aQL
         3CwuOKvhd9sRJLr6hWP0dQQ29H4rJgUcXVD1uImYe1PB7WsRU5B7QWNM6SUa5Y4hZDAV
         Aak+H56XxBNI3IfSR+mXTlLn8wYpLabV22uFU4X5Hl1NONKc1MMIUM+4uzgg5P2JtKMR
         c/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731967560; x=1732572360;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhumRkH1SLeEL/3fwKGELzg0e35VskpZ+nrbAYgQBGk=;
        b=mp4ICx6wZ6b3CYddT7xsWTdsLDVjTvcIUavwAY8k+qa+074YBWso7hfSDdt1BNaAO0
         pOf8kwWy5RwunffCWx0m0Ugn+sJKvuyG+K9RMijuaZztIXxGJutn9SuHqR90GA3YOTmq
         RXoooNZDm23Rxd7bgdB9YbFmdj4LykevU9Nl378PfoNiEGqSL7L9H5H3jXbi3rSdRx79
         jm+m2UJUwwjVJwR7p8HEQBQtlUfbsHgow/Vqx3jhh5yyTjycAyy+8vZPLEKhmokBgAPR
         CqZNvCRsk9pBlGlmSHK5LhWa3r8gcdzZqIXcxiOAjA9IDpdF8uy1RsvfF6o1fSZMex85
         rv3Q==
X-Gm-Message-State: AOJu0YxAKkRxZIku7l4lx455wME7Ll39y6K3TCsbh6KBgYIt9z8deSZF
	eX5tG9grI28Zyv1uyn0toXcbAUd6QwL0Ac4K52dvv5hLq/wMJVouqOjzBw==
X-Google-Smtp-Source: AGHT+IFvHz/3kleE0/vUSAYx+dz6HZ9W9v4yAh4WoSE6GN4kpbnSZ1P61pckCTxDN8sRCDfwJ5bgsA==
X-Received: by 2002:a05:6000:1843:b0:382:4e57:48f8 with SMTP id ffacd0b85a97d-3824e574abamr385849f8f.43.1731967559974;
        Mon, 18 Nov 2024 14:05:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823d253773sm7244332f8f.36.2024.11.18.14.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 14:05:59 -0800 (PST)
Message-Id: <d350237eddbb19ee40395c2f59e0048b14ba223f.1731967553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
References: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
	<pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 Nov 2024 22:05:53 +0000
Subject: [PATCH v4 5/5] doc: git-diff: apply format changes to config part
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

By the way, we also change the sentences where git-diff would refer to
itself, so that no link is created in the HTML output.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/diff.txt | 204 ++++++++++++++++++----------------
 1 file changed, 111 insertions(+), 93 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 190bda17e51..45f3fe855c5 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -1,18 +1,25 @@
-diff.autoRefreshIndex::
-	When using 'git diff' to compare with work tree
+`diff.autoRefreshIndex`::
+	When using `git diff` to compare with work tree
 	files, do not consider stat-only changes as changed.
 	Instead, silently run `git update-index --refresh` to
 	update the cached stat information for paths whose
 	contents in the work tree match the contents in the
-	index.  This option defaults to true.  Note that this
-	affects only 'git diff' Porcelain, and not lower level
-	'diff' commands such as 'git diff-files'.
+	index.  This option defaults to `true`.  Note that this
+	affects only `git diff` Porcelain, and not lower level
+	`diff` commands such as `git diff-files`.
 
-diff.dirstat::
+`diff.dirstat`::
+ifdef::git-diff[]
+	A comma separated list of `--dirstat` parameters specifying the
+	default behavior of the `--dirstat` option to `git diff` and friends.
+endif::git-diff[]
+ifndef::git-diff[]
 	A comma separated list of `--dirstat` parameters specifying the
 	default behavior of the `--dirstat` option to linkgit:git-diff[1]
-	and friends. The defaults can be overridden on the command line
-	(using `--dirstat=<param1,param2,...>`). The fallback defaults
+	and friends.
+endif::git-diff[]
+	The defaults can be overridden on the command line
+	(using `--dirstat=<param>,...`). The fallback defaults
 	(when not changed by `diff.dirstat`) are `changes,noncumulative,3`.
 	The following parameters are available:
 +
@@ -41,7 +48,7 @@ diff.dirstat::
 	Note that when using `cumulative`, the sum of the percentages
 	reported may exceed 100%. The default (non-cumulative) behavior can
 	be specified with the `noncumulative` parameter.
-<limit>;;
+_<limit>_;;
 	An integer parameter specifies a cut-off percent (3% by default).
 	Directories contributing less than this percentage of the changes
 	are not shown in the output.
@@ -52,58 +59,58 @@ directories with less than 10% of the total amount of changed files,
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
-	If this boolean value is set to true then the
+`diff.trustExitCode`::
+	If this boolean value is set to `true` then the
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
-	standard "a/" and "b/" depending on what is being compared.  When
+`diff.mnemonicPrefix`::
+	If set, `git diff` uses a prefix pair that is different from the
+	standard `a/` and `b/` depending on what is being compared.  When
 	this configuration is in effect, reverse diff output also swaps
 	the order of the prefixes:
 `git diff`;;
@@ -112,111 +119,117 @@ diff.mnemonicPrefix::
 	 compares a (c)ommit and the (w)ork tree;
 `git diff --cached`;;
 	compares a (c)ommit and the (i)ndex;
-`git diff HEAD:file1 file2`;;
+`git diff HEAD:<file1> <file2>`;;
 	compares an (o)bject and a (w)ork tree entity;
-`git diff --no-index a b`;;
-	compares two non-git things (1) and (2).
+`git diff --no-index <a> <b>`;;
+	compares two non-git things _<a>_ and _<b>_.
 
-diff.noPrefix::
-	If set, 'git diff' does not show any source or destination prefix.
+`diff.noPrefix`::
+	If set, `git diff` does not show any source or destination prefix.
 
-diff.srcPrefix::
-	If set, 'git diff' uses this source prefix. Defaults to "a/".
+`diff.srcPrefix`::
+	If set, `git diff` uses this source prefix. Defaults to `a/`.
 
-diff.dstPrefix::
-	If set, 'git diff' uses this destination prefix. Defaults to "b/".
+`diff.dstPrefix`::
+	If set, `git diff` uses this destination prefix. Defaults to `b/`.
 
-diff.relative::
-	If set to 'true', 'git diff' does not show changes outside of the directory
+`diff.relative`::
+	If set to `true`, `git diff` does not show changes outside of the directory
 	and show pathnames relative to the current directory.
 
-diff.orderFile::
+`diff.orderFile`::
 	File indicating how to order files within a diff.
-	See the '-O' option to linkgit:git-diff[1] for details.
+ifdef::git-diff[]
+	See the `-O` option for details.
+endif::git-diff[]
+ifndef::git-diff[]
+	See the `-O` option to linkgit:git-diff[1] for details.
+endif::git-diff[]
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
-	detect copies, as well.  Defaults to true.  Note that this
-	affects only 'git diff' Porcelain like linkgit:git-diff[1] and
+`diff.renames`::
+	Whether and how Git detects renames.  If set to `false`,
+	rename detection is disabled. If set to `true`, basic rename
+	detection is enabled.  If set to `copies` or `copy`, Git will
+	detect copies, as well.  Defaults to `true`.  Note that this
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
+`diff.<driver>.command`::
 	The custom diff driver command.  See linkgit:gitattributes[5]
 	for details.
 
-diff.<driver>.trustExitCode::
-	If this boolean value is set to true then the
+`diff.<driver>.trustExitCode`::
+	If this boolean value is set to `true` then the
 	`diff.<driver>.command` command is expected to return exit code
 	0 if it considers the input files to be equal or 1 if it
-	considers them to be different, like `diff(1)`.
-	If it is set to false, which is the default, then the command
+	considers them to be different, like `diff`(1).
+	If it is set to `false`, which is the default, then the command
 	is expected to return exit code 0 regardless of equality.
 	Any other exit code causes Git to report a fatal error.
 
-diff.<driver>.xfuncname::
+`diff.<driver>.xfuncname`::
 	The regular expression that the diff driver should use to
 	recognize the hunk header.  A built-in pattern may also be used.
 	See linkgit:gitattributes[5] for details.
 
-diff.<driver>.binary::
-	Set this option to true to make the diff driver treat files as
+`diff.<driver>.binary`::
+	Set this option to `true` to make the diff driver treat files as
 	binary.  See linkgit:gitattributes[5] for details.
 
-diff.<driver>.textconv::
+`diff.<driver>.textconv`::
 	The command that the diff driver should call to generate the
 	text-converted version of a file.  The result of the
 	conversion is used to generate a human-readable diff.  See
 	linkgit:gitattributes[5] for details.
 
-diff.<driver>.wordRegex::
+`diff.<driver>.wordRegex`::
 	The regular expression that the diff driver should use to
 	split words in a line.  See linkgit:gitattributes[5] for
 	details.
 
-diff.<driver>.cachetextconv::
-	Set this option to true to make the diff driver cache the text
+`diff.<driver>.cachetextconv`::
+	Set this option to `true` to make the diff driver cache the text
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
-`default`, `myers`;;
+`default`;;
+`myers`;;
 	The basic greedy diff algorithm. Currently, this is the default.
 `minimal`;;
 	Spend extra time to make sure the smallest possible diff is
@@ -229,7 +242,7 @@ diff.algorithm::
 --
 +
 
-diff.wsErrorHighlight::
+`diff.wsErrorHighlight`::
 	Highlight whitespace errors in the `context`, `old` or `new`
 	lines of the diff.  Multiple values are separated by comma,
 	`none` resets previous values, `default` reset the list to
@@ -238,14 +251,19 @@ diff.wsErrorHighlight::
 	The command line option `--ws-error-highlight=<kind>`
 	overrides this setting.
 
-diff.colorMoved::
-	If set to either a valid `<mode>` or a true value, moved lines
-	in a diff are colored differently, for details of valid modes
-	see '--color-moved' in linkgit:git-diff[1]. If simply set to
-	true the default color mode will be used. When set to false,
-	moved lines are not colored.
-
-diff.colorMovedWS::
+`diff.colorMoved`::
+	If set to either a valid _<mode>_ or a `true` value, moved lines
+	in a diff are colored differently.
+ifdef::git-diff[]
+	For details of valid modes see `--color-moved`.
+endif::git-diff[]
+ifndef::git-diff[]
+	For details of valid modes see `--color-moved` in linkgit:git-diff[1].
+endif::git-diff[]
+	If simply set to `true` the default color mode will be used. When
+	set to `false`, moved lines are not colored.
+
+`diff.colorMovedWS`::
 	When moved lines are colored using e.g. the `diff.colorMoved` setting,
-	this option controls the `<mode>` how spaces are treated.
-	For details of valid modes see '--color-moved-ws' in linkgit:git-diff[1].
+	this option controls the mode how spaces are treated.
+	For details of valid modes see `--color-moved-ws` in linkgit:git-diff[1].
-- 
gitgitgadget
