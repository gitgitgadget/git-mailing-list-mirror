Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05715E97
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731793381; cv=none; b=R9V1kW60I/dFT05N0v0/h/KT42Ch1ZHozoYirETDJMzHhTJMSXLsuhasK1+jFw6FTuX5eZ0GyBuDoW3NNWVRRev490x0wOErYwEgPXFJbJ8VXPAiLplMvhEBcxDR+Lv/PZFyMWII5NH/7+qLvRonh4pOoWDhGDOCPbpm6I3IW+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731793381; c=relaxed/simple;
	bh=QzigJjIMu4LAJxPDargivWoq5ZSxlD89Ufc054Bn4EQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=X5xvp/bEG2WgEGCSm+CUQg/LgDtFcw+I4Qf/uBwGz56rErFtlS4J8sILOzvu/htAo7uJ6L7Zl3/fpZUJKxLMFPRx6M2nBYlGSfIZ+SL5BVcm0nH5RntxMpmC7rgpsf0iNIOwqTwQKvNhfRFwaX2sNU5G2IU0rjXoy874c2lAcq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+CMuLv/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+CMuLv/"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so832936f8f.2
        for <git@vger.kernel.org>; Sat, 16 Nov 2024 13:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731793376; x=1732398176; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUhjmg17M+6eKKiqRAsLoeK8qJhCkh04jjK30ob2dQs=;
        b=F+CMuLv/TAlI7/sENpEjJdLgyNlCv1cJWz5EYJyT1SMPE+EsXKcnn3u1z7OnHMD2mR
         BYritgDPGhsJyMJfH8/WAvihY3W57aRCq2861YTltrr5USpJlH8cyzqC32JP+B/I8SJc
         RA016W3YmdDIc4TK7m76Q3JqnZvqd88qnxRxkeYNqi8XivAA1AI2/ka/q1HrpMYlo5uj
         xhYMuU8KO0yTNna33AdObw8DPhs3+pMVjrvygjWBWJhbyDKdvnDJ0L5fpuuYiXOwYGML
         1b9dJYqoJeJMNcFP+i7eWmepf+91x6p5HIP+2QOX9ZFZveej/4QZJY6nUHuKHb+0Ml/W
         Oetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731793376; x=1732398176;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUhjmg17M+6eKKiqRAsLoeK8qJhCkh04jjK30ob2dQs=;
        b=Evo02oJsMA5VMnIMfgkUdToqRoNIfDnv1CCm5bWGxL/EUwdalsrr8Y91b6vN0pMHsE
         YixCYFVSbqaBQsm2+lxfZ3cpzjdYEsbMAgsE608w1EDVvOVhoWcOyO5BX5bX3cHprLzL
         /r0qNf3x5JBMXH4YQG0/dNOdL4uAQpKu/VA+g6w4a+nr43ld3JhErRlIsCAVigkBJUef
         VG4/6cGYYbh/oVWqnuExoo2ciLjdMVGvIMsYAcjhG2bBkw7E+XNHjEwQHeHlN91071qK
         QrZ+RpuZ3YsmXmEjVPi5cl3SsT/IeHUqOjcFA7H/FzNjAOBsop+iiI24r49d7Hjwy5iP
         s4IQ==
X-Gm-Message-State: AOJu0YzmXosbaAPoxlyWLSRMvw+gs6NM+7FsqOrMoyy6c2Y2uBls1ANy
	4SuU348E5c8OfdPn/bQKjWWVgiel5TVEdPxOOY0yQodBbb8vmqdn2OJWmA==
X-Google-Smtp-Source: AGHT+IECJ+PgoPqA3EevSmtkX4u77c/QxXcXaJRyPs8Ac9xTplektQRpyJnYY5bTBpUnwAN5OdN0aA==
X-Received: by 2002:a05:6000:70f:b0:37d:4cf9:e08b with SMTP id ffacd0b85a97d-38225a6ac66mr7453059f8f.31.1731793376078;
        Sat, 16 Nov 2024 13:42:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382416e22c1sm339910f8f.2.2024.11.16.13.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 13:42:55 -0800 (PST)
Message-Id: <pull.1826.v2.git.1731793374648.gitgitgadget@gmail.com>
In-Reply-To: <pull.1826.git.1731348891108.gitgitgadget@gmail.com>
References: <pull.1826.git.1731348891108.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Nov 2024 21:42:54 +0000
Subject: [PATCH v2] doc: git-add.txt: convert to new style convention
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

While we are at it, let's refactor the corresponding configuration
documentation to prevent auto-referencing git-add in its own manpage.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
    doc: git-add.txt: convert to new style convention

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1826%2Fjnavila%2Fnew_git_add-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1826/jnavila/new_git_add-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1826

Range-diff vs v1:

 1:  9caabbcb263 ! 1:  7028145ae4d doc: git-add.txt: convert to new style convention
     @@ Metadata
       ## Commit message ##
          doc: git-add.txt: convert to new style convention
      
     +    While we are at it, let's refactor the corresponding configuration
     +    documentation to prevent auto-referencing git-add in its own manpage.
     +
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/config/add.txt ##


 Documentation/config/add.txt |  19 +++---
 Documentation/git-add.txt    | 111 ++++++++++++++++++-----------------
 2 files changed, 68 insertions(+), 62 deletions(-)

diff --git a/Documentation/config/add.txt b/Documentation/config/add.txt
index 4d753f006ec..7497533cbcc 100644
--- a/Documentation/config/add.txt
+++ b/Documentation/config/add.txt
@@ -1,7 +1,12 @@
-add.ignoreErrors::
-add.ignore-errors (deprecated)::
-	Tells 'git add' to continue adding files when some files cannot be
-	added due to indexing errors. Equivalent to the `--ignore-errors`
-	option of linkgit:git-add[1].  `add.ignore-errors` is deprecated,
-	as it does not follow the usual naming convention for configuration
-	variables.
+`add.ignoreErrors`::
+`add.ignore-errors` (deprecated)::
+	Tells `git add` to continue adding files when some files cannot be
+	added due to indexing errors.
+ifdef::git-add[]
+	Equivalent to the `--ignore-errors` option.
+endif::git-add[]
+ifndef::git-add[]
+	Equivalent to the `--ignore-errors` option of linkgit:git-add[1].
+endif::git-add[]
+	`add.ignore-errors` is deprecated, as it does not follow the usual
+	naming convention for configuration variables.
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index aceaa025e30..5f2c3592b8d 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -7,12 +7,12 @@ git-add - Add file contents to the index
 
 SYNOPSIS
 --------
-[verse]
-'git add' [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
-	  [--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
-	  [--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
-	  [--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
-	  [--] [<pathspec>...]
+[synopsis]
+git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [--patch | -p]
+	[--edit | -e] [--[no-]all | -A | --[no-]ignore-removal | [--update | -u]] [--sparse]
+	[--intent-to-add | -N] [--refresh] [--ignore-errors] [--ignore-missing] [--renormalize]
+	[--chmod=(+|-)x] [--pathspec-from-file=<file> [--pathspec-file-nul]]
+	[--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -41,7 +41,7 @@ The `git add` command will not add ignored files by default.  If any
 ignored files were explicitly specified on the command line, `git add`
 will fail with a list of ignored files.  Ignored files reached by
 directory recursion or filename globbing performed by Git (quote your
-globs before the shell) will be silently ignored.  The 'git add' command can
+globs before the shell) will be silently ignored.  The `git add` command can
 be used to add ignored files with the `-f` (force) option.
 
 Please see linkgit:git-commit[1] for alternative ways to add content to a
@@ -50,7 +50,7 @@ commit.
 
 OPTIONS
 -------
-<pathspec>...::
+`<pathspec>...`::
 	Files to add content from.  Fileglobs (e.g. `*.c`) can
 	be given to add all matching files.  Also a
 	leading directory name (e.g. `dir` to add `dir/file1`
@@ -66,35 +66,35 @@ OPTIONS
 For more details about the _<pathspec>_ syntax, see the 'pathspec' entry
 in linkgit:gitglossary[7].
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Don't actually add the file(s), just show if they exist and/or will
 	be ignored.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
         Be verbose.
 
--f::
---force::
+`-f`::
+`--force`::
 	Allow adding otherwise ignored files.
 
---sparse::
+`--sparse`::
 	Allow updating index entries outside of the sparse-checkout cone.
 	Normally, `git add` refuses to update index entries whose paths do
 	not fit within the sparse-checkout cone, since those files might
 	be removed from the working tree without warning. See
 	linkgit:git-sparse-checkout[1] for more details.
 
--i::
---interactive::
+`-i`::
+`--interactive`::
 	Add modified contents in the working tree interactively to
 	the index. Optional path arguments may be supplied to limit
 	operation to a subset of the working tree. See ``Interactive
 	mode'' for details.
 
--p::
---patch::
+`-p`::
+`--patch`::
 	Interactively choose hunks of patch between the index and the
 	work tree and add them to the index. This gives the user a chance
 	to review the difference before adding modified contents to the
@@ -104,8 +104,8 @@ This effectively runs `add --interactive`, but bypasses the
 initial command menu and directly jumps to the `patch` subcommand.
 See ``Interactive mode'' for details.
 
--e::
---edit::
+`-e`::
+`--edit`::
 	Open the diff vs. the index in an editor and let the user
 	edit it.  After the editor was closed, adjust the hunk headers
 	and apply the patch to the index.
@@ -116,8 +116,8 @@ quicker and more flexible than using the interactive hunk selector.
 However, it is easy to confuse oneself and create a patch that does not
 apply to the index. See EDITING PATCHES below.
 
--u::
---update::
+`-u`::
+`--update`::
 	Update the index just where it already has an entry matching
 	_<pathspec>_.  This removes as well as modifies index entries to
 	match the working tree, but adds no new files.
@@ -127,9 +127,9 @@ tracked files in the entire working tree are updated (old versions
 of Git used to limit the update to the current directory and its
 subdirectories).
 
--A::
---all::
---no-ignore-removal::
+`-A`::
+`--all`::
+`--no-ignore-removal`::
 	Update the index not only where the working tree has a file
 	matching _<pathspec>_ but also where the index already has an
 	entry. This adds, modifies, and removes index entries to
@@ -140,77 +140,77 @@ files in the entire working tree are updated (old versions
 of Git used to limit the update to the current directory and its
 subdirectories).
 
---no-all::
---ignore-removal::
+`--no-all`::
+`--ignore-removal`::
 	Update the index by adding new files that are unknown to the
 	index and files modified in the working tree, but ignore
 	files that have been removed from the working tree.  This
 	option is a no-op when no _<pathspec>_ is used.
 +
 This option is primarily to help users who are used to older
-versions of Git, whose "git add _<pathspec>_..." was a synonym
-for "git add --no-all _<pathspec>_...", i.e. ignored removed files.
+versions of Git, whose `git add <pathspec>...` was a synonym
+for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 
--N::
---intent-to-add::
+`-N`::
+`--intent-to-add`::
 	Record only the fact that the path will be added later. An entry
 	for the path is placed in the index with no content. This is
 	useful for, among other things, showing the unstaged content of
 	such files with `git diff` and committing them with `git commit
 	-a`.
 
---refresh::
+`--refresh`::
 	Don't add the file(s), but only refresh their stat()
 	information in the index.
 
---ignore-errors::
+`--ignore-errors`::
 	If some files could not be added because of errors indexing
 	them, do not abort the operation, but continue adding the
 	others. The command shall still exit with non-zero status.
 	The configuration variable `add.ignoreErrors` can be set to
 	true to make this the default behaviour.
 
---ignore-missing::
-	This option can only be used together with --dry-run. By using
+`--ignore-missing`::
+	This option can only be used together with `--dry-run`. By using
 	this option the user can check if any of the given files would
 	be ignored, no matter if they are already present in the work
 	tree or not.
 
---no-warn-embedded-repo::
+`--no-warn-embedded-repo`::
 	By default, `git add` will warn when adding an embedded
 	repository to the index without using `git submodule add` to
 	create an entry in `.gitmodules`. This option will suppress the
 	warning (e.g., if you are manually performing operations on
 	submodules).
 
---renormalize::
+`--renormalize`::
 	Apply the "clean" process freshly to all tracked files to
 	forcibly add them again to the index.  This is useful after
 	changing `core.autocrlf` configuration or the `text` attribute
-	in order to correct files added with wrong CRLF/LF line endings.
+	in order to correct files added with wrong _CRLF/LF_ line endings.
 	This option implies `-u`. Lone CR characters are untouched, thus
-	while a CRLF cleans to LF, a CRCRLF sequence is only partially
-	cleaned to CRLF.
+	while a _CRLF_ cleans to _LF_, a _CRCRLF_ sequence is only partially
+	cleaned to _CRLF_.
 
---chmod=(+|-)x::
+`--chmod=(+|-)x`::
 	Override the executable bit of the added files.  The executable
 	bit is only changed in the index, the files on disk are left
 	unchanged.
 
---pathspec-from-file=<file>::
+`--pathspec-from-file=<file>`::
 	Pathspec is passed in _<file>_ instead of commandline args. If
 	_<file>_ is exactly `-` then standard input is used. Pathspec
-	elements are separated by LF or CR/LF. Pathspec elements can be
+	elements are separated by _LF_ or _CR/LF_. Pathspec elements can be
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
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
 	for command-line options).
@@ -219,18 +219,18 @@ for "git add --no-all _<pathspec>_...", i.e. ignored removed files.
 EXAMPLES
 --------
 
-* Adds content from all `*.txt` files under `Documentation` directory
+* Adds content from all ++*.txt++ files under `Documentation` directory
   and its subdirectories:
 +
 ------------
 $ git add Documentation/\*.txt
 ------------
 +
-Note that the asterisk `*` is quoted from the shell in this
+Note that the asterisk ++*++ is quoted from the shell in this
 example; this lets the command include the files from
 subdirectories of `Documentation/` directory.
 
-* Considers adding content from all git-*.sh scripts:
+* Considers adding content from all ++git-*.sh++ scripts:
 +
 ------------
 $ git add git-*.sh
@@ -265,7 +265,7 @@ The main command loop has 6 subcommands (plus help and quit).
 
 status::
 
-   This shows the change between HEAD and index (i.e. what will be
+   This shows the change between `HEAD` and index (i.e. what will be
    committed if you say `git commit`), and between index and
    working tree files (i.e. what you could stage further before
    `git commit` using `git add`) for each path.  A sample output
@@ -277,12 +277,12 @@ status::
      2:     +403/-35        +1/-1 add-interactive.c
 ------------
 +
-It shows that foo.png has differences from HEAD (but that is
+It shows that `foo.png` has differences from `HEAD` (but that is
 binary so line count cannot be shown) and there is no
 difference between indexed copy and the working tree
 version (if the working tree version were also different,
 'binary' would have been shown in place of 'nothing').  The
-other file, add-interactive.c, has 403 lines added
+other file, `add-interactive.c`, has 403 lines added
 and 35 lines deleted if you commit what is in the index, but
 working tree file has further modifications (one addition and
 one deletion).
@@ -360,7 +360,7 @@ variable `interactive.singleKey` to `true`.
 diff::
 
   This lets you review what will be committed (i.e. between
-  HEAD and index).
+  `HEAD` and index).
 
 
 EDITING PATCHES
@@ -399,7 +399,7 @@ There are also more complex operations that can be performed. But beware
 that because the patch is applied only to the index and not the working
 tree, the working tree will appear to "undo" the change in the index.
 For example, introducing a new line into the index that is in neither
-the HEAD nor the working tree will stage the new line for commit, but
+the `HEAD` nor the working tree will stage the new line for commit, but
 the line will appear to be reverted in the working tree.
 
 Avoid using these constructs, or do so with extreme caution.
@@ -439,6 +439,7 @@ CONFIGURATION
 
 include::includes/cmd-config-section-all.txt[]
 
+:git-add: 1
 include::config/add.txt[]
 
 SEE ALSO

base-commit: facbe4f633e4ad31e641f64617bc88074c659959
-- 
gitgitgadget
