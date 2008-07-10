From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/3] Avoid errors by allowing phantoms during traversal in the resource decorator
Date: Fri, 11 Jul 2008 00:41:07 +0200
Message-ID: <1215729668-26865-3-git-send-email-robin.rosenberg@dewire.com>
References: <1215729668-26865-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729668-26865-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:47:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4vb-0004Lo-RU
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813AbYGJWqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbYGJWqb
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:31 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13177 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754256AbYGJWqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D8BF88027F7;
	Fri, 11 Jul 2008 00:46:14 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mCM35M44Rd5x; Fri, 11 Jul 2008 00:46:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 154B7802C0D;
	Fri, 11 Jul 2008 00:46:14 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729668-26865-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88035>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../internal/decorators/GitResourceDecorator.java  |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index c625ce6..8d4a7c7 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -137,7 +137,9 @@ public class GitResourceDecorator extends LabelProvider implements
 								getActiveDecorator().clearDecorationState(resource);
 								return true;
 							}
-						});
+						},
+						IResource.DEPTH_INFINITE,
+						true);
 					} finally {
 						getJobManager().endRule(markerRule);
 					}
@@ -164,7 +166,9 @@ public class GitResourceDecorator extends LabelProvider implements
 						}
 						return true;
 					}
-				});
+				},
+				true
+				);
 			} catch (Exception e) {
 				Activator.logError("Problem during decorations. Stopped", e);
 			}
-- 
1.5.6.2.220.g44701
