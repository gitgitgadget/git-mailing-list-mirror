Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB159339A8
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771067209; cv=none; b=PfWeCJaNv2p12iH8as4YonOE2fv+Z+pX86BCRIIviuVWYnnvitlbPk5GG7Co3+eXItUpY1DDsGncpIIbKisTdOAQ1tvK6btqBlUQvdbAXVYQUybrh6nKhfU6bXhytKOnUBIa5gbushFxdp4/XbwOP8KqKuDRGCKglOwAdgBTDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771067209; c=relaxed/simple;
	bh=Z4uN+IosPiXYiEO3q2OezZ4w/yYoMZaBWAwEqiKF2ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idh8sN9T1SbiJl3dkLtqNTGrcIIfJeZm/GElii5RxT6GtQLsDjAz+pPbz+gs/v1NcC7cc2nPyC0gS/vI3WXojVnhdCl6wsBYZqRAhi1wNamYn5EEh/H7TzLXUA9d4xH+e/CnkJZIZpJlNrGaKxStODBjd46dmAqXAC3a3WTpYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7qn0ovP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7qn0ovP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-483487335c2so15094455e9.2
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 03:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771067206; x=1771672006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XuYiMj4lRR/8FRX0OIewXONm+ly82xKLuzxPp29KRXY=;
        b=K7qn0ovPtUxINX2S175NJoJKi/DEcYNZhcTMxChHAXlYezrTmE1l6vlp7F1ZX9d2xJ
         f/z4OLoGiHYoMmgXy/3mA3eDjrn3/ejswdrFdY0WA8Ikakvt0cba5cyZpefp/mJBc2Cf
         YstFWDpzQNCMM4Ea91Ix8Pn97CcZPYhdncsnVkoP0nVUgHr/1LWKTFB6uhIV78q6KiHA
         5LyDt4t1rFRcN8t854gDPH53G7TA/vVVg9kYMLuIwIfXOQ4FT3gN3iWvvJHXm++RSxJ7
         h0Gprz35JiDm8z/1W77UdqFWF/SGLHquUe/gq6TFbdm1XUcej+xcz+Q571BccQ6t6dZL
         Wv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771067206; x=1771672006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuYiMj4lRR/8FRX0OIewXONm+ly82xKLuzxPp29KRXY=;
        b=XKbusMhjVSaDEC3g6RuMD7a2Jyibn5B/HyIK05ZTSczSUuvoY8neWb0r5v0rnNI7RQ
         lwh0jCxuow67DOaom9cTkoWGa1uz5OGJ0qyUEooSjVan+BhsbYUryY0IAec/Jxgkl7V/
         WTxY+yZQ2ulKQbzItOJI+XYN2VG8gqLdShFh3sMN8urW1uAQcXiezukG0DE8ljTL2VYn
         Q4+8QgojqFYyFLc71PTGChbWC3qOeALAIiE7URhShyHv5xw9ThWxOyfuW1Gy4+c18tGw
         mkMkOlxI7g4ag24nVl2df7qcQaoE0cSLevXuW3UlUya31Q7wc0sWNH5llyjXLfeJkDki
         Jt1w==
X-Gm-Message-State: AOJu0YyWczllHBCKu1cZ/n9FELp1Ba5rSP+snacEV8pTweHSafIAyRNX
	oQAHOJOWPLHJXulCwksDE69BDSdiDoyTr2qXuGgWgHiu3sAjSDGEPWl4HcnesHAg
X-Gm-Gg: AZuq6aLeJlFyzOCiZaXxQmdS+rSKRTD1Sj5Tx4TBhw7pF4nfPTTiIn61K+yqv7B5mDx
	qRASmVFMV6YhmnohaxCWRVP+8y8inMla4mTCc5s2mDqir09bnq65Ly18kFuWnJpv5Opc+Hmj/Lj
	nm413su4G7581NEcjQHisLC8LiTJh3CiF5+B7vo1Vbowp+RT4H94DWRJAbYtxYsXFxgS4CTemEa
	iTSO6lTgnotLbDh3h5G+Os/BqKH63uAOHgw0Rfjg7eHKJ4J2gplOc4H6PeuN9d0NzNXvp4bGr8/
	3GC0BoOpqs+Jy6W67y4v5o56jO6Q01lh/3WgsAICSHnmD4A+BnpK+J58Y+VhZsRCKKmbzhUP+Io
	As2ypRIGXC6detZ9pV2Zt42a9mqT9tEd9nH/agPqprGI4CGViwm1L6jORPOpkzZFw255pxB4wtv
	2IgbsLMkv2Ewqd5NundaOpqNMrO9t1LQ==
X-Received: by 2002:a05:600c:4e4d:b0:482:df17:bbbc with SMTP id 5b1f17b1804b1-48373a37b73mr76657455e9.20.1771067205756;
        Sat, 14 Feb 2026 03:06:45 -0800 (PST)
Received: from localhost ([102.88.77.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm235229105e9.3.2026.02.14.03.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 03:06:45 -0800 (PST)
Date: Sat, 14 Feb 2026 12:06:55 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH v5 4/4] add-patch: allow interfile navigation when selecting
 hunks
Message-ID: <193fba4e336897a57a26e77c6eac74a05abc79c0.1771066252.git.abrahamadekunle50@gmail.com>
References: <cover.1771066252.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771066252.git.abrahamadekunle50@gmail.com>

After deciding on all hunks in a file, the interactive session
advances automatically to the next file if there is another,
or the process ends.

Now using the `--no-auto-advance` flag with `--patch`, the process
does not advance automatically. A user can choose to go to the next
file by pressing '>' or the previous file by pressing '<', before or
after deciding on all hunks in the current file.

After all hunks have been decided in a file, the user can still
rework with the file by applying the options available in the permit
set for that hunk, and after all the decisions, the user presses 'q'
to submit.
After all hunks have been decided, the user can press '?' which will
show the hunk selection summary in the help patch remainder text
including the total hunks, number of hunks marked for use and number
of hunks marked for skip.

This feature is enabled by passing the `--no-auto-advance` flag
to `--patch` option of the subcommands add, stash, reset,
and checkout.

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 add-patch.c                |  66 ++++++++++++++++++++++--
 t/t3701-add-interactive.sh | 100 +++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+), 5 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 07526e7fb6..b3fb08f416 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1418,7 +1418,10 @@ N_("j - go to the next undecided hunk, roll over at the bottom\n"
    "e - manually edit the current hunk\n"
    "p - print the current hunk\n"
    "P - print the current hunk using the pager\n"
-   "? - print help\n");
+   "> - go to the next file, roll over at the bottom\n"
+   "< - go to the previous file, roll over at the top\n"
+   "? - print help\n"
+   "HUNKS SUMMARY - Hunks: %d, USE: %d, SKIP: %d\n");
 
 static void apply_patch(struct add_p_state *s, struct file_diff *file_diff)
 {
@@ -1483,6 +1486,7 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 	char ch;
 	int colored = !!s->colored.len, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
+	int all_decided = 0;
 	struct file_diff *file_diff = s->file_diff + idx;
 	size_t patch_update_resp = idx;
 
@@ -1502,7 +1506,9 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 			ALLOW_GOTO_NEXT_UNDECIDED_HUNK = 1 << 3,
 			ALLOW_SEARCH_AND_GOTO = 1 << 4,
 			ALLOW_SPLIT = 1 << 5,
-			ALLOW_EDIT = 1 << 6
+			ALLOW_EDIT = 1 << 6,
+			ALLOW_GOTO_PREVIOUS_FILE = 1 << 7,
+			ALLOW_GOTO_NEXT_FILE = 1 << 8
 		} permitted = 0;
 
 		if (hunk_index >= file_diff->hunk_nr)
@@ -1534,8 +1540,12 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		/* Everything decided? */
 		if (undecided_previous < 0 && undecided_next < 0 &&
 		    hunk->use != UNDECIDED_HUNK) {
-				patch_update_resp++;
-				break;
+				if (!s->s.auto_advance)
+					all_decided = 1;
+				else {
+					patch_update_resp++;
+					break;
+				}
 		}
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
@@ -1584,6 +1594,14 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 				permitted |= ALLOW_EDIT;
 				strbuf_addstr(&s->buf, ",e");
 			}
+			if (!s->s.auto_advance && s->file_diff_nr > 1) {
+				permitted |= ALLOW_GOTO_NEXT_FILE;
+				strbuf_addstr(&s->buf, ",>");
+			}
+			if (!s->s.auto_advance && s->file_diff_nr > 1) {
+				permitted |= ALLOW_GOTO_PREVIOUS_FILE;
+				strbuf_addstr(&s->buf, ",<");
+			}
 			strbuf_addstr(&s->buf, ",p,P");
 		}
 		if (file_diff->deleted)
@@ -1660,6 +1678,28 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		} else if (ch == 'q') {
 			patch_update_resp = s->file_diff_nr;
 			break;
+		} else if (!s->s.auto_advance && s->answer.buf[0] == '>') {
+			if (permitted & ALLOW_GOTO_NEXT_FILE) {
+				if (patch_update_resp == s->file_diff_nr - 1)
+					patch_update_resp = 0;
+				else
+					patch_update_resp++;
+				break;
+			} else {
+				err(s, _("No next file"));
+				continue;
+			}
+		} else if (!s->s.auto_advance && s->answer.buf[0] == '<') {
+			if (permitted & ALLOW_GOTO_PREVIOUS_FILE) {
+				if (patch_update_resp == 0)
+					patch_update_resp = s->file_diff_nr - 1;
+				else
+					patch_update_resp--;
+				break;
+			} else {
+				err(s, _("No previous file"));
+				continue;
+			}
 		} else if (s->answer.buf[0] == 'K') {
 			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
 				hunk_index = dec_mod(hunk_index,
@@ -1805,6 +1845,18 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 				 * commands shown in the prompt that are not
 				 * always available.
 				 */
+				if (all_decided && !strncmp(p, "HUNKS SUMMARY", 13)) {
+					int total = file_diff->hunk_nr, used = 0, skipped = 0;
+
+					for (i = 0; i < file_diff->hunk_nr; i++) {
+						if (file_diff->hunk[i].use == USE_HUNK)
+							used += 1;
+						if (file_diff->hunk[i].use == SKIP_HUNK)
+							skipped += 1;
+					}
+					color_fprintf_ln(stdout, s->s.help_color, _(p),
+							 total, used, skipped);
+				}
 				if (*p != '?' && !strchr(s->buf.buf, *p))
 					continue;
 
@@ -1817,7 +1869,8 @@ static size_t patch_update_file(struct add_p_state *s, size_t idx)
 		}
 	}
 
-	apply_patch(s, file_diff);
+	if (s->s.auto_advance)
+		apply_patch(s, file_diff);
 
 	putchar('\n');
 	return patch_update_resp;
@@ -1878,6 +1931,9 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 		 if ((i = patch_update_file(&s, i)) == s.file_diff_nr)
 			break;
     }
+	if (!s.s.auto_advance)
+		for (i = 0; i < s.file_diff_nr; i++)
+			apply_patch(&s, s.file_diff + i);
 
 	if (s.file_diff_nr == 0)
 		err(&s, _("No changes."));
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5ce9c6dd60..6e120a4001 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1441,5 +1441,105 @@ test_expect_success 'EOF quits' '
 	test_grep file out &&
 	test_grep ! file2 out
 '
+for cmd in add checkout reset "stash save" "stash push"
+do
+	test_expect_success "$cmd rejects invalid --no-auto-advance options" '
+		test_must_fail git $cmd --no-auto-advance 2>actual &&
+		test_grep -E  "requires .*--(interactive|patch)" actual
+	'
+done
+
+test_expect_success 'manual advance (">") moves to next file with --no-auto-advance' '
+	git reset --hard &&
+	echo line1 >first-file &&
+	echo line2 >second-file &&
+	git add -A &&
+	git commit -m initial >/dev/null 2>&1 &&
+	echo change_first >>first-file &&
+	echo change_second >>second-file &&
+
+	printf ">\nq\n" | git add -p --no-auto-advance >output.test 2>&1 &&
+	test_grep  -E "(a|b)/second-file" output.test
+'
+
+test_expect_success 'select n on a hunk, go to another file, come back and change to y stages' '
+	git reset --hard &&
+	echo one >f1 &&
+	echo one >f2 &&
+	git add -A &&
+	git commit -m initial >/dev/null 2>&1 &&
+	echo change1 >>f1 &&
+	echo change2 >>f2 &&
+
+	printf "n\n>\n<\ny\nq\n" | git add -p --no-auto-advance >output.staged 2>&1 &&
+	git diff --cached --name-only >staged &&
+	test_grep -E "(a/f1)" output.staged
+'
+
+test_expect_success 'select y on a hunk, go to another file, come back and change to n does not stage' '
+	git reset --hard &&
+	echo one >f1 &&
+	echo one >f2 &&
+	git add -A &&
+	git commit -m initial >/dev/null 2>&1 &&
+	echo change1 >>f1 &&
+	echo change2 >>f2 &&
+
+	printf "y\n>\n<\nn\nq\n" | git add -p --no-auto-advance >output.unstaged 2>&1 &&
+	git diff --cached --name-only >staged &&
+	test_must_be_empty staged
+'
+
+test_expect_success 'deciding all hunks in a file does not auto advance' '
+	git reset --hard &&
+	echo line >stay &&
+	echo line >other &&
+	git add -A &&
+	git commit -m initial >/dev/null 2>&1 &&
+	echo change >>stay &&
+	echo change >>other &&
+	test_write_lines y | git add -p --no-auto-advance >raw-output 2>&1 &&
+	test_grep "(1/1) Stage this hunk (was: y)" raw-output &&
+	test_grep ! "diff --git a/stay b/stay" raw-output
+'
+test_expect_success 'HUNKS SUMMARY does not show in help text when there are undecided hunks' '
+	git reset --hard &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 >f &&
+	git add f &&
+	git commit -m initial >/dev/null 2>&1 &&
+	test_write_lines 1 X 3 4 Y 6 7 Z 9 >f &&
+	test_write_lines s y n | git add -p --no-auto-advance >raw-nostat 2>&1 &&
+	test_grep ! "HUNKS SUMMARY - Hunks: " raw-nostat
+'
+
+test_expect_success 'help text shows HUNK SUMMARY when all hunks have been decided' '
+	git reset --hard &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 >f2 &&
+	git add f2 &&
+	git commit -m initial >/dev/null 2>&1 &&
+	test_write_lines 1 X 3 4 Y 6 7 Z 9 >f2 &&
+	printf "s\ny\nn\ny\n?\n" | git add -p --no-auto-advance >raw-stat 2>&1 &&
+	test_grep "HUNKS SUMMARY - Hunks: 3, USE: 2, SKIP: 1" raw-stat
+'
+
+test_expect_success 'selective staging across multiple files with --no-advance' '
+	git reset --hard &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 >a.file &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 >b.file &&
+	test_write_lines 1 2 3 4 5 6 7 8 9 >c.file &&
+	git add -A &&
+	git commit -m initial >/dev/null 2>&1 &&
+	test_write_lines 1 A2 3 4 A5 6 7 8 9 >a.file &&
+	test_write_lines 1 2 B3 4 5 6 7 B8 9 >b.file &&
+	test_write_lines C1 2 3 4 5 C6 7 8 9 >c.file &&
+	printf "s\ny\nn\n>\ns\nn\ny\n>\ns\ny\ny\nq\n" | git add -p --no-auto-advance >output.index 2>&1 &&
+	git diff --cached >staged.diff &&
+	test_grep "+A2" staged.diff &&
+	test_grep ! "+A5" staged.diff &&
+	test_grep "+B8" staged.diff &&
+	test_grep ! "+B3" staged.diff &&
+	test_grep "+C1" staged.diff &&
+	test_grep "+C6" staged.diff
+'
 
 test_done
-- 
2.39.5 (Apple Git-154)

