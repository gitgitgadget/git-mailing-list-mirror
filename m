Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46545500975
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884818; cv=none; b=SzR3FW9VJ+PuLD9lrddm8vY6rLP+LP3xnxab77LMfx7Cx/rqduGahojmpa3HfsSMDA6yXHQ5amA+Z7TjB6LnR07vA6dAOmfXMdgDYDJ/Th06jeUCVhCYSR9Us8KV5ui+7spmJ+b4/PCi8kP//qjLtTtUoA6E4VHnVovqcH2haOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884818; c=relaxed/simple;
	bh=qKPFNhjj+d+k5IMawnKkkASKmHygLOiICdOORt76t2o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sUxO79nDteqKIBGMgRwlJ6HhaG5fG80DoujGWex5cycaJ8binzF/IpbltAHxvvruAs66qhz0OVwR2HPf3Bel5wfwiYO6lL9DDD6v5gkbXahLC131ILmE0dtHfy6u2YJSCTXa0H2owcM/1EdoF2VN44BX0MbWO5LYD1ORUJCZ/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkYabA60; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkYabA60"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so2421681f8f.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 07:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767884814; x=1768489614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2W58e4Ua7j1nRd+5kQbZWsnXX/IwgTnj3JFQ8Ur6T9U=;
        b=gkYabA60N+AiQobqQRaQ5ENnjDG4dIYAvIgO9JydjHTOyf5T2rmdd9rBBB8nlUxfhM
         Vv+yQperVbxFWZsHKkqm7ZDOQP7T7K7ysbkT2tEgHroqsZnaDIH6U8ePQ0d0FlmNq6A8
         3ItxKb7TqJzQwMlwviHmp3MicWDfpbdyI84+UEWDTne3T1Z3gRiZf0NjFZkbg1Fx2t6a
         d8x0z/81Hi14S+SkeTg5hvYlmx0MWMsbhjc7oniTRX7ipOtQguHLpZK0KDJbc7wx65kH
         lHvzdTSuq87vn8SzhDL6YqA65+CCdAd8WkA+E7qYlsJhrRhpzxtDjt9plgGuPmku3b75
         JhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767884814; x=1768489614;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W58e4Ua7j1nRd+5kQbZWsnXX/IwgTnj3JFQ8Ur6T9U=;
        b=Nc8wmynyEePF7Jnx2Pz0ppjCdvkB86iK8c/OL4YTd7G06HHWLtFYEZDkBGcxAYaCg2
         ddwUSrZJ3AErGK4SrRpc2sE2r5otKmWlUWmhtnXBViUSYOkBEmtyeD7xu8sOluuo1DkL
         nwlzAqTF9ewPGEB11Xdn+TmtlDNLGdq9vcCW3fUQMBKr4hCmYDX94OFd5zlgtRttFuBM
         3ov7HN/xX0tyctNaGk0vv8nrE2RamTJo+AchCHJPum8w1w3mGySbCs1upKx+btlUMUMJ
         lZw9kOdjm1Y2Ac24qELtjyEYVj0R7Ovrn1sjVyY75Y27NAEGWU3VVqzE/SfRe/F5roH3
         +M4w==
X-Gm-Message-State: AOJu0Yyk3dj112j//3GnYI06I6oK2bp2YVY6RSEvHQ2WqFwEtRt74koc
	EtNpSLADkgA9Gd9jTf5nCDsRZw56TRcgBaz4Qjntp1G9p/pB9N7IKzDU5ZxINvxs
X-Gm-Gg: AY/fxX6O+WhqG7zVrKtUwY+rdfB1yVEbNMuDFEXrrHjv5hvN78BDogTC/OQpLp3WISp
	7wqqgZ6eG6mONsaU/TnRQnq9DfiWhp74YNZTPYlKe1G43tp7jV+YNDkTkMJMoWeHj+vP7cpraK0
	2qJLcENlkiV8ris0trOiixD2l7nAkQOFW6fZ68YSWm/hIMhrg55BB0kD6Qp7U0GvlqsPpiVQoHF
	rQSevouwaIyGQ5JdMlwqGviafcLcQCmwan/T+iHtJux886kvgvt03Huo3MQStrTDnv1K4W48Pi6
	RZs6ajjNE0ZS4OOHO74X347KrON/v1gHPjU68TbZGArLvUrj9df1jB34jkoTg/d/yAuswKA3Mk+
	rnfTTLVOmcmgOM/y6zPU53PoGi7Efvb4sR38h5Mc6ymwF5+YmrPCp9TCOJewoqaof5QvrexgJWC
	R1AJu8XG/jMBtYSXAf2f+Z3oZQ
X-Google-Smtp-Source: AGHT+IGMQLnrtUqmnkGNE3M5Q3zh/OQVqlcCuAD09mxGYuISAdx/vRBmSXtcYc/etZg+U27Mbytl/A==
X-Received: by 2002:a05:6000:2882:b0:431:907:f308 with SMTP id ffacd0b85a97d-432c37a375cmr7982222f8f.61.1767884813935;
        Thu, 08 Jan 2026 07:06:53 -0800 (PST)
Received: from localhost ([102.88.77.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e199bsm16860290f8f.16.2026.01.08.07.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 07:06:53 -0800 (PST)
Date: Thu, 8 Jan 2026 16:07:04 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [GSoC PATCH v7] add -p: show user's hunk decision when selecting
 hunks
Message-ID: <aV_IGCld5T_dBxTs@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVz5kf6eLsMZ6WQQ@Adekunles-MacBook-Air.local>

When a user is interactively deciding which hunks to use or skip for
staging, unstaging, stashing etc, there is no way to know the
decision previously chosen for a hunk when navigating through the
previous and next hunks using K/J respectively.

Improve the UI to explicitly show if a user has previously decided to
use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
This will improve clarity when and aid the navigation process for the
user.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
Changes in v7:
==============
- changed hunk selection state message to reduce prompt width
- Removed redundant `file_diff->hunk_nr` in hunk->use check
- Made the prompt mode more readable by retaining the space before choices
- set `hunk_use_decision` to empty string if `hunk->use == UNDECIDED` to match
  the prompt mode.

 add-patch.c                | 81 +++++++++++++++++++++-----------------
 t/t3701-add-interactive.sh | 18 ++++-----
 2 files changed, 53 insertions(+), 46 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 173a53241e..df8f2e6d74 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -42,10 +42,10 @@ static struct patch_mode patch_mode_add = {
 	.apply_args = { "--cached", NULL },
 	.apply_check_args = { "--cached", NULL },
 	.prompt_mode = {
-		N_("Stage mode change [y,n,q,a,d%s,?]? "),
-		N_("Stage deletion [y,n,q,a,d%s,?]? "),
-		N_("Stage addition [y,n,q,a,d%s,?]? "),
-		N_("Stage this hunk [y,n,q,a,d%s,?]? ")
+		N_("Stage mode change%s [y,n,q,a,d%s,?]? "),
+		N_("Stage deletion%s [y,n,q,a,d%s,?]? "),
+		N_("Stage addition%s [y,n,q,a,d%s,?]? "),
+		N_("Stage this hunk%s [y,n,q,a,d%s,?]? ")
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for staging."),
@@ -64,10 +64,10 @@ static struct patch_mode patch_mode_stash = {
 	.apply_args = { "--cached", NULL },
 	.apply_check_args = { "--cached", NULL },
 	.prompt_mode = {
-		N_("Stash mode change [y,n,q,a,d%s,?]? "),
-		N_("Stash deletion [y,n,q,a,d%s,?]? "),
-		N_("Stash addition [y,n,q,a,d%s,?]? "),
-		N_("Stash this hunk [y,n,q,a,d%s,?]? "),
+		N_("Stash mode change%s [y,n,q,a,d%s,?]? "),
+		N_("Stash deletion%s [y,n,q,a,d%s,?]? "),
+		N_("Stash addition%s [y,n,q,a,d%s,?]? "),
+		N_("Stash this hunk%s [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for stashing."),
@@ -88,10 +88,10 @@ static struct patch_mode patch_mode_reset_head = {
 	.is_reverse = 1,
 	.index_only = 1,
 	.prompt_mode = {
-		N_("Unstage mode change [y,n,q,a,d%s,?]? "),
-		N_("Unstage deletion [y,n,q,a,d%s,?]? "),
-		N_("Unstage addition [y,n,q,a,d%s,?]? "),
-		N_("Unstage this hunk [y,n,q,a,d%s,?]? "),
+		N_("Unstage mode change%s [y,n,q,a,d%s,?]? "),
+		N_("Unstage deletion%s [y,n,q,a,d%s,?]? "),
+		N_("Unstage addition%s [y,n,q,a,d%s,?]? "),
+		N_("Unstage this hunk%s [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for unstaging."),
@@ -111,10 +111,10 @@ static struct patch_mode patch_mode_reset_nothead = {
 	.apply_check_args = { "--cached", NULL },
 	.index_only = 1,
 	.prompt_mode = {
-		N_("Apply mode change to index [y,n,q,a,d%s,?]? "),
-		N_("Apply deletion to index [y,n,q,a,d%s,?]? "),
-		N_("Apply addition to index [y,n,q,a,d%s,?]? "),
-		N_("Apply this hunk to index [y,n,q,a,d%s,?]? "),
+		N_("Apply mode change to index%s [y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to index%s [y,n,q,a,d%s,?]? "),
+		N_("Apply addition to index%s [y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to index%s [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for applying."),
@@ -134,10 +134,10 @@ static struct patch_mode patch_mode_checkout_index = {
 	.apply_check_args = { "-R", NULL },
 	.is_reverse = 1,
 	.prompt_mode = {
-		N_("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard addition from worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard mode change from worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Discard addition from worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from worktree%s [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for discarding."),
@@ -157,10 +157,10 @@ static struct patch_mode patch_mode_checkout_head = {
 	.apply_check_args = { "-R", NULL },
 	.is_reverse = 1,
 	.prompt_mode = {
-		N_("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard deletion from index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard addition from index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard this hunk from index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard mode change from index and worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from index and worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Discard addition from index and worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from index and worktree%s [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for discarding."),
@@ -179,10 +179,10 @@ static struct patch_mode patch_mode_checkout_nothead = {
 	.apply_for_checkout = 1,
 	.apply_check_args = { NULL },
 	.prompt_mode = {
-		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply addition to index and worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply this hunk to index and worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply mode change to index and worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to index and worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Apply addition to index and worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to index and worktree%s [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for applying."),
@@ -202,10 +202,10 @@ static struct patch_mode patch_mode_worktree_head = {
 	.apply_check_args = { "-R", NULL },
 	.is_reverse = 1,
 	.prompt_mode = {
-		N_("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard deletion from worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard addition from worktree [y,n,q,a,d%s,?]? "),
-		N_("Discard this hunk from worktree [y,n,q,a,d%s,?]? "),
+		N_("Discard mode change from worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Discard addition from worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from worktree%s [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for discarding."),
@@ -224,10 +224,10 @@ static struct patch_mode patch_mode_worktree_nothead = {
 	.apply_args = { NULL },
 	.apply_check_args = { NULL },
 	.prompt_mode = {
-		N_("Apply mode change to worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply deletion to worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply addition to worktree [y,n,q,a,d%s,?]? "),
-		N_("Apply this hunk to worktree [y,n,q,a,d%s,?]? "),
+		N_("Apply mode change to worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Apply addition to worktree%s [y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to worktree%s [y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for applying."),
@@ -1460,6 +1460,7 @@ static int patch_update_file(struct add_p_state *s,
 	render_diff_header(s, file_diff, colored, &s->buf);
 	fputs(s->buf.buf, stdout);
 	for (;;) {
+		const char *hunk_use_decision = "";
 		enum {
 			ALLOW_GOTO_PREVIOUS_HUNK = 1 << 0,
 			ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK = 1 << 1,
@@ -1564,8 +1565,14 @@ static int patch_update_file(struct add_p_state *s,
 			      (uintmax_t)(file_diff->hunk_nr
 						? file_diff->hunk_nr
 						: 1));
+		if (hunk->use != UNDECIDED_HUNK) {
+			if (hunk->use == USE_HUNK)
+				hunk_use_decision = _(" (was: y)");
+			else
+				hunk_use_decision = _(" (was: n)");
+		}
 		printf(_(s->mode->prompt_mode[prompt_mode_type]),
-		       s->buf.buf);
+			hunk_use_decision, s->buf.buf);
 		if (*s->s.reset_color_interactive)
 			fputs(s->s.reset_color_interactive, stdout);
 		fflush(stdout);
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 4285314f35..5ce9c6dd60 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -527,7 +527,7 @@ test_expect_success 'goto hunk 1 with "g 1"' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y g 1 | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -540,7 +540,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y g1 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -554,7 +554,7 @@ test_expect_success 'navigate to hunk via regex /pattern' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y /1,2 | git add -p >actual &&
 	tail -n 5 <actual >actual.trimmed &&
@@ -567,7 +567,7 @@ test_expect_success 'navigate to hunk via regex / pattern' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y / 1,2 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -579,11 +579,11 @@ test_expect_success 'print again the hunk' '
 	tr _ " " >expect <<-EOF &&
 	+15
 	 20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
 	 10
 	+15
 	 20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y g 1 p | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -595,11 +595,11 @@ test_expect_success TTY 'print again the hunk (PAGER)' '
 	cat >expect <<-EOF &&
 	<GREEN>+<RESET><GREEN>15<RESET>
 	 20<RESET>
-	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
 	PAGER  10<RESET>
 	PAGER <GREEN>+<RESET><GREEN>15<RESET>
 	PAGER  20<RESET>
-	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
 	EOF
 	test_write_lines s y g 1 P |
 	(
@@ -810,7 +810,7 @@ test_expect_success 'colors can be overridden' '
 	<BOLD>-old<RESET>
 	<BLUE>+new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
+	<YELLOW>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
 	EOF
 	test_cmp expect actual
 '
-- 
2.39.5 (Apple Git-154)

