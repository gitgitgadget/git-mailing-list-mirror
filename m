Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40DFD1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbcG3R1f (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34268 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbcG3R0x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so20052821wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3J/8DrfKC8wRB2oqn/lWJ4LiNqC/Ucy++mQoZzgwnrY=;
        b=cvMlwumlTDmdu5ODFhu1dU3b2cn+h6F6JjXkjtWu9Xp1qx+Kfa9CJ1DXke8+5SyLzJ
         DPD8tTVHoT5qqVcI6ZdPDrD4Y2AePuV5oYd0kVCN+tSCexdyEtIC1FUQHVgf+PMQvosE
         GXPfOsB4uwlEtpjGyqZ6Qe3lBTngPc42wP0IPBH5Xczb6j5sT0kD4cSPHwDJIslxaTy8
         /z6YD4vE+b2dmXnDaUAnduYFS+KpHDF4rvRao/uhqUNY6iHBv0TVruuuw4okEHpvFez+
         l4DxCb5wCD1F5PdAbHCEsU1FfDH29sxvMh/Gw13SZ3/y0Fdj6nGjkeelO8XUhpb4+h3r
         QzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3J/8DrfKC8wRB2oqn/lWJ4LiNqC/Ucy++mQoZzgwnrY=;
        b=fxyt9uPEjbf9ESUHkmTHI3KctJ9x/trZDvj2UcLarr4r0/k49JuEN4y71yImUTQAQl
         ve7gG0CdhcqLt/Fz6VobgaXQen8v4qi918uCYLVTe7THiu6IQUt2sFxwnawPtaQnQ6Cx
         BFdPFyOgEgrxJheqRDRy6ecwOSxU79s6+WOfQpeMjj+A2xzLuVMFUuA0uFqMxq39YLXD
         Uj0YZL2A7E44PCQhHcpZ9MshzPShAn7wyNThjQz4UsBJvSku/frYn2Riy/BBxPm+w64w
         1f9tN+0ZCqX4io+9Zi7XaSLpvgYFTIYjpz5ETMmF45RUesG3ULUD1+pxfJbXt44HdY4e
         n+jA==
X-Gm-Message-State: AEkooutkMWARd1QR76Ry/9Kl6OGc/Bw6j5vGeX/zRcFoNYuQyfS7Srwv12hDzD0P26SYMg==
X-Received: by 10.28.183.134 with SMTP id h128mr49895268wmf.7.1469899566599;
        Sat, 30 Jul 2016 10:26:06 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:05 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v9 26/41] builtin/apply: make try_create_file() return -1 on error
Date:	Sat, 30 Jul 2016 19:24:54 +0200
Message-Id: <20160730172509.22939-27-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", try_create_file() should return -1 in case of
error.

Unfortunately try_create_file() currently returns -1 to signal a
recoverable error. To fix that, let's make it return 1 in case of
a recoverable error and -1 in case of an unrecoverable error.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0834ad2..dbf0372 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4150,38 +4150,45 @@ static int add_index_file(struct apply_state *state,
 	return 0;
 }
 
+/*
+ * Returns:
+ *  -1 if an unrecoverable error happened
+ *   0 if everything went well
+ *   1 if a recoverable error happened
+ */
 static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
 {
-	int fd;
+	int fd, res;
 	struct strbuf nbuf = STRBUF_INIT;
 
 	if (S_ISGITLINK(mode)) {
 		struct stat st;
 		if (!lstat(path, &st) && S_ISDIR(st.st_mode))
 			return 0;
-		return mkdir(path, 0777);
+		return !!mkdir(path, 0777);
 	}
 
 	if (has_symlinks && S_ISLNK(mode))
 		/* Although buf:size is counted string, it also is NUL
 		 * terminated.
 		 */
-		return symlink(buf, path);
+		return !!symlink(buf, path);
 
 	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
 	if (fd < 0)
-		return -1;
+		return 1;
 
 	if (convert_to_working_tree(path, buf, size, &nbuf)) {
 		size = nbuf.len;
 		buf  = nbuf.buf;
 	}
-	write_or_die(fd, buf, size);
+	res = !write_or_whine_pipe(fd, buf, size, path);
 	strbuf_release(&nbuf);
 
-	if (close(fd) < 0)
-		die_errno(_("closing file '%s'"), path);
-	return 0;
+	if (close(fd) < 0 && !res)
+		return error(_("closing file '%s': %s"), path, strerror(errno));
+
+	return res ? -1 : 0;
 }
 
 /*
@@ -4195,15 +4202,24 @@ static void create_one_file(struct apply_state *state,
 			    const char *buf,
 			    unsigned long size)
 {
+	int res;
+
 	if (state->cached)
 		return;
-	if (!try_create_file(path, mode, buf, size))
+
+	res = try_create_file(path, mode, buf, size);
+	if (res < 0)
+		exit(128);
+	if (!res)
 		return;
 
 	if (errno == ENOENT) {
 		if (safe_create_leading_directories(path))
 			return;
-		if (!try_create_file(path, mode, buf, size))
+		res = try_create_file(path, mode, buf, size);
+		if (res < 0)
+			exit(128);
+		if (!res)
 			return;
 	}
 
@@ -4222,7 +4238,10 @@ static void create_one_file(struct apply_state *state,
 		for (;;) {
 			char newpath[PATH_MAX];
 			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
-			if (!try_create_file(newpath, mode, buf, size)) {
+			res = try_create_file(newpath, mode, buf, size);
+			if (res < 0)
+				exit(128);
+			if (!res) {
 				if (!rename(newpath, path))
 					return;
 				unlink_or_warn(newpath);
-- 
2.9.2.558.gf53e569

