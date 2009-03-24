From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH 6/8] Documentation: asciidoc.conf: always use <literallayout>
 for [blocktext]
Date: Tue, 24 Mar 2009 03:04:24 -0500
Message-ID: <1237881866-5497-7-git-send-email-chris_johnsen@pobox.com>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 09:09:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1h0-00072O-H5
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800AbZCXIFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbZCXIFd
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:05:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756832AbZCXIF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:05:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0569BA4BDE;
	Tue, 24 Mar 2009 04:05:28 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 BB509A4BDC; Tue, 24 Mar 2009 04:05:22 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.214.ge986c
In-Reply-To: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: 896D4306-184A-11DE-8414-32B0EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114420>

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
1.6.2.1.214.ge986c
