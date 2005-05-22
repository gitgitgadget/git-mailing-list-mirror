From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: [PATCH] Makefile: Solaris fix: call $(MAKE) instead of make for subdirectories
Date: Sun, 22 May 2005 20:10:36 +0200
Message-ID: <20050522181036.GC18500@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun May 22 20:10:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZutX-0006XN-TU
	for gcvg-git@gmane.org; Sun, 22 May 2005 20:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVEVSKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 14:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVEVSKs
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 14:10:48 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:28627 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261196AbVEVSKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 14:10:43 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4MIAbS8020899
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 May 2005 18:10:37 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4MIAas5020898;
	Sun, 22 May 2005 20:10:36 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--- a/Makefile
+++ b/Makefile
@@ -134,11 +134,11 @@
 diffcore-pickaxe.o : $(LIB_H) diffcore.h
 
 test: all
-	make -C t/ all
+	$(MAKE) -C t/ all
 
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)
-	make -C Documentation/ clean
+	$(MAKE) -C Documentation/ clean
 
 backup: clean
 	cd .. ; tar czvf dircache.tar.gz dir-cache
