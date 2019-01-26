Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2081F453
	for <e@80x24.org>; Sat, 26 Jan 2019 21:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfAZVHJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 16:07:09 -0500
Received: from avasout05.plus.net ([84.93.230.250]:51976 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAZVHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 16:07:09 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id nVARg69fbuQOBnVASg5nAv; Sat, 26 Jan 2019 21:07:08 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=JtDfUvwC c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=jzjey2Ge5yg2apLU3XUA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] trace2: fix hdr-check warnings
Message-ID: <ba0549c5-25f1-efcc-e49a-d7e76be73fe3@ramsayjones.plus.com>
Date:   Sat, 26 Jan 2019 21:07:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHYmel5BBPx2q5AN0xWHZRq8iYmU5Y1rWSTE3Q/fkn0K+wSYbeTUh7zwD5kwwrR25lx6zw8pHPlK1tqyDCy4heQ7YKpQKqdNrxG7k1XJZUOxtIxbMY3D
 nCCC+ufxKZ2ClfiDumFVN63hOz2avOVRzYr4w53mAGPE8QH7zE6lnpf3u87UHJv2TyuXmZMUbI/8uA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Jeff,

If you need to re-roll your 'jh/trace2' branch, could you please
squash this into the relevant patches (sorry, I didn't look to
see which patches need to be modified).

Thanks!

ATB,
Ramsay Jones

 trace2/tr2_tgt.h | 4 ++++
 trace2/tr2_tls.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/trace2/tr2_tgt.h b/trace2/tr2_tgt.h
index 4fdf253b57..8a46bbad4e 100644
--- a/trace2/tr2_tgt.h
+++ b/trace2/tr2_tgt.h
@@ -1,6 +1,10 @@
 #ifndef TR2_TGT_H
 #define TR2_TGT_H
 
+struct child_process;
+struct repository;
+struct json_writer;
+
 /*
  * Function prototypes for a TRACE2 "target" vtable.
  */
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index 99ea9018ce..bb80e3f8e7 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -1,6 +1,8 @@
 #ifndef TR2_TLS_H
 #define TR2_TLS_H
 
+#include "strbuf.h"
+
 /*
  * Arbitry limit for thread names for column alignment.
  */
-- 
2.20.0
