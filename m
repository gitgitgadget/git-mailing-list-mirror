From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH] Documentation/git-clean.txt: document that -f may need to be given twice
Date: Thu, 26 Feb 2015 14:56:40 +0200
Message-ID: <1424955400-13897-1-git-send-email-mikko.rapeli@iki.fi>
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 13:56:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQxzo-0002DC-79
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 13:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbbBZM4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 07:56:49 -0500
Received: from mail.kapsi.fi ([217.30.184.167]:42357 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932076AbbBZM4s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 07:56:48 -0500
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <mcfrisk@kapsi.fi>)
	id 1YQxzj-0001Rz-0M; Thu, 26 Feb 2015 14:56:47 +0200
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.80)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1YQxzi-0004go-3B; Thu, 26 Feb 2015 14:56:46 +0200
X-Mailer: git-send-email 1.7.10.4
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: mcfrisk@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264436>

This is needed in build automation where the tree really needs to
be reset to known state.

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 Documentation/git-clean.txt |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 94b6d19..872ab45 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -34,8 +34,12 @@ OPTIONS
 -f::
 --force::
 	If the Git configuration variable clean.requireForce is not set
-	to false, 'git clean' will refuse to run unless given -f, -n or
-	-i.
+	to false, 'git clean' will refuse to delete files or directories
+	unless given -f, -n or -i. Git will refuse to delete directories
+	with .git sub directory or file unless a second -f
+	is given. This affects also git submodules where the storage area of
+	of the removed submodule under .git/modules/ is not removed until
+	-f is give twice.
 
 -i::
 --interactive::
-- 
1.7.10.4
