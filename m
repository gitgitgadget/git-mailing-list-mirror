Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6831E1FAD5
	for <e@80x24.org>; Sat, 28 Jan 2017 22:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbdA1WQE (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 17:16:04 -0500
Received: from mout.web.de ([212.227.17.11]:54521 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbdA1WP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 17:15:27 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M89mf-1cKJTG1pbN-00veDv; Sat, 28
 Jan 2017 23:14:43 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] checkout: convert post_checkout_hook() to struct object_id
Message-ID: <b30e5d34-436a-af5f-dbad-b1df464bf303@web.de>
Date:   Sat, 28 Jan 2017 23:14:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:48AoAy8ecWq4sTDVRj8K6+LQhSkmwoY13uHAgyYzGjQ5+BkzSNq
 P72Y0TyuJttZOa2sOAM8WAPF2YAsd+YfFLNg2gsufzvfcgeH+dYCKtpvPsfhV37Pl58tT1c
 iHgFjmRyG2DlWa7ONwdd65Vhicog0AnzdtAtQZwoMWshjDeSaDJG13UD8lpLNsRJAVrFZRo
 XJtWff86qK9uXM9D9GFEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pZJYdsJiaIo=:b79U2mTlfPT/QlitWfymjs
 d+O1Yh6BW/oOws+ia2+wjVHZGtVF05O/3vOpq5MsZ3npa8/EhHVBkTk2WAKFWkb4OXOVGPyLO
 eCdTcyN5b/teFlSB5aVCOaAn04GbZv9f5rJL93/vE3hqJrnXpwhxFfU7F2bSau4FIDK71valR
 cKd+DE/Bn9eg5Etr83ja2g3H0F7YSQw4m9t7IyKPlfOAv7nT3bL3p8SjSSh+v9urglwMzdSdi
 qnm0Nb+wspzXVIKMOTbTytSGFfCteNE8RGTW0fLIvkZA9gnAP0ny04Qjg0J4bd16bEqW5f6Z/
 hIRkQQYPKWWYP8RJCrnGM4woe6tF+EXH5WleclTSkRWS+36Ywcbui4/FJ3P0KfotR7JJLExWl
 Mk0iNr+OgQd0VgiEsGOviAhG8IvwPR0/pcKwPXN3RCpbIiK8/LU/AS/SmUFDFBSzVne8n2SmB
 14tRf668nGtNf/dFrtKYjZMsWCykl/VUmsRlznAbwnVW4STsrt921Zg1WkD4Gw2lVOcmKt/4u
 k2gX7AjBAEylEF6/PeqSntrUfSP1HyZVPxR+6/oHPnvv7vh5+8y/G+jUKoA0zKZWMsGzclvIj
 PPbB6VtqaawL9rtuD7DhjuglAvzzEPhIqEVHsKlnPndIbJxzlgLgS6VrbuMCUWJlOOXSUbIEE
 lZCsqObCiWO9VaVS+dsRjxtKf7fsMJaW3YyDMP1V/JUv4qzMI7mfXdfmKtt59KOSWKeZ3LmPq
 VwrNu+YXG6Otx3t+le+q7zp74sOE6nZjIX3Au5v64WVlYV+9H+EV5VW6V/pONBUl6L83UhBBF
 HXsWfXk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/checkout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index bfe685c198..80d5e38981 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -56,8 +56,8 @@ static int post_checkout_hook(struct commit *old, struct commit *new,
 			      int changed)
 {
 	return run_hook_le(NULL, "post-checkout",
-			   sha1_to_hex(old ? old->object.oid.hash : null_sha1),
-			   sha1_to_hex(new ? new->object.oid.hash : null_sha1),
+			   oid_to_hex(old ? &old->object.oid : &null_oid),
+			   oid_to_hex(new ? &new->object.oid : &null_oid),
 			   changed ? "1" : "0", NULL);
 	/* "new" can be NULL when checking out from the index before
 	   a commit exists. */
-- 
2.11.0

