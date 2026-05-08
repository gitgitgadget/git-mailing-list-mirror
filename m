Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A453397E75
	for <git@vger.kernel.org>; Fri,  8 May 2026 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244668; cv=none; b=Gl/V4b2LVDRwy8W5tgnq9tgefUMQAAzxEdERDA0jM6GyfRfiI+rhz9d95vy9hv0Y70KHIUpIRpuH9yey1CrWNwSV4nMAgeGk4xkVG18HhdG3eP+Qty1hI4KfkfCyMb2Igr97B9+e5oRDCcxBV8wnn7i2nouOjvogGJA+O7yeO/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244668; c=relaxed/simple;
	bh=MKl/LzTA80UjpHrrmDvsKHK4RuRRh3bezc7DrgV9/TM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e9YW8IZ9XIiVZntFCXw6JWFmCaPwn4tB94A4eBhR9bEggBfskzG+fY0DhNJZiMkeSwdLwdluzCyatMHIjO3Qp2e9cjUEfvVMk37D5YYl5jq1/bhABgEML9TDFZrQawtQV+3kTRKjfuUN395S2bkmUXYPI/8XXQDW6KUhVggfHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJVKo2q2; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJVKo2q2"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ef5776530bso191368685a.0
        for <git@vger.kernel.org>; Fri, 08 May 2026 05:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778244666; x=1778849466; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciW8XeIIqHYQLH6lZNOCRzR6wq0xYJr+A1GrI2jjYjA=;
        b=NJVKo2q2ndpWdNsP8vvtwqugfVcgUfwpCoPSBVPDcJuNOwmBmstxXLew3zg9f9jp+0
         /3640/6A7GVQzRhlY2t3Jo4+zp09qh/5pUzBlQNdHxLoTOOvTGgkaohEc2KmVy30op8p
         QvDrG0VVdyI0BdcYRZAJSJlACNB23ndCrTKFiZD4mmPHacAuxOkfjxymlnv3ZI8jZS35
         csDNnx1GdykHF0oxHuoNLQbAaim8SI3ks3LPUqvWZNH87NgKsJ/qtp+54p/PF3Z6h+Mm
         xuXz3lmTSq86d90Zq/HAUI+ORZ5/Zd8vuYRoIEQrN6GX78BHAGuhCAlyR3gbUe7wJ8RL
         auYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244666; x=1778849466;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ciW8XeIIqHYQLH6lZNOCRzR6wq0xYJr+A1GrI2jjYjA=;
        b=N+OUYfZPaZvl/TwLAXDd+8I7NynubVkwcjAauUfTJzV6jiehhAcugkDUetKyoozSBX
         E3KGq5RcQIOgez19fMpSvyZJmcuSnK+tsZVtMgMDbiTkkIczXl6TPHkj7i1L+m3F4HxX
         oVBrt8tRZh9MginlfVJGUxsGNC1r7wZmrxV3JgViv/uk88NfM9yEpO9v6RdUWGythT4r
         +7uGXB0SFnih2X1b8eS4G/ZNyG1jgTESj+jALHYhVITDeH4R4o7LLzNndx8g/yf0/K3q
         TKDiO0GGmyQrX92zG1p40ypvFYoYZ4UuWd+jQ3y4onD1oL5CMLRNDSCna/BGrptJMJJL
         urhw==
X-Gm-Message-State: AOJu0YyMv6De04Qrxw8l2ozOVyMHVXuxrONWE+1esbFh2Qhv2mmPNH2v
	965IHDkJUtgP48BxOfCl14u+Xvf/w7rk8acu95JiH+OlG5NbTIVQBsQ/qsNrjQ==
X-Gm-Gg: AeBDievCefjQFCe+fBI+/ncel4o2dIdeBnJJTWwVCkChVl6u/ix097OVWd21yPnD/ld
	gO2aL/FZXwK6sHFPXz77j+LneBtrAA/9hDaE3nyrydEPtTvFnMnqWl4gKvUXEveA+QxB5sQpJIB
	DLnNMHaUJ42JeDKd9E+aH4DRoO8Ha0Tm22UOSSxxzngfCCNeYR5eMa2W2+E2AVZUiEyByHNO69f
	kYtsysnDYQDxoH01imaDXkad1zXdMLU40kXakJ2DrTRXR0lrvmNkTfZvxTe4GieGdY1hZ2UbzoM
	U1gaxUCDX68KVN5YvZ4gVUneeUyfPK2iTVfIe1jy3wUecgYIPoi074/dngUbmDC2rPKNB5oZsMj
	D0EC/T211myhPnpAPR65odV2AXxraIVI/XSeFQDIkwPBvzDSthHnqje0knVlW2RNPVB8dReUz1C
	mfOO2o8ks4nY+eknTGAsHqpgZg9vVVQm4/qinju+g=
X-Received: by 2002:a05:620a:2699:b0:8fb:1acb:c907 with SMTP id af79cd13be357-904d3cb86a1mr1819896785a.12.1778244665509;
        Fri, 08 May 2026 05:51:05 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.176.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91b976sm2280035085a.39.2026.05.08.05.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:51:04 -0700 (PDT)
Message-Id: <d547877ae3efe0fc27af44819e19da863559540f.1778244661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2104.v3.git.1778244661.gitgitgadget@gmail.com>
References: <pull.2104.v2.git.1778169613.gitgitgadget@gmail.com>
	<pull.2104.v3.git.1778244661.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 12:50:56 +0000
Subject: [PATCH v3 1/6] mingw: stop using nedmalloc
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

