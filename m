Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337926;
	b=Jlzkm6vDMLh+pHEjxgi0HKy3IxzEV0hvAtDgHb5S71hYeuUKyUgNXDtfq3/vg9Pr+n3o
	 fY9R/V6wXblRP0nzgT0QIKGT97Bl8jcG44v5StM2zGsf8XQR1nV1TmJmAueVFlWjZnZ+/
	 OD+elRcf8lIbtnOJNDKTW7a30kuSyV1JHqgQH73V2gTsrbW07fbj1sdG/2m6isQVVLpXB
	 t8LXDZCa1JworjHckSMekyp4AF0l2z0xfLHu7SMEqLm+JU2V8zvdQegYfeMnSAgV0SsEi
	 TzEYSwBKB5AAX/ffQ/Qb+rOWCJLp7pN1K5aSw9Vn069fZnLitfOFKfRWyvO2emBqkgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=YEn9KqLvwb37dUbwTpjnRanpxFqp4f2S6dbgAxsPO/k=;
	b=aNdmDJpRUCWmtXliF0KxsjsMApcClcG6K8rKPML8wqpBdAiv5LAqmjskS4Zrk3OXyPC1
	 w1wYnImT25QkjOmtj6wBx+8hwNyrsaEFMvbgJQfhHdDpzwMb7HEIgtsvptFvKT0moX8Zm
	 sBGEe9rfV75fIdd48hkJiUa0hW4C9rF4pXOiINUsmsFs9VftH2kXyd0+vGjqK8E6frxVv
	 UHFoBRO+Kqc9pKBGuCPMCS9/Zj5gfCWxKKVupAKqxzVsbXvrrJEyL5lw5CelK4QVnhq23
	 ekYkOHGPPCuzIWvwa0rF3BBmVyg+e5b2E7PMdPeVDmEK7Dl4XUcIXXbvLjWvRXI4uIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Myu5TsED;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8277C606A337
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 19:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8277C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Myu5TsED
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f84a55e31aso1379764a34.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794337925; x=1794942725; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YEn9KqLvwb37dUbwTpjnRanpxFqp4f2S6dbgAxsPO/k=;
        b=Myu5TsED4WY9W4YfGLBE1CadeA8aR1FWrDZ/HFg5k7pVk2wR5NLYF31wCo4oTBFEuA
         jPc7oqKOZwipCBdHFr/c7xNQeIyTMg87NshV+Uxvi9NruHT2otokS+budDfX1OiHj2JF
         97KY3fVsRSIrgOLHduyn+x/LodDdYYHXXx7R88viSNklL3kThzv7qriqneXVu7+osGYY
         HQ4s7AMG/qD/2/PLmgpb25ZIwvhS+/HJG7iFNVPnjfsxVktcP9BKeJND0S0KrCytPMl+
         7d+XH07/A3/OfQMuRgWRPL6SmwLQ8JSWF5PTfMJT+QT6gWnLEVhiNskYs2q+GfAHysbB
         1/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337925; x=1794942725;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YEn9KqLvwb37dUbwTpjnRanpxFqp4f2S6dbgAxsPO/k=;
        b=Aadjj+uDrWGp2+Ai3qspl9Yi1CQpccQ+pQ8+KyyVSPaeI+V7DqqD8ErLhfaVzK8JU7
         990neYy1GmwM/cM7B1ea2TxYSCffOh9p8Wy73JIEvmWZZITFHohIOhhlWF4Mz0fD+OmO
         odWu9gUZClxU6Mg1kZQWRRuvMv11aX+aWSDvg//S9JhoQGl3lIhtMxrwxrw3VENtobUr
         NRYj5AMwlnLjROrO8wxkGLBINO+LzjpfLvqxrU92lZ59XenM+l3J4AGYxFTSEPJhCDCv
         DeJBJFS5mbZRSC2Et2oSXJJP3Kdox98gXxV+TYDytCsVTkCY0Y4LrJpy3mHFPaor9fYX
         53TA==
X-Gm-Message-State: APuU4Z/xBGauFad+YE4uVd5YTImc+uWSOovBEJbkw3za1d9pKik5loxH
	JZgc3JmfB6cnWPtpian+2DSrJVwYwLDbOMn7Oh0R7l1lA+YZ1KZseM317WfwcA==
X-Gm-Gg: AYBFou3v2ZA5bHf05t8Kgi43ylmjM5fzNfYkmaaNNJbKCZ4/2Jux9mpnSZQfiDCw0PS
	ym21sZLuRz2+qjX2WQEOC+iqV7qJs1BjBn/DukAa4fHjQtSCzOvPfKRVM1N5+MBC3CuV+1lecvJ
	CZ768gx2zz2WpPiZw3n6KacMUIsGtcaibBbCO44qaDhSFGwEKy/xtM81MX5IY48qHQpjvzw35Fm
	rwLTs9M0mGYH1iP8O7g8UDP3lUou9D5eCPm1kQ7VPL5/O5sMXih9mWOLH7rFiBMRNIv0y/hvBJ1
	yzjAqTd0Vh9Pc9SH+ljN0DmS3RvQhgMHF5K+cz/suAPNIo2tyomUkCqlRK9D9OTXVg3QxdqA+7g
	oRFKo1+zfQru7WqAtisi+o2b1e3l8fgFHGbnq+542+c70kQFreRU3rRJIy+HLu5hptFxeUruN1Y
	vBFOo5b25dqZEUUDbZwj4mBeIgR/3GFWjeiMl/Mz0T8zJWFjKelff2sSrGWplM8GGa1lMxH2mmo
	ra0/7gv/PWrHMrIQOr2/BdEXZByKgZFZtIvi0mcavCkequZH5ztMCZrDaALUafRz9RBt1njo7fy
	jFXT53KMlS5cU+0/LYWAsYbzI18UV90=
X-Received: by 2002:a05:6808:508e:b0:4d6:90f4:48ab with SMTP id 5614622812f47-5683cd1b07bmr3016343b6e.45.1794337925226;
        Tue, 10 Nov 2026 11:12:05 -0800 (PST)
Received: from [127.0.0.1] ([52.154.21.60])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56902ae3906sm2889515b6e.2.2026.11.10.11.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:12:04 -0800 (PST)
Message-Id: <a9b81eb87684fa9bfbc83e845eb67ded8d7cb6d9.1794337920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
References: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
From: "Wyatt Holden via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 19:11:59 +0000
Subject: [PATCH 2/3] checkout: advise when orphaned commit checks are slow
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    stolee@gmail.com,
    wyattj.holden@gmail.com,
    Wyatt Holden <wyattholden@microsoft.com>

From: Wyatt Holden <wyattholden@microsoft.com>

The orphaned-commit check can take much longer than updating the
working tree. Users who encounter this cost need a way to discover
the checkout.orphanedCommitWarning setting.

Measure the complete check and suggest disabling it when it takes
more than two seconds. Explain that opting out also removes the
warning about commits left behind, and allow the advice itself to be
disabled with advice.checkoutOrphanedCommitWarning.

Follow the slow-operation advice introduced by:

0a53561a622 (status: warn when a/b calculation takes too long, 2019-06-18)

Unlike that status advice, recommend a configuration setting rather
than a dedicated command-line option.

Keep a test hook to exercise advice and suppression without relying
on wall-clock delays. Force the advice condition without replacing
the measured duration, and check the formatted duration rather than
a fabricated fixed value.

Signed-off-by: Wyatt Holden <wyattholden@microsoft.com>
---
 Documentation/config/advice.adoc |  6 +++++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/checkout.c               | 13 +++++++++++
 t/README                         |  5 ++++
 t/t2020-checkout-detach.sh       | 40 ++++++++++++++++++++++++++++++++
 6 files changed, 66 insertions(+)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 3d91c90eda..eecf72d8d1 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -38,6 +38,12 @@ all advice messages.
 		configuration variable for how to set a given remote
 		to be used by default in some situations where this
 		advice would be printed.
+	checkoutOrphanedCommitWarning::
+		Shown when linkgit:git-checkout[1] or linkgit:git-switch[1]
+		takes more than 2 seconds to check for commits left behind
+		when leaving a detached `HEAD`. Suggests setting
+		`checkout.orphanedCommitWarning` to `false` to skip the check.
+		Disabling this advice does not disable the check itself.
 	commitBeforeMerge::
 		Shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwriting local changes.
diff --git a/advice.c b/advice.c
index 401d047391..8142d73b5e 100644
--- a/advice.c
+++ b/advice.c
@@ -50,6 +50,7 @@ static struct {
 	[ADVICE_AMBIGUOUS_FETCH_REFSPEC]		= { "ambiguousFetchRefspec" },
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
+	[ADVICE_CHECKOUT_ORPHANED_COMMIT_WARNING]		= { "checkoutOrphanedCommitWarning" },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
 	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
diff --git a/advice.h b/advice.h
index 3f0b4f0485..7dd1fe109c 100644
--- a/advice.h
+++ b/advice.h
@@ -17,6 +17,7 @@ enum advice_type {
 	ADVICE_AMBIGUOUS_FETCH_REFSPEC,
 	ADVICE_AM_WORK_DIR,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
+	ADVICE_CHECKOUT_ORPHANED_COMMIT_WARNING,
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DEFAULT_BRANCH_NAME, /* To be retired sometime after Git 3.0 */
 	ADVICE_DETACHED_HEAD,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7cc9e97612..1e94280d35 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -35,6 +35,7 @@
 #include "strvec.h"
 #include "submodule.h"
 #include "symlinks.h"
+#include "trace.h"
 #include "trace2.h"
 #include "tree.h"
 #include "tree-walk.h"
@@ -1133,6 +1134,8 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 {
 	struct rev_info revs;
 	struct object *object = &old_commit->object;
+	uint64_t t_begin = getnanotime();
+	uint64_t t_delta_in_ms;
 
 	trace2_region_enter("checkout", "orphaned_commit_warning", the_repository);
 	repo_init_revisions(the_repository, &revs, NULL);
@@ -1159,6 +1162,16 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	repo_clear_commit_marks(the_repository, ALL_REV_FLAGS);
 	release_revisions(&revs);
 	trace2_region_leave("checkout", "orphaned_commit_warning", the_repository);
+
+	t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
+	if (t_delta_in_ms > 2000 ||
+	    git_env_bool("GIT_TEST_CHECKOUT_DELAY_WARNING", 0))
+		advise_if_enabled(ADVICE_CHECKOUT_ORPHANED_COMMIT_WARNING,
+				  _("Checking for orphaned commits took %.2f seconds.\n"
+				    "You can use 'git config set checkout.orphanedCommitWarning false'\n"
+				    "to skip this check, but you will no longer be warned when leaving\n"
+				    "commits behind that are not connected to any of your branches."),
+				  t_delta_in_ms / 1000.0);
 }
 
 static int switch_branches(const struct checkout_opts *opts,
diff --git a/t/README b/t/README
index fd7e8504b5..577f02732e 100644
--- a/t/README
+++ b/t/README
@@ -371,6 +371,11 @@ test suite. Accept any boolean values that are accepted by git-config.
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
 
+GIT_TEST_CHECKOUT_DELAY_WARNING=<boolean>, when true, forces the
+slow orphaned-commit check advice to be considered regardless of the
+elapsed time. It does not change the measured duration or override
+advice settings.
+
 GIT_TEST_FULL_IN_PACK_ARRAY=<boolean> exercises the uncommon
 pack-objects code path where there are more than 1024 packs even if
 the actual number of packs in repository is below this limit. Accept
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index d21dbd5b72..7dfaaab1b8 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -186,6 +186,46 @@ do
 		check_not_detached
 	'
 
+	test_expect_success "$command advises when the orphan check is slow" '
+		git checkout --detach "$orphan2" &&
+		GIT_TEST_CHECKOUT_DELAY_WARNING=true \
+			git $command main 2>stderr &&
+		check_orphan_warning stderr "2 commits" &&
+		test_grep -E "^hint: Checking for orphaned commits took [0-9]+[.][0-9]{2} seconds[.]$" stderr &&
+		test_grep "git config set checkout.orphanedCommitWarning false" stderr &&
+		test_grep "git config set advice.checkoutOrphanedCommitWarning false" stderr
+	'
+
+	test_expect_success "$command can suppress slow orphan check advice" '
+		git checkout --detach "$orphan2" &&
+		GIT_TEST_CHECKOUT_DELAY_WARNING=true \
+			git -c advice.checkoutOrphanedCommitWarning=false \
+			$command main 2>stderr &&
+		check_orphan_warning stderr "2 commits" &&
+		test_grep ! "^hint:" stderr &&
+
+		git checkout --detach "$orphan2" &&
+		GIT_TEST_CHECKOUT_DELAY_WARNING=true GIT_ADVICE=0 \
+			git $command main 2>stderr &&
+		check_orphan_warning stderr "2 commits" &&
+		test_grep ! "^hint:" stderr
+	'
+
+	test_expect_success "$command does not advise when the orphan check is skipped" '
+		git checkout --detach "$orphan2" &&
+		GIT_TEST_CHECKOUT_DELAY_WARNING=true \
+			git -c checkout.orphanedCommitWarning=false \
+			$command main 2>stderr &&
+		check_no_orphan_warning stderr &&
+		test_grep ! "^hint:" stderr &&
+
+		git checkout --detach "$orphan2" &&
+		GIT_TEST_CHECKOUT_DELAY_WARNING=true \
+			git $command --quiet main 2>stderr &&
+		test_must_be_empty stderr &&
+		check_not_detached
+	'
+
 	test_expect_success "$command rejects invalid checkout.orphanedCommitWarning" '
 		test_must_fail git -c checkout.orphanedCommitWarning=invalid \
 			$command main 2>stderr &&
-- 
gitgitgadget

