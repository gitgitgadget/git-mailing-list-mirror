Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165309;
	b=40VrGJ/r6qcXTwRYWTazJSzedpA5n/8Y8wQMAAQmPz8yhhkbHiXs9570YRDcB01oiZNB
	 RKHTbIu3j6z6VqdidchpLr2BVvMyeAG/g2nBw0GpDECPlchmZrfM+s3VEknZnOWBAciai
	 ah4VsLSpshabAlrJX2KKZsZOeBjjWrs3s/4PtS3Gu5PDh3l5q6XqLcWYrwQWQpdvsszl5
	 pJHVriSk25J+lOsrUelfV+dNuW9e5LT86uuNk2jSpnfIO+tMNcqnXmjrneIT1WcSPzHlS
	 WyTgPberAPRii2voe9T7oyc+7Ld9JBJGNPgX+pkAcRcMnMqgl1IjbINtNE5fwFBDXJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=l5GxtAEOdPNXgz2BgGtqIfsyF3nTJ+unQeejnQDlvZ0=;
	b=dWOamC+MUxbC1xNxL3KYBWj0UhEYWRtqLrNDIfEjsUd4IzfTd8VndPaMpc2vn7K3A2P7
	 YszltN+/EO96Ky2oJFTcpZf0DFRyoh5iLAAKpQlWyFemjlOBJqAtjHHbGZNeXDcGUo7KF
	 4WqSWX8umUrX3KsNf+iZLffSnR/vNxZ8QvAaY23f5A0eYgY9/tr+Fd0p5Db9AXr8DaxAy
	 rdDXSUb6egnEFr/b/B43j/I4TNBbS09Z1sevwoIbYRfalnV/y0iaReLm9zubyWGN2d1ww
	 M0/RdXst0wlYW9ZeTVOJKKFnSfRMbOHpCTysO+FSN769rQ2SkkQ9xbbjY7izn16vAcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ReLS48Fw;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3410606A322
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 19:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3410606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ReLS48Fw
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso96098a91.3
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 11:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794165308; x=1794770108; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l5GxtAEOdPNXgz2BgGtqIfsyF3nTJ+unQeejnQDlvZ0=;
        b=ReLS48Fw8tIMp3ZBkeSkuvNY1yDR0lAKIENiLq5M0feToijwXZE/bhbOFm5vuGU71E
         pEonq6MepSHhWGbw7xgoZ9Ehqmc8+epnH9PoWOle+2mts3oZPgCnnBt2W/uSdN8YaEWf
         mO2Vyewb2hfbYiay8baEC5bLR3lhEKmYChv1E08b5ar2xDCh4BQuwBbj44xpD9z61p6H
         Y2jBG9AlvJK3GW4fsBd61xWhSFZSpVS+OxJ44O8PmLJYxIllH6QJNeztMv7n2VBOyssq
         UBeYVHo3/Er6MaOReBXDtmzx52OdAGbfYbQfbWRF9cqJzqO5H78HQlu8T//6BEw68f85
         tS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794165308; x=1794770108;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5GxtAEOdPNXgz2BgGtqIfsyF3nTJ+unQeejnQDlvZ0=;
        b=g0ZEYN19rM3kC3cMghNu78+O15hCrrjeL++iJmmXRAhtdhLJkN54AVrECGM4Tsq4dQ
         MO87mJ73QVJYh/RDYq7Umonrd/by2pBs69ZnVaHamBgRmaZZYyeUWlC+g60ou0mbHPsd
         bleQhW9UVY3/DmpBlAuqKHtkc4E8RigKMDkhaE910R6BIN4ewAmhWfhwhzus+6WQ8sIc
         UjbO3wBAcsyE47zGmYWbzMYXMwB4MqQ4bcnktG8ENNTDjVlSFwFgUC+m9edhXmqJyBc6
         aNYYFI8X7PZ8f0zqeTZbcA4vd2ezkItGw+q8155p4mgDVhALavaMm7FArqKahmsvtiQE
         R5Qw==
X-Gm-Message-State: APuU4Z/YTZ2+MmbEtVBIy+HUkLp0xN527AZ/rH3Q+ZntNUjNz67tRo41
	fNj8lpatbe9vnUKlEk68jpPByLS/PVi6Qpqf3Enlbt4H8An8umV1iGauhKAv3Nd0
X-Gm-Gg: AYBFou2c+6skie5fhiag1XasPA+48aGosHZlqHsTz8rrIE9l7Yt4wdsiAmmipDeoJDU
	iHaDa/8CSab4Sc5z3uWPIUG3XLXh84dthnMf6b+iQPjFr/xo9EjX4byhWsEO85y6aGM5Md41iky
	ovVe3q4EbCxxUfqAr7gtd+ii+AW8h6LsKPDEOtv5RCKhJ7o7lZZgT/1oFN8UhY3HPFM1SWbBoV1
	AQoHvdk2AM+nbJRRdo+AOSrDYMkJ9tcv7qsygfrr5YtrubqJmNdfKIni2RLPYoOWS4X6X5NKk6l
	5ZoD8zdy0q/aHAlYzJ7DW8K5Ys+Mc2TnG5oqoYsy9BADprXWqTddF05fadOtv/jM62cz2KnSU0t
	bUBahTinPjya+AG5SB+T/Z8AlpW/VNYcazGYOOnBkAcHEBLTknh3K4ULCscs7THhtHnKebUuMrD
	ZU7Sv9QW+eHvCbatf/MH+Tv81qVU7fHxj8cynnQLj3uISjkf0FPa0yXrwvX53uLnfseMaKMc0Q8
	c2u0Y4UW5VqF5IgnT7DhgCt5J+vJYjIUcKu3lWmhuG28XxOmLBIG59SnVqNAEYq9MA+0dOzIzWk
	MgYP7zvmvb/TzYU6hQRkxH88aVTXnQ==
X-Received: by 2002:a17:90b:540f:b0:3ad:370f:46be with SMTP id 98e67ed59e1d1-3b12d500496mr1763611a91.36.1794165308132;
        Sun, 08 Nov 2026 11:15:08 -0800 (PST)
Received: from [127.0.0.1] ([4.242.60.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm7694043a91.0.2026.11.08.11.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 11:15:06 -0800 (PST)
Message-Id: <pull.2301.v2.git.1794165304.gitgitgadget@gmail.com>
In-Reply-To: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 08 Nov 2026 19:15:02 +0000
Subject: [PATCH v2 0/2] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
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
    Kristofer Karlsson <krka@spotify.com>

While looking for slow tests in CI, t4205 stood out on macOS: its EXPENSIVE
tests take several times longer there than on Linux. A CI experiment showed
that much of the time was spent in tr(1), which is very slow on macOS for
the 2GB of data that t4205 generates.

Patch 1 adds "test-tool genbytes" and uses it instead of "genzeros | tr",
which is where the speedup comes from. Patch 2 converts the remaining
"genzeros" callers and removes it.

Changes since v1:

 * Squashed the rename of test-genzeros.c into the patch that changes it, as
   suggested by Junio. The file changes enough that the default rename
   detection shows it as deleted and newly created; "git format-patch -M30%"
   shows it as a rename.

 * "genbytes" now takes the byte as two lowercase hexadecimal digits instead
   of a literal character, as suggested by Junio. This also works for NUL
   bytes, so patch 2 now uses "genbytes 00" instead of special-casing "NUL".

Kristofer Karlsson (2):
  t: add "test-tool genbytes" to avoid slow tr(1) on macOS
  t: replace "test-tool genzeros" with "genbytes 00"

 Makefile                          |  2 +-
 t/helper/meson.build              |  2 +-
 t/helper/test-genbytes.c          | 51 +++++++++++++++++++++++++++++++
 t/helper/test-genzeros.c          | 37 ----------------------
 t/helper/test-tool.c              |  2 +-
 t/helper/test-tool.h              |  2 +-
 t/t0613-reftable-write-options.sh |  2 +-
 t/t1007-hash-object.sh            |  8 ++---
 t/t1051-large-conversion.sh       |  4 +--
 t/t1450-fsck.sh                   |  4 +--
 t/t4141-apply-too-large.sh        |  2 +-
 t/t4205-log-pretty-formats.sh     |  2 +-
 t/t5300-pack-object.sh            |  6 ++--
 t/t5318-commit-graph.sh           |  2 +-
 t/t7006-pager.sh                  |  3 +-
 t/t9850-shell.sh                  |  2 +-
 16 files changed, 72 insertions(+), 59 deletions(-)
 create mode 100644 t/helper/test-genbytes.c
 delete mode 100644 t/helper/test-genzeros.c


base-commit: fb255012acbcbe81189cb8014da0280b09c66ecc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2301%2Fspkrka%2Ftest-tool-genbytes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2301/spkrka/test-tool-genbytes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2301

Range-diff vs v1:

 1:  b4378b3527 < -:  ---------- t/helper: rename test-genzeros.c to test-genbytes.c
 2:  4c02ada9b8 ! 1:  54139a3a97 t: add "test-tool genbytes" to avoid slow tr(1) on macOS
     @@ Commit message
          macOS CI runners, tr(1) alone spends 95 to 123 seconds of CPU time on
          it, compared to about 6 seconds on Linux.
      
     -    Fix this by adding "test-tool genbytes <byte> [<count>]", which writes
     -    the requested byte directly, and turn "genzeros" into a thin
     -    wrapper around the same code.  Use the new helper in all tests that
     -    piped "genzeros" through tr(1), not just t4205, so that it is the
     -    obvious choice for new tests.
     +    Fix this by adding "test-tool genbytes <hex-byte> [<count>]", which
     +    writes the requested byte, given as two lowercase hexadecimal
     +    digits, directly.  Turn "genzeros" into a thin wrapper around the
     +    same code, and rename the file to match.  Use the new helper in all
     +    tests that piped "genzeros" through tr(1), not just t4205, so that
     +    it is the obvious choice for new tests.
      
          This makes t4205 much faster on macOS in CI.  The Linux jobs, shown
          for comparison, only save the few seconds that GNU tr(1) took, which
     @@ Commit message
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     - ## t/helper/test-genbytes.c ##
     + ## Makefile ##
     +@@ Makefile: TEST_BUILTINS_OBJS += test-env-helper.o
     + TEST_BUILTINS_OBJS += test-example-tap.o
     + TEST_BUILTINS_OBJS += test-find-pack.o
     + TEST_BUILTINS_OBJS += test-fsmonitor-client.o
     ++TEST_BUILTINS_OBJS += test-genbytes.o
     + TEST_BUILTINS_OBJS += test-genrandom.o
     +-TEST_BUILTINS_OBJS += test-genzeros.o
     + TEST_BUILTINS_OBJS += test-getcwd.o
     + TEST_BUILTINS_OBJS += test-hash-speed.o
     + TEST_BUILTINS_OBJS += test-hash.o
     +
     + ## t/helper/meson.build ##
     +@@ t/helper/meson.build: test_tool_sources = [
     +   'test-example-tap.c',
     +   'test-find-pack.c',
     +   'test-fsmonitor-client.c',
     ++  'test-genbytes.c',
     +   'test-genrandom.c',
     +-  'test-genzeros.c',
     +   'test-getcwd.c',
     +   'test-hash-speed.c',
     +   'test-hash.c',
     +
     + ## t/helper/test-genbytes.c (new) ##
      @@
     - #include "test-tool.h"
     - #include "git-compat-util.h"
     - 
     --int cmd__genzeros(int argc, const char **argv)
     ++#define DISABLE_SIGN_COMPARE_WARNINGS
     ++
     ++#include "test-tool.h"
     ++#include "git-compat-util.h"
     ++#include "hex-ll.h"
     ++
      +/*
      + * Write "count" copies of "byte" to stdout, or an endless stream of them if
      + * "count" is negative.
      + */
      +static int generate_bytes(char byte, intmax_t count)
     - {
     --	/* static, so that it is NUL-initialized */
     --	static const char zeros[256 * 1024];
     --	intmax_t count;
     ++{
      +	char buf[256 * 1024];
     - 	ssize_t n;
     - 
     --	if (argc > 2) {
     --		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
     --		return 1;
     --	}
     --
     --	count = argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
     ++	ssize_t n;
     ++
      +	memset(buf, byte, sizeof(buf));
     - 
     --	/* Writing out individual NUL bytes is slow... */
     ++
      +	/* Writing out individual bytes is slow... */
     - 	while (count < 0)
     --		if (xwrite(1, zeros, ARRAY_SIZE(zeros)) < 0)
     ++	while (count < 0)
      +		if (xwrite(1, buf, ARRAY_SIZE(buf)) < 0)
     - 			die_errno("write error");
     - 
     - 	while (count > 0) {
     --		n = xwrite(1, zeros,
     --			   count < ARRAY_SIZE(zeros)
     --			   ? count : ARRAY_SIZE(zeros));
     ++			die_errno("write error");
     ++
     ++	while (count > 0) {
      +		n = xwrite(1, buf,
      +			   count < ARRAY_SIZE(buf)
      +			   ? count : ARRAY_SIZE(buf));
     - 
     - 		if (n < 0)
     - 			die_errno("write error");
     -@@ t/helper/test-genbytes.c: int cmd__genzeros(int argc, const char **argv)
     - 
     - 	return 0;
     - }
     ++
     ++		if (n < 0)
     ++			die_errno("write error");
     ++
     ++		count -= n;
     ++	}
     ++
     ++	return 0;
     ++}
      +
      +static intmax_t parse_count(int argc, const char **argv, int pos)
      +{
     @@ t/helper/test-genbytes.c: int cmd__genzeros(int argc, const char **argv)
      +
      +int cmd__genbytes(int argc, const char **argv)
      +{
     -+	if (argc < 2 || argc > 3 || strlen(argv[1]) != 1) {
     -+		fprintf(stderr, "usage: %s <byte> [<count>]\n", argv[0]);
     ++	if (argc < 2 || argc > 3 || strlen(argv[1]) != 2 ||
     ++	    strspn(argv[1], "0123456789abcdef") != 2) {
     ++		fprintf(stderr, "usage: %s <hex-byte> [<count>]\n", argv[0]);
      +		return 1;
      +	}
      +
     -+	return generate_bytes(argv[1][0], parse_count(argc, argv, 2));
     ++	return generate_bytes(hex2chr(argv[1]), parse_count(argc, argv, 2));
      +}
      +
      +int cmd__genzeros(int argc, const char **argv)
     @@ t/helper/test-genbytes.c: int cmd__genzeros(int argc, const char **argv)
      +	return generate_bytes('\0', parse_count(argc, argv, 1));
      +}
      
     + ## t/helper/test-genzeros.c (deleted) ##
     +@@
     +-#define DISABLE_SIGN_COMPARE_WARNINGS
     +-
     +-#include "test-tool.h"
     +-#include "git-compat-util.h"
     +-
     +-int cmd__genzeros(int argc, const char **argv)
     +-{
     +-	/* static, so that it is NUL-initialized */
     +-	static const char zeros[256 * 1024];
     +-	intmax_t count;
     +-	ssize_t n;
     +-
     +-	if (argc > 2) {
     +-		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
     +-		return 1;
     +-	}
     +-
     +-	count = argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
     +-
     +-	/* Writing out individual NUL bytes is slow... */
     +-	while (count < 0)
     +-		if (xwrite(1, zeros, ARRAY_SIZE(zeros)) < 0)
     +-			die_errno("write error");
     +-
     +-	while (count > 0) {
     +-		n = xwrite(1, zeros,
     +-			   count < ARRAY_SIZE(zeros)
     +-			   ? count : ARRAY_SIZE(zeros));
     +-
     +-		if (n < 0)
     +-			die_errno("write error");
     +-
     +-		count -= n;
     +-	}
     +-
     +-	return 0;
     +-}
     +
       ## t/helper/test-tool.c ##
      @@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
       	{ "example-tap", cmd__example_tap },
     @@ t/t0613-reftable-write-options.sh: test_expect_success 'small block size fails w
       		cd repo &&
       		test_commit A &&
      -		test-tool genzeros 500 | tr "\000" "a" >logmsg &&
     -+		test-tool genbytes a 500 >logmsg &&
     ++		test-tool genbytes 61 500 >logmsg &&
       		cat >expect <<-EOF &&
       		fatal: update_ref failed for ref ${SQ}refs/heads/logme${SQ}: reftable: transaction failure: entry too large
       		EOF
     @@ t/t4205-log-pretty-formats.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'lo
       
       test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
      -	test-tool genzeros 2147483649 | tr "\000" "1" >expect &&
     -+	test-tool genbytes 1 2147483649 >expect &&
     ++	test-tool genbytes 31 2147483649 >expect &&
       	huge_commit=$(git commit-tree -F expect HEAD^{tree})
       '
       
     @@ t/t5300-pack-object.sh: test_description='git pack-object'
      -	test-tool genzeros 4096 | tr "\000" "a" >a &&
      -	test-tool genzeros 4096 | tr "\000" "b" >b &&
      -	test-tool genzeros 4096 | tr "\000" "c" >c &&
     -+	test-tool genbytes a 4096 >a &&
     -+	test-tool genbytes b 4096 >b &&
     -+	test-tool genbytes c 4096 >c &&
     ++	test-tool genbytes 61 4096 >a &&
     ++	test-tool genbytes 62 4096 >b &&
     ++	test-tool genbytes 63 4096 >c &&
       	test-tool genrandom "seed a" 2097152 >a_big &&
       	test-tool genrandom "seed b" 2097152 >b_big &&
       	git update-index --add a a_big b b_big c &&
     @@ t/t7006-pager.sh: test_expect_success 'setup trace2' '
       test_expect_success 'setup large log output' '
      -	test-tool genzeros 50000 |
      -	tr "\000" "a" |
     -+	test-tool genbytes a 50000 |
     ++	test-tool genbytes 61 50000 |
       	sed "s/a/this is a long commit message/g" >commit-msg &&
       	git commit --allow-empty -F commit-msg
       '
     @@ t/t9850-shell.sh: test_expect_success 'shell allows interactive command' '
       
       test_expect_success 'shell complains of overlong commands' '
      -	test-tool genzeros | tr "\000" "a" |
     -+	test-tool genbytes a |
     ++	test-tool genbytes 61 |
       	test_must_fail git shell 2>err &&
       	test_grep "too long" err
       '
 3:  169ca5968e ! 2:  f49af0e33f t: replace "test-tool genzeros" with "genbytes NUL"
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    t: replace "test-tool genzeros" with "genbytes NUL"
     +    t: replace "test-tool genzeros" with "genbytes 00"
      
     -    Now that "genbytes" exists, "genzeros" is merely a special case of it
     -    for NUL bytes.  It is only kept as a separate command because a NUL
     -    byte cannot be passed as a command-line argument.
     -
     -    Teach "genbytes" to accept "NUL" as the name of that byte instead,
     -    convert the remaining callers of "genzeros", and remove it, so that
     -    there is a single command for generating repeated bytes.
     +    Now that "genbytes" exists, "genzeros" is merely the special case of
     +    it that writes NUL bytes.  Convert its remaining callers to
     +    "genbytes 00" and remove it, so that there is a single command for
     +    generating repeated bytes.
      
          Only some of these callers depend on the data being NUL bytes, like
          t1007, which compares against the object ID of 5GB of zeros, and
     @@ Commit message
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## t/helper/test-genbytes.c ##
     -@@ t/helper/test-genbytes.c: static int generate_bytes(char byte, intmax_t count)
     - 	return 0;
     - }
     +@@ t/helper/test-genbytes.c: int cmd__genbytes(int argc, const char **argv)
       
     -+/*
     -+ * A NUL byte cannot be passed as an argument, so it is spelled out as
     -+ * "NUL".  Returns -1 for anything that is not a single byte.
     -+ */
     -+static int parse_byte(const char *arg)
     -+{
     -+	if (!strcmp(arg, "NUL"))
     -+		return '\0';
     -+	if (strlen(arg) == 1)
     -+		return (unsigned char)arg[0];
     -+	return -1;
     -+}
     -+
     - static intmax_t parse_count(int argc, const char **argv, int pos)
     - {
     - 	return pos < argc ? strtoimax(argv[pos], NULL, 0) : -1;
     -@@ t/helper/test-genbytes.c: static intmax_t parse_count(int argc, const char **argv, int pos)
     - 
     - int cmd__genbytes(int argc, const char **argv)
     - {
     --	if (argc < 2 || argc > 3 || strlen(argv[1]) != 1) {
     --		fprintf(stderr, "usage: %s <byte> [<count>]\n", argv[0]);
     --		return 1;
     --	}
     -+	int byte;
     - 
     --	return generate_bytes(argv[1][0], parse_count(argc, argv, 2));
     --}
     + 	return generate_bytes(hex2chr(argv[1]), parse_count(argc, argv, 2));
     + }
      -
      -int cmd__genzeros(int argc, const char **argv)
      -{
      -	if (argc > 2) {
      -		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
     -+	if (argc < 2 || argc > 3 || (byte = parse_byte(argv[1])) < 0) {
     -+		fprintf(stderr, "usage: %s (<byte> | NUL) [<count>]\n", argv[0]);
     - 		return 1;
     - 	}
     - 
     +-		return 1;
     +-	}
     +-
      -	return generate_bytes('\0', parse_count(argc, argv, 1));
     -+	return generate_bytes(byte, parse_count(argc, argv, 2));
     - }
     +-}
      
       ## t/helper/test-tool.c ##
      @@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
     @@ t/t1007-hash-object.sh: test_expect_success '--stdin outside of repository (uses
       test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
       		'files over 4GB hash literally' '
      -	test-tool genzeros $((5*1024*1024*1024)) >big &&
     -+	test-tool genbytes NUL $((5*1024*1024*1024)) >big &&
     ++	test-tool genbytes 00 $((5*1024*1024*1024)) >big &&
       	test_oid large5GB >expect &&
       	git hash-object --stdin --literally <big >actual &&
       	test_cmp expect actual
     @@ t/t1007-hash-object.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
       test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
       		'files over 4GB hash correctly via --stdin' '
      -	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
     -+	{ test -f big || test-tool genbytes NUL $((5*1024*1024*1024)) >big; } &&
     ++	{ test -f big || test-tool genbytes 00 $((5*1024*1024*1024)) >big; } &&
       	test_oid large5GB >expect &&
       	git hash-object --stdin <big >actual &&
       	test_cmp expect actual
     @@ t/t1007-hash-object.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
       test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
       		'files over 4GB hash correctly' '
      -	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
     -+	{ test -f big || test-tool genbytes NUL $((5*1024*1024*1024)) >big; } &&
     ++	{ test -f big || test-tool genbytes 00 $((5*1024*1024*1024)) >big; } &&
       	test_oid large5GB >expect &&
       	git hash-object -- big >actual &&
       	test_cmp expect actual
     @@ t/t1007-hash-object.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
       test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
       		'hash filtered files over 4GB correctly' '
      -	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
     -+	{ test -f big || test-tool genbytes NUL $((5*1024*1024*1024)) >big; } &&
     ++	{ test -f big || test-tool genbytes 00 $((5*1024*1024*1024)) >big; } &&
       	test_oid large5GB >expect &&
       	test_config filter.null-filter.clean "cat" &&
       	echo "big filter=null-filter" >.gitattributes &&
     @@ t/t1051-large-conversion.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG
       	small_size=$(test_file_size small) &&
       	test_config filter.makelarge.smudge \
      -		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
     -+		"test-tool genbytes NUL $((5*1024*1024*1024)) && cat" &&
     ++		"test-tool genbytes 00 $((5*1024*1024*1024)) && cat" &&
       	echo "small filter=makelarge" >.gitattributes &&
       	rm small &&
       	git checkout -- small &&
     @@ t/t1051-large-conversion.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG
       test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
       		'files over 4GB convert on input' '
      -	test-tool genzeros $((5*1024*1024*1024)) >big &&
     -+	test-tool genbytes NUL $((5*1024*1024*1024)) >big &&
     ++	test-tool genbytes 00 $((5*1024*1024*1024)) >big &&
       	test_config filter.checklarge.clean "wc -c >big.size" &&
       	echo "big filter=checklarge" >.gitattributes &&
       	git add big &&
     @@ t/t1450-fsck.sh: test_expect_success 'fsck error on gitattributes with excessive
       
       test_expect_success 'fsck error on gitattributes with excessive size' '
      -	blob=$(test-tool genzeros $((100 * 1024 * 1024 + 1)) | git hash-object -w --stdin) &&
     -+	blob=$(test-tool genbytes NUL $((100 * 1024 * 1024 + 1)) | git hash-object -w --stdin) &&
     ++	blob=$(test-tool genbytes 00 $((100 * 1024 * 1024 + 1)) | git hash-object -w --stdin) &&
       	test_when_finished "remove_object $blob" &&
       	tree=$(printf "100644 blob %s\t%s\n" $blob .gitattributes | git mktree) &&
       	test_when_finished "remove_object $tree" &&
     @@ t/t1450-fsck.sh: test_expect_success 'fsck with blob size equal to core.bigFileT
       	(
       		cd big-blob-fsck &&
      -		test-tool genzeros 1024 >blob &&
     -+		test-tool genbytes NUL 1024 >blob &&
     ++		test-tool genbytes 00 1024 >blob &&
       		git add blob &&
       		git commit -m "blob equal to threshold" &&
       		git repack -ad &&
     @@ t/t4141-apply-too-large.sh: test_expect_success EXPENSIVE 'git apply rejects pat
       		@@ -0,0 +1 @@
       		EOF
      -		test-tool genzeros $((1024 * 1024 * 1023))
     -+		test-tool genbytes NUL $((1024 * 1024 * 1023))
     ++		test-tool genbytes 00 $((1024 * 1024 * 1023))
       	} | test_must_fail git apply 2>err &&
       	test_grep "patch too large" err
       '
     @@ t/t5318-commit-graph.sh: corrupt_graph_and_verify() {
       	printf "$data" | dd of="full/$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
       	dd of="full/$objdir/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null &&
      -	test-tool genzeros $(($orig_size - $zero_pos)) >>"full/$objdir/info/commit-graph" &&
     -+	test-tool genbytes NUL $(($orig_size - $zero_pos)) >>"full/$objdir/info/commit-graph" &&
     ++	test-tool genbytes 00 $(($orig_size - $zero_pos)) >>"full/$objdir/info/commit-graph" &&
       	corrupt_graph_verify "$grepstr"
       
       }

-- 
gitgitgadget
