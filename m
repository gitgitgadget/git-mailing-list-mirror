From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add a few comments about %feature hash
Date: Tue, 15 May 2007 01:55:44 +0200
Message-ID: <11791869442413-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 01:51:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnkJw-0008VP-Rf
	for gcvg-git@gmane.org; Tue, 15 May 2007 01:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbXENXvJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 19:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754830AbXENXvJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 19:51:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:22667 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbXENXvI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 19:51:08 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1459801uga
        for <git@vger.kernel.org>; Mon, 14 May 2007 16:51:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=LwVOuOjwFNMASiWJjkQ5HzV0dSDfSsPFSGGuboI3sMizDo17e+/vIopkSKzmQ+0hgldzyIYPoJrMYGszWVE42XXjLD3wg0lMbuuioX4lTzsfM+cwMIxNKxgpLk7pI+NSq6M0InHdUjprx+t8CqMIpAmqhqH+o89lGvT2M8gXl8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=KYEL8q7RMZk4YzJbHTB1+lXx3XpQVk2QBqQrbdUOVbXHGszPF8NCYmiS6HsOvLiO0M7cLoeZiOpwqti/BLSVwvLUFBHmAAZ+Xq8bidUMiR+iQRRbl//4gNcNHqFGmoGhie8cTwSiUPDQo7NtDsz/HciGWPhlMUbV8ivATom3A4c=
Received: by 10.66.249.16 with SMTP id w16mr5538167ugh.1179186667215;
        Mon, 14 May 2007 16:51:07 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id 55sm14812336ugq.2007.05.14.16.51.05;
        Mon, 14 May 2007 16:51:05 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l4ENtlc6005626;
	Tue, 15 May 2007 01:55:48 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l4ENtjjp005625;
	Tue, 15 May 2007 01:55:45 +0200
X-Mailer: git-send-email 1.5.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47300>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c2eeca9..a13043d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -102,10 +102,13 @@ our %feature = (
 	# 	'override' => allow-override (boolean),
 	# 	'default' => [ default options...] (array reference)}
 	#
-	# if feature is overridable (it means that allow-override has true value,
+	# if feature is overridable (it means that allow-override has true value),
 	# then feature-sub will be called with default options as parameters;
 	# return value of feature-sub indicates if to enable specified feature
 	#
+	# if there is no 'sub' key (no feature-sub), then feature cannot be
+	# overriden
+	#
 	# use gitweb_check_feature(<feature>) to check if <feature> is enabled
 
 	# Enable the 'blame' blob view, showing the last commit that modified
@@ -138,6 +141,7 @@ our %feature = (
 
 	# Enable text search, which will list the commits which match author,
 	# committer or commit text to a given string.  Enabled by default.
+	# Project specific override is not supported.
 	'search' => {
 		'override' => 0,
 		'default' => [1]},
-- 
1.5.1.4
