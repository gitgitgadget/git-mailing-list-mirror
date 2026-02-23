Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF630361668
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846239; cv=none; b=g5ZACnMIsAOafoVYg5j2nZJmFsR/rnFrtoqt8KzpfTkHkS7N+5zi9q/drQyMXtbDyS0UQ20aexai9pHFx4lOXj+AQaLUSfUiHg6BD+FNf+nuPKu4ex0OyryjSHQhevnzVCUccGd0ZsWZlh0yiVG31rzN4gHXRw7msi23IM+EnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846239; c=relaxed/simple;
	bh=OPCHDZC9YZsZLo54Bkp/32t7d1OBL0SVSHHFe9UDyxU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=NRPdnGRCp1cODoFM47Ml8PTmLzO1RrmCctGzqmzo3Lff/M1ar1jkq9WKAxTkL+54bagdof4SNfQuXfMgPFOgAo151OwvWhhm60yKEKKlDvxqKuVDrCPKGl8C+X7bbLGOweFf8vVDNCZriJq9IjYyTZQRBImZfYFAaJdf+eqKsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5LZ2WZY; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5LZ2WZY"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb40149037so470060985a.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 03:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771846236; x=1772451036; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eqSzCatLBWKsYHCAaT9uxlOXbnjNyzNJrTp3ahOFPT4=;
        b=g5LZ2WZY1i8a+u9Fdzf4SA6DeoxbL6rieVlg6TVTHQWHxWPYyBNFC/HI7CIM1w/nVt
         8PlUrPAHVpdo9LFfxtS378bjo62wleuDogjT33T5Ht034WPOCZ5m17YVtUtzSAblMg9X
         gDvCJ+inL7p8d7mGf7dBPlIDPk4g0K8QChoQd6Yh3UWDPbMmu3Ct8m5UvrexZfwOaCGT
         PfD8086zoTKHG/8pmV1ZTP8S7/tOn0XIv/Nmed+mA3YoW4/jet/JWvnF8T4OXoxGp5bU
         j/rzmpn3jM8JnbCwD2b2axuyMATeqlgXKuzuFZB3/eWCCCP3NY5kvRnsNb+0F0fXMmwG
         gJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771846236; x=1772451036;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqSzCatLBWKsYHCAaT9uxlOXbnjNyzNJrTp3ahOFPT4=;
        b=nZ7Bq4j7YQ/dAP3SjaVaeKJ0/0fWDU+SCIpwWldLhf/YqeUpRmApAHQBZ3UMufJTgo
         oTS8Kzk9zgKUgNXnFUwRYJHhBmCaTaMPmc5OEWOzoYrxm0qji3LexmHLbE+CPIom1ga4
         5HwXlVGE1ZNKGFDj3YPZ2hmrHTma4bkLZ3roYKoUsvW07HIu8xj72rM+vsyNZm/3eHyK
         j93rLIq370PqLnqnGrHMWqm/SIvbWGe+jQqgdwQr7g++jqOmv7+ugyZDbdou2M6VNWXH
         9pXWB/02e3qTYP8UKrHPuCbyLcCpKURK5KpQoTiPnmNM8GnDdP18uw2BFrzIvXq49uLD
         v+qA==
X-Gm-Message-State: AOJu0YwCZB4TIrnBM2B0/z8LtIqOvyqMUlbIrFyFqdtG191WtjUmlbWe
	wJPUfCVYMzWCK8qzw/mkmc1GE5wpO6r5dMC5GtqNlo812BDscpsmUv60O/c2Lw==
X-Gm-Gg: AZuq6aJjmmqvUVxa74Qys4be0Xgueav8oc31VJ8Zq14mr5qONEVJCEoG5piwbzq3ufa
	K6EWui6QREyGiVVr2G3zE05lyJSo0MOmrkTXkL5aM3PG7FRI0m/nj3pg+7PqFoz4ysw4qPoaG5F
	3D9RQZDV65saAUJG+K2T4DGKqaVD4er6GPtI6+RhYHz0ZBQhjWL91pKKiQ5xPloh/z8Po3JQEmZ
	SN7nGtjJf26BVc2LAiv6JkXJZJ/WptI3KuMrMtBQ1mwImSlY8PYLTGIeiWMNCaIst2/v3IPePRE
	/F2erFe6t6qDd1k3v+HXBQ/0Y/CeR7U/QganFClffovyAcJFtQ/PauT2DPkb5wJCYKJ40ldNig1
	h3XdNGA5hVfBDglgNAttqgGR8t3njV0tUuwZX6QFuKRo1Ih/a1tr1fal234Xcyi5RYqET/+MbRz
	K8PeoOEehaslamBNqUB5w8CzXU
X-Received: by 2002:ac8:5a92:0:b0:502:a100:4054 with SMTP id d75a77b69052e-5070bbdce9dmr111124101cf.23.1771846235833;
        Mon, 23 Feb 2026 03:30:35 -0800 (PST)
Received: from [127.0.0.1] ([20.161.30.225])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6a1f14sm63264291cf.20.2026.02.23.03.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:30:35 -0800 (PST)
Message-Id: <pull.2215.git.git.1771846234706.gitgitgadget@gmail.com>
From: "Michael Ryzhikov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 11:30:34 +0000
Subject: [PATCH] docs: remove {litdd} usage
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Michael Ryzhikov <samonon@gmail.com>,
    samonon <samonon@gmail.com>

From: samonon <samonon@gmail.com>

*** Problem.
{litdd} is used as alias for -- (when not inside backticks) because --
is a reserved text in asciidoc. There is some problems with this:
- need to remember that in some cases -- should be replaced with {litdd}
- unnecessary config options when exporting adoc to other formats
- in HTML it looks like "&#x2d;&#x2d;" instead of "--" (it works, but
   browser should correctly decode hex symbols in html link:
   see htmldocs/git-sh-i18n.html)

*** Solution
For better readability just escape -- using \.
This is default asciidoc mechanism that don't need any configuration.
Tested with "make all doc" - links inside linkgit: work.

Signed-off-by: samonon <samonon@gmail.com>
---
    docs: remove {litdd} usage

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2215%2FMuxaJIbI4%2Fremove-litdd-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2215/MuxaJIbI4/remove-litdd-v1
Pull-Request: https://github.com/git/git/pull/2215

 Documentation/Makefile                          |  1 -
 Documentation/SubmittingPatches                 |  2 +-
 Documentation/asciidoc.conf.in                  |  1 -
 Documentation/config/browser.adoc               |  2 +-
 Documentation/config/core.adoc                  |  2 +-
 Documentation/git-archimport.adoc               |  6 +++---
 Documentation/git-credential-cache--daemon.adoc |  6 +++---
 Documentation/git-fsmonitor--daemon.adoc        | 12 ++++++------
 Documentation/git-help.adoc                     |  6 +++---
 Documentation/git-instaweb.adoc                 |  6 +++---
 Documentation/git-mergetool--lib.adoc           | 10 +++++-----
 Documentation/git-sh-i18n--envsubst.adoc        | 10 +++++-----
 Documentation/git-sh-i18n.adoc                  |  2 +-
 Documentation/git-update-index.adoc             |  2 +-
 Documentation/git-web--browse.adoc              | 10 +++++-----
 Documentation/lint-gitlink.perl                 |  2 +-
 Documentation/meson.build                       |  1 -
 contrib/subtree/Makefile                        |  1 -
 t/t0450-txt-doc-vs-help.sh                      |  2 +-
 19 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2699f0b24a..64c3ed880c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -223,7 +223,6 @@ ASCIIDOC_HTML = xhtml5
 ASCIIDOC_DOCBOOK = docbook5
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
-ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 ASCIIDOC_EXTRA += -adocinfo=shared
 ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e270ccbe85..8322a4a05c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -35,7 +35,7 @@ The people who may need to know are the ones who worked on the code
 you are touching.  These people happen to be the ones who are
 most likely to be knowledgeable enough to help you, but
 they have no obligation to help you (i.e. you ask them for help,
-you don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
+you don't demand).  +git log -p \-- _$area_you_are_modifying_+ would
 help you find out who they are.
 
 . You get comments and suggestions for improvements.  You may even get
diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
index 31b883a72c..3a54e1644e 100644
--- a/Documentation/asciidoc.conf.in
+++ b/Documentation/asciidoc.conf.in
@@ -20,7 +20,6 @@ backslash=&#92;
 tilde=&#126;
 apostrophe=&#39;
 backtick=&#96;
-litdd=&#45;&#45;
 manmanual=Git Manual
 mansource=Git @GIT_VERSION@
 revdate=@GIT_DATE@
diff --git a/Documentation/config/browser.adoc b/Documentation/config/browser.adoc
index 195df207a6..8f9161fb8a 100644
--- a/Documentation/config/browser.adoc
+++ b/Documentation/config/browser.adoc
@@ -1,7 +1,7 @@
 browser.<tool>.cmd::
 	Specify the command to invoke the specified browser. The
 	specified command is evaluated in shell with the URLs passed
-	as arguments. (See linkgit:git-web{litdd}browse[1].)
+	as arguments. (See linkgit:git-web\--browse[1].)
 
 browser.<tool>.path::
 	Override the path for the given tool that may be used to
diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index a0ebf03e2e..db5ab03eae 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -63,7 +63,7 @@ core.protectNTFS::
 
 core.fsmonitor::
 	If set to true, enable the built-in file system monitor
-	daemon for this working directory (linkgit:git-fsmonitor{litdd}daemon[1]).
+	daemon for this working directory (linkgit:git-fsmonitor\--daemon[1]).
 +
 Like hook-based file system monitors, the built-in file system monitor
 can speed up Git commands that need to refresh the Git index
diff --git a/Documentation/git-archimport.adoc b/Documentation/git-archimport.adoc
index 847777fd17..178a4d66ed 100644
--- a/Documentation/git-archimport.adoc
+++ b/Documentation/git-archimport.adoc
@@ -45,7 +45,7 @@ archives that it imports, it is also possible to specify Git branch names
 manually.  To do so, write a Git branch name after each <archive>/<branch>
 parameter, separated by a colon.  This way, you can shorten the Arch
 branch names and convert Arch jargon to Git jargon, for example mapping a
-"PROJECT{litdd}devo{litdd}VERSION" branch to "master".
+"PROJECT\--devo\--VERSION" branch to "master".
 
 Associating multiple Arch branches to one Git branch is possible; the
 result will make the most sense only if no commits are made to the first
@@ -86,8 +86,8 @@ OPTIONS
 -o::
 	Use this for compatibility with old-style branch names used by
 	earlier versions of 'git archimport'.  Old-style branch names
-	were category{litdd}branch, whereas new-style branch names are
-	archive,category{litdd}branch{litdd}version.  In both cases, names given
+	were category\--branch, whereas new-style branch names are
+	archive,category\--branch\--version.  In both cases, names given
 	on the command-line will override the automatically-generated
 	ones.
 
diff --git a/Documentation/git-credential-cache--daemon.adoc b/Documentation/git-credential-cache--daemon.adoc
index 650a15a7ed..b9e05146d1 100644
--- a/Documentation/git-credential-cache--daemon.adoc
+++ b/Documentation/git-credential-cache--daemon.adoc
@@ -1,5 +1,5 @@
-git-credential-cache{litdd}daemon(1)
-====================================
+git-credential-cache\--daemon(1)
+================================
 
 NAME
 ----
@@ -8,7 +8,7 @@ git-credential-cache--daemon - Temporarily store user credentials in memory
 SYNOPSIS
 --------
 [verse]
-'git credential-cache{litdd}daemon' [--debug] <socket-path>
+'git credential-cache\--daemon' [--debug] <socket-path>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-fsmonitor--daemon.adoc b/Documentation/git-fsmonitor--daemon.adoc
index 8fe5241b08..547d185214 100644
--- a/Documentation/git-fsmonitor--daemon.adoc
+++ b/Documentation/git-fsmonitor--daemon.adoc
@@ -1,5 +1,5 @@
-git-fsmonitor{litdd}daemon(1)
-=============================
+git-fsmonitor\--daemon(1)
+=========================
 
 NAME
 ----
@@ -8,10 +8,10 @@ git-fsmonitor--daemon - A Built-in Filesystem Monitor
 SYNOPSIS
 --------
 [verse]
-'git fsmonitor{litdd}daemon' start
-'git fsmonitor{litdd}daemon' run
-'git fsmonitor{litdd}daemon' stop
-'git fsmonitor{litdd}daemon' status
+'git fsmonitor\--daemon' start
+'git fsmonitor\--daemon' run
+'git fsmonitor\--daemon' stop
+'git fsmonitor\--daemon' status
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-help.adoc b/Documentation/git-help.adoc
index f0bedc1f96..b83feed536 100644
--- a/Documentation/git-help.adoc
+++ b/Documentation/git-help.adoc
@@ -110,9 +110,9 @@ other display programs (see below).
 +
 The web browser can be specified using the configuration variable
 `help.browser`, or `web.browser` if the former is not set. If neither of
-these config variables is set, the 'git web{litdd}browse' helper script
+these config variables is set, the 'git web\--browse' helper script
 (called by 'git help') will pick a suitable default. See
-linkgit:git-web{litdd}browse[1] for more information about this.
+linkgit:git-web\--browse[1] for more information about this.
 
 CONFIGURATION VARIABLES
 -----------------------
@@ -135,7 +135,7 @@ help.browser, web.browser, and browser.<tool>.path
 The `help.browser`, `web.browser` and `browser.<tool>.path` will also
 be checked if the 'web' format is chosen (either by command-line
 option or configuration variable). See '-w|--web' in the OPTIONS
-section above and linkgit:git-web{litdd}browse[1].
+section above and linkgit:git-web\--browse[1].
 
 man.viewer
 ~~~~~~~~~~
diff --git a/Documentation/git-instaweb.adoc b/Documentation/git-instaweb.adoc
index a54fe4401b..c17011c438 100644
--- a/Documentation/git-instaweb.adoc
+++ b/Documentation/git-instaweb.adoc
@@ -45,9 +45,9 @@ OPTIONS
 -b::
 --browser::
 	The web browser that should be used to view the gitweb
-	page. This will be passed to the 'git web{litdd}browse' helper
+	page. This will be passed to the 'git web\--browse' helper
 	script along with the URL of the gitweb instance. See
-	linkgit:git-web{litdd}browse[1] for more information about this. If
+	linkgit:git-web\--browse[1] for more information about this. If
 	the script fails, the URL will be printed to stdout.
 
 start::
@@ -83,7 +83,7 @@ You may specify configuration in your .git/config
 
 If the configuration variable `instaweb.browser` is not set,
 `web.browser` will be used instead if it is defined. See
-linkgit:git-web{litdd}browse[1] for more information about this.
+linkgit:git-web\--browse[1] for more information about this.
 
 SEE ALSO
 --------
diff --git a/Documentation/git-mergetool--lib.adoc b/Documentation/git-mergetool--lib.adoc
index 0726b560d4..cdbc881bfb 100644
--- a/Documentation/git-mergetool--lib.adoc
+++ b/Documentation/git-mergetool--lib.adoc
@@ -1,5 +1,5 @@
-git-mergetool{litdd}lib(1)
-==========================
+git-mergetool\--lib(1)
+======================
 
 NAME
 ----
@@ -8,7 +8,7 @@ git-mergetool--lib - Common Git merge tool shell scriptlets
 SYNOPSIS
 --------
 [verse]
-'TOOL_MODE=(diff|merge) . "$(git --exec-path)/git-mergetool{litdd}lib"'
+'TOOL_MODE=(diff|merge) . "$(git --exec-path)/git-mergetool\--lib"'
 
 DESCRIPTION
 -----------
@@ -17,11 +17,11 @@ This is not a command the end user would want to run.  Ever.
 This documentation is meant for people who are studying the
 Porcelain-ish scripts and/or are writing new ones.
 
-The 'git-mergetool{litdd}lib' scriptlet is designed to be sourced (using
+The 'git-mergetool\--lib' scriptlet is designed to be sourced (using
 `.`) by other shell scripts to set up functions for working
 with Git merge tools.
 
-Before sourcing 'git-mergetool{litdd}lib', your script must set `TOOL_MODE`
+Before sourcing 'git-mergetool\--lib', your script must set `TOOL_MODE`
 to define the operation mode for the functions listed below.
 'diff' and 'merge' are valid values.
 
diff --git a/Documentation/git-sh-i18n--envsubst.adoc b/Documentation/git-sh-i18n--envsubst.adoc
index 2ffaf9392e..6473a9a795 100644
--- a/Documentation/git-sh-i18n--envsubst.adoc
+++ b/Documentation/git-sh-i18n--envsubst.adoc
@@ -1,5 +1,5 @@
-git-sh-i18n{litdd}envsubst(1)
-=============================
+git-sh-i18n\--envsubst(1)
+=========================
 
 NAME
 ----
@@ -10,8 +10,8 @@ SYNOPSIS
 [verse]
 eval_gettext () {
 	printf "%s" "$1" | (
-		export PATH $('git sh-i18n{litdd}envsubst' --variables "$1");
-		'git sh-i18n{litdd}envsubst' "$1"
+		export PATH $('git sh-i18n\--envsubst' --variables "$1");
+		'git sh-i18n\--envsubst' "$1"
 	)
 }
 
@@ -22,7 +22,7 @@ This is not a command the end user would want to run.  Ever.
 This documentation is meant for people who are studying the
 plumbing scripts and/or are writing new ones.
 
-'git sh-i18n{litdd}envsubst' is Git's stripped-down copy of the GNU
+'git sh-i18n\--envsubst' is Git's stripped-down copy of the GNU
 `envsubst(1)` program that comes with the GNU gettext package. It's
 used internally by linkgit:git-sh-i18n[1] to interpolate the variables
 passed to the `eval_gettext` function.
diff --git a/Documentation/git-sh-i18n.adoc b/Documentation/git-sh-i18n.adoc
index 60cf49cb2a..7deb13d861 100644
--- a/Documentation/git-sh-i18n.adoc
+++ b/Documentation/git-sh-i18n.adoc
@@ -35,7 +35,7 @@ gettext::
 eval_gettext::
 	Currently a dummy fall-through function implemented as a wrapper
 	around `printf(1)` with variables expanded by the
-	linkgit:git-sh-i18n{litdd}envsubst[1] helper. Will be replaced by a
+	linkgit:git-sh-i18n\--envsubst[1] helper. Will be replaced by a
 	real gettext implementation in a later version.
 
 GIT
diff --git a/Documentation/git-update-index.adoc b/Documentation/git-update-index.adoc
index 9bea9fab9a..0cda1e699e 100644
--- a/Documentation/git-update-index.adoc
+++ b/Documentation/git-update-index.adoc
@@ -539,7 +539,7 @@ This feature is intended to speed up git operations for repos that have
 large working directories.
 
 It enables git to work together with a file system monitor (see
-linkgit:git-fsmonitor{litdd}daemon[1]
+linkgit:git-fsmonitor\--daemon[1]
 and the
 "fsmonitor-watchman" section of linkgit:githooks[5]) that can
 inform it as to what files have been modified. This enables git to avoid
diff --git a/Documentation/git-web--browse.adoc b/Documentation/git-web--browse.adoc
index f2f996cbe1..13e37dac82 100644
--- a/Documentation/git-web--browse.adoc
+++ b/Documentation/git-web--browse.adoc
@@ -1,5 +1,5 @@
-git-web{litdd}browse(1)
-=======================
+git-web\--browse(1)
+===================
 
 NAME
 ----
@@ -8,7 +8,7 @@ git-web--browse - Git helper script to launch a web browser
 SYNOPSIS
 --------
 [verse]
-'git web{litdd}browse' [<options>] (<URL>|<file>)...
+'git web\--browse' [<options>] (<URL>|<file>)...
 
 DESCRIPTION
 -----------
@@ -71,7 +71,7 @@ browser.<tool>.path
 You can explicitly provide a full path to your preferred browser by
 setting the configuration variable `browser.<tool>.path`. For example,
 you can configure the absolute path to firefox by setting
-'browser.firefox.path'. Otherwise, 'git web{litdd}browse' assumes the tool
+'browser.firefox.path'. Otherwise, 'git web\--browse' assumes the tool
 is available in PATH.
 
 browser.<tool>.cmd
@@ -80,7 +80,7 @@ browser.<tool>.cmd
 When the browser, specified by options or configuration variables, is
 not among the supported ones, then the corresponding
 `browser.<tool>.cmd` configuration variable will be looked up. If this
-variable exists then 'git web{litdd}browse' will treat the specified tool
+variable exists then 'git web\--browse' will treat the specified tool
 as a custom command and will use a shell eval to run the command with
 the URLs passed as arguments.
 
diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index a92e887b4c..c7d9b2805a 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -54,7 +54,7 @@ while (<>) {
 		my ($target, $page, $section) = ($1, $2, $3);
 
 		# De-AsciiDoc
-		$page =~ s/{litdd}/--/g;
+		$page =~ s/\\--/--/g;
 
 		if (!exists $TXT{$page}) {
 			report($pos, $line, $target, "link outside of our own docs");
diff --git a/Documentation/meson.build b/Documentation/meson.build
index fd2e8cc02d..bfeae3587b 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -295,7 +295,6 @@ elif docs_backend == 'asciidoctor'
     asciidoctor,
     '--attribute', 'compat-mode',
     '--attribute', 'tabsize=8',
-    '--attribute', 'litdd=&#x2d;&#x2d;',
     '--attribute', 'docinfo=shared',
     '--attribute', 'build_dir=' + meson.current_build_dir(),
     '--load-path', meson.current_build_dir(),
diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index c0c9f21cb7..540a074b02 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -33,7 +33,6 @@ ASCIIDOC_CONF    =
 ASCIIDOC_HTML    = xhtml5
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_EXTRA  += -I. -rasciidoctor-extensions
-ASCIIDOC_EXTRA  += -alitdd='&\#x2d;&\#x2d;'
 ASCIIDOC_DEPS    = asciidoctor-extensions.rb
 XMLTO_EXTRA     += --skip-validation
 endif
diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 822b0d55a5..4e6cb163fb 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -58,7 +58,7 @@ adoc_to_synopsis () {
 		-E '/^\[(verse|synopsis)\]$/,/^$/ {
 			/^$/q;
 			/^\[(verse|synopsis)\]$/d;
-			s/\{litdd\}/--/g;
+			s/\\--/--/g;
 			s/'\''(git[ a-z-]*)'\''/\1/g;
 
 			p;

base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
-- 
gitgitgadget
