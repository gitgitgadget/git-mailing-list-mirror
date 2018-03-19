Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAA051F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933372AbeCSNcz (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35734 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755550AbeCSNcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id r82so5154269wme.0
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ULN8ykzt4o4P24ouwE92KSHKYKitVObCL7/gI09Fo/I=;
        b=cpHBn/nkN6XQKI/merXmSClsIXZQ2qbEVOWOB/C7/3rQXzdNqY97AEKRI+72d37JKk
         Jdi+w92ciLfiGQBja+eEZzsmIxt1pznZIxx3aWl8G0iDd8/cqxAfzpNxezWRYN4U7C3M
         GDvSL73V6Mu4YhUj40r2ILUgunPjsBkWLJm/0rztbEYqyw0lEy2wSzmxUKo18TIYTupx
         +iXxOKGNLvT5QEzUdSIgLYw0IviCcH8+p6Jht+y5uUiZUeD9ugbvtDo6alWOfKVIzbFg
         vjSxzFa6D/oFP686/XIYgNG8phLiwSGVmOIt+KiUhNj+E0dEW2giWawPPXGMFgqHAzlh
         Qk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ULN8ykzt4o4P24ouwE92KSHKYKitVObCL7/gI09Fo/I=;
        b=lHv1BIl4qOz7W8VwXlD/94GXUJqtrrA+o+tlJE1biJfWcCZ1sB0/k1P6Neiog0wvHw
         XTcFs0FTd985FVhGECYqFw+8Wq5r49D7ud69y3kLduTIqIrz7PpUHF2yoB5x+LDj+fiQ
         w2VL4Om1i/Xho4uddkCGGnB8VFC87lfJ4yt0qfyAsE3gpUk5tbvP1jVatb0RgeH3z1KR
         H1Z+Cf3na8GtJ938FCJdiu5sLhdng7zowbPMpA9285N5awOAblKhedndj9ijuzzqeHM6
         npfhr4WNvx38e/r6K4rMumVln7q+tRXQIeuNdr+Q9AYvDHlRZGxjGhvKO0vjggRkqVlJ
         NSVg==
X-Gm-Message-State: AElRT7G2IgScZC/wmRg+gUc4EnsojLyl27Xfze1k269v3g7x4icAzV77
        y4oqDQEcaP6Z1ficPJ/7m8eFPGQv
X-Google-Smtp-Source: AG47ELvLR6i+l/f9/S16gxPLTdcb2iciKVY9desjcCqdijnHKMwxAjuE60sZaKrKX7qhEfGc5hqUJg==
X-Received: by 10.28.134.135 with SMTP id i129mr5342197wmd.160.1521466343450;
        Mon, 19 Mar 2018 06:32:23 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:22 -0700 (PDT)
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
Subject: [PATCH v2 11/36] odb-helper: add odb_helper_init() to send 'init' instruction
Date:   Mon, 19 Mar 2018 14:31:22 +0100
Message-Id: <20180319133147.15413-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's add an odb_helper_init() function to send an 'init'
instruction to the helpers. This 'init' instruction is
especially useful to get the capabilities that are supported
by the helpers.

So while at it, let's also add a parse_capabilities()
function to parse them and a supported_capabilities
variable in struct odb_helper to store them.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c          | 13 ++++++++-
 odb-helper.c            | 58 +++++++++++++++++++++++++++++++++++++++++
 odb-helper.h            | 11 ++++++++
 t/t0500-external-odb.sh |  4 +++
 4 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/external-odb.c b/external-odb.c
index 9f797d66f4..ae6bc017fe 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -35,6 +35,8 @@ static int external_odb_config(const char *var, const char *value, void *data)
 
 	if (!strcmp(subkey, "promisorremote")) {
 		o->type = ODB_HELPER_GIT_REMOTE;
+		o->supported_capabilities |= ODB_HELPER_CAP_HAVE;
+		o->supported_capabilities |= ODB_HELPER_CAP_GET_DIRECT;
 		return git_config_string(&o->dealer, var, value);
 	}
 	if (!strcmp(subkey, "scriptcommand")) {
@@ -52,12 +54,16 @@ static int external_odb_config(const char *var, const char *value, void *data)
 static void external_odb_do_init(int force)
 {
 	static int initialized;
+	struct odb_helper *o;
 
 	if ((!force && initialized) || !use_external_odb)
 		return;
 	initialized = 1;
 
 	git_config(external_odb_config, NULL);
+
+	for (o = helpers; o; o = o->next)
+		odb_helper_init(o);
 }
 
 static inline void external_odb_init(void)
@@ -104,9 +110,12 @@ int external_odb_has_object(const unsigned char *sha1)
 
 	external_odb_init();
 
-	for (o = helpers; o; o = o->next)
+	for (o = helpers; o; o = o->next) {
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_HAVE))
+			return 1;
 		if (odb_helper_has_object(o, sha1))
 			return 1;
+	}
 	return 0;
 }
 
@@ -164,6 +173,8 @@ int external_odb_get_direct(const unsigned char *sha1)
 	external_odb_init();
 
 	for (o = helpers; o; o = o->next) {
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_GET_DIRECT))
+			continue;
 		if (odb_helper_get_direct(o, sha1) < 0)
 			continue;
 		return 0;
diff --git a/odb-helper.c b/odb-helper.c
index bf3c1ad8ac..a99f4a1299 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -6,6 +6,40 @@
 #include "sha1-lookup.h"
 #include "fetch-object.h"
 
+static void parse_capabilities(char *cap_buf,
+			       unsigned int *supported_capabilities,
+			       const char *process_name)
+{
+	struct string_list cap_list = STRING_LIST_INIT_NODUP;
+
+	string_list_split_in_place(&cap_list, cap_buf, '=', 1);
+
+	if (cap_list.nr == 2 && !strcmp(cap_list.items[0].string, "capability")) {
+		const char *cap_name = cap_list.items[1].string;
+
+		if (!strcmp(cap_name, "get_git_obj")) {
+			*supported_capabilities |= ODB_HELPER_CAP_GET_GIT_OBJ;
+		} else if (!strcmp(cap_name, "get_raw_obj")) {
+			*supported_capabilities |= ODB_HELPER_CAP_GET_RAW_OBJ;
+		} else if (!strcmp(cap_name, "get_direct")) {
+			*supported_capabilities |= ODB_HELPER_CAP_GET_DIRECT;
+		} else if (!strcmp(cap_name, "put_git_obj")) {
+			*supported_capabilities |= ODB_HELPER_CAP_PUT_GIT_OBJ;
+		} else if (!strcmp(cap_name, "put_raw_obj")) {
+			*supported_capabilities |= ODB_HELPER_CAP_PUT_RAW_OBJ;
+		} else if (!strcmp(cap_name, "put_direct")) {
+			*supported_capabilities |= ODB_HELPER_CAP_PUT_DIRECT;
+		} else if (!strcmp(cap_name, "have")) {
+			*supported_capabilities |= ODB_HELPER_CAP_HAVE;
+		} else {
+			warning("external process '%s' requested unsupported read-object capability '%s'",
+				process_name, cap_name);
+		}
+	}
+
+	string_list_clear(&cap_list, 0);
+}
+
 struct odb_helper *odb_helper_new(const char *name, int namelen)
 {
 	struct odb_helper *o;
@@ -80,6 +114,30 @@ static int odb_helper_finish(struct odb_helper *o,
 	return 0;
 }
 
+int odb_helper_init(struct odb_helper *o)
+{
+	struct odb_helper_cmd cmd;
+	FILE *fh;
+	struct strbuf line = STRBUF_INIT;
+
+	if (o->initialized)
+		return 0;
+	o->initialized = 1;
+
+	if (odb_helper_start(o, &cmd, "init") < 0)
+		return -1;
+
+	fh = xfdopen(cmd.child.out, "r");
+	while (strbuf_getline(&line, fh) != EOF)
+		parse_capabilities(line.buf, &o->supported_capabilities, o->name);
+
+	strbuf_release(&line);
+	fclose(fh);
+	odb_helper_finish(o, &cmd);
+
+	return 0;
+}
+
 static int parse_object_line(struct odb_helper_object *o, const char *line)
 {
 	char *end;
diff --git a/odb-helper.h b/odb-helper.h
index 819182f76a..7720684744 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -3,10 +3,20 @@
 
 #include "external-odb.h"
 
+#define ODB_HELPER_CAP_GET_GIT_OBJ    (1u<<0)
+#define ODB_HELPER_CAP_GET_RAW_OBJ    (1u<<1)
+#define ODB_HELPER_CAP_GET_DIRECT     (1u<<2)
+#define ODB_HELPER_CAP_PUT_GIT_OBJ    (1u<<3)
+#define ODB_HELPER_CAP_PUT_RAW_OBJ    (1u<<4)
+#define ODB_HELPER_CAP_PUT_DIRECT     (1u<<5)
+#define ODB_HELPER_CAP_HAVE           (1u<<6)
+
 struct odb_helper {
 	const char *name;
 	const char *dealer;
 	enum odb_helper_type type;
+	unsigned int supported_capabilities;
+	int initialized;
 
 	struct odb_helper_object {
 		struct object_id oid;
@@ -21,6 +31,7 @@ struct odb_helper {
 };
 
 extern struct odb_helper *odb_helper_new(const char *name, int namelen);
+extern int odb_helper_init(struct odb_helper *o);
 extern int odb_helper_has_object(struct odb_helper *o,
 				 const unsigned char *sha1);
 extern int odb_helper_get_object(struct odb_helper *o,
diff --git a/t/t0500-external-odb.sh b/t/t0500-external-odb.sh
index eaa3688a31..977fea852d 100755
--- a/t/t0500-external-odb.sh
+++ b/t/t0500-external-odb.sh
@@ -9,6 +9,10 @@ export ALT_SOURCE
 write_script odb-helper <<\EOF
 GIT_DIR=$ALT_SOURCE; export GIT_DIR
 case "$1" in
+init)
+	echo "capability=get_git_obj"
+	echo "capability=have"
+	;;
 have)
 	git cat-file --batch-check --batch-all-objects |
 	awk '{print $1 " " $3 " " $2}'
-- 
2.17.0.rc0.37.g8f476fabe9

