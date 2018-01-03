Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA4A1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeACQer (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:34:47 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39740 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbeACQec (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:32 -0500
Received: by mail-wr0-f194.google.com with SMTP id o101so2141836wrb.6
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZHogTSX7FrB9MFwSfXq8lwOfD88OLJONfr1D7F3WRI=;
        b=ODgHiEkH8Bj8x/Wln2UJ8+vCvpfhnNCSFIuvmdChfYQ5tbqZfSdzI0kA0iTaL1G08p
         LqdVYBd+ofkh1ek98cGFn0PZa7DEUCkSCsI5Ewr5n16UIoHO7Kqp/hX7Q5eDwLcUCCJR
         SZljSRlpQ709eRGtaXMXR83DYA4qf4VwQbt5phFkaCChMHVgKqRVLXqL7PRr3i+HDgCm
         v+oXcdqjShH3A+Wz3i7M1qz3r3hjFhOfCHTDLon1wcKvXfw+vkCM7Rwhbba06Bz2z3EB
         UXc6Yr+suBiInmSP2HSpra92n38WmS0Lt8VuGmpxCwoi+ZFJjB98/bDsQj7EBFsJGddB
         5ooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YZHogTSX7FrB9MFwSfXq8lwOfD88OLJONfr1D7F3WRI=;
        b=AluJN9KLNYqpwdV0zSBNT6inC/uVyjKr/Ht6GlAK0PLoFvFedQv7fo1jkeOEoVDlqY
         rjui1U8a0PkcmUOWmH2vWhzfYOrE0B7u4+/G6ctCLqXAOGkIS4jKWPO/4YCjs01f6LNa
         U3pqTyb0boR/L6nrY1PomcaCYogiI16MmvjTO+Xqm5hWp5nraO+mkka24L0JSHbykdVw
         sWwwimOfbFcjIqNS4lqggsUXLqPIWGKoLFcO0lHx4D8q9GV6fExixOePiCm78aMRQH+t
         Na3HhhvlU5ZF3aUETtkBx3YRvf6t2vilEnJr8htvhTREsV8opHwvHHVAv5bS73tGL1U7
         9t/Q==
X-Gm-Message-State: AKGB3mKUi8+/u0gjqyOKY1i86J3+ooU6T+O/wFvCqU4zBSBkc+LQtcIe
        CqvJDOgClpDqhGWou054Kdolc/Km
X-Google-Smtp-Source: ACJfBos8n+9bEgCtK2udPok0anYzAxISc+cCvMpuRB4Fwi2kV2FLVm8DZ+M7NsNB+LmMGDzO1VqfCQ==
X-Received: by 10.223.200.8 with SMTP id d8mr1899435wrh.190.1514997271097;
        Wed, 03 Jan 2018 08:34:31 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:30 -0800 (PST)
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
Subject: [PATCH 10/40] external-odb: implement external_odb_get_direct
Date:   Wed,  3 Jan 2018 17:33:33 +0100
Message-Id: <20180103163403.11303-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is implemented only in the promisor remote mode
for now by calling fetch_object().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 15 +++++++++++++++
 external-odb.h |  1 +
 odb-helper.c   | 13 +++++++++++++
 odb-helper.h   |  3 ++-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/external-odb.c b/external-odb.c
index d26e63d8b1..5d0afb9762 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -76,3 +76,18 @@ int external_odb_has_object(const unsigned char *sha1)
 			return 1;
 	return 0;
 }
+
+int external_odb_get_direct(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	external_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		if (odb_helper_get_direct(o, sha1) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
diff --git a/external-odb.h b/external-odb.h
index 9a3c2f01b3..fd6708163e 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -4,5 +4,6 @@
 extern int has_external_odb(void);
 extern const char *external_odb_root(void);
 extern int external_odb_has_object(const unsigned char *sha1);
+extern int external_odb_get_direct(const unsigned char *sha1);
 
 #endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
index 1404393807..4b70b287af 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -4,6 +4,7 @@
 #include "odb-helper.h"
 #include "run-command.h"
 #include "sha1-lookup.h"
+#include "fetch-object.h"
 
 struct odb_helper *odb_helper_new(const char *name, int namelen)
 {
@@ -52,3 +53,15 @@ int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1)
 	return !!odb_helper_lookup(o, sha1);
 }
 
+int odb_helper_get_direct(struct odb_helper *o,
+			  const unsigned char *sha1)
+{
+	int res = 0;
+	uint64_t start = getnanotime();
+
+	fetch_object(o->dealer, sha1);
+
+	trace_performance_since(start, "odb_helper_get_direct");
+
+	return res;
+}
diff --git a/odb-helper.h b/odb-helper.h
index 9395e606ce..f4bc66b0ef 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -20,5 +20,6 @@ struct odb_helper {
 extern struct odb_helper *odb_helper_new(const char *name, int namelen);
 extern int odb_helper_has_object(struct odb_helper *o,
 				 const unsigned char *sha1);
-
+extern int odb_helper_get_direct(struct odb_helper *o,
+				 const unsigned char *sha1);
 #endif /* ODB_HELPER_H */
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

