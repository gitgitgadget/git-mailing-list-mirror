Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C7F2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 14:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdHGOD5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 10:03:57 -0400
Received: from 8.mo176.mail-out.ovh.net ([46.105.58.67]:54039 "EHLO
        8.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdHGOD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 10:03:57 -0400
X-Greylist: delayed 66907 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Aug 2017 10:03:56 EDT
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id D078E65FDC
        for <git@vger.kernel.org>; Mon,  7 Aug 2017 16:03:55 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 7 Aug
 2017 16:03:55 +0200
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: [PATCH 2/4] imap_send: setup_curl: prompt user for username/password
 if not set in config file
To:     <git@vger.kernel.org>
References: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
Message-ID: <38d3ae5b-4020-63cc-edfa-0a77e42798b8@morey-chaisemartin.com>
Date:   Mon, 7 Aug 2017 16:03:55 +0200
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
X-Ovh-Tracer-Id: 8307733938618165213
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkedugdejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 imap-send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/imap-send.c b/imap-send.c
index 38b3c817e..682a06551 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1415,6 +1415,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
 	if (!curl)
 		die("curl_easy_init failed");
 
+	server_fill_credential(&server);
 	curl_easy_setopt(curl, CURLOPT_USERNAME, server.user);
 	curl_easy_setopt(curl, CURLOPT_PASSWORD, server.pass);
 
-- 
2.14.0.rc1.16.g87fcec1e8


