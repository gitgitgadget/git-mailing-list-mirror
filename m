From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/13] refs: use name "prefix" consistently
Date: Fri,  3 Jun 2016 14:33:43 +0200
Message-ID: <dbe2c569a5cd2b91fd6d51f99dcbfe9385f98ad4.1464957077.git.mhagger@alum.mit.edu>
References: <cover.1464957077.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 14:34:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8oIt-0005Ac-N9
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 14:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbcFCMeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 08:34:10 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45414 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932263AbcFCMeH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 08:34:07 -0400
X-AuditID: 12074414-63fff700000008e6-4f-5751793d7675
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F7.8C.02278.D3971575; Fri,  3 Jun 2016 08:34:05 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53CXtin005761
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 08:34:04 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464957077.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsUixO6iqGtbGRhucP2MjsX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDM6d3kWzFSr+H4wr4GxR76LkYND
	QsBE4vYO7i5GLg4hga2MEg3HGlghnONMEm9P3gRyODnYBHQlFvU0M4HYIgIREg2vWhhBipgF
	5jBJ3H7YyQySEBawk+h6dowdxGYRUJXYc+I9I4jNKxAlsfvDFRYQW0JATuLy9AdsIDangIVE
	370fYPVCAuYSD+fsZp/AyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6FXm5miV5qSukm
	RkjAiexgPHJS7hCjAAejEg/vigUB4UKsiWXFlbmHGCU5mJREec+fBQrxJeWnVGYkFmfEF5Xm
	pBYfYpTgYFYS4f1TEBguxJuSWFmVWpQPk5LmYFES5/22WN1PSCA9sSQ1OzW1ILUIJivDwaEk
	wWteAdQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRDwr/+GJgBICkeID2VoC08xYX
	JOYCRSFaTzEqSonzCoMkBEASGaV5cGNhaeQVozjQl8K8YeVAVTzAFATX/QpoMBPQ4IJH/iCD
	SxIRUlINjKo6nhvav9VOZO3PZqmv/3FldmSUmGusVKF6vImj/dvDHVdlj8ysCZ7nErUkQt10
	3nHz+W8d+rViku1TU3fYzF85K+jM6olPwmb8P2wj3pNx9MnXeu4XU59oGPy+aeo7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296318>

In the context of the for_each_ref() functions, call the prefix that
references must start with "prefix". (In some places it was called
"base".) This is clearer, and also prevents confusion with another
planned use of the word "base".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 24 ++++++++++++------------
 refs/refs-internal.h | 14 +++++++-------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 68db3e8..5af7441 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -542,7 +542,7 @@ static struct ref_entry *current_ref;
 typedef int each_ref_entry_fn(struct ref_entry *entry, void *cb_data);
 
 struct ref_entry_cb {
-	const char *base;
+	const char *prefix;
 	int trim;
 	int flags;
 	each_ref_fn *fn;
@@ -559,7 +559,7 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 	struct ref_entry *old_current_ref;
 	int retval;
 
-	if (!starts_with(entry->name, data->base))
+	if (!starts_with(entry->name, data->prefix))
 		return 0;
 
 	if (!(data->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
@@ -1824,12 +1824,12 @@ int peel_ref(const char *refname, unsigned char *sha1)
 
 /*
  * Call fn for each reference in the specified ref_cache, omitting
- * references not in the containing_dir of base.  fn is called for all
- * references, including broken ones.  If fn ever returns a non-zero
+ * references not in the containing_dir of prefix. Call fn for all
+ * references, including broken ones. If fn ever returns a non-zero
  * value, stop the iteration and return that value; otherwise, return
  * 0.
  */
-static int do_for_each_entry(struct ref_cache *refs, const char *base,
+static int do_for_each_entry(struct ref_cache *refs, const char *prefix,
 			     each_ref_entry_fn fn, void *cb_data)
 {
 	struct packed_ref_cache *packed_ref_cache;
@@ -1846,8 +1846,8 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
 	 * disk.
 	 */
 	loose_dir = get_loose_refs(refs);
-	if (base && *base) {
-		loose_dir = find_containing_dir(loose_dir, base, 0);
+	if (prefix && *prefix) {
+		loose_dir = find_containing_dir(loose_dir, prefix, 0);
 	}
 	if (loose_dir)
 		prime_ref_dir(loose_dir);
@@ -1855,8 +1855,8 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
 	packed_ref_cache = get_packed_ref_cache(refs);
 	acquire_packed_ref_cache(packed_ref_cache);
 	packed_dir = get_packed_ref_dir(packed_ref_cache);
-	if (base && *base) {
-		packed_dir = find_containing_dir(packed_dir, base, 0);
+	if (prefix && *prefix) {
+		packed_dir = find_containing_dir(packed_dir, prefix, 0);
 	}
 
 	if (packed_dir && loose_dir) {
@@ -1878,14 +1878,14 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
 	return retval;
 }
 
-int do_for_each_ref(const char *submodule, const char *base,
+int do_for_each_ref(const char *submodule, const char *prefix,
 		    each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	struct ref_entry_cb data;
 	struct ref_cache *refs;
 
 	refs = get_ref_cache(submodule);
-	data.base = base;
+	data.prefix = prefix;
 	data.trim = trim;
 	data.flags = flags;
 	data.fn = fn;
@@ -1896,7 +1896,7 @@ int do_for_each_ref(const char *submodule, const char *base,
 	if (ref_paranoia)
 		data.flags |= DO_FOR_EACH_INCLUDE_BROKEN;
 
-	return do_for_each_entry(refs, base, do_one_ref, &data);
+	return do_for_each_entry(refs, prefix, do_one_ref, &data);
 }
 
 /*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index b4dd545..8ad02d8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -250,16 +250,16 @@ int rename_ref_available(const char *oldname, const char *newname);
 
 /*
  * Call fn for each reference in the specified submodule for which the
- * refname begins with base. If trim is non-zero, then trim that many
- * characters off the beginning of each refname before passing the
- * refname to fn. flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
- * broken references in the iteration. If fn ever returns a non-zero
- * value, stop the iteration and return that value; otherwise, return
- * 0.
+ * refname begins with prefix. If trim is non-zero, then trim that
+ * many characters off the beginning of each refname before passing
+ * the refname to fn. flags can be DO_FOR_EACH_INCLUDE_BROKEN to
+ * include broken references in the iteration. If fn ever returns a
+ * non-zero value, stop the iteration and return that value;
+ * otherwise, return 0.
  *
  * This is the common backend for the for_each_*ref* functions.
  */
-int do_for_each_ref(const char *submodule, const char *base,
+int do_for_each_ref(const char *submodule, const char *prefix,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
 
 /*
-- 
2.8.1
