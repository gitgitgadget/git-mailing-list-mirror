Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43C7C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EDA610CF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhJ1QYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhJ1QYg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:24:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62D4C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m22so11280073wrb.0
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=vJpk0gvCUpmiiPNgbxKn6wumM8Jsy49YCCt2EBK+St0=;
        b=OnCaBGoHPPNF5Dp3JmSijDUDlT1HisBX/52Jn7v5HNfpPk1oVtQm/QNcEGhaYttyk5
         4U4GDlkkXciV0nTDb59XMe90pLYyM94EiqL050KP5+LDplofDQmo+eQ036Kj6v1BJWYi
         naN5taYihCVFx3lT+iD9ZNsT45mvaLviHSEeQKM8A9bLdm5MPFFQ5CefSysE7GNsUNLB
         e5sHhjDemJEF9TwQCvDgQRIEpAh/ZoXU7a+pd5WQ0MA17omVCGsf2GnZ/urK1PiXKsko
         h64PjrAdw0daPWvIfg7UaOUzFl9a1PCV+39sSDOTKiWJ6gjYYNwZ9y5DLOP49jYgxOdv
         w73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=vJpk0gvCUpmiiPNgbxKn6wumM8Jsy49YCCt2EBK+St0=;
        b=5AohRXzvGg7SazJGFSpSc4oV3OWJ7qBTyR2isqQ3xQQhxR73hNlkoux7oIYK1mxKhl
         0Upy/KGximuEbojVsOqSLoCpE0S8gmZbZQjtNXqzZDqasSpmURwDq6MtKt9TsukCLq0a
         RpfJRZksImZ7d29hwIiYEQuBlz6r3WSVEqByjTsPaoR5loCq58Z5QWDO7Ezj3P5qoP1S
         f2T4rZAplP0QkPsBRmL3HOEiaB7r7MurpGKQL2coN19wpcXqzJ9KJRTzHl5z3Nozzy3i
         4Xdaf5qTjOoNPjaLVUKk5dm8fQzkGx3hzYQHAq7TrNqORR+vSFr6mE1O6DAXXyx29uCQ
         6S4A==
X-Gm-Message-State: AOAM5339GwDmWCo2w1Q5MCI/JG0Kz3/4FF53o+9bV4iZhRYh4SqcNrUA
        jMrT0puo7KrVzFNXEn3Tryc+6abJCIs=
X-Google-Smtp-Source: ABdhPJxbofUY6ABpOdc00MX7rRSrHTDvRF/BPhx4aN3/qQ+UBjz2BkR0fJKMz8uht/lj8G4h60ocaw==
X-Received: by 2002:a5d:6d86:: with SMTP id l6mr7090417wrs.69.1635438127435;
        Thu, 28 Oct 2021 09:22:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm3627987wrx.31.2021.10.28.09.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:22:07 -0700 (PDT)
Message-Id: <4d2d198f57294d8307453bda784bf5efe5905f45.1635438124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 16:21:58 +0000
Subject: [PATCH v2 3/9] doc: express grammar placeholders between angle
 brackets
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

This rules discerns user inputs from verbatim options in the
synopsis.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-cherry-pick.txt     |  6 ++--
 Documentation/git-config.txt          | 46 +++++++++++++--------------
 Documentation/git-cvsexportcommit.txt |  4 +--
 Documentation/git-gui.txt             |  2 +-
 Documentation/git-help.txt            |  6 ++--
 Documentation/git-http-fetch.txt      |  2 +-
 Documentation/git-init.txt            |  2 +-
 Documentation/git-pack-objects.txt    |  4 +--
 Documentation/git-pack-redundant.txt  |  2 +-
 Documentation/git-reflog.txt          |  4 +--
 Documentation/git-sparse-checkout.txt |  2 +-
 Documentation/git-stage.txt           |  2 +-
 12 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 5d750314b29..78dcc9171fb 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -8,7 +8,7 @@ git-cherry-pick - Apply the changes introduced by some existing commits
 SYNOPSIS
 --------
 [verse]
-'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
+'git cherry-pick' [--edit] [-n] [-m <parent-number>] [-s] [-x] [--ff]
 		  [-S[<keyid>]] <commit>...
 'git cherry-pick' (--continue | --skip | --abort | --quit)
 
@@ -81,8 +81,8 @@ OPTIONS
 	described above, and `-r` was to disable it.  Now the
 	default is not to do `-x` so this option is a no-op.
 
--m parent-number::
---mainline parent-number::
+-m <parent-number>::
+--mainline <parent-number>::
 	Usually you cannot cherry-pick a merge because you do not know which
 	side of the merge should be considered the mainline.  This
 	option specifies the parent number (starting from 1) of
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 992225f6129..0e58970289b 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,20 +9,20 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] name [value [value-pattern]]
-'git config' [<file-option>] [--type=<type>] --add name value
-'git config' [<file-option>] [--type=<type>] [--fixed-value] --replace-all name value [value-pattern]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get name [value-pattern]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all name [value-pattern]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp name_regex [value-pattern]
-'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
-'git config' [<file-option>] [--fixed-value] --unset name [value-pattern]
-'git config' [<file-option>] [--fixed-value] --unset-all name [value-pattern]
-'git config' [<file-option>] --rename-section old_name new_name
-'git config' [<file-option>] --remove-section name
+'git config' [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] <name> [<value> [<value-pattern>]]
+'git config' [<file-option>] [--type=<type>] --add <name> <value>
+'git config' [<file-option>] [--type=<type>] [--fixed-value] --replace-all <name> <value> [<value-pattern>]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get <name> [<value-pattern>]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all <name> [<value-pattern>]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp <name-regex> [<value-pattern>]
+'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch <name> <URL>
+'git config' [<file-option>] [--fixed-value] --unset <name> [<value-pattern>]
+'git config' [<file-option>] [--fixed-value] --unset-all <name> [<value-pattern>]
+'git config' [<file-option>] --rename-section <old-name> <new-name>
+'git config' [<file-option>] --remove-section <name>
 'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
-'git config' [<file-option>] --get-color name [default]
-'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
+'git config' [<file-option>] --get-color <name> [<default>]
+'git config' [<file-option>] --get-colorbool <name> [<stdout-is-tty>]
 'git config' [<file-option>] -e | --edit
 
 DESCRIPTION
@@ -102,9 +102,9 @@ OPTIONS
 	in which section and variable names are lowercased, but subsection
 	names are not.
 
---get-urlmatch name URL::
+--get-urlmatch <name> <URL>::
 	When given a two-part name section.key, the value for
-	section.<url>.key whose <url> part matches the best to the
+	section.<URL>.key whose <URL> part matches the best to the
 	given URL is returned (if no such key exists, the value for
 	section.key is used as a fallback).  When given just the
 	section as name, do so for all the keys in the section and
@@ -145,7 +145,7 @@ See also <<FILES>>.
 	read from or written to if `extensions.worktreeConfig` is
 	present. If not it's the same as `--local`.
 
--f config-file::
+-f <config-file>::
 --file config-file::
 	For writing options: write to the specified file rather than the
 	repository `.git/config`.
@@ -155,7 +155,7 @@ available files.
 +
 See also <<FILES>>.
 
---blob blob::
+--blob <blob>::
 	Similar to `--file` but use the given blob instead of a file. E.g.
 	you can use 'master:.gitmodules' to read values from the file
 	'.gitmodules' in the master branch. See "SPECIFYING REVISIONS"
@@ -246,18 +246,18 @@ Valid `<type>`'s include:
 	all queried config options with the scope of that value
 	(local, global, system, command).
 
---get-colorbool name [stdout-is-tty]::
+--get-colorbool <name> [<stdout-is-tty>]::
 
-	Find the color setting for `name` (e.g. `color.diff`) and output
-	"true" or "false".  `stdout-is-tty` should be either "true" or
+	Find the color setting for `<name>` (e.g. `color.diff`) and output
+	"true" or "false".  `<stdout-is-tty>` should be either "true" or
 	"false", and is taken into account when configuration says
-	"auto".  If `stdout-is-tty` is missing, then checks the standard
+	"auto".  If `<stdout-is-tty>` is missing, then checks the standard
 	output of the command itself, and exits with status 0 if color
 	is to be used, or exits with status 1 otherwise.
 	When the color setting for `name` is undefined, the command uses
 	`color.ui` as fallback.
 
---get-color name [default]::
+--get-color <name> [<default>]::
 
 	Find the color configured for `name` (e.g. `color.diff.new`) and
 	output it as the ANSI color escape sequence to the standard
@@ -281,7 +281,7 @@ Valid `<type>`'s include:
 
 --default <value>::
   When using `--get`, and the requested variable is not found, behave as if
-  <value> were the value assigned to the that variable.
+  `<value>` were the value assigned to the that variable.
 
 CONFIGURATION
 -------------
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 00154b6c85a..41c8a8a05c1 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -9,8 +9,8 @@ git-cvsexportcommit - Export a single commit to a CVS checkout
 SYNOPSIS
 --------
 [verse]
-'git cvsexportcommit' [-h] [-u] [-v] [-c] [-P] [-p] [-a] [-d cvsroot]
-	[-w cvsworkdir] [-W] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
+'git cvsexportcommit' [-h] [-u] [-v] [-c] [-P] [-p] [-a] [-d <cvsroot>]
+	[-w <cvs-workdir>] [-W] [-f] [-m <msgprefix>] [<parent-commit>] <commit-id>
 
 
 DESCRIPTION
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index c9d7e96214f..e8f3ccb4337 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -8,7 +8,7 @@ git-gui - A portable graphical interface to Git
 SYNOPSIS
 --------
 [verse]
-'git gui' [<command>] [arguments]
+'git gui' [<command>] [<arguments>]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 96d5f598b4b..44ea63cc6d3 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -9,14 +9,14 @@ SYNOPSIS
 --------
 [verse]
 'git help' [-a|--all [--[no-]verbose]]
-	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]
+	   [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
 'git help' [-g|--guides]
 'git help' [-c|--config]
 
 DESCRIPTION
 -----------
 
-With no options and no COMMAND or GUIDE given, the synopsis of the 'git'
+With no options and no '<command>' or '<guide>' given, the synopsis of the 'git'
 command and a list of the most commonly used Git commands are printed
 on the standard output.
 
@@ -33,7 +33,7 @@ variables.
 
 If an alias is given, git shows the definition of the alias on
 standard output. To get the manual page for the aliased command, use
-`git COMMAND --help`.
+`git <command> --help`.
 
 Note that `git --help ...` is identical to `git help ...` because the
 former is internally converted into the latter.
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 9fa17b60e43..fa4bb6cbc3e 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -9,7 +9,7 @@ git-http-fetch - Download from a remote Git repository via HTTP
 SYNOPSIS
 --------
 [verse]
-'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin | --packfile=<hash> | <commit>] <url>
+'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w <filename>] [--recover] [--stdin | --packfile=<hash> | <commit>] <url>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index b611d80697d..7781d0b3545 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
 	  [--separate-git-dir <git dir>] [--object-format=<format>]
 	  [-b <branch-name> | --initial-branch=<branch-name>]
-	  [--shared[=<permissions>]] [directory]
+	  [--shared[=<permissions>]] [<directory>]
 
 
 DESCRIPTION
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index dbfd1f90175..f8344e1e5ba 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -13,8 +13,8 @@ SYNOPSIS
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
-	[--stdout [--filter=<filter-spec>] | base-name]
-	[--shallow] [--keep-true-parents] [--[no-]sparse] < object-list
+	[--stdout [--filter=<filter-spec>] | <base-name>]
+	[--shallow] [--keep-true-parents] [--[no-]sparse] < <object-list>
 
 
 DESCRIPTION
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index f2869da5728..ee7034b5e52 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -9,7 +9,7 @@ git-pack-redundant - Find redundant pack files
 SYNOPSIS
 --------
 [verse]
-'git pack-redundant' [ --verbose ] [ --alt-odb ] < --all | .pack filename ... >
+'git pack-redundant' [ --verbose ] [ --alt-odb ] ( --all | <pack-filename>... )
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index ff487ff77d3..5ced7ad4f8b 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -17,12 +17,12 @@ The command takes various subcommands, and different options
 depending on the subcommand:
 
 [verse]
-'git reflog' ['show'] [log-options] [<ref>]
+'git reflog' ['show'] [<log-options>] [<ref>]
 'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
 	[--rewrite] [--updateref] [--stale-fix]
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
 'git reflog delete' [--rewrite] [--updateref]
-	[--dry-run | -n] [--verbose] ref@\{specifier\}...
+	[--dry-run | -n] [--verbose] <ref>@\{<specifier>\}...
 'git reflog exists' <ref>
 
 Reference logs, or "reflogs", record when the tips of branches and
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 42056ee9ff9..9a78dd721e8 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -11,7 +11,7 @@ given by a list of patterns.
 SYNOPSIS
 --------
 [verse]
-'git sparse-checkout <subcommand> [options]'
+'git sparse-checkout <subcommand> [<options>]'
 
 
 DESCRIPTION
diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
index 25bcda936db..2f6aaa75b9a 100644
--- a/Documentation/git-stage.txt
+++ b/Documentation/git-stage.txt
@@ -9,7 +9,7 @@ git-stage - Add file contents to the staging area
 SYNOPSIS
 --------
 [verse]
-'git stage' args...
+'git stage' <arg>...
 
 
 DESCRIPTION
-- 
gitgitgadget

