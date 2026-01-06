Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDF0327C08
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700880; cv=none; b=mCQfiEOLSMch3nyifmeNQ7fsxdYT1K9yzVTMedXEA8b6uraOR4f/igxXXSbnvErDLB6xRtA6iC5HkL6q0Z/6Q42XfR/O3alDna1A4tcPTzu4emOSxOxaNPv37l1pmCvsRBlA2Nhwe5La21kZmDVY4ZdCVeQ4gcmJ5W9zRGqKmZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700880; c=relaxed/simple;
	bh=Lg34RI4uqwTZi5opPwDv0AQ+J14eXueIZR2/DP8wuWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aaOcgPMKaphnq8b/cYbcoVj1WzEA/j4YLSSpX2IT9vLEykofEr2wZ44fVSVgsUjLBLL8kxbqWyje8mKm9z4hwKyk3PN12QbV1fKsZOdr45zTfNagbSUydojyJNPjtBQW0boF0vvH+IuGC+bCJqkEE1sD6lPutNNMFFY6VxCQrXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fA6axJ+1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA6axJ+1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so6771775e9.2
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 04:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767700876; x=1768305676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uNUGN+r2/gS9OFxrMaSbSs18/Ll+ZBLDNeDlVMZRuKI=;
        b=fA6axJ+1cFe+gc6jcS1AudcePbHBT2Jy0Vwz3Ii0mFxDNkAqUZIVhKf+wziDly08pg
         hJXv/JQxuiZJGG5HpjTOHnQKXu0vpoQNSaSQkgXp2MNjrT5/4ILQzboBYguM6fQFMcbm
         /aKcrLQlpkBB/zJi0bEAy35qBwpG70IgquarWp626DpQFMLcSswUXZ2TBcwb1mvUxSMf
         XTAGBqKjWNSaaM0XYPTH8UDy8l0NoZ6yfv7qkJ/NiESIs8Yruipwh7nv+AX0LF3PfVLc
         XbM2xXMJEj3Enydauk6ifP/+Fh/PVO5c4b+oG+VVDfeh/gQwHuhyhD0ySHDPCMha/C/G
         p4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767700876; x=1768305676;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNUGN+r2/gS9OFxrMaSbSs18/Ll+ZBLDNeDlVMZRuKI=;
        b=twM2MVpzFn+iLFqvnezNB3jukZJAZOo2l1VR50eMqMl/2X6vJOMn4mv4N30WmHoN6Z
         XGozIToBJRJeC2F3Q3hQ1ZVgTgpVjxA2YhxWbQQVZASPPE6ZlqoF0586kNWVCtFl4eUq
         gnoaFR4nslIpvjFlN76iDKw31fCmYeZFhGy4D4bRdHhJIsi+r2Nz3OqAFwZTNXXt3QKS
         n6WiuTuq8MdCH7XPkwNYezN/ZQTLnkp9AV06Rn09/4S5DAIPvnJImFevu6IpIet2OGqT
         nsN5VBg6WNqBjJWz35ROmF2BKMxYhFwyZ6GoNF74Dphrt+sjbg3naK0q9kCW8HR8horF
         p1Ag==
X-Gm-Message-State: AOJu0YxTzvjSE1MnNikWtm3cC+d5ZW14LylQqL84HvNs3UdB+cF0kJZI
	ylm04JeMAAGnsZa4GBKTZgmdo3nSTTTUNjS9K0nBWioCAlAG+46Xt4IyiHUjX4SwLzo=
X-Gm-Gg: AY/fxX7CyhF4oGxlLVm9jbtj8UjYdKKqEc8YkuH152RAjf46pysC1geANRokxPV6SpM
	QZk2xZCPZBHB8ywT0RiPThYWpXaGxVZc4vRf/hHO5Xyc4RByyoVFbzJ/QSPuAfNiv4qEqPaQq8J
	D3gxY4/B96tY/NJmJyuMZ0+X6cPFCyRUl0BTKSnopoxkvuYX/xTXEgC21g7X73rQce2MupZVnYA
	mIppvZ3ZBHyoBgk1Ro/F16WjpPjiohYClJc1y84hP9cFhkoatmc2i+Rjsaq5zGMTIPtiaQ3K5+e
	6GrZW0O9K+YhgyRBKKaFiIjZDCGLqgQ9bF+vYe+4ASYKpPlA2NSac5n3hoLt67EyccG34mDmK6F
	6OrPoQ4sfWkt+EhbpG/V60ZKAmazoNXNUDSaD0WgLLlC9e8sbdl64WLRwWvdksVytj/Jvd15dcq
	8DAugxo74fJ+oAlMEe
X-Google-Smtp-Source: AGHT+IEf38laRJPbK79NrenyhPNTpjDZJYjZFxTGNo5nDV9ctX3dYUYyzrvJ/e9SkqmI8L0e0nEwig==
X-Received: by 2002:a05:600c:64c5:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47d7f06cc47mr35192615e9.15.1767700871452;
        Tue, 06 Jan 2026 04:01:11 -0800 (PST)
Received: from localhost ([102.91.81.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f620ac8sm39221725e9.0.2026.01.06.04.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:01:11 -0800 (PST)
Date: Tue, 6 Jan 2026 13:01:21 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [GSoC PATCH v6] add -p: show user's hunk decision when selecting
 hunks
Message-ID: <aVz5kf6eLsMZ6WQQ@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVzsltM5imOSvW2G@Adekunles-MacBook-Air.local>

When a user is interactively deciding which hunks to use or skip for
staging, unstaging, stashing etc, there is no way to know the
decision previously chosen for a hunk when navigating through the
previous and next hunks using K/J respectively.

Improve the UI to explicitly show if a user has previously decided to
use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
This will improve clarity and aid the navigation process for the
user.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
Changes in v6:
==============
- Corrected duplicate Reported-by tag

 add-patch.c                | 81 +++++++++++++++++++++-----------------
 t/t3701-add-interactive.sh | 18 ++++-----
 2 files changed, 53 insertions(+), 46 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 173a53241e..a383ea7f45 100644
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
+		N_("Stage mode change%s[y,n,q,a,d%s,?]? "),
+		N_("Stage deletion%s[y,n,q,a,d%s,?]? "),
+		N_("Stage addition%s[y,n,q,a,d%s,?]? "),
+		N_("Stage this hunk%s[y,n,q,a,d%s,?]? ")
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
+		N_("Stash mode change%s[y,n,q,a,d%s,?]? "),
+		N_("Stash deletion%s[y,n,q,a,d%s,?]? "),
+		N_("Stash addition%s[y,n,q,a,d%s,?]? "),
+		N_("Stash this hunk%s[y,n,q,a,d%s,?]? "),
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
+		N_("Unstage mode change%s[y,n,q,a,d%s,?]? "),
+		N_("Unstage deletion%s[y,n,q,a,d%s,?]? "),
+		N_("Unstage addition%s[y,n,q,a,d%s,?]? "),
+		N_("Unstage this hunk%s[y,n,q,a,d%s,?]? "),
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
+		N_("Apply mode change to index%s[y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to index%s[y,n,q,a,d%s,?]? "),
+		N_("Apply addition to index%s[y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to index%s[y,n,q,a,d%s,?]? "),
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
+		N_("Discard mode change from worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard addition from worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from worktree%s[y,n,q,a,d%s,?]? "),
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
+		N_("Discard mode change from index and worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from index and worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard addition from index and worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from index and worktree%s[y,n,q,a,d%s,?]? "),
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
+		N_("Apply mode change to index and worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to index and worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Apply addition to index and worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to index and worktree%s[y,n,q,a,d%s,?]? "),
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
+		N_("Discard mode change from worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard deletion from worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard addition from worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Discard this hunk from worktree%s[y,n,q,a,d%s,?]? "),
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
+		N_("Apply mode change to worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Apply deletion to worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Apply addition to worktree%s[y,n,q,a,d%s,?]? "),
+		N_("Apply this hunk to worktree%s[y,n,q,a,d%s,?]? "),
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for applying."),
@@ -1460,6 +1460,7 @@ static int patch_update_file(struct add_p_state *s,
 	render_diff_header(s, file_diff, colored, &s->buf);
 	fputs(s->buf.buf, stdout);
 	for (;;) {
+		const char *hunk_use_decision = " ";
 		enum {
 			ALLOW_GOTO_PREVIOUS_HUNK = 1 << 0,
 			ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK = 1 << 1,
@@ -1564,8 +1565,14 @@ static int patch_update_file(struct add_p_state *s,
 			      (uintmax_t)(file_diff->hunk_nr
 						? file_diff->hunk_nr
 						: 1));
+		if (file_diff->hunk_nr && hunk->use != UNDECIDED_HUNK) {
+			if (hunk->use == USE_HUNK)
+				hunk_use_decision = _(" (previous decision: use) ");
+			else
+				hunk_use_decision = _(" (previous decision: skip) ");
+		}
 		printf(_(s->mode->prompt_mode[prompt_mode_type]),
-		       s->buf.buf);
+			hunk_use_decision, s->buf.buf);
 		if (*s->s.reset_color_interactive)
 			fputs(s->s.reset_color_interactive, stdout);
 		fflush(stdout);
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 4285314f35..cc3986a9d7 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -527,7 +527,7 @@ test_expect_success 'goto hunk 1 with "g 1"' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y g 1 | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -540,7 +540,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y g1 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -554,7 +554,7 @@ test_expect_success 'navigate to hunk via regex /pattern' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y /1,2 | git add -p >actual &&
 	tail -n 5 <actual >actual.trimmed &&
@@ -567,7 +567,7 @@ test_expect_success 'navigate to hunk via regex / pattern' '
 	_10
 	+15
 	_20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y / 1,2 | git add -p >actual &&
 	tail -n 4 <actual >actual.trimmed &&
@@ -579,11 +579,11 @@ test_expect_success 'print again the hunk' '
 	tr _ " " >expect <<-EOF &&
 	+15
 	 20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
+	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
 	 10
 	+15
 	 20
-	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
+	(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
 	EOF
 	test_write_lines s y g 1 p | git add -p >actual &&
 	tail -n 7 <actual >actual.trimmed &&
@@ -595,11 +595,11 @@ test_expect_success TTY 'print again the hunk (PAGER)' '
 	cat >expect <<-EOF &&
 	<GREEN>+<RESET><GREEN>15<RESET>
 	 20<RESET>
-	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
 	PAGER  10<RESET>
 	PAGER <GREEN>+<RESET><GREEN>15<RESET>
 	PAGER  20<RESET>
-	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
 	EOF
 	test_write_lines s y g 1 P |
 	(
@@ -810,7 +810,7 @@ test_expect_success 'colors can be overridden' '
 	<BOLD>-old<RESET>
 	<BLUE>+new<RESET>
 	<CYAN> more-context<RESET>
-	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
+	<YELLOW>(1/2) Stage this hunk (previous decision: use) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
 	EOF
 	test_cmp expect actual
 '
-- 
2.39.5 (Apple Git-154)

