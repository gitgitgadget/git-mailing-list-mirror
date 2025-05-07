Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA028FAAA
	for <git@vger.kernel.org>; Wed,  7 May 2025 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651712; cv=none; b=DgfxiUATDvtnOxyvR1+oXKzeuOY2xGX6aI+Aokeec23AGX/AO7J//vBhK4t5G2NONUr1ph3xWnmmzxClyMlHEvuoKYNT4H4Jtb/Xlw8PZOH48M/TBDk1AtZ/m1G5xoZIxbEkSLikZva29p+H9X1TwO8rFBnIbp/IDWf7bNLmB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651712; c=relaxed/simple;
	bh=CeSyEute1oNfUmgsr0v6G4OR1aH9Ktr1SAche5tXSzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zj+JUfi4XlULUUHeRXcWi5jtiBJOJ9GGSiw6Yhn512xUpCUftpj2s10Vz7ajnPsC1TmbVwYUQtbXIXd8MRPFQSYwuqy4EyNOyledI7pE5Ez+CMfOlj/MDC3gc+Ceho7Z0OEWXZnp/XrpSReg/c/xdIkMsLiFzPMRAPUtqTCQvF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from cayenne.. (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8E19113F89C;
	Wed,  7 May 2025 23:01:44 +0200 (CEST)
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] Additional changes
Date: Wed,  7 May 2025 22:58:16 +0200
Message-ID: <20250507210104.26709-2-jn.avila@free.fr>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250507210104.26709-1-jn.avila@free.fr>
References: <20250503011537.3035416-1-gitster@pobox.com>
 <20250507210104.26709-1-jn.avila@free.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Documentation/git-daemon.adoc     | 60 +++++++++++++++----------------
 Documentation/git-var.adoc        | 40 ++++++++++-----------
 Documentation/git-verify-tag.adoc |  2 +-
 Documentation/git-write-tree.adoc |  2 +-
 4 files changed, 51 insertions(+), 53 deletions(-)

diff --git a/Documentation/git-daemon.adoc b/Documentation/git-daemon.adoc
index bc3f77405e..99389f0388 100644
--- a/Documentation/git-daemon.adoc
+++ b/Documentation/git-daemon.adoc
@@ -36,13 +36,13 @@ pass some directory paths as `git daemon` arguments, the offers are limited to
 repositories within those directories.
 
 By default, only `upload-pack` service is enabled, which serves
-'git fetch-pack' and 'git ls-remote' clients, which are invoked
-from 'git fetch', 'git pull', and 'git clone'.
+`git fetch-pack` and `git ls-remote` clients, which are invoked
+from `git fetch`, `git pull`, and `git clone`.
 
 This is ideally suited for read-only updates, i.e., pulling from
 Git repositories.
 
-An `upload-archive` also exists to serve 'git archive'.
+An `upload-archive` also exists to serve `git archive`.
 
 OPTIONS
 -------
@@ -61,24 +61,24 @@ OPTIONS
 
 `--base-path-relaxed`::
 	If `--base-path` is enabled and repo lookup fails, with this option
-	'git daemon' will attempt to lookup without prefixing the base path.
+	`git daemon` will attempt to lookup without prefixing the base path.
 	This is useful for switching to `--base-path` usage, while still
 	allowing the old paths.
 
 `--interpolated-path=<pathtemplate>`::
 	To support virtual hosting, an interpolated path template can be
 	used to dynamically construct alternate paths.  The template
-	supports %H for the target hostname as supplied by the client but
-	converted to all lowercase, %CH for the canonical hostname,
-	%IP for the server's IP address, %P for the port number,
-	and %D for the absolute path of the named repository.
+	supports `%H` for the target hostname as supplied by the client but
+	converted to all lowercase, `%CH` for the canonical hostname,
+	`%IP` for the server's IP address, `%P` for the port number,
+	and `%D` for the absolute path of the named repository.
 	After interpolation, the path is validated against the directory
 	list.
 
 `--export-all`::
 	Allow pulling from all directories that look like Git repositories
 	(have the 'objects' and 'refs' subdirectories), even if they
-	do not have the 'git-daemon-export-ok' file.
+	do not have the `git-daemon-export-ok` file.
 
 `--inetd`::
 	Have the server run as an inetd service. Implies `--syslog` (may
@@ -118,17 +118,17 @@ OPTIONS
 	Send log messages to the specified destination.
 	Note that this option does not imply `--verbose`,
 	thus by default only error conditions will be logged.
-	The <destination> must be one of:
+	The _<destination>_ must be one of:
 +
 --
-stderr::
+`stderr`::
 	Write to standard error.
 	Note that if `--detach` is specified,
 	the process disconnects from the real standard error,
 	making this destination effectively equivalent to `none`.
-syslog::
+`syslog`::
 	Write to syslog, using the `git-daemon` identifier.
-none::
+`none`::
 	Disable all logging.
 --
 +
@@ -149,7 +149,7 @@ otherwise `stderr`.
 	Log details about the incoming connections and requested files.
 
 `--reuseaddr`::
-	Use SO_REUSEADDR when binding the listening socket.
+	Use `SO_REUSEADDR` when binding the listening socket.
 	This allows the server to restart without waiting for
 	old connections to time out.
 
@@ -157,7 +157,7 @@ otherwise `stderr`.
 	Detach from the shell. Implies `--syslog`.
 
 `--pid-file=<file>`::
-	Save the process id in 'file'.  Ignored when the daemon
+	Save the process id in _<file>_.  Ignored when the daemon
 	is run under `--inetd`.
 
 `--user=<user>`::
@@ -170,14 +170,14 @@ otherwise `stderr`.
 +
 Giving these options is an error when used with `--inetd`; use
 the facility of inet daemon to achieve the same before spawning
-'git daemon' if needed.
+`git daemon` if needed.
 +
 Like many programs that switch user id, the daemon does not reset
-environment variables such as `$HOME` when it runs git programs,
+environment variables such as `HOME` when it runs git programs,
 e.g. `upload-pack` and `receive-pack`. When using this option, you
 may also want to set and export `HOME` to point at the home
-directory of `<user>` before starting the daemon, and make sure any
-Git configuration files in that directory are readable by `<user>`.
+directory of _<user>_ before starting the daemon, and make sure any
+Git configuration files in that directory are readable by _<user>_.
 
 `--enable=<service>`::
 `--disable=<service>`::
@@ -206,8 +206,8 @@ Git configuration files in that directory are readable by `<user>`.
 `--access-hook=<path>`::
 	Every time a client connects, first run an external command
 	specified by the <path> with service name (e.g. "upload-pack"),
-	path to the repository, hostname (%H), canonical hostname
-	(%CH), IP address (%IP), and TCP port (%P) as its command-line
+	path to the repository, hostname (`%H`), canonical hostname
+	(`%CH`), IP address (`%IP`), and TCP port (`%P`) as its command-line
 	arguments. The external command can decide to decline the
 	service by exiting with a non-zero status (or to allow it by
 	exiting with a zero status).  It can also look at the $REMOTE_ADDR
@@ -218,7 +218,7 @@ The external command can optionally write a single line to its
 standard output to be sent to the requestor as an error message when
 it declines the service.
 
-<directory>::
+_<directory>_::
 	The remaining arguments provide a list of directories. If any
 	directories are specified, then the `git-daemon` process will
 	serve a requested directory only if it is contained in one of
@@ -230,24 +230,24 @@ SERVICES
 
 These services can be globally enabled/disabled using the
 command-line options of this command.  If finer-grained
-control is desired (e.g. to allow 'git archive' to be run
+control is desired (e.g. to allow `git archive` to be run
 against only in a few selected repositories the daemon serves),
 the per-repository configuration file can be used to enable or
 disable them.
 
 upload-pack::
-	This serves 'git fetch-pack' and 'git ls-remote'
+	This serves `git fetch-pack` and `git ls-remote`
 	clients.  It is enabled by default, but a repository can
 	disable it by setting `daemon.uploadpack` configuration
 	item to `false`.
 
 upload-archive::
-	This serves 'git archive --remote'.  It is disabled by
+	This serves `git archive --remote`.  It is disabled by
 	default, but a repository can enable it by setting
 	`daemon.uploadarch` configuration item to `true`.
 
 receive-pack::
-	This serves 'git send-pack' clients, allowing anonymous
+	This serves `git send-pack` clients, allowing anonymous
 	push.  It is disabled by default, as there is _no_
 	authentication in the protocol (in other words, anybody
 	can push anything into the repository, including removal
@@ -301,7 +301,7 @@ default repository could be made as well.
 
 
 'git daemon' as regular daemon for virtual hosts::
-	To set up 'git daemon' as a regular, non-inetd service that
+	To set up `git daemon` as a regular, non-inetd service that
 	handles repositories for multiple virtual hosts based on
 	their IP addresses, start the daemon like this:
 +
@@ -318,7 +318,7 @@ Repositories can still be accessed by hostname though, assuming
 they correspond to these IP addresses.
 
 selectively enable/disable services per repository::
-	To enable 'git archive --remote' and disable 'git fetch' against
+	To enable `git archive --remote` and disable `git fetch` against
 	a repository, have the following in the configuration file in the
 	repository (that is the file 'config' next to `HEAD`, 'refs' and
 	'objects').
@@ -332,8 +332,8 @@ selectively enable/disable services per repository::
 
 ENVIRONMENT
 -----------
-'git daemon' will set REMOTE_ADDR to the IP address of the client
-that connected to it, if the IP address is available. REMOTE_ADDR will
+`git daemon` will set `REMOTE_ADDR` to the IP address of the client
+that connected to it, if the IP address is available. `REMOTE_ADDR` will
 be available in the environment of hooks called when
 services are performed.
 
diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index 909963b1c2..b606c2d649 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -32,58 +32,56 @@ EXAMPLES
 
 VARIABLES
 ---------
-GIT_AUTHOR_IDENT::
+`GIT_AUTHOR_IDENT`::
     The author of a piece of code.
 
-GIT_COMMITTER_IDENT::
+`GIT_COMMITTER_IDENT`::
     The person who put a piece of code into Git.
 
-GIT_EDITOR::
+`GIT_EDITOR`::
     Text editor for use by Git commands.  The value is meant to be
     interpreted by the shell when it is used.  Examples: `~/bin/vi`,
     `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
-    --nofork`.  The order of preference is the `$GIT_EDITOR`
-    environment variable, then `core.editor` configuration, then
-    `$VISUAL`, then `$EDITOR`, and then the default chosen at compile
+    --nofork`.  The order of preference is `$GIT_EDITOR`, then
+    `core.editor` configuration value, then `$VISUAL`, then
+    `$EDITOR`, and then the default chosen at compile
     time, which is usually 'vi'.
 ifdef::git-default-editor[]
     The build you are using chose '{git-default-editor}' as the default.
 endif::git-default-editor[]
 
-GIT_SEQUENCE_EDITOR::
+`GIT_SEQUENCE_EDITOR`::
     Text editor used to edit the 'todo' file while running `git rebase
     -i`. Like `GIT_EDITOR`, the value is meant to be interpreted by
-    the shell when it is used. The order of preference is the
-    `$GIT_SEQUENCE_EDITOR` environment variable, then
-    `sequence.editor` configuration, and then the value of `git var
-    GIT_EDITOR`.
+    the shell when it is used. The order of preference is
+    `$GIT_SEQUENCE_EDITOR`, then `sequence.editor` configuration value,
+    and then the value of `git var GIT_EDITOR`.
 
-GIT_PAGER::
+`GIT_PAGER`::
     Text viewer for use by Git commands (e.g., 'less').  The value
     is meant to be interpreted by the shell.  The order of preference
-    is the `$GIT_PAGER` environment variable, then `core.pager`
-    configuration, then `$PAGER`, and then the default chosen at
-    compile time (usually 'less').
+    is `$GIT_PAGER`, then the value of `core.pager` configuration, then
+    `$PAGER`, and then the default chosen at compile time (usually `less`).
 ifdef::git-default-pager[]
     The build you are using chose '{git-default-pager}' as the default.
 endif::git-default-pager[]
 
-GIT_DEFAULT_BRANCH::
+`GIT_DEFAULT_BRANCH`::
     The name of the first branch created in newly initialized repositories.
 
-GIT_SHELL_PATH::
+`GIT_SHELL_PATH`::
     The path of the binary providing the POSIX shell for commands which use the shell.
 
-GIT_ATTR_SYSTEM::
+`GIT_ATTR_SYSTEM`::
     The path to the system linkgit:gitattributes[5] file, if one is enabled.
 
-GIT_ATTR_GLOBAL::
+`GIT_ATTR_GLOBAL`::
     The path to the global (per-user) linkgit:gitattributes[5] file.
 
-GIT_CONFIG_SYSTEM::
+`GIT_CONFIG_SYSTEM`::
     The path to the system configuration file, if one is enabled.
 
-GIT_CONFIG_GLOBAL::
+`GIT_CONFIG_GLOBAL`::
     The path to the global (per-user) configuration files, if any.
 
 Most path values contain only one value. However, some can contain multiple
diff --git a/Documentation/git-verify-tag.adoc b/Documentation/git-verify-tag.adoc
index ec995323f6..b3721a86f4 100644
--- a/Documentation/git-verify-tag.adoc
+++ b/Documentation/git-verify-tag.adoc
@@ -12,7 +12,7 @@ git verify-tag [-v | --verbose] [--format=<format>] [--raw] <tag>...
 
 DESCRIPTION
 -----------
-Validates the gpg signature created by 'git tag' in the tag
+Validates the gpg signature created by `git tag` in the tag
 objects listed on the command line.
 
 OPTIONS
diff --git a/Documentation/git-write-tree.adoc b/Documentation/git-write-tree.adoc
index 4e1c3b9c0c..4c7100ea1e 100644
--- a/Documentation/git-write-tree.adoc
+++ b/Documentation/git-write-tree.adoc
@@ -34,7 +34,7 @@ OPTIONS
 
 `--prefix=<prefix>/`::
 	Writes a tree object that represents a subdirectory
-	`<prefix>`.  This can be used to write the tree object
+	_<prefix>_.  This can be used to write the tree object
 	for a subproject that is in the named subdirectory.
 
 GIT
-- 
2.48.0

