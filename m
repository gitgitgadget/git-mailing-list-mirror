From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 04/17] Emacs mode: Makefile for building stgit.el
Date: Fri, 14 Dec 2007 11:57:00 +0100
Message-ID: <20071214105655.18066.47733.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 11:57:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38E9-0000Xi-VE
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 11:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761756AbXLNK4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759819AbXLNK4o
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:56:44 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51823 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759340AbXLNK4n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:56:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A4336200A217;
	Fri, 14 Dec 2007 11:56:42 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27584-01-58; Fri, 14 Dec 2007 11:56:42 +0100 (CET)
Received: from krank (vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 6175F200A1E8;
	Fri, 14 Dec 2007 11:56:42 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id CC5B47B406D;
	Fri, 14 Dec 2007 11:57:00 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68280>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

Shamelessly stolen from git's contrib/emacs/Makefile.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/Makefile |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 contrib/Makefile


diff --git a/contrib/Makefile b/contrib/Makefile
new file mode 100644
index 0000000..8556910
--- /dev/null
+++ b/contrib/Makefile
@@ -0,0 +1,19 @@
+EMACS =3D emacs
+
+ELC =3D stgit.elc
+INSTALL ?=3D install
+INSTALL_ELC =3D $(INSTALL) -m 644
+prefix ?=3D $(HOME)
+emacsdir =3D $(prefix)/share/emacs/site-lisp
+RM ?=3D rm -f
+
+all: $(ELC)
+
+install: all
+	$(INSTALL) -d $(DESTDIR)$(emacsdir)
+	$(INSTALL_ELC) $(ELC:.elc=3D.el) $(ELC) $(DESTDIR)$(emacsdir)
+
+%.elc: %.el
+	$(EMACS) -batch -f batch-byte-compile $<
+
+clean:; $(RM) $(ELC)
