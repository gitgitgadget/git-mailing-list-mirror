From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 5/9] Force full checkpoint for CheckpointOperation.
Date: Wed, 28 Feb 2007 23:26:32 +0100
Message-ID: <20070228222631.12021.49294.stgit@lathund.dewire.com>
References: <20070228222355.12021.13029.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 23:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMXMw-0003dk-UA
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 23:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbXB1Wcf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 17:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbXB1Wce
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 17:32:34 -0500
Received: from [83.140.172.130] ([83.140.172.130]:1440 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932591AbXB1WcL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 17:32:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CCD868033A3
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:05 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18378-04 for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:03 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 03B4A8033A6
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:01 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 7003629859
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id ZA9jbODQTJLU for <git@vger.kernel.org>;
	Wed, 28 Feb 2007 23:26:32 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 2C24C29233
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:32 +0100 (CET)
In-Reply-To: <20070228222355.12021.13029.stgit@lathund.dewire.com>
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41021>

Until further notice we need this operation not to cut any
corners but to do everything in order to clean up because it is
still too easy to mess upp the checkpoint tree completely.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../spearce/egit/core/op/CheckpointOperation.java  |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/CheckpointOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/CheckpointOperation.java
index 9534039..6cf80ca 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/CheckpointOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/CheckpointOperation.java
@@ -68,7 +68,7 @@ public class CheckpointOperation implements IWorkspaceRunnable {
 			final IProject project = (IProject) i.next();
 			final GitProjectData projectData = GitProjectData.get(project);
 			if (projectData != null)
-				projectData.checkpointIfNecessary();
+				projectData.fullUpdate();
 		}
 	}
 }
