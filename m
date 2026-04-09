Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D272E4247
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710788; cv=none; b=Ltf21vo65S4ajUdlO3Ddci6Je0FJVByMJe3wP5XznYaKSn03ypyoQF43uJKz0+1ORuBgBEHQWN1EQ9bNup9OUEwvNBmzPJZieme0xLqn9pghUJF1b3jccJ4/1CYOweGSntpKTjafn406Pd/BmZNm+Kc8oNdM3ZeWHW2Vij5wsAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710788; c=relaxed/simple;
	bh=EsgHUGDMRhuks515iSzmHNeqU4szO86Gm6UxEyphQ9E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pPC1xfE9XpPzYloGvxvv5UWz/7lmVNMzAZjD6lU8ndzaLgVpgO5C7KdO3qkWq8ZdKR+z1ZDp7OwXKNy1RnP/5Rr0oiOh6dcqQpLdtZUSfasOXGKzWSrKf6IgYpVBOHQEKbYqh9X4wD2BDLnm6qE2CkluAra45Q+a4pf3x5m0S7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1Zjvok/; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1Zjvok/"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d63635d80so3969331cf.0
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 21:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775710785; x=1776315585; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfq55mn7MJ04jqjtTP4/AbbAEktb2oJtSvHfgUnB3sY=;
        b=M1Zjvok/PsgzgQn5YoesSJlK8D5wkdQdNtxX6uiyrA5uwsUQlTb5Os1V6wON5grAcD
         FmqwshOIN4MbW/qwwHfdTwmQkKpUyYt2ePUBi8TRpWO+RUHXGCAb+6Y0nrxw1499RxPk
         1SnfGlS6zBwbB5WilkAYASw9BOkVln0Fj9dpgAj2kK8nud0igDacEv8zk0oVmE76F7Jk
         X0izpfOsevM6edQY7FXQpw8rA12VjVRI8k7SKIHUSyP4fa1o+CCw499vRWeHwrWjJMJ5
         eoqEoBUq88IyEWi5Dn1U+lBeTL2ciTvvk3THJ1KrLTFklRVB/l8mXhT8afahpji3BnOb
         PZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710785; x=1776315585;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hfq55mn7MJ04jqjtTP4/AbbAEktb2oJtSvHfgUnB3sY=;
        b=YCkZSYEytuBlW2nMVo61BtLfAD4dGD1e0LQVgROtuQm2su364dk900lusZ4EHSx6iF
         cpQ+prqwBgzsJrI0piGn1HLIO7QmsvfuHvjKnAjIYN/fHIviqpRUW46jrVKZqO107im0
         kzAdianoShGt1WoVj70AHPrGb9DtWRgbUh+W8o0oenj+jrPhnkTEvIpeHJoua6mZZghy
         QPKunrX7223fDzfqSaokvjHarGiUl1MsY/LiHYQPf/FaixI3HsFa+A3fB+ay4rQk5XpE
         5T6YIXD7Wl7mW4gaBgFN1CSQA8sxr6dHP7ZB0vVP0vO2hqvE0h6fv9RdAzgoBHtTMYnA
         SKjw==
X-Gm-Message-State: AOJu0YybC6RYiIWMRxDIlSsGebA2PYGeKl5LM63Ojv/9Ss7LTpbTuNCB
	8lOTfzMhukW+VknKl/RikPX9CEQ1r+a4GS4tiK49O2Fpl6FAwLRsdUbU9CccQQ==
X-Gm-Gg: AeBDieuD+HzPFkijWE+wSg1kuPVvBDOI/Xf/0UcO3b1vpVE4MYeDZzBQWvlazJ5h1V7
	e6nkU61rqWbJm7iBOKrumBKwslcItF6MgogSpK2X8bA/bb05tN3szftZNKiInlqXNru5zB92MPn
	fIWK4jlf6MHGxRqLA/vGwjp0Q/sqUKIsGTdvBLC10E7B/cqmxPNGnsqziAkVAGeTMNRcO3j71Qo
	8Q93qpp69S8HRqFbusgwiJWQoCLaGjiKsVK9oRWp9dl4od22T1J0XO71jstYjd+porMsPbwAZmg
	M3B7ClBcNuGN2o0dQ1Oy9MAlN9kNbQ2lgEb9pRJs7r+P+dcc3RqNBrbk+icku864/vSNyFsRo24
	jaoPaXhRtq7X1AUMg9Ciujmef5s0brmcW3tfucJzJbwKVSbKPw/nfTbzhGAsXIYuPMGzeGyjtqu
	NdRlblqNNOjJ0qRhyCP4A3PM6LNjA=
X-Received: by 2002:ac8:7d15:0:b0:50b:509e:7920 with SMTP id d75a77b69052e-50d62c79a83mr339099241cf.48.1775710785606;
        Wed, 08 Apr 2026 21:59:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d521952c4sm170070331cf.4.2026.04.08.21.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 21:59:44 -0700 (PDT)
Message-Id: <7086cd4530c87978661890d130246ca8fc964c35.1775710775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 04:59:28 +0000
Subject: [PATCH v14 06/13] fsmonitor: rename fsm-ipc-darwin.c to
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

