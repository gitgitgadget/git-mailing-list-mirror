Received: from mout2.freenet.de (mout2.freenet.de [195.4.92.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2399E1A00ED
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556515; cv=none; b=nChd+fV2n+q7TNdyD+d/8TFtFCGLZe/SkCxqlbfezyj4P7HupU3tWmn/WV21lWw0NHlrL7zxdMSJSh2opyz21iTvlLVsr+VuUFLg4enS4gAFn94vFVuLxR0GHGrb9ZJnXlLXcdU8+yMJtozOjC/GYvX+YTGBvDtkoM/Zk6laLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556515; c=relaxed/simple;
	bh=6Ki8FSa6HIOp10pSskoBaSfCGnyiZJC2docsT0AhMK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgkfphjOlPejCdkEwdjBNOPdMA7Ki5hGlpNHFMzXqK91D6xgqmdzRQ+u580Im13pWH2pP6yfbc3eCm0Rq7isU3qSTCxXfGc5rp2d87DedoQkO5bNOdpx+KwvhVMyrj5RUrF7+36ooLL6ICcjnVad2Ltn72q5E7w2wYw9+Egoi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=psth5j1L; arc=none smtp.client-ip=195.4.92.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="psth5j1L"
Received: from [195.4.92.122] (helo=sub3.freenet.de)
	by mout2.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1syqQg-005PYi-H1; Thu, 10 Oct 2024 12:29:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=67wcVYEz5vj3YEyx5ZGS7drr6byDQwa2ZfwewHStMMM=; b=psth5j1LZ4vR93/DmDCtagUi3t
	Ogelyi3c3LkyxsclxKJA2YA0STnJfq8AC0qu5s6YhCh90/qR8x4ytM944DHg0ukKyInOLgiIAUUKl
	URKrGrTCujkM7Teu2EENCJlHsLj8o6BK1YNx0UtyGjqxhcPa/zD5Sz7md4Mj6daz2zXitY7V1DK8W
	TUrYeznODfKEkI6BbbMDHIo/SG/bhcmXyrYxz9IKh0/Ytsgv6dgTRE21Dp6Ywoq+Ry2RScvq1MSdD
	V1r9/b0BS0DMYOIFu+S43HEOFS6ST4ShlVRX1xSTKGwNlnlgpc/wKiSLQh+9Al1+LXiusXoUIZOwz
	pBZtURgg==;
Received: from p200300e2e7083000dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e708:3000:dacb:8aff:fee0:ca63]:33428 helo=soren-pc.lan)
	by sub3.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1syqQg-00FAs8-7K; Thu, 10 Oct 2024 12:29:58 +0200
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: tboegi@web.de,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH] [PATCH] mimgw: Remove Compiler Warnings
Date: Thu, 10 Oct 2024 12:29:50 +0200
Message-Id: <20241010102950.2151-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <e7646092-84e0-4210-88e9-98352e1f60e0@gmail.com>
References: <e7646092-84e0-4210-88e9-98352e1f60e0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 17285561986E42BFF68723O
X-Originated-At: 2003:e2:e708:3000:dacb:8aff:fee0:ca63!33428
X-Scan-TS: Thu, 10 Oct 2024 12:29:58 +0200

Remove some complier warnings from msvc in compat/mingw.c for value truncation from 64 bit to 32 bit integers.

Use size_t instead of int as all of the changed variables hold the result of strlen() or wcslen() which cannot be negative.
and set the size of ssize_t to 64 bit on windwos 64 bit.

Signed-off-by: Sören Krecker <soekkle@freenet.de>
---
 compat/compiler.h               |  4 ++--
 compat/mingw.c                  | 25 +++++++++++++++----------
 compat/vcbuild/include/unistd.h |  4 ++++
 3 files changed, 21 insertions(+), 12 deletions(-)

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
index 0e851ecae2..0ff550cef3 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -782,7 +782,7 @@ static inline void filetime_to_timespec(const FILETIME *ft, struct timespec *ts)
  */
 static int has_valid_directory_prefix(wchar_t *wfilename)
 {
-	int n = wcslen(wfilename);
+	size_t n = wcslen(wfilename);
 
 	while (n > 0) {
 		wchar_t c = wfilename[--n];
@@ -891,7 +891,7 @@ static int do_lstat(int follow, const char *file_name, struct stat *buf)
  */
 static int do_stat_internal(int follow, const char *file_name, struct stat *buf)
 {
-	int namelen;
+	size_t namelen;
 	char alt_name[PATH_MAX];
 
 	if (!do_lstat(follow, file_name, buf))
@@ -1274,7 +1274,8 @@ static const char *parse_interpreter(const char *cmd)
 {
 	static char buf[100];
 	char *p, *opt;
-	int n, fd;
+	ssize_t n; /* read() can return negative values */
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
@@ -1968,7 +1969,8 @@ char *mingw_getenv(const char *name)
 	/* We cannot use xcalloc() here because that uses getenv() itself */
 	w_key = calloc(len_key, sizeof(wchar_t));
 	if (!w_key)
-		die("Out of memory, (tried to allocate %u wchar_t's)", len_key);
+		die("Out of memory, (tried to allocate %"PRIuMAX" wchar_t's)",
+			(uintmax_t)len_key);
 	xutftowcs(w_key, name, len_key);
 	/* GetEnvironmentVariableW() only sets the last error upon failure */
 	SetLastError(ERROR_SUCCESS);
@@ -1983,7 +1985,8 @@ char *mingw_getenv(const char *name)
 	/* We cannot use xcalloc() here because that uses getenv() itself */
 	value = calloc(len_value, sizeof(char));
 	if (!value)
-		die("Out of memory, (tried to allocate %u bytes)", len_value);
+		die("Out of memory, (tried to allocate %"PRIuMAX" bytes)",
+			(uintmax_t)len_value);
 	xwcstoutf(value, w_value, len_value);
 
 	/*
@@ -2001,7 +2004,7 @@ char *mingw_getenv(const char *name)
 
 int mingw_putenv(const char *namevalue)
 {
-	int size;
+	size_t size;
 	wchar_t *wide, *equal;
 	BOOL result;
 
@@ -2011,7 +2014,8 @@ int mingw_putenv(const char *namevalue)
 	size = strlen(namevalue) * 2 + 1;
 	wide = calloc(size, sizeof(wchar_t));
 	if (!wide)
-		die("Out of memory, (tried to allocate %u wchar_t's)", size);
+		die("Out of memory, (tried to allocate %" PRIuMAX " wchar_t's)",
+		    (uintmax_t)size);
 	xutftowcs(wide, namevalue, size);
 	equal = wcschr(wide, L'=');
 	if (!equal)
@@ -3085,7 +3089,8 @@ static void maybe_redirect_std_handles(void)
  */
 int wmain(int argc, const wchar_t **wargv)
 {
-	int i, maxlen, exit_status;
+	int i, exit_status;
+	size_t maxlen;
 	char *buffer, **save;
 	const char **argv;
 
diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
index 3a959d124c..a261a925b7 100644
--- a/compat/vcbuild/include/unistd.h
+++ b/compat/vcbuild/include/unistd.h
@@ -14,7 +14,11 @@ typedef _mode_t	mode_t;
 
 #ifndef _SSIZE_T_
 #define _SSIZE_T_
+#ifdef _WIN64
+typedef __int64 _ssize_t;
+#else
 typedef long _ssize_t;
+#endif /* _WIN64 */
 
 #ifndef	_OFF_T_
 #define	_OFF_T_

base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
2.39.5

