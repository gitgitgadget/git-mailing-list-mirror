Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E73570B3
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528710; cv=none; b=oC73IGcse8HM0mtNswxbEZinQbzKOre0tWZv9Iw3hZ6DJWiO9Lj2my9jTyQONwTvqm5BOiZrmW+DpW9+r8bYnZrnEh9qPwWWjUHBWDAjk9gTYuqbILo65Kfov0Bkt/rY0VMC/dRuHqkeA6eycKRCS7HzKdNmSIoCSbLIx/bEi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528710; c=relaxed/simple;
	bh=9/2FdQJZdd8UbbKkD4LozuCAGZffYNd56nGElo0bQAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klGbzFW7GE/f0AIbj556bXhh7VZzieLtIFS9ZEP2joYZX16Z0CR7bIpBsaZbhs6ILpoWIG2VXwOobgYiATWhwC15/TA51GTnOVFTIqhd8egXpDYAlJeHlGpuubAzXKMAfKCIzDvtT+mRPwsiuEIj8LeRCfrjxiUxQNmw98DrmC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCc2Qsbh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCc2Qsbh"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-432da746749so3228507f8f.0
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 07:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769528707; x=1770133507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a9O6FX03MPmgbRprtxSnskR1oj9HFa3PGHfIk+NOTHg=;
        b=YCc2Qsbh+CnO+MkVmjBB9iMipMK4SSBd3uH6qvGoYx43qhgtc09jCaDS+LSqbmRjbW
         Xv1FbLSopTlqkotdrE+9VuIxTDMBxHTwWk/Hf2JQkuA1iOadgKKG9CrZeK+unNLuOHCJ
         sFYlq8GAjVpEmTBHELKkQ4YOHcQfMchbiPoTCrxL77gW7WEr1ISY6fy6P7jeIuYtXjtO
         I+VmJ5X7jVhiXHwgoEYpJWlNHTihYZ92E18c/Iwk43oVkDkhFy5WizmK1jY7qzZP5fwT
         ZN/9bSSSbqx6WUh7zcQz2LO7xXvexKyXEgxta1Z2SIHkNZcHEC27NnIwqfVHDZpJLr+V
         gOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769528707; x=1770133507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9O6FX03MPmgbRprtxSnskR1oj9HFa3PGHfIk+NOTHg=;
        b=aqZzK6XmU5t3IT4Bl3fLk2nFLZ/QypNkCk+PZMfDIFxgnaNVrEeipJ4z3MqFdUNIT0
         bSl7u+zQfz+oZKJ7MMcewbFF2x3duuJA5H9WRCwkObs0qxk585qNHQwJTL71GfWgY8W3
         uC+cPILMD4n+75GUqQHxIzt1qmxkohM15Nhvm8+4j/Y6Uao1AU7VDFWtn3mcS34J+lCK
         syNvTMeD4Hw3FkgGQLPeGTrxjhjZR4Q6pkBDChHpGI7Fl8Ll0uc9Jq5B4njTDc7M+UYQ
         GemWtuLWLnhCPtHlVfvCwHzijOcSBmyRiIEDmJ0CQP5Z/bi0duFXFJZlrcWnUdoKl288
         aeLg==
X-Gm-Message-State: AOJu0Yydff/hqQcDQNI7eIQe5cNwAzkeR0F2Z1bBmdT4stpdicK2SLv1
	MJDs2w6yNRTNFhVIlIRa3N8MxHzBflAgt0x3BboQ/Ab+fX+IBKkzDiV+g0NZewwi
X-Gm-Gg: AZuq6aKR/qiLBrEl6LvI7+SFJUNXjYLqHPGsGzFk2WX120lRbw3AaV1lkF94mMcIQu7
	mINgJ61NdSco8XW2jLO/sZwcBVry56Az/QUtXYQo2zqHb2yMVk4DaN49q914VqF0MFmLaIl3+Wg
	pmCqZJRbnopWU26hqYF26ueenOH7NPGuFGh9jQwjFPJNW78OwuT71mJLViBeHrN6UhvZCRthvgz
	YC/AAGoDIGRWImF92aHSd1B59tvmm8aYLPnW9zS9BKcq3aq1mua0I3v7jqc+gRBPH9Uqxeey/B5
	w28mp/9OZJ08vf2CYLUoi9Y4LypeN4kOLM2tq8O51bPHtpn55/Vhqwz6WBStPx30wBqBR10lIJB
	Ve7Yy0ImEpKMpZqifrpjEam3pbUgwdPKqvISGuYAHLTnkdRNPhozfP3dNtmPlWPyr+q6c5zBvaD
	Uy8UtDhZUD+0wyiuXQ
X-Received: by 2002:a05:6000:2c04:b0:432:85eb:a3cc with SMTP id ffacd0b85a97d-435dd02fda0mr2975228f8f.19.1769528707143;
        Tue, 27 Jan 2026 07:45:07 -0800 (PST)
Received: from localhost ([102.91.81.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24bedsm37283979f8f.17.2026.01.27.07.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:45:06 -0800 (PST)
Date: Tue, 27 Jan 2026 16:45:13 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/1] Allow reworking with a file after deciding on all its
 hunks
Message-ID: <9b21cb901ab14397af94b8ed2d09da1a9a6d862b.1769522219.git.abrahamadekunle50@gmail.com>
References: <cover.1769522219.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769522219.git.abrahamadekunle50@gmail.com>

After deciding on all hunks in a file, the interactive session
advances automatically to the next file if there is another,
or the process ends.

Now the process does not advance automatically. A user can choose to
go to the next file by pressing '>' or the previous file by pressing '<',
before or after deciding on all hunks in the current file.

After all hunks have been decided in a file, a prompt appears,
which allow the user to still rework with the file by applying
the options available in the permit set for that hunk, and
after all the decisions, the user presses 'q' to submit.

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
Changes in v2:
=============
- Added '<' and '>' to the permit set
- All patches are now applied after all decisions in all files have been
  made by submitting with 'q'.

 add-patch.c | 139 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 102 insertions(+), 37 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 173a53241e..edb2fab3fd 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1418,6 +1418,8 @@ N_("j - go to the next undecided hunk, roll over at the bottom\n"
    "e - manually edit the current hunk\n"
    "p - print the current hunk\n"
    "P - print the current hunk using the pager\n"
+   "> - go to the next file\n"
+   "< - go to the previous file\n"
    "? - print help\n");
 
 static size_t dec_mod(size_t a, size_t m)
@@ -1441,6 +1443,17 @@ static bool get_first_undecided(const struct file_diff *file_diff, size_t *idx)
 	return false;
 }
 
+static size_t get_file_diff_index(struct add_p_state *s, struct file_diff *file_diff) {
+	size_t idx = 0;
+	for (size_t i = 0; i < s->file_diff_nr; i++) {
+		if (s->file_diff + i == file_diff) {
+			idx = i;
+			break;
+		}
+	}
+	return idx;
+}
+
 static int patch_update_file(struct add_p_state *s,
 			     struct file_diff *file_diff)
 {
@@ -1448,9 +1461,10 @@ static int patch_update_file(struct add_p_state *s,
 	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
 	struct hunk *hunk;
 	char ch;
-	struct child_process cp = CHILD_PROCESS_INIT;
 	int colored = !!s->colored.len, quit = 0, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
+	size_t file_diff_index = get_file_diff_index(s, file_diff);
+	int all_decided = 0;
 
 	/* Empty added files have no hunks */
 	if (!file_diff->hunk_nr && !file_diff->added)
@@ -1467,7 +1481,9 @@ static int patch_update_file(struct add_p_state *s,
 			ALLOW_GOTO_NEXT_UNDECIDED_HUNK = 1 << 3,
 			ALLOW_SEARCH_AND_GOTO = 1 << 4,
 			ALLOW_SPLIT = 1 << 5,
-			ALLOW_EDIT = 1 << 6
+			ALLOW_EDIT = 1 << 6,
+			ALLOW_GOTO_PREVIOUS_FILE = 1 << 7,
+			ALLOW_GOTO_NEXT_FILE = 1 << 8
 		} permitted = 0;
 
 		if (hunk_index >= file_diff->hunk_nr)
@@ -1499,8 +1515,7 @@ static int patch_update_file(struct add_p_state *s,
 		/* Everything decided? */
 		if (undecided_previous < 0 && undecided_next < 0 &&
 		    hunk->use != UNDECIDED_HUNK)
-			break;
-
+				all_decided = 1;
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
@@ -1548,6 +1563,16 @@ static int patch_update_file(struct add_p_state *s,
 				permitted |= ALLOW_EDIT;
 				strbuf_addstr(&s->buf, ",e");
 			}
+			if (file_diff_index >= 0 &&
+				file_diff_index < s->file_diff_nr - 1) {
+				permitted |= ALLOW_GOTO_NEXT_FILE;
+				strbuf_addstr(&s->buf, ",>");
+			}
+			if (file_diff_index > 0 &&
+				file_diff_index <= s->file_diff_nr - 1) {
+				permitted |= ALLOW_GOTO_PREVIOUS_FILE;
+				strbuf_addstr(&s->buf, ",<");
+			}
 			strbuf_addstr(&s->buf, ",p,P");
 		}
 		if (file_diff->deleted)
@@ -1566,6 +1591,9 @@ static int patch_update_file(struct add_p_state *s,
 						: 1));
 		printf(_(s->mode->prompt_mode[prompt_mode_type]),
 		       s->buf.buf);
+		if (all_decided)
+			printf(_("\n%s All hunks decided. What now? "),
+				s->s.prompt_color);
 		if (*s->s.reset_color_interactive)
 			fputs(s->s.reset_color_interactive, stdout);
 		fflush(stdout);
@@ -1618,7 +1646,24 @@ static int patch_update_file(struct add_p_state *s,
 		} else if (ch == 'q') {
 			quit = 1;
 			break;
-		} else if (s->answer.buf[0] == 'K') {
+		} else if (s->answer.buf[0] == '>') {
+			if (permitted & ALLOW_GOTO_NEXT_FILE) {
+				quit = 0;
+				break;
+			} else {
+				err(s, _("No next file"));
+				continue;
+			}
+		} else if (s->answer.buf[0] == '<') {
+			if (permitted & ALLOW_GOTO_PREVIOUS_FILE) {
+				quit = 2;
+				break;
+			} else {
+				err(s, _("No previous file"));
+				continue;
+			}
+		}
+		else if (s->answer.buf[0] == 'K') {
 			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
 				hunk_index = dec_mod(hunk_index,
 						     file_diff->hunk_nr);
@@ -1775,33 +1820,6 @@ static int patch_update_file(struct add_p_state *s,
 		}
 	}
 
-	/* Any hunk to be used? */
-	for (i = 0; i < file_diff->hunk_nr; i++)
-		if (file_diff->hunk[i].use == USE_HUNK)
-			break;
-
-	if (i < file_diff->hunk_nr ||
-	    (!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
-		/* At least one hunk selected: apply */
-		strbuf_reset(&s->buf);
-		reassemble_patch(s, file_diff, 0, &s->buf);
-
-		discard_index(s->s.r->index);
-		if (s->mode->apply_for_checkout)
-			apply_for_checkout(s, &s->buf,
-					   s->mode->is_reverse);
-		else {
-			setup_child_process(s, &cp, "apply", NULL);
-			strvec_pushv(&cp.args, s->mode->apply_args);
-			if (pipe_command(&cp, s->buf.buf, s->buf.len,
-					 NULL, 0, NULL, 0))
-				error(_("'git apply' failed"));
-		}
-		if (repo_read_index(s->s.r) >= 0)
-			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
-						     1, NULL, NULL, NULL);
-	}
-
 	putchar('\n');
 	return quit;
 }
@@ -1813,7 +1831,9 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 	struct add_p_state s = {
 		{ r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
-	size_t i, binary_count = 0;
+	size_t i, j, binary_count = 0;
+	size_t patch_update_result = 0;
+	struct child_process cp = CHILD_PROCESS_INIT;
 
 	init_add_i_state(&s.s, r, o);
 
@@ -1852,11 +1872,56 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 		return -1;
 	}
 
-	for (i = 0; i < s.file_diff_nr; i++)
-		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
+	for (i = 0; i < s.file_diff_nr;) {
+		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr) {
 			binary_count++;
-		else if (patch_update_file(&s, s.file_diff + i))
-			break;
+			i++;
+			continue;
+		}
+		else {
+			patch_update_result = patch_update_file(&s, s.file_diff + i);
+			if (patch_update_result == 0) {
+				i++;
+				continue;
+			}
+			if (patch_update_result == 1)
+				break;
+			if (patch_update_result == 2) {
+				i--;
+				continue;
+			}
+		}
+	}
+	for (i = 0; i < s.file_diff_nr; i++) {
+
+			/* Any hunk to be used? */
+		for (j = 0; j < s.file_diff[i].hunk_nr; j++)
+			if (s.file_diff[i].hunk[j].use == USE_HUNK)
+				break;
+
+		if (j < s.file_diff[i].hunk_nr ||
+	    (!s.file_diff[i].hunk_nr && s.file_diff[i].head.use == USE_HUNK)) {
+			/* At least one hunk selected: apply */
+			strbuf_reset(&s.buf);
+			reassemble_patch(&s, s.file_diff + i, 0, &s.buf);
+
+			discard_index(s.s.r->index);
+			if (s.mode->apply_for_checkout)
+				apply_for_checkout(&s, &s.buf,
+						s.mode->is_reverse);
+			else {
+				setup_child_process(&s, &cp, "apply", NULL);
+				strvec_pushv(&cp.args, s.mode->apply_args);
+				if (pipe_command(&cp, s.buf.buf, s.buf.len,
+						NULL, 0, NULL, 0))
+					error(_("'git apply' failed"));
+			}
+			if (repo_read_index(s.s.r) >= 0)
+				repo_refresh_and_write_index(s.s.r, REFRESH_QUIET, 0,
+								1, NULL, NULL, NULL);
+		}
+
+	}
 
 	if (s.file_diff_nr == 0)
 		err(&s, _("No changes."));
-- 
2.39.5 (Apple Git-154)

