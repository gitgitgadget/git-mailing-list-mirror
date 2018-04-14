Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72CEC1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbeDNPfd (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:35:33 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43514 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbeDNPfc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:35:32 -0400
Received: by mail-lf0-f65.google.com with SMTP id v207-v6so16386540lfa.10
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sHTmAFZD9oMmW8I9zZLYdq66ifD7089o5l7wm2R5hy4=;
        b=jEqy63jhM759mwGCuoaATS6vao7p3tErPXVPsHQ2FnDYUb+3K6metY/xSrbar+6Nok
         cxHDQF6D7a8DPaeZaX55HIpkl+tQuYrHso61e57eoZJiniHp5efanittQeGQLqUNxLds
         zcOCn0ymcQZ9ULIIFB5peBLoKhMTpHGfpgYkGLMyN05pGula3Sib7E8MoP4hQxcJTwWb
         5nTDAh4Cpb4sGu2/Q7r1UsAQL1o3Jvv/ua4G3eYD73S8l9InvaTGdB6GdcAq2m9icBPA
         qBJpsPQEttlYpik1xLVXkDXgEzrcSv0R+Gsps1antyuEkXi+udi1/F1UFe1+7NXfPyOY
         gtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sHTmAFZD9oMmW8I9zZLYdq66ifD7089o5l7wm2R5hy4=;
        b=fgQD5GlVGKCR6rlm7XwEuNplQ5TKY26QG65HkPSrA6vpi2JilAs1SfpSNGDbM6HYwT
         MZ6z1NolA60swFindlEc7nGLo5cjjsWvq2eoSwDVtvUK7vbhtkV7zK9qyJ+/TWJ6Kp+1
         5rqZCCEHGdjpDbq4EHJc7yG3WF44ai2+v5YltvyoC+rHdKFNZN9ipx+WJtwAxKAh6x9x
         jGKe+lA7MNzpp9BOm7bPAWaBR5Gq3JG6dlFYIJAwMdX7UrMs3JCrDdYZ1u353PK3sqNz
         K2xMj6WuGHqyHHdPmPMUg3jlHvrRgXT/vl0Ab5TtwVoVedmbiA/sSF3GKs4aJ/7lzJri
         UKVg==
X-Gm-Message-State: ALQs6tCOzg6LIoEeYlDD2Y6lr+2hoj8XbTTY1RnfL6z9ceFHWYKxPNsl
        aXwYk9EYooZa9mMkGxnW+t6YQg==
X-Google-Smtp-Source: AIpwx4+DwI7xVFgBHGzhTJu5lFtCMuQR0NIiXWDmaoSJpu11Hes/ZvsgbHcnGdTE/iglSaU98sAomQ==
X-Received: by 2002:a19:9685:: with SMTP id y127-v6mr11026378lfd.77.1523720130276;
        Sat, 14 Apr 2018 08:35:30 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id t8-v6sm1844074lfk.9.2018.04.14.08.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:35:28 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/15] pack-objects: use bitfield for object_entry::dfs_state
Date:   Sat, 14 Apr 2018 17:35:02 +0200
Message-Id: <20180414153513.9902-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414153513.9902-1-pclouds@gmail.com>
References: <20180414153513.9902-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c |  3 +++
 pack-objects.h         | 28 +++++++++++++++++-----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 88877f1f59..cc3c31747e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3049,6 +3049,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
+		BUG("too many dfs states, increase OE_DFS_STATE_BITS");
+
 	check_replace_refs = 0;
 
 	reset_pack_idx_option(&pack_idx_opts);
diff --git a/pack-objects.h b/pack-objects.h
index b4a83a6123..080ef62d31 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,6 +1,21 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
+#define OE_DFS_STATE_BITS	2
+
+/*
+ * State flags for depth-first search used for analyzing delta cycles.
+ *
+ * The depth is measured in delta-links to the base (so if A is a delta
+ * against B, then A has a depth of 1, and B a depth of 0).
+ */
+enum dfs_state {
+	DFS_NONE = 0,
+	DFS_ACTIVE,
+	DFS_DONE,
+	DFS_NUM_STATES
+};
+
 /*
  * basic object info
  * -----------------
@@ -73,19 +88,10 @@ struct object_entry {
 	unsigned no_try_delta:1;
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
+	unsigned dfs_state:OE_DFS_STATE_BITS;
 
-	/*
-	 * State flags for depth-first search used for analyzing delta cycles.
-	 *
-	 * The depth is measured in delta-links to the base (so if A is a delta
-	 * against B, then A has a depth of 1, and B a depth of 0).
-	 */
-	enum {
-		DFS_NONE = 0,
-		DFS_ACTIVE,
-		DFS_DONE
-	} dfs_state;
 	int depth;
+
 };
 
 struct packing_data {
-- 
2.17.0.367.g5dd2e386c3

