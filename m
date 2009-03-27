From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH v2 7/8] Documentation: asciidoc.conf: fix verse block with
 block titles
Date: Fri, 27 Mar 2009 01:44:04 -0500
Message-ID: <1238136245-22853-8-git-send-email-chris_johnsen@pobox.com>
References: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 07:48:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln5rG-0008Hu-1s
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 07:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbZC0Gpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 02:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbZC0Gpw
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 02:45:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45617 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbZC0Gpv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 02:45:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 08B0B936D;
	Fri, 27 Mar 2009 02:45:50 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 564309369; Fri, 27 Mar 2009 02:45:45 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.401.gc048
In-Reply-To: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: E8C5E91E-1A9A-11DE-BCC4-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114855>

No files use the variant of block-title with verse-block, but
such a case would have generated broken docbook XML (<simpara> is
not allowed inside <para>). This fixes the potential deviation from
valid docbook XML.

Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

This is a bugfix for a bug that the documentation currently does
not trigger. Drop this patch if this is unwarranted.
---
 Documentation/asciidoc.conf |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 9963f2d..dc76e7f 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -59,8 +59,9 @@ ifdef::doctype-manpage[]
 {title%}<literallayout{id? id="{id}"}>
 {title#}<literallayout>
 |
-</literallayout><simpara></simpara>
+</literallayout>
 {title#}</para></formalpara>
+{title%}<simpara></simpara>
 endif::doctype-manpage[]
 endif::git-asciidoc-no-roff[]
 endif::backend-docbook[]
-- 
1.6.2.1.401.gc048
