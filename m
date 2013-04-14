From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 25/33] pack_one_ref(): rename "path" parameter to "refname"
Date: Sun, 14 Apr 2013 14:54:40 +0200
Message-ID: <1365944088-10588-26-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMTR-0004Wx-9Q
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064Ab3DNMz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:58 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:52907 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751989Ab3DNMz4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:56 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-d9-516aa75bcc1a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 48.D8.02380.B57AA615; Sun, 14 Apr 2013 08:55:55 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAkM007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:54 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqBu9PCvQYM8PXYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M6Y36pUcIev4uRL9wbGJ9xdjJwcEgImEieXb2CDsMUkLtxbD2RzcQgJXGaU+Ph+LguE
	c5ZJ4sKrcywgVWwCuhKLepqZuhg5OEQEsiV2r5UHCTMLOEhs/tzICGILC3hLfLm6G8xmEVCV
	mP7oEzuIzSvgKnH03HV2iGUKEse3bwOr4QSKT39+DCwuJOAiMWvzbNYJjLwLGBlWMcol5pTm
	6uYmZuYUpybrFicn5uWlFuka6+VmluilppRuYoSEE98Oxvb1MocYBTgYlXh4XzBmBQqxJpYV
	V+YeYpTkYFIS5T25DCjEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhNexFSjHm5JYWZValA+TkuZg
	URLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgnQYyVLAoNT21Ii0zpwQhzcTBCSK4QDbwAG2Y
	B1LIW1yQmFucmQ5RdIpRUUqcNwUkIQCSyCjNgxsAi/xXjOJA/whD7OEBJg247ldAg5mABvvs
	TQcZXJKIkJJqYOyS8M87F6Ww5uJj3rtbSrf2XtF1PXZk5jSX2TE66Q/mbOeO8VhZW32T59+Z
	uW1udzdIaDcJ1LNnS7y+UfEq7kRr5J+Hj/c7H/xRsKIt5pTyy+hlTEfn1n1/4LSv2GWD/2cW
	0QaZVc++8m/VOLrt7QINA7tdfI99lt7o0bkXsFqV3/V2gIzy5RAlluKMREMt5qLi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221111>

Make this function conform to the naming convention established in
65385ef7d4 for the rest of the refs.c file.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 6c7f92c..16c237c 100644
--- a/refs.c
+++ b/refs.c
@@ -2001,7 +2001,7 @@ static int do_not_prune(int flags)
 	return (flags & (REF_ISSYMREF|REF_ISPACKED));
 }
 
-static int pack_one_ref(const char *path, const unsigned char *sha1,
+static int pack_one_ref(const char *refname, const unsigned char *sha1,
 			  int flags, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
@@ -2011,27 +2011,27 @@ static int pack_one_ref(const char *path, const unsigned char *sha1,
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
