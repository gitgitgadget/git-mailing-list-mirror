From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 3/3] Allow the tutorial script to be run by "make test"
Date: Thu, 02 Mar 2006 20:11:59 -0500
Message-ID: <20060303011159.14619.40752.stgit@dv.roinet.com>
References: <20060303011154.14619.71590.stgit@dv.roinet.com>
X-From: git-owner@vger.kernel.org Fri Mar 03 02:12:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEyq5-0003AK-BU
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 02:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbWCCBMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 20:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbWCCBME
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 20:12:04 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:46559 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1752106AbWCCBMA
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 20:12:00 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FEypr-0005Td-V6
	for git@vger.kernel.org; Thu, 02 Mar 2006 20:12:00 -0500
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1FEypr-0003pM-AF; Thu, 02 Mar 2006 20:11:59 -0500
To: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060303011154.14619.71590.stgit@dv.roinet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17129>



Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 Documentation/Makefile                 |    4 ++++
 Documentation/tutorial-script/Makefile |    5 +++++
 Makefile                               |    1 +
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3aad2fb..e5508e8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -55,7 +55,11 @@ install-html: html
 	$(INSTALL) -m755 -d $(DESTDIR)/$(htmldir)
 	$(INSTALL) $(DOC_HTML) $(DESTDIR)/$(htmldir)
 
+test:
+	make -C tutorial-script test
+
 clean:
+	make -C tutorial-script clean
 	rm -f *.xml *.html *.1 *.7 cg*.txt $(PACKAGE).txt
 
 .PRECIOUS: cg%.txt
diff --git a/Documentation/tutorial-script/Makefile b/Documentation/tutorial-script/Makefile
new file mode 100644
index 0000000..bdf384f
--- /dev/null
+++ b/Documentation/tutorial-script/Makefile
@@ -0,0 +1,5 @@
+test:
+	./script.sh
+
+clean:
+	rm -rf Playground
diff --git a/Makefile b/Makefile
index 994b182..2b53641 100644
--- a/Makefile
+++ b/Makefile
@@ -59,6 +59,7 @@ doc:
 
 test: all
 	$(MAKE) -C t/ all
+	$(MAKE) -C Documentation/ test
 
 
 
