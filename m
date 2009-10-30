From: Jeff King <peff@peff.net>
Subject: [PATCH] t915{0,1}: use $TEST_DIRECTORY
Date: Fri, 30 Oct 2009 16:10:17 -0400
Message-ID: <20091030201017.GA26465@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 21:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xnr-0000M7-HK
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 21:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbZJ3UKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 16:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757223AbZJ3UKV
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 16:10:21 -0400
Received: from peff.net ([208.65.91.99]:36256 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756885AbZJ3UKU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 16:10:20 -0400
Received: (qmail 3058 invoked by uid 107); 30 Oct 2009 20:14:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 16:14:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 16:10:17 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131747>

Because --root can put our trash directories elsewhere,
using ".." may not always work.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9150-svk-mergetickets.sh |    3 ++-
 t/t9151-svn-mergeinfo.sh    |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t9150-svk-mergetickets.sh b/t/t9150-svk-mergetickets.sh
index 8000c34..dd0c2ba 100644
--- a/t/t9150-svk-mergetickets.sh
+++ b/t/t9150-svk-mergetickets.sh
@@ -8,7 +8,8 @@ test_description='git-svn svk merge tickets'
 . ./lib-git-svn.sh
 
 test_expect_success 'load svk depot' "
-	svnadmin load -q '$rawsvnrepo' < '../t9150/svk-merge.dump' &&
+	svnadmin load -q '$rawsvnrepo' \
+	  < '$TEST_DIRECTORY/t9150/svk-merge.dump' &&
 	git svn init --minimize-url -R svkmerge \
 	  -T trunk -b branches '$svnrepo' &&
 	git svn fetch --all
diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
index 7eb36e5..9bee516 100644
--- a/t/t9151-svn-mergeinfo.sh
+++ b/t/t9151-svn-mergeinfo.sh
@@ -8,7 +8,8 @@ test_description='git-svn svn mergeinfo properties'
 . ./lib-git-svn.sh
 
 test_expect_success 'load svn dump' "
-	svnadmin load -q '$rawsvnrepo' < '../t9151/svn-mergeinfo.dump' &&
+	svnadmin load -q '$rawsvnrepo' \
+	  < '$TEST_DIRECTORY/t9151/svn-mergeinfo.dump' &&
 	git svn init --minimize-url -R svnmerge \
 	  -T trunk -b branches '$svnrepo' &&
 	git svn fetch --all
-- 
1.6.5.2.224.g22719.dirty
