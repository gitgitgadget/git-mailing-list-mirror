From: Adam Tkac <atkac@redhat.com>
Subject: [PATCH] DESTDIR support in contrib/subtree/Makefile
Date: Thu, 29 Nov 2012 16:41:04 +0100
Message-ID: <20121129154057.GA4300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 16:41:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te6FP-0004WC-Rp
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 16:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211Ab2K2Plk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 10:41:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2432 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336Ab2K2Plk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 10:41:40 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qATFfexT010288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 29 Nov 2012 10:41:40 -0500
Received: from localhost (evileye.atkac.brq.redhat.com [10.34.4.30])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qATFfdpA022259
	for <git@vger.kernel.org>; Thu, 29 Nov 2012 10:41:39 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210838>

Signed-off-by: Adam Tkac <atkac@redhat.com>
---

It is a good habit in Makefiles to honor DESTDIR variable to support

`make DESTDIR=/instalroot install`

syntax.

Comments are welcomed.

Regards, Adam

 contrib/subtree/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 05cdd5c..36ae3e4 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -30,12 +30,12 @@ $(GIT_SUBTREE): $(GIT_SUBTREE_SH)
 doc: $(GIT_SUBTREE_DOC)
 
 install: $(GIT_SUBTREE)
-	$(INSTALL) -m 755 $(GIT_SUBTREE) $(libexecdir)
+	$(INSTALL) -m 755 $(GIT_SUBTREE) $(DESTDIR)$(libexecdir)
 
 install-doc: install-man
 
 install-man: $(GIT_SUBTREE_DOC)
-	$(INSTALL) -m 644 $^ $(man1dir)
+	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
 
 $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
 	xmlto -m $(MANPAGE_NORMAL_XSL)  man $^
-- 
1.8.0


-- 
Adam Tkac, Red Hat, Inc.
