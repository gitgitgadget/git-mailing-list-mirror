From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Clean generated files a bit more.
Date: Fri, 12 Aug 2005 02:41:34 -0700
Message-ID: <7v8xz75w6p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 12 11:41:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3W2k-0005dX-SE
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 11:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbVHLJlg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 05:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVHLJlg
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 05:41:36 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:21218 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750929AbVHLJlf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 05:41:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812094135.SZJH16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 05:41:35 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Also attempt to build a source package for debian.
---

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

b263f24ce4f12dd39cfcd922c56a32292c6232c9
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -238,14 +238,14 @@ rpm: dist
 deb: dist
 	rm -rf $(GIT_TARNAME)
 	tar zxf $(GIT_TARNAME).tar.gz
+	dpkg-source -b $(GIT_TARNAME)
 	cd $(GIT_TARNAME) && fakeroot debian/rules binary
 
 ### Cleaning rules
 
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
-	rm -f $(GIT_TARNAME).tar.gz git-core.spec
-	rm -f git-core_$(GIT_VERSION)-*.deb git-tk_$(GIT_VERSION)-*.deb
+	rm -f git-core.spec *.deb *.dsc *.tar.gz 
 	rm -rf $(GIT_TARNAME)
 	$(MAKE) -C tools/ clean
 	$(MAKE) -C Documentation/ clean
