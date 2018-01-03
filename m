Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60ADE1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbeACQh2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:37:28 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42641 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeACQeS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:18 -0500
Received: by mail-wm0-f67.google.com with SMTP id b141so3670600wme.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l2elZOJgXQQwBnhJ2TYG3m4h2AJh28lbOIChV9ZdY1c=;
        b=V87V2b/KVz0kY6qDVmywuhwPIxB5FKV69QM6GI9NAM/Bk4jatqanOOmcXGGLvWEAry
         4nxA56GeKMidTVtYP9HsmGfXibBOH6QVx07ZjYFjCU26f+8cUbDmnF83/XlWjmzX5Mqt
         4zVaB2F5OrpTU8bIuxaBc6otmbAvB6ld9GAtqwZdd8BTXNtUDngjOiscQOd1VrwIPlAh
         QfKf9E/wk2s+XAsZNm7JODXX7EnEGMecINZ/2i6Y8oi/uEZjq8Rad9Rb5jJrk+4wdN1m
         7eQLwQN9m6Alv/Qzun8tgkmFRf/lKfLwa6zdczdy91Pg1uok8vEOK+xzEqp+Jr76DdFn
         +9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l2elZOJgXQQwBnhJ2TYG3m4h2AJh28lbOIChV9ZdY1c=;
        b=Adjag8CGmNto+7L3D8PTwU23vV/E2Udrt5w0ZBLon6G5jnR63rww6X1frf3+dIf4Ju
         JrPH8iJPCQEtYtsd+NOliue4R21VMoGVUSNOwWUl9D+4KxuEhN1IIs8Q5Ta8Hf8gcGYc
         7H0XsY2IwIp9ZUESNLSN1Z2+0apZGewPLm4tLGrOqknrvW4JGrRpoW43tstkX+0xZAhH
         mfHZKC4gV0CvL4mRg0Vprow/ZWuwnoIepYmGwaGWv5ysOdasYOF8UfKRV+HnDDKA7ELj
         2sGEKkOEvd4pMWpxKoQZ6prBP8AHwrWHFM3bkE2LBsur2ZeIUXshO0sHpECFLs2TFmab
         /vBA==
X-Gm-Message-State: AKGB3mKVkmtEKoBgXfqSg/vm8OBbv0YJmm6utWgbaRGgl0jkKIfW0YHp
        oseY3CUfxhNIxUOSMC3DinaxTNw1
X-Google-Smtp-Source: ACJfBotXSJdMJaXy2mIhiW2t7aVn9M0FrDViY/zZZ4q3X/JtsSgyXS7eFYCZS0tknyiXe1PlUqOLIw==
X-Received: by 10.28.157.7 with SMTP id g7mr1714458wme.89.1514997256787;
        Wed, 03 Jan 2018 08:34:16 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:16 -0800 (PST)
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
Subject: [PATCH 01/40] Add initial external odb support
Date:   Wed,  3 Jan 2018 17:33:24 +0100
Message-Id: <20180103163403.11303-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
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
 cache.h        |  1 +
 external-odb.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 external-odb.h |  7 ++++++
 odb-helper.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
 odb-helper.h   | 24 ++++++++++++++++++++
 sha1_file.c    | 19 +++++++++++++++-
 7 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 external-odb.c
 create mode 100644 external-odb.h
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h

diff --git a/Makefile b/Makefile
index 2a81ae22e9..07694185c9 100644
--- a/Makefile
+++ b/Makefile
@@ -799,6 +799,7 @@ LIB_OBJS += ewah/ewah_bitmap.o
 LIB_OBJS += ewah/ewah_io.o
 LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec_cmd.o
+LIB_OBJS += external-odb.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
 LIB_OBJS += fsmonitor.o
@@ -834,6 +835,7 @@ LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += object.o
+LIB_OBJS += odb-helper.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
 LIB_OBJS += packfile.o
diff --git a/cache.h b/cache.h
index a2ec8c0b55..21af6442af 100644
--- a/cache.h
+++ b/cache.h
@@ -1587,6 +1587,7 @@ extern void prepare_alt_odb(void);
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
+extern void prepare_external_alt_odb(void);
 
 /*
  * Allocate a "struct alternate_object_database" but do _not_ actually
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
index 0000000000..1404393807
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
+	return have[index].sha1;
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
index 0000000000..9395e606ce
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
+		unsigned char sha1[20];
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
diff --git a/sha1_file.c b/sha1_file.c
index 3da70ac650..3f5ff274e2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -29,6 +29,7 @@
 #include "mergesort.h"
 #include "quote.h"
 #include "packfile.h"
+#include "external-odb.h"
 
 const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
@@ -669,6 +670,21 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
 	return r;
 }
 
+void prepare_external_alt_odb(void)
+{
+	static int linked_external;
+	const char *path;
+
+	if (linked_external)
+		return;
+
+	path = external_odb_root();
+	if (!access(path, F_OK)) {
+		link_alt_odb_entry(path, NULL, 0, "");
+		linked_external = 1;
+	}
+}
+
 void prepare_alt_odb(void)
 {
 	const char *alt;
@@ -682,6 +698,7 @@ void prepare_alt_odb(void)
 	link_alt_odb_entries(alt, PATH_SEP, NULL, 0);
 
 	read_info_alternates(get_object_directory(), 0);
+	prepare_external_alt_odb();
 }
 
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
@@ -722,7 +739,7 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
 		if (check_and_freshen_file(path, freshen))
 			return 1;
 	}
-	return 0;
+	return external_odb_has_object(sha1);
 }
 
 static int check_and_freshen(const unsigned char *sha1, int freshen)
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

