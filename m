Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453901F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbeHMWGo (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:06:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38755 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbeHMWGm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:06:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so15211422wro.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMqpRXHHmR8XXsEptmWHLfgKgCYyzYrp4NYGSisFwsE=;
        b=Pj6mgAZF66lpvJ6jBgBQEEsm+ylnMzIZeryEmXxLHDgEOnQ7UjwxRMoAAxzLoABmfT
         ogtKvimwAfTz9MGQ7ARJZZUwKYg0AQnIiqRS2zFRLsLaEjaKba+daBuRM9VFtdKVsyTX
         HJY8y94UHDhz74cD2yQCFqnRy/mXgI9E7NEC1a0b+1az2GH5ru1pCrltaonsi9Rz60uB
         /dgL9pnEONIuPitZtzCZNL/0zrD6Cj540/tT7T2BdoSx/Qv8fqfLI0SI6dxdxoUdNBK/
         1TrVAuLvlyiRGA/U6uCOJY3zkjBBcUXV21+QBa/zvOyoQA6nTyn9Nd51wTOpeqBARKpu
         MQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMqpRXHHmR8XXsEptmWHLfgKgCYyzYrp4NYGSisFwsE=;
        b=DYqVYmmkINUr/tN7cKLhLH36T+jZKS8O0zb0umiiHxfGxgh6d8vP+V1zbLDHrvqjrR
         +mniqtCYIbLk9N/FiRiozfZreUTCjhLwU6RZjfQPaeVw2Vf+kL0JRn2RhrNUDBg9zf6i
         EucaQPYprDBLOH1i5+zJIGwg/ccJYmZEVFi7gM6giQzIad47pJ4H9kRs3+8NM1g9YAbD
         hnl86EC/1boiNzjSEdUL9ZjOKylY5Es8BSCQ7IAtcfYRW+FCia1e834vclosRxPFr4L+
         D4akV+3yr4KyGwSSf94lRTCBNKgWaUpG5snZLXf14uexneHBjmSkwbjyMVzdgPlwiha5
         lKrw==
X-Gm-Message-State: AOUpUlHOq0R5V4o8lrALiBa8w8CNWyCAIvZUSaxGHMdg0HXiIQysPhU0
        I2QBgzzDa3nPJcuNIGmmfHwiX/v9
X-Google-Smtp-Source: AA+uWPwQ7CFdlPVAQyTz8jrOv+GyclyaozSrdpwc0/YvEEPe13pk9kA0I8GXrIyTABnONErQOsvAPw==
X-Received: by 2002:adf:9a0b:: with SMTP id z11-v6mr10885671wrb.47.1534188187285;
        Mon, 13 Aug 2018 12:23:07 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l72-v6sm34929545wma.17.2018.08.13.12.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 12:23:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/7] push tests: remove redundant 'git push' invocation
Date:   Mon, 13 Aug 2018 19:22:44 +0000
Message-Id: <20180813192249.27585-3-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180731130718.25222-1-avarab@gmail.com>
References: <20180731130718.25222-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove an invocation of 'git push' that's exactly the same as the one
on the preceding line. This was seemingly added by mistake in
dbfeddb12e ("push: require force for refs under refs/tags/",
2012-11-29) and doesn't affect the result of the test, the second
"push" was a no-op as there was nothing new to push.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2cbe459ee6..59d7ea689a 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -973,7 +973,6 @@ test_expect_success 'push requires --force to update lightweight tag' '
 		cd child1 &&
 		git tag testTag &&
 		git push ../child2 testTag &&
-		git push ../child2 testTag &&
 		>file1 &&
 		git add file1 &&
 		git commit -m "file1" &&
-- 
2.18.0.345.g5c9ce644c3

