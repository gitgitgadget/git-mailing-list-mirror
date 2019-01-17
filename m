Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9A61F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 01:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfAQB3k (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 20:29:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42451 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfAQB3j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 20:29:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so9118527wrx.9
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 17:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5hbVaILaJX5uGJgjrjy5f+/yPYzGWA9+uSjFwE47/k=;
        b=sFbcd7q7wFAuZEKzdONvaPKY92mT4JwMSivhVL5NZYtMt5tdMho6wBhhtbD+ISgug2
         xRFIihD6lU3WFYyOCW+81YATUaiw5Gtp/yEs7vvrpfX1u/m/A6g1/3MMpnBaCN8QRvzM
         lLVJFy0sceu5mWldFS/FrWb0EKO1/QSJuej0O9xaoETyl325VU20+IiiclGBpHjjvUVj
         snA6xo6hT/I9sATBielKAP5GT2OypO35B1AcTl7YuPQBkuGSjJ5ruy0dS3l3ckO7TE2X
         9uV5KowMTaA3JAXBhgzg5Oy3Uu7R6OoxoujQ4x6C1vHlkARU3YyIK3CJyrxGyr/G7rTu
         6dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5hbVaILaJX5uGJgjrjy5f+/yPYzGWA9+uSjFwE47/k=;
        b=Uz6K6MnO1Tid9zt1W0uYs+iS39XUvd0Mba3AROHKz1lEQS1qM/OU7YmXlKDfbOV3y6
         4+r1K5EtsxTYKns/VVZkjXcm7sRViHm8AP2Fg66twVHmThYhztca7o2PXmeT64uOwVGJ
         nS2gvtzmr+cGsnAw0wPNArsUDxcGo9MR45KhKe9NXF0uXPNuOx/Gv8DkRPEYRx2JZWP0
         +d11Fw9sCdKPjC2iDd/Qo9iRvUMKfibUDp5Lq/6WIObsSRDoE62zbBSZ/m20HrRFJA0G
         D3a9vem13YoAUu6UiCZfCafqzy5wMB22lfCbe9ge3F6ltQDQ6OhkXH7WKyFSX7VfA6tj
         pSDQ==
X-Gm-Message-State: AJcUukfq0+AgzaXuz4xwHYlSqT1tVdD5E5loSe64E8EBJahv9Abeg0O9
        cvuu3Fma0x+wJcj0nHEH8jrrUuKB
X-Google-Smtp-Source: ALg8bN4puoMe7fdFUubC/LvDZlERJ73CO+2dCDc6icIECJuCyo0xfPjZxZrYODEQbkAW5s6P+pzo2w==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr10176245wrw.304.1547688577207;
        Wed, 16 Jan 2019 17:29:37 -0800 (PST)
Received: from localhost.localdomain (x4db4a994.dyn.telefonica.de. [77.180.169.148])
        by smtp.gmail.com with ESMTPSA id y13sm36818272wme.2.2019.01.16.17.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 17:29:36 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 4/5] travis-ci: switch to Xcode 10.1 macOS image
Date:   Thu, 17 Jan 2019 02:29:12 +0100
Message-Id: <20190117012913.30562-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.499.gf60de1223c
In-Reply-To: <20190117012913.30562-1-szeder.dev@gmail.com>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
 <20190117012913.30562-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When building something with GCC installed from Homebrew in the
default macOS (with Xcode 9.4) image on Travis CI, it errors out with
something like this:

  /usr/local/Cellar/gcc/8.1.0/lib/gcc/8/gcc/x86_64-apple-darwin17.5.0/8.1.0/include-fixed/stdio.h:78:10: fatal error: _stdio.h: No such file or directory
   #include <_stdio.h>
            ^~~~~~~~~~

This seems to be a common problem affecting several projects, and the
common solution is to use a Travis CI macOS image with more recent
Xcode version, e.g. 10 or 10.1.

While we don't use such a GCC yet, in the very next patch we will, so
switch our OSX build jobs to use the Xcode 10.1 image.  Compared to
the Xcode 10 image, this has the benefit that it comes with GCC (v8.2)
preinstalled from Homebrew.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 03c8e4c613..36cbdea7f4 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -8,6 +8,8 @@ os:
   - linux
   - osx
 
+osx_image: xcode10.1
+
 compiler:
   - clang
   - gcc
-- 
2.20.1.499.gf60de1223c

