Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1CB3A7591
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259673; cv=none; b=aK+oTWDbeG69Tp7QvCrxLu+1VSrkWHeXA3vTVGfSONpiIO13VcEWimzSlvFlakMqc+M3XZ2iTOzrP2W5kYb0iYDYZuKwg75JwdRbbg1tDuHwet7jkyqxyUYXzHYOEbShTSek3ZnQliDxikKUKommxD5PEF+wk2zpRLFUAt6G9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259673; c=relaxed/simple;
	bh=EsgHUGDMRhuks515iSzmHNeqU4szO86Gm6UxEyphQ9E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N4+0afF7Eb3YFZxgEjq5T/2oybw5X/W5YMXPaZ2fLEPIeetf6R0v8X526H2EpwrlVuwCrvtZGECC9fIJioWcBU5hLr3ViVauE/ucBGx0fUYvH4mvBhZEmnRYjzvO9XcADMCSohCzvEZzRJ20LkGRd7eFCRggcf5xA2b0WoWzDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6FBlrwa; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6FBlrwa"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506362ac5f7so52617971cf.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259670; x=1776864470; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfq55mn7MJ04jqjtTP4/AbbAEktb2oJtSvHfgUnB3sY=;
        b=Q6FBlrwaV0ylNWsY0glojUHVudEYfrili3yRiFbK0WpP0kbIoyMycCqmuRpjCl6UIL
         dgyKuRk8tvs9uaPcMwoc8ZL80LzNpLcrhKlO7JOLI2sUp+0ts4j+l+1gNkxnWWgzZOtL
         AmHpgJYGs56lWdUpsaVK0hnrmgUiWEpk+AVpTAk6Xz27NEQWQ2GoyA+KCAqgLYQioGdL
         o1wcYYMXDedtIS3QQn4t3p4aHQwMVuZTgzPlod1FfBek8vLwJk0m1/ONZs0RLFhoMX9U
         j7LuEZXrY6PwFUKtyAS2HU7PqVu8YIVg0SuQEs7MByK9i2wopUy2aJbe4OVz+a2mROLA
         xt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259670; x=1776864470;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hfq55mn7MJ04jqjtTP4/AbbAEktb2oJtSvHfgUnB3sY=;
        b=GcnOwXeqS13YcdtdFlwuLHoC7xetzP0ZmntKUY/JnyZ9emUOg5luAPtM+8n3kcarzL
         rdSUsz138JUJFClfvq9jHE0vTC9Rw71y/1ZWykc8JblvJuwAzOmFXEBgnZlxjTvXd6K6
         ycS2M/E84/SrWHvlgl61MP5iNZ7iczBV2plaSfbCUP37EILi8T6TaxpcnkwdLvexZqH/
         G2J66NKl/ua+VlRpMNRwyT9q6paYJY8d+tBiQouEn0CGx8/OVGOG781hA/0mG9mFF1H3
         9hI8gqrG15gFgwvvYWmJFtKfS/VQO+l/cQh5FoliGMm5l/1GV7mM1tg9+US4mkNX70AA
         GqEA==
X-Gm-Message-State: AOJu0YyLyBH/NZjTpKB88vIVz29nZbLw9B8KshqGHUey3KQ4bM2lz43d
	LCVZNIl6m0EPOyr38kMdoaZlMS+ZfyFlxTs8O17qIAeGVvLHF6VCHbpjkyw2sQ==
X-Gm-Gg: AeBDiev4nhmL3tji2ZQaUpaihKWJVRmoN7vpyV/gayfzepjNni4ps/MmrDXMUFkt6aI
	ikGqSlRlCIJNtKhQVmdNvxdqQ/PTxvi/ki52kdEIEZzqzMy9+hvaeXT49PJNy5Gn/EhW5hJmLLf
	4kwjQRm2IheYxxPZS/SkIlVc54WUNAPLZnarOuYZxHF4Pgooi7TzpS2UMY7DNFwxQl/kHFtO9Po
	LeCtFhsXWfrFMS2zjOsZ0J1zBVlPhVPTfjX05IVA9vTafn4PPx7Le53GT5Osyzc7VQVT7pfpkQ0
	LakScYk+Fv7zXX4dDSC4xa7ZSSzxXoOSpXCyYooTfxfpGWGs3f9XyhnqaVx/pN0pacrDFBAhtd2
	C+plI10aYDe1B/FdiU5E5RKYs7o2B8J8d0JnGoSJ5AIOUtK08Vvr9pkzjEpMZOy2vKt4PK9c2pe
	fE4QYegOU2obetS0kYSmO6o/RDCw==
X-Received: by 2002:a05:622a:1386:b0:50d:d9c3:830d with SMTP id d75a77b69052e-50dd9c38a67mr288290351cf.29.1776259670026;
        Wed, 15 Apr 2026 06:27:50 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9e0b0sm12713121cf.19.2026.04.15.06.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:27:48 -0700 (PDT)
Message-Id: <7086cd4530c87978661890d130246ca8fc964c35.1776259657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
References: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 13:27:30 +0000
Subject: [PATCH v15 06/13] fsmonitor: rename fsm-ipc-darwin.c to
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
    Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Jeff King <peff@peff.net>,
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

