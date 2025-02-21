Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0EC253327
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164721; cv=none; b=KwtCg9VxJG5/otLBwY3mMsxvDQdsedwn434boo5VTylnH62fFHq/KVZrrC/7j11hlf//HsF/K/HV2jqrWMSIePwMFGDoQfVRUans9kMoHYS8pvaI1Ylza9BQrfUiXYf5oZh1sJEuQO6KrXIBGg9XiyrhybusoKW8gJyTPoJ8f4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164721; c=relaxed/simple;
	bh=McZbMAR62L2h9oeNp+zn5elYKY5wKQl/yuAYLnQeAL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2m7apsfs8zDvA9FK5Wiag9Ftbr1JfYOroCyob2mJFU1kvmjGf5hjk3vNdiCq9/sSNWOLih0Db4EXqfx5/KIISD1fZO3vke8RM6gyURDL098kb8GDfece6Q2syvf4DntelVIZ3JDsaZKOkfEmMDU5lJpwEpJNWjFYPmCUUdEjN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFw0bhw2; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFw0bhw2"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-471f4909650so22576841cf.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 11:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740164719; x=1740769519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1CvhWUmF15d1EGDFVeM3CX85Oev2ufijaQZG9v76Wc=;
        b=PFw0bhw2TaObFZviXUqiu1trQgU1AxO2iell3bI7I0/5Uxdf+K/AJJfn1HR8XKVI/G
         yIGjT1V/nI2u1jlVgZYC+mFyWg+NPqX3oHNngRZ4aXA1qeSgWjek8QnkDcapiledlZhK
         gCHXlnUOveigsXAgcngRaUDhzvVo4PpUfmBHvJx/IY88Pg2GrWJOtNq80BmkMctTm11M
         lTiAnx9xcsDRemSDQ7b/Bcp2JQO+OGF/Mi10meGLTlOCnhTHQDMsmNO6oi4nSDXXhfqT
         BRJ9VJMhJKB44XtP0PxbtFxVdzZJv0674RCZ8qZRCQVERNnmZBMKDdMjo41tU63Gr5eZ
         7MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740164719; x=1740769519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1CvhWUmF15d1EGDFVeM3CX85Oev2ufijaQZG9v76Wc=;
        b=h6Nq3BPemXZ7tsKlZy+aMBRTw/U/rbhfWDCpOcdT6pco6lJMkDGCQJB/iEvzgIDvAP
         3wRhYAK6w8JAHsO7W9DhN2z7Ao2nf20XqCyOcqaMFw4OGxQElFyDSasELncPi3VJqVc6
         yKSkHni7uHJVjDjzuOX/02XOFGx4NYfHUqL0ya0lJAmllRN2o/lOUxIDMEBZbYmyf4Dd
         VT+G32T+DRDX7cSVbmt5wF6Fu+XaAIOI/Y32jpiXEHNP43UJBgLtmVmorKS5v9duL6pe
         SziKCuq4rfdh/skX7L9U49d1gvQKRUcT92RA+/dAscp34nZC8CWKecbhG6u+yd1C12ot
         ZvBg==
X-Gm-Message-State: AOJu0YyOMu/9l+kRRoHGkBkRa077KETN8dFpgU2mXGU0b2wqQUtZOgn7
	pEZjeTvivGOXcybsGXw88uCWzhBnEdzPSoBTajOW+tnq2djoOh7PZpWksynxdos=
X-Gm-Gg: ASbGncv4Ou1VSWcoLOHC+Bg/WkVpI+LLObzTK2TYjAzcedvOJdUnZvfhPHP4P02JsE4
	2ZC9zSvIg27RIqb68yzywurLHm/TPMt4nKZxffl40Q9zsnKC60ke9EhyFK5Li42DKKQl1opDnoK
	vgzBHFaSJe46CLGoDTxzJnKEFqzb54L5SfMOxtxu4jXMcFuqBj19RKX4yf0b4+ZmjLQbDLTrn5+
	UevpW+63CXoVjg+h6U5S3jr5dnMGUCNS8j34vtCzX+xEtirf6FPxUz4xorDUKKRiziCfslEwRGY
	WrIm3gvCKg43IX0wTel4Y1dDlMrJKxgRZi7bDc8dIh/wy81P7KCL
X-Google-Smtp-Source: AGHT+IFshecsn0JR9qTnZsaOtBvTwLxyPunfF2qRhZeSBCrnUGG/h3C6ifxZNc8fPREec7RIwF8r0w==
X-Received: by 2002:a05:622a:9:b0:471:fef5:ee68 with SMTP id d75a77b69052e-4722299bd3bmr65026371cf.46.1740164717412;
        Fri, 21 Feb 2025 11:05:17 -0800 (PST)
Received: from localhost.localdomain ([70.49.151.101])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720b1fe010sm32945661cf.60.2025.02.21.11.05.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 11:05:17 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v11 3/8] t1006: split test utility functions into new "lib-cat-file.sh"
Date: Fri, 21 Feb 2025 14:04:44 -0500
Message-ID: <20250221190451.12536-4-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221190451.12536-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250221190451.12536-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This refactor extracts utility functions from the cat-file's test
script "t1006-cat-file.sh" into a new "lib-cat-file.sh" dedicated
library file. The goal is to improve code reuse and readability,
enabling future tests to leverage these utilities without duplicating
code.
---
 t/lib-cat-file.sh   | 16 ++++++++++++++++
 t/t1006-cat-file.sh | 13 +------------
 2 files changed, 17 insertions(+), 12 deletions(-)
 create mode 100644 t/lib-cat-file.sh

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
index 398865d6eb..1c27c10c6f 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -3,6 +3,7 @@
 test_description='git cat-file'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-cat-file.sh
 
 test_cmdmode_usage () {
 	test_expect_code 129 "$@" 2>err &&
@@ -98,18 +99,6 @@ do
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
     oid=$2
-- 
2.48.1

