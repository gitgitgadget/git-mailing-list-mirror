From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Make SHA-1 selectable using double-click in the commit message viewer.
Date: Sat, 10 Jan 2009 18:20:53 +0100
Message-ID: <1231608053-25866-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jan 10 18:22:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLhXT-0005qK-Cz
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 18:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbZAJRU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 12:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbZAJRU6
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 12:20:58 -0500
Received: from mail.dewire.com ([83.140.172.130]:10818 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbZAJRU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 12:20:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 06C6B1484F7C;
	Sat, 10 Jan 2009 18:20:55 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QkKfRfjPUB85; Sat, 10 Jan 2009 18:20:54 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 6137D1484F72;
	Sat, 10 Jan 2009 18:20:54 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105131>

The default behaviour does not consider a sequence of numbers and letters
to be a word. Installing the DefaultTextDoubleClickStrategy and activating
"plugins" in the textviewer solves the problem.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../ui/internal/history/CommitMessageViewer.java   |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java
index 76d57bd..d21555c 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java
@@ -15,7 +15,9 @@
 import java.util.regex.Pattern;
 
 import org.eclipse.core.runtime.ListenerList;
+import org.eclipse.jface.text.DefaultTextDoubleClickStrategy;
 import org.eclipse.jface.text.Document;
+import org.eclipse.jface.text.IDocument;
 import org.eclipse.jface.text.TextViewer;
 import org.eclipse.swt.SWT;
 import org.eclipse.swt.custom.StyleRange;
@@ -98,6 +100,9 @@ public void mouseDown(final MouseEvent e) {
 				}
 			}
 		});
+		setTextDoubleClickStrategy(new DefaultTextDoubleClickStrategy(),
+				IDocument.DEFAULT_CONTENT_TYPE);
+		activatePlugins();
 	}
 
 	void addCommitNavigationListener(final CommitNavigationListener l) {
-- 
1.6.1.rc3.56.gd0306
