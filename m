Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029601F90A
	for <e@80x24.org>; Fri, 13 Jul 2018 17:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbeGMSGD (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 14:06:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33342 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbeGMSGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 14:06:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so5062740wma.0
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rh6pZMOdFWz7xG5gXxSfU5IwusEAZHQrIH54f4VypFs=;
        b=pvBS3TB9SyX1u4nPQ01uSI+di6zrmfTxbIXGBUFJw+GCns9KbY12yNcgqJSbhHYN1O
         rOsYN3/9fScpY2JbTsKQNUHKLLTBIh3ibmfTmiLlQF15kmH3oJNjMNx/TCVA3qvTNvNY
         m1euRxc6nLC8jObD91GkJr9UQA1CAmMiGNjNZQEsLit1ffTUCE9a19BLPTdigR8PRJXg
         6CEHge8SNJwBBIzT8gzwUpnsUMG8eiOL2vaAO8BayzXfXGZfGnWzFZb2lt4RVL665Zrd
         bIfyf1VhW11i5sSG108fwLALf+DXDrTQTy9BSGcN3qDhTeoUoG4mq4niByN3EHDv6wSh
         Sg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rh6pZMOdFWz7xG5gXxSfU5IwusEAZHQrIH54f4VypFs=;
        b=MvJ2eNEFrYqDMeZnK3TSjZKOEM0fB0Zr2mmw29CIej7tJQ0EX2SDLxoQM9KheKp8Ug
         wi5nqZZuada/WY8jS/wCV1PVxDllz/YboFmpkUFYlrJgGxoRp6TNWmhPsiKpuqcBOsca
         qaPizumRnOfPaAGEZ78efCzE8ODQ08ThVFIvk+RbFMZIhyId+uaHa0Y7vBUbQ6NRHWLt
         qZC0mqaBITbCIwX7oDY7HdnC8Sy2oQ624sSi55EheNmwQ0ECkW6/aY2SQC7v3jvvOt8L
         y6yUGA+3OcwtUautkSGwI/F3Rq11UO8y5UgEEQBQsDi//xA5Vk9dfFIjuA9XYW5JgYPa
         fYYQ==
X-Gm-Message-State: AOUpUlHKCY2Mc1Kgi6dux3eXTgJcRn43Ht6S1YYYgj4DJE0C223lG20o
        QlbjlpaYVjNEvPNhtZTAOSSDUY+l
X-Google-Smtp-Source: AAOMgpcOKKW+tg9X/U2mR1nyV2h85i50IybcMx4PCUBT5Ojm9tF2gow8E56lkY64uTXp/oPrZ9qJWg==
X-Received: by 2002:a1c:a8d6:: with SMTP id r205-v6mr4340325wme.6.1531504222110;
        Fri, 13 Jul 2018 10:50:22 -0700 (PDT)
Received: from localhost.localdomain (188.10.112.78.rev.sfr.net. [78.112.10.188])
        by smtp.gmail.com with ESMTPSA id v15-v6sm6556862wmc.16.2018.07.13.10.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 10:50:21 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 3/9] remote-odb: implement remote_odb_get_direct()
Date:   Fri, 13 Jul 2018 19:49:53 +0200
Message-Id: <20180713174959.16748-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.138.g7076a5fae1
In-Reply-To: <20180713174959.16748-1-chriscool@tuxfamily.org>
References: <20180713174959.16748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

This is implemented only in the promisor remote mode
for now by calling fetch_object().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 03be54ba2e..7f815c7ebb 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -89,3 +89,20 @@ int has_remote_odb(void)
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
2.18.0.171.ge260395bfe

