Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E54C21423
	for <e@80x24.org>; Tue, 22 Jan 2019 14:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfAVOmm (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:42:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40685 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbfAVOmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 09:42:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so14405940wmf.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LaoUnRDe7LDDoqzG6LyC6uCq7vKWP26VReoY9YQP5sg=;
        b=YuUe5VhE3vacHzIyLDM81V2KmneY+zMi4amlPccQl3GV/zS+rOPmQohm4g3y+xm5lw
         FxkpHBHXkHBPB7EtbSbz5RV4JOt6bnXBJPCjo7QrxloN+e6bx7Cp69CU0ULdPXLMXyeZ
         DzwJAc5RiMKHVxT4gHI1hbQnkoOfMo2f79QHBc2w+voiaxzJWbhZvekR4vAJOD3pXziN
         h7olgvEzLzPdCbczRXiFalHPoNhcxsgBR3Qk/HImK/d2+4j83YlH9sB/XcaFO8NVfGNV
         9mgRyeVliKhdwzeYk2IPCpjFqFl9OQe0Bb/iRhJ1Xdo+5IsJp+op8xvytuFZh8nMrp+l
         s+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LaoUnRDe7LDDoqzG6LyC6uCq7vKWP26VReoY9YQP5sg=;
        b=UFcxu4skXCZedfJ9zRWWlCkIQ8V+L+ehshGzvtbJOqi9EAmimawuP12j3DeI9q0EcX
         StjLcQD/kDOjDLjY7B6FLdsWctu0SMcMZTJr77WDg7PqgsWMJT2BJHBXn0CDO85uCti7
         RmTTv9QXmnQJSV54bHnhCvXDSYTVYwlbf4j/NftDkazSSd6TYYkKw5RIfkN7jnbDsAlb
         +9BH1YXCfeuk5wZ6RIZmQQkDrymEu6j1NLOKyVkkhgeOZIYAi+iyV4vpIonTdNiaoN06
         SyVfxQbHgwiUYoEw4yupHHepo6mCwuB6MXnY0q58fswQfMxtmfgGd1JpqUZTHkk1hc8O
         lZQA==
X-Gm-Message-State: AJcUuke6J7UDmai7a4zkNbTUYhyVma1M0eBMJUiE1DkueM5Yv1bcXTi0
        A+B7uxbN4JgQUos7oe1QnUeYEsem
X-Google-Smtp-Source: ALg8bN7MyiCS7KbOQgL2MmPVmGz/jX3Ws06MKdxMRW2171espEBAbuxdn4pEICjfwxNlJhxuQ73CPA==
X-Received: by 2002:a1c:ef11:: with SMTP id n17mr4001909wmh.112.1548168153690;
        Tue, 22 Jan 2019 06:42:33 -0800 (PST)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id k26sm31266168wmi.28.2019.01.22.06.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:42:33 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 05/13] promisor-remote: implement promisors_get_direct()
Date:   Tue, 22 Jan 2019 15:42:04 +0100
Message-Id: <20190122144212.15119-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.322.gd6b9ae60d4
In-Reply-To: <20190122144212.15119-1-chriscool@tuxfamily.org>
References: <20190122144212.15119-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

This is implemented for now by calling fetch_objects(). It fetches
from all the promisor remotes.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 17 +++++++++++++++++
 promisor-remote.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index d2f574651e..f86f9d0b84 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "promisor-remote.h"
 #include "config.h"
+#include "fetch-object.h"
 
 static struct promisor_remote *promisors;
 static struct promisor_remote **promisors_tail = &promisors;
@@ -98,3 +99,19 @@ int has_promisor_remote(void)
 {
 	return !!promisor_remote_find(NULL);
 }
+
+int promisor_remote_get_direct(const struct object_id *oids, int oid_nr)
+{
+	struct promisor_remote *o;
+
+	promisor_remote_init();
+
+	for (o = promisors; o; o = o->next) {
+		if (fetch_objects(o->remote_name, oids, oid_nr) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
+
diff --git a/promisor-remote.h b/promisor-remote.h
index bfbf7c0f21..f9f5825417 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -13,5 +13,6 @@ struct promisor_remote {
 extern struct promisor_remote *promisor_remote_new(const char *remote_name);
 extern struct promisor_remote *promisor_remote_find(const char *remote_name);
 extern int has_promisor_remote(void);
+extern int promisor_remote_get_direct(const struct object_id *oids, int oid_nr);
 
 #endif /* PROMISOR_REMOTE_H */
-- 
2.20.1.322.gd6b9ae60d4

