From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH 4/8] Documentation: move quieting params into
 manpage-base.xsl
Date: Tue, 24 Mar 2009 03:04:22 -0500
Message-ID: <1237881866-5497-5-git-send-email-chris_johnsen@pobox.com>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 09:06:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1et-0006ZF-Ah
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822AbZCXIFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756772AbZCXIFV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:05:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756758AbZCXIFS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:05:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9EF5FA4BD5;
	Tue, 24 Mar 2009 04:05:16 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 EB828A4BD4; Tue, 24 Mar 2009 04:05:10 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.214.ge986c
In-Reply-To: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: 82A65850-184A-11DE-B776-32B0EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114416>

Move a couple of XSL parameters that act to silence
informational/warning messages generated when running xmlto from
manpage-1.72.xsl to manpage-base.xsl.

Since unused parameters are silently ignored, there is no problem
if some version of docbook-xsl does not know about these
parameters. The only problem might be if a version of docbook-xsl
uses the parameters for alternate functionality. Since both
parameters have fairly specific names such a situation is
unlikely.

Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

I am not sure why these were only in the -1.72 variant. They
should probably be in -base (done by this patch) or in neither
variant. If there is a good reason for having it only in -1.72,
this patch can be dropped entirely, the rest do not depend on it.
---
 Documentation/manpage-1.72.xsl |    4 ----
 Documentation/manpage-base.xsl |    4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/manpage-1.72.xsl b/Documentation/manpage-1.72.xsl
index 06d4485..8b815cd 100644
--- a/Documentation/manpage-1.72.xsl
+++ b/Documentation/manpage-1.72.xsl
@@ -10,8 +10,4 @@
 <xsl:param name="git.docbook.backslash">&#x2593;</xsl:param>
 <xsl:param name="git.docbook.dot"      >&#x2302;</xsl:param>
 
-<!-- these params silence some output from xmlto -->
-<xsl:param name="man.output.quietly" select="1"/>
-<xsl:param name="refentry.meta.get.quietly" select="1"/>
-
 </xsl:stylesheet>
diff --git a/Documentation/manpage-base.xsl b/Documentation/manpage-base.xsl
index 6d3eb19..a264fa6 100644
--- a/Documentation/manpage-base.xsl
+++ b/Documentation/manpage-base.xsl
@@ -3,6 +3,10 @@
 <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 		version="1.0">
 
+<!-- these params silence some output from xmlto -->
+<xsl:param name="man.output.quietly" select="1"/>
+<xsl:param name="refentry.meta.get.quietly" select="1"/>
+
 <!-- convert asciidoc callouts to man page format;
      git.docbook.backslash and git.docbook.dot params
      must be supplied by another XSL file or other means -->
-- 
1.6.2.1.214.ge986c
