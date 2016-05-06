From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/33] read_raw_ref(): rename flags argument to type
Date: Fri,  6 May 2016 18:13:53 +0200
Message-ID: <01fdd8bc94d4d207f7043c138809163ad56ea2e4.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiPE-0008Kk-8s
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758663AbcEFQOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:48 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63737 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758638AbcEFQOn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:43 -0400
X-AuditID: 1207440d-bb3ff7000000090b-c0-572cc2f24771
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C0.48.02315.2F2CC275; Fri,  6 May 2016 12:14:42 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUs031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:41 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqPvpkE64wekT2hbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7owHC8+xFrTKVNzqa2ZpYPwm2sXIySEhYCKxcckP
	1i5GLg4hga2MEt9OH2YCSQgJHGeSWP9aCMRmE9CVWNTTDBYXEYiQaHjVwtjFyMHBLPCZUWIl
	N0hYWMBdovXMJBYQm0VAVeL+/VesIDavQJRE26cZ7BC75CQuT3/ABmJzClhIHOo9DrXKXKJj
	7Q32CYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunlZpbopaaUbmKEhBfvDsb/62QO
	MQpwMCrx8Gac1A4XYk0sK67MPcQoycGkJMr7vUAnXIgvKT+lMiOxOCO+qDQntfgQowQHs5II
	75V9QDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgRv0EGgRsGi1PTU
	irTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQ+McXAyMAJMUDtFcepJ23uCAxFygK0XqKUZfj
	yP57a5mEWPLy81KlxHnnghQJgBRllObBrYAlk1eM4kAfC/NeBqniASYiuEmvgJYwAS15P1cT
	ZElJIkJKqoHR/tG85bM1tnQnK3z/PyeemevCtEnZtS+udHqw8ExZMG+/+VxFOQ6WD29lrmq5
	bebf4Llhm/G2ncyRVxu3Hjy/8dKzX4f4ufZP61H7kbs/2/zwlrzeWaeCvJIm8Enu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293809>

This will hopefully reduce confusion with the "flags" arguments that are
used in many functions in this module as an input parameter to choose
how the function should operate.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 18 +++++++++---------
 refs/refs-internal.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 93a94af..fa8bbd6 100644
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
@@ -1482,7 +1482,7 @@ stat_ref:
 		 * ref is supposed to be, there could still be a
 		 * packed ref:
 		 */
-		if (resolve_missing_loose_ref(refname, sha1, flags)) {
+		if (resolve_missing_loose_ref(refname, sha1, type)) {
 			errno = EISDIR;
 			goto out;
 		}
@@ -1519,7 +1519,7 @@ stat_ref:
 
 		strbuf_reset(symref);
 		strbuf_addstr(symref, buf);
-		*flags |= REF_ISSYMREF;
+		*type |= REF_ISSYMREF;
 		ret = 0;
 		goto out;
 	}
@@ -1530,7 +1530,7 @@ stat_ref:
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
