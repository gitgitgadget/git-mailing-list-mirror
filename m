From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH] t9001: Fix test prerequisites
Date: Wed, 29 Dec 2010 21:02:31 +0000
Message-ID: <1293656551-5463-1-git-send-email-robbat2@gentoo.org>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 29 22:02:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY3AO-0002lO-Q8
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 22:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab0L2VCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 16:02:35 -0500
Received: from mail.isohunt.com ([208.95.172.20]:50093 "EHLO mail.as30085.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310Ab0L2VCe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 16:02:34 -0500
Received: (qmail 10406 invoked from network); 29 Dec 2010 21:02:33 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.as30085.net (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPS; Wed, 29 Dec 2010 21:02:33 +0000
Received: (qmail 5491 invoked by uid 0); 29 Dec 2010 21:02:31 -0000
X-Mailer: git-send-email 1.7.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164330>

Add in missing Perl prerequisites for new tests of send-email.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 t/t9001-send-email.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 1dc4a92..3271426 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1135,7 +1135,7 @@ test_expect_success $PREREQ '--8bit-encoding also treats subject' '
 # Note that the patches in this test are deliberately out of order; we
 # want to make sure it works even if the cover-letter is not in the
 # first mail.
-test_expect_success 'refusing to send cover letter template' '
+test_expect_success $PREREQ 'refusing to send cover letter template' '
 	clean_fake_sendmail &&
 	rm -fr outdir &&
 	git format-patch --cover-letter -2 -o outdir &&
@@ -1151,7 +1151,7 @@ test_expect_success 'refusing to send cover letter template' '
 	test -z "$(ls msgtxt*)"
 '
 
-test_expect_success '--force sends cover letter template anyway' '
+test_expect_success $PREREQ '--force sends cover letter template anyway' '
 	clean_fake_sendmail &&
 	rm -fr outdir &&
 	git format-patch --cover-letter -2 -o outdir &&
-- 
1.7.3.2
