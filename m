From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 06/10] git p4 test: check for error message in failed test
Date: Wed, 27 Jun 2012 08:00:59 -0400
Message-ID: <1340798463-14499-7-git-send-email-pw@padd.com>
References: <1340798463-14499-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 14:03:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjqxl-0005XQ-FE
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 14:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662Ab2F0MDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 08:03:09 -0400
Received: from honk.padd.com ([74.3.171.149]:52784 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756602Ab2F0MDI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 08:03:08 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id D8254D02;
	Wed, 27 Jun 2012 05:03:07 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 293DC31383; Wed, 27 Jun 2012 08:03:04 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.130.gb957a79
In-Reply-To: <1340798463-14499-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200719>

Make sure the test fails for the expected reason.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4-basic.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 7401c21..84676a1 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -45,7 +45,8 @@ test_expect_success 'git p4 sync uninitialized repo' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		test_must_fail git p4 sync
+		test_must_fail git p4 sync 2>errs &&
+		test_i18ngrep "Perhaps you never did" errs
 	)
 '
 
-- 
1.7.11.1.69.gd505fd2
