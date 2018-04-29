Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6660B1F428
	for <e@80x24.org>; Sun, 29 Apr 2018 20:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754255AbeD2UV1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 16:21:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40338 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754228AbeD2UVX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 16:21:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id j5so11156372wme.5
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RbubgDxowMvVzlswFmDIc4olz5Yt9NhgMKRvk0jSCto=;
        b=jHAkp6CuKhn2TrZJwK0xkIT9xZxUIUgTSzpCIL+OtQMblvh6Ky+jDBb14ApyOa+c/c
         YS/YyTWSw1iPcor92BbwVsDS1GYGlbyjiQZG/VDb6s7rOzu97xWeE0YvFdHvVYMB7+37
         tDdS1osW8dDYwqpjruAmB99AHnSVWRQhXV1eSANpGYu6ZSxYlNh935t6gF6HStWJpGZ3
         AZkH17uqCwLUyelzbQjxUBPSwwBGbyqKqlilVWF4UDLIpj2E+fhI70lJtlLh12yLGHYs
         7mBbie2q9irti8XhUTHDqJdsIG+53k40aHcO9S3VwPKg0u5rNfWVneFjjWKysqETsW1x
         VZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RbubgDxowMvVzlswFmDIc4olz5Yt9NhgMKRvk0jSCto=;
        b=rxoC0dYGyei0D3GDMo48O5Yt4xUq1EtEWkdNSSmHDOvusDkfXn23a7YAxKSlonNjXp
         MhoN4+hMl/clpVtOSvFg26VBqVIyC4ZsA7N19wKMoPkTWC6JMTJsBxULxo7gEi3K0oFY
         RrVvnWAjcHLmn4AO8cuJ0ZvaFesxsYqZoWNzUsx8AEV3vtWqY4taflOO/qyLsHCjg4dV
         ud0QVJP1o0DZkXXinWYR532lM3mE3ifb2xRMGMrr11Avag3Dq+sXCgjbbx5GpI6v1u4a
         kRjagBTMIdKK81VlTijFQDg6xWfMDinAmZcvZErOCNSl0mUfSaL9WWFkMHE4dvEJFJ9K
         uLFg==
X-Gm-Message-State: ALQs6tDUFDDPHUJlVEjxfu+16MjPgcNBHPFxAPfOVl1/vZUnIOyyDbKO
        G7/zB2Ger1eKgUBIafIsRrOnsUrt
X-Google-Smtp-Source: AB8JxZpfqlc6KDe3YqTWjtJrbbz84d2hI2g2HTUYTbsmp6aZ7koKlDp0JcP5/tQKtaoAHHG4gT2l5A==
X-Received: by 10.28.172.194 with SMTP id v185mr5705798wme.67.1525033281594;
        Sun, 29 Apr 2018 13:21:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y42-v6sm8134917wry.21.2018.04.29.13.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 13:21:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/8] push tests: fix logic error in "push" test assertion
Date:   Sun, 29 Apr 2018 20:20:54 +0000
Message-Id: <20180429202100.32353-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
In-Reply-To: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
References: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
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
index 7b5a553398..15c8d5a734 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -979,8 +979,8 @@ test_expect_success 'push requires --force to update lightweight tag' '
 		git tag -f Tag &&
 		test_must_fail git push ../child2 Tag &&
 		git push --force ../child2 Tag &&
-		git tag -f Tag &&
-		test_must_fail git push ../child2 Tag HEAD~ &&
+		git tag -f Tag HEAD~ &&
+		test_must_fail git push ../child2 Tag &&
 		git push --force ../child2 Tag
 	)
 '
-- 
2.17.0.290.gded63e768a

