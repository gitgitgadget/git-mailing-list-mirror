Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024C11F404
	for <e@80x24.org>; Thu,  4 Jan 2018 17:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeADRUQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 12:20:16 -0500
Received: from avasout02.plus.net ([212.159.14.17]:51402 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbeADRUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 12:20:16 -0500
Received: from [10.0.2.15] ([80.189.70.206])
        by smtp with ESMTPA
        id X9BdelrjoUnu3X9Bee0qRY; Thu, 04 Jan 2018 17:20:14 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=DY5nkrlW c=1 sm=1 tr=0
 a=BecK+r/lr4XRfISlKBaA+g==:117 a=BecK+r/lr4XRfISlKBaA+g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=N_ErAeJL6OySSau_Fn0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] utf8.c: mark utf{16,32}_{be,le}_bom symbols static
Message-ID: <e96a7a50-9d4f-c1d6-ecd7-f967b102b58a@ramsayjones.plus.com>
Date:   Thu, 4 Jan 2018 17:20:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIz1UGLVEDeavAo+UG63vZNGpa1ekWKJehFa9IPVMMVg4vJSN3a/0cVsQwln/2Z34ozkcQ2KgAR5U9LW0lTBHBdQS4P1RZTMCTzTblU0gE0RgZXRvgVt
 3qCNcax1iuB7Ep+oJZfXD1q76DXK18JrFVWAu4nf8H5OLRT5Nu4DrrBfD+0GuKfSe6QYA6uTxtjh2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Lars,

If you need to re-roll your 'ls/checkout-encoding' branch, could you
please squash this into the relevant patch (commit d5318db2d0,
"utf8: add function to detect prohibited UTF-16/32 BOM", 2017-12-31).

[yes, noticed by sparse].

Thanks!

ATB,
Ramsay Jones

 utf8.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/utf8.c b/utf8.c
index 1978d6c42..f033fec1c 100644
--- a/utf8.c
+++ b/utf8.c
@@ -544,10 +544,10 @@ static int has_bom_prefix(const char *data, size_t len,
 	return (len >= bom_len) && !memcmp(data, bom, bom_len);
 }
 
-const char utf16_be_bom[] = {0xFE, 0xFF};
-const char utf16_le_bom[] = {0xFF, 0xFE};
-const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
-const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
+static const char utf16_be_bom[] = {0xFE, 0xFF};
+static const char utf16_le_bom[] = {0xFF, 0xFE};
+static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
+static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
 
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 {
-- 
2.15.0
