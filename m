Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC881F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbeACQgR (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:36:17 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33324 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeACQer (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id g130so20902303wme.0
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5NJvW5kqrntok1Hhs1k+V9apW3n8bwIKLDQQthG5mjI=;
        b=aVoPpZpSVFLKasv2psk/Cm8wsd6drdx/Ft7VjBzzSVqOvJgiXs8ptC5QRm4KrlL+4r
         dYD4EksInzQGj/5/xctLr7Sx2K1fmCqcemB5PWT7DZW/PqQNY9WZyWVsgYkQZ125GQC5
         MMkhSQ6Y5lW4OVna/9yr6cXzBhhdldk8ATr8FGmBIf3Rj/vxmIfgHUws6dM9qxlw5035
         OBbFUwh7MZILtk38p0UttikYc+AtDLdWsJTuGRM811HoGR0wmM/kBjN4Dr5+KXGI2udX
         ei+lCPrKcx7OUPS194gprHcgDuKh9I/8/LJJrCntXB9WlHww/0Sq/w6d+dpswLnfvQEA
         XG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5NJvW5kqrntok1Hhs1k+V9apW3n8bwIKLDQQthG5mjI=;
        b=FUJJ4J/p379x+1SmG/TMcEkofe7hhGSFQZwb8p769snT8Li/8krmmD3Nbupus1NAm4
         OktmIyqj4xd88/VHU95Uzl4wwm0LXAy8Ekxpe5v3GiZ9E0rT+N++iq3t8GZkDToUh2fa
         +pkdI/noet7lZ/UYZiqY/rVF6fL+GtWxzX6FkzwK6+xNxBrCZ0bV3OgQiGg9GUrxqx0p
         YOfC0pW8mlf1x0Pg9WSwzoe6p/PkHHbIui21VasFPHSDzVwXlM4sULcs0WmNTZoJxsIr
         6UioCdfODqGY69NY8CKMJoPYOR9afmTk/Hwshu/SpOtndtSe32P2ZX34hwurVrROKbuk
         u6Ug==
X-Gm-Message-State: AKGB3mICjUjYia4swOZA/YP3+UmRPn27eGOG8Hhhbf6lCPRDYELQg7vc
        yOj3fY0Dx++Kw4hdoVljXISsfC8L
X-Google-Smtp-Source: ACJfBouYJFRRf9RL+NLQXMvHo8kImAAC8WNb78Hxqf2F9F0U4BuV0sR2g9PClH5ebPoYM8opzv3RRw==
X-Received: by 10.28.120.19 with SMTP id t19mr1993386wmc.64.1514997285494;
        Wed, 03 Jan 2018 08:34:45 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:44 -0800 (PST)
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
Subject: [PATCH 19/40] external odb: add 'put_raw_obj' support
Date:   Wed,  3 Jan 2018 17:33:42 +0100
Message-Id: <20180103163403.11303-20-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
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
index 2622c12853..337bdd2540 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -151,3 +151,18 @@ int external_odb_get_direct(const unsigned char *sha1)
 
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
index fb8b94972f..26bb931685 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -6,5 +6,7 @@ extern const char *external_odb_root(void);
 extern int external_odb_has_object(const unsigned char *sha1);
 extern int external_odb_get_object(const unsigned char *sha1);
 extern int external_odb_get_direct(const unsigned char *sha1);
+extern int external_odb_put_object(const void *buf, size_t len,
+				   const char *type, unsigned char *sha1);
 
 #endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
index ea642fd438..6f56f07b38 100644
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
@@ -120,7 +124,7 @@ int odb_helper_init(struct odb_helper *o)
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
 
-	if (odb_helper_start(o, &cmd, "init") < 0)
+	if (odb_helper_start(o, &cmd, 0, "init") < 0)
 		return -1;
 
 	fh = xfdopen(cmd.child.out, "r");
@@ -180,7 +184,7 @@ static void odb_helper_load_have(struct odb_helper *o)
 		return;
 	o->have_valid = 1;
 
-	if (odb_helper_start(o, &cmd, "have") < 0)
+	if (odb_helper_start(o, &cmd, 0, "have") < 0)
 		return;
 
 	fh = xfdopen(cmd.child.out, "r");
@@ -235,7 +239,7 @@ int odb_helper_get_object(struct odb_helper *o, const unsigned char *sha1,
 	if (!obj)
 		return -1;
 
-	if (odb_helper_start(o, &cmd, "get_git_obj %s", sha1_to_hex(sha1)) < 0)
+	if (odb_helper_start(o, &cmd, 0, "get_git_obj %s", sha1_to_hex(sha1)) < 0)
 		return -1;
 
 	memset(&stream, 0, sizeof(stream));
@@ -335,3 +339,32 @@ int odb_helper_get_direct(struct odb_helper *o,
 
 	return res;
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
index f8eac7f44c..4a9cc7f07b 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -46,5 +46,8 @@ extern int odb_helper_get_object(struct odb_helper *o,
 				 int fd);
 extern int odb_helper_get_direct(struct odb_helper *o,
 				 const unsigned char *sha1);
+extern int odb_helper_put_object(struct odb_helper *o,
+				 const void *buf, size_t len,
+				 const char *type, unsigned char *sha1);
 
 #endif /* ODB_HELPER_H */
diff --git a/sha1_file.c b/sha1_file.c
index f1d688c10a..8c873554b2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1695,6 +1695,8 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	if (!external_odb_put_object(buf, len, type, sha1))
+		return 0;
 	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

