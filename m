Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D3020A28
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdIPIIE (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34756 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdIPIH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:07:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id i131so4521257wma.1
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Oh0AgrnAKfA4X4RItrK+LffuU7gdJ5IiB9C65XSDzug=;
        b=XzNMwYMefXcS2Y/upT+aF/66MgmJwVTPYIscx+C2pf1euFDtb1nVXual66UQnH6EUh
         3d2QHfuw1OhZWsrBXBTm5OKtbZJ04/SECnb0eCV897a0DSHJss82j3OWj/aKd5NwPwI8
         jv+caFwYbytNNkty6woXVjfjmHHMACozfw8rvp8smgL6NFy6rD/WHPeFw3Lq9QlisPlO
         6pXrN7uZnV3ehA0Kmj0wyLdVCPFGewjjyQKNtjBliWX3l9ny/3xxFawrXRce3unflQjt
         QXNHu+hVwgQp+hi2gDkjulRNu0fspIYgnbW03InrwaVHPkyBlwZnd63oAByZg0KEAE2n
         paJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Oh0AgrnAKfA4X4RItrK+LffuU7gdJ5IiB9C65XSDzug=;
        b=TnAOIzNvkDUGJNIW6BDH3BrZupR+GNqA+6KhmITgCF7FxNpdb++KhQwGcMtt73nioV
         vprmX01E69mxjpHo6c9ejrl6HQAvwIsoO52/IDKoJj1z+odEG0imKL66UpPIwCI0jjkf
         yMG/siJp5JSkvN4PVjnYlWdMCIsqnKow5vW1fc84JwNUDV4w4QajYpwafeDxF7jRdApm
         xzk6h8ycDwyAqibOxWw3NgCckSv9PbzfKZFgKl4wSb/Kqufgzy0UlJt8iFXk3ws57KWJ
         EN6Pypbq313dbszFyXgtbsOK4hmasaBX+RT/EMdpcC215iVDeqSRv0ygIdEEUGzK3cW+
         0pSQ==
X-Gm-Message-State: AHPjjUgB1TFEsJlsVTgxtMgInyPhI8MLjLYumAlcYgJx10DMrfTY3Kvi
        dascu61IgSRNrtu4gsF1iiKPzQ==
X-Google-Smtp-Source: AOwi7QDiNpFgTmfDo1WmAjbaEF5x6+wDmObsQhiebzgM+/zg5ghEUH4wsQEiu0Kep71jXI6ghdQR9g==
X-Received: by 10.28.12.134 with SMTP id 128mr4814284wmm.147.1505549277369;
        Sat, 16 Sep 2017 01:07:57 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:07:56 -0700 (PDT)
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
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 10/40] odb-helper: add odb_helper_init() to send 'init' instruction
Date:   Sat, 16 Sep 2017 10:07:01 +0200
Message-Id: <20170916080731.13925-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
 external-odb.c          |  9 ++++++++-
 odb-helper.c            | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 odb-helper.h            | 12 +++++++++++
 t/t0400-external-odb.sh |  4 ++++
 4 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/external-odb.c b/external-odb.c
index e9c3f11666..0f0de170b8 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -41,12 +41,16 @@ static int external_odb_config(const char *var, const char *value, void *data)
 static void external_odb_init(void)
 {
 	static int initialized;
+	struct odb_helper *o;
 
 	if (initialized)
 		return;
 	initialized = 1;
 
 	git_config(external_odb_config, NULL);
+
+	for (o = helpers; o; o = o->next)
+		odb_helper_init(o);
 }
 
 const char *external_odb_root(void)
@@ -63,9 +67,12 @@ int external_odb_has_object(const unsigned char *sha1)
 
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
 
diff --git a/odb-helper.c b/odb-helper.c
index 5e91044872..9375eca58f 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -5,6 +5,40 @@
 #include "run-command.h"
 #include "sha1-lookup.h"
 
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
@@ -79,6 +113,26 @@ static int odb_helper_finish(struct odb_helper *o,
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
index fb25ad579e..5f28a6e512 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -1,9 +1,20 @@
 #ifndef ODB_HELPER_H
 #define ODB_HELPER_H
 
+#include "external-odb.h"
+
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
 	const char *cmd;
+	unsigned int supported_capabilities;
 
 	struct odb_helper_object {
 		unsigned char sha1[20];
@@ -18,6 +29,7 @@ struct odb_helper {
 };
 
 extern struct odb_helper *odb_helper_new(const char *name, int namelen);
+extern int odb_helper_init(struct odb_helper *o);
 extern int odb_helper_has_object(struct odb_helper *o,
 				 const unsigned char *sha1);
 extern int odb_helper_get_object(struct odb_helper *o,
diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 2f4749fab1..ed89f3ab40 100755
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
2.14.1.576.g3f707d88cd

