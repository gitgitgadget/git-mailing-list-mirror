Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0836827A
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989125; cv=none; b=HrST9LJDCZDR7jUAbmY3sxnWZrMDc8+MkWz7TpHrQepF+fW0xu79o5tLWyinte1HVqAXzuOrwni0X+hOiNWkdIzeg4u97DQppzBrRsyE3yoytxcTjtQghZ19DX0siGZbFNBNGV47Zgd1xnOgRJomBOsxfcv4fjz21NrhfNC6Xwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989125; c=relaxed/simple;
	bh=8zlMMqjZj6FRgrd8+f9QW06laXuGqjrnsi9RhrPiKu4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QclfcSstLbbvy+lzVUbOwi+eUDB9wmcIGTBY9k6OHBT6bEeSQ//e7BxRQQQJqIMWKtZ/cGKWdWrdELZoRqLdWtpzZYQyHi0V3loPz3r8Tw5HYW8p30uvCVb+VKJeeYq0CzbhvrjcuG5FFrRZRG9sQ7WoLPloHBE+ZjZ1bfcqonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eb721ydt; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb721ydt"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-122008d4054so1341365c88.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989123; x=1768593923; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MXxD+bf+4aEQPd5WanLwsiL+2CbU/CfZ/IMVsa7vYk=;
        b=eb721ydtYg/FOVYx3FklmEESAtg4pkH1UxWNtg4Za94SNDgHY38erANcaF4sED6KV2
         qTjrm6bKcac1JGkyQImCgGeCNUxfEWRjCrofOHjtBGbI+S5vo3YChAy2M5ITX0E4Y2ec
         mt7F1Oz0winvRu/oVFn9EvoYQS7Gh4ipO0NlKPf7aiY91mL0m51gnokx+BrwHditE27w
         QfpWzraaJxKiuT3DCQXUXBQTbc8pd5kAwNVohqcjPcrikdHW44Q040FtyU43mRu+7xvC
         3YwY0BD0LYxpSXQL02lV9ld1XnamgwL6JjCbVqOQgr2lshBkNOJSZfX6HnPIWwunWOLR
         q14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989123; x=1768593923;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2MXxD+bf+4aEQPd5WanLwsiL+2CbU/CfZ/IMVsa7vYk=;
        b=kIcVesSqKrzBMn447RDBeSxISPq6Bkkasik50c3J/fj1KeVyy11Wim8OCiJ7yVvBTQ
         BkEFaF9jSSAa745luHDPmyX+n9Y/BQn1qX6gGQn4W26jbA3kTyq6b2S+Ozjx6NA05wT4
         aMB0sBw0PpzUhl1KcWUPwi2N2N33S+yeNO7g//ndlQbiDaiYpCuzaSkqVKNCZIf80KSt
         QpZPzoNwe4osRHxoziOUuWdlV+sryblpK9QrK9/bvS0m6u0amIY6OQJJoLhP56jW3Tbp
         1N9JYXtQI2L7azHn11S8aq+QGbakEdJqp5eN/q5GX0eN+0MhA/ZKNv1qV6H7nYZ3ODk1
         coLw==
X-Gm-Message-State: AOJu0Yz42gqAQDejvX1mA4tzZ6X62Qco2zsUtrQs8uDMK0SUV35V9gS4
	RlAntpiERRAudIarisTyCQi50gC20wuFboxs2sdPUsPHJuOdghwyPR9XA/36uw==
X-Gm-Gg: AY/fxX7fyfAPfJAt6somwwY1NMywYxaWjNSXRViJZsWS+RJGYr7mb7TaH+WcRkxupsn
	MFNxXoURk/50MRzOEeyWfhy9AbNpxD4SNY72SANpj0SfnxlOX4zX9dde9pze662qdf88p3Amq0J
	vqulB5TqhOm2hmyfPrIUAdJ1ASpp3qR3D66fvmiDxmnlPeig8otlJGUGVFy7hN3lEtHudpx9+pH
	zrB7mfj6TLY4paZ4FNMUH8CQ2XrC+eQ2U4rU+M02C+o2cDq45nl4sFAt8eWZQPuGH3J6MIBGLQL
	r20qdy8PUx2btE2+kFCgFSwom+E7Y1bZwrAhIzCKylQAIIlRmvovnFx120Y8p5WUipoelkhsD9p
	R8bSl6R7H3iqDO/6zwcxAUbXQFjJzVWFx6KQ+NnfMB7zICPaA4RQHrjFZVX1LMcoHLxQRDaJ3Xs
	fVzXAvxiEpEUExUg+V44kE3o+F+w==
X-Google-Smtp-Source: AGHT+IHPfbgYjAFw9QlwOrERppvbnx3Hnk0GyYGbJe44OGNAjV3uVg2KZE2g8WSr5WS/knEctRTHhg==
X-Received: by 2002:a05:7022:6620:b0:11e:3e9:3e91 with SMTP id a92af1059eb24-121f866f870mr9793193c88.26.1767989122376;
        Fri, 09 Jan 2026 12:05:22 -0800 (PST)
Received: from [127.0.0.1] ([172.184.211.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243ed62sm18425047c88.5.2026.01.09.12.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:21 -0800 (PST)
Message-Id: <eb95a74d6eb2198620d44f2877519a1a7ffef6d8.1767989109.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
	<pull.2017.v2.git.1767989109.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:05 +0000
Subject: [PATCH v2 1/5] mingw: do resolve symlinks in `getcwd()`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As pointed out in https://github.com/git-for-windows/git/issues/1676,
the `git rev-parse --is-inside-work-tree` command currently fails when
the current directory's path contains symbolic links.

The underlying reason for this bug is that `getcwd()` is supposed to
resolve symbolic links, but our `mingw_getcwd()` implementation did not.

We do have all the building blocks for that, though: the
`GetFinalPathByHandleW()` function will resolve symbolic links. However,
we only called that function if `GetLongPathNameW()` failed, for
historical reasons: the latter function was supported for a long time,
but the former API function was introduced only with Windows Vista, and
we used to support also Windows XP. With that support having been
dropped, we are free to call the symbolic link-resolving function right
away.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ba1b7b6dd1..7215b127cc 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1251,18 +1251,16 @@ char *mingw_getcwd(char *pointer, int len)
 {
 	wchar_t cwd[MAX_PATH], wpointer[MAX_PATH];
 	DWORD ret = GetCurrentDirectoryW(ARRAY_SIZE(cwd), cwd);
+	HANDLE hnd;
 
 	if (!ret || ret >= ARRAY_SIZE(cwd)) {
 		errno = ret ? ENAMETOOLONG : err_win_to_posix(GetLastError());
 		return NULL;
 	}
-	ret = GetLongPathNameW(cwd, wpointer, ARRAY_SIZE(wpointer));
-	if (!ret && GetLastError() == ERROR_ACCESS_DENIED) {
-		HANDLE hnd = CreateFileW(cwd, 0,
-			FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
-			OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
-		if (hnd == INVALID_HANDLE_VALUE)
-			return NULL;
+	hnd = CreateFileW(cwd, 0,
+			  FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
+			  OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
+	if (hnd != INVALID_HANDLE_VALUE) {
 		ret = GetFinalPathNameByHandleW(hnd, wpointer, ARRAY_SIZE(wpointer), 0);
 		CloseHandle(hnd);
 		if (!ret || ret >= ARRAY_SIZE(wpointer))
@@ -1271,13 +1269,11 @@ char *mingw_getcwd(char *pointer, int len)
 			return NULL;
 		return pointer;
 	}
-	if (!ret || ret >= ARRAY_SIZE(wpointer))
-		return NULL;
-	if (GetFileAttributesW(wpointer) == INVALID_FILE_ATTRIBUTES) {
+	if (GetFileAttributesW(cwd) == INVALID_FILE_ATTRIBUTES) {
 		errno = ENOENT;
 		return NULL;
 	}
-	if (xwcstoutf(pointer, wpointer, len) < 0)
+	if (xwcstoutf(pointer, cwd, len) < 0)
 		return NULL;
 	convert_slashes(pointer);
 	return pointer;
-- 
gitgitgadget

