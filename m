From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/13] refs: use name "prefix" consistently
Date: Mon, 30 May 2016 09:55:24 +0200
Message-ID: <dbe2c569a5cd2b91fd6d51f99dcbfe9385f98ad4.1464537050.git.mhagger@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 30 09:56:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7I3U-0001FJ-ML
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 09:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbcE3H4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 03:56:00 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63916 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932141AbcE3Hz6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 03:55:58 -0400
X-AuditID: 12074414-63fff700000008e6-6f-574bf20786af
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 4F.0C.02278.702FB475; Mon, 30 May 2016 03:55:51 -0400 (EDT)
Received: from michael.fritz.box (p508EADDB.dip0.t-ipconnect.de [80.142.173.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4U7tgRs032144
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2016 03:55:49 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464537050.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqMv+yTvcoOshn8X8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgd2Dz+vv/A5LFz1l12j2e9exg9Ll5S9ljw/D67x+dNcgFs
	Udw2SYklZcGZ6Xn6dgncGZ27PAtmqlV8P5jXwNgj38XIySEhYCKx9nQjYxcjF4eQwFZGiU3H
	lzJBOCeZJL7fX8cOUsUmoCuxqKeZCcQWEYiQaHjVAtbBLLCPUeLkuvksIAlhAWuJjz/usoHY
	LAKqEg+WfQKzeQWiJJ52nWaCWCcncXn6A7A4p4CFxMRZ78DiQgLmEstmnmSewMizgJFhFaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGuhV5uZoleakrpJkZIOInsYDxyUu4QowAHoxIPb4Gmd7gQ
	a2JZcWXuIUZJDiYlUV43DqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd63j4FyvCmJlVWpRfkw
	KWkOFiVx3m+L1f2EBNITS1KzU1MLUotgsjIcHEoSvMIfgRoFi1LTUyvSMnNKENJMHJwgw7mk
	RIpT81JSixJLSzLiQREQXwyMAZAUD9De/R9A9hYXJOYCRSFaTzHqchzZf28tkxBLXn5eqpQ4
	rz1IkQBIUUZpHtwKWPJ4xSgO9LEwrxTIJTzAxAM36RXQEiagJWbnvECWlCQipKQaGEVEFQvL
	mp+L7Xqw+ASbNhvrunIOsztvzt69d5tpyeopfje0BPT2z5IzMrXkn/7ilHXJLpUTb1sExbwv
	mOrf8vvx15rPPqyoYPIePz9nx9e1C09f8tG9yp0xK6Ple+L/g4dr9Wz4w6VFJjTd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295859>

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
