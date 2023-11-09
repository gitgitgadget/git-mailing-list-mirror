Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD14524D
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2UQ3eYd"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64493C1B
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:50:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da3dd6a72a7so1471894276.0
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 10:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699555852; x=1700160652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N3uQn2zwkv7MQ66AWXKy26hAwavxnOLm/fZYPVySgps=;
        b=s2UQ3eYdcPla3bAhofjgZbxRsOfGq7vSGLool514a/ZMmRvSa8T/IbF2P+eA2UZn5u
         VdKbcYs8wvfIJByCS2w4ucEIO20RlaKTm9NHjZSLAazn8jkEqEy9abq7I/UtbNNMMXXC
         Gagdyg8IJ7RzFYd1EGNP47m4PMYge5OC8p1AYanm72OqoU6lS1M+0VfRT5lv9K9AvCzM
         T2YNUy17247V3vYOHY6AuK2eBjjBo1AheSFzLqkhIiRQJULJBhogX5iMLQ/NMh3O2qo4
         DBABuID1LkK/Wza17epj2/2X4vpwMU5+t9KxIdqSmR9DvVrPoz6lRkVwJPatF4pIdtdE
         qlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699555852; x=1700160652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N3uQn2zwkv7MQ66AWXKy26hAwavxnOLm/fZYPVySgps=;
        b=MH60PMomMG2XWH1jGGF+MJ6pD1fC7sk9lwxIMxr/Fy6+Ix2ku61TaSZvK3Q/ajSVUP
         isD+R+q+T67azq+cYg8AdD7q9P6Ewmn39ai7W+rgG7Ts4FS2iG+TgxnxinIvQrtanq0n
         PELcMgx/VD7r4b0MGDNjBz0e4Gl1aNWsWQCO1eH1tJnPmm1sUFemkI/0N7UoF1RHoox3
         KLK0r4ePAellWQfAWCNh0P3o5IcJqH9IkLCzPqFTgvNP+u4uYDuBswSnTcWxJGr8+0sU
         G2LeNPs4mKFVSFJWURt4i2cXWN40KEkZy8UrFEQ89ov7XrbJGRDyYxiPcvmGmlxcPuqf
         LPaA==
X-Gm-Message-State: AOJu0Ywq8Yv5ColTztnuJgDXM4SmDghR08N1K+vw+am4InAYypnnP7aU
	AaT6LKA25BwbgsswzZEyYqeMbvwmdrcxVsq+ruRQVI/QjE/8U20uRFOVsiP3hFRyQhx+d1U2mPI
	de4Fzfu+f8Dmhg1SPdoO8Um4K6Y1NhOl+wYdIZMzsMUCeoWlnPBhXTv6F84FJPsk=
X-Google-Smtp-Source: AGHT+IEWBM0UXP/2OAExhkoJHvjA07xaECDJKolODyUiWIQcgFpsNWRW3dhc4Bq07epl2YPlRBM/pf/bZbnw3A==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5c8e:97b9:4fad:1ea4])
 (user=steadmon job=sendgmr) by 2002:a25:d384:0:b0:d9a:c27e:5f37 with SMTP id
 e126-20020a25d384000000b00d9ac27e5f37mr149678ybf.3.1699555851973; Thu, 09 Nov
 2023 10:50:51 -0800 (PST)
Date: Thu,  9 Nov 2023 10:50:43 -0800
In-Reply-To: <cover.1699555664.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1699555664.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <7a5e21bcff577b9ffaa01ffd8e96d07a0a293ac0.1699555664.git.steadmon@google.com>
Subject: [PATCH v10 2/3] unit tests: add TAP unit test framework
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood123@gmail.com, oswald.buddenhagen@gmx.de, 
	christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This patch contains an implementation for writing unit tests with TAP
output. Each test is a function that contains one or more checks. The
test is run with the TEST() macro and if any of the checks fail then the
test will fail. A complete program that tests STRBUF_INIT would look
like

     #include "test-lib.h"
     #include "strbuf.h"

     static void t_static_init(void)
     {
             struct strbuf buf = STRBUF_INIT;

             check_uint(buf.len, ==, 0);
             check_uint(buf.alloc, ==, 0);
             check_char(buf.buf[0], ==, '\0');
     }

     int main(void)
     {
             TEST(t_static_init(), "static initialization works);

             return test_done();
     }

The output of this program would be

     ok 1 - static initialization works
     1..1

If any of the checks in a test fail then they print a diagnostic message
to aid debugging and the test will be reported as failing. For example a
failing integer check would look like

     # check "x >= 3" failed at my-test.c:102
     #    left: 2
     #   right: 3
     not ok 1 - x is greater than or equal to three

There are a number of check functions implemented so far. check() checks
a boolean condition, check_int(), check_uint() and check_char() take two
values to compare and a comparison operator. check_str() will check if
two strings are equal. Custom checks are simple to implement as shown in
the comments above test_assert() in test-lib.h.

Tests can be skipped with test_skip() which can be supplied with a
reason for skipping which it will print. Tests can print diagnostic
messages with test_msg().  Checks that are known to fail can be wrapped
in TEST_TODO().

There are a couple of example test programs included in this
patch. t-basic.c implements some self-tests and demonstrates the
diagnostic output for failing test. The output of this program is
checked by t0080-unit-test-output.sh. t-strbuf.c shows some example
unit tests for strbuf.c

The unit tests will be built as part of the default "make all" target,
to avoid bitrot. If you wish to build just the unit tests, you can run
"make build-unit-tests". To run the tests, you can use "make unit-tests"
or run the test binaries directly, as in "./t/unit-tests/bin/t-strbuf".

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                    |  28 ++-
 t/Makefile                  |  15 +-
 t/t0080-unit-test-output.sh |  58 +++++++
 t/unit-tests/.gitignore     |   1 +
 t/unit-tests/t-basic.c      |  95 +++++++++++
 t/unit-tests/t-strbuf.c     | 120 +++++++++++++
 t/unit-tests/test-lib.c     | 330 ++++++++++++++++++++++++++++++++++++
 t/unit-tests/test-lib.h     | 149 ++++++++++++++++
 8 files changed, 792 insertions(+), 4 deletions(-)
 create mode 100755 t/t0080-unit-test-output.sh
 create mode 100644 t/unit-tests/.gitignore
 create mode 100644 t/unit-tests/t-basic.c
 create mode 100644 t/unit-tests/t-strbuf.c
 create mode 100644 t/unit-tests/test-lib.c
 create mode 100644 t/unit-tests/test-lib.h

diff --git a/Makefile b/Makefile
index e440728c24..18c13f06c0 100644
--- a/Makefile
+++ b/Makefile
@@ -682,6 +682,9 @@ TEST_BUILTINS_OBJS =
 TEST_OBJS =
 TEST_PROGRAMS_NEED_X =
 THIRD_PARTY_SOURCES =
+UNIT_TEST_PROGRAMS =
+UNIT_TEST_DIR = t/unit-tests
+UNIT_TEST_BIN = $(UNIT_TEST_DIR)/bin
 
 # Having this variable in your environment would break pipelines because
 # you cause "cd" to echo its destination to stdout.  It can also take
@@ -1331,6 +1334,12 @@ THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
+UNIT_TEST_PROGRAMS += t-basic
+UNIT_TEST_PROGRAMS += t-strbuf
+UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
+UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
+UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
+
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
 EXTLIBS =
@@ -2672,6 +2681,7 @@ OBJECTS += $(TEST_OBJS)
 OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
+OBJECTS += $(UNIT_TEST_OBJS)
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3167,7 +3177,7 @@ endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
-all:: $(TEST_PROGRAMS) $(test_bindir_programs)
+all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
@@ -3592,7 +3602,7 @@ endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
-		$(MOFILES)
+		$(UNIT_TEST_PROGS) $(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 	test -n "$(ARTIFACTS_DIRECTORY)"
@@ -3653,7 +3663,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
-	$(RM) $(TEST_PROGRAMS)
+	$(RM) $(TEST_PROGRAMS) $(UNIT_TEST_PROGS)
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
@@ -3831,3 +3841,15 @@ $(FUZZ_PROGRAMS): all
 		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
 
 fuzz-all: $(FUZZ_PROGRAMS)
+
+$(UNIT_TEST_BIN):
+	@mkdir -p $(UNIT_TEST_BIN)
+
+$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS $(UNIT_TEST_BIN)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
+
+.PHONY: build-unit-tests unit-tests
+build-unit-tests: $(UNIT_TEST_PROGS)
+unit-tests: $(UNIT_TEST_PROGS)
+	$(MAKE) -C t/ unit-tests
diff --git a/t/Makefile b/t/Makefile
index 3e00cdd801..75d9330437 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -17,6 +17,7 @@ TAR ?= $(TAR)
 RM ?= rm -f
 PROVE ?= prove
 DEFAULT_TEST_TARGET ?= test
+DEFAULT_UNIT_TEST_TARGET ?= unit-tests-raw
 TEST_LINT ?= test-lint
 
 ifdef TEST_OUTPUT_DIRECTORY
@@ -41,6 +42,7 @@ TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
+UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(wildcard unit-tests/bin/t-*)))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
@@ -65,6 +67,17 @@ prove: pre-clean check-chainlint $(TEST_LINT)
 $(T):
 	@echo "*** $@ ***"; '$(TEST_SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
+$(UNIT_TESTS):
+	@echo "*** $@ ***"; $@
+
+.PHONY: unit-tests unit-tests-raw unit-tests-prove
+unit-tests: $(DEFAULT_UNIT_TEST_TARGET)
+
+unit-tests-raw: $(UNIT_TESTS)
+
+unit-tests-prove:
+	@echo "*** prove - unit tests ***"; $(PROVE) $(GIT_PROVE_OPTS) $(UNIT_TESTS)
+
 pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
@@ -149,4 +162,4 @@ perf:
 	$(MAKE) -C perf/ all
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
-	check-chainlint clean-chainlint test-chainlint
+	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
new file mode 100755
index 0000000000..961b54b06c
--- /dev/null
+++ b/t/t0080-unit-test-output.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='Test the output of the unit test framework'
+
+. ./test-lib.sh
+
+test_expect_success 'TAP output from unit tests' '
+	cat >expect <<-EOF &&
+	ok 1 - passing test
+	ok 2 - passing test and assertion return 1
+	# check "1 == 2" failed at t/unit-tests/t-basic.c:76
+	#    left: 1
+	#   right: 2
+	not ok 3 - failing test
+	ok 4 - failing test and assertion return 0
+	not ok 5 - passing TEST_TODO() # TODO
+	ok 6 - passing TEST_TODO() returns 1
+	# todo check ${SQ}check(x)${SQ} succeeded at t/unit-tests/t-basic.c:25
+	not ok 7 - failing TEST_TODO()
+	ok 8 - failing TEST_TODO() returns 0
+	# check "0" failed at t/unit-tests/t-basic.c:30
+	# skipping test - missing prerequisite
+	# skipping check ${SQ}1${SQ} at t/unit-tests/t-basic.c:32
+	ok 9 - test_skip() # SKIP
+	ok 10 - skipped test returns 1
+	# skipping test - missing prerequisite
+	ok 11 - test_skip() inside TEST_TODO() # SKIP
+	ok 12 - test_skip() inside TEST_TODO() returns 1
+	# check "0" failed at t/unit-tests/t-basic.c:48
+	not ok 13 - TEST_TODO() after failing check
+	ok 14 - TEST_TODO() after failing check returns 0
+	# check "0" failed at t/unit-tests/t-basic.c:56
+	not ok 15 - failing check after TEST_TODO()
+	ok 16 - failing check after TEST_TODO() returns 0
+	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/unit-tests/t-basic.c:61
+	#    left: "\011hello\\\\"
+	#   right: "there\"\012"
+	# check "!strcmp("NULL", NULL)" failed at t/unit-tests/t-basic.c:62
+	#    left: "NULL"
+	#   right: NULL
+	# check "${SQ}a${SQ} == ${SQ}\n${SQ}" failed at t/unit-tests/t-basic.c:63
+	#    left: ${SQ}a${SQ}
+	#   right: ${SQ}\012${SQ}
+	# check "${SQ}\\\\${SQ} == ${SQ}\\${SQ}${SQ}" failed at t/unit-tests/t-basic.c:64
+	#    left: ${SQ}\\\\${SQ}
+	#   right: ${SQ}\\${SQ}${SQ}
+	not ok 17 - messages from failing string and char comparison
+	# BUG: test has no checks at t/unit-tests/t-basic.c:91
+	not ok 18 - test with no checks
+	ok 19 - test with no checks returns 0
+	1..19
+	EOF
+
+	! "$GIT_BUILD_DIR"/t/unit-tests/bin/t-basic >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/unit-tests/.gitignore b/t/unit-tests/.gitignore
new file mode 100644
index 0000000000..5e56e040ec
--- /dev/null
+++ b/t/unit-tests/.gitignore
@@ -0,0 +1 @@
+/bin
diff --git a/t/unit-tests/t-basic.c b/t/unit-tests/t-basic.c
new file mode 100644
index 0000000000..fda1ae59a6
--- /dev/null
+++ b/t/unit-tests/t-basic.c
@@ -0,0 +1,95 @@
+#include "test-lib.h"
+
+/*
+ * The purpose of this "unit test" is to verify a few invariants of the unit
+ * test framework itself, as well as to provide examples of output from actually
+ * failing tests. As such, it is intended that this test fails, and thus it
+ * should not be run as part of `make unit-tests`. Instead, we verify it behaves
+ * as expected in the integration test t0080-unit-test-output.sh
+ */
+
+/* Used to store the return value of check_int(). */
+static int check_res;
+
+/* Used to store the return value of TEST(). */
+static int test_res;
+
+static void t_res(int expect)
+{
+	check_int(check_res, ==, expect);
+	check_int(test_res, ==, expect);
+}
+
+static void t_todo(int x)
+{
+	check_res = TEST_TODO(check(x));
+}
+
+static void t_skip(void)
+{
+	check(0);
+	test_skip("missing prerequisite");
+	check(1);
+}
+
+static int do_skip(void)
+{
+	test_skip("missing prerequisite");
+	return 1;
+}
+
+static void t_skip_todo(void)
+{
+	check_res = TEST_TODO(do_skip());
+}
+
+static void t_todo_after_fail(void)
+{
+	check(0);
+	TEST_TODO(check(0));
+}
+
+static void t_fail_after_todo(void)
+{
+	check(1);
+	TEST_TODO(check(0));
+	check(0);
+}
+
+static void t_messages(void)
+{
+	check_str("\thello\\", "there\"\n");
+	check_str("NULL", NULL);
+	check_char('a', ==, '\n');
+	check_char('\\', ==, '\'');
+}
+
+static void t_empty(void)
+{
+	; /* empty */
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	test_res = TEST(check_res = check_int(1, ==, 1), "passing test");
+	TEST(t_res(1), "passing test and assertion return 1");
+	test_res = TEST(check_res = check_int(1, ==, 2), "failing test");
+	TEST(t_res(0), "failing test and assertion return 0");
+	test_res = TEST(t_todo(0), "passing TEST_TODO()");
+	TEST(t_res(1), "passing TEST_TODO() returns 1");
+	test_res = TEST(t_todo(1), "failing TEST_TODO()");
+	TEST(t_res(0), "failing TEST_TODO() returns 0");
+	test_res = TEST(t_skip(), "test_skip()");
+	TEST(check_int(test_res, ==, 1), "skipped test returns 1");
+	test_res = TEST(t_skip_todo(), "test_skip() inside TEST_TODO()");
+	TEST(t_res(1), "test_skip() inside TEST_TODO() returns 1");
+	test_res = TEST(t_todo_after_fail(), "TEST_TODO() after failing check");
+	TEST(check_int(test_res, ==, 0), "TEST_TODO() after failing check returns 0");
+	test_res = TEST(t_fail_after_todo(), "failing check after TEST_TODO()");
+	TEST(check_int(test_res, ==, 0), "failing check after TEST_TODO() returns 0");
+	TEST(t_messages(), "messages from failing string and char comparison");
+	test_res = TEST(t_empty(), "test with no checks");
+	TEST(check_int(test_res, ==, 0), "test with no checks returns 0");
+
+	return test_done();
+}
diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
new file mode 100644
index 0000000000..de434a4441
--- /dev/null
+++ b/t/unit-tests/t-strbuf.c
@@ -0,0 +1,120 @@
+#include "test-lib.h"
+#include "strbuf.h"
+
+/* wrapper that supplies tests with an empty, initialized strbuf */
+static void setup(void (*f)(struct strbuf*, void*), void *data)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	f(&buf, data);
+	strbuf_release(&buf);
+	check_uint(buf.len, ==, 0);
+	check_uint(buf.alloc, ==, 0);
+}
+
+/* wrapper that supplies tests with a populated, initialized strbuf */
+static void setup_populated(void (*f)(struct strbuf*, void*), char *init_str, void *data)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addstr(&buf, init_str);
+	check_uint(buf.len, ==, strlen(init_str));
+	f(&buf, data);
+	strbuf_release(&buf);
+	check_uint(buf.len, ==, 0);
+	check_uint(buf.alloc, ==, 0);
+}
+
+static int assert_sane_strbuf(struct strbuf *buf)
+{
+	/* Initialized strbufs should always have a non-NULL buffer */
+	if (!check(!!buf->buf))
+		return 0;
+	/* Buffers should always be NUL-terminated */
+	if (!check_char(buf->buf[buf->len], ==, '\0'))
+		return 0;
+	/*
+	 * Freshly-initialized strbufs may not have a dynamically allocated
+	 * buffer
+	 */
+	if (buf->len == 0 && buf->alloc == 0)
+		return 1;
+	/* alloc must be at least one byte larger than len */
+	return check_uint(buf->len, <, buf->alloc);
+}
+
+static void t_static_init(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	check_uint(buf.len, ==, 0);
+	check_uint(buf.alloc, ==, 0);
+	check_char(buf.buf[0], ==, '\0');
+}
+
+static void t_dynamic_init(void)
+{
+	struct strbuf buf;
+
+	strbuf_init(&buf, 1024);
+	check(assert_sane_strbuf(&buf));
+	check_uint(buf.len, ==, 0);
+	check_uint(buf.alloc, >=, 1024);
+	check_char(buf.buf[0], ==, '\0');
+	strbuf_release(&buf);
+}
+
+static void t_addch(struct strbuf *buf, void *data)
+{
+	const char *p_ch = data;
+	const char ch = *p_ch;
+	size_t orig_alloc = buf->alloc;
+	size_t orig_len = buf->len;
+
+	if (!check(assert_sane_strbuf(buf)))
+		return;
+	strbuf_addch(buf, ch);
+	if (!check(assert_sane_strbuf(buf)))
+		return;
+	if (!(check_uint(buf->len, ==, orig_len + 1) &&
+	      check_uint(buf->alloc, >=, orig_alloc)))
+		return; /* avoid de-referencing buf->buf */
+	check_char(buf->buf[buf->len - 1], ==, ch);
+	check_char(buf->buf[buf->len], ==, '\0');
+}
+
+static void t_addstr(struct strbuf *buf, void *data)
+{
+	const char *text = data;
+	size_t len = strlen(text);
+	size_t orig_alloc = buf->alloc;
+	size_t orig_len = buf->len;
+
+	if (!check(assert_sane_strbuf(buf)))
+		return;
+	strbuf_addstr(buf, text);
+	if (!check(assert_sane_strbuf(buf)))
+		return;
+	if (!(check_uint(buf->len, ==, orig_len + len) &&
+	      check_uint(buf->alloc, >=, orig_alloc) &&
+	      check_uint(buf->alloc, >, orig_len + len) &&
+	      check_char(buf->buf[orig_len + len], ==, '\0')))
+	    return;
+	check_str(buf->buf + orig_len, text);
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	if (!TEST(t_static_init(), "static initialization works"))
+		test_skip_all("STRBUF_INIT is broken");
+	TEST(t_dynamic_init(), "dynamic initialization works");
+	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
+	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
+	TEST(setup_populated(t_addch, "initial value", "a"),
+	     "strbuf_addch appends to initial value");
+	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
+	TEST(setup_populated(t_addstr, "initial value", "hello there"),
+	     "strbuf_addstr appends string to initial value");
+
+	return test_done();
+}
diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
new file mode 100644
index 0000000000..a2cc21c706
--- /dev/null
+++ b/t/unit-tests/test-lib.c
@@ -0,0 +1,330 @@
+#include "test-lib.h"
+
+enum result {
+	RESULT_NONE,
+	RESULT_FAILURE,
+	RESULT_SKIP,
+	RESULT_SUCCESS,
+	RESULT_TODO
+};
+
+static struct {
+	enum result result;
+	int count;
+	unsigned failed :1;
+	unsigned lazy_plan :1;
+	unsigned running :1;
+	unsigned skip_all :1;
+	unsigned todo :1;
+} ctx = {
+	.lazy_plan = 1,
+	.result = RESULT_NONE,
+};
+
+static void msg_with_prefix(const char *prefix, const char *format, va_list ap)
+{
+	fflush(stderr);
+	if (prefix)
+		fprintf(stdout, "%s", prefix);
+	vprintf(format, ap); /* TODO: handle newlines */
+	putc('\n', stdout);
+	fflush(stdout);
+}
+
+void test_msg(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+	msg_with_prefix("# ", format, ap);
+	va_end(ap);
+}
+
+void test_plan(int count)
+{
+	assert(!ctx.running);
+
+	fflush(stderr);
+	printf("1..%d\n", count);
+	fflush(stdout);
+	ctx.lazy_plan = 0;
+}
+
+int test_done(void)
+{
+	assert(!ctx.running);
+
+	if (ctx.lazy_plan)
+		test_plan(ctx.count);
+
+	return ctx.failed;
+}
+
+void test_skip(const char *format, ...)
+{
+	va_list ap;
+
+	assert(ctx.running);
+
+	ctx.result = RESULT_SKIP;
+	va_start(ap, format);
+	if (format)
+		msg_with_prefix("# skipping test - ", format, ap);
+	va_end(ap);
+}
+
+void test_skip_all(const char *format, ...)
+{
+	va_list ap;
+	const char *prefix;
+
+	if (!ctx.count && ctx.lazy_plan) {
+		/* We have not printed a test plan yet */
+		prefix = "1..0 # SKIP ";
+		ctx.lazy_plan = 0;
+	} else {
+		/* We have already printed a test plan */
+		prefix = "Bail out! # ";
+		ctx.failed = 1;
+	}
+	ctx.skip_all = 1;
+	ctx.result = RESULT_SKIP;
+	va_start(ap, format);
+	msg_with_prefix(prefix, format, ap);
+	va_end(ap);
+}
+
+int test__run_begin(void)
+{
+	assert(!ctx.running);
+
+	ctx.count++;
+	ctx.result = RESULT_NONE;
+	ctx.running = 1;
+
+	return ctx.skip_all;
+}
+
+static void print_description(const char *format, va_list ap)
+{
+	if (format) {
+		fputs(" - ", stdout);
+		vprintf(format, ap);
+	}
+}
+
+int test__run_end(int was_run UNUSED, const char *location, const char *format, ...)
+{
+	va_list ap;
+
+	assert(ctx.running);
+	assert(!ctx.todo);
+
+	fflush(stderr);
+	va_start(ap, format);
+	if (!ctx.skip_all) {
+		switch (ctx.result) {
+		case RESULT_SUCCESS:
+			printf("ok %d", ctx.count);
+			print_description(format, ap);
+			break;
+
+		case RESULT_FAILURE:
+			printf("not ok %d", ctx.count);
+			print_description(format, ap);
+			break;
+
+		case RESULT_TODO:
+			printf("not ok %d", ctx.count);
+			print_description(format, ap);
+			printf(" # TODO");
+			break;
+
+		case RESULT_SKIP:
+			printf("ok %d", ctx.count);
+			print_description(format, ap);
+			printf(" # SKIP");
+			break;
+
+		case RESULT_NONE:
+			test_msg("BUG: test has no checks at %s", location);
+			printf("not ok %d", ctx.count);
+			print_description(format, ap);
+			ctx.result = RESULT_FAILURE;
+			break;
+		}
+	}
+	va_end(ap);
+	ctx.running = 0;
+	if (ctx.skip_all)
+		return 1;
+	putc('\n', stdout);
+	fflush(stdout);
+	ctx.failed |= ctx.result == RESULT_FAILURE;
+
+	return ctx.result != RESULT_FAILURE;
+}
+
+static void test_fail(void)
+{
+	assert(ctx.result != RESULT_SKIP);
+
+	ctx.result = RESULT_FAILURE;
+}
+
+static void test_pass(void)
+{
+	assert(ctx.result != RESULT_SKIP);
+
+	if (ctx.result == RESULT_NONE)
+		ctx.result = RESULT_SUCCESS;
+}
+
+static void test_todo(void)
+{
+	assert(ctx.result != RESULT_SKIP);
+
+	if (ctx.result != RESULT_FAILURE)
+		ctx.result = RESULT_TODO;
+}
+
+int test_assert(const char *location, const char *check, int ok)
+{
+	assert(ctx.running);
+
+	if (ctx.result == RESULT_SKIP) {
+		test_msg("skipping check '%s' at %s", check, location);
+		return 1;
+	}
+	if (!ctx.todo) {
+		if (ok) {
+			test_pass();
+		} else {
+			test_msg("check \"%s\" failed at %s", check, location);
+			test_fail();
+		}
+	}
+
+	return !!ok;
+}
+
+void test__todo_begin(void)
+{
+	assert(ctx.running);
+	assert(!ctx.todo);
+
+	ctx.todo = 1;
+}
+
+int test__todo_end(const char *location, const char *check, int res)
+{
+	assert(ctx.running);
+	assert(ctx.todo);
+
+	ctx.todo = 0;
+	if (ctx.result == RESULT_SKIP)
+		return 1;
+	if (res) {
+		test_msg("todo check '%s' succeeded at %s", check, location);
+		test_fail();
+	} else {
+		test_todo();
+	}
+
+	return !res;
+}
+
+int check_bool_loc(const char *loc, const char *check, int ok)
+{
+	return test_assert(loc, check, ok);
+}
+
+union test__tmp test__tmp[2];
+
+int check_int_loc(const char *loc, const char *check, int ok,
+		  intmax_t a, intmax_t b)
+{
+	int ret = test_assert(loc, check, ok);
+
+	if (!ret) {
+		test_msg("   left: %"PRIdMAX, a);
+		test_msg("  right: %"PRIdMAX, b);
+	}
+
+	return ret;
+}
+
+int check_uint_loc(const char *loc, const char *check, int ok,
+		   uintmax_t a, uintmax_t b)
+{
+	int ret = test_assert(loc, check, ok);
+
+	if (!ret) {
+		test_msg("   left: %"PRIuMAX, a);
+		test_msg("  right: %"PRIuMAX, b);
+	}
+
+	return ret;
+}
+
+static void print_one_char(char ch, char quote)
+{
+	if ((unsigned char)ch < 0x20u || ch == 0x7f) {
+		/* TODO: improve handling of \a, \b, \f ... */
+		printf("\\%03o", (unsigned char)ch);
+	} else {
+		if (ch == '\\' || ch == quote)
+			putc('\\', stdout);
+		putc(ch, stdout);
+	}
+}
+
+static void print_char(const char *prefix, char ch)
+{
+	printf("# %s: '", prefix);
+	print_one_char(ch, '\'');
+	fputs("'\n", stdout);
+}
+
+int check_char_loc(const char *loc, const char *check, int ok, char a, char b)
+{
+	int ret = test_assert(loc, check, ok);
+
+	if (!ret) {
+		fflush(stderr);
+		print_char("   left", a);
+		print_char("  right", b);
+		fflush(stdout);
+	}
+
+	return ret;
+}
+
+static void print_str(const char *prefix, const char *str)
+{
+	printf("# %s: ", prefix);
+	if (!str) {
+		fputs("NULL\n", stdout);
+	} else {
+		putc('"', stdout);
+		while (*str)
+			print_one_char(*str++, '"');
+		fputs("\"\n", stdout);
+	}
+}
+
+int check_str_loc(const char *loc, const char *check,
+		  const char *a, const char *b)
+{
+	int ok = (!a && !b) || (a && b && !strcmp(a, b));
+	int ret = test_assert(loc, check, ok);
+
+	if (!ret) {
+		fflush(stderr);
+		print_str("   left", a);
+		print_str("  right", b);
+		fflush(stdout);
+	}
+
+	return ret;
+}
diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
new file mode 100644
index 0000000000..a8f07ae0b7
--- /dev/null
+++ b/t/unit-tests/test-lib.h
@@ -0,0 +1,149 @@
+#ifndef TEST_LIB_H
+#define TEST_LIB_H
+
+#include "git-compat-util.h"
+
+/*
+ * Run a test function, returns 1 if the test succeeds, 0 if it
+ * fails. If test_skip_all() has been called then the test will not be
+ * run. The description for each test should be unique. For example:
+ *
+ *  TEST(test_something(arg1, arg2), "something %d %d", arg1, arg2)
+ */
+#define TEST(t, ...)					\
+	test__run_end(test__run_begin() ? 0 : (t, 1),	\
+		      TEST_LOCATION(),  __VA_ARGS__)
+
+/*
+ * Print a test plan, should be called before any tests. If the number
+ * of tests is not known in advance test_done() will automatically
+ * print a plan at the end of the test program.
+ */
+void test_plan(int count);
+
+/*
+ * test_done() must be called at the end of main(). It will print the
+ * plan if plan() was not called at the beginning of the test program
+ * and returns the exit code for the test program.
+ */
+int test_done(void);
+
+/* Skip the current test. */
+__attribute__((format (printf, 1, 2)))
+void test_skip(const char *format, ...);
+
+/* Skip all remaining tests. */
+__attribute__((format (printf, 1, 2)))
+void test_skip_all(const char *format, ...);
+
+/* Print a diagnostic message to stdout. */
+__attribute__((format (printf, 1, 2)))
+void test_msg(const char *format, ...);
+
+/*
+ * Test checks are built around test_assert(). checks return 1 on
+ * success, 0 on failure. If any check fails then the test will fail. To
+ * create a custom check define a function that wraps test_assert() and
+ * a macro to wrap that function to provide a source location and
+ * stringified arguments. Custom checks that take pointer arguments
+ * should be careful to check that they are non-NULL before
+ * dereferencing them. For example:
+ *
+ *  static int check_oid_loc(const char *loc, const char *check,
+ *			     struct object_id *a, struct object_id *b)
+ *  {
+ *	    int res = test_assert(loc, check, a && b && oideq(a, b));
+ *
+ *	    if (!res) {
+ *		    test_msg("   left: %s", a ? oid_to_hex(a) : "NULL";
+ *		    test_msg("  right: %s", b ? oid_to_hex(a) : "NULL";
+ *
+ *	    }
+ *	    return res;
+ *  }
+ *
+ *  #define check_oid(a, b) \
+ *	    check_oid_loc(TEST_LOCATION(), "oideq("#a", "#b")", a, b)
+ */
+int test_assert(const char *location, const char *check, int ok);
+
+/* Helper macro to pass the location to checks */
+#define TEST_LOCATION() TEST__MAKE_LOCATION(__LINE__)
+
+/* Check a boolean condition. */
+#define check(x)				\
+	check_bool_loc(TEST_LOCATION(), #x, x)
+int check_bool_loc(const char *loc, const char *check, int ok);
+
+/*
+ * Compare two integers. Prints a message with the two values if the
+ * comparison fails. NB this is not thread safe.
+ */
+#define check_int(a, op, b)						\
+	(test__tmp[0].i = (a), test__tmp[1].i = (b),			\
+	 check_int_loc(TEST_LOCATION(), #a" "#op" "#b,			\
+		       test__tmp[0].i op test__tmp[1].i,		\
+		       test__tmp[0].i, test__tmp[1].i))
+int check_int_loc(const char *loc, const char *check, int ok,
+		  intmax_t a, intmax_t b);
+
+/*
+ * Compare two unsigned integers. Prints a message with the two values
+ * if the comparison fails. NB this is not thread safe.
+ */
+#define check_uint(a, op, b)						\
+	(test__tmp[0].u = (a), test__tmp[1].u = (b),			\
+	 check_uint_loc(TEST_LOCATION(), #a" "#op" "#b,			\
+			test__tmp[0].u op test__tmp[1].u,		\
+			test__tmp[0].u, test__tmp[1].u))
+int check_uint_loc(const char *loc, const char *check, int ok,
+		   uintmax_t a, uintmax_t b);
+
+/*
+ * Compare two chars. Prints a message with the two values if the
+ * comparison fails. NB this is not thread safe.
+ */
+#define check_char(a, op, b)						\
+	(test__tmp[0].c = (a), test__tmp[1].c = (b),			\
+	 check_char_loc(TEST_LOCATION(), #a" "#op" "#b,			\
+			test__tmp[0].c op test__tmp[1].c,		\
+			test__tmp[0].c, test__tmp[1].c))
+int check_char_loc(const char *loc, const char *check, int ok,
+		   char a, char b);
+
+/* Check whether two strings are equal. */
+#define check_str(a, b)							\
+	check_str_loc(TEST_LOCATION(), "!strcmp("#a", "#b")", a, b)
+int check_str_loc(const char *loc, const char *check,
+		  const char *a, const char *b);
+
+/*
+ * Wrap a check that is known to fail. If the check succeeds then the
+ * test will fail. Returns 1 if the check fails, 0 if it
+ * succeeds. For example:
+ *
+ *  TEST_TODO(check(0));
+ */
+#define TEST_TODO(check) \
+	(test__todo_begin(), test__todo_end(TEST_LOCATION(), #check, check))
+
+/* Private helpers */
+
+#define TEST__STR(x) #x
+#define TEST__MAKE_LOCATION(line) __FILE__ ":" TEST__STR(line)
+
+union test__tmp {
+	intmax_t i;
+	uintmax_t u;
+	char c;
+};
+
+extern union test__tmp test__tmp[2];
+
+int test__run_begin(void);
+__attribute__((format (printf, 3, 4)))
+int test__run_end(int, const char *, const char *, ...);
+void test__todo_begin(void);
+int test__todo_end(const char *, const char *, int);
+
+#endif /* TEST_LIB_H */
-- 
2.42.0.869.gea05f2083d-goog

