Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8FA3A4536
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937976; cv=none; b=dWyjGXytiJ+btbUmH7Bv17Fly4C/a9D3Lvkc7Xy9MLnWdwImPDDk9XLUVDiqEI3Xk2PHIzH4XvHJAdwnd56qlhFM0KLw1ZV4LxhjXWfcZTc58WpmyKhpDHIYd1//s3b0IyXbyEJc+A7zH4nqWfYZvsm/tZXgcJudj/UX2mZ7h/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937976; c=relaxed/simple;
	bh=EsgHUGDMRhuks515iSzmHNeqU4szO86Gm6UxEyphQ9E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cCJ1snivIydj/Xe/dVsnjHkIke6AHkAYCUbAChT/u/L+aAGRFQgHk23npCSf6/Ui4pXM5bXquRqTg0QxkHI0IThHXsc17zO+jM5lth6+sVwywRmBhZxxIBR5F9cSi32mNf8s737S3pWoeRuYaLPADAU0EQRnvL9ca3ukTpA7OxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReLiV0/O; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReLiV0/O"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40ee9b945d5so3767811fac.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937974; x=1775542774; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfq55mn7MJ04jqjtTP4/AbbAEktb2oJtSvHfgUnB3sY=;
        b=ReLiV0/OWnAqPTiFDLNg51EHIe/bv/b5gwqAwBCbs2/9watgFIUH9QNA4z0xMsI6aa
         hxHtFHmMh5yjOyWKfks/22Q5YTRvtl82AIdeIjrOx0TxjJFLd1jP9q2bzoOBKfMz+kV0
         SJkvKjV4W05vOXcSSTF2lkACoahF0UWSxkja64sg/F0f/AadrrL6hBi/suxD7tE0sdsz
         UE/jse6mUoaREKmCuIZ+0H0D6ig9FR4uexeBsPKyuw8fWYiN04n1NFxmde3HH3AjEtEU
         Zu7W6AO50U6DlOW28VAwooEd3+pGCOHG9gN3HOhmaaoET5aV/BzPGv1O1eBvypEXFAh/
         YB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937974; x=1775542774;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hfq55mn7MJ04jqjtTP4/AbbAEktb2oJtSvHfgUnB3sY=;
        b=eewjNA9bRLAGrDmk8RwW4Pl05vozx1RX6MhnDXM5TuUlPZ5SRdSdDLAZwE9eoBdfNo
         YL/vuHVZ8YA/lmtocGNkCimt/cIRGguANeb4+pQCsWEq8ze3dQOItPCZyezjUB+IOMNv
         LPWJObIAxJmM7/g4MBEgQMP+QTEnRFMqZl7ghZwWlcjuYjxPevoFGPRf6+RElzllvLF0
         NvTrZhcQXQ2Uul28gaf2B2cBLRX/nfJ+VEMjVeAvg50DnqL8RppJ8Yxmg8YXAfDMs8SW
         BTDXL/JLqxkvlewIKUdyN+xQuMjzN+w6QRS/AywNk3cWmvJ9R4MICMwydO4k3bwLtJ3z
         igpg==
X-Gm-Message-State: AOJu0YwbPzm64MCNYd1z0UiJSousptkBpaV5Kuhk/Qg6PBcIol9M8VNC
	pNyEByIt1mX1NM044wyVGoLfTDv3K0sn4FIFfKBWB0KlMr9QKAEh9tMUEs6HEQ==
X-Gm-Gg: ATEYQzxe3QB9eMPY6co7NCDhy42rFJP52sB23NvokfEFCP2FmurNiYpPWss1W+y6Kxs
	J5L0eAzFRYaVZjjEDDsN0y4ppffxBqpVz3osR3d+xzSpM9eRAbNprgDwCq0sbddlA5XOdRomoO1
	92n2FzJlnkZYURr+Dwu/bzN8netfbmHyNqmYyUZsW4l8zEqVqVbMN2GWVbbECk7RyfVQq8OXThi
	drZRgIVNHPg+MTAXWzWHs4JTslOz4IxAJhcCyWpAieVES0rolltHFakjxdW70lpkZ4hCTwe+dll
	TGRCrp+pRKoOq1OmjXhBDrbWJBedKTdniYeyjA6tU3qumbwjZSZM9vVcvwJJKItlWXNQ2ykWYNb
	AKnXAl/q2bwQTSRM9hj391SKEdqxguBoXk5xZOEgii/vUUnhXXMSnYy3fzp1ZadH/Nq4DKv3qu+
	aoFnEZtNzdgFIXOusTQtPMvpu6raM=
X-Received: by 2002:a05:6871:e493:b0:3f1:6d93:4386 with SMTP id 586e51a60fabf-41cec172943mr8253906fac.1.1774937973917;
        Mon, 30 Mar 2026 23:19:33 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.162])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04c88da4sm6241084fac.12.2026.03.30.23.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:19:32 -0700 (PDT)
Message-Id: <dec0fb144f9ea4efe8d15526b376f51ef470ed5d.1774937958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 06:19:10 +0000
Subject: [PATCH v12 05/13] fsmonitor: rename fsm-ipc-darwin.c to
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

