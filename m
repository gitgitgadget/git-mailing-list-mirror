Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64E681F62D
	for <e@80x24.org>; Sat, 30 Jun 2018 08:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933987AbeF3IgR (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 04:36:17 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45837 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932488AbeF3IgG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 04:36:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id u7-v6so10855251wrn.12
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 01:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lx9UBhkyvX1gv85Pz9ISs9rqq9MJA3P0kcYrZ1O5L5Y=;
        b=rg6rbtOAkzeLR6YoEy+B+oNGXENd+BmCkLYvGqpq+x6K22nML49YTmgH6ry+RSc5pP
         4SIaIkhzpw0XoVtcfzG5uV3oTpZ6FMZ0v+6liW9NSuPK2E6yCvgv8Xx9TUO6qRXaIvPN
         Ck6VO198COilE0xGKlJveDDE/uBxI5ZLwKWyVJJmpLle4tuKsRvxf/EO8UwlhaIEGxq/
         jwkhbCJrg2APL+9sexfBDCB89oOCXsCeXt8KdMjJBXDvx7bjICqbcvdt0FsJB9hyb2wF
         KKxnHRHbPCg+AZ/mrDyn39wg8Vxo4uCVs9sBs5OmmKSeLh7NE++R5ELD763rEUV39cFp
         9RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lx9UBhkyvX1gv85Pz9ISs9rqq9MJA3P0kcYrZ1O5L5Y=;
        b=Orbcp/EWr/W89Gflf9oNHmM+L1YaJASZLC6oE/Nc7DLr2hthSeJGlwwLOskCRswh58
         1/9jSWPch3uzjzujO6lBM1NapWhdRqJX+seKiQxnaMYCB2gk/eyQ7g8+xQi1h8+cRc/E
         NNjIGE8RjEqP/TrabyET5UI49N8TuFdq0wBKGRb/EHoPeIY5qAjn12OwwFEp306GFxai
         MmlukrdLHO2C8PmRJ7qgzBDMOcf1clj0c77s6QeJFb+PFIvIS3dqc8F8rbg6ophTUKQJ
         3fhvQGVQgSOcXKvYaLM6k5YCqDTVE0kwN4kDiuB4THersULATHMDT1+pUbbj22KdIP27
         K5UQ==
X-Gm-Message-State: APt69E1HxyQau/gJR9iVzrhll1R9jkV4qccOP4lYa+XJTTV7mxPSdzBt
        bgovKwu0BSGxb3LIwrQlE4ODFKkE
X-Google-Smtp-Source: AAOMgpegv6U/XIYH1pfcvjAOTxSXvyBPyxzcvxkLTviB3NxSFt5ZbKHW9BbzVQcu6jlbVLIYj0grqQ==
X-Received: by 2002:adf:ef8c:: with SMTP id d12-v6mr3888406wro.195.1530347764609;
        Sat, 30 Jun 2018 01:36:04 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id u70-v6sm5338356wmd.3.2018.06.30.01.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 01:36:03 -0700 (PDT)
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
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/9] remote-odb: implement remote_odb_get_direct()
Date:   Sat, 30 Jun 2018 10:35:36 +0200
Message-Id: <20180630083542.20347-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g8117677157
In-Reply-To: <20180630083542.20347-1-chriscool@tuxfamily.org>
References: <20180630083542.20347-1-chriscool@tuxfamily.org>
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
 remote-odb.c | 17 +++++++++++++++++
 remote-odb.h |  1 +
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/odb-helper.c b/odb-helper.c
index b4d403ffa9..99b5a345e8 100644
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
+	res = fetch_object(o->remote, sha1);
+
+	trace_performance_since(start, "odb_helper_get_direct");
+
+	return res;
+}
diff --git a/odb-helper.h b/odb-helper.h
index 4b792a3896..4c52e81ce8 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -15,5 +15,6 @@ struct odb_helper {
 };
 
 extern struct odb_helper *odb_helper_new(const char *name, int namelen);
-
+extern int odb_helper_get_direct(struct odb_helper *o,
+				 const unsigned char *sha1);
 #endif /* ODB_HELPER_H */
diff --git a/remote-odb.c b/remote-odb.c
index 7156855155..a1811c1bfc 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -91,3 +91,20 @@ int has_remote_odb(void)
 {
 	return !!find_odb_helper(NULL);
 }
+
+int remote_odb_get_direct(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	trace_printf("trace: remote_odb_get_direct: %s", sha1_to_hex(sha1));
+
+	remote_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		if (odb_helper_get_direct(o, sha1) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
diff --git a/remote-odb.h b/remote-odb.h
index 4c7b13695f..c5384c922d 100644
--- a/remote-odb.h
+++ b/remote-odb.h
@@ -3,5 +3,6 @@
 
 extern struct odb_helper *find_odb_helper(const char *remote);
 extern int has_remote_odb(void);
+extern int remote_odb_get_direct(const unsigned char *sha1);
 
 #endif /* REMOTE_ODB_H */
-- 
2.18.0.138.gac082779dc

