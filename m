Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D7C35B653
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643472; cv=none; b=CBRy5Vc8UkG4aRb3L9qZGfNz2vA7NDpLMU3seRHzhLvisBC6jcvKRsS+C6D+JekPwhc9cftncJVq+8OPmLFQ9ZVOPpZ6BpJs/OGxXUyK07c7quENIeFvvzGJP7OumwvV/1ZDHt9PpiMu4OlrBKyWc/gLSi+U/N9/gay48PtDx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643472; c=relaxed/simple;
	bh=Q4L9jQoT/Wyj7JXVxtFmd9PoPWiF1ChiNir+6KR+yAw=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=q9V4B1fAak4pDJYa8vELJuWMJZhmsVR4RFUBWGxqca0aDhqnSP+kSZ7a/rpCnclsN8JwORB/tBEDyIzBKbl02MkjWm4Q+TgbVSYReounKks0n28a4zXLCTOc5ITnRsIqooesHMJ6tgaD2damZmHU9h6D4Y+dskr7KnlOcbXNEpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6StnG+R; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6StnG+R"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2be27fa54feso2555236eec.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 08:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643470; x=1773248270; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2mJ5Wa3JrYeErdPS5rcvuwTe3dSuNNwyXJoPZ9kOFiM=;
        b=c6StnG+RnGjy8SghgZaBL7Eb6QEM5eJxTUFISBHZD/SMD3rAoqMar/iv3p2KJF8k89
         hBFSCVdSDdhAibDcisNd4NAaI9oe+EbOHofTmdyL66a/3UAFnd+LoYnVvwUI20ku8fkW
         DcEwjY/oAgbY2LoFfyDvfVA5oN+qaL2iecFK+53ol2iAt9P13K1wa5muYjbiwK0EH9bf
         r776DZZQUyK+nsW69i0IZukK3Casg6WZEfBgBtaWZjtzPaYJbvUE3FP5Tyx39MIjJqM1
         cTzSK/2Q/lwGDd1aG/x/GVac8lEV05P0BT4WVsPKT3XEN9DKn5uuueRFZbpM4BWYu2gG
         jknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643470; x=1773248270;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mJ5Wa3JrYeErdPS5rcvuwTe3dSuNNwyXJoPZ9kOFiM=;
        b=P4/nGsf1/MFiMVFRarDB8CTfiYzj3JKH2o249Zhdx1NWYhySvQaoYul0pQzY+ad1Sz
         myPKvB1dOQYtfnro0eGUuVCR463Iwr4M/Slrh9we2hGt2+A5hnBekkBjxooML1DdR4r9
         QKqPf3erlGN0WqU0YYeR0yI3ocIEFreB6wyhp78TO8kKojgUpbA/29UMmV7II1Fg0VcN
         aQ7INk0rFq6lUNBKFLOGhUTrL0JLR+B3pTxDbuRpbwde8wq/zombby+Y00bVTWqVMvvV
         Oc7kGUDN9GSd1hwpCHY2PrGw6CFlFuwjZ5tJjf25NKnncG7nGHUKXtDesiRyg3UVjPDE
         meBQ==
X-Gm-Message-State: AOJu0Ywx5bGQOZ0uSBbcfCyzx4EsTiLT2Dg4qU6BQHuTEcx83XRb5rvH
	swM5ZazqTWqMCMHaX89gjt6pqFvhXon0u8OCsX5NfD79jUC54nI7C4/ngF1tcg==
X-Gm-Gg: ATEYQzx9FB3n7+CMlrlC961dr8J4CWfXTTGViO3spLI8sgRC9xX4/J1KwcAZv0+pjim
	DAPJ/Vyw9ZM8HNUMtLXtjcUXy6tXJ2RQow6KsEYyAVIQ4QlaRcpGuOv0IdB7Hn1T/qRiJnygYr8
	wI71DsKBHKIt6Gm/o30SvHrIybfGPLA2F/tzi0OdZbjZAK/w+pMe//Dg2orWdA3VmSoowoMPbxq
	LQJB0aHivmpU8d9nFQCm0TY94R2d+sc+vbPy033ZV+widM1TxvQMRV37/2fNJWfeYekpCs5dmac
	G8jlN0r0lfk7jub3y6+EpGfoDLmPZKPMvXyXxwPZWFUU+ALxKkXiCMfI4h3LjkSveJV7Mp9WNgy
	OeZTDPcIxtnSUALldnu4HNn+fGlChZ3aL6dl7AweHNTYIVChB3TjWqyg3IHdJ1XC6Rm9xrbFpmq
	tfsIFpyUsolVPPdiXaUL3sy26veOc=
X-Received: by 2002:a05:693c:3013:b0:2bd:b4d6:d9b0 with SMTP id 5a478bee46e88-2be30db32afmr1069997eec.0.1772643469776;
        Wed, 04 Mar 2026 08:57:49 -0800 (PST)
Received: from [127.0.0.1] ([172.184.210.171])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be0cc8517dsm8093079eec.30.2026.03.04.08.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:57:49 -0800 (PST)
Message-Id: <pull.2224.git.git.1772643468305.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 16:57:48 +0000
Subject: [PATCH] promisor-remote: prevent lazy-fetch recursion in child fetch
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
Cc: Paul Tarjan <github@paulisageek.com>,
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
GIT_NO_LAZY_FETCH=1 via a reference-transaction hook, and that
only one fetch subprocess is spawned.

Cc: Jonathan Tan <jonathantanmy@google.com>
Cc: Han Xin <hanxin.hx@bytedance.com>
Cc: Jeff Hostetler <jeffhostetler@github.com>
Cc: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
    promisor-remote: prevent recursive lazy-fetch during index-pack
    
    fetch_objects() in promisor-remote.c spawns a child git fetch to lazily
    fill missing objects. That child's index-pack --fix-thin, when it hits a
    REF_DELTA against a still-missing base, calls
    promisor_remote_get_direct() — which is fetch_objects() again. Unbounded
    recursion.
    
    We hit this in production: 276 GB of promisor packs written in 90
    minutes against a 100 GB monorepo with ~61K stale prefetch refs pointing
    at GC'd commits. Every thin pack picked a bad delta base, and the
    recursion fanned out until the mount filled.
    
    The fix is one line: propagate GIT_NO_LAZY_FETCH=1 into the child
    fetch's environment. The guard already exists at the top of
    fetch_objects() (added by e6d5479e7a, 2021); nothing was setting it in
    the child. This is the same bug shape that Han Xin's 3a1ea94a49 (2022)
    closed at lookup_commit_in_graph().
    
    Depth-1 lazy fetch (the whole point of fetch_objects()) is unaffected —
    only the child and its descendants see the variable. With
    negotiationAlgorithm=noop the client advertises no "have" lines, so a
    well-behaved server sends objects un-deltified or deltified only against
    objects in the same pack. A depth-2 fetch would not help; if the server
    sends broken thin packs, recursing just makes it worse.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2224%2Fptarjan%2Fclaude%2Ffix-lazy-fetch-recursion-KP9Hl-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2224/ptarjan/claude/fix-lazy-fetch-recursion-KP9Hl-v1
Pull-Request: https://github.com/git/git/pull/2224

 promisor-remote.c                           |  7 +++
 t/meson.build                               |  1 +
 t/t0412-promisor-no-lazy-fetch-recursion.sh | 49 +++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100755 t/t0412-promisor-no-lazy-fetch-recursion.sh

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
diff --git a/t/meson.build b/t/meson.build
index e5174ee575..0499533dff 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -141,6 +141,7 @@ integration_tests = [
   't0303-credential-external.sh',
   't0410-partial-clone.sh',
   't0411-clone-from-partial.sh',
+  't0412-promisor-no-lazy-fetch-recursion.sh',
   't0450-txt-doc-vs-help.sh',
   't0500-progress-display.sh',
   't0600-reffiles-backend.sh',
diff --git a/t/t0412-promisor-no-lazy-fetch-recursion.sh b/t/t0412-promisor-no-lazy-fetch-recursion.sh
new file mode 100755
index 0000000000..ec203543d4
--- /dev/null
+++ b/t/t0412-promisor-no-lazy-fetch-recursion.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='promisor-remote: no recursive lazy-fetch
+
+Verify that fetch_objects() sets GIT_NO_LAZY_FETCH=1 in the child
+fetch environment, so that index-pack cannot recurse back into
+fetch_objects() when resolving REF_DELTA bases.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_create_repo server &&
+	test_commit -C server foo &&
+	git -C server repack -a -d --write-bitmap-index &&
+
+	git clone "file://$(pwd)/server" client &&
+	HASH=$(git -C client rev-parse foo) &&
+	rm -rf client/.git/objects/* &&
+
+	git -C client config core.repositoryformatversion 1 &&
+	git -C client config extensions.partialclone "origin"
+'
+
+test_expect_success 'lazy-fetch spawns only one fetch subprocess' '
+	GIT_TRACE="$(pwd)/trace" git -C client cat-file -p "$HASH" &&
+
+	grep "git fetch" trace >fetches &&
+	test_line_count = 1 fetches
+'
+
+test_expect_success 'child of lazy-fetch has GIT_NO_LAZY_FETCH=1' '
+	rm -rf client/.git/objects/* &&
+
+	# Install a reference-transaction hook to record the env var
+	# as seen by processes inside the child fetch.
+	test_hook -C client reference-transaction <<-\EOF &&
+	echo "$GIT_NO_LAZY_FETCH" >>../env-in-child
+	EOF
+
+	rm -f env-in-child &&
+	git -C client cat-file -p "$HASH" &&
+
+	# The hook runs inside the child fetch, which should have
+	# GIT_NO_LAZY_FETCH=1 in its environment.
+	grep "^1$" env-in-child
+'
+
+test_done

base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
-- 
gitgitgadget
