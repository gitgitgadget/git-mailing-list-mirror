Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0351220286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbdIMRQd (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:16:33 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59495 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751054AbdIMRQ3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:16:29 -0400
X-AuditID: 12074412-1e5ff7000000748d-73-59b967ecaf0a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C1.27.29837.CE769B95; Wed, 13 Sep 2017 13:16:28 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIiR001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:26 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/20] packed_ref_cache: add a backlink to the associated `packed_ref_store`
Date:   Wed, 13 Sep 2017 19:15:57 +0200
Message-Id: <3f231e673b9aa67347dd71c3d1c0eb813fe3a761.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqPsmfWekwf/5uhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxpadG1kLWqUqXs84ytLAOFG0i5GTQ0LAROLN3S1s
        XYxcHEICO5gkersuM0M4J5kk3nZfYQOpYhPQlVjU08wEYosIqElMbDvEAlLELPCUSWLnybus
        IAlhgRiJA2/+gzWwCKhKrHu1jx3E5hWIkmjdsoQdYp28xLkHt5lBbE4BC4mNO54wgthCAuYS
        jXN2Mk5g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdMLzezRC81pXQTIyTEhHYwrj8p
        d4hRgINRiYf3geXOSCHWxLLiytxDjJIcTEqivHt1gUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVE
        eIOigHK8KYmVValF+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8f9OAGgWLUtNT
        K9Iyc0oQ0kwcnCDDeYCGzwCp4S0uSMwtzkyHyJ9i1OXouHn3D5MQS15+XqqUOO/fVKAiAZCi
        jNI8uDmw1PCKURzoLWHeYyCjeIBpBW7SK6AlTEBLzpzeAbKkJBEhJdXAyLdVKt1j7ZOrMVPk
        vggu+xnAdb7f5HjnrFijZaYVfr6aPPelw3pSFqdHPlwvc0lzcc/BCzOSX21672KXP+vdrsp5
        W545K+smWgh26K07MCvqoXq7+jKTl9/PTPj6Vd4oe3K9ahN31EGdoKCiErnpUpvXdic3bs+O
        9ljXsUKtz2YOe8VXxfkLlFiKMxINtZiLihMBbKHKF+gCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It will prove convenient in upcoming patches.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index e411501871..a3d9210cb0 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -7,7 +7,15 @@
 #include "../iterator.h"
 #include "../lockfile.h"
 
+struct packed_ref_store;
+
 struct packed_ref_cache {
+	/*
+	 * A back-pointer to the packed_ref_store with which this
+	 * cache is associated:
+	 */
+	struct packed_ref_store *refs;
+
 	struct ref_cache *cache;
 
 	/*
@@ -154,7 +162,7 @@ static const char *parse_ref_line(struct strbuf *line, struct object_id *oid)
 }
 
 /*
- * Read from `packed_refs_file` into a newly-allocated
+ * Read from the `packed-refs` file into a newly-allocated
  * `packed_ref_cache` and return it. The return value will already
  * have its reference count incremented.
  *
@@ -182,7 +190,7 @@ static const char *parse_ref_line(struct strbuf *line, struct object_id *oid)
  *      compatibility with older clients, but we do not require it
  *      (i.e., "peeled" is a no-op if "fully-peeled" is set).
  */
-static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
+static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 {
 	FILE *f;
 	struct packed_ref_cache *packed_refs = xcalloc(1, sizeof(*packed_refs));
@@ -191,11 +199,12 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
 	struct ref_dir *dir;
 
+	packed_refs->refs = refs;
 	acquire_packed_ref_cache(packed_refs);
 	packed_refs->cache = create_ref_cache(NULL, NULL);
 	packed_refs->cache->root->flag &= ~REF_INCOMPLETE;
 
-	f = fopen(packed_refs_file, "r");
+	f = fopen(refs->path, "r");
 	if (!f) {
 		if (errno == ENOENT) {
 			/*
@@ -205,7 +214,7 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 			 */
 			return packed_refs;
 		} else {
-			die_errno("couldn't read %s", packed_refs_file);
+			die_errno("couldn't read %s", refs->path);
 		}
 	}
 
@@ -218,7 +227,7 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 		const char *traits;
 
 		if (!line.len || line.buf[line.len - 1] != '\n')
-			die("unterminated line in %s: %s", packed_refs_file, line.buf);
+			die("unterminated line in %s: %s", refs->path, line.buf);
 
 		if (skip_prefix(line.buf, "# pack-refs with:", &traits)) {
 			if (strstr(traits, " fully-peeled "))
@@ -258,7 +267,7 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 			last->flag |= REF_KNOWS_PEELED;
 		} else {
 			strbuf_setlen(&line, line.len - 1);
-			die("unexpected line in %s: %s", packed_refs_file, line.buf);
+			die("unexpected line in %s: %s", refs->path, line.buf);
 		}
 	}
 
@@ -293,7 +302,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct packed_ref_store *re
 		validate_packed_ref_cache(refs);
 
 	if (!refs->cache)
-		refs->cache = read_packed_refs(refs->path);
+		refs->cache = read_packed_refs(refs);
 
 	return refs->cache;
 }
-- 
2.14.1

