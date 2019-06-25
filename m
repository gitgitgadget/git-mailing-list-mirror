Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852FA1F4B6
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfFYNlM (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43626 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfFYNlL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so27164556edr.10
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nwn5LqtJPnLfB1W/n67QhtQIQYjR44RipOuBBt93sys=;
        b=MR9rmF86F1Siawr6j85Fa/BypsaOvlKUqhksEPOE3+hnOOZYwGhrU1ATAvz62mEV+i
         s/jW/WC6vntPe9jaK13zNrEs/YXxkWm1POSPY84iwTPX4Mss3QE3aSPHNVYgJXw7szvT
         4BzZ8hHO0Gl30aeOvqPgSXOdu4306uy2xi/ZTJTpbpLEnNx4IPc+ZpZoqSYOmJnmnyrV
         rZlOkM0AU0Tbz37z+BuOtDGWnHcCIS1PUYUeNdH7Y+DOuzCrYgVf0b5rmb5bkeIE1Tkp
         /v2e0XDNWjkzi8niOCQsntBCntyfTW8bcrJIkTfXGY9VHV4sJqCxPW3P5a9y9BJRB31i
         vxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nwn5LqtJPnLfB1W/n67QhtQIQYjR44RipOuBBt93sys=;
        b=R2en0wNxq7nglfZrRwtEMj3R4sXRN64oYJ/HEmO4QVl7sGvb2PB077860KxHZsRrQP
         ZtRqWRkBoqIbEIoOC9wYzkEkUfLfr8bkdMjfC/qGQN0bbqNpSsS/Oy+wCrU+jexIlzFH
         C6qObikneQX1BqIRrKv2CV+7BxNyd+UYWneB1afGpCppiSoWpGYwgqhQapjJobWI9vpM
         hAOC8BQt3oR/NV+z58fg5YfAjcYZoy8os9KWwdjn6GPhQfWN/eJIiotNB3XBQyl/NmK5
         qJ9i5siQlOkoWPESDoOF9tSY6JqRaCFj/UVcIAIzo/RQO1CpW/HTG4WafxeRzvTZtsmX
         4pcg==
X-Gm-Message-State: APjAAAVZGoMkfSnzSACEm3brOgitHS0tANDvK0QIdW8Hd4TU/y8QC9tq
        DsOtZModU1lnR4LM8vcTnF99SfuLMZQ=
X-Google-Smtp-Source: APXvYqyyLi2TaERZlxM4KtS3cnYG6mpemRoWnWzTM6YfO6dtnnIT8ZzpFRLdzOJCc/xu/I42D0rsOw==
X-Received: by 2002:a50:940b:: with SMTP id p11mr61361756eda.194.1561470068946;
        Tue, 25 Jun 2019 06:41:08 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:08 -0700 (PDT)
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
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 03/15] Add initial support for many promisor remotes
Date:   Tue, 25 Jun 2019 15:40:27 +0200
Message-Id: <20190625134039.21707-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile          |  1 +
 promisor-remote.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++
 promisor-remote.h | 16 +++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 promisor-remote.c
 create mode 100644 promisor-remote.h

diff --git a/Makefile b/Makefile
index f58bf14c7b..049bc8cfd4 100644
--- a/Makefile
+++ b/Makefile
@@ -944,6 +944,7 @@ LIB_OBJS += preload-index.o
 LIB_OBJS += pretty.o
 LIB_OBJS += prio-queue.o
 LIB_OBJS += progress.o
+LIB_OBJS += promisor-remote.o
 LIB_OBJS += prompt.o
 LIB_OBJS += protocol.o
 LIB_OBJS += quote.o
diff --git a/promisor-remote.c b/promisor-remote.c
new file mode 100644
index 0000000000..c249b80e02
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
+		if (!strcmp(r->name, remote_name)) {
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
2.22.0.229.ga13d9ffdf7.dirty

