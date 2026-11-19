Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070652;
	b=dArch5M/yjdFUqS99cR3O4y755rZoVPlfbV0sx+zgiDzq4jm8F0ErAuRjaneObfvCCgU
	 IcXib6yRPwhjpJc0n+LrBGstPxQNaTSzJMwjQOxIsgDsLVjxHvNUIeY2NpTONZObkG4zb
	 srYq7g0WZXZHinQwZdhob3rjBLZk4MxEQyLAS2IodTqJ8bAYB5YXWOhBaUNWY0VYE0ocf
	 xd6XZfHoeBJxk+F5Hc6SPcQUUgLUbqC9GgF0evofP/B6n+eeSG34w0jr8GbERI+fKYPU7
	 2Rob99AA25rtA/G+NvZ84T/gjAnzyhCkeahM0wnlqni+sNlMnqB1zP73K1SfllpWcrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=hdj3u3AHtUq4V7hGc9IeV1x62JbADbld/2lb98M9GU8=;
	b=AqKF8deglkotLsm1rRF2pl9d8bMRO2ghn3gInAM6ZuzMn/lB0EInxJlOBt/+F39b7U/l
	 xpanW7uxJkl9UrOofEfto4w7qAIzD0VP4Gdj4GU2tSRfC3gINJ1kdCxLTJYFAfEnC/tQ9
	 jxe5zTaRvyGGZuKHgEw0k6hPbt2SETBOeNMbiSTfgyg8GLsZOoh0vRxwnk8IRye3a75w1
	 v6C9gkfzWi2RVryJsTlpAliQaUPo0rPCeiv+mih+n5T96+9YXkWuLq48uSEBM4qOAolY2
	 zjYKGHXRSf0iqZtOkxDMsinZwj1Mo4LzbPF25+dBzrSHjfNyK2E2Oe1q5/CpsIqW/vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wbJxdt4k;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5623606A337
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5623606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wbJxdt4k
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso18292035e9.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795070650; x=1795675450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hdj3u3AHtUq4V7hGc9IeV1x62JbADbld/2lb98M9GU8=;
        b=wbJxdt4kkeYKCudr14Uac6ihnZkjCp89I59u1vZ8s2TzwDrl03j0aAolLCxnmAj4x1
         ou1r61r7ot0TPz9d9SCF/m0Dc7PgMQFjYPvphaww7KRmuncailTa0lWhr7vIWGhJMzn5
         6ZnA0M3cu0oy6iaMDqlNOlHES8gyrLpNRcw924XUNdxPdJhvj27XqLp9thHiFm/yvJNR
         MB01Pxo0RgloyQEijElU3B0WAdCT1LWTqp6eb1Y8YFhzj4wUMadU3sSwQspKTJfYGTbN
         I2q9FQTEeHHCyNoBMBF2FoUAxnrlcHq714VAzqadOFFPBKIR1UqM21ygoWqn/n5HszY1
         /7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795070650; x=1795675450;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hdj3u3AHtUq4V7hGc9IeV1x62JbADbld/2lb98M9GU8=;
        b=v3W+qQvCHcxq5nKgVjOMT2I1uRm7wYaOpA7bMUyTLZPhjbJEJg/9zKGnHGgeNPKeXY
         O3uVdrtq+KTJNDfny6TlUHxVh8KQWR3WdF0Kpvvhcgko2r1r8SxylP//kcn+9+cqZl9I
         6aYfG0dVBQfnjDImcCEetslIu7vvAN3z7av6aQaTbq+HACIwvCYSaM0hTmMgWarHFkc1
         Aqs4yKWfFXEl5aLzPLy2FHxL2p0ZiTU8SeLQwwVs9iD5k8A84RZgAqeKz2wCOWUP2jRL
         rRUI0WAi51Ol/p+jugPKGGnibKtil/FtsIRrlatAAauuVTS+lXOLXjmDXOcd19wdYLWm
         gdbQ==
X-Gm-Message-State: APuU4Z9wfDTfFtB8hSBNPEYSFHkaeVjKoBP2PKEnvrwMqkU6gSkf0v4E
	j9OMa5FtrcnPn0srlw9RTPxavZNdLJWohcL4W0xSmDe4sJoSK+Ifvech5/t3TA==
X-Gm-Gg: AYBFou2dOfkRPxmN7qbI9pheifLHYHLuoWcx/jEpiSX/FnMxqw0dxOUozf3VooB48QQ
	2FIwOEWQHrc33j20W9qkGQ3LvoHY+P7AAaSTUOqAvHYNiziHSm0+n5VzpCqYBvIiDXQxPWHGoN2
	ASTuTCPa1FHIOvicm1RY2niSdTOnKRsx5XClayFBUMG4CWOhAKHLhEPlSSVUxzjg134a9vatYGe
	2NekxPys4STrao7odwMF8f8lDBG4wMYTMJ0c6/wmsfKabTxlWsn9FyiakTHKIVT5TLL+lSncxM5
	cr0hcrYrlk3tuB/BfbhFsTiYmPw6J5pE7Zy5W9C/FrvQqolCJ/NCrwiRPNwMqsTl45/yjTOgVTu
	P7Ou4i5/2VgYmftlUiAys0CTjl8i/VSmWq0gaohS+B7IVFJYUDMdoTDPCyj1JT+Ilqy5CAIL8h0
	+KvFVlNiGpzzR/qaaBnz1xB4stLK9OKA2fb3V7NhKsdU0UUZJpuwE//3ZUSAqaD80j8anea+2IM
	0eCnPRNKLzsnpJC1BiMYZFskfWDp7kl9zo8JpCX1BZGWTNabA1hJL5CyEDmj72jXxK9q2luxdBv
	DMqeYiii5cPq+uuPOJMICl38wvtZWvE6dNTdyHkiwL+o2hyAb1XZ273mVnuKFJ72Ol2OHYQWA8T
	czAFEFSdu
X-Received: by 2002:a05:600c:1d0f:b0:4bb:56bb:1196 with SMTP id 5b1f17b1804b1-4bb7da349e2mr99223215e9.23.1795070650296;
        Wed, 18 Nov 2026 22:44:10 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85372d15sm15172955e9.14.2026.11.18.22.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:44:08 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Alexander Meshcheryakov <alexander.s.m@gmail.com>
Subject: [PATCH v3 4/4] diff: use uintmax_t for diffstat totals and graph scaling
Date: Thu, 19 Nov 2026 07:43:56 +0100
Message-ID: <bf516f9b4dc73e8b5786d735704fcbfdf6208ea2.1795070117.git.gitter.spiros@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

show_stats() and show_shortstats() add up the per-file line counts,
which struct diffstat_file keeps in uintmax_t, in "int" variables, so
the summary line overflows past INT_MAX lines. With the previous patch
one file is enough: a complete rewrite into a file of 2^31 lines makes
"git diff -B --stat" end with

	1 file changed, -2147483648 insertions(+), 1000 deletions(-)

Add them up in uintmax_t and print them as such in
print_stat_summary(), which "git apply --stat" also uses; apply.c keeps
its own "int" totals for now. A uintmax_t total cannot overflow in
practice: each line counted is at least one byte that git has read,
and nobody feeds git 2^64 bytes.

The graph has two more problems:

 - scale_linear() computes "it * (width - 1)" in "int", which overflows
   even for small files when the graph is wide: for a new file of 50000
   lines, "git diff --stat=46100 --stat-graph-width=46000" prints no
   "+" at all. It now works in uintmax_t; its result is at most
   "width", so it still fits in an "int".

 - The "int" graph_width was set to max_change, which may not fit.
   Cap it at "width" instead. A wider graph is cut down to "width"
   right after anyway, so the output only changes where max_change did
   not fit.

Add the scale_linear() case to t4052; it fails without this patch. The
totals are not tested, as they need a file of 2GiB or more.

Tested-by: Torsten Bögershausen <tboegi@web.de>
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

