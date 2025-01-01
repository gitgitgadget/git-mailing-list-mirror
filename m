Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC6DDBE
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 22:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735772364; cv=none; b=YYZQ30x7Ttf5nSL7kU5FF3tioANK6pEj7QrsLQ3E/n4STmdH+VnoQRM7E6BC7A4WOgZaotw97a9VvLF6S9qJF8seermQ2DuDgmqCNwUoPgB4WAU4nas0bsjpoC+ByMwHTjbH7n40aDD9ESzk7aqkb3fqZdoVoep8fskAF8rdA4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735772364; c=relaxed/simple;
	bh=8Mn8CZaBF202NPbFfu+I77L+mrC/z6z0uwDnOPX98EA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qOTKphQT2agTDmgZXNfwZ8o1mUqrBLG0EHcFmEuAQRgRAcSeQhAOEUF+pLpPiaGlh3yJT9SqyJqPYXZ8wYCnexMSRdO1SjzjSYB6mKRarcqwnASmbCcrpND7jqeF2WUGu674/vwUzH+RmtBBDe4tkQWydJJKbHOILJyUIQo8Ipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnOe+m5G; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnOe+m5G"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e2880606so8074847f8f.3
        for <git@vger.kernel.org>; Wed, 01 Jan 2025 14:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735772361; x=1736377161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7uVVNdGRxx3mRlwLhgJCH0LDl22gFDSSGqyg3K4zsw=;
        b=nnOe+m5GCPqnJiapgbn03mp2NxXw9cKpluKIUslNKhzyNRGy7PVFf044+aK4O720Yp
         IE6NKSA1DHPY9PBzOPIezjr9Rjzbl57dKFNGAiwDUqTd1zpG37yNHAhDhx0LLpWC5Ql3
         RUilSLnLDWt0B8X0cs+aDZDceWUuWQnehQ+7Rz1j8LbnK0KVStjoX5lc0Wo99QzGN6bx
         5+rWlvEYZ2KnXCPFudZfDYqfwq4uLa0U0M+qqgP7/UVeE0eHosXHThtSZV0Uf9IyfXVV
         jgP5xMTS4jCARiy2rgahliOfc2hr9fd1Tr0KGde1Lto25yIxnVl8h+YZwnDKUDfD15ma
         MHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735772361; x=1736377161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7uVVNdGRxx3mRlwLhgJCH0LDl22gFDSSGqyg3K4zsw=;
        b=N0im8IKorCRLN8ECgjhmGszd7qVBj+6s3fcr9HDGgGzkumye3w2bLBIfqyGsU2TuN7
         rcAwbARR83wLHY2oU28HyMqDz+OIc3U0DtBNttTH2VccvCp+skAPOaI9TBB+rHVXOFBk
         L5eoi8eavd/2rDxXAey8k9Q7LhCAWvtMAUi2Fi7cDKBYeNL3MMIicG4emJY1NYtx4giS
         k5o1b5nGL4DNm6cJofNrXmRTuKWoBVaEsABQZ+N8hlkV7v2pOK7SzxGIe25etwhMfhxT
         NfYFm4r/xP2hw2nlrhQs/zB6JD4UsgQemPKN2iHBIH4QjfzwWSx7zN8Esc43oUx2yF0U
         BA2Q==
X-Gm-Message-State: AOJu0YwE0wnFNtV5yO2ikkEFK1HLHkbEDJga8MHvSKAlyb5pJakl0BSv
	ji4cTkZF0RTIs+DRlYO9trQKNqkD/GOjtMRTNfVDdRFTdAUpHMoyshqJ6LLH
X-Gm-Gg: ASbGncvV5aJyVg4udShYWBqsJ1h2hpbHzfUg4T5qFQVbhbFvhLM26IRxPvEX/SzFFOP
	S/Zp+JV+4x/ax4TZa0KkNFFgeoFEb1JvVQzQacMxHbttjzOARLU6pXy3w+asEL7TLPbhxWOoSO0
	XvuTr7rz6wQZuyjGOavYa3HYK+2unKDZE2LoHwYEJWQofiYEOu7zvhV7VIt6HmEU/zRwhn/Zo21
	IwGvNwm6Lh45whv4jHNqcNntwhi8uWVJYTqhqtecjQ5L3UQlmNSRjp0IXAoexbw8W7MqxZHzfb2
	g4W3yg6zp3ZyPfg2wSIfL0bJoC0=
X-Google-Smtp-Source: AGHT+IEsozyYpvzyHm5k6O5etnCjdAWjPIpEiZ9crQrfRwrFmc/JvfFiE2UhOSDbLFbO8FdIcJbVhw==
X-Received: by 2002:a05:6000:4715:b0:385:f560:7916 with SMTP id ffacd0b85a97d-38a221fae73mr40770525f8f.35.1735772360501;
        Wed, 01 Jan 2025 14:59:20 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:646f:3ee1:250e:1f83:d66d:f762])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a6e19sm36281182f8f.100.2025.01.01.14.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 14:59:20 -0800 (PST)
From: matteobagnolini <matteobagnolini2003@gmail.com>
To: git@vger.kernel.org
Cc: matteobagnolini <matteobagnolini2003@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t7110: Replace `test -f` and `! test -f` with `test_path_is_file` and `test_path_is_missing` for improved debuggability when failing.
Date: Wed,  1 Jan 2025 23:59:14 +0100
Message-Id: <20250101225915.65185-1-matteobagnolini2003@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`test -f` and `! test -f` do not provide clear error messages when they fail.
To enanche debuggability, use `test_path_is_file` and `test_path_is_missing`,
which instead provides more informative error messages.
Note that `! test -f` checks if a path is not a file, while
`test_path_is_missing` verifies that a path does not exist. In this specific
case the tests are meant to check the absence of the path, making
`test_path_is_missing` a valid replacement.

Signed-off-by: matteobagnolini <matteobagnolini2003@gmail.com>
---
 t/t7110-reset-merge.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 61669a2d21..9a335071af 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -270,13 +270,13 @@ test_expect_success '--merge is ok with added/deleted merge' '
 	git reset --hard third &&
 	rm -f file2 &&
 	test_must_fail git merge branch3 &&
-	! test -f file2 &&
-	test -f file3 &&
+	test_path_is_missing file2 &&
+	test_path_is_file file3 &&
 	git diff --exit-code file3 &&
 	git diff --exit-code branch3 file3 &&
 	git reset --merge HEAD &&
-	! test -f file3 &&
-	! test -f file2 &&
+	test_path_is_missing file3 &&
+	test_path_is_missing file2 &&
 	git diff --exit-code --cached
 '
 
@@ -284,8 +284,8 @@ test_expect_success '--keep fails with added/deleted merge' '
 	git reset --hard third &&
 	rm -f file2 &&
 	test_must_fail git merge branch3 &&
-	! test -f file2 &&
-	test -f file3 &&
+	test_path_is_missing file2 &&
+	test_path_is_file file3 &&
 	git diff --exit-code file3 &&
 	git diff --exit-code branch3 file3 &&
 	test_must_fail git reset --keep HEAD 2>err.log &&
-- 
2.39.2 (Apple Git-143)

