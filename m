From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [PATCH] Check content if necessary when decorations want to know status
Date: Tue, 10 Jun 2008 00:50:14 +0200
Message-ID: <1213051816-4046-6-git-send-email-robin.rosenberg.lists@dewire.com>
References: <1213051816-4046-1-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-2-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-3-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-4-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-5-git-send-email-robin.rosenberg.lists@dewire.com>
Cc: spearce@spearce.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 00:55:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qGF-0001Eo-GY
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 00:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768AbYFIWxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 18:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755762AbYFIWxc
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 18:53:32 -0400
Received: from [83.140.172.130] ([83.140.172.130]:17233 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755684AbYFIWx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 18:53:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C556D1434DCD;
	Tue, 10 Jun 2008 00:53:26 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tvXaAKjN78jc; Tue, 10 Jun 2008 00:53:26 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id 6506C1434DE0;
	Tue, 10 Jun 2008 00:53:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1213051816-4046-5-git-send-email-robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84443>

From: Robin Rosenberg <robin.rosenberg@dewire.com>


diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index 10e740e..4b6394c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -310,7 +310,7 @@ public class GitResourceDecorator extends LabelProvider implements
 
 						decoration.addOverlay(UIIcons.OVR_SHARED);
 
-						if (entry.isModified(mapped.getWorkDir())) {
+						if (entry.isModified(mapped.getWorkDir(), true)) {
 							decoration.addPrefix(">");
 							decoration.addSuffix("(not updated)");
 							orState(rsrc.getParent(), CHANGED);
-- 
1.5.5.1.178.g1f811
