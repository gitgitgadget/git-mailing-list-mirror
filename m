From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] Fix formatting for urls section of fetch, pull, and push manpages
Date: Sat, 30 Dec 2006 20:03:51 -0500
Message-ID: <E1H0p79-0004T8-8V@candygram.thunk.org>
X-From: git-owner@vger.kernel.org Sun Dec 31 02:04:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0p7O-0004HD-B5
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 02:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWLaBD4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 20:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWLaBD4
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 20:03:56 -0500
Received: from thunk.org ([69.25.196.29]:55397 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932312AbWLaBDz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 20:03:55 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H0pBT-0008MQ-Cg; Sat, 30 Dec 2006 20:08:19 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H0p79-0004T8-8V; Sat, 30 Dec 2006 20:03:51 -0500
To: git@vger.kernel.org
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35636>


The line:

[remote "<remote>"]

was getting swallowed up by asciidoc, causing a critical line in the
explanation for how to store the .git/remotes information in .git/config
to go missing from the git-fetch, git-pull, and git-push manpages.  

Put all of the examples into delimited blocks to fix this problem and to
make them look nicer.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 Documentation/urls.txt |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 670827c..870c950 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -40,9 +40,11 @@ In addition to the above, as a short-hand, the name of a
 file in `$GIT_DIR/remotes` directory can be given; the
 named file should be in the following format:
 
-	URL: one of the above URL format
-	Push: <refspec>
-	Pull: <refspec>
+------------
+URL: one of the above URL format
+Push: <refspec>
+Pull: <refspec>
+------------
 
 Then such a short-hand is specified in place of
 <repository> without <refspec> parameters on the command
@@ -54,10 +56,12 @@ be specified for additional branch mappings.
 Or, equivalently, in the `$GIT_DIR/config` (note the use
 of `fetch` instead of `Pull:`):
 
+------------
 [remote "<remote>"]
 	url = <url>
 	push = <refspec>
 	fetch = <refspec>
+------------
 
 The name of a file in `$GIT_DIR/branches` directory can be
 specified as an older notation short-hand; the named
@@ -68,10 +72,15 @@ name of remote head (URL fragment notation).
 without the fragment is equivalent to have this in the
 corresponding file in the `$GIT_DIR/remotes/` directory.
 
-	URL: <url>
-	Pull: refs/heads/master:<remote>
+------------
+URL: <url>
+Pull: refs/heads/master:<remote>
+------------
+
 
 while having `<url>#<head>` is equivalent to
 
-	URL: <url>
-	Pull: refs/heads/<head>:<remote>
+------------
+URL: <url>
+Pull: refs/heads/<head>:<remote>
+------------
-- 
1.5.0.rc0.g1ed48
