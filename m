Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D822C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B68A61357
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbhJDQ7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237889AbhJDQ7n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:59:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE22C061753
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 09:57:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id s24so13980361wmh.4
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fv7nQ5ZUwa4uFFNumJcqLSj/tyOInbTAFP+n8tQn3ko=;
        b=LZ/LYkNqQ3O9dyC60IxG2iRCgYz0XAor8wzW0gw684NiJU6BLyr2b6reyJ1rPO1oMZ
         h+NkFjUrXudHUqBe4SyvepFjIRsQEV9UZT115it8gu4j71ZGdmrmhxkI2KU9WE2Ms9p6
         n4GZfA8oU56mX9pbrF7wxjChX5Af8+8D11vofYdhSVPFOhVyehPLGiKfRIerCmGocQn8
         xv7G7PyPlrtn5tQVGhbBlsKItwPSKuQNK0wLeTYTkExw34rDGAcQ10NmlzF8mpwj1hav
         C09MwzqPWANIl8aCaoXnxupCJW6hyoS9+AL2/d8x3ire3foooHUXyvkMS3bp/v0fcu/G
         O8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fv7nQ5ZUwa4uFFNumJcqLSj/tyOInbTAFP+n8tQn3ko=;
        b=TyLVRqV8Jpe7mNkmoFnEWkcEV64PiuRbNaI6CXRfbkNt7jwKmkbX+njXVBjpKYJd5m
         E+S7POwx8ZyYzg2pDnybko/rdHffamT7qSg+bqN1K8sazpQekNePkL2izA3pWw+OiMt3
         Dm6UTMbg7SjWkObB9fAKONOyM8HVe8Dj3xalK2nFkm8383q7N8Qvdg2ObHCpI5m2gA65
         i9mO4Y60Tb31iEKTt5JoJ27B7BYtPQAgA5sDsFswLrGNJjQJye6URiP5E/PUEz/bySDl
         I49QLfMMXhoqCcbDScQOvPB4X2VO3gRN/pXfZhXlkVyone5Oh6D3w0gfBIXT88bvhRV5
         OEgg==
X-Gm-Message-State: AOAM530U7/15ot5K6xrpjPpZ2hTioJJiDonQ9jZZ3D3xb1f8gIftgzB9
        qn03juzBlRmcMmruCZ/Qhc9e9dlDM88=
X-Google-Smtp-Source: ABdhPJzSvIW+3O+cfFFsf2YkujGCYfKRs9tQ8q3RfyWkBr+rYb9JpMGNsc3kf9RsBP1T8H5BxsNxvw==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr13281615wmj.106.1633366672559;
        Mon, 04 Oct 2021 09:57:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i14sm2110824wmq.29.2021.10.04.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:57:52 -0700 (PDT)
Message-Id: <8df32eaaa9a9c41b6d9d49a50630952f14f33495.1633366667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
References: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
        <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Oct 2021 16:57:43 +0000
Subject: [PATCH v8 5/9] core.fsyncobjectfiles: add windows support for batch
 mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

This commit adds a win32 implementation for fsync_no_flush that is
called git_fsync. The 'NtFlushBuffersFileEx' function being called is
available since Windows 8. If the function is not available, we
return -1 and Git falls back to doing a full fsync.

The operating system is told to flush data only without a hardware
flush primitive. A later full fsync will cause the metadata log
to be flushed and then the disk cache to be flushed on NTFS and
ReFS. Other filesystems will treat this as a full flush operation.

I added a new file here for this system call so as not to conflict with
downstream changes in the git-for-windows repository related to fscache.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 compat/mingw.h                      |  3 +++
 compat/win32/flush.c                | 28 ++++++++++++++++++++++++++++
 config.mak.uname                    |  2 ++
 contrib/buildsystems/CMakeLists.txt |  3 ++-
 wrapper.c                           |  4 ++++
 5 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 compat/win32/flush.c

diff --git a/compat/mingw.h b/compat/mingw.h
index c9a52ad64a6..6074a3d3ced 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -329,6 +329,9 @@ int mingw_getpagesize(void);
 #define getpagesize mingw_getpagesize
 #endif
 
+int win32_fsync_no_flush(int fd);
+#define fsync_no_flush win32_fsync_no_flush
+
 struct rlimit {
 	unsigned int rlim_cur;
 };
diff --git a/compat/win32/flush.c b/compat/win32/flush.c
new file mode 100644
index 00000000000..75324c24ee7
--- /dev/null
+++ b/compat/win32/flush.c
@@ -0,0 +1,28 @@
+#include "../../git-compat-util.h"
+#include <winternl.h>
+#include "lazyload.h"
+
+int win32_fsync_no_flush(int fd)
+{
+       IO_STATUS_BLOCK io_status;
+
+#define FLUSH_FLAGS_FILE_DATA_ONLY 1
+
+       DECLARE_PROC_ADDR(ntdll.dll, NTSTATUS, NtFlushBuffersFileEx,
+			 HANDLE FileHandle, ULONG Flags, PVOID Parameters, ULONG ParameterSize,
+			 PIO_STATUS_BLOCK IoStatusBlock);
+
+       if (!INIT_PROC_ADDR(NtFlushBuffersFileEx)) {
+		errno = ENOSYS;
+		return -1;
+       }
+
+       memset(&io_status, 0, sizeof(io_status));
+       if (NtFlushBuffersFileEx((HANDLE)_get_osfhandle(fd), FLUSH_FLAGS_FILE_DATA_ONLY,
+				NULL, 0, &io_status)) {
+		errno = EINVAL;
+		return -1;
+       }
+
+       return 0;
+}
diff --git a/config.mak.uname b/config.mak.uname
index e6d482fbcc6..34c93314a50 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -451,6 +451,7 @@ endif
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
+		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/trace2_win32_process_info.o \
@@ -626,6 +627,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/trace2_win32_process_info.o \
+		compat/win32/flush.o \
 		compat/win32/path-utils.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 171b4124afe..b573a5ee122 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -261,7 +261,8 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
 				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
 				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET)
-	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
+	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c
+		compat/win32/flush.c compat/win32/path-utils.c
 		compat/win32/pthread.c compat/win32mmap.c compat/win32/syslog.c
 		compat/win32/trace2_win32_process_info.c compat/win32/dirent.c
 		compat/nedmalloc/nedmalloc.c compat/strdup.c)
diff --git a/wrapper.c b/wrapper.c
index bb4f9f043ce..1a1e2fba9c9 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -567,6 +567,10 @@ int git_fsync(int fd, enum fsync_action action)
 						 SYNC_FILE_RANGE_WAIT_AFTER);
 #endif
 
+#ifdef fsync_no_flush
+		return fsync_no_flush(fd);
+#endif
+
 		errno = ENOSYS;
 		return -1;
 
-- 
gitgitgadget

