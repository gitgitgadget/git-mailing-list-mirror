From: ferry.huberts@pelagic.nl
Subject: [EGIT] [PATCH 1/2] Make sure to set core.bare to false when cloning
Date: Sat, 21 Feb 2009 16:17:47 +0100
Message-ID: <80065b1339c7b235b19fa1f5a40a58dca335ae91.1235228532.git.ferry.huberts@pelagic.nl>
References: <cover.1235228532.git.ferry.huberts@pelagic.nl>
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 16:20:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Latdu-0002Vg-UF
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 16:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbZBUPR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 10:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753196AbZBUPR4
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 10:17:56 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:55608 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753189AbZBUPRz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Feb 2009 10:17:55 -0500
Received: from localhost.localdomain (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 58FB758BDCE;
	Sat, 21 Feb 2009 16:17:53 +0100 (CET)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <cover.1235228532.git.ferry.huberts@pelagic.nl>
In-Reply-To: <cover.1235228532.git.ferry.huberts@pelagic.nl>
References: <cover.1235228532.git.ferry.huberts@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110961>

From: Ferry Huberts <ferry.huberts@pelagic.nl>

This is to make sure that the git plugin sets up a clone
in the same fashion as the CLI git clone command.

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
 .../org/spearce/egit/core/op/CloneOperation.java   |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
index 145c50b..f9ff6a3 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/CloneOperation.java
@@ -154,6 +154,9 @@ private void doInit(final IProgressMonitor monitor)
 					remoteConfig.addFetchRefSpec(wcrs.expandFromSource(ref));
 		}
 
+		/* we're setting up for a clone with a checkout */
+		local.getConfig().setBoolean("core", null, "bare", false);
+		
 		remoteConfig.update(local.getConfig());
 		local.getConfig().save();
 	}
-- 
1.6.0.6
