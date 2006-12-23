From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 2/3] gitweb: Require a minimum of two character for the search text.
Date: Sat, 23 Dec 2006 03:35:15 +0000
Message-ID: <11668449271631-git-send-email-robfitz@273k.net>
References: <11668449162618-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sat Dec 23 04:35:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxxfW-0002GM-NE
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 04:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbWLWDfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 22:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbWLWDfX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 22:35:23 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:59444 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbWLWDfW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 22:35:22 -0500
Received: from [194.125.99.166] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GxxfA-00061b-Kx; Sat, 23 Dec 2006 03:35:08 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.gae7ae3
In-Reply-To: <11668449162618-git-send-email-robfitz@273k.net>
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35258>


Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---
 gitweb/gitweb.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cc6bd0c..6778b24 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -351,6 +351,9 @@ if (defined $searchtext) {
 	if ($searchtext =~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/) {
 		die_error(undef, "Invalid search parameter");
 	}
+ 	if (length($searchtext) < 2) {
+		die_error(undef, "At least two characters are required for search parameter");
+	}
 	$searchtext = quotemeta $searchtext;
 }
 
-- 
1.4.4.3.gae7ae3
