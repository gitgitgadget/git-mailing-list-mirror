Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833E51F453
	for <e@80x24.org>; Sun,  4 Nov 2018 00:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeKDKDd (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 05:03:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35573 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeKDKDd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 05:03:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id 32-v6so2599723pgu.2
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 17:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6pDFEIO5zGxrkrqAjMqFkMD9TdcofPxijl3fGW4m584=;
        b=Qo+hdPUzD1zA5C2/ozMHanzkk94066TTJzUCjRwNb3XmE/LIWPIaEGP742wpDDzkqc
         Ug1DRjnsE2kOxg/271wO3wuoK95ZKeAfXdQRQqmEbh7cUB2JrKpxnwMc6xIXSjK8zddT
         x85PEkm2ljmUzqihznP0TYjfVT+dxvnMX3OXmAQYVLXwjjR0Hw+Z/VbaFqkWns+hXw9s
         TcBBfsPhvch26TNi4Q71C7/1AECoQ2M9WA8LemiukL4aLhwspWe0KV6bNild/WuvjPPC
         wB7CfxAZKWM+wFPHbeqTzTSw40PBosqVPae7mFvSo8HnvZNXquqeG5VlFtA/LEBN4eRD
         mkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6pDFEIO5zGxrkrqAjMqFkMD9TdcofPxijl3fGW4m584=;
        b=FH9Scw2rLJx7hpfcxTXcPczavVsE/J+jQT9JYPuwTe67GKHp8I7Ul3My3WTF3mclDF
         OsFbWbCKT0Dd2piM0nd7eP9CZyjkMUjWjzBwSCe3G2I2irkjrB1tHLbXHFziL1eouylM
         CNnRQXcM3XHtWdLGhxJQt7kBZbhcdq8psIZa4K1XZjTeYo/QIEJkQTw9fUWIk1IX72dt
         /VCui8MkcA3KxQUpCVKtLOowGggoZqy7OfW6ug1z4fkWKxQVRMx2b/J09ayyM+v0SnaK
         sIG8EhqTyWJ+Ev3xCwVFKZhurCGS7jzPSOQGoAg8BgYLFtitQry6qXQPzr4DqvoStTS3
         hQpQ==
X-Gm-Message-State: AGRZ1gIRUTwprIvRHPQMfK6oGVHQ5gSw6DXCGSDebRPCquSxHhYhuhhf
        BtkeT0VjDb4Q7KWVL2POyFAO7zlK
X-Google-Smtp-Source: AJdET5d/NVMZOCQTg6MbvY5ix3yjG81lqByYCdyipx2L0GbUUMHzaFHW35CbLey2BARZOS/062Ogpw==
X-Received: by 2002:a62:1416:: with SMTP id 22-v6mr17200376pfu.114.1541292633818;
        Sat, 03 Nov 2018 17:50:33 -0700 (PDT)
Received: from localhost.localdomain ([144.178.0.40])
        by smtp.gmail.com with ESMTPSA id 22-v6sm2088851pfs.108.2018.11.03.17.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Nov 2018 17:50:33 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] multi-pack-index: make code -Wunused-parameter clean
Date:   Sat,  3 Nov 2018 17:49:57 -0700
Message-Id: <20181104004957.52913-1-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1.816.gcd69ec8cd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

introduced in 662148c435 ("midx: write object offsets", 2018-07-12)
but included on all previous versions as well.

midx.c:713:54: warning: unused parameter 'nr_objects' [-Wunused-parameter]

likely an oversight as the information needed to iterate over is
embedded in nr_large_offset

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 midx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 4fac0cd08a..a2c17e3108 100644
--- a/midx.c
+++ b/midx.c
@@ -710,7 +710,7 @@ static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_nee
 }
 
 static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_offset,
-				       struct pack_midx_entry *objects, uint32_t nr_objects)
+				       struct pack_midx_entry *objects)
 {
 	struct pack_midx_entry *list = objects;
 	size_t written = 0;
@@ -880,7 +880,7 @@ int write_midx_file(const char *object_dir)
 				break;
 
 			case MIDX_CHUNKID_LARGEOFFSETS:
-				written += write_midx_large_offsets(f, num_large_offsets, entries, nr_entries);
+				written += write_midx_large_offsets(f, num_large_offsets, entries);
 				break;
 
 			default:
-- 
2.19.1.816.gcd69ec8cd

