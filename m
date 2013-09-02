From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 6/7] revisions.txt: fix and clarify <rev>^{<type>}
Date: Mon,  2 Sep 2013 01:34:25 -0400
Message-ID: <1378100066-31889-7-git-send-email-rhansen@bbn.com>
References: <1378100066-31889-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 02 08:20:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNVK-0007ht-Ip
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757204Ab3IBGUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 02:20:46 -0400
Received: from smtp.bbn.com ([128.33.0.80]:54766 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756978Ab3IBGUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:20:45 -0400
Received: from socket.bbn.com ([192.1.120.102]:55321)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VGMmk-000NLl-F4; Mon, 02 Sep 2013 01:34:46 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id CA6CB4015A
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1378100066-31889-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233606>

If possible, <rev> will be dereferenced even if it is not a tag type
(e.g., commit dereferenced to a tree).

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/revisions.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 569b563..1f1e79b 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -111,10 +111,14 @@ some output processing may assume ref names in UTF-8.
 
 '<rev>{caret}\{<type>\}', e.g. 'v0.99.8{caret}\{commit\}'::
   A suffix '{caret}' followed by an object type name enclosed in
-  brace pair means the object
-  could be a tag, and dereference the tag recursively until an
-  object of that type is found or the object cannot be
-  dereferenced anymore (in which case, barf).  '<rev>{caret}0'
+  brace pair means dereference the object at '<rev>' recursively until
+  an object of type '<type>' is found or the object cannot be
+  dereferenced anymore (in which case, barf).
+  For example, if '<rev>' is a committish, '<rev>{caret}\{commit\}'
+  describes the corresponding commit object.
+  Similarly, if '<rev>' is a treeish, '<rev>{caret}\{tree\}' describes
+  the corresponding tree object.
+  '<rev>{caret}0'
   is a short-hand for '<rev>{caret}\{commit\}'.
 +
 'rev{caret}\{object\}' can be used to make sure 'rev' names an
-- 
1.8.4
