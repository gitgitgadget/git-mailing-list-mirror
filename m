Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731B020193
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbcHHVEk (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34903 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbcHHVE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so17867085wmg.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2aEgXBuOiG5ZJ9udEdLeOZSRJFN+Ewns5xKcgvgFkw8=;
        b=pFZ6ECRHAorNETnvf8oOpSOzbMb2K4o4Uepo/oeJizaBato/yvKpKJZGXH39JmR7OC
         32Z4Tp+K32hhsYb3oa0+EZemKE1CLTJZu4+uPtRJ4iq7WbHAprecDSjDXV1saLJ9y3zg
         Am9Ua/JQ2/pKKUFQI3aWRBl+3cR9YBE9w88fe4jneSWIig0mTCPILUCj3E0kTqeO8+Hl
         lehqmL1b4+1RwosAYm89MBCstpd0fF2dUnq+zAYn6+uPHkiyWPAM56B46jPyjsa1Uh5E
         4quzv5fmkRWjLfwpAD0p1o3ir7RDBqrl61cYcmWFt2VFBk7zS5FsRRGpgse8Mkfol+lh
         dprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2aEgXBuOiG5ZJ9udEdLeOZSRJFN+Ewns5xKcgvgFkw8=;
        b=DVqlrtNYQtF2iqDZdIYITDDouJPH1KGq35nJW3gqCskxcmu27LGYfAo/6S4hdl+/x1
         DVk4cCNLUW3u2W0xM/Qbsc6u/up9Vp4hbzueLkr0Zz1Pt5Lt0O1eh5Kl1Dq4WnKA0Knd
         lumgcZpgrccYJI+vSV+/njyojjxpyFzVDQJZMa+SpadmWVmDXXcylNplMqzNwWTTeLP8
         0qD7fGDUMbM74k/ykDrzMRS8dNPA0FfxFOg56nBKm+EdQlIGRKXC2UzkQKs1AXy0PzCK
         JtHf3kcBxtbDlG6tbmJEV/Q/sogAS29F5jpg6EWNz/GDyukvejw1EHCJiFDDpYGtJHR7
         SfUw==
X-Gm-Message-State: AEkoouvUjFsWYQPStC/FrhVWBlgAWUkskUyomRrO0Jy/W4gqrRTQU3XUSLNmcm9LEqxlcg==
X-Received: by 10.194.38.9 with SMTP id c9mr23815453wjk.78.1470690268131;
        Mon, 08 Aug 2016 14:04:28 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:27 -0700 (PDT)
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
Subject: [PATCH v10 26/40] builtin/apply: make try_create_file() return -1 on error
Date:	Mon,  8 Aug 2016 23:03:23 +0200
Message-Id: <20160808210337.5038-27-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c787ead..9372999 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4150,38 +4150,48 @@ static int add_index_file(struct apply_state *state,
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
+
+	res = write_in_full(fd, buf, size) < 0;
+	if (res)
+		error_errno(_("failed to write to '%s'"), path);
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
@@ -4195,15 +4205,24 @@ static void create_one_file(struct apply_state *state,
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
 
@@ -4222,7 +4241,10 @@ static void create_one_file(struct apply_state *state,
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
2.9.2.614.g4980f51

