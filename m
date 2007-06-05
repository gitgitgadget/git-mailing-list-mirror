From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] make clean should remove all the test programs too
Date: Tue, 5 Jun 2007 15:43:17 +0200
Message-ID: <20070605134317.GA7950@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 15:43:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvZJp-0006zz-J8
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 15:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599AbXFENnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 09:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756484AbXFENnU
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 09:43:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:42360 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755599AbXFENnU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 09:43:20 -0400
Received: (qmail invoked by alias); 05 Jun 2007 13:43:18 -0000
Received: from pd9ebb5ec.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.236]
  by mail.gmx.net (mp036) with SMTP; 05 Jun 2007 15:43:18 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18L21sETasL51UEZcgsjB9PuG/OzTKKlg6qBGx84T
	VRCbElP9gKd/DV
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49198>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
There seems to be another test program lying around which is not
included in the Makefile: dump-tree-cache.c.  I've no idea what this
does or what it is used for, it was just dropped from the Makefile
during some cleanup.  If it should stay I'd recommend to do:
    - git mv dump-cache-tree.c test-dump-cache-trees.c
    - add dump-cache-trees to TEST_PROGRAMS
    - s/dump-cache-tree/dump-cache-trees/ in .gitignore
---
 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 69f3b66..cd620b0 100644
--- a/Makefile
+++ b/Makefile
@@ -1052,8 +1052,9 @@ dist-doc:
 
 clean:
 	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
-		test-chmtime$X test-genrandom$X $(LIB_FILE) $(XDIFF_LIB)
+		$(LIB_FILE) $(XDIFF_LIB)
 	rm -f $(ALL_PROGRAMS) $(BUILT_INS) git$X
+	rm -f $(TEST_PROGRAMS)
 	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
 	rm -rf autom4te.cache
 	rm -f configure config.log config.mak.autogen config.mak.append config.status config.cache
-- 
1.5.2.1.122.g91581
