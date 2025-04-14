Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA11EA84
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665371; cv=none; b=XBTkRBJ2K8xiNlJI/RdF2xWLcwe+903QZnfxu8TP5mOhSZXFw8eaHKyYcXijUOeEVZqva9U+dyQTq3QDGNCxFAgRIR0bfVWxfguRriZsmjdQa2aOy3umEv9qwYzrGkGPghePzi3WIVBmI+y2gIbm0eg7Bt6eMoJjLnQnWsqfOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665371; c=relaxed/simple;
	bh=uV1/dWMmSzGfZOJ7b+/tpG60bB3pivLrnfPtu6DcE3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FiUpj6G4f1J8+fG9bKdKNPoPO8pWmdJU0lZb6EeRaY2ykM2d6PwV4roXa3muBk9H3T0OqJ7xcJxBeAAobu8CgiseGLvKu99uz/ESr3VFyeSfZz0Sddv8iw+IZ1xlVuRoxBpz89a5TMEhMYHOmsQpF7xfZOkmlwW6Rd2sCBLGNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EajUqWo2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EajUqWo2"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so8779285a12.2
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 14:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744665367; x=1745270167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pl5SQ3yuSOoBkxKDUGmlm0X/6nK4LGxYNXUqobeHsJE=;
        b=EajUqWo2YRsOIkg4WjQMvQaR00mOUyE4B1kDqy0nuCnSLZj8qBNwFJ3+2CNNHwzbnI
         J/+LcYdwd6Cw4Y5nJvlZuEP9jKPKSxdd90boLwcZe/Zc8OGqdHLfwxyVsniFJMmbp6nq
         ymlBCpH94vXKQv81zWmmn4pWJQbSY7XPMpCKiSohSEXQeF+5B1c2DBNInLrgknib3X8x
         0v6G3gyLT8JszSGpA7ioCEXw9s8zMwbFO2R54qU1OprjXFEEJSyP6rxWia6GtQVcu2vp
         B4utL+OeJGgXkOwLT3xEOFDl2KirWPZj7+bg3p9RLxuVT5DnV8dzREnNO0JtLFFai2qk
         ahfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744665367; x=1745270167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pl5SQ3yuSOoBkxKDUGmlm0X/6nK4LGxYNXUqobeHsJE=;
        b=NjXRbLgKc1uJ7KY6U7vQRFGooXLD0D8xeKGUtW0XmzfJpJR4Fa8zI8yH+1PiSil2ZB
         BwnClbkc5njAgsOC1753mnFAUGdtPpvwlnRouv4ZEgNGdonLAgNR0RzPGlLCNf4Lws2n
         T5mryHmiUh+EubiGodlPExNNuk8lGIqh9jfv9S63XEKX21+/qLl7sphEBIW+2Wilv+ct
         0VPnA7XKWe4YS12WjDtisOX1KwGcwkPItfJwvOI3/q/LoWJai9N6WCI7PCnYzOYCpASb
         mD44GJ6j0NfA4uif9aMasdXJfJxOYMg9NqBsh5hnRCIcjUVC0FXSiqcc41Fu0wHhdZXs
         yXMw==
X-Gm-Message-State: AOJu0YyB6xtH2Xpqj2Lp48uR+2/RxKaAp66DPiLE4F/ADL5s1BHbnpNu
	WjcYTtVMEKbnW7dg6V2/vDQi53BlQw9eNpbC3xziVuFKb3+CXqLv1FhVmQn0
X-Gm-Gg: ASbGncs0gCawMfrBKd2nv/BlX76IhdUJRdbAOc9mjdotCFWyjPk6U2JfBBBcKgyxgQt
	3Wrm1DsBpAnAZ3zqK9tFzOQb03POKwjFNBfGPtJR6pevSwMXNl1XWejdaCQ+noScwmiGRZxWCG5
	l3dOs/wDc9yT08ilkDcajbsuf8VFhZUusYQAbgHjmPScGOAyL0z0R5gGExNeH0B6A3mZw8B6Cvu
	1LBxdn3duA4UeElFF5x0NFoi7wUsjA62Ms89smAXHhhy9czF6VAg2M7ARah+ayzWWyh7PUfTEmv
	Ov250BGoUyBs6qj+966PHF5l1sMXirehNwtJH/86IPgannI=
X-Google-Smtp-Source: AGHT+IF4L3ppw0BXErA/burZP6YWQuthaT+Q4NSN6qRW2JNQEXYX1OWNcAEoor++HX3MdV+bV360XA==
X-Received: by 2002:a05:6402:2685:b0:5e4:cfe8:3502 with SMTP id 4fb4d7f45d1cf-5f36fede97bmr12652648a12.17.1744665367124;
        Mon, 14 Apr 2025 14:16:07 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:f62e:e088:2c58:70de])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54fb5sm5527518a12.13.2025.04.14.14.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 14:16:06 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 14 Apr 2025 23:16:01 +0200
Subject: [PATCH v3 3/4] meson: add support for 'hdr-check'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-505-wire-up-sparse-via-meson-v3-3-edc6e7f26745@gmail.com>
References: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
In-Reply-To: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3469; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=uV1/dWMmSzGfZOJ7b+/tpG60bB3pivLrnfPtu6DcE3Y=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf9exOw64KVx+J6202T734Jw0Nu+B6VgIN+V
 f/uQs51j+y04IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn/XsTAAoJED7VnySO
 Rox/7xIMAI9/V86muApdvKgaTdR1WD2vQVrpE0rPvsMAENmufnhH8v13v5cZMLrsNQUfZaWQd1U
 ml3GlaTSzTfnA7XN4a9k/+Fiu4aWpEQmN0x+nFQpwaK2K2gSegji4p/H6YA3DZ6v6BQYtBiD/G3
 hqFlzFlPj3oUTM/r94U8siDXxxXp73U26Tj/MF9/52PmNWYnLVEPFal3c56vubRFPeQlDPLLqwk
 GngGh9hs763Px1UvVRdtjyuBCkwk1ELhb6QNnL1bElW4IvaY899Q3nfZ8UcgWSrpHM0I6bHJVfi
 ZnerZJEx86NxaGgAZN3BJqt4SsdzT4L/M3WPNKx9+MuOoQdfLEARkuHmonWTc/FJwYChZ8C+UfW
 M+IzTH19l22c64NV2SwNUcyhE2snCWrLzm8JQ4bMmerBRpDpEbjnaxeZ7xyFw5pAQKtfQx74HAH
 EqKwRMKJ7XRTHMj4lyWgS9aFiSjqal3couGpMquPiCzW/cY7xm69yRenz/Powo4YdvYBRQQy147
 XI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The Makefile supports a target called 'hdr-check', which checks if
individual header files can be independently compiled. Let's port this
functionality to Meson, our new build system too. The implementation
resembles that of the Makefile and provides the same check.

Since meson builds are out-of-tree, header dependencies are not
automatically met. So unlike the Makefile version, we also need to add
the required dependencies.

Also add the 'xdiff/' dir to the list of 'third_party_sources' as those
headers must be skipped from the checks too!

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 meson.build | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/meson.build b/meson.build
index 3ca5d01071..b1be2b3cbb 100644
--- a/meson.build
+++ b/meson.build
@@ -646,6 +646,7 @@ third_party_sources = [
   ':!t/unit-tests/clar',
   ':!t/unit-tests/clar',
   ':!t/t[0-9][0-9][0-9][0-9]*',
+  ':!xdiff',
 ]
 
 if git.found()
@@ -655,6 +656,10 @@ if git.found()
   endforeach
 endif
 
+generated_headers = [
+  'command-list.h',
+]
+
 if not get_option('breaking_changes')
   builtin_sources += 'builtin/pack-redundant.c'
 endif
@@ -669,6 +674,7 @@ builtin_sources += custom_target(
   ],
   env: script_environment,
 )
+generated_headers += 'config-list.h'
 
 builtin_sources += custom_target(
   input: 'Documentation/githooks.adoc',
@@ -681,6 +687,7 @@ builtin_sources += custom_target(
   ],
   env: script_environment,
 )
+generated_headers += 'hook-list.h'
 
 # This contains the variables for GIT-BUILD-OPTIONS, which we use to propagate
 # build options to our tests.
@@ -1995,6 +2002,69 @@ endif
 
 subdir('contrib')
 
+exclude_from_check_headers = generated_headers
+exclude_from_check_headers += [
+  'compat/',
+  'unicode-width.h',
+]
+
+if sha1_backend != 'openssl'
+  exclude_from_check_headers += 'sha1/openssl.h'
+endif
+if sha256_backend != 'openssl'
+  exclude_from_check_headers += 'sha256/openssl.h'
+endif
+if sha256_backend != 'nettle'
+  exclude_from_check_headers += 'sha256/nettle.h'
+endif
+if sha256_backend != 'gcrpyt'
+  exclude_from_check_headers += 'sha256/gcrypt.h'
+endif
+
+if git.found() and compiler.get_argument_syntax() == 'gcc'
+  hco_targets = []
+  foreach h : headers
+    skip_header = false
+    foreach exclude : exclude_from_check_headers
+      if h.startswith(exclude)
+        skip_header = true
+        break
+      endif
+    endforeach
+
+    if skip_header
+      continue
+    endif
+
+    hcc = custom_target(
+      input: h,
+      output: h.underscorify() + 'cc',
+      command: [
+        shell,
+        '-c',
+        'echo \'#include "git-compat-util.h"\' > @OUTPUT@ && echo \'#include "' + h + '"\' >> @OUTPUT@'
+      ]
+    )
+
+    hco = custom_target(
+      input: hcc,
+      output: fs.replace_suffix(h.underscorify(), '.hco'),
+      command: [
+        compiler.cmd_array(),
+        libgit_c_args,
+        '-I', meson.project_source_root(),
+        '-I', meson.project_source_root() / 't/unit-tests',
+        '-o', '/dev/null',
+        '-c', '-xc',
+        '@INPUT@'
+      ]
+    )
+    hco_targets += hco
+  endforeach
+
+  alias_target('hdr-check', hco_targets)
+endif
+
 foreach key, value : {
   'DIFF': diff.full_path(),
   'GIT_SOURCE_DIR': meson.project_source_root(),

-- 
2.48.1

