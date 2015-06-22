From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 01/19] delete_ref(): move declaration to refs.h
Date: Mon, 22 Jun 2015 16:02:52 +0200
Message-ID: <0c49ee45d76303320c197f10270601683ed27cf4.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:03:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72Jm-0005Pm-Vm
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834AbbFVODT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:03:19 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42854 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750838AbbFVODR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:17 -0400
X-AuditID: 1207440e-f79516d0000012b3-b8-558815a477e6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.96.04787.4A518855; Mon, 22 Jun 2015 10:03:16 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3Cbx030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:15 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqLtEtCPUoK/PyKLrSjeTRUPvFWaL
	2yvmM1v8aOlhtti8uZ3FgdXj7/sPTB4LNpV6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGT/nT2AsmC9SsemkSgPjEoEuRk4OCQETiZbOa2wQtpjEhXvrgWwuDiGBy4wS704+ZoRw
	TjJJvG9aAVbFJqArsainmQnEFhFQk5jYdogFpIhZoINR4sLybewgCWEBJ4nuC7vBbBYBVYkr
	e/8zgti8AlESX+asZ4dYJydx/vhPZhCbU8BCYv6+/2BxIQFziYkzH7FMYORdwMiwilEuMac0
	Vzc3MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMkpPh2MLavlznEKMDBqMTDO8O+PVSINbGs
	uDL3EKMkB5OSKO+B10AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwtZ4FyvCmJlVWpRfkwKWkO
	FiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJXj+RjlAhwaLU9NSKtMycEoQ0EwcnyHAuKZHi
	1LyU1KLE0pKMeFBsxBcDowMkxQO01wSknbe4IDEXKArReopRUUqc1x8kIQCSyCjNgxsLSxSv
	GMWBvhTmVQWmDSEeYJKB634FNJgJaPCX3DaQwSWJCCmpBkYzz3Wy1qsnvHpwnVeG82GP/qSa
	tHtv7DoV94ldz5kmWxp8Xelc3vFjte8bQ0Qktz65d9879JbhWamrDo5Nrb8Wb+zsyL3Qnid2
	jNXOIyP+95X3mfM8tgldz1d89aGo/8UHzYYtfvrWofkrAppWxdXFBH0q4ZvzwzqR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272343>

Also

* Add a docstring

* Rename the second parameter to "old_sha1", to be consistent with the
  convention used elsewhere in the refs module

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h |  2 --
 refs.c  |  5 +++--
 refs.h  | 10 ++++++++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 571c98f..be92121 100644
--- a/cache.h
+++ b/cache.h
@@ -585,8 +585,6 @@ extern void update_index_if_able(struct index_state *, struct lock_file *);
 extern int hold_locked_index(struct lock_file *, int);
 extern void set_alternate_index_output(const char *);
 
-extern int delete_ref(const char *, const unsigned char *sha1, unsigned int flags);
-
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int trust_ctime;
diff --git a/refs.c b/refs.c
index a742d79..b575bb8 100644
--- a/refs.c
+++ b/refs.c
@@ -2789,7 +2789,8 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_ref(const char *refname, const unsigned char *sha1, unsigned int flags)
+int delete_ref(const char *refname, const unsigned char *old_sha1,
+	       unsigned int flags)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -2797,7 +2798,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, unsigned int flag
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname,
-				   (sha1 && !is_null_sha1(sha1)) ? sha1 : NULL,
+				   (old_sha1 && !is_null_sha1(old_sha1)) ? old_sha1 : NULL,
 				   flags, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
diff --git a/refs.h b/refs.h
index 8c3d433..68b5e81 100644
--- a/refs.h
+++ b/refs.h
@@ -202,6 +202,16 @@ extern int read_ref_at(const char *refname, unsigned int flags,
 /** Check if a particular reflog exists */
 extern int reflog_exists(const char *refname);
 
+/*
+ * Delete the specified reference. If old_sha1 is non-NULL and not
+ * NULL_SHA1, then verify that the current value of the reference is
+ * old_sha1 before deleting it. If old_sha1 is NULL or NULL_SHA1,
+ * delete the reference if it exists, regardless of its old value.
+ * flags is passed through to ref_transaction_delete().
+ */
+extern int delete_ref(const char *refname, const unsigned char *old_sha1,
+		      unsigned int flags);
+
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
 
-- 
2.1.4
