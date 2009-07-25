From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 03/19] Make Config.escapeValue a private method
Date: Sat, 25 Jul 2009 11:52:46 -0700
Message-ID: <1248547982-4003-4-git-send-email-spearce@spearce.org>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org>
 <1248547982-4003-2-git-send-email-spearce@spearce.org>
 <1248547982-4003-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:54:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmO0-0002ZF-7x
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbZGYSxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbZGYSxH
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:07 -0400
Received: from george.spearce.org ([209.20.77.23]:35549 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbZGYSxE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:04 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A066738222; Sat, 25 Jul 2009 18:53:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id AFC58381FE;
	Sat, 25 Jul 2009 18:53:03 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
In-Reply-To: <1248547982-4003-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124037>

This method is only used by toText() as it generates the
value for an entry in the file.  We don't want (or need)
to export it to our subclasses.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index 76f780f..a2f5c6a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -115,7 +115,7 @@ protected void setFileRead(boolean ok) {
 	 *            the value to escape
 	 * @return the escaped value
 	 */
-	protected static String escapeValue(final String x) {
+	private static String escapeValue(final String x) {
 		boolean inquote = false;
 		int lineStart = 0;
 		final StringBuffer r = new StringBuffer(x.length());
-- 
1.6.4.rc2.216.g769fa
