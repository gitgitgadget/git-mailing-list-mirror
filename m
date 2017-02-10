Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011C81FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 11:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbdBJLQk (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 06:16:40 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58457 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752468AbdBJLQh (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Feb 2017 06:16:37 -0500
X-AuditID: 1207440d-967ff70000000a35-87-589da10ade87
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id F2.1C.02613.A01AD985; Fri, 10 Feb 2017 06:16:28 -0500 (EST)
Received: from bagpipes.fritz.box (p57906495.dip0.t-ipconnect.de [87.144.100.149])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1ABGLLe025185
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 10 Feb 2017 06:16:24 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/9] refs: reorder some function definitions
Date:   Fri, 10 Feb 2017 12:16:11 +0100
Message-Id: <661ef87844918501e84b43d254305e1997af9b57.1486724698.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486724698.git.mhagger@alum.mit.edu>
References: <cover.1486724698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqMuzcG6EwcZVMhZdV7qZLBp6rzBb
        9C/vYrO4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+7x4WOcx4JNpR5d
        7UfYPJ717mH0uHhJ2ePzJrkAjigum5TUnMyy1CJ9uwSujPu7H7IXXBet+HJiGXsD407BLkZO
        DgkBE4kl76cxdzFycQgJXGaUOL3tDAuEc4pJ4taP1WwgVWwCuhKLepqZQGwRATWJiW2HWEBs
        ZpCicwuA4hwcwgL2Ev2fSkDCLAKqEuvOL2EHsXkFoiRuzTrEBrFMTuLSti/MIDangIXEvxNn
        wGwhAXOJ46uOMk9g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdILzezRC81pXQTIyTg
        eHcw/l8nc4hRgINRiYf3Rc2cCCHWxLLiytxDjJIcTEqivN9nzI0Q4kvKT6nMSCzOiC8qzUkt
        PsQowcGsJMJr0wGU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8DIs
        AGoULEpNT61Iy8wpQUgzcXCCDOcBGs4OUsNbXJCYW5yZDpE/xagoJc5bNx8oIQCSyCjNg+uF
        JYRXjOJArwjzioG08wCTCVz3K6DBTECDr5+eBTK4JBEhJdXAWDnBUdLj2Y+oA9P9RF3yJpk2
        sLUoun/hWhM74d6FN3ZXsm4ubFuro7lT+9yNzORXwv1P+n0PbqtMitrIHPfF61F1bfWVW7b2
        L9fZFtUfaL+Xq+81QVlJbcPjskvqdxfPNt7E2XrkWfP52VO2W/X2JqcLlsf63zsdUcPKcHXO
        fbHadI3tTCY2SizFGYmGWsxFxYkAwNGqneMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This avoids the need to add forward declarations in the next step.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 64 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/refs.c b/refs.c
index 9bd0bc1..707092f 100644
--- a/refs.c
+++ b/refs.c
@@ -1358,27 +1358,19 @@ static struct ref_store *main_ref_store;
 /* A linked list of ref_stores for submodules: */
 static struct ref_store *submodule_ref_stores;
 
-void base_ref_store_init(struct ref_store *refs,
-			 const struct ref_storage_be *be,
-			 const char *submodule)
+struct ref_store *lookup_ref_store(const char *submodule)
 {
-	refs->be = be;
-	if (!submodule) {
-		if (main_ref_store)
-			die("BUG: main_ref_store initialized twice");
+	struct ref_store *refs;
 
-		refs->submodule = "";
-		refs->next = NULL;
-		main_ref_store = refs;
-	} else {
-		if (lookup_ref_store(submodule))
-			die("BUG: ref_store for submodule '%s' initialized twice",
-			    submodule);
+	if (!submodule || !*submodule)
+		return main_ref_store;
 
-		refs->submodule = xstrdup(submodule);
-		refs->next = submodule_ref_stores;
-		submodule_ref_stores = refs;
+	for (refs = submodule_ref_stores; refs; refs = refs->next) {
+		if (!strcmp(submodule, refs->submodule))
+			return refs;
 	}
+
+	return NULL;
 }
 
 struct ref_store *ref_store_init(const char *submodule)
@@ -1395,21 +1387,6 @@ struct ref_store *ref_store_init(const char *submodule)
 		return be->init(submodule);
 }
 
-struct ref_store *lookup_ref_store(const char *submodule)
-{
-	struct ref_store *refs;
-
-	if (!submodule || !*submodule)
-		return main_ref_store;
-
-	for (refs = submodule_ref_stores; refs; refs = refs->next) {
-		if (!strcmp(submodule, refs->submodule))
-			return refs;
-	}
-
-	return NULL;
-}
-
 struct ref_store *get_ref_store(const char *submodule)
 {
 	struct ref_store *refs;
@@ -1435,6 +1412,29 @@ struct ref_store *get_ref_store(const char *submodule)
 	return refs;
 }
 
+void base_ref_store_init(struct ref_store *refs,
+			 const struct ref_storage_be *be,
+			 const char *submodule)
+{
+	refs->be = be;
+	if (!submodule) {
+		if (main_ref_store)
+			die("BUG: main_ref_store initialized twice");
+
+		refs->submodule = "";
+		refs->next = NULL;
+		main_ref_store = refs;
+	} else {
+		if (lookup_ref_store(submodule))
+			die("BUG: ref_store for submodule '%s' initialized twice",
+			    submodule);
+
+		refs->submodule = xstrdup(submodule);
+		refs->next = submodule_ref_stores;
+		submodule_ref_stores = refs;
+	}
+}
+
 void assert_main_repository(struct ref_store *refs, const char *caller)
 {
 	if (*refs->submodule)
-- 
2.9.3

