From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Add a simple makefile
Date: Wed, 03 May 2006 11:34:31 -0400
Message-ID: <20060503153431.9246.64487.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed May 03 17:35:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbJND-0007ZE-Sq
	for gcvg-git@gmane.org; Wed, 03 May 2006 17:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbWECPel (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 11:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWECPel
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 11:34:41 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:48809 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965225AbWECPek
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 May 2006 11:34:40 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FbJN7-0007S7-Jy
	for git@vger.kernel.org; Wed, 03 May 2006 11:34:38 -0400
Received: from localhost.roinet.com ([127.0.0.1] helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.61)
	(envelope-from <proski@gnu.org>)
	id 1FbJN1-0002PF-P3; Wed, 03 May 2006 11:34:31 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19492>

From: Pavel Roskin <proski@gnu.org>


---

 Makefile |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
new file mode 100644
index 0000000..df77d97
--- /dev/null
+++ b/Makefile
@@ -0,0 +1,23 @@
+PREFIX = $(HOME)
+DESTDIR = /
+PYTHON = python
+
+all:
+	$(PYTHON) setup.py build
+
+install:
+	$(PYTHON) setup.py install --prefix=$(PREFIX) --root=$(DESTDIR)
+
+doc:
+	cd doc && $(MAKE) all
+
+test:
+	cd t && $(MAKE) all
+
+clean:
+	for dir in doc t; do \
+		(cd $$dir && $(MAKE) clean); \
+	done
+	rm -rf build
+	rm -f stgit/*.pyc
+	rm -f stgit/commands/*.pyc
