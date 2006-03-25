From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/4] send-email: use built-in time() instead of /bin/date '+%s'
Date: Sat, 25 Mar 2006 02:43:31 -0800
Message-ID: <11432834112657-git-send-email-normalperson@yhbt.net>
References: <11432834101430-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git <git@vger.kernel.org>, Ryan Anderson <ryan@michonline.com>,
	Greg KH <greg@kroah.com>, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Mar 25 11:44:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN6Fw-00016M-3z
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 11:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWCYKoB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 05:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWCYKoA
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 05:44:00 -0500
Received: from hand.yhbt.net ([66.150.188.102]:19592 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751161AbWCYKn6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 05:43:58 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E023A7DC021;
	Sat, 25 Mar 2006 02:43:57 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email
In-Reply-To: <11432834101430-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17977>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-send-email.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

079ce058710240643369589448660620cd925f5c
diff --git a/git-send-email.perl b/git-send-email.perl
index efaf457..5e08817 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -264,8 +264,7 @@ my $message_id_template = "<%s-git-send-
 
 sub make_message_id
 {
-	my $date = `date "+\%s"`;
-	chomp($date);
+	my $date = time;
 	my $pseudo_rand = int (rand(4200));
 	$message_id = sprintf $message_id_template, "$date$pseudo_rand";
 	#print "new message id = $message_id\n"; # Was useful for debugging
-- 
1.2.4.gb622a
