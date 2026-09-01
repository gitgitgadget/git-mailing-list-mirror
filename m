Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898E31BCAE
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222481; cv=none; b=XIeSvMbbg+H92EufClygYHkZpdn992SSSQHeMzRb+MPSD7xSUcxQRRRHLYTJSYhUq70+DVnEz2fr48aq1yus2q9X1aafsgyqLtualubtbcLfTFjSoGsh4MAo2GFIIxZnICz9pbgMVSRIxXSe/Gr/mL4VQdZ5P9ppdTT5au025g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222481; c=relaxed/simple;
	bh=gUmh1l0blknYUevt2wUJ0prwZAJ0etIo1U2xmJGoKSo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bly/Q4QyyIBYHTEPSk/8Nhj+PESd+2QTHBX+cFMFPvQGPoIilFORLA//qdFlIJEx80/ZJo9hQ666Wt+XPvFTfqkgyLFurUK4sNauVSzza9ll4gSRRN9RTEop+bHlUkwS+eoiCo/9yFtXTENwZRBhrrI0M8DaY+L+NPjYh5gPO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuBD8/3H; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuBD8/3H"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso4499870a91.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788222478; x=1788827278; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LvkQL33UCP/e/oUnVIWJSTvWmbHID/t02/WBVcOg6ys=;
        b=VuBD8/3HMVDCfcv6UFJbIcfPgFFgeQ2C23hUGoMWwht7p/KWB5LLXKGm/f3uoIfHzn
         ClUPI/+JOLmdtqF63tkw2O+h4QNwy+qMG1pEX1bhoU2wmuMR0bwTjQi3qq4TseROx4/L
         JBZjzT1IoLlf9ZkkLRm42JRSWJxuWKord8MxwHQaEVUPC7lT13r1INpKMrRRVVnezPUe
         wNssuTl4AZT45CXXYbDhaQ3BUl/SSK2h+vop8MJdsif6pPA4tC75Mqn+7IT630PB1S9J
         Y0M/mbSpeXcCjy3Cd334rLxJAZSg2uln5nhkNoI5PVrw+AMB10Sp1hW3s7HDeDtJ++r3
         Kbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788222478; x=1788827278;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LvkQL33UCP/e/oUnVIWJSTvWmbHID/t02/WBVcOg6ys=;
        b=m7HGAapKK70a6BLdEVsW2GHEtE/cLg++m39Y9S7467mF0dmDZnFBW7EpDzfX5unnvw
         nR0dcmcjOSgbHGGCzNmNwGeRLxkKvy4cR4zxwPeiuIDv3G/Ow3QyvWihuOihB+vsB9Mt
         ZIC6SUVdqJ2W/DY3YwmxTkD30WIqn/dErSuZaAin7pAUUbrKpD6kTPAgUgjGeBqpQw3+
         KjRAoEz8Zr3GzptelElQY5tqd8ZdBTOdd3ILtLHZvK0h9tmY29JhlxWqHWRSLigVTu0B
         /QI2asUqNHlfbLzKYRBFTrFeQx6B4Vmozj/fN/5pYmYSxAzXVeF0VW8hryJ4DAsHidy3
         0O+A==
X-Gm-Message-State: AFuF++kJ4YJ/N16xy25ucuQ0LqD8d9ObEV+3LLBkiccNdcqhtVKeDoCg
	x1iSObfZp473GumRWtKRkm2h32vWHR6Q6YaPyE7ptZobyEL22lHChJUzlflP+RR7
X-Gm-Gg: AYBFou3Gf/Qmj92NnDBfLfPWIiFkIlQh+WiBI+9Fgr+6SIRLJwOAzWARon/3Y9p4743
	Ab/PIxTyjxywwG4GSKSNgDyfirWoZr9u/b+NOdcSY+dmZ8pXQhW7PSvj1kJQ9FOY5+zjlV9ZndY
	eMxjjQdE6LQJa4nnPqa2xV5VmdBUHMkGWT8IrBFJa5nT26RH4JFcE2XPvOfRyzbcsUEmRY5j4pd
	XvTQCq3xWm+sZVC4ncgYmuwM+n7C0T6Qt5o6Nj/yVpigyIz6yO9RV2Oy7xUb1ijocw9ZVQbflai
	TbJYAA7oGka4xZJsLQqFYjeex+6mbEu6pbYVLQbij+/z5p5BKCbswo2SZ8nWYg8/4f1X47YkNdl
	yXaGT8BdPuNdl0OVeAKdJbhF7qleNbyjLuH74ONu3KJhbe+H7ctbAu+BvB6gF3i0pmexBcExIEk
	WxHsFUohJ7ixYmCox0ZWALwBzzAiu8VJO87gqlEcYpBtRKfuuMAOMCtYNsL1eTKGBYfvg9JYBWu
	6U=
X-Received: by 2002:a17:90b:534b:b0:398:ceef:edbd with SMTP id 98e67ed59e1d1-398ceefee8emr19377921a91.18.1788222477627;
        Mon, 31 Aug 2026 17:27:57 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.55.133])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0dc854dsm30797035c88.10.2026.08.31.17.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 17:27:57 -0700 (PDT)
Message-Id: <pull.2171.v4.git.1788222476.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 00:27:53 +0000
Subject: [PATCH v4 0/3] t/lib-httpd: make CGI test helpers concurrency-safe
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Michael Montalbo <mmontalbo@gmail.com>

t/lib-httpd.sh provides several helpers that can be invoked concurrently by
Apache while exercising tests. Currently, two of these helpers use state
management logic that fails under certain race conditions.

apply-one-time-script.sh is one of those test helpers. It executes a
"one-time-script" responsible for modifying the response normally returned
by git-http-backend. Sometimes a race between multiple concurrent requests
causes apply-one-time-script.sh to misbehave and return multiple modified
responses or an empty response that results in:

fatal: ... The requested URL returned error: 500 fatal: could not fetch from
promisor remote

This can be seen in the flaky failure of t5616.47 on the macOS CI
runners[1].

Fix this by chaining (&&) the logic for executing "one-time-script" with its
removal, rather than running them as separate actions. Add
t/t5567-one-time-script.sh to verify this fix is effective.

http-429.sh is the other helper whose state management logic can fail under
certain race conditions. However, these failures do not manifest themselves
currently since http-429.sh is invoked sequentially.

As a preventive measure, fix http-429.sh's state management logic so it
relies on an atomic mkdir operation to mark that a 429 was returned rather
than separate "test -f marker", "touch marker", and "rm -f marker" actions
to manage state. http-429.sh is not as straightforward to test as
apply-one-time-script.sh, which is why no regression test was added for the
change.

Finally, document these patterns and anti-patterns in t/lib-httpd.sh for
future developers.

Changes since v3:

 * Rewrite all the prose in the series from scratch without AI to remove
   fluff.
 * Fix the lack of clarity around the actual fix applied to
   apply-one-time-script.sh, which ultimately has nothing to do with rm
   itself, but rather how rm is used in conjunction with the surrounding
   state management logic.
 * No logical behavior change.

[1]
https://github.com/gitgitgadget/git/actions/runs/28756172690/job/85263916762?pr=2169

Michael Montalbo (3):
  t/lib-httpd: fix apply-one-time-script race under concurrent requests
  t/lib-httpd: make http-429 first-request check atomic
  t/lib-httpd: document writing concurrency-safe CGI helpers

 t/lib-httpd.sh                       | 11 ++++
 t/lib-httpd/apply-one-time-script.sh | 38 +++++++----
 t/lib-httpd/http-429.sh              | 22 +++----
 t/meson.build                        |  1 +
 t/t5567-one-time-script.sh           | 96 ++++++++++++++++++++++++++++
 5 files changed, 142 insertions(+), 26 deletions(-)
 create mode 100755 t/t5567-one-time-script.sh


base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2171%2Fmmontalbo%2Fmm%2Flib-httpd-cgi-safe-proto-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2171/mmontalbo/mm/lib-httpd-cgi-safe-proto-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2171

Range-diff vs v3:

 1:  862c4258e5 ! 1:  e202142f19 t/lib-httpd: fix apply-one-time-script race under concurrent requests
     @@ Metadata
       ## Commit message ##
          t/lib-httpd: fix apply-one-time-script race under concurrent requests
      
     -    apply-one-time-script.sh is a CGI helper that, when the file
     -    "one-time-script" is present, runs it to rewrite the git-http-backend
     -    response. If "one-time-script" generates a response that differs from
     -    git-http-backend, the modified response is returned and
     -    "one-time-script" is deleted. Requests after the deletion return normal
     -    git-http-backend responses.
     -
     -    The deletion is not safe under concurrency. The helper serves the
     -    modified body first and deletes "one-time-script" only afterward, so a
     -    client can issue its next request while the file still exists. Apache
     -    runs the CGI for both requests at once, for example when a partial fetch
     -    lazily fetches a missing promisor base while the first response is still
     -    in flight. Both requests find the file and try to run it; the first
     -    deletes it; the second then fails to exec the now-missing file, produces
     -    no output, and the server returns HTTP 500:
     +    apply-one-time-script.sh is a test helper that executes a
     +    "one-time-script" responsible for modifying the response normally
     +    returned by git-http-backend. apply-one-time-script.sh should run
     +    "one-time-script" once and return a modified response once. However,
     +    sometimes a race between multiple concurrent requests causes
     +    apply-one-time-script.sh to misbehave and return multiple modified
     +    responses or an empty response that results in:
      
            fatal: ... The requested URL returned error: 500
            fatal: could not fetch <oid> from promisor remote
      
     -    This is the flaky failure of t5616.47 on the macOS CI runners.
     -
     -    Fix it by removing the file with "rm" only after the script has actually
     -    changed the response. Because "rm" without "-f" fails once the file is
     -    gone, exactly one request removes it and serves the modified body. Any
     -    other request serves the unmodified body. Running the script more than
     -    once is harmless; only its deletion is serialized, so exactly one
     -    request's modified response is ever served. Per-request scratch file
     -    names keep concurrent runs from overwriting each other, and no path
     -    emits an empty response body.
     +    This can be seen in the flaky failure of t5616.47 on the macOS CI
     +    runners.
      
     -    t5616.47 exercises the real code path but, being timing-dependent,
     -    passes against the buggy helper almost every time. Add t5567, which
     -    drives the helper directly with a fake git-http-backend and forces the
     -    overlap with FIFOs; against the pre-fix helper it fails with the same
     -    shell error seen in the field:
     +    Fix the logic that checks if "one-time-script" has returned its modified
     +    response by chaining "rm one-time-script" with its execution. This
     +    ensures a racing script does not also have the opportunity to execute
     +    "one-time-script".
      
     -      ./one-time-script: No such file or directory
     +    Add t/t5567-one-time-script.sh to verify the race is fixed. Implement a
     +    stub "git-http-backend" that intentionally invokes a concurrent request,
     +    and check that only one modified response is returned without error.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ t/lib-httpd/apply-one-time-script.sh
      -then
      -	LC_ALL=C
      -	export LC_ALL
     -+#
     -+# Apache can run this CGI for several requests at the same time. For example, a
     -+# partial fetch lazily fetches a missing object while the first response is
     -+# still in flight. To stay correct, the helper removes the marker only after
     -+# the response changes, and only with "rm" (without "-f"). The "rm" fails for
     -+# every request except the one that removes the marker first. That request
     -+# serves the modified body. Every other request serves its response unchanged.
     -+# No request emits an empty body, which Apache would report as HTTP 500.
     -+#
     -+# A scratch file name includes the process ID ($$), so concurrent requests do
     -+# not overwrite each other's files.
     -+#
     -+# The helper can run one-time-script more than once. It consumes the marker
     -+# when the response changes (the "rm" after "cmp"), not when it runs the
     -+# script. A request whose response is not the target runs the script, finds no
     -+# change, and leaves the marker for a later request. This is safe because the
     -+# scripts are stateless filters over the captured response.
     ++test -f one-time-script || exec "$GIT_EXEC_PATH/git-http-backend"
     ++
     ++LC_ALL=C
     ++export LC_ALL
       
      -	"$GIT_EXEC_PATH/git-http-backend" >out
      -	./one-time-script out >out_modified
     -+test -f one-time-script || exec "$GIT_EXEC_PATH/git-http-backend"
     ++out=out.$$
     ++modified=out-modified.$$
     ++"$GIT_EXEC_PATH/git-http-backend" >"$out"
       
      -	if cmp -s out out_modified
      -	then
     @@ t/lib-httpd/apply-one-time-script.sh
      -		cat out_modified
      -		rm one-time-script
      -	fi
     -+LC_ALL=C
     -+export LC_ALL
     -+
     -+out=out.$$
     -+modified=out-modified.$$
     -+"$GIT_EXEC_PATH/git-http-backend" >"$out"
     -+
     -+# one-time-script can be gone here: a concurrent request may have consumed it
     -+# since the "test -f" above. Then "./one-time-script" fails, the exit status
     -+# selects the unmodified body, and "2>/dev/null" discards the expected
     -+# "no such file" message.
     ++# Since Apache can execute this script for multiple requests
     ++# concurrently, we chain "rm one-time-script" with the logic
     ++# for generating a modified response. If the "rm" ran separately,
     ++# a concurrent request could pass the "test -f" above and
     ++# erroneously result in multiple modified responses or an empty
     ++# body depending on the race state.
     ++#
     ++# We discard stderr for ./one-time-script since it is possible
     ++# ./one-time-script has been removed already, which is expected
     ++# sometimes. In this case, the unmodified response will be returned.
      +if ./one-time-script "$out" 2>/dev/null >"$modified" &&
      +   ! cmp -s "$out" "$modified" &&
      +   rm one-time-script 2>/dev/null
     @@ t/t5567-one-time-script.sh (new)
      +
      +HELPER="$TEST_DIRECTORY/lib-httpd/apply-one-time-script.sh"
      +
     -+test_expect_success PIPE 'concurrent requests: one rewritten, one passed through, neither empty' '
     ++test_expect_success PIPE 'helper only serves one rewritten response for concurrent requests' '
      +	mkdir workdir fakebin &&
      +	ENTERED="$PWD/entered" &&
      +	GATE="$PWD/gate" &&
      +	export ENTERED GATE &&
      +	mkfifo "$ENTERED" "$GATE" &&
      +
     -+	# Stand in for git-http-backend. The modify role returns a response
     -+	# containing "packfile", which the one-time script rewrites. The
     -+	# passthrough role returns a response that is left untouched, but first
     -+	# announces that it has entered the helper and then blocks, so that it
     -+	# is still in flight when the modify role claims and removes the marker.
     ++	# A stub git-http-backend that returns a response based on
     ++	# $ROLE. For $ROLE = modify, return the response string
     ++	# "packfile", which ends up being modified by the example
     ++	# one-time-script below.
     ++	#
     ++	# Otherwise, run the branch returning a response that
     ++	# should be passed through, and block until released
     ++	# by "read -r $GATE".
      +	write_script fakebin/git-http-backend <<-\EOF &&
      +	printf "Status: 200 OK\r\n"
      +	printf "Content-Type: application/x-git-result\r\n"
     @@ t/t5567-one-time-script.sh (new)
      +	fi
      +	EOF
      +
     -+	# The transform that replace_packfile would install as one-time-script:
     -+	# rewrite responses that contain "packfile", leave the rest alone.
     ++	# An example one-time-script for apply-one-time-script
     ++	# to execute. Checks for "packfile" in the response
     ++	# that will be returned, and replaces it with a
     ++	# modified response. Passes through responses without
     ++	# "packfile" in them.
      +	write_script workdir/one-time-script <<-\EOF &&
      +	if grep packfile "$1" >/dev/null
      +	then
     @@ t/t5567-one-time-script.sh (new)
      +	GIT_EXEC_PATH="$PWD/fakebin" &&
      +	export GIT_EXEC_PATH &&
      +
     -+	# Hold GATE open read-write on fd 9 for the duration, so releasing the
     -+	# passthrough request below cannot block even if that request has
     -+	# already exited (it keeps a reader on the FIFO).
     ++	# Ensure $GATE has a reader so the test does not block indefinitely if
     ++	# the helper is buggy and "echo released >&9" below does not unblock
     ++	# the unmodified response gate.
      +	exec 9<>"$GATE" &&
      +
     -+	# Launch the passthrough request in the background. It enters the
     -+	# helper, signals us through ENTERED, then blocks on GATE inside the
     -+	# fake backend. The braces keep the && chain intact while backgrounding
     -+	# only the subshell, so "wait" can reap it by pid; kill it on any exit
     -+	# so a stray blocked child cannot hold the test output open and stall a
     -+	# reader such as prove.
     ++	# Launch the passthrough request in the background. Record its pid
     ++	# so it can be killed when the test finishes if, for some reason, the
     ++	# request stays blocked and would stall a test runner.
      +	{ (
      +		cd workdir &&
      +		ROLE=passthrough sh "$HELPER" >../passthrough.out 2>../passthrough.err
     @@ t/t5567-one-time-script.sh (new)
      +	passthrough_pid=$! &&
      +	test_when_finished "kill $passthrough_pid 2>/dev/null || :" &&
      +
     -+	# Wait until the passthrough request is past the marker check.
     ++	# Wait until the passthrough request is "in-flight" and paused
     ++	# mid-response.
      +	read -r entered <"$ENTERED" &&
      +
     -+	# Run the modifying request to completion while the passthrough request
     -+	# is still blocked.
     ++	# Launch the request for a modified response while the passthrough
     ++	# request is concurrently "in-flight" and paused.
      +	(
      +		cd workdir &&
      +		ROLE=modify sh "$HELPER" >../modify.out 2>../modify.err
      +	) &&
      +
     -+	# Release the passthrough request and let it finish. Ignore the helper
     -+	# exit status here so a broken helper is diagnosed by the assertions
     -+	# below rather than aborting the test.
     ++	# Unblock the passthrough request, allowing git-http-backend to
     ++	# complete its response.
      +	echo released >&9 &&
      +	{ wait "$passthrough_pid" || :; } &&
      +
     -+	# Neither request may error out or produce an empty (HTTP 500) body,
     -+	# and each must have played its role: the modify request rewrote its
     -+	# response and the passthrough request came through untouched.
      +	test_must_be_empty passthrough.err &&
      +	test_must_be_empty modify.err &&
      +	test_grep "Status: 200 OK" passthrough.out &&
 2:  8ed22c02a1 ! 2:  79396d491f t/lib-httpd: make http-429 first-request check atomic
     @@ Metadata
       ## Commit message ##
          t/lib-httpd: make http-429 first-request check atomic
      
     -    http-429.sh returns 429 to the first request for an endpoint and
     -    forwards later ones to git-http-backend so the retry succeeds. It
     -    remembers that it has already answered 429 by checking for a shared
     -    state file with "test -f" and creating it with "touch".
     +    http-429.sh is a helper for testing retry logic. It uses "test -f" to
     +    check for the existence of a state file and later uses "touch" or
     +    "rm -f" on that file to determine if it should return a 429. This method
     +    of managing state can fail if the helper script is invoked concurrently.
     +    However, this failure does not currently manifest itself since the
     +    helper is invoked sequentially.
      
     -    That "check-and-set" is not atomic. Apache runs the CGI for several
     -    requests at once, so two of them can pass the "test -f" before either
     -    "touch"es the file, and both then answer as the first request. The
     -    retry flow is mostly sequential, so this has not been observed to fail,
     -    but the race is latent. Replace the check and the "touch" with a single
     -    atomic "mkdir", which fails if the directory already exists, so exactly
     -    one of the concurrent requests is rate-limited and the rest are
     -    forwarded.
     -
     -    The "permanent" mode needs one extra step, for correctness rather than
     -    tidiness. The marker means "429 already served, now forward", so it must
     -    never be visible to a request that must itself return 429. Since
     -    "permanent" returns 429 to every request, it must leave no marker. The
     -    original did not manage this. It ran the "touch" unconditionally and
     -    removed the file with "rm -f" in the "permanent" case, and that
     -    "create-then-remove" has the same racy window: a concurrent "permanent"
     -    request can see the marker before the "rm -f" and be wrongly forwarded.
     -    Skipping the "mkdir" entirely for "permanent" (the "!= permanent" guard)
     -    leaves no marker at all, so every "permanent" request rate-limits.
     -
     -    There is no regression test. The check and the set are adjacent commands
     -    with nothing in between to synchronize on, so the overlap cannot be
     -    forced deterministically, only reproduced by chance; the fix is
     -    preventive.
     +    As a preventive measure, fix the state management logic so it relies on
     +    an atomic mkdir operation to mark that a 429 was returned. When
     +    $retry_after is "permanent", always return 429 now that we do not rely
     +    on a state file that is "touch"ed and "rm"ed to indicate when to respond
     +    with a 429.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ t/lib-httpd/http-429.sh: repo_path="${remaining#*/}"  # Get rest (repo path)
      -# Use current directory (HTTPD_ROOT_PATH) for state file
      -# Create a safe filename from test_context, retry_after and repo_name
      -# This ensures all requests for the same test context share the same state file
     -+# Store state in the current directory (HTTPD_ROOT_PATH). Build a safe name
     -+# from test_context, retry_after, and repo_name, so that all requests for one
     -+# test context share the same state.
     ++# Use current directory (HTTPD_ROOT_PATH) to hold state directory
     ++# Create a safe directory name from test_context, retry_after and repo_name
     ++# This ensures all requests for the same test context share the same state directory
       safe_name=$(echo "${test_context}-${retry_after}-${repo_name}" | tr '/' '_' | tr -cd 'a-zA-Z0-9_-')
      -state_file="http-429-state-${safe_name}"
      +state="http-429-state-${safe_name}"
       
      -# Check if this is the first call (no state file exists)
      -if test -f "$state_file"
     -+# This endpoint returns 429 to the first request. It forwards every later
     -+# request to git-http-backend, so the retry succeeds. Apache can run this CGI
     -+# for several requests at the same time. A single atomic "mkdir" selects the
     -+# first request, because only one "mkdir" succeeds. That request returns 429
     -+# and leaves the directory as the "already rate-limited" marker. Every later
     -+# "mkdir" fails, so the endpoint forwards those requests.
     -+#
     -+# "permanent" is the exception. It must return 429 to every request, so it
     -+# skips the "mkdir" and records no state. A leftover directory would let a
     -+# later "permanent" request find the marker. The endpoint would forward that
     -+# request, which "permanent" must not allow.
     ++# Check if this is the first call (no state directory exists), or if
     ++# the retry-after-value is "permanent", which indicates a 429 must be
     ++# returned for every request (even if the state directory exists).
      +if test "$retry_after" != permanent && ! mkdir "$state" 2>/dev/null
       then
       	# Already returned 429 once, forward to git-http-backend
 3:  374d148f43 ! 3:  d8d11ad246 t/lib-httpd: document writing concurrency-safe CGI helpers
     @@ Metadata
       ## Commit message ##
          t/lib-httpd: document writing concurrency-safe CGI helpers
      
     -    The apply-one-time-script.sh and http-429.sh fixes share a root cause: a
     -    CGI helper assumed it had a file to itself, when Apache can run the
     -    helper for several requests at once. Document the atomic idioms that
     -    avoid this next to where lib-httpd.sh installs the CGI scripts, so the
     -    advice is in front of anyone adding another one.
     -
     -    The note describes the anti-pattern, a "test -f" check followed by a
     -    separate action, and the two atomic alternatives these helpers now use:
     -
     -     - "mkdir", which fails if the directory exists, to elect the first
     -       request (http-429.sh); and
     -     - "rm" without "-f", which fails once the file is gone, to consume a
     -       one-shot marker (apply-one-time-script.sh).
     +    Update t/lib-httpd.sh to document the fixes applied to
     +    apply-one-time-script.sh and http-429.sh for future developers working
     +    on helper scripts. Add concrete examples of patterns and anti-patterns
     +    that should be considered when handling state management.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ t/lib-httpd.sh: prepare_httpd() {
       	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
       	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
       	cp "$TEST_PATH"/proxy-passwd "$HTTPD_ROOT_PATH"
     -+	# Apache runs each of these CGI scripts once per request. Apache can run one
     -+	# script for several requests at the same time. A helper that keeps state
     -+	# between requests must update that state with one atomic operation. A check
     -+	# and then a separate action is not safe: two requests can both pass the
     -+	# check before either one acts. Test the exit status of one atomic operation
     -+	# instead:
     -+	#   - "mkdir dir" fails if the directory exists, so only one request
     -+	#     succeeds. http-429.sh selects the first request this way.
     -+	#   - "rm marker" (without "-f") fails if the marker is gone, so only one
     -+	#     request consumes it. apply-one-time-script.sh claims its one-shot
     -+	#     marker this way.
     -+	# A scratch file name includes the process ID ($$), so concurrent requests
     -+	# do not overwrite each other's files.
     ++	# Apache can run the following scripts concurrently per request. Make
     ++	# sure any state management logic is resilient to race conditions.
     ++	#
     ++	# For example:
     ++	#   - use "mkdir dir" to ensure only one request "succeeds" under some
     ++	#     condition (see http-429.sh).
     ++	#   - chain (&&) atomic operations like "rm marker" (no -f) with the
     ++	#     logic that "claims" the marker instead of relying on a separate
     ++	#     "test -f" and "rm marker" check (see apply-one-time-script.sh).
     ++	#   - use scratch file names that include the process ID ($$), so
     ++	#     concurrent requests do not overwrite each other's state.
       	install_script incomplete-length-upload-pack-v2-http.sh
       	install_script incomplete-body-upload-pack-v2-http.sh
       	install_script error-no-report.sh

-- 
gitgitgadget
