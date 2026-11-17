Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794911893;
	b=au5fhUqg6oIq0ID1haSDicaR5AY91n05YLspQGJBqmHFWfYm7OsLCA9H7dwzu5Obrhk8
	 /2wl1k0sqJfrC6u+snWxskbFEQzz17P3w+Dc/y/ywzGUpsKA20Cjgn7m1wpbzYJoWUL9j
	 oPp72sCZ+4sWmzCS90lEE4Jjhkyw0ZHH50d8Xpf2XXlyDRJeEsHvxyJJZgMNqQWm5Qb8P
	 1ScS1EYwjIL2cbxLKktZekQ9pJNJ8D16ZNoDe4oxbf7DX+TSemjloxrqKfBguoRx0y0Gu
	 RDkJBms5PfUv/Fhl+heRZ+0LmJaKoXz42jPTIudvy6txYvGbYnyCirGhI4i7tamejZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794911893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9/1GCIwOY9qNSGYwMgZd4kylvp9x78s/ohbUn5D7XOY=;
	b=GnaLsXiArbqWjX5e21S4xyQjugEAtiDonhMs5wv9ceP4jDf3Rd9eHbss231Nja2yInbW
	 lsB33ZU3YmjAzS4yhLZZ54+JeHQVWLL4nBmkhOy5fvAxW4bOjdnak7nOrV4j1NR6ln6vb
	 bCKPytpVxXb52njCsLWImzA2sZlp4lgb/oEiIXGoX12leImwDtJUJgBYK3T6y6tKjxw+d
	 iKO/H+TBnB/EnzXq+iHZVKPrGmWJVxTyZO/nQvzGPfZ6grg9n+mkiG5Uzf8amuPV8ztym
	 6VYNnPg5HNyT/EeLDmd5flzYWUzo/QglHMpc2fjxTviMYm4hVhcVNiXY9cOf69O1/6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kWvIPodR;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBB7606A32A
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 10:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DBB7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kWvIPodR
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-490d59c3edaso516012f8f.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 02:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794911890; x=1795516690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9/1GCIwOY9qNSGYwMgZd4kylvp9x78s/ohbUn5D7XOY=;
        b=kWvIPodRuJBxVlkcf+tK3CIVocCkyU8acqyfl/1fT03lpwuulQf7fE5pWLfT8u/wB6
         OM4f65UWhzukBol5jXaQm01mOjHMBp0lpjQga5BA0nKdzRTidF17Vod1Jr0Fx9X/UdiH
         NSSGdyFa8xoX3Vp+4Qruq4onGj+lm9Avm5cZYyS0ODUabNFSZ5p3FsgblcWdfCoUD0aL
         WLFI/3UveFHJxB3zlZkPWBZwp5zqEZ7HPbk/woHzIyPG1QSPwDVwOWeukyxYvvhZQEOR
         7Vwxc2gy5HY8H5a4UcSDnfzea7sScKn6K8Hs7Tsx7RDw9MW4lPDrLgm59DX1VjkdrdNH
         YO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794911890; x=1795516690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9/1GCIwOY9qNSGYwMgZd4kylvp9x78s/ohbUn5D7XOY=;
        b=ERT+4GdAuPm4M4MunUQ3nu4Fd9lvcoWr0knfB/acgwjEr7ltxCaun0XST5GIjrBFjU
         rAZL+AC7qqPGencuuPMS7q9tI+ffb6hcUQ4nZERmv/mSgThvLhIsw+I9uOzFZ7KW7SFF
         dXVSyUySUYYBP9JcE4M5QQA6Sn+Vb6CmMbu/FxxaXoGdgCuZQoXKwKNWCZzPAxFp0I+P
         Agph2d77/ljbNenXPz4nUcUzbh/yjUizbsU7jwZ17HZru3BeU/ytEeekA++sJya9i7nM
         Jmw+bdtj8HmxFJ4Gy1q1lWqNIKeU3XfqMlqjK4xjrHVuLqOcZen8ae6wHrUvRGAZtz/6
         EjVQ==
X-Gm-Message-State: APuU4Z97MtuW3s+qhqzDXANK4J47sDHs2CSwH0qqsqU8RbigtWBmJexc
	xqRlE2JxMZe/tQX9+ETjnaoijcREeAj8sKv4eeMcFA3bp6Fy24SZ1mcNR4aSwA==
X-Gm-Gg: AZFdTZe+532mU7SGcaeVKGwweu1dkWgO3qgW1V3zXGOsT18+niJV3VCW4R5dKjbRZrp
	llG7ndumSY2x4vhKJpmRjF9DSWynOtoEBD40GNMfGCT5JptGOvQ7w3ICz3kSSeeMT6huXahFro8
	Ek2gP+Lp3BTpwgXW17n+ZzdUN6RdfXpPXWqyZAwFntEZjdZR6S3ddNEUzyhhJ2yG2E1SDt9twRZ
	7MtxwYtYqGtBZLqQi9SlZD3eR4vPXzAOBLmcfhrT3O/q2XwFB91p3aUsGEHA977U0sAhCUpD40y
	wLRnheJYYvlcSfDIj2UCX/+2tfAG15M9bNGOqskto12WMlVzNIJqb4M1vvqlShZqMme8cGYyarV
	+Q4nDcgYTy/KC/WUTCo3nXilRTj7gtDS13NdDyYxzOeHeu+fyw/qnl+U6KA/Me6WilCT3Yh2NX0
	A6nokOnCxWz40faBMA5Gli2gIqt1Il0pvru/y7+Lsqzqvc8NjYrw754pA9Pe4X+eQkF++j41hh5
	7r0omF0QOcWckKmhmxyW6EI3xZ05CKVE+VCycp0fkjCyDx8fQqd4VJX80MR1o62PupYfN2Q/5MZ
	sSFKJy8Plx1sOpehUZSn9dBguNSWgCk13xoV1i+aGwPAdANNAedJVrjvm4r1+Ws=
X-Received: by 2002:a05:6000:2082:b0:4a3:2ac:26a4 with SMTP id ffacd0b85a97d-4a3774cbc51mr4711967f8f.23.1794911890442;
        Tue, 17 Nov 2026 02:38:10 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608d10b2sm44715932f8f.44.2026.11.17.02.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:38:09 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexander Meshcheryakov <alexander.s.m@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 4/4] diff: use uintmax_t for diffstat totals and graph scaling
Date: Tue, 17 Nov 2026 11:37:56 +0100
Message-ID: <692c503e97d9841def6e0429ef52a963ab93eec0.1794909894.git.gitter.spiros@gmail.com>
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

struct diffstat_file stores the number of added and deleted lines of
each file in uintmax_t, but show_stats() and show_shortstats() add them
up in "int" variables. When the total goes over INT_MAX, the summary
line overflows. With the previous patch, a single file is enough: for
a complete rewrite into a file of 2^31 lines, "git diff -B --stat"
ends with

	1 file changed, -2147483648 insertions(+), 1000 deletions(-)

Several files whose changes add up to more than INT_MAX lines lead to
the same overflow even without -B.

Use uintmax_t for these totals and for the parameters of
print_stat_summary() and print_stat_summary_inserts_deletes(), which
printed them with "%d". print_stat_summary() is also called by
"git apply --stat", hence the change of its prototype in diff.h.
apply.c still adds up its own totals in "int"; it is left alone here.

The graph has a similar problem. scale_linear() takes the number of
changed lines and max_change as "int", although show_stats() holds
them in uintmax_t, and computes "it * (width - 1)" in "int". The
product overflows even for a small file when the graph is wide enough.
For a new file of 50000 lines,

	git diff --stat=46100 --stat-graph-width=46000

prints no "+" at all, because 50000 * 45999 is larger than INT_MAX.
Make scale_linear() take uintmax_t, so that the product is computed in
uintmax_t. Its result is at most "width", so it still fits in an
"int".

show_stats() also assigned max_change to the "int" graph_width. Cap it
at "width" instead: a wider graph is cut down to fit "width" right
after, so the output does not change when max_change fits in an "int".

When the graph is not scaled, the numbers of added and deleted lines
are copied as they are into "add" and "del", which stay "int": in that
case both are smaller than graph_width.

Add the graph case to t4052. The test fails without this patch and is
cheap enough to run by default. The totals are not tested, because
going over INT_MAX lines needs a file of 2GiB or more.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 diff.c                 | 46 +++++++++++++++++++++++++-----------------
 diff.h                 |  2 +-
 t/t4052-stat-output.sh | 10 +++++++++
 3 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index ee92a8ac4d..0d2ea21280 100644
--- a/diff.c
+++ b/diff.c
@@ -2838,7 +2838,7 @@ static int diffstat_consume(void *priv, char *line, unsigned long len)
 
 const char mime_boundary_leader[] = "------------";
 
-static int scale_linear(int it, int width, int max_change)
+static int scale_linear(uintmax_t it, int width, uintmax_t max_change)
 {
 	if (!it)
 		return 0;
@@ -2880,7 +2880,7 @@ static void fill_print_name(struct diffstat_file *file)
 }
 
 static void print_stat_summary_inserts_deletes(struct diff_options *options,
-		int files, int insertions, int deletions)
+		int files, uintmax_t insertions, uintmax_t deletions)
 {
 	struct strbuf sb = STRBUF_INIT;
 
@@ -2905,13 +2905,15 @@ static void print_stat_summary_inserts_deletes(struct diff_options *options,
 	 */
 	if (insertions || deletions == 0) {
 		strbuf_addf(&sb,
-			    (insertions == 1) ? ", %d insertion(+)" : ", %d insertions(+)",
+			    (insertions == 1) ? ", %"PRIuMAX" insertion(+)" :
+						", %"PRIuMAX" insertions(+)",
 			    insertions);
 	}
 
 	if (deletions || insertions == 0) {
 		strbuf_addf(&sb,
-			    (deletions == 1) ? ", %d deletion(-)" : ", %d deletions(-)",
+			    (deletions == 1) ? ", %"PRIuMAX" deletion(-)" :
+					       ", %"PRIuMAX" deletions(-)",
 			    deletions);
 	}
 	strbuf_addch(&sb, '\n');
@@ -2921,7 +2923,7 @@ static void print_stat_summary_inserts_deletes(struct diff_options *options,
 }
 
 void print_stat_summary(FILE *fp, int files,
-			int insertions, int deletions)
+			uintmax_t insertions, uintmax_t deletions)
 {
 	struct diff_options o;
 	memset(&o, 0, sizeof(o));
@@ -2954,8 +2956,8 @@ static int utf8_ish_width(const char **start)
 
 static void show_stats(struct diffstat_t *data, struct diff_options *options)
 {
-	int i, len, add, del, adds = 0, dels = 0;
-	uintmax_t max_change = 0, max_len = 0;
+	int i, len, add, del;
+	uintmax_t adds = 0, dels = 0, max_change = 0, max_len = 0;
 	int total_files = data->nr, count;
 	int width, name_width, graph_width, number_width = 0, bin_width = 0;
 	const char *reset, *add_c, *del_c;
@@ -3062,7 +3064,11 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * strlen("Bin XXX -> YYY bytes") == bin_width, and the part
 	 * starting from "XXX" should fit in graph_width.
 	 */
-	graph_width = max_change + 4 > bin_width ? max_change : bin_width - 4;
+	if (max_change + 4 > bin_width)
+		/* anything wider than "width" is cut down below anyway */
+		graph_width = max_change < width ? max_change : width;
+	else
+		graph_width = bin_width - 4;
 	if (options->stat_graph_width &&
 	    options->stat_graph_width < graph_width)
 		graph_width = options->stat_graph_width;
@@ -3164,21 +3170,22 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		/*
 		 * scale the add/delete
 		 */
-		add = added;
-		del = deleted;
-
 		if (graph_width <= max_change) {
-			int total = scale_linear(add + del, graph_width, max_change);
-			if (total < 2 && add && del)
+			int total = scale_linear(added + deleted, graph_width, max_change);
+			if (total < 2 && added && deleted)
 				/* width >= 2 due to the sanity check */
 				total = 2;
-			if (add < del) {
-				add = scale_linear(add, graph_width, max_change);
+			if (added < deleted) {
+				add = scale_linear(added, graph_width, max_change);
 				del = total - add;
 			} else {
-				del = scale_linear(del, graph_width, max_change);
+				del = scale_linear(deleted, graph_width, max_change);
 				add = total - del;
 			}
+		} else {
+			/* both fit in the graph, hence in an int */
+			add = added;
+			del = deleted;
 		}
 		strbuf_addf(&out, " %s%s%*s | %*"PRIuMAX"%s",
 			    prefix, name, padding, "",
@@ -3222,14 +3229,15 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 
 static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
 {
-	int i, adds = 0, dels = 0, total_files = data->nr;
+	int i, total_files = data->nr;
+	uintmax_t adds = 0, dels = 0;
 
 	if (data->nr == 0)
 		return;
 
 	for (i = 0; i < data->nr; i++) {
-		int added = data->files[i]->added;
-		int deleted = data->files[i]->deleted;
+		uintmax_t added = data->files[i]->added;
+		uintmax_t deleted = data->files[i]->deleted;
 
 		if (data->files[i]->is_unmerged ||
 		    (!data->files[i]->is_interesting && (added + deleted == 0))) {
diff --git a/diff.h b/diff.h
index bb5cddaf34..d51507d192 100644
--- a/diff.h
+++ b/diff.h
@@ -764,7 +764,7 @@ int parse_rename_score(const char **cp_p);
 long parse_algorithm_value(const char *value);
 
 void print_stat_summary(FILE *fp, int files,
-			int insertions, int deletions);
+			uintmax_t insertions, uintmax_t deletions);
 void setup_diff_pager(struct diff_options *);
 
 extern int diff_auto_refresh_index;
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 62d3d2604c..d1cca6ab8e 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -470,4 +470,14 @@ test_expect_success FUNNYNAMES 'diffstat truncation with control chars does not
 	git commit -m "remove test file"
 '
 
+test_expect_success 'diffstat graph of a large change with a wide graph' '
+	test_when_finished "git rm -f --cached big && rm -f big" &&
+	test_seq 50000 >big &&
+	git add -N big &&
+	git diff --stat=46100 --stat-graph-width=46000 -- big >output &&
+	grep " | " output >line &&
+	tr -cd + <line >plus &&
+	test $(wc -c <plus) -eq 46000
+'
+
 test_done
-- 
2.53.0

