Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281EB37757B
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 05:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898426; cv=none; b=P37gDJpyMFJ9LxxuO50mjdk3WQmCYMgnOSPikd6BI1c4ekcxBpCa5ZGbYk5YF4cUS++PYls5xQIWoHZduSz2EoamplwCL7JCihb/k9HXAdlf7TW2Y6EjqEAD5utv8y1Jh2/looUe5S34ZazYEgc/bc7OPX+0sdB2di76PzsFxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898426; c=relaxed/simple;
	bh=tbnHKVQUEwovcZ+pa/glfpADQCWNlESTEzWMURYnan4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=js7WYfAdMzaQFSof5VGaXO2qlsxhgKTMiFMMkg60qyULKN9hmVUhgclzlZgVzoQCLoBLqbxclzy+Iwa5nBKCUqGwbaogprThQ1MQ+4aNraw+TTwFGfEDS2FNUm8zGQHxnQ+Lz+CyLQhkmVczMAQfxoxhGXTqZTSPOTIkMppZnjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EFHBo5Us; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uDO4h8Lj; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EFHBo5Us";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uDO4h8Lj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B65F1400227;
	Thu, 19 Mar 2026 01:33:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 19 Mar 2026 01:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773898424;
	 x=1773984824; bh=8qw8l7ZHTDOhRdIXtnUNDgjuEqMfxemPOexuEET0LOg=; b=
	EFHBo5Us4oMybxiy6+QpgpCrgRYWDk6bMM0EcYk1lgUikSbP4LZQc6QkpjNpYg0U
	Q6C0jyjVeo18ANuIHQEqC1xOEWbQdW7s/gDY8RqB242uTCG2+UOBUCDOuNy4jlPe
	2u2xehnZIId/AaButAfp07mS/BjnG6RG9P8WC8hRZ4Ln85GnpZLMOmTzxZ4zmHU1
	Tudj3WsHpO4xjW9WKiCp6LcXmeCYaqX2KW13hyjMKbduyL4gpn91h4SKxHeYiYNn
	zSCpKAyDcncOciOBWmzgmh0IvvWQLmnnGB0agzVsZ7WSJ+zINohffMwAsWMValmz
	27vzqTHLr4fRqnXIYds0sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773898424; x=
	1773984824; bh=8qw8l7ZHTDOhRdIXtnUNDgjuEqMfxemPOexuEET0LOg=; b=u
	DO4h8Lj5MyrNsYdxW3orOjS/5HfjL+WdiUiopGDUZA+BeoLkLYFUbtIGAdr8rDht
	MeLKeQmkurLY/At9h3SMwEEeHeH6cKcni1/VkY4ra/KdyglDfeT2lSrluez4lPU7
	knNw+BXn9Swb3VAgte52Ofnh+o8WrdDyMr1K3utGPVXA7Eg0pTIPqGKGs+g4lWvs
	CrrdznoJKwmS6yRWq8v/SmB/BZHQ1HFXN8LSPpmLh1u9X6gvN0Fs2QjheW484o+/
	LqZrci2SQVpKfiULwvVQqjguh9ARRHkmvxc4LhmaHqYfevUNYXukjCTvTtJMXKMA
	7ItKZSkzHvtERQNn92vpw==
X-ME-Sender: <xms:uIq7adwNfRr0cyuUZUSOR3cILQw8NavZitgyTZnJttwYHs-PFTGdrg>
    <xme:uIq7aey4I7ZutnZdSqK_crPxco9AVS6qdNe5q_-mdFSyWlMLLMbb-fOy_gO4_hI8S
    -0xVUdDonG9x2q5TMQL0Nts-7T4rU4VAQ0GZf7kXeIO5APU3qrUUJg>
X-ME-Received: <xmr:uIq7aXaB__vJ5Pm31VWDhwf5mrorIBGTcM2_vyYFohULpooa34Rwu9PLSphImyL4RkYbzoeYK1Bg6_H7ZP_a1zurJ15JyzcxkjTq12SCeJq_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uIq7afV83ookOLI5ePS8AkTCb2peOfzaqCoTSxmON_ZsQbBuhIPnmQ>
    <xmx:uIq7aViaFAObw_iifYH5YK-GUYpjbHy5jfArK-C92pfrlgAS5TuPMA>
    <xmx:uIq7adsIAmO0gcp7y5Ll4hMis7NPCyqD1atszgAmBuAbIc_togb1iA>
    <xmx:uIq7ae7heVh67jEsLzdfuIFD77FdXGdDjLChhLflI7_9CoOjj9ZoKA>
    <xmx:uIq7aemlz9gi7pwuYwSHbbNSSMwyg-PUE8sS5Ak0zrmsmO3Ml9KwwIpq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 01:33:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3f46e444 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 05:33:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 06:33:26 +0100
Subject: [PATCH v3 7/8] meson: compile compatibility sources separately
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-build-infra-improvements-v3-7-82f5fb3edc3f@pks.im>
References: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
In-Reply-To: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3

In the next commit we're about to introduce a precompiled header for
"git-compat-util.h". The consequence of this change is that we'll
implicitly include that header for every compilation unit that uses the
precompiled headers.

This is okay for our "normal" library sources and our builtins. But some
of our compatibility sources do not include the header on purpose, and
doing so would cause compilation errors.

Prepare for this change by splitting out compatibility sources into
their static library. Like this, we can selectively enable precompiled
headers for the library sources.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 79 +++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/meson.build b/meson.build
index 604fe89d2d..cd00be1c23 100644
--- a/meson.build
+++ b/meson.build
@@ -271,6 +271,13 @@ version_gen_environment.set('GIT_VERSION', get_option('version'))
 
 compiler = meson.get_compiler('c')
 
+compat_sources = [
+  'compat/nonblock.c',
+  'compat/obstack.c',
+  'compat/open.c',
+  'compat/terminal.c',
+]
+
 libgit_sources = [
   'abspath.c',
   'add-interactive.c',
@@ -304,10 +311,6 @@ libgit_sources = [
   'commit.c',
   'common-exit.c',
   'common-init.c',
-  'compat/nonblock.c',
-  'compat/obstack.c',
-  'compat/open.c',
-  'compat/terminal.c',
   'compiler-tricks/not-constant.c',
   'config.c',
   'connect.c',
@@ -1163,7 +1166,7 @@ endif
 
 if not has_poll_h and not has_sys_poll_h
   libgit_c_args += '-DNO_POLL'
-  libgit_sources += 'compat/poll/poll.c'
+  compat_sources += 'compat/poll/poll.c'
   libgit_include_directories += 'compat/poll'
 endif
 
@@ -1179,7 +1182,7 @@ endif
 # implementation to threat things like drive prefixes specially.
 if host_machine.system() == 'windows' or not compiler.has_header('libgen.h')
   libgit_c_args += '-DNO_LIBGEN_H'
-  libgit_sources += 'compat/basename.c'
+  compat_sources += 'compat/basename.c'
 endif
 
 if compiler.has_header('paths.h')
@@ -1209,7 +1212,7 @@ if host_machine.system() != 'windows'
   foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
     if not compiler.has_function(symbol, dependencies: networking_dependencies)
       libgit_c_args += '-DNO_' + symbol.to_upper()
-      libgit_sources += 'compat/' + symbol + '.c'
+      compat_sources += 'compat/' + symbol + '.c'
     endif
   endforeach
 endif
@@ -1251,18 +1254,18 @@ else
 endif
 
 if host_machine.system() == 'darwin'
-  libgit_sources += 'compat/precompose_utf8.c'
+  compat_sources += 'compat/precompose_utf8.c'
   libgit_c_args += '-DPRECOMPOSE_UNICODE'
   libgit_c_args += '-DPROTECT_HFS_DEFAULT'
 endif
 
 # Configure general compatibility wrappers.
 if host_machine.system() == 'cygwin'
-  libgit_sources += [
+  compat_sources += [
     'compat/win32/path-utils.c',
   ]
 elif host_machine.system() == 'windows'
-  libgit_sources += [
+  compat_sources += [
     'compat/winansi.c',
     'compat/win32/dirent.c',
     'compat/win32/flush.c',
@@ -1289,20 +1292,20 @@ elif host_machine.system() == 'windows'
   libgit_include_directories += 'compat/win32'
   if compiler.get_id() == 'msvc'
     libgit_include_directories += 'compat/vcbuild/include'
-    libgit_sources += 'compat/msvc.c'
+    compat_sources += 'compat/msvc.c'
   else
-    libgit_sources += 'compat/mingw.c'
+    compat_sources += 'compat/mingw.c'
   endif
 endif
 
 if host_machine.system() == 'linux'
-  libgit_sources += 'compat/linux/procinfo.c'
+  compat_sources += 'compat/linux/procinfo.c'
 elif host_machine.system() == 'windows'
-  libgit_sources += 'compat/win32/trace2_win32_process_info.c'
+  compat_sources += 'compat/win32/trace2_win32_process_info.c'
 elif host_machine.system() == 'darwin'
-  libgit_sources += 'compat/darwin/procinfo.c'
+  compat_sources += 'compat/darwin/procinfo.c'
 else
-  libgit_sources += 'compat/stub/procinfo.c'
+  compat_sources += 'compat/stub/procinfo.c'
 endif
 
 if host_machine.system() == 'cygwin' or host_machine.system() == 'windows'
@@ -1315,13 +1318,13 @@ endif
 
 # Configure the simple-ipc subsystem required fro the fsmonitor.
 if host_machine.system() == 'windows'
-  libgit_sources += [
+  compat_sources += [
     'compat/simple-ipc/ipc-shared.c',
     'compat/simple-ipc/ipc-win32.c',
   ]
   libgit_c_args += '-DSUPPORTS_SIMPLE_IPC'
 else
-  libgit_sources += [
+  compat_sources += [
     'compat/simple-ipc/ipc-shared.c',
     'compat/simple-ipc/ipc-unix-socket.c',
   ]
@@ -1339,7 +1342,7 @@ if fsmonitor_backend != ''
   libgit_c_args += '-DHAVE_FSMONITOR_DAEMON_BACKEND'
   libgit_c_args += '-DHAVE_FSMONITOR_OS_SETTINGS'
 
-  libgit_sources += [
+  compat_sources += [
     'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
     'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
@@ -1355,7 +1358,7 @@ if not get_option('b_sanitize').contains('address') and get_option('regex').allo
 
   if compiler.get_define('REG_ENHANCED', prefix: '#include <regex.h>') != ''
     libgit_c_args += '-DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS'
-    libgit_sources += 'compat/regcomp_enhanced.c'
+    compat_sources += 'compat/regcomp_enhanced.c'
   endif
 elif not get_option('regex').enabled()
   libgit_c_args += [
@@ -1364,7 +1367,7 @@ elif not get_option('regex').enabled()
     '-DNO_MBSUPPORT',
   ]
   build_options_config.set('NO_REGEX', '1')
-  libgit_sources += 'compat/regex/regex.c'
+  compat_sources += 'compat/regex/regex.c'
   libgit_include_directories += 'compat/regex'
 else
     error('Native regex support requested but not found')
@@ -1428,7 +1431,7 @@ else
 
   if get_option('b_sanitize').contains('address')
     libgit_c_args += '-DNO_MMAP'
-    libgit_sources += 'compat/mmap.c'
+    compat_sources += 'compat/mmap.c'
   else
     checkfuncs += { 'mmap': ['mmap.c'] }
   endif
@@ -1438,7 +1441,7 @@ foreach func, impls : checkfuncs
   if not compiler.has_function(func)
     libgit_c_args += '-DNO_' + func.to_upper()
     foreach impl : impls
-      libgit_sources += 'compat/' + impl
+      compat_sources += 'compat/' + impl
     endforeach
   endif
 endforeach
@@ -1449,13 +1452,13 @@ endif
 
 if not compiler.has_function('strdup')
   libgit_c_args += '-DOVERRIDE_STRDUP'
-  libgit_sources += 'compat/strdup.c'
+  compat_sources += 'compat/strdup.c'
 endif
 
 if not compiler.has_function('qsort')
   libgit_c_args += '-DINTERNAL_QSORT'
 endif
-libgit_sources += 'compat/qsort_s.c'
+compat_sources += 'compat/qsort_s.c'
 
 if compiler.has_function('getdelim')
   libgit_c_args += '-DHAVE_GETDELIM'
@@ -1511,7 +1514,7 @@ if meson.can_run_host_binaries() and compiler.run('''
   }
 ''', name: 'fread reads directories').returncode() == 0
   libgit_c_args += '-DFREAD_READS_DIRECTORIES'
-  libgit_sources += 'compat/fopen.c'
+  compat_sources += 'compat/fopen.c'
 endif
 
 if not meson.is_cross_build() and fs.exists('/dev/tty')
@@ -1745,14 +1748,22 @@ else
 endif
 
 libgit = declare_dependency(
-  link_with: static_library('git',
-    sources: libgit_sources,
-    c_args: libgit_c_args + [
-      '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
-    ],
-    dependencies: libgit_dependencies,
-    include_directories: libgit_include_directories,
-  ),
+  link_with: [
+    static_library('compat',
+      sources: compat_sources,
+      c_args: libgit_c_args,
+      dependencies: libgit_dependencies,
+      include_directories: libgit_include_directories,
+    ),
+    static_library('git',
+      sources: libgit_sources,
+      c_args: libgit_c_args + [
+        '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
+      ],
+      dependencies: libgit_dependencies,
+      include_directories: libgit_include_directories,
+    ),
+  ],
   compile_args: libgit_c_args,
   dependencies: libgit_dependencies,
   include_directories: libgit_include_directories,

-- 
2.53.0.959.g497ff81fa9.dirty

