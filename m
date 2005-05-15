From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/4] Trivial test harness fixes.
Date: Sun, 15 May 2005 14:21:13 -0700
Message-ID: <7voebcqj7a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun May 15 23:22:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXQYB-00007x-TR
	for gcvg-git@gmane.org; Sun, 15 May 2005 23:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVEOVVf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 17:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVEOVVf
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 17:21:35 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:21460 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261248AbVEOVVS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 17:21:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515212113.FGFK550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 17:21:13 -0400
To: pasky@ucw.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The documentation of the test harness still refer to old
numbering and also contains an obvious typo.

Also "make test" should be run after making sure we have built
all binaries, since test is designed to test the newly built
ones.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Makefile |    2 +-
t/README |    5 +++--
2 files changed, 4 insertions(+), 3 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -120,7 +120,7 @@
 strbuf.o: $(LIB_H)
 gitenv.o: $(LIB_H)
 
-test:
+test: all
 	make -C t/ all
 
 clean:
--- a/t/README
+++ b/t/README
@@ -32,7 +32,7 @@
 Or you can run each test individually from command line, like
 this:
 
-    $ sh ./t0500-ls-files.sh
+    $ sh ./t3001-ls-files-killed.sh
     *   ok 1: git-update-cache --add to add various paths.
     *   ok 2: git-ls-files -k to show killed files.
     *   ok 3: validate git-ls-files -k output.
@@ -92,7 +92,7 @@
 	# Copyright (c) 2005 Junio C Hamano
 	#
 
-	test_description=xxx test (option --frotz)
+	test_description='xxx test (option --frotz)
 
 	This test registers the following structure in the cache
 	and tries to run git-ls-files with option --frotz.'
@@ -120,6 +120,7 @@
    consistently when command line arguments --verbose (or -v),
    --debug (or -d), and --immediate (or -i) is given.
 
+
 End with test_done
 ------------------
 


