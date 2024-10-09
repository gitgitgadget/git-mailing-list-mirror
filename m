Received: from mout1.freenet.de (mout1.freenet.de [195.4.92.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B58F18F2C1
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470467; cv=none; b=r9/JpuG2QOlbkcQh1Gkd2egk30G1gmE1BbaFBCcvqCisD1+CzP8waOlSDC0yiFWmuUOLk+eIbdoFj1o1KvLc/sNQTjMwJIvAOatKXVe2wZp4Weg0NdhB2bgiv6bLZFeyyY688ldBihSiz6U4GrTmNZp0D1qEtNRLeKDfhEQvJcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470467; c=relaxed/simple;
	bh=Wtu0kCNRmLCCbY+ZnvmQg9VpJwZSwpBLjO9dLJBeiGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HvUnEaWTRHvwNb5o/1vmMhQ8NIMEeUnv5nrdQOzXAvwAQdKr4eB9OnTw/KEA1ak+k6R78O7mv+1nLrOv8Q1Vtd+T5LckadxyDztvVZnqic7/kNQp5jhfJiPZsyoFg30IUbuBy9ouO7ZoryCKx+I2fgfg8OSbkPrUQOmeMFF90So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=zM2QcAZO; arc=none smtp.client-ip=195.4.92.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="zM2QcAZO"
Received: from [195.4.92.123] (helo=sub4.freenet.de)
	by mout1.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1syU2s-006MTl-7O
	for git@vger.kernel.org; Wed, 09 Oct 2024 12:35:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G1GZjJo1tj4Arkr2u4JwM8XePCjG/ScOOrZ5QdaBHGk=; b=zM2QcAZOPaBQ9QS1xGRqSvsAzU
	RWuclTIrmZJYn99dntlxZPK6F9CC96jH/BWUIDtQAF2m59zC3PkmrGajajZtDaZjIZIqb8cz3LWZY
	0lxDtYhgBQR+21153d9rQVkwstRnsRcdJelbaRp++pMkdp958OowF0PV1YLk6RgaWo8nbNwbw1B+9
	Nxf6q7aJ27Yt9SRPoHxRJwqcHRJ2+A3hm3OqpOlb6DTddPJ/J/0CVBYnTjFaOL8sGwRjtNU3HhQvx
	KZNU0F8gNnbXpr127Inu0icXZNXgoLlproq73s5fQn0r0n6AWcs39yAwEMYOPAN0Xe9TI2Z1G0/0+
	pJmIkEBA==;
Received: from p200300e2e7083000dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e708:3000:dacb:8aff:fee0:ca63]:60838 helo=soren-pc.lan)
	by sub4.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1syU2r-0054S3-UH; Wed, 09 Oct 2024 12:35:54 +0200
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH] mimgw: remove Compiler Warnings
Date: Wed,  9 Oct 2024 12:35:41 +0200
Message-Id: <20241009103541.2887-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 172847015399E9A1C9554CO
X-Originated-At: 2003:e2:e708:3000:dacb:8aff:fee0:ca63!60838
X-Scan-TS: Wed, 09 Oct 2024 12:35:53 +0200

Remove some complier warnings from msvc in compat/mingw.c for value truncation from 64 bit to 32 bit intigers.

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 compat/compiler.h               |  4 ++--
 compat/mingw.c                  | 26 ++++++++++++++++----------
 compat/vcbuild/include/unistd.h |  7 +++++++
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/compat/compiler.h b/compat/compiler.h
index e9ad9db84f..e12e426404 100644
--- a/compat/compiler.h
+++ b/compat/compiler.h
@@ -9,7 +9,7 @@
 
 static inline void get_compiler_info(struct strbuf *info)
 {
-	int len = info->len;
+	size_t len = info->len;
 #ifdef __clang__
 	strbuf_addf(info, "clang: %s\n", __clang_version__);
 #elif defined(__GNUC__)
@@ -27,7 +27,7 @@ static inline void get_compiler_info(struct strbuf *info)
 
 static inline void get_libc_info(struct strbuf *info)
 {
-	int len = info->len;
+	size_t len = info->len;
 
 #ifdef __GLIBC__
 	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
diff --git a/compat/mingw.c b/compat/mingw.c
index 0e851ecae2..dca0816267 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -782,7 +782,7 @@ static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
  */
 static int has_valid_directory_prefix(wchar_t *wfilename)
 {
-	int n = wcslen(wfilename);
+	ssize_t n = wcslen(wfilename);
 
 	while (n > 0) {
 		wchar_t c = wfilename[--n];
@@ -891,7 +891,7 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
  */
 static int do_stat_internal(int follow, const char *file_name, struct stat *buf)
 {
-	int namelen;
+	ssize_t namelen;
 	char alt_name[PATH_MAX];
 
 	if (!do_lstat(follow, file_name, buf))
@@ -1274,7 +1274,8 @@ static const char *parse_interpreter(const char *cmd)
 {
 	static char buf[100];
 	char *p, *opt;
-	int n, fd;
+	ssize_t n;
+	int fd;
 
 	/* don't even try a .exe */
 	n = strlen(cmd);
@@ -1339,7 +1340,7 @@ static char *path_lookup(const char *cmd, int exe_only)
 {
 	const char *path;
 	char *prog = NULL;
-	int len = strlen(cmd);
+	size_t len = strlen(cmd);
 	int isexe = len >= 4 && !strcasecmp(cmd+len-4, ".exe");
 
 	if (strpbrk(cmd, "/\\"))
@@ -1956,7 +1957,7 @@ char *mingw_getenv(const char *name)
 #define GETENV_MAX_RETAIN 64
 	static char *values[GETENV_MAX_RETAIN];
 	static int value_counter;
-	int len_key, len_value;
+	size_t len_key, len_value;
 	wchar_t *w_key;
 	char *value;
 	wchar_t w_value[32768];
@@ -1968,7 +1969,9 @@ char *mingw_getenv(const char *name)
 	/* We cannot use xcalloc() here because that uses getenv() itself */
 	w_key = calloc(len_key, sizeof(wchar_t));
 	if (!w_key)
-		die("Out of memory, (tried to allocate %u wchar_t's)", len_key);
+		die("Out of memory, (tried to allocate %"
+			    PRIuMAX" wchar_t's)",
+		    (uintmax_t)len_key);
 	xutftowcs(w_key, name, len_key);
 	/* GetEnvironmentVariableW() only sets the last error upon failure */
 	SetLastError(ERROR_SUCCESS);
@@ -1983,7 +1986,8 @@ char *mingw_getenv(const char *name)
 	/* We cannot use xcalloc() here because that uses getenv() itself */
 	value = calloc(len_value, sizeof(char));
 	if (!value)
-		die("Out of memory, (tried to allocate %u bytes)", len_value);
+	    die("Out of memory, (tried to allocate %" PRIuMAX " bytes)",
+	    (uintmax_t)len_value);
 	xwcstoutf(value, w_value, len_value);
 
 	/*
@@ -2001,7 +2005,7 @@ char *mingw_getenv(const char *name)
 
 int mingw_putenv(const char *namevalue)
 {
-	int size;
+	size_t size;
 	wchar_t *wide, *equal;
 	BOOL result;
 
@@ -2011,7 +2015,8 @@ int mingw_putenv(const char *namevalue)
 	size = strlen(namevalue) * 2 + 1;
 	wide = calloc(size, sizeof(wchar_t));
 	if (!wide)
-		die("Out of memory, (tried to allocate %u wchar_t's)", size);
+		die("Out of memory, (tried to allocate %" PRIuMAX " wchar_t's)",
+		    (uintmax_t)size);
 	xutftowcs(wide, namevalue, size);
 	equal = wcschr(wide, L'=');
 	if (!equal)
@@ -3085,7 +3090,8 @@ static void maybe_redirect_std_handles(void)
  */
 int wmain(int argc, const wchar_t **wargv)
 {
-	int i, maxlen, exit_status;
+	int exit_status;
+	size_t i, maxlen;
 	char *buffer, **save;
 	const char **argv;
 
diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
index 3a959d124c..ab3dc06709 100644
--- a/compat/vcbuild/include/unistd.h
+++ b/compat/vcbuild/include/unistd.h
@@ -13,8 +13,15 @@ typedef _mode_t	mode_t;
 #endif	/* Not _MODE_T_ */
 
 #ifndef _SSIZE_T_
+#ifdef _WIN64
 #define _SSIZE_T_
+typedef __int64 _ssize_t;
+#pragma message("Compiling on Win64")
+#else
 typedef long _ssize_t;
+#endif // _AMD64
+
+
 
 #ifndef	_OFF_T_
 #define	_OFF_T_

base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
2.39.5

