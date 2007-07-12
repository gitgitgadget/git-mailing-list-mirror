From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 5/5] Add documentation for --window-bytes, pack.windowBytes
Date: Wed, 11 Jul 2007 22:14:18 -0500
Message-ID: <1184210058514-git-send-email-bdowning@lavos.net>
References: <11842100581060-git-send-email-bdowning@lavos.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 05:14:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8p8h-0005x4-GY
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 05:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934809AbXGLDO0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 23:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934865AbXGLDOZ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 23:14:25 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:56792 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934809AbXGLDOS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 23:14:18 -0400
Received: by silvara (Postfix, from userid 1000)
	id 3D3CE52139; Wed, 11 Jul 2007 22:14:18 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
In-Reply-To: <11842100581060-git-send-email-bdowning@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52241>

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 Documentation/config.txt           |    5 +++++
 Documentation/git-pack-objects.txt |    8 ++++++++
 Documentation/git-repack.txt       |    8 ++++++++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index aeece84..83c7dc1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -592,6 +592,11 @@ pack.depth::
 	The maximum delta depth used by gitlink:git-pack-objects[1] when no
 	maximum depth is given on the command line. Defaults to 50.
 
+pack.windowBytes::
+	This option provides an additional limit on top of `pack.window`;
+	the window size will dynamically scale down so as to not take
+	up more than N bytes in memory.
+
 pack.compression::
 	An integer -1..9, indicating the compression level for objects
 	in a pack file. -1 is the zlib default. 0 means no
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index e3549b5..21ed198 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -85,6 +85,14 @@ base-name::
 	times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
 
+--window-bytes=[N]::
+	This option provides an additional limit on top of `--window`;
+	the window size will dynamically scale down so as to not take
+	up more than N bytes in memory.  This is useful in
+	repositories with a mix of large and small objects to not run
+	out of memory with a large window, but still be able to take
+	advantage of the large window for the smaller objects.
+
 --max-pack-size=<n>::
 	Maximum size of each output packfile, expressed in MiB.
 	If specified,  multiple packfiles may be created.
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 2894939..805d930 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -68,6 +68,14 @@ OPTIONS
 	to be applied that many times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
 
+--window-bytes=[N]::
+	This option provides an additional limit on top of `--window`;
+	the window size will dynamically scale down so as to not take
+	up more than N bytes in memory.  This is useful in
+	repositories with a mix of large and small objects to not run
+	out of memory with a large window, but still be able to take
+	advantage of the large window for the smaller objects.
+
 --max-pack-size=<n>::
 	Maximum size of each output packfile, expressed in MiB.
 	If specified,  multiple packfiles may be created.
-- 
1.5.2.GIT
