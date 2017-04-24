Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D14F207E2
	for <e@80x24.org>; Mon, 24 Apr 2017 10:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168355AbdDXKCT (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 06:02:19 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35505 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168339AbdDXKCB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 06:02:01 -0400
Received: by mail-io0-f195.google.com with SMTP id d203so47830961iof.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUQQlfZ+Y8ZhWHZYcFfPwzG40QVfGu3yTVmak9wqtuA=;
        b=gZ1q7jdnvWfgNiKiqBXh9k5vYPOR1w9CdDU7XaFdDfSI7TrSjkLw7PicnAOERpHNKp
         pG+/H00UykZYrbY8J4xP4dXKuD2z/CMsohLGBu90Zqe4j3XmSJLJrho2Vd32fKAQ7Miw
         sZyW9ThZjYvQGkk1nPODxBED5jt7cuzpk0zZsNjdFnb8KjxqTIczTo+MqPUoU9gOe1fv
         dVzOBu4Ot2NFSdwNhCy132STrE7keeb+ldWmVdtizBRxzmrRQ1n9hbftLJvB6GtVTQ7S
         yBuQlncSKoAjzv//nWyXxIqgXmRXZIhWGfEtXE/5lgUDZB8rznVbl+YmKwugUEmwjLTY
         938w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUQQlfZ+Y8ZhWHZYcFfPwzG40QVfGu3yTVmak9wqtuA=;
        b=Mhi0Aqa8sA3Bk73nEIvftST9shrBSgWEacZTbQUDB8Jm0zpUgNKizbLzbL9rDBWIep
         r4Xh6iTV1qZcI2g2bReKlpupsJzA0Z2IBs5+9aPDgcdXYWDYt/keIiGAf8bXnn1pV9cw
         ET4wC8E3IYjOyCq8CtgbVAqx1s3DLcUbuRo+/gWg9tFjZpOgrCQoHOtTaUT7jtb0wfjl
         oP67n4LetnzewTdGvrzxg8OJwrB5aEtEJuS5f13qGIsWxIGQoDNo1kLrRntaSlDpsGwa
         VwQQhWPuC88mbgp1aEoxlZ0C7Ltv3J106Hhpz7sGOFHUnSH8LWBUPGFkFPfNwlClFUg7
         Seuw==
X-Gm-Message-State: AN3rC/4AA8p5lgZL30TNWVGCXou2MyhMmxwxtAx+FHn5RbCPH4nW+ny8
        mKX3MdmFKjdfCA==
X-Received: by 10.98.68.133 with SMTP id m5mr23954770pfi.60.1493028114876;
        Mon, 24 Apr 2017 03:01:54 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id a187sm29832771pfa.59.2017.04.24.03.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 03:01:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Apr 2017 17:01:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 3/6] refs: add REFS_STORE_ALL_CAPS
Date:   Mon, 24 Apr 2017 17:01:21 +0700
Message-Id: <20170424100124.24637-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170424100124.24637-1-pclouds@gmail.com>
References: <20170404102123.25315-1-pclouds@gmail.com>
 <20170424100124.24637-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 6 +-----
 refs/refs-internal.h | 4 ++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 96eba92475..6e6f0ec5be 100644
--- a/refs.c
+++ b/refs.c
@@ -1526,11 +1526,7 @@ struct ref_store *get_main_ref_store(void)
 	if (main_ref_store)
 		return main_ref_store;
 
-	main_ref_store = ref_store_init(get_git_dir(),
-					(REF_STORE_READ |
-					 REF_STORE_WRITE |
-					 REF_STORE_ODB |
-					 REF_STORE_MAIN));
+	main_ref_store = ref_store_init(get_git_dir(), REF_STORE_ALL_CAPS);
 	return main_ref_store;
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 690498698e..b26f7e41ce 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -467,6 +467,10 @@ struct ref_store;
 #define REF_STORE_WRITE		(1 << 1) /* can perform update operations */
 #define REF_STORE_ODB		(1 << 2) /* has access to object database */
 #define REF_STORE_MAIN		(1 << 3)
+#define REF_STORE_ALL_CAPS	(REF_STORE_READ | \
+				 REF_STORE_WRITE | \
+				 REF_STORE_ODB | \
+				 REF_STORE_MAIN)
 
 /*
  * Initialize the ref_store for the specified gitdir. These functions
-- 
2.11.0.157.gd943d85

