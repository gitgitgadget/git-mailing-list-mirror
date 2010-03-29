From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH 2/2] gitweb: readme fixed regarding per user project root repository
Date: Tue, 30 Mar 2010 00:34:03 +0200
Message-ID: <1269902043-11134-3-git-send-email-sylvain@abstraction.fr>
References: <7v39zmnceq.fsf@alter.siamese.dyndns.org>
 <1269902043-11134-1-git-send-email-sylvain@abstraction.fr>
 <1269902043-11134-2-git-send-email-sylvain@abstraction.fr>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 30 00:34:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwNXB-0004cr-SO
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 00:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab0C2WeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 18:34:10 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:35460 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110Ab0C2WeI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 18:34:08 -0400
Received: by mail-bw0-f209.google.com with SMTP id 1so3962624bwz.21
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 15:34:08 -0700 (PDT)
Received: by 10.204.6.23 with SMTP id 23mr5718939bkx.179.1269902047626;
        Mon, 29 Mar 2010 15:34:07 -0700 (PDT)
Received: from localhost.localdomain (smj33-1-82-233-66-33.fbx.proxad.net [82.233.66.33])
        by mx.google.com with ESMTPS id a11sm41874051bkc.21.2010.03.29.15.34.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 15:34:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3
In-Reply-To: <1269902043-11134-2-git-send-email-sylvain@abstraction.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143523>

- the rewrite rules '/user/<user>' and '/+<user>' have been updated to also allow
  '/user/<user>/', '/user/<user>/gitweb.cgi', '/+<user>/' and '/+<user>/gitweb.cgi'
- some typos fixed

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 gitweb/README |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index ad6a04c..63e5f2e 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -347,38 +347,38 @@ something like the following in your gitweb.conf (or gitweb_config.perl) file:
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
 
     # make the front page an internal rewrite to the gitweb script
-    RewriteRule ^/$ 		/cgi-bin/gitweb.cgi [QSA,L,PT]
+    RewriteRule ^/$					/cgi-bin/gitweb.cgi [QSA,L,PT]
 
     # look for a public_git folder in unix users' home
     # http://git.example.org/~<user>/
-    RewriteRule ^/\~([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
+    RewriteRule ^/\~([^\/]+)(/|/gitweb.cgi)?$		/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
 
     # http://git.example.org/+<user>/
-    #RewriteRule ^/\+([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
+    #RewriteRule ^/\+([^\/]+)(/|/gitweb.cgi)?$		/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
 
     # http://git.example.org/user/<user>/
-    #RewriteRule ^/user/([^\/]+)/(gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
+    #RewriteRule ^/user/([^\/]+)(/|/gitweb.cgi)?$	/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/home/$1/public_git/,L,PT]
 
     # defined list of project roots
-    RewriteRule ^/scm(/|/gitweb.cgi)?$		/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/pub/scm/,L,PT]
-    RewriteRule ^/var(/|/gitweb.cgi)?$		/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/var/git/,L,PT]
+    RewriteRule ^/scm(/|/gitweb.cgi)?$			/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/pub/scm/,L,PT]
+    RewriteRule ^/var(/|/gitweb.cgi)?$			/cgi-bin/gitweb.cgi [QSA,E=GITWEB_PROJECTROOT:/var/git/,L,PT]
 
     # make access for "dumb clients" work
     RewriteRule ^/(.*\.git/(?!/?(HEAD|info|objects|refs)).*)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
-- 
1.7.0.3
