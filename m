Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0910F9
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665369; cv=none; b=rFMJWN3FCgeYCn80mFwgXn/6tCq/TSLCTMW+lIxW3+udKuE/we5A66g1dSZ/8idGUVVS3e3yPj3Kcu0sik2A3tqJP0KeG6RQzS3WkTjcIZYipW5jPAxA/ICYtTLUcsAdM5fia4OgFQd+efd5b7DFoJeXQHauHiP4hRFvmljidsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665369; c=relaxed/simple;
	bh=e+95IPB3knNRUNiUbfCBrW3kFUIwqBobJcWY+hvhoDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mt6yNS9EGaTyCnZvdF6NOF0C/dsMYyfRqUggxB360/ZYxPnnvGXGEntZkgr3P/WPrPZYhL2ES6y+Gub1a4R8c+3jub6AnEqGsvBJcJ9rVxMUwQ2XuUyoeO7zuPCvAunODtQlO4aGiNmb+jjsV+djO0JfhahApomQYyFDRAk4k7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR3p3hnB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR3p3hnB"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so3041324a12.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 14:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744665366; x=1745270166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qt7zca6xyyA6tmgnZeVe/9iIYYImPXm7IOxdbbsEAKs=;
        b=IR3p3hnBjpvIVr8wfNAS6dN+vfA+uDvQUiGEkuYKFH5RFnfuZjB1ykMiewp2JxI7d2
         XyXwKrTtSLbgRa578CZvVHM2azm843uxSz5ZqlruNoImQpXRT/8UVddJ5DeADsCTd6eM
         0gySQpF3XL63SuucAfKE1h0mvq44rRJ2kft467gGWIRpKycTvOPlptNMmA2IdBWLBg4t
         tO9iRcCHWEDxaJRLwDSAR2b8QEebDeUe0bUwuiNZycDEvw38tFe77b7UPM02JZzulTB2
         DfjWHSlqaLuwCwusUowUn6N9ZKNbGPv+vMhAubPL5Xy6S7wlvd08NhtCH0TZ+JcysACt
         GEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744665366; x=1745270166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qt7zca6xyyA6tmgnZeVe/9iIYYImPXm7IOxdbbsEAKs=;
        b=qX3wobIfXDlxY7KCcza565HWYYQhkSG1lcVnCWsQ0+khnUtE2ZTTNWIv3fOC36QvXF
         ErKsXenBfDq9vvj7olKHoIPzAq4HuH3fwPWKRIoecC1z/m3kdCuSSjP6bsmINWl9FQVB
         DBhyRcbtnqw8LJtsyEf+SXno8cKKz8DAKOZhLN7uDw9cYWIrFTwU7LLK5PrQj+qPz0y/
         rai4WE8XPeTmuj3NvXsjXc6ZlLUcIpcHKdaH7OhfE4Py/63oSBDSls2TwJu15FMK58GJ
         dHMk+9spR8bpcZgDjlYLA4Zz+V1nh3gVvlKWSwos1cnJ/ML+m2Ce7vzO/mgtels0XSRq
         AIBA==
X-Gm-Message-State: AOJu0YyJfG0TFPReAYej/LOhRfTygnS2d7G+OKllAJmP+tiwFCkl12q0
	qZ5QpvrsIezp+q6ci/jyomNHEQcqndA9GBsGi9FCiOBVumwWLxET
X-Gm-Gg: ASbGncvFUEgytmTLc/KS+NHn2n0u8W9w9utLEX54MdHKzJw62Nrk31BAImjfZm2g7t2
	STEcf6gx6oSROU/UOmMlpgA6bdLC51IRe4SHVMm+sEvoNE6Vcbgm92WURHXstK8/zDtsVfsD/te
	qszt/Yyb2G0CKkiLos0mJPkXF9hTONnZpmFt981su1zw/9eqWcP4JXK+3UU+z9U8cMhkFT1ycqu
	TTHB/STLM+jIbUO/meIRQVCybnvfJ5OzC6NTOGKA2ITaxjzunKSTH/Qa1K/hvTTBBYabnLBgNar
	THzd9U1HdxIAurD/EMn4DN3GcWaCFZceu0cZv86hhz3CdoE=
X-Google-Smtp-Source: AGHT+IF1B2shx1/Q1caqngOY/r+lTCMkwaFRM1UtCdbHUFlUSE1l0iVVg1pWnyp09LUd3xl7bv/3Ng==
X-Received: by 2002:a05:6402:3482:b0:5e0:8a34:3b5c with SMTP id 4fb4d7f45d1cf-5f45ddf1f6dmr765911a12.0.1744665366153;
        Mon, 14 Apr 2025 14:16:06 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:f62e:e088:2c58:70de])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54fb5sm5527518a12.13.2025.04.14.14.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 14:16:05 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 14 Apr 2025 23:16:00 +0200
Subject: [PATCH v3 2/4] meson: move headers definition from
 'contrib/coccinelle'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-505-wire-up-sparse-via-meson-v3-2-edc6e7f26745@gmail.com>
References: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
In-Reply-To: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2966; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=e+95IPB3knNRUNiUbfCBrW3kFUIwqBobJcWY+hvhoDQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf9exKxYQzMOARB6onBk7u68F8lK2jwiTWCc
 ZDMpM1zZ6Im6IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn/XsSAAoJED7VnySO
 Rox/UqQL/2hbsbrA5JhChDJ6TyvxxnrEAJGIDMq81GYyRUthiuUoOyaFd6DIG5HTaix/fPyNglQ
 8aSdntYfUEPu3iISp28xstc7X2oUW/GG3uzeOkC2eHcLwU0p9lKwTwnxRgyMGb71CG+zXj05VFu
 tdOAbVZtZwbDZyaWXr9ahUxqFV5ojlbWp/0e0u1tih+nTvLPWxyx4Nu7FAHWBjee6xiwB6CTiFP
 Z9ivzO7k5oQ7ZYzjK8u6rbJ/xQdRvrHMXVN7ktnXNY1SCcMWrRC+2dunlQAFynh35LOLLTZssOW
 w0ZRRGJ0zlvRtNjMBfYErjP3Yuq9GARci2sZmVOxeguUGhnIW5oqOsGqZ6wGfyIGgz6tKCQYwb2
 4ZB2a9dffc1/DL6+LoICnkA/gyCQFcpJ8DpmD+cmob+HU02/nDRARKxvGhB91/HwXCYqrZHNGrj
 AFiP6qLF/tMXuCi1t/CObmJwmineJvPdcgunPWgNHl6yZEqF7imHz+p+347bEHdclG5cSHJNLI7
 G0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The Meson build for coccinelle static analysis lists all headers to
analyse. Due to the way Meson exports variables between subdirs, this
variable is also available in the root Meson build.

An upcoming commit, will add a new check complimenting 'hdr-check' in
the Makefile. This would require the list of headers. So move the
'coccinelle_headers' to the root Meson build and rename it to 'headers',
remove the root path being appended to each header and retain that in
the coccinelle Meson build since it is specific to the coccinelle build.

Also move the 'third_party_sources' variable to the root Meson build
since it is also a dependency for the 'headers' variable. This also
makes it easier to understand as the variable is now propagated from the
top level to the bottom.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 contrib/coccinelle/meson.build | 17 +----------------
 meson.build                    | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index 03ce52d752..32568c5103 100644
--- a/contrib/coccinelle/meson.build
+++ b/contrib/coccinelle/meson.build
@@ -8,21 +8,6 @@ if not spatch.found()
   subdir_done()
 endif
 
-third_party_sources = [
-  ':!contrib',
-  ':!compat/inet_ntop.c',
-  ':!compat/inet_pton.c',
-  ':!compat/nedmalloc',
-  ':!compat/obstack.*',
-  ':!compat/poll',
-  ':!compat/regex',
-  ':!sha1collisiondetection',
-  ':!sha1dc',
-  ':!t/unit-tests/clar',
-  ':!t/unit-tests/clar',
-  ':!t/t[0-9][0-9][0-9][0-9]*',
-]
-
 rules = [
   'array.cocci',
   'commit.cocci',
@@ -61,7 +46,7 @@ foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files',
 endforeach
 
 coccinelle_headers = []
-foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
+foreach header : headers
   coccinelle_headers += meson.project_source_root() / header
 endforeach
 
diff --git a/meson.build b/meson.build
index e98cfa4909..3ca5d01071 100644
--- a/meson.build
+++ b/meson.build
@@ -633,6 +633,28 @@ builtin_sources = [
   'builtin/write-tree.c',
 ]
 
+third_party_sources = [
+  ':!contrib',
+  ':!compat/inet_ntop.c',
+  ':!compat/inet_pton.c',
+  ':!compat/nedmalloc',
+  ':!compat/obstack.*',
+  ':!compat/poll',
+  ':!compat/regex',
+  ':!sha1collisiondetection',
+  ':!sha1dc',
+  ':!t/unit-tests/clar',
+  ':!t/unit-tests/clar',
+  ':!t/t[0-9][0-9][0-9][0-9]*',
+]
+
+if git.found()
+  headers = []
+  foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
+    headers += header
+  endforeach
+endif
+
 if not get_option('breaking_changes')
   builtin_sources += 'builtin/pack-redundant.c'
 endif

-- 
2.48.1

