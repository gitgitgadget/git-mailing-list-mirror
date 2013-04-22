From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 25/33] pack_one_ref(): rename "path" parameter to "refname"
Date: Mon, 22 Apr 2013 21:52:33 +0200
Message-ID: <1366660361-21831-26-git-send-email-mhagger@alum.mit.edu>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:02:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUMwH-0007fY-Bz
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab3DVUBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:01:51 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:63879 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755044Ab3DVUBn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:01:43 -0400
X-AuditID: 1207440d-b7fd06d000000905-a7-5175955b6178
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.0E.02309.B5595715; Mon, 22 Apr 2013 15:54:03 -0400 (EDT)
Received: from michael.fritz.box (p57A2598E.dip0.t-ipconnect.de [87.162.89.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3MJrEOc008578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Apr 2013 15:54:02 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqBs9tTTQ4PUHPouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M54cHo5S8EdvopTM4+zNzA+
	4e5i5OCQEDCR+LS9tIuRE8gUk7hwbz1bFyMXh5DAZUaJR3vnQDkXmCSer3vGAlLFJqArsain
	mQnEFhFQk5jYdggszizgILH5cyMjiC0s4Cdx7tRtJpAFLAKqEj9PhICEeQVcJbZeecsKsUxB
	4vj2bWDlnEDx0x0nwMYICbhIrDg4lWUCI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpG
	ermZJXqpKaWbGCGBwruD8f86mUOMAhyMSjy8Au6lgUKsiWXFlbmHGCU5mJREeTmmAIX4kvJT
	KjMSizPii0pzUosPMUpwMCuJ8IrmA+V4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtS
	i2CyMhwcShK8GSBDBYtS01Mr0jJzShDSTBycIIILZAMP0IZIkELe4oLE3OLMdIiiU4yKUuK8
	bpOAEgIgiYzSPLgBsJh+xSgO9I8wrwdIOw8wHcB1vwIazAQ0ODOhBGRwSSJCSqqB0cfzImPS
	J5V//57a/Z/G6djCZrL/zIl9368e3M0e3BCqxLp5Ru60bdXPj7l4rTR1WHewpORf5b2TE/tk
	PrJ7r64Vvh5zevrxdKmHUVu+Cd1Yo5b68dGn8xU3PzKxMvJq8X3fqhf64F6fRvTcnNSCg2HR
	19xyLWdfO3ZzYxXrFq/5IjmMDVzP1ZVYijMSDbWYi4oTAd/MHQLEAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222083>

Make this function conform to the naming convention established in
65385ef7d4 for the rest of the refs.c file.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 268c1a0..b41dd5e 100644
--- a/refs.c
+++ b/refs.c
@@ -2003,7 +2003,7 @@ static int do_not_prune(int flags)
 	return (flags & (REF_ISSYMREF|REF_ISPACKED));
 }
 
-static int pack_one_ref(const char *path, const unsigned char *sha1,
+static int pack_one_ref(const char *refname, const unsigned char *sha1,
 			  int flags, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
@@ -2013,27 +2013,27 @@ static int pack_one_ref(const char *path, const unsigned char *sha1,
 	/* Do not pack the symbolic refs */
 	if ((flags & REF_ISSYMREF))
 		return 0;
-	is_tag_ref = !prefixcmp(path, "refs/tags/");
+	is_tag_ref = !prefixcmp(refname, "refs/tags/");
 
 	/* ALWAYS pack refs that were already packed or are tags */
 	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref && !(flags & REF_ISPACKED))
 		return 0;
 
-	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
+	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), refname);
 
-	o = parse_object_or_die(sha1, path);
+	o = parse_object_or_die(sha1, refname);
 	if (o->type == OBJ_TAG) {
-		o = deref_tag(o, path, 0);
+		o = deref_tag(o, refname, 0);
 		if (o)
 			fprintf(cb->refs_file, "^%s\n",
 				sha1_to_hex(o->sha1));
 	}
 
 	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
-		int namelen = strlen(path) + 1;
+		int namelen = strlen(refname) + 1;
 		struct ref_to_prune *n = xcalloc(1, sizeof(*n) + namelen);
 		hashcpy(n->sha1, sha1);
-		strcpy(n->name, path);
+		strcpy(n->name, refname);
 		n->next = cb->ref_to_prune;
 		cb->ref_to_prune = n;
 	}
-- 
1.8.2.1
