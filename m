Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992DB200DB
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448044; cv=none; b=N8oD4WqeWqdLezgHuFAI7I3M5ODuapZRslKBS9p8uvr+o4FLQx64Bb63/8eGB4WIQsEa7GQKrWiINLls+kMU3ixKn6xzL6IQsVs5HFKDGHcRTjpSqEtU+PWuacu1txIoO6a+9VxILO+mXTTltS6mzX7kIExxgb+CKSMSmEidvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448044; c=relaxed/simple;
	bh=awTBm0Mye/90FDnN5ANbjpwkTjKl3Q1Ym5fcOiCQzSU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pw+R2jmuLobV71CiXEUPgMkTdrp2zMIoLNCQz8NGN5roeItOzAz4QxPJ147Pb7mfYwruVEcXVBuuCcqdm2jZoiycv6SKZPutmsKxreAEuBn7b8XO67YNiux90MQBQTAACtf88c/aYnRHCZxydacCWtnhrbaI6xUBtQXB6E2b1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncI7Y+J/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncI7Y+J/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42662c21289so10814235e9.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720448041; x=1721052841; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtzKRO8olhvkh/vbHbp7w0dnOLtFh68631Gp2yJ3RSw=;
        b=ncI7Y+J/Wvj1AWTNLtZe5qTB3UxhQ6Eu10YIkSAg4kB5qFfN9AdozP90/mmT8f/Cj1
         owC+SCfesGXjUhCsaUwzXTzma2/LyDf4/RInIFoMNik3WFPN9OLa25O9CFm/Ky1h8y1I
         uLcOFvheJ8fxC4dSNBjQhNmgCYo6fNfsLvVBSJZSlXCTDMApeZFntlgD8A/lEfUfTUDg
         KaZpeaPdb8HzG1PNiW4H8lS95I7uEWgqJEu8oXFE5xw5rdQq3dHZCgrdgsEc6soZhWEc
         e9Lw7Pvc0qOt1Rv8betZWrTQO5WakMwg+wi686+5m2fpRQOW9OpPPUixvIfXpKtc5/5u
         DqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720448041; x=1721052841;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtzKRO8olhvkh/vbHbp7w0dnOLtFh68631Gp2yJ3RSw=;
        b=k98GHaSh2aoPC9goAX6H89C+i2+qumUNPtN0Dt9yDwMlSOXVRvN9pm/ISn6KZpkO7e
         /Ygysof97n9Bd2bKBmmU7za1WGvUHWip/TxJp7nGznsWuqfGFn8KAORkjjxibBxEouH0
         WTyn8kAFI4i0SW7BwUXEq1rM7lXFNhN7IzBq6LeERULEixQwWzU0BN2ZpxPT5D0bOhkt
         ge/xsRR8yaur59btSO4KBbaKeAvQjVOKaG7r9Aks/naW4ORohPJOpmow05ZHWkVRPhy7
         TOn71DA5DmJVRH6SuMEEsSCPk0wvuCljpLUcVxmnNss3qrMo9U+cOB0vGvRP4UZX6B5J
         fbmQ==
X-Gm-Message-State: AOJu0YxBqSZqXI9Rrz49hW3ZtR5qTvWlCllL9mX0AKZPQdsrRcFU11Nl
	ebJUcsPlAoMClm+kFXutdbXun3jpSnXolEbaJyjIXx0f+5r3V71IuHWVHw==
X-Google-Smtp-Source: AGHT+IF64D8IhAmpjrO5CDO0AZXxz/zR+WA9WrH4KJytUkNbSksxjrO6TtL88fdHFHv2I8+e9QvZGQ==
X-Received: by 2002:a05:600c:6d4f:b0:421:7aa1:435 with SMTP id 5b1f17b1804b1-4264a3f60c7mr83905395e9.25.1720448040251;
        Mon, 08 Jul 2024 07:14:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741624sm301375e9.41.2024.07.08.07.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:13:59 -0700 (PDT)
Message-Id: <pull.1756.v2.git.1720448038745.gitgitgadget@gmail.com>
In-Reply-To: <pull.1756.git.1720019679517.gitgitgadget@gmail.com>
References: <pull.1756.git.1720019679517.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Jul 2024 14:13:58 +0000
Subject: [PATCH v2] advice: warn when sparse index expands
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    vdye@github.com,
    rsbecker@nexbridge.com,
    =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Typically, forcing a sparse index to expand to a full index means that
Git could not determine the status of a file outside of the
sparse-checkout and needed to expand sparse trees into the full list of
sparse blobs. This operation can be very slow when the sparse-checkout
is much smaller than the full tree at HEAD.

When users are in this state, there is usually a modified or untracked
file outside of the sparse-checkout mentioned by the output of 'git
status'. There are a number of reasons why this is insufficient:

 1. Users may not have a full understanding of which files are inside or
    outside of their sparse-checkout. This is more common in monorepos
    that manage the sparse-checkout using custom tools that map build
    dependencies into sparse-checkout definitions.

 2. In some cases, an empty directory could exist outside the
    sparse-checkout and these empty directories are not reported by 'git
    status' and friends.

 3. If the user has '.gitignore' or 'exclude' files, then 'git status'
    will squelch the warnings and not demonstrate any problems.

In order to help users who are in this state, add a new advice message
to indicate that a sparse index is expanded to a full index. This
message should be written at most once per process, so add a static
global 'give_advice_on_expansion' to sparse-index.c. Further, there is a
case in 'git sparse-checkout set' that uses the sparse index as an
in-memory data structure (even when writing a full index) so we need to
disable the message in that kind of case.

The t1092-sparse-checkout-compatibility.sh test script compares the
behavior of several Git commands across full and sparse repositories,
including sparse repositories with and without a sparse index. We need
to disable the advice in the sparse-index repo to avoid differences in
stderr. By leaving the advice on in the sparse-checkout repo (without
the sparse index), we can test the behavior of disabling the advice in
convert_to_sparse(). (Indeed, these tests are how that necessity was
discovered.) Add a test that reenables the advice and demonstrates that
the message is output.

The advice message is defined outside of expand_index() to avoid super-
wide lines. It is also defined as a macro to avoid compile issues with
-Werror=format-security.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    advice: warn when sparse index expands
    
    This is motivated by some cases I noticed while supporting users who
    were in this bad state and hitting the performance issue noticed in [1].
    These users had some of the example situations where 'git status' did
    not provide helpful output. This idea has always been in the back of my
    mind since the sparse index was created, but it didn't make sense
    initially when only a few builtins could operate without immediately
    expanding a sparse index to a full one.
    
    [1]
    https://lore.kernel.org/git/pull.1754.v3.git.1719578605.gitgitgadget@gmail.com/
    
    
    Updates in V2
    =============
    
    Thanks for the discussion on this patch!
    
     * Alphabetical order is restored. Sorry for that mixup.
     * The advice message is edited to hint towards ways for the user to
       figure out what is happening.
    
    Thanks, Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1756%2Fderrickstolee%2Fadvice-sparse-index-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1756/derrickstolee/advice-sparse-index-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1756

Range-diff vs v1:

 1:  9d5fa2caabd ! 1:  0ba93568f28 advice: warn when sparse index expands
     @@ Commit message
          sparse blobs. This operation can be very slow when the sparse-checkout
          is much smaller than the full tree at HEAD.
      
     -    When users are in this state, it is common that 'git status' will report
     -    the problem. Usually there is a modified or untracked file outside of
     -    the sparse-checkout mentioned by the 'git status' output. There are a
     -    number of reasons why this is insufficient:
     +    When users are in this state, there is usually a modified or untracked
     +    file outside of the sparse-checkout mentioned by the output of 'git
     +    status'. There are a number of reasons why this is insufficient:
      
           1. Users may not have a full understanding of which files are inside or
              outside of their sparse-checkout. This is more common in monorepos
     @@ Documentation/config/advice.txt: advice.*::
      
       ## advice.c ##
      @@ advice.c: static struct {
     - 	[ADVICE_RM_HINTS]				= { "rmHints" },
       	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse" },
       	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
     -+	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
       	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
     ++	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
       	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
       	[ADVICE_STATUS_HINTS]				= { "statusHints" },
     + 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption" },
      
       ## advice.h ##
      @@ advice.h: enum advice_type {
     - 	ADVICE_RM_HINTS,
       	ADVICE_SEQUENCER_IN_USE,
       	ADVICE_SET_UPSTREAM_FAILURE,
     -+	ADVICE_SPARSE_INDEX_EXPANDED,
       	ADVICE_SKIPPED_CHERRY_PICKS,
     ++	ADVICE_SPARSE_INDEX_EXPANDED,
       	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
       	ADVICE_STATUS_HINTS,
     + 	ADVICE_STATUS_U_OPTION,
      
       ## sparse-index.c ##
      @@
     @@ sparse-index.c
      + */
      +static int give_advice_on_expansion = 1;
      +#define ADVICE_MSG \
     -+	"The sparse index is expanding to a full index, a slow operation.\n" \
     -+	"This likely means that you have files in your working directory\n"  \
     -+	"that are outside of your sparse-checkout patterns. Remove them\n"   \
     -+	"to recover performance expectations, such as with 'git clean'."
     ++	"The sparse index is expanding to a full index, a slow operation.\n"   \
     ++	"Your working directory likely has contents that are outside of\n"     \
     ++	"your sparse-checkout patterns. Use 'git sparse-checkout list' to\n"   \
     ++	"see your sparse-checkout definition and compare it to your working\n" \
     ++	"directory contents. Running 'git clean' may assist in this cleanup."
       
       struct modify_index_context {
       	struct index_state *write;


 Documentation/config/advice.txt          |  4 ++++
 advice.c                                 |  1 +
 advice.h                                 |  1 +
 sparse-index.c                           | 28 ++++++++++++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh | 16 +++++++++++++-
 5 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index fa612417568..0ba89898207 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -116,6 +116,10 @@ advice.*::
 	skippedCherryPicks::
 		Shown when linkgit:git-rebase[1] skips a commit that has already
 		been cherry-picked onto the upstream branch.
+	sparseIndexExpanded::
+		Shown when a sparse index is expanded to a full index, which is likely
+		due to an unexpected set of files existing outside of the
+		sparse-checkout.
 	statusAheadBehind::
 		Shown when linkgit:git-status[1] computes the ahead/behind
 		counts for a local ref compared to its remote tracking ref,
diff --git a/advice.c b/advice.c
index 558a46fc0b3..6b879d805c0 100644
--- a/advice.c
+++ b/advice.c
@@ -78,6 +78,7 @@ static struct {
 	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse" },
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
+	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
 	[ADVICE_STATUS_HINTS]				= { "statusHints" },
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption" },
diff --git a/advice.h b/advice.h
index 5105d90129d..d7466bc0ef2 100644
--- a/advice.h
+++ b/advice.h
@@ -45,6 +45,7 @@ enum advice_type {
 	ADVICE_SEQUENCER_IN_USE,
 	ADVICE_SET_UPSTREAM_FAILURE,
 	ADVICE_SKIPPED_CHERRY_PICKS,
+	ADVICE_SPARSE_INDEX_EXPANDED,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
 	ADVICE_STATUS_HINTS,
 	ADVICE_STATUS_U_OPTION,
diff --git a/sparse-index.c b/sparse-index.c
index e48e40cae71..8f4a43c182a 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -12,6 +12,22 @@
 #include "config.h"
 #include "dir.h"
 #include "fsmonitor-ll.h"
+#include "advice.h"
+
+/**
+ * This global is used by expand_index() to determine if we should give the
+ * advice for advice.sparseIndexExpanded when expanding a sparse index to a full
+ * one. However, this is sometimes done on purpose, such as in the sparse-checkout
+ * builtin, even when index.sparse=false. This may be disabled in
+ * convert_to_sparse().
+ */
+static int give_advice_on_expansion = 1;
+#define ADVICE_MSG \
+	"The sparse index is expanding to a full index, a slow operation.\n"   \
+	"Your working directory likely has contents that are outside of\n"     \
+	"your sparse-checkout patterns. Use 'git sparse-checkout list' to\n"   \
+	"see your sparse-checkout definition and compare it to your working\n" \
+	"directory contents. Running 'git clean' may assist in this cleanup."
 
 struct modify_index_context {
 	struct index_state *write;
@@ -183,6 +199,12 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	    !is_sparse_index_allowed(istate, flags))
 		return 0;
 
+	/*
+	 * If we are purposefully collapsing a full index, then don't give
+	 * advice when it is expanded later.
+	 */
+	give_advice_on_expansion = 0;
+
 	/*
 	 * NEEDSWORK: If we have unmerged entries, then stay full.
 	 * Unmerged entries prevent the cache-tree extension from working.
@@ -328,6 +350,12 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 			pl = NULL;
 	}
 
+	if (!pl && give_advice_on_expansion) {
+		give_advice_on_expansion = 0;
+		advise_if_enabled(ADVICE_SPARSE_INDEX_EXPANDED,
+				  _(ADVICE_MSG));
+	}
+
 	/*
 	 * A NULL pattern set indicates we are expanding a full index, so
 	 * we use a special region name that indicates the full expansion.
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 2f1ae5fd3bc..a2c0e1b4dcc 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -159,7 +159,10 @@ init_repos () {
 	git -C sparse-checkout sparse-checkout set deep &&
 	git -C sparse-index sparse-checkout init --cone --sparse-index &&
 	test_cmp_config -C sparse-index true index.sparse &&
-	git -C sparse-index sparse-checkout set deep
+	git -C sparse-index sparse-checkout set deep &&
+
+	# Disable this message to keep stderr the same.
+	git -C sparse-index config advice.sparseIndexExpanded false
 }
 
 init_repos_as_submodules () {
@@ -2331,4 +2334,15 @@ test_expect_success 'sparse-index is not expanded: check-attr' '
 	ensure_not_expanded check-attr -a --cached -- folder1/a
 '
 
+test_expect_success 'advice.sparseIndexExpanded' '
+	init_repos &&
+
+	git -C sparse-index config --unset advice.sparseIndexExpanded &&
+	git -C sparse-index sparse-checkout set deep/deeper1 &&
+	mkdir -p sparse-index/deep/deeper2/deepest &&
+	touch sparse-index/deep/deeper2/deepest/bogus &&
+	git -C sparse-index status 2>err &&
+	grep "The sparse index is expanding to a full index" err
+'
+
 test_done

base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
-- 
gitgitgadget
