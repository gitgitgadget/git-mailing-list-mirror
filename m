Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304A628B4FD
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205843; cv=none; b=tw8VnKjL2LmjhW6C4RXonpCo19uORp9oHqMEGAXaUFD5bn5EjIQulDF+5Qsni8DK9kK5QaHlUEqdRZP25GXtqwGrJGnSFzFEGtsBw82pfkyTu7rLjEIyJfxLvEUM1I+WO1RfySTmxglNblRLsVr8rupMSRi1XBmfcG6SKAB+G58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205843; c=relaxed/simple;
	bh=C/T3gFDw40mBKQpvu+qHmLI8cyPw2KrI8Fw9SdT5XPg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ipbK7KzeXZJ7XpNvPr6/++1sin48dRAJ5ru3iumo4z+wzPUO1aLHNDCMa85gAVJUT2SBbFr6V9O47c3Gh7/loILH8UWJrwGmnTdDxLRs0+EUKg8DmZkQ+MB3qHWZaerGCAIRtGtWNjHn6nAVEpCpyysX7A1hwvH+y4ImpuFvEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO5ogfdG; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO5ogfdG"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-9491604d00fso14177739f.2
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205841; x=1764810641; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y64Gpm3X5F+xH4GFazA4o5MZ8bEHaPJg/KdC3jF+oAI=;
        b=OO5ogfdGqHL+hn5IEx2muV2BEtA5vY7tTTPyvG62rkUfLH5c7ztFZyLXn7nWoRz7Ls
         PygUkuRe7IBDc1liy5Pd+mldC1w95pY9zyAZaO0rslEgv7DWajYBYdEZOOHbCGLkvy71
         GmN9jc4GJcLWu1/FcLh3Tz8XalFEB5bGNhPlzYNA9/eEh97h5lRFaVVWcdYAip6r1g3B
         PBnAh5V3/gbEkoj4Ng2LaW+q+lMsUBQ8t0QBp+szKvjiSfIcPccVftN5iWwm26qXz2E0
         VjhzYn5V2Sf68Zh7RHDjvjc6ZwQjoJjmxdaU3xfWiFwR0TwcP9pTtFvrdwJQx0yhoHu1
         RRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205841; x=1764810641;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y64Gpm3X5F+xH4GFazA4o5MZ8bEHaPJg/KdC3jF+oAI=;
        b=csCY5v9eoFSZ5S3Vb0u0x7Fxf3cUHZOxeO49eMll/y70gCXRZ1FIVHn3r1esvhw8B3
         r63a0wKeD0fKeQJX2BLRL+ey1f3DgtBswvdvdAobSCyKr+l7SsACtaRKfA8hpiTlSf3n
         tVcPHLJME+CnZ5nn/jgjee0E0mBWfM/ywlIL4fVEqwayTRpEIx1c8qSW6B3qZ2eH7+S3
         P6IPuODQXTvaXkVtqQ1lE38sssjyR42UJhwQFlqnTFOiVk5B/fR2OnV+RTYOptfdcB+/
         LgYGwAlVXZ3Xi3h/G8kkH4ZM1G6upHqLkVigfsz+i1Ht2yN68b5SpQ+7lKWUnA3r0IcT
         IgHg==
X-Gm-Message-State: AOJu0YyG/VAlgNNTYPFTQH/r3cNIyv+qecODuGNbKWQ3wii2UbHmDA45
	okR52nSzq9PFYfcNSLXUcVhqPY/zhOJyFr11BipzUmnzfZSFdOBb+VpgW8YWCn1F
X-Gm-Gg: ASbGncuNryeatqy1wY9XNz9nPuMSe5kpu9VhgF6qyAd13ZDKFJxKzSWDNnbjZaZTfed
	tCIJOUAsQ4Iipx3FeDgEwJzMWDnSklLUfnVAR+KqhJn6m4ocXEecDn3vEMdB5F68myI7ynTAQBd
	hTsWKUEpkrIPvyQ/0OBXLJMeDdvXY8BUL7qNpewnFfQPwVIjD5VHrBQ5VL0Yfdvfdr45yXS3mWe
	Uy2RxuC7sQEuh6O69AKo65MRz+zhJ/AaAOSt2KRYSlnbBD0zdjjYbGtBfG1Q0KMP68/xxNXOn3E
	kAIuLkZ1RgvqRC8pqrA0fkPlaenxu/u+GdlcBKRyjDA/0F1jQjYbsnoOAAZQDkULAnfWJbiAS6x
	iHZalYwMx74GJI+ASMDDIJUts0aGKZqAEa6oit6yOMYEDtnBQ+aIDkEdKEx6Kk00/xYiXdMTUMb
	eEkT9s1fUQpq4oiw==
X-Google-Smtp-Source: AGHT+IGq53MoUdFpN4NXQIYfYRh463nPLYNBMj+2+2QdvLW0Z/H7VnJf/751ej+RNqAWNKmLq/RKDg==
X-Received: by 2002:a05:6638:6809:b0:5b7:c88e:1837 with SMTP id 8926c6da1cb9f-5b967a8b201mr13778352173.16.1764205840807;
        Wed, 26 Nov 2025 17:10:40 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954a0de5esm8982456173.6.2025.11.26.17.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:40 -0800 (PST)
Message-Id: <dd8787e3e07a567acf56c23c69599aaefd87b3b0.1764205835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
References: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:24 +0000
Subject: [PATCH 02/13] meson: undo Patrick's changes concerning Rust
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 meson.build        | 19 ++-----------------
 meson_options.txt  |  4 ++--
 src/cargo-meson.sh | 39 ---------------------------------------
 src/meson.build    | 41 -----------------------------------------
 4 files changed, 4 insertions(+), 99 deletions(-)
 delete mode 100755 src/cargo-meson.sh
 delete mode 100644 src/meson.build

diff --git a/meson.build b/meson.build
index 2b763f7c53..8966596ee8 100644
--- a/meson.build
+++ b/meson.build
@@ -220,7 +220,7 @@ project('git', 'c',
   # learned to define __STDC_VERSION__ with C11 and later. We thus require
   # GNU C99 and fall back to C11. Meson only learned to handle the fallback
   # with version 1.3.0, so on older versions we use GNU C99 unconditionally.
-  default_options: meson.version().version_compare('>=1.3.0') ? ['rust_std=2018', 'c_std=gnu99,c11'] : ['rust_std=2018', 'c_std=gnu99'],
+  default_options: meson.version().version_compare('>=1.3.0') ? ['c_std=gnu99,c11'] : ['c_std=gnu99'],
 )
 
 fs = import('fs')
@@ -1709,21 +1709,6 @@ version_def_h = custom_target(
 )
 libgit_sources += version_def_h
 
-cargo = find_program('cargo', dirs: program_path, native: true, required: get_option('rust'))
-rust_option = get_option('rust').disable_auto_if(not cargo.found())
-if rust_option.allowed()
-  subdir('src')
-  libgit_c_args += '-DWITH_RUST'
-
-  if host_machine.system() == 'windows'
-    libgit_dependencies += compiler.find_library('userenv')
-  endif
-else
-  libgit_sources += [
-    'varint.c',
-  ]
-endif
-
 libgit = declare_dependency(
   link_with: static_library('git',
     sources: libgit_sources,
@@ -2270,7 +2255,7 @@ summary({
   'pcre2': pcre2,
   'perl': perl_features_enabled,
   'python': target_python.found(),
-  'rust': rust_option.allowed(),
+  'rust': get_option('with_rust'),
 }, section: 'Auto-detected features', bool_yn: true)
 
 summary({
diff --git a/meson_options.txt b/meson_options.txt
index 143dee9237..0059b7c7df 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -71,8 +71,8 @@ option('zlib_backend', type: 'combo', choices: ['auto', 'zlib', 'zlib-ng'], valu
 # Build tweaks.
 option('breaking_changes', type: 'boolean', value: false,
   description: 'Enable upcoming breaking changes.')
-option('rust', type: 'feature', value: 'auto',
-  description: 'Enable building with Rust.')
+option('with_rust', type: 'boolean', value: true,
+  description: 'Enable building with Rust, true by default.')
 option('macos_use_homebrew_gettext', type: 'boolean', value: true,
   description: 'Use gettext from Homebrew instead of the slightly-broken system-provided one.')
 
diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
deleted file mode 100755
index 3998db0435..0000000000
--- a/src/cargo-meson.sh
+++ /dev/null
@@ -1,39 +0,0 @@
-#!/bin/sh
-
-if test "$#" -lt 2
-then
-	exit 1
-fi
-
-SOURCE_DIR="$1"
-BUILD_DIR="$2"
-BUILD_TYPE=debug
-
-shift 2
-
-for arg
-do
-	case "$arg" in
-	--release)
-		BUILD_TYPE=release;;
-	esac
-done
-
-cargo build --lib --quiet --manifest-path="$SOURCE_DIR/Cargo.toml" --target-dir="$BUILD_DIR" "$@"
-RET=$?
-if test $RET -ne 0
-then
-	exit $RET
-fi
-
-case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
-	*-windows-*)
-		LIBNAME=gitcore.lib;;
-	*)
-		LIBNAME=libgitcore.a;;
-esac
-
-if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
-then
-	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
-fi
diff --git a/src/meson.build b/src/meson.build
deleted file mode 100644
index 25b9ad5a14..0000000000
--- a/src/meson.build
+++ /dev/null
@@ -1,41 +0,0 @@
-libgit_rs_sources = [
-  'lib.rs',
-  'varint.rs',
-]
-
-# Unfortunately we must use a wrapper command to move the output file into the
-# current build directory. This can fixed once `cargo build --artifact-dir`
-# stabilizes. See https://github.com/rust-lang/cargo/issues/6790 for that
-# effort.
-cargo_command = [
-  shell,
-  meson.current_source_dir() / 'cargo-meson.sh',
-  meson.project_source_root(),
-  meson.current_build_dir(),
-]
-if get_option('buildtype') == 'release'
-  cargo_command += '--release'
-endif
-
-libgit_rs = custom_target('git_rs',
-  input: libgit_rs_sources + [
-    meson.project_source_root() / 'Cargo.toml',
-  ],
-  output: 'libgitcore.a',
-  command: cargo_command,
-)
-libgit_dependencies += declare_dependency(link_with: libgit_rs)
-
-if get_option('tests')
-  test('rust', cargo,
-    args: [
-      'test',
-      '--manifest-path',
-      meson.project_source_root() / 'Cargo.toml',
-      '--target-dir',
-      meson.current_build_dir() / 'target',
-    ],
-    timeout: 0,
-    protocol: 'rust',
-  )
-endif
-- 
gitgitgadget

