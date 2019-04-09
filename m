Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CDD12037F
	for <e@80x24.org>; Tue,  9 Apr 2019 16:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDIQLx (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:11:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43428 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfDIQLt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:11:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so21629455wrx.10
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4yazDCGjft1r6zafJgy+9GM8LpQdf1guYns4hTQWHw=;
        b=fWkR48OKd9zvBZfghu9ch8AuQT0sfimWxr4tJpfpfelmY/5J59OW4lwAJ99yM1hSBQ
         3iHaugG1ltJ6qadzFc87V0r/96+TRUsfTjDEd+xyUJbavSaMdmgl22rljIWjPXxqKahb
         KQGFr9kAtoVSb6HxrN5Ydc/CYg+heHAVG/bLc3ng9iapA4etaQaFkTj0nAuzr5snWs6y
         qxRE0oT0yc/PFfkOrMYBe+bb2SJlPWhbuRn0hMZfZB+3hucR47V15pOl+yv1geiPWNK9
         bNOrqzFiN3zY7lPV+VKz9ZPQNNyZq0xEVrmOjKp1069lmMqqyHpw9Y7X3Ju12UVeFDV7
         8xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4yazDCGjft1r6zafJgy+9GM8LpQdf1guYns4hTQWHw=;
        b=bavS6PQUa7uPmezAv10qm/TdbNVYvWqWT6ZeX9zJHv2slNmXLmBHwMtQa1okHrhvUa
         QEml5Bu/iq85YJD7vaW82dWQe4YO+scz7ZyzH7ocL5SEo6IwFTDWJcAU1rX+SRMIZl4u
         OY9uUUN+zybiZjE9SNtsWGtlB9r7WmEM267/VXkenfX1VHkOZOwzeBLC5aDG91Z/i9h4
         7o7fEth1oRRoDY6pKRX+s8h7MQyOmUqTl4sI9Y05p9y0Ly0PvzrLvyKbuCwtIm51aVcM
         C6attPXoUbX8E5mjG+LCvUbsrMaEB8OaBRIuCVuU0e/WvqmX4KSV8SjWeF/T+zayf+IY
         KWzw==
X-Gm-Message-State: APjAAAWBShZW5BGFfeEWqTiWfiJP9eLJArIhZ7/RmkPat7A1bUR4elNI
        W01XKZZSjirkdO1y/KIJDk6u5WtJ
X-Google-Smtp-Source: APXvYqy9LBIDHrDILAH4BYOhYIB5oZGJkJmQK9hZVJuvUw9dAcEJmcG1RCNYhQfk949ZiLIJyTkeqA==
X-Received: by 2002:adf:9c91:: with SMTP id d17mr22526470wre.285.1554826307408;
        Tue, 09 Apr 2019 09:11:47 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:11:45 -0700 (PDT)
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
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 04/16] promisor-remote: implement promisor_remote_get_direct()
Date:   Tue,  9 Apr 2019 18:11:04 +0200
Message-Id: <20190409161116.30256-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

This is implemented for now by calling fetch_objects(). It fetches
from all the promisor remotes.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 promisor-remote.h |  3 +++
 2 files changed, 69 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index c249b80e02..289f1dd074 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1,6 +1,8 @@
 #include "cache.h"
+#include "object-store.h"
 #include "promisor-remote.h"
 #include "config.h"
+#include "fetch-object.h"
 
 static struct promisor_remote *promisors;
 static struct promisor_remote **promisors_tail = &promisors;
@@ -90,3 +92,67 @@ int has_promisor_remote(void)
 {
 	return !!promisor_remote_find(NULL);
 }
+
+static int remove_fetched_oids(struct object_id **oids, int oid_nr, int to_free)
+{
+	int i, missing_nr = 0;
+	int *missing = xcalloc(oid_nr, sizeof(*missing));
+	struct object_id *old_oids = *oids;
+	struct object_id *new_oids;
+	int old_fetch_if_missing = fetch_if_missing;
+
+	fetch_if_missing = 0;
+
+	for (i = 0; i < oid_nr; i++)
+		if (oid_object_info_extended(the_repository, &old_oids[i], NULL, 0)) {
+			missing[i] = 1;
+			missing_nr++;
+		}
+
+	fetch_if_missing = old_fetch_if_missing;
+
+	if (missing_nr) {
+		int j = 0;
+		new_oids = xcalloc(missing_nr, sizeof(*new_oids));
+		for (i = 0; i < oid_nr; i++)
+			if (missing[i])
+				oidcpy(&new_oids[j++], &old_oids[i]);
+		*oids = new_oids;
+		if (to_free)
+			free(old_oids);
+	}
+
+	free(missing);
+
+	return missing_nr;
+}
+
+int promisor_remote_get_direct(const struct object_id *oids, int oid_nr)
+{
+	struct promisor_remote *r;
+	struct object_id *missing_oids = (struct object_id *)oids;
+	int missing_nr = oid_nr;
+	int to_free = 0;
+	int res = -1;
+
+	promisor_remote_init();
+
+	for (r = promisors; r; r = r->next) {
+		if (fetch_objects(r->name, missing_oids, missing_nr) < 0) {
+			if (missing_nr == 1)
+				continue;
+			missing_nr = remove_fetched_oids(&missing_oids, missing_nr, to_free);
+			if (missing_nr) {
+				to_free = 1;
+				continue;
+			}
+		}
+		res = 0;
+		break;
+	}
+
+	if (to_free)
+		free(missing_oids);
+
+	return res;
+}
diff --git a/promisor-remote.h b/promisor-remote.h
index 01dcdf4dc7..92650cfd4c 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -1,6 +1,8 @@
 #ifndef PROMISOR_REMOTE_H
 #define PROMISOR_REMOTE_H
 
+struct object_id;
+
 /*
  * Promisor remote linked list
  * Its information come from remote.XXX config entries.
@@ -12,5 +14,6 @@ struct promisor_remote {
 
 extern struct promisor_remote *promisor_remote_find(const char *remote_name);
 extern int has_promisor_remote(void);
+extern int promisor_remote_get_direct(const struct object_id *oids, int oid_nr);
 
 #endif /* PROMISOR_REMOTE_H */
-- 
2.21.0.750.g68c8ebb2ac

