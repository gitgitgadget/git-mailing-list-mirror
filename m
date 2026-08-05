Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB7388382
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940022; cv=none; b=DxPGXvaXNXIBinXUN+RKfW+Hpd8sBml0fg5lfxZeSFA+p+nK2VUnq7SnQIh5VO64Vsl5w3hNY5vqc5+PGb65ySrwKOe7CtRR5rAc43cyaL61FDqo+h1lA5J5r9UmN4RAgc8GID1P/umlVg94AtDXiqfF+1j+inNvTPcxVyMNr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940022; c=relaxed/simple;
	bh=wqVy581eHaomChLx3smLXz52HSrB5qQbeGjYp5NLg+g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Vx3PKN3wSTkYTU4TRGwIpwpMpY2Omm6J84CkOGOwjpXxnQga/1oRFVygYq+DboWCNOXmn8jc1A9MR1/QWGXB7vCn5SHA40Dl9sXNHWnQpYEIQ34GZT289uCar5VmiyuKQioJBlI5Q8s4KSJ+dUpIPe+OE6dOBNH8hxC8l7MpcMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWUtrOFm; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWUtrOFm"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-902fc790cd5so6472646d6.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940015; x=1786544815; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3ML1yiUPOVtYcs4oHR/KMvq52L6Y4JD789Ox32l02VQ=;
        b=oWUtrOFmYnRjIoXLAQwT0Jz9CzxF6nUYkP9CAB5AYqG5q3KzGA0JgKecFXxV0+lxhk
         yFrm6i25iVYHGu7JmZB4H8XDJSVFzfcxWROEVpaDhgnnUmDdhDgGORciXYE38UlUBLtt
         PbeW5t+txvCXYfC6JbO0wdriMcmBUeUCwj/g9y0e0mjeK0ppEK9AYNP+Wuy7u6Z/cKUX
         3XYYkGP8VNBLAlKkgGrrpZSOrLsZkGRKyqrj94mhWjyn0vsQpPiGocEqU8Jr3iV2lT0u
         mI7BgWAemLVSXwhfPvPP5lB7lKgAAdgs5GzBWtvr7qfv5PA6se3z0u2UFoPHOhGeYe//
         Rwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940015; x=1786544815;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ML1yiUPOVtYcs4oHR/KMvq52L6Y4JD789Ox32l02VQ=;
        b=YeR6ZqQuD2Qka+GVZqUN1cgDIWs6gbGwhVFFLIh9xyS+u4Zwlb2TprB6y6Wupn/ln8
         DR3EDIhfl+jMOjh2EQ4m5+Ex6TJHN62fAmrsRREB1rV+ZQ4oWZ2tx4qFbyn9nPfgcau/
         iMi9CbqfBFTjJDxu7H+x/wj9H9JabrTurSvnDaAdJFKpfRLjP97fzZHhwkO0XJ4pRO3a
         SLew72AhhiijBvUcmGluY+KXXyBM4jUUuPyXEZ40ZqrFy42q7VCXUOffDeeFL3j7ps/k
         YRoeXiK8bxFml5JsYSu7hS9NH5i/F0xeRMOAgCgPo2L6rZMdP6nHIyjC2YAAERiwyrN4
         CyMg==
X-Gm-Message-State: AOJu0YzgyHwxYwLYtt7eYZT+EbEu1VuzfSnGnh0DSPshaCRHYOVWcPhQ
	DKG5YfcDclCw0WnbTooQrdWyZ4YKPpD/9n7EPhDfdXJiTD1TqXl2briM9XjpDg==
X-Gm-Gg: AR+sD13yzCUBQze3rJFQ7nLVoBfWOiVLOLhOLsCMSdHv/Y7PclDosXK9yUWnjDFsJ1v
	u8kcGnmQ6wAgikEVMji720rnPcc1w83xdmh7X+eyOqNgvFDqfl0aTHcx6zaQvVdm64QHsklQ35B
	pvVLKH6nix7xqscd+tXFMD2SmH7m64g7ZHDmUzy8wlfuHT/QNXLuJn1HbHCsOjmPzNmWhBjQdiN
	/cF51M5imPZ+XgQE1U5cCXSt3fzyLM4GgDnQYMbL+/5vYkETanULuUQJ171i5wUYGpFxbZkqPIX
	xjpxkgpv1EiYB0FOLkV4CZW2MNHluzziHgZIMlgjoLCQnXXUuWIe0Z5luldefnrGnxXJV7b/jzY
	q7FCb2Goq8CGtBSKt8VnBWDAaWnGMSeQdlBlr7Rw71o5G4jwID93ycmgTifM3fFex43W7m3c6FD
	MxaN/pQ0eqD/UzN5WcPH710w0ADWJcwdqpP3bz/2q25jWDMM6Q+YfENtyr1qU2B9g=
X-Received: by 2002:a05:6214:1cc1:b0:907:5516:3d61 with SMTP id 6a1803df08f44-90881260b5fmr83155656d6.21.1785940014830;
        Wed, 05 Aug 2026 07:26:54 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ffda379sm26556176d6.20.2026.08.05.07.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:26:54 -0700 (PDT)
Message-Id: <1593d1d1a0dceb58640cfa56b49bf30d8a2c6365.1785939999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:26:34 +0000
Subject: [PATCH 08/12] mingw: rely on MSYS2's metadata instead of hard-coding
 it
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

MSYS2 defines some helpful environment variables, e.g. `MSYSTEM`. There
is code in Git for Windows to ensure that that `MSYSTEM` variable is
set, hard-coding a default.

However, the existing solution jumps through hoops to reconstruct the
proper default, and is even incomplete doing so, as we found out when we
extended it to support CLANGARM64.

This is absolutely unnecessary because there is already a perfectly
valid `MSYSTEM` value we can use at build time. This is even true when
building the MINGW32 variant on a MINGW64 system because `makepkg-mingw`
will override the `MSYSTEM` value as per the `MINGW_ARCH` array.

The same is equally true for the `/mingw64`, `/mingw32` and
`/clangarm64` prefix: those values are already available via the
`MINGW_PREFIX` environment variable, and we just need to pass that
setting through.

Only when `MINGW_PREFIX` is not set (as is the case in Git for Windows'
minimal SDK, where only `MSYSTEM` is guaranteed to be set correctly), we
use as fall-back the top-level directory whose name is the down-cased
value of the `MSYSTEM` variable.

Incidentally, this also broadens the support to all the configurations
supported by the MSYS2 project, i.e. clang64 & ucrt64, too.

Note: This keeps the same, hard-coded MSYSTEM platform support for CMake
as before, but drops it for Meson (because it is unclear how Meson could
do this in a more flexible manner).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname                    | 14 ++++++--------
 contrib/buildsystems/CMakeLists.txt |  9 ++++++++-
 meson.build                         | 13 ++++++++++++-
 meson_options.txt                   |  4 ++++
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 21f53e3f7e..3a90995587 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -465,14 +465,8 @@ ifeq ($(uname_S),Windows)
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
 	# Assume that this is built in Git for Windows' SDK
-        ifeq (MINGW32,$(MSYSTEM))
-		prefix = /mingw32
-        else
-                ifeq (CLANGARM64,$(MSYSTEM))
-			prefix = /clangarm64
-                else
-			prefix = /mingw64
-                endif
+        ifneq (,$(MSYSTEM))
+		prefix = $(MINGW_PREFIX)
         endif
 	# Prepend MSVC 64-bit tool-chain to PATH.
 	#
@@ -755,6 +749,10 @@ ifeq ($(uname_S),MINGW)
 		BASIC_LDFLAGS += -Wl,--dynamicbase
         endif
         ifneq (,$(MSYSTEM))
+                ifeq ($(MINGW_PREFIX),$(filter-out /%,$(MINGW_PREFIX)))
+			# Override if empty or does not start with a slash
+			MINGW_PREFIX := /$(shell echo '$(MSYSTEM)' | tr A-Z a-z)
+                endif
 		prefix = $(MINGW_PREFIX)
 		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
 		BASIC_LDFLAGS += -Wl,--pic-executable
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index a57c4b464f..7285bd9ac2 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -256,7 +256,14 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
 				OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
-				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
+				HAVE_WPGMPTR HAVE_RTLGENRANDOM)
+	if(CMAKE_GENERATOR_PLATFORM STREQUAL "x64")
+		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="MINGW64" MINGW_PREFIX="mingw64")
+	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "arm64")
+		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="CLANGARM64" MINGW_PREFIX="clangarm64")
+	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "x86")
+		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="MINGW32" MINGW_PREFIX="mingw32")
+	endif()
 	list(APPEND compat_SOURCES
 		compat/mingw.c
 		compat/winansi.c
diff --git a/meson.build b/meson.build
index 7073d5844d..6ddc461873 100644
--- a/meson.build
+++ b/meson.build
@@ -1318,7 +1318,6 @@ elif host_machine.system() == 'windows'
 
   libgit_c_args += [
     '-DDETECT_MSYS_TTY',
-    '-DENSURE_MSYSTEM_IS_SET',
     '-DNATIVE_CRLF',
     '-DNOGDI',
     '-DNO_POSIX_GOODIES',
@@ -1328,6 +1327,18 @@ elif host_machine.system() == 'windows'
     '-D__USE_MINGW_ANSI_STDIO=0',
   ]
 
+  msystem = get_option('msystem')
+  if msystem != ''
+    mingw_prefix = get_option('mingw_prefix')
+    if mingw_prefix == ''
+      mingw_prefix = '/' + msystem.to_lower()
+    endif
+    libgit_c_args += [
+      '-DENSURE_MSYSTEM_IS_SET="' + msystem + '"',
+      '-DMINGW_PREFIX="' + mingw_prefix + '"'
+    ]
+  endif
+
   libgit_dependencies += compiler.find_library('ntdll')
   libgit_include_directories += 'compat/win32'
   if compiler.get_id() == 'msvc'
diff --git a/meson_options.txt b/meson_options.txt
index dc88f130d7..becf4689bf 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -21,6 +21,10 @@ option('runtime_prefix', type: 'boolean', value: false,
   description: 'Resolve ancillary tooling and support files relative to the location of the runtime binary instead of hard-coding them into the binary.')
 option('sane_tool_path', type: 'array', value: [],
   description: 'An array of paths to pick up tools from in case the normal tools are broken or lacking.')
+option('msystem', type: 'string', value: '',
+  description: 'Fall-back on Windows when MSYSTEM is not set.')
+option('mingw_prefix', type: 'string', value: '',
+  description: 'Fall-back on Windows when MINGW_PREFIX is not set.')
 
 # Build information compiled into Git and other parts like documentation.
 option('build_date', type: 'string', value: '',
-- 
gitgitgadget

