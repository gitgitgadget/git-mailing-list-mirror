Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80F14F9EB
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507787; cv=none; b=bLBNqr900teqaV4a5aWQYA04m1PN/dLf7ok+xPByM3HC+XgiLvO1/i0A9vk0tzMnhyXIALbIkikSw3cWi/nDBQx6c5tksf5RvmRRIZxbwS8n14YJQOPFBUlnXjCbDHJnqvTtClfZ32LqqN9vTa9Ds/RUJFAj8l7rLVxTMhXA3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507787; c=relaxed/simple;
	bh=fO63y+zPXfN+XtL4rE2mXRvAf/HBkgMREeL/2rxKZS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iHZHt+sjq0ODViVNspx50esJy5JuGH4wTeG+32IzUsP+mibTGuCHXLyATWsw3tIUjzY+NnICWzOl42E9kSKWFGHWtmmJ+ICjGIrsKF+za67Nq+dg4UZC13fB6vt3fSQDmnrzfpwxyzMOS9RPt7FQ+yH/c2oLxnuHWwF+Ag/+Klw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ8p2vsj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ8p2vsj"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-301302a328bso1600670a91.2
        for <git@vger.kernel.org>; Thu, 24 Apr 2025 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745507785; x=1746112585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bmVfJT8MpcsS/hp0qJ3/CUmYLdkB/jCnsls/7RiUkj4=;
        b=gQ8p2vsjAb3hib5NkkJAroAdfYRFZpq4ESqt1fzy8T2QWWwtPKkQ/fAT/GCm1iIdG0
         VFHZHlZ7S5nyg3ZWN2g6lfVOWPra+ZtE0qIKCqpmZX4Rg0HmkZReUWIXITZoIct4STyQ
         dWMhTQO+n+PNFtx+AWyMNnk7+Dn5f0VXmapfvj5eGpjyFy+00us/P2irHGblp+N9A3gj
         bR1zX8l2yArzYOyrUtW7aFlAnMuZXT5IEQZKfFe9k7MwPwbjrc0766RHLuS4iDxRe1gF
         ptYLPLmnEDrpnWo8dq0PFadDSp0MUOwvxE0NguVYwlcZ+pd2YiCE+e+EPhBnQj7e2LIR
         nKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745507785; x=1746112585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmVfJT8MpcsS/hp0qJ3/CUmYLdkB/jCnsls/7RiUkj4=;
        b=OujVL2Z//Jzo961h0wCIGgqIOc6qcX5ygddS74JxBWPbkQ8zSweP6PoA+9/A9AwhwE
         ORT4A3HgaIqwg5+/9fNzqmjhrjed4HYnqRil6MFGicq2csz2NzGOCKBSpPl3q0m7Qi+U
         9wb4jsBdzUaGJRguW1UdOgVS0G6oQqhfJbp3+KP3XCrbH2GMNqmvBX4Z3dF8COBY9Wt7
         ZB8miweIt3Db0Y4BBkBumyBA1NUDqPUqdPXyVgJEVsuqasd1CRXH4Qf9roWwZRGN3qpy
         zVSDgldPxY2nSVvR5yyFDkRFwHAWqAxzxwutR7Wv9qVwdxlaMNkAcEIGP4/XPtP7BQWa
         307A==
X-Gm-Message-State: AOJu0YymHThkbiIfYukOcH3H+W2B8yQNptQiBqwRAO1bxqdQkULy98N/
	yLCWuf5pJPnsTxHA2dHV2leG8JF194Aa6FkoTWN+LacTf7NDF/juokmLEg==
X-Gm-Gg: ASbGnctngmYVrY8+lDlvD0a0A5vaY9JE++k0TGfHT6t46hBnB7o7zMVo8Ik5Gtq0moq
	tyUGC2FeArFk7lumnHcB0py9APj8AVDgdaeXZg5M0gGuAUwUkjGuBs5EeQ4VFGB/EWcHvzm49QU
	v8vFpzpjYVL2onx9lM+BgRTF1j5fhNX4lcxAHxgHxlq4A2K6u1S7kAZyw5VuA/0lfuncZfnAz9o
	qoCwrmhFgIGamw797ILvQNVxSakBsDPGcflYufRTw6CpiPkwaxmP702m0PkJLn9TK1qfRaRkQwJ
	ELSkS84iTPeFb1ajLdQFG1dPv1prDbhdqClGhKPuJZwLEkiJVf8=
X-Google-Smtp-Source: AGHT+IFn0UjrexUEBYhbAZ6JIcE9cbP3xftd8YsLdm9zunC+lVsjvYbW5OaYyCvEpQU3XYQZCzRCHA==
X-Received: by 2002:a17:90b:586b:b0:2ee:fa0c:cebc with SMTP id 98e67ed59e1d1-309f555021dmr126415a91.20.1745507784975;
        Thu, 24 Apr 2025 08:16:24 -0700 (PDT)
Received: from localhost.localdomain ([14.191.94.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef12466asm1490285a91.39.2025.04.24.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:16:24 -0700 (PDT)
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH] meson: allow customize perl installation path
Date: Thu, 24 Apr 2025 22:16:18 +0700
Message-ID: <80a2a6ce7c6b05323cf931cdc20d4decb6270002.1745507677.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557ceb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some distros, notably Fedora, want to install non-core Perl libraries
into specific directory, namely /usr/share/perl5/vendor_perl.

The Makefile build system allows this by overriding perllibdir variable,
let's make meson works on par with our Makefile.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 meson.build                        | 9 +++++++--
 meson_options.txt                  | 5 +++++
 perl/FromCPAN/Mail/meson.build     | 2 +-
 perl/FromCPAN/meson.build          | 2 +-
 perl/Git/LoadCPAN/Mail/meson.build | 2 +-
 perl/Git/LoadCPAN/meson.build      | 2 +-
 perl/Git/SVN/Memoize/meson.build   | 2 +-
 perl/Git/SVN/meson.build           | 2 +-
 perl/Git/meson.build               | 2 +-
 perl/meson.build                   | 2 +-
 10 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/meson.build b/meson.build
index 223384b130b62..830deb9a069a6 100644
--- a/meson.build
+++ b/meson.build
@@ -1826,14 +1826,19 @@ if perl_features_enabled
     perl_header_template = 'perl/header_templates/runtime_prefix.template.pl'
   endif
 
+  perllibdir = get_option('perllibdir')
+  if perllibdir == ''
+    perllibdir = get_option('datadir') / 'perl5'
+  endif
+
   perl_header = configure_file(
     input: perl_header_template,
     output: 'GIT-PERL-HEADER',
     configuration: {
       'GITEXECDIR_REL': get_option('libexecdir') / 'git-core',
-      'PERLLIBDIR_REL': get_option('datadir') / 'perl5',
+      'PERLLIBDIR_REL': perllibdir,
       'LOCALEDIR_REL': get_option('datadir') / 'locale',
-      'INSTLIBDIR': get_option('datadir') / 'perl5',
+      'INSTLIBDIR': perllibdir,
       'PATHSEP': pathsep,
     },
   )
diff --git a/meson_options.txt b/meson_options.txt
index 78d172a74019a..43f3f2d234a8e 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1,3 +1,8 @@
+# Configuration for Git installation
+
+option('perllibdir', type: 'string', value: '',
+  description: 'Directory to install perl lib to. Default to <datadir>/perl5')
+
 # Configuration for how Git behaves at runtime.
 option('default_pager', type: 'string', value: 'less',
   description: 'Fall-back pager.')
diff --git a/perl/FromCPAN/Mail/meson.build b/perl/FromCPAN/Mail/meson.build
index b4ff2fc0b24c9..467507c5e690e 100644
--- a/perl/FromCPAN/Mail/meson.build
+++ b/perl/FromCPAN/Mail/meson.build
@@ -3,6 +3,6 @@ test_dependencies += custom_target(
   output: 'Address.pm',
   command: generate_perl_command,
   install: true,
-  install_dir: get_option('datadir') / 'perl5/FromCPAN/Mail',
+  install_dir: perllibdir / 'FromCPAN/Mail',
   depends: [git_version_file],
 )
diff --git a/perl/FromCPAN/meson.build b/perl/FromCPAN/meson.build
index 1f9ea6ce8e844..720c60283d89b 100644
--- a/perl/FromCPAN/meson.build
+++ b/perl/FromCPAN/meson.build
@@ -3,7 +3,7 @@ test_dependencies += custom_target(
   output: 'Error.pm',
   command: generate_perl_command,
   install: true,
-  install_dir: get_option('datadir') / 'perl5/FromCPAN',
+  install_dir: perllibdir / 'FromCPAN',
   depends: [git_version_file],
 )
 
diff --git a/perl/Git/LoadCPAN/Mail/meson.build b/perl/Git/LoadCPAN/Mail/meson.build
index 89cde56be8491..05a5770560d3d 100644
--- a/perl/Git/LoadCPAN/Mail/meson.build
+++ b/perl/Git/LoadCPAN/Mail/meson.build
@@ -3,6 +3,6 @@ test_dependencies += custom_target(
   output: 'Address.pm',
   command: generate_perl_command,
   install: true,
-  install_dir: get_option('datadir') / 'perl5/Git/LoadCPAN/Mail',
+  install_dir: perllibdir / 'Git/LoadCPAN/Mail',
   depends: [git_version_file],
 )
diff --git a/perl/Git/LoadCPAN/meson.build b/perl/Git/LoadCPAN/meson.build
index 1ee915c650517..b975d4972631d 100644
--- a/perl/Git/LoadCPAN/meson.build
+++ b/perl/Git/LoadCPAN/meson.build
@@ -3,7 +3,7 @@ test_dependencies += custom_target(
   output: 'Error.pm',
   command: generate_perl_command,
   install: true,
-  install_dir: get_option('datadir') / 'perl5/Git/LoadCPAN',
+  install_dir: perllibdir / 'Git/LoadCPAN',
   depends: [git_version_file],
 )
 
diff --git a/perl/Git/SVN/Memoize/meson.build b/perl/Git/SVN/Memoize/meson.build
index 233ec670d7de9..4c589b30c387a 100644
--- a/perl/Git/SVN/Memoize/meson.build
+++ b/perl/Git/SVN/Memoize/meson.build
@@ -3,6 +3,6 @@ test_dependencies += custom_target(
   output: 'YAML.pm',
   command: generate_perl_command,
   install: true,
-  install_dir: get_option('datadir') / 'perl5/Git/SVN',
+  install_dir: perllibdir / 'Git/SVN',
   depends: [git_version_file],
 )
diff --git a/perl/Git/SVN/meson.build b/perl/Git/SVN/meson.build
index 44abaf42b7cea..8858985fe8660 100644
--- a/perl/Git/SVN/meson.build
+++ b/perl/Git/SVN/meson.build
@@ -13,7 +13,7 @@ foreach source : [
     output: source,
     command: generate_perl_command,
     install: true,
-    install_dir: get_option('datadir') / 'perl5/Git/SVN',
+    install_dir: perllibdir / 'Git/SVN',
     depends: [git_version_file],
   )
 endforeach
diff --git a/perl/Git/meson.build b/perl/Git/meson.build
index b21fa5591e7e7..a61b7b1f4abf2 100644
--- a/perl/Git/meson.build
+++ b/perl/Git/meson.build
@@ -10,7 +10,7 @@ foreach source : [
     output: source,
     command: generate_perl_command,
     install: true,
-    install_dir: get_option('datadir') / 'perl5/Git',
+    install_dir: perllibdir / 'Git',
     depends: [git_version_file],
   )
 endforeach
diff --git a/perl/meson.build b/perl/meson.build
index 2d4ab1c4a986f..3c66b007eaad9 100644
--- a/perl/meson.build
+++ b/perl/meson.build
@@ -3,7 +3,7 @@ test_dependencies += custom_target(
   output: 'Git.pm',
   command: generate_perl_command,
   install: true,
-  install_dir: get_option('datadir') / 'perl5',
+  install_dir: perllibdir,
   depends: [git_version_file],
 )
 
-- 
2.49.0.395.g12beb8f557ceb

