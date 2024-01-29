Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A113657B9
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534973; cv=none; b=uEqoLx0g2ygjFlHvBmNbz8a68J4vl/kVhRxiImLp0Kk987TvJKmmGRJhvKbBXFm4NYo/SzvzGeJgKgzAAe49v0RA6rXnCVhMUo1XICKupeU9pQYrtQM9FfoMjVxZ80tN2V01Px8IW8CzyIGgQNMlGsLL1WWfzxxCV67AoI4uX8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534973; c=relaxed/simple;
	bh=/IOxjZtEY6NUyop/gqj0KxhgpkA4HNGWgtHCoAA4v0Y=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=cSlZqZ2cWoeerU+77wUEC+5ooHCtA+DgdAWblX9RNJcQTVpnhb73ukw/4hkENrT+XydJD7gAieCh0lVx0IWkEKXekUbBcBxke9VGmS0Lf3RFTWsyRneb82x8TqgRmWl77hrdkrwroPZBTyc7s+m6bfbDRgisRw78LEzt2wItSsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAXgDqpm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAXgDqpm"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ef6f10b56so6838455e9.2
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 05:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706534969; x=1707139769; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XH+uOhaaR428cFNp5NbQzf6gBTX4GoaYpk+cbFZvBYg=;
        b=TAXgDqpm8N6HSbmcb/tNhlkHvaFCcEw15VQGg1rTkZLKv2QzuHJUPfKmk5gU17uEnK
         wVyLf3IpLa0hk9gAqYDpper3freatcsHBr3sS/GadQBtj0F+UjmaIkpDt88D7aeLGW/9
         /UzEJwZBYgsAp7hjEq2ALh1IOOTFQnCVYClOX7KIyb9+GHY4pZFKHeIWBaxDdLPjXixu
         07HUqhWEmWJ9A2tDEvVVUE/CX3GHwnVW3uVJxyMxDuv78c7enXVgmszoPk7wu83OWuPX
         fBUMlun3g+Mbffgn9L996fPvfJDOxvMEKRqy0cTuFC/9U9d52zF87Q/MchDUW9RV+0i0
         vDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534969; x=1707139769;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XH+uOhaaR428cFNp5NbQzf6gBTX4GoaYpk+cbFZvBYg=;
        b=vsEoDeJNL+Wm+X8ye/bQ6UTRtrHiJoHutOeO7suWosOiBJDyrDOGUYQLBFpf7wAYKC
         ywZOF3yvZDibcuKrVzRbwl/cAjgoK2malAY4nLk4cNsaa8U9Q/NRJIJXLZLPlRxJAp/l
         fFDiujsK7EsdV3sd1l4PM8t10xTx+YopP3UgJAj3sJv4+S56iFfC6j/CbT+khK3+LOkl
         yEzcEt8VNoywGeb2tLSGWDyXwXzis9tdiN67pQKg9ww4a48Pn60A7EWS3cJXfd3kV9j3
         eAw8nMLlI/3Uwuiuea8+8o6ugoaOZ8BRq3mCLThFkX1+VTVwGyTiMa7oOXKK+GiVkIg9
         Z+Dw==
X-Gm-Message-State: AOJu0YxUUjUzn1wMchmdgSDzBUea4yUjrG3ENqr+V/EvRdtq6f8p+vhK
	RTOBKkJdLiu70eIkgjq+HvcSOFwqDeZnqccGLMGPrdtAo03v/Bibnp1V4H+Q
X-Google-Smtp-Source: AGHT+IGRrvJRtvX+wXCY9MIeg2D4ZEX+W6w0w3DUA0GmTSyVRLDR2TbYa2a4MO08blwpbJet28GRlA==
X-Received: by 2002:a05:600c:1d22:b0:40e:4a3d:83e with SMTP id l34-20020a05600c1d2200b0040e4a3d083emr4231184wms.22.1706534969448;
        Mon, 29 Jan 2024 05:29:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b0040efb503d58sm1235112wmq.28.2024.01.29.05.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:29:29 -0800 (PST)
Message-ID: <pull.1661.git.git.1706534968589.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Jan 2024 13:29:28 +0000
Subject: [PATCH] merge-ort: turn submodule conflict suggestions into an advice
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
Cc: Calvin Wan <calvinwan@google.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Add a new advice type 'submoduleMergeConflict' for the error message
shown when a non-trivial submodule conflict is encountered, which was
added in 4057523a40 (submodule merge: update conflict error message,
2022-08-04). That commit mentions making this message an advice as
possible future work.

Update the tests as the expected message now appears on stderr instead
of stdout.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    merge-ort: turn submodule conflict suggestions into an advice

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1661%2Fphil-blain%2Fmerge-submodule-conflict-advice-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1661/phil-blain/merge-submodule-conflict-advice-v1
Pull-Request: https://github.com/git/git/pull/1661

 Documentation/config/advice.txt |  3 +++
 advice.c                        |  1 +
 advice.h                        |  1 +
 merge-ort.c                     |  3 ++-
 t/t6437-submodule-merge.sh      | 14 +++++++-------
 t/t7402-submodule-rebase.sh     |  2 +-
 6 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 25c09175244..32701b96828 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -128,6 +128,9 @@ advice.*::
 	submoduleAlternateErrorStrategyDie::
 		Advice shown when a submodule.alternateErrorStrategy option
 		configured to "die" causes a fatal error.
+	submoduleMergeConflict::
+		Advice shown when a non-trivial submodule merge conflict is
+		encountered.
 	submodulesNotUpdated::
 		Advice shown when a user runs a submodule command that fails
 		because `git submodule update --init` was not run.
diff --git a/advice.c b/advice.c
index f6e4c2f302e..eee27b5bebc 100644
--- a/advice.c
+++ b/advice.c
@@ -73,6 +73,7 @@ static struct {
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
 	[ADVICE_SUBMODULES_NOT_UPDATED] 		= { "submodulesNotUpdated", 1 },
 	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
+	[ADVICE_SUBMODULE_MERGE_CONFLICT]               = { "submoduleMergeConflict", 1  },
 	[ADVICE_SUGGEST_DETACHING_HEAD]			= { "suggestDetachingHead", 1 },
 	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
diff --git a/advice.h b/advice.h
index 9d4f49ae38b..7d0a821f5cb 100644
--- a/advice.h
+++ b/advice.h
@@ -47,6 +47,7 @@ enum advice_type {
 	ADVICE_STATUS_U_OPTION,
 	ADVICE_SUBMODULES_NOT_UPDATED,
 	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
+	ADVICE_SUBMODULE_MERGE_CONFLICT,
 	ADVICE_SUGGEST_DETACHING_HEAD,
 	ADVICE_UPDATE_SPARSE_PATH,
 	ADVICE_WAITING_FOR_EDITOR,
diff --git a/merge-ort.c b/merge-ort.c
index 77ba7f3020c..59f025db26f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -18,6 +18,7 @@
 #include "merge-ort.h"
 
 #include "alloc.h"
+#include "advice.h"
 #include "attr.h"
 #include "cache-tree.h"
 #include "commit.h"
@@ -4555,7 +4556,7 @@ static void print_submodule_conflict_suggestion(struct string_list *csub) {
 		      " - commit the resulting index in the superproject\n"),
 		    tmp.buf, subs.buf);
 
-	printf("%s", msg.buf);
+	advise_if_enabled(ADVICE_SUBMODULE_MERGE_CONFLICT, "%s", msg.buf);
 
 	strbuf_release(&subs);
 	strbuf_release(&tmp);
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 70650521b04..7a3f1cb27c1 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -113,7 +113,7 @@ test_expect_success 'merging should conflict for non fast-forward' '
 	 git checkout -b test-nonforward-a b &&
 	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	  then
-		test_must_fail git merge c >actual &&
+		test_must_fail git merge c 2>actual &&
 		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
 		grep "$sub_expect" actual
 	  else
@@ -154,9 +154,9 @@ test_expect_success 'merging should conflict for non fast-forward (resolution ex
 	  git rev-parse --short sub-d > ../expect) &&
 	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	  then
-		test_must_fail git merge c >actual &&
+		test_must_fail git merge c >actual 2>sub-actual &&
 		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
-		grep "$sub_expect" actual
+		grep "$sub_expect" sub-actual
 	  else
 		test_must_fail git merge c 2> actual
 	  fi &&
@@ -181,9 +181,9 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 	 ) &&
 	 if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	 then
-		test_must_fail git merge c >actual &&
+		test_must_fail git merge c >actual 2>sub-actual &&
 		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
-		grep "$sub_expect" actual
+		grep "$sub_expect" sub-actual
 	 else
 		test_must_fail git merge c 2> actual
 	 fi &&
@@ -227,7 +227,7 @@ test_expect_success 'merging should fail for changes that are backwards' '
 	git commit -a -m "f" &&
 
 	git checkout -b test-backward e &&
-	test_must_fail git merge f >actual &&
+	test_must_fail git merge f 2>actual &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
     then
 		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-d)" &&
@@ -535,7 +535,7 @@ test_expect_success 'merging should fail with no merge base' '
 	git checkout -b b init &&
 	git add sub &&
 	git commit -m "b" &&
-	test_must_fail git merge a >actual &&
+	test_must_fail git merge a 2>actual &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
     then
 		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short HEAD^1)" &&
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 2b3c363078b..aa2fdc31d1a 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -116,7 +116,7 @@ test_expect_success 'rebasing submodule that should conflict' '
 	test_tick &&
 	git commit -m fourth &&
 
-	test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 >actual_output &&
+	test_must_fail git rebase --onto HEAD^^ HEAD^ HEAD^0 2>actual_output &&
 	git ls-files -s submodule >actual &&
 	(
 		cd submodule &&

base-commit: b50a608ba20348cb3dfc16a696816d51780e3f0f
-- 
gitgitgadget
