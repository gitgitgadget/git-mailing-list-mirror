From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH v2 6/8] Documentation: asciidoc.conf: always use
 <literallayout> for [blocktext]
Date: Fri, 27 Mar 2009 01:44:03 -0500
Message-ID: <1238136245-22853-7-git-send-email-chris_johnsen@pobox.com>
References: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 07:48:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln5rF-0008Hu-8y
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 07:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbZC0Gpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 02:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbZC0Gpp
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 02:45:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbZC0Gpn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 02:45:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E6BE49368;
	Fri, 27 Mar 2009 02:45:41 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 32D839364; Fri, 27 Mar 2009 02:45:37 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.401.gc048
In-Reply-To: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: E3F36CA4-1A9A-11DE-ADB9-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114856>

Make the docbook-xsl-no-raw-roff variant match the
no-docbook-xsl-no-raw-roff variant in terms of which XML tag is
used to wrap listing block text (delimited with lines of dashes).

e920b56 (Tweak asciidoc output to work with broken docbook-xsl,
2006-03-05) says docbook-xsl 1.68 needs <literallayout>. This
<screen> usages was in the old, 1.72-only section. But since it
is now the "roff-less" section, it probably makes sense to make it
symmetric with the "roff-ful" section.

Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

This is another cleanup to make the two conditional sections more
symmetric.

The only large, remaining asymmetry in the asciidoc.conf
roff/non-roff parts is the [verseblock] in the non-roff
section. Should [verseblock] be pulled out of the
roff-conditional parts?  Should a [verseblock] section be added
to the roff-using part?
---
 Documentation/asciidoc.conf |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index ce1b175..9963f2d 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -49,9 +49,9 @@ ifdef::doctype-manpage[]
 # The following two small workarounds insert a simple paragraph after screen
 [listingblock]
 <example><title>{title}</title>
-<screen>
+<literallayout>
 |
-</screen><simpara></simpara>
+</literallayout><simpara></simpara>
 {title#}</example>
 
 [verseblock]
-- 
1.6.2.1.401.gc048
