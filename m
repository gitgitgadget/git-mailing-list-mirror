From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] gitattributes: Clarify discussion of attribute macros
Date: Wed,  3 Aug 2011 15:41:29 +0200
Message-ID: <1312378890-31703-2-git-send-email-mhagger@alum.mit.edu>
References: <1312378890-31703-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, peff@peff.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 15:41:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qobhn-0002xk-DW
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749Ab1HCNlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 09:41:49 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:53306 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab1HCNlp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 09:41:45 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QobfH-0000wA-3l; Wed, 03 Aug 2011 15:39:15 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312378890-31703-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178577>

In particular, make it clear that attribute macros are themselves
recorded as attributes in addition to setting other attributes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/gitattributes.txt |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 412c55b..ccb3f3f 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -879,16 +879,19 @@ produced for, any binary file you track.  You would need to specify e.g.
 ------------
 
 but that may become cumbersome, when you have many attributes.  Using
-attribute macros, you can specify groups of attributes set or unset at
-the same time.  The system knows a built-in attribute macro, `binary`:
+attribute macros, you can define an attribute that, when set, also
+sets or unsets a number of other attributes at the same time.  The
+system knows a built-in attribute macro, `binary`:
 
 ------------
 *.jpg binary
 ------------
 
-which is equivalent to the above.  Note that the attribute macros can only
-be "Set" (see the above example that sets "binary" macro as if it were an
-ordinary attribute --- setting it in turn unsets "text" and "diff").
+Setting the "binary" attribute also unsets the "text" and "diff"
+attributes as above.  Note that attribute macros can only be "Set",
+though setting one might have the effect of setting or unsetting other
+attributes or even returning other attributes to the "Unspecified"
+state.
 
 
 DEFINING ATTRIBUTE MACROS
-- 
1.7.6.8.gd2879
