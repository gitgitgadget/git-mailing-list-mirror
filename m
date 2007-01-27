From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/2] Fix merge of subtrees
Date: Sun, 28 Jan 2007 00:57:18 +0100
Message-ID: <20070127235718.26097.74542.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 11:15:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB74K-0000y0-Fr
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 11:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbXA1KPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 05:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbXA1KPO
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 05:15:14 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11922 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932520AbXA1KPK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 05:15:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 46FB3803396;
	Sun, 28 Jan 2007 10:48:53 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21553-09; Sun, 28 Jan 2007 10:48:52 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D8AA2803393;
	Sun, 28 Jan 2007 10:48:50 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 131A5293AC;
	Sun, 28 Jan 2007 00:57:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id ibeuIJ43hF5v; Sun, 28 Jan 2007 00:57:22 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 470942939E;
	Sun, 28 Jan 2007 00:57:19 +0100 (CET)
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38030>

Subtrees are sometimes lost in creating the active diff
MergedTree.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/MergedTree.java       |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/MergedTree.java b/org.spearce.jgit/src/org/spearce/jgit/lib/MergedTree.java
index 58da5cf..9aba575 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/MergedTree.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/MergedTree.java
@@ -200,7 +200,7 @@ public class MergedTree {
 
 		if (cmp <= 0) {
 		    newMerged[pos + srcId] = thisEntry;
-		    if (thisEntry instanceof Tree) {
+		    if (thisEntry instanceof Tree && !mergeCurrentTree) {
 			if (srcId == 0) {
 			    mergeCurrentTree = true;
 			} else if (srcId == 1) {
