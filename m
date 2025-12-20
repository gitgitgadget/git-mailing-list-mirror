Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0081A26B95B
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766258197; cv=none; b=HZbR/nbowinyt28ogzZ6IIIfMFzucT5/wTywUL04n/C2aIc3GeBPL7tlVEaT0jiLje7HOn8Jlf4h9qqX5MsKCCaI1OGnZSQHUUKHarJ4bvsKt5lytwTwNk3LFmSY7RbKLJHVgwvu29wiOcXKw+diLO3L7JpBerwiwPkcBq5S38g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766258197; c=relaxed/simple;
	bh=dq+fTjCocK06cpNbXuvWv/oq5OzCeAn2bdcmRUiJ+vc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=jYIZCsyyiOeXAep2se0c00DmBL85IVcSRz6bBVmeFKY6BPRWPB914gdjFmfkPBNJ6V/wtSMC86QWaakAa9sFhjNPQ0CWAkpdHXmbNqJMCP6zPORI+lT2EvrtrEoTkNvDICAlon360XjX9PE9edxIAxqNE87q42jjiajpl5DSOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlH7c9lW; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlH7c9lW"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a26ce6619so29193996d6.3
        for <git@vger.kernel.org>; Sat, 20 Dec 2025 11:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766258193; x=1766862993; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVmOkdUEdgElFwdJFqwxIM4BwTStwGatqocQYuYqCb0=;
        b=PlH7c9lWgLlBpQ590dLAoqXbe3SHa1rtr/vRQmbXiOjrFxhxY5bKZNs2Vjsr5Z5DLq
         RH0BN/MGiUOJTvDt3o8xRLR28eDwGGePVjYBx52jQ0iW8XvKjczW8q9xmjGTQVq4zJ01
         /2OCpwjVzv/jyIpr2y6i/dhsqUZsNiNNb//QsksEz/purbCfGFkVA7w2frXon4X6VAG2
         3DbOdZ13sjR/wDhnIoTplM+ttBVt4vbm7ELlvzSfXGy6xwdyDxi7VpimUafLFQOD+7PD
         Soy3rmWTdZ4wwJyV7OTjmNJSbo1Qkld5Ln2iBqPjh5FuNMkrQH/32CPfSm85sXzuz1Or
         ixbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766258193; x=1766862993;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZVmOkdUEdgElFwdJFqwxIM4BwTStwGatqocQYuYqCb0=;
        b=GZpnTjuNnfW+5T97Muq2RbAQCfvbrjXx7btOlsv3+h6oNYVFH4NLmYGlqygi9BytO1
         AaNSVRSShKgq7esuupu13rzLd2N48kk4OnpI8hK4KTO0v3LKeqYSL7cUTCAZ3LhsPfPZ
         dGIEhcMxQqGpbX2mA8jUsuEikANFlqZmhv17x7YWbGoUmOfEH0DiT6UDfzIm9ioNsM/N
         UJ24SjzSqgOtzXL3VejyAr7wCpzR+HWU4yC21Ti9jDKh1c9iJftiNhE/pcQc/ctrT0Lz
         kSb/VIEnkg4FeTRL/kPGr94DWO4k49wTOLIG+mceAJuBVxpOTSEBvSlECWAH6avhbcwv
         37PQ==
X-Gm-Message-State: AOJu0Yxi0xjBUxhjJslU78mn1QOJEaET1JWrmg247e8n5Im9eJ82Kmdz
	eYvld2hqD9IMPEWsdG5y1+ZIxiw2Py/d2trriT9ZXjvFz5NdgoryPuhykrw15A==
X-Gm-Gg: AY/fxX7+hJk8vK1Y/LUMxCocsGWyEZ6LhO0hRz30ukelWjSWXVt4UPAt1t6Q/Rd+w5O
	JS3/0yaqen0iX3q4krKvNJTDaq5JgeqbT/L9+OeT1ZiKjzNMoZj64XryDzWrqZBja5VUTimHi9Z
	02aer1Nvgi18jcJnGWeNrWPxFRgKaOxliyQVS45dbEh8gdHuYDcQHmCuKoCXole7NcRsNIrHwhg
	Ei2fqf9Syynpg6RuS39cpGYeCnLZxq4lS+9oN3mLvwFuyxbH346NmTEdjL/oYo3qKQVLhQtDhfA
	r2iJW0D/oJsu2MQxDiycUDBqbNRN3Q1nNC/2+kI3HI1XqrWQcEJMRrAyHbsYoJpxQ+QqQKwL4Gu
	2CqOsUxIPyFXntCy+Mv8fjbGgquitPWIRhgTS/NRzwzwvfGgRb0tyzX3Q1+XDl8f7EtByGcZgxq
	NlO8nsdPHuKjRkkw==
X-Google-Smtp-Source: AGHT+IGxcoylZFwmG3gqxcdZ69di+XVt66yeDWNYy8zVOH/08NPuibwP6UW0pAswrYhG5cRtH15ApQ==
X-Received: by 2002:a05:6214:486:b0:787:8e43:5761 with SMTP id 6a1803df08f44-88d87be8f57mr126411846d6.56.1766258193221;
        Sat, 20 Dec 2025 11:16:33 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0975ec0f0sm461756685a.50.2025.12.20.11.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 11:16:32 -0800 (PST)
Message-Id: <08f3bb0e36f0fc67dae3767211b97439a80980a1.1766258187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2020.git.1766258187.gitgitgadget@gmail.com>
References: <pull.2020.git.1766258187.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Dec 2025 19:16:24 +0000
Subject: [PATCH 2/5] doc: convert git-status to synopsis style
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

Also convert unformatted lists to proper AsciiDoc lists.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-status.adoc | 182 ++++++++++++++++++----------------
 1 file changed, 95 insertions(+), 87 deletions(-)

diff --git a/Documentation/git-status.adoc b/Documentation/git-status.adoc
index 9a376886a5..37b0453898 100644
--- a/Documentation/git-status.adoc
+++ b/Documentation/git-status.adoc
@@ -8,8 +8,9 @@ git-status - Show the working tree status
 
 SYNOPSIS
 --------
-[verse]
-'git status' [<options>] [--] [<pathspec>...]
+
+[synopsis]
+git status [<options>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -18,57 +19,57 @@ current HEAD commit, paths that have differences between the working
 tree and the index file, and paths in the working tree that are not
 tracked by Git (and are not ignored by linkgit:gitignore[5]). The first
 are what you _would_ commit by running `git commit`; the second and
-third are what you _could_ commit by running 'git add' before running
+third are what you _could_ commit by running `git add` before running
 `git commit`.
 
 OPTIONS
 -------
 
--s::
---short::
+`-s`::
+`--short`::
 	Give the output in the short-format.
 
--b::
---branch::
+`-b`::
+`--branch`::
 	Show the branch and tracking info even in short-format.
 
---show-stash::
+`--show-stash`::
 	Show the number of entries currently stashed away.
 
---porcelain[=<version>]::
+`--porcelain[=<version>]`::
 	Give the output in an easy-to-parse format for scripts.
 	This is similar to the short output, but will remain stable
 	across Git versions and regardless of user configuration. See
 	below for details.
 +
-The version parameter is used to specify the format version.
-This is optional and defaults to the original version 'v1' format.
+The _<version>_ parameter is used to specify the format version.
+This is optional and defaults to the original version `v1` format.
 
---long::
+`--long`::
 	Give the output in the long-format. This is the default.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	In addition to the names of files that have been changed, also
 	show the textual changes that are staged to be committed
 	(i.e., like the output of `git diff --cached`). If `-v` is specified
 	twice, then also show the changes in the working tree that
 	have not yet been staged (i.e., like the output of `git diff`).
 
--u[<mode>]::
---untracked-files[=<mode>]::
+`-u[<mode>]`::
+`--untracked-files[=<mode>]`::
 	Show untracked files.
 +
 --
 The mode parameter is used to specify the handling of untracked files.
-It is optional: it defaults to 'all', and if specified, it must be
+It is optional: it defaults to `all`, and if specified, it must be
 stuck to the option (e.g. `-uno`, but not `-u no`).
 
 The possible options are:
 
-	- 'no'     - Show no untracked files.
-	- 'normal' - Shows untracked files and directories.
-	- 'all'    - Also shows individual files in untracked directories.
+`no`:: Show no untracked files.
+`normal`:: Show untracked files and directories.
+`all`:: Also show individual files in untracked directories.
 
 When `-u` option is not used, untracked files and directories are
 shown (i.e. the same as specifying `normal`), to help you avoid
@@ -82,76 +83,78 @@ return more quickly without showing untracked files.
 All usual spellings for Boolean value `true` are taken as `normal`
 and `false` as `no`.
 
-The default can be changed using the status.showUntrackedFiles
+The default can be changed using the `status.showUntrackedFiles`
 configuration variable documented in linkgit:git-config[1].
 --
 
---ignore-submodules[=<when>]::
-	Ignore changes to submodules when looking for changes. <when> can be
-	either "none", "untracked", "dirty" or "all", which is the default.
-	Using "none" will consider the submodule modified when it either contains
+`--ignore-submodules[=<when>]`::
+	Ignore changes to submodules when looking for changes. _<when>_ can be
+	either `none`, `untracked`, `dirty` or `all`, which is the default.
+`none`;; will consider the submodule modified when it either contains
 	untracked or modified files or its HEAD differs from the commit recorded
 	in the superproject and can be used to override any settings of the
-	'ignore' option in linkgit:git-config[1] or linkgit:gitmodules[5]. When
-	"untracked" is used submodules are not considered dirty when they only
+	`ignore` option in linkgit:git-config[1] or linkgit:gitmodules[5].
+`untracked`;; submodules are not considered dirty when they only
 	contain untracked content (but they are still scanned for modified
-	content). Using "dirty" ignores all changes to the work tree of submodules,
+	content).
+`dirty`;; ignore all changes to the work tree of submodules,
 	only changes to the commits stored in the superproject are shown (this was
-	the behavior before 1.7.0). Using "all" hides all changes to submodules
+	the behavior before 1.7.0).
+`all`;; hide all changes to submodules
 	(and suppresses the output of submodule summaries when the config option
 	`status.submoduleSummary` is set).
 
---ignored[=<mode>]::
+`--ignored[=<mode>]`::
 	Show ignored files as well.
 +
 --
 The mode parameter is used to specify the handling of ignored files.
-It is optional: it defaults to 'traditional'.
+It is optional: it defaults to `traditional`.
 
 The possible options are:
 
-	- 'traditional' - Shows ignored files and directories, unless
-			  --untracked-files=all is specified, in which case
-			  individual files in ignored directories are
-			  displayed.
-	- 'no'	        - Show no ignored files.
-	- 'matching'    - Shows ignored files and directories matching an
-			  ignore pattern.
-
-When 'matching' mode is specified, paths that explicitly match an
+`traditional`:: Show ignored files and directories, unless
+`--untracked-files=all` is specified, in which case
+ individual files in ignored directories are
+ displayed.
+`no`:: Show no ignored files.
+`matching`:: Show ignored files and directories matching an
+ignore pattern.
++
+Paths that explicitly match an
 ignored pattern are shown. If a directory matches an ignore pattern,
 then it is shown, but not paths contained in the ignored directory. If
 a directory does not match an ignore pattern, but all contents are
 ignored, then the directory is not shown, but all contents are shown.
 --
 
--z::
-	Terminate entries with NUL, instead of LF.  This implies
+`-z`::
+	Terminate entries with _NUL_, instead of _LF_.  This implies
 	the `--porcelain=v1` output format if no other format is given.
 
---column[=<options>]::
---no-column::
+`--column[=<options>]`::
+`--no-column`::
 	Display untracked files in columns. See configuration variable
 	`column.status` for option syntax. `--column` and `--no-column`
-	without options are equivalent to 'always' and 'never'
+	without options are equivalent to `always` and `never`
 	respectively.
 
---ahead-behind::
---no-ahead-behind::
+`--ahead-behind`::
+`--no-ahead-behind`::
 	Display or do not display detailed ahead/behind counts for the
-	branch relative to its upstream branch.  Defaults to true.
+	branch relative to its upstream branch.  Defaults to `true`.
 
---renames::
---no-renames::
+`--renames`::
+`--no-renames`::
 	Turn on/off rename detection regardless of user configuration.
 	See also linkgit:git-diff[1] `--no-renames`.
 
---find-renames[=<n>]::
+`--find-renames[=<n>]`::
 	Turn on rename detection, optionally setting the similarity
 	threshold.
 	See also linkgit:git-diff[1] `--find-renames`.
 
-<pathspec>...::
+`<pathspec>...`::
 	See the 'pathspec' entry in linkgit:gitglossary[7].
 
 OUTPUT
@@ -173,12 +176,12 @@ Short Format
 In the short-format, the status of each path is shown as one of these
 forms
 
-	XY PATH
-	XY ORIG_PATH -> PATH
+	<xy> <path>
+	<xy> <orig-path> -> <path>
 
-where `ORIG_PATH` is where the renamed/copied contents came
-from. `ORIG_PATH` is only shown when the entry is renamed or
-copied. The `XY` is a two-letter status code.
+where _<orig-path>_ is where the renamed/copied contents came
+from. _<orig-path>_ is only shown when the entry is renamed or
+copied. The _<xy>_ is a two-letter status code `XY`.
 
 The fields (including the `->`) are separated from each other by a
 single space. If a filename contains whitespace or other nonprintable
@@ -187,7 +190,7 @@ literal: surrounded by ASCII double quote (34) characters, and with
 interior special characters backslash-escaped.
 
 There are three different types of states that are shown using this format, and
-each one uses the `XY` syntax differently:
+each one uses the _<xy>_ syntax differently:
 
 * When a merge is occurring and the merge was successful, or outside of a merge
 	situation, `X` shows the status of the index and `Y` shows the status of the
@@ -207,14 +210,14 @@ In the following table, these three classes are shown in separate sections, and
 these characters are used for `X` and `Y` fields for the first two sections that
 show tracked paths:
 
-* ' ' = unmodified
-* 'M' = modified
-* 'T' = file type changed (regular file, symbolic link or submodule)
-* 'A' = added
-* 'D' = deleted
-* 'R' = renamed
-* 'C' = copied (if config option status.renames is set to "copies")
-* 'U' = updated but unmerged
+' ':: unmodified
+`M`:: modified
+`T`:: file type changed (regular file, symbolic link or submodule)
+`A`:: added
+`D`:: deleted
+`R`:: renamed
+`C`:: copied (if config option status.renames is set to "copies")
+`U`:: updated but unmerged
 
 ....
 X          Y     Meaning
@@ -248,19 +251,21 @@ U           U    unmerged, both modified
 
 Submodules have more state and instead report
 
-* 'M' = the submodule has a different HEAD than recorded in the index
-* 'm' = the submodule has modified content
-* '?' = the submodule has untracked files
+`M`:: the submodule has a different HEAD than recorded in the index
+`m`:: the submodule has modified content
+`?`:: the submodule has untracked files
 
 This is since modified content or untracked files in a submodule cannot be added
 via `git add` in the superproject to prepare a commit.
 
-'m' and '?' are applied recursively. For example if a nested submodule
-in a submodule contains an untracked file, this is reported as '?' as well.
+`m` and `?` are applied recursively. For example if a nested submodule
+in a submodule contains an untracked file, this is reported as `?` as well.
+
+If `-b` is used the short-format status is preceded by a line
 
-If -b is used the short-format status is preceded by a line
+[synopsis]
+{empty}## <branchname> <tracking-info>
 
-    ## branchname tracking info
 
 Porcelain Format Version 1
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -271,16 +276,16 @@ based on user configuration. This makes it ideal for parsing by scripts.
 The description of the short format above also describes the porcelain
 format, with a few exceptions:
 
-1. The user's color.status configuration is not respected; color will
+1. The user's `color.status` configuration is not respected; color will
    always be off.
 
-2. The user's status.relativePaths configuration is not respected; paths
+2. The user's `status.relativePaths` configuration is not respected; paths
    shown will always be relative to the repository root.
 
-There is also an alternate -z format recommended for machine parsing. In
+There is also an alternate `-z` format recommended for machine parsing. In
 that format, the status field is the same, but some other things
-change.  First, the '\->' is omitted from rename entries and the field
-order is reversed (e.g 'from \-> to' becomes 'to from'). Second, a NUL
+change.  First, the `->` is omitted from rename entries and the field
+order is reversed (e.g `from -> to` becomes `to from`). Second, a _NUL_
 (ASCII 0) follows each filename, replacing space as a field separator
 and the terminating newline (but a space still separates the status
 field from the first filename).  Third, filenames containing special
@@ -296,7 +301,7 @@ Version 2 format adds more detailed information about the state of
 the worktree and changed items.  Version 2 also defines an extensible
 set of easy to parse optional headers.
 
-Header lines start with "#" and are added in response to specific
+Header lines start with `#` and are added in response to specific
 command line arguments.  Parsers should ignore headers they
 don't recognize.
 
@@ -336,11 +341,13 @@ line types in any order.
 
 Ordinary changed entries have the following format:
 
-    1 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <path>
+[synopsis]
+1 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <path>
 
 Renamed or copied entries have the following format:
 
-    2 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <X><score> <path><sep><origPath>
+[synopsis]
+2 <XY> <sub> <mH> <mI> <mW> <hH> <hI> <X><score> <path><sep><origPath>
 
 ....
 Field       Meaning
@@ -377,7 +384,8 @@ Field       Meaning
 Unmerged entries have the following format; the first character is
 a "u" to distinguish from ordinary changed entries.
 
-    u <XY> <sub> <m1> <m2> <m3> <mW> <h1> <h2> <h3> <path>
+[synopsis]
+u <XY> <sub> <m1> <m2> <m3> <mW> <h1> <h2> <h3> <path>
 
 ....
 Field       Meaning
@@ -416,7 +424,7 @@ Pathname Format Notes and -z
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 When the `-z` option is given, pathnames are printed as is and
-without any quoting and lines are terminated with a NUL (ASCII 0x00)
+without any quoting and lines are terminated with a _NUL_ (ASCII 0x00)
 byte.
 
 Without the `-z` option, pathnames with "unusual" characters are
@@ -439,11 +447,11 @@ directory.
 If `status.submoduleSummary` is set to a non zero number or true (identical
 to -1 or an unlimited number), the submodule summary will be enabled for
 the long format and a summary of commits for modified submodules will be
-shown (see --summary-limit option of linkgit:git-submodule[1]). Please note
+shown (see `--summary-limit` option of linkgit:git-submodule[1]). Please note
 that the summary output from the status command will be suppressed for all
-submodules when `diff.ignoreSubmodules` is set to 'all' or only for those
+submodules when `diff.ignoreSubmodules` is set to `all` or only for those
 submodules where `submodule.<name>.ignore=all`. To also view the summary for
-ignored submodules you can either use the --ignore-submodules=dirty command
+ignored submodules you can either use the `--ignore-submodules=dirty` command
 line option or the 'git submodule summary' command, which shows a similar
 output but does not honor these settings.
 
@@ -484,7 +492,7 @@ results, so it could be faster on subsequent runs.
 	setting this variable to `false` disables the warning message
 	given when enumerating untracked files takes more than 2
 	seconds.  In a large project, it may take longer and the user
-	may have already accepted the trade off (e.g. using "-uno" may
+	may have already accepted the trade off (e.g. using `-uno` may
 	not be an acceptable option for the user), in which case, there
 	is no point issuing the warning message, and in such a case,
 	disabling the warning may be the best.
-- 
gitgitgadget

