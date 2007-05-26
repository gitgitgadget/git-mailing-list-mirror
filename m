From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: [PATCH] move template_dir logic to configure script.
Date: Sat, 26 May 2007 20:07:28 -0300
Message-ID: <4658BDB0.9040501@xs4all.nl>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 01:15:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs5UB-0002rO-11
	for gcvg-git@gmane.org; Sun, 27 May 2007 01:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXEZXPl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 19:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbXEZXPl
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 19:15:41 -0400
Received: from main.gmane.org ([80.91.229.2]:39937 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbXEZXPk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 19:15:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hs5PR-0002I8-HY
	for git@vger.kernel.org; Sun, 27 May 2007 01:10:54 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 May 2007 01:10:53 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 27 May 2007 01:10:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48505>


---
 config.mak.in |    2 +-
 configure.ac  |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 9a57840..12a541f 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -12,7 +12,7 @@ exec_prefix = @exec_prefix@
 bindir = @bindir@
 #gitexecdir = @libexecdir@/git-core/
 datarootdir = @datarootdir@
-template_dir = @datadir@/git-core/templates/
+template_dir = @template_dir@
 
 mandir=@mandir@
 
diff --git a/configure.ac b/configure.ac
index 7cfb3a0..d1622a6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -323,6 +323,12 @@ GIT_PARSE_WITH(iconv))
 # change being considered an inode change from the update-cache perspective.
 
 
+
+AC_SUBST(template_dir)
+if test "$template_dir" = ""; then
+  template_dir='${datadir}/git-core/templates/'
+fi
+
 ## Output files
 AC_CONFIG_FILES(["${config_file}":"${config_in}":"${config_append}"])
 AC_OUTPUT
-- 
1.5.0.6


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
