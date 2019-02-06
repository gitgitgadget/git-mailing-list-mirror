Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 986BE1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 00:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfBFAVp (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 19:21:45 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:54359 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfBFAVp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 19:21:45 -0500
Received: by mail-vs1-f73.google.com with SMTP id v199so2162855vsc.21
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 16:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c5eafgfC+uPgjJecVEUZDa4WPYVYyn2cMXyiBBc6yK4=;
        b=JPyy2KwA4Nq75GqztbRw2djV4AyGFDyCxDTKD4nLVlb5un2A1MzSfK3GpYaUbsqQ0O
         R2aze1ZgD/vh5elAjUJtaKJ78dDeSIoHSUQhge/9HwFjnpAeLN+bVf9Sv9Y51zsTGwBj
         PBgxSDsOE+Yd7P/EqGGlvLkqxr4U5N56J3WXNvXcg0EdT32BMTmA5YPMs73WGfLOo7Fi
         IZXyaXL2GA8hvI62sVnjuYpOF26mYQxMeqg1bp5oOzE6vWd1ElF62SNhlsOSGhKnEKvc
         AG1KVa4ahrE4wkD6+ba4X0LOOhuJRz+q0+rp3JwuAyhY4bpatnonp8HewzOR29yLF5LP
         LCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c5eafgfC+uPgjJecVEUZDa4WPYVYyn2cMXyiBBc6yK4=;
        b=YBBz/fi5JrzmboPWH2tER1lLmKerF8JePYkQMWGsd2BIyZjrLgEMorVT3S6Rx9yr7L
         dA1SsrUG1HTqkIWAgNJ8HridZVWeUb/ZV1NrvlrH2DH/3DIrRFzYAIlT+eze90MsrW0p
         rrdcLWP5DZlnZqpN3d2F1a2l9T9sByyAbn8PfXXelLqCgt1UXL7DHpKCN23bGvcJjKud
         BP5nqF2xLkiYT/LLVHNx9KDGOEUUceGw1dy4DW9xvk4DbKF7B00PnMXEYn4VBT4cSwQe
         8ZmL5LEk7pMiZApXiopWP+dmYGBaLS5Nm6h0gADJgArUhx/7pnGbTcPbLbGx4FrbK9y6
         0fcA==
X-Gm-Message-State: AHQUAuYzNODWSW2ln+Z3nguqP7YnKmyliPXx+hnwBuG+jTbDVBP1K0u2
        1QGysb0L6IW/DLu6i54Wwm55FJacv/3FXMNv1y8LYCNR4SQJRis0kOGieLq0CKLW4Q/tLwBRCns
        pu6VrIa1lQMuuhEVrijEs1Zp4D/rVzEA6dwKtkqARCD2CW7E5xhARD26GQUZvpy/s8Y5A/eFBKw
        TL
X-Google-Smtp-Source: AHgI3IZzYfLON33hbHdjxHCQaUgKipxNNw1HyE2C9Rii8mmiLZBnDd0+DOzPux/YfruL8Tuoq+c1Y1xlUd/fOVld8BzS
X-Received: by 2002:ab0:2388:: with SMTP id b8mr4882112uan.16.1549412503853;
 Tue, 05 Feb 2019 16:21:43 -0800 (PST)
Date:   Tue,  5 Feb 2019 16:21:21 -0800
In-Reply-To: <cover.1549411880.git.jonathantanmy@google.com>
Message-Id: <2e8ad7ab247e6b14c0583f0800a228e95bcda095.1549411880.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1549411880.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 7/8] t5552: compensate for v2 filtering ref adv.
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Protocol v2 filters the ref advertisement, but protocol v0 does not. A
test in t5552 uses the ref advertisement, so fix it to use protocol v0.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5552-skipping-fetch-negotiator.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 30857b84a8..8a14be51a1 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -127,7 +127,10 @@ test_expect_success 'use ref advertisement to filter out commits' '
 	# not need to send any ancestors of "c3", but we still need to send "c3"
 	# itself.
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	trace_fetch client origin to_fetch &&
+
+	# The ref advertisement itself is filtered when protocol v2 is used, so
+	# use v0.
+	GIT_TEST_PROTOCOL_VERSION= trace_fetch client origin to_fetch &&
 	have_sent c5 c4^ c2side &&
 	have_not_sent c4 c4^^ c4^^^
 '
-- 
2.19.0.271.gfe8321ec05.dirty

