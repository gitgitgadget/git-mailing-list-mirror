Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF0B397D32
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980545; cv=none; b=Y51Ihb2Yd7UvgZQRQ0qRdtzfw6V+kHbk9XtMCs7rw4d3fbP+dS1phckCiN4EYwnxNs3+Y2LcK0hR52Xeznnnz7eszJ7X9dzdC+jPa7yPbOUdQVsvRk0ZP5t7oDwuKkmyfP62nqc3zRkMMbzg2qTTGOKC++X8qry1iCsORGlQTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980545; c=relaxed/simple;
	bh=YGTcVB0FrAfvwflHBsKepy8nlJeJBFLgIQ6IAHAJcWg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qxc+pYoqjL5Iv1kwDYMD730jRmaxUNpjkDmW9s85HddugQiupSZBtzOASi4UkVjVKl5KDTGMbXcs8+G0tZJ40rSJk7CCnoEHZp9C+6Vf5yR/WAyFxhI0HOt2G9KbiBEHWyWl5nGdTqOKa78N+tTlzYCWkX0iwdTrlLaD1NcpI+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bN9xOfD9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN9xOfD9"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ed75832448so76393291cf.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980542; x=1766585342; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwpzRPeqgFc+fGqbFZZAt6Eat9T9mc/zwNSuyP8Ynzk=;
        b=bN9xOfD9FFs2DmJvkk14v4DMejiqvor3/BgKS45job9MmTbdDVzdl/MXQfQXQT/odv
         FTvOCjCQEiX9UxfizPlFhcHdIqT3gqIsI7g0Z9y0pOArlDE9v0MwK+u4LAq6H1heSadT
         7WBta7nwXxrbFbs8p6sP1RVQ2i7c5ofZmyGPwE1S1sELZHU/aCKAYgDEXtMf75ucYtRN
         YFGL60YJqQJJHkmzarIeb6hAReS8NpyilDmR+h412lgOCSjKXg+Wz1dr/77E61XiWdHO
         HiKc7dGmwgDWyMjLP55IddnlPPq8+uWzIcwkhfil4M1zxSlnOPPYLAlU4+H5BJPLcAZs
         KF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980542; x=1766585342;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UwpzRPeqgFc+fGqbFZZAt6Eat9T9mc/zwNSuyP8Ynzk=;
        b=ZOSNm29a6PYFBM88fnyh5qXvkXluyc5Lb2TaxOmCi6XwmPr2xmlZYLLp2a6KZ124Ce
         DevfSs88Qg6hVOMOa6HnMHHStRhw+yFPPG2OEYoCRWh+1qjPYNzkU7Yfcw0pvrgGIgi+
         cmS4EnB75NF0WttHFOR5PK97IWlsVcMCJ3W/T7yozEqhs6Hf8CE0XDBfVsGrZYLhlovT
         G+Wz2dzdmPkfdbNQ30igzBgsyN7QxgNj0FgCyYG4rgbPyhousldbyXah+4qeqfdZro/4
         E4PD92r1NdmAkNXX7usLJSHbFkMwgY/e8NG92EFgxOPT1IftqJtG0n8knlFlBM/U+QmY
         cYaQ==
X-Gm-Message-State: AOJu0YzjfwG+PhaQQNCSvhdgLGYUh5GJh8lyW8gzE0KEMor/rwsNLPaI
	ZdZv+CQxs3EjCcduqpuhBqz5BaDBUJ5mbrQ6A4dN9GruEN3t/OiAJah2RCSnFkc1
X-Gm-Gg: AY/fxX4LMnSbrCNRjfmuqnhTx1/hmDesvuSuTaWFG7F/isKE74HVD2TNUKMNAxJu+YE
	NBjE3mlqmJrZL2kSYEdGdguRSXA1HiWplAU+NGL1seFysYjTFUOx0ixerdhShftF9k3nN8Y5T12
	zHqGoAv+pFK2+Mr8qjLZEZtij0gLW8lbjzXUgKz7m7r6zSsydPaS4j7Oq0OLMSnkBbh7fPBOS4d
	YazFE00fOK7OClqW8OXewnZLGPAGaEId2aIUsSZpQlnx/0mv3V7KaG4W533CqC3n5jjzmJgOpIW
	FQg1f3pJ1ttbPlj7iOgiKJqQ5xmOiORa3IOl/0ZiuQLc2h/1p7JGKML8/iBxeJQR8+LG1XbKf8f
	Fu+ICG5K1uQBCnJuv1OAAbYKxXv3ZvWveAi5UWzzQVgXaa/EJUW0FN8J3Xw4eBfr1gJ00Uyydrk
	UaKLVdOOrSIK0=
X-Google-Smtp-Source: AGHT+IHlIg5gz3k8ytCNifNJ5C2PpJqhDp3nAEqeV0znsIMe/x2cG8rI8xwh8fvx9ArmbfsuKtMeDg==
X-Received: by 2002:a05:622a:480e:b0:4ed:dec2:301a with SMTP id d75a77b69052e-4f1d0478283mr271748671cf.16.1765980541748;
        Wed, 17 Dec 2025 06:09:01 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f345c7f82asm34705861cf.35.2025.12.17.06.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:01 -0800 (PST)
Message-Id: <886044373be1bd4d2e7ecf758c42474e9efbe067.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:41 +0000
Subject: [PATCH 04/18] mingw: let `mingw_lstat()` error early upon problems
 with reparse points
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Karsten Blees <blees@dcon.de>

From: Karsten Blees <blees@dcon.de>

When obtaining lstat information for reparse points, we need to call
`FindFirstFile()` in addition to `GetFileInformationEx()` to obtain
the type of the reparse point (symlink, mount point etc.). However,
currently there is no error handling whatsoever if `FindFirstFile()`
fails.

Call `FindFirstFile()` before modifying the `stat *buf` output parameter
and error out if the call fails.

Note: The `FindFirstFile()` return value includes all the data
that we get from `GetFileAttributesEx()`, so we could replace
`GetFileAttributesEx()` with `FindFirstFile()`. We don't do that because
`GetFileAttributesEx()` is about twice as fast for single files. I.e.
we only pay the extra cost of calling `FindFirstFile()` in the rare case
that we encounter a reparse point.

Please also note that the indentation the remaining reparse point
code changed, and hence the best way to look at this diff is with
`--color-moved -w`. That code was _not_ moved because a subsequent
commit will move it to an altogether different function, anyway.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ec6c2801d3..23a926c7d1 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -920,6 +920,7 @@ static int has_valid_directory_prefix(wchar_t *wfilename)
 int mingw_lstat(const char *file_name, struct stat *buf)
 {
 	WIN32_FILE_ATTRIBUTE_DATA fdata;
+	WIN32_FIND_DATAW findbuf = { 0 };
 	wchar_t wfilename[MAX_PATH];
 	int wlen = xutftowcs_path(wfilename, file_name);
 	if (wlen < 0)
@@ -934,6 +935,13 @@ int mingw_lstat(const char *file_name, struct stat *buf)
 	}
 
 	if (GetFileAttributesExW(wfilename, GetFileExInfoStandard, &fdata)) {
+		/* for reparse points, use FindFirstFile to get the reparse tag */
+		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) {
+			HANDLE handle = FindFirstFileW(wfilename, &findbuf);
+			if (handle == INVALID_HANDLE_VALUE)
+				goto error;
+			FindClose(handle);
+		}
 		buf->st_ino = 0;
 		buf->st_gid = 0;
 		buf->st_uid = 0;
@@ -946,20 +954,16 @@ int mingw_lstat(const char *file_name, struct stat *buf)
 		filetime_to_timespec(&(fdata.ftLastWriteTime), &(buf->st_mtim));
 		filetime_to_timespec(&(fdata.ftCreationTime), &(buf->st_ctim));
 		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) {
-			WIN32_FIND_DATAW findbuf;
-			HANDLE handle = FindFirstFileW(wfilename, &findbuf);
-			if (handle != INVALID_HANDLE_VALUE) {
-				if ((findbuf.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) &&
-						(findbuf.dwReserved0 == IO_REPARSE_TAG_SYMLINK)) {
-					buf->st_mode = S_IFLNK | S_IREAD;
-					if (!(findbuf.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
-						buf->st_mode |= S_IWRITE;
-				}
-				FindClose(handle);
+			if ((findbuf.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) &&
+					(findbuf.dwReserved0 == IO_REPARSE_TAG_SYMLINK)) {
+				buf->st_mode = S_IFLNK | S_IREAD;
+				if (!(findbuf.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
+					buf->st_mode |= S_IWRITE;
 			}
 		}
 		return 0;
 	}
+error:
 	switch (GetLastError()) {
 	case ERROR_ACCESS_DENIED:
 	case ERROR_SHARING_VIOLATION:
-- 
gitgitgadget

