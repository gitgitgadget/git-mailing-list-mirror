From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH 2/3] Docs: move git url and remotes text to separate sections
Date: Tue, 7 Feb 2006 03:22:55 +0000 (UTC)
Message-ID: <1139282428.ec02f402.1@fieldses.org>
References: <1139282428.ec02f402.0@fieldses.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 04:22:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6JQy-000744-Fy
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 04:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWBGDWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 22:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWBGDWZ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 22:22:25 -0500
Received: from mail.fieldses.org ([66.93.2.214]:9607 "EHLO puzzle.fieldses.org")
	by vger.kernel.org with ESMTP id S932449AbWBGDWY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 22:22:24 -0500
Received: from bfields by puzzle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1F6JPk-0004Jl-RY; Mon, 06 Feb 2006 22:21:12 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <1139282428.ec02f402.0@fieldses.org>
Date: Sun Feb 5 18:29:49 2006 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15682>

The sections on git urls and remotes files in the git-fetch,
git-pull, and git-push manpages seem long enough to be worth a
manpage section of their own.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

---

 Documentation/git-fetch.txt        |    2 +-
 Documentation/git-pull.txt         |    3 ++-
 Documentation/git-push.txt         |    5 +++--
 Documentation/pull-fetch-param.txt |    3 +--
 Documentation/urls.txt             |   32 +++++++++++++++++++-------------
 5 files changed, 26 insertions(+), 19 deletions(-)

6f35b7d338781d0ad18980045cdc6ff4fe0a7b98
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index d1b45f9..a67dc34 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -27,7 +27,7 @@ include::fetch-options.txt[]
 
 include::pull-fetch-param.txt[]
 
-
+include::urls.txt[]
 
 SEE ALSO
 --------
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 3a7d385..20175f4 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -29,8 +29,9 @@ include::fetch-options.txt[]
 
 include::pull-fetch-param.txt[]
 
-include::merge-strategies.txt[]
+include::urls.txt[]
 
+include::merge-strategies.txt[]
 
 EXAMPLES
 --------
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 7e9452e..ce909f5 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -24,8 +24,8 @@ documentation for gitlink:git-receive-pa
 OPTIONS
 -------
 <repository>::
-	The "remote" repository that is destination of a push operation.
-include::urls.txt[]
+	The "remote" repository that is destination of a push
+	operation.  See the section <<URLS,GIT URLS>> below.
 
 <refspec>::
 	The canonical format of a <refspec> parameter is
@@ -65,6 +65,7 @@ Some short-cut notations are also suppor
 	This flag disables the check.  This can cause the
 	remote repository to lose commits; use it with care.
 
+include::urls.txt[]
 
 Author
 ------
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 9011ffb..e852f41 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -1,7 +1,6 @@
 <repository>::
 	The "remote" repository that is the source of a fetch
-	or pull operation.
-include::urls.txt[]
+	or pull operation.  See the section <<URLS,GIT URLS>> below.
 
 <refspec>::
 	The canonical format of a <refspec> parameter is
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index e027c71..7477413 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -1,6 +1,9 @@
+GIT URLS[[URLS]]
+----------------
+
 One of the following notations can be used
 to name the remote repository:
-+
+
 ===============================================================
 - rsync://host.xz/path/to/repo.git/
 - http://host.xz/path/to/repo.git/
@@ -11,39 +14,42 @@ to name the remote repository:
 - ssh://host.xz/~user/path/to/repo.git/
 - ssh://host.xz/~/path/to/repo.git
 ===============================================================
-+
+
 SSH Is the default transport protocol and also supports an
 scp-like syntax.  Both syntaxes support username expansion,
 as does the native git protocol. The following three are
 identical to the last three above, respectively:
-+
+
 ===============================================================
 - host.xz:/path/to/repo.git/
 - host.xz:~user/path/to/repo.git/
 - host.xz:path/to/repo.git
 ===============================================================
-+
+
 To sync with a local directory, use:
-+
+
 ===============================================================
 - /path/to/repo.git/
 ===============================================================
-+
+
+REMOTES
+-------
+
 In addition to the above, as a short-hand, the name of a
 file in `$GIT_DIR/remotes` directory can be given; the
 named file should be in the following format:
-+
+
 	URL: one of the above URL format
 	Push: <refspec>
 	Pull: <refspec>
-+
-When such a short-hand is specified in place of
+
+Then such a short-hand is specified in place of
 <repository> without <refspec> parameters on the command
 line, <refspec> specified on `Push:` lines or `Pull:`
 lines are used for `git-push` and `git-fetch`/`git-pull`,
 respectively.  Multiple `Push:` and and `Pull:` lines may
 be specified for additional branch mappings.
-+
+
 The name of a file in `$GIT_DIR/branches` directory can be
 specified as an older notation short-hand; the named
 file should contain a single line, a URL in one of the
@@ -52,11 +58,11 @@ name of remote head (URL fragment notati
 `$GIT_DIR/branches/<remote>` file that stores a <url>
 without the fragment is equivalent to have this in the
 corresponding file in the `$GIT_DIR/remotes/` directory.
-+
+
 	URL: <url>
 	Pull: refs/heads/master:<remote>
-+
+
 while having `<url>#<head>` is equivalent to
-+
+
 	URL: <url>
 	Pull: refs/heads/<head>:<remote>
-- 
0.99.8b.g3480-dirty
