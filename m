From: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
Subject: [PATCH] Avoid git-rev-parse warnings in gitweb blame
Date: Tue,  3 Jun 2008 12:14:19 +0200
Message-ID: <1212488060-23251-1-git-send-email-rgarciasuarez@gmail.com>
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 12:15:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3TXo-0002CK-AQ
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 12:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756361AbYFCKOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 06:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756328AbYFCKOK
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 06:14:10 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:46963 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669AbYFCKOI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 06:14:08 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id A17765FE84;
	Tue,  3 Jun 2008 12:14:06 +0200 (CEST)
Received: from localhost.localdomain (inv75-3-82-241-119-67.fbx.proxad.net [82.241.119.67])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 83AC35FE80;
	Tue,  3 Jun 2008 12:14:06 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83633>

Adding a '--' to the command-line avoids git-rev-parse emitting an error
message "ambiguous argument... Use '--' to separate paths from revisions".

Signed-off-by: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 55fb100..472326f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4226,7 +4226,7 @@ HTML
 			              esc_html($rev));
 			print "</td>\n";
 		}
-		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
+		open (my $dd, "-|", git_cmd(), "rev-parse", '--', "$full_rev^")
 			or die_error(undef, "Open git-rev-parse failed");
 		my $parent_commit = <$dd>;
 		close $dd;
-- 
1.5.6.rc1
