From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] repack: improve documentation on -a option
Date: Sat, 30 Jun 2007 20:56:12 +1200
Message-ID: <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 10:57:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4YlM-0006AV-NU
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 10:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbXF3I4k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 04:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbXF3I4j
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 04:56:39 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:56645 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbXF3I40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 04:56:26 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1I4Ykg-0008Tv-2I; Sat, 30 Jun 2007 20:56:22 +1200
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 0CCF45CE00; Sat, 30 Jun 2007 20:56:22 +1200 (NZST)
X-Mailer: git-send-email 1.5.2.1.1131.g3b90-dirty
In-Reply-To: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51204>

Some minor enhancements to the git-repack manual page.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/git-repack.txt |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index c33a512..be8e5f8 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -14,7 +14,8 @@ DESCRIPTION
 -----------
 
 This script is used to combine all objects that do not currently
-reside in a "pack", into a pack.
+reside in a "pack", into a pack.  It can also be used to re-organise
+existing packs into a single, more efficient pack.
 
 A pack is a collection of objects, individually compressed, with
 delta compression applied, stored in a single file, with an
@@ -28,11 +29,13 @@ OPTIONS
 
 -a::
 	Instead of incrementally packing the unpacked objects,
-	pack everything available into a single pack.
+	pack everything referenced into a single pack.
 	Especially useful when packing a repository that is used
-	for private development and there is no need to worry
-	about people fetching via dumb file transfer protocols
-	from it.  Use with '-d'.
+	for private development and there no need to worry
+	about people fetching via dumb protocols from it.  Use
+	with '-d'.  This will clean up the objects that `git prune`
+	leaves behind, but `git fsck-objects --full` shows as
+	dangling.
 
 -d::
 	After packing, if the newly created packs make some
-- 
1.5.2.1.1131.g3b90
