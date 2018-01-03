Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0336B1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeACQfJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:35:09 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:44660 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeACQfB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:35:01 -0500
Received: by mail-wm0-f66.google.com with SMTP id t8so3633259wmc.3
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FbkF3E/lvmNIN9d03CyOBB3aay8aofUqVLj0L2MYCDc=;
        b=jaLZBAbYRSGQGnxtc1jFUZCScwDHYn81lVO+g7jIvM376b4m5GNGnnTaGrZvCJkmxq
         7dJuba1bkbgckN5J8Wqjrh5/watm4BT1n/NRXJ0Th9tL9ACb2dhsCO7U7np7cmG5vQ5P
         IkGYAl5Cfq9QobTJi7YIEc4xJzoNKE6YAqfY0BsGy0QHNC8oA2cova2loj1oTgWi0StE
         /jFj5wb3awtU81brnEcqIBTAQS/pD0CDjSN/IeusCr2fOlVaDaV5TU6inqBn3icy7vRw
         h0vlFQa96mW/3K9mE6aNJoKYxck/IW/y0ijs1PVanilA8Q9Nhf7YF1XYhATOJ2xEzmxe
         cHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FbkF3E/lvmNIN9d03CyOBB3aay8aofUqVLj0L2MYCDc=;
        b=E6+hTScpNU90XxJDeRJofHyztzVRnMyKL9Ak7FWz1Rfzk0az2lnvG91s7qTFnp8XHU
         mYnSsQLyWCFN9iHhqM3o3wCGI8hoUF6iNC4Ght/4nbXZ843RxgPo15ipGhbvjBlNy/zk
         T6Sh2COXFEx1/kMIeYVicvd+6//qoq2z+BcLAKGs4LAmlGC0J5TVxlkTYFdweUgL2Zuq
         arFiVld/yosg+XpuFIXWxeV7rdQJx1hUNEvqI1IaE+EcsDLLxy9xaf7Aj0KqL5F4AH7D
         nl4jxYILu53MfHOC6KspCrFlXMb4ZUybp8oTzpbw7g7P5FU9CIFQ8j/JZ/R+NGKZs/ju
         0zNQ==
X-Gm-Message-State: AKGB3mLYUoiTY4qo6oOUiPYD+vCisHFZDROLAgeI0C6EuepwSdG4fxlu
        ukEwTDqQDAywMogRYGLO9U5HiMgU
X-Google-Smtp-Source: ACJfBovq1a++Fx2sybnqI8trHqQItx7JcExygf/kRAqiT2WSHcsR4uuY85SHGYm1dZhxbVEXvF1q4g==
X-Received: by 10.28.95.7 with SMTP id t7mr1733582wmb.86.1514997299533;
        Wed, 03 Jan 2018 08:34:59 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:59 -0800 (PST)
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
Subject: [PATCH 28/40] pack-objects: don't pack objects in external odbs
Date:   Wed,  3 Jan 2018 17:33:51 +0100
Message-Id: <20180103163403.11303-29-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Objects managed by an external ODB should not be put into
pack files. They should be transfered using other mechanism
that can be specific to the external odb.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6c71552cdf..4ed66c7677 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -28,6 +28,7 @@
 #include "argv-array.h"
 #include "mru.h"
 #include "packfile.h"
+#include "external-odb.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
@@ -1026,6 +1027,9 @@ static int want_object_in_pack(const struct object_id *oid,
 			return want;
 	}
 
+	if (external_odb_has_object(oid->hash))
+		return 0;
+
 	for (entry = packed_git_mru.head; entry; entry = entry->next) {
 		struct packed_git *p = entry->item;
 		off_t offset;
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

