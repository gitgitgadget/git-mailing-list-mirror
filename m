From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH] Documentation/pack-format.txt: Clear up description of types.
Date: Wed, 21 Mar 2007 19:43:37 +0100
Message-ID: <20070321184337.GA2705@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 19:50:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU5tE-0006AG-5E
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 19:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933660AbXCUSuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 14:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933635AbXCUSuV
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 14:50:21 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:41695 "HELO bohr.gbar.dtu.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933648AbXCUSuU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 14:50:20 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Mar 2007 14:50:19 EDT
Received: (qmail 3240 invoked by uid 5842); 21 Mar 2007 19:43:37 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42813>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>
---
 Documentation/technical/pack-format.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 0e1ffb2..9ce3c47 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -21,11 +21,11 @@ GIT pack format
      which looks like this:
 
      (undeltified representation)
-     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
+     n-byte type and length (3-bit type, (n-1)*7+4-bit length)
      compressed data
 
      (deltified representation)
-     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
+     n-byte type and length (3-bit type, (n-1)*7+4-bit length)
      20-byte base object name
      compressed delta data
 
@@ -102,11 +102,13 @@ trailer	  | | packfile checksum              |
 Pack file entry: <+
 
      packed object header:
-	1-byte type (upper 4-bit)
+	1-byte size extension bit (MSB)
+	       type (next 3 bit)
 	       size0 (lower 4-bit) 
         n-byte sizeN (as long as MSB is set, each 7-bit)
 		size0..sizeN form 4+7+7+..+7 bit integer, size0
-		is the most significant part.
+		is the least significant part, and sizeN is the
+		most significant part.
      packed object data:
         If it is not DELTA, then deflated bytes (the size above
 		is the size before compression).
-- 
1.5.0.4.g1589e
