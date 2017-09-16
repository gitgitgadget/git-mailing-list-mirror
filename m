Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A64920A28
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbdIPIIT (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:19 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34138 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdIPIIP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:15 -0400
Received: by mail-wr0-f196.google.com with SMTP id k20so2370396wre.1
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ybPWpNbZ6Ubi1cLfXYdKQSeJHfz/H7+dAcifWXs6aKQ=;
        b=hbItO+NREsacQZhjHk1i1u7y1Req/uczBPfZlOc0w/ir6lOCaJz9c0trj7fur22ju1
         Xi80F8Y1HVDcpwT09eKAeQIMDwc6+VjBH7PrxrdytDnab6VUB3iJS6VlsfscJ+9P4eLX
         vdMQld/ujAemVVt9RagZZJt9pDRTsvZuRtCgaawTMUAOTnuYZWKB5WrVwfSZ80hXGwft
         nHxT9hNqzCqi2nsH+w2vzzRA2dav87O/RlIzq+bYf+uHGpn9y3pE4rzWtoJ1l0wXgK0S
         LEvhIkvqyogGMNZAJyGPKAmev2MQcE9GverPEBZbdTtyjh9uJEkLLY3DcgjEPQXEujCd
         r7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ybPWpNbZ6Ubi1cLfXYdKQSeJHfz/H7+dAcifWXs6aKQ=;
        b=l8snKHMtiAM5O0jAxMgUxpzAahcKbv3LrrMVbBNrtJ/ZCdhuQhIs36DDNGLWZLa4/O
         qqzxAkHsB5SMxwSGFtObLxqwnTBIWWts9ifLE1hV/wTI/oyoDPuQnLiq9uSuATIba3RG
         ugo+TVkK/a2Fe+2rHs/PDyhHtc8O2YV3bD4PZK+5r2CFpk+nwJS2vEUXcsj2IjlL8WaR
         hDt5r22xN++zy40UZKq2UNATXclTk6d4POQ9wEUU7sWW3eahirBr1pPS4ao4Wu9EuZ01
         NIoq2H2S4DRZT804HkvY7efwGn33Fw6uQdlkc2pv/HCP5vKHFvQmt27BoMbfjurnp6dc
         3p1g==
X-Gm-Message-State: AHPjjUiyeBQgrqP7GeqNVYvz7DShZ/lcdBgOiIhxGLUoEWArzNFvyKBv
        jRcvNiu8COYb5PUn
X-Google-Smtp-Source: ADKCNb4AzfDFl9wQ6LmEcY3LlnXcv1Tmtee6K8ld5HCq/oGTKkt7aaATigCMJzWIv8ajnoS+685jIg==
X-Received: by 10.223.175.217 with SMTP id y25mr25891937wrd.255.1505549294405;
        Sat, 16 Sep 2017 01:08:14 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:13 -0700 (PDT)
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
Subject: [PATCH v6 22/40] pack-objects: don't pack objects in external odbs
Date:   Sat, 16 Sep 2017 10:07:13 +0200
Message-Id: <20170916080731.13925-23-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
index a57b4f058d..db5e225d5a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -26,6 +26,7 @@
 #include "argv-array.h"
 #include "mru.h"
 #include "packfile.h"
+#include "external-odb.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
@@ -1012,6 +1013,9 @@ static int want_object_in_pack(const unsigned char *sha1,
 			return want;
 	}
 
+	if (external_odb_has_object(sha1))
+		return 0;
+
 	for (entry = packed_git_mru->head; entry; entry = entry->next) {
 		struct packed_git *p = entry->item;
 		off_t offset;
-- 
2.14.1.576.g3f707d88cd

