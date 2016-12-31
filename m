Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 039D22078D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbcLaDNj (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:39 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43008 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754672AbcLaDNf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:35 -0500
X-AuditID: 12074412-5ddff700000009b5-32-5867225ec8ee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 79.F7.02485.E5227685; Fri, 30 Dec 2016 22:13:34 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6uD010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:33 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 19/23] try_remove_empty_parents(): rename parameter "name" -> "refname"
Date:   Sat, 31 Dec 2016 04:12:59 +0100
Message-Id: <1397dd5bbe2a9cc5bf2dda5c0bc3eda369edac9a.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsUixO6iqBunlB5hcOe7qkXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4MvYfbmEqmMFR8ehDH3MD4262LkZODgkBE4nOKaeZuhi5OIQELjNKPF2wmxHCOc4kcfXe
        a2aQKjYBXYlFPc1MILaIgJrExLZDLCBFzAITGSWmbbkElhAWiJK4tGMdK4jNIqAqsW/xdbA4
        L1B8/4p1jBDr5CQubfsCNpRTwEJi8ac+sBohAXOJdTsvMU9g5FnAyLCKUS4xpzRXNzcxM6c4
        NVm3ODkxLy+1SNdMLzezRC81pXQTIyR4hHYwrj8pd4hRgINRiYf3wY20CCHWxLLiytxDjJIc
        TEqivJaWqRFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHgXyqVHCPGmJFZWpRblw6SkOViUxHl/
        Llb3ExJITyxJzU5NLUgtgsnKcHAoSfAqKAI1ChalpqdWpGXmlCCkmTg4QYbzAA3vBanhLS5I
        zC3OTIfIn2JUlBLnXasAlBAASWSU5sH1wqL7FaM40CvCvE4g7TzAxADX/QpoMBPQYLWcZJDB
        JYkIKakGxrmqa/Na75yPkJ+1Su/qJFuv4s4+ceU+Bq2p3xS+24T/unFvi0c4F/+uXXeZb+vw
        fE3cuCLGkY/zvtr99gkBdTJ2+lPfzTp4nOvv9ttLPz/6wSvCLrsjUDL9r/4Gee+yGfwdO1cZ
        u22I3DXr0PyChTUvVeME42/MfeC4oJifRTHvQN2epNVrbiixFGckGmoxFxUnAgDMYLujyQIA
        AA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the standard nomenclature.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e81c8a9..0275c8d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2282,13 +2282,13 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 
 /*
  * Remove empty parents, but spare refs/ and immediate subdirs.
- * Note: munges *name.
+ * Note: munges *refname.
  */
-static void try_remove_empty_parents(char *name)
+static void try_remove_empty_parents(char *refname)
 {
 	char *p, *q;
 	int i;
-	p = name;
+	p = refname;
 	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
 		while (*p && *p != '/')
 			p++;
@@ -2306,7 +2306,7 @@ static void try_remove_empty_parents(char *name)
 		if (q == p)
 			break;
 		*q = '\0';
-		if (rmdir(git_path("%s", name)))
+		if (rmdir(git_path("%s", refname)))
 			break;
 	}
 }
-- 
2.9.3

