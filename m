From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Makefile: The big git command renaming fallout fix.
Date: Fri, 29 Apr 2005 14:53:35 -0700
Message-ID: <7v3bt945cw.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504291416190.18901@ppc970.osdl.org>
	<7vacnh45x0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 23:49:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdLc-00089r-SS
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbVD2Vxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbVD2Vxz
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:53:55 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:45760 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262991AbVD2Vxj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 17:53:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050429215336.UIAJ23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Apr 2005 17:53:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vacnh45x0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 29 Apr 2005 14:41:31 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is another.  This one belongs to a clean-up category.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
cd /opt/packrat/playpen/public/in-place/git/git.linus/
show-diff -p Makefile
--- k/Makefile  (mode:100644)
+++ l/Makefile  (mode:100644)
@@ -59,8 +59,6 @@ CFLAGS += '-DSHA1_HEADER=$(SHA1_HEADER)'
 $(LIB_FILE): $(LIB_OBJS)
 	$(AR) rcs $@ $(LIB_OBJS)
 
-init-db: init-db.o
-
 git-%: %.c $(LIB_FILE)
 	$(CC) $(CFLAGS) -o $@ $(filter %.c,$^) $(LIBS)
 
@@ -104,6 +102,7 @@ read-cache.o: $(LIB_H)
 sha1_file.o: $(LIB_H)
 usage.o: $(LIB_H)
 diff.o: $(LIB_H)
+strbuf.o: $(LIB_H)
 
 clean:
 	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROG) $(LIB_FILE)


