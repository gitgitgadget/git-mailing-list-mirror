From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] Add a bit of developer documentation to pull.h
Date: Thu, 23 Jun 2005 16:23:12 -0700
Message-ID: <7vy890ejz3.fsf@assigned-by-dhcp.cox.net>
References: <7vfyv8fyqn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 01:17:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlawY-0003VY-LU
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 01:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVFWXX1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 19:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVFWXX1
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 19:23:27 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:29852 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262705AbVFWXXO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 19:23:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050623232312.XXPT550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Jun 2005 19:23:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vfyv8fyqn.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 23 Jun 2005 16:18:56 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Describe what to implement in fetch() and fetch_ref() for
pull backend writers a bit better.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 pull.h |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/pull.h b/pull.h
--- a/pull.h
+++ b/pull.h
@@ -1,24 +1,33 @@
 #ifndef PULL_H
 #define PULL_H
 
-/** To be provided by the particular implementation. **/
+/*
+ * Fetch object given SHA1 from the remote, and store it locally under
+ * GIT_OBJECT_DIRECTORY.  Return 0 on success, -1 on failure.  To be
+ * provided by the particular implementation.
+ */
 extern int fetch(unsigned char *sha1);
 
+/*
+ * Fetch ref (relative to $GIT_DIR/refs) from the remote, and store
+ * the 20-byte SHA1 in sha1.  Return 0 on success, -1 on failure.  To
+ * be provided by the particular implementation.
+ */
 extern int fetch_ref(char *ref, unsigned char *sha1);
 
-/** If set, the ref filename to write the target value to. **/
+/* If set, the ref filename to write the target value to. */
 extern const char *write_ref;
 
-/** If set, the hash that the current value of write_ref must be. **/
+/* If set, the hash that the current value of write_ref must be. */
 extern const unsigned char *current_ref;
 
-/** Set to fetch the target tree. */
+/* Set to fetch the target tree. */
 extern int get_tree;
 
-/** Set to fetch the commit history. */
+/* Set to fetch the commit history. */
 extern int get_history;
 
-/** Set to fetch the trees in the commit history. **/
+/* Set to fetch the trees in the commit history. */
 extern int get_all;
 
 /* Set to zero to skip the check for delta object base;
------------

