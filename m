Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3472EDD78
	for <git@vger.kernel.org>; Wed, 27 May 2026 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779855858; cv=none; b=jzHoQQ/CALTvH/W7S8PJpanskhw9Tsw/jIKgNu8adspSCmy42sYsG9OanXLvDxVUl0t6e9Zsl6d906njq1nSbEzxRLluF83FPXeZ+QiVZUV36HkBmm9wIPr4GKIrCE0oSUbcyel+1Uoa531uh3J1FyTxKzvEaiGzXGLJBN5B8pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779855858; c=relaxed/simple;
	bh=YofxgReP86DytKBmphkRAS6PFSXcAgg+hDP8s1VqwFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hvwc1oaQ7bdYIWWJfItRDZW+Qw8S9dlTpYcftz/iFGobjD7MYdkBnLDzC9xl3K2Jla/TTmpj07fl0E97dOiWEJihVhvYkXb+f2rZWXWHzRneRsA1+Ee5nsnr42zRjO9m2bWE6/IZS8UyXQhOKbm7MIdsSoUkoO6G+1CQwrCkvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/i7smBr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/i7smBr"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bd1dbccd13so14267925ad.1
        for <git@vger.kernel.org>; Tue, 26 May 2026 21:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779855855; x=1780460655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Jo8DDzIkTjxGBpKCyGHKIYAkKjrCLmPdpMpcZCz0KE=;
        b=L/i7smBrwfNcdGinQJLw2CefK1zORKOokrsIe8s/T/wCrvF8/aJu32QjcikC8sSdiP
         uYNhcZ99zS//5r23+df4X8p1JyCfAqwzhLfmHx5UQNiR5ues5I5aglANWd4gDZvzurA6
         mLaFHJtxhgnYT169bkfvNYX/tI3YjyKrjVFX8KwNtWj7XUEJTHsruak0o7hMLzjl0J5x
         Yxq0YFpJlKL9UUz8lcdm5tx9BsBk7UcWqR0kS6tMMIOxM2Hx+SvrjBsJ1XqcaKsHcx40
         5dR7mE26Yyi5p6DdAM5692C7eKGgS6+JFgAdXzLdyqTDuf/ND+CfOtUO91YilxbboZdh
         PhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779855855; x=1780460655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Jo8DDzIkTjxGBpKCyGHKIYAkKjrCLmPdpMpcZCz0KE=;
        b=rlW4HH1EwcrylkeUWfOSquFn4EZjEabDurZ0kxOcfHAPsDH8rA/KC6Um+ntVl0hVUV
         Ktd6BYQViE5x4SON/3OmJC0D+SmURkCv6jTJvsKwPSWI+clNeBVbjavO0wIqbDbVDY70
         wiO9TuNtwxVUuPco53RLGw7iCZYLISl5w1hY87561VxapKY6xP24yNfdteZGbC5VjsC7
         d3DKpGVMUmsz6juJgMbYF6QBinbSOzIdtgrRFXjRCGCGeqJVkHgfq/FbfBj/TxhVvTiJ
         EKaG24s2sfOaN+Xsg2lxSD5401XnR48mGIsuKMUjrwQH2TOaspo42r9yMUBX94E9JfxW
         W7/A==
X-Gm-Message-State: AOJu0YzQQOkzLYZlXJWRHVP6cQvw2JK13jHyBLCz7Ss+aB2GGAcWNTEC
	sicCowzAyAmQtXmw2/AvsAZab24nlof7GgjXCcIAkcTk12QMPnPWBoHT7HSABw==
X-Gm-Gg: Acq92OHAosyx7egJl8rNFLS+knWOFT1ZtGR+Uuk2NO90HdYWrPwrza1GFBYW28Bhxn1
	66y6TpjVUxQi0Qwfd/y706n2c3K7UeQMJ/sVm8GfITCqe56trjH4F9kwUqOEOdQR0+YfPJgfc/n
	LF/Ty4G0Pg7D/xP76MAM5QBbjO9wVOTg6G0epa7ldXAHUPo2UDcTAs7BBk2TGV22J75G6ZVscoX
	u7Sib/pngwlcAz0slqHOnuCnpQ0d47XQSg17VgPNK/HlYbQw4+4u5WRIuj0h0xkPYn7+9J/OGl6
	cj/APooZKDvaC17lc0kX1sgWnlQEulctOm4t5NLqKvXbcw2zC5yej1TkQ6Y0f0IyDjMBuhCkUAb
	BCDpM6AhHPy7qKOvQpZOE6w5NvphwHFRciR/pNkEYEypdzeYXfhyNQxGKTxqBflc3hmZxRsDwQ9
	/8xjuDX4t+5PtO4oWK/DNBe9Q6nFpL0Xdgo/jaAKXNauqsixQ2wd1kVGqv/veTV90b+uYCArinV
	ybm3pBMgTgxWdYb7SspAhrkvV7u
X-Received: by 2002:a17:903:320d:b0:2bd:5b20:a5dd with SMTP id d9443c01a7336-2beb065bb2bmr129713295ad.1.1779855855038;
        Tue, 26 May 2026 21:24:15 -0700 (PDT)
Received: from localhost.localdomain (122x211x77x66.ap122.ftth.ucom.ne.jp. [122.211.77.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9fe9sm135625495ad.65.2026.05.26.21.24.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 21:24:14 -0700 (PDT)
From: Keita Oda <ainsophyao@gmail.com>
To: git@vger.kernel.org
Cc: Keita ODA <ainsophyao@gmail.com>
Subject: [RFC PATCH 1/3] diff: add word-diff-align line pairing
Date: Wed, 27 May 2026 13:24:00 +0900
Message-Id: <20260527042402.13607-2-ainsophyao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260527042402.13607-1-ainsophyao@gmail.com>
References: <20260527042402.13607-1-ainsophyao@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keita ODA <ainsophyao@gmail.com>

Add an opt-in --word-diff-align mode that post-processes emitted diff
symbols and tries to pair similar deleted and inserted lines inside each hunk.

This is not a replacement for the diff algorithm.  The normal diff is produced
first; the new code only annotates the already-emitted symbols for review.

The candidate search is intentionally approximate.  Each line is tokenized into
word-ish runs and single non-space symbols.  Each token gets a hash, each line
gets a compact 64-bit fingerprint, and each changed line also gets a small
surrounding window fingerprint.  Inserted-side windows are placed into bit
buckets, and deleted-side windows query those buckets to avoid a full all-pairs
scan in typical cases.

The fingerprint is only a retrieval index.  Candidate pairs are scored again
using token hashes:

  W = unique token overlap in the small surrounding windows
  L = center-line token LCS score
  S = W + 4L

For the center-line score, tokens repeated in the surrounding window carry less
weight.  This is a local-IDF-like approximation: in a run of "import" or
"#define" lines, the repeated keyword is weak evidence, while the identifier
specific to the center line remains strong evidence.

For this RFC, selected pairs are exposed with a debug-style "# aligned ..."
comment.  The next patch adds a small renderer to make the selected pairs more
readable.

---
 diff.c | 809 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 diff.h |   1 +
 2 files changed, 802 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 397e38b41..6b8744920 100644
--- a/diff.c
+++ b/diff.c
@@ -46,6 +46,7 @@
 #include "setup.h"
 #include "strmap.h"
 #include "ws.h"
+#include "ewah/ewok.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -1358,6 +1359,774 @@ static void dim_moved_lines(struct diff_options *o)
 	}
 }
 
+struct word_diff_align_line_info {
+	uint64_t bits;
+	int token_start;
+	int token_nr;
+};
+
+struct word_diff_align_item {
+	int symbol;
+	int change_pos;
+	int line_no;
+};
+
+struct word_diff_align_candidate {
+	int old_pos;
+	int new_pos;
+	int score;
+	int window_score;
+	int window_shared;
+	int line_score;
+	int line_shared;
+};
+
+#define WORD_DIFF_ALIGN_NUMBER_HASH 0x9e3779b9U
+
+#define WORD_DIFF_ALIGN_WINDOW_SIZE 2
+#define WORD_DIFF_ALIGN_FINGERPRINT_BITS 64
+#define WORD_DIFF_ALIGN_BIT_BUCKET_MAX 256
+#define WORD_DIFF_ALIGN_WINDOW_MIN_SCORE 35
+#define WORD_DIFF_ALIGN_WINDOW_MIN_SHARED 4
+#define WORD_DIFF_ALIGN_LINE_WEIGHT 4
+#define WORD_DIFF_ALIGN_SCORE_MIN 175
+
+static void word_diff_align_window_bounds(int nr, int pos,
+					  int *start_p, int *end_p)
+{
+	int radius = WORD_DIFF_ALIGN_WINDOW_SIZE;
+
+	*start_p = pos > radius ? pos - radius : 0;
+	*end_p = pos + radius + 1 < nr ? pos + radius + 1 : nr;
+}
+
+static int word_diff_align_payload_len(const struct emitted_diff_symbol *e)
+{
+	int len = e->len;
+
+	if (len && e->line[len - 1] == '\n')
+		len--;
+	if (len && e->line[len - 1] == '\r')
+		len--;
+	return len;
+}
+
+static int word_diff_align_word_byte(char ch)
+{
+	return isalnum((unsigned char)ch) || ch == '_';
+}
+
+static int word_diff_align_numeric_token(const char *line, int start, int end)
+{
+	int i;
+
+	for (i = start; i < end; i++)
+		if (!isdigit((unsigned char)line[i]))
+			return 0;
+	return start < end;
+}
+
+static uint64_t word_diff_align_token_bits(unsigned int hash)
+{
+	return (1ULL << (hash & 63)) | (1ULL << ((hash >> 6) & 63));
+}
+
+static int word_diff_align_next_token(const char *line, int len, int *pos,
+				      int *start_p, int *end_p)
+{
+	while (*pos < len && isspace((unsigned char)line[*pos]))
+		(*pos)++;
+	if (*pos == len)
+		return 0;
+
+	*start_p = *pos;
+	if (word_diff_align_word_byte(line[*pos]))
+		while (*pos < len && word_diff_align_word_byte(line[*pos]))
+			(*pos)++;
+	else
+		(*pos)++;
+	*end_p = *pos;
+	return 1;
+}
+
+static void word_diff_align_prepare_line(const struct emitted_diff_symbol *e,
+					 struct word_diff_align_line_info *line,
+					 unsigned int **tokens,
+					 int *tokens_nr,
+					 int *tokens_alloc)
+{
+	int len = word_diff_align_payload_len(e);
+	int pos = 0;
+	int start, end;
+
+	line->bits = 0;
+	line->token_start = *tokens_nr;
+	while (word_diff_align_next_token(e->line, len, &pos, &start, &end)) {
+		int numeric = word_diff_align_numeric_token(e->line, start, end);
+		unsigned int hash = numeric ? WORD_DIFF_ALIGN_NUMBER_HASH :
+			memhash(e->line + start, end - start);
+
+		ALLOC_GROW(*tokens, *tokens_nr + 1, *tokens_alloc);
+		(*tokens)[*tokens_nr] = hash;
+		line->bits |= word_diff_align_token_bits(hash);
+		(*tokens_nr)++;
+	}
+	line->token_nr = *tokens_nr - line->token_start;
+}
+
+static uint64_t word_diff_align_window_bits(struct word_diff_align_line_info *lines,
+					    int nr, int pos)
+{
+	uint64_t bits = 0;
+	int start, end;
+	int i;
+
+	word_diff_align_window_bounds(nr, pos, &start, &end);
+	for (i = start; i < end; i++)
+		bits |= lines[i].bits;
+	return bits;
+}
+
+static int word_diff_align_filter_score(uint64_t a, uint64_t b, int *shared_p)
+{
+	int shared = ewah_bit_popcount64(a & b);
+	int total = ewah_bit_popcount64(a | b);
+
+	*shared_p = shared;
+	return total ? shared * 100 / total : 0;
+}
+
+static int word_diff_align_line_has_token(const struct word_diff_align_line_info *line,
+					  const unsigned int *tokens,
+					  unsigned int hash);
+
+static int word_diff_align_window_has_token(const struct word_diff_align_line_info *lines,
+					    int start, int end,
+					    const unsigned int *tokens,
+					    unsigned int hash)
+{
+	int i;
+
+	for (i = start; i < end; i++)
+		if (word_diff_align_line_has_token(&lines[i], tokens, hash))
+			return 1;
+	return 0;
+}
+
+static int word_diff_align_window_seen_token(const struct word_diff_align_line_info *lines,
+					     int start, int line_pos,
+					     int token_pos,
+					     const unsigned int *tokens,
+					     unsigned int hash)
+{
+	int i;
+
+	for (i = start; i <= line_pos; i++) {
+		const struct word_diff_align_line_info *line = &lines[i];
+		int end = i == line_pos ? token_pos : line->token_nr;
+		int j;
+
+		for (j = 0; j < end; j++)
+			if (tokens[line->token_start + j] == hash)
+				return 1;
+	}
+	return 0;
+}
+
+static int word_diff_align_window_token_score(const struct word_diff_align_line_info *minus_lines,
+					      int minus_nr, int minus_pos,
+					      const unsigned int *minus_tokens,
+					      const struct word_diff_align_line_info *plus_lines,
+					      int plus_nr, int plus_pos,
+					      const unsigned int *plus_tokens,
+					      int *shared_p)
+{
+	int minus_start, minus_end, plus_start, plus_end;
+	int minus_unique = 0, plus_unique = 0, shared = 0;
+	int i;
+
+	word_diff_align_window_bounds(minus_nr, minus_pos, &minus_start,
+				      &minus_end);
+	word_diff_align_window_bounds(plus_nr, plus_pos, &plus_start,
+				      &plus_end);
+
+	for (i = minus_start; i < minus_end; i++) {
+		const struct word_diff_align_line_info *line = &minus_lines[i];
+		int j;
+
+		for (j = 0; j < line->token_nr; j++) {
+			unsigned int hash = minus_tokens[line->token_start + j];
+
+			if (word_diff_align_window_seen_token(minus_lines,
+							      minus_start, i, j,
+							      minus_tokens,
+							      hash))
+				continue;
+			minus_unique++;
+			if (word_diff_align_window_has_token(plus_lines,
+							     plus_start, plus_end,
+							     plus_tokens, hash))
+				shared++;
+		}
+	}
+
+	for (i = plus_start; i < plus_end; i++) {
+		const struct word_diff_align_line_info *line = &plus_lines[i];
+		int j;
+
+		for (j = 0; j < line->token_nr; j++) {
+			unsigned int hash = plus_tokens[line->token_start + j];
+
+			if (word_diff_align_window_seen_token(plus_lines,
+							      plus_start, i, j,
+							      plus_tokens,
+							      hash))
+				continue;
+			plus_unique++;
+		}
+	}
+
+	*shared_p = shared;
+	return minus_unique + plus_unique - shared ?
+		shared * 100 / (minus_unique + plus_unique - shared) : 0;
+}
+
+static int word_diff_align_line_has_token(const struct word_diff_align_line_info *line,
+					  const unsigned int *tokens,
+					  unsigned int hash)
+{
+	int i;
+
+	for (i = 0; i < line->token_nr; i++)
+		if (tokens[line->token_start + i] == hash)
+			return 1;
+	return 0;
+}
+
+static int word_diff_align_surrounding_line_freq(const struct word_diff_align_line_info *lines,
+						 int nr, int pos,
+						 const unsigned int *tokens,
+						 unsigned int hash)
+{
+	int radius = WORD_DIFF_ALIGN_WINDOW_SIZE;
+	int start = pos > radius ? pos - radius : 0;
+	int end = pos + radius + 1 < nr ? pos + radius + 1 : nr;
+	int i, freq = 0;
+
+	for (i = start; i < end; i++) {
+		if (i == pos)
+			continue;
+		if (word_diff_align_line_has_token(&lines[i], tokens, hash))
+			freq++;
+	}
+	return freq;
+}
+
+static int word_diff_align_shared_token_value(const struct word_diff_align_line_info *minus_lines,
+					      int minus_nr, int minus_pos,
+					      const unsigned int *minus_tokens,
+					      const struct word_diff_align_line_info *plus_lines,
+					      int plus_nr, int plus_pos,
+					      const unsigned int *plus_tokens,
+					      unsigned int hash)
+{
+	int minus_freq = word_diff_align_surrounding_line_freq(minus_lines,
+							       minus_nr,
+							       minus_pos,
+							       minus_tokens,
+							       hash);
+	int plus_freq = word_diff_align_surrounding_line_freq(plus_lines,
+							      plus_nr,
+							      plus_pos,
+							      plus_tokens,
+							      hash);
+	int freq = minus_freq > plus_freq ? minus_freq : plus_freq;
+	int value = 2 * WORD_DIFF_ALIGN_WINDOW_SIZE - freq;
+
+	return value > 0 ? value : 0;
+}
+
+static int word_diff_align_unmatched_weight(const struct word_diff_align_line_info *line,
+					    const unsigned int *tokens,
+					    const unsigned int *other_tokens,
+					    int other_start, int other_nr)
+{
+	int i, weight = 0;
+
+	for (i = 0; i < line->token_nr; i++) {
+		unsigned int hash = tokens[line->token_start + i];
+		int j, matched = 0;
+
+		for (j = 0; j < other_nr; j++) {
+			if (hash == other_tokens[other_start + j]) {
+				matched = 1;
+				break;
+			}
+		}
+		if (!matched)
+			weight++;
+	}
+	return weight;
+}
+
+static int word_diff_align_line_token_score(const struct word_diff_align_line_info *minus,
+					    const struct word_diff_align_line_info *minus_lines,
+					    int minus_nr, int minus_pos,
+					    const unsigned int *minus_tokens,
+					    const struct word_diff_align_line_info *plus,
+					    const struct word_diff_align_line_info *plus_lines,
+					    int plus_nr, int plus_pos,
+					    const unsigned int *plus_tokens,
+					    int *shared_p)
+{
+	int i, j, shared;
+	int *lcs;
+	int unmatched, total;
+
+	if (!minus->token_nr || !plus->token_nr) {
+		*shared_p = 0;
+		return 0;
+	}
+
+	CALLOC_ARRAY(lcs, plus->token_nr + 1);
+	for (i = 0; i < minus->token_nr; i++) {
+		unsigned int minus_hash = minus_tokens[minus->token_start + i];
+		int prev = 0;
+
+		for (j = 0; j < plus->token_nr; j++) {
+			unsigned int plus_hash = plus_tokens[plus->token_start + j];
+			int column = j + 1;
+			int saved;
+
+			saved = lcs[column];
+			if (minus_hash == plus_hash) {
+				int value = word_diff_align_shared_token_value(minus_lines,
+									       minus_nr,
+									       minus_pos,
+									       minus_tokens,
+									       plus_lines,
+									       plus_nr,
+									       plus_pos,
+									       plus_tokens,
+									       minus_hash);
+				int best = prev + value;
+
+				if (lcs[column] > best)
+					best = lcs[column];
+				if (lcs[column - 1] > best)
+					best = lcs[column - 1];
+				lcs[column] = best;
+			}
+			else if (lcs[column - 1] > lcs[column])
+				lcs[column] = lcs[column - 1];
+			prev = saved;
+		}
+	}
+
+	shared = lcs[plus->token_nr];
+	free(lcs);
+	unmatched = word_diff_align_unmatched_weight(minus, minus_tokens,
+						     plus_tokens,
+						     plus->token_start,
+						     plus->token_nr) +
+		word_diff_align_unmatched_weight(plus, plus_tokens,
+						 minus_tokens,
+						 minus->token_start,
+						 minus->token_nr);
+	total = 2 * shared + unmatched;
+	*shared_p = shared;
+	return total ? shared * 200 / total : 0;
+}
+
+static int word_diff_align_pair_score(int window_score,
+				      const struct word_diff_align_line_info *minus,
+				      const struct word_diff_align_line_info *minus_lines,
+				      int minus_nr, int minus_pos,
+				      const unsigned int *minus_tokens,
+				      const struct word_diff_align_line_info *plus,
+				      const struct word_diff_align_line_info *plus_lines,
+				      int plus_nr, int plus_pos,
+				      const unsigned int *plus_tokens,
+				      int *line_score_p,
+				      int *line_shared_p)
+{
+	int line_score, line_shared;
+
+	line_score = word_diff_align_line_token_score(minus, minus_lines,
+						      minus_nr, minus_pos,
+						      minus_tokens,
+						      plus, plus_lines,
+						      plus_nr, plus_pos,
+						      plus_tokens, &line_shared);
+	*line_score_p = line_score;
+	*line_shared_p = line_shared;
+
+	/*
+	 * The bit fingerprint is only a retrieval approximation.  The window
+	 * score passed here is computed from exact token hashes in the 5-line
+	 * windows, while the line score gives the center line an additional
+	 * identity bonus.
+	 */
+	return window_score + WORD_DIFF_ALIGN_LINE_WEIGHT * line_score;
+}
+
+static int word_diff_align_candidate_cmp(const void *va, const void *vb)
+{
+	const struct word_diff_align_candidate *a = va;
+	const struct word_diff_align_candidate *b = vb;
+
+	if (a->score != b->score)
+		return b->score - a->score;
+	if (a->line_score != b->line_score)
+		return b->line_score - a->line_score;
+	if (a->window_score != b->window_score)
+		return b->window_score - a->window_score;
+	if (a->line_shared != b->line_shared)
+		return b->line_shared - a->line_shared;
+	if (a->window_shared != b->window_shared)
+		return b->window_shared - a->window_shared;
+	if (a->old_pos != b->old_pos)
+		return a->old_pos - b->old_pos;
+	return a->new_pos - b->new_pos;
+}
+
+static void word_diff_align_add_candidate(struct word_diff_align_candidate **candidates,
+					  int *candidates_nr,
+					  int *candidates_alloc,
+					  int old_pos, int new_pos,
+					  int score, int window_score,
+					  int window_shared, int line_score,
+					  int line_shared)
+{
+	struct word_diff_align_candidate *candidate;
+
+	ALLOC_GROW(*candidates, *candidates_nr + 1, *candidates_alloc);
+	candidate = &(*candidates)[(*candidates_nr)++];
+	candidate->old_pos = old_pos;
+	candidate->new_pos = new_pos;
+	candidate->score = score;
+	candidate->window_score = window_score;
+	candidate->window_shared = window_shared;
+	candidate->line_score = line_score;
+	candidate->line_shared = line_shared;
+}
+
+static void word_diff_align_debug_append_comment(struct emitted_diff_symbol *line,
+						 const struct strbuf *suffix)
+{
+	struct strbuf out = STRBUF_INIT;
+	char *old_line = (char *)line->line;
+	size_t new_len;
+
+	if (line->len && line->line[line->len - 1] == '\n') {
+		strbuf_add(&out, line->line, line->len - 1);
+		strbuf_addbuf(&out, suffix);
+		strbuf_addch(&out, '\n');
+	} else {
+		strbuf_add(&out, line->line, line->len);
+		strbuf_addbuf(&out, suffix);
+	}
+	line->line = strbuf_detach(&out, &new_len);
+	line->len = (int)new_len;
+	free(old_line);
+}
+
+static void word_diff_align_debug_mark_pair(struct emitted_diff_symbol *minus_line,
+					    struct emitted_diff_symbol *plus_line,
+					    int minus_lineno, int plus_lineno,
+					    int changed, int moved,
+						    int window_score,
+						    int line_score,
+						    int pair_score)
+{
+	struct strbuf suffix = STRBUF_INIT;
+
+	if (moved) {
+		minus_line->flags |= DIFF_SYMBOL_MOVED_LINE;
+		plus_line->flags |= DIFF_SYMBOL_MOVED_LINE;
+	}
+
+	strbuf_addf(&suffix,
+		    "        # aligned from %d to %d, %s, W=%d L=%d S=%d",
+		    minus_lineno, plus_lineno,
+		    changed ? "edited" : "unchanged",
+		    window_score, line_score, pair_score);
+	word_diff_align_debug_append_comment(minus_line, &suffix);
+	word_diff_align_debug_append_comment(plus_line, &suffix);
+	strbuf_release(&suffix);
+}
+
+static void word_diff_align_add_item(struct word_diff_align_item **items,
+				     int *items_nr, int *items_alloc,
+				     int symbol, int change_pos, int line_no)
+{
+	ALLOC_GROW(*items, *items_nr + 1, *items_alloc);
+	(*items)[*items_nr].symbol = symbol;
+	(*items)[*items_nr].change_pos = change_pos;
+	(*items)[*items_nr].line_no = line_no;
+	(*items_nr)++;
+}
+
+static void word_diff_align_hunk_start(const struct emitted_diff_symbols *e,
+				       int start, int *old_lineno,
+				       int *new_lineno)
+{
+	const char *line;
+	char *endp;
+
+	*old_lineno = 0;
+	*new_lineno = 0;
+	if (start <= 0 || e->buf[start - 1].s != DIFF_SYMBOL_CONTEXT_FRAGINFO)
+		return;
+	line = e->buf[start - 1].line;
+	if (!starts_with(line, "@@ -"))
+		return;
+	line += 4;
+	if (!isdigit((unsigned char)*line))
+		return;
+	*old_lineno = strtol(line, &endp, 10);
+	line = endp;
+	if (*line == ',') {
+		line++;
+		strtol(line, &endp, 10);
+		line = endp;
+	}
+	if (!starts_with(line, " +"))
+		return;
+	line += 2;
+	if (!isdigit((unsigned char)*line))
+		return;
+	*new_lineno = strtol(line, &endp, 10);
+}
+
+static int word_diff_align_local_pair(int old_pos, int new_pos)
+{
+	return old_pos == new_pos;
+}
+
+static void word_diff_align_hunk(struct emitted_diff_symbols *e, int start, int end)
+{
+	struct word_diff_align_item *old_items = NULL, *new_items = NULL;
+	int old_items_nr = 0, old_items_alloc = 0;
+	int new_items_nr = 0, new_items_alloc = 0;
+	int minus_nr = 0, plus_nr = 0;
+	struct word_diff_align_line_info *old_lines = NULL, *new_lines = NULL;
+	unsigned int *old_tokens = NULL, *new_tokens = NULL;
+	int old_tokens_nr = 0, old_tokens_alloc = 0;
+	int new_tokens_nr = 0, new_tokens_alloc = 0;
+	uint64_t *new_contexts = NULL;
+	int *bucket_heads = NULL, *bucket_next = NULL, *bucket_counts = NULL;
+	int *candidate_counts = NULL, *candidate_touched = NULL;
+	char *used_old = NULL, *used_plus = NULL;
+	struct word_diff_align_candidate *candidates = NULL;
+	int candidates_nr = 0, candidates_alloc = 0;
+	int old_lineno, new_lineno;
+	int i, j;
+
+	word_diff_align_hunk_start(e, start, &old_lineno, &new_lineno);
+	for (i = start; i < end; i++) {
+		if (e->buf[i].s == DIFF_SYMBOL_MINUS) {
+			word_diff_align_add_item(&old_items, &old_items_nr,
+						 &old_items_alloc, i, minus_nr++,
+						 old_lineno++);
+		} else if (e->buf[i].s == DIFF_SYMBOL_PLUS) {
+			word_diff_align_add_item(&new_items, &new_items_nr,
+						 &new_items_alloc, i, plus_nr++,
+						 new_lineno++);
+		} else if (e->buf[i].s == DIFF_SYMBOL_CONTEXT) {
+			word_diff_align_add_item(&old_items, &old_items_nr,
+						 &old_items_alloc, i, -1,
+						 old_lineno++);
+			word_diff_align_add_item(&new_items, &new_items_nr,
+						 &new_items_alloc, i, -1,
+						 new_lineno++);
+		}
+	}
+
+	if (!minus_nr || !plus_nr)
+		goto cleanup;
+
+	CALLOC_ARRAY(old_lines, old_items_nr);
+	CALLOC_ARRAY(new_lines, new_items_nr);
+	CALLOC_ARRAY(new_contexts, new_items_nr);
+	CALLOC_ARRAY(bucket_heads, WORD_DIFF_ALIGN_FINGERPRINT_BITS);
+	CALLOC_ARRAY(bucket_counts, WORD_DIFF_ALIGN_FINGERPRINT_BITS);
+	CALLOC_ARRAY(bucket_next, new_items_nr * WORD_DIFF_ALIGN_FINGERPRINT_BITS);
+	CALLOC_ARRAY(candidate_counts, new_items_nr);
+	CALLOC_ARRAY(candidate_touched, new_items_nr);
+	CALLOC_ARRAY(used_old, minus_nr);
+	CALLOC_ARRAY(used_plus, plus_nr);
+
+	for (i = 0; i < old_items_nr; i++)
+		word_diff_align_prepare_line(&e->buf[old_items[i].symbol], &old_lines[i],
+					     &old_tokens, &old_tokens_nr,
+					     &old_tokens_alloc);
+	for (i = 0; i < new_items_nr; i++)
+		word_diff_align_prepare_line(&e->buf[new_items[i].symbol], &new_lines[i],
+					     &new_tokens, &new_tokens_nr,
+					     &new_tokens_alloc);
+	for (i = 0; i < new_items_nr; i++)
+		new_contexts[i] = word_diff_align_window_bits(new_lines, new_items_nr, i);
+
+	for (i = 0; i < new_items_nr; i++) {
+		if (new_items[i].change_pos < 0)
+			continue;
+		for (j = 0; j < WORD_DIFF_ALIGN_FINGERPRINT_BITS; j++) {
+			uint64_t bit = 1ULL << j;
+
+			if (!(new_contexts[i] & bit))
+				continue;
+			bucket_counts[j]++;
+			bucket_next[i * WORD_DIFF_ALIGN_FINGERPRINT_BITS + j] = bucket_heads[j];
+			bucket_heads[j] = i + 1;
+		}
+	}
+
+	for (i = 0; i < old_items_nr; i++) {
+		int touched_nr = 0;
+		uint64_t old_context;
+
+		if (old_items[i].change_pos < 0)
+			continue;
+		old_context = word_diff_align_window_bits(old_lines, old_items_nr, i);
+		for (j = 0; j < WORD_DIFF_ALIGN_FINGERPRINT_BITS; j++) {
+			uint64_t bit = 1ULL << j;
+			int item;
+
+			if (!(old_context & bit))
+				continue;
+			if (bucket_counts[j] > WORD_DIFF_ALIGN_BIT_BUCKET_MAX)
+				continue;
+			for (item = bucket_heads[j]; item; item = bucket_next[(item - 1) * WORD_DIFF_ALIGN_FINGERPRINT_BITS + j]) {
+				int new_pos = item - 1;
+
+				if (!candidate_counts[new_pos])
+					candidate_touched[touched_nr++] = new_pos;
+				candidate_counts[new_pos]++;
+			}
+		}
+
+		for (j = 0; j < touched_nr; j++) {
+			int new_pos = candidate_touched[j];
+			int filter_score, filter_shared;
+			int window_score, window_shared;
+			int line_score, line_shared, pair_score;
+
+			candidate_counts[new_pos] = 0;
+			if (new_items[new_pos].change_pos < 0)
+				continue;
+			filter_score = word_diff_align_filter_score(old_context,
+								    new_contexts[new_pos],
+								    &filter_shared);
+			if (filter_score < WORD_DIFF_ALIGN_WINDOW_MIN_SCORE ||
+			    filter_shared < WORD_DIFF_ALIGN_WINDOW_MIN_SHARED)
+				continue;
+			window_score = word_diff_align_window_token_score(old_lines,
+									 old_items_nr,
+									 i,
+									 old_tokens,
+									 new_lines,
+									 new_items_nr,
+									 new_pos,
+									 new_tokens,
+									 &window_shared);
+			if (window_score < WORD_DIFF_ALIGN_WINDOW_MIN_SCORE)
+				continue;
+			pair_score = word_diff_align_pair_score(window_score,
+								&old_lines[i],
+								old_lines,
+								old_items_nr,
+								i,
+								old_tokens,
+								&new_lines[new_pos],
+								new_lines,
+								new_items_nr,
+								new_pos,
+								new_tokens,
+								&line_score,
+								&line_shared);
+			if (pair_score < WORD_DIFF_ALIGN_SCORE_MIN)
+				continue;
+			word_diff_align_add_candidate(&candidates, &candidates_nr,
+						      &candidates_alloc, i, new_pos,
+						      pair_score, window_score,
+						      window_shared, line_score,
+						      line_shared);
+		}
+	}
+
+	QSORT(candidates, candidates_nr, word_diff_align_candidate_cmp);
+	for (i = 0; i < candidates_nr; i++) {
+		int old_pos = candidates[i].old_pos;
+		int new_pos = candidates[i].new_pos;
+		int minus_pos = old_items[old_pos].change_pos;
+		int plus_pos = new_items[new_pos].change_pos;
+		int old_len, new_len, edited, moved;
+
+		if (used_old[minus_pos] || used_plus[plus_pos])
+			continue;
+		used_old[minus_pos] = 1;
+		used_plus[plus_pos] = 1;
+		old_len = word_diff_align_payload_len(&e->buf[old_items[old_pos].symbol]);
+		new_len = word_diff_align_payload_len(&e->buf[new_items[new_pos].symbol]);
+		edited = old_len != new_len ||
+			memcmp(e->buf[old_items[old_pos].symbol].line,
+			       e->buf[new_items[new_pos].symbol].line,
+			       old_len);
+		moved = !word_diff_align_local_pair(old_pos, new_pos);
+		word_diff_align_debug_mark_pair(&e->buf[old_items[old_pos].symbol],
+						&e->buf[new_items[new_pos].symbol],
+						old_items[old_pos].line_no,
+						new_items[new_pos].line_no,
+						edited, moved,
+						candidates[i].window_score,
+						candidates[i].line_score,
+						candidates[i].score);
+	}
+
+cleanup:
+	free(old_items);
+	free(new_items);
+	free(old_lines);
+	free(new_lines);
+	free(old_tokens);
+	free(new_tokens);
+	free(new_contexts);
+	free(bucket_heads);
+	free(bucket_next);
+	free(bucket_counts);
+	free(candidate_counts);
+	free(candidate_touched);
+	free(used_old);
+	free(used_plus);
+	free(candidates);
+}
+
+static void mark_word_diff_align(struct diff_options *o)
+{
+	int i, hunk_start = -1;
+	struct emitted_diff_symbols *e = o->emitted_symbols;
+
+	for (i = 0; i < e->nr; i++) {
+		if (e->buf[i].s == DIFF_SYMBOL_CONTEXT_FRAGINFO) {
+			if (hunk_start >= 0)
+				word_diff_align_hunk(e, hunk_start, i);
+			hunk_start = i + 1;
+		} else if (hunk_start >= 0 &&
+			   e->buf[i].s != DIFF_SYMBOL_CONTEXT &&
+			   e->buf[i].s != DIFF_SYMBOL_CONTEXT_INCOMPLETE &&
+			   e->buf[i].s != DIFF_SYMBOL_CONTEXT_MARKER &&
+			   e->buf[i].s != DIFF_SYMBOL_PLUS &&
+			   e->buf[i].s != DIFF_SYMBOL_MINUS) {
+			word_diff_align_hunk(e, hunk_start, i);
+			hunk_start = -1;
+		}
+	}
+
+	if (hunk_start >= 0)
+		word_diff_align_hunk(e, hunk_start, e->nr);
+}
+
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set_sign, const char *set,
 				const char *reset,
@@ -5245,6 +6014,10 @@ void diff_setup_done(struct diff_options *options)
 		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s' and '%s'"),
 			"--pickaxe-all", "--find-object", "--pickaxe-all", "-G", "-S");
 
+	if (options->word_diff_align && options->word_diff)
+		die(_("options '%s' and '%s' cannot be used together"),
+		    "--word-diff-align", "--word-diff");
+
 	/*
 	 * Most of the time we can say "there are changes"
 	 * only by checking if there are changed paths, but
@@ -5971,6 +6744,18 @@ static int diff_opt_word_diff_regex(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_word_diff_align(const struct option *opt,
+				    const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	options->word_diff_align = !unset;
+	if (!unset)
+		enable_patch_output(&options->output_format);
+	return 0;
+}
+
 static int diff_opt_rotate_to(const struct option *opt, const char *arg, int unset)
 {
 	struct diff_options *options = opt->value;
@@ -6205,6 +6990,9 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_CALLBACK_F(0, "word-diff-regex", options, N_("<regex>"),
 			       N_("use <regex> to decide what a word is"),
 			       PARSE_OPT_NONEG, diff_opt_word_diff_regex),
+		OPT_CALLBACK_F(0, "word-diff-align", options, NULL,
+			       N_("annotate similar moved lines"),
+			       PARSE_OPT_NOARG, diff_opt_word_diff_align),
 		OPT_CALLBACK_F(0, "color-words", options, N_("<regex>"),
 			       N_("equivalent to --word-diff=color --word-diff-regex=<regex>"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_color_words),
@@ -7076,7 +7864,7 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	if (WSEH_NEW & WS_RULE_MASK)
 		BUG("WS rules bit mask overlaps with diff symbol flags");
 
-	if (o->color_moved && want_color(o->use_color))
+	if ((o->color_moved && want_color(o->use_color)) || o->word_diff_align)
 		o->emitted_symbols = &esm;
 
 	if (o->additional_path_headers)
@@ -7092,14 +7880,19 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 		struct mem_pool entry_pool;
 		struct moved_entry_list *entry_list;
 
-		mem_pool_init(&entry_pool, 1024 * 1024);
-		entry_list = add_lines_to_move_detection(o, &entry_pool);
-		mark_color_as_moved(o, entry_list);
-		if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
-			dim_moved_lines(o);
+		if (o->word_diff_align)
+			mark_word_diff_align(o);
+
+		if (o->color_moved && want_color(o->use_color)) {
+			mem_pool_init(&entry_pool, 1024 * 1024);
+			entry_list = add_lines_to_move_detection(o, &entry_pool);
+			mark_color_as_moved(o, entry_list);
+			if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
+				dim_moved_lines(o);
 
-		mem_pool_discard(&entry_pool, 0);
-		free(entry_list);
+			mem_pool_discard(&entry_pool, 0);
+			free(entry_list);
+		}
 
 		for (i = 0; i < esm.nr; i++)
 			emit_diff_symbol_from_struct(o, &esm.buf[i]);
diff --git a/diff.h b/diff.h
index 7eb84aadf..b9a20b7f2 100644
--- a/diff.h
+++ b/diff.h
@@ -351,6 +351,7 @@ struct diff_options {
 	int stat_count;
 	const char *word_regex;
 	enum diff_words_type word_diff;
+	int word_diff_align;
 	enum diff_submodule_format submodule_format;
 
 	struct oidset *objfind;
-- 
2.39.3 (Apple Git-146)
