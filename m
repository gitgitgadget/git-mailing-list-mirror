From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/29] read_raw_ref(): improve docstring
Date: Wed, 27 Apr 2016 18:57:29 +0200
Message-ID: <5b73d10ec47a68535725d77ebbc5c4f0512ac5f3.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:58:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSnE-0003f6-LH
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbcD0Q6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:58:25 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53601 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753195AbcD0Q6X (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:23 -0400
X-AuditID: 12074414-63fff700000008e6-0e-5720efaf5efd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 0C.62.02278.FAFE0275; Wed, 27 Apr 2016 12:58:23 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6P022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:21 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqLv+vUK4wYlv/BbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxj+1tYCxZIVvx4fYq5gfGFcBcjJ4eEgInEs7aV
	bF2MXBxCAlsZJVb/6WKBcI4zSfT+bWIHqWIT0JVY1NPMBGKLCDhILF/5ix2kiFmgiUni+/Im
	FpCEsICFxI2rrcxdjBwcLAKqElMPlYOYvAJREudes0Isk5O4PP0BG4jNCVT9pfUtI4gtJGAu
	seTBavYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFula6OVmluilppRuYoQEmMgOxiMn
	5Q4xCnAwKvHwnpBSCBdiTSwrrsw9xCjJwaQkyrvkLFCILyk/pTIjsTgjvqg0J7X4EKMEB7OS
	CO/0N0A53pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZqakFqUUwWRkODiUJ3vJ3QI2CRanp
	qRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoAiILwbGAEiKB2hvKUg7b3FBYi5QFKL1FKOi
	lDjvApCEAEgiozQPbiwsbbxiFAf6Upg3CKSKB5hy4LpfAQ1mAhp8+ZAsyOCSRISUVAPj5G/r
	3tzOldZjDq/L+rXjuDJDbPHEFL2pPbIqvzkZTmSKfik9YnB26dLivVOruUUzUlw8/SNiD7J/
	urJp77Qju4pjoo0n/n/KNlviSnu+wP6/c/8sW7GoT/b9OlXRzOZzMVnfU1aXVvF0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292750>

Among other things, document the (important!) requirement that input
refname be checked for safety before calling this function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 364425c..1d2ef2a 100644
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
