From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 1/4] gitweb: Add missing show '...' links change.
Date: Fri, 22 Dec 2006 19:38:12 +0000
Message-ID: <11668162961084-git-send-email-robfitz@273k.net>
References: 200612191214.58474.jnareb@gmail.com <11668162952375-git-send-email-robfitz@273k.net>
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Fri Dec 22 20:39:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxqEX-0003L4-M7
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 20:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbWLVTjA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 14:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752405AbWLVTjA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 14:39:00 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:35572 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbWLVTi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 14:38:59 -0500
Received: from [194.125.117.173] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GxqDG-0005my-Qv; Fri, 22 Dec 2006 19:37:50 +0000
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.4.3.g8aca-dirty
In-Reply-To: <11668162952375-git-send-email-robfitz@273k.net>
Message-Id: <8edd09bf9114df40281e7527df8704b1a94bb280.1166813858.git.robfitz@273k.net>
In-Reply-To: <20061218224327.GG16029@localhost>
References: <20061218224327.GG16029@localhost>
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-2, required 7, autolearn=disabled,
	RCVD_IN_NERDS_IE -2.00)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Part of the patch for "gitweb: Show '...' links in "summary" view only
if there are more items" (313ce8cee665447e4476d7e8985b270346a8e5a1) is
missing.  Add it back in.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>
---


With all the tooing and frowing this part of the original patch got
lost.  I'm also resubmiting the original optimizations patches with a
few changes.

Robert



 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ebbc397..80c04b8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2983,6 +2983,7 @@ sub git_summary {
 	if (@forklist) {
 		git_print_header_div('forks');
 		git_project_list_body(\@forklist, undef, 0, 15,
+		                      $#forklist <= 15 ? undef :
 		                      $cgi->a({-href => href(action=>"forks")}, "..."),
 				      'noheader');
 	}
-- 
1.4.4.3.gc902c
