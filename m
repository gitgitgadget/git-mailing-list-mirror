Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0BEA1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 19:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeCWTg4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 15:36:56 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35127 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeCWTgz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 15:36:55 -0400
Received: by mail-io0-f195.google.com with SMTP id e7so16461875iof.2
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hackers-mu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZoZtYRPvd9L4qYnfUpd6sjcYxV1evqSQDeXCNqd+XxA=;
        b=T6jCBP9UwATNUsch8LsnpgfeovBUePTgL2qeucQODz8wgDxhOuJi5+ye8hFiREzfB+
         WX3v2y555Td8Zq0OXIdCOS/jkYaBnScYrFbLf91MYw70/BfQadFMLCAEfa2qd+4TAnf9
         sGq/OzvtaUTaquTAzVVF5YIhtV/s1zD8Sow953Feh7zgnsl5q8P2GvTr7m5aw9eMFgYh
         /RdqGuueUEVrH3dazIukXzhrGGtR8Fu7vLOFbWpTE9J5XdDyef4XaqE3gROPhn8WGsZY
         +QoNhNbVXdVow7PoGLz7LVCWr1y56BxbvCVrueMjPql5VN3PK+dRBAIpaF9p5Q9+T5rN
         nUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZoZtYRPvd9L4qYnfUpd6sjcYxV1evqSQDeXCNqd+XxA=;
        b=uSxb2XFrdLcjQ/WMdgm6HduVHF7A0+LyxV+NaTXN6NudKcAzXJzdHmlF/aZFIii0YR
         KM0GBxYILa1fvv1HFRihoQYY8ZajCTzSvsxVDEhPDyj0fLHy5pJM3S/bLKXbZnuu17yw
         Q+BKqW/vEJmVrN8UuJ60673EPqDWoVbwJijUXsW+do7FktDd36s3ELMoay1pBMxGisHK
         AINaXLdKRF8OOXulmUOVjO8+LkXFwRfpTjXo5IBICI/cRGIU4zEmjZus++Uig6nV+Fhu
         H2M8mQ+XEvtBC/4peOKUEhI6UgYLxXeoFthI7Ow3Qi/aubeNaETIh6DUIfiK1+NK7OhW
         80Qw==
X-Gm-Message-State: AElRT7H/o32L4gtLkYxSqMrxBBhldhVzdUDdhnWYiA5/XfZ1q7hSo3Ol
        oYcQAAuNdegFzxDQz+rBR1lOnnGN
X-Google-Smtp-Source: AG47ELtRo26VrQ0wgtsxsBwrCbNYkanVV2LVGobq79eiHtiWuNlGO2zlcg1q0CMuuZWL+0PwBia5gQ==
X-Received: by 10.107.43.203 with SMTP id r194mr31782863ior.221.1521833814481;
        Fri, 23 Mar 2018 12:36:54 -0700 (PDT)
Received: from voidlinux ([41.136.242.177])
        by smtp.gmail.com with ESMTPSA id 74-v6sm6351155ith.17.2018.03.23.12.36.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 12:36:53 -0700 (PDT)
Date:   Fri, 23 Mar 2018 23:34:35 +0400
From:   Loganaden Velvindron <logan@hackers.mu>
To:     git@vger.kernel.org
Subject: [PATCH v2] Allow use of TLS 1.3
Message-ID: <20180323193435.GA21971@voidlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a tlsv1.3 option to http.sslVersion in addition to the existing 
tlsv1.[012] options. libcurl has supported this since 7.52.0.

Done during IETF 101 Hackathon

Signed-off-by: Loganaden Velvindron <logan@hackers.mu>
---
 Documentation/config.txt | 2 +-
 http.c                   | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce9102cea..b18cb9104 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1957,7 +1957,7 @@ http.sslVersion::
 	- tlsv1.0
 	- tlsv1.1
 	- tlsv1.2
-
+	- tlsv1.3
 +
 Can be overridden by the `GIT_SSL_VERSION` environment variable.
 To force git to use libcurl's default ssl version and ignore any
diff --git a/http.c b/http.c
index a5bd5d62c..25eb84c11 100644
--- a/http.c
+++ b/http.c
@@ -62,6 +62,9 @@ static struct {
 	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
 	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
 #endif
+#ifdef CURL_SSLVERSION_TLSv1_3
+	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
+#endif
 };
 #if LIBCURL_VERSION_NUM >= 0x070903
 static const char *ssl_key;
-- 
2.16.2

