Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419626ADD
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858166; cv=none; b=ECRlaUxaura0C5IK4MBSBQrOVUcDaXaOpF3QozAZFsEMAlyfdLL4LrAwErvFRDp+cwAFrXNlG4JoMK74E8czrafgENugzYPMAPWlfn7SSy+dzvd++PmgAwxMwPJF+COKkU6OGLdnyIBqBR+OTA+FSR6OTYvl6NGEa4YuHM6p7sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858166; c=relaxed/simple;
	bh=A6MvewiZyWbi8SEDyLVDT6vtKam9vQHEKkE4196MYNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IulD+XLfoUURTSSjetARJ98vGBlGO5AXSJP8Y1C0VYo428b4GehH3dev4otsDai77bIyTnk3nLyz7O3AmowwjsRxH/aHvvOcxPsSpvUC3lxlhyHidbxD5LURmD7uCVNH3CgKSNwQh28x4ufFWun9Yz4/S5x2TH3DqMQxksevJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMNH+WSk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMNH+WSk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23526264386so21030595ad.2
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752858164; x=1753462964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+EXZMf6HC/xf6aTquIVyNMVCzonlXgQs2Jsr6TzNeg=;
        b=NMNH+WSkMMhCV80hrljhKN6XWNnLYa9oGt/FEHb3Q6Llp1ROg7X+MdP+MSavljlaty
         /w7H5GmMjcP27ZbBbeWgUDIpRQJQZDwYiTmKwqbG4mErQI7LPLl6Hy5YXRJoKAmDadFj
         Xrvy3+H4cEiQ2lug0HXL7B4iWx5LC1+dbXDYFAI4QdFOspO/n1txPqL22olJKhDs6oLB
         8xrmHv2kmrkITxQsjbnvoZsDwf9972xG3b3RPB1cA2kNqtTAXn85h+dEcFhfRCHlBAYV
         b5OLsSyVimkxogL9WU5ykcZ8f6n8ATKNjSQqG0c9lidAVmI9xWnAmrXm/7qlZwzzmyzY
         ZBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752858164; x=1753462964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+EXZMf6HC/xf6aTquIVyNMVCzonlXgQs2Jsr6TzNeg=;
        b=H+h3VuX46N4JbPI6+tn13UykZbG2sos5UXAxVhuEWCg0owdCvQL69wgz6Of1+yKJkg
         2M3gtupZHva1HM1IJeT5/uvcbS1WG5zxTsBFdVVPieFiTYWBi4V8zOrtEe++4M0e1h8O
         P2XnvD4IGDJBj/8kgZ8a2VmYUxr0pkjvzbhLH9ByHotXnuiAiENvVgEatDHSz08zKUpF
         nzfOAAMtOMbr9WGzSFaMRFCMGhaks4V4GmFScmvdQt+tycrcZEg1OvnhZnWFI237yleu
         72dBEEu+GtGTe5d5ts04AJkO3q0NraJeI8PssNkoYOLDUBrM2qzS88vqeEW/qBoViCZC
         XyQg==
X-Gm-Message-State: AOJu0Yxj4CHfJpQ5LomJcAuB61CTRpjrNfjphg/c4UQWrTEKytPc7bZT
	UOHVaMkCkSTRG8OPc/nqT09meTe91gU5iwTKrP2L4U3455xlgFi6GYevGCsf7g==
X-Gm-Gg: ASbGncu49HPXbLyxqKsEWQZimIr/yM6mRRz8O3b2mtNI/NDO+KSHzSMPFnEntX2GrGo
	nOUJQD75QgAur3uiX+vJD21yX9lVdaWXIHOxLWGoxENrINi18Am0Fj7s6oPLe3gKYnAJqlj+VxP
	Xw0cyAFpdUSkRI1uFWBmeSSjTS/xrg10lPJEfn1MwfJ8rbCTYZRw2yQHwGhOzO4jTboAaPGgTX2
	+YdA5V6muhMaOc58jNG7cYGy126t7lBxhgsi+oY6yvsDZmfZ9YDMPtqijbg7sbOYmO5HpIN2V4h
	KT7VSM93dZ8u5GvsNrFXHyljFss0iDAyeqLNbNlWefK6yd7F7mWNTilnelF4iiwzBJ2kGOV4ZUl
	2H2P85ruWe71+bxbKu1FmsAlyWYR5Om8JZauNYqHKuP8pgh6HQvlRxW6sdbxoEJXw8oZTkT0A
X-Google-Smtp-Source: AGHT+IEpmnrR0eMZRdv+TPXyqzUqNMJqfEx/D8PRwfsWxOajA6lYEGtFNvhhryo6SRO9pX/8P7kY1Q==
X-Received: by 2002:a17:902:e5d2:b0:234:8f5d:e3bd with SMTP id d9443c01a7336-23e25764c9fmr169187455ad.39.1752858163039;
        Fri, 18 Jul 2025 10:02:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d8825sm15796055ad.169.2025.07.18.10.02.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Jul 2025 10:02:41 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	sandals@crustytoothpaste.net,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: [PATCH v6] meson: work around broken system PCRE2 dependency in macOS
Date: Fri, 18 Jul 2025 10:02:25 -0700
Message-Id: <20250718170225.6063-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716193000.44673-1-carenas@gmail.com>
References: <20250716193000.44673-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

macOS provides a PCRE2 library in base that is not usable and not
configured properly, as it installs a pkgconf module that
points to a non-existent pcre2.h header in /usr/local/include.

Detect that case and if the feature is enabled, try to fallback
to a wrapped subproject through an anonymous dependency, aborting
with an error if that is not possible.

Change the feature to "auto" and print a warning and disable it
if a broken dependency was detected, but to keep consistency
with the cmake build system used on Windows, add a special rule
to re-enable the pcre2 feature by default there.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Suggested-by: Eli Schwartz <eschwartz@gentoo.org>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 meson.build       | 28 +++++++++++++++++++++++++++-
 meson_options.txt |  2 +-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 596f5ac711..5225efb4a6 100644
--- a/meson.build
+++ b/meson.build
@@ -1055,7 +1055,33 @@ else
   build_options_config.set('NO_ICONV', '1')
 endif
 
-pcre2 = dependency('libpcre2-8', required: get_option('pcre2'), default_options: ['default_library=static', 'test=false'])
+# can't use enable_auto_if() because it is only available in meson 1.1
+if host_machine.system() == 'windows' and get_option('pcre2').allowed()
+  pcre2_feature = true
+else
+  pcre2_feature = get_option('pcre2')
+endif
+pcre2 = dependency('libpcre2-8', required: pcre2_feature, default_options: ['default_library=static', 'test=false'])
+if pcre2.found() and pcre2.type_name() != 'internal' and host_machine.system() == 'darwin'
+  # macOS installs a broken system package, double check
+  if not compiler.has_header('pcre2.h', dependencies: pcre2)
+    if pcre2_feature.enabled()
+      pcre2_fallback = ['pcre2', 'libpcre2_8']
+    else
+      pcre2_fallback = []
+    endif
+    # Attempt to fallback or replace with not-found-dependency
+    pcre2 = dependency('', required: false, fallback: pcre2_fallback, default_options: ['default_library=static', 'test=false'])
+    if not pcre2.found()
+      if pcre2_feature.enabled()
+        error('only a broken pcre2 install found and pcre2 is required')
+      else
+        warning('broken pcre2 install found, disabling pcre2 feature')
+      endif
+    endif
+  endif
+endif
+
 if pcre2.found()
   libgit_dependencies += pcre2
   libgit_c_args += '-DUSE_LIBPCRE2'
diff --git a/meson_options.txt b/meson_options.txt
index e7f768df24..1668f260a1 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -45,7 +45,7 @@ option('gitweb', type: 'feature', value: 'auto',
   description: 'Build Git web interface. Requires Perl.')
 option('iconv', type: 'feature', value: 'auto',
   description: 'Support reencoding strings with different encodings.')
-option('pcre2', type: 'feature', value: 'enabled',
+option('pcre2', type: 'feature', value: 'auto',
   description: 'Support Perl-compatible regular expressions in e.g. git-grep(1).')
 option('perl', type: 'feature', value: 'auto',
   description: 'Build tools written in Perl.')
-- 
2.39.5 (Apple Git-154)

