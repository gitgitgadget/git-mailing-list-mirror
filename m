Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AAA11F935
	for <e@80x24.org>; Wed, 21 Sep 2016 18:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936356AbcIUSfG (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:35:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:61194 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933594AbcIUSfF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:35:05 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MBFUT-1bfOVa1cEn-00AGUT; Wed, 21 Sep 2016 20:34:51
 +0200
Date:   Wed, 21 Sep 2016 20:34:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benjamin Kramer <benny.kra@googlemail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 1.5/3] fixup! regex: -G<pattern> feeds a non NUL-terminated
 string to regexec() and fails
Message-ID: <alpine.DEB.2.20.1609212030250.129229@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:u+9vL7mHhaTPkqHZtYiY9eeG3/8wWEK+e8e7GOhA3VXlmcFCPHI
 /XF7Hb37XvVBavHRt9T29zrNkdDYF+1MM73dzXaymLF5mjg48oxVK5E4SzLqjuBonycuW5N
 O3lKVkhdmS1KxuQAU9rOL+MesWev1ocao+Ky/xTW4W2O6wEHckU+SuqF1vNKt4VDLc8vl8F
 hopsXzUD4Sde/iJ8N8cMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x/h1p/zVJqE=:/CxpEICwLYfQcTPfrBeXuv
 8ecryxdZe+UJMJKW2UtHy6zamLaUMeVlh53gPqpUVXUFGmRnvYQww8mTK8wGo4lFqU/zR3PuS
 CktXedouG+79CGVtPw681yfq42zq2+HURsYfbVF6otSVCbycoMlBIPEhXLn+ul3tYrCTonXwv
 VSSWqJ7SbWdwvpmCpSkXVLwTtKqHYKC+t0m0JsDqCTKZbpTbprdRneEwfJRTTJYfVcdF2PMqA
 SbzzjK0A0SM5lzTU84iM0m0C1NG875cQj08R6ys9pPj5I93qk5keRWCBMzzqBNul9P7gD9hu8
 W4NbHtXvI7w0q94ifmssEiB1o8Mgkm1sITxu9E2ZapaMK9pMBqIe4YU2XJ/xhkJfhCD0nqyYc
 sbzZq0jZdb3PLIyKfEzHzUxalIaFFyt4j/7qH2Ogg5KzMfw7DY1kgE29lFWd5QhmV0fcAdBV/
 hVde8ToLBiREMp2chJ5AWstqNaxjHNaVKzUG4LovG2gLBGdivWwbBuHjPulmwYFCiTQVuJ6+b
 dtGwwt2IVINXsEqyxjE0SRxdJH19KbyabGmvBFAjUihHONCchOQKtFNEwl/p7WEV1v20H/fWy
 sh+nsYXvqUjwqIg32W0Erc0OmPKlY7o2zuVabXEHALn5M7Drx6p/Zos/vn/em7BwiuMfUNoUS
 i6x9f5+1z5tr/QvdOuwg9e/OFGS32MkCTJPhLYRrhEZsvyxcFx3rTczgr1293RH2OZQSMysoc
 UINnb9jsCHZ2q4QrDOZn65ZDbAwCIy19keDgJdPxl9JXhSdrnBDR1alhghu6zwYY1xjFRLljx
 r4/TfSh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I should have squashed that in, but I *just* noticed the conflict
with 433860f (diff: improve positioning of add/delete blocks in diffs,
2016-09-05).

---
 t/{t4061-diff-pickaxe.sh => t4062-diff-pickaxe.sh} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename t/{t4061-diff-pickaxe.sh => t4062-diff-pickaxe.sh} (100%)

diff --git a/t/t4061-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
similarity index 100%
rename from t/t4061-diff-pickaxe.sh
rename to t/t4062-diff-pickaxe.sh
-- 
2.10.0.windows.1.10.g803177d


