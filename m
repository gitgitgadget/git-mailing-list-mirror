From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: TOPGIT: [PATCH] Use standard prefix and DESTDIR rather than explain
Date: Tue, 12 Aug 2008 14:54:30 +0200
Organization: lilypond-design.org
Message-ID: <1218545670.7264.2.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 15:12:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KStfN-0001zO-Hp
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 15:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbYHLNKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 09:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753109AbYHLNKh
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 09:10:37 -0400
Received: from edu-smtp-01.edutel.nl ([88.159.1.221]:55472 "EHLO
	edu-smtp-01.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbYHLNKg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 09:10:36 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id A90C567793;
	Tue, 12 Aug 2008 15:10:35 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 0733ADC07A;
	Tue, 12 Aug 2008 15:10:35 +0200 (CEST)
X-Mailer: Evolution 2.23.6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92097>

First an install nitpick.



Signed-off-by: Jan Nieuwenhuizen <janneke@gnu.org>
---
 Makefile |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 6eade1e..ea6489e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,7 @@
-# Set PREFIX to wherever you want to install TopGit
-PREFIX = $(HOME)
-bindir = $(PREFIX)/bin
-cmddir = $(PREFIX)/libexec/topgit
-sharedir = $(PREFIX)/share/topgit
+prefix = $(HOME)
+bindir = $(prefix)/bin
+cmddir = $(prefix)/libexec/topgit
+sharedir = $(prefix)/share/topgit
 hooksdir = $(cmddir)/hooks
 
 
@@ -31,14 +30,15 @@ $(help_out): README
 	./create-help.sh $$CMD
 
 install:: all
-	install -d -m 755 "$(bindir)"
-	install tg "$(bindir)"
-	install -d -m 755 "$(cmddir)"
-	install $(commands_out) "$(cmddir)"
-	install -d -m 755 "$(hooksdir)"
-	install $(hooks_out) "$(hooksdir)"
-	install -d -m 755 "$(sharedir)"
-	install -m 644 $(help_out) "$(sharedir)"
+	install -d -m 755 "$(DESTDIR)$(bindir)"
+	install -d -m 755 "$(DESTDIR)$(bindir)"
+	install tg "$(DESTDIR)$(bindir)"
+	install -d -m 755 "$(DESTDIR)$(cmddir)"
+	install $(commands_out) "$(DESTDIR)$(cmddir)"
+	install -d -m 755 "$(DESTDIR)$(hooksdir)"
+	install $(hooks_out) "$(DESTDIR)$(hooksdir)"
+	install -d -m 755 "$(DESTDIR)$(sharedir)"
+	install -m 644 $(help_out) "$(DESTDIR)$(sharedir)"
 
 clean::
 	rm -f tg $(commands_out) $(hooks_out) $(help_out)
-- 
1.6.0.rc0.44.g67270


-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
