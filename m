From: David Kastrup <dak@gnu.org>
Subject: [install info (using perl) 1/2] Add support for an info version of the user manual
Date: Mon, 6 Aug 2007 12:22:57 +0200
Message-ID: <f61195c2c46468565b52f86e285cfda8c4ae9a3e.1186483533.git.dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 12:47:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIMbM-0005cX-5o
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 12:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758410AbXHGKro (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 06:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758092AbXHGKro
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 06:47:44 -0400
Received: from main.gmane.org ([80.91.229.2]:50362 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756886AbXHGKrn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 06:47:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIMb1-0006HA-Q6
	for git@vger.kernel.org; Tue, 07 Aug 2007 12:47:29 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 12:47:27 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 12:47:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
X-From-Line: f61195c2c46468565b52f86e285cfda8c4ae9a3e Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:NEbRZvO9taNDnNqnyAglkxLZ2j8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55242>

These patches use docbook2x in order to create an info version of the
git user manual.  No existing Makefile targets (including "all") are
touched, so you need to explicitly say

make info
sudo make install-info

to get git.info created and installed.  If the info target directory
does not already contain a "dir" file, no directory entry is created.
This facilitates $(DESTDIR)-based installations.  The same could be
achieved with

sudo make INSTALL_INFO=: install-info

explicitly.

perl is used for patching up sub-par file and directory information in
the Texinfo file.  It would be cleaner to place the respective info
straight into user-manual.txt or the conversion configurations, but I
find myself unable to find out how to do this with Asciidoc/Texinfo.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 COMMIT_EDITMSG         |   57 ++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/Makefile |   27 ++++++++++++++++++++++
 Makefile               |    6 +++++
 3 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 COMMIT_EDITMSG

diff --git a/COMMIT_EDITMSG b/COMMIT_EDITMSG
new file mode 100644
index 0000000..1718ad5
--- /dev/null
+++ b/COMMIT_EDITMSG
@@ -0,0 +1,57 @@
+Add support for an info version of the user manual
+
+These patches use docbook2x in order to create an info version of the
+git user manual.  No existing Makefile targets (including "all") are
+touched, so you need to explicitly say
+
+make info
+sudo make install-info
+
+to get git.info created and installed.  If the info target directory
+does not already contain a "dir" file, no directory entry is created.
+This facilitates $(DESTDIR)-based installations.  The same could be
+achieved with
+
+sudo make INSTALL_INFO=: install-info
+
+explicitly.
+
+perl is used for patching up sub-par file and directory information in
+the Texinfo file.  It would be cleaner to place the respective info
+straight into user-manual.txt or the conversion configurations, but I
+find myself unable to find out how to do this with Asciidoc/Texinfo.
+
+# Please enter the commit message for your changes.
+# (Comment lines starting with '#' will not be included)
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD^1 <file>..." to unstage)
+#
+#	modified:   Documentation/Makefile
+#	modified:   Makefile
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	0001-Add-support-for-an-info-version-of-the-user-manual.patch
+#	0001-Documentation-git-commit.txt-correct-bad-list-forma.patch
+#	0001-Introduce-ediff-option-for-mergetool.patch
+#	0002-Documentation-Makefile-remove-cmd-list.made-before.patch
+#	Documentation/git.info
+#	Documentation/git.texi
+#	TAGS
+#	contrib/emacs/0010-vc-git-previous-version-vc-git-next-version.patch
+#	contrib/emacs/0011-contrib-emacs-vc-git.el-a-few-more-tentative-change.patch
+#	contrib/emacs/0012-contrib-emacs-vc-git.el-further-improvements.patch
+#	contrib/emacs/ChangeLog
+#	contrib/emacs/ChangeLog~
+#	contrib/emacs/Makefile.orig
+#	contrib/emacs/vc-git.el.BACKUP.17026
+#	contrib/emacs/vc-git.el.BASE.17026
+#	contrib/emacs/vc-git.el.LOCAL.17026
+#	contrib/emacs/vc-git.el.REMOTE.17026
+#	contrib/emacs/vc-git.el.rej
+#	contrib/emacs/vc-git.el.rej~
+#	contrib/emacs/vc-git.el~
+#	svn-commit.tmp~
+#	texput.log
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 91a437d..71b7056 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -44,6 +44,11 @@ INSTALL?=install
 RM ?= rm -f
 DOC_REF = origin/man
 
+infodir?=$(prefix)/share/info
+MAKEINFO=makeinfo
+INSTALL_INFO=install-info
+DOCBOOK2X_TEXI=docbook2x-texi
+
 -include ../config.mak.autogen
 -include ../config.mak
 
@@ -67,6 +72,8 @@ man1: $(DOC_MAN1)
 man5: $(DOC_MAN5)
 man7: $(DOC_MAN7)
 
+info: git.info
+
 install: man
 	$(INSTALL) -d -m755 $(DESTDIR)$(man1dir)
 	$(INSTALL) -d -m755 $(DESTDIR)$(man5dir)
@@ -75,6 +82,14 @@ install: man
 	$(INSTALL) -m644 $(DOC_MAN5) $(DESTDIR)$(man5dir)
 	$(INSTALL) -m644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
 
+install-info: info
+	$(INSTALL) -d -m755 $(DESTDIR)$(infodir)
+	$(INSTALL) -m644 git.info $(DESTDIR)$(infodir)
+	if test -r $(DESTDIR)$(infodir)/dir; then \
+	  $(INSTALL_INFO) --info-dir=$(DESTDIR)$(infodir) git.info ;\
+	else \
+	  echo "No directory found in $(DESTDIR)$(infodir)" >&2 ; \
+	fi
 
 ../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	$(MAKE) -C ../ GIT-VERSION-FILE
@@ -139,6 +154,18 @@ XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 user-manual.html: user-manual.xml
 	xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
 
+git.info: user-manual.xml
+	$(RM) $@ $*.texi
+	$(DOCBOOK2X_TEXI) user-manual.xml --to-stdout | \
+	perl -ne 'if (/^\@setfilename/) {$$_="\@setfilename git.info\
+"} elsif (/^\@direntry/) {print "\@dircategory Development\
+\@direntry\
+* Git: (git).           A fast distributed revision control system\
+\@end direntry\
+"} print unless (/^\@direntry/ .. /^\@end direntry/)' > $*.texi
+	$(MAKEINFO) --no-split $*.texi
+	$(RM) $*.texi
+
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	$(RM) $@+ $@
 	sh ./howto-index.sh $(wildcard howto/*.txt) >$@+
diff --git a/Makefile b/Makefile
index 2f3b9b2..b685c7e 100644
--- a/Makefile
+++ b/Makefile
@@ -913,6 +913,9 @@ perl/Makefile: perl/Git.pm perl/Makefile.PL GIT-CFLAGS
 doc:
 	$(MAKE) -C Documentation all
 
+info:
+	$(MAKE) -C Documentation info
+
 TAGS:
 	$(RM) TAGS
 	$(FIND) . -name '*.[hcS]' -print | xargs etags -a
@@ -1005,6 +1008,9 @@ endif
 install-doc:
 	$(MAKE) -C Documentation install
 
+install-info:
+	$(MAKE) -C Documentation install-info
+
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
-- 
1.5.3.rc4.21.ga63eb
