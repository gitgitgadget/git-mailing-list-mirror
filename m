Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412755;
	b=27EBDHYHiFwepaUd5n7tlDSFANNZRR5NiiaB9FdvRy/iyfJM5BExOpZsQQfEh3fiEIQS
	 OHYWdHYRl6R7MPo2xkRv1lPFtk15kNMGyXMNNTKDD9XLu2VKnxQD+8Fhi3rwbhEXDUfQt
	 tQ9i7E9LdcKsDuaw8GJBp5tH21TN18RDKngOKB5fBVYUmfAEGZAgOF2yhSqtPzmodzXkb
	 QVZH3TnKCKzCqzDrybeIYPmVacfTVt4n4wKZRsLLXJAkA3pzQ7jxjOh/P5C3t/7rFQG6w
	 77Y4fHWedvG7KWtcU67FMAcXVo19GjsQ7T5JUNz6pfhJgsdwVZsoFq4bdpwVfigF/kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=2q7CB8GD/bpXVILKxjMnv7docN4fcUkUbtjStYNN+Mg=;
	b=G/xqHXKh3TCDuWJH1b3dPGAhz5ALKLojHRE1lkiYcTnsF4BYViP4yIOkj3NIIspDNvSR
	 qlm2NKx9ooO4kDoRFGmEfJBlU3+klkLgAWXf6ivD1ExX6QzugIMT9cfvhomK+Zhzf8CnV
	 UiTAVJirv22bDkB/uLGg7R+Gtf70G6uacyS02vMnvJgn+4CH8EaLIPAqW/zYDPqXieAIj
	 19HADYtiyDwVvDTAW12/6JqnH7orXbg10V4iuFUUuTTyRqbkHcuuj2reD82G4owKx4XI3
	 SzManS2BEPDHNUyCRlXMgJzsOJNhKf5bOQ3CvE0FwC/qKlfo6olQtP2n+mcgu1N7XZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fx8KhovD;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3C606A326
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28E3C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fx8KhovD
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53665358476so32296081cf.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794412754; x=1795017554; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2q7CB8GD/bpXVILKxjMnv7docN4fcUkUbtjStYNN+Mg=;
        b=Fx8KhovDpKsqKfpL7+Yt7QVnHjSNGXyTPXzs4BASWRKu47gcKZsYsCB6vy2f3Mw7Yl
         KSFoQ9C1VAi4RND5UJphD3azx+wPdJIkEMVp10nSt8ceg3hRfTVj19noAK86tPP9T0Fb
         0HOMXz6Tw0MKnv4dJ8MTKaxoWXrjfktgbtJ6RFmi53FAHDN+SecxyH+1q3wAnBdmSxxs
         SqXzi0Se1ozycBWUT2ijOUQVBSjTkQ+Y6OXnt4Dni4zgV64Gnt39/VXdeIlmfNvfwtmo
         IGEBg71LDIvYixmmFLZglGZDY78+JicWNGQZN2TLfMuJ02Z/iHYOSNH8XKYgKJU6BHjR
         AGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412754; x=1795017554;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2q7CB8GD/bpXVILKxjMnv7docN4fcUkUbtjStYNN+Mg=;
        b=yyZJDzjd0kR7tz2inp0t7x7fuZlsqObAyHcHMA3L4PjphQiOlwCYiqCiM3dMC/Ftga
         7vDiAkU4toSqPRMHwCYldYO26tLVNC7Kkm9TILg2H2SWOi8BAmPm25rIBRWYaAFTi49W
         WWV6jNw0l+S+5DkBFa5Levas8x6KuJOGuXxoA3cA1dGWfDSqppRZofi1jdaCwypOVBCk
         xPcvD1mkRakQndxz40OxUEl+FA/bkvLJzH+Uu7mH+LlgsZpLxk0lSmnVovulzUJMvJcq
         AsQGBBlsQ1IRfJK6pBTy74xqCiZTcvm3BTibn3ykL2M1uit0tbZtrSCbNQnTf8hnrIyg
         gM/g==
X-Gm-Message-State: APuU4Z9iYfvKD45ulimnwU0GoCq62q9FNT09Owf3IrScgn+NkUyLGpr3
	eFLtW4yccyxf7RG320rdOwb/Tn//IrfNpLodZTag/Rfgj0BSe01c8hSML3NhrNvf
X-Gm-Gg: AYBFou20Lmr3fuNBD2ot3OHAmwF4BxXT0oalgF2D9XW9Fcq5sqp04h5LNO0tNuPPx5m
	gHSFMwEHqtyJ+Itwdh6cOd1e5C46AQclN4B47+sHOLpDJklOe2xRZnEMNX+QHhUC0E0+sIrc+FX
	HyHiKH8V/IKvKFz2EMXO1DCxlVUtV4Ot+bDYF2rJ/36tic/IQCLwB39ByT3zgOZenFyhZPtRUF8
	16uYKIy0eUKMnStqe0202QTLOS/YDHGcYY+r6EvOAH9XZ6JEQgueOhmbWxJ27CGRlZ8+wvHtqhP
	8Ord+Gt5eMDC9vOkGQlR2oqN0FFmfm7NOpfMu+g6j3Eb66Q7SDZ0G49bUkaLQGrHkIc684Ofo9N
	+qYOiVivjBgMrZUFD8KcjRYquQYFWQsi9aI6efdn7SA8Mh6D0YWXm7CEC9julCHM15vv87T4lko
	x7q+cNbWeiD6xCiP7FNUVMFOJHlaq+MLxQBrYSByUbJ6E3iyGIo/73ZcWudkgusIo79qpxVBlXt
	KWmIqXAkwFoUu1HZ3IoGXLClDl6oZeRqouN3fnsd0dOpLhEjEW8RNalDKPbtO9Ny91HPpsDSfV9
	9ihZYF2SZ1yZeABhPCQVb/yMT4UGMpSlaks=
X-Received: by 2002:a05:622a:4b06:b0:536:b7a:2ce8 with SMTP id d75a77b69052e-556c0ac2483mr40064111cf.51.1794412753774;
        Wed, 11 Nov 2026 07:59:13 -0800 (PST)
Received: from [127.0.0.1] ([172.176.144.161])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af6096asm53687361cf.5.2026.11.11.07.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:59:12 -0800 (PST)
Message-Id: <pull.2301.v4.git.1794412751763.gitgitgadget@gmail.com>
In-Reply-To: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 15:59:11 +0000
Subject: [PATCH v4] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
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
    Collin Funk <collin.funk1@gmail.com>,
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

Fix this by adding "test-tool genbytes <char> [<count>]" next to
"genzeros", sharing the same code, which writes the requested
character directly.  Use it in all tests that piped "genzeros"
through tr(1), not just t4205, so that it is the obvious choice for
new tests.  Callers that want NUL bytes keep using "genzeros".

While at it, parse the count with git_parse_signed(), so that an
invalid count is reported as a usage error instead of being silently
treated as 0.

This makes t4205 much faster on macOS in CI.  The Linux jobs, shown
for comparison, show smaller differences, which may partly be due to
normal run-to-run variation:

  job                before    after   change
  osx-gcc            821.1s   243.3s   -70.4%
  osx-reftable       911.0s   194.0s   -78.7%
  linux-asan-ubsan   226.7s   222.1s    -2.0%
  linux-leaks        320.2s   298.8s    -6.7%

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    t: add "test-tool genbytes" to avoid slow tr(1) on macOS
    
    While looking for slow tests in CI, t4205 stood out on macOS: its
    EXPENSIVE tests take several times longer there than on Linux. A CI
    experiment showed that much of the time was spent in tr(1), which is
    very slow on macOS for the 2GB of data that t4205 generates.
    
    This adds "test-tool genbytes []" and uses it instead of "genzeros |
    tr", which is where the speedup comes from.
    
    Changes since v3:
    
     * Rebased on latest master to also convert a new large "genzeros | tr"
       use in t1600.
    
    Changes since v2:
    
     * "genbytes" takes a literal character again ("genbytes a") instead of
       two hex digits ("genbytes 61"), which Patrick found hard to read at
       the call sites.
    
     * "genzeros" and its callers that want NUL bytes are kept as they are,
       and the patch that converted them to "genbytes 00" is dropped. This
       avoids churn in tests that do not need to change, as discussed with
       Johannes. Keeping "genzeros" also means that "genbytes" does not need
       special handling for NUL bytes.
    
     * test-genzeros.c is no longer renamed, and "genbytes" lives next to
       "genzeros" in the same file. Since "genzeros" stays, the current file
       name is still valid and not worth churning.
    
     * The buffer is static again instead of 256 KiB on the stack, as
       suggested by Junio, to avoid using a large part of the limited stack
       space. There is no risk of concurrent use in a run-once helper.
    
     * The count is parsed with git_parse_signed(), so that an invalid count
       is a usage error instead of being silently treated as 0, as suggested
       by Patrick. This applies to "genzeros" as well.
    
    Changes in v2 (subsequently reverted in v3):
    
     * Squashed the rename of test-genzeros.c into the patch that changes
       it, as suggested by Junio.
    
     * "genbytes" took the byte as two lowercase hexadecimal digits instead
       of a literal character, as suggested by Junio. This also worked for
       NUL bytes, so "genbytes 00" replaced special-casing "NUL".

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2301%2Fspkrka%2Ftest-tool-genbytes-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2301/spkrka/test-tool-genbytes-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2301

Range-diff vs v3:

 1:  17e5baacdb ! 1:  c94a8e0ca7 t: add "test-tool genbytes" to avoid slow tr(1) on macOS
     @@ t/t0613-reftable-write-options.sh: test_expect_success 'small block size fails w
       		fatal: update_ref failed for ref ${SQ}refs/heads/logme${SQ}: reftable: transaction failure: entry too large
       		EOF
      
     + ## t/t1600-index.sh ##
     +@@ t/t1600-index.sh: test_expect_success 'index.maxPathLen rejects out-of-range values' '
     + make_large_tree () {
     + 	{
     + 		printf "100644 " &&
     +-		test-tool genzeros "$1" | tr "\000" a &&
     ++		test-tool genbytes a "$1" &&
     + 		printf "\0" &&
     + 		test-tool genzeros "$(test_oid rawsz)"
     + 	} >"tree-$1" &&
     +
       ## t/t4205-log-pretty-formats.sh ##
      @@ t/t4205-log-pretty-formats.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit mes
       '


 t/helper/test-genzeros.c          | 54 ++++++++++++++++++++++---------
 t/helper/test-tool.c              |  1 +
 t/helper/test-tool.h              |  1 +
 t/t0613-reftable-write-options.sh |  2 +-
 t/t1600-index.sh                  |  2 +-
 t/t4205-log-pretty-formats.sh     |  2 +-
 t/t5300-pack-object.sh            |  6 ++--
 t/t7006-pager.sh                  |  3 +-
 t/t9850-shell.sh                  |  2 +-
 9 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
index b895436a32..e8d83d5012 100644
--- a/t/helper/test-genzeros.c
+++ b/t/helper/test-genzeros.c
@@ -2,30 +2,28 @@
 
 #include "test-tool.h"
 #include "git-compat-util.h"
+#include "parse.h"
 
-int cmd__genzeros(int argc, const char **argv)
+/*
+ * Write "count" copies of "byte" to stdout, or an endless stream of them if
+ * "count" is negative.
+ */
+static int generate_bytes(unsigned char byte, intmax_t count)
 {
-	/* static, so that it is NUL-initialized */
-	static const char zeros[256 * 1024];
-	intmax_t count;
+	static char buf[256 * 1024];
 	ssize_t n;
 
-	if (argc > 2) {
-		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
-		return 1;
-	}
-
-	count = argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
+	memset(buf, byte, sizeof(buf));
 
-	/* Writing out individual NUL bytes is slow... */
+	/* Writing out individual bytes is slow... */
 	while (count < 0)
-		if (xwrite(1, zeros, ARRAY_SIZE(zeros)) < 0)
+		if (xwrite(1, buf, ARRAY_SIZE(buf)) < 0)
 			die_errno("write error");
 
 	while (count > 0) {
-		n = xwrite(1, zeros,
-			   count < ARRAY_SIZE(zeros)
-			   ? count : ARRAY_SIZE(zeros));
+		n = xwrite(1, buf,
+			   count < ARRAY_SIZE(buf)
+			   ? count : ARRAY_SIZE(buf));
 
 		if (n < 0)
 			die_errno("write error");
@@ -35,3 +33,29 @@ int cmd__genzeros(int argc, const char **argv)
 
 	return 0;
 }
+
+int cmd__genbytes(int argc, const char **argv)
+{
+	intmax_t count = -1;
+
+	if (argc < 2 || argc > 3 || strlen(argv[1]) != 1 ||
+	    (argc == 3 && !git_parse_signed(argv[2], &count, INTMAX_MAX))) {
+		fprintf(stderr, "usage: %s <char> [<count>]\n", argv[0]);
+		return 1;
+	}
+
+	return generate_bytes(argv[1][0], count);
+}
+
+int cmd__genzeros(int argc, const char **argv)
+{
+	intmax_t count = -1;
+
+	if (argc > 2 ||
+	    (argc == 2 && !git_parse_signed(argv[1], &count, INTMAX_MAX))) {
+		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
+		return 1;
+	}
+
+	return generate_bytes('\0', count);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 83e5fee730..768d1c7e35 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -35,6 +35,7 @@ static struct test_cmd cmds[] = {
 	{ "example-tap", cmd__example_tap },
 	{ "find-pack", cmd__find_pack },
 	{ "fsmonitor-client", cmd__fsmonitor_client },
+	{ "genbytes", cmd__genbytes },
 	{ "genrandom", cmd__genrandom },
 	{ "genzeros", cmd__genzeros },
 	{ "getcwd", cmd__getcwd },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index b020e24fc4..8dc54150ef 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -28,6 +28,7 @@ int cmd__env_helper(int argc, const char **argv);
 int cmd__example_tap(int argc, const char **argv);
 int cmd__find_pack(int argc, const char **argv);
 int cmd__fsmonitor_client(int argc, const char **argv);
+int cmd__genbytes(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
 int cmd__genzeros(int argc, const char **argv);
 int cmd__getcwd(int argc, const char **argv);
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index 0b27d75fe3..0b74ff6157 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -146,7 +146,7 @@ test_expect_success 'small block size fails with large reflog message' '
 	(
 		cd repo &&
 		test_commit A &&
-		test-tool genzeros 500 | tr "\000" "a" >logmsg &&
+		test-tool genbytes a 500 >logmsg &&
 		cat >expect <<-EOF &&
 		fatal: update_ref failed for ref ${SQ}refs/heads/logme${SQ}: reftable: transaction failure: entry too large
 		EOF
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 9c51cc04e1..dc4d68c1fb 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -161,7 +161,7 @@ test_expect_success 'index.maxPathLen rejects out-of-range values' '
 make_large_tree () {
 	{
 		printf "100644 " &&
-		test-tool genzeros "$1" | tr "\000" a &&
+		test-tool genbytes a "$1" &&
 		printf "\0" &&
 		test-tool genzeros "$(test_oid rawsz)"
 	} >"tree-$1" &&
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 01b97c8888..894d88c39b 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1182,7 +1182,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit mes
 '
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
-	test-tool genzeros 2147483649 | tr "\000" "1" >expect &&
+	test-tool genbytes 1 2147483649 >expect &&
 	huge_commit=$(git commit-tree -F expect HEAD^{tree})
 '
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index e5ce478484..4fb6a22145 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -9,9 +9,9 @@ test_description='git pack-object'
 
 test_expect_success 'setup' '
 	rm -f .git/index* &&
-	test-tool genzeros 4096 | tr "\000" "a" >a &&
-	test-tool genzeros 4096 | tr "\000" "b" >b &&
-	test-tool genzeros 4096 | tr "\000" "c" >c &&
+	test-tool genbytes a 4096 >a &&
+	test-tool genbytes b 4096 >b &&
+	test-tool genbytes c 4096 >c &&
 	test-tool genrandom "seed a" 2097152 >a_big &&
 	test-tool genrandom "seed b" 2097152 >b_big &&
 	git update-index --add a a_big b b_big c &&
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 75ca7a25da..8f1f71bf12 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -662,8 +662,7 @@ test_expect_success 'setup trace2' '
 '
 
 test_expect_success 'setup large log output' '
-	test-tool genzeros 50000 |
-	tr "\000" "a" |
+	test-tool genbytes a 50000 |
 	sed "s/a/this is a long commit message/g" >commit-msg &&
 	git commit --allow-empty -F commit-msg
 '
diff --git a/t/t9850-shell.sh b/t/t9850-shell.sh
index 27cc49bbd1..d56edebda7 100755
--- a/t/t9850-shell.sh
+++ b/t/t9850-shell.sh
@@ -30,7 +30,7 @@ test_expect_success 'shell allows interactive command' '
 '
 
 test_expect_success 'shell complains of overlong commands' '
-	test-tool genzeros | tr "\000" "a" |
+	test-tool genbytes a |
 	test_must_fail git shell 2>err &&
 	test_grep "too long" err
 '

base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
-- 
gitgitgadget
