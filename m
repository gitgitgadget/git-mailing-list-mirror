Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165312;
	b=N9Bbc7WaODy7ea7ugRF8qL8V/39B4/i0W9zsEfRhTfPFDRZgiSyY6RSoRJ+NE9vzXScQ
	 r0ynWX7OAjtwegNPkVudrwRA0qJT/t059TtxmePNK77BOVcqbeiPvt8insPqBHJqWiG0D
	 oCatdln+wcAi2MH2pHfT+Pjgzi20mol5xGPo/zPtuG2T+tYhQYNAEiTcV7vd3XBkSSJUC
	 VALjK1VUNRa/diN9cw1Et00rwBMOq9nhAHCzaaxLitSngmLAzgYm96Bw6jFsIvxUlqmWx
	 TTDx0cos/WIyuFDMkzqKS9rZ0Yurm8fCGRM2E3s8e871ymzl2hSrxjAq3tkZBqb49Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=5p4UxyY1jFavyqTdUIi5SJ5SQfrUKa6rxC4dOZbfTDI=;
	b=odgPGOFe0R1m46eZt3yTKHsJS64efLEX38bKXXtOvSh9UsEo8fL7uaSz1j0qcuirLsBL
	 TX1L9vfO5fARpvQEqt7AQ+eGXV6uGvvh9bryxKZxZU/DaH9S4Vu8O/M1QyGPH2ThT/+ZI
	 nu0MZG9GdYdPybr+833lS8cH60ZeEst3ChMNjniO8rzoGLmqR8vVCQX/ZuYAPZ0Euv9SQ
	 FFPfBtGxjHKjGrZjWsHA9MrRBIJVU4gZ7+Ynzni2k2LzYbtA1604FeJ9MEWa4fNDOs9cu
	 ooe6Jgp69qrzrhmuLalw/jjKlFo/vID5ODKaSWFc2+z3MrYbCMwqA1Iox9oNoeMjkAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vR7Ro46/";
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727D606A321
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 19:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A727D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vR7Ro46/
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso53990a12.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 11:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794165311; x=1794770111; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5p4UxyY1jFavyqTdUIi5SJ5SQfrUKa6rxC4dOZbfTDI=;
        b=vR7Ro46/snWb8ISmO9ah8zr8Rv1i/4EzPTcr/2aREv4C7u3RgWUejkX6W6uE1vz7Gy
         a71GQ4N9/zfj/KuXQHAAXFV2F+CXISfbeIX6Bf9mRQuFdvoPjAnL8do4Ww+Wb/HOEQr5
         2YB38SFHnt0BkyJpC7+NKyYTZSULUGDquiYCKEss4qwIqvpIS3TC625+Pebdw8SkMulB
         FSxQKyxOyzmMBPwc050+Er19yIchyND6oJv4ayDZ5aT7E+0ciPieG6M8hi6xb5/fBwVi
         /P42MKVjKMA6U30UFrcIt6B58SF6e0ytJyL6W53qRDf8ewBExTE1t7StcFN5YOmPAluQ
         iRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794165311; x=1794770111;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5p4UxyY1jFavyqTdUIi5SJ5SQfrUKa6rxC4dOZbfTDI=;
        b=ID2IGeJRuK4Y+dxErLdr5Z50r6Eb+rZMiSoVzMTs3LwZtyom9BLuBs7GlrPz/WG0qv
         9LntB5JqWuo+oFPz6zJfqESfArCKwn+Jft6PVcOikr/LxqLgqCG3vNQoXf4YQJTXY/fm
         7k3sktfehUTbyJPUtAcfjEZ5FjzrM572q1S/PEspmnyOiXuBrQOmPZzwi3EhaUnKS2Yb
         u/Ljhs6W8BXQe/w3DDg2s9QYnwUo4ksO675eD25ewfBDsl2ZO1MV/+Q2JTTTxwxqamcj
         VwS38YnIS1uyE9hF0Gp4PWTV0+0/3+NGcZ6F/D11pK709+z9dVmLRfHMGTc7iyPK0lgx
         hdJA==
X-Gm-Message-State: APuU4Z+lOimsdPYDjTzI/TBNGF2mGr3wR018z+67udPwLGmXPncmQLMH
	MnduSdD6iY9B0TnfdNwD02dYCXLSEnbH2oJeQSCQSqZaIMlS6iyCHJvudQRg6bR0
X-Gm-Gg: AYBFou2R9C9tI57KVAeeOiHYhdVwgENP7E2XfgFn7ND9yxkFJOvdyfwtITd8zhAsnnQ
	yYUfV8P9OXfjxRJX1M7F9NRqauntUUzbVi3xJpz0QgzUSsRS8Cve3IexxSwIxVmeXP3dzkYV/zs
	DLjv1yhsrEE6Ci7kV9vE6vXVudGcDoVKKspkjIUN3FziucK4YajEzlOpelVIc0UIgA3BKoA9pz1
	VL58CDY7h4AdbBSb31BJgUTsP8K/84PhfaDLGJ/ULzPTGRvx1tMEiPF73E+x/9aUPnjFMbHcuLs
	DPmT5RZ3JzmuvXSlKrzInIgjh0Yh34R+Zs6B1hfLpkIDKgafWR3gMi6C5vtzyouijBEBpXt8yua
	UleiWjPKcLt07eq4VMXsWzK4icAR/9lxnYu7+h1UI+R9m/PIj+eNnByjBir0l9s1SYHdWJrXovU
	u6ZjgakIrqNAeDiETLPxaQtfETu6LxCTutnru4fDMfmaRMmy1z+hn/j4sSzUEFHMtju8+vRLpdd
	FBVNSdq3fBfeLrZsGGWY+qoB+5TCgJsduhTjJqaCoVnAnvW4KNDShguvj72IaTlVDFQyzbsnbc2
	k6JFMKo1vix1aH0Unpr7bVNMJddKnA==
X-Received: by 2002:a17:90b:4b8f:b0:3a6:f1d2:57f8 with SMTP id 98e67ed59e1d1-3b12d0fb4a1mr1904807a91.2.1794165310638;
        Sun, 08 Nov 2026 11:15:10 -0800 (PST)
Received: from [127.0.0.1] ([4.242.60.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b12790befasm3823970a91.13.2026.11.08.11.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 11:15:09 -0800 (PST)
Message-Id: <54139a3a97127732e11fc5abbc9a3687542669f6.1794165304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2301.v2.git.1794165304.gitgitgadget@gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
	<pull.2301.v2.git.1794165304.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Nov 2026 19:15:03 +0000
Subject: [PATCH v2 1/2] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Sixt <j6t@kdbg.org>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Several tests create fixture data consisting of a single repeated
character with "test-tool genzeros <count> | tr '\000' <char>".  This
works well on platforms where tr(1) is implemented efficiently.

The implementation of tr(1) on macOS supports multi-byte characters,
and processes its input one character at a time through
getwchar() and putwchar(), even in the C locale.  For small inputs
that does not matter, but t4205 generates more than 2GB of data this
way, which makes that test much slower on macOS than on Linux: on the
macOS CI runners, tr(1) alone spends 95 to 123 seconds of CPU time on
it, compared to about 6 seconds on Linux.

Fix this by adding "test-tool genbytes <hex-byte> [<count>]", which
writes the requested byte, given as two lowercase hexadecimal
digits, directly.  Turn "genzeros" into a thin wrapper around the
same code, and rename the file to match.  Use the new helper in all
tests that piped "genzeros" through tr(1), not just t4205, so that
it is the obvious choice for new tests.

This makes t4205 much faster on macOS in CI.  The Linux jobs, shown
for comparison, only save the few seconds that GNU tr(1) took, which
is within the usual noise:

  job                before    after   change
  osx-gcc            821.1s   243.3s   -70.4%
  osx-reftable       911.0s   194.0s   -78.7%
  linux-asan-ubsan   226.7s   222.1s    -2.0%
  linux-leaks        320.2s   298.8s    -6.7%

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 Makefile                          |  2 +-
 t/helper/meson.build              |  2 +-
 t/helper/test-genbytes.c          | 61 +++++++++++++++++++++++++++++++
 t/helper/test-genzeros.c          | 37 -------------------
 t/helper/test-tool.c              |  1 +
 t/helper/test-tool.h              |  1 +
 t/t0613-reftable-write-options.sh |  2 +-
 t/t4205-log-pretty-formats.sh     |  2 +-
 t/t5300-pack-object.sh            |  6 +--
 t/t7006-pager.sh                  |  3 +-
 t/t9850-shell.sh                  |  2 +-
 11 files changed, 72 insertions(+), 47 deletions(-)
 create mode 100644 t/helper/test-genbytes.c
 delete mode 100644 t/helper/test-genzeros.c

diff --git a/Makefile b/Makefile
index c2a6098484..8d214286e0 100644
--- a/Makefile
+++ b/Makefile
@@ -825,8 +825,8 @@ TEST_BUILTINS_OBJS += test-env-helper.o
 TEST_BUILTINS_OBJS += test-example-tap.o
 TEST_BUILTINS_OBJS += test-find-pack.o
 TEST_BUILTINS_OBJS += test-fsmonitor-client.o
+TEST_BUILTINS_OBJS += test-genbytes.o
 TEST_BUILTINS_OBJS += test-genrandom.o
-TEST_BUILTINS_OBJS += test-genzeros.o
 TEST_BUILTINS_OBJS += test-getcwd.o
 TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-hash.o
diff --git a/t/helper/meson.build b/t/helper/meson.build
index ae513b4cdc..f99688c49b 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -22,8 +22,8 @@ test_tool_sources = [
   'test-example-tap.c',
   'test-find-pack.c',
   'test-fsmonitor-client.c',
+  'test-genbytes.c',
   'test-genrandom.c',
-  'test-genzeros.c',
   'test-getcwd.c',
   'test-hash-speed.c',
   'test-hash.c',
diff --git a/t/helper/test-genbytes.c b/t/helper/test-genbytes.c
new file mode 100644
index 0000000000..b760326b24
--- /dev/null
+++ b/t/helper/test-genbytes.c
@@ -0,0 +1,61 @@
+#define DISABLE_SIGN_COMPARE_WARNINGS
+
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "hex-ll.h"
+
+/*
+ * Write "count" copies of "byte" to stdout, or an endless stream of them if
+ * "count" is negative.
+ */
+static int generate_bytes(char byte, intmax_t count)
+{
+	char buf[256 * 1024];
+	ssize_t n;
+
+	memset(buf, byte, sizeof(buf));
+
+	/* Writing out individual bytes is slow... */
+	while (count < 0)
+		if (xwrite(1, buf, ARRAY_SIZE(buf)) < 0)
+			die_errno("write error");
+
+	while (count > 0) {
+		n = xwrite(1, buf,
+			   count < ARRAY_SIZE(buf)
+			   ? count : ARRAY_SIZE(buf));
+
+		if (n < 0)
+			die_errno("write error");
+
+		count -= n;
+	}
+
+	return 0;
+}
+
+static intmax_t parse_count(int argc, const char **argv, int pos)
+{
+	return pos < argc ? strtoimax(argv[pos], NULL, 0) : -1;
+}
+
+int cmd__genbytes(int argc, const char **argv)
+{
+	if (argc < 2 || argc > 3 || strlen(argv[1]) != 2 ||
+	    strspn(argv[1], "0123456789abcdef") != 2) {
+		fprintf(stderr, "usage: %s <hex-byte> [<count>]\n", argv[0]);
+		return 1;
+	}
+
+	return generate_bytes(hex2chr(argv[1]), parse_count(argc, argv, 2));
+}
+
+int cmd__genzeros(int argc, const char **argv)
+{
+	if (argc > 2) {
+		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
+		return 1;
+	}
+
+	return generate_bytes('\0', parse_count(argc, argv, 1));
+}
diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
deleted file mode 100644
index b895436a32..0000000000
--- a/t/helper/test-genzeros.c
+++ /dev/null
@@ -1,37 +0,0 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
-#include "test-tool.h"
-#include "git-compat-util.h"
-
-int cmd__genzeros(int argc, const char **argv)
-{
-	/* static, so that it is NUL-initialized */
-	static const char zeros[256 * 1024];
-	intmax_t count;
-	ssize_t n;
-
-	if (argc > 2) {
-		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
-		return 1;
-	}
-
-	count = argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
-
-	/* Writing out individual NUL bytes is slow... */
-	while (count < 0)
-		if (xwrite(1, zeros, ARRAY_SIZE(zeros)) < 0)
-			die_errno("write error");
-
-	while (count > 0) {
-		n = xwrite(1, zeros,
-			   count < ARRAY_SIZE(zeros)
-			   ? count : ARRAY_SIZE(zeros));
-
-		if (n < 0)
-			die_errno("write error");
-
-		count -= n;
-	}
-
-	return 0;
-}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b71a22b43b..af70e2bec7 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -33,6 +33,7 @@ static struct test_cmd cmds[] = {
 	{ "example-tap", cmd__example_tap },
 	{ "find-pack", cmd__find_pack },
 	{ "fsmonitor-client", cmd__fsmonitor_client },
+	{ "genbytes", cmd__genbytes },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
 	{ "getcwd", cmd__getcwd },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f2885b33d5..c35e7412af 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -26,6 +26,7 @@ int cmd__env_helper(int argc, const char **argv);
 int cmd__example_tap(int argc, const char **argv);
 int cmd__find_pack(int argc, const char **argv);
 int cmd__fsmonitor_client(int argc, const char **argv);
+int cmd__genbytes(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
 int cmd__getcwd(int argc, const char **argv);
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index 0b27d75fe3..b2032a799d 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -146,7 +146,7 @@ test_expect_success 'small block size fails with large reflog message' '
 	(
 		cd repo &&
 		test_commit A &&
-		test-tool genzeros 500 | tr "\000" "a" >logmsg &&
+		test-tool genbytes 61 500 >logmsg &&
 		cat >expect <<-EOF &&
 		fatal: update_ref failed for ref ${SQ}refs/heads/logme${SQ}: reftable: transaction failure: entry too large
 		EOF
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 01b97c8888..aa51a70a34 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1182,7 +1182,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit mes
 '
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
-	test-tool genzeros 2147483649 | tr "\000" "1" >expect &&
+	test-tool genbytes 31 2147483649 >expect &&
 	huge_commit=$(git commit-tree -F expect HEAD^{tree})
 '
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index aac139e6a0..3c2f83091c 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -9,9 +9,9 @@ test_description='git pack-object'
 
 test_expect_success 'setup' '
 	rm -f .git/index* &&
-	test-tool genzeros 4096 | tr "\000" "a" >a &&
-	test-tool genzeros 4096 | tr "\000" "b" >b &&
-	test-tool genzeros 4096 | tr "\000" "c" >c &&
+	test-tool genbytes 61 4096 >a &&
+	test-tool genbytes 62 4096 >b &&
+	test-tool genbytes 63 4096 >c &&
 	test-tool genrandom "seed a" 2097152 >a_big &&
 	test-tool genrandom "seed b" 2097152 >b_big &&
 	git update-index --add a a_big b b_big c &&
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 75ca7a25da..f59b3a00a8 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -662,8 +662,7 @@ test_expect_success 'setup trace2' '
 '
 
 test_expect_success 'setup large log output' '
-	test-tool genzeros 50000 |
-	tr "\000" "a" |
+	test-tool genbytes 61 50000 |
 	sed "s/a/this is a long commit message/g" >commit-msg &&
 	git commit --allow-empty -F commit-msg
 '
diff --git a/t/t9850-shell.sh b/t/t9850-shell.sh
index 27cc49bbd1..cf05944682 100755
--- a/t/t9850-shell.sh
+++ b/t/t9850-shell.sh
@@ -30,7 +30,7 @@ test_expect_success 'shell allows interactive command' '
 '
 
 test_expect_success 'shell complains of overlong commands' '
-	test-tool genzeros | tr "\000" "a" |
+	test-tool genbytes 61 |
 	test_must_fail git shell 2>err &&
 	test_grep "too long" err
 '
-- 
gitgitgadget

