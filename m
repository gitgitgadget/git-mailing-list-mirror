From: "Dave O'Neill" <dmo@roaringpenguin.com>
Subject: [PATCH] Set correct date for tags.
Date: Wed, 20 Jun 2007 22:15:03 -0400
Message-ID: <11823921031931-git-send-email-dmo@roaringpenguin.com>
Cc: "Dave O'Neill" <dmo@roaringpenguin.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 04:31:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1CS6-0001Ud-6O
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 04:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbXFUCbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 22:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbXFUCbG
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 22:31:06 -0400
Received: from www.roaringpenguin.com ([206.191.13.82]:3969 "EHLO
	www.roaringpenguin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbXFUCbG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 22:31:06 -0400
X-Greylist: delayed 968 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jun 2007 22:31:05 EDT
Received: from magnesium.roaringpenguin.com (ottawa-hs-64-26-171-99.s-ip.magma.ca [64.26.171.99])
	by www.roaringpenguin.com (8.14.1/8.14.0) with ESMTP id l5L2F3Kk001837
	for <git@vger.kernel.org>; Wed, 20 Jun 2007 22:15:03 -0400
Received: from localhost.localdomain (oxygen.roaringpenguin.com [192.168.10.8])
	by magnesium.roaringpenguin.com (8.12.10/8.12.10) with ESMTP id l5L2F3Wo005715;
	Wed, 20 Jun 2007 22:15:03 -0400
X-Mailer: git-send-email 1.5.2.2.239.g89630
X-Scanned-By: CanIt (www . roaringpenguin . com) on 206.191.13.82
X-Scanned-By: MIMEDefang 2.57 on 192.168.10.12
X-Spam-Score: undef - spam scanning disabled
X-CanItPRO-Stream: outgoing (inherits from default)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50582>

Without this, all tags show up as 'unknown' time in gitweb (and probably
elsewhere)
---
 git-svnimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svnimport.perl b/git-svnimport.perl
index 7076f41..9526f3d 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -891,7 +891,7 @@ sub commit {
 		print $out ("object $cid\n".
 		    "type commit\n".
 		    "tag $dest\n".
-		    "tagger $committer_name <$committer_email> 0 +0000\n") and
+		    "tagger $committer_name <$committer_email> $date +0000\n") and
 		close($out)
 		    or die "Cannot create tag object $dest: $!\n";
 
-- 
1.5.2.2.239.g89630
