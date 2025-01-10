Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8571E200F
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503711; cv=none; b=EZuLp0V1fEXF4+q4S/aDGBY7NUlmYYnBiXtHermp+uiT9Y/WvK3JuH/zWX6gXAhABlkNwB3jTvy9DLizYnolOxy2gCmf7pqaxBCDJ5qd8j6mgOJE/PtKZz0M+tQV8N8UopZnyRHpnZJoDMGgjFmbwJipXQV9cUA5SCf9hFxcrwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503711; c=relaxed/simple;
	bh=HcY5vx/ZVK+wWeOarWyAjnQgiHY4B/fPwmFJ4u8ltFo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=rFkG0wlnQ/hKgwvogDm6MzjA8X0h4b1K52heCWjeoQGXV1Y5H0xZUsrCiGObBM0MaHyzHIiTwOYSGATdVyctJT2BD4PDaR0jM/wIKpF5Kxodhv660bYl/Sd7Uyfn/sIpc/8hCnxJqLssMmrWVca3sD9Mv/77EiOovGNPcKdsvMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LReL6noR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LReL6noR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43623f0c574so14034215e9.2
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 02:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736503706; x=1737108506; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhiibeNNn5d+rsXmZsCR+kE0Q0A/fUcZdg6NbL8G6AA=;
        b=LReL6noRZKW7nSTQhth1dNjFccPBTQuUBh7EZ14JaYh+lCU9nqUrkeROsvzLQwTj9b
         YEENAp9yGB+61TD74hxOu6LEeeLJr/61Y5Gjgmbso9JEJK9z6ivDzEInJdqbF64bKIyq
         HTJYfoIbYS18WpiRYqwB+WLrWHsSYKL22JRBhH2M3YzXLORcxTVT1Ax6iDs4GPGEtskk
         5QLyUhSEU06Y4FAeucbsFaIz5WmtdYZPVbjytwPgaBKL3eOmnZhsspewr2HE+9eTcLGN
         HwH4dzik9Z7leRjs62PwCisUsCpKk3lxnj96Bb/YO9IH4StiYle1q+jyPHGcYw2LuTpQ
         xQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736503706; x=1737108506;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhiibeNNn5d+rsXmZsCR+kE0Q0A/fUcZdg6NbL8G6AA=;
        b=n0VMKpVSyfBKt0c/3ektn8A99xxLxa0fECszGGRsXOY2GrqJlROGjNP6YfVHFWsGP6
         dPnY3MxjbD9roLe00JkT04PtLhv3aBvvVhjkETQERBOYwujlckEkHfy1YW7U134HerIt
         1b2AXlzaedPL2UEuIB0Q80/wlPo0UcZ5uISQJMt+Z+CDVbgRhQ/+uQpgQdd7/d1Dqr76
         I6yD0X6U3RzLmG27G0C8/OqlbZtk+3ij8GoAQerm10ebq0xnlTaCh0GrYkFvGhRJfSNF
         0+qUbLmK/OUwnEOSWC7Q4JP8wYwPjUKeji9NdY8g+S1fboW4QWd/RWEfoaaJ6fEqEFRC
         Dfgw==
X-Gm-Message-State: AOJu0YzCeF59e182fieYLt6MEo976lQ2KcvnUaCMf4Wic+CIj+wp7qIV
	qUBHTAENJafFo+VSbF94Rf8dMmOvIpoi8t8Q06o6vXAfes+D7VkuvbRVAw==
X-Gm-Gg: ASbGnctBlJky8PrJZC4K1Fdsk+vOrBCIurSc0qVOEx4RcQjmE+YxYHc+VsE/JRo/Ff9
	23lON+ohiSfpGUtxplYCJiS1PG+YFbbW//itHmZl3yT6yj6UJlfg15ptBeMsHvwGxYxeemr0D22
	MPbYlzFcEBQ9ZWCEABu/Id34joUByNVtqscaCjbWsuto0RcHWepghoswY6Z8EKQJ1PR1/DgehWN
	kNGIiVky31jJOPugklfTx0GPPEqyBUfR+I2MVRRKL8ShBC1gaN5lyp1/g==
X-Google-Smtp-Source: AGHT+IHaK9gyTfL3Y3oY5Cp8wNP2FDuTPt4V9d7XH1i6FnldZajJQSeB1AyoxXcxHGwSW+ac5cMZHA==
X-Received: by 2002:a05:6000:1869:b0:38a:8b2c:53ad with SMTP id ffacd0b85a97d-38a8b2c5601mr6114546f8f.39.1736503705479;
        Fri, 10 Jan 2025 02:08:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d111sm4227262f8f.18.2025.01.10.02.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:08:24 -0800 (PST)
Message-Id: <pull.1846.v2.git.1736503703573.gitgitgadget@gmail.com>
In-Reply-To: <pull.1846.git.1735924216993.gitgitgadget@gmail.com>
References: <pull.1846.git.1735924216993.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jan 2025 10:08:23 +0000
Subject: [PATCH v2] doc: convert git-notes to new documentation format
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
    doc: git-notes.txt: migrate to new documentation format
    
    cc: Patrick Steinhardt ps@pks.im

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1846%2Fjnavila%2Fgit-notes-new-format-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1846/jnavila/git-notes-new-format-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1846

Range-diff vs v1:

 1:  7923846fb09 ! 1:  9c815abd55a doc: git-notes.txt: migrate to new documentation format
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    doc: git-notes.txt: migrate to new documentation format
     +    doc: convert git-notes to new documentation format
      
     -    The git-notes manpage files were converted to the new documentation
     -    format:
     -
     -    - switching the synopsis to a synopsis block which will automatically
     +    - Switch the synopsis to a synopsis block which will automatically
            format placeholders in italics and keywords in monospace
     -    - use _<placeholder>_ instead of <placeholder> in the description
     -    - use `backticks for keywords and more complex option
     -    descriptions`. The new rendering engine will apply synopsis rules to
     +    - Use _<placeholder>_ instead of <placeholder> in the description
     +    - Use `backticks` for keywords and more complex option
     +    descriptions. The new rendering engine will apply synopsis rules to
          these spans.
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
     @@ Documentation/config/notes.txt: globs.
       +
      -This setting can be disabled by the `--no-notes` option to the 'git
      -log' family of commands, or by the `--notes=<ref>` option accepted by
     -+This setting can be disabled by the `--no-notes` option to the `git
     -+log` family of commands, or by the `--notes=<ref>` option accepted by
     ++This setting can be disabled by the `--no-notes` option to the linkgit:git-log[1]
     ++family of commands, or by the `--notes=<ref>` option accepted by
       those commands.
       +
      -The effective value of "core.notesRef" (possibly overridden by
     @@ Documentation/git-notes.txt: ENVIRONMENT sections below.  If this ref does not e
       the original commit message. To distinguish these notes from the
       message stored in the commit object, the notes are indented like the
      -message, after an unindented line saying "Notes (<refname>):" (or
     --"Notes:" for `refs/notes/commits`).
     -+message, after an unindented line saying "`Notes (<refname>):`" (or
     -+"`Notes:`" for `refs/notes/commits`).
     ++message, after an unindented line saying "Notes (_<refname>_):" (or
     + "Notes:" for `refs/notes/commits`).
       
       Notes can also be added to patches prepared with `git format-patch` by
       using the `--notes` option. Such notes are added as a patch commentary


 Documentation/config/notes.txt |  32 +++---
 Documentation/git-notes.txt    | 191 +++++++++++++++++----------------
 2 files changed, 112 insertions(+), 111 deletions(-)

diff --git a/Documentation/config/notes.txt b/Documentation/config/notes.txt
index 43db8e808d7..b7e536496f5 100644
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
+This setting can be disabled by the `--no-notes` option to the linkgit:git-log[1]
+family of commands, or by the `--notes=<ref>` option accepted by
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
index 84022f99d76..5c8e6ff5660 100644
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
+message, after an unindented line saying "Notes (_<refname>_):" (or
 "Notes:" for `refs/notes/commits`).
 
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
