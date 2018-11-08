Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 557AA1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 04:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeKHO2k (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:28:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35291 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbeKHO2k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 09:28:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so8333613pgu.2
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 20:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TEACPUbf9LKilUsENgqE1AsKA4VNCAyaGbrfWRTpqTs=;
        b=pa8ckZ5SJ1SyZxz4dC/o+fkC4L+IcPGOGT7Ob+cZy+vNyusQAUr1BH2+YHZOvsftdM
         NSmWQ9OIiXa13jByVMVxdZDpa8220u9gyC0+ypXNHsFBq+LLZ3RRZTMhhx/oxlMsTVWj
         74JJ17DYWm8EfzmEyRfv4TsiwewSIyKajSAYI4p4HVP43bKZE4fIQdjJxAZry78fKT/T
         L3hTouzxnRm90Ss7zRYoeirzf/zAubqgh1b2TdHRqTWc9DI9txpAhdw37lbOnbKrX8JD
         3pZIAuOMAqYlLlAI1kLtHhCMedZFXUPD5198iRBcKHH5HO8yvgRLSnhiF7jyEeg4TrCI
         nt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TEACPUbf9LKilUsENgqE1AsKA4VNCAyaGbrfWRTpqTs=;
        b=XHTZ8js3nvbqnKlaFL0jIoTDiKdi9dldIY+LP32tM5BuhgBpYrP4uR7A6hYeChKrFT
         TKHr9P2JcvFMRdaUwfDIXrpyfh5GmHRiy/Vw9F9eF8nAvCUkzsC58GN2pFKypxhxsAYR
         OLzDgEocJsgk905j45hu6gt5MYdZdDl3GTFueADJDwmh9accXfnfsfMQ40egasP4hFcE
         oxGdrBZ/xOOjbdk0pvCNWssQDzLcMBLO9J/ETBGDCUdRMcXDNOsV5WFE3C2lflrQVG59
         SogmE1irdmxosUV7UNUlYsu+oB636uTIbs+SL2lACNUb9cnBxjnTLh3ExxSVcttg3CMv
         ylmw==
X-Gm-Message-State: AGRZ1gIA6R9QHV8ZQZFbMJllVEvli2Ta3jyzstHfBkIbcz0MSJjjdw+T
        RXcVpFMgNpmCl3GPioR4pE8wVIlo
X-Google-Smtp-Source: AJdET5fReSqWWdnpNom5idl8rsUNUxbJ6NCi36anOjx59l30fkyQZC+7ngZoVWNzRxYJXreZlv/zrg==
X-Received: by 2002:a63:e055:: with SMTP id n21mr2654038pgj.397.1541652901154;
        Wed, 07 Nov 2018 20:55:01 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id d3sm1830520pgl.64.2018.11.07.20.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 20:55:00 -0800 (PST)
Date:   Wed, 07 Nov 2018 20:55:00 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 04:54:53 GMT
Message-Id: <06e9685d2bcef99d6635bd928845156b1580062f.1541652896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v3.git.gitgitgadget@gmail.com>
References: <pull.69.v2.git.gitgitgadget@gmail.com>
        <pull.69.v3.git.gitgitgadget@gmail.com>
From:   "Force Charlie via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 2/4] support force use http 1.1
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Force Charlie <charlieio@outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Force Charlie <charlieio@outlook.com>

Signed-off-by: Force Charlie <charlieio@outlook.com>
---
 http.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index 99cb04faba..b2ec31aef5 100644
--- a/http.c
+++ b/http.c
@@ -48,7 +48,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
 
 static int curl_ssl_verify = -1;
 static int curl_ssl_try;
-static int curl_http_version = 11;
+static int curl_http_version = 0;
 static const char *ssl_cert;
 static const char *ssl_cipherlist;
 static const char *ssl_version;
@@ -811,11 +811,14 @@ static CURL *get_curl_handle(void)
 		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2);
 	}
 
-#if LIBCURL_VERSION_NUM >= 0x073100
-	if(curl_http_version == 20){
-		/* CURL Enable HTTP2*/
-		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_2);
-     }
+#if LIBCURL_VERSION_NUM >= 0x074700
+    // curl_http_version 0 is default.
+    if (curl_http_version == 20) {
+		/* Enable HTTP2 when request TLS*/
+		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_2TLS);
+    } else if (curl_http_version == 11) {
+		curl_easy_setopt(result, CURLOPT_HTTP_VERSION,CURL_HTTP_VERSION_1_1);
+    }
 #endif
 
 #if LIBCURL_VERSION_NUM >= 0x070907
-- 
gitgitgadget

