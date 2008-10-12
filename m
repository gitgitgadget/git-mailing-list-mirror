From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 1/4] log command: Use explicit US locale for dates
Date: Mon, 13 Oct 2008 00:50:57 +0200
Message-ID: <1223851860-13068-2-git-send-email-robin.rosenberg@dewire.com>
References: <1223851860-13068-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Oct 13 00:54:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp9os-0001ia-T5
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 00:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbYJLWwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 18:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbYJLWwi
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 18:52:38 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19051 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbYJLWwh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 18:52:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EE04EAE5729;
	Mon, 13 Oct 2008 00:52:34 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nDxzMmKJgtc2; Mon, 13 Oct 2008 00:52:18 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id E8BF28026D0;
	Mon, 13 Oct 2008 00:52:17 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
In-Reply-To: <1223851860-13068-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98062>

The format used is a variation of the US locale and looks odd when localized
anyway so do not try to localize it.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/pgm/Log.java              |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
index e16387b..e3a32c8 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Log.java
@@ -40,6 +40,7 @@
 
 import java.text.DateFormat;
 import java.text.SimpleDateFormat;
+import java.util.Locale;
 import java.util.TimeZone;
 
 import org.spearce.jgit.lib.PersonIdent;
@@ -52,7 +53,7 @@
 	private final DateFormat fmt;
 
 	Log() {
-		fmt = new SimpleDateFormat("EEE MMM dd HH:mm:ss yyyy ZZZZZ");
+		fmt = new SimpleDateFormat("EEE MMM dd HH:mm:ss yyyy ZZZZZ", Locale.US);
 	}
 
 	@Override
-- 
1.6.0.2.308.gef4a
