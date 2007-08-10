From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] tweak manpage formatting
Date: Fri, 10 Aug 2007 00:49:26 -0700
Message-ID: <7vbqdfvng9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 09:51:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJPH4-0005tv-4y
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 09:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657AbXHJHvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 03:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753692AbXHJHvG
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 03:51:06 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:40848 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbXHJHvF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 03:51:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070810074926.FHFF2095.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 10 Aug 2007 03:49:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a7pT1X0011kojtg0000000; Fri, 10 Aug 2007 03:49:27 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55517>

This attempts to force fixed-font in manpages for literal
blocks.  I have tested this with docbook 1.71 and it seems to
work as expected.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The illustration in git-rev-parse.1 is much easier to read
   with this...

 Documentation/callouts.xsl |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/callouts.xsl b/Documentation/callouts.xsl
index 6a361a2..7941af7 100644
--- a/Documentation/callouts.xsl
+++ b/Documentation/callouts.xsl
@@ -27,4 +27,17 @@
   </xsl:if>
 </xsl:template>
 
+<xsl:template match="literallayout[@class='monospaced']">
+  <xsl:text>.RS</xsl:text>
+  <xsl:if test="not($man.indent.width = '')">
+    <xsl:text> </xsl:text>
+    <xsl:value-of select="$man.indent.width"/>
+  </xsl:if>
+  <xsl:text>&#10;</xsl:text>
+  <xsl:text>&#10;.ft C&#10;.nf&#10;</xsl:text>
+  <xsl:apply-templates/>
+  <xsl:text>&#10;.fi&#10;.ft&#10;</xsl:text>
+  <xsl:text>.RE&#10;</xsl:text>
+</xsl:template>
+
 </xsl:stylesheet>
