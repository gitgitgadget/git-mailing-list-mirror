Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 894CE1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 13:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbeGaOrx (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 10:47:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52310 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbeGaOrw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 10:47:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so2990899wmh.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 06:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=APEE9tR2OEO3es9D94nZGngEKjBOcCshBcFXlgSr8Io=;
        b=V+15GMU9cbJHUY/qL863etkVyxfflqpIMmveAJQ0+2ex5xQinq7TElDmkI8Q2wP3f4
         GYNinjgO9u6xZJFwk3Eyk5NV5LS3sgIOxM2hAjH97sDhkf7tYP8sj76KF4m6nHJ2W9ll
         Kdf2aik/DWJHKYPaHeMpP4Eg8KfJU4JUBarcOlXJQ75r1LQAyNq4+K5HNNCzlGk90lE3
         d3veXMSTEcNXvllBnBC2S0VmzFXbMY2mzZZT/vI0KL2CdFsJF5PMp/6w8PrUk9vY6VYG
         +68WXEOFCw4K9X2xH9zE+zStjzrL5+/GB5U02UsnJwVbjVyCyY+hAj0scj2K58YrNwTS
         YQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=APEE9tR2OEO3es9D94nZGngEKjBOcCshBcFXlgSr8Io=;
        b=GeooDGF0Qdlk7Ul/8I1JQ9X/3GuIEqNf5CAkjL4Sjy7elt3Gj2Ly/826Gjr/Ce4raz
         yjEjt+vFNcsHjtj2l4i2/xtlLmjg0RfkmwU5v7cZQdzE1djk80L2qjnoLvlmfMvpbxfl
         W/GpcEt1WcNWbFhmMveWIzXLpUbnliuq5pyxx4bP90NAMlWezGGXQflry7JFZee5YLP+
         0vPhbeRq3hcU+8wGYWMC98gJZer0+9YOJOjxPu64YiCtfADFlhUaRzc0gUhlfCqMxbqT
         LOC2WZg1B08g5whJcI8wzaFEimZj9H9CyXqWQvguDN+vUK37Y13Db01t/4kFLUBqAvCn
         kLLQ==
X-Gm-Message-State: AOUpUlE/uV6JYm76qDuwF7vkkAmKyaAryP2W/WU/J6bCL2IOOSO0hg0I
        Ua0VSgD1Z6/GletRfbqFycwUyM5fxHk=
X-Google-Smtp-Source: AAOMgpfM0FmTxQgL+PNOCtmHD04s+aCDiOJHXHs9/wAd0cXGTV1R7+CRp3tzygKXyz8mkbzbqj1YIw==
X-Received: by 2002:a1c:a691:: with SMTP id p139-v6mr2215571wme.42.1533042456319;
        Tue, 31 Jul 2018 06:07:36 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p25-v6sm894081wmc.29.2018.07.31.06.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:07:35 -0700 (PDT)
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
Subject: [PATCH v2 01/10] fetch tests: change "Tag" test tag to "testTag"
Date:   Tue, 31 Jul 2018 13:07:09 +0000
Message-Id: <20180731130718.25222-2-avarab@gmail.com>
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

Calling the test tag "Tag" will make for confusing reading later in
this series when making use of the "git push tag <name>"
feature. Let's call the tag testTag instead.

Changes code initially added in dbfeddb12e ("push: require force for
refs under refs/tags/", 2012-11-29).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index a5077d8b7c..08b9cf581d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -971,18 +971,18 @@ test_expect_success 'push requires --force to update lightweight tag' '
 	mk_child testrepo child2 &&
 	(
 		cd child1 &&
-		git tag Tag &&
-		git push ../child2 Tag &&
-		git push ../child2 Tag &&
+		git tag testTag &&
+		git push ../child2 testTag &&
+		git push ../child2 testTag &&
 		>file1 &&
 		git add file1 &&
 		git commit -m "file1" &&
-		git tag -f Tag &&
-		test_must_fail git push ../child2 Tag &&
-		git push --force ../child2 Tag &&
-		git tag -f Tag &&
-		test_must_fail git push ../child2 Tag HEAD~ &&
-		git push --force ../child2 Tag
+		git tag -f testTag &&
+		test_must_fail git push ../child2 testTag &&
+		git push --force ../child2 testTag &&
+		git tag -f testTag &&
+		test_must_fail git push ../child2 testTag HEAD~ &&
+		git push --force ../child2 testTag
 	)
 '
 
-- 
2.18.0.345.g5c9ce644c3

