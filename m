Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2183B27DC
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238783; cv=none; b=lKwu2euhI/rv9c+TT2V8gN1pLWRi2U4fDiPk+dv+kBwCzEbFMDxlFOzoqzaWBGmf1Ejq30ou2FDIbTOTjQh/DyIVhKvrdE64v+BZ/nV6GLYstJsD6knnRpQnXsVx6+4H6Rh8HdrIR4MB3y1WvCkkihzlPqQujnSddx6HAHxtAPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238783; c=relaxed/simple;
	bh=otwo8KtJ3hPnfxZDYPTYRwcfcd7LXKoHoQQkSgi+H/0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J3+/32fJRiCf/AMATpAHevEhLikW6qc+VxodCiqOO4w8IZP2RejH9XNPAde2AUlrxAgVyK1HGaGOEwtd6RapRU+zJKNvuq3xlVjasieRpDv8qZA7ukWgYUQ1xVIZCSgrNIn4Cfvdz6RxBPRzwWHN77/+uoK2uAkbP9/nPJ97V5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fz1AurR5; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz1AurR5"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d74aa6bcdbso1878828a34.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773238780; x=1773843580; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlVi5n6Js6a+FuOFu/T2yRmdGrLKvT53WhIhYdW1AZA=;
        b=Fz1AurR5PaMyGGnjsnniWD0WXWEXJ0vtAtf4TrQM1G7Bz8sEFgnthemYt0LNAX3uiv
         LYsTnklAzLhNQKfVvmFD9OMstVlFivhh0++e3NS9aGYzfftA8yOFLoQP6+T1lir/ry70
         N2MXrZAgnn7conb8M2fyquEfYmBQtqNKyH4eVJQJHdG0KEjVodJQAJxk5rBlNRavrrfF
         hYR2XjNkLjSrwtdQNt0dey8buiAFcviiV57isWXJ3wHqCFawKIrFkxinWehIOcUJ9fQJ
         LhuLkaCoijY5rUSLmfBXm2h4/OS3eHc+TJXGutAH3jfnAHnOP/+jkRhjZRWcEBW8zHOi
         HmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238780; x=1773843580;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlVi5n6Js6a+FuOFu/T2yRmdGrLKvT53WhIhYdW1AZA=;
        b=eOA2CVjGZkw3JaB06PnoJzRp16iAtOiWv0CpCrYujme7jj7AGouSIfahqlkSwO3crU
         Zqz/ngJZGQkeYfc2FEhSwCuyvp0mSTf9rA2xlxORi4X+AxtP+LCeDBRmJ3TQ/uW9FVhQ
         +pW9YWiIT6bkEIhfD05XbWn1752A43L6uCGXsGjUhE90IF2IpeX5ymSO/u22HmAg8lxm
         AMPI4hu2TolO9S05s+nU1w5R/6MBquRTNMmrksq7DxMMjEFt766oxzu7x+eSWatoCPfR
         b7DQRLfy9zB/HoxAM6A5DlQI86GZ6dYZUPOm3ue4vFuwjCS6LMj698URw09RMBlc0dmm
         M/RQ==
X-Gm-Message-State: AOJu0YwF7TQu0pEkF/oz72qZ524B/E1u1zvfvoHvL3OY7cHu34Nd66ik
	tSjggbszyUQjlJ58iZharv/eGNHg2BtH8t3/1B/EY6LAeTVJDROmuaZ6Wf5Iiw==
X-Gm-Gg: ATEYQzydRVwu7P7IyKH1YYDuPKYlJIz4rJGYpX5fX81Ss6iBCpgcP4hfCwqe+JXU/uH
	VVJ4g1iow1cbji3K8sVIQDVmLtOQosiPqvtgT+FH8Qo6MHxWHD2/ukCJcHwKhcu6cyWsuf6yehK
	K4c2pm5ICNjfu8tFgUfxXpwjQfPL8zH+gx0VA7Ab3bqLMfWpBDkUeP8fjqeFv131mZpNeB9l7kC
	/v0r2x5BLAa2YKBS5TncYPBfjbEHQR6ntoOTuGWpS+sbI99O7E2Qqr4/5P93f04vjyHGhZmS3Mh
	TmNC6AEp72VAXmtDTxrZk17nXnR45PpIMDHX069sJJ+qg4qwYxMQQKwwGZT6z6bOwWzdrN7XMQS
	j3TisWkQu15MtwrjQOUXkzMUuCw2XkS9OcKTexk+YEZyx7+lYYmXsjnuMW7+HJW5Q+mVWflKUCq
	QqmxUUWBzVQJ0UAkS/pCmTz8rp
X-Received: by 2002:a05:6830:4c0d:b0:7d7:4921:897d with SMTP id 46e09a7af769-7d76a46af88mr1801974a34.0.1773238780208;
        Wed, 11 Mar 2026 07:19:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.12.182.167])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae39600sm1990603a34.17.2026.03.11.07.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 07:19:39 -0700 (PDT)
Message-Id: <pull.2224.v3.git.git.1773238778894.gitgitgadget@gmail.com>
In-Reply-To: <pull.2224.v2.git.git.1772648846009.gitgitgadget@gmail.com>
References: <pull.2224.v2.git.git.1772648846009.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Mar 2026 14:19:38 +0000
Subject: [PATCH v3] promisor-remote: prevent lazy-fetch recursion in child
 fetch
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
Cc: Christian Couder <christian.couder@gmail.com>,
    Han Xin <hanxin.hx@bytedance.com>,
    Paul Tarjan <paul@paultarjan.com>,
    Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

fetch_objects() spawns a child `git fetch` to lazily fill in missing
objects. That child's index-pack, when it receives a thin pack
containing a REF_DELTA against a still-missing base, calls
promisor_remote_get_direct() -- which is fetch_objects() again.

With negotiationAlgorithm=noop the client advertises no "have"
lines, so a well-behaved server sends requested objects
un-deltified or deltified only against objects in the same pack.
A server that nevertheless sends REF_DELTA against a base the
client does not have is misbehaving; however the client should
not recurse unboundedly in response.

Propagate GIT_NO_LAZY_FETCH=1 into the child fetch's environment
so that if the child's index-pack encounters such a REF_DELTA, it
hits the existing guard at the top of fetch_objects() and fails
fast instead of recursing.  Depth-1 lazy fetch (the whole point
of fetch_objects()) is unaffected: only the child and its
descendants see the variable.

Add a test that injects a thin pack containing a REF_DELTA against
a missing base via HTTP, triggering the recursion path through
index-pack's promisor_remote_get_direct() call.  With the fix, the
child's fetch_objects() sees GIT_NO_LAZY_FETCH=1 and blocks the
depth-2 fetch with a "lazy fetching disabled" warning.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
    promisor-remote: prevent recursive lazy-fetch during index-pack
    
    Propagate GIT_NO_LAZY_FETCH=1 into the child fetch spawned by
    fetch_objects() so that index-pack cannot recurse back into lazy-fetch
    when resolving REF_DELTA bases.
    
    We hit this in production: 276 GB of promisor packs written in 90
    minutes against a ~10 GB monorepo with ~61K stale prefetch refs pointing
    at GC'd commits.
    
    Changes since v2:
    
     * Replaced env-var-proxy test with behavioral test that injects a thin
       pack containing a REF_DELTA against a missing base via HTTP,
       triggering the actual recursion path through index-pack's
       promisor_remote_get_direct() call
     * Moved test from t0411-clone-from-partial.sh to t5616-partial-clone.sh
       (requires HTTP infrastructure)
     * Dropped commit-graph comparison from commit message per review
       feedback
    
    Changes since v1:
    
     * Dropped CC: trailers from commit message (moved here for
       GitGitGadget)
     * Moved test into t0411-clone-from-partial.sh instead of a new file
     * Removed duplicate commit-message summary from PR description

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2224%2Fptarjan%2Fclaude%2Ffix-lazy-fetch-recursion-KP9Hl-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2224/ptarjan/claude/fix-lazy-fetch-recursion-KP9Hl-v3
Pull-Request: https://github.com/git/git/pull/2224

Range-diff vs v2:

 1:  907ca7a0ac ! 1:  d58ccb858f promisor-remote: prevent lazy-fetch recursion in child fetch
     @@ Commit message
      
          fetch_objects() spawns a child `git fetch` to lazily fill in missing
          objects. That child's index-pack, when it receives a thin pack
     -    containing a REF_DELTA against a still-missing base, explicitly
     -    calls promisor_remote_get_direct() — which is fetch_objects() again.
     -    If the base is truly unavailable (e.g. because many refs in the
     -    local store point at objects that have been garbage-collected on the
     -    server), each recursive lazy-fetch can trigger another, leading to
     -    unbounded recursion with runaway disk and process consumption.
     +    containing a REF_DELTA against a still-missing base, calls
     +    promisor_remote_get_direct() -- which is fetch_objects() again.
      
     -    The GIT_NO_LAZY_FETCH guard (introduced by e6d5479e7a (git: add
     -    --no-lazy-fetch option, 2021-08-31)) already exists at the top of
     -    fetch_objects(); the missing piece is propagating it into the child
     -    fetch's environment. Add that propagation so the child's
     -    index-pack, if it encounters a REF_DELTA against a missing base,
     -    hits the guard and fails fast instead of recursing.
     -
     -    Depth-1 lazy fetch (the whole point of fetch_objects()) is
     -    unaffected: only the child and its descendants see the variable.
          With negotiationAlgorithm=noop the client advertises no "have"
          lines, so a well-behaved server sends requested objects
     -    un-deltified or deltified only against objects in the same pack;
     -    the child's index-pack should never need a depth-2 fetch. If it
     -    does, the server response was broken or the local store is already
     -    corrupt, and further fetching would not help.
     +    un-deltified or deltified only against objects in the same pack.
     +    A server that nevertheless sends REF_DELTA against a base the
     +    client does not have is misbehaving; however the client should
     +    not recurse unboundedly in response.
      
     -    This is the same bug shape that 3a1ea94a49 (commit-graph.c: no lazy
     -    fetch in lookup_commit_in_graph(), 2022-07-01) addressed at a
     -    different entry point.
     +    Propagate GIT_NO_LAZY_FETCH=1 into the child fetch's environment
     +    so that if the child's index-pack encounters such a REF_DELTA, it
     +    hits the existing guard at the top of fetch_objects() and fails
     +    fast instead of recursing.  Depth-1 lazy fetch (the whole point
     +    of fetch_objects()) is unaffected: only the child and its
     +    descendants see the variable.
      
     -    Add a test that verifies the child fetch environment contains
     -    GIT_NO_LAZY_FETCH=1 via a reference-transaction hook.
     +    Add a test that injects a thin pack containing a REF_DELTA against
     +    a missing base via HTTP, triggering the recursion path through
     +    index-pack's promisor_remote_get_direct() call.  With the fix, the
     +    child's fetch_objects() sees GIT_NO_LAZY_FETCH=1 and blocks the
     +    depth-2 fetch with a "lazy fetching disabled" warning.
      
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
     @@ promisor-remote.c: static int fetch_objects(struct repository *repo,
       		     "fetch", remote_name, "--no-tags",
       		     "--no-write-fetch-head", "--recurse-submodules=no",
      
     - ## t/t0411-clone-from-partial.sh ##
     -@@ t/t0411-clone-from-partial.sh: test_expect_success 'promisor lazy-fetching can be re-enabled' '
     - 	test_path_is_file script-executed
     + ## t/t5616-partial-clone.sh ##
     +@@ t/t5616-partial-clone.sh: test_expect_success PERL_TEST_HELPERS 'tolerate server sending REF_DELTA against
     + 	! test -e "$HTTPD_ROOT_PATH/one-time-script"
       '
       
     -+test_expect_success 'lazy-fetch child has GIT_NO_LAZY_FETCH=1' '
     -+	test_create_repo nolazy-server &&
     -+	test_commit -C nolazy-server foo &&
     -+	git -C nolazy-server repack -a -d --write-bitmap-index &&
     ++test_expect_success PERL_TEST_HELPERS 'lazy-fetch of REF_DELTA with missing base does not recurse' '
     ++	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
     ++	rm -rf "$SERVER" repo &&
     ++	test_create_repo "$SERVER" &&
     ++	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
     ++	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
     ++
     ++	# Create a commit with 2 blobs to be used as delta base and content.
     ++	for i in $(test_seq 10)
     ++	do
     ++		echo "this is a line" >>"$SERVER/foo.txt" &&
     ++		echo "this is another line" >>"$SERVER/bar.txt" || return 1
     ++	done &&
     ++	git -C "$SERVER" add foo.txt bar.txt &&
     ++	git -C "$SERVER" commit -m initial &&
     ++	BLOB_FOO=$(git -C "$SERVER" rev-parse HEAD:foo.txt) &&
     ++	BLOB_BAR=$(git -C "$SERVER" rev-parse HEAD:bar.txt) &&
      +
     -+	git clone "file://$(pwd)/nolazy-server" nolazy-client &&
     -+	HASH=$(git -C nolazy-client rev-parse foo) &&
     -+	rm -rf nolazy-client/.git/objects/* &&
     ++	# Partial clone with blob:none. The client has commits and
     ++	# trees but no blobs.
     ++	test_config -C "$SERVER" protocol.version 2 &&
     ++	git -c protocol.version=2 clone --no-checkout \
     ++		--filter=blob:none $HTTPD_URL/one_time_script/server repo &&
      +
     -+	git -C nolazy-client config core.repositoryformatversion 1 &&
     -+	git -C nolazy-client config extensions.partialclone "origin" &&
     ++	# Sanity check: client does not have either blob locally.
     ++	git -C repo rev-list --objects --ignore-missing \
     ++		-- $BLOB_FOO >objlist &&
     ++	test_line_count = 0 objlist &&
      +
     -+	# Install a reference-transaction hook to record the env var
     -+	# as seen by processes inside the child fetch.
     -+	test_hook -C nolazy-client reference-transaction <<-\EOF &&
     -+	echo "$GIT_NO_LAZY_FETCH" >>../env-in-child
     ++	# Craft a thin pack where BLOB_FOO is a REF_DELTA against
     ++	# BLOB_BAR. Since the client has neither blob (blob:none
     ++	# filter), the delta base will be missing. This simulates a
     ++	# misbehaving server that sends REF_DELTA against an object
     ++	# the client does not have.
     ++	test-tool -C "$SERVER" pack-deltas --num-objects=1 >thin.pack <<-EOF &&
     ++	REF_DELTA $BLOB_FOO $BLOB_BAR
      +	EOF
      +
     -+	rm -f env-in-child &&
     -+	git -C nolazy-client cat-file -p "$HASH" &&
     ++	replace_packfile thin.pack &&
      +
     -+	# The hook runs inside the child fetch, which should have
     -+	# GIT_NO_LAZY_FETCH=1 in its environment.
     -+	grep "^1$" env-in-child
     ++	# Trigger a lazy fetch for BLOB_FOO. The child fetch spawned
     ++	# by fetch_objects() receives our crafted thin pack. Its
     ++	# index-pack encounters the missing delta base (BLOB_BAR) and
     ++	# tries to lazy-fetch it via promisor_remote_get_direct().
     ++	#
     ++	# With the fix: fetch_objects() propagates GIT_NO_LAZY_FETCH=1
     ++	# to the child, so the depth-2 fetch is blocked and we see the
     ++	# "lazy fetching disabled" warning. The object cannot be
     ++	# resolved, so cat-file fails.
     ++	#
     ++	# Without the fix: the depth-2 fetch would proceed, potentially
     ++	# recursing unboundedly with a persistently misbehaving server.
     ++	test_must_fail git -C repo -c protocol.version=2 \
     ++		cat-file -p $BLOB_FOO 2>err &&
     ++	test_grep "lazy fetching disabled" err &&
     ++
     ++	# Ensure that the one-time-script was used.
     ++	! test -e "$HTTPD_ROOT_PATH/one-time-script"
      +'
      +
     - test_done
     + # DO NOT add non-httpd-specific tests here, because the last part of this
     + # test script is only executed when httpd is available and enabled.
     + 


 promisor-remote.c        |  7 +++++
 t/t5616-partial-clone.sh | 60 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

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
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 1e354e057f..27f131c8d9 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -907,6 +907,66 @@ test_expect_success PERL_TEST_HELPERS 'tolerate server sending REF_DELTA against
 	! test -e "$HTTPD_ROOT_PATH/one-time-script"
 '
 
+test_expect_success PERL_TEST_HELPERS 'lazy-fetch of REF_DELTA with missing base does not recurse' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	rm -rf "$SERVER" repo &&
+	test_create_repo "$SERVER" &&
+	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
+	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
+
+	# Create a commit with 2 blobs to be used as delta base and content.
+	for i in $(test_seq 10)
+	do
+		echo "this is a line" >>"$SERVER/foo.txt" &&
+		echo "this is another line" >>"$SERVER/bar.txt" || return 1
+	done &&
+	git -C "$SERVER" add foo.txt bar.txt &&
+	git -C "$SERVER" commit -m initial &&
+	BLOB_FOO=$(git -C "$SERVER" rev-parse HEAD:foo.txt) &&
+	BLOB_BAR=$(git -C "$SERVER" rev-parse HEAD:bar.txt) &&
+
+	# Partial clone with blob:none. The client has commits and
+	# trees but no blobs.
+	test_config -C "$SERVER" protocol.version 2 &&
+	git -c protocol.version=2 clone --no-checkout \
+		--filter=blob:none $HTTPD_URL/one_time_script/server repo &&
+
+	# Sanity check: client does not have either blob locally.
+	git -C repo rev-list --objects --ignore-missing \
+		-- $BLOB_FOO >objlist &&
+	test_line_count = 0 objlist &&
+
+	# Craft a thin pack where BLOB_FOO is a REF_DELTA against
+	# BLOB_BAR. Since the client has neither blob (blob:none
+	# filter), the delta base will be missing. This simulates a
+	# misbehaving server that sends REF_DELTA against an object
+	# the client does not have.
+	test-tool -C "$SERVER" pack-deltas --num-objects=1 >thin.pack <<-EOF &&
+	REF_DELTA $BLOB_FOO $BLOB_BAR
+	EOF
+
+	replace_packfile thin.pack &&
+
+	# Trigger a lazy fetch for BLOB_FOO. The child fetch spawned
+	# by fetch_objects() receives our crafted thin pack. Its
+	# index-pack encounters the missing delta base (BLOB_BAR) and
+	# tries to lazy-fetch it via promisor_remote_get_direct().
+	#
+	# With the fix: fetch_objects() propagates GIT_NO_LAZY_FETCH=1
+	# to the child, so the depth-2 fetch is blocked and we see the
+	# "lazy fetching disabled" warning. The object cannot be
+	# resolved, so cat-file fails.
+	#
+	# Without the fix: the depth-2 fetch would proceed, potentially
+	# recursing unboundedly with a persistently misbehaving server.
+	test_must_fail git -C repo -c protocol.version=2 \
+		cat-file -p $BLOB_FOO 2>err &&
+	test_grep "lazy fetching disabled" err &&
+
+	# Ensure that the one-time-script was used.
+	! test -e "$HTTPD_ROOT_PATH/one-time-script"
+'
+
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 

base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
-- 
gitgitgadget
