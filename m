From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH v2 1/8] Documentation: move callouts.xsl to
 manpage-{base,normal}.xsl
Date: Fri, 27 Mar 2009 01:43:58 -0500
Message-ID: <1238136245-22853-2-git-send-email-chris_johnsen@pobox.com>
References: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 07:46:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln5pn-0007vH-VX
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 07:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbZC0GpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 02:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbZC0GpE
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 02:45:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbZC0GpB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 02:45:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 057839351;
	Fri, 27 Mar 2009 02:45:00 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 457CD9350; Fri, 27 Mar 2009 02:44:55 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.401.gc048
In-Reply-To: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: CAF678CC-1A9A-11DE-ADB9-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114854>

Each of manpage-base.xsl and manpage-normal.xsl gets a copy of
the contents of callouts.xsl and the original is removed. The
Makefile is adjusted to refer to manpage-normal.xsl instead of
callouts.xsl. manpage-base.xsl will be later made into a common
base for -normal and -1.72.

Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

This duplication is in preparation for refactoring. It should
make it easier to keep track of the source of the various XSL
constructs while reviewing.
---
 Documentation/Makefile                             |    2 +-
 Documentation/{callouts.xsl => manpage-base.xsl}   |    0
 Documentation/{callouts.xsl => manpage-normal.xsl} |    0
 3 files changed, 1 insertions(+), 1 deletions(-)
 copy Documentation/{callouts.xsl => manpage-base.xsl} (100%)
 rename Documentation/{callouts.xsl => manpage-normal.xsl} (100%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 144ec32..e1562e3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -41,7 +41,7 @@ man7dir=$(mandir)/man7
 
 ASCIIDOC=asciidoc
 ASCIIDOC_EXTRA =
-MANPAGE_XSL = callouts.xsl
+MANPAGE_XSL = manpage-normal.xsl
 INSTALL?=install
 RM ?= rm -f
 DOC_REF = origin/man
diff --git a/Documentation/callouts.xsl b/Documentation/manpage-base.xsl
similarity index 100%
copy from Documentation/callouts.xsl
copy to Documentation/manpage-base.xsl
diff --git a/Documentation/callouts.xsl b/Documentation/manpage-normal.xsl
similarity index 100%
rename from Documentation/callouts.xsl
rename to Documentation/manpage-normal.xsl
-- 
1.6.2.1.401.gc048
