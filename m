From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH] gitweb: readme fixed regarding per user project root repository
Date: Mon, 22 Mar 2010 23:15:30 +0100
Message-ID: <1269296130-2237-2-git-send-email-sylvain@abstraction.fr>
References: <1269296130-2237-1-git-send-email-sylvain@abstraction.fr>
Cc: Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 23:16:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntput-0002c0-IT
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 23:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460Ab0CVWQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 18:16:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:7143 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755765Ab0CVWP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 18:15:59 -0400
Received: by fg-out-1718.google.com with SMTP id l26so691654fgb.1
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 15:15:58 -0700 (PDT)
Received: by 10.204.23.6 with SMTP id p6mr4684291bkb.67.1269296155100;
        Mon, 22 Mar 2010 15:15:55 -0700 (PDT)
Received: from localhost.localdomain (smj33-1-82-233-66-33.fbx.proxad.net [82.233.66.33])
        by mx.google.com with ESMTPS id 24sm21285403bkr.12.2010.03.22.15.15.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 15:15:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3
In-Reply-To: <1269296130-2237-1-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142972>

+ the RewriteRule '/+<user>' is not working as the '+' character is
  replaced by a space in urls when you click on links. it is replaced by '/u/<user>'
+ the RewriteRule '/user/<user>' updated to allow
  '/user/<user>', '/user/<user>/' and '/user/<user>/gitweb.cgi'
+ some typos fixed

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 gitweb/README |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index ad6a04c..bc90f4d 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -347,18 +347,18 @@ something like the following in your gitweb.conf (or gitweb_config.perl) file:
   $home_link = "/";
 
 
-Webserver configuration with multiple projects' root
-----------------------------------------------------
+Webserver configuration with multiple project roots
+---------------------------------------------------
 
-If you want to use gitweb with several project roots you can edit your apache
-virtual host and gitweb.conf configuration files like this :
+If you want to use gitweb with several project roots then you can edit your
+apache virtual host and gitweb.conf configuration files like this :
 
 virtual host configuration :
 
 <VirtualHost *:80>
-    ServerName			git.example.org
-    DocumentRoot		/pub/git
-    SetEnv				GITWEB_CONFIG	/etc/gitweb.conf
+    ServerName		git.example.org
+    DocumentRoot	/pub/git
+    SetEnv		GITWEB_CONFIG	/etc/gitweb.conf
 
     # turning on mod rewrite
     RewriteEngine on
@@ -368,13 +368,13 @@ virtual host configuration :
 
     # look for a public_git folder in unix users' home
     # http://git.example.org/~<user>/
-    RewriteRule ^/\~([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
+    RewriteRule ^/\~([^\/]+)(/|/gitweb.cgi)?$		/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
 
-    # http://git.example.org/+<user>/
-    #RewriteRule ^/\+([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
+    # http://git.example.org/u/<user>/
+    #RewriteRule ^/\+([^\/]+)(/|/gitweb.cgi)?$		/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
 
     # http://git.example.org/user/<user>/
-    #RewriteRule ^/user/([^\/]+)/(gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
+    #RewriteRule ^/user/([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
 
     # defined list of project roots
     RewriteRule ^/scm(/|/gitweb.cgi)?$		/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/pub/scm/,L,PT]
-- 
1.7.0.3
