Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37BD21F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbeHMWGq (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:06:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35029 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbeHMWGp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:06:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so9968750wmc.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9gl/DfTNwApGgEcQTvaptLV5+csefq5mrw204qIYiMs=;
        b=WI1ggJSbbQhdBuKoA9gdF9IAvMEGbNO3nFQR7mAMiKBWPbjBYhImmHWgr/mkcktIqs
         cmz9LOk06rCLWYaG3h403FpzKKFhHnCTWxPFveNv5fX0oRLZl+MwaoNayVkObwq9e8ym
         gfq1bx8Tw0U5PKTJDdLsdeccS2lp8gve9rpbm7Yt9eshi4ywd2BUf9i9wxi7bsHeDV2g
         gIqmOjx14iQqOnfKA4/p72ZdAxA++SSR2/By69W7NV0c6dmdCmhJ77muNuRhGtg6pc9B
         YB1BiVrFXF0SqTRcfp+KG7x1Jskx2s7aS6FbCmO8toVD5ZB20Bw4ziAMSM0i+LsbA/SX
         9OQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gl/DfTNwApGgEcQTvaptLV5+csefq5mrw204qIYiMs=;
        b=I+GLtNvdgZtXZGwnTEgZuXuIZB4smW2Nc7D+V9GACRpXiJ0G4s+41irOakx9qmQyWM
         Pxj3rjVy9l1N4HAGLuGLuA/qkN7zuUb8M6cS2+xa3L1Q3S+AZLRxFEYThsMXVwEN70Jd
         z1LVIhU1S2GJGGUHVfouvRECfJzlhIitjda+4Uh0YgZ1N5gjTGm2xDU+ChiE+rrL1/I1
         bxmWXE/M2DRaw5XMgqSEJHHME+aRwkwHYSgRpVAN2O3F/ZXqpQo1QOw4paS8QL/L8S+5
         bXg+nOvtEsBe7sAH+XD4FzdW96Sr9LG/5zGnt7ImCQzKhBMoJMfpm6vikU2US5NTbcn9
         yV3w==
X-Gm-Message-State: AOUpUlEsMt2Ol0Yp/IW55wlTaNoETmVgadQOjZoKAylNDTj9/d7mgfQY
        8mkxg+gb+ZS6q0nqkDOsnyIyjYJG
X-Google-Smtp-Source: AA+uWPxrZ0gc1lmd9A0MxveOznJP3MmGWg3mznvn6ryJa39alrNT7jb6Ve2TR1EioyfP7z2xjfQJ0g==
X-Received: by 2002:a1c:20cb:: with SMTP id g194-v6mr9422874wmg.102.1534188189225;
        Mon, 13 Aug 2018 12:23:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l72-v6sm34929545wma.17.2018.08.13.12.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 12:23:08 -0700 (PDT)
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
Subject: [PATCH v3 3/7] push tests: fix logic error in "push" test assertion
Date:   Mon, 13 Aug 2018 19:22:45 +0000
Message-Id: <20180813192249.27585-4-avarab@gmail.com>
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

Fix a logic error that's been here since this test was added in
dbfeddb12e ("push: require force for refs under refs/tags/",
2012-11-29).

The intent of this test is to force-create a new tag pointing to
HEAD~, and then assert that pushing it doesn't work without --force.

Instead, the code was not creating a new tag at all, and then failing
to push the previous tag for the unrelated reason of providing a
refspec that doesn't make any sense.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 59d7ea689a..fbc44273d9 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -979,8 +979,8 @@ test_expect_success 'push requires --force to update lightweight tag' '
 		git tag -f testTag &&
 		test_must_fail git push ../child2 testTag &&
 		git push --force ../child2 testTag &&
-		git tag -f testTag &&
-		test_must_fail git push ../child2 testTag HEAD~ &&
+		git tag -f testTag HEAD~ &&
+		test_must_fail git push ../child2 testTag &&
 		git push --force ../child2 testTag
 	)
 '
-- 
2.18.0.345.g5c9ce644c3

