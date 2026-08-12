Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3078278161
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521190; cv=none; b=PcFe3V/Tzrw7hnBC119l7QJM+wSqXza0zs/ElJu5D6zUmVA+rHI+HWwJbxZPP8YhtNf8Dh6Xx7GBMJwaVZ2V6xIjcR/A7PeVPiTpSip1uSW/mO/92QaAwE+0tWV3RkjgyMzzkIb1QVLtHrK5P9ioq5Duk2HbCSHZYYYRPsCHj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521190; c=relaxed/simple;
	bh=SYwjK741ukYEls6wbHFxbx790SGGquB4/4r3pFF/yCY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qIgP+dwk2qGQ+BOwrPRDnNpg7l/0RTcvQ8gi89NcTnuF9fbw8QqHGW30yFl9kO5Rj0MJokuYgwZaogG1IQ0eF0LLlbN6zEUROtXl5nw2LJUMejn7QwXFzZ6oZZqpie+XqnKQrVLqA3hsjOI962965t76gjU3LmkldY1cQylzipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkkSclZz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkkSclZz"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cf50c6f235so10916325ad.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521188; x=1787125988; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=233GQXmWTqafwi4WkLc4ijhnurNuITK9xiKEC3d2GXs=;
        b=TkkSclZz57HfFTY8GJCR35pVH6FON5F+VvhNWQiI359W8tmUboHGpP/f78gcV8OwOS
         WusVvBozB5ErhjWfSYXsbcwWC9r/s29BL6Fy8thzBHUJTuUHxjRXyFMGQdp2rp3CwpsP
         nylx2HSLfGebatuH1Xbs+xemWlZhwrTDMKbYNUOa6z13NNWaL6zBZ9R2KRgktFF7P/gi
         AYQnhSo/F9kXV5bylB82sKsBZpaZwoGOqzEfuJ0ZPMg4HChiCdmGrH0JDGeTz1+EGVtl
         B0PH7PNOWuC3w8HwPDJ9jdLNWvSKnCVrq208JMYikcBc3RNI+uqVSkNyJweDu0xw6CDC
         FhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521188; x=1787125988;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=233GQXmWTqafwi4WkLc4ijhnurNuITK9xiKEC3d2GXs=;
        b=GNRNyG+eOmsVBuwm7Ra3uPOBZzVJnap6uiJtGGvD/xEEoa+dKwEeJu10NMrVeRjgLN
         gQH4jc94t7PxODI11BX/bAvm/fw5Q37/yC+eNXGIA3qzSigFWIbtJx6shUcI0nzzyAMA
         eRlckc4sGNEDt0/xSHIfy6YNFocP1EKWI8iWKVtMCGItXiMTMHj9AQoFgw2jlYtEHwp6
         0wMprIL1D1D+fSROv6W23K//ut2061zbj3ROAf4jizOoR4Zn1AsYe7ePU8+cF0WRkvBP
         pXyMbiqckOEXHf69vPrWlk30LaP7MzuyGFH4B09ezg6yArkpf112AEcs+CdYRMwYLeCc
         sf/Q==
X-Gm-Message-State: AOJu0YweLLyLwhQ9b2mBDN2lFQWfFm9SibqOk3A1M0Jkw76G4iyPfW/E
	02C9ncfPUK+nFiSCVINzb0+xl0WGbh3vFAQCyJY3q+bfOiPZrg99nMagu6Vi5g==
X-Gm-Gg: AR+sD13xM3TYxwqGpJW6vMqPNhsx6suu9opIc5Z6FVc29+NILb+KudcnifkaLiN7vei
	N9gAtm940oOypKzpXrbePRmqGdMAvdtu88f+QdFbddCA0ob1dSIyYQV+2VYW0q8BAMgxxS75M8G
	wn05gxqH0OMq/cmDGcnNGRGDu+i93i9gKSV0qoQSP/Fi3jsum2glElJu+miViE7sHEPEeiLoeCr
	V9A0NHf04prGsKfSGhTUYGNRh/mNM7eBrvfVqSm322KlAqS/lhwOuJxW4wf0cVVs0SO4S5cFZk0
	JzyPikeih0uN4OhewTp5OfoYUyN/LqnngRnpIF9XUELQNGmmHRN2r22HnD4PQl4Xw9KGH6CkznV
	9rBPlwyQavlsOOMg1HoILSxL8suim0ymY+SrZDaE3haT0hxXc/F2abGm6FQm7Czfu2GFFKLGK2w
	SMPr9VKh5EwLurxg9dN+o59Se3zI4W576hojotqIJOSyn1/oO0nFM7OiTcNCCuMPTz
X-Received: by 2002:a17:902:d58b:b0:2ca:d666:df72 with SMTP id d9443c01a7336-2d34567c763mr37865935ad.21.1786521187735;
        Wed, 12 Aug 2026 00:53:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.184.150.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d351152467sm2813415ad.33.2026.08.12.00.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:53:07 -0700 (PDT)
Message-Id: <9de4ea7fc1d250e8e9dfae386424451242cb3daa.1786521173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 07:52:48 +0000
Subject: [PATCH v2 08/12] mingw: rely on MSYS2's metadata instead of
 hard-coding it
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

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname                    | 14 ++++++--------
 contrib/buildsystems/CMakeLists.txt |  9 ++++++++-
 meson.build                         | 15 ++++++++++++++-
 meson_options.txt                   |  4 ++++
 4 files changed, 32 insertions(+), 10 deletions(-)

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
index 7073d5844d..a8aba81e29 100644
--- a/meson.build
+++ b/meson.build
@@ -1318,7 +1318,6 @@ elif host_machine.system() == 'windows'
 
   libgit_c_args += [
     '-DDETECT_MSYS_TTY',
-    '-DENSURE_MSYSTEM_IS_SET',
     '-DNATIVE_CRLF',
     '-DNOGDI',
     '-DNO_POSIX_GOODIES',
@@ -1328,6 +1327,20 @@ elif host_machine.system() == 'windows'
     '-D__USE_MINGW_ANSI_STDIO=0',
   ]
 
+  msystem = get_option('msystem')
+  if msystem != ''
+    mingw_prefix = get_option('mingw_prefix')
+    if mingw_prefix == ''
+      mingw_prefix = msystem.to_lower()
+    elif mingw_prefix.startswith('/')
+      mingw_prefix = mingw_prefix.substring(1)
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

