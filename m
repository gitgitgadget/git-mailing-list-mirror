From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: support for / as home_link.
Date: Thu, 17 Aug 2006 00:28:39 +0200
Message-ID: <11557673263081-git-send-email-tali@admingilde.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <11557673212235-git-send-email-tali@admingilde.org> <1155767325181-git-send-email-tali@admingilde.org>
Cc: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 00:29:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDTss-0000AM-3G
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 00:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWHPW2t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 18:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWHPW2t
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 18:28:49 -0400
Received: from agent.admingilde.org ([213.95.21.5]:13000 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932295AbWHPW2s
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 18:28:48 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GDTsU-0007OY-8W; Thu, 17 Aug 2006 00:28:46 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.rc2.gf055
In-Reply-To: <1155767325181-git-send-email-tali@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25534>

If the webserver is configured to use gitweb even for the root directory
of the site, then my_uri is empty which leads to a non-functional home
link.  Fix that by defaulting to "/" in this case.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a022569..0a0b37f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -34,7 +34,7 @@ # location for temporary files needed fo
 our $git_temp = "/tmp/gitweb";
 
 # target of the home link on top of all pages
-our $home_link = $my_uri;
+our $home_link = $my_uri || "/";
 
 # string of the home link on top of all pages
 our $home_link_str = "++GITWEB_HOME_LINK_STR++";
-- 
1.4.2.rc2.gf055
