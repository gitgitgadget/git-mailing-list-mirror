Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEAEB1F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeACQei (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:34:38 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37921 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeACQe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:29 -0500
Received: by mail-wr0-f194.google.com with SMTP id y9so2152070wrb.5
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HgVFL/kCQHQKHp2n9Tiu+eG6+BL8v1HoQgE5DoN8Pro=;
        b=ZGLMt67A5CCbPXw85807vbCw06lUGzCcxveoHnvJUIokHRTLjRGCUo4yl3rAFvRxNP
         THJAJnE5Shb7hgDTypIMCnBKADhkrdWecCRQS+yfUZCGpvKA5xqMJOYk4PGxFCHmXDJ4
         fjSPO9coCmpxGxqW+Fpyo04Ydvg4/5qVWWbPjvV35Ezqxvo51XuUJ05UZEuBRopXSM3O
         NaMAsBmvAmu9gtpdFJh4FApX8VNgYIsu13K3ZJFCiTwh5XPj3pVDBE1kpxW5UvaAHGXc
         a/Tn4k49kfoXsMKQsNayVIEncfqGFHzTVUfVQkZM1pKvOlxeDAJkTId1wJHM8bymkYij
         Pc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HgVFL/kCQHQKHp2n9Tiu+eG6+BL8v1HoQgE5DoN8Pro=;
        b=MO5kAwoQCDmPWMtdBmizabp8B+iK18K+m6mIzVDVw86vooQOxAhHtrmcTvGL4BaFhC
         4Oub+o5Lg3WHYXGk5t1ZaqKbR81lQqeeRYbtenH5gFKJ0ebtBIJWMrMIyAP9KNaQctbi
         kQh00Ha/XbBU2sO+g6R5SVYQmqCCJgZqeiszT2EahUR7WWAUsClyScMo+91zniwP+HvJ
         NvxjbNYEe0wxmnoNsSd/uEXkJlfYCz4tTJyXzAj+Z689xoy1O5sMvfcKv22vmQb3S/SZ
         NRNXjl2D8f9O4pz/2bGvTNyaTZ7ZJNCm2H78lbRD8QlU+w+ELa6bMMqbdYzNmpa7fI/5
         yZZw==
X-Gm-Message-State: AKGB3mKyVLEtRqwXp3C0rsDpXKIXggj6PJHZCQTm6Dzgwl/3BzRTCieS
        PuE9Y4BZyyuxXRngt3hGhPeUhNok
X-Google-Smtp-Source: ACJfBosXvZKtqOLOo2xnoXfKn8SJpOaGPljaPj60qL2lgtBoA9pum/J8wWvUIVBPVsNHRpPdZ34PQQ==
X-Received: by 10.223.197.16 with SMTP id q16mr2198071wrf.9.1514997267876;
        Wed, 03 Jan 2018 08:34:27 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:27 -0800 (PST)
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
Subject: [PATCH 08/40] index-pack: refactor writing of .keep files
Date:   Wed,  3 Jan 2018 17:33:31 +0100
Message-Id: <20180103163403.11303-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

In a subsequent commit, index-pack will be taught to write ".promisor"
files which are similar to the ".keep" files it knows how to write.
Refactor the writing of ".keep" files, so that the implementation of
writing ".promisor" files becomes easier.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c | 99 ++++++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 46 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4c51aec81f..47515d8977 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1389,15 +1389,58 @@ static void fix_unresolved_deltas(struct sha1file *f)
 	free(sorted_by_pos);
 }
 
+static const char *derive_filename(const char *pack_name, const char *suffix,
+				   struct strbuf *buf)
+{
+	size_t len;
+	if (!strip_suffix(pack_name, ".pack", &len))
+		die(_("packfile name '%s' does not end with '.pack'"),
+		    pack_name);
+	strbuf_add(buf, pack_name, len);
+	strbuf_addch(buf, '.');
+	strbuf_addstr(buf, suffix);
+	return buf->buf;
+}
+
+static void write_special_file(const char *suffix, const char *msg,
+			       const char *pack_name, const unsigned char *sha1,
+			       const char **report)
+{
+	struct strbuf name_buf = STRBUF_INIT;
+	const char *filename;
+	int fd;
+	int msg_len = strlen(msg);
+
+	if (pack_name)
+		filename = derive_filename(pack_name, suffix, &name_buf);
+	else
+		filename = odb_pack_name(&name_buf, sha1, suffix);
+
+	fd = odb_pack_keep(filename);
+	if (fd < 0) {
+		if (errno != EEXIST)
+			die_errno(_("cannot write %s file '%s'"),
+				  suffix, filename);
+	} else {
+		if (msg_len > 0) {
+			write_or_die(fd, msg, msg_len);
+			write_or_die(fd, "\n", 1);
+		}
+		if (close(fd) != 0)
+			die_errno(_("cannot close written %s file '%s'"),
+				  suffix, filename);
+		*report = suffix;
+	}
+	strbuf_release(&name_buf);
+}
+
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
-		  const char *keep_name, const char *keep_msg,
-		  unsigned char *sha1)
+		  const char *keep_msg, unsigned char *sha1)
 {
 	const char *report = "pack";
 	struct strbuf pack_name = STRBUF_INIT;
 	struct strbuf index_name = STRBUF_INIT;
-	struct strbuf keep_name_buf = STRBUF_INIT;
 	int err;
 
 	if (!from_stdin) {
@@ -1409,28 +1452,9 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 			die_errno(_("error while closing pack file"));
 	}
 
-	if (keep_msg) {
-		int keep_fd, keep_msg_len = strlen(keep_msg);
-
-		if (!keep_name)
-			keep_name = odb_pack_name(&keep_name_buf, sha1, "keep");
-
-		keep_fd = odb_pack_keep(keep_name);
-		if (keep_fd < 0) {
-			if (errno != EEXIST)
-				die_errno(_("cannot write keep file '%s'"),
-					  keep_name);
-		} else {
-			if (keep_msg_len > 0) {
-				write_or_die(keep_fd, keep_msg, keep_msg_len);
-				write_or_die(keep_fd, "\n", 1);
-			}
-			if (close(keep_fd) != 0)
-				die_errno(_("cannot close written keep file '%s'"),
-					  keep_name);
-			report = "keep";
-		}
-	}
+	if (keep_msg)
+		write_special_file("keep", keep_msg, final_pack_name, sha1,
+				   &report);
 
 	if (final_pack_name != curr_pack_name) {
 		if (!final_pack_name)
@@ -1472,7 +1496,6 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 	strbuf_release(&index_name);
 	strbuf_release(&pack_name);
-	strbuf_release(&keep_name_buf);
 }
 
 static int git_index_pack_config(const char *k, const char *v, void *cb)
@@ -1615,26 +1638,13 @@ static void show_pack_info(int stat_only)
 	}
 }
 
-static const char *derive_filename(const char *pack_name, const char *suffix,
-				   struct strbuf *buf)
-{
-	size_t len;
-	if (!strip_suffix(pack_name, ".pack", &len))
-		die(_("packfile name '%s' does not end with '.pack'"),
-		    pack_name);
-	strbuf_add(buf, pack_name, len);
-	strbuf_addstr(buf, suffix);
-	return buf->buf;
-}
-
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0;
 	const char *curr_index;
 	const char *index_name = NULL, *pack_name = NULL;
-	const char *keep_name = NULL, *keep_msg = NULL;
-	struct strbuf index_name_buf = STRBUF_INIT,
-		      keep_name_buf = STRBUF_INIT;
+	const char *keep_msg = NULL;
+	struct strbuf index_name_buf = STRBUF_INIT;
 	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
 	unsigned char pack_sha1[20];
@@ -1740,9 +1750,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (from_stdin && !startup_info->have_repository)
 		die(_("--stdin requires a git repository"));
 	if (!index_name && pack_name)
-		index_name = derive_filename(pack_name, ".idx", &index_name_buf);
-	if (keep_msg && !keep_name && pack_name)
-		keep_name = derive_filename(pack_name, ".keep", &keep_name_buf);
+		index_name = derive_filename(pack_name, "idx", &index_name_buf);
 
 	if (verify) {
 		if (!index_name)
@@ -1790,13 +1798,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (!verify)
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
-		      keep_name, keep_msg,
+		      keep_msg,
 		      pack_sha1);
 	else
 		close(input_fd);
 	free(objects);
 	strbuf_release(&index_name_buf);
-	strbuf_release(&keep_name_buf);
 	if (pack_name == NULL)
 		free((void *) curr_pack);
 	if (index_name == NULL)
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

