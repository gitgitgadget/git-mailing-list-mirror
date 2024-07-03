Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F073D180A8C
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019684; cv=none; b=dlPTFPIQpvLcu5w/E8TUyXT8pUqv/t+kfBruPuA1NdqohCTogLXrXYlTWoG0XL7AbnrtnGb2GnOo6vtdjQ2kZpSERmPZJK0ctfCKk8dz+EFPAPJ88qumnUWbpHphvT+1lJDfeYTL5h50cu+drtI/z9KNa2a0SF8gwy8wby30lks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019684; c=relaxed/simple;
	bh=zriqh3jVG4DcdlWzvZhS1E/nbrnVhf2DYwLekaeM44M=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=bip9b/4E8RN/nPRpdbd5wJ/CEP4D/sIpOKYALfXQv8S0K1lOAPRu9KH8hw3NVucaMV1I828wJC5rSVkPrmRzoiRGgWKoigBo/rEu3eArAN624wv199hzp8pA2RPvo4Be0IxGHQPAHhPzrbXfsWQZ5k146Fu8Z3U9bm9/6pi71yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWrx5Q+Y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWrx5Q+Y"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42562a984d3so38884805e9.3
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720019681; x=1720624481; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ultXpmmKuv0zsp3uhaOkyfbkERGHjqHb/tLt8Q/x2xI=;
        b=bWrx5Q+YuORhVhFI9DTZif1thsn+6SdekQErYhspZtV3X6yZjUSE+JVxIqgpFNsxFe
         2ghzRQjMTnMr/vGdyo68cyryMzgnzklX3o4FsRy6nEKHThc5+0JiIDNNBVKdiFDIMfiP
         SpqQNHEZPSmU/SH4G+VtV3tL2SyFlYKBFBA1QB4KS/cnI+n953sfrclRh67QFIS29PqX
         xPeHyu5V4Xt6l1mZknq2skE2kCx4nRoEbNFELuO/6kfoDXe5d4qLvdnHheF7RDUg8Ind
         ivzZ7j+DDvjPAX9ySdKV/v7SW21lqBe+3pmEwSPPQkMwgGfjVNZAyINpiaUKZXQBQdno
         b/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019681; x=1720624481;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ultXpmmKuv0zsp3uhaOkyfbkERGHjqHb/tLt8Q/x2xI=;
        b=gT4H/LSpVt55sHe5NQfmMUD/kFQ5EiJJCeQHw1Ng/PDMTj6r62cScZRv2f/B+FSYY6
         ghVIVO2ITKMUdmp0wkdez3UrUYEKYK0qif1BzfgeFAF8tOFRA2dL7AiO5pS/ZR2sCPlm
         NX3mkTJiUAdA1ttKpGTrAnxaMXyBpj9p05ZQyRlxnlW0UJkpfduDH1tVDP7FJprjjFAE
         weksoy6Gho0vLu6hErZwMOPFO4xL41U628N6xrN15ycYyw+iRIcwUozwrsOMaaWYVSaW
         UUhTtnWqXFqRdjDPv6h+B1YAy/Ayb1aXuYtW3ZRF7sPq7BuGTGaYC6MOxR63qNzA6B0H
         DSfQ==
X-Gm-Message-State: AOJu0YwigR9qwmfMO6Q0Y2FwDNlKYWzQO5/ghCSAe2aloip3Q99P+6wm
	djApNmU05Tt9/iiSTsK+RwKlW7CUep7YXp5DWytXV4R62KOhucAek0t30g==
X-Google-Smtp-Source: AGHT+IHQR2+J4wV5CY+XB3D4cxfIBCd3LBJUS10i9TVYepZK4fB+MLlDRNQLHfxrj9EDRyNFyl21Dg==
X-Received: by 2002:a5d:548a:0:b0:367:8638:539a with SMTP id ffacd0b85a97d-3678638547cmr3021904f8f.35.1720019680857;
        Wed, 03 Jul 2024 08:14:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367957d3451sm1547164f8f.101.2024.07.03.08.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:14:40 -0700 (PDT)
Message-Id: <pull.1756.git.1720019679517.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jul 2024 15:14:39 +0000
Subject: [PATCH] advice: warn when sparse index expands
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Typically, forcing a sparse index to expand to a full index means that
Git could not determine the status of a file outside of the
sparse-checkout and needed to expand sparse trees into the full list of
sparse blobs. This operation can be very slow when the sparse-checkout
is much smaller than the full tree at HEAD.

When users are in this state, it is common that 'git status' will report
the problem. Usually there is a modified or untracked file outside of
the sparse-checkout mentioned by the 'git status' output. There are a
number of reasons why this is insufficient:

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
    
    Thanks, Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1756%2Fderrickstolee%2Fadvice-sparse-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1756/derrickstolee/advice-sparse-index-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1756

 Documentation/config/advice.txt          |  4 ++++
 advice.c                                 |  1 +
 advice.h                                 |  1 +
 sparse-index.c                           | 27 ++++++++++++++++++++++++
 t/t1092-sparse-checkout-compatibility.sh | 16 +++++++++++++-
 5 files changed, 48 insertions(+), 1 deletion(-)

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
index 558a46fc0b3..7845e427c89 100644
--- a/advice.c
+++ b/advice.c
@@ -77,6 +77,7 @@ static struct {
 	[ADVICE_RM_HINTS]				= { "rmHints" },
 	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse" },
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
+	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
 	[ADVICE_STATUS_HINTS]				= { "statusHints" },
diff --git a/advice.h b/advice.h
index 5105d90129d..572272fa0da 100644
--- a/advice.h
+++ b/advice.h
@@ -44,6 +44,7 @@ enum advice_type {
 	ADVICE_RM_HINTS,
 	ADVICE_SEQUENCER_IN_USE,
 	ADVICE_SET_UPSTREAM_FAILURE,
+	ADVICE_SPARSE_INDEX_EXPANDED,
 	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
 	ADVICE_STATUS_HINTS,
diff --git a/sparse-index.c b/sparse-index.c
index e48e40cae71..1e517f696dd 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -12,6 +12,21 @@
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
+	"The sparse index is expanding to a full index, a slow operation.\n" \
+	"This likely means that you have files in your working directory\n"  \
+	"that are outside of your sparse-checkout patterns. Remove them\n"   \
+	"to recover performance expectations, such as with 'git clean'."
 
 struct modify_index_context {
 	struct index_state *write;
@@ -183,6 +198,12 @@ int convert_to_sparse(struct index_state *istate, int flags)
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
@@ -328,6 +349,12 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
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
