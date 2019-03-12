Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE942032D
	for <e@80x24.org>; Tue, 12 Mar 2019 13:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfCLNaU (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:30:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32862 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfCLNaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id d12so2320124edp.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UTtyVVmechrkSs9dBFE04OBtxYGIF4H9ahHN5WolIZE=;
        b=KbwD06oV4/VZ0i6e00lbACxYFoVkXAnTr//qCN4e4ziU6LKZ0RExD5Ezofav2jX0pE
         VuNOw44ukM+wX+IBfw90IBUlhfxlqS0Ip3P8dWAKlHgCq0ZPMOecW5Wgk2YXYUD4igVx
         3jrquHwUWW+rzWhk6AIAb0tXmxehn4uliJL9Ir5f+CkdZaLNFwr86qQYQLKmEGRYPC3/
         oy+3R4i81hsY23kekJxYBERk6I8N3B87mzS7gTc/xo7sOd1Sa8e7+XwSLUV253Vkyy5S
         tL6sq2qL0XsUPqyRCXQv8Eux5yHgAxgfyPQ2enI7eH6XBpmeDZxmygoG1L0yshAPE7Z9
         vVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UTtyVVmechrkSs9dBFE04OBtxYGIF4H9ahHN5WolIZE=;
        b=adco32IaRVHEScVSKs0OJe4IU3FDFeJ7/WFiitevH0EW7TNDaUvHZemcCtDPaDoycB
         CCsR7lIlDzMwB3BZw0VPyu8pK++wFxGnh0GsCcMvd+QIUzR9GicTxVHvJpL7gdK3I5Vu
         kLWENH3iRHNhTPIswKiHRp7Zn9Of11iBhgSkqXA3y/oK4/xG2Im7+ag9umW5QpY35hWf
         /7cYLa+Ih8l8BsH3f7ICdZPPSm04Yfu32kGqHdn48TO57ItvFFDvwp5kIMqU5J+U29o3
         VHftwY1HimCcEMWqXnicVhqaeGppvYMj0DUgyFx1AWfOJ6DrDM//A4mhMYqLxVWwgn5h
         ixLA==
X-Gm-Message-State: APjAAAX81YKcMfqkW3EOSIiM6vzMVtdeqPh0ktieampSJFIwxcg+nVV5
        /yrlcyu11oHpRbdMQ0C0AQ4UqeCa
X-Google-Smtp-Source: APXvYqwU3z76EXwai7orW+D09QNGyk6hVByqeNYWDin3iMxKgiOzVsrCvweDdA2wwF2CJ9N2tuE0ZA==
X-Received: by 2002:a17:906:1942:: with SMTP id b2mr26132376eje.5.1552397416649;
        Tue, 12 Mar 2019 06:30:16 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id h8sm5875213edk.21.2019.03.12.06.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:15 -0700 (PDT)
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
Subject: [PATCH v3 03/11] promisor-remote: implement promisor_remote_get_direct()
Date:   Tue, 12 Mar 2019 14:29:51 +0100
Message-Id: <20190312132959.11764-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.166.gb5e4dbcfd3
In-Reply-To: <20190312132959.11764-1-chriscool@tuxfamily.org>
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
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
2.21.0.166.gb5e4dbcfd3

