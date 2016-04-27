From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/29] read_raw_ref(): rename flags argument to type
Date: Wed, 27 Apr 2016 18:57:26 +0200
Message-ID: <9ff68ec3e90555304f7bec4970dee769bbe0e668.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:58:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSnV-0003nF-E8
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbcD0Q6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:35 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47365 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753519AbcD0Q6d (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:33 -0400
X-AuditID: 12074411-e2bff70000000955-92-5720efaab0d7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id B7.5D.02389.AAFE0275; Wed, 27 Apr 2016 12:58:18 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6M022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:16 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqLvqvUK4Qf8kQYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8abXdNZCz5KVvS1bWNsYFwl0sXIySEhYCJx9c8G
	pi5GLg4hga2MEgsf/2CDcI4zSRx93McOUsUmoCuxqKeZCcQWEXCQWL7yFztIEbNAE5PE9+VN
	LCAJYQEXie9LjrGB2CwCqhILpvaC2bwCURJvZpxjg1gnJ3F5+gMwm1PAQuJL61tGEFtIwFxi
	yYPV7BMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXVy80s0UtNKd3ECAkywR2MM07K
	HWIU4GBU4uEtkFAIF2JNLCuuzD3EKMnBpCTKu+QsUIgvKT+lMiOxOCO+qDQntfgQowQHs5II
	7/Q3QDnelMTKqtSifJiUNAeLkjgv3xJ1PyGB9MSS1OzU1ILUIpisDAeHkgTv0XdAjYJFqemp
	FWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgKIgvBsYBSIoHaG8pSDtvcUFiLlAUovUUo6KU
	OO9rkIQASCKjNA9uLCx1vGIUB/pSmNcZmEiEeIBpB677FdBgJqDBlw/JggwuSURISTUw6pzl
	W2B59mCg7OE/z/803VzYHftJQ/XQgY47J76wb1uUdTyi0Dinq7HN7IkWm8vD/69r0w8/u8xW
	v0LTV85J7HjU+Yxm2YUfZ8VXzpZ3nv1c9MclxUo29f7Lu30LZvM18a/l2G8q+UXO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292753>

This will hopefully reduce confusion with the "flags" arguments that are
used in many functions in this module as an input parameter to choose
how the function should operate.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 16 ++++++++--------
 refs/refs-internal.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 05797cb..303c43b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1395,18 +1395,18 @@ static int resolve_missing_loose_ref(const char *refname,
  *
  * If the ref is symbolic, fill in *symref with the referrent
  * (e.g. "refs/heads/master") and return 0.  The caller is responsible
- * for validating the referrent.  Set REF_ISSYMREF in flags.
+ * for validating the referrent.  Set REF_ISSYMREF in type.
  *
  * If the ref doesn't exist, set errno to ENOENT and return -1.
  *
  * If the ref exists but is neither a symbolic ref nor a sha1, it is
- * broken. Set REF_ISBROKEN in flags, set errno to EINVAL, and return
+ * broken. Set REF_ISBROKEN in type, set errno to EINVAL, and return
  * -1.
  *
  * If there is another error reading the ref, set errno appropriately and
  * return -1.
  *
- * Backend-specific flags might be set in flags as well, regardless of
+ * Backend-specific flags might be set in type as well, regardless of
  * outcome.
  *
  * sb_path is workspace: the caller should allocate and free it.
@@ -1419,7 +1419,7 @@ static int resolve_missing_loose_ref(const char *refname,
  *   refname will still be valid and unchanged.
  */
 int read_raw_ref(const char *refname, unsigned char *sha1,
-		 struct strbuf *symref, unsigned int *flags)
+		 struct strbuf *symref, unsigned int *type)
 {
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
@@ -1448,7 +1448,7 @@ stat_ref:
 	if (lstat(path, &st) < 0) {
 		if (errno != ENOENT)
 			goto out;
-		if (resolve_missing_loose_ref(refname, sha1, flags)) {
+		if (resolve_missing_loose_ref(refname, sha1, type)) {
 			errno = ENOENT;
 			goto out;
 		}
@@ -1469,7 +1469,7 @@ stat_ref:
 		if (starts_with(sb_contents.buf, "refs/") &&
 		    !check_refname_format(sb_contents.buf, 0)) {
 			strbuf_swap(&sb_contents, symref);
-			*flags |= REF_ISSYMREF;
+			*type |= REF_ISSYMREF;
 			ret = 0;
 			goto out;
 		}
@@ -1510,7 +1510,7 @@ stat_ref:
 
 		strbuf_reset(symref);
 		strbuf_addstr(symref, buf);
-		*flags |= REF_ISSYMREF;
+		*type |= REF_ISSYMREF;
 		ret = 0;
 		goto out;
 	}
@@ -1521,7 +1521,7 @@ stat_ref:
 	 */
 	if (get_sha1_hex(buf, sha1) ||
 	    (buf[40] != '\0' && !isspace(buf[40]))) {
-		*flags |= REF_ISBROKEN;
+		*type |= REF_ISBROKEN;
 		errno = EINVAL;
 		goto out;
 	}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 3a4f634..0b047f6 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -210,6 +210,6 @@ int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
 
 int read_raw_ref(const char *refname, unsigned char *sha1,
-		 struct strbuf *symref, unsigned int *flags);
+		 struct strbuf *symref, unsigned int *type);
 
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.8.1
