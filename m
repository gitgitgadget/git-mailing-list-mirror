From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/38] resolve_packed_ref(): rename function from resolve_missing_loose_ref()
Date: Fri,  3 Jun 2016 23:03:47 +0200
Message-ID: <977a81b2d2ac82516bbbd8494052ccaaed5d495a.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHI-0000Yi-1n
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbcFCVFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:01 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53972 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932740AbcFCVEz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:55 -0400
X-AuditID: 12074412-51bff700000009f7-c6-5751f0ee6979
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 2D.94.02551.EE0F1575; Fri,  3 Jun 2016 17:04:46 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcc003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:45 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqPvuQ2C4wc1vBhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M440fyHqeAGV8W1Pd1MDYzzOboY
	OTgkBEwk5nXGdjFycQgJbGWUONd5iB3COc4ksXxBC2sXIycHm4CuxKKeZiYQW0QgQqLhVQsj
	SBGzwBwmidsPO5lBEsICsRJX53xhB5nKIqAqcXBFKUiYVyBKYsf1HjYQW0JATuLy9AdgNqeA
	hUTL51Vg84UEzCUaTx1mmcDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrplebmaJXmpK
	6SZGSMgJ7WBcf1LuEKMAB6MSD2/Bs8BwIdbEsuLK3EOMkhxMSqK8e+8AhfiS8lMqMxKLM+KL
	SnNSiw8xSnAwK4nwprwGyvGmJFZWpRblw6SkOViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAo
	SfDKA2NLSLAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UAfHFwBgASfEA7eUGaect
	LkjMBYpCtJ5iVJQS5z30HighAJLIKM2DGwtLJK8YxYG+FOZNBqniASYhuO5XQIOZgAYXPPIH
	GVySiJCSamAs/S4ntvDsfc/nbnwl6ZoJG06m+VyT/vh0qmywdb74ZXbt9a8Urzz4xtPHm9W1
	2E2nrPKlbcFuTnumB59+LP/Ts/mio/XivVv2CW0o4kzlWLWQw6GT8djN7WF2K1N+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296379>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 50bfe97..b54355d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1333,10 +1333,9 @@ static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
 /*
  * A loose ref file doesn't exist; check for a packed ref.
  */
-static int resolve_missing_loose_ref(struct files_ref_store *refs,
-				     const char *refname,
-				     unsigned char *sha1,
-				     unsigned int *flags)
+static int resolve_packed_ref(struct files_ref_store *refs,
+			      const char *refname,
+			      unsigned char *sha1, unsigned int *flags)
 {
 	struct ref_entry *entry;
 
@@ -1387,7 +1386,7 @@ stat_ref:
 	if (lstat(path, &st) < 0) {
 		if (errno != ENOENT)
 			goto out;
-		if (resolve_missing_loose_ref(refs, refname, sha1, type)) {
+		if (resolve_packed_ref(refs, refname, sha1, type)) {
 			errno = ENOENT;
 			goto out;
 		}
@@ -1421,7 +1420,7 @@ stat_ref:
 		 * ref is supposed to be, there could still be a
 		 * packed ref:
 		 */
-		if (resolve_missing_loose_ref(refs, refname, sha1, type)) {
+		if (resolve_packed_ref(refs, refname, sha1, type)) {
 			errno = EISDIR;
 			goto out;
 		}
-- 
2.8.1
