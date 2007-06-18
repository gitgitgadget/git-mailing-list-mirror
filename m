From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] make dist: include configure script in tarball
Date: Mon, 18 Jun 2007 23:30:36 +0200
Message-ID: <20070618213036.GA7222@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 18 23:30:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Oo5-0007Cf-8h
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 23:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762608AbXFRVaj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 17:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762912AbXFRVaj
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 17:30:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:48458 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762550AbXFRVaj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 17:30:39 -0400
Received: (qmail invoked by alias); 18 Jun 2007 21:30:37 -0000
Received: from pD9EBB5AD.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.173]
  by mail.gmx.net (mp016) with SMTP; 18 Jun 2007 23:30:37 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19jXq9FQFljKkfurpTElQfi8AkF23OjysKI69sCiy
	DaMNCzoXtnClBJ
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50414>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 Makefile |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 0f75955..9b7efcf 100644
--- a/Makefile
+++ b/Makefile
@@ -1009,15 +1009,16 @@ git.spec: git.spec.in
 	mv $@+ $@
 
 GIT_TARNAME=git-$(GIT_VERSION)
-dist: git.spec git-archive
+dist: git.spec git-archive configure
 	./git-archive --format=tar \
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
 	@mkdir -p $(GIT_TARNAME)
-	@cp git.spec $(GIT_TARNAME)
+	@cp git.spec configure $(GIT_TARNAME)
 	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
 	@$(MAKE) -C git-gui TARDIR=../$(GIT_TARNAME)/git-gui dist-version
 	$(TAR) rf $(GIT_TARNAME).tar \
 		$(GIT_TARNAME)/git.spec \
+		$(GIT_TARNAME)/configure \
 		$(GIT_TARNAME)/version \
 		$(GIT_TARNAME)/git-gui/version
 	@rm -rf $(GIT_TARNAME)
