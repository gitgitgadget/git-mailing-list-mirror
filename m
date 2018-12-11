Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C481A20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 05:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbeLKF2M (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 00:28:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47099 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbeLKF2L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 00:28:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so12662899wrt.13
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 21:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6Avg48SowHLfYs20Xzi415uBeQZHl9WsF4bqj5V+RY=;
        b=BAA2m2F0sAsIklKRFFxdvLvjaRn5QJXfnsobj+HAddo2/O/KJ3e6DhgTusuXSgdJLJ
         wQYdmPW5oAgjfvr2VeHjUsyQObBL8WGU5OaqUm+qgO43yof0XiUvBlwXqiSeK+IhDD37
         /+7HTqMx+UEBs9ljaSNcrzd/vGn8vpIBqX02ISfJi3+DKJYLTw3Uwp7QVbb2puUbyRTI
         eSZkqM8+ujt5OQh5HcXRU6nDxXyxNxtFoxC4z+NUO94wmVpx8RicD57KGIdQUAcLiKTq
         tQOrEfj3XzzOZVZbLyErKWTHoYqj/nRhuClbgXe4tKNKCW6J1NTPYBpUQq2f+HgloWgh
         JRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6Avg48SowHLfYs20Xzi415uBeQZHl9WsF4bqj5V+RY=;
        b=oY7d6OHh3554f+TAWkdd0n4fgtVoRAXmuiBbZCrtW/LO4jk0MG86jHApogYQitJhdG
         xc1+PxShmnPFmxiiO3vy44PvJqjhB4XulyqJwghGWmgu7rPtSpH/ephEBFAje03XxQlN
         L+fgKUH/Xq4EkFoRZSPTVfzRlKRW5APJCDajmIw9lm8m2XJv9+2RwhBpC8HT6W1IWJD/
         F4GXivEt+Mk/LP0bo7/48rxsYIp8Uquslz/JRDdxba1papgIFEv/jDJpw1mJd/vj1KPp
         VC2CgW8CNMGObtYvzuT90UYn1J/Cj99D1iYgrSZ0NYMiw18mj6Te1LKXug9uO+PiT6H7
         UBvQ==
X-Gm-Message-State: AA+aEWYMozvGOIhnIG4JyGnBp71tI6/OikJhlgWLOnplla8zd9Eu5T5o
        bgq4YFNdT4578ZvLHBi317CEuqWO
X-Google-Smtp-Source: AFSGD/XtYGlC4bJ2NyU+43aWlQLJpzdV1gGkYV+HFT6lzyMIEi6KP8MuOw7zmMih65CgxQiUuc92VQ==
X-Received: by 2002:adf:ee89:: with SMTP id b9mr12732176wro.246.1544506089041;
        Mon, 10 Dec 2018 21:28:09 -0800 (PST)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l197sm3708185wma.44.2018.12.10.21.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 21:28:08 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v1 3/8] promisor-remote: implement promisors_get_direct()
Date:   Tue, 11 Dec 2018 06:27:41 +0100
Message-Id: <20181211052746.16218-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.0.rc2.14.g1379de12fa.dirty
In-Reply-To: <20181211052746.16218-1-chriscool@tuxfamily.org>
References: <20181211052746.16218-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

This is implemented for now by calling fetch_objects(). It fetches
from all the promisor remotes.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 33 +++++++++++++++++++++++++++++++++
 promisor-remote.h |  1 +
 2 files changed, 34 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 701f5a351b..e0724bdc20 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "promisor-remote.h"
 #include "config.h"
+#include "fetch-object.h"
 
 static struct promisor_remote *promisors;
 static struct promisor_remote **promisors_tail = &promisors;
@@ -88,3 +89,35 @@ int has_promisor_remote(void)
 {
 	return !!find_promisor_remote(NULL);
 }
+
+static int promisor_remote_get_direct(struct promisor_remote *o,
+				      const struct object_id *oids,
+				      int oid_nr)
+{
+	int res;
+	uint64_t start = getnanotime();
+
+	res = fetch_objects(o->remote_name, oids, oid_nr);
+
+	trace_performance_since(start, "promisor_remote_get_direct");
+
+	return res;
+}
+
+int promisors_get_direct(const struct object_id *oids, int oid_nr)
+{
+	struct promisor_remote *o;
+
+	trace_printf("trace: promisor_remote_get_direct: nr: %d", oid_nr);
+
+	promisor_remote_init();
+
+	for (o = promisors; o; o = o->next) {
+		if (promisor_remote_get_direct(o, oids, oid_nr) < 0)
+			continue;
+		return 0;
+	}
+
+	return -1;
+}
+
diff --git a/promisor-remote.h b/promisor-remote.h
index d07ac07a43..8b89221b33 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -13,5 +13,6 @@ struct promisor_remote {
 extern struct promisor_remote *promisor_remote_new(const char *remote_name);
 extern struct promisor_remote *find_promisor_remote(const char *remote_name);
 extern int has_promisor_remote(void);
+extern int promisors_get_direct(const struct object_id *oids, int oid_nr);
 
 #endif /* PROMISOR_REMOTE_H */
-- 
2.20.0.rc2.14.g1379de12fa.dirty

