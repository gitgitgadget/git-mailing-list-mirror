Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F72305E10
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771020752; cv=none; b=ipp21wGOrtltpFAImZnhOjeMiIvoAg0FkwqyOODVsO5X95UUq9aH/M3QfyW5w+SBaq1EQ7Ozrk2NmTuqcttNcCYmC6z+sRKeboDmrL5uMDFwK6r9vUOyq2GoHKiJs3ekJuvqGwf6WHAI9lOQ4UOTFFRoekVK8NrKRz8yi4P82hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771020752; c=relaxed/simple;
	bh=M0Mrmh68rQ4stCstayr+BA/lnVigKvicX+5pfB4AShE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkF3matBr06KdX92aD4XqH7J8omTPoEuLNSsnFgglQpL4GPvVmGqvEuFPor/sB6oIH2vweQFmS+XuwwEF5ZW3/JVcjw2hcHaNv8mnZTbdCCtHyQEshdvIYBdlalY/f5beNd5OylN/OBwuWr03NIQ4gd0zzr8DSQc420IN67x3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OExAPjnQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OExAPjnQ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-436e8758b91so1067742f8f.0
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 14:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771020748; x=1771625548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2wB7yYzRTjPbDb0/uNOmKIeui8o0+ED3eJNq1r6PWM=;
        b=OExAPjnQlu/0h2TUEam7LEnDKvWNwKBKrhv6N5CyVqgSNJ7YCbGZFc6dTvURIm/lal
         R20WrRXE9oUWay4Gk4sc/5Q2kHQso/XLOGhTXwLIQ5vnBGMWxvUeb5lllLHxlIB/vZyp
         PJ2IuztH4ZgeskW9/vIoJZ472Ig87CceVX4Zr+T4d1fDEUpVLvMWZ659VNSPrcxFTpGF
         fkdtJr5PKZOrWymbMH5r/Y7bsHQ8swcuvHWx3DQhW9qyC5Vb0oPaKsgzR/HZmzEcKQEE
         U7CX/jrFZnl5VTWHkg8FGHD1xyAEgQhdX+kNF8BQDTJq08J/HGEQPJ3m3AyfuSLVyXqb
         Xt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771020748; x=1771625548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2wB7yYzRTjPbDb0/uNOmKIeui8o0+ED3eJNq1r6PWM=;
        b=r+0OPZAnLBHMsyFdEHDgI7cWRJDH2cqqNJ3e7Kw5FqcuA0vMJXi/zOAnPOGibfo4Gq
         5pmLi+qepmEOuXuwEcXY63hLkaGLrERlsQ1wIvfrdE4jKxaglvn5+/uVqvSwyTU3UOAP
         KGF3UhmqgxHcIkyc9dn8TGCEOVV1Tosp4Eue/1X6KE14YkvafGpx1dvJtzedaWh/1hcs
         mWdDwZeyqtua/GasTRDewDXY8f6BIHv/Siz2KOMs02YMbtOqPT60j/WP6otyQcYJ9vUw
         Djy2z47S2eFe+qBPgwhV/4aJGVa4qhy1bVXcJS2FQJTCxRH5x6jgaA9Y6WGiEAthK8eN
         fZ9g==
X-Gm-Message-State: AOJu0YxHT/9iVOt1OIHvcTGx76zjd95jRfczAFIHLTGHrv8kFLGpUQ9w
	6aOwOJQFmEpRrPyn78Uv6m9hsP0MYpZumokkw0oQiJKZre/TMqSaY1QtFaGZ1Nw5
X-Gm-Gg: AZuq6aISBVDKIb88kENOQ123i2p8GuAoaeTdLR7TEVqp641DyR/pYGY1BgSw9dUAuV7
	MkZUTwsBwkBGlcTPUHufx0GsnQbsjrqcYCU+tQIls8129lXUSyzH8ylghAN+U0p5LFN7TVAOJiB
	i8pPAGij32cFVDrUa7oPjAqiAEICWcDdvQU3TxNUjm7uwZW7GMEh543cqqnq6GXJVoco/WF38eP
	tZ0UO1CvpoIBozLJM/RBqFH28oz0p0ZC/b3m1U3x0j6XWZBkOCcD/dtnyg81g1qHPGV7vXp0SzJ
	Kro5/rMbvaKkgfiyTMd1S7mMyWJBxGzalD7nWrfgQSCS37HEI2FNg8rMAIfECMlLREvoLMqyYMx
	C80Z2hOQCM/0Ufqf4ocfPEDL77yRgjotE/7lu49GDc6H4uQMIS25rTzylWhFIU7Vj7bGN1+uNzm
	kernZV+HibnClrUPoOh7AwbKGEZ0zmCA==
X-Received: by 2002:a5d:5d10:0:b0:437:7168:af4f with SMTP id ffacd0b85a97d-4379db6485emr1750276f8f.27.1771020747510;
        Fri, 13 Feb 2026 14:12:27 -0800 (PST)
Received: from localhost ([102.88.77.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a74704sm8661855f8f.16.2026.02.13.14.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 14:12:27 -0800 (PST)
Date: Fri, 13 Feb 2026 23:12:32 +0100
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
Subject: [PATCH v4 4/4] add-patch: allow interfile navigation when selecting
 hunks
Message-ID: <900d39c1b66d1a71fe0abb40d88f328e40b049e4.1771015581.git.abrahamadekunle50@gmail.com>
References: <cover.1771015581.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771015581.git.abrahamadekunle50@gmail.com>

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
index 7d4f17e432..6b9ae4da30 100644
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
@@ -1483,6 +1486,7 @@ static ssize_t patch_update_file(struct add_p_state *s, size_t idx)
 	char ch;
 	int colored = !!s->colored.len, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
+	int all_decided = 0;
 	struct file_diff *file_diff = s->file_diff + idx;
 	ssize_t patch_update_resp = (ssize_t)idx;
 
@@ -1502,7 +1506,9 @@ static ssize_t patch_update_file(struct add_p_state *s, size_t idx)
 			ALLOW_GOTO_NEXT_UNDECIDED_HUNK = 1 << 3,
 			ALLOW_SEARCH_AND_GOTO = 1 << 4,
 			ALLOW_SPLIT = 1 << 5,
-			ALLOW_EDIT = 1 << 6
+			ALLOW_EDIT = 1 << 6,
+			ALLOW_GOTO_PREVIOUS_FILE = 1 << 7,
+			ALLOW_GOTO_NEXT_FILE = 1 << 8
 		} permitted = 0;
 
 		if (hunk_index >= file_diff->hunk_nr)
@@ -1534,8 +1540,12 @@ static ssize_t patch_update_file(struct add_p_state *s, size_t idx)
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
@@ -1584,6 +1594,14 @@ static ssize_t patch_update_file(struct add_p_state *s, size_t idx)
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
@@ -1660,6 +1678,28 @@ static ssize_t patch_update_file(struct add_p_state *s, size_t idx)
 		} else if (ch == 'q') {
 			patch_update_resp = -1;
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
@@ -1805,6 +1845,18 @@ static ssize_t patch_update_file(struct add_p_state *s, size_t idx)
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
 
@@ -1817,7 +1869,8 @@ static ssize_t patch_update_file(struct add_p_state *s, size_t idx)
 		}
 	}
 
-	apply_patch(s, file_diff);
+	if (s->s.auto_advance)
+		apply_patch(s, file_diff);
 
 	putchar('\n');
 	return patch_update_resp;
@@ -1881,6 +1934,9 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 			break;
 		i = (size_t)patch_update_resp;
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

