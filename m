Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911888;
	b=wzSjOOPPgUCV+LTYVRBoOyWCghr7EFY4bucoEuLWrcr11Kq4D505oCv3MqMFcGdG4IL9
	 DdqUR1hziVHpQW42BnEmd43q/OaK2YMNz8daIqg2ulzaSgtIU45Em7Q1sqXXlm21RdayT
	 n2v/twK8q3dfOwmUysWmUOMmPIKiMFgVtyXaKNYk0kbvHLQ57Ps8L3ScvX/g9vpfT2IKj
	 rm46+Di6DhZKKtx8htYEM2XmdX2AStHAi1DZlZaulPtIXFoF/nTRB+gx03HRapxZiF51M
	 Fssdy9zObniHXxOIGfsv7mhLFWHxcnoRXJf46M1lCBRZGgnvR/jew8XBARefLNtpO3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mtvdRul3D5pOzJl3pzRYSs5dX+6LMbtLJkoSvMIk3ds=;
	b=gdpEeToqyq6RTnF0L8o56/MkHZ8hNo3+jmxbzOHUQMA/UHrwVjWKWNZ/wgx3C38XvPWt
	 xTBQPYSRqgXJqCNmJ7lvuu2yAnG2n/KYe95udt9q+ZCXS8xvo3vIbM6lY8P1Hs8rd7a9M
	 rmPorWm0LbQawiJwlo1/oodu74yEK/MesMs6W+zeb7Bbpcp0JXa8EG1i20C1NclFq7YCC
	 zgdTA2XUBzfGaZaMUJ/ZeoblJwDRdV4RsfFLVwIfkJzNZfY8DaBq8UyvQvFErPVWWnEsL
	 +zqE3aJ7R4CmQ+VulFnmGrS92nFyzjB/hXUwuPQzGVqBpoJjNhAtBRTZSaWhsOSI5dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kZnJvbja;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA093606A89E
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 10:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA093606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kZnJvbja
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so2422109f8f.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 02:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794911886; x=1795516686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mtvdRul3D5pOzJl3pzRYSs5dX+6LMbtLJkoSvMIk3ds=;
        b=kZnJvbjamUsGnZPmXFBSehAgCAF95xB1RgwxCRC5ta0hGC2T9dTjhgO8X6YRa9nRf0
         GU1nWWR8uPRTlkp0vC8h6H1AGCT5AnqEbQbdXZgf8qA7gKWTQKbnOsGo5KQqdRJAPEMh
         mBh9vlTQq91HOkSwcOzwXxwx5gpA61ycLiJkuGdudAo9gZWQlsXi4XHNKpMXejg5WtTe
         IDrZFQioQtS7E1TfRI8BkdUMOyErSt5d0wPEDchJ+Go0j5wNacqoH1GH02DIu/HHBrYV
         7sxm8RuCMiGLtScBkqz8RFd5qRbcTJ3ACHrFKfl88oA2p060aMnYZXaZ5n0z1Q9dORhC
         jCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794911886; x=1795516686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mtvdRul3D5pOzJl3pzRYSs5dX+6LMbtLJkoSvMIk3ds=;
        b=COzJmZlqvnkWGRVPi9gpIT/ctNDc5kxXB154wYE2CYsAjZIrNlEmQTbXNKiKg/RZ9g
         YVuy7EU3420Z8pjcvSZfORKY8qKdYZaba1KdYJhTC9XJDb2GyVLx1bWBLsN4AXKaNszG
         9PKYDsesX/wRdOOTfYOyDHGk7G6BWiMfIDNDLjMC30PVjDktsFzVbqfRi8uZ0KTY5C/Q
         on1QbBEAJlkchA6Riyk1Ja4eJCwvNOMJh3GFX6fsfeGwQyUo3bxQ5pFHkMEUYQa+Jye7
         WrZG0XTkXJgd3XyYhPbhOrsk0RL8FigCJaGQHO6Poklvk0VDQ1A7Ap3hm+DUAQjeayiY
         pcwA==
X-Gm-Message-State: APuU4Z8ZOaS/6JsVjEAqFLRhykPg7ICuLv7dsDoneanyXg6o73bHvoz4
	WL+wfGPDMzAG+epNX2rVD7cvRWJe2AiKu/fhcp6/nO4Ccmlp143FCoJI6xdisg==
X-Gm-Gg: AZFdTZdypkk1fJ7IgDJQJKYxklZ3Ih2b3rBTd6Dp/BnHT+3s9+b+V5LCeTRzXn2weig
	dAhbiwRuH8VZosfvYLqxAXg3WKPMI3m+q0aNQLvIM41Chd7jaJXQ0e+dfW9/534uXqVPXhYOhr4
	76+izBIH/eNyBm3YFrTubSi9dBgZERS41QJMNovtc7L4ZmIBCyrHZk5nCcgsQp+GN7SrFhpZXfB
	7ZtqZlUId0oyPRXCGLzfo8MK1f9zXVUO1jMz7juyozMgwYstKxgKKZozLUO+jyiBJ1OxGlVd+Tm
	YUOLVWX2i0SVaqWC16YPZKeTkSDMFMJe63Oh+4dKuMCmYv3xUS2wKxSuicaLB3YNuScoq2ECIiz
	hOtHiJ71Qv9cFfzd7gwrKqHG9LVI2xMgHIwlcmc/JmsGoeZgGBd/BDo1mICelFqfP2VcD1Mo8X3
	xXYroGPanUEDz3k+HQoZYwdwyCFYGFpW1jWoPMqEcDcrQs+xPICd42qEGd7sK2Z/wx4BJOXAhK8
	A5qOzw6T+gCWtu6hYNExtysJE8+mrW8AoIUfUQ6nLXO486nthftKiknpI4OOHlLgmGVNSVRV8+p
	9BBB8Sh2WFWmUnPlsN7GLUA/0BQvUNZELU6TJ3vjFMJkMtEmKoeIPkMYnTKClTc=
X-Received: by 2002:a05:6000:4024:b0:490:d197:bde8 with SMTP id ffacd0b85a97d-49c6b972aedmr32950691f8f.0.1794911886026;
        Tue, 17 Nov 2026 02:38:06 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm44715932f8f.44.2026.11.17.02.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:38:05 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Montalbo <mmontalbo@gmail.com>
Subject: [PATCH v2 2/4] diff: use size_t for sizes and line counts of complete rewrites
Date: Tue, 17 Nov 2026 11:37:54 +0100
Message-ID: <e63ed0c49c513e5f771f55f68e79735c3f3c17c0.1794909894.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794909894.git.gitter.spiros@gmail.com>
References: <cover.1793546752.git.gitter.spiros@gmail.com> <cover.1794909894.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "git diff -B" finds a complete rewrite, the diffstat comes from
count_lines() and the patch from emit_rewrite_diff(). Neither goes
through xdiff, so MAX_XDIFF_SIZE does not apply to them.

Without -B, a file this large does not get that far. If its contents
have not been loaded yet and it is larger than core.bigFileThreshold
(512MiB by default), it is treated as binary; otherwise xdiff refuses
it, as it does not accept more than MAX_XDIFF_SIZE (just under 1GiB).
With -B, should_break() in diffcore-break.c loads the contents without
asking for the binary check, so core.bigFileThreshold is never looked
at and a file too large for an "int" reaches count_lines().

count_lines() and emit_rewrite_lines() take the size as an "int". For
a file of 2GiB or more the size is truncated, typically to a negative
value, and both functions then see no data. As a result:

 - "git diff -B --stat" reports 0 changed lines;

 - "git diff -B -p" prints "@@ -0,0 +0,0 @@" with no body, a patch
   that "git apply" rejects as corrupt, and still exits with status 0.

Passing the size as a size_t is not enough. The size no longer bounds
the "int" line counter in count_lines(), which overflows on a file of
more than INT_MAX lines, and emit_rewrite_lines() would still truncate
the size, leaving a correct hunk header above an empty body.

Use size_t throughout this code path instead:

 - count_lines() takes a size_t and returns a size_t count, which
   struct diffstat_file already stores in uintmax_t;

 - count_trailing_blank() uses size_t for its counter, which overflows
   on a file ending in more than INT_MAX blank lines, and for the size,
   which it stored in a "long". On LLP64 platforms such as 64-bit
   Windows, where "long" has 32 bits while size_t has 64, a size of
   2GiB or more would move the pointer before the start of the buffer.
   This was found by inspection and has not been tested on such a
   platform;

 - emit_rewrite_diff(), add_line_count() and check_blank_at_eof() hold
   and print these counts as size_t, as do the line number and blank
   line fields of struct emit_callback;

 - emit_rewrite_lines() takes the size as a size_t. The length of one
   line remains an "int" because emit_del_line() and emit_add_line()
   take one, so use cast_size_t_to_int() to die instead of truncating
   it when a single line is longer than INT_MAX;

 - builtin_checkdiff() follows the type of the field it reads. It is
   still protected by the xdiff limit.

To reproduce, using about 2.2GiB of working tree data:

	yes old | head -c 2200M >big &&
	git add big &&
	git commit -m old &&
	yes new | head -c 2200M >big &&
	git diff -B --stat

Before this patch this reports 0 insertions and 0 deletions. With it,
it reports 576716800 of each.

Add two tests to t4022, marked EXPENSIVE because they need several GiB
of disk space and take minutes to run. The first checks the numstat
and the patch for a file of 2GiB. The second checks the numstat for a
file of 2^31 lines. Both fail before this patch, and also with only the
size parameter of count_lines() changed.

The tests run only where size_t and "long" have 64 bits. struct
diff_filespec still holds the size of the file in an "unsigned long",
and the tests have not been run on a platform where "long" has 32
bits, such as Windows, whose CI would run them.

The count_trailing_blank() overflow is not covered by these tests. It
only affects whitespace highlighting, so it is not visible in the
uncoloured output. It was checked instead with a build using
"make SANITIZE=signed-integer-overflow", by running "git diff -B -p"
on a complete rewrite to a file of 2200MiB of newlines: the sanitizer
stops in count_trailing_blank() without this change and reports nothing
with it.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
Changes since v1:

 - v1 only changed the size parameter of count_lines(). Phillip pointed
   out that this removes the bound that kept the "int" counter from
   overflowing, so count_lines() now counts and returns a size_t.

 - emit_rewrite_lines() now takes a size_t. With v1, "git diff -B -p"
   printed a correct hunk header above an empty body.

 - count_trailing_blank() and the callers and fields that hold line
   counts now use size_t. This also fixes a "long" size that is too
   small on LLP64 platforms.

 - Add EXPENSIVE tests to t4022. Both fail on master and with v1.

 - The commit message is rewritten. v1 said that only the diffstat was
   affected and that there were no memory access issues; neither claim
   holds. The 16-bit simulation is replaced by a reproduction on a real
   file.
---
 diff.c                  | 44 ++++++++++++++++++-----------------
 t/t4022-diff-rewrite.sh | 51 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index b4ac17f8ef..ee92a8ac4d 100644
--- a/diff.c
+++ b/diff.c
@@ -598,10 +598,10 @@ static struct diff_tempfile {
 struct emit_callback {
 	int color_diff;
 	unsigned ws_rule;
-	int blank_at_eof_in_preimage;
-	int blank_at_eof_in_postimage;
-	int lno_in_preimage;
-	int lno_in_postimage;
+	size_t blank_at_eof_in_preimage;
+	size_t blank_at_eof_in_postimage;
+	size_t lno_in_preimage;
+	size_t lno_in_postimage;
 	int last_line_kind;
 	const char **label_path;
 	struct diff_words_data *diff_words;
@@ -655,9 +655,10 @@ struct line_range_callback {
 	int ret;			/* latched error from orig_line_fn */
 };
 
-static int count_lines(const char *data, int size)
+static size_t count_lines(const char *data, size_t size)
 {
-	int count, ch, completely_empty = 1, nl_just_seen = 0;
+	size_t count;
+	int ch, completely_empty = 1, nl_just_seen = 0;
 	count = 0;
 	while (0 < size--) {
 		ch = *data++;
@@ -708,11 +709,11 @@ static unsigned long diff_filespec_size(struct repository *r,
 	return one->size;
 }
 
-static int count_trailing_blank(mmfile_t *mf)
+static size_t count_trailing_blank(mmfile_t *mf)
 {
 	char *ptr = mf->ptr;
-	long size = mf->size;
-	int cnt = 0;
+	size_t size = mf->size;
+	size_t cnt = 0;
 
 	if (!size)
 		return cnt;
@@ -737,7 +738,7 @@ static int count_trailing_blank(mmfile_t *mf)
 static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 			       struct emit_callback *ecbdata)
 {
-	int l1, l2, at;
+	size_t l1, l2, at;
 	l1 = count_trailing_blank(mf1);
 	l2 = count_trailing_blank(mf2);
 	if (l2 <= l1) {
@@ -1816,7 +1817,7 @@ static void remove_tempfile(void)
 	}
 }
 
-static void add_line_count(struct strbuf *out, int count)
+static void add_line_count(struct strbuf *out, size_t count)
 {
 	switch (count) {
 	case 0:
@@ -1826,29 +1827,30 @@ static void add_line_count(struct strbuf *out, int count)
 		strbuf_addstr(out, "1");
 		break;
 	default:
-		strbuf_addf(out, "1,%d", count);
+		strbuf_addf(out, "1,%"PRIuMAX, (uintmax_t)count);
 		break;
 	}
 }
 
 static void emit_rewrite_lines(struct emit_callback *ecbdata,
-			       int prefix, const char *data, int size)
+			       int prefix, const char *data, size_t size)
 {
 	const char *endp = NULL;
 
 	while (0 < size) {
-		int len, plen;
+		size_t len;
+		int plen;
 		char *pdata = NULL;
 
 		endp = memchr(data, '\n', size);
 
 		if (endp) {
 			len = endp - data + 1;
-			plen = len;
+			plen = cast_size_t_to_int(len);
 		} else {
 			len = size;
-			plen = len + 1;
-			pdata = xmalloc(plen + 2);
+			plen = cast_size_t_to_int(len + 1);
+			pdata = xmalloc(len + 3);
 			memcpy(pdata, data, len);
 			pdata[len] = '\n';
 			pdata[len + 1] = '\0';
@@ -1879,7 +1881,7 @@ static void emit_rewrite_diff(const char *name_a,
 			      struct userdiff_driver *textconv_two,
 			      struct diff_options *o)
 {
-	int lc_a, lc_b;
+	size_t lc_a, lc_b;
 	static struct strbuf a_name = STRBUF_INIT, b_name = STRBUF_INIT;
 	const char *a_prefix, *b_prefix;
 	char *data_one, *data_two;
@@ -4308,7 +4310,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 
 		if (data.ws_rule & WS_BLANK_AT_EOF) {
 			struct emit_callback ecbdata;
-			int blank_at_eof;
+			size_t blank_at_eof;
 
 			ecbdata.ws_rule = data.ws_rule;
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
@@ -4318,8 +4320,8 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 				static char *err;
 				if (!err)
 					err = whitespace_error_string(WS_BLANK_AT_EOF);
-				fprintf(o->file, "%s:%d: %s.\n",
-					data.filename, blank_at_eof, err);
+				fprintf(o->file, "%s:%"PRIuMAX": %s.\n",
+					data.filename, (uintmax_t)blank_at_eof, err);
 				data.status = 1; /* report errors */
 			}
 		}
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index b5c1b6868f..08e5533437 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -97,5 +97,54 @@ test_expect_success 'no newline at eof is on its own line with -B' '
 	test_grep ! "^..*\\\\ " res
 '
 
-test_done
+# Write "$1" repeated 2^$2 times to "$3".
+repeat_doubling () {
+	printf "$1" >"$3" &&
+	for i in $(test_seq "$2")
+	do
+		cat "$3" "$3" >"$3.tmp" &&
+		mv "$3.tmp" "$3" || return 1
+	done
+}
+
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,LONG_IS_64BIT 'rewrite of a 2GiB file' '
+	test_when_finished "rm -rf rewrite-2gb" &&
+	git init rewrite-2gb &&
+	(
+		cd rewrite-2gb &&
+		test_seq 1000 >big &&
+		git add big &&
+		git commit -m small &&
+		repeat_doubling "new\n" 29 big &&
+
+		printf "536870912\t1000\tbig\n" >expect &&
+		git diff -B --numstat >actual &&
+		test_cmp expect actual &&
+
+		git diff -B -p >diff &&
+		echo "@@ -1,1000 +1,536870912 @@" >expect &&
+		grep "^@@" diff >actual &&
+		test_cmp expect actual &&
+		echo 536870912 >expect &&
+		grep -c "^+new$" diff >actual &&
+		test_cmp expect actual
+	)
+'
 
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,LONG_IS_64BIT 'rewrite with 2^31 lines' '
+	test_when_finished "rm -rf rewrite-2g-lines" &&
+	git init rewrite-2g-lines &&
+	(
+		cd rewrite-2g-lines &&
+		test_seq 1000 >big &&
+		git add big &&
+		git commit -m small &&
+		repeat_doubling "\n" 31 big &&
+
+		printf "2147483648\t1000\tbig\n" >expect &&
+		git diff -B --numstat >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done
-- 
2.53.0

