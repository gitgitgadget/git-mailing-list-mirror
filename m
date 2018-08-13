Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078471F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbeHMWGl (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:06:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38754 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbeHMWGk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:06:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so15211354wro.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cj86cpnUeVtxO/3/50lQM/RGXxWRqGUZwLYDehWXqdk=;
        b=dqKRvXVLS2riqFbzF2xbGIcYESc6k0bVAUt8F7UkIECAXHN/BWDhSIX9AHzHIEbM44
         cRP90IkZGtsJJatQ0R4RNRsqdE4QRtevEiQwGq6Hg2+i91m2k02QDyiKiPb+G+79R8f/
         UH70z+w2PW5do+giN3MqfR/djJ0+vAQd8ZHHcznDj2Va+l1Spm9DbaL2/KjDbX3j4qlx
         RseKinsUXjw93QqBTtwqrQtYbeTv+wMgNyKB2NYcS/Q7/pmWr0Me0JicAueWZ5f6QCFM
         rxqjohrJMb2PHRgbN7e+FLpQn44X1sE0w7w17YTSFWv+Sw6giOvCAe7gghpqcRjDkzZm
         pf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cj86cpnUeVtxO/3/50lQM/RGXxWRqGUZwLYDehWXqdk=;
        b=CIYVU2SQHuRqndFbLY8pZiMTNWNX8rzN2PuVBGFaFPsEgrUi472IAsMEm7jZFkOq5D
         SB+gADouubWeyG99a7ksKT0NWXXhww7UeWvfYrECblatBHY3iMYW+d5QPZa0BAEPEXTD
         47vkx+VXbtZJzeXKbsG6otldGGGT0MacDo1OepIO+KAsoOZ5j6hNx1Z750Qzl+SJb+Ur
         7PBlr7FzuT77DfSLQ1de7uTkm1HiWpigvrUDyIYE2aV3YJ24d4rF9N37G5ggspIuUhGo
         Fgz0O3/C3V/CTmkYPo1t4TJLJUFYNCb8bf1BhkT6LTkaCc1P/viVxYEg8ScT+JbGFYHV
         zHuw==
X-Gm-Message-State: AOUpUlHO7QIZgePHvPWdKOVXcIgbkyXQmmDziKX9L1SLeu5VtmqjnU3F
        ENPJy9pnNcgN5Vir2csbJH617zXi
X-Google-Smtp-Source: AA+uWPzdTHRFF+QZjLliRyrouA30unEGymiAXX552PmzVOIRf3/Ppwl4jkVlvn5SzQcQIFhe+ggmSA==
X-Received: by 2002:a5d:4147:: with SMTP id c7-v6mr11803222wrq.61.1534188185288;
        Mon, 13 Aug 2018 12:23:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l72-v6sm34929545wma.17.2018.08.13.12.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 12:23:04 -0700 (PDT)
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
Subject: [PATCH v3 1/7] fetch tests: change "Tag" test tag to "testTag"
Date:   Mon, 13 Aug 2018 19:22:43 +0000
Message-Id: <20180813192249.27585-2-avarab@gmail.com>
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
index bd8f23e430..2cbe459ee6 100755
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

