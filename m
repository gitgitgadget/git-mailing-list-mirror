Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37542AB4
	for <git@vger.kernel.org>; Sat, 10 May 2025 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746880489; cv=none; b=gQGh6ao2LsBdoZ503yL+FZqASzlYMlDKuVscE8L2xMilZyAvXyWv35VY23KTOsp0JVtUjVTgo8p4j6ZBbQlnI7nZ7HVkqNmVWziTx5q/D2+BSePN0fr+s4bf0lwaDZii/RoewbQxdiGmCh3rIO//vGDjdigPQwE5RLxS75UtiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746880489; c=relaxed/simple;
	bh=LrvTyCsG4gH6wbZRWQASp23glSnGgXNk/1WWK/vTYPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeMRrKur52Q1kHt7hHjNaUyRJn4oTHTvUnnJeyicPB74M9FXe+D0tzvGgccPeHsHWqkW+82CAwt5zcJMlKBDaFtR/Mz1u5EzBzXxgR14MtE7Gmj05EvpRP/8EikfZG2svd86s3onXQrnG0XfpzSWqDM9hOSPLg7ZRzPuD2D4TW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from cayenne.. (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A924213F8CE;
	Sat, 10 May 2025 14:34:39 +0200 (CEST)
From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3 1/4] git-daemon doc: update mark-up of synopsis option descriptions
Date: Sat, 10 May 2025 14:33:14 +0200
Message-ID: <20250510123346.20927-2-jn.avila@free.fr>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250510123346.20927-1-jn.avila@free.fr>
References: <20250501213414.370514-1-gitster@pobox.com>
 <20250510123346.20927-1-jn.avila@free.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

To unify mark-up used in our documentation to a newer convention,
started by 22293895 (doc: apply synopsis simplification on git-clone
and git-init, 2024-09-24), update the documentation of 'git daemon'
to

 * use [synopsis], not [verse] in the SYNOPSIS section
 * enclose `--option=<value>` in backquotes

Also, split '--[no-]option' into '--option' and '--no-option'
to make it easier to grep for them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-daemon.adoc | 181 +++++++++++++++++-----------------
 1 file changed, 91 insertions(+), 90 deletions(-)

diff --git a/Documentation/git-daemon.adoc b/Documentation/git-daemon.adoc
index ede7b935d6..99389f0388 100644
--- a/Documentation/git-daemon.adoc
+++ b/Documentation/git-daemon.adoc
@@ -7,21 +7,21 @@ git-daemon - A really simple server for Git repositories
 
 SYNOPSIS
 --------
-[verse]
-'git daemon' [--verbose] [--syslog] [--export-all]
-	     [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]
-	     [--strict-paths] [--base-path=<path>] [--base-path-relaxed]
-	     [--user-path | --user-path=<path>]
-	     [--interpolated-path=<pathtemplate>]
-	     [--reuseaddr] [--detach] [--pid-file=<file>]
-	     [--enable=<service>] [--disable=<service>]
-	     [--allow-override=<service>] [--forbid-override=<service>]
-	     [--access-hook=<path>] [--[no-]informative-errors]
-	     [--inetd |
-	      [--listen=<host-or-ipaddr>] [--port=<n>]
-	      [--user=<user> [--group=<group>]]]
-	     [--log-destination=(stderr|syslog|none)]
-	     [<directory>...]
+[synopsis]
+git daemon [--verbose] [--syslog] [--export-all]
+	   [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]
+	   [--strict-paths] [--base-path=<path>] [--base-path-relaxed]
+	   [--user-path | --user-path=<path>]
+	   [--interpolated-path=<pathtemplate>]
+	   [--reuseaddr] [--detach] [--pid-file=<file>]
+	   [--enable=<service>] [--disable=<service>]
+	   [--allow-override=<service>] [--forbid-override=<service>]
+	   [--access-hook=<path>] [--[no-]informative-errors]
+	   [--inetd |
+	     [--listen=<host-or-ipaddr>] [--port=<n>]
+	     [--user=<user> [--group=<group>]]]
+	   [--log-destination=(stderr|syslog|none)]
+	   [<directory>...]
 
 DESCRIPTION
 -----------
@@ -32,111 +32,111 @@ that service if it is enabled.
 It verifies that the directory has the magic file "git-daemon-export-ok", and
 it will refuse to export any Git directory that hasn't explicitly been marked
 for export this way (unless the `--export-all` parameter is specified). If you
-pass some directory paths as 'git daemon' arguments, the offers are limited to
+pass some directory paths as `git daemon` arguments, the offers are limited to
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
---strict-paths::
+`--strict-paths`::
 	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
 	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
-	'git daemon' will refuse to start when this option is enabled and no
+	`git daemon` will refuse to start when this option is enabled and no
 	directory arguments are provided.
 
---base-path=<path>::
+`--base-path=<path>`::
 	Remap all the path requests as relative to the given path.
-	This is sort of "Git root" - if you run 'git daemon' with
-	'--base-path=/srv/git' on example.com, then if you later try to pull
-	'git://example.com/hello.git', 'git daemon' will interpret the path
-	as `/srv/git/hello.git`.
-
---base-path-relaxed::
-	If --base-path is enabled and repo lookup fails, with this option
-	'git daemon' will attempt to lookup without prefixing the base path.
-	This is useful for switching to --base-path usage, while still
+	This is sort of "Git root" - if you run `git daemon` with
+	`--base-path=/srv/git` on `example.com`, then if you later try
+	to pull from `git://example.com/hello.git`, `git daemon` will
+	interpret the path as `/srv/git/hello.git`.
+
+`--base-path-relaxed`::
+	If `--base-path` is enabled and repo lookup fails, with this option
+	`git daemon` will attempt to lookup without prefixing the base path.
+	This is useful for switching to `--base-path` usage, while still
 	allowing the old paths.
 
---interpolated-path=<pathtemplate>::
+`--interpolated-path=<pathtemplate>`::
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
 
---export-all::
+`--export-all`::
 	Allow pulling from all directories that look like Git repositories
 	(have the 'objects' and 'refs' subdirectories), even if they
-	do not have the 'git-daemon-export-ok' file.
+	do not have the `git-daemon-export-ok` file.
 
---inetd::
-	Have the server run as an inetd service. Implies --syslog (may be
-	overridden with `--log-destination=`).
-	Incompatible with --detach, --port, --listen, --user and --group
-	options.
+`--inetd`::
+	Have the server run as an inetd service. Implies `--syslog` (may
+	be overridden with `--log-destination=`).
+	Incompatible with `--detach`, `--port`, `--listen`, `--user` and
+	`--group` options.
 
---listen=<host-or-ipaddr>::
+`--listen=<host-or-ipaddr>`::
 	Listen on a specific IP address or hostname.  IP addresses can
 	be either an IPv4 address or an IPv6 address if supported.  If IPv6
-	is not supported, then --listen=<hostname> is also not supported and
-	--listen must be given an IPv4 address.
+	is not supported, then `--listen=<hostname>` is also not supported
+	and `--listen` must be given an IPv4 address.
 	Can be given more than once.
 	Incompatible with `--inetd` option.
 
---port=<n>::
+`--port=<n>`::
 	Listen on an alternative port.  Incompatible with `--inetd` option.
 
---init-timeout=<n>::
+`--init-timeout=<n>`::
 	Timeout (in seconds) between the moment the connection is established
 	and the client request is received (typically a rather low value, since
 	that should be basically immediate).
 
---timeout=<n>::
+`--timeout=<n>`::
 	Timeout (in seconds) for specific client sub-requests. This includes
 	the time it takes for the server to process the sub-request and the
 	time spent waiting for the next client's request.
 
---max-connections=<n>::
+`--max-connections=<n>`::
 	Maximum number of concurrent clients, defaults to 32.  Set it to
 	zero for no limit.
 
---syslog::
+`--syslog`::
 	Short for `--log-destination=syslog`.
 
---log-destination=<destination>::
+`--log-destination=<destination>`::
 	Send log messages to the specified destination.
-	Note that this option does not imply --verbose,
+	Note that this option does not imply `--verbose`,
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
 The default destination is `syslog` if `--inetd` or `--detach` is specified,
 otherwise `stderr`.
 
---user-path::
---user-path=<path>::
+`--user-path`::
+`--user-path=<path>`::
 	Allow {tilde}user notation to be used in requests.  When
 	specified with no parameter, a request to
 	git://host/{tilde}alice/foo is taken as a request to access
@@ -145,23 +145,23 @@ otherwise `stderr`.
 	taken as a request to access `<path>/foo` repository in
 	the home directory of user `alice`.
 
---verbose::
+`--verbose`::
 	Log details about the incoming connections and requested files.
 
---reuseaddr::
-	Use SO_REUSEADDR when binding the listening socket.
+`--reuseaddr`::
+	Use `SO_REUSEADDR` when binding the listening socket.
 	This allows the server to restart without waiting for
 	old connections to time out.
 
---detach::
-	Detach from the shell. Implies --syslog.
+`--detach`::
+	Detach from the shell. Implies `--syslog`.
 
---pid-file=<file>::
-	Save the process id in 'file'.  Ignored when the daemon
+`--pid-file=<file>`::
+	Save the process id in _<file>_.  Ignored when the daemon
 	is run under `--inetd`.
 
---user=<user>::
---group=<group>::
+`--user=<user>`::
+`--group=<group>`::
 	Change daemon's uid and gid before entering the service loop.
 	When only `--user` is given without `--group`, the
 	primary group ID for the user is used.  The values of
@@ -170,43 +170,44 @@ otherwise `stderr`.
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
 
---enable=<service>::
---disable=<service>::
+`--enable=<service>`::
+`--disable=<service>`::
 	Enable/disable the service site-wide per default.  Note
 	that a service disabled site-wide can still be enabled
 	per repository if it is marked overridable and the
 	repository enables the service with a configuration
 	item.
 
---allow-override=<service>::
---forbid-override=<service>::
+`--allow-override=<service>`::
+`--forbid-override=<service>`::
 	Allow/forbid overriding the site-wide default with per
 	repository configuration.  By default, all the services
 	may be overridden.
 
---[no-]informative-errors::
+`--informative-errors`::
+`--no-informative-errors`::
 	When informative errors are turned on, git-daemon will report
 	more verbose errors to the client, differentiating conditions
 	like "no such repository" from "repository not exported". This
 	is more convenient for clients, but may leak information about
 	the existence of unexported repositories.  When informative
 	errors are not enabled, all errors report "access denied" to the
-	client. The default is --no-informative-errors.
+	client. The default is `--no-informative-errors`.
 
---access-hook=<path>::
+`--access-hook=<path>`::
 	Every time a client connects, first run an external command
 	specified by the <path> with service name (e.g. "upload-pack"),
-	path to the repository, hostname (%H), canonical hostname
-	(%CH), IP address (%IP), and TCP port (%P) as its command-line
+	path to the repository, hostname (`%H`), canonical hostname
+	(`%CH`), IP address (`%IP`), and TCP port (`%P`) as its command-line
 	arguments. The external command can decide to decline the
 	service by exiting with a non-zero status (or to allow it by
 	exiting with a zero status).  It can also look at the $REMOTE_ADDR
@@ -217,7 +218,7 @@ The external command can optionally write a single line to its
 standard output to be sent to the requestor as an error message when
 it declines the service.
 
-<directory>::
+_<directory>_::
 	The remaining arguments provide a list of directories. If any
 	directories are specified, then the `git-daemon` process will
 	serve a requested directory only if it is contained in one of
@@ -229,24 +230,24 @@ SERVICES
 
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
@@ -300,7 +301,7 @@ default repository could be made as well.
 
 
 'git daemon' as regular daemon for virtual hosts::
-	To set up 'git daemon' as a regular, non-inetd service that
+	To set up `git daemon` as a regular, non-inetd service that
 	handles repositories for multiple virtual hosts based on
 	their IP addresses, start the daemon like this:
 +
@@ -317,7 +318,7 @@ Repositories can still be accessed by hostname though, assuming
 they correspond to these IP addresses.
 
 selectively enable/disable services per repository::
-	To enable 'git archive --remote' and disable 'git fetch' against
+	To enable `git archive --remote` and disable `git fetch` against
 	a repository, have the following in the configuration file in the
 	repository (that is the file 'config' next to `HEAD`, 'refs' and
 	'objects').
@@ -331,8 +332,8 @@ selectively enable/disable services per repository::
 
 ENVIRONMENT
 -----------
-'git daemon' will set REMOTE_ADDR to the IP address of the client
-that connected to it, if the IP address is available. REMOTE_ADDR will
+`git daemon` will set `REMOTE_ADDR` to the IP address of the client
+that connected to it, if the IP address is available. `REMOTE_ADDR` will
 be available in the environment of hooks called when
 services are performed.
 
-- 
2.48.0

