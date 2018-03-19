Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10851FAE9
	for <e@80x24.org>; Mon, 19 Mar 2018 13:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933323AbeCSNcq (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40221 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933186AbeCSNcf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id z8so8898904wrh.7
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yNKMM0is80psub+XG2LJa3RVBjn+UvvDOESDN+de8AQ=;
        b=sVpkhX4t/wwUHPWJOns28sAUIjGnsgP0KmCuq8y/k7HjetM2M+uNq5X7bmg+33riX4
         ai61GQjm3MyBpFZ9gFtQKofBBfUH7Al7QWnrEsPPLBG7Krqaggi1LDRFgy9G6S3XZrzY
         YVYZxjYYLNEs6vAPTEWwVIea7/bsD1reYcwlVaDi/cMniN+R89j2sQkd/6OGqQm9zpWr
         YP42NnIxwrFps8oF0153faK6C3bQX2vqHrnhZImJI2L4iY9Y0/o/BA9uHqQnnJUn0Iz7
         ItvAlhK2za4J7WuqXioatX0/7KUtnQk/9miiBJ5nr4M+SvBND+qb1hYDXaeO3HcUed3I
         oumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yNKMM0is80psub+XG2LJa3RVBjn+UvvDOESDN+de8AQ=;
        b=UVpS0mhdonbPFRMKNGlxToePgpDp7SvFyfhbBgZHkkPgGYsxlrpEHEv4zdjXqV+Yuz
         ZtQAC1srW3EUdLxdAmTmk0WkcZDzYpxrJcYA2m6IIWjApFNtT+349QxHlZSs+6CNWM4K
         FlDC5lOHxiu3e9kuhmY8L681eZ9UZjsbH9U0/xfAJrapJ7hjuY3UMuKTV56Xv6JvGL/Z
         d4uwwFaR/PWs4A1YncEvXHTxY7masZ2YcyzooIknYU4QuteVUk8LANB9OiIu8r4m+k6p
         qRgxCuKihkv6cTVG8dRC8fOHMCEncFDHtvahkNb/oSRpCsFnnqc2FWR9qC9lPG8ecY92
         bP2Q==
X-Gm-Message-State: AElRT7EWy/1XqKP6WOycqZXgZxMws+s622xCu04f7udjWycsvBG+CnQ+
        6xG3/nS5db6y+lo+Mp77uiMe+PEb
X-Google-Smtp-Source: AG47ELs9K5FOEXzsDqhxZMUF1Ep/zoX99jTyD8hrPPWLKxI53BqE2bI9R7jbLRv/iGE3GQXSqs5pLw==
X-Received: by 10.223.160.195 with SMTP id n3mr10007741wrn.92.1521466352669;
        Mon, 19 Mar 2018 06:32:32 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:32 -0700 (PDT)
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
Subject: [PATCH v2 17/36] external odb: add 'put_raw_obj' support
Date:   Mon, 19 Mar 2018 14:31:28 +0100
Message-Id: <20180319133147.15413-18-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support for a 'put_raw_obj' capability/instruction to send new
objects to an external odb. Objects will be sent as they are (in
their 'raw' format). They will not be converted to Git objects.

For now any new Git object (blob, tree, commit, ...) would be sent
if 'put_raw_obj' is supported by an odb helper. This is not a great
default, but let's leave it to following commits to tweak that.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 15 +++++++++++++++
 external-odb.h |  2 ++
 odb-helper.c   | 51 ++++++++++++++++++++++++++++++++++++++++++++------
 odb-helper.h   |  3 +++
 sha1_file.c    |  2 ++
 5 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 192b09e843..806dc8e699 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -202,3 +202,18 @@ int external_odb_get_many_direct(const struct oid_array *to_get)
 
 	return -1;
 }
+
+int external_odb_put_object(const void *buf, size_t len,
+			    const char *type, unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	external_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		int r = odb_helper_put_object(o, buf, len, type, sha1);
+		if (r <= 0)
+			return r;
+	}
+	return 1;
+}
diff --git a/external-odb.h b/external-odb.h
index a4eda95b09..60da8ed3d4 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -18,5 +18,7 @@ extern int external_odb_has_object(const unsigned char *sha1);
 extern int external_odb_get_object(const unsigned char *sha1);
 extern int external_odb_get_direct(const unsigned char *sha1);
 extern int external_odb_get_many_direct(const struct oid_array *to_get);
+extern int external_odb_put_object(const void *buf, size_t len,
+				   const char *type, unsigned char *sha1);
 
 #endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
index 30cfe689de..2734af793b 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -72,9 +72,10 @@ static void prepare_helper_command(struct argv_array *argv, const char *cmd,
 	strbuf_release(&buf);
 }
 
-__attribute__((format (printf,3,4)))
+__attribute__((format (printf,4,5)))
 static int odb_helper_start(struct odb_helper *o,
 			    struct odb_helper_cmd *cmd,
+			    int use_stdin,
 			    const char *fmt, ...)
 {
 	va_list ap;
@@ -91,7 +92,10 @@ static int odb_helper_start(struct odb_helper *o,
 
 	cmd->child.argv = cmd->argv.argv;
 	cmd->child.use_shell = 1;
-	cmd->child.no_stdin = 1;
+	if (use_stdin)
+		cmd->child.in = -1;
+	else
+		cmd->child.no_stdin = 1;
 	cmd->child.out = -1;
 
 	if (start_command(&cmd->child) < 0) {
@@ -124,7 +128,10 @@ int odb_helper_init(struct odb_helper *o)
 		return 0;
 	o->initialized = 1;
 
-	if (odb_helper_start(o, &cmd, "init") < 0)
+	if (o->type != ODB_HELPER_SCRIPT_CMD)
+		return 0;
+
+	if (odb_helper_start(o, &cmd, 0, "init") < 0)
 		return -1;
 
 	fh = xfdopen(cmd.child.out, "r");
@@ -180,7 +187,7 @@ static void have_object_script(struct odb_helper *o)
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
 
-	if (odb_helper_start(o, &cmd, "have") < 0)
+	if (odb_helper_start(o, &cmd, 0, "have") < 0)
 		return;
 
 	fh = xfdopen(cmd.child.out, "r");
@@ -245,7 +252,7 @@ int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
 	if (!obj)
 		return -1;
 
-	if (odb_helper_start(o, &cmd, "get_git_obj %s", sha1_to_hex(sha1)) < 0)
+	if (odb_helper_start(o, &cmd, 0, "get_git_obj %s", sha1_to_hex(sha1)) < 0)
 		return -1;
 
 	memset(&stream, 0, sizeof(stream));
@@ -348,7 +355,7 @@ int odb_helper_get_direct(struct odb_helper *o,
 		if (!obj)
 			return -1;
 
-		if (odb_helper_start(o, &cmd, "get_direct %s", sha1_to_hex(sha1)) < 0)
+		if (odb_helper_start(o, &cmd, 0, "get_direct %s", sha1_to_hex(sha1)) < 0)
 			return -1;
 
 		if (odb_helper_finish(o, &cmd))
@@ -375,3 +382,35 @@ int odb_helper_get_many_direct(struct odb_helper *o,
 
 	return res;
 }
+
+int odb_helper_put_object(struct odb_helper *o,
+			  const void *buf, size_t len,
+			  const char *type, unsigned char *sha1)
+{
+	struct odb_helper_cmd cmd;
+
+	if (o->type != ODB_HELPER_SCRIPT_CMD)
+		return 1;
+
+	if (odb_helper_start(o, &cmd, 1, "put_raw_obj %s %"PRIuMAX" %s",
+			     sha1_to_hex(sha1), (uintmax_t)len, type) < 0)
+		return -1;
+
+	do {
+		int w = xwrite(cmd.child.in, buf, len);
+		if (w < 0) {
+			error("unable to write to odb helper '%s': %s",
+			      o->name, strerror(errno));
+			close(cmd.child.in);
+			close(cmd.child.out);
+			odb_helper_finish(o, &cmd);
+			return -1;
+		}
+		len -= w;
+	} while (len > 0);
+
+	close(cmd.child.in);
+	close(cmd.child.out);
+	odb_helper_finish(o, &cmd);
+	return 0;
+}
diff --git a/odb-helper.h b/odb-helper.h
index 3ec2d8448f..b6a1498662 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -42,5 +42,8 @@ extern int odb_helper_get_direct(struct odb_helper *o,
 				 const unsigned char *sha1);
 extern int odb_helper_get_many_direct(struct odb_helper *o,
 				      const struct oid_array *to_get);
+extern int odb_helper_put_object(struct odb_helper *o,
+				 const void *buf, size_t len,
+				 const char *type, unsigned char *sha1);
 
 #endif /* ODB_HELPER_H */
diff --git a/sha1_file.c b/sha1_file.c
index 99adfceede..64679fae36 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1709,6 +1709,8 @@ int write_object_file(const void *buf, unsigned long len, const char *type,
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_object_file_prepare(buf, len, type, oid, hdr, &hdrlen);
+	if (!external_odb_put_object(buf, len, type, oid->hash))
+		return 0;
 	if (freshen_packed_object(oid->hash) || freshen_loose_object(oid->hash))
 		return 0;
 	return write_loose_object(oid, hdr, hdrlen, buf, len, 0);
-- 
2.17.0.rc0.37.g8f476fabe9

