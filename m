Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853D3C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2946023D
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhJZPNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbhJZPNj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 11:13:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A6EC061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 08:11:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d3so15716661wrh.8
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=I0Yefl2+zYilyP0XoF/D+dqCm4xay0ERzrbpBiBDCE0=;
        b=UU77JeDDOeEA6pxMnXSKuUJMCs3qi/Gz0DL9MlndJZDZmhpL39KUEKeqx9cVjrhMAo
         gy/yJ/qKkAXhFiuCFzvcduBojKLBXaWBIju7y/VXSfZW2aKF+LB8KjPaPICheu7YrPRC
         1CvP0I4PoxvDXgX7Qc5a1lS0PxclKkZ9bgHKC/QGzrwU3wBVHDKVB5Q6Y/NRA6sJrWNU
         dDYnhKn9qRTa5saS4T+hiMC6IwchMu1sLWbp2e3pPrDO7GCZE0uXXgfQF9wCA/8DQlhv
         nz1AnkgdaahI6t6KxhDppI1nxu6bLoQJdOJJhoTswuZluGoV2LtyqjlU/eDi0M9nwhfW
         Vu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=I0Yefl2+zYilyP0XoF/D+dqCm4xay0ERzrbpBiBDCE0=;
        b=mZJC99m+Kmo4PLQZNjDsvFc9k4+2A7AwJiqHeVwIhSN/FxVNuFlJrw9V8IUmz8owiM
         e6rQaVbdbQ6Q9hzu+4ECAwG2zdvq83neqrOuKhT6y9gGppfNuXJAcqoVViHpGkEE3v4F
         t3H6+cTCjGWqxaOrr2C2nmfzLW0Sef4cKrt0JN/sLgQ9aBt1iXVo8T4uF84F0IlGRlJU
         61zdcAg3CbotsrND4Lw9iFAi0pJrS59wBpcR/Zwe9eMwTY7nx3KckehNVS+73WnC6aZB
         uMqnDK+3s4uBrXPksgsI7Q1PkblzUluPy1Su77TxOZVoHdpeiHG+TQtTAJ2qe+SUh/m6
         Yzww==
X-Gm-Message-State: AOAM532WRq5Yx58lM50tLOmQ5WoMmKLgh/giZmOC1Iya4Wpq7kGE7J5P
        QJW5NpawP2a7D/kcv+gcfmNl5hER394=
X-Google-Smtp-Source: ABdhPJxZcX0CONz+cZuucUp5WvLwVZbVxPVo1oNO76PzLelbbYtwPlFUxx8cJuYJ01QiIYh1H3RZ9w==
X-Received: by 2002:adf:a143:: with SMTP id r3mr1143560wrr.8.1635261074365;
        Tue, 26 Oct 2021 08:11:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm858514wmj.20.2021.10.26.08.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 08:11:13 -0700 (PDT)
Message-Id: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 26 Oct 2021 15:11:12 +0000
Subject: [PATCH] doc: fix grammar rules in commands'syntax
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

According to the coding guidelines, the placeholders must:
 * be in small letters
 * enclosed in angle brackets

Some other rules are also applied.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
    doc: fix grammar rules in commands'syntax
    
    There are command expressions which do not follow the grammar syntax
    rules.
    
    According to the coding guidelines, the placeholders must:
    
     * be in small letters
     * enclosed in angle brackets
    
    Some other rules are also applied.
    
    Signed-off-by: Jean-Noël Avila jn.avila@free.fr

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1066%2Fjnavila%2Ffix_manpages_placeholders-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1066/jnavila/fix_manpages_placeholders-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1066

 Documentation/git-archimport.txt      |  4 +--
 Documentation/git-checkout.txt        |  8 +++---
 Documentation/git-cherry-pick.txt     |  6 ++---
 Documentation/git-config.txt          | 36 +++++++++++++--------------
 Documentation/git-credential.txt      |  2 +-
 Documentation/git-cvsexportcommit.txt |  4 +--
 Documentation/git-cvsimport.txt       | 10 ++++----
 Documentation/git-fsck.txt            |  2 +-
 Documentation/git-gui.txt             |  2 +-
 Documentation/git-help.txt            |  6 ++---
 Documentation/git-http-fetch.txt      |  2 +-
 Documentation/git-http-push.txt       | 13 +++++-----
 Documentation/git-init-db.txt         |  2 +-
 Documentation/git-init.txt            | 25 ++++++++++---------
 Documentation/git-log.txt             |  4 +--
 Documentation/git-ls-files.txt        |  4 +--
 Documentation/git-merge-index.txt     |  2 +-
 Documentation/git-p4.txt              |  6 ++---
 Documentation/git-pack-objects.txt    |  4 +--
 Documentation/git-pack-redundant.txt  |  2 +-
 Documentation/git-reflog.txt          |  4 +--
 Documentation/git-shortlog.txt        |  4 +--
 Documentation/git-sparse-checkout.txt |  2 +-
 Documentation/git-stage.txt           |  2 +-
 Documentation/git-web--browse.txt     |  2 +-
 25 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index a595a0ffeee..25d8bd2b08c 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -9,8 +9,8 @@ git-archimport - Import a GNU Arch repository into Git
 SYNOPSIS
 --------
 [verse]
-'git archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D depth] [-t tempdir]
-               <archive/branch>[:<git-branch>] ...
+'git archimport' [-h] [-v] [-o] [-a] [-f] [-T] [-D <depth>] [-t <tempdir>]
+	       <archive>/<branch>[:<git-branch>]...
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index d473c9bf387..5964dcc25ed 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [<branch>]
 'git checkout' [-q] [-f] [-m] --detach [<branch>]
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
-'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
+'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]
 'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
@@ -43,7 +43,7 @@ You could omit `<branch>`, in which case the command degenerates to
 rather expensive side-effects to show only the tracking information,
 if exists, for the current branch.
 
-'git checkout' -b|-B <new_branch> [<start point>]::
+'git checkout' -b|-B <new-branch> [<start-point>]::
 
 	Specifying `-b` causes a new branch to be created as if
 	linkgit:git-branch[1] were called and then checked out.  In
@@ -145,11 +145,11 @@ as `ours` (i.e. "our shared canonical history"), while what you did
 on your side branch as `theirs` (i.e. "one contributor's work on top
 of it").
 
--b <new_branch>::
+-b <new-branch>::
 	Create a new branch named `<new_branch>` and start it at
 	`<start_point>`; see linkgit:git-branch[1] for details.
 
--B <new_branch>::
+-B <new-branch>::
 	Creates the branch `<new_branch>` and start it at `<start_point>`;
 	if it already exists, then reset it to `<start_point>`. This is
 	equivalent to running "git branch" with "-f"; see
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
index 992225f6129..96330bf4001 100644
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
@@ -102,7 +102,7 @@ OPTIONS
 	in which section and variable names are lowercased, but subsection
 	names are not.
 
---get-urlmatch name URL::
+--get-urlmatch <name> <URL>::
 	When given a two-part name section.key, the value for
 	section.<url>.key whose <url> part matches the best to the
 	given URL is returned (if no such key exists, the value for
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
@@ -246,7 +246,7 @@ Valid `<type>`'s include:
 	all queried config options with the scope of that value
 	(local, global, system, command).
 
---get-colorbool name [stdout-is-tty]::
+--get-colorbool <name> [<stdout-is-tty>]::
 
 	Find the color setting for `name` (e.g. `color.diff`) and output
 	"true" or "false".  `stdout-is-tty` should be either "true" or
@@ -257,7 +257,7 @@ Valid `<type>`'s include:
 	When the color setting for `name` is undefined, the command uses
 	`color.ui` as fallback.
 
---get-color name [default]::
+--get-color <name> [<default>]::
 
 	Find the color configured for `name` (e.g. `color.diff.new`) and
 	output it as the ANSI color escape sequence to the standard
diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 206e3c5f407..fc1733a6163 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -8,7 +8,7 @@ git-credential - Retrieve and store user credentials
 SYNOPSIS
 --------
 ------------------
-git credential <fill|approve|reject>
+git credential [fill|approve|reject]
 ------------------
 
 DESCRIPTION
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
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index de1ebed67d7..f47416d1c44 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -9,11 +9,11 @@ git-cvsimport - Salvage your data out of another SCM people love to hate
 SYNOPSIS
 --------
 [verse]
-'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>]
+'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <cvsroot>]
 	      [-A <author-conv-file>] [-p <options-for-cvsps>] [-P <file>]
-	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
+	      [-C <git-repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
 	      [-a] [-m] [-M <regex>] [-S <regex>] [-L <commitlimit>]
-	      [-r <remote>] [-R] [<CVS_module>]
+	      [-r <remote>] [-R] [<CVS-module>]
 
 
 DESCRIPTION
@@ -52,14 +52,14 @@ OPTIONS
 -v::
 	Verbosity: let 'cvsimport' report what it is doing.
 
--d <CVSROOT>::
+-d <cvsroot>::
 	The root of the CVS archive. May be local (a simple path) or remote;
 	currently, only the :local:, :ext: and :pserver: access methods
 	are supported. If not given, 'git cvsimport' will try to read it
 	from `CVS/Root`. If no such file exists, it checks for the
 	`CVSROOT` environment variable.
 
-<CVS_module>::
+<CVS-module>::
 	The CVS module you want to import. Relative to <CVSROOT>.
 	If not given, 'git cvsimport' tries to read it from
 	`CVS/Repository`.
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index bd596619c0d..5088783dccb 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
 	 [--[no-]full] [--strict] [--verbose] [--lost-found]
 	 [--[no-]dangling] [--[no-]progress] [--connectivity-only]
-	 [--[no-]name-objects] [<object>*]
+	 [--[no-]name-objects] [<object>...]
 
 DESCRIPTION
 -----------
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
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index ea03a4eeb0f..6b29d38a2a6 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -63,16 +63,15 @@ of such patterns separated by a colon ":" (this means that a ref name
 cannot have a colon in it).  A single pattern '<name>' is just a
 shorthand for '<name>:<name>'.
 
-Each pattern pair consists of the source side (before the colon)
-and the destination side (after the colon).  The ref to be
-pushed is determined by finding a match that matches the source
-side, and where it is pushed is determined by using the
-destination side.
+Each pattern pair '<src>:<dst>' consists of the source side (before
+the colon) and the destination side (after the colon).  The ref to be
+pushed is determined by finding a match that matches the source side,
+and where it is pushed is determined by using the destination side.
 
- - It is an error if <src> does not match exactly one of the
+ - It is an error if '<src>' does not match exactly one of the
    local refs.
 
- - If <dst> does not match any remote ref, either
+ - If '<dst>' does not match any remote ref, either
 
    * it has to start with "refs/"; <dst> is used as the
      destination literally in this case.
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 648a6cd78ad..18bf1a3c8ce 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -9,7 +9,7 @@ git-init-db - Creates an empty Git repository
 SYNOPSIS
 --------
 [verse]
-'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
+'git init-db' [-q | --quiet] [--bare] [--template=<template-directory>] [--separate-git-dir <git-dir>] [--shared[=<permissions>]]
 
 
 DESCRIPTION
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index b611d80697d..99bcfc9f2c9 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -9,10 +9,10 @@ git-init - Create an empty Git repository or reinitialize an existing one
 SYNOPSIS
 --------
 [verse]
-'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
-	  [--separate-git-dir <git dir>] [--object-format=<format>]
+'git init' [-q | --quiet] [--bare] [--template=<template-directory>]
+	  [--separate-git-dir <git-dir>] [--object-format=<format>]
 	  [-b <branch-name> | --initial-branch=<branch-name>]
-	  [--shared[=<permissions>]] [directory]
+	  [--shared[=<permissions>]] [<directory>]
 
 
 DESCRIPTION
@@ -57,12 +57,12 @@ values are 'sha1' and (if enabled) 'sha256'.  'sha1' is the default.
 +
 include::object-format-disclaimer.txt[]
 
---template=<template_directory>::
+--template=<template-directory>::
 
 Specify the directory from which templates will be used.  (See the "TEMPLATE
 DIRECTORY" section below.)
 
---separate-git-dir=<git dir>::
+--separate-git-dir=<git-dir>::
 
 Instead of initializing the repository as a directory to either `$GIT_DIR` or
 `./.git/`, create a text file there containing the path to the actual
@@ -79,7 +79,7 @@ repository.  If not specified, fall back to the default name (currently
 `master`, but this is subject to change in the future; the name can be
 customized via the `init.defaultBranch` configuration variable).
 
---shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
+--shared[=(false|true|umask|group|all|world|everybody|0<octal>)]::
 
 Specify that the Git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
@@ -110,13 +110,14 @@ the repository permissions.
 
 Same as 'group', but make the repository readable by all users.
 
-'0xxx'::
+'0<octal>'::
 
-'0xxx' is an octal number and each file will have mode '0xxx'. '0xxx' will
-override users' umask(2) value (and not only loosen permissions as 'group' and
-'all' does). '0640' will create a repository which is group-readable, but not
-group-writable or accessible to others. '0660' will create a repo that is
-readable and writable to the current user and group, but inaccessible to others.
+'0<octal>' is an octal number and each file will have mode
+'0<octal>'. '0<octal>' will override users' umask(2) value (and not
+only loosen permissions as 'group' and 'all' does). '0640' will create
+a repository which is group-readable, but not group-writable or
+accessible to others. '0660' will create a repo that is readable and
+writable to the current user and group, but inaccessible to others.
 --
 
 By default, the configuration flag `receive.denyNonFastForwards` is enabled
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0498e7bacbe..ac8e96265c3 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -9,7 +9,7 @@ git-log - Show commit logs
 SYNOPSIS
 --------
 [verse]
-'git log' [<options>] [<revision range>] [[--] <path>...]
+'git log' [<options>] [<revision-range>] [[--] <path>...]
 
 DESCRIPTION
 -----------
@@ -81,7 +81,7 @@ produced by `--stat`, etc.
 
 include::line-range-options.txt[]
 
-<revision range>::
+<revision-range>::
 	Show only commits in the specified revision range.  When no
 	<revision range> is specified, it defaults to `HEAD` (i.e. the
 	whole history leading to the current commit).  `origin..HEAD`
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 6d11ab506b7..64dcedce97d 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git ls-files' [-z] [-t] [-v] [-f]
-		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
-		(-[c|d|o|i|s|u|k|m])*
+		[--(cached|deleted|others|ignored|stage|unmerged|killed|modified)...]
+		[-(c|d|o|i|s|u|k|m)...]
 		[--eol]
 		[--deduplicate]
 		[-x <pattern>|--exclude=<pattern>]
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 2ab84a91e53..eea56b3154e 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -9,7 +9,7 @@ git-merge-index - Run a merge for files needing merging
 SYNOPSIS
 --------
 [verse]
-'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>*)
+'git merge-index' [-o] [-q] <merge-program> (-a | ( [--] <file>...) )
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 38e5257b2a4..f2de6400302 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -9,10 +9,10 @@ git-p4 - Import from and submit to Perforce repositories
 SYNOPSIS
 --------
 [verse]
-'git p4 clone' [<sync options>] [<clone options>] <p4 depot path>...
-'git p4 sync' [<sync options>] [<p4 depot path>...]
+'git p4 clone' [<sync-options>] [<clone-options>] <p4-depot-path>...
+'git p4 sync' [<sync-options>] [<p4-depot-path>...]
 'git p4 rebase'
-'git p4 submit' [<submit options>] [<master branch name>]
+'git p4 submit' [<submit-options>] [<master-branch-name>]
 
 
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
index f2869da5728..7c55c476b65 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -9,7 +9,7 @@ git-pack-redundant - Find redundant pack files
 SYNOPSIS
 --------
 [verse]
-'git pack-redundant' [ --verbose ] [ --alt-odb ] < --all | .pack filename ... >
+'git pack-redundant' [ --verbose ] [ --alt-odb ] ( --all | <.pack-filename>... )
 
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
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index c9c7f3065ca..5babc07f094 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -8,7 +8,7 @@ git-shortlog - Summarize 'git log' output
 SYNOPSIS
 --------
 [verse]
-'git shortlog' [<options>] [<revision range>] [[--] <path>...]
+'git shortlog' [<options>] [<revision-range>] [[--] <path>...]
 git log --pretty=short | 'git shortlog' [<options>]
 
 DESCRIPTION
@@ -89,7 +89,7 @@ counts both authors and co-authors.
 If width is `0` (zero) then indent the lines of the output without wrapping
 them.
 
-<revision range>::
+<revision-range>::
 	Show only commits in the specified revision range.  When no
 	<revision range> is specified, it defaults to `HEAD` (i.e. the
 	whole history leading to the current commit).  `origin..HEAD`
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 42056ee9ff9..92b2ca374df 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -11,7 +11,7 @@ given by a list of patterns.
 SYNOPSIS
 --------
 [verse]
-'git sparse-checkout <subcommand> [options]'
+'git sparse-checkout <subcommand> [<options>...]'
 
 
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
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 8d162b56c59..3cf0b3df04f 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -8,7 +8,7 @@ git-web--browse - Git helper script to launch a web browser
 SYNOPSIS
 --------
 [verse]
-'git web{litdd}browse' [<options>] <url|file>...
+'git web{litdd}browse' [<options>] (<url>|<file>)...
 
 DESCRIPTION
 -----------

base-commit: 9d530dc0024503ab4218fe6c4395b8a0aa245478
-- 
gitgitgadget
