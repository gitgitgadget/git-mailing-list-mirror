From: Joey Hess <joey@kitenet.net>
Subject: [PATCH] document delta attribute
Date: Wed, 21 Oct 2009 19:20:59 -0400
Message-ID: <20091021232059.GA17412@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 01:31:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0keZ-0005Gk-Rf
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 01:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbZJUXb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 19:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbZJUXb3
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 19:31:29 -0400
Received: from wren.kitenet.net ([80.68.85.49]:55472 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbZJUXb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 19:31:29 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2009 19:31:29 EDT
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 4E1FF314333
	for <git@vger.kernel.org>; Wed, 21 Oct 2009 19:21:49 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 22B952A0487; Wed, 21 Oct 2009 19:20:59 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130985>

I always wanted a way to turn off delta compression. Turns out git had one,
but it wasn't documented. Added documentation based on
the commit message of a74db82e15cd8a2c53a4a83e9a36dc7bf7a4c750.

Skipped the .jpg example though because I don't want to over-encourage use
of the attribute. (Also because jpeg file changes might delta-compress
well, if only metadata is changed.)

Signed-off-by: Joey Hess <joey@kitenet.net>
---
 Documentation/gitattributes.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 1195e83..e3e3d2c 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -577,6 +577,18 @@ If this attribute is not set or has an invalid value, the value of the
 (See linkgit:git-config[1]).
 
 
+Packing objects
+~~~~~~~~~~~~~~~
+
+`delta`
+^^^^^^^
+
+This attribute controls whether linkgit:git-pack-objects[1] will try
+to delta compress files. The attribute is set by default. You may benefit
+from unsetting it for certain large binary files for which attempting delta
+compression will only use CPU cycles and memory.
+
+
 USING ATTRIBUTE MACROS
 ----------------------
 
-- 
1.6.4.3
