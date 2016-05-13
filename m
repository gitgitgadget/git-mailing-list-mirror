From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-multimail: update to release 1.3.1
Date: Fri, 13 May 2016 19:00:41 +0200
Message-ID: <20160513170041.18696-1-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 13 19:00:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1GSM-0004wJ-Qr
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 19:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbcEMRAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 13:00:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45533 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242AbcEMRAt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 13:00:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4DH0gZt004754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 13 May 2016 19:00:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4DH0hXN027689;
	Fri, 13 May 2016 19:00:44 +0200
X-Mailer: git-send-email 2.8.1.339.g3ad15fd
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Fri, 13 May 2016 19:00:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4DH0gZt004754
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1463763642.96958@9DGPvq0YfGhlRim30EuZhQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294546>

The changes are described in CHANGES.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/hooks/multimail/CHANGES          |  8 ++++++++
 contrib/hooks/multimail/README           |  2 +-
 contrib/hooks/multimail/README.Git       |  4 ++--
 contrib/hooks/multimail/git_multimail.py | 10 +++++++++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/contrib/hooks/multimail/CHANGES b/contrib/hooks/multimail/CHANGES
index 53c71b4..100cc7a 100644
--- a/contrib/hooks/multimail/CHANGES
+++ b/contrib/hooks/multimail/CHANGES
@@ -1,3 +1,11 @@
+Release 1.3.1 (bugfix-only release)
+===================================
+
+* Generate links to commits in combined emails (it was done only for
+  commit emails in 1.3.0).
+
+* Fix broken links on PyPi.
+
 Release 1.3.0
 =============
 
diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/README
index 1e04801..0c91d19 100644
--- a/contrib/hooks/multimail/README
+++ b/contrib/hooks/multimail/README
@@ -1,4 +1,4 @@
-git-multimail 1.3.0
+git-multimail 1.3.1
 ===================
 
 .. image:: https://travis-ci.org/git-multimail/git-multimail.svg?branch=master
diff --git a/contrib/hooks/multimail/README.Git b/contrib/hooks/multimail/README.Git
index ee1fa75..1210bde 100644
--- a/contrib/hooks/multimail/README.Git
+++ b/contrib/hooks/multimail/README.Git
@@ -6,10 +6,10 @@ website:
     https://github.com/git-multimail/git-multimail
 
 The version in this directory was obtained from the upstream project
-on May 03 2016 and consists of the "git-multimail" subdirectory from
+on May 13 2016 and consists of the "git-multimail" subdirectory from
 revision
 
-    26f3ae9f86aa7f8a054ba89235c4d3879f98b03d refs/tags/1.3.0
+    3ce5470d4abf7251604cbf64e73a962e1b617f5e refs/tags/1.3.1
 
 Please see the README file in this directory for information about how
 to report bugs or contribute to git-multimail.
diff --git a/contrib/hooks/multimail/git_multimail.py b/contrib/hooks/multimail/git_multimail.py
index f2c92ae..54ab4a4 100755
--- a/contrib/hooks/multimail/git_multimail.py
+++ b/contrib/hooks/multimail/git_multimail.py
@@ -1,6 +1,6 @@
 #! /usr/bin/env python
 
-__version__ = '1.3.0'
+__version__ = '1.3.1'
 
 # Copyright (c) 2015 Matthieu Moy and others
 # Copyright (c) 2012-2014 Michael Haggerty and others
@@ -1704,6 +1704,14 @@ class BranchChange(ReferenceChange):
         self.header_template = COMBINED_HEADER_TEMPLATE
         self.intro_template = COMBINED_INTRO_TEMPLATE
         self.footer_template = COMBINED_FOOTER_TEMPLATE
+
+        def revision_gen_link(base_url):
+            # revision is used only to generate the body, and
+            # _content_type is set while generating headers. Get it
+            # from the BranchChange object.
+            revision._content_type = self._content_type
+            return revision.generate_browse_link(base_url)
+        self.generate_browse_link = revision_gen_link
         for line in self.generate_email(push, body_filter, values):
             yield line
 
-- 
2.8.1.339.g3ad15fd
