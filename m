From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] install-sh from automake does not like -m without
	delimiting space
Date: Sat, 1 Dec 2007 18:05:40 +0100
Message-ID: <20071201170540.GS11347@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 18:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyVnB-0000jA-PG
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 18:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbXLARFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 12:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbXLARFs
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 12:05:48 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:45880 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbXLARFr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 12:05:47 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1351833mue
        for <git@vger.kernel.org>; Sat, 01 Dec 2007 09:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        bh=SQbikZSvNmAAT4CSQWQ4+d0Yx/Q1Hw3vvELmgkqCTnE=;
        b=t9oBXG1YxhAfldjKSnp77VzmYp4Sb/b2uSMb/25WxTLb3unhlRWifVgc5gvELC4OeiGLrC0W9z5EkDOcyoqIcTBnjs0FhZAoQJ6iUyiBMebcKj1LvjMZuHUAVZjRThHciCBP8oYziKakrOGZKoffxK6CVFRzBOPhHvei/rZUL88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=UckOO2DnI8p0hVOHXeejcbeXk7rn5dlJaXx+XamgwQRvsad9cWHlxqp8evG4c27w+Anl8dWc2B6GGD/R05D+bxqG2zC0zPJqCU+Xmc0oGr1ZFM/z+J8E6D1DVZk2TtcFOLqsOU98S9FX3F0Nr3o1gFgsZA8CWOiRaTZ+F4fP6cY=
Received: by 10.82.107.15 with SMTP id f15mr2024899buc.1196528743130;
        Sat, 01 Dec 2007 09:05:43 -0800 (PST)
Received: from sigkill.schiele.dyndns.org ( [84.171.214.202])
        by mx.google.com with ESMTPS id g8sm20327984muf.2007.12.01.09.05.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Dec 2007 09:05:42 -0800 (PST)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id A171937227; Sat,  1 Dec 2007 18:05:40 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66726>

The install-sh script as shipped with automake requires a space between
the -m switch and its argument.  Since this is also the regular way of
doing it with other install implementations this change inserts the
missing space in all makefiles.

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
 Documentation/Makefile |   16 ++++++++--------
 Makefile               |    4 ++--
 git-gui/Makefile       |   12 ++++++------
 templates/Makefile     |    2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d886641..2de4b8b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -79,16 +79,16 @@ man7: $(DOC_MAN7)
 info: git.info
 
 install: man
-	$(INSTALL) -d -m755 $(DESTDIR)$(man1dir)
-	$(INSTALL) -d -m755 $(DESTDIR)$(man5dir)
-	$(INSTALL) -d -m755 $(DESTDIR)$(man7dir)
-	$(INSTALL) -m644 $(DOC_MAN1) $(DESTDIR)$(man1dir)
-	$(INSTALL) -m644 $(DOC_MAN5) $(DESTDIR)$(man5dir)
-	$(INSTALL) -m644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(man5dir)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(man7dir)
+	$(INSTALL) -m 644 $(DOC_MAN1) $(DESTDIR)$(man1dir)
+	$(INSTALL) -m 644 $(DOC_MAN5) $(DESTDIR)$(man5dir)
+	$(INSTALL) -m 644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
 
 install-info: info
-	$(INSTALL) -d -m755 $(DESTDIR)$(infodir)
-	$(INSTALL) -m644 git.info $(DESTDIR)$(infodir)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(infodir)
+	$(INSTALL) -m 644 git.info $(DESTDIR)$(infodir)
 	if test -r $(DESTDIR)$(infodir)/dir; then \
 	  $(INSTALL_INFO) --info-dir=$(DESTDIR)$(infodir) git.info ;\
 	else \
diff --git a/Makefile b/Makefile
index e869b85..7d23aec 100644
--- a/Makefile
+++ b/Makefile
@@ -1024,8 +1024,8 @@ remove-dashes:
 ### Installation rules
 
 install: all
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(bindir_SQ)'
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
diff --git a/git-gui/Makefile b/git-gui/Makefile
index e860319..4f8b7c8 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -43,11 +43,11 @@ endif
 RM_RF     ?= rm -rf
 RMDIR     ?= rmdir
 
-INSTALL_D0 = $(INSTALL) -d -m755 # space is required here
+INSTALL_D0 = $(INSTALL) -d -m 755 # space is required here
 INSTALL_D1 =
-INSTALL_R0 = $(INSTALL) -m644 # space is required here
+INSTALL_R0 = $(INSTALL) -m 644 # space is required here
 INSTALL_R1 =
-INSTALL_X0 = $(INSTALL) -m755 # space is required here
+INSTALL_X0 = $(INSTALL) -m 755 # space is required here
 INSTALL_X1 =
 INSTALL_A0 = find # space is required here
 INSTALL_A1 = | cpio -pud
@@ -71,11 +71,11 @@ ifndef V
 	QUIET_2DEVNULL = 2>/dev/null
 
 	INSTALL_D0 = dir=
-	INSTALL_D1 = && echo ' ' DEST $$dir && $(INSTALL) -d -m755 "$$dir"
+	INSTALL_D1 = && echo ' ' DEST $$dir && $(INSTALL) -d -m 755 "$$dir"
 	INSTALL_R0 = src=
-	INSTALL_R1 = && echo '   ' INSTALL 644 `basename $$src` && $(INSTALL) -m644 $$src
+	INSTALL_R1 = && echo '   ' INSTALL 644 `basename $$src` && $(INSTALL) -m 644 $$src
 	INSTALL_X0 = src=
-	INSTALL_X1 = && echo '   ' INSTALL 755 `basename $$src` && $(INSTALL) -m755 $$src
+	INSTALL_X1 = && echo '   ' INSTALL 755 `basename $$src` && $(INSTALL) -m 755 $$src
 	INSTALL_A0 = src=
 	INSTALL_A1 = && echo '   ' INSTALL '   ' `basename "$$src"` && find "$$src" | cpio -pud
 
diff --git a/templates/Makefile b/templates/Makefile
index 6f4dbd3..ebd3a62 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -46,6 +46,6 @@ clean:
 	$(RM) -r blt boilerplates.made
 
 install: all
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(template_dir_SQ)'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_dir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(template_dir_SQ)' && $(TAR) xf -)
-- 
1.5.2.4
