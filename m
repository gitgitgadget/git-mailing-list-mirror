Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D97C1F4B6
	for <e@80x24.org>; Sun,  7 Jul 2019 08:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfGGIai (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jul 2019 04:30:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35341 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfGGIah (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jul 2019 04:30:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so5235166wrm.2
        for <git@vger.kernel.org>; Sun, 07 Jul 2019 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHpsrlzp5Lnx2I0k5648FxkcMn9lYUrfU2xTwbpTOPs=;
        b=i5oMuzhPW4Hu2x6OyvLZFPsYUYIfATwAnk3+FWY6QrQUoSabM/vTFiJVIuAiqi77pY
         R6J7N+bC1nxHzhYb/OoMSAtbT2CJYSweVUPv8nEGaub+Q7vOpVeOmEe6/SoeGbqjrnAl
         hlT8eDo2XrqVjxfugZwLLpiEqiWePMXPDzga1vSIDvh25bmrb0MgQXz2LsIVOdbc0PLg
         ZlR6C+W3l9UiwsDCM0idAoUTDQsPh3d5XU1rUwIjhzdhG+IwdzllqrnidWLiKvg6gorL
         +KYTdE0nxn/v2sqPDYktFRBM1Jw98SPKzy4ebDMGAKB/OP5uJcuZQOdsXhnXG/n/BcKI
         Vuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHpsrlzp5Lnx2I0k5648FxkcMn9lYUrfU2xTwbpTOPs=;
        b=oTCUhanQ5wv/Jg0MFMjB1dBU0PWVgWcY8R+ckcLqKG+BmaW8DYrRB7Nk2Q0GJQjtn5
         pbISJ1EJq9J8jdKeExwoJoS/G7wRrjJM441A7U+vn1+bMoDnFaxf5zok4BbDPL6asxQh
         wGUScT2BRcqM79rXuVpPs36b/kt8Ve5Hk/CzqJtwE1VXojX2cxUT5zZ9ax7p9YHMoHgy
         wKuY+XPjA5o2b/OyhwG+gy9SKlewRDLCw05aUJRoC6EVj7sWQLykdybTNPIn2tCZytGP
         ZGIZ6EnAwH3xHZx1Lw/WwTvcmq4d2xQjDe/rIaXvhWo2Ov2K6qPoRPL+GK2ErceGMQER
         9HKA==
X-Gm-Message-State: APjAAAW7mSPJIg7jS7UpMPnY7cOjc+DsXFO0DoxB34iyDO0Nwly331KW
        okfUhbeXE1xpEiCeW6GC3UJkuKsL/L4=
X-Google-Smtp-Source: APXvYqyZz0NPNO7neWpnaGckpCBwtDxi4umo53DaQz4HFEJbC/3SjOHe6kQfps0CF3eleDdsg3voDw==
X-Received: by 2002:a5d:468a:: with SMTP id u10mr12758645wrq.177.1562488235631;
        Sun, 07 Jul 2019 01:30:35 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10c1:a195:f489:5ba4:f140:8c9a])
        by smtp.gmail.com with ESMTPSA id u186sm9606319wmu.26.2019.07.07.01.30.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 01:30:35 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 5/5] t0016: add 'add' and 'get_all' subcommand test
Date:   Sun,  7 Jul 2019 10:30:02 +0200
Message-Id: <20190707083002.7037-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.514.g3228928bce.dirty
In-Reply-To: <20190707083002.7037-1-chriscool@tuxfamily.org>
References: <20190707083002.7037-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's add a test case to test both the 'add' and 'get_all' subcommand
from "test-oidmap.c", and through them oidmap_add() and
oidmap_get_next() from "oidmap.{c,h}".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0016-oidmap.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
index bbe719e950..1d3196d624 100755
--- a/t/t0016-oidmap.sh
+++ b/t/t0016-oidmap.sh
@@ -67,6 +67,32 @@ Unknown oid: invalidOid
 
 '
 
+test_expect_success 'add and get_all' '
+
+test_oidmap "add one 1
+add one un
+add two 2
+add two deux
+add three 3
+get_all two
+get_all four
+get_all invalidOid
+get_all three
+get_all one" "1
+un
+2
+deux
+3
+deux
+2
+NULL
+Unknown oid: invalidOid
+3
+un
+1"
+
+'
+
 test_expect_success 'remove' '
 
 test_oidmap "put one 1
-- 
2.22.0.514.g3228928bce.dirty

