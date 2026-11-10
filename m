Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335172;
	b=BljmillriheEJEvhBTiWJXFTqEZrX8MAFY2l733xPlU/WUUq9UU7tEzBlMMUv0cI+eEi
	 kCnnsgiETJ+OGFDF+EEoFxKURu+UjE1Fy3ct5augin1v3nY5tajcsLgZQaIUrH3soTqI/
	 gwDfijz9V248dFwPCRKO57tXlC6tcoArsGL5Ax7rZuHpmblTm4tlPckCXbctOxZZrEIB3
	 k5QFRfi19CR/guH8LPGYmyPeF/f9h5IR9h6niSb++4O8rrlI9lat7dLqx2zZnWt+YQJ55
	 C3cF9RZMrl5FDjhpj6sMQizBweOn8oD8Ndmex4c+ToGdAp781/qOQXXwcHSoc6qogmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=kWgLkuh9FizNV8VaWcaTdREGmEm2ozva/R5FIjGy0Rs=;
	b=WT4lEI4NXtnplhtfzV/VzQywjRQJ3aCimwvUEVwDv6SV8etJmSUYxVq5W3WQcJ1t7iu+
	 GpbwousztVZFIwy5W8D0TbaJRF5fv00gEN5tG2q1uplxBOJVTW+ho0E6m769OqAukosci
	 0NR9Mw1rTsUTm0MRinUAzH/pszfyEwazAfDVI9McBQ+x8JxMefLgYa2mQGMueMt+gEXWn
	 pYq/wEoI8EOWgXFx1fFHNFLB6PUGPhKE9d6A8vxZwIVfpMtLxE5QDRlRzY4L4US+9bwTw
	 sz77CkX0SyASUdbidhUr9B/iTFDdW1Wr3F2AAWMCTNxUT5YRrQDuy/icDN4/j6uW1Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zA9txcKd;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A349606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 18:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A349606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zA9txcKd
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so171263c88.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 10:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794335171; x=1794939971; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kWgLkuh9FizNV8VaWcaTdREGmEm2ozva/R5FIjGy0Rs=;
        b=zA9txcKd8p2+J8/aDxmT1EN90vqNeYKowKIvEVM6XYDDVruw75z/HSHJ3Ehsgxe6HT
         eBFBdwc2XBWXDQxcNQ8YS1j/S8Bwb2DUVdVNDuCjF9nkVxaNF6VHw1CkU1bQH1ZFQufQ
         C+k1GPpT1rBbUFtqJGugC0ZghQJiWL5mscTYzLFcrGhIoIGIrgVgDzKtNMlL8uUPAQ4G
         ch57TDrflkRKIITNZcLnUDuQ0XLDqNd6iS+NRC+freefAF1hZVxqgOxuvrS+TfPlXzvM
         3X7LcRtmkyH6Etid446GQXhX70Q4BsKksC0VnZWDElnfWxJVRGm/0nov39GdSUgYP7If
         1xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335171; x=1794939971;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kWgLkuh9FizNV8VaWcaTdREGmEm2ozva/R5FIjGy0Rs=;
        b=PEpThRkUd4UD+aYqRdHB9Cz4ogqxA0oSw/DBtj1EaS9+zbxf2nIQugNcFOaW7n00bB
         hhbJ+HGuj9HVSFYjhyOS6McdonRr5yjU7CFI4nK4y5V2Lt/GVWjqIsd6u8+ZiwqXWV86
         qA3DH8J6sybpAYbF4sclXA0CWbO00wDqCoMiORbrJmKxaI3k3EZrZxDezezqNo53YMcl
         h+vbV1HgVv+rOq4jKlWBMa6J9/tRgowhAMZZNtyyKFQbQsRm7gUhb6mq56ay0+fXBG/a
         H1L4qOUaxGDTBOcgDINGym1/eDZfgyN4ZBIVqVXlxjkf5ZD4qDhZTT4NDwoSuWRqSoYl
         81RA==
X-Gm-Message-State: APuU4Z/JZtY/2mUjALDqZ03w4uqT7gdgTFhIfBUMjpCGF/uEG1qm5PBh
	V/SgQZYXm3JWXGCpptiZd1Ot2jSnrpjC8WW1uTQ3jpA25MLgnlME2XtyqmfZTg==
X-Gm-Gg: AYBFou0G+6DP8T3HNGfInUtijWePzRklnxgBTMaP6um/86GmI3LRjW3doqCP3iKBpGK
	RqdZGeSRynKxIQ5dVjp7vmUJMVIzVn+RJ/exjhKsAZt054M7ojfD8iQPu9N96OXEqv9riZfoowY
	DTkgKcfCdZkphSpoWs5d4ioXYlP7nsfzTxXiUb/xfBV1+0ReQSngIsTe00sQIh3DTkbGiRrVkji
	NNU3qVLVUVGgHCuENB/l9z3L+h4KAsRIx8XAqHc55unnGFOshU599/2JwkmwnORmwZUxZkSjjgi
	D1xyJO42/aKl1+X9n9F34V38e+rONup8w2QbCYuh85sVE6JXE5wxJwgcvkzwRoy5u9xXs+GPBwv
	aFt8H3qO29D0FOKj+xnga0CoGKaHZkau6A6Luv/uEpMD2cwHfLqG/G5hcMaJOjS/MitqP2nvYQT
	n4EjRsOZgI/lnSbKlj3LTAsYJw+9l6Rqd68pyOFXD9is5R9gJSlTRcMyPYU5e+bEOM4LtGj7AXH
	8sGqjfbDnTmN5Wv9NsSciHwud4qoOjOUJhQbYZz/X8gQw7gUKjWHTpPfcr3Vf89GriRN/3Xl0rD
	O3dag3stj/1CnYQdd5TDw7glWI7zrdg=
X-Received: by 2002:a05:701b:2901:b0:1a8:7b58:6f1b with SMTP id a92af1059eb24-1b3b6078256mr5219435c88.19.1794335169428;
        Tue, 10 Nov 2026 10:26:09 -0800 (PST)
Received: from [127.0.0.1] ([20.169.74.100])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4b90csm7725499c88.14.2026.11.10.10.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:26:08 -0800 (PST)
Message-Id: <pull.2301.v3.git.1794335168170.gitgitgadget@gmail.com>
In-Reply-To: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 18:26:08 +0000
Subject: [PATCH v3] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2301%2Fspkrka%2Ftest-tool-genbytes-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2301/spkrka/test-tool-genbytes-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2301

Range-diff vs v2:

 1:  54139a3a97 ! 1:  17e5baacdb t: add "test-tool genbytes" to avoid slow tr(1) on macOS
     @@ Commit message
          macOS CI runners, tr(1) alone spends 95 to 123 seconds of CPU time on
          it, compared to about 6 seconds on Linux.
      
     -    Fix this by adding "test-tool genbytes <hex-byte> [<count>]", which
     -    writes the requested byte, given as two lowercase hexadecimal
     -    digits, directly.  Turn "genzeros" into a thin wrapper around the
     -    same code, and rename the file to match.  Use the new helper in all
     -    tests that piped "genzeros" through tr(1), not just t4205, so that
     -    it is the obvious choice for new tests.
     +    Fix this by adding "test-tool genbytes <char> [<count>]" next to
     +    "genzeros", sharing the same code, which writes the requested
     +    character directly.  Use it in all tests that piped "genzeros"
     +    through tr(1), not just t4205, so that it is the obvious choice for
     +    new tests.  Callers that want NUL bytes keep using "genzeros".
     +
     +    While at it, parse the count with git_parse_signed(), so that an
     +    invalid count is reported as a usage error instead of being silently
     +    treated as 0.
      
          This makes t4205 much faster on macOS in CI.  The Linux jobs, shown
     -    for comparison, only save the few seconds that GNU tr(1) took, which
     -    is within the usual noise:
     +    for comparison, show smaller differences, which may partly be due to
     +    normal run-to-run variation:
      
            job                before    after   change
            osx-gcc            821.1s   243.3s   -70.4%
     @@ Commit message
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
     - ## Makefile ##
     -@@ Makefile: TEST_BUILTINS_OBJS += test-env-helper.o
     - TEST_BUILTINS_OBJS += test-example-tap.o
     - TEST_BUILTINS_OBJS += test-find-pack.o
     - TEST_BUILTINS_OBJS += test-fsmonitor-client.o
     -+TEST_BUILTINS_OBJS += test-genbytes.o
     - TEST_BUILTINS_OBJS += test-genrandom.o
     --TEST_BUILTINS_OBJS += test-genzeros.o
     - TEST_BUILTINS_OBJS += test-getcwd.o
     - TEST_BUILTINS_OBJS += test-hash-speed.o
     - TEST_BUILTINS_OBJS += test-hash.o
     -
     - ## t/helper/meson.build ##
     -@@ t/helper/meson.build: test_tool_sources = [
     -   'test-example-tap.c',
     -   'test-find-pack.c',
     -   'test-fsmonitor-client.c',
     -+  'test-genbytes.c',
     -   'test-genrandom.c',
     --  'test-genzeros.c',
     -   'test-getcwd.c',
     -   'test-hash-speed.c',
     -   'test-hash.c',
     -
     - ## t/helper/test-genbytes.c (new) ##
     + ## t/helper/test-genzeros.c ##
      @@
     -+#define DISABLE_SIGN_COMPARE_WARNINGS
     -+
     -+#include "test-tool.h"
     -+#include "git-compat-util.h"
     -+#include "hex-ll.h"
     -+
     + 
     + #include "test-tool.h"
     + #include "git-compat-util.h"
     ++#include "parse.h"
     + 
     +-int cmd__genzeros(int argc, const char **argv)
      +/*
      + * Write "count" copies of "byte" to stdout, or an endless stream of them if
      + * "count" is negative.
      + */
     -+static int generate_bytes(char byte, intmax_t count)
     -+{
     -+	char buf[256 * 1024];
     -+	ssize_t n;
     -+
     ++static int generate_bytes(unsigned char byte, intmax_t count)
     + {
     +-	/* static, so that it is NUL-initialized */
     +-	static const char zeros[256 * 1024];
     +-	intmax_t count;
     ++	static char buf[256 * 1024];
     + 	ssize_t n;
     + 
     +-	if (argc > 2) {
     +-		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
     +-		return 1;
     +-	}
     +-
     +-	count = argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
      +	memset(buf, byte, sizeof(buf));
     -+
     + 
     +-	/* Writing out individual NUL bytes is slow... */
      +	/* Writing out individual bytes is slow... */
     -+	while (count < 0)
     + 	while (count < 0)
     +-		if (xwrite(1, zeros, ARRAY_SIZE(zeros)) < 0)
      +		if (xwrite(1, buf, ARRAY_SIZE(buf)) < 0)
     -+			die_errno("write error");
     -+
     -+	while (count > 0) {
     + 			die_errno("write error");
     + 
     + 	while (count > 0) {
     +-		n = xwrite(1, zeros,
     +-			   count < ARRAY_SIZE(zeros)
     +-			   ? count : ARRAY_SIZE(zeros));
      +		n = xwrite(1, buf,
      +			   count < ARRAY_SIZE(buf)
      +			   ? count : ARRAY_SIZE(buf));
     -+
     -+		if (n < 0)
     -+			die_errno("write error");
     -+
     -+		count -= n;
     -+	}
     -+
     -+	return 0;
     -+}
     -+
     -+static intmax_t parse_count(int argc, const char **argv, int pos)
     -+{
     -+	return pos < argc ? strtoimax(argv[pos], NULL, 0) : -1;
     -+}
     + 
     + 		if (n < 0)
     + 			die_errno("write error");
     +@@ t/helper/test-genzeros.c: int cmd__genzeros(int argc, const char **argv)
     + 
     + 	return 0;
     + }
      +
      +int cmd__genbytes(int argc, const char **argv)
      +{
     -+	if (argc < 2 || argc > 3 || strlen(argv[1]) != 2 ||
     -+	    strspn(argv[1], "0123456789abcdef") != 2) {
     -+		fprintf(stderr, "usage: %s <hex-byte> [<count>]\n", argv[0]);
     ++	intmax_t count = -1;
     ++
     ++	if (argc < 2 || argc > 3 || strlen(argv[1]) != 1 ||
     ++	    (argc == 3 && !git_parse_signed(argv[2], &count, INTMAX_MAX))) {
     ++		fprintf(stderr, "usage: %s <char> [<count>]\n", argv[0]);
      +		return 1;
      +	}
      +
     -+	return generate_bytes(hex2chr(argv[1]), parse_count(argc, argv, 2));
     ++	return generate_bytes(argv[1][0], count);
      +}
      +
      +int cmd__genzeros(int argc, const char **argv)
      +{
     -+	if (argc > 2) {
     ++	intmax_t count = -1;
     ++
     ++	if (argc > 2 ||
     ++	    (argc == 2 && !git_parse_signed(argv[1], &count, INTMAX_MAX))) {
      +		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
      +		return 1;
      +	}
      +
     -+	return generate_bytes('\0', parse_count(argc, argv, 1));
     ++	return generate_bytes('\0', count);
      +}
      
     - ## t/helper/test-genzeros.c (deleted) ##
     -@@
     --#define DISABLE_SIGN_COMPARE_WARNINGS
     --
     --#include "test-tool.h"
     --#include "git-compat-util.h"
     --
     --int cmd__genzeros(int argc, const char **argv)
     --{
     --	/* static, so that it is NUL-initialized */
     --	static const char zeros[256 * 1024];
     --	intmax_t count;
     --	ssize_t n;
     --
     --	if (argc > 2) {
     --		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
     --		return 1;
     --	}
     --
     --	count = argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
     --
     --	/* Writing out individual NUL bytes is slow... */
     --	while (count < 0)
     --		if (xwrite(1, zeros, ARRAY_SIZE(zeros)) < 0)
     --			die_errno("write error");
     --
     --	while (count > 0) {
     --		n = xwrite(1, zeros,
     --			   count < ARRAY_SIZE(zeros)
     --			   ? count : ARRAY_SIZE(zeros));
     --
     --		if (n < 0)
     --			die_errno("write error");
     --
     --		count -= n;
     --	}
     --
     --	return 0;
     --}
     -
       ## t/helper/test-tool.c ##
      @@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
       	{ "example-tap", cmd__example_tap },
     @@ t/t0613-reftable-write-options.sh: test_expect_success 'small block size fails w
       		cd repo &&
       		test_commit A &&
      -		test-tool genzeros 500 | tr "\000" "a" >logmsg &&
     -+		test-tool genbytes 61 500 >logmsg &&
     ++		test-tool genbytes a 500 >logmsg &&
       		cat >expect <<-EOF &&
       		fatal: update_ref failed for ref ${SQ}refs/heads/logme${SQ}: reftable: transaction failure: entry too large
       		EOF
     @@ t/t4205-log-pretty-formats.sh: test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'lo
       
       test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
      -	test-tool genzeros 2147483649 | tr "\000" "1" >expect &&
     -+	test-tool genbytes 31 2147483649 >expect &&
     ++	test-tool genbytes 1 2147483649 >expect &&
       	huge_commit=$(git commit-tree -F expect HEAD^{tree})
       '
       
     @@ t/t5300-pack-object.sh: test_description='git pack-object'
      -	test-tool genzeros 4096 | tr "\000" "a" >a &&
      -	test-tool genzeros 4096 | tr "\000" "b" >b &&
      -	test-tool genzeros 4096 | tr "\000" "c" >c &&
     -+	test-tool genbytes 61 4096 >a &&
     -+	test-tool genbytes 62 4096 >b &&
     -+	test-tool genbytes 63 4096 >c &&
     ++	test-tool genbytes a 4096 >a &&
     ++	test-tool genbytes b 4096 >b &&
     ++	test-tool genbytes c 4096 >c &&
       	test-tool genrandom "seed a" 2097152 >a_big &&
       	test-tool genrandom "seed b" 2097152 >b_big &&
       	git update-index --add a a_big b b_big c &&
     @@ t/t7006-pager.sh: test_expect_success 'setup trace2' '
       test_expect_success 'setup large log output' '
      -	test-tool genzeros 50000 |
      -	tr "\000" "a" |
     -+	test-tool genbytes 61 50000 |
     ++	test-tool genbytes a 50000 |
       	sed "s/a/this is a long commit message/g" >commit-msg &&
       	git commit --allow-empty -F commit-msg
       '
     @@ t/t9850-shell.sh: test_expect_success 'shell allows interactive command' '
       
       test_expect_success 'shell complains of overlong commands' '
      -	test-tool genzeros | tr "\000" "a" |
     -+	test-tool genbytes 61 |
     ++	test-tool genbytes a |
       	test_must_fail git shell 2>err &&
       	test_grep "too long" err
       '
 2:  f49af0e33f < -:  ---------- t: replace "test-tool genzeros" with "genbytes 00"


 t/helper/test-genzeros.c          | 54 ++++++++++++++++++++++---------
 t/helper/test-tool.c              |  1 +
 t/helper/test-tool.h              |  1 +
 t/t0613-reftable-write-options.sh |  2 +-
 t/t4205-log-pretty-formats.sh     |  2 +-
 t/t5300-pack-object.sh            |  6 ++--
 t/t7006-pager.sh                  |  3 +-
 t/t9850-shell.sh                  |  2 +-
 8 files changed, 48 insertions(+), 23 deletions(-)

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

base-commit: fbd2d1e765da4d2931cadc4c62d3ca5d5b590e7e
-- 
gitgitgadget
