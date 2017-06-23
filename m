Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6892D20401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754649AbdFWHCX (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:23 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50046 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754632AbdFWHCQ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:16 -0400
X-AuditID: 1207440d-3e9ff70000001be7-32-594cbcf74067
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F9.51.07143.7FCBC495; Fri, 23 Jun 2017 03:02:15 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o5s001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:13 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 09/29] get_packed_refs(): take a `packed_ref_store *` parameter
Date:   Fri, 23 Jun 2017 09:01:27 +0200
Message-Id: <78a520b9b7d1cd234f64fb477f03d2b2f4ce0257.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqPt9j0+kwfIn0hZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGX8bT3DXrCUv+L/8jcsDYydvF2M
        nBwSAiYS9z5uZ+xi5OIQEtjBJHHkcjc7hHOKSWLV05/sIFVsAroSi3qamUBsEQE1iYlth1hA
        ipgFJjFLvL22ECjBwSEsECSxpdUVpIZFQFXiTEsnI4jNKxAl8XHxO1aIbfISu9ougtmcAhYS
        PROXg80XEjCXWPV7NesERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9HIzS/RSU0o3
        MUKCjncH4/91MocYBTgYlXh4E856RwqxJpYVV+YeYpTkYFIS5dWM9IkU4kvKT6nMSCzOiC8q
        zUktPsQowcGsJMKrswoox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS
        4G3ZDdQoWJSanlqRlplTgpBm4uAEGc4DNNxjM8jw4oLE3OLMdIj8KUZFKXHeDSDNAiCJjNI8
        uF5YUnjFKA70ijBvIkgVDzChwHW/AhrMBDR4xhqwwSWJCCmpBsakZ0Ux/5fItqXPnxXJHnj6
        iek8s4wjv/ZeNtkosO35kczieCbr+t0GD7i+Hpyh/TbrfNm7KcummW9ouXCp8ClDMfvipT89
        jM1PPzE4vuCY+WY1sa8csq932Mvp/rhazxo/+cvGiFfPLphHCcRffdRULPc56q3x1deveNi7
        fvJM0/S4GuqY8/62EktxRqKhFnNRcSIALOIJu+UCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b2ef7b3bb9..bc5c0de84e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -427,9 +427,9 @@ static struct ref_dir *get_packed_ref_dir(struct packed_ref_cache *packed_ref_ca
 	return get_ref_dir(packed_ref_cache->cache->root);
 }
 
-static struct ref_dir *get_packed_refs(struct files_ref_store *refs)
+static struct ref_dir *get_packed_refs(struct packed_ref_store *refs)
 {
-	return get_packed_ref_dir(get_packed_ref_cache(refs->packed_ref_store));
+	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
 /*
@@ -450,7 +450,7 @@ static void add_packed_ref(struct files_ref_store *refs,
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
 
-	packed_refs = get_packed_refs(refs);
+	packed_refs = get_packed_refs(refs->packed_ref_store);
 	packed_entry = find_ref_entry(packed_refs, refname);
 	if (packed_entry) {
 		/* Overwrite the existing entry: */
@@ -592,7 +592,7 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
 					const char *refname)
 {
-	return find_ref_entry(get_packed_refs(refs), refname);
+	return find_ref_entry(get_packed_refs(refs->packed_ref_store), refname);
 }
 
 /*
@@ -1633,7 +1633,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 		unable_to_lock_message(refs->packed_ref_store->path, errno, err);
 		return -1;
 	}
-	packed = get_packed_refs(refs);
+	packed = get_packed_refs(refs->packed_ref_store);
 
 	/* Remove refnames from the cache */
 	for_each_string_list_item(refname, refnames)
-- 
2.11.0

