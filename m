Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495631F597
	for <e@80x24.org>; Tue, 31 Jul 2018 13:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbeGaOr7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 10:47:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55872 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbeGaOr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 10:47:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so2995851wmc.5
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ziu7Q46fRQnx80+8whaJjlQnrzU2wxV3XRE5p1yFP0Q=;
        b=BNftb5v8iaoLJByJrpoNAmiPzqHeP9xCIpMrnmRgD2LKgDGSyCLiZyNEXpVJBo7zjx
         X4sqNjfezT+FlCjD1Cew6v1drh/1vyZDnAwrS2cGNcbuXWOLL8dFcNRJnkXBr/V+PAau
         uWjqIvO6EiqIsnXnvaQXLp7Ctg52i55IDQaIywKqnPyhv07xsUYLOrgFLI04li1A6KPl
         AwJ04HwB/Qjqv+XeugUtQnrGHOGy7Q5Ah+reB1WcQUe/0150519bI5SDIN4tzsc9Ntbi
         QIibzoy9foFQInTrJYubyirDD3DhaiKCUxtlbcPkdwEthLGX7QSiJa8Tcaj5jdkal8gt
         dYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ziu7Q46fRQnx80+8whaJjlQnrzU2wxV3XRE5p1yFP0Q=;
        b=XXCi9M9qlKMv2M/jn5cI29Mleax6+9HIlbQmC0hwUZu6ty9mUUiNyxEza5QfBRuvaR
         GRCfhr/jfQBI71JaN0S+QV3U2AoiHIhFPeriYapoPkMHnnu5akf/jEPx5KK8grENjlMe
         Z/McIi4pbohFy2BAEth/kBIzlbnlnfss5rJ5Lt3wdK6fEX0rR2Lj9vHOU4f62HyuA4Y3
         Ww9e765eoo7IgxLcZ6zxRaOeYfsXMOPbiIOyk7TNCXoCqVOlSx39b/poQiTZc8gNlsgX
         13UxIdPusBdm1HW57AnvX9cbJF2m3g6mEfanNkhpm9R67ZqH8c9v2PutEXfUkGF1E2O8
         pT9Q==
X-Gm-Message-State: AOUpUlF9BODZRt0BG6RKIBX07ZIDyilYskeIfWzWWTLhl6OnFNJrZf+5
        oOqIH00FASBV7GOyxflgU9bSPvlMnbI=
X-Google-Smtp-Source: AAOMgpcwbHZSg098A7lwmBx1nSlJq3SNFiSYR07Q4oISbag2ct5hUsN1h4blgfdp1kADZEpyJ5ehUg==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr2319168wmc.68.1533042461387;
        Tue, 31 Jul 2018 06:07:41 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p25-v6sm894081wmc.29.2018.07.31.06.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:07:40 -0700 (PDT)
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
Subject: [PATCH v2 04/10] push tests: add more testing for forced tag pushing
Date:   Tue, 31 Jul 2018 13:07:12 +0000
Message-Id: <20180731130718.25222-5-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the tests added in dbfeddb12e ("push: require force for refs
under refs/tags/", 2012-11-29) to assert that the same behavior
applies various other combinations of command-line option and
refspecs.

Supplying either "+" in refspec or "--force" is sufficient to clobber
the reference. With --no-force we still pay attention to "+" in the
refspec, and vice-versa with clobbering kicking in if there's no "+"
in the refspec but "+" is given.

This is consistent with how refspecs work for branches, where either
"+" or "--force" will enable clobbering, with neither taking priority
over the other.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 82af990ab3..4bd533dd48 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -965,7 +965,7 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 	)
 '
 
-test_expect_success 'push requires --force to update lightweight tag' '
+test_expect_success 'force pushing required to update lightweight tag' '
 	mk_test testrepo heads/master &&
 	mk_child testrepo child1 &&
 	mk_child testrepo child2 &&
@@ -981,7 +981,25 @@ test_expect_success 'push requires --force to update lightweight tag' '
 		git push --force ../child2 testTag &&
 		git tag -f testTag HEAD~ &&
 		test_must_fail git push ../child2 testTag &&
-		git push --force ../child2 testTag
+		git push --force ../child2 testTag &&
+
+		# Clobbering without + in refspec needs --force
+		git tag -f testTag &&
+		test_must_fail git push ../child2 "refs/tags/*:refs/tags/*" &&
+		git push --force ../child2 "refs/tags/*:refs/tags/*" &&
+
+		# Clobbering with + in refspec does not need --force
+		git tag -f testTag HEAD~ &&
+		git push ../child2 "+refs/tags/*:refs/tags/*" &&
+
+		# Clobbering with --no-force still obeys + in refspec
+		git tag -f testTag &&
+		git push --no-force ../child2 "+refs/tags/*:refs/tags/*" &&
+
+		# Clobbering with/without --force and "tag <name>" format
+		git tag -f testTag HEAD~ &&
+		test_must_fail git push ../child2 tag testTag &&
+		git push --force ../child2 tag testTag
 	)
 '
 
-- 
2.18.0.345.g5c9ce644c3

