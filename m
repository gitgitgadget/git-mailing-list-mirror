From: Ingmar Vanhassel <ingmar@exherbo.org>
Subject: [PATCH] import-tars: Add missing closing bracket
Date: Fri,  9 Oct 2009 14:08:31 +0200
Message-ID: <1255090111-32612-1-git-send-email-ingmar@exherbo.org>
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Junio C Hamano <gitster@pobox.com>,
	Ingmar Vanhassel <ingmar@exherbo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 14:41:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwEmr-000103-8O
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 14:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbZJIMju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 08:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbZJIMju
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 08:39:50 -0400
Received: from bach.exherbo.org ([78.47.197.147]:34379 "EHLO bach.exherbo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbZJIMjt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 08:39:49 -0400
X-Greylist: delayed 1821 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2009 08:39:49 EDT
Received: from [83.101.72.69] (helo=localhost)
	by bach.exherbo.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <ingmar@exherbo.org>)
	id 1MwEH8-0000Dk-RJ; Fri, 09 Oct 2009 12:08:47 +0000
X-Mailer: git-send-email 1.6.5.rc3.193.gdf7a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129796>

This fixes an obvious syntax error that snuck in commit 7e787953:

syntax error at /home/ingmar/bin//git-import-tars line 143, near "/^$/ { "
syntax error at /home/ingmar/bin//git-import-tars line 145, near "} else"
syntax error at /home/ingmar/bin//git-import-tars line 152, near "}"

Signed-off-by: Ingmar Vanhassel <ingmar@exherbo.org>
---
 contrib/fast-import/import-tars.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index a909716..7001862 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -140,7 +140,7 @@ foreach my $tar_file (@ARGV)
 				} elsif (!$header_done && /^Author:\s+([^<>]*)\s+<(.*)>\s*$/i) {
 					$this_author_name = $1;
 					$this_author_email = $2;
-				} elsif (!$header_done && /^$/ { # empty line ends header.
+				} elsif (!$header_done && /^$/) { # empty line ends header.
 					$header_done = 1;
 				} else {
 					$commit_msg .= $_;
-- 
1.6.5.rc3.193.gdf7a
