Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6BE520A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 05:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeLKF2M (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 00:28:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35150 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbeLKF2K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 00:28:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so827610wmh.0
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 21:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FyxXPcl1mtmM4B7FNlUbG6Fa4zo6QIcLJrF7xx1bedM=;
        b=cTysa74HbWQ5ZJ1esZVzEPGEKEP4n5eh3LV2JsV63mBAwzN6wipleleo9RkJJPCQ4B
         2jTtaHCjfghWEr8p6zuRki/7NZJUbsqLp4rn2mpxmwq3+Mgs2tQZIOke8zjEdCsnwTzf
         C183ZoOruX0FjE5JcLNetYP75+wbxMO7DQ5Uzr6IK0K1rj795QJLEtinn0NoraHpcfeJ
         NLV0gq71l49/H9eq7+Uhf6Lkl7g8BVEUXF/1mpjAS7ekNSKD5bVfqTrKwSV4P7F5ex5Z
         1oziD4dJf4ALXtVknWneZu4ow0H3MsjoelflZUwfT3CpfKTfJgeZ02WRTSQzBgFvF7mS
         x9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FyxXPcl1mtmM4B7FNlUbG6Fa4zo6QIcLJrF7xx1bedM=;
        b=KXGbne9pnAhZjFbewpr4hc76dRSLGU/A1Zs4I7JgdI70fWHj5//lHiOe7j8rQx+1ic
         E/PRDHM4l39HvSHIAR0REdSFEXrF8cKPfV87rLwnS9HeVBfx7LfsqL7sF10tUgOBBBBK
         gXkbkTmSD4tgQU2xjdUUsjvT107GDFM87H/XUHXiC6ccTOBohn8x9q/Jw6/QD4HpLh63
         XHPyDv7LuHUecK2lw6/cX4vwvq05M9cbidfVfgK1PVBNs2lEceJ5vhl+fXKwFsGi2iJn
         Bd1z+KQIv3Px4blsdzXJc2xAxCJmMi1KA4oO1cDavw/qjjDfbWBaODqZ2K8DOi0N1J5L
         MT8w==
X-Gm-Message-State: AA+aEWaBg8QLgG5x4sMphsaDIipB42qsvwdPyDCbXin2W0Um30syARDV
        U6nJbFCqea1C2nmGVdxc5cNCL50g
X-Google-Smtp-Source: AFSGD/WrXfU28riM1MH2mqDWZjbblQNK/wYqO+uygeo4TEc+f0VmAmYMcKm4R4EYhd6Nz0gWWdHxxA==
X-Received: by 2002:a1c:709:: with SMTP id 9mr923205wmh.39.1544506087434;
        Mon, 10 Dec 2018 21:28:07 -0800 (PST)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l197sm3708185wma.44.2018.12.10.21.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 21:28:06 -0800 (PST)
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
Subject: [PATCH v1 2/8] Add initial support for many promisor remotes
Date:   Tue, 11 Dec 2018 06:27:40 +0100
Message-Id: <20181211052746.16218-3-chriscool@tuxfamily.org>
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

The promisor-remote.{c,h} files will contain functions to
manage many promisor remotes.

We expect that there will not be a lot of promisor remotes,
so it is ok to use a simple linked list to manage them.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile          |  1 +
 promisor-remote.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 promisor-remote.h | 17 +++++++++
 3 files changed, 108 insertions(+)
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
index 0000000000..701f5a351b
--- /dev/null
+++ b/promisor-remote.c
@@ -0,0 +1,90 @@
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
+static struct promisor_remote *do_find_promisor_remote(const char *remote_name)
+{
+	struct promisor_remote *o;
+
+	for (o = promisors; o; o = o->next)
+		if (o->remote_name && !strcmp(o->remote_name, remote_name))
+			return o;
+
+	return NULL;
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
+		if (do_find_promisor_remote(remote_name)) {
+			free(remote_name);
+			return error(_("when parsing config key '%s' "
+				       "promisor remote '%s' already exists"),
+				     var, remote_name);
+		}
+
+		promisor_remote_new(remote_name);
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
+struct promisor_remote *find_promisor_remote(const char *remote_name)
+{
+	promisor_remote_init();
+
+	if (!remote_name)
+		return promisors;
+
+	return do_find_promisor_remote(remote_name);
+}
+
+int has_promisor_remote(void)
+{
+	return !!find_promisor_remote(NULL);
+}
diff --git a/promisor-remote.h b/promisor-remote.h
new file mode 100644
index 0000000000..d07ac07a43
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
+extern struct promisor_remote *find_promisor_remote(const char *remote_name);
+extern int has_promisor_remote(void);
+
+#endif /* PROMISOR_REMOTE_H */
-- 
2.20.0.rc2.14.g1379de12fa.dirty

