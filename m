Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773E51F954
	for <e@80x24.org>; Wed, 22 Aug 2018 12:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeHVQJc (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 12:09:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44049 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbeHVQJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 12:09:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so1485803wro.11
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 05:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=08VA1SYqiPa+QU8ai+g82ZuS373EL3P3+2MnP1uxR7Q=;
        b=ddwxx07KHLvJ6aiHuIMIT0LyvzbsL4dnCZTnPA4KXtcX5Oi6MzwKH9XKDVTXESXrZF
         wUzTSJuNOAXKw6+rwi7SNh8yOn+2tYkt7JNONf+vikqiJ9DVTx/53Po0Z1PE7WPT5qbY
         OVNDZJ/716fggmYe4IZQvGV87vWIj1OVV/+Z0CgLyN51GRadm2XVw/KQnn0SEahoFGpi
         2jllppjvFB2K0UH4BpHPnFbMWpbRHWrKQ200pmnASGdBNAIcyPvzpveds0jxyDmyGudc
         BNIrRjJo8ebiBSeekIWTRJFA1i7JZBAg+bcIz0Z1/55o/vjBfuASCIWh8v0BbgaJDAwq
         bSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=08VA1SYqiPa+QU8ai+g82ZuS373EL3P3+2MnP1uxR7Q=;
        b=a+iEWlz6fplwIUv6PPCQwBI3nZLwokvHs71mNhkpzNWiuBDBP1NrI1RrLiKrih41XU
         DfnJJp9Arhnr2RUMO/1UT0iG+eaZJIiUmX8Iq0zJlCmCJTtDqCSHU8IiwA1+QAZZN8t1
         SG29eUqtNQoyRIL0LPFZZSkZDYsyR/uuRfpkX8JVxzmTsUhAbipE9I+atx3PF0dlIeu8
         JsinmzAu3eaWYyEcmwTa4V7p6CQlC65EQp2/lY5mrmc2csPa4VFk4MYQntAYKHvnc7pm
         vn8K6Sy4HZYA5AmXpfG2JLSQC6ZqQBI3fBQt88QHPE0TtUyJ+UY46OoK+jhGpyZ27PA2
         vfhw==
X-Gm-Message-State: APzg51AQ0SXu/yhBiTvKEm38vvGDNO7peJg/YYnRADwRPSaZdwrHqTJF
        0FY1654Lla2IMMxHqAUi7Gs=
X-Google-Smtp-Source: ANB0Vda9f/Xhqq4vkO69BWtsUgwPn39JcHUSYLpvvMMMVpwpjId808kAeXAwB6YZCE+wjbWBLbKY1w==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr11372189wra.120.1534941884655;
        Wed, 22 Aug 2018 05:44:44 -0700 (PDT)
Received: from localhost.localdomain (62-165-238-147.pool.digikabel.hu. [62.165.238.147])
        by smtp.gmail.com with ESMTPSA id s10-v6sm1931855wrw.35.2018.08.22.05.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 05:44:43 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] t0020-crlf: check the right file
Date:   Wed, 22 Aug 2018 14:44:36 +0200
Message-Id: <20180822124437.11242-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.136.gd2dd172e64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the test 'checkout with autocrlf=input' in 't0020-crlf.sh', one of
the 'has_cr' checks looks at the non-existing file 'two' instead of
'dir/two'.  The test still succeeds, without actually checking what it
was supposed to, because this check is expected to fail anyway.

As a minimal fix, fix the name of the file to be checked.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t0020-crlf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 5f056982a5..854da0ae16 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -160,7 +160,7 @@ test_expect_success 'checkout with autocrlf=input' '
 	git config core.autocrlf input &&
 	git read-tree --reset -u HEAD &&
 	test_must_fail has_cr one &&
-	test_must_fail has_cr two &&
+	test_must_fail has_cr dir/two &&
 	git update-index -- one dir/two &&
 	test "$one" = $(git hash-object --stdin <one) &&
 	test "$two" = $(git hash-object --stdin <dir/two) &&
-- 
2.19.0.rc0.136.gd2dd172e64

