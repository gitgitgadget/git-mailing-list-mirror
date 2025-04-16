Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD324BD00
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 23:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744845573; cv=none; b=E58YZUA79jmBfkbF6xA3mxGAvfVfGLDEZl+fRgzDD0yWC9Ssm2F0MxMm47uYckq/HITmRttkkYu3bqNp4XSqdbTdmc389lMv9O4QwZ/+7vCnSsao96/q1jOH4P3N+7ONv22NISJf9zp+YQ0cPNyNNBjpbAyI+so3pTR6uUOfLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744845573; c=relaxed/simple;
	bh=CPmYKMmTb9AXzVMVfvG7PCfEyENCM/NIr7hl6XLnyN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u69XBIjENje43qCs4FBbXVJdZ8vk8nwqtRo2ccqieXYIobZBZXtRkyMJg2c2Hqk8mKT7Hz0B7lN9JvNsm4QCreS/jkD48iFv5EfDCFPbi5PSC+PVT8H/109I+5F6MZyqnbwsbYrP+k6z8qROGW8wRMVnePblp5yq+u8Qk8xjqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=TYRBQ3B/; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="TYRBQ3B/"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 5C1quLy9hjZe55C2Vu8KPO; Thu, 17 Apr 2025 00:19:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1744845571; bh=/kmbUB+q16OLoAX1Ktai3FPtuGvbh9wjvtuedrSTUbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TYRBQ3B/qeemhr2FcGiGAGEqPpzpEQ/hiQrXwX7BZxpEkZuSchUsgkmMY6xPOK5B6
	 numQ6Msc0iLJUfGBhU7NSxuq4QHzvhGSD2NAQHhP5Si5OdUL92UM9qS2cj5IK6vrpv
	 rqw0gpahUHE2NqcT4sfYCeeMd0+wM7NCJNpE9cq/9Ou+xNMJI3wNDrvnj4yMKipUR2
	 2O7vvglNndSxhnaFjE3O1Va45DT3jpxfjoRxN0MYkgsqNAu1MMwkgQVYBeD99fKas/
	 Pt5z12d5tywZDBMVgVQQeasoOCYNIMoAUoqhRJPIgnxHhZ5UzEGoZ4u9ZIB1c/6phL
	 XAHfBOxVmJLAQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UuDANPwB c=1 sm=1 tr=0 ts=68003b03
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=anev5XLoH9Hw9iYphZAA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 04/13] meson.build: set default help format to html on windows
Date: Thu, 17 Apr 2025 00:18:25 +0100
Message-ID: <20250416231835.2492562-5-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
References: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <20250416231835.2492562-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHa/7CXei91mTFPpZ5q0d0OegWpE+Z419sKa7lsB2bbBCqoTxVTaVFb0rHTlbb6AxaydKW5d6SEXowajKXxIdBGYc8Ic85RwOi3OhZXj0DIdxvba/MVV
 zMsOQq5XJwW8edNGrN+/kaSoBa9b7v7fUfSbdiWafMVlW2/Zv5sTeiONdx9dLdMc2WknT8FuVOTWxJn+G0n7o44TOMSUdz6Mq2k=

The build variable DEFAULT_HELP_FORMAT has an appropriate default
('man') set in the code, so there is no need to pass the -Define on
the compiler command-line, unless the build requires a non-standard
value.

In addition, on windows the make build overrides the default help
format to 'html', rather than 'man', in the 'config.mak.uname' file.

In order to suppress the -Define on the C compiler command-line, only
add the -Define to the 'libgit_c_args' variable when the requested
value is not the standard 'man'. In order to override the default value
on windows, add a 'platform' value to the 'default_help_format' combo
option and set it as the default choice. When this option is set to
'platform', use the 'host_machine.system()' method call to determine the
appropriate default value for the host system.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 meson.build       | 13 ++++++++++++-
 meson_options.txt |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index efd0bd3319..8f8a258064 100644
--- a/meson.build
+++ b/meson.build
@@ -694,7 +694,6 @@ endif
 libgit_c_args = [
   '-DBINDIR="' + get_option('bindir') + '"',
   '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
-  '-DDEFAULT_HELP_FORMAT="' + get_option('default_help_format') + '"',
   '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
   '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
   '-DFALLBACK_RUNTIME_PREFIX="' + get_option('prefix') + '"',
@@ -717,6 +716,18 @@ if pager_opt != '' and pager_opt != 'less'
   libgit_c_args += '-DDEFAULT_PAGER="' + pager_opt + '"'
 endif
 
+help_format_opt = get_option('default_help_format')
+if help_format_opt == 'platform'
+  if host_machine.system() == 'windows'
+    help_format_opt = 'html'
+  else
+    help_format_opt = 'man'
+  endif
+endif
+if help_format_opt != 'man'
+    libgit_c_args += '-DDEFAULT_HELP_FORMAT="' + help_format_opt + '"'
+endif
+
 libgit_include_directories = [ '.' ]
 libgit_dependencies = [ ]
 
diff --git a/meson_options.txt b/meson_options.txt
index 78d172a740..8ac30a5223 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -95,7 +95,7 @@ option('highlight_bin', type: 'string', value: 'highlight')
 # Documentation.
 option('docs', type: 'array', choices: ['man', 'html'], value: [],
   description: 'Which documenattion formats to build and install.')
-option('default_help_format', type: 'combo', choices: ['man', 'html'], value: 'man',
+option('default_help_format', type: 'combo', choices: ['man', 'html', 'platform'], value: 'platform',
   description: 'Default format used when executing git-help(1).')
 option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto'], value: 'auto',
   description: 'Which backend to use to generate documentation.')
-- 
2.49.0

