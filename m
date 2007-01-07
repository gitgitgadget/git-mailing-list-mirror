From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH 1/2] Fix up Makefiles
Date: Sat,  6 Jan 2007 23:04:51 -0300
Message-ID: <11681354942365-git-send-email-vonbrand@inf.utfsm.cl>
References: <11681354924120-git-send-email-vonbrand@inf.utfsm.cl>
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Sun Jan 07 03:05:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3NPI-0004HF-R8
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 03:05:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbXAGCE7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 21:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbXAGCE7
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 21:04:59 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:60703 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932321AbXAGCE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 21:04:58 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l0724t2O005585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Jan 2007 23:04:56 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0724s4v024001;
	Sat, 6 Jan 2007 23:04:54 -0300
Received: (from vonbrand@localhost)
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8/Submit) id l0724s4O024000;
	Sat, 6 Jan 2007 23:04:54 -0300
To: Josef Sipek <jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.5.0.rc0.g244a7
In-Reply-To: <11681354924120-git-send-email-vonbrand@inf.utfsm.cl>
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Sat, 06 Jan 2007 23:04:56 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36117>

From: Horst H. von Brand <vonbrand@inf.utfsm.cl>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Makefile            |   11 ++++++++++-
 regression/Makefile |    1 +
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index a9fb9b7..7e40266 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,17 @@
 PREFIX=/usr/local
 
+SCRIPTS = guilt guilt-applied guilt-delete guilt-header guilt-init guilt-new guilt-next guilt-pop guilt-prev guilt-push guilt-refresh guilt-series guilt-top guilt-unapplied
+
+.PHONY: all 
 all:
 	echo "Nothing to build, it is all bash :)"
 	echo "Try make install"
 
+.PHONY: install
 install:
-	install guilt* $(PREFIX)/bin/
+	install -m 755 $(SCRIPTS) $(PREFIX)/bin/
+
+.PHONY: test
+test:
+	make -C regression all
+		
diff --git a/regression/Makefile b/regression/Makefile
index c73d5d0..c538029 100644
--- a/regression/Makefile
+++ b/regression/Makefile
@@ -1,2 +1,3 @@
+.PHONY: all
 all:
 	(for x in *.sh ; do sh $$x || exit $?; done)
-- 
1.5.0.rc0.g244a7
