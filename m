From: Nur Hussein <hussein@cs.usm.my>
Subject: [PATCH 1/1] Guilt: Added an uninstall target
Date: Tue, 06 Mar 2007 11:31:09 +0800
Message-ID: <1173151869.4877.15.camel@gandalf.dcc.usm.my>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Tue Mar 06 04:40:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOQXT-0004Au-60
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 04:40:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbXCFDkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 22:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933905AbXCFDkc
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 22:40:32 -0500
Received: from cs.usm.my ([202.170.56.49]:38333 "EHLO cs.usm.my"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932619AbXCFDkb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 22:40:31 -0500
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Mar 2007 22:40:30 EST
Received: from localhost (cs.usm.my [10.207.207.3])
	by cs.usm.my (8.13.8/8.13.8) with ESMTP id l263Tf4x010635;
	Tue, 6 Mar 2007 11:29:42 +0800 (SGT)
X-Mailer: Evolution 2.6.3 
X-Ppskomp-MailScanner-Information: Please contact the ISP for more information
X-Ppskomp-MailScanner: Found to be clean
X-Ppskomp-MailScanner-From: hussein@cs.usm.my
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41533>

Invoking make uninstall will remove guilt files from installed directory.

Signed-off-by: Nur Hussein <hussein@cs.usm.my>
---
 Makefile  |    4 ++++
 uninstall |   18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 828e73f..eb5fc2e 100644
--- a/Makefile
+++ b/Makefile
@@ -32,6 +32,10 @@ install:
 	install -d $(PREFIX)/bin/
 	install -m 755 $(SCRIPTS) $(PREFIX)/bin/
 
+.PHONY: uninstall
+uninstall:
+       ./uninstall $(PREFIX)/bin/ $(SCRIPTS)
+
 .PHONY: doc
 doc:
 	$(MAKE) -C Documentation all
diff --git a/uninstall b/uninstall
new file mode 100755
index 0000000..aa2e127
--- /dev/null
+++ b/uninstall
@@ -0,0 +1,18 @@
+#!/bin/bash
+#
+# Copyright (c) 2007 Nur Hussein <hussein@cs.usm.my>
+#
+
+if [ $# -lt 2 ]; then
+	echo "Usage: $0 <prefix> <file1> <file2> ..." >&2
+	exit 1
+fi
+
+PRE=$1
+
+shift
+
+for x in "$@"
+do
+	rm "$PRE/$x"
+done
-- 
1.4.4.4


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
