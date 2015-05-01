From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 17/18] ref_transaction_commit(): delete extra "the" from error message
Date: Fri,  1 May 2015 14:25:57 +0200
Message-ID: <1430483158-14349-18-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:26:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA1p-0001As-ND
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbbEAM0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:40 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:54459 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753618AbbEAM0c (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:32 -0400
X-AuditID: 12074412-f79e46d0000036b4-a8-554370f7f191
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 16.9C.14004.7F073455; Fri,  1 May 2015 08:26:31 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zu004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:30 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqPu9wDnU4PRURYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ+xcvIit4IB8xfP/vcwNjL2SXYycHBICJhKfDq9lgrDFJC7cW8/WxcjFISRwmVFiw/o+
	ZgjnBJPE8msHWUCq2AR0JRb1NIN1iAioSUxsO8QCUsQs0MEocWH5NnaQhLBAmMSZ5SvBGlgE
	VCWuTH7BCmLzCrhKrPv7lA1inZzE+eM/gTZwcHACxb9MTQQJCwm4SNz//pVtAiPvAkaGVYxy
	iTmlubq5iZk5xanJusXJiXl5qUW6Znq5mSV6qSmlmxghISW0g3H9SblDjAIcjEo8vBuOOYUK
	sSaWFVfmHmKU5GBSEuW1TXAOFeJLyk+pzEgszogvKs1JLT7EKMHBrCTCe08dKMebklhZlVqU
	D5OS5mBREuf9uVjdT0ggPbEkNTs1tSC1CCYrw8GhJMH7Kx+oUbAoNT21Ii0zpwQhzcTBCTKc
	S0qkODUvJbUosbQkIx4UG/HFwOgASfEA7V0G0s5bXJCYCxSFaD3FqCglznsCJCEAksgozYMb
	C0sUrxjFgb4U5mUFpg0hHmCSget+BTSYCWjw+VsOIINLEhFSUg2MLBOKEncc074dpDfz2qzt
	4nO3GTardpW3yFmceK57Yh1L+7u2kmYeDluRrgo2qZV7BSeZpP7cqpN9W3FjTnbwnxuqW4wX
	m9ms3l1f/Ez/0vPfisvSJjWoOfAUam8R/ezH7VnMKLs30CK/70n1H/5vtbOe11xx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268123>

While we are in the area, let's remove a superfluous definite article
from the error message that is emitted when the reference cannot be
locked. This improves how it reads and makes it a bit shorter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                |  2 +-
 t/t1400-update-ref.sh | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 2d0d8bd..f64f6ae 100644
--- a/refs.c
+++ b/refs.c
@@ -3836,7 +3836,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				? TRANSACTION_NAME_CONFLICT
 				: TRANSACTION_GENERIC_ERROR;
 			reason = strbuf_detach(err, NULL);
-			strbuf_addf(err, "Cannot lock the ref '%s': %s",
+			strbuf_addf(err, "Cannot lock ref '%s': %s",
 				    update->refname, reason);
 			goto cleanup;
 		}
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 636d3a1..ba89f4c 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -519,7 +519,7 @@ test_expect_success 'stdin create ref works with path with space to blob' '
 test_expect_success 'stdin update ref fails with wrong old value' '
 	echo "update $c $m $m~1" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	grep "fatal: Cannot lock ref '"'"'$c'"'"'" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -555,7 +555,7 @@ test_expect_success 'stdin update ref works with right old value' '
 test_expect_success 'stdin delete ref fails with wrong old value' '
 	echo "delete $a $m~1" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock the ref '"'"'$a'"'"'" err &&
+	grep "fatal: Cannot lock ref '"'"'$a'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -688,7 +688,7 @@ test_expect_success 'stdin update refs fails with wrong old value' '
 	update $c  ''
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	grep "fatal: Cannot lock ref '"'"'$c'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual &&
@@ -883,7 +883,7 @@ test_expect_success 'stdin -z create ref works with path with space to blob' '
 test_expect_success 'stdin -z update ref fails with wrong old value' '
 	printf $F "update $c" "$m" "$m~1" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	grep "fatal: Cannot lock ref '"'"'$c'"'"'" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -899,7 +899,7 @@ test_expect_success 'stdin -z create ref fails when ref exists' '
 	git rev-parse "$c" >expect &&
 	printf $F "create $c" "$m~1" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	grep "fatal: Cannot lock ref '"'"'$c'"'"'" err &&
 	git rev-parse "$c" >actual &&
 	test_cmp expect actual
 '
@@ -930,7 +930,7 @@ test_expect_success 'stdin -z update ref works with right old value' '
 test_expect_success 'stdin -z delete ref fails with wrong old value' '
 	printf $F "delete $a" "$m~1" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock the ref '"'"'$a'"'"'" err &&
+	grep "fatal: Cannot lock ref '"'"'$a'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -1045,7 +1045,7 @@ test_expect_success 'stdin -z update refs fails with wrong old value' '
 	git update-ref $c $m &&
 	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "$m" "$Z" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock the ref '"'"'$c'"'"'" err &&
+	grep "fatal: Cannot lock ref '"'"'$c'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual &&
-- 
2.1.4
