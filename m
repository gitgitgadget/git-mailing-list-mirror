Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0B970814
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743968554; cv=none; b=ZEEAVghDqPiOXPn+yWsLLdbAKThYvVi5BZ8xMFzNLlfbzQVsatz0uckue3cYMDdEBLPw5fmKX65EYg6P6XZSZX39iI631d8f8QNaPz95cMM9eXVygWcbr4wi2XxOTYRpS0+IhJGH+tmWFKzdC46+sOkBIWfnD3hkAAaX6PgM4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743968554; c=relaxed/simple;
	bh=CPmYKMmTb9AXzVMVfvG7PCfEyENCM/NIr7hl6XLnyN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJeCDTGjFKbpO4B3keopdJNXvrt4p3w3tJpo26i0tQS8amrz0Ezl1RWzrNBHz6c36bemvA2ZQr8lTb4H2+tTsY4dDYA0FSv99pVxQ6Q6pO+RPHsIe596k1p7JJcqKdO1PllOWNVktO23sRu2xRnfqJXKu8RcU7zuEade4POV0qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=FkTxaNwA; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="FkTxaNwA"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id 1VpUuYqwzbpaN1Vq8upkLU; Sun, 06 Apr 2025 20:39:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1743968373; bh=/kmbUB+q16OLoAX1Ktai3FPtuGvbh9wjvtuedrSTUbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FkTxaNwAQio3yxuox3AQzhMPE4JsVNb5vBgqtolupqE+yRCwAumSB9X9TaGneO9bE
	 6fs/1eMbt/PfOEv8YgfDuleFx1O4CHiHfyJT4FUjwsdKqhPtHb8l7jOhNcCWU65xjL
	 cRYfeRuAKCZFVe2KWwkRmtwZeoEfDABnwSqam2sT71Si0et6vQpVrirvE2xkdFdVim
	 6FbIk3/2CHcI6rFVFF2Nx/zmtSncAy+O0Bs2pQKF5L/qUrthlZKXi7m/housBFm5FJ
	 rfj+XOTyGBhQQTrykZErtvD6eHyULPJs7vyA2KI8eC0vo2omAhTJ+yySJijU+OZ6B4
	 sm0Jj5jc+gKFQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frZ/Z04f c=1 sm=1 tr=0 ts=67f2d875
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=anev5XLoH9Hw9iYphZAA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Adam Dinwoodie <git@dinwoodie.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 04/13] meson.build: set default help format to html on windows
Date: Sun,  6 Apr 2025 20:38:30 +0100
Message-ID: <34349bf98c5b01dd1b73065448b616517bb784a3.1743859985.git.ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743859985.git.ramsay@ramsayjones.plus.com>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com> <cover.1743859985.git.ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJVxKdMhU4a+Pz3Y1S+qj9h92FgtiqEqYon8xTxb67iUY2/RkHZ4onIW/07Mmlg6Yk2i18t6SbwUN8wlyGgVEJGvnCKOV/a8N01/8dYRnymXD/PnJNZM
 TIopzY2UIEICq3//EqMNcpSo7qRzBMBmxx5MlSh96rWyCEZp/CzT4hVd0NW779VTWXRQkof0lPi192g/NtPuOKAseZzQzgf3wxw=

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

