Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73BAD1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162547AbeBNTBg (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:01:36 -0500
Received: from mail-oi0-f73.google.com ([209.85.218.73]:46941 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162541AbeBNTBe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:34 -0500
Received: by mail-oi0-f73.google.com with SMTP id 16so11380594oin.13
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=p4nCmXWPSy3lzpAUdgrTAYK7YiRjeRxjk+uErjJa0Lc=;
        b=P4iaJCujue5PR2O7YakipByKCvZVjkJwUc5J64h+3ncS0wPdKBhQ1KJGbbgpq1qykB
         BqNd80momGhSEP+uLfZWfbn4Ru80JvuyTDD94y/RgJjUPCL8uyTo/DeF72s8wSpcoo7w
         tRaD6kJWiDJjXmEFFQ1prtFNplRUiBe114NM0rcGgHgjtZHL9TgFWXLZDAbZY9d4NfLS
         Rb438qpKFKp4M5GDBE9TyrTgw9aSbUJHoOD3L1BfYMv/kJkPIVeCcgzlZTYvZAqtp6n6
         dVIQmf0k3qv1xMI+VD6y3TanNSuTNL8f/S/L45f7o5GuUx1cy9+uuTn68kPHXaRRbMr2
         sQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=p4nCmXWPSy3lzpAUdgrTAYK7YiRjeRxjk+uErjJa0Lc=;
        b=BrRSOYTHSZDXMTUkgOLJCPW/f/kjyyxWOKEXSr4s7TmdIY3ucIVSh8FA2gtDFIcZlL
         NCZB4ZWO4F/Ysc1wYebb4G7mx+LAULbnjDf0JyMWcJ3eKgIUVKPuHhfxz40lBxyScbiJ
         IZlguKI7a/4pbUfQwgDouNyNGqRHGX4c8D33vIhjBGLvN8sfyguiNwuN8QXcgtYRPTe6
         4IPCruty37jx6Rko+bPjGrhSnKywMLmXMKmqExiFuk8RUnyodprN75kX2niC3EYGxUY4
         XSaFsqcASWCQrLnTE6IGM7LSWxdhyU1cun4/ZzJw3vD3/4T5+iK48BsQ8Hy4jgk+C6W3
         1H+g==
X-Gm-Message-State: APf1xPD/L6YsK8KGk0BWIdTYpOQVUC9n00OqonGqIgt5QsXrY52a0e9m
        3Pp9/qPQ9Flohdszl6rvAhrvOPzJA1zvrL08PyQm/UtZuXeMEH5qJSd3dEjF1ZtxB6sCNYrdY1P
        7/tlHtZDcwEYBQe3s2K52AZvYHQqHvm6Itnh5KxzSpIUY16I61nFyra/VGw==
X-Google-Smtp-Source: AH8x224DnFjsKRb4vTBafSBhs4BIINeZFAaFTHV1DZh98qdRW0B9iBLU3x6DhpozGmH2DlfKIOYPwN1Pay0=
MIME-Version: 1.0
X-Received: by 10.157.38.8 with SMTP id a8mr13545otb.87.1518634893338; Wed, 14
 Feb 2018 11:01:33 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:41 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-20-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 19/37] entry: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 entry.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/entry.c b/entry.c
index 30211447a..6c33112ae 100644
--- a/entry.c
+++ b/entry.c
@@ -85,12 +85,12 @@ static int create_file(const char *path, unsigned int mode)
 static void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
 {
 	enum object_type type;
-	void *new = read_sha1_file(ce->oid.hash, &type, size);
+	void *blob_data = read_sha1_file(ce->oid.hash, &type, size);
 
-	if (new) {
+	if (blob_data) {
 		if (type == OBJ_BLOB)
-			return new;
-		free(new);
+			return blob_data;
+		free(blob_data);
 	}
 	return NULL;
 }
@@ -256,7 +256,7 @@ static int write_entry(struct cache_entry *ce,
 	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
 	struct delayed_checkout *dco = state->delayed_checkout;
 	int fd, ret, fstat_done = 0;
-	char *new;
+	char *new_blob;
 	struct strbuf buf = STRBUF_INIT;
 	unsigned long size;
 	ssize_t wrote;
@@ -276,8 +276,8 @@ static int write_entry(struct cache_entry *ce,
 
 	switch (ce_mode_s_ifmt) {
 	case S_IFLNK:
-		new = read_blob_entry(ce, &size);
-		if (!new)
+		new_blob = read_blob_entry(ce, &size);
+		if (!new_blob)
 			return error("unable to read sha1 file of %s (%s)",
 				     path, oid_to_hex(&ce->oid));
 
@@ -288,8 +288,8 @@ static int write_entry(struct cache_entry *ce,
 		if (!has_symlinks || to_tempfile)
 			goto write_file_entry;
 
-		ret = symlink(new, path);
-		free(new);
+		ret = symlink(new_blob, path);
+		free(new_blob);
 		if (ret)
 			return error_errno("unable to create symlink %s", path);
 		break;
@@ -300,11 +300,11 @@ static int write_entry(struct cache_entry *ce,
 		 * bother reading it at all.
 		 */
 		if (dco && dco->state == CE_RETRY) {
-			new = NULL;
+			new_blob = NULL;
 			size = 0;
 		} else {
-			new = read_blob_entry(ce, &size);
-			if (!new)
+			new_blob = read_blob_entry(ce, &size);
+			if (!new_blob)
 				return error("unable to read sha1 file of %s (%s)",
 					     path, oid_to_hex(&ce->oid));
 		}
@@ -313,18 +313,18 @@ static int write_entry(struct cache_entry *ce,
 		 * Convert from git internal format to working tree format
 		 */
 		if (dco && dco->state != CE_NO_DELAY) {
-			ret = async_convert_to_working_tree(ce->name, new,
+			ret = async_convert_to_working_tree(ce->name, new_blob,
 							    size, &buf, dco);
 			if (ret && string_list_has_string(&dco->paths, ce->name)) {
-				free(new);
+				free(new_blob);
 				goto delayed;
 			}
 		} else
-			ret = convert_to_working_tree(ce->name, new, size, &buf);
+			ret = convert_to_working_tree(ce->name, new_blob, size, &buf);
 
 		if (ret) {
-			free(new);
-			new = strbuf_detach(&buf, &newsize);
+			free(new_blob);
+			new_blob = strbuf_detach(&buf, &newsize);
 			size = newsize;
 		}
 		/*
@@ -336,15 +336,15 @@ static int write_entry(struct cache_entry *ce,
 	write_file_entry:
 		fd = open_output_fd(path, ce, to_tempfile);
 		if (fd < 0) {
-			free(new);
+			free(new_blob);
 			return error_errno("unable to create file %s", path);
 		}
 
-		wrote = write_in_full(fd, new, size);
+		wrote = write_in_full(fd, new_blob, size);
 		if (!to_tempfile)
 			fstat_done = fstat_output(fd, state, &st);
 		close(fd);
-		free(new);
+		free(new_blob);
 		if (wrote < 0)
 			return error("unable to write file %s", path);
 		break;
-- 
2.16.1.291.g4437f3f132-goog

