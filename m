Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8098B1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeA2Wi1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:27 -0500
Received: from mail-yb0-f202.google.com ([209.85.213.202]:35873 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbeA2Wi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:26 -0500
Received: by mail-yb0-f202.google.com with SMTP id m7so6662563yba.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=dSHpVABlbBqu/lONzrFGGmc7WWQlHENGTbzweT2SM9k=;
        b=K9kaPglfSj2DmRSdidFzyHiaCGOXoh3DfzuoF4dfUM1xr7jm5jKej7w78C24T6RZIr
         lAEb7GkUcCqHfePw/xb7Q0PXXjpnALZSzKOVMyiiCusQQvALhFL/OJB/I/wAu/JI7j/p
         mHmef2opLvx/SW/sqDYuxLO1d7xOsxWHuQGs0q9RkQ8SIau3+Bx0VLeUXJQVP1/fFtam
         DLVLmYvixkaIikO0P6Qb0xiRtP/1IVE5W+51H/zljv/6Vo2fMRm1OOM2wBXm/hgZKWfV
         9Qt+/jZdms4zcsWorpiZhc5zPdcIakHitSRyyFCL6O5YBzTeXDi+mTz+NZCEX0O35UDd
         px9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=dSHpVABlbBqu/lONzrFGGmc7WWQlHENGTbzweT2SM9k=;
        b=jBWJ49DE+RTE26YhE7LhCN2G8C82vCXOKiRQejNePY0eYVUIkfGF8hMLIg0KIgqyBm
         HbrSi9TzeOvvJMLXn1MdjYpueMHGu5fID7oSFncukENkSq3/3rFj2E4ykDMFthhTcHLp
         ovtKKGAmwGILH7Z+ExV9ibsYgna4bTIGtygDzkk81Pa/QRXMkTsxcPZ9yb7djIrr6Gze
         JFH61W+eOJtJdfbXIbg42lXZ4OnBd5Zd07io+nf4KbusxwKO5VWxSC4aD4gVsPITW1aU
         yX2Kwj3C4qeKG5d9CcVZpjnVfJS2L4Pm1ZggeqE9q5NMPcvxleYdGZVRi+USfBHL66KL
         ENJg==
X-Gm-Message-State: AKwxytea1QBF4BPEA7MmihyjoJ5ceOiNlIt9L9cHzWDQMcPvq6gX0TYz
        NENWIClzOeOsqvCPFHFwj1x+SUy+wHh9ZlxBOoyFgxvZViZl7vs6r/tUzqJRwG9xApW+z7u7jKl
        7mmGOAkbM0UFgkAKF0QcKpW0RQg6hUjY2a+kkagfc4Lm/NU1a+eXbEA8uEw==
X-Google-Smtp-Source: AH8x224OUldxKdHiFkWjqyjKDYzIaDh3nr3vyNSaJkP6fpBQA+/1u5+8tuUN2vrQHDkyTfhDRzyEH+BHpjw=
MIME-Version: 1.0
X-Received: by 10.129.112.73 with SMTP id l70mr11768326ywc.24.1517265505513;
 Mon, 29 Jan 2018 14:38:25 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:10 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-20-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 19/37] entry: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
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
2.16.0.rc1.238.g530d649a79-goog

