Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772352EC0A4
	for <git@vger.kernel.org>; Thu,  7 May 2026 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169619; cv=none; b=amhiIB+Y54f8teZuOlBpOqYWU3FFEeY3Ss+pgRwiMicKfS4zuJzBCh3reX7xUkvH+C4NWtVcqZd2hy0imzLVZ9E31my03ffqegjFyxI+vwvJn3A9z3N+BYOwNAfJkZNKdVEJzCLUA0NyDFb6zG2lcZCtrVMx/SeLqA2o//zsMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169619; c=relaxed/simple;
	bh=MKl/LzTA80UjpHrrmDvsKHK4RuRRh3bezc7DrgV9/TM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B0hhUTQvN3GkV4sQ292iKqgMCiBFJl4ynrXCkRa3CtLYzCkdegQ0/GHRhmse3MFnfIb6LzHJBVlBowW57eixkmysbR6HWwjsHdG0KRRHEPsIYFwJ4kK72vZV5hJDqpPcSdKx3/VveiwHWAGPuvV0CokYJWeL1E6TLzE+++GxHBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEZHg2Hn; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEZHg2Hn"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7bdec52f48dso26604577b3.0
        for <git@vger.kernel.org>; Thu, 07 May 2026 09:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169617; x=1778774417; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciW8XeIIqHYQLH6lZNOCRzR6wq0xYJr+A1GrI2jjYjA=;
        b=dEZHg2Hnkj4LwLbJjfOk3xjRsqv9J+3dIRpRcUoeEXRLwotIrLIwtngML7V6rP2rNF
         hKxeoZ0SbfbHnJ3JdNymGkViT2EYKwADim2nDMfN1NHPMTakXajDwUndYSZhqkmvexxH
         FsLnLwXTGZrhsneYlh/QBgwAb/0MD8wbGSz9wwnKj0Ss/xXvYue9W9VZkp4EKCkUx85O
         MXN8PhrD9nUURhlkM6KOFxBQ2usXOPt9LHXhKVhkzlnCqpagLDCxX9dzoV0ql+jKVmRG
         9avb+POqhQwKbwuRYt6Q6x0pyMtnRip9YKTFevQ8bbWMw86uHUN6Ip0399r2ttZl5tti
         CTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169617; x=1778774417;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ciW8XeIIqHYQLH6lZNOCRzR6wq0xYJr+A1GrI2jjYjA=;
        b=IuAcJCg1cfDqBP+EM+JJ8l+Joa9+9KWmvsSQpjTdRsKYYKRBBqa4LAkr9dyK5Ky1fD
         U0BL3WKlsc4NVt9VYQlap+vGQ8ISNcRnM4iJ4mYir0iVI/4exMfSIM+yS+KL06R9ReM8
         eYLOO9KgtG9ul4isT1S7ED8dss3bJL2tqhxXRpNZiIyVl68lt8aSFG/VegcD6W+ccPdn
         x2XQYqV049p/ysV2Qqy3rzxLj6bwZMKEjng7icjELGD8zs2GRBTBGXJTTEOONYipFgWX
         UggjVjqxaHWOERI/R+c2lzIQS46WEasYbcJv9bjsv4Cg7VR3j0R/V76QAN81YjvvrnMA
         +Sbw==
X-Gm-Message-State: AOJu0YyqinZuCwcVATld4Hjya/OhaHN9AEt9wY0Jn99xHQNZwYI4dQxU
	BKuLaf5wST33mqm5uqeNl1zXwPT6/0oYPiJUAvThXM52dByhKPfJaD08FRLB4w==
X-Gm-Gg: Acq92OFVV2MJx6gDZbfpT3OItbjqYQSRQQZ4rP5KNMWdFsbyTZK6IMBP4oH/X+Ia2nl
	6JyEMxDaK7kqloWxn7fzuZknWM0Yhumk2aVAEmHQOn/MnxwXDSX/eRa8xihI3CXqRLboJUb5TnS
	IeNM5a6cs5uGZtKsgXw9uQiGFvfzU2ihleko9Hy85HPgsNQKFI/DGKnsFHINw/CfIo5UxRrxZ1n
	GoMib8ZOs+tjYegYINMWh2FGGBkzn57rDHdzxD8xI7j5rJXCrEVhyTpA9iXp/UQvcbeWjnv0JaF
	57ftM9L1h0v88LTf4MpRHHaHNIth+SUupKl2AhXgcd0PFhQQJQNvisDl/5qjkceahxL1tBQ3ekq
	FwSW7M3Dh/Q6wwGs7ZwO3KKdNJ6hnFYIfsWls5cgM2YD/3q3QltOdOM24gSLsi4lnXn+uW3biIb
	/kpMRqM3j/phGIwCOzYfeRc/KWMFU=
X-Received: by 2002:a05:690c:e3ed:b0:7ba:f0ed:c5d9 with SMTP id 00721157ae682-7bf04c303f2mr28340897b3.14.1778169616601;
        Thu, 07 May 2026 09:00:16 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.176.153])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66891246sm94870417b3.46.2026.05.07.09.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:00:15 -0700 (PDT)
Message-Id: <d547877ae3efe0fc27af44819e19da863559540f.1778169613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2104.v2.git.1778169613.gitgitgadget@gmail.com>
References: <pull.2104.git.1777811392756.gitgitgadget@gmail.com>
	<pull.2104.v2.git.1778169613.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 07 May 2026 16:00:08 +0000
Subject: [PATCH v2 1/6] mingw: stop using nedmalloc
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

The vendored nedmalloc allocator under compat/nedmalloc/ has been
unmaintained upstream for a very long time: the original repository at
https://github.com/ned14/nedmalloc received its last commit on July 5,
2014, and was archived (made read-only) by its owner on March 15, 2019.
Our copy has been carried forward unchanged ever since.

The Git for Windows commit that introduced mimalloc as a replacement
on Windows ("mingw: use mimalloc", 2019-06-24, present in the Git for
Windows branch thicket but not upstream) already observed at that time
that nedmalloc had ceased to see any updates for several years.

This came to a head when the Git for Windows SDK upgraded to GCC 16:
the `add_segment()` function in `compat/nedmalloc/malloc.c.h` declares
`int nfences = 0` and only references it inside an `assert()`, which
GCC 16 now flags as `-Wunused-but-set-variable`. Combined with the
`-Werror` enabled by `DEVELOPER=1`, this turns into a hard build
failure:

	compat/nedmalloc/malloc.c.h: In function 'add_segment':
	compat/nedmalloc/malloc.c.h:3897:7: error: variable 'nfences' set but not used [-Werror=unused-but-set-variable=]
	 3897 |   int nfences = 0;
	      |       ^~~~~~~
	cc1.exe: all warnings being treated as errors

The same source built without complaint under GCC 15.2.0; the
regression was bisected to the SDK package update at
https://github.com/git-for-windows/git-sdk-64/commit/188d93dd455
(`mingw-w64-x86_64-gcc 15.2.0-14 -> 16.1.0-1`), with the failing CI
run captured at
https://github.com/git-for-windows/git-sdk-64/actions/runs/25244795074.

Rather than patch the unmaintained vendored sources to silence the
warning, stop opting into nedmalloc altogether on Windows. The
platform allocator is what every non-MINGW build already uses, and a
fresh build of git.git's master against a minimal Git for Windows SDK
upgraded to GCC 16 completes successfully.

The compat/nedmalloc/ subtree itself is removed by subsequent commits
in this series.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname                    | 3 ---
 contrib/buildsystems/CMakeLists.txt | 3 +--
 meson.build                         | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 5feb582558..3636b98238 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -758,9 +758,6 @@ ifeq ($(uname_S),MINGW)
 	HAVE_LIBCHARSET_H = YesPlease
 	USE_GETTEXT_SCHEME = fallthrough
 	USE_LIBPCRE = YesPlease
-        ifneq (CLANGARM64,$(MSYSTEM))
-		USE_NED_ALLOCATOR = YesPlease
-        endif
         ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
 		# Move system config into top-level /etc/
 		ETC_GITCONFIG = ../etc/gitconfig
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 81b4306e72..9d6b98ecb6 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -255,7 +255,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
-				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
+				OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
 				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
 	list(APPEND compat_SOURCES
 		compat/mingw.c
@@ -267,7 +267,6 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 		compat/win32/syslog.c
 		compat/win32/trace2_win32_process_info.c
 		compat/win32/dirent.c
-		compat/nedmalloc/nedmalloc.c
 		compat/strdup.c)
 	set(NO_UNIX_SOCKETS 1)
 
diff --git a/meson.build b/meson.build
index 11488623bf..e896bc15a1 100644
--- a/meson.build
+++ b/meson.build
@@ -1285,7 +1285,6 @@ elif host_machine.system() == 'windows'
     'compat/win32/pthread.c',
     'compat/win32/syslog.c',
     'compat/win32mmap.c',
-    'compat/nedmalloc/nedmalloc.c',
   ]
 
   libgit_c_args += [
-- 
gitgitgadget

