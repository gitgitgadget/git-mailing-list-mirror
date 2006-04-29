From: Huw Davies <huw@codeweavers.com>
Subject: [PATCH] git-format-patch: Use rfc2822 compliant date.
Date: Sat, 29 Apr 2006 15:50:28 +0000 (UTC)
Message-ID: <S1750753AbWD2PuQ/20060429155016Z+1890@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 29 17:50:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZri9-0004jE-OT
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 17:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWD2PuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 11:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWD2PuQ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 11:50:16 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:16020 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1750750AbWD2PuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 11:50:15 -0400
Received: from vineyard.dyndns.org ([82.152.46.94])
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FZri2-0007IJ-5E
	for git@vger.kernel.org; Sat, 29 Apr 2006 10:50:15 -0500
Received: from daviesh by vineyard.dyndns.org with local (Exim 4.60)
	(envelope-from <huw@codeweavers.com>)
	id 1FZrhV-0000Yc-Uh
	for git@vger.kernel.org; Sat, 29 Apr 2006 16:49:41 +0100
Date: Sat Apr 29 15:55:01 2006 +0100
Apparently-To: <huw@codeweavers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19307>

Signed-off-by: Huw Davies <huw@codeweavers.com>


---

 git-format-patch.sh |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

fa12b0e43a0559101551d697866c01a92778c67f
diff --git a/git-format-patch.sh b/git-format-patch.sh
index c7133bc..c077f44 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -205,11 +205,10 @@ sub show_date {
     }
     my $t = $time + $minutes * 60;
     my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday) = gmtime($t);
-    return sprintf("%s %s %d %02d:%02d:%02d %d %+05d",
-		   $weekday_names[$wday],
-		   $month_names[$mon],
-		   $mday, $hour, $min, $sec,
-		   $year+1900, $tz);
+    return sprintf("%s, %d %s %d %02d:%02d:%02d %+05d",
+		   $weekday_names[$wday], $mday,
+		   $month_names[$mon], $year+1900,
+		   $hour, $min, $sec, $tz);
 }
 
 print "From nobody Mon Sep 17 00:00:00 2001\n";
-- 
1.3.0
