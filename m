Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845051F453
	for <e@80x24.org>; Tue, 30 Oct 2018 09:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeJ3SPL (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 14:15:11 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:43569 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3SPL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 14:15:11 -0400
Received: by mail-pg1-f175.google.com with SMTP id n10-v6so5319494pgv.10
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TZWgSeN0zFPkc4lWxR5AQK491iOXdbqZTOobCCpkTBc=;
        b=lW85legoSknl/cOzVZ5Jwmy8wTTV7FeAX8WSWTeDQXWjyK4J4TOK8E6W5ZLte1iDQe
         RpkFPT0ykFOAoWP1U/i6DRg0re7WBeHDYf9XT5VfAwOqzEKaN85XU749TpaUjyosNjOC
         OP7+ogmuP7ZY/hFLs/oSTM45/eXjYmzWbJdLojeWYbG2Pmuk4PoD38kZlx3ZrCCcjGND
         4a8JoDu7lXvluKrGU3fxRQzvYHJyawvVQAqbdJKJ55LqMy0aV64WisbLJJZVEZqvZrjT
         sWbUacbrAIC0QBSdUKeGstJJEpGl6/uXoiRXTaV/A/9/xNG3vnR8N+gVgigi1dvZbrJE
         Y6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TZWgSeN0zFPkc4lWxR5AQK491iOXdbqZTOobCCpkTBc=;
        b=TVwRkLe51U17k0NoPLzizU/12M+pOOehur5SVjYEWisXwbyL7eQkt8YOMUHuXOv5/6
         8s4jP4UmiHUNrqyZJR0c9FTy2LjgNkSAWMLMNTTdtLd48BDsNsyyWumctpWNf5oJZlLR
         bB+P5s2Y4pvWlD0xpXiMqMTVCwsD9TO0Hs7w+WhxjqyK9CkyGeVjViPAlJqfgX89CJC1
         dQD26uPqOp88d21v887ExcTFvtB73AQMtmPep2vtmZwuXn1AuSjXsdCrHC2nAieWpk82
         mSSjnPbnTwHaoyFFPTDVq0D9WfqZZrIQ6m9ooqlXjlVYgG0fTyJ8TyGRfEPt+HnR428C
         vOVw==
X-Gm-Message-State: AGRZ1gIpm31iBwt5jPtruU3tf9i335JP9N7/UK4C6wlFqmFdaNdMAp9z
        6IbWB9sK4ezEHKbwyP2T4Dy4/t0m
X-Google-Smtp-Source: AJdET5eQfLIOUAF/fZ9QvFUCInct/xqIJ+MwLkU+oB0Ch54GOE0rdnrRE8okh4SMrSHx82RmsjNpEw==
X-Received: by 2002:a63:111c:: with SMTP id g28mr17046967pgl.85.1540891351446;
        Tue, 30 Oct 2018 02:22:31 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id b16-v6sm23812140pgl.66.2018.10.30.02.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 02:22:30 -0700 (PDT)
Date:   Tue, 30 Oct 2018 02:22:30 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 09:22:25 GMT
Message-Id: <9538106fb528c747416d7193267d9ffdcbbb1de5.1540891346.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.57.git.gitgitgadget@gmail.com>
References: <pull.57.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] mingw: reencode environment variables on the fly (UTF-16
 <-> UTF-8)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Karsten Blees <karsten.blees@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, the authoritative environment is encoded in UTF-16. In Git
for Windows, we convert that to UTF-8 (because UTF-16 is *such* a
foreign idea to Git that its source code is unprepared for it).

Previously, out of performance concerns, we converted the entire
environment to UTF-8 in one fell swoop at the beginning, and upon
putenv() and run_command() converted it back.

Having a private copy of the environment comes with its own perils: when
a library used by Git's source code tries to modify the environment, it
does not really work (in Git for Windows' case, libcurl, see
https://github.com/git-for-windows/git/compare/bcad1e6d58^...bcad1e6d58^2
for a glimpse of the issues).

Hence, it makes our environment handling substantially more robust if we
switch to on-the-fly-conversion in `getenv()`/`putenv()` calls. Based
on an initial version in the MSVC context by Jeff Hostetler, this patch
makes it so.

Surprisingly, this has a *positive* effect on speed: at the time when
the current code was written, we tested the performance, and there were
*so many* `getenv()` calls that it seemed better to convert everything
in one go. In the meantime, though, Git has obviously been cleaned up a
bit with regards to `getenv()` calls so that the Git processes spawned
by the test suite use an average of only 40 `getenv()`/`putenv()` calls
over the process lifetime.

Speaking of the entire test suite: the total time spent in the
re-encoding in the current code takes about 32.4 seconds (out of 113
minutes runtime), whereas the code introduced in this patch takes only
about 8.2 seconds in total. Not much, but it proves that we need not be
concerned about the performance impact introduced by this patch.

Helped-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 280 +++++++++++++++++++++++++++++--------------------
 compat/mingw.h |  32 +++++-
 2 files changed, 196 insertions(+), 116 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 44264fe3f..0cd432441 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1071,44 +1071,121 @@ static char *path_lookup(const char *cmd, int exe_only)
 	return prog;
 }
 
-static int do_putenv(char **env, const char *name, int size, int free_old);
+static const wchar_t *wcschrnul(const wchar_t *s, wchar_t c)
+{
+	while (*s && *s != c)
+		s++;
+	return s;
+}
+
+/* Compare only keys */
+static int wenvcmp(const void *a, const void *b)
+{
+	wchar_t *p = *(wchar_t **)a, *q = *(wchar_t **)b;
+	size_t p_len, q_len;
+
+	/* Find the keys */
+	p_len = wcschrnul(p, L'=') - p;
+	q_len = wcschrnul(q, L'=') - q;
+
+	/* If the length differs, include the shorter key's NUL */
+	if (p_len < q_len)
+		p_len++;
+	else if (p_len > q_len)
+		p_len = q_len + 1;
+
+	return _wcsnicmp(p, q, p_len);
+}
 
-/* used number of elements of environ array, including terminating NULL */
-static int environ_size = 0;
-/* allocated size of environ array, in bytes */
-static int environ_alloc = 0;
+/* We need a stable sort to convert the environment between UTF-16 <-> UTF-8 */
+#ifndef INTERNAL_QSORT
+#include "qsort.c"
+#endif
 
 /*
- * Create environment block suitable for CreateProcess. Merges current
- * process environment and the supplied environment changes.
+ * Build an environment block combining the inherited environment
+ * merged with the given list of settings.
+ *
+ * Values of the form "KEY=VALUE" in deltaenv override inherited values.
+ * Values of the form "KEY" in deltaenv delete inherited values.
+ *
+ * Multiple entries in deltaenv for the same key are explicitly allowed.
+ *
+ * We return a contiguous block of UNICODE strings with a final trailing
+ * zero word.
  */
 static wchar_t *make_environment_block(char **deltaenv)
 {
-	wchar_t *wenvblk = NULL;
-	char **tmpenv;
-	int i = 0, size = environ_size, wenvsz = 0, wenvpos = 0;
+	wchar_t *wenv = GetEnvironmentStringsW(), *wdeltaenv, *result, *p;
+	size_t wlen, s, delta_size, size;
+
+	wchar_t **array = NULL;
+	size_t alloc = 0, nr = 0, i;
+
+	size = 1; /* for extra NUL at the end */
+
+	/* If there is no deltaenv to apply, simply return a copy. */
+	if (!deltaenv || !*deltaenv) {
+		for (p = wenv; p && *p; ) {
+			size_t s = wcslen(p) + 1;
+			size += s;
+			p += s;
+		}
+
+		ALLOC_ARRAY(result, size);
+		memcpy(result, wenv, size * sizeof(*wenv));
+		FreeEnvironmentStringsW(wenv);
+		return result;
+	}
+
+	/*
+	 * If there is a deltaenv, let's accumulate all keys into `array`,
+	 * sort them using the stable git_qsort() and then copy, skipping
+	 * duplicate keys
+	 */
+	for (p = wenv; p && *p; ) {
+		ALLOC_GROW(array, nr + 1, alloc);
+		s = wcslen(p) + 1;
+		array[nr++] = p;
+		p += s;
+		size += s;
+	}
+
+	/* (over-)assess size needed for wchar version of deltaenv */
+	for (delta_size = 0, i = 0; deltaenv[i]; i++)
+		delta_size += strlen(deltaenv[i]) * 2 + 1;
+	ALLOC_ARRAY(wdeltaenv, delta_size);
+
+	/* convert the deltaenv, appending to array */
+	for (i = 0, p = wdeltaenv; deltaenv[i]; i++) {
+		ALLOC_GROW(array, nr + 1, alloc);
+		wlen = xutftowcs(p, deltaenv[i], wdeltaenv + delta_size - p);
+		array[nr++] = p;
+		p += wlen + 1;
+	}
 
-	while (deltaenv && deltaenv[i])
-		i++;
+	git_qsort(array, nr, sizeof(*array), wenvcmp);
+	ALLOC_ARRAY(result, size + delta_size);
 
-	/* copy the environment, leaving space for changes */
-	ALLOC_ARRAY(tmpenv, size + i);
-	memcpy(tmpenv, environ, size * sizeof(char*));
+	for (p = result, i = 0; i < nr; i++) {
+		/* Skip any duplicate keys; last one wins */
+		while (i + 1 < nr && !wenvcmp(array + i, array + i + 1))
+		       i++;
 
-	/* merge supplied environment changes into the temporary environment */
-	for (i = 0; deltaenv && deltaenv[i]; i++)
-		size = do_putenv(tmpenv, deltaenv[i], size, 0);
+		/* Skip "to delete" entry */
+		if (!wcschr(array[i], L'='))
+			continue;
 
-	/* create environment block from temporary environment */
-	for (i = 0; tmpenv[i]; i++) {
-		size = 2 * strlen(tmpenv[i]) + 2; /* +2 for final \0 */
-		ALLOC_GROW(wenvblk, (wenvpos + size) * sizeof(wchar_t), wenvsz);
-		wenvpos += xutftowcs(&wenvblk[wenvpos], tmpenv[i], size) + 1;
+		size = wcslen(array[i]) + 1;
+		memcpy(p, array[i], size * sizeof(*p));
+		p += size;
 	}
-	/* add final \0 terminator */
-	wenvblk[wenvpos] = 0;
-	free(tmpenv);
-	return wenvblk;
+	*p = L'\0';
+
+	free(array);
+	free(wdeltaenv);
+	FreeEnvironmentStringsW(wenv);
+	return result;
 }
 
 struct pinfo_t {
@@ -1350,87 +1427,83 @@ int mingw_kill(pid_t pid, int sig)
 }
 
 /*
- * Compare environment entries by key (i.e. stopping at '=' or '\0').
+ * UTF-8 versions of getenv(), putenv() and unsetenv().
+ * Internally, they use the CRT's stock UNICODE routines
+ * to avoid data loss.
  */
-static int compareenv(const void *v1, const void *v2)
+char *mingw_getenv(const char *name)
 {
-	const char *e1 = *(const char**)v1;
-	const char *e2 = *(const char**)v2;
+#define GETENV_MAX_RETAIN 30
+	static char *values[GETENV_MAX_RETAIN];
+	static int value_counter;
+	int len_key, len_value;
+	wchar_t *w_key;
+	char *value;
+	wchar_t w_value[32768];
 
-	for (;;) {
-		int c1 = *e1++;
-		int c2 = *e2++;
-		c1 = (c1 == '=') ? 0 : tolower(c1);
-		c2 = (c2 == '=') ? 0 : tolower(c2);
-		if (c1 > c2)
-			return 1;
-		if (c1 < c2)
-			return -1;
-		if (c1 == 0)
-			return 0;
-	}
-}
+	if (!name || !*name)
+		return NULL;
 
-static int bsearchenv(char **env, const char *name, size_t size)
-{
-	unsigned low = 0, high = size;
-	while (low < high) {
-		unsigned mid = low + ((high - low) >> 1);
-		int cmp = compareenv(&env[mid], &name);
-		if (cmp < 0)
-			low = mid + 1;
-		else if (cmp > 0)
-			high = mid;
-		else
-			return mid;
+	len_key = strlen(name) + 1;
+	/* We cannot use xcalloc() here because that uses getenv() itself */
+	w_key = calloc(len_key, sizeof(wchar_t));
+	if (!w_key)
+		die("Out of memory, (tried to allocate %u wchar_t's)", len_key);
+	xutftowcs(w_key, name, len_key);
+	len_value = GetEnvironmentVariableW(w_key, w_value, ARRAY_SIZE(w_value));
+	if (!len_value && GetLastError() == ERROR_ENVVAR_NOT_FOUND) {
+		free(w_key);
+		return NULL;
 	}
-	return ~low; /* not found, return 1's complement of insert position */
+	free(w_key);
+
+	len_value = len_value * 3 + 1;
+	/* We cannot use xcalloc() here because that uses getenv() itself */
+	value = calloc(len_value, sizeof(char));
+	if (!value)
+		die("Out of memory, (tried to allocate %u bytes)", len_value);
+	xwcstoutf(value, w_value, len_value);
+
+	/*
+	 * We return `value` which is an allocated value and the caller is NOT
+	 * expecting to have to free it, so we keep a round-robin array,
+	 * invalidating the buffer after GETENV_MAX_RETAIN getenv() calls.
+	 */
+	free(values[value_counter]);
+	values[value_counter++] = value;
+	if (value_counter >= ARRAY_SIZE(values))
+		value_counter = 0;
+
+	return value;
 }
 
-/*
- * If name contains '=', then sets the variable, otherwise it unsets it
- * Size includes the terminating NULL. Env must have room for size + 1 entries
- * (in case of insert). Returns the new size. Optionally frees removed entries.
- */
-static int do_putenv(char **env, const char *name, int size, int free_old)
+int mingw_putenv(const char *namevalue)
 {
-	int i = bsearchenv(env, name, size - 1);
+	int size;
+	wchar_t *wide, *equal;
+	BOOL result;
 
-	/* optionally free removed / replaced entry */
-	if (i >= 0 && free_old)
-		free(env[i]);
+	if (!namevalue || !*namevalue)
+		return 0;
 
-	if (strchr(name, '=')) {
-		/* if new value ('key=value') is specified, insert or replace entry */
-		if (i < 0) {
-			i = ~i;
-			memmove(&env[i + 1], &env[i], (size - i) * sizeof(char*));
-			size++;
-		}
-		env[i] = (char*) name;
-	} else if (i >= 0) {
-		/* otherwise ('key') remove existing entry */
-		size--;
-		memmove(&env[i], &env[i + 1], (size - i) * sizeof(char*));
+	size = strlen(namevalue) * 2 + 1;
+	wide = calloc(size, sizeof(wchar_t));
+	if (!wide)
+		die("Out of memory, (tried to allocate %u wchar_t's)", size);
+	xutftowcs(wide, namevalue, size);
+	equal = wcschr(wide, L'=');
+	if (!equal)
+		result = SetEnvironmentVariableW(wide, NULL);
+	else {
+		*equal = L'\0';
+		result = SetEnvironmentVariableW(wide, equal + 1);
 	}
-	return size;
-}
+	free(wide);
 
-char *mingw_getenv(const char *name)
-{
-	char *value;
-	int pos = bsearchenv(environ, name, environ_size - 1);
-	if (pos < 0)
-		return NULL;
-	value = strchr(environ[pos], '=');
-	return value ? &value[1] : NULL;
-}
+	if (!result)
+		errno = err_win_to_posix(GetLastError());
 
-int mingw_putenv(const char *namevalue)
-{
-	ALLOC_GROW(environ, (environ_size + 1) * sizeof(char*), environ_alloc);
-	environ_size = do_putenv(environ, namevalue, environ_size, 1);
-	return 0;
+	return result ? 0 : -1;
 }
 
 /*
@@ -2337,17 +2410,6 @@ void mingw_startup(void)
 	maxlen = wcslen(wargv[0]);
 	for (i = 1; i < argc; i++)
 		maxlen = max(maxlen, wcslen(wargv[i]));
-	for (i = 0; wenv[i]; i++)
-		maxlen = max(maxlen, wcslen(wenv[i]));
-
-	/*
-	 * nedmalloc can't free CRT memory, allocate resizable environment
-	 * list. Note that xmalloc / xmemdupz etc. call getenv, so we cannot
-	 * use it while initializing the environment itself.
-	 */
-	environ_size = i + 1;
-	environ_alloc = alloc_nr(environ_size * sizeof(char*));
-	environ = malloc_startup(environ_alloc);
 
 	/* allocate buffer (wchar_t encodes to max 3 UTF-8 bytes) */
 	maxlen = 3 * maxlen + 1;
@@ -2356,14 +2418,8 @@ void mingw_startup(void)
 	/* convert command line arguments and environment to UTF-8 */
 	for (i = 0; i < argc; i++)
 		__argv[i] = wcstoutfdup_startup(buffer, wargv[i], maxlen);
-	for (i = 0; wenv[i]; i++)
-		environ[i] = wcstoutfdup_startup(buffer, wenv[i], maxlen);
-	environ[i] = NULL;
 	free(buffer);
 
-	/* sort environment for O(log n) getenv / putenv */
-	qsort(environ, i, sizeof(char*), compareenv);
-
 	/* fix Windows specific environment settings */
 	setup_windows_environment();
 
diff --git a/compat/mingw.h b/compat/mingw.h
index f31dcff2b..cb9cef275 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -257,11 +257,35 @@ char *mingw_mktemp(char *template);
 char *mingw_getcwd(char *pointer, int len);
 #define getcwd mingw_getcwd
 
+#ifdef NO_UNSETENV
+#error "NO_UNSETENV is incompatible with the Windows-specific startup code!"
+#endif
+
+/*
+ * We bind *env() routines (even the mingw_ ones) to private mingw_ versions.
+ * These talk to the CRT using UNICODE/wchar_t, but maintain the original
+ * narrow-char API.
+ *
+ * Note that the MSCRT maintains both ANSI (getenv()) and UNICODE (_wgetenv())
+ * routines and stores both versions of each environment variable in parallel
+ * (and secretly updates both when you set one or the other), but it uses CP_ACP
+ * to do the conversion rather than CP_UTF8.
+ *
+ * Since everything in the git code base is UTF8, we define the mingw_ routines
+ * to access the CRT using the UNICODE routines and manually convert them to
+ * UTF8.  This also avoids round-trip problems.
+ *
+ * This also helps with our linkage, since "_wenviron" is publicly exported
+ * from the CRT.  But to access "_environ" we would have to statically link
+ * to the CRT (/MT).
+ *
+ * We require NO_SETENV (and let gitsetenv() call our mingw_putenv).
+ */
+#define getenv       mingw_getenv
+#define putenv       mingw_putenv
+#define unsetenv     mingw_putenv
 char *mingw_getenv(const char *name);
-#define getenv mingw_getenv
-int mingw_putenv(const char *namevalue);
-#define putenv mingw_putenv
-#define unsetenv mingw_putenv
+int   mingw_putenv(const char *name);
 
 int mingw_gethostname(char *host, int namelen);
 #define gethostname mingw_gethostname
-- 
gitgitgadget
