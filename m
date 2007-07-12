From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 6/6] Add documentation for --window-memory, pack.windowMemory
Date: Thu, 12 Jul 2007 07:55:52 -0500
Message-ID: <11842449521427-git-send-email-bdowning@lavos.net>
References: <1184244952554-git-send-email-bdowning@lavos.net>
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 14:56:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8yDY-0005TH-Dr
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 14:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763648AbXGLM4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 08:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763602AbXGLM4E
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 08:56:04 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:53127 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1763319AbXGLMzv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 08:55:51 -0400
Received: by silvara (Postfix, from userid 1000)
	id B14B45213A; Thu, 12 Jul 2007 07:55:52 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
In-Reply-To: <1184244952554-git-send-email-bdowning@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52278>

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 Documentation/config.txt           |    6 ++++++
 Documentation/git-pack-objects.txt |   11 +++++++++++
 Documentation/git-repack.txt       |   11 +++++++++++
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4b67f0a..11b3321 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -589,6 +589,12 @@ pack.depth::
 	The maximum delta depth used by gitlink:git-pack-objects[1] when no
 	maximum depth is given on the command line. Defaults to 50.
 
+pack.windowMemory::
+	The window memory size limit used by gitlink:git-pack-objects[1]
+	when no limit is given on the command line.  The value can be
+	suffixed with "k", "m", or "g".  Defaults to 0, meaning no
+	limit.
+
 pack.compression::
 	An integer -1..9, indicating the compression level for objects
 	in a pack file. -1 is the zlib default. 0 means no
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index e3549b5..6f17cff 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -85,6 +85,17 @@ base-name::
 	times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
 
+--window-memory=[N]::
+	This option provides an additional limit on top of `--window`;
+	the window size will dynamically scale down so as to not take
+	up more than N bytes in memory.  This is useful in
+	repositories with a mix of large and small objects to not run
+	out of memory with a large window, but still be able to take
+	advantage of the large window for the smaller objects.  The
+	size can be suffixed with "k", "m", or "g".
+	`--window-memory=0` makes memory usage unlimited, which is the
+	default.
+
 --max-pack-size=<n>::
 	Maximum size of each output packfile, expressed in MiB.
 	If specified,  multiple packfiles may be created.
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 2894939..5283ef8 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -68,6 +68,17 @@ OPTIONS
 	to be applied that many times to get to the necessary object.
 	The default value for --window is 10 and --depth is 50.
 
+--window-memory=[N]::
+	This option provides an additional limit on top of `--window`;
+	the window size will dynamically scale down so as to not take
+	up more than N bytes in memory.  This is useful in
+	repositories with a mix of large and small objects to not run
+	out of memory with a large window, but still be able to take
+	advantage of the large window for the smaller objects.  The
+	size can be suffixed with "k", "m", or "g".
+	`--window-memory=0` makes memory usage unlimited, which is the
+	default.
+
 --max-pack-size=<n>::
 	Maximum size of each output packfile, expressed in MiB.
 	If specified,  multiple packfiles may be created.
-- 
1.5.2.GIT
