From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/4] git-svn: verify_ref() should actually --verify
Date: Thu, 28 Dec 2006 01:16:21 -0800
Message-ID: <1167297385162-git-send-email-normalperson@yhbt.net>
References: <11672973823960-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Dec 28 10:16:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzrNP-0002oO-VN
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 10:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWL1JQ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 04:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWL1JQ2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 04:16:28 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43034 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964969AbWL1JQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 04:16:26 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 502BC7DC094;
	Thu, 28 Dec 2006 01:16:25 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 28 Dec 2006 01:16:25 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.4.3.gd4ada
In-Reply-To: <11672973823960-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35549>

Not sure how I missed this the first time around...

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a772ce8..74a3424 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1098,7 +1098,8 @@ sub read_uuid {
 
 sub verify_ref {
 	my ($ref) = @_;
-	eval { command_oneline([ 'rev-parse', $ref ], { STDERR => 0 }) };
+	eval { command_oneline([ 'rev-parse', '--verify', $ref ],
+	                       { STDERR => 0 }); };
 }
 
 sub repo_path_split {
-- 
1.4.4.3.gd4ada
