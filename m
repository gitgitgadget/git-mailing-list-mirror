Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B084187346
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767524569; cv=none; b=CTAE9XuqSDEW4JInU5METy27CzjJCtz8fvedkKVmmAXk3+uqb7f4tl+OskW7F4YYcxhBvLeI6jK4zoclQCWKf/mbUNlPHBGQbj+NE6lsJDUW+Dde3slaX23h46PHkadUHUtlO+PYQzmQpZ0pR7CVzc8hHyQmIhlOqUIERqizi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767524569; c=relaxed/simple;
	bh=uw6oVgeEELG6rtFjScWIXO3SJvkIOwr8UENl9SBfGI4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GUWhK69zANCePXADIwSlLhMHn1ncBXGxkN2322NyXe+Uyhq2hHEAZ1Dt0LtJWkelW/RZbGQ+s3yVrNVV36ySTIRHgVdcJuRiyfsxE5If0YESAMD8LZWOpd98SI6IKY2KmKDfRdJZrMspAi96tbx28Ay2v5bDOKS8kHmYLAMY+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHTTU1i2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHTTU1i2"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so6258910f8f.2
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 03:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767524565; x=1768129365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Lr3wqUAzKFOM70RSl6jQOjrnvA4/ZyC3tXSFCj84hs=;
        b=KHTTU1i2pPe5yVhjVycbHTGymTchkfBLabgQNxVmlE+xFGqfUu12zysvCtJ+1jxVUS
         huEMBShtEhVD8WX+CPxGRCGcGlFsojXnlTpJEICjY6QB9YJFxAvKS42W6S8wZK8O0cBG
         lUqpryx0oDky5aAdKVXCKKm22r91mIZcrKk3kJKW6azy+dnkxB74y72/z5A0xwaFS5oD
         /q67BNhqjXyFndRfqa4qPu357l1D3HResMfEfWP9jonXTBh4e8Sb7m1qxmCMChJGIeFj
         TlAz0GsALXUpFHocAkQQs21bORv8mrzi+jwHlop12OHYK/MUDq5/gdtIM/N/9Tk8QxkE
         IWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767524565; x=1768129365;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Lr3wqUAzKFOM70RSl6jQOjrnvA4/ZyC3tXSFCj84hs=;
        b=VLpLoHT5IEBaXKbgylkodYvxlQQuojeOWlBvoE90BrND6Pcefls8xqpIfkZJCC3JQd
         9gHjiAXh7Aau8RkeOToKRBfLmyYbQa+MyZ1P3LmNa+UmIgT7UqyauuvLGxH0ivJt04ZO
         aNAEZAxmSafjkQqZMS8i78iFM/DaCksqaJt5caLv4plxVOUx+MIf0WnlH3oEqqMEmHGZ
         E2MvChYdExp1dZsznvCXrrRwxOB0HH27QnWfJ/0jTYoXwLsQv6S01Lp8ya9sqUvnEV7X
         TgXr5paK0u3bMQcnthVGeVCmWpJKPhVqCvI+kOl/SvLrxRTZBRa3pkWymv6RW3Y612Y3
         fNQQ==
X-Gm-Message-State: AOJu0YxK9UoBuaeg20AnPgi+7pQSvZ0Qo6m6MlA1ogPRw0sFi2iGBaYB
	BCE19Mj5pEGHJavIpr/I/Jirktd01zbYGXeRVUx1/nMYh8/Koch6z67fZ0mLE5MA
X-Gm-Gg: AY/fxX63RxHAEs1u4fJUWBp79nik6qGU7OQuHXZ6Y8+6P05ZcRJY2ZxvP62wA/eq25F
	JqAxQsdnId8I3loL2Jt1FlGoLk8PLyIPF7/0VodSEWUixlmHQ38+nOw+CVbAoDCLANvhI89Pz/B
	6TNNEAeF0LhJnDMF+fxEXf4KNeaHeK9ahTegRzHtazFlVVLJOMFod1p0iRzVD5wyFCLyDG95UV0
	3VrovILpbmsFv2gsKZ6kxx1gUAEGeCU+y4z4tdfqbk0TRQc4NiGe34FmvgluTrA8mwnPeMVsZZn
	21cNfwUS0X3GuXVbwdnTTNBPplvGZOJbahaKiGiGyXBz9RD8cnE+0Zn474GF5OE3CoCozohbDHU
	MVXNDMb9QIk2hW2vFFHVVVprJWuNLaGs4kE/F+jOpen4/jOgI2LwuD5nv0fudZfG6ZpOiKNittf
	7aWLvlWqnknWNzbQ==
X-Google-Smtp-Source: AGHT+IE6vYrT6SsaGO2ruVgnw21wJHq4FVaSJIBrC5C2Qq6uoccIqgZctN3u9555JTNdtvfpDq4kuA==
X-Received: by 2002:a05:6000:2881:b0:430:96bd:411b with SMTP id ffacd0b85a97d-4324e70111dmr52667352f8f.58.1767524565190;
        Sun, 04 Jan 2026 03:02:45 -0800 (PST)
Received: from localhost ([102.88.77.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea8311fsm94655167f8f.28.2026.01.04.03.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 03:02:44 -0800 (PST)
Date: Sun, 4 Jan 2026 12:02:55 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v4] add -p: show user's hunk decision when selecting
 hunks
Message-ID: <aVpI36nPuZAEchuM@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVgTmYhosEiGG3th@Adekunles-MacBook-Air.local>

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
Changes in v4:
--------------
- Modified the test case
  "expecting success of 3701.50 'print again the hunk (PAGER)'"
  which was skipped in v3 due to the test being run on a MacOs

 add-patch.c                | 84 +++++++++++++++++++++-----------------
 t/t3701-add-interactive.sh | 18 ++++----
 2 files changed, 56 insertions(+), 46 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 173a53241e..bc7a340d21 100644
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
@@ -1448,6 +1448,7 @@ static int patch_update_file(struct add_p_state *s,
 	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
 	struct hunk *hunk;
 	char ch;
+	const char *hunk_use_decision;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int colored = !!s->colored.len, quit = 0, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
@@ -1564,8 +1565,17 @@ static int patch_update_file(struct add_p_state *s,
 			      (uintmax_t)(file_diff->hunk_nr
 						? file_diff->hunk_nr
 						: 1));
+		if (file_diff->hunk_nr) {
+			if (hunk->use == USE_HUNK)
+				hunk_use_decision = _(" (previous decision: use) ");
+			else if (hunk->use == SKIP_HUNK)
+				hunk_use_decision = _(" (previous decision: skip) ");
+			else
+				hunk_use_decision = " ";
+
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

