Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963CE1FAE4
	for <e@80x24.org>; Mon, 19 Mar 2018 13:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeCSNcO (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46149 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755270AbeCSNcL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:11 -0400
Received: by mail-wr0-f196.google.com with SMTP id s10so5768920wra.13
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OZle3Y/j+0tIVpx5vxzVWc6VJrDfk7hLXGQoYjYWSGk=;
        b=Qo4EBULyQRUyUU7CDJkoGI245AfkHeCDqwRQHwsur3UyBnOMTIcX4c7IFV5PFWzase
         6MUq8oTSGlA/SrKGf+hqWKFl3DMRR4Web8S1LVu/IdUR5U32dvfBcxe3xHbAVDYmnQtZ
         PrdtdY5A4yoy3hqW0W1fiVfDOido5ZY75mZHYoV2qOHvFVXqxWoqvfMc1FutCcbZLU0o
         f4uo1K3tXZbrdiChEfBC1ZgrfRRfGE/WfL9yJw7nWMuaVR3SIqduh4ISdJjkoO1xJepr
         kVuC69cXpUa//3mtvykEwOijwKa1r234E7hQBRzoWCQrZawf4mK5NjMZx7DTY7ZXLsuT
         8tXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OZle3Y/j+0tIVpx5vxzVWc6VJrDfk7hLXGQoYjYWSGk=;
        b=ZNlXyTkQxr5KesjYsDqpb0hDiReKYBjZqLKD2bbMpO/BxlrBWz8QznlBgIZcy2jRPa
         sKIOelPYdqkRl/Wcj/yg7J1ATHAEnYOSFOncI9CovHFyXg7CXWTXPeImjXPXuDEEpsqj
         WUIT6Hmw5IDtAZDUieDteV+axizZ1M1yvdOFmghfbhDI3Q4j0O35U6Tta4jm18O8SwKp
         amuU9qdmWmYjjlHnkrEpuctCc/yH9b8doM4stFGfFvW4Fo0VJPZPQQUINa2Z+cnMTRTZ
         bR9FR36mKV0U1Y7IiH2jOsljv/6NTAb6DUZ2dyxN7197JKISqWrc9sVsEos+HmMuWia2
         5k+A==
X-Gm-Message-State: AElRT7G8Bjg+iMeBS7+XZoPgomluU268xiNDEqbFbErukFQbYJfugnii
        3YAk0MWyWw5Z+V0dYDenVFwNWa/b
X-Google-Smtp-Source: AG47ELsKxi+Gxq3xp/WjWtKu/GmARBQEC77lwac9BCpuRid6Ejp8/fOyARUKanbXFLFPKspw1hkCWA==
X-Received: by 10.223.130.194 with SMTP id 60mr3932330wrc.46.1521466329504;
        Mon, 19 Mar 2018 06:32:09 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:08 -0700 (PDT)
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
Subject: [PATCH v2 01/36] Add initial external odb support
Date:   Mon, 19 Mar 2018 14:31:12 +0100
Message-Id: <20180319133147.15413-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The external-odb.{c,h} files will contain the functions
that are called by the rest of Git mostly from
"sha1_file.c" to access the objects managed by the
external odbs.

The odb-helper.{c,h} files will contain the functions to
actually implement communication with either the internal
functions or the external scripts or processes that will
manage and provide external git objects.

For now only infrastructure to create helpers from the
config and to manage a cache for the 'have' command is
implemented.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile       |  2 ++
 external-odb.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 external-odb.h |  7 +++++
 odb-helper.c   | 54 +++++++++++++++++++++++++++++++++++++
 odb-helper.h   | 24 +++++++++++++++++
 5 files changed, 159 insertions(+)
 create mode 100644 external-odb.c
 create mode 100644 external-odb.h
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h

diff --git a/Makefile b/Makefile
index a1d8775adb..11dd620155 100644
--- a/Makefile
+++ b/Makefile
@@ -808,6 +808,7 @@ LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec_cmd.o
+LIB_OBJS += external-odb.o
 LIB_OBJS += fetch-object.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
@@ -843,6 +844,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
+LIB_OBJS += odb-helper.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
 LIB_OBJS += packfile.o
diff --git a/external-odb.c b/external-odb.c
new file mode 100644
index 0000000000..f3ea491333
--- /dev/null
+++ b/external-odb.c
@@ -0,0 +1,72 @@
+#include "cache.h"
+#include "external-odb.h"
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
+static int external_odb_config(const char *var, const char *value, void *data)
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
+		return git_config_string(&o->dealer, var, value);
+
+	return 0;
+}
+
+static void external_odb_init(void)
+{
+	static int initialized;
+
+	if (initialized)
+		return;
+	initialized = 1;
+
+	git_config(external_odb_config, NULL);
+}
+
+const char *external_odb_root(void)
+{
+	static const char *root;
+	if (!root)
+		root = git_pathdup("objects/external");
+	return root;
+}
+
+int external_odb_has_object(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	external_odb_init();
+
+	for (o = helpers; o; o = o->next)
+		if (odb_helper_has_object(o, sha1))
+			return 1;
+	return 0;
+}
+
diff --git a/external-odb.h b/external-odb.h
new file mode 100644
index 0000000000..ae2b228792
--- /dev/null
+++ b/external-odb.h
@@ -0,0 +1,7 @@
+#ifndef EXTERNAL_ODB_H
+#define EXTERNAL_ODB_H
+
+extern const char *external_odb_root(void);
+extern int external_odb_has_object(const unsigned char *sha1);
+
+#endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
new file mode 100644
index 0000000000..67196e6317
--- /dev/null
+++ b/odb-helper.c
@@ -0,0 +1,54 @@
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
+
+struct odb_helper_cmd {
+	struct argv_array argv;
+	struct child_process child;
+};
+
+static void odb_helper_load_have(struct odb_helper *o)
+{
+	if (o->have_valid)
+		return;
+	o->have_valid = 1;
+
+	/* TODO */
+}
+
+static const unsigned char *have_sha1_access(size_t index, void *table)
+{
+	struct odb_helper_object *have = table;
+	return have[index].oid.hash;
+}
+
+static struct odb_helper_object *odb_helper_lookup(struct odb_helper *o,
+						   const unsigned char *sha1)
+{
+	int idx;
+
+	odb_helper_load_have(o);
+	idx = sha1_pos(sha1, o->have, o->have_nr, have_sha1_access);
+	if (idx < 0)
+		return NULL;
+	return &o->have[idx];
+}
+
+int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1)
+{
+	return !!odb_helper_lookup(o, sha1);
+}
+
diff --git a/odb-helper.h b/odb-helper.h
new file mode 100644
index 0000000000..e3c9c1cfe4
--- /dev/null
+++ b/odb-helper.h
@@ -0,0 +1,24 @@
+#ifndef ODB_HELPER_H
+#define ODB_HELPER_H
+
+struct odb_helper {
+	const char *name;
+	const char *dealer;
+
+	struct odb_helper_object {
+		struct object_id oid;
+		unsigned long size;
+		enum object_type type;
+	} *have;
+	int have_nr;
+	int have_alloc;
+	int have_valid;
+
+	struct odb_helper *next;
+};
+
+extern struct odb_helper *odb_helper_new(const char *name, int namelen);
+extern int odb_helper_has_object(struct odb_helper *o,
+				 const unsigned char *sha1);
+
+#endif /* ODB_HELPER_H */
-- 
2.17.0.rc0.37.g8f476fabe9

