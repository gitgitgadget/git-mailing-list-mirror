From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] Makefile: Add TAGS and tags targets
Date: Sat, 18 Mar 2006 11:07:12 +0100
Message-ID: <20060318100712.8364.7137.stgit@c165>
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Mar 18 11:07:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKYLO-0002My-Ni
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 11:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWCRKHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 05:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWCRKHV
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 05:07:21 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:39829 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S932377AbWCRKHV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 05:07:21 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 8C0A440FD; Sat, 18 Mar 2006 11:23:18 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with esmtp (Exim 3.36 #1 (Debian))
	id 1FKYL2-0002B5-00; Sat, 18 Mar 2006 11:07:12 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17692>




Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 Makefile |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8a20c76..8d45378 100644
--- a/Makefile
+++ b/Makefile
@@ -553,6 +553,13 @@ $(LIB_FILE): $(LIB_OBJS)
 doc:
 	$(MAKE) -C Documentation all
 
+TAGS:
+	rm -f TAGS
+	find . -name '*.[hcS]' -print | xargs etags -a
+
+tags:
+	rm -f tags
+	find . -name '*.[hcS]' -print | xargs ctags -a
 
 ### Testing rules
 
@@ -617,7 +624,7 @@ rpm: dist
 clean:
 	rm -f *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o $(LIB_FILE)
 	rm -f $(ALL_PROGRAMS) git$X
-	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h
+	rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
 	rm -rf $(GIT_TARNAME)
 	rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(MAKE) -C Documentation/ clean
@@ -626,5 +633,5 @@ clean:
 	rm -f GIT-VERSION-FILE
 
 .PHONY: all install clean strip
-.PHONY: .FORCE-GIT-VERSION-FILE
+.PHONY: .FORCE-GIT-VERSION-FILE TAGS tags
 
