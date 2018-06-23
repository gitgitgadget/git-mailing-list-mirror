Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58FE41F597
	for <e@80x24.org>; Sat, 23 Jun 2018 12:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeFWMTI (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 08:19:08 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46136 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752052AbeFWMTF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 08:19:05 -0400
Received: by mail-wr0-f195.google.com with SMTP id l14-v6so4060206wrq.13
        for <git@vger.kernel.org>; Sat, 23 Jun 2018 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E2cR17pd/sr3kpqaCYuqh9NbOwMVlqNLX6uu+CFXoIE=;
        b=U8mvfSjUI7t9MYnnG9JyZYuWOAPuutOfYJ4Y56o3z0XHhaFG+R4buuY9kviUSpI+N4
         sUZOQaSQQTYXu100fGay50f0Dcjjs7IkWOkNLe8l8J1QsHqZZkzfXxfYsQSAxIO8VK3M
         T4X12b+WWfORgnmP3Fx9vIZ+Dil5GO/cyYXlknViTdIwn3zfQVrpvxtWj87+u11uz1PT
         yy51sHgGR2Mi3Dk+sj0te0xN7loSgPR483L/y03P0hXmuisghzKWmjSgDn8IlFxBkSHf
         4EDX7R2B8lCpCGtadsjxpOhJGf6pLKqri5wFtar4FMFxYYvMiKsraAynWHwxZnpSXHsj
         4sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E2cR17pd/sr3kpqaCYuqh9NbOwMVlqNLX6uu+CFXoIE=;
        b=JvAyNgy1cW6JghSPiUMLqa6382mFf+6pxcAciva3YOfwBzkQOTZOtap6CyFbxY/o3H
         EukS9+V1xBO5KeuqG4hVGcSnRXc5i4ThRjSeIHfhx0jegvUhP+uiqafjpdz0VkETgTcN
         IY6Eo1yv1ZgKL7WTuvQV5s/RY7fKBqt1ki19JVpfKMd+nGX/38ZgwaUZh/nZVvzxxLiL
         bIFZvu/VjnUEDAp7K5vxl3bcidmfEMgOI15KXUQyg0sRwMRGFk1o5kjKEcF32L0m62R0
         YwzqCeMlR1xMs4mtj9hF+v8MjD69PytyL+9LujAhI+tk4R1CXHdNWgX72r7C2vcvYxsV
         tiKA==
X-Gm-Message-State: APt69E0mcRE37vv8qrUQDeQtTlcYqlBxpSpy0ztMlzgYSKMcqGTNt+Ar
        u8N2SvIwWXVgYV1d0uZxXDtQGF06
X-Google-Smtp-Source: AAOMgpe2lkSSolEMWj+xNx63N3G+iWb+7cfapCZBbKIryvd6XkB6ZtNg61ZesKy9yraC08eZfInOVw==
X-Received: by 2002:adf:93c6:: with SMTP id 64-v6mr4537512wrp.119.1529756343884;
        Sat, 23 Jun 2018 05:19:03 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id q14-v6sm5527731wmd.20.2018.06.23.05.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 05:19:03 -0700 (PDT)
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
Subject: [PATCH v1 02/11] Add initial remote odb support
Date:   Sat, 23 Jun 2018 14:18:39 +0200
Message-Id: <20180623121846.19750-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.762.g886f54ea46
In-Reply-To: <20180623121846.19750-1-chriscool@tuxfamily.org>
References: <20180623121846.19750-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The remote-odb.{c,h} files will contain the functions
that are called by the rest of Git mostly from
"sha1-file.c" to access the objects managed by the
remote odbs.

The odb-helper.{c,h} files will contain the functions to
actually implement communication with either the internal
functions or the external scripts or processes that will
manage and provide remote git objects.

For now only infrastructure to create helpers from the
config and to check if there are remote odbs and odb
helpers is implemented.

We expect that there will not be a lot of helpers, so it
is ok to use a simple linked list to manage them.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile     |  2 ++
 odb-helper.c | 16 ++++++++++++
 odb-helper.h | 19 ++++++++++++++
 remote-odb.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote-odb.h |  7 +++++
 5 files changed, 116 insertions(+)
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100644 remote-odb.c
 create mode 100644 remote-odb.h

diff --git a/Makefile b/Makefile
index e4b503d259..8465e3ccd4 100644
--- a/Makefile
+++ b/Makefile
@@ -896,6 +896,8 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
+LIB_OBJS += odb-helper.o
+LIB_OBJS += remote-odb.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
 LIB_OBJS += packfile.o
diff --git a/odb-helper.c b/odb-helper.c
new file mode 100644
index 0000000000..b4d403ffa9
--- /dev/null
+++ b/odb-helper.c
@@ -0,0 +1,16 @@
+#include "cache.h"
+#include "object.h"
+#include "argv-array.h"
+#include "odb-helper.h"
+#include "run-command.h"
+#include "sha1-lookup.h"
+
+struct odb_helper *odb_helper_new(const char *name, int namelen)
+{
+	struct odb_helper *o;
+
+	o = xcalloc(1, sizeof(*o));
+	o->name = xmemdupz(name, namelen);
+
+	return o;
+}
diff --git a/odb-helper.h b/odb-helper.h
new file mode 100644
index 0000000000..4b792a3896
--- /dev/null
+++ b/odb-helper.h
@@ -0,0 +1,19 @@
+#ifndef ODB_HELPER_H
+#define ODB_HELPER_H
+
+/*
+ * An odb helper is a way to access a remote odb.
+ *
+ * Information in its fields comes from the config file [odb "NAME"]
+ * entries.
+ */
+struct odb_helper {
+	const char *name;                 /* odb.<NAME>.* */
+	const char *remote;               /* odb.<NAME>.promisorRemote */
+
+	struct odb_helper *next;
+};
+
+extern struct odb_helper *odb_helper_new(const char *name, int namelen);
+
+#endif /* ODB_HELPER_H */
diff --git a/remote-odb.c b/remote-odb.c
new file mode 100644
index 0000000000..1dc165eaf6
--- /dev/null
+++ b/remote-odb.c
@@ -0,0 +1,72 @@
+#include "cache.h"
+#include "remote-odb.h"
+#include "odb-helper.h"
+#include "config.h"
+
+static struct odb_helper *helpers;
+static struct odb_helper **helpers_tail = &helpers;
+
+static struct odb_helper *find_or_create_helper(const char *name, int len)
+{
+	struct odb_helper *o;
+
+	for (o = helpers; o; o = o->next)
+		if (!strncmp(o->name, name, len) && !o->name[len])
+			return o;
+
+	o = odb_helper_new(name, len);
+	*helpers_tail = o;
+	helpers_tail = &o->next;
+
+	return o;
+}
+
+static int remote_odb_config(const char *var, const char *value, void *data)
+{
+	struct odb_helper *o;
+	const char *name;
+	int namelen;
+	const char *subkey;
+
+	if (parse_config_key(var, "odb", &name, &namelen, &subkey) < 0)
+		return 0;
+
+	o = find_or_create_helper(name, namelen);
+
+	if (!strcmp(subkey, "promisorremote"))
+		return git_config_string(&o->remote, var, value);
+
+	return 0;
+}
+
+static void remote_odb_init(void)
+{
+	static int initialized;
+
+	if (initialized)
+		return;
+	initialized = 1;
+
+	git_config(remote_odb_config, NULL);
+}
+
+struct odb_helper *find_odb_helper(const char *remote)
+{
+	struct odb_helper *o;
+
+	remote_odb_init();
+
+	if (!remote)
+		return helpers;
+
+	for (o = helpers; o; o = o->next)
+		if (!strcmp(o->remote, remote))
+			return o;
+
+	return NULL;
+}
+
+int has_remote_odb(void)
+{
+	return !!find_odb_helper(NULL);
+}
diff --git a/remote-odb.h b/remote-odb.h
new file mode 100644
index 0000000000..4c7b13695f
--- /dev/null
+++ b/remote-odb.h
@@ -0,0 +1,7 @@
+#ifndef REMOTE_ODB_H
+#define REMOTE_ODB_H
+
+extern struct odb_helper *find_odb_helper(const char *remote);
+extern int has_remote_odb(void);
+
+#endif /* REMOTE_ODB_H */
-- 
2.17.0.762.g886f54ea46

