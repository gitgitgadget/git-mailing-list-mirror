From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 2/5] cvsimport: Improve documentation of CVSROOT and CVS module determination
Date: Fri,  6 Apr 2007 23:52:40 +0200
Message-ID: <11758963643049-git-send-email-frank@lichtenheld.de>
References: <11758963633237-git-send-email-frank@lichtenheld.de> <11758963634155-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 01:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwN8-0006I3-UE
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 23:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbXDFVxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 17:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbXDFVxQ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 17:53:16 -0400
Received: from mail.lenk.info ([217.160.134.107]:59335 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbXDFVxK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 17:53:10 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwN2-0006IX-PG; Fri, 06 Apr 2007 23:53:24 +0200
Received: from p54b0f96b.dip.t-dialin.net ([84.176.249.107] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwMk-0001c6-H4; Fri, 06 Apr 2007 23:53:06 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HZwMO-000389-7F; Fri, 06 Apr 2007 23:52:44 +0200
X-Mailer: git-send-email 1.5.1
In-Reply-To: <11758963634155-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43924>

Document the fact that git-cvsimport tries to find out CVSROOT from
CVS/Root and $ENV{CVSROOT} and CVS_module from CVS/Repository.

Also use ` ` syntax for all filenames for consistency.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsimport.txt |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 8374d90..6a0821a 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -35,7 +35,9 @@ OPTIONS
 -d <CVSROOT>::
 	The root of the CVS archive. May be local (a simple path) or remote;
 	currently, only the :local:, :ext: and :pserver: access methods 
-	are supported.
+	are supported. If not given, git-cvsimport will try to read it
+	from `CVS/Root`. If no such file exists, it checks for the
+	`CVSROOT` environment variable.
 
 -C <target-dir>::
         The git repository to import to.  If the directory doesn't
@@ -87,6 +89,8 @@ If you need to pass multiple options, separate them with a comma.
 
 <CVS_module>::
 	The CVS module you want to import. Relative to <CVSROOT>.
+	If not given, git-cvsimport tries to read it from
+	`CVS/Repository`.
 
 -h::
 	Print a short usage message and exit.
@@ -124,7 +128,7 @@ git-cvsimport will make it appear as those authors had
 their GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL set properly
 all along.
 +
-For convenience, this data is saved to $GIT_DIR/cvs-authors
+For convenience, this data is saved to `$GIT_DIR/cvs-authors`
 each time the -A option is provided and read from that same
 file each time git-cvsimport is run.
 +
-- 
1.5.1
