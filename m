Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800220;
	b=mjcVZZUjsLVt229DKNzj2BkTcngPBT6EaPS+x9nCLZSjBGAmglpDjEZgUTpmqCFdwj0X
	 J8KMuaxvL9L/f/NhJkefzqEcz2yrTLxlLttZzw6bnyIXmgy+9SX2/TFjr537t61g3c19s
	 AcTsbjsOzmU385E4PuWcEkeWJDDz1KOQ04Kb56TH19MkjN6Xm7+qxRMtTS+XPJho9ugjr
	 94+0YPM8otnXJAn7PhiF9XEJQ1pvukdh0YTkr43aGlk6vB20bU/90E5AoROKbwTyJtq1N
	 MSTLQUywiSrbiWkbv5yv6bE89X145ZdGrlLhIq4DvqVOGmcMOBALqGVKPMNZWtH3Vgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer;
	bh=RSi9/QvpTwzIT7LK/YzJNQ8FbngV0ezBn+sIOpwnnpE=;
	b=En5+bN4AJL6fZBQ2CXHA7vIwwjfaI6TD54vcGe89W4cSmjTsERPdduLNey85Md2HxtUI
	 iQVAU1c5OOo8FK1GgnTEfb+Qcz9QziDynJFKl2HxWMyWx1aDWo/CnLsU3O34uaTME5GPf
	 Al4/QBsdHSJCTYWOj5FfS7odwwycHFKKWn6WX4MA4vvRJfsaqTUmnIWVS0U1gm+Cg/afg
	 rW3J35xERhNJgrQmuZ050Fq2eeKyMaLwB/uHzgfK7GJb7TWHpGQBTj9QMgSKdUCr0QXbD
	 99Ss6VGVBKXy7spkkL/O1Q/vExzhXAYgzfms1VfFuoAh2A6JA6AP6tFQePSeLmwe1Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mLo1GMa3;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40F606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 17:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE40F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mLo1GMa3
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2761c69fbso12148787c88.0
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 09:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795800219; x=1796405019; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RSi9/QvpTwzIT7LK/YzJNQ8FbngV0ezBn+sIOpwnnpE=;
        b=mLo1GMa3+1ae/AlzL2/+HJvpuVZqM9nQRGV77a1xV5kM/f11EBse0Z7CxYqqHBOHkE
         6EmEG+EZ85OoSQpX/182wdQhwypUwZW2ckXwU8Eu91L/MPyZsti+rZfo9nr65veYzQt8
         bkcpWwWafa3yGXCIuqyZ5kOUmWdtoGUx/Vy6vgB821lqck5p+kJlMXlH8SwoHo8WHuVC
         ljYX1qF62maPq1cnG8AMT47eUvnjCm7HjqajISSwVRYr9ZcL/FXA5IXZ9h20s+n4+wwO
         2XovHez3l2fckhWR5uWh3GaJNrEXiTyEJ7pvi2ooFQB1koA/TKFkOU7yCtemSbANGk8y
         Equg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795800219; x=1796405019;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RSi9/QvpTwzIT7LK/YzJNQ8FbngV0ezBn+sIOpwnnpE=;
        b=Rn+yxKCiAvAZSJODSu6IRtpMEBT9M7vQ3kA8Ul0kX33zX2+y03zSPljnYobxA0hX+M
         ffv2Q/pJeCD+cFk0x5VsHmPD23Fo9LcAWZVGEmAR2RNxc0MoBNneDJayWyxzAT4b2oWN
         NyO+qRiZU/cyCABbMeipe3XZHhR++49BgbU3d2m8mRMJcvrMdappZKeEF9gpA4sEuCKZ
         myznrUOvC3X4dDyH8PY2inyoItjrg7YpXc+OKQW4162LVuYFz/Rf3I6NpatVA249iocu
         5eBGzkiIpQTJ+KVMKTJAgDufIqKdtUdNsc81LHka0qUGL8gxizi3Gln6ljjH7WhmA2+Z
         I1/A==
X-Gm-Message-State: APuU4Z/tqugWIo5KtZuKSewLNV0n9n51ze6YeEPzFrFdSoBr2ZNzS19H
	LSDFpfItFBdEF7RCaHsNzCi0wuDuCv9br8pvDn1/G3uNyEHbGM3RQwGKKFSmAA==
X-Gm-Gg: AZFdTZcX1Z/gtHeUz2k7ngjV4ZeqmVUM0dBzlx5ULAPT0LDN4c+ncwVtaWNvZ6N0lVG
	qBxgZTrTzcbLYyAC9RApqHcxnIdTmHze1AK8EepKZ2hAxmwXuw3cgTaYwm57G5O+TCkjylC6Fms
	l+UO2CsigD5yDSD81BbzmuUthZo1h95fNh11sEQQ0qCdiLXurG9cw0qCDYjIB0zuM+CyUBc/3/s
	tN3vQT5w2/bJEztP9inJJGyfOUdf+/jV9yAiHmW5uFwapg1VHhNo1GDEs7VYZ9fIhdthPbJpNzm
	LLz43aX4Ti3zpNEKpUbIKBv0m2o1sIYYzGlXwzBCzAdPq1ozLQ0gYv+KutolqHmkGX5qmDdKzZj
	NkV7onoew+sXBHns3U8B5zTyusZfsmUWlKQi+XAJ+Ym3+zSScZkpoW2UqRYrtOkms1+nx7IP3N+
	Td+Lc3rf21IGSzXioWqO3Dee7PHEfGppz1V7DGwJwF/sbT5Ts5UHA/2KFo1krvQqZhHGCUOgXmV
	NJOmJr63bg1AjPYhKcF7LopwzTpBLSoNd4/wsDxFIcNiAkV+SNM+SE9BJ3DskPfCx9HY2TlvFKq
	zkO7F8C/jY7sewdp0FCo3g066MM2xQkjC5b3x8I=
X-Received: by 2002:a05:693c:87cc:20b0:358:3426:d601 with SMTP id 5a478bee46e88-3856c0d0961mr25411570eec.2.1795800218414;
        Fri, 27 Nov 2026 09:23:38 -0800 (PST)
Received: from [127.0.1.1] ([2406:7400:12b:ed80:b0d1:a550:950a:606f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm84086600eec.26.2026.11.27.09.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 09:23:38 -0800 (PST)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Fri, 27 Nov 2026 22:53:15 +0530
Subject: [PATCH v3] test-lib: run EXPENSIVE tests one at a time
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-ks-ci-long-test-hang-fix-v3-1-91b2aac82a1c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIO8CWsC/42NzQ7CIBAGX6Xh7BqgtT+efA/jocLSom0xgETT9
 N2FGhMvJh5n8+3MTBxajY7ss5lYDNppM0XINxkRfTt1CFpGJpzykjFWwdWB0DCYqQOPzkMagdI
 PoLTGiitZUFGS+H6zGM+r+nh6s7ufLyh88qVFr5039rm2A0u7T6b5nQkMGBQ7wZVSpWwUPXRjq
 4etMCNJmcD/FfEoyivKmKB1XlP5LVqW5QVLpRwKGwEAAA==
X-Change-ID: 20261117-ks-ci-long-test-hang-fix-008e72fd40c6
In-Reply-To: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
References: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.16.0

Recently, we've acquired quite a few expensive tests in our test suite.
For instance, these commits add several tests that require
multi-gigabytes of memory:

  - 89048b48fb (t1600-index: add expensive tests for over-long
    tree paths, 2026-10-16) added tests to t1600

  - 288266c11d (xdiff: use size_t for merge buffer size computations,
    2026-10-16) added tests to t4300

  - 55c54fd375 (apply: reject binary patches greater than MAX_APPLY_SIZE,
    2026-03-25) added tests to t4141

We also have the memory hungry 5GB filtered hash-object test in t1007.

When GIT_TEST_LONG is set, "prove --jobs" happily runs several of these
at once. On the 16GB GitLab CI runners this exhausts memory: the
sanitizer jobs have been hanging in t1007 until they hit the job
timeout ever since the new EXPENSIVE tests in t1600 started running
alongside it. Running the two under a 16GB memory cap reproduces it,
with the t1007 git process getting OOM-killed.

GitHub CI runners are no exception and observe the same behaviour.

Take a lock shared by all test scripts around each EXPENSIVE test, so
only one of them runs at a time. Cheap tests in the same scripts keep
running in parallel. Only the expensive ones wait for each other.

The lock is a file in TEST_RESULTS_DIR holding its owner's PID. A
script writes its PID to a file of its own and hard links it into place
with ln(1). Like mkdir(1), that is atomic and fails if the lock exists,
but the lock never exists without its owner recorded in it.

The lock is released after the test and its cleanup finish, and from
the EXIT trap. A lock whose owner is gone was left by a killed script,
and a waiter removes it after re-reading it, so that a lock another
waiter has just taken is left alone. Two waiters clearing the same
stale lock at once may let two expensive tests run together, which is
rare and better than hanging. If the lock cannot be created although
nobody holds it, e.g. without hard link support, the test runs anyway.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
In recent times, we've been noticing the sanitizer jobs (linux-leaks,
linux-reftable-leaks, linux-asan-ubsan) hang and fail with timeout in
our GitLab CI runners. On some digging, it turns out that this is
because of multiple memory hungry tests running in parallel.

So, I thought of suggesting this patch to serialize the expensive tests
at least to avoid the putting the CI runners under memory pressure.

The GitHub CI runners also observed the same behaviour.

Both CI runners are happy with this change.

GitHub: https://github.com/sivaraam/git/actions/runs/43281285339
GitLab: https://gitlab.com/gitlab-org/git/-/pipelines/3079929506
---
Changes in v3:
- Fixed issues in the commit message as pointed out by Junio.
- Fixed a race, pointed out in review, where a waiter could remove a
  lock another script had just taken, letting two EXPENSIVE tests run
  at once. A waiter now re-reads the owner and only removes the lock
  if it still names the same dead process.
- Fixed a deadlock where a script killed between creating the lock and
  recording its PID left a lock that nobody would ever remove. The lock
  is now a hard link to a file that already holds the PID, so it never
  exists without an owner.
- A lock that names the waiter's own PID (left by a dead holder whose
  PID was reused) is now treated as stale instead of waited on forever.
- If the lock cannot be created although nobody holds it (no hard
  links, read-only or full disk), the test runs without it instead of
  waiting forever.
- Rewrote the lock part of the commit message for the new scheme.
- Link to v2: https://patch.msgid.link/20261119-ks-ci-long-test-hang-fix-v2-1-37011c08380d@gmail.com

Changes in v2:
- Corrected commit messages as per Patrick's suggestions
- Tweaked the shell function comment to avoid mentioning 'prove --jobs'
- Made the owner and waiting variables local within acquire_expensive_lock_
- Link to v1: https://patch.msgid.link/20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com

Range-diff vs. v2
1:  7152a81bdc ! 1:  fd87caa359 test-lib: run EXPENSIVE tests one at a time
    @@ Commit message
         For instance, these commits add several tests that require
         multi-gigabytes of memory:
     
    -      - 9048b48fb (t1600-index: add expensive tests for over-long
    +      - 89048b48fb (t1600-index: add expensive tests for over-long
             tree paths, 2026-10-16) added tests to t1600
     
           - 288266c11d (xdiff: use size_t for merge buffer size computations,
             2026-10-16) added tests to t4300
     
           - 55c54fd375 (apply: reject binary patches greater than MAX_APPLY_SIZE,
    -        2026-03-25), added tests to t4141
    +        2026-03-25) added tests to t4141
     
         We also have the memory hungry 5GB filtered hash-object test in t1007.
     
    @@ Commit message
         GitHub CI runners are no exception and observe the same behaviour.
     
         Take a lock shared by all test scripts around each EXPENSIVE test, so
    -    only one of them runs at a time. The lock is a directory in
    -    TEST_RESULTS_DIR, created with mkdir(1) like the existing valgrind
    -    symlink lock. It records the holder's PID so that a lock left behind by
    -    a script that was killed with SIGKILL gets taken over by the next
    -    waiter. It is released after the test and its cleanup finish, and from
    -    the EXIT trap when a script dies or is interrupted while holding it.
    +    only one of them runs at a time. Cheap tests in the same scripts keep
    +    running in parallel. Only the expensive ones wait for each other.
     
    -    Cheap tests in the same scripts keep running in parallel. Only the
    -    expensive ones wait for each other.
    +    The lock is a file in TEST_RESULTS_DIR holding its owner's PID. A
    +    script writes its PID to a file of its own and hard links it into place
    +    with ln(1). Like mkdir(1), that is atomic and fails if the lock exists,
    +    but the lock never exists without its owner recorded in it.
    +
    +    The lock is released after the test and its cleanup finish, and from
    +    the EXIT trap. A lock whose owner is gone was left by a killed script,
    +    and a waiter removes it after re-reading it, so that a lock another
    +    waiter has just taken is left alone. Two waiters clearing the same
    +    stale lock at once may let two expensive tests run together, which is
    +    rare and better than hanging. If the lock cannot be created although
    +    nobody holds it, e.g. without hard link support, the test runs anyway.
     
         Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
     
    @@ t/README: appropriately before running "make". Short options can be bundled, i.e
      	This causes additional long-running tests to be run (where
     -	available), for more exhaustive testing.
     +	available), for more exhaustive testing. These tests can use a
    -+	lot of memory and disk, so only one of them runs at a time, even
    ++	lot of memory, so only one of them runs at a time, even
     +	when several test scripts run in parallel (e.g. "prove --jobs").
    ++	They take turns through a lock file, "expensive.lock" in the
    ++	test-results directory. A lock left behind by a killed test
    ++	script is cleared by the next one that needs it. If the lock
    ++	cannot be created at all, the test runs anyway.
      
      -r::
      --run=<test-selector>::
    @@ t/test-lib.sh: die () {
      	# ctrl-C, i.e. when 'test_done' is not invoked at all.
      	test_atexit_handler || code=$?
     +	release_expensive_lock_
    ++	test -z "$expensive_lock_" || rm -f "$expensive_lock_.$$"
      	if test -n "$GIT_EXIT_OK"
      	then
      		exit $code
    @@ t/test-lib.sh: fail_117 () {
      	return 117
      }
      
    -+# EXPENSIVE tests may need many gigabytes of memory or disk, so two of
    -+# them running at the same time can exhaust the machine.
    ++# EXPENSIVE tests may need many gigabytes of memory, so two of them
    ++# running at the same time can exhaust the machine.
     +#
     +# Allow only one at a time across all test scripts that share
     +# this TEST_OUTPUT_DIRECTORY.
    @@ t/test-lib.sh: fail_117 () {
     +have_expensive_lock_=
     +
     +acquire_expensive_lock_ () {
    -+	local owner waited=
    ++	local owner waited= tmp="$expensive_lock_.$$" misses=0
     +	mkdir -p "$TEST_RESULTS_DIR" || return 1
    -+	while ! mkdir "$expensive_lock_" 2>/dev/null
    ++	# The lock is a hard link to a file that already holds our PID, so
    ++	# it never exists without its owner recorded in it. Remove any
    ++	# $tmp left by a dead process with our PID first: it may still be
    ++	# linked to that process's lock, which writing to it would empty.
    ++	rm -f "$tmp"
    ++	echo $$ >"$tmp" || return 1
    ++	while ! ln "$tmp" "$expensive_lock_" 2>/dev/null
     +	do
    -+		owner=$(cat "$expensive_lock_/pid" 2>/dev/null)
    -+		if test -n "$owner" && ! kill -0 "$owner" 2>/dev/null
    ++		if ! test -f "$expensive_lock_"
    ++		then
    ++			# Nobody holds the lock, yet we cannot create it (no
    ++			# hard links, disk full, ...). Retry in case it was
    ++			# just released, then run anyway rather than wait
    ++			# forever.
    ++			misses=$((misses + 1))
    ++			test $misses -lt 3 && continue
    ++			say >&3 "cannot take the EXPENSIVE lock, running anyway"
    ++			rm -f "$tmp"
    ++			return 0
    ++		fi
    ++		misses=0
    ++		owner=$(cat "$expensive_lock_" 2>/dev/null)
    ++		# A lock carrying our own PID was left by a dead holder whose
    ++		# PID we were given again; we know we do not hold it.
    ++		if test -n "$owner" &&
    ++		   { test "$owner" = $$ || ! kill -0 "$owner" 2>/dev/null; }
     +		then
     +			# The holder was killed without releasing the lock.
    -+			rm -rf "$expensive_lock_"
    ++			#
    ++			# Another waiter may have taken it over since we
    ++			# looked, so only remove it if it is still the same.
    ++			if test "$(cat "$expensive_lock_" 2>/dev/null)" = "$owner"
    ++			then
    ++				rm -f "$expensive_lock_"
    ++			fi
     +			continue
     +		fi
     +		if test -z "$waited"
    @@ t/test-lib.sh: fail_117 () {
     +		fi
     +		sleep 1
     +	done
    -+	echo $$ >"$expensive_lock_/pid"
     +	have_expensive_lock_=t
    ++	rm -f "$tmp"
     +}
     +
     +release_expensive_lock_ () {
     +	test -n "$have_expensive_lock_" || return 0
    -+	rm -rf "$expensive_lock_"
    ++	rm -f "$expensive_lock_"
     +	have_expensive_lock_=
     +}
     +
---
 t/README      |  8 ++++++-
 t/test-lib.sh | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index fd7e8504b5..824783acfa 100644
--- a/t/README
+++ b/t/README
@@ -117,7 +117,13 @@ appropriately before running "make". Short options can be bundled, i.e.
 -l::
 --long-tests::
 	This causes additional long-running tests to be run (where
-	available), for more exhaustive testing.
+	available), for more exhaustive testing. These tests can use a
+	lot of memory, so only one of them runs at a time, even
+	when several test scripts run in parallel (e.g. "prove --jobs").
+	They take turns through a lock file, "expensive.lock" in the
+	test-results directory. A lock left behind by a killed test
+	script is cleared by the next one that needs it. If the lock
+	cannot be created at all, the test runs anyway.
 
 -r::
 --run=<test-selector>::
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c56654b7c5..916ec2d7d1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -784,6 +784,8 @@ die () {
 	# test script run with '--immediate' fails, or when the user hits
 	# ctrl-C, i.e. when 'test_done' is not invoked at all.
 	test_atexit_handler || code=$?
+	release_expensive_lock_
+	test -z "$expensive_lock_" || rm -f "$expensive_lock_.$$"
 	if test -n "$GIT_EXIT_OK"
 	then
 		exit $code
@@ -1089,6 +1091,71 @@ fail_117 () {
 	return 117
 }
 
+# EXPENSIVE tests may need many gigabytes of memory, so two of them
+# running at the same time can exhaust the machine.
+#
+# Allow only one at a time across all test scripts that share
+# this TEST_OUTPUT_DIRECTORY.
+expensive_lock_="$TEST_RESULTS_DIR/expensive.lock"
+have_expensive_lock_=
+
+acquire_expensive_lock_ () {
+	local owner waited= tmp="$expensive_lock_.$$" misses=0
+	mkdir -p "$TEST_RESULTS_DIR" || return 1
+	# The lock is a hard link to a file that already holds our PID, so
+	# it never exists without its owner recorded in it. Remove any
+	# $tmp left by a dead process with our PID first: it may still be
+	# linked to that process's lock, which writing to it would empty.
+	rm -f "$tmp"
+	echo $$ >"$tmp" || return 1
+	while ! ln "$tmp" "$expensive_lock_" 2>/dev/null
+	do
+		if ! test -f "$expensive_lock_"
+		then
+			# Nobody holds the lock, yet we cannot create it (no
+			# hard links, disk full, ...). Retry in case it was
+			# just released, then run anyway rather than wait
+			# forever.
+			misses=$((misses + 1))
+			test $misses -lt 3 && continue
+			say >&3 "cannot take the EXPENSIVE lock, running anyway"
+			rm -f "$tmp"
+			return 0
+		fi
+		misses=0
+		owner=$(cat "$expensive_lock_" 2>/dev/null)
+		# A lock carrying our own PID was left by a dead holder whose
+		# PID we were given again; we know we do not hold it.
+		if test -n "$owner" &&
+		   { test "$owner" = $$ || ! kill -0 "$owner" 2>/dev/null; }
+		then
+			# The holder was killed without releasing the lock.
+			#
+			# Another waiter may have taken it over since we
+			# looked, so only remove it if it is still the same.
+			if test "$(cat "$expensive_lock_" 2>/dev/null)" = "$owner"
+			then
+				rm -f "$expensive_lock_"
+			fi
+			continue
+		fi
+		if test -z "$waited"
+		then
+			say >&3 "waiting for another EXPENSIVE test to finish"
+			waited=t
+		fi
+		sleep 1
+	done
+	have_expensive_lock_=t
+	rm -f "$tmp"
+}
+
+release_expensive_lock_ () {
+	test -n "$have_expensive_lock_" || return 0
+	rm -f "$expensive_lock_"
+	have_expensive_lock_=
+}
+
 test_run_ () {
 	test_cleanup=:
 	expecting_failure=$2
@@ -1103,6 +1170,12 @@ test_run_ () {
 		fi
 	fi
 
+	case ",$test_prereq," in
+	*,EXPENSIVE,*)
+		acquire_expensive_lock_
+		;;
+	esac
+
 	setup_malloc_check
 	test_eval_ "$1"
 	eval_ret=$?
@@ -1115,6 +1188,7 @@ test_run_ () {
 		test_eval_ "$test_cleanup"
 		teardown_malloc_check
 	fi
+	release_expensive_lock_
 	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"
 	then
 		echo ""

---
base-commit: acba8bf9753134d9bde89f94369f775838a8c5fe
change-id: 20261117-ks-ci-long-test-hang-fix-008e72fd40c6

