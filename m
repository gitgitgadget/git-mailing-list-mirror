Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB512459FF
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448212; cv=none; b=gMUUYdOSsr8btajPzCfb42oLIJUEkkhZtEgYLoSNIMiw+QyDXbCiD8f+YSnRoXXxNCoTuql3+eAtYvLdVz7Pawmn8hjKE+BQpVhxqAnROqNHiElvaYXm1w9Ekokuo2/dwBZA8TlQ5tR7YY+mJTiu1i2rX17htTRME6CFjaGybmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448212; c=relaxed/simple;
	bh=ChtGHjfmbUB14A/jJpRhaUJRAxfOUvDCj8VVJGjoZZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ke01Xh907FL9opqUj4apscD7uwQaApqqKp6IfYAP2pMaxY3+56ojg66V7YsW+qZUBJsXXetuuvuvUEaVhBhJHXfsYuzWkR5DLkq4R3hBSQG8SB6EEzykfjZmPmltZPopanvvF9LPYdkvajoBlM65YSqtakGHo0t6IbUfF3kZqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1yfneRC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1yfneRC"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-addda47ebeaso1376229666b.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751448209; x=1752053009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yv2iBf56CWO0Fdm7GFwQjBuMaJQZ1frtH3wd5pQyCkY=;
        b=H1yfneRCVaJZ16llnyBe/hpKoecWcoPhTpH75gtTc5Hpl5joIOcsH2w2nMedD9ftC9
         8Y1ZaLo8bmFH0qS+2yZWVIL3MWlO080+cKX1jF2OYBHkRc7ZmkhJ6Ay1BPsbByAECX5I
         sT9oI/WNz4DTrNZdQdvrQKIeLqCfosIpjLljh7Ia99cuIPfBNQkMks9WSRjZ8t/tvDG9
         3XUMOTH9tJz+IKPa7NmlVmcdoDUwDZhFY9YoKXYEaubkr8c/kiQiyDifWkbeTUInbInx
         VcD/Rq5VCaIUA+hYVDqMGsUppHcpfwji4MrKwdLn3tDETUjB/8VTdYmmm+dU0nurM/aa
         ye7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751448209; x=1752053009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv2iBf56CWO0Fdm7GFwQjBuMaJQZ1frtH3wd5pQyCkY=;
        b=fEUVHdg7KxehjS3VFazkarM6HxTrMPsL5+tEiwNfU9EOAmv6VWm8lgKf7g6LeUcAfd
         WqXl8YOFlaLUbqLuB2cRZr/teOtUqanbVVhJFU1kVT6H9S1ZDuEaQuuA8zETXdb20O78
         /s3NB3oAGhUNflT7lsY/CtwTTCGENyKJRPqJ1U9K1dTfBKOOF9Nyteb3RlRNvOXD96MI
         UmnxYXAvBJrI4JL9oZ2tlV/Kvm76phrBwjI90AzTJZh621xrowaYbsT2/5v57MNGvZ+1
         XlUbmvfzh9FAgVBSq+FJkL/9s93+AufwOO73zTCbJrt0hePQMvl4vAH9mHoNz42fULvJ
         vxeg==
X-Gm-Message-State: AOJu0Yw9cmrMqdlSgj7/qXp0Jli0GZM/8q8mVOIYUgBijfdccfzozP59
	4Jaw90AgeQ0m2S0RB7bvLrtPRcaYmyOufnzpBUhPLpYGfJg46QNG5bzC
X-Gm-Gg: ASbGncuBYfmx5TUEu8nidbbWG/WyixCwZYi1iKoj3us6Zq66O1QtV7uXXr4UFW1qrBN
	JEMg4jZCRuT39ggN+nD68G1rgdCRIcyZM7qGEO9NJVQsDtDa6sAQdn023CVnvdI7rgjQupwEivc
	tFKNgGTv7kQCEJgjY/hj/VVV38Uo4nK6V/JNXp4MAhtpojh5P++TxG7AMiTfawn2kDEe3dGXkij
	2rjuYFIaUi0rWA7xqqZOGhCZArLcFHmwMNJj1lbKJ5/YlQK6Ey9+KT9Ee9+0ODIrdWDd9RqKuDf
	JHC6pnGUczhzxlej2KhXwfR1tTveWrSqqwEknN3hzGmJUg==
X-Google-Smtp-Source: AGHT+IHqsZ3utOHtoQswkyI/X9wANHFeKJjR/mR/vHvhJG7gNpYauvANeKrUfLcRm9gIgd6dOtTSIQ==
X-Received: by 2002:a17:907:9626:b0:ae0:a590:bc64 with SMTP id a640c23a62f3a-ae3c2b52858mr210034666b.18.1751448208505;
        Wed, 02 Jul 2025 02:23:28 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:56cd:2345:b424:ce97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b1b9sm1052809066b.12.2025.07.02.02.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:23:28 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 02 Jul 2025 11:23:20 +0200
Subject: [PATCH v3 3/3] meson: add rule to run 'git clang-format'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-525-make-clang-format-more-robust-v3-3-705344f30580@gmail.com>
References: <20250702-525-make-clang-format-more-robust-v3-0-705344f30580@gmail.com>
In-Reply-To: <20250702-525-make-clang-format-more-robust-v3-0-705344f30580@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, chriscool@tuxfamily.org, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ChtGHjfmbUB14A/jJpRhaUJRAxfOUvDCj8VVJGjoZZg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhk+o1KMRQGQT/fZf4rS9MhYR1UC7cRnuEXl
 veklquxGaSerIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoZPqNAAoJED7VnySO
 Rox/5KYMAKMIkk77Pb8Da9KwFe1NYHKOfAf3/N9UV9FzRfhE8MYyFX6X/y06kiEz3pYEXZJDIrQ
 WPr45mRl4oyBUAg5gDdDJ3P+86vkQ6SiizhAFlfnrGCWIppvYPVEqza/hDuOd3EFNHQF7kndTlo
 TYqkTayXGrIMnPrv4CVSlBE1C9wFmDR4Qd494zPmsds4r+4Kbl3qSTQxk8duoB3Ee3Yls1EiYYg
 /KbW6hvQaBwSQo+0/3nP2ltt4h/2U2wzDqVkCWdTcZ64tGhxlcl1Livd02boPXXHu5TsZjshPH2
 UsnVgznxP0tsMLYeVHhqmUfoXCTkx94XH9BKu8C0yLuSEIRWWRIvIJJ8dJ/w0bC2WLlIURmTnB2
 4kJG+uIuZmVS37Ok2HC/3fE4P+g3CPLnxfXEKMR4GnaB2PVdGNSqpsS60demmoEgmRsIMFc83g5
 8XGapTHw0cD0/xASM3LXAbgasEHQMWPJxSCYxSKwSXleAt8JdeFw8QICNixrXscdh8ehgQqwFV3
 x0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The Makefile has a 'style' rule to run 'git clang-format'. While Meson
intrinsically supports a 'clang-format' target, which can be run when
using the ninja backend by running 'ninja clang-format', this runs the
formatting on all existing files.

Our Meson build doesn't yet support a way to run 'git clang-format',
which runs the formatter between the working directory and commit
provided. Add a new 'style' target to Meson to mimic the target in the
Makefile.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 meson.build | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/meson.build b/meson.build
index 7fea4a34d6..48dff818e0 100644
--- a/meson.build
+++ b/meson.build
@@ -2144,6 +2144,18 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
   alias_target('check-headers', hdr_check)
 endif
 
+git_clang_format = find_program('git-clang-format', required: false, native: true)
+if git_clang_format.found()
+  run_target('style',
+    command: [
+      git_clang_format,
+      '--style', 'file',
+      '--diff',
+      '--extensions', 'c,h'
+    ]
+  )
+endif
+
 foreach key, value : {
   'DIFF': diff.full_path(),
   'GIT_SOURCE_DIR': meson.project_source_root(),

-- 
2.49.0

