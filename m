From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 1/5] cvsimport: sync usage lines with existing options
Date: Fri,  6 Apr 2007 23:52:39 +0200
Message-ID: <11758963634155-git-send-email-frank@lichtenheld.de>
References: <11758963633237-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 01:21:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZwN7-0006I3-RK
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 23:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbXDFVxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 17:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbXDFVxM
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 17:53:12 -0400
Received: from mail.lenk.info ([217.160.134.107]:59330 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbXDFVxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 17:53:09 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwN2-0006IR-IN; Fri, 06 Apr 2007 23:53:24 +0200
Received: from p54b0f96b.dip.t-dialin.net ([84.176.249.107] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HZwMk-0001c5-CU; Fri, 06 Apr 2007 23:53:06 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HZwMO-000387-27; Fri, 06 Apr 2007 23:52:44 +0200
X-Mailer: git-send-email 1.5.1
In-Reply-To: <11758963633237-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43927>

Sync both the usage lines in the code and the asciidoc
documentation with the real list of options. While
all options seems to be documented in the asciidoc
document, not all of them were listed in the usage line.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsimport.txt |    8 +++++---
 git-cvsimport.perl              |    5 +++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 0d59c06..8374d90 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -9,9 +9,11 @@ git-cvsimport - Salvage your data out of another SCM people love to hate
 SYNOPSIS
 --------
 [verse]
-'git-cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>] [-s <subst>]
-	      [-p <options-for-cvsps>] [-C <git_repository>] [-i] [-P <file>]
-	      [-m] [-M regex] [<CVS_module>]
+'git-cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>]
+	      [-A <author-conv-file>] [-p <options-for-cvsps>] [-P <file>]
+	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
+	      [-a] [-m] [-M <regex>] [-S <regex>] [-L <commitlimit>]
+	      [<CVS_module>]
 
 
 DESCRIPTION
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 1a1ba7b..d3fbcbc 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -36,8 +36,9 @@ sub usage() {
 	print STDERR <<END;
 Usage: ${\basename $0}     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
-       [-p opts-for-cvsps] [-C GIT_repository] [-z fuzz] [-i] [-k] [-u]
-       [-s subst] [-a] [-m] [-M regex] [-S regex] [CVS_module]
+       [-p opts-for-cvsps] [-P file] [-C GIT_repository] [-z fuzz] [-i] [-k]
+       [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
+       [CVS_module]
 END
 	exit(1);
 }
-- 
1.5.1
