Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AAEF2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbcF0SZn (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33337 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbcF0SZj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id r201so26996359wme.0
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gTswT3AoZqCxsjRxRF41r5uChN4eyUvH+iKAnGaCtnw=;
        b=IpgmMib9g3jAccpUzQdqOAwRbwWBnkZ/qZ0g7NP933xdBfAWL/pXA/1z5Adp6VSHx3
         ExNFwAK+IpCxK7kDB/8HrLFDTE+etjFYH6pbOqUUx5Kd8L6AnLOcu9Zy2LstetcgVUXO
         eV0iiMHFbOaWOz5h+uTIZSIw4ZME/33wqWiu6THawn6rLao2CbTwSiWumT50Gw6EuGBj
         Heq4dFHsy8wvRHNsaeBdM/0ckp8fDfKP0PTWvTuyJ4iPgX8d1FQtxe4jsmU9ZKYKW6Ec
         Ubw8LW23LvPL7UADRNE02rkerNjiP2bhxv9zfI6MVqUBBp1gYxbkjvJNh292Cav+MlLX
         5Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gTswT3AoZqCxsjRxRF41r5uChN4eyUvH+iKAnGaCtnw=;
        b=ENl68uSC4O/0kpKSIayaOsv1b2gslTPosfLu0k1GjbZi1XR6ZYBNPvYj1RKzFJpzhC
         4iFDxIeGueY5kG9mRasQmLCESMpdJJqmetENLjHcQyGVy9nee8evsCzVIcoShU+6ypyl
         bI36A05thMyMpQTtLg73OmL1ta5mTUm3hxe8Oj31xXyqig8LU0OHB7MwZAAGk2LI1ci7
         NrmWyz0Xm9/o5Aqc+LsWBd4id1LK5vnTpVOUy/y5eSOwwVZ9avgMBmAGoR9iAUHwyX+n
         sF0OTWCkb5Bat043SQL/0hPxSe8csG/CeSTwm0BbYWganEhC4Zd/64UN8x4wfb+kputo
         fPYQ==
X-Gm-Message-State: ALyK8tIyqYgxBvkMdk4TE1mdQBdT+xe5+VyiawyMxZhwdTLgi5vy8PxC7BQgEncXREnBcQ==
X-Received: by 10.194.178.199 with SMTP id da7mr2136358wjc.123.1467051925735;
        Mon, 27 Jun 2016 11:25:25 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:25 -0700 (PDT)
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
Subject: [PATCH v8 26/41] builtin/apply: make try_create_file() return -1 on error
Date:	Mon, 27 Jun 2016 20:24:14 +0200
Message-Id: <20160627182429.31550-27-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
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
index f54b8c5..651a057 100644
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
2.9.0.172.gfb57a78

