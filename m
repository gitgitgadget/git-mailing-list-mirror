From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/1] Compile all Java sources in jgit as UTF-8
Date: Sat, 26 Jul 2008 21:11:54 -0700
Message-ID: <1217131914-14837-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 06:12:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMxcx-0007GT-0k
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 06:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbYG0EL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 00:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbYG0EL5
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 00:11:57 -0400
Received: from george.spearce.org ([209.20.77.23]:51124 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbYG0EL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 00:11:57 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7FED9383A8; Sun, 27 Jul 2008 04:11:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 16DCB383A3;
	Sun, 27 Jul 2008 04:11:54 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc0.182.gb96c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90305>

We use a UTF-8 encoding in our source files whenever possible.
If the compiler assumes ASCII we sometimes get warnings parsing
copyright information for authors whose names aren't representable
in US-ASCII.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 make_jgit.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/make_jgit.sh b/make_jgit.sh
index 89df80c..13d0e32 100755
--- a/make_jgit.sh
+++ b/make_jgit.sh
@@ -58,6 +58,7 @@ do
 	 xargs javac \
 		-source 1.5 \
 		-target 1.5 \
+		-encoding UTF-8 \
 		-g \
 		-d ../bin2) || die "Building $p failed."
 	CLASSPATH="$CLASSPATH:$R/$p/bin2"
-- 
1.6.0.rc0.182.gb96c7
