From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 6/7] revisions.txt: fix and clarify <rev>^{<type>}
Date: Wed,  4 Sep 2013 15:04:33 -0400
Message-ID: <1378321474-7125-7-git-send-email-rhansen@bbn.com>
References: <xmqq1u55plqe.fsf@gitster.dls.corp.google.com>
 <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 04 21:05:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHIOC-0002LG-Gr
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 21:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652Ab3IDTFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 15:05:11 -0400
Received: from smtp.bbn.com ([128.33.0.80]:16721 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760099Ab3IDTFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 15:05:08 -0400
Received: from socket.bbn.com ([192.1.120.102]:55423)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VHIO3-0008b6-Cp; Wed, 04 Sep 2013 15:05:07 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 2C5924004A
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233861>

If possible, <rev> will be dereferenced even if it is not a tag type
(e.g., commit dereferenced to a tree).

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/revisions.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index d477b3f..b0f4284 100644
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
+  For example, if '<rev>' is a commit-ish, '<rev>{caret}\{commit\}'
+  describes the corresponding commit object.
+  Similarly, if '<rev>' is a tree-ish, '<rev>{caret}\{tree\}'
+  describes the corresponding tree object.
+  '<rev>{caret}0'
   is a short-hand for '<rev>{caret}\{commit\}'.
 +
 'rev{caret}\{object\}' can be used to make sure 'rev' names an
-- 
1.8.4
