Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA541A0AFB
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496338; cv=none; b=uYXfRF3MO3hmrP+SedwBnPWosxZQw0bz+pLHWxkT0+mL55tPgvfX4/vF4adZEnztiDeBPMzmljQdxiPwrAKW1X9h5jLOdEAPWFxlhHesOWXXVtRKI0VgTOS5baHhtD1K7ZL0hYcm5gA4nD0pKsbuZAhgzDdHBLGaO/25srBsedY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496338; c=relaxed/simple;
	bh=lFNXeMtuhzo4XOU6dtiBouuIdn08yTF5MnwVSB7hnmY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=mbfFJ3zSVhUB+WL/IDuiyzsT/r/BjWboOKKnsVZDmP97mZrAAtW/ex71QuQC3gQuQEsIipWvCWWREQAxv5A9lj+sqAsdDToKsYp2Byox7KHqNISOS/0sHamP56GpL7UoyAssMBQmmF5wbqAapYXiHnZKdon7X+kVscyQ036KDIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1GSDcBX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1GSDcBX"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41c011bb920so19575e9.1
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714496334; x=1715101134; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wWSWQHF4lhI+Sj2GGmSjwwhG5K80BtyQDlaFvbc7tBk=;
        b=l1GSDcBXJeLHLY4qhWLDR5d4sp9bIFSksW1oRrq/Bl0gdiAw1Qlbqk2u9xBxqAftYV
         8BSi2E7zK9JYmEkDXY5emoXcsZsUi+7W12ul5ImhQmeI4tV2g8SSEOqGzpoXXK7GCaDq
         1aX91bI64y9bUZTqSEiRb0y/n2353ztubuv0sCZ1ZDvGnUneYAkZGaVc0aWJtjJ4577B
         M23tcKpVbO1JTJk3r/9gsAln5uS6/dpla4yyYR1ubWGV2w/lqqDzYUVcn9EyHY0MuQhR
         H2GfsWBQbC1m7bHuzMa+czOJWbu9qUfi858Xmq0/9r3JzSltzjoY1sCA0enRZLpY+83O
         iH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714496334; x=1715101134;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWSWQHF4lhI+Sj2GGmSjwwhG5K80BtyQDlaFvbc7tBk=;
        b=KT1FJq0vdL4HPlnRVSXNzWA9SXRsnspe/3sP+LSyjpkjL2OB1UVrdPJzAMI7m6RH7A
         xKazrirHfr+TWDhQ5jcUTlCMsP/m0+iSkPmRo9kXbiS51ZRre2nnl2NdKNaQfepNfWeI
         ePSwdIfxDvGRqQx6+Q1ChQmBdJyB++LpzJJyeCyxoxUX988/haV4pnROupgIY7WHw24w
         dVUwzv5XVOM1o00ap1SpRYfL1Ksdxb7hWpvQtE9ZQI0nkr9dXINuLPh7IiGusADRaMM8
         dsbpsHDSYJrfjeEQWy5FA+EmDHYlLpc2A/dBCOG3RC7YGZQRYuZ30G4ToVqrNkO7M6p0
         e9AA==
X-Gm-Message-State: AOJu0YyZsjjK9zDX50WjEBS8lWDJ2P3G8U9Ziwwc6I33o2XgfrXRS0wv
	kJ9UD7ErWejrLy+c/u8LHIzNdbwNzU2Hrt2ZgMVUciLelAjW9EZAuPLJnQ==
X-Google-Smtp-Source: AGHT+IGZeikvtB7rfQE6E0LZ5MWQ3bp4EifZc9G6otBRbvJVZdzDE5ItXgfq72+pgxFs0ldi+IMiUw==
X-Received: by 2002:a05:600c:3510:b0:41b:e55c:8dc1 with SMTP id h16-20020a05600c351000b0041be55c8dc1mr2814623wmq.20.1714496334244;
        Tue, 30 Apr 2024 09:58:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0041bfb176a87sm11557383wms.27.2024.04.30.09.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:58:53 -0700 (PDT)
Message-Id: <pull.1724.git.1714496333004.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Apr 2024 16:58:52 +0000
Subject: [PATCH] scalar: avoid segfault in reconfigure --all
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

During the latest v2.45.0 update, 'scalar reconfigure --all' started to
segfault on my machine. Breaking it down via the debugger, it was
faulting on a NULL reference to the_hash_algo, which is a macro pointing
to the_repository->hash_algo.

This NULL reference appears to be due to the way the loop is abusing the
the_repository pointer, pointing it to a local repository struct after
discovering that the current directory is a valid Git repository. This
repo-swapping bit was in the original implementation from 4582676075
(scalar: teach 'reconfigure' to optionally handle all registered
enlistments, 2021-12-03), but only recently started segfaulting while
trying to parse the HEAD reference. This also only happens on the
_second_ repository in the list, so does not reproduce if there is only
one registered repo.

My first inclination was to try to refactor cmd_reconfigure() to execute
'git for-each-repo' instead of this loop. In addition to the difficulty
of executing 'scalar reconfigure' within 'git for-each-repo', it would
be difficult to perform the clean-up logic for non-existent repos if we
relied on that child process.

Instead, I chose to move the temporary repo to be within the loop and
reinstate the_repository to its old value after we are done performing
logic on the current array item.

Add a test to t9210-scalar.sh to test 'scalar reconfigure --all' with
multiple registered repos, as a precaution. Unfortunately, I was unable
to reproduce the segfault using this test, so there is some coverage
left to be desired. What exactly causes my setup to hit this bug but not
this test structure? Unclear.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    scalar: avoid segfault in reconfigure --all
    
    I noticed this while validating the v2.45.0 release (specifically the
    microsoft/git fork, but this applies to the core project).
    
    I couldn't figure out if or why this changed during this cycle. There
    were some changes in setup.c (30b7c4bdca (setup: notice more types of
    implicit bare repositories, 2024-03-09) and 45bb916248 (setup: allow
    cwd=.git w/ bareRepository=explicit, 2024-01-20)) but they seemed
    innocuous and were not in the stack trace of the segfault.
    
    After asking around, it seems like this kind of issue has been happening
    in older versions, but users were ignoring the error during the
    installer or was hidden by a silent installer.
    
    -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1724%2Fderrickstolee%2Fscalar-reconfigure-repo-handle-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1724/derrickstolee/scalar-reconfigure-repo-handle-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1724

 scalar.c          | 10 +++++++---
 t/t9210-scalar.sh | 17 +++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/scalar.c b/scalar.c
index fb2940c2a00..7234049a1b8 100644
--- a/scalar.c
+++ b/scalar.c
@@ -645,7 +645,6 @@ static int cmd_reconfigure(int argc, const char **argv)
 	};
 	struct string_list scalar_repos = STRING_LIST_INIT_DUP;
 	int i, res = 0;
-	struct repository r = { NULL };
 	struct strbuf commondir = STRBUF_INIT, gitdir = STRBUF_INIT;
 
 	argc = parse_options(argc, argv, NULL, options,
@@ -665,6 +664,7 @@ static int cmd_reconfigure(int argc, const char **argv)
 
 	for (i = 0; i < scalar_repos.nr; i++) {
 		int succeeded = 0;
+		struct repository *old_repo, r = { NULL };
 		const char *dir = scalar_repos.items[i].string;
 
 		strbuf_reset(&commondir);
@@ -712,13 +712,17 @@ static int cmd_reconfigure(int argc, const char **argv)
 
 		git_config_clear();
 
+		if (repo_init(&r, gitdir.buf, commondir.buf))
+			goto loop_end;
+
+		old_repo = the_repository;
 		the_repository = &r;
-		r.commondir = commondir.buf;
-		r.gitdir = gitdir.buf;
 
 		if (set_recommended_config(1) >= 0)
 			succeeded = 1;
 
+		the_repository = old_repo;
+
 loop_end:
 		if (!succeeded) {
 			res = -1;
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 428339e3427..a696337b055 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -180,6 +180,23 @@ test_expect_success 'scalar reconfigure' '
 	test true = "$(git -C one/src config core.preloadIndex)"
 '
 
+test_expect_success 'scalar reconfigure --all' '
+	repos="two three four" &&
+	for num in $repos
+	do
+		git init $num/src &&
+		scalar register $num/src &&
+		git -C $num/src config core.preloadIndex false || return 1
+	done &&
+
+	scalar reconfigure --all &&
+
+	for num in $repos
+	do
+		test true = "$(git -C $num/src config core.preloadIndex)" || return 1
+	done
+'
+
 test_expect_success '`reconfigure -a` removes stale config entries' '
 	git init stale/src &&
 	scalar register stale &&

base-commit: e326e520101dcf43a0499c3adc2df7eca30add2d
-- 
gitgitgadget
