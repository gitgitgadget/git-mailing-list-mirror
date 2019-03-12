Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480BE20377
	for <e@80x24.org>; Tue, 12 Mar 2019 13:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfCLNaU (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 09:30:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43092 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfCLNaS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id m35so2264910ede.10
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hw5FkOkjpdxozIvis1yT3kMadFYOiBoUwesRa2Fd4lE=;
        b=RblRkCXnOrSX/7necRtOgSecCnngBuEE6QeU2lDPAzxXsUeYrUub9eg1AQIhghF+to
         NTPXBPH+DSNNJxkRbP1BW1dcU5dZUygxTaftZXq0y0Lq7UE93dJXe6vETDOOlXVF2QaI
         xsj5qdynnTisELzGk9ttxg5AUUmgdFBfQohmbpqwuzMHVIyDG0yuysDSKI6cwBTfIivC
         Y0yQtEGvmryWM2n9wK63yQqag7JySP3eTWIPnyZEV8bwoaSCwSRasi26bHDG02nEgE1l
         v9DcuWozhwHTmZlqsr56/bPc7eHhSO/Nct0CafV0UBlFADINK4dFndKn+/OLqTUPnfp8
         nJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hw5FkOkjpdxozIvis1yT3kMadFYOiBoUwesRa2Fd4lE=;
        b=aEeOQWNUvayfuN4y53/QlZmByvcSJOUcP4X9bl21EOhSrQAXCAe0BIRtBsYEjvFB6d
         aeO2tVgZQ87WLPSMX70REs3Hm17jt6g7Ms8agfn8DKzMISCJ0F+6JhRSVvuD98S7AUXt
         0yeEPGckJjvEUq+7m6MNfUFvcLAC7HkVphB0qpQJh3TvwrhXqznUdQVbZHoFI3eM9pQl
         0L4pMckepw5r6FjgyVbI/diYRpdEZsYPQwAk58ZO/ORn7dSJERFSs271kT2nZ0eVwii+
         PCLyEgbrOP156sv0PWeSSLk14WhsSQ5LaDyhuejpX3yGRi+VQlA19ASpXVyY9ewTq3Gj
         O4XQ==
X-Gm-Message-State: APjAAAV2TnvVAHW3VfTQUgDccR651kAEs5uhh4nEEmupgs4MR4+7fZUb
        m0d8eNxefET2IOxEmRZtyTJTzybK
X-Google-Smtp-Source: APXvYqxlumMJhKRkaDban5GLnDdAGGWz0k1pK+kyryMlAcRxGoE5N3GsFHzs77D/XIRVvgoUOwu9cg==
X-Received: by 2002:aa7:dd8b:: with SMTP id g11mr3462187edv.75.1552397415641;
        Tue, 12 Mar 2019 06:30:15 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id h8sm5875213edk.21.2019.03.12.06.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:15 -0700 (PDT)
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
Subject: [PATCH v3 02/11] Add initial support for many promisor remotes
Date:   Tue, 12 Mar 2019 14:29:50 +0100
Message-Id: <20190312132959.11764-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.166.gb5e4dbcfd3
In-Reply-To: <20190312132959.11764-1-chriscool@tuxfamily.org>
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
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
 Makefile          |   1 +
 promisor-remote.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++
 promisor-remote.h |  17 ++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 promisor-remote.c
 create mode 100644 promisor-remote.h

diff --git a/Makefile b/Makefile
index 537493822b..4f24ccb3dc 100644
--- a/Makefile
+++ b/Makefile
@@ -972,6 +972,7 @@ LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
 LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
+LIB_OBJS += promisor-remote.o
 LIB_OBJS += prompt.o
 LIB_OBJS += protocol.o
 LIB_OBJS += quote.o
diff --git a/promisor-remote.c b/promisor-remote.c
new file mode 100644
index 0000000000..d2f574651e
--- /dev/null
+++ b/promisor-remote.c
@@ -0,0 +1,100 @@
+#include "cache.h"
+#include "promisor-remote.h"
+#include "config.h"
+
+static struct promisor_remote *promisors;
+static struct promisor_remote **promisors_tail = &promisors;
+
+struct promisor_remote *promisor_remote_new(const char *remote_name)
+{
+	struct promisor_remote *o;
+
+	o = xcalloc(1, sizeof(*o));
+	o->remote_name = xstrdup(remote_name);
+
+	*promisors_tail = o;
+	promisors_tail = &o->next;
+
+	return o;
+}
+
+static struct promisor_remote *promisor_remote_look_up(const char *remote_name,
+						       struct promisor_remote **previous)
+{
+	struct promisor_remote *o, *p;
+
+	for (p = NULL, o = promisors; o; p = o, o = o->next)
+		if (o->remote_name && !strcmp(o->remote_name, remote_name)) {
+			if (previous)
+				*previous = p;
+			return o;
+		}
+
+	return NULL;
+}
+
+static void promisor_remote_move_to_tail(struct promisor_remote *o,
+					 struct promisor_remote *previous)
+{
+	if (previous)
+		previous->next = o->next;
+	else
+		promisors = o->next ? o->next : o;
+	o->next = NULL;
+	*promisors_tail = o;
+	promisors_tail = &o->next;
+}
+
+static int promisor_remote_config(const char *var, const char *value, void *data)
+{
+	struct promisor_remote *o;
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
+		if (!promisor_remote_look_up(remote_name, NULL))
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
+	return promisor_remote_look_up(remote_name, NULL);
+}
+
+int has_promisor_remote(void)
+{
+	return !!promisor_remote_find(NULL);
+}
diff --git a/promisor-remote.h b/promisor-remote.h
new file mode 100644
index 0000000000..bfbf7c0f21
--- /dev/null
+++ b/promisor-remote.h
@@ -0,0 +1,17 @@
+#ifndef PROMISOR_REMOTE_H
+#define PROMISOR_REMOTE_H
+
+/*
+ * Promisor remote linked list
+ * Its information come from remote.XXX config entries.
+ */
+struct promisor_remote {
+	const char *remote_name;
+	struct promisor_remote *next;
+};
+
+extern struct promisor_remote *promisor_remote_new(const char *remote_name);
+extern struct promisor_remote *promisor_remote_find(const char *remote_name);
+extern int has_promisor_remote(void);
+
+#endif /* PROMISOR_REMOTE_H */
-- 
2.21.0.166.gb5e4dbcfd3

