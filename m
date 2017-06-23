Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE3420401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754645AbdFWHCV (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:21 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59222 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754637AbdFWHCU (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:20 -0400
X-AuditID: 12074412-b97ff70000000fed-33-594cbcf009ea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id B2.9F.04077.0FCBC495; Fri, 23 Jun 2017 03:02:08 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o5p001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:06 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/29] clear_packed_ref_cache(): take a `packed_ref_store *` parameter
Date:   Fri, 23 Jun 2017 09:01:24 +0200
Message-Id: <e74089e81f67bdac4914058fc664faacfad2df74.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqPthj0+kwfPz1hZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGUcnrmJuWAeX8WdlaeZGhgn83Qx
        cnJICJhItPbeZuli5OIQEtjBJPGk5zE7hHOKSWLb54dsIFVsAroSi3qamUBsEQE1iYlth8A6
        mAUmMUu8vbYQLCEsECkxc+l6FhCbRUBV4uab7WDNvAJREkeP7WeEWCcvsavtIiuIzSlgIdEz
        cTk7iC0kYC6x6vdq1gmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrp5WaW6KWmlG5i
        hISd0A7G9SflDjEKcDAq8fAmnPWOFGJNLCuuzD3EKMnBpCTKqxnpEynEl5SfUpmRWJwRX1Sa
        k1p8iFGCg1lJhFdnFVCONyWxsiq1KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampBahFMVoaDQ0mC
        12A3UKNgUWp6akVaZk4JQpqJgxNkOA/QcI/NIMOLCxJzizPTIfKnGBWlxHltdwElBEASGaV5
        cL2wtPCKURzoFWHeRJAVPMCUAtf9CmgwE9DgGWvABpckIqSkGhjN1k3RaeG+WLyuhHum6+53
        +jF/un6ftM7ifnZrv/SP+ckbu1fXS6Q7PjNp/r3pTCp7RtHV3Y7zc4PSNcSD/oizNW3cwn5p
        u480s5KK2ul+zTn+knnz7utlaZ5j9ip5wi8fxfurNdZol4XfI7eDnn5Lt999lfApL2u7zP5r
        WS8rdKdEfGn/nqHEUpyRaKjFXFScCADLT0Z65gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index de8293493f..2b0db60b2b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -120,15 +120,15 @@ static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
 	}
 }
 
-static void clear_packed_ref_cache(struct files_ref_store *refs)
+static void clear_packed_ref_cache(struct packed_ref_store *refs)
 {
-	if (refs->packed_ref_store->cache) {
-		struct packed_ref_cache *packed_refs = refs->packed_ref_store->cache;
+	if (refs->cache) {
+		struct packed_ref_cache *cache = refs->cache;
 
-		if (is_lock_file_locked(&refs->packed_ref_store->lock))
+		if (is_lock_file_locked(&refs->lock))
 			die("BUG: packed-ref cache cleared while locked");
-		refs->packed_ref_store->cache = NULL;
-		release_packed_ref_cache(packed_refs);
+		refs->cache = NULL;
+		release_packed_ref_cache(cache);
 	}
 }
 
@@ -401,7 +401,7 @@ static void validate_packed_ref_cache(struct files_ref_store *refs)
 	if (refs->packed_ref_store->cache &&
 	    !stat_validity_check(&refs->packed_ref_store->cache->validity,
 				 refs->packed_ref_store->path))
-		clear_packed_ref_cache(refs);
+		clear_packed_ref_cache(refs->packed_ref_store);
 }
 
 /*
@@ -1435,7 +1435,7 @@ static void rollback_packed_refs(struct files_ref_store *refs)
 		die("BUG: packed-refs not locked");
 	rollback_lock_file(&refs->packed_ref_store->lock);
 	release_packed_ref_cache(packed_ref_cache);
-	clear_packed_ref_cache(refs);
+	clear_packed_ref_cache(refs->packed_ref_store);
 }
 
 struct ref_to_prune {
-- 
2.11.0

