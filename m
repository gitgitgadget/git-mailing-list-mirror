From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/19] git-check-attr: Add tests of command-line parsing
Date: Thu, 28 Jul 2011 06:46:45 +0200
Message-ID: <1311828418-2676-7-git-send-email-mhagger@alum.mit.edu>
References: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 28 06:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIVa-0005eI-AM
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465Ab1G1Erd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:47:33 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:57266 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab1G1ErW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:47:22 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmITD-000889-DZ; Thu, 28 Jul 2011 06:45:15 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178021>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0003-attributes.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index dae76b3..f1debeb 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -44,6 +44,13 @@ test_expect_success 'setup' '
 
 test_expect_success 'command line checks' '
 
+	test_must_fail git check-attr &&
+	test_must_fail git check-attr -- &&
+	test_must_fail git check-attr -- f &&
+	echo "f" | test_must_fail git check-attr --stdin &&
+	echo "f" | test_must_fail git check-attr --stdin -- f &&
+	echo "f" | test_must_fail git check-attr --stdin test -- f &&
+	echo "f" | test_must_fail git check-attr --stdin test f &&
 	test_must_fail git check-attr "" -- f
 
 '
-- 
1.7.6.8.gd2879
