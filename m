Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C48C136E28
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348897; cv=none; b=F2GGsx1mNV0UqJCbNNHXFhOiUD1qG9SpeP3C6ZaWgwFEJrU50aBFXXiDAMmRQCifx+CERuaBDkvjLooELLQxuytSH9itBNeKXW+NR6zLfrU4GnbShQeOk6KDBob1xGDgWuy217CRbb2OdWoMrOgX32/V3PmFB2tkpVm5mAWjz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348897; c=relaxed/simple;
	bh=n3zMf6/QNCAbyhpT0XhxmfUXGWlRnxI2V6zz1w+dYHQ=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=kSe5p7XbfVFO1372flQoNJlWheR8UZoDGRzlvIKaVBjIdqvJuj0A/iKAP9CrEcg0LIlXvytS3dCLzXhjlwdA28LkrHMVh3ioxes4w3QLPIfElY+dpkQU0xiPerFDKz51oJUgyiPmLPXFuwuD122/adt/mXbq2NUZ6F0Sr1HOBpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFWLcJCn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFWLcJCn"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4c482844so3262511f8f.0
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731348893; x=1731953693; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tBcMWIjzyE1wKwo/DtyLLvSE+UM7Udy2uxfAXpReSBU=;
        b=WFWLcJCn14U19daegnzLjPDD0Onk9KIgPq73PuEVfzZbJhrA06vijCIVi89vNe4rV1
         KY5r6kqUQcRP5sChc3tWyKgDUdNXR+C/mCDHW0pZbkMV+pqKGCPm5wbJfnaa4zZ6oGuZ
         PFKJYFCj+tf3KUsYJgjoBmw0rE6pDOWpFUtO26EVdVklVWEbHyu1SfO5sCNKBkbpISM6
         GyXCqAckQbS9gtdgEhSkoewRINylVplQEICybADLff/ieEirLdqH4DrT6YOxchdwVaxp
         ixdne4y5m+pKTYrforzgNfFC3L4LJiTeyBvfxlyruKXmCzbV67MVzkIsTv0gdCAv3GFY
         dmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348893; x=1731953693;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBcMWIjzyE1wKwo/DtyLLvSE+UM7Udy2uxfAXpReSBU=;
        b=l7hr8w67PX3vjTqA7iWvPh6Dy7Ob70vZBftE5N+0N7ceqImg72p3/OwdwbXwRmpSuQ
         1H14x84+xPmwEu61tO0/OVE3PdUE7wkhIPBDW0uNKSSNHMwkce9OxgFN9IIgb8KkE5U6
         c0QtuYVJGSY3DL0eKl7Ygq6+nmD2k+cgAVSGk4cVf0CKGQvVm5LZ9kTuCP/LRO/NGez1
         WlfMBZ2WyTxPwO4TSSeQFe1HKtVoJwg2xuNVSwsV+hfwmvw6SRzJ3FfW0h5CrhXdKN7n
         5FM20bNQTAw48Sa9pk5RC3RvJ2vRLu7Xnd+d/m2d+rEUB2Vl9XRU8S7L/8gjc76nRgbN
         WcTA==
X-Gm-Message-State: AOJu0Yzhz9mPBUZeRa/TdIQbMQDgo/HMy9r0Y3HrSbkV9rLg+6UsEwNz
	U4OMmSnLExaoK8ekF+y77GTG8uLJKKV2PrlNjCB9E9VGdmazAvTsTqTz7g==
X-Google-Smtp-Source: AGHT+IGfwk3jzTRiBYAwhJMYbmokQo4wC510LsEPiGZNM3YBRp65mMEE4ApnAP6H+hPED/WI+A0z8A==
X-Received: by 2002:a5d:5e90:0:b0:37c:c892:a98c with SMTP id ffacd0b85a97d-381f188c972mr9779727f8f.56.1731348892446;
        Mon, 11 Nov 2024 10:14:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda05dfcsm13441800f8f.91.2024.11.11.10.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:14:51 -0800 (PST)
Message-Id: <pull.1826.git.1731348891108.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Nov 2024 18:14:50 +0000
Subject: [PATCH] doc: git-add.txt: convert to new style convention
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
    doc: git-add.txt: convert to new style convention

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1826%2Fjnavila%2Fnew_git_add-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1826/jnavila/new_git_add-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1826

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
