From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 06/12] Remove pointless null assignments in Config
Date: Tue, 21 Jul 2009 13:19:24 -0700
Message-ID: <1248207570-13880-7-git-send-email-spearce@spearce.org>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org>
 <1248207570-13880-2-git-send-email-spearce@spearce.org>
 <1248207570-13880-3-git-send-email-spearce@spearce.org>
 <1248207570-13880-4-git-send-email-spearce@spearce.org>
 <1248207570-13880-5-git-send-email-spearce@spearce.org>
 <1248207570-13880-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:21:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLpw-0001jT-2s
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbZGUUTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756100AbZGUUTj
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:19:39 -0400
Received: from george.spearce.org ([209.20.77.23]:59254 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756122AbZGUUTd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:19:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2468538262; Tue, 21 Jul 2009 20:19:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E6508381FD;
	Tue, 21 Jul 2009 20:19:32 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc1.186.g60aa0c
In-Reply-To: <1248207570-13880-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123697>

The new instance already initialized these fields to null.  We
don't set them elsewhere unless we want them to be non-null,
so we shouldn't set them here either.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index 4a60199..4940cc2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -639,8 +639,6 @@ else if (values.size() == 1) {
 				// so we must create a new section header at the end.
 				//
 				final Entry e = new Entry();
-				e.prefix = null;
-				e.suffix = null;
 				e.base = section;
 				e.extendedBase = subsection;
 				entries.add(e);
@@ -648,8 +646,6 @@ else if (values.size() == 1) {
 			}
 			while (valueIndex < values.size()) {
 				final Entry e = new Entry();
-				e.prefix = null;
-				e.suffix = null;
 				e.base = section;
 				e.extendedBase = subsection;
 				e.name = name;
-- 
1.6.4.rc1.186.g60aa0c
