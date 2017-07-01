Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C6D20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbdGAScf (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:32:35 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45228 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752143AbdGAScV (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:32:21 -0400
X-AuditID: 12074412-b97ff70000000fed-e4-5957eab12f59
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id F1.75.04077.1BAE7595; Sat,  1 Jul 2017 14:32:17 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBe010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:32:15 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 27/30] commit_packed_refs(): remove call to `packed_refs_unlock()`
Date:   Sat,  1 Jul 2017 20:31:05 +0200
Message-Id: <99cb6a5eb837f50f7ef39deca98e4794316b3ca2.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLvpVXikwc7DTBZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGVcuryWreCPaMWe7QuYGhgnCHUx
        cnJICJhIPL16jhnEFhLYwSTxoAnKPskkMe0RO4jNJqArsainmQnEFhFQk5jYdoili5GLg1lg
        ErPE22sLwRLCAqESp149BmtmEVCVeH3pNRuIzSsQJXFrVT8rxDJ5iV1tF8FsTgELiT9t66GW
        mUs0H+xjmcDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrplebmaJXmpK6SZGSMgJ7WBc
        f1LuEKMAB6MSD++GkLBIIdbEsuLK3EOMkhxMSqK8K6+FRgrxJeWnVGYkFmfEF5XmpBYfYpTg
        YFYS4c19Hh4pxJuSWFmVWpQPk5LmYFES5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEkwTvpJVCj
        YFFqempFWmZOCUKaiYMTZDgP0PCFd0GGFxck5hZnpkPkTzHqcrya8P8bkxBLXn5eqpQ4byvI
        IAGQoozSPLg5sFTxilEc6C1hXgZg4hDiAaYZuEmvgJYwAS0RnhECsqQkESEl1cC4jX+9l4x7
        Q4VJYqeJ5KSzaUceGyvYdtxuztw478HJ6QZM+h78J1U0JXZ83Ta94hevw1rFiRfTZdnubJBk
        KpecdIIj22D/v1SWfj+9Oy67X93uW1/vd0rZyML77snvYpMsXf5WJMwXOCSz997cryv+vZ91
        NVmDP6biTLj2Lt/dc5br12st7l6qxFKckWioxVxUnAgA05spZPACAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead, change the callers of `commit_packed_refs()` to call
`packed_refs_unlock()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c  |  2 ++
 refs/packed-backend.c | 18 ++++++++----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8ea4e9ab05..93bdc8f0c8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1131,6 +1131,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 
 	if (commit_packed_refs(refs->packed_ref_store, &err))
 		die("unable to overwrite old ref-pack file: %s", err.buf);
+	packed_refs_unlock(refs->packed_ref_store);
 
 	prune_refs(refs, refs_to_prune);
 	strbuf_release(&err);
@@ -2699,6 +2700,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 	}
 
 cleanup:
+	packed_refs_unlock(refs->packed_ref_store);
 	transaction->state = REF_TRANSACTION_CLOSED;
 	string_list_clear(&affected_refnames, 0);
 	return ret;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 96d92a5eea..5cf6b3d40e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -606,7 +606,6 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(refs);
 	int ok;
-	int ret = -1;
 	struct strbuf sb = STRBUF_INIT;
 	FILE *out;
 	struct ref_iterator *iter;
@@ -619,7 +618,7 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 		strbuf_addf(err, "unable to create file %s: %s",
 			    sb.buf, strerror(errno));
 		strbuf_release(&sb);
-		goto out;
+		return -1;
 	}
 	strbuf_release(&sb);
 
@@ -660,18 +659,14 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
 	if (rename_tempfile(&refs->tempfile, refs->path)) {
 		strbuf_addf(err, "error replacing %s: %s",
 			    refs->path, strerror(errno));
-		goto out;
+		return -1;
 	}
 
-	ret = 0;
-	goto out;
+	return 0;
 
 error:
 	delete_tempfile(&refs->tempfile);
-
-out:
-	packed_refs_unlock(ref_store);
-	return ret;
+	return -1;
 }
 
 /*
@@ -705,6 +700,7 @@ int repack_without_refs(struct ref_store *ref_store,
 	struct ref_dir *packed;
 	struct string_list_item *refname;
 	int needs_repacking = 0, removed = 0;
+	int ret;
 
 	packed_assert_main_repository(refs, "repack_without_refs");
 	assert(err);
@@ -740,7 +736,9 @@ int repack_without_refs(struct ref_store *ref_store,
 	}
 
 	/* Write what remains */
-	return commit_packed_refs(&refs->base, err);
+	ret = commit_packed_refs(&refs->base, err);
+	packed_refs_unlock(ref_store);
+	return ret;
 }
 
 static int packed_init_db(struct ref_store *ref_store, struct strbuf *err)
-- 
2.11.0

