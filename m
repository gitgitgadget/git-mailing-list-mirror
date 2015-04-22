From: Jeff King <peff@peff.net>
Subject: [PATCH] test-lib: turn on GIT_TEST_CHAIN_LINT by default
Date: Wed, 22 Apr 2015 16:09:57 -0400
Message-ID: <20150422200956.GA29282@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 22:10:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0yE-0001ik-N7
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 22:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbbDVUKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 16:10:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:48825 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750747AbbDVUJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 16:09:59 -0400
Received: (qmail 14512 invoked by uid 102); 22 Apr 2015 20:09:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 15:09:59 -0500
Received: (qmail 13684 invoked by uid 107); 22 Apr 2015 20:10:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 16:10:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 16:09:57 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267632>

Now that the feature has had time to prove itself, and any
topics in flight have had a chance to clean up any broken
&&-chains, we can flip this feature on by default. This
makes one less thing submitters need to configure or check
before sending their patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4ea99a2..39da9c2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -529,7 +529,7 @@ test_run_ () {
 	test_cleanup=:
 	expecting_failure=$2
 
-	if test "${GIT_TEST_CHAIN_LINT:-0}" != 0; then
+	if test "${GIT_TEST_CHAIN_LINT:-1}" != 0; then
 		# 117 is magic because it is unlikely to match the exit
 		# code of other programs
 		test_eval_ "(exit 117) && $1"
-- 
2.4.0.rc2.498.g02440db
