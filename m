Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A771B20248
	for <e@80x24.org>; Mon, 25 Feb 2019 14:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfBYORs (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 09:17:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40308 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfBYORr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 09:17:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id 10so7678665eds.7
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 06:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eodLX6FwTr2DuINIopozXOKG59Ml4UInobyxR3vqqKc=;
        b=q40204fpINqGjRn1RG2lPu3+WKJF0gzWnSrMovt6VAKmJI2vUUYiGt4RJYaeshzJ8n
         FmdVyhvrj9GE8nGqHYEj6ucqDFc37AIwduLaiBw4obCtcndvrIKj114x5n/Q8oAa+FYb
         RLzEElNhNAVT16gnHf2FRQMSczqX4SWAfwWPUx+NtolxHF+XCXHVh27JaUT0bNDkSCra
         MxavxyVLGUIoyUpf0ranEX0fJVI89WOZerYs5ARIdVl3f6xWokF4qKzgxJ/8fSzlXGDU
         RsG/kansGGxKcjeicSkW1y1bfgHNutM3Nb4AnBir0Upe4VV0hgAe8g5UPVBnc9ZofSfi
         aneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eodLX6FwTr2DuINIopozXOKG59Ml4UInobyxR3vqqKc=;
        b=mbNLIKhy4cns2ZeRti81XrkIcZMGKEYR1FIw9H27jbhWTCGF5hF5mZ+12olCoQEPAt
         2Kc5lGjg2Giw8Ox2QNWarbEigmJiRpQr7sX9DdNPaOuw2klZtmF0ylGFDZ6i2DYcFR9/
         EoGlxJURWVzHdlp/9xt/bPK5MitNgRoMW7KQFaDce96c1lXQfwtOO1xDSOEP4ne9l8w3
         gJm7e3Q3vmZ2NxeptmISyIYyZtwF4YbANXIMgnU7omFB/o7UfezVvAf/gte0M1aebNU8
         yGpnD6IKBUqpYnA4XZDXMIdfL1FCx7gyLAyyMunHtDTLFLUf+tM8ZcfBhu+gBERpp5Q/
         p90Q==
X-Gm-Message-State: AHQUAuZHwuqNwPprg2ykEtOYkaGySRPGtTFBcM/+ZgtlkQB6kHguDGQF
        P1pi62paWRYM/kHUE9TrtBZt3XHR
X-Google-Smtp-Source: AHgI3IaU2M0X7pU4EFATkudd/wKJjMzRqjwBCiVBnVH9LnciA2vn+vnv7t/xCrSnWZrjONYwS6qOjQ==
X-Received: by 2002:a50:b6f4:: with SMTP id f49mr14989605ede.80.1551104265724;
        Mon, 25 Feb 2019 06:17:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d47sm2553368eda.77.2019.02.25.06.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 06:17:45 -0800 (PST)
Date:   Mon, 25 Feb 2019 06:17:45 -0800 (PST)
X-Google-Original-Date: Mon, 25 Feb 2019 14:17:43 GMT
Message-Id: <2c3c559da0a5e9b397f4dc80be233c66b8597678.1551104263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.140.git.gitgitgadget@gmail.com>
References: <pull.140.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t5580: verify that alternates can be UNC paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, UNC paths are a very convenient way to share data, and
alternates are all about sharing data.

We fixed a bug where alternates specifying UNC paths were not handled
properly, and it is high time that we add a regression test to ensure
that this bug is not reintroduced.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5580-clone-push-unc.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
index 217adf3a63..b3c8a92450 100755
--- a/t/t5580-clone-push-unc.sh
+++ b/t/t5580-clone-push-unc.sh
@@ -62,4 +62,16 @@ test_expect_success MINGW 'remote nick cannot contain backslashes' '
 	test_i18ngrep ! "unable to access" err
 '
 
+test_expect_success 'unc alternates' '
+	tree="$(git rev-parse HEAD:)" &&
+	mkdir test-unc-alternate &&
+	(
+		cd test-unc-alternate &&
+		git init &&
+		test_must_fail git show $tree &&
+		echo "$UNCPATH/.git/objects" >.git/objects/info/alternates &&
+		git show $tree
+	)
+'
+
 test_done
-- 
gitgitgadget
