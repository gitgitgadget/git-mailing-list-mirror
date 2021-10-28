Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AFCC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6D9610CA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhJ1QYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhJ1QYe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:24:34 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45339C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u18so11205220wrg.5
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rsu4JXnQ4VB77OGtLFfCDO6+bo0XB0DURS5md8Bk8lo=;
        b=fiDNoRnl2vgrnJgsc0tSxc7QOOqj+2coVDfNfDH/5ju4ieJtH4+pNMJCFoN9je2yYu
         lFkC0uSK1EP8g89yUpuWX1TdCVla5jDisSX90OS4VqCIrWpiegxJ3bNqyVHFx3XIQelk
         +6AAY99WnXx0oP5QCj5M3hotUMT2jC3KYIAM4GNMHIKKjHJa0AqsraRGBCtH/eyh7KTm
         R9uD/jKXr7uPIjeX46gbs+VUwg6EZIKFicBpUwU+epVW0QsAs7gXJi4heeitYlwKnI2G
         A46dgR9ygARp68a9No18RNC9kbrgeDY5XiCWPAoBipVNQ7oPzEEJ125kueu461je34bc
         xT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rsu4JXnQ4VB77OGtLFfCDO6+bo0XB0DURS5md8Bk8lo=;
        b=cSUzeVcWV8oFHHYN2jUoweWHZeZ6281s688i/2LlIY2OJqGvG+BNVvlPCHwEjaBJ1r
         mb6v8ouv4yv51PLTwhlNKE/oARKNHNF9aswoPHiC7fgaa5BZzHX4ZEVMX2O4JcN+YEFe
         BeVsmdIJhyqQ3RMst+QJIKGXW2ZqhBnZqbp2g+nIvl94YZ7q9BiUy4UQigxszcqWHT4g
         Zrg54Fh1QtfsyZp9PGb0BCko6Y6zwDkqW3yJYN/qDdR7FQOVa+73Pe3nb8WDvh8+Da5B
         rFauQZ7hrY49yT3urp9pGUyszGvhbwzdgPmbxnqx5rxyN1GFCHCH23HegRNdaKUKsq0t
         cVYQ==
X-Gm-Message-State: AOAM532Py9iiaa26aueImzOyymMmWrkBxBz1HX+gds16PT+1Lh2cvVf+
        2wVcwHpr/I4nSusIVeqlKLEo7DzKUQg=
X-Google-Smtp-Source: ABdhPJzseADKdr+oKvu4enqAWho5Nf4pzh92YR9e9q9+OTvzeAQx3rF7parwPGkTLpOOM2nZw1Oj7w==
X-Received: by 2002:a05:6000:154b:: with SMTP id 11mr6969232wry.422.1635438125851;
        Thu, 28 Oct 2021 09:22:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm4186389wrx.17.2021.10.28.09.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:22:05 -0700 (PDT)
Message-Id: <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 16:21:55 +0000
Subject: [PATCH v2 0/9] doc: fix grammar rules in commands' syntax
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are command expressions which do not follow the grammar syntax rules.

According to the coding guidelines, the placeholders must:

 * be in small letters
 * enclosed in angle brackets
 * use hyphens as spaces

They also must represent tokens' meaning as atomic entities.

Some fixups for git-credential, git-ls-files, git-init and git-http-push.

changes since v1:

 * split changes across simpler commits

Signed-off-by: Jean-Noël Avila jn.avila@free.fr

Jean-Noël Avila (9):
  doc: fix git credential synopsis
  doc: split placeholders as individual tokens
  doc: express grammar placeholders between angle brackets
  doc: use only hyphens as word separators in placeholders
  doc: git-ls-files: express options as optional alternatives
  doc: use three dots for indicating repetition instead of star
  doc: uniformize <URL> placeholders' case
  doc: git-http-push: describe the refs as pattern pairs
  doc: git-init: clarify file modes in octal.

 Documentation/date-formats.txt        |  4 +--
 Documentation/git-archimport.txt      | 14 ++++----
 Documentation/git-checkout.txt        | 36 +++++++++----------
 Documentation/git-cherry-pick.txt     |  6 ++--
 Documentation/git-clone.txt           |  8 ++---
 Documentation/git-config.txt          | 46 ++++++++++++------------
 Documentation/git-credential.txt      |  2 +-
 Documentation/git-cvsexportcommit.txt |  4 +--
 Documentation/git-cvsimport.txt       |  8 ++---
 Documentation/git-diff-files.txt      |  2 +-
 Documentation/git-diff-index.txt      |  2 +-
 Documentation/git-diff-tree.txt       |  2 +-
 Documentation/git-fsck.txt            |  2 +-
 Documentation/git-gui.txt             |  2 +-
 Documentation/git-help.txt            |  6 ++--
 Documentation/git-http-fetch.txt      |  2 +-
 Documentation/git-http-push.txt       | 15 ++++----
 Documentation/git-init-db.txt         |  2 +-
 Documentation/git-init.txt            | 26 +++++++-------
 Documentation/git-log.txt             |  8 ++---
 Documentation/git-ls-files.txt        |  6 ++--
 Documentation/git-merge-index.txt     |  2 +-
 Documentation/git-p4.txt              |  8 ++---
 Documentation/git-pack-objects.txt    |  4 +--
 Documentation/git-pack-redundant.txt  |  2 +-
 Documentation/git-reflog.txt          |  4 +--
 Documentation/git-remote.txt          |  8 ++---
 Documentation/git-request-pull.txt    |  8 ++---
 Documentation/git-shortlog.txt        |  8 ++---
 Documentation/git-sparse-checkout.txt |  2 +-
 Documentation/git-stage.txt           |  2 +-
 Documentation/git-svn.txt             |  2 +-
 Documentation/git-web--browse.txt     |  2 +-
 Documentation/gitcredentials.txt      |  4 +--
 Documentation/gitsubmodules.txt       |  2 +-
 Documentation/gitworkflows.txt        |  6 ++--
 Documentation/pretty-formats.txt      | 52 +++++++++++++--------------
 Documentation/urls-remotes.txt        |  8 ++---
 builtin/credential.c                  |  2 +-
 39 files changed, 165 insertions(+), 164 deletions(-)


base-commit: 9d530dc0024503ab4218fe6c4395b8a0aa245478
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1066%2Fjnavila%2Ffix_manpages_placeholders-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1066/jnavila/fix_manpages_placeholders-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1066

Range-diff vs v1:

  -:  ----------- >  1:  4d1fa80d471 doc: fix git credential synopsis
  -:  ----------- >  2:  0045fe6faea doc: split placeholders as individual tokens
  1:  605236f6d49 !  3:  4d2d198f572 doc: fix grammar rules in commands'syntax
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    doc: fix grammar rules in commands'syntax
     +    doc: express grammar placeholders between angle brackets
      
     -    According to the coding guidelines, the placeholders must:
     -     * be in small letters
     -     * enclosed in angle brackets
     -
     -    Some other rules are also applied.
     +    This rules discerns user inputs from verbatim options in the
     +    synopsis.
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
     - ## Documentation/git-archimport.txt ##
     -@@ Documentation/git-archimport.txt: git-archimport - Import a GNU Arch repository into Git
     - SYNOPSIS
     - --------
     - [verse]
     --'git archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D depth] [-t tempdir]
     --               <archive/branch>[:<git-branch>] ...
     -+'git archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D <depth>] [-t <tempdir>]
     -+	       <archive>/<branch>[:<git-branch>]...
     - 
     - DESCRIPTION
     - -----------
     -
     - ## Documentation/git-checkout.txt ##
     -@@ Documentation/git-checkout.txt: SYNOPSIS
     - 'git checkout' [-q] [-f] [-m] [<branch>]
     - 'git checkout' [-q] [-f] [-m] --detach [<branch>]
     - 'git checkout' [-q] [-f] [-m] [--detach] <commit>
     --'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
     -+'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]
     - 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...
     - 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]
     - 'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
     -@@ Documentation/git-checkout.txt: You could omit `<branch>`, in which case the command degenerates to
     - rather expensive side-effects to show only the tracking information,
     - if exists, for the current branch.
     - 
     --'git checkout' -b|-B <new_branch> [<start point>]::
     -+'git checkout' -b|-B <new-branch> [<start-point>]::
     - 
     - 	Specifying `-b` causes a new branch to be created as if
     - 	linkgit:git-branch[1] were called and then checked out.  In
     -@@ Documentation/git-checkout.txt: as `ours` (i.e. "our shared canonical history"), while what you did
     - on your side branch as `theirs` (i.e. "one contributor's work on top
     - of it").
     - 
     ---b <new_branch>::
     -+-b <new-branch>::
     - 	Create a new branch named `<new_branch>` and start it at
     - 	`<start_point>`; see linkgit:git-branch[1] for details.
     - 
     ---B <new_branch>::
     -+-B <new-branch>::
     - 	Creates the branch `<new_branch>` and start it at `<start_point>`;
     - 	if it already exists, then reset it to `<start_point>`. This is
     - 	equivalent to running "git branch" with "-f"; see
     -
       ## Documentation/git-cherry-pick.txt ##
      @@ Documentation/git-cherry-pick.txt: git-cherry-pick - Apply the changes introduced by some existing commits
       SYNOPSIS
     @@ Documentation/git-config.txt: OPTIONS
      ---get-urlmatch name URL::
      +--get-urlmatch <name> <URL>::
       	When given a two-part name section.key, the value for
     - 	section.<url>.key whose <url> part matches the best to the
     +-	section.<url>.key whose <url> part matches the best to the
     ++	section.<URL>.key whose <URL> part matches the best to the
       	given URL is returned (if no such key exists, the value for
     + 	section.key is used as a fallback).  When given just the
     + 	section as name, do so for all the keys in the section and
      @@ Documentation/git-config.txt: See also <<FILES>>.
       	read from or written to if `extensions.worktreeConfig` is
       	present. If not it's the same as `--local`.
     @@ Documentation/git-config.txt: Valid `<type>`'s include:
      ---get-colorbool name [stdout-is-tty]::
      +--get-colorbool <name> [<stdout-is-tty>]::
       
     - 	Find the color setting for `name` (e.g. `color.diff`) and output
     - 	"true" or "false".  `stdout-is-tty` should be either "true" or
     -@@ Documentation/git-config.txt: Valid `<type>`'s include:
     +-	Find the color setting for `name` (e.g. `color.diff`) and output
     +-	"true" or "false".  `stdout-is-tty` should be either "true" or
     ++	Find the color setting for `<name>` (e.g. `color.diff`) and output
     ++	"true" or "false".  `<stdout-is-tty>` should be either "true" or
     + 	"false", and is taken into account when configuration says
     +-	"auto".  If `stdout-is-tty` is missing, then checks the standard
     ++	"auto".  If `<stdout-is-tty>` is missing, then checks the standard
     + 	output of the command itself, and exits with status 0 if color
     + 	is to be used, or exits with status 1 otherwise.
       	When the color setting for `name` is undefined, the command uses
       	`color.ui` as fallback.
       
     @@ Documentation/git-config.txt: Valid `<type>`'s include:
       
       	Find the color configured for `name` (e.g. `color.diff.new`) and
       	output it as the ANSI color escape sequence to the standard
     -
     - ## Documentation/git-credential.txt ##
     -@@ Documentation/git-credential.txt: git-credential - Retrieve and store user credentials
     - SYNOPSIS
     - --------
     - ------------------
     --git credential <fill|approve|reject>
     -+git credential [fill|approve|reject]
     - ------------------
     +@@ Documentation/git-config.txt: Valid `<type>`'s include:
       
     - DESCRIPTION
     + --default <value>::
     +   When using `--get`, and the requested variable is not found, behave as if
     +-  <value> were the value assigned to the that variable.
     ++  `<value>` were the value assigned to the that variable.
     + 
     + CONFIGURATION
     + -------------
      
       ## Documentation/git-cvsexportcommit.txt ##
      @@ Documentation/git-cvsexportcommit.txt: git-cvsexportcommit - Export a single commit to a CVS checkout
     @@ Documentation/git-cvsexportcommit.txt: git-cvsexportcommit - Export a single com
       
       DESCRIPTION
      
     - ## Documentation/git-cvsimport.txt ##
     -@@ Documentation/git-cvsimport.txt: git-cvsimport - Salvage your data out of another SCM people love to hate
     - SYNOPSIS
     - --------
     - [verse]
     --'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>]
     -+'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <cvsroot>]
     - 	      [-A <author-conv-file>] [-p <options-for-cvsps>] [-P <file>]
     --	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
     -+	      [-C <git-repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
     - 	      [-a] [-m] [-M <regex>] [-S <regex>] [-L <commitlimit>]
     --	      [-r <remote>] [-R] [<CVS_module>]
     -+	      [-r <remote>] [-R] [<CVS-module>]
     - 
     - 
     - DESCRIPTION
     -@@ Documentation/git-cvsimport.txt: OPTIONS
     - -v::
     - 	Verbosity: let 'cvsimport' report what it is doing.
     - 
     ---d <CVSROOT>::
     -+-d <cvsroot>::
     - 	The root of the CVS archive. May be local (a simple path) or remote;
     - 	currently, only the :local:, :ext: and :pserver: access methods
     - 	are supported. If not given, 'git cvsimport' will try to read it
     - 	from `CVS/Root`. If no such file exists, it checks for the
     - 	`CVSROOT` environment variable.
     - 
     --<CVS_module>::
     -+<CVS-module>::
     - 	The CVS module you want to import. Relative to <CVSROOT>.
     - 	If not given, 'git cvsimport' tries to read it from
     - 	`CVS/Repository`.
     -
     - ## Documentation/git-fsck.txt ##
     -@@ Documentation/git-fsck.txt: SYNOPSIS
     - 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
     - 	 [--[no-]full] [--strict] [--verbose] [--lost-found]
     - 	 [--[no-]dangling] [--[no-]progress] [--connectivity-only]
     --	 [--[no-]name-objects] [<object>*]
     -+	 [--[no-]name-objects] [<object>...]
     - 
     - DESCRIPTION
     - -----------
     -
       ## Documentation/git-gui.txt ##
      @@ Documentation/git-gui.txt: git-gui - A portable graphical interface to Git
       SYNOPSIS
     @@ Documentation/git-http-fetch.txt: git-http-fetch - Download from a remote Git re
       DESCRIPTION
       -----------
      
     - ## Documentation/git-http-push.txt ##
     -@@ Documentation/git-http-push.txt: of such patterns separated by a colon ":" (this means that a ref name
     - cannot have a colon in it).  A single pattern '<name>' is just a
     - shorthand for '<name>:<name>'.
     - 
     --Each pattern pair consists of the source side (before the colon)
     --and the destination side (after the colon).  The ref to be
     --pushed is determined by finding a match that matches the source
     --side, and where it is pushed is determined by using the
     --destination side.
     -+Each pattern pair '<src>:<dst>' consists of the source side (before
     -+the colon) and the destination side (after the colon).  The ref to be
     -+pushed is determined by finding a match that matches the source side,
     -+and where it is pushed is determined by using the destination side.
     - 
     -- - It is an error if <src> does not match exactly one of the
     -+ - It is an error if '<src>' does not match exactly one of the
     -    local refs.
     - 
     -- - If <dst> does not match any remote ref, either
     -+ - If '<dst>' does not match any remote ref, either
     - 
     -    * it has to start with "refs/"; <dst> is used as the
     -      destination literally in this case.
     -
     - ## Documentation/git-init-db.txt ##
     -@@ Documentation/git-init-db.txt: git-init-db - Creates an empty Git repository
     - SYNOPSIS
     - --------
     - [verse]
     --'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
     -+'git init-db' [-q | --quiet] [--bare] [--template=<template-directory>] [--separate-git-dir <git-dir>] [--shared[=<permissions>]]
     - 
     - 
     - DESCRIPTION
     -
       ## Documentation/git-init.txt ##
     -@@ Documentation/git-init.txt: git-init - Create an empty Git repository or reinitialize an existing one
     - SYNOPSIS
     - --------
     - [verse]
     --'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
     --	  [--separate-git-dir <git dir>] [--object-format=<format>]
     -+'git init' [-q | --quiet] [--bare] [--template=<template-directory>]
     -+	  [--separate-git-dir <git-dir>] [--object-format=<format>]
     +@@ Documentation/git-init.txt: SYNOPSIS
     + 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
     + 	  [--separate-git-dir <git dir>] [--object-format=<format>]
       	  [-b <branch-name> | --initial-branch=<branch-name>]
      -	  [--shared[=<permissions>]] [directory]
      +	  [--shared[=<permissions>]] [<directory>]
       
       
     - DESCRIPTION
     -@@ Documentation/git-init.txt: values are 'sha1' and (if enabled) 'sha256'.  'sha1' is the default.
     - +
     - include::object-format-disclaimer.txt[]
     - 
     ----template=<template_directory>::
     -+--template=<template-directory>::
     - 
     - Specify the directory from which templates will be used.  (See the "TEMPLATE
     - DIRECTORY" section below.)
     - 
     ----separate-git-dir=<git dir>::
     -+--separate-git-dir=<git-dir>::
     - 
     - Instead of initializing the repository as a directory to either `$GIT_DIR` or
     - `./.git/`, create a text file there containing the path to the actual
     -@@ Documentation/git-init.txt: repository.  If not specified, fall back to the default name (currently
     - `master`, but this is subject to change in the future; the name can be
     - customized via the `init.defaultBranch` configuration variable).
     - 
     ----shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
     -+--shared[=(false|true|umask|group|all|world|everybody|0<octal>)]::
     - 
     - Specify that the Git repository is to be shared amongst several users.  This
     - allows users belonging to the same group to push into that
     -@@ Documentation/git-init.txt: the repository permissions.
     - 
     - Same as 'group', but make the repository readable by all users.
     - 
     --'0xxx'::
     -+'0<octal>'::
     - 
     --'0xxx' is an octal number and each file will have mode '0xxx'. '0xxx' will
     --override users' umask(2) value (and not only loosen permissions as 'group' and
     --'all' does). '0640' will create a repository which is group-readable, but not
     --group-writable or accessible to others. '0660' will create a repo that is
     --readable and writable to the current user and group, but inaccessible to others.
     -+'0<octal>' is an octal number and each file will have mode
     -+'0<octal>'. '0<octal>' will override users' umask(2) value (and not
     -+only loosen permissions as 'group' and 'all' does). '0640' will create
     -+a repository which is group-readable, but not group-writable or
     -+accessible to others. '0660' will create a repo that is readable and
     -+writable to the current user and group, but inaccessible to others.
     - --
     - 
     - By default, the configuration flag `receive.denyNonFastForwards` is enabled
     -
     - ## Documentation/git-log.txt ##
     -@@ Documentation/git-log.txt: git-log - Show commit logs
     - SYNOPSIS
     - --------
     - [verse]
     --'git log' [<options>] [<revision range>] [[--] <path>...]
     -+'git log' [<options>] [<revision-range>] [[--] <path>...]
     - 
     - DESCRIPTION
     - -----------
     -@@ Documentation/git-log.txt: produced by `--stat`, etc.
     - 
     - include::line-range-options.txt[]
     - 
     --<revision range>::
     -+<revision-range>::
     - 	Show only commits in the specified revision range.  When no
     - 	<revision range> is specified, it defaults to `HEAD` (i.e. the
     - 	whole history leading to the current commit).  `origin..HEAD`
     -
     - ## Documentation/git-ls-files.txt ##
     -@@ Documentation/git-ls-files.txt: SYNOPSIS
     - --------
     - [verse]
     - 'git ls-files' [-z] [-t] [-v] [-f]
     --		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
     --		(-[c|d|o|i|s|u|k|m])*
     -+		[--(cached|deleted|others|ignored|stage|unmerged|killed|modified)...]
     -+		[-(c|d|o|i|s|u|k|m)...]
     - 		[--eol]
     - 		[--deduplicate]
     - 		[-x <pattern>|--exclude=<pattern>]
     -
     - ## Documentation/git-merge-index.txt ##
     -@@ Documentation/git-merge-index.txt: git-merge-index - Run a merge for files needing merging
     - SYNOPSIS
     - --------
     - [verse]
     --'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>*)
     -+'git merge-index' [-o] [-q] <merge-program> (-a | ( [--] <file>...) )
     - 
     - DESCRIPTION
     - -----------
     -
     - ## Documentation/git-p4.txt ##
     -@@ Documentation/git-p4.txt: git-p4 - Import from and submit to Perforce repositories
     - SYNOPSIS
     - --------
     - [verse]
     --'git p4 clone' [<sync options>] [<clone options>] <p4 depot path>...
     --'git p4 sync' [<sync options>] [<p4 depot path>...]
     -+'git p4 clone' [<sync-options>] [<clone-options>] <p4-depot-path>...
     -+'git p4 sync' [<sync-options>] [<p4-depot-path>...]
     - 'git p4 rebase'
     --'git p4 submit' [<submit options>] [<master branch name>]
     -+'git p4 submit' [<submit-options>] [<master-branch-name>]
     - 
     - 
       DESCRIPTION
      
       ## Documentation/git-pack-objects.txt ##
     @@ Documentation/git-pack-redundant.txt: git-pack-redundant - Find redundant pack f
       --------
       [verse]
      -'git pack-redundant' [ --verbose ] [ --alt-odb ] < --all | .pack filename ... >
     -+'git pack-redundant' [ --verbose ] [ --alt-odb ] ( --all | <.pack-filename>... )
     ++'git pack-redundant' [ --verbose ] [ --alt-odb ] ( --all | <pack-filename>... )
       
       DESCRIPTION
       -----------
     @@ Documentation/git-reflog.txt: The command takes various subcommands, and differe
       
       Reference logs, or "reflogs", record when the tips of branches and
      
     - ## Documentation/git-shortlog.txt ##
     -@@ Documentation/git-shortlog.txt: git-shortlog - Summarize 'git log' output
     - SYNOPSIS
     - --------
     - [verse]
     --'git shortlog' [<options>] [<revision range>] [[--] <path>...]
     -+'git shortlog' [<options>] [<revision-range>] [[--] <path>...]
     - git log --pretty=short | 'git shortlog' [<options>]
     - 
     - DESCRIPTION
     -@@ Documentation/git-shortlog.txt: counts both authors and co-authors.
     - If width is `0` (zero) then indent the lines of the output without wrapping
     - them.
     - 
     --<revision range>::
     -+<revision-range>::
     - 	Show only commits in the specified revision range.  When no
     - 	<revision range> is specified, it defaults to `HEAD` (i.e. the
     - 	whole history leading to the current commit).  `origin..HEAD`
     -
       ## Documentation/git-sparse-checkout.txt ##
      @@ Documentation/git-sparse-checkout.txt: given by a list of patterns.
       SYNOPSIS
       --------
       [verse]
      -'git sparse-checkout <subcommand> [options]'
     -+'git sparse-checkout <subcommand> [<options>...]'
     ++'git sparse-checkout <subcommand> [<options>]'
       
       
       DESCRIPTION
     @@ Documentation/git-stage.txt: git-stage - Add file contents to the staging area
       
       
       DESCRIPTION
     -
     - ## Documentation/git-web--browse.txt ##
     -@@ Documentation/git-web--browse.txt: git-web--browse - Git helper script to launch a web browser
     - SYNOPSIS
     - --------
     - [verse]
     --'git web{litdd}browse' [<options>] <url|file>...
     -+'git web{litdd}browse' [<options>] (<url>|<file>)...
     - 
     - DESCRIPTION
     - -----------
  -:  ----------- >  4:  984b6d687a2 doc: use only hyphens as word separators in placeholders
  -:  ----------- >  5:  8e078e6ea17 doc: git-ls-files: express options as optional alternatives
  -:  ----------- >  6:  0c7b1d53808 doc: use three dots for indicating repetition instead of star
  -:  ----------- >  7:  8f85da3bb4a doc: uniformize <URL> placeholders' case
  -:  ----------- >  8:  20900b019f8 doc: git-http-push: describe the refs as pattern pairs
  -:  ----------- >  9:  7eef3538f3c doc: git-init: clarify file modes in octal.

-- 
gitgitgadget
