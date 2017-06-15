Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A94C20401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbdFOOsm (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:42 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45443 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752481AbdFOOsj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:39 -0400
X-AuditID: 1207440c-631ff70000002ef9-6e-59429e464c28
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 19.EC.12025.64E92495; Thu, 15 Jun 2017 10:48:38 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbRK014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:36 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 26/28] commit_packed_refs(): remove call to `packed_refs_unlock()`
Date:   Thu, 15 Jun 2017 16:47:31 +0200
Message-Id: <7d23641b9e9d3843fe9ddb36a372c79af79ef465.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqOs2zynSYMc6aYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJWrv7GWPBHtGLh7EfMDYwThLoY
        OTkkBEwkenqns3cxcnEICexgkjjZ+ocFwjnJJPHu0wQWkCo2AV2JRT3NTCC2iICaxMS2Q2BF
        zAKTmCXeXlsIlhAWCJLobdvLCGKzCKhK/Ly8lLmLkYODVyBKYn2LFcQ2eYldbRdZQWxOAQuJ
        2V/WgZUICZhLHFuuMYGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXUO93MwSvdSU0k2M
        kJDj2cH4bZ3MIUYBDkYlHl6FBqdIIdbEsuLK3EOMkhxMSqK8/HJAIb6k/JTKjMTijPii0pzU
        4kOMEhzMSiK8U+cA5XhTEiurUovyYVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxKErzb
        QBoFi1LTUyvSMnNKENJMHJwgw3mAhv8FG15ckJhbnJkOkT/FqCglzusBkhAASWSU5sH1wlLC
        K0ZxoFeEeaPmAlXxANMJXPcroMFMQIODLjiADC5JREhJNTB67qp8p/l2RbzcY06DDT2ZfM2T
        HDs9shJv67//HGq5fPLJS2ovnreHc5mfYfb+N73pFPuZ7OO/QyQd9p97tt8v/bBy9mmd2rOJ
        Suv+PPU4GMr8+pxUT/qq/vr0S5urv6cvaz0RlrDG0GZi3rrSi5YZPRJX/284nMyg9kidu3r5
        5nCLFdfT5/kqsRRnJBpqMRcVJwIAN7fgtuQCAAA=
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
index 802ed9e2e9..09dad2806e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1119,6 +1119,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 
 	if (commit_packed_refs(refs->packed_ref_store, &err))
 		die("unable to overwrite old ref-pack file: %s", err.buf);
+	packed_refs_unlock(refs->packed_ref_store);
 
 	prune_refs(refs, refs_to_prune);
 	strbuf_release(&err);
@@ -2687,6 +2688,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 	}
 
 cleanup:
+	packed_refs_unlock(refs->packed_ref_store);
 	transaction->state = REF_TRANSACTION_CLOSED;
 	string_list_clear(&affected_refnames, 0);
 	return ret;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1732e3aad4..54b48d1f02 100644
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

