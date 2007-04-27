From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH 7/8] Update git-local-fetch documentation
Date: Fri, 27 Apr 2007 00:09:58 -0500
Message-ID: <20070427050958.GF9798@bowser.ruder>
References: <20070427050550.GA9594@bowser.ruder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 07:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhIkq-0001Dm-J7
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 07:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339AbXD0FMX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 01:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755343AbXD0FMX
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 01:12:23 -0400
Received: from www.aeruder.net ([65.254.53.245]:4598 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755339AbXD0FMW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 01:12:22 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 2B12840EC7;
	Fri, 27 Apr 2007 00:12:22 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070427050550.GA9594@bowser.ruder>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45694>

Documentation/git-local-fetch.txt: -s to use
symbolic links instead of file-to-file copy, -l
to use hardlinks, -n to never use file-to-file
copies, --recover to resume a failed fetch.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/git-local-fetch.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
index 22048d8..dd9e238 100644
--- a/Documentation/git-local-fetch.txt
+++ b/Documentation/git-local-fetch.txt
@@ -24,6 +24,16 @@ OPTIONS
 	Get all the objects.
 -v::
 	Report what is downloaded.
+-s::
+	Instead of regular file-to-file copying use symbolic links to the objects
+	in the remote repository.
+-l::
+	Before attempting symlinks (if -s is specified) or file-to-file copying the
+	remote objects, try to hardlink the remote objects into the local
+	repository.
+-n::
+	Never attempt to file-to-file copy remote objects.  Only useful with
+	-s or -l command-line options.
 
 -w <filename>::
         Writes the commit-id into the filename under $GIT_DIR/refs/<filename> on
@@ -35,6 +45,10 @@ OPTIONS
 
 		<commit-id>['\t'<filename-as-in--w>]
 
+--recover::
+	Verify that everything reachable from target is fetched.  Used after
+	an earlier fetch is interrupted.
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net>
-- 
1.5.2.rc0.64.g8476
