From: mhagger@alum.mit.edu
Subject: [PATCH 3/7] t0000: verify that real_path() fails if passed the empty string
Date: Tue,  4 Sep 2012 10:14:26 +0200
Message-ID: <1346746470-23127-4-git-send-email-mhagger@alum.mit.edu>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 10:15:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8oIN-0007eK-Ot
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 10:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812Ab2IDIPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 04:15:30 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:53341 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752540Ab2IDIPP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 04:15:15 -0400
X-AuditID: 1207440e-b7f036d0000008b5-f2-5045b8925611
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.4A.02229.298B5405; Tue,  4 Sep 2012 04:15:14 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q848EtSX025047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Sep 2012 04:15:13 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqDtph2uAwfqPuhZdV7qZLBp6rzBb
	PJl7l9ni9or5zA4sHn/ff2DyePiqi93j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M15MmMhW
	cI+1YtOFB+wNjLdZuhg5OSQETCRWrf3NDGGLSVy4t56ti5GLQ0jgMqPE9P1TmCCc00wSu6e3
	MYFUsQlISbxs7GEHsUUE1CQmth0Cm8QskC5xYkE7mC0sECLxpn8ZWD2LgKrEpc2XwWxeAReJ
	34v/QW1TlPjxfQ2YzSngKvHqw2ugzRxAy1wkPj5wnsDIu4CRYRWjXGJOaa5ubmJmTnFqsm5x
	cmJeXmqRrrFebmaJXmpK6SZGSPjw7WBsXy9ziFGAg1GJh7fyk0uAEGtiWXFl7iFGSQ4mJVFe
	u82uAUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeG+vBsrxpiRWVqUW5cOkpDlYlMR51Zao+wkJ
	pCeWpGanphakFsFkZTg4lCR4PbYDNQoWpaanVqRl5pQgpJk4OEEEF8gGHqANWSCFvMUFibnF
	mekQRacYFaXEeTNBEgIgiYzSPLgBsEh/xSgO9I8wbwVIFQ8wScB1vwIazAQ02PW9C8jgkkSE
	lFQDY43IKa/NcjdtP+6+xnZz69ICgYM+p8+XbWE4b6454Uam7MqaZY7uvx7nyvK9t9Vcun7r
	bNUnv5VaNwZnRB+TjGpQsFwi/+CthaZOBDCNWKpJvZ3iUqch/KDXukxX0NZOWVJC9cXdd35F
	vav2sqoeNtaKXvlGYx7D81tsPhfe8dzsuL138a/TSizFGYmGWsxFxYkAw1hOvc8C 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204722>

From: Michael Haggerty <mhagger@alum.mit.edu>

It doesn't, so mark the test as failing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0000-basic.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 5963a6c..363e190 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -454,6 +454,10 @@ test_expect_success 'absolute path rejects the empty string' '
 	test_must_fail test-path-utils absolute_path ""
 '
 
+test_expect_failure 'real path rejects the empty string' '
+	test_must_fail test-path-utils real_path ""
+'
+
 test_expect_success SYMLINKS 'real path works as expected' '
 	mkdir first &&
 	ln -s ../.git first/.git &&
-- 
1.7.11.3
