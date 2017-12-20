Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100E01F404
	for <e@80x24.org>; Wed, 20 Dec 2017 22:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932618AbdLTWRd (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 17:17:33 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:39314 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbdLTWRb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 17:17:31 -0500
Received: by mail-io0-f195.google.com with SMTP id g70so6381838ioj.6
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ZRZdPETG3ekF+KypkLsJRq/T/bpHyUZ39aRFkE3hI0=;
        b=XIqB8zLW3phOtxxcGJEnnurT+BteeSAjWLNuCULVuvh6VQHPk6uFLYB6sfvILB6vKk
         NOsGRlpX2AkauKIA2OpGj4p1LW48YH6bFJWjY+7xHabChtd/8wBqLut6Gj2kpESKl6ZM
         PTQmEIaCJ9ZBUwAr9U3cC5nyLjNxlJpCErkFmlwaX0Ky+XZPow5htr3ieHIIVcPSuWrd
         XWxJ+rGFDM2RPCGKwptX5efw7tc+HyZdZnIl9nbPEiyq/TzCyxcF7ZCSWtu86NdAMZqE
         +PoyQA1up0utfxB6lwSAzdHRnS2JsQcT5j3Unet19KZLrjCHg5ZOpkUCGovN7i7Cafbl
         3MMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ZRZdPETG3ekF+KypkLsJRq/T/bpHyUZ39aRFkE3hI0=;
        b=Oziv8t7X9eg3tbnaAvCBiB9DM/YPV3sJO0DNzXEftmbkl4sfSNwjY4tMzPFQd/INLq
         ncJhBaxcihmZJovbDgXafCtcP7b/icnEP0RDFzctFW67KiS9DTVOZM0E495VNn/I1kfY
         6gKi1CCnd/WEe00FnxQAImVakiJdKoytu7STAgGJveRaJ6f4f7dwRhCjfYDEC5SPI4iU
         qkkfrPi/hVhtrIO4R91axEiSYQAloA8SQRVWIwbM3zEhmH2LBMK7Wdl4CEw97mhkRsxw
         IPPVZcp2GgxaaWRihTtxcFcq0lUQ++RQP/x2oGZjMM+9f4EYXDixn7XGbKwYXiiM0Tno
         QZsQ==
X-Gm-Message-State: AKGB3mKKPKTZGg2CqS3hbWgphYKoGOXE6Xn4YF4Ob22d0IIfKVnrUJBk
        czviuM9+wEZrR5nGwVKOW68S7Q==
X-Google-Smtp-Source: ACJfBovH1Lu/4TLBT4HvzSDF1g/5a+3htUT6U7O3v7jFz/VJihhnRPz+4OsufpKY9dudB6ZRTOzziw==
X-Received: by 10.107.107.6 with SMTP id g6mr10640371ioc.305.1513808250596;
        Wed, 20 Dec 2017 14:17:30 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id a202sm3150661ita.3.2017.12.20.14.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Dec 2017 14:17:30 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] t/lib-submodule-update.sh: clarify test
Date:   Wed, 20 Dec 2017 14:17:22 -0800
Message-Id: <20171220221725.129162-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171220221725.129162-1-sbeller@google.com>
References: <20171220221725.129162-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the local branch name as the upstream branch name to avoid confusion.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 38dadd2c29..d7699046f6 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -664,8 +664,8 @@ test_submodule_recursing_with_args_common() {
 			cd submodule_update &&
 			git -C sub1 checkout -b keep_branch &&
 			git -C sub1 rev-parse HEAD >expect &&
-			git branch -t check-keep origin/modify_sub1 &&
-			$command check-keep &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			$command modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/modify_sub1 &&
 			git -C sub1 rev-parse keep_branch >actual &&
-- 
2.15.1.620.gb9897f4670-goog

