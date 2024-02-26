Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A40127B77
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954054; cv=none; b=j4pX9cj5Wa+yMxvY6uSKAihKjm2jHph8Q3BjCMg6OG3vHw0KspH01a94hMx17UJgftShc0kZ6QsQD0+MKH4q6C4UqQ7AoYqGqiEh1PRZa6IHQ1AAzdJuO9/86sm9kuRu6TVeABgexsqnCnPie2MRUd/8Chlo4nK58LcJum3x6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954054; c=relaxed/simple;
	bh=jlKfeJTZ+wGr+c82X9faHhTHRCaC3WixVsXR03twxQw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U/Oz7qgZrj0tBmgia9//G02LzgcIab7dM0XnuE5cxjEGA2YIIk1s+RHlHUJ8F5ZoiMOAL+DcIMRCxBNrOizcZ0DY7QxAn4hkY2cIHFOISp3U5dL0DbhXBeckaMeJbM6MyskQ6BVfVjc8PwCpIxk9oy4gSfcJyPAhtdDYkqDPvf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fg0CrXWU; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fg0CrXWU"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512f5484a37so2094618e87.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 05:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708954050; x=1709558850; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aTZfUwc7+RnffhqIDlc4a2RV47q0yRGSrYZUlo3iPo=;
        b=fg0CrXWUIfCzgojAYdIGYghgZubsgI+d7hYMfKlBP4Ssn3aSM7O8Abef5icbuWYHYf
         sHjxD1ec4CSrcSdy7ZzWyuXcVfPCZOwbMfNxJsbOfQj0hvwrPhubzvPJGC1XXrGDvyMf
         nGl1qgNaTk518nCGuXpzcCWJEZY0ohRvs+WyCqoQyiS11airPsO+j+Rlydmuq8qAN3KR
         90UbzXjyevf5nqYozCJ+Bcd3C36Vtw+gx9CDW5Vaais6StA/YYiRQ4n+VR+znwn5aOVl
         zrbkW1H+U4sMHqT7nAmtJ2iAZexOoolg6ibUFRrwahBCPMTVAaoSJYT0jPgh11JNu+yP
         1Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708954050; x=1709558850;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aTZfUwc7+RnffhqIDlc4a2RV47q0yRGSrYZUlo3iPo=;
        b=KkLEl/tXPJ96EO530M/C9AzQdn2KbAeHjgBSSB0SceC9WP3XGmQ/Eudx+YyNWYxR8O
         rVKfbP9iRjz1P+3QiI0kRFGKBnLjqeZezqa9LzDpnsR97XritSzBNTmhZljTakmTOpOH
         75fULC1VLAkgCLBA86e1/Da2NAvoHKZZKZ9SHr3K2f3HQCluzXoKVNpsWK5ZOgY7y01B
         P1Mb6Jf+K6qbXgNS+AUiXZz+/f3EsSqXwRYPrwu7zwPU9icSCOXtPqu/6U43wLCSS6ef
         odSgASJ5VxGXP2mFMFbln8PxNP4BVclQOLRP6ethBejDrsmlFS7J4fXCH03Xypa8os+b
         UDYA==
X-Gm-Message-State: AOJu0YzLAjWtrOf0Q7lrx9Sb22pDfLL+FZ+hvGZ9RKT3fx42MSvkEy1/
	+kgLxvVu9A9DqcJTes6uX2WHUNaoKm9y+zJ8cOxqRrBayu2tOfdnsCyR9YHZ
X-Google-Smtp-Source: AGHT+IG+k3XNvVejR+EkDvSNABIOJhEL49CWx5X3soAlkaEeKF2IIXcXsGs1elNK2nvVjOvEOhs1Sg==
X-Received: by 2002:ac2:4c4b:0:b0:512:a95b:ac6e with SMTP id o11-20020ac24c4b000000b00512a95bac6emr5573855lfk.61.1708954049710;
        Mon, 26 Feb 2024 05:27:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x4-20020a05600c188400b0040fc56712e8sm8154827wmp.17.2024.02.26.05.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 05:27:29 -0800 (PST)
Message-ID: <pull.1661.v2.git.git.1708954048301.gitgitgadget@gmail.com>
In-Reply-To: <pull.1661.git.git.1706534968589.gitgitgadget@gmail.com>
References: <pull.1661.git.git.1706534968589.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 13:27:28 +0000
Subject: [PATCH v2] merge-ort: turn submodule conflict suggestions into an
 advice
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
    Glen Choo <glencbz@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Add a new advice type 'submoduleMergeConflict' for the error message
shown when a non-trivial submodule conflict is encountered, which was
added in 4057523a40 (submodule merge: update conflict error message,
2022-08-04). That commit mentions making this message an advice as
possible future work. Only show the advice if it is enabled.

Update the tests as the expected message now appears on stderr instead
of stdout.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    merge-ort: turn submodule conflict suggestions into an advice
    
    Changes since v1:
    
     * Rebased onto v2.44.0 to solve conflicts
     * CC'ed more people involved in the thread where the message was added

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1661%2Fphil-blain%2Fmerge-submodule-conflict-advice-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1661/phil-blain/merge-submodule-conflict-advice-v2
Pull-Request: https://github.com/git/git/pull/1661

Range-diff vs v1:

 1:  e77f3453fe1 ! 1:  a6d631e0c69 merge-ort: turn submodule conflict suggestions into an advice
     @@ Commit message
          shown when a non-trivial submodule conflict is encountered, which was
          added in 4057523a40 (submodule merge: update conflict error message,
          2022-08-04). That commit mentions making this message an advice as
     -    possible future work.
     +    possible future work. Only show the advice if it is enabled.
      
          Update the tests as the expected message now appears on stderr instead
          of stdout.
     @@ Documentation/config/advice.txt: advice.*::
      
       ## advice.c ##
      @@ advice.c: static struct {
     - 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
     - 	[ADVICE_SUBMODULES_NOT_UPDATED] 		= { "submodulesNotUpdated", 1 },
     - 	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
     -+	[ADVICE_SUBMODULE_MERGE_CONFLICT]               = { "submoduleMergeConflict", 1  },
     - 	[ADVICE_SUGGEST_DETACHING_HEAD]			= { "suggestDetachingHead", 1 },
     - 	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
     - 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
     + 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption" },
     + 	[ADVICE_SUBMODULES_NOT_UPDATED] 		= { "submodulesNotUpdated" },
     + 	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie" },
     ++	[ADVICE_SUBMODULE_MERGE_CONFLICT]               = { "submoduleMergeConflict" },
     + 	[ADVICE_SUGGEST_DETACHING_HEAD]			= { "suggestDetachingHead" },
     + 	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath" },
     + 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor" },
      
       ## advice.h ##
      @@ advice.h: enum advice_type {


 Documentation/config/advice.txt |  3 +++
 advice.c                        |  1 +
 advice.h                        |  1 +
 merge-ort.c                     |  3 ++-
 t/t6437-submodule-merge.sh      | 14 +++++++-------
 t/t7402-submodule-rebase.sh     |  2 +-
 6 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c7ea70f2e2e..dde8e7840ef 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -129,6 +129,9 @@ advice.*::
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
index 6e9098ff089..4ba64ee5b2d 100644
--- a/advice.c
+++ b/advice.c
@@ -79,6 +79,7 @@ static struct {
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption" },
 	[ADVICE_SUBMODULES_NOT_UPDATED] 		= { "submodulesNotUpdated" },
 	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie" },
+	[ADVICE_SUBMODULE_MERGE_CONFLICT]               = { "submoduleMergeConflict" },
 	[ADVICE_SUGGEST_DETACHING_HEAD]			= { "suggestDetachingHead" },
 	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath" },
 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor" },
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
index 8617babee41..6a48aea2275 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -18,6 +18,7 @@
 #include "merge-ort.h"
 
 #include "alloc.h"
+#include "advice.h"
 #include "attr.h"
 #include "cache-tree.h"
 #include "commit.h"
@@ -4556,7 +4557,7 @@ static void print_submodule_conflict_suggestion(struct string_list *csub) {
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

base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
-- 
gitgitgadget
