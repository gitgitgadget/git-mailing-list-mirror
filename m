Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3D1A1FAE5
	for <e@80x24.org>; Mon, 19 Mar 2018 13:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933161AbeCSNcQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38891 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755518AbeCSNcM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:12 -0400
Received: by mail-wr0-f195.google.com with SMTP id l8so18605664wrg.5
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aXcALav1t0H0xEOIH1HQXTmOTSn/mpYXNmxy2Y5VEb4=;
        b=DeZZxIGeGOz1QMFoyK/WaYv7kZ3qCMMOQR7MBdn5ZSd1+EMNHvNPr7RUth73chahNH
         Lew2GSi8YChZXEGUIBqa0CKSMmxXRo1fbN8Cb84fQeaM6Yum/QFtamh/Nm2sLVA+GWOd
         PVAACA9+JjSMwpERhgd/QAkfCai3DmFsJNi6zUkYFQgYoe8IVd0E7bKcqDibAAGJFKDy
         5Tn0jSazk4wFe8ZNMpz6ohmNv6zub3Ka+TQCNjd1Kaz8I2a4cjx9iW5HjrMs6BilNf1Q
         bmXWVDJvjOAX0l8kBp/aKjQNO8VPjobjQ8gIhiSmm5gsc+uFoh+Oo2OaMJO4zNlLyFLr
         tOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aXcALav1t0H0xEOIH1HQXTmOTSn/mpYXNmxy2Y5VEb4=;
        b=UCHHgG4++ybMg767xPLLx1DqlGdX9wo6qdIBwLd0yPIw44CDzdfX9ElnU1dKH22MtV
         1i6PrE8UZgpVqIVWeha6bj9L9m2ahafG02jDVWa/Dxz+s+JxfuzBJLrenqRqRd4v/sIh
         k/EmmVMNaYsX4Hzhiuj2pEuhekA0OvUSnVzRIqeSL68p4hkPhdvO5+b/0LCIIeUj9b50
         X2hICA7m/1oIKuo4NET8fHVg0hs5zsyzCbPEs6a8bsZR0KJm+z/Vt7XdH1sRmhwlqR9C
         lfFJmj7QPv2t7dZD4bVx+tipIS1nxrtnUv8DsKrTLZg1rQy6wAO4ajLU2QbXKej/bl0m
         gMHg==
X-Gm-Message-State: AElRT7FoDNpTcN2geZ8lNTqK9ZRoBAfrXSta5CHCd3umKTLkPto9RzuC
        rS3SCfqu5dSsA9hm1rgleivZdoEN
X-Google-Smtp-Source: AG47ELuECIhIq9/KRsZDm4aauo6rylh7jYIBj9uct77qmAG/VkB8p0/K+/DUh8PChlaVQllsdJMl6w==
X-Received: by 10.223.196.82 with SMTP id a18mr9916617wrg.164.1521466331081;
        Mon, 19 Mar 2018 06:32:11 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:10 -0700 (PDT)
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
Subject: [PATCH v2 02/36] sha1_file: add prepare_external_alt_odb()
Date:   Mon, 19 Mar 2018 14:31:13 +0100
Message-Id: <20180319133147.15413-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new function adds the external odb cache to all
the other odbs.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h     |  1 +
 sha1_file.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/cache.h b/cache.h
index d06932ed0b..2ac7d63e5c 100644
--- a/cache.h
+++ b/cache.h
@@ -1583,6 +1583,7 @@ extern void prepare_alt_odb(void);
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
+extern void prepare_external_alt_odb(void);
 
 /*
  * Allocate a "struct alternate_object_database" but do _not_ actually
diff --git a/sha1_file.c b/sha1_file.c
index 1b94f39c4c..3f00fc716e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -29,6 +29,7 @@
 #include "quote.h"
 #include "packfile.h"
 #include "fetch-object.h"
+#include "external-odb.h"
 
 const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
@@ -663,6 +664,21 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
+void prepare_external_alt_odb(void)
+{
+	static int linked_external;
+	const char *path;
+
+	if (linked_external)
+		return;
+
+	path = external_odb_root();
+	if (!access(path, F_OK)) {
+		link_alt_odb_entry(path, NULL, 0, "");
+		linked_external = 1;
+	}
+}
+
 void prepare_alt_odb(void)
 {
 	const char *alt;
@@ -676,6 +692,7 @@ void prepare_alt_odb(void)
 	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
+	prepare_external_alt_odb();
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
-- 
2.17.0.rc0.37.g8f476fabe9

