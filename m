From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCHv6 5/6] gitweb: add documentation to INSTALL regarding gitweb.js
Date: Fri, 02 Apr 2010 20:36:44 -0400
Message-ID: <4BB68D9C.9080303@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 03 02:36:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxrM7-0008A4-Vk
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 02:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079Ab0DCAgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 20:36:52 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:55357 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752913Ab0DCAgu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 20:36:50 -0400
Received: from karakura.local (bas1-toronto01-1177657512.dsl.bell.ca [70.49.160.168])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o330aiwO017585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Apr 2010 20:36:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-UUID: 5fc472c0-5955-4060-a226-c7b13243507f
X-Miltered: at mailchk-m05 with ID 4BB68D9C.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Fri, 02 Apr 2010 20:36:48 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143873>

This patch updates gitweb/INSTALL to mention gitweb.js, including
JavaScript minification support.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>

---

Changes since last revision:
	- Fixed the tabs/spaces issue that Jakub pointed out


 gitweb/INSTALL |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index b75a90b..44ff17d 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -3,8 +3,9 @@ GIT web Interface (gitweb) Installation
 
 First you have to generate gitweb.cgi from gitweb.perl using
 "make gitweb/gitweb.cgi", then copy appropriate files (gitweb.cgi,
-gitweb.css, git-logo.png and git-favicon.png) to their destination.
-For example if git was (or is) installed with /usr prefix, you can do
+gitweb.js, gitweb.css, git-logo.png and git-favicon.png) to their
+destination. For example if git was (or is) installed with /usr prefix,
+you can do
 
 	$ make prefix=/usr gitweb/gitweb.cgi  ;# as yourself
 	# cp gitweb/git* /var/www/cgi-bin/    ;# as root
@@ -62,14 +63,15 @@ file for gitweb (in gitweb/README).
   a suggestion).
 
 - You can control where gitweb tries to find its main CSS style file,
-  its favicon and logo with the GITWEB_CSS, GITWEB_FAVICON and GITWEB_LOGO
-  build configuration variables. By default gitweb tries to find them
-  in the same directory as gitweb.cgi script.
+  its JavaScript file, its favicon and logo with the GITWEB_CSS, GITWEB_JS
+  GITWEB_FAVICON and GITWEB_LOGO build configuration variables. By default
+  gitweb tries to find them in the same directory as gitweb.cgi script.
 
-- You can optionally generate a minified version of gitweb.css by defining
-  the CSSMIN build configuration variable. By default the non-minified
-  version of gitweb.css will be used. NOTE: if you enable this option,
-  substitute gitweb.min.css for all uses of gitweb.css in the help files.
+- You can optionally generate minified versions of gitweb.js and gitweb.css
+  by defining the JSMIN and CSSMIN build configuration variables. By default
+  the non-minified versions will be used. NOTE: if you enable this option,
+  substitute gitweb.min.js and gitweb.min.css for all uses of gitweb.js and
+  gitweb.css in the help files.
 
 Build example
 ~~~~~~~~~~~~~
@@ -79,13 +81,14 @@ Build example
   we want to display are under /home/local/scm, you can do
 
 	make GITWEB_PROJECTROOT="/home/local/scm" \
+	     GITWEB_JS="/gitweb/gitweb.js" \
 	     GITWEB_CSS="/gitweb/gitweb.css" \
 	     GITWEB_LOGO="/gitweb/git-logo.png" \
 	     GITWEB_FAVICON="/gitweb/git-favicon.png" \
 	     bindir=/usr/local/bin \
 	     gitweb/gitweb.cgi
 
-	cp -fv ~/git/gitweb/gitweb.{cgi,css} \
+	cp -fv ~/git/gitweb/gitweb.{cgi,js,css} \
 	       ~/git/gitweb/git-{favicon,logo}.png \
 	     /var/www/cgi-bin/gitweb/
 
-- 
1.7.0.3.519.g7e0613
