Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BDDD1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbeA2WjC (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:39:02 -0500
Received: from mail-yb0-f202.google.com ([209.85.213.202]:47263 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752300AbeA2WjB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:39:01 -0500
Received: by mail-yb0-f202.google.com with SMTP id d13so6628857ybn.14
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=FnuqFAUZuDzfZlH609t9NzacbT+Yb7QZ3lzefy/Rzy0=;
        b=eEZIsdRz6H5UK7mhoFdENuIuB2d9BkFwyGMEld543TgbqyBYKnXdLCUl/BpVKc3mfs
         /qK5BAyL5lFHeW3ztEx43bnYAJTf7jNbtE7l55INX9WUKupn1XFCeukvGpVwSavEcGRt
         oJyYGuWcMOU02BvPrvNSoex+5twNr6/9Kyx0zrePH16k6SD1JvtwgLL1ppBh6dpExgF2
         m1blqwimyhE+Ub0qLCGb0FciERVk42COyVvKNmXDo+GPR+jRbdg3OcT3Qw6Dbgzm7gBf
         yjzIh7ktMQV7bIeeLJigENGaFxQIDol6khnGpZG0/DFX/ElKgGeGNZ5mnH5D7WxJnoGg
         Zchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=FnuqFAUZuDzfZlH609t9NzacbT+Yb7QZ3lzefy/Rzy0=;
        b=rNDPy9YITgx+onVJwkBLyK52B2JuHxrCyCiX8pSv9UHPg5vbSN6Atyjrw3P27A6x36
         r2D/QLkBznc+31lmkTw23Xsma9sfN/0H20C8vZurpCLJGUM4q2Nfxm0QEU6qlkbmVjtA
         7TqrhuftXZSpJN5fJsW6ouBQC2Iix9hU4NxmcYljKdmokeSZIoyvW1VxgFopKDUuxQI6
         eITI+ITYkXS9DNOlDJTuNl6BHEmyqWrQMqWlrMCsYi4XAPIJoakhgGnF1L6V14E5p55w
         M3H/1TlReiq/VBW97JhFkGXZEag5pd5cmUTmmA/M1t7K9upI0XN7riwGin7kRubnugNv
         2CaA==
X-Gm-Message-State: AKwxytfVpuoHEDTcJkhPBBmRcwpTs2hG4cl3mDOglIYyJ3JEF5tYOhi6
        oB0YNCZwehRBigEe0CUtFs+ucSByYQ9MCK7hJFIDxSFwn3d4wX9XTzksdp7h+PH77jenPZ05S7i
        3qe5TV4JxtJ1yRka6WHTcYcuGY7tIQ6HuXEkDrPq/RglezbXIP8zdrM5p9A==
X-Google-Smtp-Source: AH8x225fftSmHXCFDbtiLzmBxCxm+9U4wzCquNt/GD3BBKzbKZc8WUpjhirtUndo7jjXs18mXcE8seb+07I=
MIME-Version: 1.0
X-Received: by 10.129.69.10 with SMTP id s10mr11273201ywa.98.1517265540427;
 Mon, 29 Jan 2018 14:39:00 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:25 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-35-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 34/37] wrapper: rename 'template' variables
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
 git-compat-util.h |  4 ++--
 wrapper.c         | 40 ++++++++++++++++++++--------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 68b2ad531..07e383257 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -826,8 +826,8 @@ extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 extern int xdup(int fd);
 extern FILE *xfopen(const char *path, const char *mode);
 extern FILE *xfdopen(int fd, const char *mode);
-extern int xmkstemp(char *template);
-extern int xmkstemp_mode(char *template, int mode);
+extern int xmkstemp(char *temp_filename);
+extern int xmkstemp_mode(char *temp_filename, int mode);
 extern char *xgetcwd(void);
 extern FILE *fopen_for_writing(const char *path);
 extern FILE *fopen_or_warn(const char *path, const char *mode);
diff --git a/wrapper.c b/wrapper.c
index d20356a77..1fd5e33ea 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -445,21 +445,21 @@ FILE *fopen_or_warn(const char *path, const char *mode)
 	return NULL;
 }
 
-int xmkstemp(char *template)
+int xmkstemp(char *filename_template)
 {
 	int fd;
 	char origtemplate[PATH_MAX];
-	strlcpy(origtemplate, template, sizeof(origtemplate));
+	strlcpy(origtemplate, filename_template, sizeof(origtemplate));
 
-	fd = mkstemp(template);
+	fd = mkstemp(filename_template);
 	if (fd < 0) {
 		int saved_errno = errno;
 		const char *nonrelative_template;
 
-		if (strlen(template) != strlen(origtemplate))
-			template = origtemplate;
+		if (strlen(filename_template) != strlen(origtemplate))
+			filename_template = origtemplate;
 
-		nonrelative_template = absolute_path(template);
+		nonrelative_template = absolute_path(filename_template);
 		errno = saved_errno;
 		die_errno("Unable to create temporary file '%s'",
 			nonrelative_template);
@@ -481,7 +481,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	static const int num_letters = 62;
 	uint64_t value;
 	struct timeval tv;
-	char *template;
+	char *filename_template;
 	size_t len;
 	int fd, count;
 
@@ -503,16 +503,16 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	 */
 	gettimeofday(&tv, NULL);
 	value = ((size_t)(tv.tv_usec << 16)) ^ tv.tv_sec ^ getpid();
-	template = &pattern[len - 6 - suffix_len];
+	filename_template = &pattern[len - 6 - suffix_len];
 	for (count = 0; count < TMP_MAX; ++count) {
 		uint64_t v = value;
 		/* Fill in the random bits. */
-		template[0] = letters[v % num_letters]; v /= num_letters;
-		template[1] = letters[v % num_letters]; v /= num_letters;
-		template[2] = letters[v % num_letters]; v /= num_letters;
-		template[3] = letters[v % num_letters]; v /= num_letters;
-		template[4] = letters[v % num_letters]; v /= num_letters;
-		template[5] = letters[v % num_letters]; v /= num_letters;
+		filename_template[0] = letters[v % num_letters]; v /= num_letters;
+		filename_template[1] = letters[v % num_letters]; v /= num_letters;
+		filename_template[2] = letters[v % num_letters]; v /= num_letters;
+		filename_template[3] = letters[v % num_letters]; v /= num_letters;
+		filename_template[4] = letters[v % num_letters]; v /= num_letters;
+		filename_template[5] = letters[v % num_letters]; v /= num_letters;
 
 		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
 		if (fd >= 0)
@@ -541,21 +541,21 @@ int git_mkstemp_mode(char *pattern, int mode)
 	return git_mkstemps_mode(pattern, 0, mode);
 }
 
-int xmkstemp_mode(char *template, int mode)
+int xmkstemp_mode(char *filename_template, int mode)
 {
 	int fd;
 	char origtemplate[PATH_MAX];
-	strlcpy(origtemplate, template, sizeof(origtemplate));
+	strlcpy(origtemplate, filename_template, sizeof(origtemplate));
 
-	fd = git_mkstemp_mode(template, mode);
+	fd = git_mkstemp_mode(filename_template, mode);
 	if (fd < 0) {
 		int saved_errno = errno;
 		const char *nonrelative_template;
 
-		if (!template[0])
-			template = origtemplate;
+		if (!filename_template[0])
+			filename_template = origtemplate;
 
-		nonrelative_template = absolute_path(template);
+		nonrelative_template = absolute_path(filename_template);
 		errno = saved_errno;
 		die_errno("Unable to create temporary file '%s'",
 			nonrelative_template);
-- 
2.16.0.rc1.238.g530d649a79-goog

