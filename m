Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CDB3090D7
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775454336; cv=none; b=JCqzLgg+waYRFO6acXf5fz2qBCtkl4E4qxA8qn8+tzQFC6/LNvBgvt8l2Ul+OTiRsAb6LMy8702RSMcD176OO7GyddSqsPyVfIuXFJ1a4o4aOJG44vdHa3Y2QgOjy6IkmLecFjp4Nrq69UaanjWWZpl/isAZfxdQ2mWOz5qzMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775454336; c=relaxed/simple;
	bh=EjXMnB36E6CvpHaSicKNy5mADUZO5/vNoeKm7ZHArGE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=DcthnwWa1tKJWJ30+B0WsE3MMDPrXfYQS20egvcRxloQaEcqCan3O7LUcpaEBohgRS214xPsphVgAtm643GKki7IM+Yu35ra66nC4I9h7u+dKGtSAitrTgxTUZ8ffoBNHEjx7l1Z7UMNyyRWLstFkQ6K4REdPzC6Ah+Xwx5R6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxAH5Ngx; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxAH5Ngx"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a05c388b27so74714586d6.3
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 22:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775454334; x=1776059134; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBtG+qxacYM/C6vOSTPXDVTNGPkcm+oD/59K0C1GTfs=;
        b=fxAH5NgxrAq1FUXlyJ8C651ORyTiqgm29A2yR2RlPZm5G7hfZ+YAGO+myFZf3MRzLQ
         Aa7hTan2dHeUp5jDb7qOn+KPnWG+gV8DK0C9zzK7EWg+GTsToIGO3NX4yya3pVNxmfN3
         f2SXWseQUYdSOptnv9gOp499G6d5v18+VseVtWZ0hsVg5p+vVSjrCcPboR6EUBJzgZ4N
         fngNv5Rpvptmov5YRSf5urJXStbPq8JtUFDW6KqTOOJo1VKc6nrwAUom4+33Y0/8iuBk
         /S6w9qzf+4K3YXsn33Uhk3d4nAWKTWabhTJ9IA6ktdTUBs8sGURiUOWUsxDn7jwIqAFY
         tgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775454334; x=1776059134;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mBtG+qxacYM/C6vOSTPXDVTNGPkcm+oD/59K0C1GTfs=;
        b=bpg6CclCRJy/qBiH5+dhFkfPsqmNVXa265FAwlzKsHvlXpmQGOIb+NMvKWNFpbCFFg
         3MXL5sYxE73GUnctWZ9a3Dmg8rElW8pG42LrnKnqdPlM3nQmAKK9C7DQ5uoh4GTDiRFC
         3K+htyDkLfdSu8LzUGq6dCgQL8jcPfG1nKVN/MPWxvOGzGzURLQx4Zz6QgvsKFiSsOM/
         xmkUVVh6IYS0/4+NWiN+aza049lZ2QTPXrW2d6xSk3YYPQBQ1KjxX9pUzwYKdmieZD7i
         y3/QZZXEKNiaHrDd/ML/miH6GHKJb7NLhPw6cb6M/k/PJSQ6WpaepRdo/oe8RtFup8H7
         pl4A==
X-Gm-Message-State: AOJu0Yz2I+b3TZDAn6z6q0imvEfUTfUPC0jckMgq46JKe+N21H1wexuY
	F9BvGvNlsh5cjsS4ORMUUahLHRUakE6nhD1y8XEgCGXZf+nh/N9nxBMcqq6fuw==
X-Gm-Gg: AeBDiev6T5cpM0BZvH3iKQycfagkTK7La6ES07EFZ6ohpydcROWfLaJr/y3StQKr2QW
	pVUMUGylPaaEsRn7WyRG5tPDouA1bA+uLGU2HrcR36cVeP82PMCdPNhFz6utRrNh9cMYVuBFT9c
	wawY2ExWxT3517IFgMyu7cbVZwdjUTOm8A+3d3idmnUhL3cHvKxTvgYWOks5vRR8zZI+pRg7mfv
	T9tuWcOqBaQAdeepf0JrFmj304w5oaa7C72K6efRx75d3yOKMVF9P0PI14BHTvLSBDTTleEXtLP
	EujE9jc+0aLRxpqTFnsBf14lG7arYjljEEUQ+yNL7JWYvdLAqYPCCgRaEOnajy06+Fs32PAxLYc
	Kd7alzyy3rg51ETE1OjEHdnWGkxkbS9N4nysIpojeWROlfToJlYqVcAlMvt2tf2vybLfIXFQz3s
	UQwEQZNVHUShpr/y0IKGANrbKbHas=
X-Received: by 2002:a05:6214:260b:b0:89c:8669:18a5 with SMTP id 6a1803df08f44-8a704bb73f1mr201027336d6.50.1775454334038;
        Sun, 05 Apr 2026 22:45:34 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.198])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5974dda27sm112744006d6.42.2026.04.05.22.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 22:45:32 -0700 (PDT)
Message-Id: <949696de7ac069cc98fd6f0d06507635bda7ede6.1775454330.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2081.v2.git.1775454330.gitgitgadget@gmail.com>
References: <pull.2081.git.1775386448854.gitgitgadget@gmail.com>
	<pull.2081.v2.git.1775454330.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 05:45:29 +0000
Subject: [PATCH v2 1/2] unify and bump _WIN32_WINNT definition to Windows 8.1
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
-- 
gitgitgadget

