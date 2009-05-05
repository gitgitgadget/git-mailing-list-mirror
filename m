From: "Alexey I. Froloff" <raorn@altlinux.org>
Subject: [PATCH] Fixed man entities.
Date: Wed,  6 May 2009 01:51:23 +0400
Message-ID: <1241560283-13529-1-git-send-email-raorn@altlinux.org>
Cc: "Dmitry V. Levin" <ldv@altlinux.org>,
	"Alexey I. Froloff" <raorn@altlinux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 00:02:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1SiE-0006Fg-SR
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 00:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbZEEWB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 18:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbZEEWB5
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 18:01:57 -0400
Received: from vint.altlinux.org ([194.107.17.35]:53075 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbZEEWB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 18:01:57 -0400
X-Greylist: delayed 631 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 May 2009 18:01:57 EDT
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vint.altlinux.org (Postfix) with ESMTP id 739A13F80009
	for <git@vger.kernel.org>; Tue,  5 May 2009 21:51:26 +0000 (UTC)
Received: from [213.85.39.63] (unknown [213.85.39.63])
	by imap.altlinux.org (Postfix) with ESMTPSA id 2D2443E489EB;
	Wed,  6 May 2009 01:51:24 +0400 (MSD)
Received: by hell.fortress (Postfix, from userid 500)
	id 82A083600058; Wed,  6 May 2009 01:51:23 +0400 (MSD)
X-Mailer: git-send-email 1.6.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118315>

It has to be just "\fR", "\fB", ".sp" and ".br", not weird unicode
stuff.

Signed-off-by: Alexey I. Froloff <raorn@altlinux.org>
---
 Documentation/manpage-1.72.xsl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/manpage-1.72.xsl b/Documentation/manpage-1.72.xsl
index 4065a3a..2f4b6cb 100644
--- a/Documentation/manpage-1.72.xsl
+++ b/Documentation/manpage-1.72.xsl
@@ -5,17 +5,17 @@
 <xsl:param name="refentry.meta.get.quietly" select="1"/>
 
 <xsl:template match="co">
-	<xsl:value-of select="concat('&#x2593;fB(',substring-after(@id,'-'),')&#x2593;fR')"/>
+	<xsl:value-of select="concat('\\fB(',substring-after(@id,'-'),')\\fR')"/>
 </xsl:template>
 <xsl:template match="calloutlist">
-	<xsl:text>&#x2302;sp&#10;</xsl:text>
+	<xsl:text>.sp&#10;</xsl:text>
 	<xsl:apply-templates/>
 	<xsl:text>&#10;</xsl:text>
 </xsl:template>
 <xsl:template match="callout">
-	<xsl:value-of select="concat('&#x2593;fB',substring-after(@arearefs,'-'),'. &#x2593;fR')"/>
+	<xsl:value-of select="concat('\\fB',substring-after(@arearefs,'-'),'. \\fR')"/>
 	<xsl:apply-templates/>
-	<xsl:text>&#x2302;br&#10;</xsl:text>
+	<xsl:text>.br&#10;</xsl:text>
 </xsl:template>
 
 </xsl:stylesheet>
-- 
1.6.2.4
