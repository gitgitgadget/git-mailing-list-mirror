Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB61201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbdEQMHO (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:07:14 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55110 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753464AbdEQMGX (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:23 -0400
X-AuditID: 12074413-0c9ff70000001dc3-e1-591c3cbce7a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0C.8E.07619.CBC3C195; Wed, 17 May 2017 08:06:20 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pg4000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:18 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/23] ref_update_reject_duplicates(): expose function to whole refs module
Date:   Wed, 17 May 2017 14:05:36 +0200
Message-Id: <106ab35ba40da745502da02abac66494208397f6.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqLvHRibS4NBNYYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGmV2/WQpuiVQ0fyhrYNwq0MXIwSEhYCLx
        +bpYFyMXh5DADiaJo+vXMEE4J5gknh1oBHI4OdgEdCUW9TSD2SICahIT2w6xgBQxCzxmkvi7
        rJsFJCEsEC1xp2ENI4jNIqAqMfHlY7AGXoEoiT1fVzGD2BIC8hK72i6ygticAhYS998/Yge5
        QkjAXGL79coJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6+VmluilppRuYoSEmfAO
        xl0n5Q4xCnAwKvHwTuCSjhRiTSwrrsw9xCjJwaQkyrv/AVCILyk/pTIjsTgjvqg0J7X4EKME
        B7OSCO9NU5lIId6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBK+QNVCj
        YFFqempFWmZOCUKaiYMTZDgP0HAukBre4oLE3OLMdIj8KUZFKXHeWCughABIIqM0D64XlgZe
        MYoDvSLMmwfSzgNMIXDdr4AGMwENbgb5iLe4JBEhJdXAyLPD96jM8vvLV3Z8U1pm5HhSOHbV
        ke1fK4V/it9Obf7zoJxZ4lR/0K3da+6Ul7r/L9w8e2df3Om68JgJ8aGPf5d+Wyow4ZeA7dZt
        FnvCWxw5jykErgtQK58w4azldtWZD+1sTkz51779Jqsj58XFCWKv1E5ZLfs8Z545258N18qj
        Ts+atSRMXU2JpTgj0VCLuag4EQDa1tjV3gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It will soon have some other users.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 17 +++++++++++++++++
 refs/files-backend.c | 17 -----------------
 refs/refs-internal.h |  8 ++++++++
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 689362db1e..43d65bc9c6 100644
--- a/refs.c
+++ b/refs.c
@@ -1689,6 +1689,23 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 				  refs_heads_master, logmsg);
 }
 
+int ref_update_reject_duplicates(struct string_list *refnames,
+				 struct strbuf *err)
+{
+	int i, n = refnames->nr;
+
+	assert(err);
+
+	for (i = 1; i < n; i++)
+		if (!strcmp(refnames->items[i - 1].string, refnames->items[i].string)) {
+			strbuf_addf(err,
+				    "multiple updates for ref '%s' not allowed.",
+				    refnames->items[i].string);
+			return 1;
+		}
+	return 0;
+}
+
 int ref_transaction_prepare(struct ref_transaction *transaction,
 			    struct strbuf *err)
 {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f48409132d..d7596b5222 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2524,23 +2524,6 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 	return ref_iterator;
 }
 
-static int ref_update_reject_duplicates(struct string_list *refnames,
-					struct strbuf *err)
-{
-	int i, n = refnames->nr;
-
-	assert(err);
-
-	for (i = 1; i < n; i++)
-		if (!strcmp(refnames->items[i - 1].string, refnames->items[i].string)) {
-			strbuf_addf(err,
-				    "multiple updates for ref '%s' not allowed.",
-				    refnames->items[i].string);
-			return 1;
-		}
-	return 0;
-}
-
 /*
  * If update is a direct update of head_ref (the reference pointed to
  * by HEAD), then add an extra REF_LOG_ONLY update for HEAD.
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2ff65d3ebd..52350c5301 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -169,6 +169,14 @@ int refs_read_raw_ref(struct ref_store *ref_store,
 		      const char *refname, unsigned char *sha1,
 		      struct strbuf *referent, unsigned int *type);
 
+/*
+ * Write an error to `err` and return a nonzero value iff the same
+ * refname appears multiple times in `refnames`. `refnames` must be
+ * sorted on entry to this function.
+ */
+int ref_update_reject_duplicates(struct string_list *refnames,
+				 struct strbuf *err);
+
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify
-- 
2.11.0

