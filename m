From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/7] gitweb: Improve comments about gitweb features configuration
Date: Sat, 26 Aug 2006 19:14:22 +0200
Message-ID: <11566124672096-git-send-email-jnareb@gmail.com>
References: <1156612392716-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 26 19:14:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH1jw-0003zu-Vm
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 19:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWHZROd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 13:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422879AbWHZROc
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 13:14:32 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:32646 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S964802AbWHZROc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 13:14:32 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7QHDFFZ004444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Aug 2006 19:13:15 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7QHERIU032735;
	Sat, 26 Aug 2006 19:14:27 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7QHERvU032734;
	Sat, 26 Aug 2006 19:14:27 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <1156612392716-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26053>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index df2f9e5..c29ffa8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -67,9 +67,16 @@ our $mimetypes_file = undef;
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
-	# feature => {'sub' => feature-sub, 'override' => allow-override, 'default' => [ default options...]
-	# if feature is overridable, feature-sub will be called with default options;
-	# return value indicates if to enable specified feature
+	# feature => {
+	# 	'sub' => feature-sub (subroutine),
+	# 	'override' => allow-override (boolean),
+	# 	'default' => [ default options...] (array reference)}
+	#
+	# if feature is overridable (it means that allow-override has true value,
+	# then feature-sub will be called with default options as parameters;
+	# return value of feature-sub indicates if to enable specified feature
+	#
+	# use gitweb_check_feature(<feature>) to check if <feature> is enabled
 
 	'blame' => {
 		'sub' => \&feature_blame,
@@ -95,9 +102,9 @@ sub gitweb_check_feature {
 }
 
 # To enable system wide have in $GITWEB_CONFIG
-# $feature{'blame'}{'default'} =  [1];
-# To have project specific config enable override in  $GITWEB_CONFIG
-# $feature{'blame'}{'override'} =  1;
+# $feature{'blame'}{'default'} = [1];
+# To have project specific config enable override in $GITWEB_CONFIG
+# $feature{'blame'}{'override'} = 1;
 # and in project config gitweb.blame = 0|1;
 
 sub feature_blame {
@@ -113,9 +120,9 @@ sub feature_blame {
 }
 
 # To disable system wide have in $GITWEB_CONFIG
-# $feature{'snapshot'}{'default'} =  [undef];
-# To have project specific config enable override in  $GITWEB_CONFIG
-# $feature{'blame'}{'override'} =  1;
+# $feature{'snapshot'}{'default'} = [undef];
+# To have project specific config enable override in $GITWEB_CONFIG
+# $feature{'blame'}{'override'} = 1;
 # and in project config  gitweb.snapshot = none|gzip|bzip2
 
 sub feature_snapshot {
-- 
1.4.1.1
