From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/5] Add ConfigInvalidException constructor to take Throwable
Date: Wed, 29 Jul 2009 08:50:25 -0700
Message-ID: <1248882627-7285-4-git-send-email-spearce@spearce.org>
References: <1248882627-7285-1-git-send-email-spearce@spearce.org>
 <1248882627-7285-2-git-send-email-spearce@spearce.org>
 <1248882627-7285-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:51:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWBQn-0000Sa-Fv
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 17:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087AbZG2Pud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 11:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754415AbZG2Pud
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 11:50:33 -0400
Received: from george.spearce.org ([209.20.77.23]:45985 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510AbZG2Pub (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 11:50:31 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A51B538200; Wed, 29 Jul 2009 15:50:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 87F5D38195;
	Wed, 29 Jul 2009 15:50:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc3.201.gd9d59
In-Reply-To: <1248882627-7285-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124359>

This permits applications to wrap a ConfigInvalidException with
more detail before throwing it to the caller.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../jgit/errors/ConfigInvalidException.java        |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/ConfigInvalidException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/ConfigInvalidException.java
index 6e861fd..28c87a5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/ConfigInvalidException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/ConfigInvalidException.java
@@ -50,4 +50,16 @@
 	public ConfigInvalidException(final String message) {
 		super(message);
 	}
+
+	/**
+	 * Construct an invalid configuration error.
+	 *
+	 * @param message
+	 *            why the configuration is invalid.
+	 * @param cause
+	 *            root cause of the error.
+	 */
+	public ConfigInvalidException(final String message, final Throwable cause) {
+		super(message, cause);
+	}
 }
-- 
1.6.4.rc3.201.gd9d59
