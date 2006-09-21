From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: fix display of trees via PATH_INFO.
Date: Thu, 21 Sep 2006 09:48:21 +0200
Message-ID: <20060921074821.GG31940@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 21 09:48:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQJIH-0004tx-O9
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 09:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWIUHsW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 03:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWIUHsW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 03:48:22 -0400
Received: from agent.admingilde.org ([213.95.21.5]:8426 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1751006AbWIUHsW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 03:48:22 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GQJID-0001mz-8U
	for git@vger.kernel.org; Thu, 21 Sep 2006 09:48:21 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27464>

When adding a / to the URL, git should display the corresponding
tree object, but it has to remove the / first.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index baadbe7..ea57717 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -300,6 +300,7 @@ sub evaluate_path_info {
 		$pathname =~ s,^/+,,;
 		if (!$pathname || substr($pathname, -1) eq "/") {
 			$action  ||= "tree";
+			$pathname =~ s,/$,,;
 		} else {
 			$action  ||= "blob_plain";
 		}
-- 
1.4.2.gb8b6b

-- 
Martin Waitz
