Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3354A2023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934682AbdEVOSV (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:21 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:43491 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934407AbdEVOSS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:18 -0400
X-AuditID: 12074414-071ff70000004f50-21-5922f3281311
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 06.88.20304.823F2295; Mon, 22 May 2017 10:18:16 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24D023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:14 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/25] files-backend: use `die("BUG: ...")`, not `die("internal error: ...")`
Date:   Mon, 22 May 2017 16:17:34 +0200
Message-Id: <37be27050566a0f5772f2c2e60b435a07fcef263.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqKv5WSnS4NVfRou1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxoaGncwFN/gq
        /rRdYmlg3MzTxcjJISFgInHqwVr2LkYuDiGBHUwSd/Y8gHJOMUms2NDGBFLFJqArsainGcwW
        EVCTmNh2iAWkiFlgA7PEm+mrwRLCAgkSn1f8YQWxWQRUJXoXrGEEsXkFoiQWLp/JDLFOXmJX
        20WwGk4BC4nfsw6A9QoJmEv0/lvNMoGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu9
        3MwSvdSU0k2MkFAU2cF45KTcIUYBDkYlHl6Nx0qRQqyJZcWVuYcYJTmYlER5j74BCvEl5adU
        ZiQWZ8QXleakFh9ilOBgVhLh1b4LlONNSaysSi3Kh0lJc7AoifN+W6zuJySQnliSmp2aWpBa
        BJOV4eBQkuCd/AmoUbAoNT21Ii0zpwQhzcTBCTKcB2j4mg8gw4sLEnOLM9Mh8qcYFaXEeQ1A
        mgVAEhmleXC9sFTxilEc6BVh3n0fgap4gGkGrvsV0GAmoMHWz+RBBpckIqSkGhi12cqlTwpz
        /VL81DVtsf2iEH49juKjqpfkNWomRcQ5BCgvn3ujls36++mP0bMii/SvusRxXZ/l3bQ1RGll
        lqNKDr/+90dqPy8cyigplApMF1n/LvDBvK/PQnek6V97Gzm/9sThjisGeQtVstb+Xtrn5pWe
        +eLe+9JLRvZmK9c8CGO2fvLr0gYlluKMREMt5qLiRAAF7VPd8AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The former is by far more common in our codebase.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index cb1f528cbe..fa5d2b6f08 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -105,7 +105,7 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
 		struct packed_ref_cache *packed_refs = refs->packed;
 
 		if (packed_refs->lock)
-			die("internal error: packed-ref cache cleared while locked");
+			die("BUG: packed-ref cache cleared while locked");
 		refs->packed = NULL;
 		release_packed_ref_cache(packed_refs);
 	}
@@ -397,7 +397,7 @@ static void add_packed_ref(struct files_ref_store *refs,
 	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
 
 	if (!packed_ref_cache->lock)
-		die("internal error: packed refs not locked");
+		die("BUG: packed refs not locked");
 	add_ref_entry(get_packed_ref_dir(packed_ref_cache),
 		      create_ref_entry(refname, oid, REF_ISPACKED, 1));
 }
@@ -1324,7 +1324,7 @@ static int commit_packed_refs(struct files_ref_store *refs)
 	files_assert_main_repository(refs, "commit_packed_refs");
 
 	if (!packed_ref_cache->lock)
-		die("internal error: packed-refs not locked");
+		die("BUG: packed-refs not locked");
 
 	out = fdopen_lock_file(packed_ref_cache->lock, "w");
 	if (!out)
@@ -1367,7 +1367,7 @@ static void rollback_packed_refs(struct files_ref_store *refs)
 	files_assert_main_repository(refs, "rollback_packed_refs");
 
 	if (!packed_ref_cache->lock)
-		die("internal error: packed-refs not locked");
+		die("BUG: packed-refs not locked");
 	rollback_lock_file(packed_ref_cache->lock);
 	packed_ref_cache->lock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
-- 
2.11.0

