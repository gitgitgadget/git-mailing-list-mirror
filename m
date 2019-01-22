Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848D82141A
	for <e@80x24.org>; Tue, 22 Jan 2019 14:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfAVOmn (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:42:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37287 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfAVOmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 09:42:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so14432094wmd.2
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pKiSDrHmvOLfdHOET6EWLlQtaJLwLiW26pKNK863HMM=;
        b=nsl785e/OgwKmxH54QKf0fBmRPs1awsByJYYrv44OurnPmuey6lOzI+cYYYomGtXgw
         TxC73wz+g9fTatm/cfEO50RZow1Woekpisr2DpvYVrDrDBx/3EjDERI/BurLzoP5Wmb3
         WfvQuy18rgq8q57AcfquxgaMwQ9enz0turTCohu/LxTVmmnzOCTr+8ZMsGwiUvVut2Kq
         uWQjNuavn2oHLaOqTrvQEhT0V06Xl8HLhIbjZLyc4LX7A4k493n8t7bQChvyKI4YcMOJ
         uu28drI9qkmVULlt8809fDHHiQvyG/ChVqVl5HHk2nhVrEjXsAvx5xcSmREWaBBY20+6
         EuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKiSDrHmvOLfdHOET6EWLlQtaJLwLiW26pKNK863HMM=;
        b=LlxT39l/em5sXqjpvoIT2ne51/YbV0JYDab78+0DvOCZ4VwXUZMCudhYSpDZEfU5Ee
         ye6o7YvJ23PFr3c5Co+cRATPc0kHo9kMfaJW8klk4atkMQHigSf6g4cvJr4FeZj7/EP5
         w8/uCfH06hjJsDO+GHKltRXrKvjjd35AHVpRNpVBpwabA83eqJ5RqwsWjyE7jUH01HgK
         QxIUgDFEW8cE3Bd5zEQ62xj02Nsw9n1sQHgWEnSFHKMVfDuzH5Y9UOXEdatRSjn2WW/K
         auwc3A/B+31oTquzY/98+OskuloqVHIlu5moNEHC1+7wtegBxx4V/MtFgYo2BrAbn45J
         8S7g==
X-Gm-Message-State: AJcUukdnqXAaKadJUbmiR1mNqtjKRrQTFv45yxzbJnKGGo2smJjryquJ
        zp+PdWrS6KCz7Tpect0cjrUFwKVT
X-Google-Smtp-Source: ALg8bN7LeqRkHcwIFLvWpdgnksvl+7tGM6biLwdoPQYrZAh6xU6OwL6vbDXUxs3v0aZaStLH3g8crw==
X-Received: by 2002:a1c:2787:: with SMTP id n129mr4182614wmn.128.1548168152810;
        Tue, 22 Jan 2019 06:42:32 -0800 (PST)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id k26sm31266168wmi.28.2019.01.22.06.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:42:32 -0800 (PST)
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
Subject: [PATCH v2 04/13] Add initial support for many promisor remotes
Date:   Tue, 22 Jan 2019 15:42:03 +0100
Message-Id: <20190122144212.15119-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.322.gd6b9ae60d4
In-Reply-To: <20190122144212.15119-1-chriscool@tuxfamily.org>
References: <20190122144212.15119-1-chriscool@tuxfamily.org>
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
index 1a44c811aa..565a5fbb4e 100644
--- a/Makefile
+++ b/Makefile
@@ -949,6 +949,7 @@ LIB_OBJS += preload-index.o
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
2.20.1.322.gd6b9ae60d4

