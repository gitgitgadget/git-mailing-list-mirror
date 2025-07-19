Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30C269D11
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928120; cv=none; b=m8enrFmCHeSDHl+ZDNZNyyRK0rDBbqm8PpWHevmlBuFqDvqGKn/t4MHRqbQr64SVb0dLFGv+6OUe6S5YA5/cj3g695/NVbIBXKvUFKFRRjWyJsc1VbTZvCpcew4FJ2j5R1dfDQC0M71s57Tqg6bOeBIDImXZJHgoCTZweAfEqcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928120; c=relaxed/simple;
	bh=Z60OfPM9em5e8Ij2reOQeZedqFU+OWyuhnRk/vYfJDg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QQY7HqhsUwIajitOvwbcGRNefHIgBmDMEPjo66J5pO7lZUo7D893ziY4RhvCEiB9hMDHfbWIJKDFZpYmx6GxAYwdUHO854dOJs5A61MZ/PNICcr3PuMIkTg05K1tUbC1n3M9IdRf6C+KEP/lQLp5Hu3yH/5g4TKUgjRc53JBhOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSmkmC0Y; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSmkmC0Y"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d3f72391so28793205e9.3
        for <git@vger.kernel.org>; Sat, 19 Jul 2025 05:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752928117; x=1753532917; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTq4/KMaMX+XFLvZIcbb012jl178PexolS5j8q5Yh64=;
        b=FSmkmC0YZqGsKBTiyju3ikBJ2CsnpTQW46RVPt/Dx9F0XpK8E3BT0PZanwy6Pk/B0l
         /UPBq1ZcKO6pVDbgZb4s6ryJAEgW9gyLTRGsf9/4ud8MIaCvFSarh4ERIP60XnrackL7
         g8J1mNpDuc8UiVyeYSC+IOBHeFYtcp2/EEwVKkX7aFYIBAzA/TdAjsxRgcSdwQEg0aXa
         y97ie6EbbbkLoptTd76i6Hz6Q52324dIwtS/X4agVI9I9HZ8QqMeiVA+GQDA2Tm+X0WG
         BlOmvh+JOdBB9fdZ1er1PZ+fqWxtzoORGqg/EdnqH+XETbmj2UvOJBtouALtfyJ/3WuC
         4faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752928117; x=1753532917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTq4/KMaMX+XFLvZIcbb012jl178PexolS5j8q5Yh64=;
        b=g8/ITftDlBK1Cmg/YxBKCjphPrc947Au0J9gHMQC0gmriUcW5a8nh9/s/+zqALV8oQ
         KIP13J8/gGsERHt8KoZpXZ9ymeNP4tUjVuol0jR6vqB5W+K+KrAzDfyN3f2YJKuJwH1o
         +1PLtwl6h56+dLfRrTwHTtYLsOCyAdHnLGW5875x2QabJQMyo9FwVRnQb48BOi4ncHxm
         V4E8uTZ7A39oz9XxC76JJJww5BNRPbpr9PzGP4d0VqBYRMDYNpTjBuHOE+Hs9RPi8hmt
         JtsO0Sie7DAS8MrsdpDCXqd18QS55+kPbx5VZu3eQ2p7g9HAAlperTaLHaS0PWVtQBnb
         aTTQ==
X-Gm-Message-State: AOJu0Yy0ywV4LHFjRIOpQi36H6gMkxOpCaGiJsW7Ext6Q25Tn6we/5Ez
	G6zbAntSPlV61/DvJfI49NuHTKWcAfGF5/jw6m+gZZsr28giBkS28UryaLngUg==
X-Gm-Gg: ASbGncsGyNfAHfNBngADViqPG+oNa76kmf/ODsLKLz71OQ8qDd9RU51j8QHttM/1Nva
	my5vwNJttpm/pXxoa3nXKZ0U8g99TCXMUnrmYTfcJZEai4HGV99oo7ZCPXpxiSNYkuhLB1ad43a
	aMN9oeLEE3CqabOTKzzv0ecFyXSoEzQZY/4vY9TRrq1f+KcNOVUDReB69VAm1YtvGl5E2iNeLB6
	8jafNlyaev6FSJ+bQthNxt3dmGCahGwXHuPKsV7ukWhUrgUuHF2tOEbIoX4tziVBqVETnYyBW02
	WV8FUfvRHM5FLTq9XgbvvXUO2mavnBweFz81A7VPHoEbuabSAcZXwR+tb1hk4vmSaHPCBNIB1gr
	PYMBFRVvbKOvhuwgTfciZLeI=
X-Google-Smtp-Source: AGHT+IGYn1jcA00z6xFZ9m1u/z0jb1oBhiYD0fPWDW5wegJc6WSlLo2OvORMCr6Sk6VmfaV5+11PKQ==
X-Received: by 2002:a05:600c:4750:b0:456:1ab0:d567 with SMTP id 5b1f17b1804b1-4562e365809mr124134955e9.1.1752928116523;
        Sat, 19 Jul 2025 05:28:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e88474fsm107843495e9.22.2025.07.19.05.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 05:28:36 -0700 (PDT)
Message-Id: <bbb2bc7082baaa11fd428efb375c5d142f82e7fd.1752928113.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
References: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
	<pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Jul 2025 12:28:30 +0000
Subject: [PATCH v4 1/4] t: use test_grep in t3701 and t4055
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Christian Couder <christian.couder@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

From: Leon Michalak <leonmichalak6@gmail.com>

As a preparatory clean-up, use the "test_grep" test utility instead of
regular "grep" which provides better debug information if tests fail.

Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
---
 t/t3701-add-interactive.sh | 48 +++++++++++++++++++-------------------
 t/t4055-diff-context.sh    | 28 +++++++++++-----------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b8a05d95f3f1..b088ee141ff4 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -63,7 +63,7 @@ test_expect_success 'setup (initial)' '
 '
 test_expect_success 'status works (initial)' '
 	git add -i </dev/null >output &&
-	grep "+1/-0 *+2/-0 file" output
+	test_grep "+1/-0 *+2/-0 file" output
 '
 
 test_expect_success 'setup expected' '
@@ -86,7 +86,7 @@ test_expect_success 'revert works (initial)' '
 	git add file &&
 	test_write_lines r 1 | git add -i &&
 	git ls-files >output &&
-	! grep . output
+	test_grep ! . output
 '
 
 test_expect_success 'add untracked (multiple)' '
@@ -109,7 +109,7 @@ test_expect_success 'setup (commit)' '
 '
 test_expect_success 'status works (commit)' '
 	git add -i </dev/null >output &&
-	grep "+1/-0 *+2/-0 file" output
+	test_grep "+1/-0 *+2/-0 file" output
 '
 
 test_expect_success 'update can stage deletions' '
@@ -141,7 +141,7 @@ test_expect_success 'revert works (commit)' '
 	git add file &&
 	test_write_lines r 1 | git add -i &&
 	git add -i </dev/null >output &&
-	grep "unchanged *+3/-0 file" output
+	test_grep "unchanged *+3/-0 file" output
 '
 
 test_expect_success 'reject multi-key input' '
@@ -185,7 +185,7 @@ test_expect_success 'setup fake editor' '
 test_expect_success 'bad edit rejected' '
 	git reset &&
 	test_write_lines e n d | git add -p >output &&
-	grep "hunk does not apply" output
+	test_grep "hunk does not apply" output
 '
 
 test_expect_success 'setup patch' '
@@ -198,7 +198,7 @@ test_expect_success 'setup patch' '
 test_expect_success 'garbage edit rejected' '
 	git reset &&
 	test_write_lines e n d | git add -p >output &&
-	grep "hunk does not apply" output
+	test_grep "hunk does not apply" output
 '
 
 test_expect_success 'setup patch' '
@@ -313,8 +313,8 @@ test_expect_success FILEMODE 'stage mode and hunk' '
 	chmod +x file &&
 	printf "y\\ny\\n" | git add -p &&
 	git diff --cached file >out &&
-	grep "new mode" out &&
-	grep "+content" out &&
+	test_grep "new mode" out &&
+	test_grep "+content" out &&
 	git diff file >out &&
 	test_must_be_empty out
 '
@@ -636,7 +636,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
 	printf "%s\n" s e     q n q q |
 	EDITOR=: git add -p &&
 	git diff >actual &&
-	! grep "^+15" actual
+	test_grep ! "^+15" actual
 '
 
 test_expect_success 'split hunk "add -p (no, yes, edit)"' '
@@ -648,7 +648,7 @@ test_expect_success 'split hunk "add -p (no, yes, edit)"' '
 	EDITOR=: git add -p 2>error &&
 	test_must_be_empty error &&
 	git diff >actual &&
-	! grep "^+31" actual
+	test_grep ! "^+31" actual
 '
 
 test_expect_success 'split hunk with incomplete line at end' '
@@ -682,7 +682,7 @@ test_expect_success 'edit, adding lines to the first hunk' '
 	EDITOR=./fake_editor.sh git add -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached >actual &&
-	grep "^+22" actual
+	test_grep "^+22" actual
 '
 
 test_expect_success 'patch mode ignores unmerged entries' '
@@ -696,7 +696,7 @@ test_expect_success 'patch mode ignores unmerged entries' '
 	test_must_fail git merge side &&
 	echo changed >non-conflict.t &&
 	echo y | git add -p >output &&
-	! grep a/conflict.t output &&
+	test_grep ! a/conflict.t output &&
 	cat >expected <<-\EOF &&
 	* Unmerged path conflict.t
 	diff --git a/non-conflict.t b/non-conflict.t
@@ -728,7 +728,7 @@ test_expect_success 'diffs can be colorized' '
 
 	# We do not want to depend on the exact coloring scheme
 	# git uses for diffs, so just check that we saw some kind of color.
-	grep "$(printf "\\033")" output
+	test_grep "$(printf "\\033")" output
 '
 
 test_expect_success 'colors can be overridden' '
@@ -743,7 +743,7 @@ test_expect_success 'colors can be overridden' '
 		-c color.interactive.error=blue \
 		add -i 2>err.raw <input &&
 	test_decode_color <err.raw >err &&
-	grep "<BLUE>Huh (trigger)?<RESET>" err &&
+	test_grep "<BLUE>Huh (trigger)?<RESET>" err &&
 
 	test_write_lines help quit >input &&
 	force_color git \
@@ -863,7 +863,7 @@ test_expect_success 'colorized diffs respect diff.wsErrorHighlight' '
 	printf y >y &&
 	force_color git -c diff.wsErrorHighlight=all add -p >output.raw 2>&1 <y &&
 	test_decode_color <output.raw >output &&
-	grep "old<" output
+	test_grep "old<" output
 '
 
 test_expect_success 'diffFilter filters diff' '
@@ -876,7 +876,7 @@ test_expect_success 'diffFilter filters diff' '
 
 	# avoid depending on the exact coloring or content of the prompts,
 	# and just make sure we saw our diff prefixed
-	grep foo:.*content output
+	test_grep foo:.*content output
 '
 
 test_expect_success 'detect bogus diffFilter output' '
@@ -886,7 +886,7 @@ test_expect_success 'detect bogus diffFilter output' '
 	test_config interactive.diffFilter "sed 6d" &&
 	printf y >y &&
 	force_color test_must_fail git add -p <y >output 2>&1 &&
-	grep "mismatched output" output
+	test_grep "mismatched output" output
 '
 
 test_expect_success 'handle iffy colored hunk headers' '
@@ -896,7 +896,7 @@ test_expect_success 'handle iffy colored hunk headers' '
 	printf n >n &&
 	force_color git -c interactive.diffFilter="sed s/.*@@.*/XX/" \
 		add -p >output 2>&1 <n &&
-	grep "^XX$" output
+	test_grep "^XX$" output
 '
 
 test_expect_success 'handle very large filtered diff' '
@@ -1002,7 +1002,7 @@ test_expect_success 'add -p does not expand argument lists' '
 	# update it, but we want to be sure that our "." pathspec
 	# was not expanded into the argument list of any command.
 	# So look only for "not-changed".
-	! grep -E "^trace: (built-in|exec|run_command): .*not-changed" trace.out
+	test_grep ! -E "^trace: (built-in|exec|run_command): .*not-changed" trace.out
 '
 
 test_expect_success 'hunk-editing handles custom comment char' '
@@ -1072,21 +1072,21 @@ test_expect_success 'setup different kinds of dirty submodules' '
 
 test_expect_success 'status ignores dirty submodules (except HEAD)' '
 	git -C for-submodules add -i </dev/null >output &&
-	grep dirty-head output &&
-	grep dirty-both-ways output &&
-	! grep dirty-otherwise output
+	test_grep dirty-head output &&
+	test_grep dirty-both-ways output &&
+	test_grep ! dirty-otherwise output
 '
 
 test_expect_success 'handle submodules' '
 	echo 123 >>for-submodules/dirty-otherwise/initial.t &&
 
 	force_color git -C for-submodules add -p dirty-otherwise >output 2>&1 &&
-	grep "No changes" output &&
+	test_grep "No changes" output &&
 
 	force_color git -C for-submodules add -p dirty-head >output 2>&1 <y &&
 	git -C for-submodules ls-files --stage dirty-head >actual &&
 	rev="$(git -C for-submodules/dirty-head rev-parse HEAD)" &&
-	grep "$rev" actual
+	test_grep "$rev" actual
 '
 
 test_expect_success 'set up pathological context' '
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index ec2804eea67c..c66f966a3ab3 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -38,36 +38,36 @@ test_expect_success 'setup' '
 
 test_expect_success 'the default number of context lines is 3' '
 	git diff >output &&
-	! grep "^ d" output &&
-	grep "^ e" output &&
-	grep "^ j" output &&
-	! grep "^ k" output
+	test_grep ! "^ d" output &&
+	test_grep "^ e" output &&
+	test_grep "^ j" output &&
+	test_grep ! "^ k" output
 '
 
 test_expect_success 'diff.context honored by "log"' '
 	git log -1 -p >output &&
-	! grep firstline output &&
+	test_grep ! firstline output &&
 	git config diff.context 8 &&
 	git log -1 -p >output &&
-	grep "^ firstline" output
+	test_grep "^ firstline" output
 '
 
 test_expect_success 'The -U option overrides diff.context' '
 	git config diff.context 8 &&
 	git log -U4 -1 >output &&
-	! grep "^ firstline" output
+	test_grep ! "^ firstline" output
 '
 
 test_expect_success 'diff.context honored by "diff"' '
 	git config diff.context 8 &&
 	git diff >output &&
-	grep "^ firstline" output
+	test_grep "^ firstline" output
 '
 
 test_expect_success 'plumbing not affected' '
 	git config diff.context 8 &&
 	git diff-files -p >output &&
-	! grep "^ firstline" output
+	test_grep ! "^ firstline" output
 '
 
 test_expect_success 'non-integer config parsing' '
@@ -85,8 +85,8 @@ test_expect_success 'negative integer config parsing' '
 test_expect_success '-U0 is valid, so is diff.context=0' '
 	git config diff.context 0 &&
 	git diff >output &&
-	grep "^-ADDED" output &&
-	grep "^+MODIFIED" output
+	test_grep "^-ADDED" output &&
+	test_grep "^+MODIFIED" output
 '
 
 test_expect_success '-U2147483647 works' '
@@ -94,9 +94,9 @@ test_expect_success '-U2147483647 works' '
 	test_line_count = 16 x &&
 	git diff -U2147483647 >output &&
 	test_line_count = 22 output &&
-	grep "^-ADDED" output &&
-	grep "^+MODIFIED" output &&
-	grep "^+APPENDED" output
+	test_grep "^-ADDED" output &&
+	test_grep "^+MODIFIED" output &&
+	test_grep "^+APPENDED" output
 '
 
 test_done
-- 
gitgitgadget

