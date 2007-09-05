From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 2/3] Makefile: Add install-lib and install-include targets
Date: Thu, 6 Sep 2007 03:22:13 +0400
Message-ID: <20070905232213.GB331@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 01:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT4eX-00033R-7O
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 01:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbXIEXvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 19:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757118AbXIEXvN
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 19:51:13 -0400
Received: from vhq.altlinux.org ([194.107.17.3]:47152 "EHLO
	sendmail.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089AbXIEXvL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 19:51:11 -0400
Received: from nomad.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by sendmail.altlinux.org (Postfix) with ESMTP id F053D1B58105;
	Thu,  6 Sep 2007 03:22:00 +0400 (MSD)
Received: by nomad.office.altlinux.org (Postfix, from userid 501)
	id 9F1B3170DB; Thu,  6 Sep 2007 03:22:13 +0400 (MSD)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57777>

Several external projects (e.g. parsecvs) need libgit library
and related header files.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 Makefile |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 51af531..d50e30b 100644
--- a/Makefile
+++ b/Makefile
@@ -143,6 +143,8 @@ STRIP ?= strip
 
 prefix = $(HOME)
 bindir = $(prefix)/bin
+libdir = $(prefix)/lib
+includedir = $(prefix)/include
 gitexecdir = $(bindir)
 sharedir = $(prefix)/share
 template_dir = $(sharedir)/git-core/templates
@@ -702,6 +704,8 @@ ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
+libdir_SQ = $(subst ','\'',$(libdir))
+includedir_SQ = $(subst ','\'',$(includedir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 prefix_SQ = $(subst ','\'',$(prefix))
@@ -1017,6 +1021,13 @@ install-info:
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
+install-lib: $(LIB_FILE)
+	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(libdir_SQ)'
+	$(INSTALL) -p -m644 $(LIB_FILE) '$(DESTDIR_SQ)$(libdir_SQ)/'
+
+install-include: $(LIB_H)
+	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(includedir_SQ)/git'
+	$(INSTALL) -p -m644 $(LIB_H) '$(DESTDIR_SQ)$(includedir_SQ)/git/'
 
 
 ### Maintainer's dist rules
-- 
ldv
