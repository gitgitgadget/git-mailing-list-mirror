Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45F4208E9
	for <e@80x24.org>; Thu,  2 Aug 2018 06:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeHBIFO (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 04:05:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44496 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHBIFO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 04:05:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so848615wrt.11
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 23:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vADtAtfCWSEXsH1OpMO146gzo9GsV3Ul3WFRiVwhEDk=;
        b=kFDPiT7ypxfZq54p8vmSLTgLTrjNU6GN7PLW5/y0OLufqdAKiZ0n2Wpab778sPXpXi
         7Vu2xFeu6qWkiYbvgutQPD627SnEkoH5ii5qRSTjitJ6+gL6ELHiAbAbhAyO9wDC7AgE
         UI8i2N9wbsK/xk1guM/7hgItGavD+1w8HXzFlgH3labpiwL+vxeSopi4V+GwyTemCPJV
         9nLFJ49F7VRT3WSOus2GOpYj8ZR0xJ0jb8Byk/iGFqcRhEke4RYpwfBf7OmxcFkcSyRb
         IiNHIG66TM0XRGNyog/19tnf8jcZyjayPOSxo6KTXrlGMjjzcwFAFIXQxlVNRlf5D8Un
         Cp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vADtAtfCWSEXsH1OpMO146gzo9GsV3Ul3WFRiVwhEDk=;
        b=OVDgPLa4m9BjfQXbAFa7/13SbL9R6/RciWMkdmdcqqqj8tPNWE89g8jN3cMiyfrj0/
         VHiP78dOyHRpouB4mCtoG1z2C0pBbmPp9pZjtwhOhw8DBDnag881hue6beACXoxEUlJO
         c3PACJ4MecrKjPEe6bGq8suy67FLSTkPItb/PKwbnSp7Lrh2O6H0C7tFFVUOPTCg6V1w
         emJZ/Bd0wUhFqHSqVYIuug289doLqbyaA4lwkn5TdlFdciewYfiblSUYBMFOTuxJ3RUN
         Vvyxq/kKiz3iO551voRzH7lYKqW5dw357Bzkd3GdKQWjW3u8YO/4caLbyPAPmlfiXr/k
         tAaQ==
X-Gm-Message-State: AOUpUlGHoMCcPRvbui0X5bKD1yk17p98ecUczZzGel9k5k7/C4FHKwY6
        I5+ACIAoOuKSE8Z5G/izvOie/vJM
X-Google-Smtp-Source: AAOMgpdQoiCcF80i5lB5o60oBNXN7Yss3VO1S2EebpfrzfOPOeS6bUB1lJmw42qF95gYr67+MJpsXQ==
X-Received: by 2002:adf:dfcd:: with SMTP id q13-v6mr875049wrn.113.1533190541258;
        Wed, 01 Aug 2018 23:15:41 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:109f:b149:1092:6e1:496b:fd26])
        by smtp.gmail.com with ESMTPSA id m200-v6sm1093018wma.32.2018.08.01.23.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 23:15:40 -0700 (PDT)
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
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 3/9] remote-odb: implement remote_odb_get_direct()
Date:   Thu,  2 Aug 2018 08:14:59 +0200
Message-Id: <20180802061505.2983-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.330.g17eb9fed90
In-Reply-To: <20180802061505.2983-1-chriscool@tuxfamily.org>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.18.0.330.g17eb9fed90

