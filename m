Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0322F20A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753848AbdDPGmc (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:42:32 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56011 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753167AbdDPGm3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:29 -0400
X-AuditID: 12074413-f4fff700000077e1-b4-58f31253f789
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B4.87.30689.35213F85; Sun, 16 Apr 2017 02:42:27 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGN4025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:25 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 03/20] refs_ref_iterator_begin(): new function
Date:   Sun, 16 Apr 2017 08:41:25 +0200
Message-Id: <a8777f4c8eea6c098385a44542137e57d733d860.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsUixO6iqBss9DnC4M9jbou1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGnGUKBTMFK6auX8LcwNjK18XIwSEhYCLx
        sk+1i5GTQ0hgB5PE5N1mXYxcQPYJJolrjY3sIAk2AV2JRT3NTCC2iICaxMS2QywgRcwCj5kk
        /i7rZgFJCAs4SnxtnwNWxCKgKrHkzWVWEJtXIEri39ldbCC2hIC8xK62i2BxTgELiSl3N7BA
        bDaX2H78KvMERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MULCTHgH
        466TcocYBTgYlXh4Lfw/RQixJpYVV+YeYpTkYFIS5ZX5DxTiS8pPqcxILM6ILyrNSS0+xCjB
        wawkwpvM8jlCiDclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwftBAKhR
        sCg1PbUiLTOnBCHNxMEJMpwHaPhWkBre4oLE3OLMdIj8KUZdjr6Oj++ZhFjy8vNSpcR5f4AU
        CYAUZZTmwc2BpYdXjOJAbwnzMgsCVfEAUwvcpFdAS5iAljBM/gCypCQRISXVwBh76+jvi0xL
        6jOv6tnkasd3P1msy/Kq1e0Z55JlR6ZtmaDh3df5iklgZc3qubyVNT6W/dbxSlM+1PPt8fb5
        xDxvW7q08wJ7Sb9YxsZ/z0J/v2Lve3hoztRtcn12G/Y9/HfVTEKPQfV9Hd9XzlAenTk8GV0n
        7zE/Sniv96RUN2RZ9GPF5JSSSCWW4oxEQy3mouJEALrLz4fqAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a new function from `do_for_each_ref()`. It will be useful
elsewhere.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 15 +++++++++++++--
 refs/refs-internal.h | 11 +++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index aa461156c4..2ae18097d4 100644
--- a/refs.c
+++ b/refs.c
@@ -1230,6 +1230,18 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return head_ref_submodule(NULL, fn, cb_data);
 }
 
+struct ref_iterator *refs_ref_iterator_begin(
+		struct ref_store *refs,
+		const char *prefix, int trim, int flags)
+{
+	struct ref_iterator *iter;
+
+	iter = refs->be->iterator_begin(refs, prefix, flags);
+	iter = prefix_ref_iterator_begin(iter, prefix, trim);
+
+	return iter;
+}
+
 /*
  * Call fn for each reference in the specified submodule for which the
  * refname begins with prefix. If trim is non-zero, then trim that
@@ -1247,8 +1259,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = refs->be->iterator_begin(refs, prefix, flags);
-	iter = prefix_ref_iterator_begin(iter, prefix, trim);
+	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
 
 	return do_for_each_ref_iterator(iter, fn, cb_data);
 }
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 6ee9f20dbc..545989ae7f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -335,6 +335,17 @@ struct ref_iterator *empty_ref_iterator_begin(void);
  */
 int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
 
+/*
+ * Return an iterator that goes over each reference in `refs` for
+ * which the refname begins with prefix. If trim is non-zero, then
+ * trim that many characters off the beginning of each refname. flags
+ * can be DO_FOR_EACH_INCLUDE_BROKEN to include broken references in
+ * the iteration.
+ */
+struct ref_iterator *refs_ref_iterator_begin(
+		struct ref_store *refs,
+		const char *prefix, int trim, int flags);
+
 /*
  * A callback function used to instruct merge_ref_iterator how to
  * interleave the entries from iter0 and iter1. The function should
-- 
2.11.0

