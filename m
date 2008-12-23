From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/5] Sort Ref objects by OrigName and not Name
Date: Tue, 23 Dec 2008 14:56:43 -0800
Message-ID: <1230073007-17337-2-git-send-email-spearce@spearce.org>
References: <1230073007-17337-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 23:58:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFGCY-0004fK-0a
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 23:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbYLWW4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 17:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbYLWW4u
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 17:56:50 -0500
Received: from george.spearce.org ([209.20.77.23]:51447 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbYLWW4t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 17:56:49 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 79D2E38215; Tue, 23 Dec 2008 22:56:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id EAD8C38200;
	Tue, 23 Dec 2008 22:56:47 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1230073007-17337-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103850>

This avoids sorting symrefs by their target; instead we sort the
symref by the symref's own name, thus placing "HEAD" before the
standard "refs/heads/..." namespace.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/RefComparator.java    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefComparator.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefComparator.java
index 95e3e0f..940a7ec 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefComparator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefComparator.java
@@ -54,7 +54,7 @@
 	public static final RefComparator INSTANCE = new RefComparator();
 
 	public int compare(final Ref o1, final Ref o2) {
-		return o1.getName().compareTo(o2.getName());
+		return o1.getOrigName().compareTo(o2.getOrigName());
 	}
 
 	/**
-- 
1.6.1.rc4.301.g5497a
