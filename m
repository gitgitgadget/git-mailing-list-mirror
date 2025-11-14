Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E020A27F005
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763099577; cv=none; b=Iciw9+wzjWqumFURTUHanBS6/C0A1Et6apmrUpSuTSXUUHSgiDSVrOZ5bfy4yv7Roxol4WJzrujIhITE4HS+rrvXZCqO2MFtEF4zXF2kJkioUiR1uHRICSmrwHHBvQ0Mu31IUvRHr8Uk6lC25SoVSuq9QwZvWUFG17VqOGmOcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763099577; c=relaxed/simple;
	bh=9Dmcnr+Lps4FJjZcBQK1rSPNvjDQT7T3XmRXJQEHiLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8Kc8JkboEU/TTTnzQZlIXnsaTpHbcx1z6BESmioQXN3d/sJl17eww04p0T7XZdfas/C8TYrGXwEzTZuPRqdI/EcrJrhbPnh/xLkNoh4y1Tfe6LWonU9btU2Kb5z3yA5/JpD8YcQMdGbtOOE9eqPgFs0qDxRUOBQmAYM0nUzaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Src1M1l0; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Src1M1l0"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78802ac22abso16702037b3.3
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 21:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763099575; x=1763704375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RpSHVoy6gRSryu9knbc266q8DYfUYbLMOryFyH7O9k=;
        b=Src1M1l0dPtTel/meMkM3mSAiwNJlwLM4O+6WqowdooY+G7sraVGu9R50NTZfT7ORh
         6tU/6sPZGs994+W4r+bCO6BUFHOY7KOKA5W1VA7X/ukY3LF2ZLIKCLR5Nm9OgkudoU/q
         lWBOWCYge3O2IrIBwtfaN7jXi8IfMeg1AqE7857INVjsugKym2vIU5wdzSyodN6LQvvW
         TrxTNTIQaFZQMJPLYNdTrymOcKAQdq05eGjMQdeoL0/VoUhuFp/wo8Nug49pRzT3V0vm
         HRo1Vvy51/Z+NpkmBIB+OFUiGKxXevB9JBHUBNUYwzOYOy9/9H3X4iUUGf7bTuQKcn51
         OdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763099575; x=1763704375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7RpSHVoy6gRSryu9knbc266q8DYfUYbLMOryFyH7O9k=;
        b=NcobEuDyXsy8K+66sE7J5cwXq02pQbJDYiHhmVYCJgG/C7coQn7IVHn8QNGu1fN6py
         qgZiTUyjBMCI0S7Jgj/u9Iw8Od8w8LTppLTu+ptSyPNJRT7oL+BNwIahpLqnygAi4Qo0
         fWMTNVptEbarhF2fe1uCk+tDMPlKU6cP150exBiwOmTatludjWiYnSeN0/02IocXZmBL
         /d1TM1hMR0Dlxw+021tKyLpJsK7eVpmEfdtgr4qphnoWzaja9spUxRxc5QiesN30969L
         vTvGkVP7cZOtFlMrSINbhmgvg3HsJsxFBnlm/jPlCKFRngwNa14iwWZ/iH7PVw4rr5BJ
         tdgw==
X-Forwarded-Encrypted: i=1; AJvYcCVXySnkJ2TGO2jBXcBs9ttk6Zf8KcuMnXsr7Ke7d/dgcEyYSBR2p07NFyPjNgG0aG4QA+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXAhn54Qv+3Dbk4XOAAbkWnZbAjJKYkgj1CIhZIHJM7C7xbnp
	Z0F83LEt3USvKGBSR46s2wW3JcXQHUxqcYjq5OkNrvrfCMUmJd4u027P
X-Gm-Gg: ASbGnctIV3pZkKYxFtxyGaWBYLpPXdlnLGUkAB5R3klIu35OSJNKVI31r+U2ZerqqGp
	KTAp1mnmeXoFP6BL/cZa4HCGPLjLzAIghP4eVIStICNP89Bu0W8BV91gNVN1JzrYOsiDoI/FWZS
	+xvoUWJrTFst692eb8Q+5+mLJVKFZrbtIZpSF9+GvzH9jFxp5dEYgnp4N6iY4qjFc2o4NfEs4jm
	BxNM+GllZwDyJMW9x45BFUnB1SmMuKH/WBNnyhMSiTkPwv0pxnJ/67Ghlntn9hzwOIyyNPkVmrk
	4Z3HcrZ488FcP56b/1mn9okp8qgnDZIgEKwXVK+51uOt4Q33yCsqz7WAS4yfYCw8bXBenQq6k0G
	Jb8XIFlr1Sit9ut0N6k/gS/4EkLIDl1NFBbXq/5eisshexRP3GYIZEYPgSqRURwCyaXs74mMtmR
	Eir+xg1NeXPpg9mth7/CRETmUZh35Yqm3fKpmJi0laxPdIM6jmVyCE8M812Vz93QTbx4VgH/trj
	CVFp7hHVrM=
X-Google-Smtp-Source: AGHT+IHwxhM/ud5tks0HZtYzK26hpGTU70PnYK4aMMecGcjGFOUTtTwuEIcFY6skS2LcUGOd0/9SVw==
X-Received: by 2002:a05:690e:148b:b0:63f:bd67:7c5f with SMTP id 956f58d0204a3-641e74aff3bmr1625406d50.7.1763099574827;
        Thu, 13 Nov 2025 21:52:54 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410ea037besm1411408d50.9.2025.11.13.21.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 21:52:54 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Justin Tobler <jltobler@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 1/2] t/unit-tests: add UTF-8 width tests for CJK chars
Date: Fri, 14 Nov 2025 00:52:44 -0500
Message-ID: <04ab347ff80e16d49524246a8923cc86cc7355be.1763098804.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <cover.1763098804.git.worldhello.net@gmail.com>
References: <cover.1763098804.git.worldhello.net@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit adds a new test suite (u-utf8-width.c) to test the UTF-8
width functions in Git, particularly focusing on multi-byte characters
from East Asian languages like Chinese, Japanese, and Korean that
typically require 2 display columns per character.

The test suite includes:
- Tests for utf8_strnwidth with Chinese strings
- Tests for utf8_strwidth with Chinese strings
- Tests for Japanese and Korean characters
- Edge case tests with invalid UTF-8 sequences
- Proper test function naming following the Clar framework convention

Also updated the build configuration in Makefile and meson.build to
include the new test suite in the build process.

Co-developed-by: Claude <noreply@anthropic.com>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Makefile                    |  1 +
 t/meson.build               |  1 +
 t/unit-tests/u-utf8-width.c | 85 +++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 t/unit-tests/u-utf8-width.c

diff --git a/Makefile b/Makefile
index 7e0f77e298..2a67546154 100644
--- a/Makefile
+++ b/Makefile
@@ -1525,6 +1525,7 @@ CLAR_TEST_SUITES += u-string-list
 CLAR_TEST_SUITES += u-strvec
 CLAR_TEST_SUITES += u-trailer
 CLAR_TEST_SUITES += u-urlmatch-normalization
+CLAR_TEST_SUITES += u-utf8-width
 CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
 CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
diff --git a/t/meson.build b/t/meson.build
index a5531df415..dc43d69636 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -24,6 +24,7 @@ clar_test_suites = [
   'unit-tests/u-strvec.c',
   'unit-tests/u-trailer.c',
   'unit-tests/u-urlmatch-normalization.c',
+  'unit-tests/u-utf8-width.c',
 ]
 
 clar_sources = [
diff --git a/t/unit-tests/u-utf8-width.c b/t/unit-tests/u-utf8-width.c
new file mode 100644
index 0000000000..455294ca90
--- /dev/null
+++ b/t/unit-tests/u-utf8-width.c
@@ -0,0 +1,85 @@
+#include "unit-test.h"
+#include "utf8.h"
+#include "strbuf.h"
+
+/*
+ * Test utf8_strnwidth with various Chinese strings
+ * Chinese characters typically have a width of 2 columns when displayed
+ */
+void test_utf8_width__strnwidth_chinese(void)
+{
+	const char *ansi_test;
+	const char *str;
+
+	/* Test basic ASCII - each character should have width 1 */
+	cl_assert_equal_i(5, utf8_strnwidth("hello", 5, 0));
+	cl_assert_equal_i(5, utf8_strnwidth("hello", 5, 1));  /* skip_ansi = 1 */
+
+	/* Test simple Chinese characters - each should have width 2 */
+	cl_assert_equal_i(4, utf8_strnwidth("你好", 6, 0));  /* "你好" is 6 bytes (3 bytes per char in UTF-8), 4 display columns */
+
+	/* Test mixed ASCII and Chinese - ASCII = 1 column, Chinese = 2 columns */
+	cl_assert_equal_i(6, utf8_strnwidth("hi你好", 8, 0));  /* "h"(1) + "i"(1) + "你"(2) + "好"(2) = 6 */
+
+	/* Test longer Chinese string */
+	cl_assert_equal_i(10, utf8_strnwidth("你好世界！", 15, 0));  /* 5 Chinese chars = 10 display columns */
+
+	/* Test with skip_ansi = 1 to make sure it works with escape sequences */
+	ansi_test = "\033[31m你好\033[0m";
+	cl_assert_equal_i(4, utf8_strnwidth(ansi_test, strlen(ansi_test), 1));  /* Skip escape sequences, just count "你好" which should be 4 columns */
+
+	/* Test individual Chinese character width */
+	cl_assert_equal_i(2, utf8_strnwidth("中", 3, 0));  /* Single Chinese char should be 2 columns */
+
+	/* Test empty string */
+	cl_assert_equal_i(0, utf8_strnwidth("", 0, 0));
+
+	/* Test length limiting */
+	str = "你好世界";
+	cl_assert_equal_i(2, utf8_strnwidth(str, 3, 0));  /* Only first char "你"(2 columns) within 3 bytes */
+	cl_assert_equal_i(4, utf8_strnwidth(str, 6, 0));  /* First two chars "你好"(4 columns) in 6 bytes */
+}
+
+/*
+ * Tests for utf8_strwidth (simpler version without length limit)
+ */
+void test_utf8_width__strwidth_chinese(void)
+{
+	/* Test basic ASCII */
+	cl_assert_equal_i(5, utf8_strwidth("hello"));
+
+	/* Test Chinese characters */
+	cl_assert_equal_i(4, utf8_strwidth("你好"));  /* 2 Chinese chars = 4 display columns */
+
+	/* Test mixed ASCII and Chinese */
+	cl_assert_equal_i(9, utf8_strwidth("hello世界"));  /* 5 ASCII (5 cols) + 2 Chinese (4 cols) = 9 */
+	cl_assert_equal_i(7, utf8_strwidth("hi世界!"));   /* 2 ASCII (2 cols) + 2 Chinese (4 cols) + 1 ASCII (1 col) = 7 */
+}
+
+/*
+ * Additional tests with other East Asian characters
+ */
+void test_utf8_width__strnwidth_japanese_korean(void)
+{
+	/* Japanese characters (should also be 2 columns each) */
+	cl_assert_equal_i(10, utf8_strnwidth("こんにちは", 15, 0));  /* 5 Japanese chars @ 2 cols each = 10 display columns */
+
+	/* Korean characters (should also be 2 columns each) */
+	cl_assert_equal_i(10, utf8_strnwidth("안녕하세요", 15, 0));  /* 5 Korean chars @ 2 cols each = 10 display columns */
+}
+
+/*
+ * Test edge cases with partial UTF-8 sequences
+ */
+void test_utf8_width__strnwidth_edge_cases(void)
+{
+	const char *invalid;
+	unsigned char truncated_bytes[] = {0xe4, 0xbd, 0x00};  /* First 2 bytes of "中" + null */
+
+	/* Test invalid UTF-8 - should fall back to byte count */
+	invalid = "\xff\xfe";  /* Invalid UTF-8 sequence */
+	cl_assert_equal_i(2, utf8_strnwidth(invalid, 2, 0));  /* Should return length if invalid UTF-8 */
+
+	/* Test partial UTF-8 character (truncated) */
+	cl_assert_equal_i(2, utf8_strnwidth((const char*)truncated_bytes, 2, 0));  /* Invalid UTF-8, returns byte count */
+}
-- 
2.52.0.rc2.5.g4c20a63325.dirty

