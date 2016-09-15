Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B086B2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbcIOSbc (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:31:32 -0400
Received: from mout.web.de ([212.227.15.4]:53782 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751704AbcIOSba (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:31:30 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lym5H-1ayoXN1Nm3-0169DA; Thu, 15 Sep 2016 20:31:06
 +0200
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] contrib/coccinelle: fix semantic patch for oid_to_hex_r()
Message-ID: <423e8ce2-354b-3088-e051-ff44f53806cb@web.de>
Date:   Thu, 15 Sep 2016 20:30:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:xzVBjcCFn3pE4mazfHbXvPQBrouo/JRUh/w2rAnlpKYf9VNAsYN
 pvj8oRrG9ggFXfCSTUl6YfumYHIsa0zzjLNDxYs1MmOKvKXDYv8v71s6lWymK/vSDWtkhkr
 21R3jocxqCpqeBwOG2Vs4GhOGjgu/FMebydh+oG0RRu8l+1A3o9XdC33tlNF/JWR5wYgfwh
 ES4b/9iOsj1cM8zUo+sjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v5Tjo0Ayu7s=:ktVgSCDCHL6LBmlp1D5RZm
 8CHQoWIckv/AQ62+Mebvu2w2qyKFQNtO+bwypXkcVw5cqs/TPWdbT+M2kcbqEqG+vxq4fhQ1B
 ZZDzdLJmNBAZyzBcYykPVY4xxQU1rwC8/6zTzzfUUa/28djX/Esw8G68WqtUYdTEfvZaVKm/N
 +foJvRbmJjjylFxPEo6c+e4CLkv6r1AISXTdP9sRM4KHxlDJN6mMaAtPihCwr1VYPhMTollp3
 zr5sGcAdQngYMlzn8XbWp93YURB0TO3RUspkGo5WL4e+Hbq33PD5ZCzTgLK13Y0BLvYR01XXs
 wradNRTz5w5Eah0qRDWN2fZNkn6scx7xCn91wUOSK5YRrt8dL0R4INtigw4C/3d9hW/zwe4IL
 GjSP4har52D3b5JH7WMDzSiAVgKIuW1GNw7kEOlx0ZEH6BDuZivW8sVawkenYn32wCVO+C7Og
 PxTzTAqCxLdT3wsWC57ONwCWebtEXKXOCVK7mzN0qyAOQZER+bp3z/hVXTnRDGV0Jq1Gpevte
 5SOZZ7ZyB7fxEaz6+H713L3o9sD1q6iHs9wph+nKn6/XBjP1qzv7y0yMz6/c6YdM/WukGQOWT
 J+QnOsZ/0JDuft8eFHFKL0/MOfdeLOyyjvXSRwUv5FfsaqDB2EGSgzP39VLH95tvEfXqMQVyb
 jQujvImzxYFKND5/tVr/khriwe8Z6d9mVPUjDrgazyslvgjK7Mb/K+sJrlKjaxDKEx//Zse/n
 fxIuPcBPKcVAqoS1xei+zF1uM5+Lk0pEsR1yN+aA66f9auyM0vQARUHv0Ek6XV0+zYpvFxLCP
 5TYivdj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both sha1_to_hex_r() and oid_to_hex_r() take two parameters, so use two
expressions in the semantic patch for transforming calls of the former
to the latter one.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/object_id.cocci | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index 8ccdbb5..0307624 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -23,16 +23,16 @@ expression E1;
 + oid_to_hex(E1)
 
 @@
-expression E1;
+expression E1, E2;
 @@
-- sha1_to_hex_r(E1.hash)
-+ oid_to_hex_r(&E1)
+- sha1_to_hex_r(E1, E2.hash)
++ oid_to_hex_r(E1, &E2)
 
 @@
-expression E1;
+expression E1, E2;
 @@
-- sha1_to_hex_r(E1->hash)
-+ oid_to_hex_r(E1)
+- sha1_to_hex_r(E1, E2->hash)
++ oid_to_hex_r(E1, E2)
 
 @@
 expression E1;
-- 
2.10.0

