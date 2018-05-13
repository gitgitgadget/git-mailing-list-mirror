Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4B41F42D
	for <e@80x24.org>; Sun, 13 May 2018 10:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeEMKdC (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 06:33:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40772 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbeEMKc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 06:32:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id j5-v6so10122629wme.5
        for <git@vger.kernel.org>; Sun, 13 May 2018 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PXSmIg5oxUiUsZDRXtK6i0FVdlsCsJG+50kKGv3eyWY=;
        b=eAoSH6iMOg1yMQ0WZlMZSd7SM68YDqAG2qndxs7mb5maCAoiurAIv606JhS+1+yDLv
         aXua1pJftKIfpBIMEjazvxuXQoTpHXaLK3R3cecqRV105/n9PvS+4PRZba88JjwJevWe
         H0SK9d1dE8hLAG4PX+v9Q+P031cfcDyI9a0vBXLLjtb91uoNUwM3p1oIP75troOLdrdf
         Tsfp8/5+jNj8lbD5RrZzfyzfVTyZEM8OLJvC2+lqxqPuV+CIh1za5+lqDlAPzmWzzYaX
         Jsp1kPpgWTRzib4joTfWVrQZR5GAbKok5D5H9B9TzmB/dyjE9TgWS0b2K1db2YwJRjVZ
         HgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PXSmIg5oxUiUsZDRXtK6i0FVdlsCsJG+50kKGv3eyWY=;
        b=Ew0rzkSZfm3r1MnJ4RAAPc0MUNC7mdCZrTs8jAGnRaxqJB6uT4CKWUvkiPJe/Xi2UO
         7b7fOvNPf6SAXr9zGURi3JEBxMcO60bfLduGmzhpYzvuMz2oJFRkgi1sPk4v7fdkemQA
         PX9iXg/AiB/v2tn+JGcrDjkob/HN9815kj0igoQnc5hTfWL3L2o9W8nR5tikx7192Btw
         iQCQ6LGr+oHxMjB9f1pGiI7gka3W+GIa3bLxs2xL9aVhnB3fCYW7T7u7l3BgV8FMe8p7
         WqbNAvNBf0fAERZrgV8WirZ5arqGFdmsYvcuTG6/lyNJOCw6H0DfeEA/wFfJAHxjuIDR
         pCBg==
X-Gm-Message-State: ALKqPweb0jOUrVzE/VIRcupNN5Even6NLhyP8+uXA52lUq0HzTER3L/Q
        BBDpmwVRZ5cfay2bUXQ+iUthmgqS
X-Google-Smtp-Source: AB8JxZrQE0TdgplBV35OByuVGbQNEorgwwxr1qjPbjyMM5giacQNiEyFpEsXvNMteWdAPxm1jnM/Cg==
X-Received: by 2002:a1c:4518:: with SMTP id s24-v6mr2983389wma.50.1526207577873;
        Sun, 13 May 2018 03:32:57 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t203-v6sm6886375wmt.33.2018.05.13.03.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 May 2018 03:32:57 -0700 (PDT)
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
Subject: [PATCH v1 3/8] odb-remote: implement odb_remote_get_direct()
Date:   Sun, 13 May 2018 12:32:27 +0200
Message-Id: <20180513103232.17514-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.590.gbd05bfcafd
In-Reply-To: <20180513103232.17514-1-chriscool@tuxfamily.org>
References: <20180513103232.17514-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is implemented only in the promisor remote mode
for now by calling fetch_object().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 14 ++++++++++++++
 odb-helper.h |  3 ++-
 odb-remote.c | 17 +++++++++++++++++
 odb-remote.h |  1 +
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/odb-helper.c b/odb-helper.c
index b4d403ffa9..2851fe2657 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -4,6 +4,7 @@
 #include "odb-helper.h"
 #include "run-command.h"
 #include "sha1-lookup.h"
+#include "fetch-object.h"
 
 struct odb_helper *odb_helper_new(const char *name, int namelen)
 {
@@ -14,3 +15,16 @@ struct odb_helper *odb_helper_new(const char *name, int namelen)
 
 	return o;
 }
+
+int odb_helper_get_direct(struct odb_helper *o,
+			  const unsigned char *sha1)
+{
+	int res;
+	uint64_t start = getnanotime();
+
+	res = fetch_object(o->dealer, sha1);
+
+	trace_performance_since(start, "odb_helper_get_direct");
+
+	return res;
+}
diff --git a/odb-helper.h b/odb-helper.h
index 61d2ad082b..d21b625a7e 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -9,5 +9,6 @@ struct odb_helper {
 };
 
 extern struct odb_helper *odb_helper_new(const char *name, int namelen);
-
+extern int odb_helper_get_direct(struct odb_helper *o,
+				 const unsigned char *sha1);
 #endif /* ODB_HELPER_H */
diff --git a/odb-remote.c b/odb-remote.c
index e03b953ec6..dbab40c0f8 100644
--- a/odb-remote.c
+++ b/odb-remote.c
@@ -70,3 +70,20 @@ int has_odb_remote(void)
 {
 	return !!find_odb_helper(NULL);
 }
+
+int odb_remote_get_direct(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	trace_printf("trace: odb_remote_get_direct: %s", sha1_to_hex(sha1));
+
+	odb_remote_init();
+
+	for (o = helpers; o; o = o->next) {
+		if (odb_helper_get_direct(o, sha1) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
diff --git a/odb-remote.h b/odb-remote.h
index 68aa330244..27a480fcfe 100644
--- a/odb-remote.h
+++ b/odb-remote.h
@@ -3,5 +3,6 @@
 
 extern struct odb_helper *find_odb_helper(const char *dealer);
 extern int has_odb_remote(void);
+extern int odb_remote_get_direct(const unsigned char *sha1);
 
 #endif /* ODB_REMOTE_H */
-- 
2.17.0.590.gbd05bfcafd

