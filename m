Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E013C208E9
	for <e@80x24.org>; Thu,  2 Aug 2018 06:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeHBIFK (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 04:05:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54187 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHBIFK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 04:05:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id s9-v6so1089895wmh.3
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 23:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dUYRRmKuksjrhgIShDDPHgGxzPW/oFuQH4jgxmgHBYs=;
        b=gBAl2pyaKIuV9pRc6MtFZ1d4BywYA7jokVpSvzxfq2wSvMcHc+zjqmahIcLh6UvhAs
         17YXyeNoGzJfnomhJc7onDPEivDAsyNa2wfRDJfWiLDFt+4IHKCCXghxtpe9c7Mb8WW3
         8WWOZAQqJMPmLgdSgzOqMPVqyOZQURNKSBcOs6fduYDaQitMlWYJFoRBAcmGHaV2VfUD
         H7NVVrQEkAsb/7/k1UhfIwMKjc97yC9aBulZFBT84OGsIiE20AwP36ErSkwjKVB0BruS
         B++uJ/Xq7PpAiDADCJGeCRGNtf+ChoG7p8beUz4CsR+JrKqtco2WP+0QHMKEQina3Z6n
         5NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dUYRRmKuksjrhgIShDDPHgGxzPW/oFuQH4jgxmgHBYs=;
        b=ngp4Wr/keqR5umpG4gUXwBpYTjHZunKv2JDg0nzvONQ8/UIHkLUsRbKQtzevceJ3oN
         2dPyqiGfOh5F3VENTP2pZqb5AhWQklBmG6N5ZHYzfIdhQ2n5oZdHGVDsYYom3U3l0R9N
         r/TamVfsjKgmJxvOyMuHbe9dhmJUqHNr2zjgiVsoH1GqDFOfAsvFfsWuNspeBZpQswbi
         1xYlY9J2yBSFq5QY/PdJX5rq/ayUPKATQ6ZY97iAZojA+BzQRs0m1LtzbaQK0w40aY0O
         jKwhegJS2OqTf58TB2iCiO1onyS/rr9b78yGjFQ0+feYpKNH1RA2/Z/g+lWlaqAO4N8G
         XehQ==
X-Gm-Message-State: AOUpUlHazbElC35uO9JzEBP5HmN7IWyHHIrdnXViYvNubJRFi2aO8PSn
        V0smv3rPqq6LY4s5aywyxKawp4px
X-Google-Smtp-Source: AAOMgpezpA3QLT9at0pynWLURRcfdysfBOAtNQiN/XidvrdcFfAjhxelkzus/dcaO1hGLoAztiofQg==
X-Received: by 2002:a1c:7015:: with SMTP id l21-v6mr903888wmc.81.1533190536777;
        Wed, 01 Aug 2018 23:15:36 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:109f:b149:1092:6e1:496b:fd26])
        by smtp.gmail.com with ESMTPSA id m200-v6sm1093018wma.32.2018.08.01.23.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 23:15:36 -0700 (PDT)
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
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 2/9] Add initial remote odb support
Date:   Thu,  2 Aug 2018 08:14:58 +0200
Message-Id: <20180802061505.2983-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.330.g17eb9fed90
In-Reply-To: <20180802061505.2983-1-chriscool@tuxfamily.org>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile     |  2 ++
 odb-helper.c | 16 +++++++++
 odb-helper.h | 19 +++++++++++
 remote-odb.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote-odb.h |  7 ++++
 5 files changed, 135 insertions(+)
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100644 remote-odb.c
 create mode 100644 remote-odb.h

diff --git a/Makefile b/Makefile
index 08e5c54549..2a9bd02208 100644
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
index 0000000000..03be54ba2e
--- /dev/null
+++ b/remote-odb.c
@@ -0,0 +1,91 @@
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
+static struct odb_helper *do_find_odb_helper(const char *remote)
+{
+	struct odb_helper *o;
+
+	for (o = helpers; o; o = o->next)
+		if (o->remote && !strcmp(o->remote, remote))
+			return o;
+
+	return NULL;
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
+	if (!strcmp(subkey, "promisorremote")) {
+		const char *remote;
+		int res = git_config_string(&remote, var, value);
+
+		if (res)
+			return res;
+
+		if (do_find_odb_helper(remote))
+			return error(_("when parsing config key '%s' "
+				       "helper for remote '%s' already exists"),
+				     var, remote);
+
+		o->remote = remote;
+
+		return 0;
+	}
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
+	remote_odb_init();
+
+	if (!remote)
+		return helpers;
+
+	return do_find_odb_helper(remote);
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
2.18.0.330.g17eb9fed90

