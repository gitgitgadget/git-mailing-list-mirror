From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: [PATH] sed -e '/RE/r rfile/' needs space in 'r rfile'
Date: Sat, 8 Jul 2006 17:27:10 +0200
Organization: NextSoft
Message-ID: <200607081727.10837.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Jul 08 17:27:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzEiE-0006ZE-1I
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 17:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWGHP1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 8 Jul 2006 11:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWGHP1P
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 11:27:15 -0400
Received: from s3.icr.cz ([82.142.72.7]:50635 "EHLO s3.icr.cz")
	by vger.kernel.org with ESMTP id S964863AbWGHP1O convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 11:27:14 -0400
Received: (from root@localhost)
	by s3.icr.cz (8.11.4/8.11.4) id k68FRCf20803
	for git@vger.kernel.org; Sat, 8 Jul 2006 17:27:12 +0200
Received: from michal.rokos.cz (mx1.evangnet.cz [88.83.237.35] (may be forged))
	by s3.icr.cz (8.11.4/8.11.4) with ESMTP id k68FRBS20763
	for <git@vger.kernel.org>; Sat, 8 Jul 2006 17:27:11 +0200
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
X-scanner: scanned by Inflex 1.0.10 - (http://pldaniels.com/inflex/)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23487>

Johannes,

in commit 07002287f3e219a16a948a8a6eca0a41162a491f
you cleaned up 'replace ugly and unportable sed invocation' as you said=
=2E
Please note, that some SEDs (like HP-UX one) mandate a space between 'r=
'=20
and 'rfile'.

Michal

Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>

diff --git a/Makefile b/Makefile
index 202f261..8f9881f 100644
--- a/Makefile
+++ b/Makefile
@@ -552,9 +553,9 @@ git-instaweb: git-instaweb.sh gitweb/git
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    -e 's/@@NO_PYTHON@@/$(NO_PYTHON)/g' \
-	    -e '/@@GITWEB_CGI@@/rgitweb/gitweb.cgi' \
+	    -e '/@@GITWEB_CGI@@/r gitweb/gitweb.cgi' \
 	    -e '/@@GITWEB_CGI@@/d' \
-	    -e '/@@GITWEB_CSS@@/rgitweb/gitweb.css' \
+	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
 	    $@.sh > $@+
 	chmod +x $@+

--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
