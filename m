From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 4/4] Documentation/git-svn.txt: Fix formatting errors
Date: Thu,  1 Mar 2007 22:41:17 +0300
Message-ID: <11727781092949-git-send-email-vsu@altlinux.ru>
References: <1172778077659-git-send-email-vsu@altlinux.ru> <11727780872894-git-send-email-vsu@altlinux.ru> <11727780982140-git-send-email-vsu@altlinux.ru>
Cc: git@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 20:42:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMrAn-0004Zx-NS
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 20:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965539AbXCATmk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 14:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965540AbXCATmk
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 14:42:40 -0500
Received: from master.altlinux.org ([62.118.250.235]:4151 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965539AbXCATmj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 14:42:39 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id C2779E34CD; Thu,  1 Mar 2007 22:42:37 +0300 (MSK)
X-Mailer: git-send-email 1.5.0.2.285.g5347
In-Reply-To: <11727780982140-git-send-email-vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41122>

Fix some formatting problems:

  - Some list labels were missing their "::" characters.
  - Some of continuation paragraphs in labeled lists were incorrectly
    formatted as literal paragraphs.
  - In one case "[verse]" was missing before the config key list.
  - The "Basic Examples" section was incorrectly nested inside the
    "Config File-Only Options" section.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
Cc: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |  119 +++++++++++++++++++++++++--------------------
 1 files changed, 67 insertions(+), 52 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index cf094ca..06b49b0 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -63,7 +63,7 @@ COMMANDS
 	transports (eg svn+ssh://), you must include the username in
 	the URL, eg svn+ssh://foo@svn.bar.com/project
 
---prefix=<prefix>
+--prefix=<prefix>::
 	This allows one to specify a prefix which is prepended
 	to the names of remotes if trunk/branches/tags are
 	specified.  The prefix does not automatically include a
@@ -94,16 +94,16 @@ COMMANDS
 	This fetches revisions from the SVN parent of the current HEAD
 	and rebases the current (uncommitted to SVN) work against it.
 
-	This works similarly to 'svn update' or 'git-pull' except that
-	it preserves linear history with 'git-rebase' instead of
-	'git-merge' for ease of dcommit-ing with git-svn.
+This works similarly to 'svn update' or 'git-pull' except that
+it preserves linear history with 'git-rebase' instead of
+'git-merge' for ease of dcommit-ing with git-svn.
 
-	This accepts all options that 'git-svn fetch' and 'git-rebase'
-	accepts.  However '--fetch-all' only fetches from the current
-	[svn-remote], and not all [svn-remote] definitions.
+This accepts all options that 'git-svn fetch' and 'git-rebase'
+accepts.  However '--fetch-all' only fetches from the current
+[svn-remote], and not all [svn-remote] definitions.
 
-	Like 'git-rebase'; this requires that the working tree be clean
-	and have no uncommitted changes.
+Like 'git-rebase'; this requires that the working tree be clean
+and have no uncommitted changes.
 
 'dcommit'::
 	Commit each diff from a specified head directly to the SVN
@@ -117,29 +117,40 @@ COMMANDS
 	alternative to HEAD.
 	This is advantageous over 'set-tree' (below) because it produces
 	cleaner, more linear history.
+--
 
 'log'::
 	This should make it easy to look up svn log messages when svn
 	users refer to -r/--revision numbers.
++
+The following features from `svn log' are supported:
++
+--
+--revision=<n>[:<n>];;
+	is supported, non-numeric args are not:
+	HEAD, NEXT, BASE, PREV, etc ...
+-v/--verbose;;
+	it's not completely compatible with the --verbose
+	output in svn log, but reasonably close.
+--limit=<n>;;
+	is NOT the same as --max-count, doesn't count
+	merged/excluded commits
+--incremental;;
+	supported
+--
++
+New features:
++
+--
+--show-commit;;
+	shows the git commit sha1, as well
+--oneline;;
+	our version of --pretty=oneline
+--
++
+Any other arguments are passed directly to `git log'
 
-	The following features from `svn log' are supported:
-
-	--revision=<n>[:<n>] - is supported, non-numeric args are not:
-	                       HEAD, NEXT, BASE, PREV, etc ...
-	-v/--verbose         - it's not completely compatible with
-	                       the --verbose output in svn log, but
-			       reasonably close.
-	--limit=<n>          - is NOT the same as --max-count,
-	                       doesn't count merged/excluded commits
-	--incremental        - supported
-
-	New features:
-
-	--show-commit        - shows the git commit sha1, as well
-	--oneline            - our version of --pretty=oneline
-
-	Any other arguments are passed directly to `git log'
-
+--
 'set-tree'::
 	You should consider using 'dcommit' instead of this command.
 	Commit specified commit or tree objects to SVN.  This relies on
@@ -256,16 +267,18 @@ config key: svn.authorsfile
 	Make git-svn less verbose.
 
 --repack[=<n>]::
---repack-flags=<flags>
-	These should help keep disk usage sane for large fetches
-	with many revisions.
+--repack-flags=<flags>::
+
+These should help keep disk usage sane for large fetches
+with many revisions.
 
-	--repack takes an optional argument for the number of revisions
-	to fetch before repacking.  This defaults to repacking every
-	1000 commits fetched if no argument is specified.
+--repack takes an optional argument for the number of revisions
+to fetch before repacking.  This defaults to repacking every
+1000 commits fetched if no argument is specified.
 
-	--repack-flags are passed directly to gitlink:git-repack[1].
+--repack-flags are passed directly to gitlink:git-repack[1].
 
+[verse]
 config key: svn.repack
 config key: svn.repackflags
 
@@ -323,28 +336,30 @@ CONFIG FILE-ONLY OPTIONS
 
 svn.noMetadata::
 svn-remote.<name>.noMetadata::
-	This gets rid of the git-svn-id: lines at the end of every commit.
 
-	If you lose your .git/svn/git-svn/.rev_db file, git-svn will not
-	be able to rebuild it and you won't be able to fetch again,
-	either.  This is fine for one-shot imports.
+This gets rid of the git-svn-id: lines at the end of every commit.
+
+If you lose your .git/svn/git-svn/.rev_db file, git-svn will not
+be able to rebuild it and you won't be able to fetch again,
+either.  This is fine for one-shot imports.
 
-	The 'git-svn log' command will not work on repositories using
-	this, either.  Using this conflicts with the 'useSvmProps'
-	option for (hopefully) obvious reasons.
+The 'git-svn log' command will not work on repositories using
+this, either.  Using this conflicts with the 'useSvmProps'
+option for (hopefully) obvious reasons.
 
 svn.useSvmProps::
 svn-remote.<name>.useSvmProps::
-	This allows git-svn to re-map repository URLs and UUIDs from
-	mirrors created using SVN::Mirror (or svk) for metadata.
 
-	If an SVN revision has a property, "svm:headrev", it is likely
-	that the revision was created by SVN::Mirror (also used by SVK).
-	The property contains a repository UUID and a revision.  We want
-	to make it look like we are mirroring the original URL, so
-	introduce a helper function that returns the original identity
-	URL and UUID, and use it when generating metadata in commit
-	messages.
+This allows git-svn to re-map repository URLs and UUIDs from
+mirrors created using SVN::Mirror (or svk) for metadata.
+
+If an SVN revision has a property, "svm:headrev", it is likely
+that the revision was created by SVN::Mirror (also used by SVK).
+The property contains a repository UUID and a revision.  We want
+to make it look like we are mirroring the original URL, so
+introduce a helper function that returns the original identity
+URL and UUID, and use it when generating metadata in commit
+messages.
 
 svn.useSvnsyncProps::
 svn-remote.<name>.useSvnsyncprops::
@@ -369,8 +384,8 @@ section because they affect the 'git-svn-id:' metadata line.
 
 --
 
-Basic Examples
-~~~~~~~~~~~~~~
+BASIC EXAMPLES
+--------------
 
 Tracking and contributing to a the trunk of a Subversion-managed project:
 
-- 
1.5.0.2.285.g5347
