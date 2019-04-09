Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D76420380
	for <e@80x24.org>; Tue,  9 Apr 2019 16:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfDIQMH (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:12:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53842 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfDIQMG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:12:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so4258815wmj.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ywh7pk8fJOay6WPvPOMpZ/tRvhES9EqCpsD1ysVDC1I=;
        b=OXsz5MGBTrfz19kRbQL4UnsMVpkUU6XOgRpFwZFbNhyhJqK75MeC1X53JsRb6W9Oh2
         SAxL1B2eZKD54XYOEnX9o6gIqhMq9tGzjEzTMs3Lmu4gteQQJvWDfh3FcKJ3YRaDJJKN
         5Ic7aXFFawB4KJRbZb+U+XScj4jJa8zhI69NEiVcDD/tzN8sVSzrdLYk37GkBKagqjoZ
         rLWCRNuvAPVcZx2e1B8UdoQwI8Q1WPBOf/oJuLKuM+BQQ2MzaVwA5557nqB/i2AC0qy+
         AMicsG3bHqbKh3jBOBI/ccG5f3TcqwKfycys891rv4k3HdNyPzNh6e+bhI+eGNob1ns1
         lu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ywh7pk8fJOay6WPvPOMpZ/tRvhES9EqCpsD1ysVDC1I=;
        b=uFiZ4TOA0yCJBqpWmTZNVM7UGnK7u8S+ELcSxWrMJ6PedM3uHPrR1bhZOox7SuHtCd
         w2FGQc8bMTNcYNvI34t2nZG2lVF46CykZ5IG1S9o/n5x/ZEEKn6Wr2b53EeU1Ibso9h9
         KJKkLEK+TxBrMPbUu3zpVFLkrb0PVouMWUrO4iH6NYLlteenie6zPrjCNr7qBs0CCcyF
         Xz/Rapu1b2Eg04nX+Cp/vOW1U7vKgPbHh05JdCxb3ZhYmXEMGC/RL8bVG7wJmt+0JBj8
         RBDTMAgjL5H0OU3POeCbjz6gAKCeFKow4XWjZFiTxy5gouDpdZosKQPW4TpOc8MG1e4d
         kh4w==
X-Gm-Message-State: APjAAAVKeZUQwMo618KzTEhnTCodyiuIr7avTTYEGVpUX+Kwt87BMzuS
        z3iMA9kxMpTwX6omjXfbkRTDaBys
X-Google-Smtp-Source: APXvYqxiF3sVwl1q8DBgHDd7Aqos/3BdU1f5UUHGviiw2i/MDdnOnlZioW0YzAmDm4gwNu2hlxoIPA==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr21441287wmk.82.1554826323222;
        Tue, 09 Apr 2019 09:12:03 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:12:02 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 14/16] Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
Date:   Tue,  9 Apr 2019 18:11:14 +0200
Message-Id: <20190409161116.30256-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As fetch_objects() is now used only in promisor-remote.c
and should't be used outside it, let's move it into
promisor-remote.c, make it static there, and remove
fetch-object.{c,h}.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile          |  1 -
 fetch-object.c    | 43 -------------------------------------------
 fetch-object.h    |  9 ---------
 promisor-remote.c | 40 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 39 insertions(+), 54 deletions(-)
 delete mode 100644 fetch-object.c
 delete mode 100644 fetch-object.h

diff --git a/Makefile b/Makefile
index 3523ae0517..0996fb6646 100644
--- a/Makefile
+++ b/Makefile
@@ -890,7 +890,6 @@ LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec-cmd.o
 LIB_OBJS += fetch-negotiator.o
-LIB_OBJS += fetch-object.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
diff --git a/fetch-object.c b/fetch-object.c
deleted file mode 100644
index eac4d448ef..0000000000
--- a/fetch-object.c
+++ /dev/null
@@ -1,43 +0,0 @@
-#include "cache.h"
-#include "packfile.h"
-#include "pkt-line.h"
-#include "strbuf.h"
-#include "transport.h"
-#include "fetch-object.h"
-
-static int fetch_refs(const char *remote_name, struct ref *ref)
-{
-	struct remote *remote;
-	struct transport *transport;
-	int original_fetch_if_missing = fetch_if_missing;
-	int res;
-
-	fetch_if_missing = 0;
-	remote = remote_get(remote_name);
-	if (!remote->url[0])
-		die(_("Remote with no URL"));
-	transport = transport_get(remote, remote->url[0]);
-
-	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
-	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
-	res = transport_fetch_refs(transport, ref);
-	fetch_if_missing = original_fetch_if_missing;
-
-	return res;
-}
-
-int fetch_objects(const char *remote_name, const struct object_id *oids,
-		  int oid_nr)
-{
-	struct ref *ref = NULL;
-	int i;
-
-	for (i = 0; i < oid_nr; i++) {
-		struct ref *new_ref = alloc_ref(oid_to_hex(&oids[i]));
-		oidcpy(&new_ref->old_oid, &oids[i]);
-		new_ref->exact_oid = 1;
-		new_ref->next = ref;
-		ref = new_ref;
-	}
-	return fetch_refs(remote_name, ref);
-}
diff --git a/fetch-object.h b/fetch-object.h
deleted file mode 100644
index 7bcc7cadb0..0000000000
--- a/fetch-object.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef FETCH_OBJECT_H
-#define FETCH_OBJECT_H
-
-struct object_id;
-
-int fetch_objects(const char *remote_name, const struct object_id *oids,
-		  int oid_nr);
-
-#endif
diff --git a/promisor-remote.c b/promisor-remote.c
index 707a8005c5..066489b637 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -2,7 +2,45 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 #include "config.h"
-#include "fetch-object.h"
+#include "transport.h"
+
+static int fetch_refs(const char *remote_name, struct ref *ref)
+{
+	struct remote *remote;
+	struct transport *transport;
+	int original_fetch_if_missing = fetch_if_missing;
+	int res;
+
+	fetch_if_missing = 0;
+	remote = remote_get(remote_name);
+	if (!remote->url[0])
+		die(_("Remote with no URL"));
+	transport = transport_get(remote, remote->url[0]);
+
+	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
+	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
+	res = transport_fetch_refs(transport, ref);
+	fetch_if_missing = original_fetch_if_missing;
+
+	return res;
+}
+
+static int fetch_objects(const char *remote_name,
+			 const struct object_id *oids,
+			 int oid_nr)
+{
+	struct ref *ref = NULL;
+	int i;
+
+	for (i = 0; i < oid_nr; i++) {
+		struct ref *new_ref = alloc_ref(oid_to_hex(&oids[i]));
+		oidcpy(&new_ref->old_oid, &oids[i]);
+		new_ref->exact_oid = 1;
+		new_ref->next = ref;
+		ref = new_ref;
+	}
+	return fetch_refs(remote_name, ref);
+}
 
 static struct promisor_remote *promisors;
 static struct promisor_remote **promisors_tail = &promisors;
-- 
2.21.0.750.g68c8ebb2ac

