Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB2A1F516
	for <e@80x24.org>; Sat, 23 Jun 2018 12:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751929AbeFWMT1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 08:19:27 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:40145 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeFWMTG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 08:19:06 -0400
Received: by mail-wr0-f176.google.com with SMTP id g18-v6so9121723wro.7
        for <git@vger.kernel.org>; Sat, 23 Jun 2018 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TYxOA+nbWkxTat8/q7A1B/XSs+t4ZJnOcZyvfqdFAao=;
        b=Bcja3TQtarVluXypAVzGzjcBroZX3bOjEbWPfV6w4a0nBOyp7DPwAJKaZ23/d6komU
         IwRyuJVzxswm4vXvkvCwchrNpcHkDLo3RuOIElN6Tx3Zg98tYu1MN26guZxMdHyhBV6i
         3/A4aHgPT8ce0HxRi23eZOrTV6iIvzJhQqshJ4oNqnRi/DBisBRxwfePHKmasvbo865B
         98CG3tWYSVKX9IYBrd57jeROdflu3znIEVqk4rNKw3J1CSUc/EmI4GL+uyIjir88QkDK
         SZfOA28IAgdr4TwekfzEbpGWcM9h8BffwNrNBX9JLfwqOImOYXKjKUztLKf3jGGapp3U
         zSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TYxOA+nbWkxTat8/q7A1B/XSs+t4ZJnOcZyvfqdFAao=;
        b=tS86sH/7gKHXdnXmedS5FWg8DoUIfcZpuI/d+DY5VrcGcbS1Vjc3B4dlyNnGTPsYs8
         YLE8UBv8aVn700Y2a6PuBP/pLZdufZa6RHWXyuqyO8eTbkqMZSLjeUD2mmSG58Luaakh
         u1L68/x/YeRFhKJWk856G4N2gnBj2z8b29OUUtgDoHZKLndMjjz2dgnU0utrFYEBZ6mE
         TtZBV8jYtCqRY/9BbV9r6dtxIC1l62Cp43YtVaQgLLfeDUTM9ybFKtqCBh8uvJYFSfnb
         YY8U9WlVDTYDHQbljYJ5dmiz6fH9VekBvCJo4F9FiQCyz9oNXqRX1YT80zFj2kLAIRYB
         udSQ==
X-Gm-Message-State: APt69E1eUcxNTKrn0B0LxDwcyzKCdVgmE4hX52Xlhh1KN8vTjYs7uKa5
        Z7jbOKj/ixwrf5a7kkSvz+TNvRct
X-Google-Smtp-Source: AAOMgpfnk1TNdPNHCPjkZ19ELMa7M8W1N761hPColVDeBkoOy619sypU1a0/7/iAcnIiYdYfxTnMPQ==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr4716051wrc.40.1529756345334;
        Sat, 23 Jun 2018 05:19:05 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id q14-v6sm5527731wmd.20.2018.06.23.05.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 05:19:04 -0700 (PDT)
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
Subject: [PATCH v1 03/11] remote-odb: implement remote_odb_get_direct()
Date:   Sat, 23 Jun 2018 14:18:40 +0200
Message-Id: <20180623121846.19750-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.762.g886f54ea46
In-Reply-To: <20180623121846.19750-1-chriscool@tuxfamily.org>
References: <20180623121846.19750-1-chriscool@tuxfamily.org>
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
index 1dc165eaf6..a34537c05c 100644
--- a/remote-odb.c
+++ b/remote-odb.c
@@ -70,3 +70,20 @@ int has_remote_odb(void)
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
2.17.0.762.g886f54ea46

