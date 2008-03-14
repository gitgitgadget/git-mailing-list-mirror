From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Make man page building quiet when DOCBOOK_XSL_172 is
	defined
Date: Fri, 14 Mar 2008 22:38:18 +0100
Message-ID: <20080314213818.GB10085@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:39:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaHcC-0004Pm-UI
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 22:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbYCNViV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 17:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbYCNViV
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 17:38:21 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:36357 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121AbYCNViV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 17:38:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 7E5B5770036;
	Fri, 14 Mar 2008 22:38:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GcJDJZo-a-Q8; Fri, 14 Mar 2008 22:38:18 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 46A35770026;
	Fri, 14 Mar 2008 22:38:18 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 51F6A6DF8B3; Fri, 14 Mar 2008 22:37:30 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 31D381DC479; Fri, 14 Mar 2008 22:38:18 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77287>

Tell xmlto to repress printing of the lines:

	Note: meta date   : No date. Using generated date       git-xyx
	Note: Writing git-xyz.1

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/manpage-1.72.xsl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/manpage-1.72.xsl b/Documentation/manpage-1.72.xsl
index fe3cd72..96bc921 100644
--- a/Documentation/manpage-1.72.xsl
+++ b/Documentation/manpage-1.72.xsl
@@ -1,5 +1,9 @@
-<!-- callout.xsl: converts asciidoc callouts to man page format -->
+<!-- Based on callouts.xsl. Fixes man page callouts for DocBook 1.72 XSL -->
 <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
+
+<xsl:param name="man.output.quietly" select="1"/>
+<xsl:param name="refentry.meta.get.quietly" select="1"/>
+
 <xsl:template match="co">
 	<xsl:value-of select="concat('&#x2593;fB(',substring-after(@id,'-'),')&#x2593;fR')"/>
 </xsl:template>
-- 
1.5.4.4.684.g0e08.dirty

-- 
Jonas Fonseca
