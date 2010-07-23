From: Johan Herland <johan@herland.net>
Subject: [WIP/RFC 01/13] (trivial) notes.h: Minor documentation fixes to
 copy_notes()
Date: Fri, 23 Jul 2010 12:14:52 +0200
Message-ID: <1279880104-29796-2-git-send-email-johan@herland.net>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 12:16:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcFIc-0001FC-Bv
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 12:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756308Ab0GWKPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 06:15:54 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43952 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754609Ab0GWKPM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 06:15:12 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6000G9A9T9M390@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:09 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 989EA1EA5509_C496BADB	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:09 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 807EE1EA36EC_C496BADF	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:09 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L60005R49T9TN00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:09 +0200 (MEST)
X-Mailer: git-send-email 1.7.2.220.gea1d3
In-reply-to: <1279880104-29796-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151524>

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/notes.h b/notes.h
index 65fc3a6..c0288b0 100644
--- a/notes.h
+++ b/notes.h
@@ -104,6 +104,10 @@ const unsigned char *get_note(struct notes_tree *t,
  * Copy a note from one object to another in the given notes_tree.
  *
  * Fails if the to_obj already has a note unless 'force' is true.
+ *
+ * IMPORTANT: The changes made by copy_note() to the given notes_tree structure
+ * are not persistent until a subsequent call to write_notes_tree() returns
+ * zero.
  */
 int copy_note(struct notes_tree *t,
 	      const unsigned char *from_obj, const unsigned char *to_obj,
@@ -149,6 +153,7 @@ int copy_note(struct notes_tree *t,
  * notes tree) from within the callback:
  * - add_note()
  * - remove_note()
+ * - copy_note()
  * - free_notes()
  */
 typedef int each_note_fn(const unsigned char *object_sha1,
-- 
1.7.2.220.gea1d3
