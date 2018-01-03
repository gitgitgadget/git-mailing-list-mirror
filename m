Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0B01F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbeACQgd (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:36:33 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34761 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeACQeo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:44 -0500
Received: by mail-wr0-f194.google.com with SMTP id 36so2153674wrh.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=73zFBiMvHOb0hQ4P5ODLUJc0WIlECu/mtsXyBvVZTi0=;
        b=DBlA6Czud9Sy38AaJOqs63RsvLkBw194ZTWQNtkiwuI744SX1oJ+R52icOOMCH2SL5
         tz1RUBalFb95QjLM7t8ibtRz1lGtcvMyxgSmSlewfsGZy/yjiBJkLvlrTgBgnwhcMAbk
         gtqC3W58xUvnCtRmK47B95zcRjJYeSg2YG7E6YR0SvsobXCu3xew52Kot0AwacJxkhTH
         0KeN1mV02+4AJLL9tSYBoJ90Jab7GRJKsUGiOUUTVp4rnLOTkXGXL1z7raMKP9SwkBHx
         763o9lYi8nkD/efZBfAaSZM8+EBLOs2qBJCevUSVtJqppSIhY/zj9ibQEIgXCmr9LDk4
         c7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=73zFBiMvHOb0hQ4P5ODLUJc0WIlECu/mtsXyBvVZTi0=;
        b=IP9TXK1GgcESOF0QalVJRYUgQuDjDpd0w//RJBFp6YTif47/9hMbt+ql9HqQ0oONUn
         AONbVOKpB5rTLqj1Wrru0jvp8XalPQS+lP74hI32NvAkvY8OzKyS/Rq6CNhia2V14AcT
         2ITXnt79HcIU+1YXOEeuu9HolWJs+NkZWUPxdnz4mDyeDvvLChMQcgKw0+rI5ahVs2SC
         Z3cbLY8ce/Mc5eSwIvNNwodvLopBy63gM0Wfgs691k+mGcGWckD1onoyCaKS1ccx0dnu
         uU+F0g9xv/pR1b5d3XCMLxLJpdZz62vp3Bqf+wR+HGdhtWGaosXFtFzHVmJAYU3bqabT
         T0XA==
X-Gm-Message-State: AKGB3mLNyIyxhHQ7hqcIXJVM2kaGQevZydzTyfGnEytU0LdapcRmQvt3
        xgoQdX3NWXZtYlneH9XYTpkrU7vH
X-Google-Smtp-Source: ACJfBovMKInVTF830WtAQcQN5/WRktnfAm3sepYP2QxYPpBHH7SB0Dh+IBJzLbXuyVFQD5pOc9UYxg==
X-Received: by 10.223.134.14 with SMTP id 14mr2241770wrv.155.1514997282477;
        Wed, 03 Jan 2018 08:34:42 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:41 -0800 (PST)
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
Subject: [PATCH 17/40] odb-helper: add odb_helper_init() to send 'init' instruction
Date:   Wed,  3 Jan 2018 17:33:40 +0100
Message-Id: <20180103163403.11303-18-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
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
 external-odb.c          | 13 +++++++++++-
 odb-helper.c            | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 odb-helper.h            | 12 +++++++++++
 t/t0400-external-odb.sh |  4 ++++
 4 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/external-odb.c b/external-odb.c
index 81f2aa5fac..2622c12853 100644
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
@@ -48,12 +50,16 @@ static int external_odb_config(const char *var, const char *value, void *data)
 static void external_odb_init(void)
 {
 	static int initialized;
+	struct odb_helper *o;
 
 	if (initialized || !use_external_odb)
 		return;
 	initialized = 1;
 
 	git_config(external_odb_config, NULL);
+
+	for (o = helpers; o; o = o->next)
+		odb_helper_init(o);
 }
 
 int has_external_odb(void)
@@ -77,9 +83,12 @@ int external_odb_has_object(const unsigned char *sha1)
 
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
 
@@ -133,6 +142,8 @@ int external_odb_get_direct(const unsigned char *sha1)
 	external_odb_init();
 
 	for (o = helpers; o; o = o->next) {
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_GET_DIRECT))
+			continue;
 		if (odb_helper_get_direct(o, sha1) < 0)
 			continue;
 		return 0;
diff --git a/odb-helper.c b/odb-helper.c
index c1a3443dc7..ea642fd438 100644
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
@@ -80,6 +114,26 @@ static int odb_helper_finish(struct odb_helper *o,
 	return 0;
 }
 
+int odb_helper_init(struct odb_helper *o)
+{
+	struct odb_helper_cmd cmd;
+	FILE *fh;
+	struct strbuf line = STRBUF_INIT;
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
index 4f2ac5e476..f8eac7f44c 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -1,6 +1,8 @@
 #ifndef ODB_HELPER_H
 #define ODB_HELPER_H
 
+#include "external-odb.h"
+
 enum odb_helper_type {
 	ODB_HELPER_NONE = 0,
 	ODB_HELPER_GIT_REMOTE,
@@ -9,10 +11,19 @@ enum odb_helper_type {
 	OBJ_HELPER_MAX
 };
 
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
 
 	struct odb_helper_object {
 		unsigned char sha1[20];
@@ -27,6 +38,7 @@ struct odb_helper {
 };
 
 extern struct odb_helper *odb_helper_new(const char *name, int namelen);
+extern int odb_helper_init(struct odb_helper *o);
 extern int odb_helper_has_object(struct odb_helper *o,
 				 const unsigned char *sha1);
 extern int odb_helper_get_object(struct odb_helper *o,
diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index eaa3688a31..977fea852d 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
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
2.16.0.rc0.16.g82191dbc6c.dirty

