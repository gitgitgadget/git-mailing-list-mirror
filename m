Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3CCE20A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbdIPIKF (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:10:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34927 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdIPIIB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id e64so4516902wmi.2
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FsvpqAzeunrxKiH6BIzCTdGK+NfplTaXdnw2qU8+JBs=;
        b=VF7gBeAAHlcffjQLqXg5dJsTLo/KcyOwBTDHOzKpPshyMy0YDGnRjPmJHlA3+s7rpf
         gohHTG3N6t8NTuX5mjwbWFl2QQAEBBKMQ/e+zfR10lNpZZscwZh64myW1vWLuvTQ62KM
         kciaQFErGdz3UhcsTYEHfIT05KZ2wgQTxumb//HrCX8o6+zELyr+PytGSszPjEEHC3o0
         G9M921HKB5Z0fcY6hUXqLRaHPPQu/evvtVdxHPanZuwCn9+lndfeXJpNoQiygt1pE5+W
         4xtOW9xTJJdQHL5mH8ZEipM0ymQfjkiSJJiSIsH9funN9SqcrlSKLZD+b/nYAHj9warD
         sIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FsvpqAzeunrxKiH6BIzCTdGK+NfplTaXdnw2qU8+JBs=;
        b=Yoz+f0CD06c/2NWoxnFSRCvsrMrzqdlvmpBQTzLrgvp8Dtl60Zg7z3GDlpWvMZkXS8
         JjzWCwiZj6k/8Tzw7xm3dDn1DHz5UWYHODDFwphwo8Ta3OwUrhObFAxG4AZ0XKvMBRHr
         AgKvK9uc3ouyeBSQeZIaV3UumuEjDXqE4+fy00rEZGbFAM0ba8MHn8O4ODQcWJ5BZB7j
         0ttJ7L0PIGS7aBaSFcwoVT8OyrW9hDGORucOZlwV7EUydsYVqHZwdNdBwg+byNA7ESoO
         URksNo5MXUuxXbqvJG6QTNGz+Lu6gQRhmlctGRzyWMgNz2ImmWvoYAbgE0sIZd9d35Yv
         1A7A==
X-Gm-Message-State: AHPjjUhTSgY6dVZPfPX7bhdTa/hNbmsrI1rAiHuVZw95GoFPGaZMPvbR
        Owvy0GjKxteVf+vYhIvwlFIY8g==
X-Google-Smtp-Source: AOwi7QDNqe+PvghJrw6TDOFhQqqjCoiLIQLNmdLQkXj+8l8W6uAUn2kSEZfwDZNoH0BnmhcQwZ2x5Q==
X-Received: by 10.28.151.200 with SMTP id z191mr5101323wmd.115.1505549280150;
        Sat, 16 Sep 2017 01:08:00 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:07:59 -0700 (PDT)
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
Subject: [PATCH v6 12/40] external odb: add 'put_raw_obj' support
Date:   Sat, 16 Sep 2017 10:07:03 +0200
Message-Id: <20170916080731.13925-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
 odb-helper.c   | 43 ++++++++++++++++++++++++++++++++++++++-----
 odb-helper.h   |  3 +++
 sha1_file.c    |  2 ++
 5 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 0f0de170b8..82fac702e8 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -118,3 +118,18 @@ int external_odb_get_object(const unsigned char *sha1)
 
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
index dc5635f452..d369dfdf6f 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -4,5 +4,7 @@
 extern const char *external_odb_root(void);
 extern int external_odb_has_object(const unsigned char *sha1);
 extern int external_odb_get_object(const unsigned char *sha1);
+extern int external_odb_put_object(const void *buf, size_t len,
+				   const char *type, unsigned char *sha1);
 
 #endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
index 9375eca58f..39d20fdfd7 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -71,9 +71,10 @@ static void prepare_helper_command(struct argv_array *argv, const char *cmd,
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
@@ -90,7 +91,10 @@ static int odb_helper_start(struct odb_helper *o,
 
 	cmd->child.argv = cmd->argv.argv;
 	cmd->child.use_shell = 1;
-	cmd->child.no_stdin = 1;
+	if (use_stdin)
+		cmd->child.in = -1;
+	else
+		cmd->child.no_stdin = 1;
 	cmd->child.out = -1;
 
 	if (start_command(&cmd->child) < 0) {
@@ -119,7 +123,7 @@ int odb_helper_init(struct odb_helper *o)
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
 
-	if (odb_helper_start(o, &cmd, "init") < 0)
+	if (odb_helper_start(o, &cmd, 0, "init") < 0)
 		return -1;
 
 	fh = xfdopen(cmd.child.out, "r");
@@ -179,7 +183,7 @@ static void odb_helper_load_have(struct odb_helper *o)
 		return;
 	o->have_valid = 1;
 
-	if (odb_helper_start(o, &cmd, "have") < 0)
+	if (odb_helper_start(o, &cmd, 0, "have") < 0)
 		return;
 
 	fh = xfdopen(cmd.child.out, "r");
@@ -234,7 +238,7 @@ int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
 	if (!obj)
 		return -1;
 
-	if (odb_helper_start(o, &cmd, "get_git_obj %s", sha1_to_hex(sha1)) < 0)
+	if (odb_helper_start(o, &cmd, 0, "get_git_obj %s", sha1_to_hex(sha1)) < 0)
 		return -1;
 
 	memset(&stream, 0, sizeof(stream));
@@ -321,3 +325,32 @@ int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
 
 	return 0;
 }
+
+int odb_helper_put_object(struct odb_helper *o,
+			  const void *buf, size_t len,
+			  const char *type, unsigned char *sha1)
+{
+	struct odb_helper_cmd cmd;
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
index 5f28a6e512..0571ba09cb 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -35,5 +35,8 @@ extern int odb_helper_has_object(struct odb_helper *o,
 extern int odb_helper_get_object(struct odb_helper *o,
 				 const unsigned char *sha1,
 				 int fd);
+extern int odb_helper_put_object(struct odb_helper *o,
+				 const void *buf, size_t len,
+				 const char *type, unsigned char *sha1);
 
 #endif /* ODB_HELPER_H */
diff --git a/sha1_file.c b/sha1_file.c
index 4a4f5df5ec..d0155e392f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1613,6 +1613,8 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	if (!external_odb_put_object(buf, len, type, sha1))
+		return 0;
 	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
-- 
2.14.1.576.g3f707d88cd

