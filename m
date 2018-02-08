Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4AE1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 15:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeBHP5L (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 10:57:11 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55370 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeBHP5K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 10:57:10 -0500
Received: by mail-wm0-f65.google.com with SMTP id 143so10325963wma.5
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 07:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VLzfmwpFaXAuvAY8SHdvYU/9u+L37h/GzY0QQUgjgYA=;
        b=CpS2EMuBunXk91gG1OOdN6xm8f4nau16Wl4k3y/5PLXRMP8i/rKCg/hDre0cQvQb9K
         OeQETdswNvsL5XtkbPtbiaK/Koj5cdaoLWXvGsopca732C6uKLjM2YCaDj6yacjceTWk
         oIZjvlevtJFwAuq8KLJIyYPhdv2vnKJJNC7Y1f2nrwaXP317Qrgw50wfHnsFnAvdxx/8
         Bh0HMsss5M3t5U7zJam2eXKE3Xs3GgW/3ipcI+//kY55B50H7saC2lG9oSwFqL1UShjv
         MWvi9E8RFuShSwzg2+t2zzB4ds6Hw9kDTPciqPuDTZPGDwEFypkOZRPE8zwbtUD2Cdr7
         rJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VLzfmwpFaXAuvAY8SHdvYU/9u+L37h/GzY0QQUgjgYA=;
        b=WD1Jar/W+cH2+IM3wLIMvcfa/KqDxUYLvndwibi7bNmTG2qYCeTce+iXDcFVNgWYro
         RJqALCp4bUAcHRMLKEaIALnAvKlyGklUC7pCPaSDvXsxBxR1EwCpHP0MQOsV6xqs0Lp0
         hrX2URGFhPJRptr03QyUMpI8kPBJnFRN9aH/DSD9r48Le5LUPxGHBhX5wSI5j75tf/cF
         PZz+yiwMFH+lxQUVUznH0xoYWnkFXgOrts8cP45pBYIwjjnSpPDuKQrf1WxqVoX8ElON
         zrQh7o65dotfMVjOR7a2wqErJ7oI33rxfMhHrjvmuYQGgaHFvq07GdG3y0ZB2tEoQQ+Y
         jHDA==
X-Gm-Message-State: APf1xPBI4xySp6PlPLOfvUlAXRaIsb+Hpai9YCvHDCc+N2upbS8a54k+
        eFR8tdEOitP1eWZd7bDw1f8=
X-Google-Smtp-Source: AH8x22575Ffm4MPd2pNTAaKMq4PnOjv3iaf2JguIbYVmWirU0GsuGVvXWYavniPA/mAtCIOQCkfOIw==
X-Received: by 10.28.153.20 with SMTP id b20mr1561968wme.6.1518105429439;
        Thu, 08 Feb 2018 07:57:09 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id p14sm308880wrg.42.2018.02.08.07.57.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 07:57:09 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/9] t5812: add 'test_i18ngrep's missing filename parameter
Date:   Thu,  8 Feb 2018 16:56:49 +0100
Message-Id: <20180208155656.9831-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180208155656.9831-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180208155656.9831-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The second 'test_i18ngrep' invocation in the test 'curl redirects
respect whitelist' is missing its filename parameter.  This has
remained unnoticed since its introduction in f4113cac0 (http: limit
redirection to protocol-whitelist, 2015-09-22), because it would only
cause the test to fail if Git was built with a sufficiently old
libcurl version.  The test's two ||-chained 'test_i18ngrep'
invocations are supposed to check that either one of the two patterns
is present in 'git clone's error message.  As it happens, the first
invocation covers the error message from any reasonably up-to-date
libcurl, thus the second invocation, the one without the filename
parameter, isn't executed at all.  Apparently no one has run the test
suite's httpd tests with such an old libcurl in the last 2+ years, or
at least they haven't bothered to notify us about the failed test.

Fix this by consolidating the two patterns into a single extended
regexp, eliminating the need for an ||-chained second 'test_i18ngrep'
invocation.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5812-proto-disable-http.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index d911afd24c..872788ac8c 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -20,10 +20,7 @@ test_expect_success 'curl redirects respect whitelist' '
 	test_must_fail env GIT_ALLOW_PROTOCOL=http:https \
 			   GIT_SMART_HTTP=0 \
 		git clone "$HTTPD_URL/ftp-redir/repo.git" 2>stderr &&
-	{
-		test_i18ngrep "ftp.*disabled" stderr ||
-		test_i18ngrep "your curl version is too old"
-	}
+	test_i18ngrep -E "(ftp.*disabled|your curl version is too old)" stderr
 '
 
 test_expect_success 'curl limits redirects' '
-- 
2.16.1.158.ge6451079d

