From: Patrick Welche <prlw1@cam.ac.uk>
Subject: compiling on netbsd
Date: Sun, 26 Apr 2009 14:49:00 +0100
Message-ID: <20090426134900.GB454@quartz.inf.phy.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 27 12:16:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly5A0-000245-6p
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 16:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007AbZDZOOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 10:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755546AbZDZOOl
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 10:14:41 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:60498 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968AbZDZOOk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 10:14:40 -0400
X-Greylist: delayed 1537 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Apr 2009 10:14:40 EDT
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from skye.inf.phy.cam.ac.uk ([131.111.79.113]:34303)
	by ppsw-1.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.131]:25)
	with esmtp id 1Ly4j6-0006TE-4o (Exim 4.70) for git@vger.kernel.org
	(return-path <prlw1@inf.phy.cam.ac.uk>); Sun, 26 Apr 2009 14:49:00 +0100
Received: from quartz.inf.phy.cam.ac.uk ([131.111.79.101])
	by skye.inf.phy.cam.ac.uk with esmtp (Exim 3.36 #1)
	id 1Ly4j6-0000Mj-00
	for git@vger.kernel.org; Sun, 26 Apr 2009 14:49:00 +0100
Received: from prlw1 by quartz.inf.phy.cam.ac.uk with local (Exim 4.66)
	(envelope-from <prlw1@inf.phy.cam.ac.uk>)
	id 1Ly4j6-0000Bu-Dc
	for git@vger.kernel.org; Sun, 26 Apr 2009 14:49:00 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-04-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117640>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I found I needed to add the following patch in order to compile today's
git source under NetBSD-current (5.99.11)

Cheers,

Patrick

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git.patch"

diff --git a/Makefile b/Makefile
index 5c8e83a..25d2b9c 100644
--- a/Makefile
+++ b/Makefile
@@ -764,6 +764,7 @@ ifeq ($(uname_S),NetBSD)
 	BASIC_CFLAGS += -I/usr/pkg/include
 	BASIC_LDFLAGS += -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
 	THREADED_DELTA_SEARCH = YesPlease
+	USE_ST_TIMESPEC = YesPlease
 endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 785aa31..1ac16bd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -46,6 +46,7 @@
 #define _ALL_SOURCE 1
 #define _GNU_SOURCE 1
 #define _BSD_SOURCE 1
+#define _NETBSD_SOURCE 1
 
 #include <unistd.h>
 #include <stdio.h>

--oyUTqETQ0mS9luUI--
