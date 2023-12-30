Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E987F
	for <git@vger.kernel.org>; Sat, 30 Dec 2023 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co/Wu+ws"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-40d4103aed7so88678515e9.3
        for <git@vger.kernel.org>; Fri, 29 Dec 2023 16:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703895116; x=1704499916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTkhP507yY/oR0GTF4J5zlG8yDjDbSwmtjYTDTWNlHM=;
        b=co/Wu+wsNCigk3idd9GjAFFoJaHxwDUQCyK3JSsgbQHhz3LoVSEzrwN/A+o+jTzp7E
         Gc05DgNPytxGRCT6+h8nH9uISJEaofCI1XqFzTKf+X+1JUXFTUkYWqV03K7dySk8YwDZ
         vSaB3Fp97ZdTzWtj2b9vEbsuuytozSXI5IIHlkdLRnrpeufvOEs/KEFEjTwgCPgKJ6YW
         oyouPBTP40pwA2dAlmOM4akpilx01vMaV4DXjSB4R8K66kyFloPuylEz/Xy39d+oK9N7
         JkaSA00DeBXs3itFqrcDYmUqzI9K7pOn+1mf7mNZ5w6qQ5BCwOhDobwQWSKInzIcn7E9
         Auhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703895116; x=1704499916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTkhP507yY/oR0GTF4J5zlG8yDjDbSwmtjYTDTWNlHM=;
        b=oaTfmyRBMxluY9xS9CGV9toa3T1me2VTmr7v2YUNtqFTYOZbzwVs15VhfvqTTJidoX
         behO6qpiXvvTW20OHpkGZDY96uD/mQbyyhdeLgZ55YGCsWSEIyGWgXhmRwNS5hS1SGYk
         kryv5z6zil/7LqtD9+94JCuON2qD/P7ubIi8+44RdjxBFB+lYw7eauCPgvS3AcsWA3Ik
         veJfkM11j+MHDgYSTEyqC0vTQ7Vsqfsqs0Dv4PdU98eg5RfqtutmsmZY9WaxYmGdITUI
         1/XckPMCCYYb118my5ej9G/3AJ25SE2/FmmZtiNFRlDc2SSNN8lt3LuXNyqQp3zVVEo1
         rXnQ==
X-Gm-Message-State: AOJu0YxW6AevXW3dbz9LK9X5EkHYSLUh4lY8oISbwKKtXgZ18nXCi3o3
	FXLM7W/DoND4yagaC57Oe+7g9BG7zlICvw==
X-Google-Smtp-Source: AGHT+IHdBcvplw7fF/RxV9ZT/gdBe9Nk3ytDeqzvM8f5edCy9FqIVBvJ5eeo+XWupCi9Ilm2s/dtyg==
X-Received: by 2002:a05:600c:34c6:b0:40d:7242:e305 with SMTP id d6-20020a05600c34c600b0040d7242e305mr1364499wmq.0.1703895115923;
        Fri, 29 Dec 2023 16:11:55 -0800 (PST)
Received: from localhost.localdomain ([41.202.207.147])
        by smtp.gmail.com with ESMTPSA id v20-20020a05600c471400b0040d77ebd55csm3672888wmo.13.2023.12.29.16.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 16:11:55 -0800 (PST)
From: Achu Luma <ach.lumap@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	l.s.r@web.de,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	steadmon@google.com,
	Achu Luma <ach.lumap@gmail.com>
Subject: [Outreachy][PATCH v2] Port helper/test-ctype.c to unit-tests/t-ctype.c
Date: Sat, 30 Dec 2023 01:09:59 +0100
Message-ID: <20231230001102.9220-1-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20231221231527.8130-1-ach.lumap@gmail.com>
References: <20231221231527.8130-1-ach.lumap@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the recent codebase update(8bf6fbd00d (Merge branch
'js/doc-unit-tests', 2023-12-09)), a new unit testing framework was
merged, providing a standardized approach for testing C code. Prior to
this update, some unit tests relied on the test helper mechanism,
lacking a dedicated unit testing framework. It's more natural to perform
these unit tests using the new unit test framework.

This commit migrates the unit tests for C character classification
functions (isdigit(), isspace(), etc) from the legacy approach
using the test-tool command `test-tool ctype` in t/helper/test-ctype.c
to the new unit testing framework (t/unit-tests/test-lib.h).

The migration involves refactoring the tests to utilize the testing
macros provided by the framework (TEST() and check_*()).

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Achu Luma <ach.lumap@gmail.com>
---
 In the revised patch, several improvements were made to the 
 TEST_CTYPE_FUNC macro. The updated version enhances error handling 
 by utilizing a direct comparison approach between the func and 
 is_in(string, i) functions across ASCII characters. Additionally, 
 the loop control variable i is locally scoped within the loop, ensuring 
 proper encapsulation. These changes streamline the comparison process 
 and clarify failure reporting. Special thanks to the invaluable reviews 
 by Junio, Phillip and René for their insightful feedback and thorough 
 review of the patch, contributing significantly to these changes.

 Makefile               |  2 +-
 t/helper/test-ctype.c  | 70 --------------------------------------
 t/helper/test-tool.c   |  1 -
 t/helper/test-tool.h   |  1 -
 t/t0070-fundamental.sh |  4 ---
 t/unit-tests/t-ctype.c | 77 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 78 insertions(+), 77 deletions(-)
 delete mode 100644 t/helper/test-ctype.c
 create mode 100644 t/unit-tests/t-ctype.c

diff --git a/Makefile b/Makefile
index 88ba7a3c51..a4df48ba65 100644
--- a/Makefile
+++ b/Makefile
@@ -792,7 +792,6 @@ TEST_BUILTINS_OBJS += test-chmtime.o
 TEST_BUILTINS_OBJS += test-config.o
 TEST_BUILTINS_OBJS += test-crontab.o
 TEST_BUILTINS_OBJS += test-csprng.o
-TEST_BUILTINS_OBJS += test-ctype.o
 TEST_BUILTINS_OBJS += test-date.o
 TEST_BUILTINS_OBJS += test-delta.o
 TEST_BUILTINS_OBJS += test-dir-iterator.o
@@ -1341,6 +1340,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 
 UNIT_TEST_PROGRAMS += t-basic
 UNIT_TEST_PROGRAMS += t-strbuf
+UNIT_TEST_PROGRAMS += t-ctype
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
deleted file mode 100644
index e5659df40b..0000000000
--- a/t/helper/test-ctype.c
+++ /dev/null
@@ -1,70 +0,0 @@
-#include "test-tool.h"
-
-static int rc;
-
-static void report_error(const char *class, int ch)
-{
-	printf("%s classifies char %d (0x%02x) wrongly\n", class, ch, ch);
-	rc = 1;
-}
-
-static int is_in(const char *s, int ch)
-{
-	/*
-	 * We can't find NUL using strchr. Accept it as the first
-	 * character in the spec -- there are no empty classes.
-	 */
-	if (ch == '\0')
-		return ch == *s;
-	if (*s == '\0')
-		s++;
-	return !!strchr(s, ch);
-}
-
-#define TEST_CLASS(t,s) {			\
-	int i;					\
-	for (i = 0; i < 256; i++) {		\
-		if (is_in(s, i) != t(i))	\
-			report_error(#t, i);	\
-	}					\
-	if (t(EOF))				\
-		report_error(#t, EOF);		\
-}
-
-#define DIGIT "0123456789"
-#define LOWER "abcdefghijklmnopqrstuvwxyz"
-#define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
-#define PUNCT "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
-#define ASCII \
-	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
-	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
-	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
-	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
-	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
-	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
-	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
-	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
-#define CNTRL \
-	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
-	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
-	"\x7f"
-
-int cmd__ctype(int argc UNUSED, const char **argv UNUSED)
-{
-	TEST_CLASS(isdigit, DIGIT);
-	TEST_CLASS(isspace, " \n\r\t");
-	TEST_CLASS(isalpha, LOWER UPPER);
-	TEST_CLASS(isalnum, LOWER UPPER DIGIT);
-	TEST_CLASS(is_glob_special, "*?[\\");
-	TEST_CLASS(is_regex_special, "$()*+.?[\\^{|");
-	TEST_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=>@_`~");
-	TEST_CLASS(isascii, ASCII);
-	TEST_CLASS(islower, LOWER);
-	TEST_CLASS(isupper, UPPER);
-	TEST_CLASS(iscntrl, CNTRL);
-	TEST_CLASS(ispunct, PUNCT);
-	TEST_CLASS(isxdigit, DIGIT "abcdefABCDEF");
-	TEST_CLASS(isprint, LOWER UPPER DIGIT PUNCT " ");
-
-	return rc;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 37ba996539..33b9501c21 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -19,7 +19,6 @@ static struct test_cmd cmds[] = {
 	{ "config", cmd__config },
 	{ "crontab", cmd__crontab },
 	{ "csprng", cmd__csprng },
-	{ "ctype", cmd__ctype },
 	{ "date", cmd__date },
 	{ "delta", cmd__delta },
 	{ "dir-iterator", cmd__dir_iterator },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 8a1a7c63da..b72f07ded9 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -12,7 +12,6 @@ int cmd__chmtime(int argc, const char **argv);
 int cmd__config(int argc, const char **argv);
 int cmd__crontab(int argc, const char **argv);
 int cmd__csprng(int argc, const char **argv);
-int cmd__ctype(int argc, const char **argv);
 int cmd__date(int argc, const char **argv);
 int cmd__delta(int argc, const char **argv);
 int cmd__dir_iterator(int argc, const char **argv);
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 487bc8d905..a4756fbab9 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -9,10 +9,6 @@ Verify wrappers and compatibility functions.
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-test_expect_success 'character classes (isspace, isalpha etc.)' '
-	test-tool ctype
-'
-
 test_expect_success 'mktemp to nonexistent directory prints filename' '
 	test_must_fail test-tool mktemp doesnotexist/testXXXXXX 2>err &&
 	grep "doesnotexist/test" err
diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
new file mode 100644
index 0000000000..8a215d387a
--- /dev/null
+++ b/t/unit-tests/t-ctype.c
@@ -0,0 +1,77 @@
+#include "test-lib.h"
+
+static int is_in(const char *s, int ch)
+{
+	/*
+	 * We can't find NUL using strchr. Accept it as the first
+	 * character in the spec -- there are no empty classes.
+	 */
+	if (ch == '\0')
+		return ch == *s;
+	if (*s == '\0')
+		s++;
+	return !!strchr(s, ch);
+}
+
+/* Macro to test a character type */
+#define TEST_CTYPE_FUNC(func, string)				\
+static void test_ctype_##func(void)				\
+{								\
+	for (int i = 0; i < 256; i++) {				\
+        	if (!check_int(func(i), ==, is_in(string, i))) 	\
+        		test_msg("       i: %02x", i);		\
+        } 							\
+}
+
+#define DIGIT "0123456789"
+#define LOWER "abcdefghijklmnopqrstuvwxyz"
+#define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+#define PUNCT "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
+#define ASCII \
+	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
+	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
+	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
+	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
+	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
+	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
+	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
+	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"
+#define CNTRL \
+	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
+	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
+	"\x7f"
+
+TEST_CTYPE_FUNC(isdigit, DIGIT)
+TEST_CTYPE_FUNC(isspace, " \n\r\t")
+TEST_CTYPE_FUNC(isalpha, LOWER UPPER)
+TEST_CTYPE_FUNC(isalnum, LOWER UPPER DIGIT)
+TEST_CTYPE_FUNC(is_glob_special, "*?[\\")
+TEST_CTYPE_FUNC(is_regex_special, "$()*+.?[\\^{|")
+TEST_CTYPE_FUNC(is_pathspec_magic, "!\"#%&',-/:;<=>@_`~")
+TEST_CTYPE_FUNC(isascii, ASCII)
+TEST_CTYPE_FUNC(islower, LOWER)
+TEST_CTYPE_FUNC(isupper, UPPER)
+TEST_CTYPE_FUNC(iscntrl, CNTRL)
+TEST_CTYPE_FUNC(ispunct, PUNCT)
+TEST_CTYPE_FUNC(isxdigit, DIGIT "abcdefABCDEF")
+TEST_CTYPE_FUNC(isprint, LOWER UPPER DIGIT PUNCT " ")
+
+int cmd_main(int argc, const char **argv) {
+	/* Run all character type tests */
+	TEST(test_ctype_isspace(), "isspace() works as we expect");
+	TEST(test_ctype_isdigit(), "isdigit() works as we expect");
+	TEST(test_ctype_isalpha(), "isalpha() works as we expect");
+	TEST(test_ctype_isalnum(), "isalnum() works as we expect");
+	TEST(test_ctype_is_glob_special(), "is_glob_special() works as we expect");
+	TEST(test_ctype_is_regex_special(), "is_regex_special() works as we expect");
+	TEST(test_ctype_is_pathspec_magic(), "is_pathspec_magic() works as we expect");
+	TEST(test_ctype_isascii(), "isascii() works as we expect");
+	TEST(test_ctype_islower(), "islower() works as we expect");
+	TEST(test_ctype_isupper(), "isupper() works as we expect");
+	TEST(test_ctype_iscntrl(), "iscntrl() works as we expect");
+	TEST(test_ctype_ispunct(), "ispunct() works as we expect");
+	TEST(test_ctype_isxdigit(), "isxdigit() works as we expect");
+	TEST(test_ctype_isprint(), "isprint() works as we expect");
+
+	return test_done();
+}
-- 
2.42.0.windows.2

