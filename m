Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070648;
	b=PXDIzZRm1aXkm9JUOyizBQXvDX7gw6HkCEImoVQyrDVSUhop8ojewKYj+ogQ39d2kKif
	 65NgvLRmD8xuqCs1SctoFi7cGVCrWc78o5fjLg3FNLDGmbpjg/p1fCalqBhg7HjUnBQRg
	 yWKLW5g35A/xM7/mx1qsNCy3UF7XyapzvaNLGrAB9378UceY1SMYhrDr7pZV7DSMg7KGJ
	 H2paYkDBZdFrYQnCX9ZLIRcerK7sO7b6qy9UZdrGHEONoNUVZ9/BnlT2A4oGvYMtKFb6K
	 JUCiypqwAdTkDe7qgPt+eQNWIa7K9GCbBJOyrD5AN/xgWb06jYpaoQPMAMRSazVDaig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070648;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h0IjKqif0uU5TgRaXZe//d2dZ9QqWb8L84CeBIY7b9w=;
	b=EwvjXPXXOOkns0IusR97q9eHfA3meGG+/XjKZ+ra7oqePVzHSHc0MdPQlsE2VotqquSc
	 pTabQdc0YlUiVGBDLXC73fvN4i6P0kQctBw2FKJaz9qtcMhKpfV58B+rMeLlYDUIZbA5t
	 1YX14IWBZEtH1J/U+jaNC9ZvxXH0nRJhuj0QRMKb1qA4JpuEusW5OOwt3ufeVHy9ZkIG4
	 NgA4SDmFw7ncLwtwvw7DwC//2sfOWrI79DHdcpRL98gHIUEc7icVXU7GIWZIiW8RqB7Sb
	 +QHO9c+woIqnUnicnQUpCo+AQPnoYjZAv/QjXtRCWpUzQVyZeGtEyjSccYOu59P1CBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="LmD/iCc+";
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD26606A326
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECD26606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LmD/iCc+
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so15853105e9.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795070646; x=1795675446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h0IjKqif0uU5TgRaXZe//d2dZ9QqWb8L84CeBIY7b9w=;
        b=LmD/iCc+pElYLca1MiJF91ZR45sMrXoHi5wHpqZSSNQlpmwpXA3KRRbffiIFYNBcxC
         XoSl4Pvvv1K4rE9v9ki6huU5lgsLr5ht+wOcpClJau4KBFxGTCyKprm6cpi/djmDe42f
         wsZBcETGyCfQ3nyBPuWLs/3N/9BuTjMKGkX0rIfSG7KxL98MD1VMmrsF8FtpYOuTG0Kl
         Dpif73EQMktzNG2UZljPIQXIXcxTcTQ90ROGRJrCPt5sOERqDQxGA5zVv6+TMpKQjnX1
         1KL8gDKDT/ubpNJ7QsCt2I8j1e2IfgwObOJPdAaaciKCx7QFVdgImO/ISVJQXgibe0Ee
         pyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795070646; x=1795675446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h0IjKqif0uU5TgRaXZe//d2dZ9QqWb8L84CeBIY7b9w=;
        b=kgo8t6X0kMBBRBuqIcK4DYgJxO8FlL17ZozmpHyWvOM3r1TTCA3HJUdlSA3LQ0DwtY
         MS1D/ktbY4+gKgdN68j/3LF0UUOx50YmHegA2QqLQhYWxn5YhlQEY5RZKrJZbQPpw6yR
         VAJ+9R83UtyK3OQkLwofdEuj2hhpr38AnMeh1egnvmUMKb7+Jy/aRZhseoT3w6TMc2HO
         sOZmbYMNN6woIOuXqb9dbSRXC2zLj2nDqnetUYz73rg3LgVaKY9eFDis6CrSSuvMpjHa
         s5oNaTRgFCNVMR5JVdRjghEoV9yMUO57CmNKYZcSN3ikiD1uccjnveN1L843XOij7u0V
         BQFg==
X-Gm-Message-State: APuU4Z+4WefKoWRfzX/14I50pEgnxEJDYA6elBWXeAGGNYb3TCE1Kq2A
	KCGj8i+iTnt6ADeKPkloo/9YF75NbaKSsAFZM1me0+gfrQVDAneReUgeCTnwFQ==
X-Gm-Gg: AYBFou0WtERNxg0ZeSLWpN2SJ6JcYVUJxJOMWegyUBJA5HOVagwerNyo9NtfQwjQ3I6
	wZRvnwiwyD4x/C3FEh6T0xXiA88DOk8eD4Aj3GVaREc4FFaHTCC9knwBujvMcVJyqNBjhYpjsuI
	6Rm5uVcKIfIWTEXHmphC7g4VkFqA3jhoOapzgX7S89CHbY0KBzjz4tkiPdPbeGGc11LlYYycRrs
	/2dwjZGkYfzOzu/t8vxqpn0d03kWcQN4RGhAd++xDpOcvuZAz6oXxFQXzLKmWdNL7J+syldhzgq
	wb1u4dixIO6ObOcPUHw9Qo+cOwP5P8thX73dkpxTVDfZHbWtkOZYTTAL0K9SDzuYwEoE4/I8/mQ
	m+3JmTKPd3ng3HgCUZp9S7VQ7yox+/nmE7U1vUWzuvBp4Akf8gl2dT2AVdDgAPbcB+yXCGH5Y36
	K/w/C888QAKnCE7cNQiPmoRguuxPiB+W1KhIOs/M4INYoG8UhwQKJPUqt+aOEYJy4MNUkEjLdj7
	3ShiOKqB22dN26wFrQJjoAs9T6QuXUqbQdC2TwmRZNIU0y1OWYvl5vZ3ytlqPrv1+GuP+Y4at8G
	GmfX2tHo24oQ2DgIcf2j+yJuBTj9zGVeNDDJjHvYSyMeR+Mr1u4nnPObQXcCMNc=
X-Received: by 2002:a05:600c:6095:b0:4bb:6238:cd81 with SMTP id 5b1f17b1804b1-4bb7d9fb3e1mr87607455e9.10.1795070646187;
        Wed, 18 Nov 2026 22:44:06 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85372d15sm15172955e9.14.2026.11.18.22.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:44:05 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Montalbo <mmontalbo@gmail.com>
Subject: [PATCH v3 2/4] diff: use size_t for sizes and line counts of complete rewrites
Date: Thu, 19 Nov 2026 07:43:54 +0100
Message-ID: <aa16803558c3c6bce444e46a778fa0c51c42df6d.1795070117.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1795070117.git.gitter.spiros@gmail.com>
References: <cover.1794909894.git.gitter.spiros@gmail.com> <cover.1795070117.git.gitter.spiros@gmail.com>
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
count_lines() and the patch from emit_rewrite_diff(), neither of which
goes through xdiff and its MAX_XDIFF_SIZE limit. should_break() loads
the contents without the binary check, so core.bigFileThreshold does
not stop a large file either.

count_lines() and emit_rewrite_lines() take the size as an "int". For
a file of 2GiB or more it is truncated, typically to a negative value,
and both see no data: "git diff -B --stat" reports 0 changed lines, and
"git diff -B -p" prints "@@ -0,0 +0,0 @@" with no body, a patch that
"git apply" rejects, and still exits with 0.

Widening the size alone is not enough, as the "int" line counter in
count_lines() then overflows on a file of more than INT_MAX lines. Use
size_t for the sizes and line counts along the whole path, up to struct
emit_callback; struct diffstat_file already stores the counts in
uintmax_t. A single line longer than INT_MAX goes through
cast_size_t_to_int(), as emit_del_line() and emit_add_line() take an
"int" length.

count_trailing_blank() gets a size_t counter too: without it, a build
with "make SANITIZE=signed-integer-overflow" stops there on a rewrite
to 2200MiB of newlines. Its size was a "long", which on 64-bit Windows,
where "long" has 32 bits while size_t has 64, could move the pointer
before the start of the buffer.

To reproduce, with about 2.2GiB of working tree data:

	yes old | head -c 2200M >big &&
	git add big &&
	git commit -m old &&
	yes new | head -c 2200M >big &&
	git diff -B --stat

reports 0 insertions and 0 deletions before this patch, and 576716800
of each with it.

The two tests added to t4022, for a file of 2GiB and one of 2^31
lines, are marked EXPENSIVE, as they need several GiB of disk and take
minutes. They also require "long" to have 64 bits, as struct
diff_filespec still keeps the size in an "unsigned long".

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
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

