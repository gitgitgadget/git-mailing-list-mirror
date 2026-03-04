Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455A265629
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648850; cv=none; b=oCDsVDmRJhGzQWgAC+tMnXUmzcKwSo3wX+BsHckUhbrSFb5qImvdpge2fBxQKu/8TnVeL1P0zTrItsR6OE0gJpWndvmH2KA5DXX/2924rDsm1ECygo6kLQKBQ4lja7qQTiPpMqA2MaPhAENUrX/zKYXthLCdqqz/pyfzKqxoJm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648850; c=relaxed/simple;
	bh=k2BqazH7TV4OHPpy0xk/HFZQma/Y/R8mD5frizi1aFU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=SKsfr3CdnTmGOJykwJ/MP/IHajgw3k7pInQH7oq5PqIcUjplZKRXq7VbmOGA52aqChTthsxjcuKojKNOaxGSx5YHT8LpjA7ElZ4jMb2dKB/bRW216cReF3I253EPNBQARV1g31rUMfm/nUx99L2Gx3vC7VIGmEubMeoHcvbpoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vibd7xHL; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vibd7xHL"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6729292dcd7so4173070eaf.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648847; x=1773253647; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtJvyMoKTKDU6RkJzldUoKDBwjq1X9lnaG5vEO4gwp0=;
        b=Vibd7xHLz1HCET6TyPEzi4KZ2AzjRPj6z9Io2lTcf+A+US31GufaCYZRKPhnU6qpSE
         jOD1PaV/lSdep41v/r+qJRZeTXl96f/1vgmV7Ss8Sqavwn2MFzltzt9FIv5ImTvhTx+R
         D3buqJMUJP3yuaqRLasUwBI8wo2kX8ek7ARayjfJjtbFNgebDH4CP3p28lNod4MPRkto
         FOkVYJ4sYQo/FJRTiWSjgJXq4Zn8zqBEVvu4sIR5TEiwOwl7+rfF618JtQFU+3Ajl7YG
         uAQdqTwRh9zjHbmvHBzQsIIU6eXGi3QI2VYNL/kRsQmrfSKqQlxAJTiWTOiOfLG5+Vu3
         Lztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648847; x=1773253647;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MtJvyMoKTKDU6RkJzldUoKDBwjq1X9lnaG5vEO4gwp0=;
        b=o/FGwyjTf8pkNsqSvvRHicstTlnuXIpUOX+aurgIxFhXQuvQzDnrfMu0LC8C0Wm5qW
         DPV3a6xyPLPfAjLU5nfLqciFzjIwOUJreLZgpoqu65hY9RFZUKrIlNXGwm8OMPyx6MEv
         QjnoGZiVAlde8UUmm5Ph4Wzwirya1EJwIwwURJKtnxy0/PoXwILUhhEs9JmwFNgi/Bht
         qE4MvLLFRR3cCkE+EfoNQkMBHmAp1+prLjyg6hOJL+tXrI2kVM/VyBnbHgLOOf2avg1R
         nLpIEa9RSD2GYOfQmLDExqM9c88AAjn1jg83RpO8/6fU/El5BNjDYomwSlO9eG1GZO9A
         LReA==
X-Gm-Message-State: AOJu0YxqlVe1AvMlXYCFhQL1xztGOnD+WiC/nRr/2DtS9KABW2dRaCZe
	aqa9CsCFeCSX/hQHGTOlrbYzDxa/ONmLmzouE0WBpvFMtkZR+BdiHFa9TvYdqA==
X-Gm-Gg: ATEYQzx6rTZ0VUaUVIZKpt2ZQfla4iBo1iyNQjJcqSS74bXWQKq9xfBCHU0fvG54VpE
	H6g3CDblyT2ZrP1WQxOxH4Ew/YREZvwMdRgmThMKgNUFNNMls1OG6T44uc/bLKopDDAllM7VPGt
	T/lfJWxGlvUqm4pz1Q9lX+A+673hF6ZuG/FC82W4JrPXLHhCe+q3866Mvo3wkP92nISWDHw8+gH
	KGd6Q0azkSojq0/Yx0mSQNW/SKm88P2yx4xxSW6hPJdg/WY/CztkPae5DTU9+tvbV1nZEM1WyWG
	vuLCVD7Z2HdQaDzf6kWLmNNuNyv/4VjjMEHSwY2Qa8/TK/01tMvKWfRmtXyo/hD6oONiE8y3Pho
	mRP9AvxtfReVUZnZIXSXugYmyc1WdmEDcDuUaLAQfsICaWfQiZJXXG3xJ57nBV1M7c7jQcx71sP
	367RSNZiik9MvFRpKELczc+ZObyv0LWD2ihg==
X-Received: by 2002:a05:6820:188a:b0:67a:1d28:7bae with SMTP id 006d021491bc7-67b17764b35mr1719213eaf.37.1772648847249;
        Wed, 04 Mar 2026 10:27:27 -0800 (PST)
Received: from [127.0.0.1] ([132.196.82.6])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67a201e1fa4sm3372815eaf.4.2026.03.04.10.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:27:26 -0800 (PST)
Message-Id: <pull.2224.v2.git.git.1772648846009.gitgitgadget@gmail.com>
In-Reply-To: <pull.2224.git.git.1772643468305.gitgitgadget@gmail.com>
References: <pull.2224.git.git.1772643468305.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 18:27:25 +0000
Subject: [PATCH v2] promisor-remote: prevent lazy-fetch recursion in child
 fetch
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
    Han Xin <hanxin.hx@bytedance.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

fetch_objects() spawns a child `git fetch` to lazily fill in missing
objects. That child's index-pack, when it receives a thin pack
containing a REF_DELTA against a still-missing base, explicitly
calls promisor_remote_get_direct() — which is fetch_objects() again.
If the base is truly unavailable (e.g. because many refs in the
local store point at objects that have been garbage-collected on the
server), each recursive lazy-fetch can trigger another, leading to
unbounded recursion with runaway disk and process consumption.

The GIT_NO_LAZY_FETCH guard (introduced by e6d5479e7a (git: add
--no-lazy-fetch option, 2021-08-31)) already exists at the top of
fetch_objects(); the missing piece is propagating it into the child
fetch's environment. Add that propagation so the child's
index-pack, if it encounters a REF_DELTA against a missing base,
hits the guard and fails fast instead of recursing.

Depth-1 lazy fetch (the whole point of fetch_objects()) is
unaffected: only the child and its descendants see the variable.
With negotiationAlgorithm=noop the client advertises no "have"
lines, so a well-behaved server sends requested objects
un-deltified or deltified only against objects in the same pack;
the child's index-pack should never need a depth-2 fetch. If it
does, the server response was broken or the local store is already
corrupt, and further fetching would not help.

This is the same bug shape that 3a1ea94a49 (commit-graph.c: no lazy
fetch in lookup_commit_in_graph(), 2022-07-01) addressed at a
different entry point.

Add a test that verifies the child fetch environment contains
GIT_NO_LAZY_FETCH=1 via a reference-transaction hook.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
    promisor-remote: prevent recursive lazy-fetch during index-pack
    
    Propagate GIT_NO_LAZY_FETCH=1 into the child fetch spawned by
    fetch_objects() so that index-pack cannot recurse back into lazy-fetch
    when resolving REF_DELTA bases.
    
    We hit this in production: 276 GB of promisor packs written in 90
    minutes against a 100 GB monorepo with ~61K stale prefetch refs pointing
    at GC'd commits.
    
    Changes since v1:
    
     * Dropped CC: trailers from commit message (moved here for
       GitGitGadget)
     * Moved test into t0411-clone-from-partial.sh instead of a new file
     * Removed duplicate commit-message summary from PR description

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2224%2Fptarjan%2Fclaude%2Ffix-lazy-fetch-recursion-KP9Hl-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2224/ptarjan/claude/fix-lazy-fetch-recursion-KP9Hl-v2
Pull-Request: https://github.com/git/git/pull/2224

Range-diff vs v1:

 1:  7b723441f4 ! 1:  907ca7a0ac promisor-remote: prevent lazy-fetch recursion in child fetch
     @@ Commit message
          different entry point.
      
          Add a test that verifies the child fetch environment contains
     -    GIT_NO_LAZY_FETCH=1 via a reference-transaction hook, and that
     -    only one fetch subprocess is spawned.
     +    GIT_NO_LAZY_FETCH=1 via a reference-transaction hook.
      
     -    Cc: Jonathan Tan <jonathantanmy@google.com>
     -    Cc: Han Xin <hanxin.hx@bytedance.com>
     -    Cc: Jeff Hostetler <jeffhostetler@github.com>
     -    Cc: Christian Couder <christian.couder@gmail.com>
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
       ## promisor-remote.c ##
     @@ promisor-remote.c: static int fetch_objects(struct repository *repo,
       		     "fetch", remote_name, "--no-tags",
       		     "--no-write-fetch-head", "--recurse-submodules=no",
      
     - ## t/meson.build ##
     -@@ t/meson.build: integration_tests = [
     -   't0303-credential-external.sh',
     -   't0410-partial-clone.sh',
     -   't0411-clone-from-partial.sh',
     -+  't0412-promisor-no-lazy-fetch-recursion.sh',
     -   't0450-txt-doc-vs-help.sh',
     -   't0500-progress-display.sh',
     -   't0600-reffiles-backend.sh',
     -
     - ## t/t0412-promisor-no-lazy-fetch-recursion.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='promisor-remote: no recursive lazy-fetch
     -+
     -+Verify that fetch_objects() sets GIT_NO_LAZY_FETCH=1 in the child
     -+fetch environment, so that index-pack cannot recurse back into
     -+fetch_objects() when resolving REF_DELTA bases.
     -+'
     -+
     -+. ./test-lib.sh
     -+
     -+test_expect_success 'setup' '
     -+	test_create_repo server &&
     -+	test_commit -C server foo &&
     -+	git -C server repack -a -d --write-bitmap-index &&
     + ## t/t0411-clone-from-partial.sh ##
     +@@ t/t0411-clone-from-partial.sh: test_expect_success 'promisor lazy-fetching can be re-enabled' '
     + 	test_path_is_file script-executed
     + '
     + 
     ++test_expect_success 'lazy-fetch child has GIT_NO_LAZY_FETCH=1' '
     ++	test_create_repo nolazy-server &&
     ++	test_commit -C nolazy-server foo &&
     ++	git -C nolazy-server repack -a -d --write-bitmap-index &&
      +
     -+	git clone "file://$(pwd)/server" client &&
     -+	HASH=$(git -C client rev-parse foo) &&
     -+	rm -rf client/.git/objects/* &&
     -+
     -+	git -C client config core.repositoryformatversion 1 &&
     -+	git -C client config extensions.partialclone "origin"
     -+'
     -+
     -+test_expect_success 'lazy-fetch spawns only one fetch subprocess' '
     -+	GIT_TRACE="$(pwd)/trace" git -C client cat-file -p "$HASH" &&
     -+
     -+	grep "git fetch" trace >fetches &&
     -+	test_line_count = 1 fetches
     -+'
     ++	git clone "file://$(pwd)/nolazy-server" nolazy-client &&
     ++	HASH=$(git -C nolazy-client rev-parse foo) &&
     ++	rm -rf nolazy-client/.git/objects/* &&
      +
     -+test_expect_success 'child of lazy-fetch has GIT_NO_LAZY_FETCH=1' '
     -+	rm -rf client/.git/objects/* &&
     ++	git -C nolazy-client config core.repositoryformatversion 1 &&
     ++	git -C nolazy-client config extensions.partialclone "origin" &&
      +
      +	# Install a reference-transaction hook to record the env var
      +	# as seen by processes inside the child fetch.
     -+	test_hook -C client reference-transaction <<-\EOF &&
     ++	test_hook -C nolazy-client reference-transaction <<-\EOF &&
      +	echo "$GIT_NO_LAZY_FETCH" >>../env-in-child
      +	EOF
      +
      +	rm -f env-in-child &&
     -+	git -C client cat-file -p "$HASH" &&
     ++	git -C nolazy-client cat-file -p "$HASH" &&
      +
      +	# The hook runs inside the child fetch, which should have
      +	# GIT_NO_LAZY_FETCH=1 in its environment.
      +	grep "^1$" env-in-child
      +'
      +
     -+test_done
     + test_done


 promisor-remote.c             |  7 +++++++
 t/t0411-clone-from-partial.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 96fa215b06..35c7aab93d 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -42,6 +42,13 @@ static int fetch_objects(struct repository *repo,
 	child.in = -1;
 	if (repo != the_repository)
 		prepare_other_repo_env(&child.env, repo->gitdir);
+	/*
+	 * Prevent the child's index-pack from recursing back into
+	 * fetch_objects() when resolving REF_DELTA bases it does not
+	 * have.  With noop negotiation the server should never need
+	 * to send such deltas, so a depth-2 fetch would not help.
+	 */
+	strvec_pushf(&child.env, "%s=1", NO_LAZY_FETCH_ENVIRONMENT);
 	strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=noop",
 		     "fetch", remote_name, "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
diff --git a/t/t0411-clone-from-partial.sh b/t/t0411-clone-from-partial.sh
index 9e6bca5625..10a829fb80 100755
--- a/t/t0411-clone-from-partial.sh
+++ b/t/t0411-clone-from-partial.sh
@@ -78,4 +78,30 @@ test_expect_success 'promisor lazy-fetching can be re-enabled' '
 	test_path_is_file script-executed
 '
 
+test_expect_success 'lazy-fetch child has GIT_NO_LAZY_FETCH=1' '
+	test_create_repo nolazy-server &&
+	test_commit -C nolazy-server foo &&
+	git -C nolazy-server repack -a -d --write-bitmap-index &&
+
+	git clone "file://$(pwd)/nolazy-server" nolazy-client &&
+	HASH=$(git -C nolazy-client rev-parse foo) &&
+	rm -rf nolazy-client/.git/objects/* &&
+
+	git -C nolazy-client config core.repositoryformatversion 1 &&
+	git -C nolazy-client config extensions.partialclone "origin" &&
+
+	# Install a reference-transaction hook to record the env var
+	# as seen by processes inside the child fetch.
+	test_hook -C nolazy-client reference-transaction <<-\EOF &&
+	echo "$GIT_NO_LAZY_FETCH" >>../env-in-child
+	EOF
+
+	rm -f env-in-child &&
+	git -C nolazy-client cat-file -p "$HASH" &&
+
+	# The hook runs inside the child fetch, which should have
+	# GIT_NO_LAZY_FETCH=1 in its environment.
+	grep "^1$" env-in-child
+'
+
 test_done

base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
-- 
gitgitgadget
