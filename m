Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15D31D399
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767697552; cv=none; b=EiB1IuAP3nl12JN3L7jGeRJ8GniipCAwGAvmhipiGTfmk/37bz9QMye1mod2RSedGYDsRVCjAYzX2IUFd19aWHD07PiyjX1rv0fbdhT/B72oxqRcFaVLjwZWZau0Cv2FrGdiHmoAOwLvryvrgfXkdyICWRwp7HZnqPTRiiTnSR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767697552; c=relaxed/simple;
	bh=fJggAPDLVrZj8P/NdVFVpUjHNJmJx9jwGcZqVUsxj5g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mRxIuU0Gg8CirKJTYD+SnbGKfHI7uS4Fvd45EKqNJovOvsejgb0KsC3J1Xqx4XBcCzVKN02qLdUOTyVgk3jPrlS1UPGtD5EF7/EyiAkmv5blAjkfmhhmt7I1g9TL2ODAmkNrwLhn7KI0tnQWIvvLvuup9CHQYmynL/I+M8m7xDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br03YUFO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br03YUFO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so5125215e9.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 03:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767697549; x=1768302349; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PwJrqbVLyCfIdEEYRsTjLS3BiG+DjwQyyT3vGSYZ3ZQ=;
        b=br03YUFOQMzwrl218bOhNfuwD/4w8LN0dG+zbKQiYoVmLK5yXA84Ux8RDSuNETPWcW
         fPJJPPTjcX3TSyTMQlVtw5r4pkjyVLVR8Gz8b9nr8/PlocBjxJlj+bciCSQ20662oIHS
         wyjyKXYt33E8T93ijs5SAuomBHr2avUt97zUTLRx1G2abEmBtO6wDR3/JOx/bvvLi4Ng
         UWC9WH4BU/EtXYsQX1xNZuqUMdBbV9oZI7ubil9Hec4BGNetpmreOYpFZy99TvqrdOV/
         UaHHbsrt3MZqPbxuC/qwJ5XbjgB56PXgVfdRBGHqPHH5l9ROi7gWZWEHVo0n2xdRVa38
         WvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767697549; x=1768302349;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PwJrqbVLyCfIdEEYRsTjLS3BiG+DjwQyyT3vGSYZ3ZQ=;
        b=HqC4l+4wpvGQpGzUReN/e5mGHXctMl5DNjDPsryO0GkdQ5U8gTflrbvDdSxY54z9G4
         RXrj9Es6JmZWDyQRh0yIoXmIZnMLJpPCNBooO9AYWPtr6miFi8yjIUDw74c1CLzTppH8
         FbpRUXLUd57f91PrWisWfb0J704sgllyj95OudSh+D1PE8oW0BcbusBIWkUPjKc4GXBy
         CBjuJbxx/L6r9au7t8OeYoO6/rkMyHXqyzcuW6XGFPQvgYGbSspYMPhKYxBqCT6vtez5
         bQSiYMn8gU2uZCSilBNxn1kVhlD14Vj/1YsyykaAtDK6NmbDHsdgiwCz72AZ97a5r4B0
         n0Lg==
X-Gm-Message-State: AOJu0YwE+uk11fiL2CCD8pgaf20oIxzMynUKNl/lZ+wvuAHqNY+dVeqh
	vVQX51PWMzwN4/ccvwnHFFpPvK3zTFC2sFpPPcCrcgU20WhzlTTRxHZ3tLaY/0Lg
X-Gm-Gg: AY/fxX6PiJyaiiiaiZlRBtRZm/BiEvTqZc98AT2irGbcCkMnl23yfGLFi03kjVdAljq
	ybQbeQu9/hg+gGGe20fvHzMBckmhfZRBrYphit2soyHo2eQm3JNRM1R2shODroJQlfGW8Wl9HxD
	xDD14qXCps4JNdJiOmKZbglRXZ++UTnoW5PWfK1bFiz4ORGPWknrEVFs3UHk6mcCvciarmtqQyB
	OZoFwUy1ak1SlgfYVsIgR5Vnic3wdZ7Pm/BPKn7TzdW8yJVRlvvyyZUju28LuvJUHNP0gRseQh7
	ESpWDyvv3xnVjg9jinDob7fo16KIVxyR0vfbGiYubQcVEvybQrIphiAXDkcbGTnZUc+5PF2daaU
	ROtrf7rqP6wcO5TLz0Ck2rOCa7OeYwb6jbydm7aNO/S4KBaueJ9Py6eKO2RKMWKXrRJnsHwZPDe
	fh4Ef7kDmMah8MaCTs
X-Google-Smtp-Source: AGHT+IGaNzfJU4HCvl92yeHn9YDZlOuwYUOnIxJg0MzS/8XfooEtaJGu/IY3uqYtXdo/+iVTLQt7cA==
X-Received: by 2002:a05:600c:1384:b0:47a:810f:1d06 with SMTP id 5b1f17b1804b1-47d7f0651c9mr26392755e9.4.1767697548493;
        Tue, 06 Jan 2026 03:05:48 -0800 (PST)
Received: from localhost ([102.91.81.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f686sm36852845e9.3.2026.01.06.03.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:05:48 -0800 (PST)
Date: Tue, 6 Jan 2026 12:05:58 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [GSoC PATCH v5] add -p: show user's hunk decision when selecting
 hunks
Message-ID: <aVzsltM5imOSvW2G@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVpI36nPuZAEchuM@Adekunles-MacBook-Air.local>

When a user is interactively deciding which hunks to use or skip for
staging, unstaging, stashing etc, there is no way to know the
decision previously chosen for a hunk when navigating through the
previous and next hunks using K/J respectively.

Improve the UI to explicitly show if a user has previously decided to
use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
This will improve clarity when and aid the navigation process for the
user.

Reported-by: Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
Changes in v5:
===============
- Modified code to handle uninitialized variable `hunk_use_decision`
  observed by SZEDER Gábor.
- Removed an unnecessary empty line

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

