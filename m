From: Thomas Ackermann <th.acker66@arcor.de>
Subject: [Patch 1/1] Wire html for all files in ./technical and ./howto in
 Makefile
Date: Tue, 23 Oct 2012 19:58:04 +0200 (CEST)
Message-ID: <1531209463.296427.1351015084181.JavaMail.ngmail@webmail16.arcor-online.net>
References: <139737172.296334.1351014913982.JavaMail.ngmail@webmail16.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, peff@peff.net, th.acker66@arcor.de
To: th.acker66@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 19:58:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQik7-0006oi-B7
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 19:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830Ab2JWR6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 13:58:07 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:51921 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756761Ab2JWR6F (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Oct 2012 13:58:05 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mx.arcor.de (Postfix) with ESMTP id 308645A976;
	Tue, 23 Oct 2012 19:58:04 +0200 (CEST)
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net [151.189.21.56])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 2A24D7DAC38;
	Tue, 23 Oct 2012 19:58:04 +0200 (CEST)
Received: from webmail16.arcor-online.net (webmail16.arcor-online.net [151.189.8.70])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id 297D48663;
	Tue, 23 Oct 2012 19:58:04 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-16.arcor-online.net 297D48663
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1351015084; bh=2pZ5OUsqrxkqrWrSPOhqHawuketoTcMLRMKHj/LSTJs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=QZ4xs4vlsCOGDE44Nl6unGOJm29u0ewk6lFLQL69hVDdnKmjX73s/gz93xPieaf0a
	 fPQfPxstK63pt49sUc57awzQeCIbFo8P3rR11s54eeINzoMoOWEp79k3w+0U28q5eR
	 9QX9Ld/Mt5G/t4G/pD3CIgx7PHveb9mKFXuPBJ4w=
Received: from [188.99.42.120] by webmail16.arcor-online.net (151.189.8.70) with HTTP (Arcor Webmail); Tue, 23 Oct 2012 19:58:04 +0200 (CEST)
In-Reply-To: <139737172.296334.1351014913982.JavaMail.ngmail@webmail16.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.99.42.120
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208235>


- target "html" creates html for all files in Documentation/howto and Documentation/technical

Signed-off-by: Thomas Ackermann <th.acker66@arcor.de>
---
 Documentation/Makefile | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 267dfe1..c4e5594 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -24,8 +24,30 @@ SP_ARTICLES = user-manual
 SP_ARTICLES += howto/revert-branch-rebase
 SP_ARTICLES += howto/using-merge-subtree
 SP_ARTICLES += howto/using-signed-tag-in-pull-request
+SP_ARTICLES += howto/use-git-daemon
+SP_ARTICLES += howto/update-hook-example
+SP_ARTICLES += howto/setup-git-server-over-http
+SP_ARTICLES += howto/separating-topic-branches
+SP_ARTICLES += howto/revert-a-faulty-merge
+SP_ARTICLES += howto/recover-corrupted-blob-object
+SP_ARTICLES += howto/rebuild-from-update-hook
+SP_ARTICLES += howto/rebuild-from-update-hook
+SP_ARTICLES += howto/rebase-from-internal-branch
+SP_ARTICLES += howto/maintain-git
 API_DOCS = $(patsubst %.txt,%,$(filter-out technical/api-index-skel.txt technical/api-index.txt, $(wildcard technical/api-*.txt)))
 SP_ARTICLES += $(API_DOCS)
+
+TECH_DOCS = technical/index-format
+TECH_DOCS += technical/pack-format
+TECH_DOCS += technical/pack-heuristics
+TECH_DOCS += technical/pack-protocol
+TECH_DOCS += technical/protocol-capabilities
+TECH_DOCS += technical/protocol-common
+TECH_DOCS += technical/racy-git
+TECH_DOCS += technical/send-pack-pipeline
+TECH_DOCS += technical/shallow
+TECH_DOCS += technical/trivial-merge
+SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
 
 DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
@@ -231,7 +253,7 @@ clean:
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
 	$(RM) *.pdf
 	$(RM) howto-index.txt howto/*.html doc.dep
-	$(RM) technical/api-*.html technical/api-index.txt
+	$(RM) technical/*.html technical/api-index.txt
 	$(RM) $(cmds_txt) *.made
 	$(RM) manpage-base-url.xsl
 
@@ -264,7 +286,7 @@ technical/api-index.txt: technical/api-index-skel.txt \
 	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
-$(patsubst %,%.html,$(API_DOCS) technical/api-index): %.html : %.txt
+$(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt
 	$(QUIET_ASCIIDOC)$(ASCIIDOC) -b xhtml11 -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=$(GIT_VERSION) $*.txt
 
-- 
1.7.11.msysgit.1


---
Thomas
