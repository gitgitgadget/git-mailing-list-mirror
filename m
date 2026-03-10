Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF82C11FD
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167720; cv=none; b=hZOesWfdbKPLgF0R0WDF+SL75zsGM1JKCcenactBpBPSJIOA8C/ElOLa7uvowh1ZuG/7P4GAbtqZo8GedmjUzzzBflTQi+BU/BoDeYvpo5vW2FdaQHKpSQg79wLuyd+HTwVZ9Mq5Wt4cqGda2wDpiZqkul25iJ867NsCxUQEHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167720; c=relaxed/simple;
	bh=iRKEgAzRE+b+GInQI4kTuG4VF06TDY8KnLCmQYAOYu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvr2QSQgo3opkKSsv7sC5W1+k/KLG+OPaxQqWZ2pZo7XSjPcUxtnqcjTQlDnrs1GoLq3MJdsh0R3tzoytNyoEn+POIpu/tAKRaGf2Cxtx4FVq4cdwq8HnVrW+/KCD7e2KmTv530oORPXb62zvWxLLB1M35i6O0S7FGfvzaaurks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqCthH/x; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqCthH/x"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48534e9076fso21379835e9.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773167717; x=1773772517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8n5NBgGwrid2vbyHzkIP/7M+I1izxU+u5Td4Wx5rBhQ=;
        b=bqCthH/xexwF+P8ypkx3oH9Nbp0K8iXbyjucizNC/pw3tpj8+pQCaecTdaXEqtZtob
         vt4ZxTU9JksyuiS6S6LZAAbYsFlPZ/r0LUIhkUpvVA3GdsmClqnlDdaUd8ayiGHMd6fO
         14yBMIsh1Fn34FvC600ktSHegjANFMA5g3bsLaWzTucUb6SzWNEaqE34o/OSb42laIMh
         AW6LrViiLGPsNrb/VPJsrU9W0qiOkorQ09Q89S/yacG7jISmpwA1GIdxRAHt9IGxlBQ3
         0QhhvctkBqkameq0ptl/83b3D/Pqy3THcMOZeSqNk4SkO1xUEM+fhxGTJPuDsrseq3GW
         AMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773167717; x=1773772517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8n5NBgGwrid2vbyHzkIP/7M+I1izxU+u5Td4Wx5rBhQ=;
        b=GfYaH0Is+h64Vi4QJtKnyQRPwXqsNPEISfSN5XlQLy7Eq1C6wgKXOk3GLfXy55K9qd
         JlSBBBLAUYe+BHVD6NAmvOvQStaMmUNYihWJNFqJ9G9Bti7ILZgct4krJlJwk0KfybxK
         aMI5+6Hi67E3ug9aXHHaiOou8Hz0DAqvnNv8OShiSVpqp6T3nDLCDMOaTGZ6uMMK3BAw
         dJxEvvRyWDaS+mQtxapQwIRAGqakKcMo6BTYMjceXmxHbdmi7d61LZ9A0SgHkrjmp6pU
         3T3Koq3LZUFi9xAXzExtkQFXSX8PAMim1Qe2wVMzOfFZw+gKGpY1EhtfBkAUuLb5GReJ
         cm+w==
X-Gm-Message-State: AOJu0YwvLscHiWTcoc0rvdSl+X5GQxzWF3V/H7b4Ps7Nv/3HcxJHXacJ
	GHq4wnKl3EyfTjft4v8pmr00h8LyqkwtJWbFZVMr7+9HEEhsLpnp+paBJazCv9Iw
X-Gm-Gg: ATEYQzwRo6vXNEziuiV7bbeSNBYK7T/WiGvJafDev608D9n8rCgi6kCFFaRJpF7/DrV
	TJhbKVyO6xp50+a0/QGLjMZMh7v/poOrRGoRUqfcNj2DWa6oBF6mAQKL99poaV3YYMT4WHwcQ5Y
	GyZ/sHC2NNL/iRaxGWp6HrgQjYbb5rmIlYwG3xLvQDp/uePyC0yqB0jrezUPgOQp3vUx5WTlAjr
	Tx2/DMQE3WxOh4OQ2AXqm0/D7/v5uCgnYxkcBZ2Zqf8AUIjT+4jWn52qt5jFGGQjkrWUM6YE9u1
	OuC/AxCoXkV+lkeb+B1a53GgAi4HtH8m1Jo9Vpph6reA1WhMndDSGjC223/4xGTfXfOr+b6Tsx9
	JN40SYrQfkZSnEyJ5KcCLyCLhaavCVRg3uk9wSzANoxnOioEnlqBeHiPJ+I6pCqfRKQGy28JcHf
	GuA46Lz+RE+rdX4+VF+gR26SnhB9AWzRt1YYJoLKg80J5OwQB5SMntO0q9LQWdPDr/wTZgHfQNa
	jaz1ju4qKjxzBtMxS15r3mcPcWpxuN3OtCdXKkThy3GCyD6xmvFTiI4leg=
X-Received: by 2002:a05:600c:5288:b0:485:3af5:7e53 with SMTP id 5b1f17b1804b1-4853af58154mr139887255e9.19.1773167717270;
        Tue, 10 Mar 2026 11:35:17 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ad1e4esm97168435e9.8.2026.03.10.11.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:35:16 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH] test-lib: print escape sequence names
Date: Tue, 10 Mar 2026 19:35:13 +0100
Message-ID: <20260310183513.1077875-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing expected/actual characters in failed checks, use
their names (\a, \b, \n, ...) instead of their octal representation,
making it easier to read

- Add tests to test-example-tap.c
- Update t0080-unit-test-output.sh
 to match the desired output

Teach 'print_one_char()' the equivalent name

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/helper/test-example-tap.c |  4 +++
 t/t0080-unit-test-output.sh | 58 ++++++++++++++++++++++---------------
 t/unit-tests/test-lib.c     | 19 ++++++++++--
 3 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/t/helper/test-example-tap.c b/t/helper/test-example-tap.c
index 229d495ecf..998a1f0b42 100644
--- a/t/helper/test-example-tap.c
+++ b/t/helper/test-example-tap.c
@@ -63,6 +63,8 @@ static void t_messages(void)
 	check_str("NULL", NULL);
 	check_char('a', ==, '\n');
 	check_char('\\', ==, '\'');
+	check_char('\a', ==, '\v');
+	check_char('\x00', ==, '\x01');
 }
 
 static void t_empty(void)
@@ -123,6 +125,8 @@ int cmd__example_tap(int argc UNUSED, const char **argv UNUSED)
 		check_str("NULL", NULL);
 		check_char('a', ==, '\n');
 		check_char('\\', ==, '\'');
+		check_char('\a', ==, '\v');
+		check_char('\x00', ==, '\x01');
 	}
 	if_test ("if_test test with no checks")
 		; /* nothing */
diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index 3db10f095c..11ab8b53bb 100755
--- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -6,10 +6,10 @@ test_description='Test the output of the unit test framework'
 
 test_expect_success 'TAP output from unit tests' - <<\EOT
 	cat >expect <<-EOF &&
-	# BUG: check outside of test at t/helper/test-example-tap.c:75
+	# BUG: check outside of test at t/helper/test-example-tap.c:77
 	ok 1 - passing test
 	ok 2 - passing test and assertion return 1
-	# check "1 == 2" failed at t/helper/test-example-tap.c:79
+	# check "1 == 2" failed at t/helper/test-example-tap.c:81
 	#    left: 1
 	#   right: 2
 	not ok 3 - failing test
@@ -34,53 +34,65 @@ test_expect_success 'TAP output from unit tests' - <<\EOT
 	not ok 15 - failing check after TEST_TODO()
 	ok 16 - failing check after TEST_TODO() returns 0
 	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/test-example-tap.c:62
-	#    left: "\011hello\\\\"
-	#   right: "there\"\012"
+	#    left: "\thello\\\\"
+	#   right: "there\"\n"
 	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:63
 	#    left: "NULL"
 	#   right: NULL
 	# check "'a' == '\n'" failed at t/helper/test-example-tap.c:64
 	#    left: 'a'
-	#   right: '\012'
-	# check "'\\\\' == '\\''" failed at t/helper/test-example-tap.c:65
+	#   right: '\n'
+	# check "'\\\\' == '\''" failed at t/helper/test-example-tap.c:65
 	#    left: '\\\\'
-	#   right: '\\''
+	#   right: '\''
+	# check "'\a' == '\v'" failed at t/helper/test-example-tap.c:66
+	#    left: '\a'
+	#   right: '\v'
+	# check "'\x00' == '\x01'" failed at t/helper/test-example-tap.c:67
+	#    left: '\000'
+	#   right: '\001'
 	not ok 17 - messages from failing string and char comparison
-	# BUG: test has no checks at t/helper/test-example-tap.c:94
+	# BUG: test has no checks at t/helper/test-example-tap.c:96
 	not ok 18 - test with no checks
 	ok 19 - test with no checks returns 0
 	ok 20 - if_test passing test
-	# check "1 == 2" failed at t/helper/test-example-tap.c:100
+	# check "1 == 2" failed at t/helper/test-example-tap.c:102
 	#    left: 1
 	#   right: 2
 	not ok 21 - if_test failing test
 	not ok 22 - if_test passing TEST_TODO() # TODO
-	# todo check 'check(1)' succeeded at t/helper/test-example-tap.c:104
+	# todo check 'check(1)' succeeded at t/helper/test-example-tap.c:106
 	not ok 23 - if_test failing TEST_TODO()
-	# check "0" failed at t/helper/test-example-tap.c:106
+	# check "0" failed at t/helper/test-example-tap.c:108
 	# skipping test - missing prerequisite
-	# skipping check '1' at t/helper/test-example-tap.c:108
+	# skipping check '1' at t/helper/test-example-tap.c:110
 	ok 24 - if_test test_skip() # SKIP
 	# skipping test - missing prerequisite
 	ok 25 - if_test test_skip() inside TEST_TODO() # SKIP
-	# check "0" failed at t/helper/test-example-tap.c:113
+	# check "0" failed at t/helper/test-example-tap.c:115
 	not ok 26 - if_test TEST_TODO() after failing check
-	# check "0" failed at t/helper/test-example-tap.c:119
+	# check "0" failed at t/helper/test-example-tap.c:121
 	not ok 27 - if_test failing check after TEST_TODO()
-	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/test-example-tap.c:122
-	#    left: "\011hello\\\\"
-	#   right: "there\"\012"
-	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:123
+	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/helper/test-example-tap.c:124
+	#    left: "\thello\\\\"
+	#   right: "there\"\n"
+	# check "!strcmp("NULL", NULL)" failed at t/helper/test-example-tap.c:125
 	#    left: "NULL"
 	#   right: NULL
-	# check "'a' == '\n'" failed at t/helper/test-example-tap.c:124
+	# check "'a' == '\n'" failed at t/helper/test-example-tap.c:126
 	#    left: 'a'
-	#   right: '\012'
-	# check "'\\\\' == '\\''" failed at t/helper/test-example-tap.c:125
+	#   right: '\n'
+	# check "'\\\\' == '\''" failed at t/helper/test-example-tap.c:127
 	#    left: '\\\\'
-	#   right: '\\''
+	#   right: '\''
+	# check "'\a' == '\v'" failed at t/helper/test-example-tap.c:128
+	#    left: '\a'
+	#   right: '\v'
+	# check "'\x00' == '\x01'" failed at t/helper/test-example-tap.c:129
+	#    left: '\000'
+	#   right: '\001'
 	not ok 28 - if_test messages from failing string and char comparison
-	# BUG: test has no checks at t/helper/test-example-tap.c:127
+	# BUG: test has no checks at t/helper/test-example-tap.c:131
 	not ok 29 - if_test test with no checks
 	1..29
 	EOF
diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 87e1f5c201..72ee20a06f 100644
--- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -396,8 +396,23 @@ int check_uint_loc(const char *loc, const char *check, int ok,
 static void print_one_char(char ch, char quote)
 {
 	if ((unsigned char)ch < 0x20u || ch == 0x7f) {
-		/* TODO: improve handling of \a, \b, \f ... */
-		printf("\\%03o", (unsigned char)ch);
+		char esc;
+		switch (ch) {
+		case '\a': esc = 'a'; break;
+		case '\b': esc = 'b'; break;
+		case '\t': esc = 't'; break;
+		case '\n': esc = 'n'; break;
+		case '\v': esc = 'v'; break;
+		case '\f': esc = 'f'; break;
+		case '\r': esc = 'r'; break;
+		default: esc = 0; break;
+		}
+		if (esc) {
+			putc('\\', stdout);
+			putc(esc, stdout);
+		} else {
+			printf("\\%03o", (unsigned char)ch);
+		}
 	} else {
 		if (ch == '\\' || ch == quote)
 			putc('\\', stdout);
-- 
2.43.0

