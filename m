Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C113B19CA
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881015; cv=none; b=MPVyrgJCvuntGj7zKNMq8gByiXiVMw4ixP4BjzfPdMYu1MD2ZmNT0s3qlawrbc2p4LFs0g9jky8yi08S8jzexU+fsXXSiURIVFG8/ich3g4rnxjWkrb2uKcws8dM1KwSGBAPXzuIf9sAiUesYBfXcLNkOQvuW0w5M6NuI3V5XeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881015; c=relaxed/simple;
	bh=A7l9hGc07E87yMZl0+Quk2FSzmmH9NcZ6FZMTcwMmG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0UjYJ3HXTtNaCQAER3OtACDPP3b4DjDpX/qf0zeMYveirqznz7MoaUMsPZTbBTazUotMOBK6420HHTrU7CMCFcAFoVV0vkmyLHd7kl7U2oOfe7EcSjWa03LX+6Vd3h7YFpNNKrUBq72G9tHFb1YN7+z1bcwlJAbtRFo1kUcgRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS7iwlgJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS7iwlgJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-491b390f9e9so19412805e9.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881012; x=1782485812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CJrwibuS8F5G6nQI5trc47fMr4AdXqLIPxkLGe4bKo=;
        b=mS7iwlgJRTgtW7Z7BKUDndjtguP+o2j4u7JqKIR06R3Wrh48yXlS7n2EvN0vUn6W7J
         aftzdM+c8YzX5lgtFu9BXCZT418RdyQCCc/JjlFTM01ZaZRSXFMcIxPJ6QGaXMMrPZVV
         Ot2GBc/+5+f9jfA6NSAORjDI22Qc7hofTCiYKbl8GLT4YwJWlkQgbhbCcPI/ioqyIhH5
         HVzz9yufSXPFhk7BL1GR9XKNA7jcAmtGLMAieSMa1XYCi4N8sP6WSlzDvldorEhvf3gW
         yMqeG852ORpdQmMFWjSjkTb4AdtCThspdzSA69p0RkJf4ZejDiRPtzVZd1LywIClXHmr
         zoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881012; x=1782485812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7CJrwibuS8F5G6nQI5trc47fMr4AdXqLIPxkLGe4bKo=;
        b=EUnbYIVJgvZuiEktBESBCeLVJoYE52hHKnhaf3gC3N464NA3tWiwDpkanEtlYe5RPf
         +cSTunlJAmWjYyfhVmLeSqI42jE6iYFs9JhjYpW9xymm6CrEAhU+UkveeWh8RNn6iKLd
         CEO4FPITC1xVtl3sBI7J8madDU7NzP+OBX9TIa/XL3UMRJx/02TrBaH10aAztGBRb+FA
         0TdAyvg50bdYT2V1mHjYvxHfsRfpI4i6etKc/5Hee7O4runVH+M84q03ItEea4b+fmf8
         RJpnz4CeP5d9iBqDcuKW87RkTG7MXxqfVoA3db+mKuplIC9zG9p4+LmUeFIPp2HkPYpF
         gHmA==
X-Forwarded-Encrypted: i=1; AFNElJ8qxGmLtcQqwFvuqV+aqLd0atNzY0GPf003NIXntiwXfzrI3HiTbqMvnUk2+Qgnw9pxZ/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUgx7WzDpJlVkQ0umrPpRe2zZptonUQJSIYGXVfZishtnX9gF
	XA7e8kXBKuHmK/eTnTdFoXW2W8f7ZUSB3x81wr7j6KWMinxFSBkmCLw/
X-Gm-Gg: AfdE7cnwtwUI6cdhS3l6dVGVGA8GEWn230hNqy+WrDO4UVsL4IwaVE0bBZYQKA/8uOK
	phkVva2HnzLwkGx8+I6+ri94FO+MGt+yzKIDmCyjGSnWf9px/hCHmb+sRNF88n2x+w3YurwS2+5
	K3k3oBlcKPDltSw3BfjV13V8hcQ9LmSWSpl3WHlVDfOGZfWuABRDQIxKohlO1xoSUZRzbdi9AUZ
	UQ4DSmFujFwAR8C3kNz5p0xw1DJCML9U6j3MZVRnu2gLxBKaO6mWICAnnTOdIwDD1lKHcwQC/Y7
	YVj+Cchqtxlwn1n3FqdOD1ao0ORTlr9UxEWTE6if1Yf1OXOkTiChmyF7mOSdonU8wadUpn8de7h
	yNviqo9rkZqTN93kT798eFO1xy7PDnihez5AXrRpxNRXUvk+XeXCPNLDlJT0EZIUeYfsfj0cjl2
	/wYa9jUNYKUc4whm+Zt33i0qxBNpnB1yRth2cHSMB/8Cp+SwtiqME0hVUb1pp33chPLGE92/gQ5
	OWM2hMXEzSNBeUXSEHKe7oV37m+1DYILbpKaA2CPXiubYrYhV3THHMr/hnkD36k1cWwmrIlLINd
	CGRX/IHqgiYixdr2sVPSJv3zNRMl9bNQQltLF4KAeFX/MmxNbwQA3GeTch4gKAs50LM9E9PScCn
	nk3toug4bJvgUqA==
X-Received: by 2002:a05:600c:c494:b0:492:465c:56f6 with SMTP id 5b1f17b1804b1-492465c57eemr18674455e9.10.1781881012244;
        Fri, 19 Jun 2026 07:56:52 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc63fsm39430795e9.1.2026.06.19.07.56.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 07:56:51 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: gitster@pobox.com
Cc: peff@peff.net,
	eric.peijian@gmail.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v13 04/12] t1006: split test utility functions into new "lib-cat-file.sh"
Date: Fri, 19 Jun 2026 16:56:33 +0200
Message-ID: <20260619-ps-eric-work-rebase-v13-4-3d4c7315d2f8@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Eric Ju <eric.peijian@gmail.com>

This refactor extracts utility functions from the cat-file's test
script "t1006-cat-file.sh" into a new "lib-cat-file.sh" dedicated
library file. The goal is to improve code reuse and readability,
enabling future tests to leverage these utilities without duplicating
code.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/lib-cat-file.sh   | 16 ++++++++++++++++
 t/t1006-cat-file.sh | 13 +------------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
new file mode 100644
index 0000000000..44af232d74
--- /dev/null
+++ b/t/lib-cat-file.sh
@@ -0,0 +1,16 @@
+# Library of git-cat-file related test functions.
+
+# Print a string without a trailing newline.
+echo_without_newline () {
+	printf '%s' "$*"
+}
+
+# Print a string without newlines and replace them with a NULL character (\0).
+echo_without_newline_nul () {
+	echo_without_newline "$@" | tr '\n' '\0'
+}
+
+# Calculate the length of a string.
+strlen () {
+	echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
+}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8e2c52652c..8360f3bbd9 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -4,6 +4,7 @@ test_description='git cat-file'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-loose.sh"
+. "$TEST_DIRECTORY"/lib-cat-file.sh
 
 test_cmdmode_usage () {
 	test_expect_code 129 "$@" 2>err &&
@@ -99,18 +100,6 @@ do
 	'
 done
 
-echo_without_newline () {
-    printf '%s' "$*"
-}
-
-echo_without_newline_nul () {
-	echo_without_newline "$@" | tr '\n' '\0'
-}
-
-strlen () {
-    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
-}
-
 run_tests () {
     type=$1
     object_name="$2"

-- 
2.54.0
