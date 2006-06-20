From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: add '/' to the end of filename in page title for trees
Date: Tue, 20 Jun 2006 06:17:04 +0000 (UTC)
Message-ID: <1150784206793-git-send-email-jnareb@gmail.com>
References: <11507842053885-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 20 08:17:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsZXo-0005s8-TT
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 08:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWFTGQw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 02:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbWFTGQv
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 02:16:51 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:51073 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S965077AbWFTGQu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 02:16:50 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k5K6GRia018471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Jun 2006 08:16:27 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k5K6Gkpu001835;
	Tue, 20 Jun 2006 08:16:46 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k5K6Gk2j001834;
	Tue, 20 Jun 2006 08:16:46 +0200
To: git@vger.kernel.org
Date: wto, 20 cze 2006 08:16:45 +0200
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11507842053885-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22171>

---

 gitweb/gitweb.cgi |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

d17c119d32ae4c5dd50976ea6a255d2bcbe480ed
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 1e1a044..42f3296 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -263,6 +263,9 @@ sub git_header_html {
 			$title .= "/$action";
 			if (defined $file_name) {
 				$title .= " - $file_name";
+				if ($action eq "tree" && $file_name !~ m|/$|) {
+					$title .= "/";
+				}
 			}
 		}
 	}
-- 
1.3.0
