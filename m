From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 4/4] revisions.txt: fix and clarify <rev>^{<type>}
Date: Tue, 18 Jun 2013 22:09:40 -0400
Message-ID: <1371607780-2966-5-git-send-email-rhansen@bbn.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 19 04:43:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up8Mu-0006fc-IK
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 04:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934120Ab3FSCn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 22:43:26 -0400
Received: from smtp.bbn.com ([128.33.1.81]:58327 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934083Ab3FSCnY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 22:43:24 -0400
Received: from socket.bbn.com ([192.1.120.102]:39096)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Up7qT-000I86-8P; Tue, 18 Jun 2013 22:10:01 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 0504540153
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228329>

If possible, <rev> will be dereferenced even if it is not a tag type
(e.g., commit dereferenced to a tree).

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/revisions.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 09896a3..bf563cf 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -114,10 +114,14 @@ some output processing may assume ref names in UTF-8.
 
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
+  specifies the corresponding commit object.
+  Similarly, if '<rev>' is a tree-ish, '<rev>{caret}\{tree\}'
+  specifies the corresponding tree object.
+  '<rev>{caret}0'
   is a short-hand for '<rev>{caret}\{commit\}'.
 +
 'rev{caret}\{object\}' can be used to make sure 'rev' names an
-- 
1.8.3.1
