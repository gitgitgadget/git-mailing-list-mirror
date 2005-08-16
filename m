From: Chris Wright <chrisw@osdl.org>
Subject: [PATCH] Make tools use DESTDIR as well (otherwise rpm build is broken)
Date: Tue, 16 Aug 2005 11:28:02 -0700
Message-ID: <20050816182802.GH8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 20:30:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E56AZ-0006DZ-3v
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 20:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbVHPS2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 14:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbVHPS2L
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 14:28:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030284AbVHPS2J (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 14:28:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7GIS2jA017447
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 Aug 2005 11:28:02 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7GIS2Yg005539;
	Tue, 16 Aug 2005 11:28:02 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j7GIS2DI005538;
	Tue, 16 Aug 2005 11:28:02 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Please pull from:
	rsync.kernel.org://pub/scm/linux/kernel/git/chrisw/git

This will give you the following trivial fix for the rpm build, where
tools was still using dest not DESTDIR.

thanks,
-chris
--

diff-tree 5eaaed02111510ff00b288a99ec3d203d5d1761f (from d9ac9df41c8c1c3a2f5b0fb1bcc0546dc1bafba2)
tree 636f8c808fd80fb886c5c8b96e854d7d9dea8591
parent d9ac9df41c8c1c3a2f5b0fb1bcc0546dc1bafba2
author Chris Wright <chrisw@osdl.org> 1124215389 -0700
committer Chris Wright <chrisw@osdl.org> 1124215389 -0700

    Make tools use DESTDIR as well (otherwise rpm build is broken).
    
    Signed-off-by: Chris Wright <chrisw@osdl.org>

diff --git a/tools/Makefile b/tools/Makefile
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -18,7 +18,7 @@ git-%: %.c
 all: $(PROGRAMS)
 
 install: $(PROGRAMS) $(SCRIPTS)
-	$(INSTALL) -m755 -d $(dest)$(bindir)
+	$(INSTALL) -m755 -d $(DESTDIR)$(bindir)
 	$(INSTALL) $(PROGRAMS) $(SCRIPTS) $(DESTDIR)$(bindir)
 
 clean:
