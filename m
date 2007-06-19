From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-svn: trailing slash in prefix is mandatory with --branches/-b
Date: Tue, 19 Jun 2007 16:47:41 +0000
Message-ID: <20070619164741.16352.qmail@1b445471b48f1c.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 18:47:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0grW-0004zj-92
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 18:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195AbXFSQrZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 12:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757241AbXFSQrY
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 12:47:24 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:43514 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756480AbXFSQrY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 12:47:24 -0400
Received: (qmail 16353 invoked by uid 1000); 19 Jun 2007 16:47:41 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50494>

Make clear in the documentation that when using --branches/-b and
--prefix with 'init', the prefix must include a trailing slash.
This matches the actual behavior of git-svn, e.g.:

 $ git svn init -Ttrunk -treleases -bbranches --prefix xxx \
     http://svn.sacredchao.net/svn/quodlibet/
 --prefix='xxx' must have a trailing slash '/'
 $

This was noticed by R. Vanicat and reported through
 http://bugs.debian.org/429443

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/git-svn.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index c0d7d95..0a210e4 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -66,9 +66,10 @@ COMMANDS
 	to the names of remotes if trunk/branches/tags are
 	specified.  The prefix does not automatically include a
 	trailing slash, so be sure you include one in the
-	argument if that is what you want.  This is useful if
-	you wish to track multiple projects that share a common
-	repository.
+	argument if that is what you want.  If --branches/-b is
+	specified, the prefix must include a trailing slash.
+	Setting a prefix is useful if you wish to track multiple
+	projects that share a common repository.
 
 'fetch'::
 	Fetch unfetched revisions from the Subversion remote we are
-- 
1.5.2.1
