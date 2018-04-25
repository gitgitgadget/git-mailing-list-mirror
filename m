Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDFB01F404
	for <e@80x24.org>; Wed, 25 Apr 2018 09:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeDYJz0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 05:55:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:60625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751750AbeDYJys (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 05:54:48 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LhTjQ-1eXpi731Jg-00mdUn; Wed, 25 Apr 2018 11:54:43 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v5 10/11] technical/shallow: describe why shallow cannot use replace refs
Date:   Wed, 25 Apr 2018 11:54:37 +0200
Message-Id: <4cbe2ebb4ce3ccdeacdea7be394fbe54f95db848.1524650029.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524650028.git.johannes.schindelin@gmx.de>
References: <cover.1524303776.git.johannes.schindelin@gmx.de> <cover.1524650028.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:84v6CSIXC+vEhXt8xIEaLimNGyDh1Ho0945wKFEGYguIrgpeTcl
 52MZ0PakFJNn7laOUpbTep2bikrqQUQQcMaL5GscZmroYbZ7xjY8nX0vTKcYlfWJdF2jAsB
 qF5RVQhASabikdfE1/zXQgpM16lrpvSJ6WSUANc+ESYgrTRjDwDBkUavqhFW8/Tm+INfaYf
 T7GR++RMKZT+PBLxtLQrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:G1oO0Ns7OjM=:MFC4K3isZQEyUx1KmV7zLY
 qFmxWzQnareSAGz9GmGPttAAnDj7yOJnXHcjLuDt5Aq1ko7dgs5PaahbN2fTxRoRtJiWjJn5c
 JGGlpb3qgqclm4s0hDYYS0cMfTMJweTvK5EBbX+l7O9j5lbkloX/DtSMtAuqrEqQ8xYwEpHdm
 7Lm2TcRMBsaCxfLg43mrpsr51dfH19Pmzy15YlOyO4LoTrbG9MUTChyJb6lgOgZd+kLO7qw+u
 /tS7ihrh9F0nTnIlCPFQ1jyuM3Bojx/qX+9rl/5/WZzG3DZICkB3KTE9wEacoIsCYQVasTtQo
 X0yyifQ/Lv2AI6Kig5wmymJFQGLfjO7nskq0Uv24/RltfmKLom1Ipse9nsfjPfpgMemNrSnQ1
 A8iC2OkUCheBxe6abCiw08MdZmnba0EeYDLIZqZD59MjjQtnR3wNAoCn0Ye2/+9eWJBT3X1UE
 ve71HsWa65ym5vn7uT+GHSeG4Ymigw8bF9E6xMF/8M/JT6x6L8qH5vNfpthJCbaexU2C+gvQL
 XRh1zeYBRVwKcw/Uxc51o2+orpp1TETkHwRaUdyqZWVTp9/wmHH+TAUbRzi3GCuj9xkK3TZn9
 jl8qYStJJCXJxauG1WORqxYofC4UYm3vQ2WcoWo92ikCqagXzPVI/I0qJpVntVZEF2tF/yUZt
 DpcN4px+oUByQFM+i17q7ulqmlZgrYaPD/dtQJWlvHd3ed78VOAWN3F2L/L5udjxzcQ5t1dYZ
 SShkYnWcEV/YNpak0DcavmK5NbBNhQx72G7HYGZbAT5aCBZDUk1sZh8PGtx1OH94FYk05sf6O
 7m+aJYSsAxyKxu66RgGqp4jdezW4y/OIN1xgxsUeo0c1UeTjrhcliobcApJfpvk55A9hzyO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is tempting to do away with commit_graft altogether (in the long
haul), now that grafts are deprecated.

However, the shallow feature needs a couple of things that the replace
refs cannot fulfill. Let's point that out in the documentation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/shallow.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index 4ec721335d2..01dedfe9ffe 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -17,6 +17,13 @@ Each line contains exactly one SHA-1. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
 to discern from user provided grafts.
 
+Note that the shallow feature could not be changed easily to
+use replace refs: a commit containing a `mergetag` is not allowed
+to be replaced, not even by a root commit. Such a commit can be
+made shallow, though. Also, having a `shallow` file explicitly
+listing all the commits made shallow makes it a *lot* easier to
+do shallow-specific things such as to deepen the history.
+
 Since fsck-objects relies on the library to read the objects,
 it honours shallow commits automatically.
 
-- 
2.17.0.windows.1.33.gfcbb1fa0445


