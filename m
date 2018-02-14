Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ABFB1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162591AbeBNTCS (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:02:18 -0500
Received: from mail-qt0-f201.google.com ([209.85.216.201]:56822 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162565AbeBNTCO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:02:14 -0500
Received: by mail-qt0-f201.google.com with SMTP id s42so5887673qta.23
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=AeGHOZD+16DfzpjoQvG9UGI3L+S9btPWiVoXG3dBsKE=;
        b=sC/eCeZPJ+4Ny/bSouqbu5KJjGsTL1SHJ9gqvrnU+ZFlN8hFcr74pbdYsJZC2vM0jM
         3htr0c5ofa78WVO369Ggk8yuV5Ws9mgpAntEodPyHGZnJ+TCIvX9/nr0F2kA6U7cQB0t
         v4zHbkseMQ6w4O2dV4S00srWcuNViZl+K/ydlVvc8CulFCB6dPIBR7elkuh/93T3/cKT
         1hhLhtM8+F4Qm7UMpYh+s7BlB9I6Wl4OELVq4f8O+huxCL7niYlQBf+OuTfExg8YBDop
         0ESJjjzvBMy3GuwE3JaywoPM7bKRwYyJIKGaqsCgCHv3MM5zK+t/fQsc8LcRY76X2b4V
         Wl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=AeGHOZD+16DfzpjoQvG9UGI3L+S9btPWiVoXG3dBsKE=;
        b=bZJTGyLGosVOCyBBYTTpFylyCRusmU5VLfoQfSOIpHouP/5/pjIbb1gaMBjAD8JoTE
         oLixmnWvvbqBDg2et9MmlMju6VjuEJcOJO6oen5TEuHBbYyheb97byRNCsykfwwdMBEF
         GcTcny3uBuWtcCWhIg8O3TY4sHt/NQvQFp9Y9WLa1a+75wFjVLJP2leW3AiruIXKEDMx
         8MegXEfR/4eAUZXiuPawfK5r1efhnjyCuYOKmTm9mF3+bDoAOosRbh6yWGKyBSjk1+tf
         jw91wiOCPOaqB+sXd2Xhu+2Cxihsx9shKdxG5fLAOS1CexRBgZEYXhvJad6b5JzJVmVD
         blWg==
X-Gm-Message-State: APf1xPDP2ageyNuY05z7mK+qokNvmdpxknoaRkCEBHSVMuCa1BUApxwt
        COQ0C8wTdOuIzg4s/0w6Xlg4Ibh8ySjXpAyxiFf+G5VKXRmKmJULK+ifvK7SPOY+ImAWI1fe/HY
        Ps9/hvbRdRKIS3ExhjRt/Y3zgy/3rebnmCVBbpWEvI1m3Cs+JnsDCtHyIZQ==
X-Google-Smtp-Source: AH8x225S+HMjtol8N+Yq6O3C/f0VmUbLmZbleLi9qvBqHthbDgfvXDsG3CpvjlPe2IwX4eP83+WVLIPoOvw=
MIME-Version: 1.0
X-Received: by 10.200.33.162 with SMTP id 31mr29449qty.27.1518634933808; Wed,
 14 Feb 2018 11:02:13 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:56 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-35-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 34/37] wrapper: rename 'template' variables
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
2.16.1.291.g4437f3f132-goog

