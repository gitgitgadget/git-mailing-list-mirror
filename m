Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FCD27603F
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498111; cv=none; b=rmN5OskVcracI3GMt6mNSizEz6Lbsu1qXeQmp0YedB5kycv8/CQirdHNVFiTC7kPmtU6Ei8FW9cKq6E0Qtd53zzD9mL6+pzxmIFEoX9JcUAKDxFFnwgkWZUjdySBfh1ztuYgUfNyICqFhCM2eJ8jK17XtwOY+8ONh1MzGUiYnM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498111; c=relaxed/simple;
	bh=EsgHUGDMRhuks515iSzmHNeqU4szO86Gm6UxEyphQ9E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Oiu0KA6mPCEVcJ7BEU16tCdu26ay/De6mqfa+l2HQhmVbcUogs6y+RKkN9H4bEB3iA6GavaRdySeIoXjylMr3zfK6dVI2AxquSo/7eOZlGS8pVkC5UWyNhOCkszzXYwZ1Wa+4S55oXZoH2j05U8Uy22bJQLxl2OTGjO8B5oAFcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkvsNjCX; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkvsNjCX"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12732165d1eso5664944c88.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775498108; x=1776102908; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfq55mn7MJ04jqjtTP4/AbbAEktb2oJtSvHfgUnB3sY=;
        b=hkvsNjCX4efaA1i0is50Ewc9nHL12npXhZTo1xSsFQvrTWd5waB5RCICUXKVG28NRz
         xfyuXpllRAz3O3YiZk6dlGRbbN2N/GchJQBrukOqAPbFe9/JIZVZzSph5q1uh0vnV6+G
         aXfR1CIa1WfhoPk56freNAituiCnxbSY/W9uRy43K+Vau1qH2Od4eVZw5j7D9e+jQKkq
         EpN+qBJiwdVimtzEUXJNXZNA0sT8KNp5DWOfjf2pNswOrAstsn9iq0Du4Sp/qSapquLb
         Y516tCfYnTu8GdCIJSRqmSBjeq3ckoVF5YyYVNT+2ECn2vl8RtykxVRdmSCpjJRQYSC0
         8yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498108; x=1776102908;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hfq55mn7MJ04jqjtTP4/AbbAEktb2oJtSvHfgUnB3sY=;
        b=MQk/mNSLlApWnPyJ0O9SiJpTBSamqOrtIGKWOA1o+fA3Il3rTJqBYWmkczJeNUd8qI
         mowdWvJhqEPa/VahvX+LFQATM5hiTXKQ/mI3TDFiX2mAdzWD/UsrovN4FRSXkB41gkLn
         e3f6EcXuje1Rn/Jt9fXfoJ+gjmtW8wBkPYdIxJNtyKII1YhZ/oy+rsW9xGYdmTODUW2w
         c9KWoSWgAQe6Pl3BvB7jFdztFx2uo+6htLAQdrVjqpJxDQ/qvgNmd0/qoUpRTBI2Ff9p
         4IKuGU/61gjKKt+af8YWwd4+I8dyzHNAPnPfPcPxywKaZ0WfH3+0vz+FiEU7hPaDGnyu
         4q1Q==
X-Gm-Message-State: AOJu0Ywm7cIOsn1Xr9JhCi2vBpATioJDHtxYXQO+KyymK94O+Z2usBnU
	W7BitOIPHyXr2xM+Gd180+cMxYTiSz7zb3TrpjHpkx0b9XuT95P7tm24U8hgNw==
X-Gm-Gg: AeBDieubdzMuC+kFn8v6HjDmWRy5V7CT8yXBWqUtzTBTEaIrski8q1sQiTlYjfUP25B
	UsPXx74nKG1+Zwae1wRol3TiPHeIT82oJ0rN/5YvOB769ALJABGS5AguaiK56tY3/qIsGRjPr5E
	f7wYf+IigPmF8x2X7xtRJwD3DbJq115HyamaZ8FCBORwxptF3UIE8wltZz6ThMgI/hs+IGg5Ovn
	i3CAVeXFCYsJYOlebx0iLnQi8BYIwYqnzkWC/+t/e6cePwK2SL7tSX76sH6w+IbBr64aVevGlkU
	r6aDpFEzI1KJ2597Ox5czlEhpMUUEDo5VGfgLLw6MbkTfhWUWN8vVY/WB5BaRIor/6xKnMZGpUT
	UpM1QfleccD8H+5Q9kdAVs6rg6y8vgugKnzcMcib0if/LWJt7t4io8IuFcxw1OfBHwLmBNtx/YQ
	KapoOdHyH6gwaHRrt0IGX9H4mU3jc=
X-Received: by 2002:a05:7022:6097:b0:128:d9a1:b68b with SMTP id a92af1059eb24-12bfb767ec5mr6504031c88.33.1775498108434;
        Mon, 06 Apr 2026 10:55:08 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm16552223c88.0.2026.04.06.10.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:55:07 -0700 (PDT)
Message-Id: <e897193b0e62ff9085e5c9798545677c18f9f862.1775498098.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 17:54:51 +0000
Subject: [PATCH v13 06/13] fsmonitor: rename fsm-ipc-darwin.c to
 fsm-ipc-unix.c
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
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The fsmonitor IPC path logic in fsm-ipc-darwin.c is not
Darwin-specific and will be reused by the upcoming Linux
implementation.  Rename it to fsm-ipc-unix.c to reflect that it
is shared by all Unix platforms.

Introduce FSMONITOR_OS_SETTINGS (set to "unix" for non-Windows, "win32"
for Windows) as a separate variable from FSMONITOR_DAEMON_BACKEND so
that the build files can distinguish between platform-specific files
(listen, health, path-utils) and shared Unix files (ipc, settings).

Move fsm-ipc to the FSMONITOR_OS_SETTINGS section in the Makefile, and
switch fsm-path-utils to use FSMONITOR_DAEMON_BACKEND since path-utils
is platform-specific (there will be separate darwin and linux versions).

Based-on-patch-by: Eric DeCosta <edecosta@mathworks.com>
Based-on-patch-by: Marziyeh Esipreh <marziyeh.esipreh@gmail.com>
Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 Makefile                                      |  6 ++---
 .../{fsm-ipc-darwin.c => fsm-ipc-unix.c}      |  0
 config.mak.uname                              |  2 +-
 contrib/buildsystems/CMakeLists.txt           | 25 +++++++++----------
 meson.build                                   |  7 ++++--
 5 files changed, 21 insertions(+), 19 deletions(-)
 rename compat/fsmonitor/{fsm-ipc-darwin.c => fsm-ipc-unix.c} (100%)

diff --git a/Makefile b/Makefile
index 8aa489f3b6..080d009bf0 100644
--- a/Makefile
+++ b/Makefile
@@ -417,7 +417,7 @@ include shared.mak
 # If your platform has OS-specific ways to tell if a repo is incompatible with
 # fsmonitor (whether the hook or IPC daemon version), set FSMONITOR_OS_SETTINGS
 # to the "<name>" of the corresponding `compat/fsmonitor/fsm-settings-<name>.c`
-# that implements the `fsm_os_settings__*()` routines.
+# and `compat/fsmonitor/fsm-ipc-<name>.c` files.
 #
 # Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
 # programs in oss-fuzz/.
@@ -2365,13 +2365,13 @@ ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
 	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
-	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
 ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
+	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_OS_SETTINGS).o
 	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
-	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
+	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
 ifdef WITH_BREAKING_CHANGES
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-unix.c
similarity index 100%
rename from compat/fsmonitor/fsm-ipc-darwin.c
rename to compat/fsmonitor/fsm-ipc-unix.c
diff --git a/config.mak.uname b/config.mak.uname
index 3c35ae33a3..33877020e9 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -165,7 +165,7 @@ ifeq ($(uname_S),Darwin)
         ifndef NO_PTHREADS
         ifndef NO_UNIX_SOCKETS
 	FSMONITOR_DAEMON_BACKEND = darwin
-	FSMONITOR_OS_SETTINGS = darwin
+	FSMONITOR_OS_SETTINGS = unix
         endif
         endif
 
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 28877feb9d..6197d5729c 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -291,23 +291,22 @@ endif()
 
 if(SUPPORTS_SIMPLE_IPC)
 	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
-		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-win32.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-win32.c)
-
-		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
+		set(FSMONITOR_DAEMON_BACKEND "win32")
+		set(FSMONITOR_OS_SETTINGS "win32")
 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
+		set(FSMONITOR_DAEMON_BACKEND "darwin")
+		set(FSMONITOR_OS_SETTINGS "unix")
+	endif()
+
+	if(FSMONITOR_DAEMON_BACKEND)
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-${FSMONITOR_OS_SETTINGS}.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_DAEMON_BACKEND}.c)
 	endif()
 endif()
 
diff --git a/meson.build b/meson.build
index dd52efd1c8..86a68365a9 100644
--- a/meson.build
+++ b/meson.build
@@ -1320,10 +1320,13 @@ else
 endif
 
 fsmonitor_backend = ''
+fsmonitor_os = ''
 if host_machine.system() == 'windows'
   fsmonitor_backend = 'win32'
+  fsmonitor_os = 'win32'
 elif host_machine.system() == 'darwin'
   fsmonitor_backend = 'darwin'
+  fsmonitor_os = 'unix'
   libgit_dependencies += dependency('CoreServices')
 endif
 if fsmonitor_backend != ''
@@ -1332,14 +1335,14 @@ if fsmonitor_backend != ''
 
   libgit_sources += [
     'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
-    'compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
+    'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
     'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
   ]
 endif
 build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
-build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_backend)
+build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_os)
 
 if not get_option('b_sanitize').contains('address') and get_option('regex').allowed() and compiler.has_header('regex.h') and compiler.get_define('REG_STARTEND', prefix: '#include <regex.h>') != ''
   build_options_config.set('NO_REGEX', '')
-- 
gitgitgadget

