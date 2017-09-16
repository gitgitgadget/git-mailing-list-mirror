Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A0320A29
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbdIPIIL (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:11 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35183 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751316AbdIPIIE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:04 -0400
Received: by mail-wr0-f194.google.com with SMTP id n64so2375162wrb.2
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yJuPloOeBEbOMyEStoyGJ/is7GSk8IPFctchD1pqqR0=;
        b=JzUcTou+aNunWOMsugsvmOVHbtlUVrFpM3PMfpQJP2svDom0M5tsewhjZw1uNzwxy2
         TRkRWJHFdrXDKPta0iZF1quroVlUyrteerB3m+90YSkk8/8TSv1AAEt4wxBAFwyRfDvl
         q+1ZKKfBhV1CqR1gX2ONaHELEQ0S/T3Yz67vuLt2DoRtyYKACE4MJ/KS0ZD2XpGEbwg2
         2FesvG66r2qJ82DNboPt7GkZ9uLv6gTBM+nkMgDb9K7Xa86UiaN31jmHgvbS1lnm9V6+
         sUFKAcYnSZEgvW86jYLvKLH8ffBIBLA/5ydXQqfvVaYi6twPgyeFkbin20avDeqEotO5
         OfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yJuPloOeBEbOMyEStoyGJ/is7GSk8IPFctchD1pqqR0=;
        b=gAWn/i6J9VnCQ3+aGvqqLO/Cfes4qVHreSTSy+6LAtkB+rhk3OvM1Ib+ssVd3NgMNE
         pS9GW4u1GyFomYqZ8DofCie6U4yRSyOq+8XpcSYUhLJM0ABycgPeTyhFGce+q3TtXsE7
         ok9jYfJ3TCUlDVkjyRjENAnzEubKARpxS28Qo90tXOp0T6MPHZxQqtot2MThzl32cFBG
         aXaWFSBk1ArkwYGVjv/LBb9hIFqknr5Fhg0jq2sy3Z72DWLhhSZSwYY9rbw6BMKK5ZmD
         pNlY/q4D3H6utlAhDG3NUw6N9ltWpeV6R/jUi/NgG9uGusT/Hq4lMWdCWw0bJTX0UFRU
         3qRA==
X-Gm-Message-State: AHPjjUju4lG6tdTG4Si++6BLp/OwrAC7evWcrUSaAbXswP4ZR2tYkY5L
        0zejJOWXXh0X4hNN
X-Google-Smtp-Source: ADKCNb5pembIool1e3T0aXyLi7igOhMT1/Rn3JTbMBjZ4tlK97aG+iAT1e3gwtFOLjt9J7SR0uDOdQ==
X-Received: by 10.223.151.54 with SMTP id r51mr20418189wrb.207.1505549282809;
        Sat, 16 Sep 2017 01:08:02 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:02 -0700 (PDT)
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
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 14/40] t0400: add test for external odb write support
Date:   Sat, 16 Sep 2017 10:07:05 +0200
Message-Id: <20170916080731.13925-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index f9e6ea1015..03df030461 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -71,4 +71,12 @@ test_expect_success 'helper can add objects to alt repo' '
 	test "$size" -eq "$alt_size"
 '
 
+test_expect_success 'commit adds objects to alt repo' '
+	test_config odb.magic.scriptCommand "$HELPER" &&
+	test_commit three &&
+	hash3=$(git ls-tree HEAD | grep three.t | cut -f1 | cut -d\  -f3) &&
+	content=$(cd alt-repo && git show "$hash3") &&
+	test "$content" = "three"
+'
+
 test_done
-- 
2.14.1.576.g3f707d88cd

