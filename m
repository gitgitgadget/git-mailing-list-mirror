Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B3112047F
	for <e@80x24.org>; Mon,  7 Aug 2017 14:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbdHGOXd (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 10:23:33 -0400
Received: from 4.mo176.mail-out.ovh.net ([46.105.39.204]:46660 "EHLO
        4.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbdHGOXc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 10:23:32 -0400
X-Greylist: delayed 69073 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Aug 2017 10:23:32 EDT
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 6AF636A703
        for <git@vger.kernel.org>; Mon,  7 Aug 2017 16:04:06 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 7 Aug
 2017 16:04:06 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCH 4/4] imap-send: use curl by default
To:     <git@vger.kernel.org>
References: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
Message-ID: <71479602-fabc-1861-124b-90b26b952344@morey-chaisemartin.com>
Date:   Mon, 7 Aug 2017 16:04:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: EX3.indiv2.local (172.16.2.3) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 8310830164087203805
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkedugdejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 imap-send.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 90b8683ed..4ebc16437 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -35,13 +35,7 @@ typedef void *SSL;
 #include "http.h"
 #endif
 
-#if defined(USE_CURL_FOR_IMAP_SEND) && defined(NO_OPENSSL)
-/* only available option */
 #define USE_CURL_DEFAULT 1
-#else
-/* strictly opt in */
-#define USE_CURL_DEFAULT 0
-#endif
 
 static int verbosity;
 static int use_curl = USE_CURL_DEFAULT;
-- 
2.14.0.rc1.16.g87fcec1e8

