From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 2/7] Rename patch_update_file function to patch_update_pathspec
Date: Fri, 23 Nov 2007 20:20:45 +0100
Message-ID: <1195845650-85962-3-git-send-email-win@wincent.com>
References: <1195845650-85962-1-git-send-email-win@wincent.com>
 <1195845650-85962-2-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net,
	Wincent Colaiuta <win@wincent.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 20:21:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ive5j-0007yW-2y
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643AbXKWTVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 14:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755596AbXKWTVM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:21:12 -0500
Received: from wincent.com ([72.3.236.74]:60672 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053AbXKWTVM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 14:21:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lANJKolx018032;
	Fri, 23 Nov 2007 13:20:54 -0600
X-Mailer: git-send-email 1.5.3.6.886.g6e20-dirty
In-Reply-To: <1195845650-85962-2-git-send-email-win@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65909>

The patch_update_file function really works on pathspecs, not files, so
rename it to reflect its actual purpose.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 git-add--interactive.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index fb1e92a..81575e5 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -564,10 +564,10 @@ sub patch_update_cmd {
 				     IMMEDIATE => 1,
 				     HEADER => $status_head, },
 				   @mods);
-	patch_update_file($it->{VALUE}) if ($it);
+	patch_update_pathspec($it->{VALUE}) if ($it);
 }
 
-sub patch_update_file {
+sub patch_update_pathspec {
 	my ($ix, $num);
 	my $path = shift;
 	my ($head, @hunk) = parse_diff($path);
-- 
1.5.3.6.886.g3364
