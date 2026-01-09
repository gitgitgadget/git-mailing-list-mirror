Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C95369205
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989132; cv=none; b=cFn5+K2bIEuaWYMxnB/ft/43f4neY6zCxWBk4x6Osz2Mxwf77iValQZck25rsks36fzGE1WVdrQk8HhxpuOqdCw64zH+aZOqLa8aPFqyjHQZXjrP4aUSemx+KhW5BrOHr22y81VyfVRBfp8YBYLN6UULliFcAifcVLpLo7tfpIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989132; c=relaxed/simple;
	bh=/S0Pv8XxmCGF9fYXjAbIV1y4IOvBrLSWbmNjchZF0GE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xq0etTab60BmW2Q4srpGxDIasmrogGyyVd5YtsO+5rJ+IUASMdRlqb5nN2m6PqYuwitJEJMvPpAzB1j3axtvsk2Ud0f4+fo3DpGy201gPVOwmz8Ju45jHJYnvYfjuEp+O80MfYy090H1Y7+IL0z7tuuIzIIah5qUSpG4/HCiiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcyyUc3o; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcyyUc3o"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4fc42188805so48823511cf.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989126; x=1768593926; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKOuzr+obFAbzkb8784gQ/VhOcl/5AcxnPs6E/HucdE=;
        b=FcyyUc3oCWJAgSwLw7jkj2YxKn3+1sldPJVmr22p5dEW5c9bqaOpQ1WP/6OwPep/6P
         qqqbGaBkTRsl30kdaeEYiTwuJ2QCdTTngaxsxXd+qZh3MG0Z0jrwQOk1Tib7OSCKNxhU
         GsU4pDqEdBvTZmoyEDSkfUObsTMLD9dksPOuZmbc2NfnPhiJkPIcCdlGsgsMs/wFmZwa
         LPGUzs4K8SGFkgnq1mKb+vpSmM1VVKHJvN+dTrHO8ZWb/o1BWWwAuwHnbAJyDVgaox8a
         Vm524qQaNchcZmdI+4tNlbzyAx5A8dUuLTXizybIrSj87lMndhVcBhspTwEmkEp86+Vj
         pm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989126; x=1768593926;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKOuzr+obFAbzkb8784gQ/VhOcl/5AcxnPs6E/HucdE=;
        b=CKd7WgPi46e6VQdTvAa73k4Iliop75t0X7r6dDMbytfODUvbjmuuYCrokdKcejLg6u
         Cv1eZVI1MbRA6snCypAdhE/ZPxXtxDXXdT05c4jw8N/kIzBijKIE4p9+22SqgT8P94sL
         9FVE8kQj60aypbkv1TLN+aIDfuRSSfeYVt2tBpit0ionlQMf0lyxWf5GpCXUm71U65i0
         IqFyZg/W9MYQN3S2k6jBxh+fFHm9xI9dAPBa6o9zLTmKEJ9O6fq3ctWu/qiHHaEOaE9B
         +5gy6NDRS2oZRq4XMbupz/OMnozC9Ad4ggDO9A9liku19/hGLKNIBneullrEp7u4mfmA
         F9eQ==
X-Gm-Message-State: AOJu0YzlIJaxB4ZoS8yequdc7+j7/P/RnmzTbJfoy07pUYLXlldO9d0h
	z3radiIMJ7+ObYthCxtDWyjh/eYN350kzC75M3tKgoUeW7UlIawU2+LbZnuNAqKk
X-Gm-Gg: AY/fxX7bGbnTdjoIfT6zZ4Qj4/pvXpl2Znhq41+b8Au0vfvMk97lSz4z7zbtIo2KCcY
	fYGNj9XmoaW6q7VciVqdscH8UjUbeSl527pS6FacIxMGDFPp6i2y+t6ooRgNJVBnTHOSMNDK6fp
	e+O3CYjiHTLiVtlbGDHPFBuNeIMXBY46+53wGI7rx1Nz/XDbH37a/dexFWl1mANdbVbJiE/GeuH
	Vakq2Fh5vyOs56LJJWpKQEM4ObuC0FHp1bLR3jHmW9sMjnMquyUhSMh+FEEGbes0e54PZxR0E9F
	Qmd/ljvG0K6FbfRx9wBP7dkRIxBdkm9xQhLx8Nkru49xrMtYT9arG5LH3khoOwYpzBZjThCfYx6
	cvOxQvfCji0dYP3MoOgUSQwbHxvZv9W8mwlzuhdxc6ERj7EpHlXaFoWB92ZQsh4k1jOSen4YGKG
	ETQznHETOdEpzEysFaRW7PYg8=
X-Google-Smtp-Source: AGHT+IFX4PF0ueYRxqV6Pva524bRSgTAtLeGhg9pVeL9il++Iqabxm+1nSt25GZ5+2XYI0qxRr/MDQ==
X-Received: by 2002:ac8:584e:0:b0:4f1:e3fd:4f0d with SMTP id d75a77b69052e-4ffb4a2b6b6mr155906641cf.75.1767989125534;
        Fri, 09 Jan 2026 12:05:25 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e5d4c8sm74697391cf.28.2026.01.09.12.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:24 -0800 (PST)
Message-Id: <4aeccd6656a106e537bad73c0f1c8c8c2c34992a.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:04 +0000
Subject: [PATCH v2 07/18] mingw: factor out the retry logic
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Karsten Blees <karsten.blees@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Karsten Blees <karsten.blees@gmail.com>

From: Karsten Blees <karsten.blees@gmail.com>

In several places, Git's Windows-specific code follows the pattern where
it tries to perform an operation, and retries several times when that
operation fails, sleeping an increasing amount of time, before finally
giving up and asking the user whether to rety (after, say, closing an
editor that held a handle to a file, preventing the operation from
succeeding).

This logic is a bit hard to use, and inconsistent:
`mingw_unlink()` and `mingw_rmdir()` duplicate the code to retry,
and both of them do so incompletely. They also do not restore `errno` if the
user answers 'no'.

Introduce a `retry_ask_yes_no()` helper function that handles retry with
small delay, asking the user, and restoring `errno`.

Note that in `mingw_unlink()`, we include the `_wchmod()` call in the
retry loop (which may fail if the file is locked exclusively).

In `mingw_rmdir()`, we include special error handling in the retry loop.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 104 ++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 58 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index c7571951dc..26e64c6a5a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -28,8 +28,6 @@
 
 #define HCAST(type, handle) ((type)(intptr_t)handle)
 
-static const int delay[] = { 0, 1, 10, 20, 40 };
-
 void open_in_gdb(void)
 {
 	static struct child_process cp = CHILD_PROCESS_INIT;
@@ -205,15 +203,12 @@ static int read_yes_no_answer(void)
 	return -1;
 }
 
-static int ask_yes_no_if_possible(const char *format, ...)
+static int ask_yes_no_if_possible(const char *format, va_list args)
 {
 	char question[4096];
 	const char *retry_hook;
-	va_list args;
 
-	va_start(args, format);
 	vsnprintf(question, sizeof(question), format, args);
-	va_end(args);
 
 	retry_hook = mingw_getenv("GIT_ASK_YESNO");
 	if (retry_hook) {
@@ -238,6 +233,31 @@ static int ask_yes_no_if_possible(const char *format, ...)
 	}
 }
 
+static int retry_ask_yes_no(int *tries, const char *format, ...)
+{
+	static const int delay[] = { 0, 1, 10, 20, 40 };
+	va_list args;
+	int result, saved_errno = errno;
+
+	if ((*tries) < ARRAY_SIZE(delay)) {
+		/*
+		 * We assume that some other process had the file open at the wrong
+		 * moment and retry. In order to give the other process a higher
+		 * chance to complete its operation, we give up our time slice now.
+		 * If we have to retry again, we do sleep a bit.
+		 */
+		Sleep(delay[*tries]);
+		(*tries)++;
+		return 1;
+	}
+
+	va_start(args, format);
+	result = ask_yes_no_if_possible(format, args);
+	va_end(args);
+	errno = saved_errno;
+	return result;
+}
+
 /* Windows only */
 enum hide_dotfiles_type {
 	HIDE_DOTFILES_FALSE = 0,
@@ -298,7 +318,7 @@ static wchar_t *normalize_ntpath(wchar_t *wbuf)
 
 int mingw_unlink(const char *pathname, int handle_in_use_error)
 {
-	int ret, tries = 0;
+	int tries = 0;
 	wchar_t wpathname[MAX_PATH];
 	if (xutftowcs_path(wpathname, pathname) < 0)
 		return -1;
@@ -306,29 +326,19 @@ int mingw_unlink(const char *pathname, int handle_in_use_error)
 	if (DeleteFileW(wpathname))
 		return 0;
 
-	/* read-only files cannot be removed */
-	_wchmod(wpathname, 0666);
-	while ((ret = _wunlink(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
+	do {
+		/* read-only files cannot be removed */
+		_wchmod(wpathname, 0666);
+		if (!_wunlink(wpathname))
+			return 0;
 		if (!is_file_in_use_error(GetLastError()))
 			break;
 		if (!handle_in_use_error)
-			return ret;
+			return -1;
 
-		/*
-		 * We assume that some other process had the source or
-		 * destination file open at the wrong moment and retry.
-		 * In order to give the other process a higher chance to
-		 * complete its operation, we give up our time slice now.
-		 * If we have to retry again, we do sleep a bit.
-		 */
-		Sleep(delay[tries]);
-		tries++;
-	}
-	while (ret == -1 && is_file_in_use_error(GetLastError()) &&
-	       ask_yes_no_if_possible("Unlink of file '%s' failed. "
-			"Should I try again?", pathname))
-	       ret = _wunlink(wpathname);
-	return ret;
+	} while (retry_ask_yes_no(&tries, "Unlink of file '%s' failed. "
+			"Should I try again?", pathname));
+	return -1;
 }
 
 static int is_dir_empty(const wchar_t *wpath)
@@ -355,7 +365,7 @@ static int is_dir_empty(const wchar_t *wpath)
 
 int mingw_rmdir(const char *pathname)
 {
-	int ret, tries = 0;
+	int tries = 0;
 	wchar_t wpathname[MAX_PATH];
 	struct stat st;
 
@@ -381,7 +391,11 @@ int mingw_rmdir(const char *pathname)
 	if (xutftowcs_path(wpathname, pathname) < 0)
 		return -1;
 
-	while ((ret = _wrmdir(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
+	do {
+		if (!_wrmdir(wpathname)) {
+			invalidate_lstat_cache();
+			return 0;
+		}
 		if (!is_file_in_use_error(GetLastError()))
 			errno = err_win_to_posix(GetLastError());
 		if (errno != EACCES)
@@ -390,23 +404,9 @@ int mingw_rmdir(const char *pathname)
 			errno = ENOTEMPTY;
 			break;
 		}
-		/*
-		 * We assume that some other process had the source or
-		 * destination file open at the wrong moment and retry.
-		 * In order to give the other process a higher chance to
-		 * complete its operation, we give up our time slice now.
-		 * If we have to retry again, we do sleep a bit.
-		 */
-		Sleep(delay[tries]);
-		tries++;
-	}
-	while (ret == -1 && errno == EACCES && is_file_in_use_error(GetLastError()) &&
-	       ask_yes_no_if_possible("Deletion of directory '%s' failed. "
-			"Should I try again?", pathname))
-	       ret = _wrmdir(wpathname);
-	if (!ret)
-		invalidate_lstat_cache();
-	return ret;
+	} while (retry_ask_yes_no(&tries, "Deletion of directory '%s' failed. "
+			"Should I try again?", pathname));
+	return -1;
 }
 
 static inline int needs_hiding(const char *path)
@@ -2384,20 +2384,8 @@ repeat:
 			SetFileAttributesW(wpnew, attrs);
 		}
 	}
-	if (tries < ARRAY_SIZE(delay) && gle == ERROR_ACCESS_DENIED) {
-		/*
-		 * We assume that some other process had the source or
-		 * destination file open at the wrong moment and retry.
-		 * In order to give the other process a higher chance to
-		 * complete its operation, we give up our time slice now.
-		 * If we have to retry again, we do sleep a bit.
-		 */
-		Sleep(delay[tries]);
-		tries++;
-		goto repeat;
-	}
 	if (gle == ERROR_ACCESS_DENIED &&
-	       ask_yes_no_if_possible("Rename from '%s' to '%s' failed. "
+	       retry_ask_yes_no(&tries, "Rename from '%s' to '%s' failed. "
 		       "Should I try again?", pold, pnew))
 		goto repeat;
 
-- 
gitgitgadget

