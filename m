Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DF341F42E
	for <e@80x24.org>; Wed,  3 Jan 2018 16:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbeACQey (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:34:54 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35117 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeACQeu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:50 -0500
Received: by mail-wm0-f65.google.com with SMTP id a79so3644893wma.0
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sdMq+sZdBZkY+aFtKr+A90bZt9825yNsrVkWP7nVEV0=;
        b=LKqm246QjQQ3IY/URDvJaN4KSBKEhTe3dywkPHtPQ3a6uErr6Kn0S6hB3WAyiCduM/
         qtiUBY02LLzYdMDDuM4Vs/j2l3g92jTuK4Cx3hR3WQGi+rBQ4DoSjgzopSRjESfBVaFV
         j1XUOaD16eUJUIxzcevas7qocQTEdtICQw/b/LyU4sg1plyJw1pxyZra9Aym228+X5u5
         kREXGENWskAXPLFIvNGmdy2m2c+HNYGN9SQgnnkR4OB83ZugKRXY4vwz7OvGJ9ACnNfw
         z7feQzMqtjszWiYnrsdBT93E+NiYp9ORPnhRmMgPUuY47li/wRfg4+A3jsx3g/ZEyjsK
         uLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sdMq+sZdBZkY+aFtKr+A90bZt9825yNsrVkWP7nVEV0=;
        b=kZfKPTRGJesNVpZoBFalamTcGT9o1jTow2GGEfNdPmADtitFXQimF2JzMchxkBbOfR
         0dUzxlH4efv4d6Bg27B4f474DU2/Ua33gDZ+TWC0FSkzCGQabnrxtL5bR41O1ilO3TBn
         xp8iyb+jn0h1UDiW6uHcZ4a+CfOoDx5OPfGaexyt9Go6RN/o7ehWE6xu5OJhiJOAGUfM
         8zCXiY/drbiTy3fSTDdGROTgjZflXz6LacI92IOjkpPhaT1D44BTuNz2ZIs9/qofBIup
         zaI2RwoYj8Vxq81Gi65FTn8gEQs+ua/B/7Ljcf4zMbJuv8NqY3iY7Y2Psak56vu2TtPm
         p2UQ==
X-Gm-Message-State: AKGB3mLqcZss3oOiht7oVos0Y1VLlhza95efJWxoieQm66rVWXETcPO7
        DIObxjY7s6RYil4+JYwlbDsgievq
X-Google-Smtp-Source: ACJfBouY0RbBTZcw2g1d+I2hRVUY/a1hRsM3F/oxS9fkxdMVzXhJ7IrlbPMMlJLgnf5Eng7+ej694w==
X-Received: by 10.28.19.195 with SMTP id 186mr1819181wmt.20.1514997288666;
        Wed, 03 Jan 2018 08:34:48 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:48 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 21/40] t0400: add test for external odb write support
Date:   Wed,  3 Jan 2018 17:33:44 +0100
Message-Id: <20180103163403.11303-22-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 4ccca1e965..f924de870f 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -69,4 +69,12 @@ test_expect_success 'helper can add objects to alt repo' '
 	test "$size" -eq "$alt_size"
 '
 
+test_expect_success 'commit adds objects to alt repo' '
+	test_config odb.magic.scriptCommand "$HELPER" &&
+	test_commit three &&
+	hash3=$(git ls-tree HEAD | grep three.t | cut -f1 | cut -d\  -f3) &&
+	content=$(git -C alt-repo show "$hash3") &&
+	test "$content" = "three"
+'
+
 test_done
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

