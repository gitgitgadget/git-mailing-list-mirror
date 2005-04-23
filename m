From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] Fix broken diff-cache output on added files
Date: Sun, 24 Apr 2005 01:43:42 +0200
Message-ID: <20050423234342.GR13222@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 01:39:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPUDB-0004zD-3N
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 01:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVDWXnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 19:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVDWXnp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 19:43:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34744 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262180AbVDWXnn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 19:43:43 -0400
Received: (qmail 2327 invoked by uid 2001); 23 Apr 2005 23:43:42 -0000
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Added files were errorneously reported with the - prefix by diff-cache,
obviously leading to great confusion.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

Index: diff-cache.c
===================================================================
--- 099679c62a98433d9d9b38581f39563c9574478e/diff-cache.c  (mode:100644 sha1:b407d753e520fa0b1523d770d98b3015af197275)
+++ 3df862ae5cc66733dab3d8bd5c4ea359b2ca1884/diff-cache.c  (mode:100644 sha1:2ec6c29ab6b79a10277a2ff9021a2032d656abf0)
@@ -57,7 +57,7 @@
 		}
 		/* No matching 1-stage (tree) entry? Show the current one as added */
 		if (entries == 1 || !same_name(ce, ac[1])) {
-			show_file("-", ce);
+			show_file("+", ce);
 			ac++;
 			entries--;
 			continue;


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
