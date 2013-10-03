From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] Documentation/Makefile: make AsciiDoc dblatex dir configurable
Date: Thu,  3 Oct 2013 20:17:32 +0100
Message-ID: <6c148f88f6efb7c5d7a9a03f8383b47f939b36ec.1380827852.git.john@keeping.me.uk>
Cc: Miklos Vajna <vmiklos@suse.cz>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 03 21:17:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRoPI-0005YE-HH
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 21:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031Ab3JCTRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Oct 2013 15:17:48 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:58824 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab3JCTRs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Oct 2013 15:17:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6A82BCDA60B;
	Thu,  3 Oct 2013 20:17:47 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6dFsz8m8uBQ4; Thu,  3 Oct 2013 20:17:46 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id D3A92CDA605;
	Thu,  3 Oct 2013 20:17:41 +0100 (BST)
X-Mailer: git-send-email 1.8.4.566.g73d370b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235690>

On my system this is in /usr/share/asciidoc/dblatex not
/etc/asciidoc/dblatex.  Extract this portion of the path to a variable
so that is can be set in config.mak.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0cfdc36..4f13a23 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -103,6 +103,7 @@ MAKEINFO = makeinfo
 INSTALL_INFO = install-info
 DOCBOOK2X_TEXI = docbook2x-texi
 DBLATEX = dblatex
+ASCIIDOC_DBLATEX_DIR = /etc/asciidoc/dblatex
 ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl
 endif
@@ -354,7 +355,7 @@ user-manual.texi: user-manual.xml
 
 user-manual.pdf: user-manual.xml
 	$(QUIET_DBLATEX)$(RM) $@+ $@ && \
-	$(DBLATEX) -o $@+ -p /etc/asciidoc/dblatex/asciidoc-dblatex.xsl -s /etc/asciidoc/dblatex/asciidoc-dblatex.sty $< && \
+	$(DBLATEX) -o $@+ -p $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.xsl -s $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.sty $< && \
 	mv $@+ $@
 
 gitman.texi: $(MAN_XML) cat-texi.perl
-- 
1.8.4.566.g73d370b
