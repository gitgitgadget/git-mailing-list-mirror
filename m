From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/33] read_raw_ref(): improve docstring
Date: Fri,  6 May 2016 18:13:56 +0200
Message-ID: <3531b94aa4ba673eafdb92ec43838fbf4e619bc2.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:14:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiP4-0008Bp-LA
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758676AbcEFQOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:51 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:64270 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758638AbcEFQOt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:49 -0400
X-AuditID: 12074411-e2bff70000000955-64-572cc2f86dda
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 84.00.02389.8F2CC275; Fri,  6 May 2016 12:14:48 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUv031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:46 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqPvjkE64wYX1XBbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxrd+6xFCyQrHi4t4GtgfGFcBcjJ4eEgInE3L9t
	bF2MXBxCAlsZJU6sncQM4Rxnkjhwdw0jSBWbgK7Eop5mJhBbRCBCouFVC1Ccg4NZ4DOjxEpu
	kLCwgLXE/Cmn2UBsFgFViVez94GV8ApESRycHQyxS07i8vQHYCWcAhYSh3qPg00UEjCX6Fh7
	g30CI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqmermZJXqpKaWbGCHhJbiDccZJuUOM
	AhyMSjy8GSe1w4VYE8uKK3MPMUpyMCmJ8n4v0AkX4kvKT6nMSCzOiC8qzUktPsQowcGsJMJ7
	ZR9QjjclsbIqtSgfJiXNwaIkzsu3RN1PSCA9sSQ1OzW1ILUIJivDwaEkwcsPjCMhwaLU9NSK
	tMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFD4xxcDIwAkxQO0lw+knbe4IDEXKArReopRl+PI
	/ntrmYRY8vLzUqXEeeceBCoSACnKKM2DWwFLJq8YxYE+FuadBFLFA0xEcJNeAS1hAlryfq4m
	yJKSRISUVANjeP2d1YucX73+0Pdr64ndF9luFPxld3klGBo+aUqUbn7vgjfTL1zx9N45Ide4
	T0iui6/0yJR85ct3382Rlj4gsOTvafbtlTxT7k3nXL1u2iLej/zpGgVVX974nZlc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293805>

Among other things, document the (important!) requirement that input
refname be checked for safety before calling this function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fbbd48f..73717dd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1389,33 +1389,40 @@ static int resolve_missing_loose_ref(const char *refname,
 }
 
 /*
- * Read a raw ref from the filesystem or packed refs file.
+ * Read the specified reference from the filesystem or packed refs
+ * file, non-recursively. Set type to describe the reference, and:
  *
- * If the ref is a sha1, fill in sha1 and return 0.
+ * - If refname is the name of a normal reference, fill in sha1
+ *   (leaving referent unchanged).
  *
- * If the ref is symbolic, fill in *referent with the name of the
- * branch to which it refers (e.g. "refs/heads/master") and return 0.
- * The caller is responsible for validating the referent. Set
- * REF_ISSYMREF in type.
+ * - If refname is the name of a symbolic reference, write the full
+ *   name of the reference to which it refers (e.g.
+ *   "refs/heads/master") to referent and set the REF_ISSYMREF bit in
+ *   type (leaving sha1 unchanged). The caller is responsible for
+ *   validating that referent is a valid reference name.
  *
- * If the ref doesn't exist, set errno to ENOENT and return -1.
+ * WARNING: refname might be used as part of a filename, so it is
+ * important from a security standpoint that it be safe in the sense
+ * of refname_is_safe(). Moreover, for symrefs this function sets
+ * referent to whatever the repository says, which might not be a
+ * properly-formatted or even safe reference name. NEITHER INPUT NOR
+ * OUTPUT REFERENCE NAMES ARE VALIDATED WITHIN THIS FUNCTION.
  *
- * If the ref exists but is neither a symbolic ref nor a sha1, it is
- * broken. Set REF_ISBROKEN in type, set errno to EINVAL, and return
- * -1.
- *
- * If there is another error reading the ref, set errno appropriately and
- * return -1.
+ * Return 0 on success. If the ref doesn't exist, set errno to ENOENT
+ * and return -1. If the ref exists but is neither a symbolic ref nor
+ * a sha1, it is broken; set REF_ISBROKEN in type, set errno to
+ * EINVAL, and return -1. If there is another error reading the ref,
+ * set errno appropriately and return -1.
  *
  * Backend-specific flags might be set in type as well, regardless of
  * outcome.
  *
- * sb_path is workspace: the caller should allocate and free it.
+ * It is OK for refname to point into referent. If so:
  *
- * It is OK for refname to point into referent. In this case:
  * - if the function succeeds with REF_ISSYMREF, referent will be
- *   overwritten and the memory pointed to by refname might be changed
- *   or even freed.
+ *   overwritten and the memory formerly pointed to by it might be
+ *   changed or even freed.
+ *
  * - in all other cases, referent will be untouched, and therefore
  *   refname will still be valid and unchanged.
  */
-- 
2.8.1
