From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: [PATCH] Use inttypes.h rather than stdint.h.
Date: Thu, 25 Jan 2007 13:11:40 -0800
Message-ID: <24182.1169759500@lotus.CS.Berkeley.EDU>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 22:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HABsn-00034Z-RA
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 22:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030571AbXAYVLm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 16:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbXAYVLm
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 16:11:42 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:46699 "EHLO
	lotus.CS.Berkeley.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030571AbXAYVLl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 16:11:41 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id l0PLBeSH024188
	for <git@vger.kernel.org>; Thu, 25 Jan 2007 13:11:40 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id l0PLBehA024185
	for <git@vger.kernel.org>; Thu, 25 Jan 2007 13:11:40 -0800 (PST)
X-Mailer: MH-E 8.0.3; nmh 1.1; GNU Emacs 22.0.92
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37757>

Older Solaris machines lack stdint.h but have inttypes.h.
The standard has inttypes.h including stdint.h, so at worst
this pollutes the namespace a bit.

Signed-off-by: Jason Riedy <ejr@cs.berkeley.edu>
---
   There's a simple work-around (-I. and a symlink), so I'll
   understand if this is dropped for being too damn stupid.  But
   I'm pretty sure Solaris 5.8 is still widespread (relatively
   speaking).

 git-compat-util.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index bf3ceb8..c1bcb00 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -46,7 +46,7 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <pwd.h>
-#include <stdint.h>
+#include <inttypes.h>
 #undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
 #include <grp.h>
 #define _ALL_SOURCE 1
-- 
1.5.0.rc1.g6f729
