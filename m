Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA31EB19D
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745155184; cv=none; b=Jky82DvbaHpBrNAbqkXitDuCdKqxxplGYi7KS8QJ4/9nlXB0eWv3zBcUOWN1X5l6oHosFOBPBcBjWFjbLasOlYzl4l71cB0EDk4Ltn56/t+ILToShGVhKu0vduWGOrx7VYI9migPXEnDfIhtOfO/xYM+sAkTySWhaCfJ3HL6a54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745155184; c=relaxed/simple;
	bh=RwCTdrA8icR8Czy+TEEztB+WipDB3zsRLjXCWc8lxl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NoebVDqFtP7t1M88yBE+E4rWXo6Xi/II47JIWWF8sIPWjmeS6RHD74QetNLlvLBGN/wr6UBqqHDsJgncxyC8TffpdSFpyymHOU2NobIe0Zu3Aqg73pwaZrCikkgnG1fGjvWQW54TsE1al+84pU+ddT+Ps50XD/B3LVCd6WxA3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDHB7IA+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDHB7IA+"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so583838966b.3
        for <git@vger.kernel.org>; Sun, 20 Apr 2025 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745155180; x=1745759980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTd6E/vrgs2Bd78lT+8jLJqmI8OKYBte2pkiVgRhMB0=;
        b=cDHB7IA+U6Md5oy0CAbTEcp1Iji5es8E+O2Zwj8vCPiRpQ68KWihHZps1WpyVFHZKZ
         l2Z6094RDHlZaferei7odeHHywyQ2LP7TloyvbKbLR7hxgiGm39GsvwYv4jXZssyxAmU
         Ecd0qD3wMJAIFx1bnPNcJb3Mgda0XTJ3ZvtjMREbehWUhCUhxy/O+r5tW6XvkBW6N0iN
         PfUJ+PNHOfGVQe6b+Je/bXQBQxFviNs4Bna53zYyVirS+w+wvtD8BNPvLq8+p5YYDn4L
         p8+ySwQLthcAYDh2i/EnGogewhKJoK5tB0qqwseCT0qsmt1d32jm6q/L+YrUXiTVvZCX
         orXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745155180; x=1745759980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTd6E/vrgs2Bd78lT+8jLJqmI8OKYBte2pkiVgRhMB0=;
        b=v8gnoPKTlWQhJ3O83OxyA02Y68Q+El3jpMTcrVkoraVri4aZkxjNQL0C8eD/0oOBdq
         cv3sygMQKGVqPL3nLKFkDArHeR5DFq1uWcxlmM9gPrNbNbEtGbnxYQAdAiXIdF2Ppjhu
         CCW2plK4/KMevLmM5AJgMHUHAyIFMvSn2Aab0+MVd3JycR9dZYRRp708xo51oejPidtE
         NhzDOl4TB+W04Ku1M8VdrYfmdhjau2tc+AsIjNfnOZWcJby8j+SEJxraj2j0dj/fhIRo
         j3kaxLJByrsBVQjpmfPx0zTaNnTuBwtBN7plmucBcIq2CNo66DJtelleKH6DI9Du5ZsB
         +J9w==
X-Gm-Message-State: AOJu0Ywqn8qVDx34nl6atlCsXAvSDZEqK9XIoXbtCaPwbFgV1PZqYJrL
	GcxqbCXqWL3H1Wa+PuxJL389YrfMFmCDuoWJCrzrTd2tuZN99L6z
X-Gm-Gg: ASbGnctbcewVG8Byo8YAyyGzFNNMW3t/rI5R3NaeDI77pCrLmPxII6UM4zaPykWLd1q
	H5tBSdSrAxI5ClC7mIuzMGBiwGR8grJn6uZMI6m4O4A4mghQkjJitqlst0xAO89ShWyPIIq/V8G
	v1zkyYWOQczwnVBvQ8M20IJ3FgzfhsQ8aK+PEkmap4ddq4zYC9CVn9iEUaYN3b83Wp9R4+/+iIG
	hOrzr9Js9TFzs6nd6NGfXk1lacR1Gft4ABGYsMj8Wr08iaSjf7wT9YhmD6MsNGTTSKpG7daUtHM
	MHkmvyoeP7WjQVhKutV1KtRF22vhMroqaNzMiC3k0rTP+iA=
X-Google-Smtp-Source: AGHT+IHb9a9ewOewGGpL1LLd3WdkeI7GzL6ere+4JmBDJs2pbR2WTi0oo9v5WVcMr6BsyzcjZQmHDg==
X-Received: by 2002:a17:907:9488:b0:ac2:baab:681c with SMTP id a640c23a62f3a-acb74b7faedmr907843266b.28.1745155179541;
        Sun, 20 Apr 2025 06:19:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:7cb7:e0fd:4535:dd46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefc703sm397872566b.94.2025.04.20.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 06:19:39 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 20 Apr 2025 14:21:36 +0200
Subject: [PATCH v4 4/5] meson: add support for 'hdr-check'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250420-505-wire-up-sparse-via-meson-v4-4-66e14134e822@gmail.com>
References: <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
In-Reply-To: <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2857; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=RwCTdrA8icR8Czy+TEEztB+WipDB3zsRLjXCWc8lxl8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgE9GZQw4Fzc4VCy/Hb2sFVKjfr1+Ze+NhoO
 KgYy+jboaiUwYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoBPRmAAoJED7VnySO
 Rox/YyoMAIM+eCjH6yVatv0XVa2HdObuPJ/XSKX9GRZTSLvUG/4tealQ4f18ATQzAzaQKY9woKd
 2aS5N55UhR0/bgOfuIJUiuJ8bOGnnuz7yEBybFJK/APRfhJb7zj46dV7d3OtWNFHCD2I7zdfmtG
 AyIm1MgmClgiUEPdtFnWOPI4YywUm4Rn9h44usv8G7saTLVtr78PJkhxgt9QHkr+5RCJ5omnIc1
 BrojvRJyI9yTv4GpZorIDVV0TC2D+pz89mmSim67muOkPjmgZY1gjsrdYWvn+0Utt4rjeeKRiLv
 sLWbMZJHrBWOBsVLnYojBLRsj0VCspZ6e1pgmGlgPy4tCgUdPo1J/WLPkwnS5eG50PHa4775O8o
 J2okiy6ZHtlp7q2lXu6JJ4EhBgEpfz1n3FUl4gdgi64BHM1MlDGMmwnE/eX0dq5IkLDmtuBOK0Y
 TF3KyZWADei/Rz80BpSZuxgXF6RSITXtCeju9t6nUXl4X7LlQUEgXUBKjoKbes9UyCE2N9RnPG6
 XM=
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
headers must be skipped from the checks too. This also skips the folder
from the 'coccinelle' checks, this is okay, since this code is an
external dependency.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 meson.build | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/meson.build b/meson.build
index c4dcf756b3..afbdc97fb6 100644
--- a/meson.build
+++ b/meson.build
@@ -645,6 +645,7 @@ third_party_excludes = [
   ':!sha1dc',
   ':!t/unit-tests/clar',
   ':!t/t[0-9][0-9][0-9][0-9]*',
+  ':!xdiff',
 ]
 
 if git.found()
@@ -1994,6 +1995,68 @@ endif
 
 subdir('contrib')
 
+exclude_from_check_headers = [
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
+if sha256_backend != 'gcrypt'
+  exclude_from_check_headers += 'sha256/gcrypt.h'
+endif
+
+if git.found() and compiler.get_argument_syntax() == 'gcc'
+  hco_targets = []
+  foreach h : headers_to_check
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

