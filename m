From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 1/2] Use --force to overwrite python files
Date: Thu, 30 Aug 2007 23:04:49 -0400
Message-ID: <20070831030449.22554.49699.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 05:04:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQwoa-0005zi-ES
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 05:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756453AbXHaDEw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 23:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756483AbXHaDEv
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 23:04:51 -0400
Received: from c60.cesmail.net ([216.154.195.49]:51574 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756384AbXHaDEv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 23:04:51 -0400
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81])
  by c60.cesmail.net with ESMTP; 30 Aug 2007 23:04:50 -0400
Received: from dv.roinet.com (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id ED358618FE1;
	Thu, 30 Aug 2007 23:04:49 -0400 (EDT)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57107>

Installing StGIT with "make install" is not working properly if another
version is installed.  Files under ~/lib/python2.5/site-packages/stgit
are not updated.

This causes unexpected problems if switching between different branches
of StGIT.

Using "--force" ensures that the files in the tree are installed even if
the already installed files are newer.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/Makefile b/Makefile
index 8671209..c890b8e 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,7 @@ all:
 	$(PYTHON) setup.py build
 
 install:
-	$(PYTHON) setup.py install --prefix=$(PREFIX) --root=$(DESTDIR)
+	$(PYTHON) setup.py install --prefix=$(PREFIX) --root=$(DESTDIR) --force
 
 doc:
 	cd Documentation && $(MAKE) all
