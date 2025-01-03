Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E6746B5
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735924223; cv=none; b=Rf1X6xyci1cHeSEcymjrUcttunY4KO1aVaJLgH4JqIMztHMS9L4aHzN0cqfjS7OIiivOcjdYFOtrvE1MTfV8diznoekSI0bAohdAKVjfdUNvsCt4yJQegFoGxUSP5vxvpvlK/bUoDDaaLZoB1qFYeovISs3JqSWGP4ikmd0fcbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735924223; c=relaxed/simple;
	bh=MKVsbVMnWmReqDG1Oo+r45y8wI25/Qstpt2VhnpWmEw=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=ek38ugC1f0OthJ7zG9vJ9v1uc2Fsyd+Cn91oWRuQQav5vzIjIDcQO1OgtAebdzAOIPTTpmdKv1T9KPDMpQx2pbL4qAcGeoY0QMZ0utx2AH+j9+U6PHhVfzmKCmGQve53HkEa/ZL/Bh69c93UXALcKlOKyYnt/lUVFycbBWf25Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgL0uWBO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgL0uWBO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436341f575fso129193625e9.1
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 09:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735924218; x=1736529018; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KFV5WbM+eNZi3Rh4H8Pwi8xlwr9GtfJMdjBAWU/dg7c=;
        b=EgL0uWBO2I98NUiSDklI1JiXYxbWx9a77QeUy8Wt9IIJkmbZaQ2pqJ8ChOx66X6k4Q
         OGZU9gt+szRBBiLdvRl+jadVSmf0b2kF6dP+R3e7yT1my44gjdqZVORat2Bv/TafpGkZ
         GzN8ZX8VFFjcQGc0+UwXBF4RvN4Bnp63VPlz6Kaf42oRBmhOknQ0Su/OZSvI0QARzmTV
         dJs1ocnM5DFxLzm4EI8KREdBucsWZ3OlXez2SkO7TuCl7aNlogs6j/c+jQVCTEd7ui9r
         IwNX8wjHTooIo3DR7OYeNkO6jjBr9tetiLnpaSjk+FEa/2swWj731kiyP/LhO86rjHNz
         FDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735924218; x=1736529018;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFV5WbM+eNZi3Rh4H8Pwi8xlwr9GtfJMdjBAWU/dg7c=;
        b=M2a5YdKj/+c0dN5xyrM3b7FgOvZLlVD7n/qfXpIQ4cvONjc9cLAboR9yOvvv9AwROF
         rAPuOTr/IgiqKsS3KQEw+drC91zZZiD384JS8dm5bvL5/XVjwxxJZtjTPxqpJTm5aoRJ
         /XzU541Bo3vXqJEwBKsIJDZ7kNhVKkvdhoc/lamnHCJGyIZTsAZK1DAqo6RDoMN00tpb
         1XYc4V1CjJI2ixnq3ntTPbrWwkwYCf4ulKm4H9MDYuzzQivYTGZzUu60fdWSfRhrPY9Y
         qxyogrbk6PZohn0FZW7KO5Th8SL+FjoLsB0nFCmSp7iq6X+cYG5J+2pQvUtZ4b9chun5
         hT3g==
X-Gm-Message-State: AOJu0YzQ19hLq6zrJLP70HwOrHE1XZ/1U9bakpvaM++hiuUSqkjuMr5R
	p+irWANyvvBtixGfkuYjMt6URcY7UIKsfOGTsuCDRamdQR0VXbqQIi/Owg==
X-Gm-Gg: ASbGncuZ31UDdjTN/0pq2Gn1SAXQ9NE6v8J5Lt9JcS0XtPHNqzoSMu+mr90bjs1utfZ
	HiTktag+igWYX2G6iVLorhj2mxIBCyUgBcQij28NKuvMmUKSkBaXeLYTIkC9O3kGmV2VkXhk3iQ
	J4UqeognOIlTbYMY2kIxpcjpWl8K8cc/S2aJsMmfSWDz4qyZ5+N3wLRpBPncONzRHE76Psp/Vq/
	EQCyCFLMVtkUy51cbVmISmxZn2Lp4RdMOlvjDNU2o0IjwIzxTSbskWpjQ==
X-Google-Smtp-Source: AGHT+IFgSsbIpIlU2NJ3caQDeu20EZ9VXMMzvdbv7y6rutci151ZmN+VXa6veiHcnB5xo50/+DI9lg==
X-Received: by 2002:a05:600c:35c9:b0:434:f753:6012 with SMTP id 5b1f17b1804b1-436686440bemr464032625e9.17.1735924218047;
        Fri, 03 Jan 2025 09:10:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a08sm493721775e9.25.2025.01.03.09.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 09:10:17 -0800 (PST)
Message-Id: <pull.1846.git.1735924216993.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Jan 2025 17:10:16 +0000
Subject: [PATCH] doc: git-notes.txt: migrate to new documentation format
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

The git-notes manpage files were converted to the new documentation
format:

- switching the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- use _<placeholder>_ instead of <placeholder> in the description
- use `backticks for keywords and more complex option
descriptions`. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
    doc: git-notes.txt: migrate to new documentation format

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1846%2Fjnavila%2Fgit-notes-new-format-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1846/jnavila/git-notes-new-format-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1846

 Documentation/config/notes.txt |  32 +++---
 Documentation/git-notes.txt    | 193 +++++++++++++++++----------------
 2 files changed, 113 insertions(+), 112 deletions(-)

diff --git a/Documentation/config/notes.txt b/Documentation/config/notes.txt
index 43db8e808d7..70859f5c574 100644
--- a/Documentation/config/notes.txt
+++ b/Documentation/config/notes.txt
@@ -1,4 +1,4 @@
-notes.mergeStrategy::
+`notes.mergeStrategy`::
 	Which merge strategy to choose by default when resolving notes
 	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
 	`cat_sort_uniq`.  Defaults to `manual`.  See the "NOTES MERGE STRATEGIES"
@@ -7,17 +7,17 @@ notes.mergeStrategy::
 This setting can be overridden by passing the `--strategy` option to
 linkgit:git-notes[1].
 
-notes.<name>.mergeStrategy::
+`notes.<name>.mergeStrategy`::
 	Which merge strategy to choose when doing a notes merge into
-	refs/notes/<name>.  This overrides the more general
-	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section in
+	`refs/notes/<name>`.  This overrides the more general
+	`notes.mergeStrategy`.  See the "NOTES MERGE STRATEGIES" section in
 	linkgit:git-notes[1] for more information on the available strategies.
 
-notes.displayRef::
+`notes.displayRef`::
 	Which ref (or refs, if a glob or specified more than once), in
 	addition to the default set by `core.notesRef` or
 	`GIT_NOTES_REF`, to read notes from when showing commit
-	messages with the 'git log' family of commands.
+	messages with the `git log` family of commands.
 +
 This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
 environment variable, which must be a colon separated list of refs or
@@ -26,27 +26,27 @@ globs.
 A warning will be issued for refs that do not exist,
 but a glob that does not match any refs is silently ignored.
 +
-This setting can be disabled by the `--no-notes` option to the 'git
-log' family of commands, or by the `--notes=<ref>` option accepted by
+This setting can be disabled by the `--no-notes` option to the `git
+log` family of commands, or by the `--notes=<ref>` option accepted by
 those commands.
 +
-The effective value of "core.notesRef" (possibly overridden by
-GIT_NOTES_REF) is also implicitly added to the list of refs to be
+The effective value of `core.notesRef` (possibly overridden by
+`GIT_NOTES_REF`) is also implicitly added to the list of refs to be
 displayed.
 
-notes.rewrite.<command>::
-	When rewriting commits with <command> (currently `amend` or
+`notes.rewrite.<command>`::
+	When rewriting commits with _<command>_ (currently `amend` or
 	`rebase`), if this variable is `false`, git will not copy
 	notes from the original to the rewritten commit.  Defaults to
-	`true`.  See also "`notes.rewriteRef`" below.
+	`true`.  See also `notes.rewriteRef` below.
 +
 This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
 environment variable, which must be a colon separated list of refs or
 globs.
 
-notes.rewriteMode::
+`notes.rewriteMode`::
 	When copying notes during a rewrite (see the
-	"notes.rewrite.<command>" option), determines what to do if
+	`notes.rewrite.<command>` option), determines what to do if
 	the target commit already has a note.  Must be one of
 	`overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
 	Defaults to `concatenate`.
@@ -54,7 +54,7 @@ notes.rewriteMode::
 This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
 environment variable.
 
-notes.rewriteRef::
+`notes.rewriteRef`::
 	When copying notes during a rewrite, specifies the (fully
 	qualified) ref whose notes should be copied.  May be a glob,
 	in which case notes in all matching refs will be copied.  You
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 84022f99d76..02a3495986a 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -7,19 +7,19 @@ git-notes - Add or inspect object notes
 
 SYNOPSIS
 --------
-[verse]
-'git notes' [list [<object>]]
-'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [-e] [<object>]
-'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
-'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [-e] [<object>]
-'git notes' edit [--allow-empty] [<object>] [--[no-]stripspace]
-'git notes' show [<object>]
-'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
-'git notes' merge --commit [-v | -q]
-'git notes' merge --abort [-v | -q]
-'git notes' remove [--ignore-missing] [--stdin] [<object>...]
-'git notes' prune [-n] [-v]
-'git notes' get-ref
+[synopsis]
+git notes [list [<object>]]
+git notes add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [-e] [<object>]
+git notes copy [-f] ( --stdin | <from-object> [<to-object>] )
+git notes append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [-e] [<object>]
+git notes edit [--allow-empty] [<object>] [--[no-]stripspace]
+git notes show [<object>]
+git notes merge [-v | -q] [-s <strategy> ] <notes-ref>
+git notes merge --commit [-v | -q]
+git notes merge --abort [-v | -q]
+git notes remove [--ignore-missing] [--stdin] [<object>...]
+git notes prune [-n] [-v]
+git notes get-ref
 
 
 DESCRIPTION
@@ -33,34 +33,34 @@ ENVIRONMENT sections below.  If this ref does not exist, it will be
 quietly created when it is first needed to store a note.
 
 A typical use of notes is to supplement a commit message without
-changing the commit itself. Notes can be shown by 'git log' along with
+changing the commit itself. Notes can be shown by `git log` along with
 the original commit message. To distinguish these notes from the
 message stored in the commit object, the notes are indented like the
-message, after an unindented line saying "Notes (<refname>):" (or
-"Notes:" for `refs/notes/commits`).
+message, after an unindented line saying "`Notes (<refname>):`" (or
+"`Notes:`" for `refs/notes/commits`).
 
 Notes can also be added to patches prepared with `git format-patch` by
 using the `--notes` option. Such notes are added as a patch commentary
 after a three dash separator line.
 
-To change which notes are shown by 'git log', see the
-"notes.displayRef" discussion in <<CONFIGURATION>>.
+To change which notes are shown by `git log`, see the
+`notes.displayRef` discussion in <<CONFIGURATION,CONFIGURATION>>.
 
-See the "notes.rewrite.<command>" configuration for a way to carry
+See the `notes.rewrite.<command>` configuration for a way to carry
 notes across commands that rewrite commits.
 
 
 SUBCOMMANDS
 -----------
 
-list::
+`list`::
 	List the notes object for a given object. If no object is
 	given, show a list of all note objects and the objects they
-	annotate (in the format "<note-object> <annotated-object>").
+	annotate (in the format "`<note-object> <annotated-object>`").
 	This is the default subcommand if no subcommand is given.
 
-add::
-	Add notes for a given object (defaults to HEAD). Abort if the
+`add`::
+	Add notes for a given object (defaults to `HEAD`). Abort if the
 	object already has notes (use `-f` to overwrite existing notes).
 	However, if you're using `add` interactively (using an editor
 	to supply the notes contents), then - instead of aborting -
@@ -71,10 +71,10 @@ add::
 	fine-tune the message(s) supplied from `-m` and `-F` options
 	interactively (using an editor) before adding the note.
 
-copy::
+`copy`::
 	Copy the notes for the first object onto the second object (defaults to
-	HEAD). Abort if the second object already has notes, or if the first
-	object has none (use -f to overwrite existing notes to the
+	`HEAD`). Abort if the second object already has notes, or if the first
+	object has none (use `-f` to overwrite existing notes to the
 	second object). This subcommand is equivalent to:
 	`git notes add [-f] -C $(git notes list <from-object>) <to-object>`
 +
@@ -84,27 +84,27 @@ In `--stdin` mode, take lines in the format
 <from-object> SP <to-object> [ SP <rest> ] LF
 ----------
 +
-on standard input, and copy the notes from each <from-object> to its
-corresponding <to-object>.  (The optional `<rest>` is ignored so that
+on standard input, and copy the notes from each _<from-object>_ to its
+corresponding _<to-object>_.  (The optional _<rest>_ is ignored so that
 the command can read the input given to the `post-rewrite` hook.)
 
-append::
+`append`::
 	Append new message(s) given by `-m` or `-F` options to an
 	existing note, or add them as a new note if one does not
-	exist, for the object (defaults to HEAD).  When appending to
+	exist, for the object (defaults to `HEAD`).  When appending to
 	an existing note, a blank line is added before each new
 	message as an inter-paragraph separator.  The separator can
 	be customized with the `--separator` option.
 	Edit the notes to be appended given by `-m` and `-F` options with
 	`-e` interactively (using an editor) before appending the note.
 
-edit::
-	Edit the notes for a given object (defaults to HEAD).
+`edit`::
+	Edit the notes for a given object (defaults to `HEAD`).
 
-show::
-	Show the notes for a given object (defaults to HEAD).
+`show`::
+	Show the notes for a given object (defaults to `HEAD`).
 
-merge::
+`merge`::
 	Merge the given notes ref into the current notes ref.
 	This will try to merge the changes made by the given
 	notes ref (called "remote") since the merge-base (if
@@ -112,35 +112,35 @@ merge::
 +
 If conflicts arise and a strategy for automatically resolving
 conflicting notes (see the "NOTES MERGE STRATEGIES" section) is not given,
-the "manual" resolver is used. This resolver checks out the
+the `manual` resolver is used. This resolver checks out the
 conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
 and instructs the user to manually resolve the conflicts there.
 When done, the user can either finalize the merge with
-'git notes merge --commit', or abort the merge with
-'git notes merge --abort'.
+`git notes merge --commit`, or abort the merge with
+`git notes merge --abort`.
 
-remove::
-	Remove the notes for given objects (defaults to HEAD). When
+`remove`::
+	Remove the notes for given objects (defaults to `HEAD`). When
 	giving zero or one object from the command line, this is
 	equivalent to specifying an empty note message to
 	the `edit` subcommand.
 
-prune::
+`prune`::
 	Remove all notes for non-existing/unreachable objects.
 
-get-ref::
+`get-ref`::
 	Print the current notes ref. This provides an easy way to
 	retrieve the current notes ref (e.g. from scripts).
 
 OPTIONS
 -------
--f::
---force::
+`-f`::
+`--force`::
 	When adding notes to an object that already has notes,
 	overwrite the existing notes (instead of aborting).
 
--m <msg>::
---message=<msg>::
+`-m <msg>`::
+`--message=<msg>`::
 	Use the given note message (instead of prompting).
 	If multiple `-m` options are given, their values
 	are concatenated as separate paragraphs.
@@ -148,95 +148,96 @@ OPTIONS
 	single line between paragraphs will be stripped out.
 	If you wish to keep them verbatim, use `--no-stripspace`.
 
--F <file>::
---file=<file>::
-	Take the note message from the given file.  Use '-' to
+`-F <file>`::
+`--file=<file>`::
+	Take the note message from the given file.  Use `-` to
 	read the note message from the standard input.
 	Lines starting with `#` and empty lines other than a
 	single line between paragraphs will be stripped out.
 	If you wish to keep them verbatim, use `--no-stripspace`.
 
--C <object>::
---reuse-message=<object>::
+`-C <object>`::
+`--reuse-message=<object>`::
 	Take the given blob object (for example, another note) as the
 	note message. (Use `git notes copy <object>` instead to
 	copy notes between objects.).  By default, message will be
 	copied verbatim, but if you wish to strip out the lines
 	starting with `#` and empty lines other than a single line
-	between paragraphs, use with`--stripspace` option.
+	between paragraphs, use with `--stripspace` option.
 
--c <object>::
---reedit-message=<object>::
-	Like '-C', but with `-c` the editor is invoked, so that
+`-c <object>`::
+`--reedit-message=<object>`::
+	Like `-C`, but with `-c` the editor is invoked, so that
 	the user can further edit the note message.
 
---allow-empty::
+`--allow-empty`::
 	Allow an empty note object to be stored. The default behavior is
 	to automatically remove empty notes.
 
---[no-]separator, --separator=<paragraph-break>::
+`--[no-]separator`::
+`--separator=<paragraph-break>`::
 	Specify a string used as a custom inter-paragraph separator
 	(a newline is added at the end as needed). If `--no-separator`, no
 	separators will be added between paragraphs.  Defaults to a blank
 	line.
 
---[no-]stripspace::
+`--[no-]stripspace`::
 	Strip leading and trailing whitespace from the note message.
 	Also strip out empty lines other than a single line between
 	paragraphs. Lines starting with `#` will be stripped out
 	in non-editor cases like `-m`, `-F` and `-C`, but not in
 	editor case like `git notes edit`, `-c`, etc.
 
---ref <ref>::
-	Manipulate the notes tree in <ref>.  This overrides
-	`GIT_NOTES_REF` and the "core.notesRef" configuration.  The ref
+`--ref <ref>`::
+	Manipulate the notes tree in _<ref>_.  This overrides
+	`GIT_NOTES_REF` and the `core.notesRef` configuration.  The ref
 	specifies the full refname when it begins with `refs/notes/`; when it
 	begins with `notes/`, `refs/` and otherwise `refs/notes/` is prefixed
 	to form a full name of the ref.
 
---ignore-missing::
+`--ignore-missing`::
 	Do not consider it an error to request removing notes from an
 	object that does not have notes attached to it.
 
---stdin::
+`--stdin`::
 	Also read the object names to remove notes from the standard
 	input (there is no reason you cannot combine this with object
 	names from the command line).
 
--n::
---dry-run::
+`-n`::
+`--dry-run`::
 	Do not remove anything; just report the object names whose notes
 	would be removed.
 
--s <strategy>::
---strategy=<strategy>::
+`-s <strategy>`::
+`--strategy=<strategy>`::
 	When merging notes, resolve notes conflicts using the given
-	strategy. The following strategies are recognized: "manual"
-	(default), "ours", "theirs", "union" and "cat_sort_uniq".
-	This option overrides the "notes.mergeStrategy" configuration setting.
+	strategy. The following strategies are recognized: `manual`
+	(default), `ours`, `theirs`, `union` and `cat_sort_uniq`.
+	This option overrides the `notes.mergeStrategy` configuration setting.
 	See the "NOTES MERGE STRATEGIES" section below for more
 	information on each notes merge strategy.
 
---commit::
-	Finalize an in-progress 'git notes merge'. Use this option
-	when you have resolved the conflicts that 'git notes merge'
-	stored in .git/NOTES_MERGE_WORKTREE. This amends the partial
-	merge commit created by 'git notes merge' (stored in
-	.git/NOTES_MERGE_PARTIAL) by adding the notes in
-	.git/NOTES_MERGE_WORKTREE. The notes ref stored in the
-	.git/NOTES_MERGE_REF symref is updated to the resulting commit.
-
---abort::
-	Abort/reset an in-progress 'git notes merge', i.e. a notes merge
+`--commit`::
+	Finalize an in-progress `git notes merge`. Use this option
+	when you have resolved the conflicts that `git notes merge`
+	stored in `.git/NOTES_MERGE_WORKTREE`. This amends the partial
+	merge commit created by `git notes merge` (stored in
+	`.git/NOTES_MERGE_PARTIAL`) by adding the notes in
+	`.git/NOTES_MERGE_WORKTREE`. The notes ref stored in the
+	`.git/NOTES_MERGE_REF` symref is updated to the resulting commit.
+
+`--abort`::
+	Abort/reset an in-progress `git notes merge`, i.e. a notes merge
 	with conflicts. This simply removes all files related to the
 	notes merge.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	When merging notes, operate quietly.
 
--v::
---verbose::
+`-v`::
+`--verbose`::
 	When merging notes, be more verbose.
 	When pruning notes, report all object names whose notes are
 	removed.
@@ -270,28 +271,28 @@ object, in which case the history of the notes can be read with
 NOTES MERGE STRATEGIES
 ----------------------
 
-The default notes merge strategy is "manual", which checks out
+The default notes merge strategy is `manual`, which checks out
 conflicting notes in a special work tree for resolving notes conflicts
 (`.git/NOTES_MERGE_WORKTREE`), and instructs the user to resolve the
 conflicts in that work tree.
 When done, the user can either finalize the merge with
-'git notes merge --commit', or abort the merge with
-'git notes merge --abort'.
+`git notes merge --commit`, or abort the merge with
+`git notes merge --abort`.
 
 Users may select an automated merge strategy from among the following using
-either -s/--strategy option or configuring notes.mergeStrategy accordingly:
+either `-s`/`--strategy` option or configuring `notes.mergeStrategy` accordingly:
 
-"ours" automatically resolves conflicting notes in favor of the local
+`ours` automatically resolves conflicting notes in favor of the local
 version (i.e. the current notes ref).
 
-"theirs" automatically resolves notes conflicts in favor of the remote
+`theirs` automatically resolves notes conflicts in favor of the remote
 version (i.e. the given notes ref being merged into the current notes
 ref).
 
-"union" automatically resolves notes conflicts by concatenating the
+`union` automatically resolves notes conflicts by concatenating the
 local and remote versions.
 
-"cat_sort_uniq" is similar to "union", but in addition to concatenating
+`cat_sort_uniq` is similar to `union`, but in addition to concatenating
 the local and remote versions, this strategy also sorts the resulting
 lines, and removes duplicate lines from the result. This is equivalent
 to applying the "cat | sort | uniq" shell pipeline to the local and
@@ -320,7 +321,7 @@ Notes:
 
 In principle, a note is a regular Git blob, and any kind of
 (non-)format is accepted.  You can binary-safely create notes from
-arbitrary files using 'git hash-object':
+arbitrary files using `git hash-object`:
 
 ------------
 $ cc *.c
@@ -331,7 +332,7 @@ $ git notes --ref=built add --allow-empty -C "$blob" HEAD
 (You cannot simply use `git notes --ref=built add -F a.out HEAD`
 because that is not binary-safe.)
 Of course, it doesn't make much sense to display non-text-format notes
-with 'git log', so if you use such notes, you'll probably need to write
+with `git log`, so if you use such notes, you'll probably need to write
 some special-purpose tools to do something useful with them.
 
 
@@ -339,7 +340,7 @@ some special-purpose tools to do something useful with them.
 CONFIGURATION
 -------------
 
-core.notesRef::
+`core.notesRef`::
 	Notes ref to read and manipulate instead of
 	`refs/notes/commits`.  Must be an unabbreviated ref name.
 	This setting can be overridden through the environment and

base-commit: 1b4e9a5f8b5f048972c21fe8acafe0404096f694
-- 
gitgitgadget
