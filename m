Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F991210FB
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 00:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758931668; cv=none; b=c+PZrZYuMPkFCHxw07liPQRp30Nmsz7Crx/FqXiOWSjq3hd4XOGXfmWIhvAAXlUp9IKN4O07swqdvb1siBZGkcq6p4FzWbJ9l/33PoWhqUkO4DMgVuVQ2M9Ho5lZZzkvxGtjRtk0V2o3IJCspbY6gSteC87RgVZrdNt8AHZ1zrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758931668; c=relaxed/simple;
	bh=rwixZ5310GB1yWYMUco5cwCkSGj+L7ibVrC8UHnHRN4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KDArh4UmmXGHS6EPP82wB+ENWcIdvp6gqTD63qs8tbaTudbU9+LtFBws3AZTxLkgbscpQqhYeww8umOVD/ORS5f3XGYac3JDm15bn7HaOOO0brHB7PqkSjDW+twR4sMoZS7GCORD6wQ6q2Gzv6v8PeFSEEddvRXXFPJVwZcXL+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIhn7ey6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIhn7ey6"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8571a0947d1so295012985a.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 17:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758931665; x=1759536465; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxoFNfmxJNaO8HV39KBL3+UwvUgT52a9pCMuGP/Z+2I=;
        b=OIhn7ey6P4KPRoRhLfJbTa0s/jaedq3uykIE5QUOiHs+eokX/7P1XWZFUQV3Mi1b3d
         im6mnm1eMx4M7bpR3dfnOkwMZZ1SY5CavwwE1uC+cWQph6b8PwQVgvISpnTwTPoUY1H+
         bxi+7cYDNXNDCQz0QtwJys4YYYHcoH+sq3Qx8iLISRRDuPppghhm6+/0dMtrVW6lt9dP
         f0EnPrmHyt1RHexTAy+XPR56l94IReakGsBIeL555735jD5zvsDGs8tkfhvhkChiALkM
         hjG/lMa+Sh79ghTBYlhCkSToaWydOJqUh6gOClC2qiVhMM1NlaeLbtgfD/Q1btDoGpek
         aMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758931665; x=1759536465;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxoFNfmxJNaO8HV39KBL3+UwvUgT52a9pCMuGP/Z+2I=;
        b=nAR8Td+d+8XpR1xr/qr5oTyBSAKF7cDksC0phK6JsAx7zdXHAHnn6earOC/ZQTFkxq
         hpghlcwCAn/Jpp7Proq5NwZkLLyTSR21UjckSJhNJ1nSgKY9AIiwa5eDV+rnWsNFMW7B
         ZPPgsWUQt29f8SI3bUYt/jZHZJ42WfDC29DmXanco3UX0kj8CFdh7CrM1ZjfoibrYril
         YanoehEdUWzBcbB5KDyeQ34bWzUpGEGV4DGZl/v3bEsR2FxawzVQPTe9veBhWD7xy/4N
         Oxscgfhvfr8DsI5Z8/kIKebbQCpHL2VisxEpLinG1f/H0InB1UjO+np6AR8ZImmaU+aq
         4Gww==
X-Gm-Message-State: AOJu0Yy8cpRQauygrbK4wMJ4Gv2BkUkL85ZrwQ7U9zwV0PZspJELEDFL
	nvVd1VnbiQsO58EKiUn/FqiLXbne5dqtyiVlht7B4uGaGfFnRhesq9xU/kK79J5q
X-Gm-Gg: ASbGncuBCULbXPuaSWcq4zEW0SOGwqxJP7Y9breVEjgD+iSVfkn3uXufQR0oynqSQS8
	xU5qS0rl0xeIS6v+giHB6l/SfHcWZNzsFrIRYY4/szEroW8TlP/P/GUsl+5f31CprwsRMlw/quL
	t3dja418ObfLhDOCfHEG8V5PYAamA+F1ghiJ6vbB3Pk8mfO3Y5mIV2IkJMee9ALhjlJF7UWshnP
	C4zYLBbnhfgeit+uVfX2bB3g+nG9XyGU1bcnYLo4FwETSaA71bCvxr3vZir2RJCl8LdcqCWyNmj
	XfV7opI7I+M99kYx6IhQ4GetiTy3eiml2Ud26CZZW9IPM0lORhuQIqVMkql1TraPZngB63a1CMO
	uCRCzqUCChsMtz1EnlYBXA0Qo+g==
X-Google-Smtp-Source: AGHT+IGbQwELTt/3luBw2F5gNtBwsCbZ4HpCWM1uNPEjsRGNnOBUBMeKfdeKJazm3hG4yJYCeyWdEw==
X-Received: by 2002:a05:620a:29ca:b0:855:4f0f:d782 with SMTP id af79cd13be357-86462eace68mr199037585a.34.1758931664846;
        Fri, 26 Sep 2025 17:07:44 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.102.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c27378987sm371534485a.4.2025.09.26.17.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 17:07:43 -0700 (PDT)
Message-Id: <d7810781fc3af1902c99cccbd50853dd630a0080.1758931659.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
References: <pull.1977.git.1758800669.gitgitgadget@gmail.com>
	<pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
From: "ionnss via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Sep 2025 00:07:37 +0000
Subject: [PATCH v2 1/3] po: fix escaped underscores in README.md
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
Cc: Chris Torek <chris.torek@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    ions <zara.leonardo@gmail.com>,
    ionnss <zara.leonardo@gmail.com>

From: ionnss <zara.leonardo@gmail.com>

Remove unnecessary backslashes from language code examples.
The underscores in "ll\_CC" and "zh\_CN" don't need escaping
in Markdown.

Signed-off-by: ionnss <zara.leonardo@gmail.com>
---
 po/README.md | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/po/README.md b/po/README.md
index ec08aa24ad..d7757bed4e 100644
--- a/po/README.md
+++ b/po/README.md
@@ -13,9 +13,9 @@ We will use XX as an alias to refer to the language translation code in
 the following paragraphs, for example we use "po/XX.po" to refer to the
 translation file for a specific language. But this doesn't mean that
 the language code has only two letters. The language code can be in one
-of two forms: "ll" or "ll\_CC". Here "ll" is the ISO 639 two-letter
+of two forms: "ll" or "ll_CC". Here "ll" is the ISO 639 two-letter
 language code and "CC" is the ISO 3166 two-letter code for country names
-and subdivisions. For example: "de" for German language code, "zh\_CN"
+and subdivisions. For example: "de" for German language code, "zh_CN"
 for Simplified Chinese language code.
 
 
@@ -126,7 +126,7 @@ you add a translation for the first time by running:
 make po-init PO_FILE=po/XX.po
 ```
 
-where XX is the locale, e.g. "de", "is", "pt\_BR", "zh\_CN", etc.
+where XX is the locale, e.g. "de", "is", "pt_BR", "zh_CN", etc.
 
 The newly generated message file "po/XX.po" is based on the core pot
 file "po/git-core.pot", so it contains only a minimal set of messages
-- 
gitgitgadget

