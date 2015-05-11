From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/18] ref_transaction_commit(): delete extra "the" from error message
Date: Mon, 11 May 2015 17:25:19 +0200
Message-ID: <1431357920-25090-18-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:26:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrpay-0002iU-TG
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbbEKP0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:26:13 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48239 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754404AbbEKPZ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:59 -0400
X-AuditID: 12074412-f79e46d0000036b4-7a-5550ca07c642
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id EF.B7.14004.70AC0555; Mon, 11 May 2015 11:25:59 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnT002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:58 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqMt+KiDUYMouWYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWizNvGhkd2Dz+vv/A5LFgU6nHs949jB4XLyl7LH7g5fF5k1wAWxS3
	TVJiSVlwZnqevl0Cd8aPpV4FZ+UrOp8+Y29gnCnZxcjBISFgItF9SKmLkRPIFJO4cG89Wxcj
	F4eQwGVGieZ5T5ghnONMEr3Nh1hBqtgEdCUW9TQzgdgiAmoSE9sOsYAUMQvsYpS4t3QqC0hC
	WCBS4szEC4wgG1gEVCXmXPUFCfMKuAKFlzNCbJOTOH/8JzOIzQkUX3r1MlirkICLRNPjeywT
	GHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI108vNLNFLTSndxAgJMKEdjOtPyh1iFOBg
	VOLhNbjgHyrEmlhWXJl7iFGSg0lJlPfX3oBQIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8ymuA
	crwpiZVVqUX5MClpDhYlcd6fi9X9hATSE0tSs1NTC1KLYLIyHBxKErxvTgA1ChalpqdWpGXm
	lCCkmTg4QYZzSYkUp+alpBYllpZkxIPiIr4YGBkgKR6gvV9B2nmLCxJzgaIQracYFaXEee+B
	JARAEhmleXBjYWnjFaM40JfCvB9BqniAKQeu+xXQYCagwY5xYINLEhFSUg2M80z3rNoZZrg2
	bxODvl/7rNNVwfOyGFPeyx3Oe/eUvXaDdN3VaJFMrg8pDps5/J4H1Px9ZvL+cMGUv5f/3u0L
	NPLjN33zROvHp9zDrdZMjJ+YnvzU33Vu8QRNo6sXRHhvl8dpJR1rPNVX/nsX94Z2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268789>

While we are in the area, let's remove a superfluous definite article
from the error message that is emitted when the reference cannot be
locked. This improves how it reads and makes it a bit shorter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                |  2 +-
 t/t1400-update-ref.sh | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index ecaf804..bc4b1ab 100644
--- a/refs.c
+++ b/refs.c
@@ -3844,7 +3844,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				? TRANSACTION_NAME_CONFLICT
 				: TRANSACTION_GENERIC_ERROR;
 			reason = strbuf_detach(err, NULL);
-			strbuf_addf(err, "Cannot lock the ref '%s': %s",
+			strbuf_addf(err, "Cannot lock ref '%s': %s",
 				    update->refname, reason);
 			free(reason);
 			goto cleanup;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 6805b9e..86fa468 100755
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
