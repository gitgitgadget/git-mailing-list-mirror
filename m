From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 27/33] unlock_ref(): move definition higher in the file
Date: Fri,  6 May 2016 18:14:08 +0200
Message-ID: <e76e0d4119aba05bfce6b4c4d0fe8d7f9d05c132.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiPd-0000Bq-TX
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbcEFQPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:17 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63363 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758677AbcEFQPJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:15:09 -0400
X-AuditID: 1207440c-c3fff70000000b85-2f-572cc30d3977
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 07.74.02949.D03CC275; Fri,  6 May 2016 12:15:09 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHV9031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:15:07 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqMt7WCfcYM56IYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8bc68tZC25zVWzruM/cwHido4uRk0NCwETixdEv
	jF2MXBxCAlsZJbrOP2CCcI4zSZw9fYIRpIpNQFdiUU8zE4gtIhAh0fCqBSjOwcEs8JlRYiU3
	SFhYwEui9fFNZhCbRUBV4tHl76wgNq9AlMTKU/9ZIZbJSVye/oANxOYUsJA41HscbKSQgLlE
	x9ob7BMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXUy80s0UtNKd3ECAkwnh2M39bJ
	HGIU4GBU4uE9cFo7XIg1say4MvcQoyQHk5Io7/cCnXAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxK
	IrxX9gHleFMSK6tSi/JhUtIcLErivKpL1P2EBNITS1KzU1MLUotgsjIcHEoSvIcOAjUKFqWm
	p1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEgyIgvhgYAyApHqC9fIdA9hYXJOYCRSFaTzHq
	chzZf28tkxBLXn5eqpQ471yQHQIgRRmleXArYOnkFaM40MfCvJdBqniAqQhu0iugJUxAS97P
	1QRZUpKIkJJqYKxY90j4UflDVob4UrsFbWEdvAssT6rPWysjpay++0Ll6ZBvZntPNqqYXlmh
	2DZ/Hk9skmdC8I2DXoK1J8IqcuS7lZpFO/2VghOPxN9nfPuNo5Hbo+BqPvfzWyIG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293817>

This avoids the need for a forward declaration in the next patch.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1c20af5..8ff76ed 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1516,6 +1516,16 @@ out:
 	return ret;
 }
 
+static void unlock_ref(struct ref_lock *lock)
+{
+	/* Do not free lock->lk -- atexit() still looks at them */
+	if (lock->lk)
+		rollback_lock_file(lock->lk);
+	free(lock->ref_name);
+	free(lock->orig_ref_name);
+	free(lock);
+}
+
 /*
  * Peel the entry (if possible) and return its new peel_status.  If
  * repeel is true, re-peel the entry even if there is an old peeled
@@ -1674,16 +1684,6 @@ int do_for_each_ref(const char *submodule, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
-static void unlock_ref(struct ref_lock *lock)
-{
-	/* Do not free lock->lk -- atexit() still looks at them */
-	if (lock->lk)
-		rollback_lock_file(lock->lk);
-	free(lock->ref_name);
-	free(lock->orig_ref_name);
-	free(lock);
-}
-
 /*
  * Verify that the reference locked by lock has the value old_sha1.
  * Fail if the reference doesn't exist and mustexist is set. Return 0
-- 
2.8.1
