Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 384101F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 09:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeCZJ1M (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 05:27:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52063 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeCZJ1L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 05:27:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id v21so14045076wmc.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hackers-mu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JaRGTlXGXfIjByX6NmUIkKP1dRgtMrgiNFQdvk6vw7I=;
        b=S7JpDrNJ4XZfrF8VjksvYRsSZ5UjVAVuy2P1Cr4jASPTCc7zHN8DORi4DT36lgn1GE
         ll0wzjI4Qnssv/hBiJEtDGX6MyIk9B6Kxu6OIJVrEBFDPSo2ev0oAj92ULKaU5MlLIbC
         d+PKMrj2aoOhm2yiJqMsYkWeirbDG5i0l8HePUfqtfTT3+85/PQC3ezvRLsAS8HxkKsq
         +995m6IUcQgbQL3kBN+GBE1ag9fnb2gX1PwZdTyj7J69YiDanU3lBXxANlpvhd5+0TPe
         iJ4O2BwDCAptWfJ5kJe4tVx1bHui4J5UJBNODJ3zx9aT264pfg3Y+3FjCrgoDarhNhop
         kZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JaRGTlXGXfIjByX6NmUIkKP1dRgtMrgiNFQdvk6vw7I=;
        b=hVnkwG+K3a0DON53EAYnmrMn9XEVAxliHyUFhIKVncUe/x/Nqco7xO+buTJ+6aSE0N
         FL+c1fpt005YQ6xArsSeeLWlY460ZBYdR1SkN/jHg0MaEzYp/w0Bse7dpdbA9flfq7wm
         PI2LejrDR05sRNPP/tiA4V7fs4Ztst+qQ0C1zqVRN5fYNU+U50BwbvHmhXl7YsbQPVNs
         TjORZR+HLP3bFGTdJquXKO+M6lzKGmZG6AAXiSYFfyaWcY8JFwP3gGg20VCrSPUpD8GU
         XZEcpyq3dmoMjoOqO86VXqGXssfC+2NoCH7p/hCRzWQMvnN0ajCHEr8zQGvE8F7yUQO4
         6RTQ==
X-Gm-Message-State: AElRT7F5KEg4HOJoZQjoF4V5lEkppW1gU5PkJtO7Pe95t8GfeQ7s3kZx
        +q5BciwR3HiWafX9LZHDpAd1NPQr
X-Google-Smtp-Source: AG47ELtpNbXgIXXxr93D86Gc0NlqwPW7pb14aA0KLfP6McXEpaZ0lrkzxBzciS2Utd1nNEcZ8NlkXw==
X-Received: by 10.28.177.215 with SMTP id a206mr14685410wmf.142.1522056430010;
        Mon, 26 Mar 2018 02:27:10 -0700 (PDT)
Received: from voidlinux ([41.136.240.87])
        by smtp.gmail.com with ESMTPSA id a63sm18844565wrc.22.2018.03.26.02.27.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 02:27:08 -0700 (PDT)
Date:   Mon, 26 Mar 2018 13:24:23 +0400
From:   Loganaden Velvindron <logan@hackers.mu>
To:     git@vger.kernel.org
Subject: [PATCH v3] Allow use of TLS 1.3
Message-ID: <20180326092423.GA7521@voidlinux>
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

Signed-off-by: Loganaden Velvindron <logan@hackers.mu>
---
 Documentation/config.txt | 1 +
 http.c                   | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ce9102cea..f31d62772 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1957,6 +1957,7 @@ http.sslVersion::
 	- tlsv1.0
 	- tlsv1.1
 	- tlsv1.2
+	- tlsv1.3
 
 +
 Can be overridden by the `GIT_SSL_VERSION` environment variable.
diff --git a/http.c b/http.c
index a5bd5d62c..f84b18551 100644
--- a/http.c
+++ b/http.c
@@ -62,6 +62,9 @@ static struct {
 	{ "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
 	{ "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
 #endif
+#if LIBCURL_VERSION_NUM >= 0x073400
+	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
+#endif
 };
 #if LIBCURL_VERSION_NUM >= 0x070903
 static const char *ssl_key;
-- 
2.16.2

