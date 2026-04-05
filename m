Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203911607A4
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775386456; cv=none; b=PCXvO0p6lFlkzj/RletGN5HM7GBk9VTcdo3cs/1xu+Q54Wr4TDY2krnNISeuQ6yn4hZiNWErops9aBdRucDvrsCxLJ+iyeCa2yk4beUui/3X8+y9BJ1MzP0/MHPcy/ZqnBO2y+9vcYrmLmLIxshbadGYLlffK2KK7lhu3sVob4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775386456; c=relaxed/simple;
	bh=Uxxk2O1gEq6twAtGpVxpSrKebgc47NMp0RjpjjM+0SQ=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=MG7ajpCBhybU/ROuwag6faW8RYpRBs/x4kLbc/AVlqGTe6BHAc1LqFweLx0b25MThrY/lxhsDZ/pDTMyvTaDt4Xa1aRdlnsuDeCEw8uQl/eIUilgZrbvOUL7oEZcxoV4oZHB8uVTgjYYgihv0qcmA6WKr3cIhAyW7a6kvw0QGn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh1AGkUR; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh1AGkUR"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12713e56abdso1005930c88.1
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775386452; x=1775991252; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6LhtyNoGFDI0Hv53V7EvTcyN9Sdy9ilBS++A/M9VQNA=;
        b=Gh1AGkURLcljyflCtQO6hmX04RKBTDUqKzYrHSYbL3wDzu38br2EiFPA48jkeUGY/c
         S12h4t71lo8VFKORS074S3kwCeqKERRWOxb6+FJEbU2mplmJn5Z1pwMzbPkLm+xuFg/h
         6cJXwVnLzS8mduyboDzj2zG52TfQoTIkRdQlpr/v6nx1hH37fFafmDE5IK72Ik87snX+
         0ri6YSsGyClMycXT4XzZV4Y0zOzM+/WP3eLUJBHoyXLzS52LHcQ533y4J+RQYlJyJbbB
         Sb6g8t9hAgVb8wJLgOfpddSUfrKxmUo+aATIpjgLxqbci2P8JtWstgSp+mdashMBud/T
         iIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775386452; x=1775991252;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LhtyNoGFDI0Hv53V7EvTcyN9Sdy9ilBS++A/M9VQNA=;
        b=j7ia7RxgQR/z/zR3EhQAxcx8Nrng2/UYuiLEpzcEUMzOZpjQqUzGSd1cghSo09KH/x
         0y/Xfy5ZCBceK3RUdm1CfUamNdaw9LXWZCfmQ0iXxCwxoTHb7PWcIjsRoZ0dcnbc1gI8
         QonNSMLibZYyZKKYp1NGahVXDd3115jWxCgPhBPfaBMpk/sHNhFGXIAViE7qOgQugQb+
         /a+azpNE7IQL+PaG+4y2pgQSb7x2oYOoWADmTKfs697wVAg5PZKb3nrIuf/omxYHrDy/
         IlZfhDishHN1YogbhF8cQs4bMXoLlaG7qFwVfTdnBB556gWc/uyZPuI/IM6g504Crd0+
         cIrA==
X-Gm-Message-State: AOJu0YxsIsuOoly9PcS4NJcVtBMWYsSCju4AykiAMG8Mnb5u6pJP4EcL
	G5PG0YzZHRdXigO+7gbG3gOjFV8clATJWabZlxrDJypoflntD/FnXh6ydEXEww==
X-Gm-Gg: AeBDiesKN/HQDejo6iTCBLzR0SoQ40pCZ36UYuJOmWsFvonr/LqIjc8kRLwPqys9f6Z
	+64B23NmQsxZk73bjXCmi3Fl+jUH/SWLrBPs4xgOqbqt2MkzfWcV8B2j1wm9cw0OX8PiYq5VReg
	XQLlFyN6yVKXlUGYdrtSOAUujPFJwAcCFz3JOZNaUsNJlJkl8AJp78WdZphyBSIpgixwSpYFgq6
	MpfvBes3btQHtsAJhOLFFGlH35f6lfAGGdJq169HHSpye+weGApQbP3cVqXZJ3S3zcCBAQvffIy
	pjCXur0jAKAHM5rxuFHiKjOx00/oBSemlbCQogZR1Jm0cKII2H6pvw+0Iy6jlY9Q/hwtk68U5DC
	2ZVNtPsJFB/03V+pIuvuDjsZVt7ELWWpEp64fI/Pq9uyHkNYPUfgCj7p+vMwMdciOGVTVdhMg7R
	DEj/iOfQuG/OOYQYI5r/Cjbw01og==
X-Received: by 2002:a05:7022:220b:b0:11e:3e9:3e92 with SMTP id a92af1059eb24-12bf08ba9f5mr4720014c88.23.1775386452506;
        Sun, 05 Apr 2026 03:54:12 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.58.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedd4e4e3sm8305870c88.1.2026.04.05.03.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 03:54:10 -0700 (PDT)
Message-Id: <pull.2081.git.1775386448854.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Apr 2026 10:54:08 +0000
Subject: [PATCH] unify and bump _WIN32_WINNT definition to Windows 8.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

Git for Windows doesn't support anything prior to Windows 8.1 since 2.47.0
and Git followed along with commits like ce6ccba (mingw: drop Windows
7-specific work-around, 2025-08-04).

There is no need to pretend to the compiler that we still support Windows
Vista, just to lock us out of easy access to newer APIs. There is also no
need to have conflicting and unused definitions claiming we support some
versions of Windows XP or even Windows NT 4.0.

Bump all definitions of _WIN32_WINNT to a realistic value of Windows 8.1.
This will also simplify code for a followup commit that will improve cpu
core detection on multi-socket systems.

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    unify and bump _WIN32_WINNT definition to Windows 8.1
    
    A clean-up while preparing for v2.54.0.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2081%2Fdscho%2Fdrop-windows-vista-support-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2081/dscho/drop-windows-vista-support-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2081

 compat/mingw.c              | 2 +-
 compat/nedmalloc/malloc.c.h | 2 +-
 compat/poll/poll.c          | 4 ++--
 compat/posix.h              | 2 +-
 compat/win32/flush.c        | 2 ++
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 338ec3535e..2023c16db6 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2464,7 +2464,7 @@ repeat:
 	if (supports_file_rename_info_ex) {
 		/*
 		 * Our minimum required Windows version is still set to Windows
-		 * Vista. We thus have to declare required infrastructure for
+		 * 8.1. We thus have to declare required infrastructure for
 		 * FileRenameInfoEx ourselves until we bump _WIN32_WINNT to
 		 * 0x0A00. Furthermore, we have to handle cases where the
 		 * FileRenameInfoEx call isn't supported yet.
diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 814845d4b3..e0c567586c 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -500,7 +500,7 @@ MAX_RELEASE_CHECK_RATE   default: 4095 unless not HAVE_MMAP
 #ifdef WIN32
 #define WIN32_LEAN_AND_MEAN
 #ifndef _WIN32_WINNT
-#define _WIN32_WINNT 0x403
+#define _WIN32_WINNT 0x603
 #endif
 #include <windows.h>
 #define HAVE_MMAP 1
diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index a2becd16cd..ea362b4a8e 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -20,7 +20,7 @@
 
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
-/* To bump the minimum Windows version to Windows Vista */
+/* To bump the minimum Windows version to Windows 8.1 */
 #include "git-compat-util.h"
 
 /* Tell gcc not to warn about the (nfd < 0) tests, below.  */
@@ -41,7 +41,7 @@
 #if (defined _WIN32 || defined __WIN32__) && ! defined __CYGWIN__
 # define WIN32_NATIVE
 # if defined (_MSC_VER) && !defined(_WIN32_WINNT)
-#  define _WIN32_WINNT 0x0502
+#  define _WIN32_WINNT 0x0603
 # endif
 # include <winsock2.h>
 # include <windows.h>
diff --git a/compat/posix.h b/compat/posix.h
index 3c611d2736..94699a03fa 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -76,7 +76,7 @@
 
 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
 # if !defined(_WIN32_WINNT)
-#  define _WIN32_WINNT 0x0600
+#  define _WIN32_WINNT 0x0603
 # endif
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
diff --git a/compat/win32/flush.c b/compat/win32/flush.c
index 291f90ea94..7244ff69ac 100644
--- a/compat/win32/flush.c
+++ b/compat/win32/flush.c
@@ -6,7 +6,9 @@ int win32_fsync_no_flush(int fd)
 {
        IO_STATUS_BLOCK io_status;
 
+#ifndef FLUSH_FLAGS_FILE_DATA_ONLY
 #define FLUSH_FLAGS_FILE_DATA_ONLY 1
+#endif
 
        DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NTAPI, NtFlushBuffersFileEx,
 			 HANDLE FileHandle, ULONG Flags, PVOID Parameters, ULONG ParameterSize,

base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
-- 
gitgitgadget
