From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] Documentation: fix man page dependency on asciidoc.conf
Date: Sat, 5 Jan 2013 16:00:17 +0000
Message-ID: <20130105160017.GD6440@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 17:07:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrWHW-0007yw-7P
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 17:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817Ab3AEQHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 11:07:09 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:32812 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812Ab3AEQHC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 11:07:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id D5DBE6064D6;
	Sat,  5 Jan 2013 16:00:24 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MxPqi7vFwE-s; Sat,  5 Jan 2013 16:00:24 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 6080C6064D3;
	Sat,  5 Jan 2013 16:00:22 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 4E974161E541;
	Sat,  5 Jan 2013 16:00:22 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lpOii5EUmQKb; Sat,  5 Jan 2013 16:00:22 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 61A34161E530;
	Sat,  5 Jan 2013 16:00:18 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212700>

When building manual pages, the source text is transformed to XML with
AsciiDoc before the man pages are generated from the XML with xmlto.

Fix the dependency in the Makefile so that the XML files are rebuilt
when asciidoc.conf changes and not just the manual pages from unchanged
XML.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e53d333..71d2b4a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -178,7 +178,7 @@ all: html man
 
 html: $(DOC_HTML)
 
-$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN5) $(DOC_MAN7): asciidoc.conf
+$(DOC_HTML) $(MAN_XML): asciidoc.conf
 
 man: man1 man5 man7
 man1: $(DOC_MAN1)
-- 
1.8.0.2
