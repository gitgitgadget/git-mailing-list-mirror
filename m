Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAEC420377
	for <e@80x24.org>; Tue,  9 Apr 2019 16:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfDIQLt (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:11:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37233 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfDIQLs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:11:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so4002820wmf.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CwuNyocFjBz/OD2XS+em3Lh8A8L82/w2MDgZ9CiAvL4=;
        b=fjiC/FkgN1SrpLYFNX65SIFfd21nm+zNDXWVvet94uJgCDqd/xdP9R7eGdwrme7KV5
         6wVYXZk5nMkBtOMk2w3JBV0ykoSeCLOZpdyzj2VBH1kZO5tBwSoRXzp1pE8O2wrb/RAS
         RciJO9skytyphv7ZxKzulwLrTKG35cQN58hKffaKOkb45yQF2c9ZGjw+WGttUiQ0OSQY
         5oPfnVlNU1v0u5R6q/ZjXui+6xlHnoBBaA5BWBSqKaPPTW+VRrLMdubJ5tbr8F9/YjGF
         CSSWfnzwdH1x/M1WlYRiuGyqd1FQ4fr0Y6KeOsJHQjSBblSCu2BJWSYqZeUHMTF2V7RO
         TtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CwuNyocFjBz/OD2XS+em3Lh8A8L82/w2MDgZ9CiAvL4=;
        b=I9dez/y63NP9fEuxrZTH4x+288aHpOX+5Xl+2lqQM8H+RnJNsryun8XclVNLxG1Oj8
         jeJe3dtuX+ca7mgja2KnMXhn7BoGoG4Dsay6ShxZmNgw1T9brElGrDKC3h3yiSdEX+T7
         aX/Ie41jUSoW3YAt4d9tNHOdDdIkP1dErVSbxysx8tjh8LZEPSraaNRlubDay3Wsm5Lp
         O/lh6nyj6HQjsPshGVnNdqxEhQFz0hM6LdnRvq01O3pnKLUhUXu0xhfJDjJhh9YWzKI4
         sBXRq+kMLmndx6k7GUMnAn8yXmSi6p8f0EfkWp4+7Nnuz3M+Il/sF1P0S8Xe0zRR0yFQ
         pnBw==
X-Gm-Message-State: APjAAAWSohxHu8QCjZ7wSEVX+5M84lEpZx72BOLNr4bPGCVUtOg2GGEF
        EjzuVKYI/Ol/9UVHx8XYBsG9fKHS
X-Google-Smtp-Source: APXvYqzMWtpIv3mz8M+eM6t+ij+8k1c47zeDjWYiORjMjXxiRoe55GwKUARpU1nTNrah7Ld4mRimaw==
X-Received: by 2002:a1c:486:: with SMTP id 128mr18549084wme.3.1554826305730;
        Tue, 09 Apr 2019 09:11:45 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.11.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:11:43 -0700 (PDT)
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
Subject: [PATCH v5 03/16] Add initial support for many promisor remotes
Date:   Tue,  9 Apr 2019 18:11:03 +0200
Message-Id: <20190409161116.30256-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
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
index 34fa9da39a..3523ae0517 100644
--- a/Makefile
+++ b/Makefile
@@ -954,6 +954,7 @@ LIB_OBJS += preload-index.o
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
2.21.0.750.g68c8ebb2ac

