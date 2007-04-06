From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 4/5] cvsimport: Reorder options in documentation for better understanding
Date: Fri,  6 Apr 2007 23:52:42 +0200
Message-ID: <11758963643062-git-send-email-frank@lichtenheld.de>
References: <11758963633237-git-send-email-frank@lichtenheld.de> <11758963634155-git-send-email-frank@lichtenheld.de> <11758963643049-git-send-email-frank@lichtenheld.de> <11758963642149-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 01:21:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwNA-0006I3-28
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 23:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbXDFVxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 17:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbXDFVxT
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 17:53:19 -0400
Received: from mail.lenk.info ([217.160.134.107]:59346 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbXDFVxM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 17:53:12 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwN3-0006Ir-Jn; Fri, 06 Apr 2007 23:53:27 +0200
Received: from p54b0f96b.dip.t-dialin.net ([84.176.249.107] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwMl-0001cA-4N; Fri, 06 Apr 2007 23:53:07 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HZwMO-00038E-Mp; Fri, 06 Apr 2007 23:52:44 +0200
X-Mailer: git-send-email 1.5.1
In-Reply-To: <11758963642149-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43923>

The current order the options are documented in makes no sense
at all to me. Reorder them so that similar options are grouped
together and also order them somehwhat by importance.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsimport.txt |   54 +++++++++++++++++++-------------------
 1 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 6a0821a..a5276f7 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -32,6 +32,9 @@ any CVS branches, yourself.
 
 OPTIONS
 -------
+-v::
+	Verbosity: let 'cvsimport' report what it is doing.
+
 -d <CVSROOT>::
 	The root of the CVS archive. May be local (a simple path) or remote;
 	currently, only the :local:, :ext: and :pserver: access methods 
@@ -39,10 +42,23 @@ OPTIONS
 	from `CVS/Root`. If no such file exists, it checks for the
 	`CVSROOT` environment variable.
 
+<CVS_module>::
+	The CVS module you want to import. Relative to <CVSROOT>.
+	If not given, git-cvsimport tries to read it from
+	`CVS/Repository`.
+
 -C <target-dir>::
         The git repository to import to.  If the directory doesn't
         exist, it will be created.  Default is the current directory.
 
+-o <branch-for-HEAD>::
+	The 'HEAD' branch from CVS is imported to the 'origin' branch within
+	the git repository, as 'HEAD' already has a special meaning for git.
+	Use this option if you want to import into a different branch.
++
+Use '-o master' for continuing an import that was initially done by
+the old cvs2git tool.
+
 -i::
 	Import-only: don't perform a checkout after importing.  This option
 	ensures the working directory and index remain untouched and will
@@ -56,13 +72,8 @@ OPTIONS
 -u::
 	Convert underscores in tag and branch names to dots.
 
--o <branch-for-HEAD>::
-	The 'HEAD' branch from CVS is imported to the 'origin' branch within
-	the git repository, as 'HEAD' already has a special meaning for git.
-	Use this option if you want to import into a different branch.
-+
-Use '-o master' for continuing an import that was initially done by
-the old cvs2git tool.
+-s <subst>::
+	Substitute the character "/" in branch names with <subst>
 
 -p <options-for-cvsps>::
 	Additional options for cvsps.
@@ -70,6 +81,10 @@ the old cvs2git tool.
 +
 If you need to pass multiple options, separate them with a comma.
 
+-z <fuzz>::
+	Pass the timestamp fuzz factor to cvsps, in seconds. If unset,
+	cvsps defaults to 300s.
+
 -P <cvsps-output-file>::
 	Instead of calling cvsps, read the provided cvsps output file. Useful
 	for debugging or when cvsps is being handled outside cvsimport.
@@ -84,31 +99,13 @@ If you need to pass multiple options, separate them with a comma.
 	regex. It can be used with -m to also see the default regexes. 
 	You must escape forward slashes. 
 
--v::
-	Verbosity: let 'cvsimport' report what it is doing.
-
-<CVS_module>::
-	The CVS module you want to import. Relative to <CVSROOT>.
-	If not given, git-cvsimport tries to read it from
-	`CVS/Repository`.
-
--h::
-	Print a short usage message and exit.
-
--z <fuzz>::
-	Pass the timestamp fuzz factor to cvsps, in seconds. If unset,
-	cvsps defaults to 300s.
-
--s <subst>::
-	Substitute the character "/" in branch names with <subst>
+-S <regex>::
+	Skip paths matching the regex.
 
 -a::
 	Import all commits, including recent ones. cvsimport by default
 	skips commits that have a timestamp less than 10 minutes ago.
 
--S <regex>::
-	Skip paths matching the regex.
-
 -L <limit>::
 	Limit the number of commits imported. Workaround for cases where
 	cvsimport leaks memory.
@@ -136,6 +133,9 @@ It is not recommended to use this feature if you intend to
 export changes back to CVS again later with
 gitlink:git-cvsexportcommit[1].
 
+-h::
+	Print a short usage message and exit.
+
 OUTPUT
 ------
 If '-v' is specified, the script reports what it is doing.
-- 
1.5.1
