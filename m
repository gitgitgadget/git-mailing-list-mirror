Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0271F461
	for <e@80x24.org>; Sun,  7 Jul 2019 08:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfGGIag (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jul 2019 04:30:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55981 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfGGIaf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jul 2019 04:30:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so12873540wmj.5
        for <git@vger.kernel.org>; Sun, 07 Jul 2019 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPqw6dLbiA0kdIhGVZt90Qm7ihjawq/cBMoPZ0zLKAs=;
        b=fiDWy89Kkjkafo/n8nf84ZEp8Yon0D7f0NooWXgsuwOdTLIvqhbqAexYqMy4lkidGF
         pEI9UPvtN7y5jSXz7uO/s+u/tYnEkXcyxmhNTC54v+12HbBIaegQV7vohwfoypxsu23F
         oyrAIdLP2DpjrO14/cYOoWBif8MurCGGZYje1/F81uNW/6Pty9vcz0ZcL4SoJ5U5MNTt
         Eg8Wq6Cu1odEaUAfTCz5cwiiu6w2sxNNDQ709PEdMQmdbJhz6DumXhUG5AhucUO+t6t7
         UVwZXNlO3KHm+riNVyguP3WcxmOK89Th4Xux+OiUjFWjBCEonGzMLSVN97m2UYZvdoOB
         oonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPqw6dLbiA0kdIhGVZt90Qm7ihjawq/cBMoPZ0zLKAs=;
        b=DlpMlwjxJUwwh/++EZRnUXtd1Zi2ZOSHDVojxzs2Z4ELon2Y+cDUmQDJAgODnonLcT
         u3MRjIda5ciywcCUsxwNbOSIAaoSlf3xoHoiDzL3NsgshS/BOU5buN4cD6047uOCOIHz
         Mfu3ZROj8MF7tDq8OiHpIuHOf1r037Jiui5xT0f8Ghz+Kf8aOBb3NsRsZqKlMZLQiGW+
         X3OHp2d38bZOVXwuAPUfRW8tA4Y1EXA7RSgjQYMKt79t7vcjwXIJOeDlooc06bwgNR2E
         rf4FKckKKGe1FpO0pZ4FChb8o3yH6ONgQ40tbf7LQVGff5x8KbGBvFF5KBgPx261vU9V
         mpnQ==
X-Gm-Message-State: APjAAAW1HLXYMEdkaGUQZ87W2fDp8JUllHdyCLrCEWI5m0CcurBgy7fK
        jqpul2O3BiPxpLdqph9FD42qq1D0X3I=
X-Google-Smtp-Source: APXvYqzabATUThqLHQAgj7D6JMkzev5RD2L9G4/gBB/eX+F1oFcl0W7omT4MhMQ9o9/yr/4WRJgtPA==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr11836054wml.175.1562488233115;
        Sun, 07 Jul 2019 01:30:33 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10c1:a195:f489:5ba4:f140:8c9a])
        by smtp.gmail.com with ESMTPSA id u186sm9606319wmu.26.2019.07.07.01.30.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 01:30:32 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 3/5] test-oidmap: add back proper 'add' subcommand
Date:   Sun,  7 Jul 2019 10:30:00 +0200
Message-Id: <20190707083002.7037-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.514.g3228928bce.dirty
In-Reply-To: <20190707083002.7037-1-chriscool@tuxfamily.org>
References: <20190707083002.7037-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's making it ppossible to test oidmap_add() by adding an 'add'
subcommand.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/helper/test-oidmap.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index 0acf99931e..c19b41aa4f 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -65,6 +65,23 @@ int cmd__oidmap(int argc, const char **argv)
 			puts(entry ? entry->name : "NULL");
 			free(entry);
 
+		} else if (!strcmp("add", cmd) && p1 && p2) {
+
+			if (get_oid(p1, &oid)) {
+				printf("Unknown oid: %s\n", p1);
+				continue;
+			}
+
+			/* create entry with oid_key = p1, name_value = p2 */
+			FLEX_ALLOC_STR(entry, name, p2);
+			oidcpy(&entry->entry.oid, &oid);
+
+			/* add entry */
+			oidmap_add(&map, entry);
+
+			/* print added entry */
+			puts(entry->name);
+
 		} else if (!strcmp("get", cmd) && p1) {
 
 			if (get_oid(p1, &oid)) {
-- 
2.22.0.514.g3228928bce.dirty

