Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBBB34CFC2
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971693; cv=none; b=kRhdVg9O0uZuTWfm7gkhpMSQbNXuCbB0GHnJOJkcTmOuQTigNuwEWdKNAVnSELfiRsNSLnPjtQ9nMr+xj1bxKRL0VUGQnjnoWbzFjHtZPHcYbWiKHDmXuEyWUAas+K97akCEvoEdmt5OazAulqigNJRtWw0X70M1I3rBGrjOJJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971693; c=relaxed/simple;
	bh=QR6jpUFUAgrY73SoZIFqLLruF2UtfU0tCIiczbKbopY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aU9A5uTSHdAFA4NMO9PM26I8LxO48x8sa4R/Pj0mxfkaTn8pzvJ4zy58Fb8PdY2gVBA43UVjg6KkdMHJx8EQplxk2oeaPMZyIg83257eHW0D2+4925wBQ2AayA6TIiudbr8DXezhdiZyXI2I37xg0IkQAk8Sv/1i/KSm+ZlrVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXyLDzR7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXyLDzR7"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-853e2610bb4so2014401b3a.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2026 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789971691; x=1790576491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4BfgLC2V9+mTvkfzwArtXGD77xJ3OilyvzlZQ5BmmI=;
        b=DXyLDzR70yD5bJSdKCaFXVfbFHzuQiPjOUjTwYNt9/AnmWKjUMY6H5d1sBfmoXHDJC
         XtYXEvmHRT+wJmnSts5Gcp1onCfqCyDIZY23WMcZirXt8gO2icARSXG4EH3FJDZ5fd1j
         kfTywLMgixadQye7G1DeZHU3d55IFmEsiWM2JVgxw4PP4Ae4sayYBL2hMYVMJZLnFuAJ
         7OCECOY5gk27Hxo51pDTPEhqr7vcjHq3MaARXIo0mkeRXPPVNH+FFjRQXzBhQ3nVbn/x
         2LU3d8DLO9CxkWG4DU0LX5iozaRJ0PFk9/8IWQDf/caFsUIlNl+d5lTtjb9BmSvXmYCG
         H9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789971691; x=1790576491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U4BfgLC2V9+mTvkfzwArtXGD77xJ3OilyvzlZQ5BmmI=;
        b=Fp3UMb8xkhYR5dRCwMWjrGkc5Yz4b094Ze98asl3N3ZEOf6SNTRidvCmBaN0GS/NR4
         pCY3vo4V8dNLVcaaGv7D7+rgywnNKXfN2/uF1ZFIpGXifp2+ZxNLM/dpaNrNnDZkR5eZ
         FJEU7xXGsHxxjZEcQT5bg27Sv+5FkemY0RC+fdgGPvI/ul1KDfwFvtpJMTsWAbQtUUgd
         Jab0WdzM+lBAJKAFGEKJd+Hv9TQ1bAY3kcB7iPhQ2lYemsUQ81rLsUX6n+EcPTwQZlGY
         5l/ITFhX3F8DnFLROKkB+T1cNbBrn6t7fTB9pyO13wqTuq27wgX+vXrGimUp0KX+NPgf
         aBBw==
X-Gm-Message-State: AFuF++lp6LTb3UL11qXYN19o1zYYKWLJdK/0kWXglb63WaRllDhiZw05
	3YW+Sh/W7wiHCaz/LGmOZnKpmzBgfM/MIm5I/AjdSSny4CxPZ0wa8r03Ufm01yqE
X-Gm-Gg: AYBFou08RIXuYhw5u+UpDBHGA7m4tnFQb7ZfZ2XKdHx+dZ7T4dLLkeRLH803jAJxBD/
	9mLzrOq+DZ3U5boym5G8fQfdECtbV+WM2pDB/07jxbDDF5bMih3QDCrJEWOU2sNZMaBVJ4L70vJ
	93+JwRWJ8vtfePFjZBklXlcCV2FGTb8jDH2tRPG3BU5XGxKYPq0qfE3h0q6VE62RMwv9aLljlB2
	TKKY5UWHDaCdg3ZvyVWJIGDSIgwp34TrChzQu13J7eH8D0BU5zMjsg2xBgyvgHyQRinMCeIbnvW
	HPYlcZUvoyCYJ60+FS5AtbhI6Die/aCovIACZ+/jrnlRDtai6yTyMEmwDGb1a+sJQML/PH2To5d
	o+B/xFeeBmSIg/D+l1ud6ENT7JPZjIrF6zyMSvYudd2f3cXjHJxpWfAuuVSLZ5cwohRn/e0ZGmi
	1eJV/zYNv+lfd/2K/hadR64cw/xI5Q1qQ/JEKRSytfrtd60MuF9Djflpq0jUYajnsN/Y8m1Ub+4
	i/YaWQmxeHTkdC+a3NjpSD1fueXVGZBH8Q8nNzCgJodUlRNZy006w1CRFKopgAt2OuHi0VTn37k
	eWVm7w1SUi6S8IWMIdMDprhojR7+dCZS480D
X-Received: by 2002:a05:6a00:3983:b0:857:73c3:446a with SMTP id d2e1a72fcca58-873445a3c4dmr16209027b3a.25.1789971691458;
        Sun, 20 Sep 2026 23:21:31 -0700 (PDT)
Received: from MU00187702X.tailf3e3b4.ts.net (n175-33-87-126.meb22.vic.optusnet.com.au. [175.33.87.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa70200esm2658554b3a.61.2026.09.20.23.21.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 23:21:30 -0700 (PDT)
From: Yongqiang Tian <yqtian668@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2] compat/winansi: fix die_lasterr() argument formatting
Date: Mon, 21 Sep 2026 16:20:53 +1000
Message-ID: <20260921062114.14450-1-yqtian668@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260916042312.35891-1-yqtian668@gmail.com>
References: <20260916042312.35891-1-yqtian668@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During WinANSI initialization, duplicate_handle() reports the handle
when DuplicateHandle() fails. die_lasterr() collects the formatting
arguments in a va_list, but passes that va_list to die_errno() as an
ordinary variadic argument. die_errno() consequently formats part of
the va_list representation instead of the supplied handle, producing
an incorrect fatal message.

The helper also converts GetLastError() to errno, losing the exact
Windows error code.

Remove die_lasterr() and report GetLastError() directly at its four
call sites, following the existing Windows diagnostic style. This
passes the handle to the formatter correctly and preserves the Windows
error code. Keep the existing %li representation of the handle.

With MinGW GCC 13, compat/winansi.o builds with DEVELOPER=1 and the
complete git.exe builds and links.

Signed-off-by: Yongqiang Tian <yqtian668@gmail.com>
---

Changes since v1:
- replace die_lasterr() with direct die() calls;
- preserve exact GetLastError() values instead of mapping them to errno;
- follow the existing Windows diagnostic style and retain %li for the
  handle;
- verify compat/winansi.o with DEVELOPER=1 and build and link the
  complete git.exe with MinGW GCC 13.

 compat/winansi.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 3ce1900939..088734a1df 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -436,15 +436,6 @@ static void winansi_exit(void)
 	CloseHandle(hthread);
 }
 
-static void die_lasterr(const char *fmt, ...)
-{
-	va_list params;
-	va_start(params, fmt);
-	errno = err_win_to_posix(GetLastError());
-	die_errno(fmt, params);
-	va_end(params);
-}
-
 #undef dup2
 int winansi_dup2(int oldfd, int newfd)
 {
@@ -462,8 +453,8 @@ static HANDLE duplicate_handle(HANDLE hnd)
 	HANDLE hresult, hproc = GetCurrentProcess();
 	if (!DuplicateHandle(hproc, hnd, hproc, &hresult, 0, TRUE,
 			DUPLICATE_SAME_ACCESS))
-		die_lasterr("DuplicateHandle(%li) failed",
-			(long) (intptr_t) hnd);
+		die("DuplicateHandle(%li) failed: %lu",
+		    (long) (intptr_t) hnd, GetLastError());
 	return hresult;
 }
 
@@ -609,16 +600,16 @@ void winansi_init(void)
 	hwrite = CreateNamedPipeW(name, PIPE_ACCESS_OUTBOUND,
 		PIPE_TYPE_BYTE | PIPE_WAIT, 1, BUFFER_SIZE, 0, 0, NULL);
 	if (hwrite == INVALID_HANDLE_VALUE)
-		die_lasterr("CreateNamedPipe failed");
+		die("CreateNamedPipe failed: %lu", GetLastError());
 
 	hread = CreateFileW(name, GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL);
 	if (hread == INVALID_HANDLE_VALUE)
-		die_lasterr("CreateFile for named pipe failed");
+		die("CreateFile for named pipe failed: %lu", GetLastError());
 
 	/* start console spool thread on the pipe's read end */
 	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
 	if (!hthread)
-		die_lasterr("CreateThread(console_thread) failed");
+		die("CreateThread(console_thread) failed: %lu", GetLastError());
 
 	/* schedule cleanup routine */
 	if (atexit(winansi_exit))
-- 
2.34.1
