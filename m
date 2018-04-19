Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266451F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeDSMWv (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:22:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:38049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751840AbeDSMWu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:22:50 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lpxdr-1eXLee382J-00fn53; Thu, 19
 Apr 2018 14:22:43 +0200
Date:   Thu, 19 Apr 2018 14:22:27 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v7 11/17] rebase --rebase-merges: add test for --keep-empty
In-Reply-To: <cover.1524139900.git.johannes.schindelin@gmx.de>
Message-ID: <95863516e312bca6f8ae3cd884c1d2dbbb411f84.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vHLArcl2TRYIRvVwV/bVijpcOWOALCdBony6rvIvc7opybbjmw7
 SfYoUaBMTfQ8xuBnuph+2NIE12xEN/w85XGzxax4LTNo+qgcl2JWNtg8oCC/U4uXw+WJBQZ
 2sCR8ZYU+cAdvxwXlNhnJzSY+dObDkJ/9wpoWgyy4/d3yuAWkys23x/IZk5kLtXgg7diYjf
 1Ez4SfXC+d4RqVDJJbaKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c1Ko097OVFU=:FZxslmzmtLFEZfWs41Zy8W
 scUUgliPlzP9KMAgoHzr/j2zCqWcPdwnyCLU+KKIMscoPqym713YKPHhOaFKvZe3t5tBnuPJ1
 JiPHLy/9rPsaew5CmYLgB2vGzV/dc6s9LGXjmTCkt7zp8IOzuc2aXya5J8AUrDqnLzs2XHnjh
 XHJF7oN6Hz/TsnTi132n+W2O7Rvho8FrWDnckY8yTK4odYG9Ectjld/40c0na96fvI21/eIhu
 nLqGwL8yYoWH4fUbMTeLP+T/aBXf/j+tp2Aa70GndR4goft+CZOXjLzfFgIvcPS0fAHBzuFVj
 qpBijiSF7FCpOCH77B36YkfdkjVJMjvgxK09eWJTtxfF8qxA4prHwWBZUHNMMRM8LKBdTncgm
 bdY96C5583INVUyv0M0YSNdBHYmjzRf8u+hCcbuIHo5XSCSmnuwxSWa5vIScseaug1MTiQwbt
 Ro4zETs82KMdclCF7A/BYk2V/NOoGeJSHDdqGO0pfSQys+QxGkNeVAXk5EqQurXtOeaq7C0Li
 CJb/eS7E+++avZ1p6ZafKVQI2S4ESOxrLUD6nZF9kZIQKwIEdvwKK2nvfnl1AKMpStgg5JAM9
 qeGFaXsDjibH1FTFYtueeEeIALma2jDggYpL75SKqDWGsnJ8AqalhN1nk7/0OSIoeJYjHIjbM
 eUGkPMHKwyyG3qgPZhs1dVqhCS5qkIgxazevyrCbdAz2vOopudMHdhvXkp7jNgKCsysV3kBT2
 gAmsUMlpUQOpXZ+ZF44lIShKxD8+WHYzab7uv44XLL10zuvz9qSxpB4wPRNNSTgcMfsmtdezx
 63O3iBH7apPNsnNHQArEZuaUiDEQnpUJDsi7R5GmxC0ij936bk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there are empty commits on the left hand side of $upstream...HEAD
then the empty commits on the right hand side that we want to keep are
being pruned.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3421-rebase-topology-linear.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 68fe2003ef5..fbae5dab7e2 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -217,6 +217,7 @@ test_run_rebase success ''
 test_run_rebase failure -m
 test_run_rebase failure -i
 test_run_rebase failure -p
+test_run_rebase success --rebase-merges
 
 #       m
 #      /
-- 
2.17.0.windows.1.4.g7e4058d72e3


