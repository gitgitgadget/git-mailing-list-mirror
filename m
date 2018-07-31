Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105B11F597
	for <e@80x24.org>; Tue, 31 Jul 2018 13:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbeGaOsD (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 10:48:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41019 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732230AbeGaOsD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 10:48:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so16602160wrr.8
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 06:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HvM4dkO5Jy3mqPO3y17k6qzn65hG259wuOvbMA2lxuM=;
        b=rjD6j89Z1i/W5t3Au9iedcOKZHBmC71oUvY1g3bxsU6OZbTVHYg8hvvPj7XX4dTNzi
         WG6FMWhkPPJJyLQ3GTJgIxOqXj8kOjTm0avSd0dsv2RfJkFGl7U2hoGS0EMWdFXyNS3C
         U9LG1CTJsfxqrmWvnTrohugf3XBpnq44PtfKYrf5kPKvVL8Pi5kfZq3EDKGsYlLqO3+H
         LGn+mMWMPkQQgnK6pVqgjzbrgTk5PJXg/oYswJjwRPEe2MEhGucAQXXMPRldNQMIS6h4
         ZU0fBbRHCtOXH6C6lbJdonn1U5axhBLxEANFyiH9vVJdm7OWA9qMKNoyvkFEabO20xTw
         7kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HvM4dkO5Jy3mqPO3y17k6qzn65hG259wuOvbMA2lxuM=;
        b=NVE8uMPzWX/Z3jp+tB3I2ANLCFKNqATqOXVWEvzpyjEky0QRr7cEJndOv3kFYYzc/j
         2gO4QGpBKubSVN79m8p6Tvc+Nbt1/sXcsP6FiFxA9XwxmIyX46EQJIeSyOGZdsG67nC4
         09LG6+1IZg4Z0qnEJx0HAfk+BHiaD/MiODFMRk4v9BCfGUng9iySWXOvBt1eLq2h/+/G
         331YL3l1xv/8jU6i+YTsrf5OUDFlVDYbZi9NKaMxCJF0zGg/5vH7t/LwKpVTl4KEsAMQ
         RCV+Z9xBKW1zBQmdduk7LaqEGOhWg2Rn0KvSOgQKKzYO3XXgb+m01jI/hk4FXaa8gFYU
         bdDA==
X-Gm-Message-State: AOUpUlEHTv0C3a35kh/T0Nru7KhkA8iGb6uqH7mJ61ESaUAxX1XeFGFr
        2ONa6fJIZka8/OCD5PPFxja3WCnmi+Q=
X-Google-Smtp-Source: AAOMgpeonBNh64l4MlIVfCio//jcMP+7rlsuBK+PBl1vUvsog9GK7oZ3z4ZGV6/WURx/jZNBYIiYHg==
X-Received: by 2002:adf:e749:: with SMTP id c9-v6mr21264029wrn.143.1533042466238;
        Tue, 31 Jul 2018 06:07:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p25-v6sm894081wmc.29.2018.07.31.06.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:07:45 -0700 (PDT)
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
Subject: [PATCH v2 07/10] fetch tests: correct a comment "remove it" -> "remove them"
Date:   Tue, 31 Jul 2018 13:07:15 +0000
Message-Id: <20180731130718.25222-8-avarab@gmail.com>
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

Correct a comment referring to the removal of just the branch to also
refer to the tag. This should have been changed in my
ca3065e7e7 ("fetch tests: add a tag to be deleted to the pruning
tests", 2018-02-09) when the tag deletion was added, but I missed it
at the time.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index e402aee6a2..6ab093207a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -613,7 +613,7 @@ test_configured_prune_type () {
 			git rev-parse --verify refs/tags/newtag
 		) &&
 
-		# now remove it
+		# now remove them
 		git branch -d newbranch &&
 		git tag -d newtag &&
 
-- 
2.18.0.345.g5c9ce644c3

