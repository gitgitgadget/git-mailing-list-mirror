From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Do not include unused header files.
Date: Sat, 28 May 2005 02:55:16 -0700
Message-ID: <7vu0knwu7v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 11:54:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dby1S-0002ff-4Z
	for gcvg-git@gmane.org; Sat, 28 May 2005 11:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVE1J4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 05:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVE1J4f
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 05:56:35 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:63739 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262677AbVE1JzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 05:55:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050528095517.ZFI7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 May 2005 05:55:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Some source files were including "delta.h" without actually
needing it.  Remove them.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

count-delta.c       |    1 -
diffcore-pathspec.c |    1 -
diffcore-pickaxe.c  |    1 -
3 files changed, 3 deletions(-)

diff --git a/count-delta.c b/count-delta.c
--- a/count-delta.c
+++ b/count-delta.c
@@ -6,7 +6,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <limits.h>
-#include "delta.h"
 #include "count-delta.h"
 
 static unsigned long get_hdr_size(const unsigned char **datap)
diff --git a/diffcore-pathspec.c b/diffcore-pathspec.c
--- a/diffcore-pathspec.c
+++ b/diffcore-pathspec.c
@@ -4,7 +4,6 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "delta.h"
 
 struct path_spec {
 	const char *spec;
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -4,7 +4,6 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "delta.h"
 
 static int contains(struct diff_filespec *one,
 		    const char *needle, unsigned long len)
------------------------------------------------

