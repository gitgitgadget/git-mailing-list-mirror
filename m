Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FAFF20379
	for <e@80x24.org>; Mon,  1 Apr 2019 16:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfDAQlO (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:41:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36916 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfDAQlO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:41:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so113371wmf.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+uJKNeyVs7eJOOFHMl19MBknHdS/OUfniwpw59xGsIs=;
        b=hLzJbZ4Pun9VrnTWKuxIzhxKlvb9NzSB3f0XyjcGzFQL7f1p81GWuH4gjGp4+T11QD
         VmSmnjLfdvvLoXskvjnXlbi0Tzxj0u+yzy1TXgc7eCwLheY7L6nIMgWfQy58VM7pwV0p
         82NJjjmvRlJiDkbWZgD95mMRUGJHaP1oOAXB+uvP4Bxt7V8u7HG10eg5b9G2ZqVHoXxe
         VGuiLz9mjNHcdNpiy8qRNyk43u3xx4qPHlK+9XkHuR3Ar0ZAs421S6mYJ5tlDAEGPUsM
         2c67sSUpowqVqUmJfrpTwuIzdjkNK+Olx29Uty2qsifbyLy+nnPsWRXwP+1jVKkQjTSw
         Lj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+uJKNeyVs7eJOOFHMl19MBknHdS/OUfniwpw59xGsIs=;
        b=Bvlvj2d70NpWkWmfWeizFJOCSwTgtYyJ9NJUjP2DqEvBa3tqH5RfJDXasX5N3PscoW
         ozVUcc9HdIwG72RD8Bp+86V6LhGnRSMaPxNJaIB4xSvPzRe794YjXywKisn2LXgMe7bi
         b2B5IDpewwbXFfz1dt5T5WHefG4YZvoHmdO8IkXdIWyJrFHTcP8XyQ7CmDZd9L6DmVL7
         6d08GYD0qMsxzMUQV9ucvSWzPfFUWXaMpx6zcn+tfCYquvw1ghkBzkvaFfYYIOz+af5k
         7GTba15apIiiUhyuN+SCGNehlkuMnA7qMIDFUXTTPlltDp0felFY2XGxl1zZlEThKbmo
         XBeg==
X-Gm-Message-State: APjAAAXirV4qgW2RtskRmp3sN6mNkzSThm3w4Y5aIzmfnC0ZBleAv474
        WBXSazOcCiN2A8dwqK/6RFoQgn6N
X-Google-Smtp-Source: APXvYqwFW6yuDIAzXlfFFlPpHPfUXZgWJp9leinLe0/r2OZFQ1abBXz8ZQnEt0Dc2hTZBJuZ3frbUw==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr352754wmb.110.1554136871264;
        Mon, 01 Apr 2019 09:41:11 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:101d:3e80:8542:d1d4:667f:a0da])
        by smtp.gmail.com with ESMTPSA id s10sm11749070wmh.0.2019.04.01.09.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:41:10 -0700 (PDT)
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
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 02/11] Add initial support for many promisor remotes
Date:   Mon,  1 Apr 2019 18:40:36 +0200
Message-Id: <20190401164045.17328-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.203.gd44fa53258
In-Reply-To: <20190401164045.17328-1-chriscool@tuxfamily.org>
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

The promisor-remote.{c,h} files will contain functions to
manage many promisor remotes.

We expect that there will not be a lot of promisor remotes,
so it is ok to use a simple linked list to manage them.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile          |  1 +
 promisor-remote.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++
 promisor-remote.h | 16 +++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 promisor-remote.c
 create mode 100644 promisor-remote.h

diff --git a/Makefile b/Makefile
index 3e03290d8f..79b45060a1 100644
--- a/Makefile
+++ b/Makefile
@@ -953,6 +953,7 @@ LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
 LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
+LIB_OBJS += promisor-remote.o
 LIB_OBJS += prompt.o
 LIB_OBJS += protocol.o
 LIB_OBJS += quote.o
diff --git a/promisor-remote.c b/promisor-remote.c
new file mode 100644
index 0000000000..0c768210ee
--- /dev/null
+++ b/promisor-remote.c
@@ -0,0 +1,92 @@
+#include "cache.h"
+#include "promisor-remote.h"
+#include "config.h"
+
+static struct promisor_remote *promisors;
+static struct promisor_remote **promisors_tail = &promisors;
+
+static struct promisor_remote *promisor_remote_new(const char *remote_name)
+{
+	struct promisor_remote *r;
+
+	if (*remote_name == '/') {
+		warning(_("promisor remote name cannot begin with '/': %s"),
+			remote_name);
+		return NULL;
+	}
+
+	FLEX_ALLOC_STR(r, name, remote_name);
+
+	*promisors_tail = r;
+	promisors_tail = &r->next;
+
+	return r;
+}
+
+static struct promisor_remote *promisor_remote_lookup(const char *remote_name,
+						      struct promisor_remote **previous)
+{
+	struct promisor_remote *r, *p;
+
+	for (p = NULL, r = promisors; r; p = r, r = r->next)
+		if (r->name && !strcmp(r->name, remote_name)) {
+			if (previous)
+				*previous = p;
+			return r;
+		}
+
+	return NULL;
+}
+
+static int promisor_remote_config(const char *var, const char *value, void *data)
+{
+	const char *name;
+	int namelen;
+	const char *subkey;
+
+	if (parse_config_key(var, "remote", &name, &namelen, &subkey) < 0)
+		return 0;
+
+	if (!strcmp(subkey, "promisor")) {
+		char *remote_name;
+
+		if (!git_config_bool(var, value))
+			return 0;
+
+		remote_name = xmemdupz(name, namelen);
+
+		if (!promisor_remote_lookup(remote_name, NULL))
+			promisor_remote_new(remote_name);
+
+		free(remote_name);
+		return 0;
+	}
+
+	return 0;
+}
+
+static void promisor_remote_init(void)
+{
+	static int initialized;
+
+	if (initialized)
+		return;
+	initialized = 1;
+
+	git_config(promisor_remote_config, NULL);
+}
+
+struct promisor_remote *promisor_remote_find(const char *remote_name)
+{
+	promisor_remote_init();
+
+	if (!remote_name)
+		return promisors;
+
+	return promisor_remote_lookup(remote_name, NULL);
+}
+
+int has_promisor_remote(void)
+{
+	return !!promisor_remote_find(NULL);
+}
diff --git a/promisor-remote.h b/promisor-remote.h
new file mode 100644
index 0000000000..01dcdf4dc7
--- /dev/null
+++ b/promisor-remote.h
@@ -0,0 +1,16 @@
+#ifndef PROMISOR_REMOTE_H
+#define PROMISOR_REMOTE_H
+
+/*
+ * Promisor remote linked list
+ * Its information come from remote.XXX config entries.
+ */
+struct promisor_remote {
+	struct promisor_remote *next;
+	const char name[FLEX_ARRAY];
+};
+
+extern struct promisor_remote *promisor_remote_find(const char *remote_name);
+extern int has_promisor_remote(void);
+
+#endif /* PROMISOR_REMOTE_H */
-- 
2.21.0.203.gd44fa53258

