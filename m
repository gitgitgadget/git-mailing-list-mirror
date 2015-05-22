From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/5] ref_transaction_commit(): do not capitalize error messages
Date: Sat, 23 May 2015 01:34:57 +0200
Message-ID: <1432337697-29161-6-git-send-email-mhagger@alum.mit.edu>
References: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 01:35:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvwTR-0003SR-PZ
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 01:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757655AbbEVXfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 19:35:22 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:59581 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757328AbbEVXfU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 19:35:20 -0400
X-AuditID: 1207440c-f79df6d000000d2d-49-555fbd2d428c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B2.6A.03373.D2DBF555; Fri, 22 May 2015 19:35:09 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3AFA.dip0.t-ipconnect.de [93.219.58.250])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4MNZ2Pw007402
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 22 May 2015 19:35:08 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqKu7Nz7UoOesrkXXlW4mi4beK8wW
	t1fMZ7bYvLmdxYHF4+/7D0weCzaVely8pOzxeZNcAEsUt01SYklZcGZ6nr5dAnfG1I/t7AW3
	FCt2dOxmb2B8LtXFyMkhIWAice7jPSYIW0ziwr31bF2MXBxCApcZJSYdOswI4Zxgknj3eis7
	SBWbgK7Eop5msA4RATWJiW2HWEBsZoFciQ37ToHFhQX8JTZMamEGsVkEVCVuP7jJCGLzCrhI
	/Jvxlxlim5zE+eM/wWxOAVeJ20v7wHqFgGp6t39jmcDIu4CRYRWjXGJOaa5ubmJmTnFqsm5x
	cmJeXmqRrqFebmaJXmpK6SZGSPjw7GD8tk7mEKMAB6MSD2/H4bhQIdbEsuLK3EOMkhxMSqK8
	q1bEhwrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4T27GSjHm5JYWZValA+TkuZgURLnVV2i7ick
	kJ5YkpqdmlqQWgSTleHgUJLgXbYbqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMe
	FBvxxcDoAEnxAO2tBmnnLS5IzAWKQrSeYlSUEufdBJIQAElklObBjYUlhVeM4kBfCvN+A6ni
	ASYUuO5XQIOZgAavmhALMrgkESEl1cBYUb3B6Tk3l7ZcWufL9Secs7cejtUVW8zp66+ySt6n
	//rOq8KXqyaYy0Sr3Glc117bKsDx9deOr09ZrOS0e5wfzms8vjtvZafb5cd5W148tF++1/Tn
	yUd7Yr0zDTn1Nq92eKS7QMi7Q+mLkf5GGbYjeut+74+5wSnG1Ki1n0f42W2V7YIX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269774>

Our convention is for error messages to start with a lower-case
letter.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                |  4 ++--
 t/t1400-update-ref.sh | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 48aff79..1d60fcd 100644
--- a/refs.c
+++ b/refs.c
@@ -3856,7 +3856,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				? TRANSACTION_NAME_CONFLICT
 				: TRANSACTION_GENERIC_ERROR;
 			reason = strbuf_detach(err, NULL);
-			strbuf_addf(err, "Cannot lock ref '%s': %s",
+			strbuf_addf(err, "cannot lock ref '%s': %s",
 				    update->refname, reason);
 			free(reason);
 			goto cleanup;
@@ -3883,7 +3883,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			} else if (write_ref_sha1(update->lock, update->new_sha1,
 						  update->msg)) {
 				update->lock = NULL; /* freed by write_ref_sha1 */
-				strbuf_addf(err, "Cannot update the ref '%s'.",
+				strbuf_addf(err, "cannot update the ref '%s'.",
 					    update->refname);
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 86fa468..9c133c1 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -519,7 +519,7 @@ test_expect_success 'stdin create ref works with path with space to blob' '
 test_expect_success 'stdin update ref fails with wrong old value' '
 	echo "update $c $m $m~1" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock ref '"'"'$c'"'"'" err &&
+	grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -555,7 +555,7 @@ test_expect_success 'stdin update ref works with right old value' '
 test_expect_success 'stdin delete ref fails with wrong old value' '
 	echo "delete $a $m~1" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock ref '"'"'$a'"'"'" err &&
+	grep "fatal: cannot lock ref '"'"'$a'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -688,7 +688,7 @@ test_expect_success 'stdin update refs fails with wrong old value' '
 	update $c  ''
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock ref '"'"'$c'"'"'" err &&
+	grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual &&
@@ -883,7 +883,7 @@ test_expect_success 'stdin -z create ref works with path with space to blob' '
 test_expect_success 'stdin -z update ref fails with wrong old value' '
 	printf $F "update $c" "$m" "$m~1" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock ref '"'"'$c'"'"'" err &&
+	grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -899,7 +899,7 @@ test_expect_success 'stdin -z create ref fails when ref exists' '
 	git rev-parse "$c" >expect &&
 	printf $F "create $c" "$m~1" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock ref '"'"'$c'"'"'" err &&
+	grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
 	git rev-parse "$c" >actual &&
 	test_cmp expect actual
 '
@@ -930,7 +930,7 @@ test_expect_success 'stdin -z update ref works with right old value' '
 test_expect_success 'stdin -z delete ref fails with wrong old value' '
 	printf $F "delete $a" "$m~1" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock ref '"'"'$a'"'"'" err &&
+	grep "fatal: cannot lock ref '"'"'$a'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -1045,7 +1045,7 @@ test_expect_success 'stdin -z update refs fails with wrong old value' '
 	git update-ref $c $m &&
 	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "$m" "$Z" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Cannot lock ref '"'"'$c'"'"'" err &&
+	grep "fatal: cannot lock ref '"'"'$c'"'"'" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual &&
-- 
2.1.4
