Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2025A1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 12:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfFXMo5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 08:44:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35746 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXMo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 08:44:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so13272099wml.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 05:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KXYMBvEskJGYaM0uiuo4ReAjWp9G3fqwDZM5KtLT4zw=;
        b=Rgf2FzTA5pjbDaGmBODkCSSA+1velQoOmobniSrAA0985bKOe/G0FuULHePy26zaxp
         fGnLEXLImkYDFTpgddVJu0MQoSXI1oU/F3OJs8gsnTmr3G1secui7Fcz0kOSWEfp+65j
         fm8YXdW3FyqcpUKG2Z/YKHMYSZMY+mcIpKqXPqzxUoQEihX7L6ulfxOGcSxr9PwFbPQl
         KqibuTYiGLhm9AeWcgQd2jPun8WM64hxGGcLrmk5Hv3E46J9BrzqwO4j+2Wk/pZgvWLN
         xAYQvOXVuE/8cV4kd/GGBAmPbEz9lNiYqluQ9RlnNmmVOJscKgWzi41bGjEF1MXNm6Id
         C+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KXYMBvEskJGYaM0uiuo4ReAjWp9G3fqwDZM5KtLT4zw=;
        b=Leh9OXdWvKOrXeLdzpOY6wmC9XebkWrQuvgyiQJnyqSPqQuazm/nWTZShuci4KrDEG
         3Kag2ObgVz7lOB1bc9gQZZlnQOGTwIaDQrBGj7iafaVl95WLr28TYdp+91R6RKclZPkB
         KYRhPS2PEm8UD9L0JWuoSxUXE3y4LUGVqfobI/5A+iM4FEYz3CWRJaAFK54tfhSivEU2
         tLiFd7batfHiQXQq0eyHRIGs7Thpne1UF4g1XjJztn0Hxjb/Y2LEPmuZmDXn++55EbFQ
         z1I+TLJps1rZQo7pOvFKyuAv/r4LUJ7lgJBl2TWg12iUPF9fG4aS15JAm8U9aQzF5ly1
         40/g==
X-Gm-Message-State: APjAAAWflBObCmEWl5tezcwYQbJn3ofy8NdpoQnFC74uAx2nJYBsxe4X
        lCtL8E3NeCXOcwMTURXmQqM=
X-Google-Smtp-Source: APXvYqzHIrR5+aekZ7fW9+UQ1AZ54qfMwgNMAS0BwJSdHB7uuRnYaQWRokpGWPlmdHhGiYm+/IIHog==
X-Received: by 2002:a1c:343:: with SMTP id 64mr1933705wmd.0.1561380295314;
        Mon, 24 Jun 2019 05:44:55 -0700 (PDT)
Received: from localhost.localdomain (x4db9a89d.dyn.telefonica.de. [77.185.168.157])
        by smtp.gmail.com with ESMTPSA id i25sm14239615wrc.91.2019.06.24.05.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 05:44:54 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t5551: use 'test_i18ngrep' to check translated output
Date:   Mon, 24 Jun 2019 14:44:46 +0200
Message-Id: <20190624124446.32206-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.589.g5bd7971b91
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The two tests 'invalid Content-Type rejected' and 'server-side error
detected' in 't5551-http-fetch-smart.sh' use "plain" 'grep' to check
that 'git clone' failed with the expected error message, but the
messages they are checking are translated, and, consequently, these
tests fail when the test script is run with GIT_TEST_GETTEXT_POISON
enabled.

Use 'test_i18ngrep' instead.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

The GETTEXT_POISON CI build jobs haven't caught these, because they
don't run the httpd (and svn, p4...) tests.  Should they?  Dunno.

 t/t5551-http-fetch-smart.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index ac74626a7b..cb11f13d6d 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -199,7 +199,7 @@ test_expect_success 'GIT_SMART_HTTP can disable smart http' '
 
 test_expect_success 'invalid Content-Type rejected' '
 	test_must_fail git clone $HTTPD_URL/broken_smart/repo.git 2>actual &&
-	grep "not valid:" actual
+	test_i18ngrep "not valid:" actual
 '
 
 test_expect_success 'create namespaced refs' '
@@ -466,7 +466,7 @@ test_expect_success 'GIT_TRACE_CURL_NO_DATA prevents data from being traced' '
 
 test_expect_success 'server-side error detected' '
 	test_must_fail git clone $HTTPD_URL/error_smart/repo.git 2>actual &&
-	grep "server-side error" actual
+	test_i18ngrep "server-side error" actual
 '
 
 test_done
-- 
2.22.0.589.g5bd7971b91

