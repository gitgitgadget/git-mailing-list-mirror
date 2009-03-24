From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH 7/8] Documentation: asciidoc.conf: fix verse block with block
 titles
Date: Tue, 24 Mar 2009 03:04:25 -0500
Message-ID: <1237881866-5497-8-git-send-email-chris_johnsen@pobox.com>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 09:09:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1h1-00072O-9z
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841AbZCXIFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756821AbZCXIFh
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:05:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824AbZCXIFf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:05:35 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 71014A4BE2;
	Tue, 24 Mar 2009 04:05:33 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 44548A4BDF; Tue, 24 Mar 2009 04:05:27 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.214.ge986c
In-Reply-To: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: 8CAB7FB0-184A-11DE-BE4E-32B0EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114419>

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
1.6.2.1.214.ge986c
