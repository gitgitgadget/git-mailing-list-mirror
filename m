From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Fix use of wc in t0000-basic
Date: Fri, 20 May 2005 20:49:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505202045580.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 02:52:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZIDM-0002Wp-Hq
	for gcvg-git@gmane.org; Sat, 21 May 2005 02:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVEUAvX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 20:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVEUAvX
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 20:51:23 -0400
Received: from iabervon.org ([66.92.72.58]:28420 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261615AbVEUAtx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 20:49:53 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DZIAz-0007N2-00; Fri, 20 May 2005 20:49:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The version of wc I have (GNU textutils-2.1) puts spaces at the beginning
of lines. This patch should work for any version of wc.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Acked-by: Junio C Hamano <junkio@cox.net>
Index: t/t0000-basic.sh
===================================================================
--- 58741c69570705801db4b785681790d636475695/t/t0000-basic.sh  (mode:100755 sha1:9a557129d98b499bcd601903d6646de29ba4bfc5)
+++ uncommitted/t/t0000-basic.sh  (mode:100755)
@@ -32,7 +32,7 @@
 find .git/objects -type d -print >full-of-directories
 test_expect_success \
     '.git/objects should have 256 subdirectories.' \
-    'test "$(wc -l full-of-directories | sed -e "s/ .*//")" = 257'
+    'test $(cat full-of-directories | wc -l) = 257'
 
 ################################################################
 # Basics of the basics


