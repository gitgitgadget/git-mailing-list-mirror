Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BFC720281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdISGXp (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:23:45 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42077 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751284AbdISGWo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:22:44 -0400
X-AuditID: 1207440c-7e5ff7000000143e-cb-59c0b7b285ca
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FB.37.05182.2B7B0C95; Tue, 19 Sep 2017 02:22:42 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1a002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:22:40 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/21] packed_ref_cache: add a backlink to the associated `packed_ref_store`
Date:   Tue, 19 Sep 2017 08:22:11 +0200
Message-Id: <3f231e673b9aa67347dd71c3d1c0eb813fe3a761.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLtp+4FIg6U3dS3WPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZWzZuZG1oFWq4vWMoywNjBNFuxg5
        OSQETCT+TOpm7mLk4hAS2MEkse3QJFYI5xSTxNwPr9hAqtgEdCUW9TQzgdgiAmoSE9sOsYAU
        MQusZJaYtPUKK0hCWCBeorVjKlgRi4CqxPYZd8BsXoEoiVVrjrFDrJOXOPfgNjOIzSlgIdG8
        ZzvQIA6gbeYSB44WT2DkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWldBMj
        JOR4djB+WydziFGAg1GJh1fg2v5IIdbEsuLK3EOMkhxMSqK8YZsORArxJeWnVGYkFmfEF5Xm
        pBYfYpTgYFYS4T20CCjHm5JYWZValA+TkuZgURLnVV2i7ickkJ5YkpqdmlqQWgSTleHgUJLg
        VQTGlpBgUWp6akVaZk4JQpqJgxNkOA/QcBWQGt7igsTc4sx0iPwpRl2Ojpt3/zAJseTl56VK
        ifPe3wZUJABSlFGaBzcHlipeMYoDvSXM6wpSxQNMM3CTXgEtYQJakr0BbElJIkJKqoFxyaFV
        E2NbUz772actrP3R+q3j7L4JaZkP3zb5pUx407RFTudCEdfNn4V8+zap/FRfWX24fefGSek/
        IgL/GXTMvrBBtmFu3EN7dYuKAr0F3P8W2B3QY8orcpjXaPj2awqP/T7tj/IB5vb3Xj3JVIs0
        OHP3QhaTLP8LJoOlcu4NlhJeV5Kc/lxRYinOSDTUYi4qTgQADanY/vACAAA=
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

