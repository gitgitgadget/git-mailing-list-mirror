From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/1] Remove dead cacheTree related code from GitProjectData
Date: Mon,  4 Aug 2008 19:22:56 -0700
Message-ID: <1217902976-801-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:24:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQCDU-00020r-NC
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 04:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbYHECXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 22:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753955AbYHECW7
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 22:22:59 -0400
Received: from george.spearce.org ([209.20.77.23]:52260 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbYHECW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 22:22:59 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 7428838420; Tue,  5 Aug 2008 02:22:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 6943838368;
	Tue,  5 Aug 2008 02:22:57 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91407>

We have long since purged the idea of the cache tree from egit, so we
do not need this commented out block of code anymore.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/egit/core/project/GitProjectData.java  |   35 --------------------
 1 files changed, 0 insertions(+), 35 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
index f092669..8754bd1 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjectData.java
@@ -415,31 +415,6 @@ public class GitProjectData {
 						} else if (s == null) {
 							return true;
 						}
-
-//						final Tree cacheTree = m.getCacheTree();
-//						if (cacheTree != null) {
-//							try {
-//								synchronized (cacheTree) {
-//									final TreeEntry e;
-//									if (res.getType() == IResource.FILE)
-//										e = cacheTree.findBlobMember(s);
-//									else
-//										e = cacheTree.findTreeMember(s);
-//									if (e instanceof FileTreeEntry) {
-//										trace("modified " + r + " -> "
-//												+ e.getFullName());
-//										e.setModified();
-//										affectedMappings.add(m);
-//									}
-//								}
-//							} catch (IOException ioe) {
-//								throw Activator
-//										.error(
-//												CoreText.GitProjectData_lazyResolveFailed,
-//												ioe);
-//							}
-//							return true;
-//						}
 					}
 					return false;
 				}
@@ -451,16 +426,6 @@ public class GitProjectData {
 			detachFromWorkspace();
 			Activator.logError(CoreText.GitProjectData_notifyChangedFailed, ce);
 		}
-
-//		try {
-//			final Iterator i = affectedMappings.iterator();
-//			while (i.hasNext()) {
-//				((RepositoryMapping) i.next()).recomputeMerge();
-//			}
-//		} catch (IOException ioe) {
-//			Activator
-//					.logError(CoreText.GitProjectData_notifyChangedFailed, ioe);
-//		}
 	}
 
 	private File propertyFile() {
-- 
1.6.0.rc1.250.g9b5e2
