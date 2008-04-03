From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [PATCH] Protect current tags, import tags into remote tree
Date: Thu, 3 Apr 2008 12:07:06 +0200
Message-ID: <20080425234556.C9C7A545F@aristoteles.cuci.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 01:46:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpXcv-0004gI-0R
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 01:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761647AbYDYXqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 19:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761537AbYDYXp7
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 19:45:59 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:56102 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758626AbYDYXp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 19:45:58 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id C9C7A545F; Sat, 26 Apr 2008 01:45:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80357>

---
 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 95c5eec..73109d6 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -781,7 +781,7 @@ sub commit {
 		$xtag =~ tr/_/\./ if ( $opt_u );
 		$xtag =~ s/[\/]/$opt_s/g;
 
-		system('git-tag', '-f', $xtag, $cid) == 0
+		system("git-update-ref $remote/tags/$xtag $cid") == 0
 			or die "Cannot create tag $xtag: $!\n";
 
 		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
-- 
1.5.5.1.83.ge77a4.dirty
