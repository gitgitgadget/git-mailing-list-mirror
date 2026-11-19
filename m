Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109369;
	b=k2/y0EeFkclgabn3ma0afQaGUSzuIt00sHBJVFPiMPXTIZCBv5Zt4az+cqUqRhE8Gp0C
	 QKRokiLYcHdqAH3ZrN9r8MGrtAe0WZrAWBfKh8WT190vsSa1CjvBeUoG260Dm4I/GxzFp
	 5xPBbl9zjPprKJoodH5hMCVIK6Vf5USVkNVfF5vWCA1cTWnMzGWWfsDDKonBCGJDo0bQI
	 QPLmKZMxOr/LKRbN8PkSy/tUiekODQAC7t0xrFKs7Fo3b5jqd0iLsx18I8ok5XtiSpxk+
	 dCFqOV6fEjYF0ixfm06VNOURfZcStMHXDVc6d8Ok8NkvFFYnU/1AuBPVOabHi1hrGpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109369;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer;
	bh=kn+TbEeBXhBtQNqlA2p7SVX4cJFhRc6trwMWmnBZWpA=;
	b=KzahlcunS0exDuNRoNqMlC+NXcqhoDoZwtIMvFRI669p9TvilVU2Hk9ZfZHOkb7OU4Zb
	 tTWE39OoPpsUp914OJ7fsX4jLjLBCTcuTBESSF8GHDuldMF7IlM0l4FOTT2qA1NquG0YW
	 ATcUqRRQaiNUyzhhuCIWyr9AxUDyrxkjQqNoWlxFahqmKARjlS3ssNTCW2SyDevt5FkOj
	 Dk9xSFq1NoDIFOzI2caBTvrqLjUYDEj3D40pn/oCD5oImnyzmrRsrz0xTxeHIPUW8XSDQ
	 ph5IKRveHq/d+mkY8u4ymZr89JK5R+JDxX7az9GvCMGtfOsuAAbjRbJtxmNlPJZsOww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X2OW9ubL;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C0C606A325
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 17:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0C0C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X2OW9ubL
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a315ed211so1159246eec.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 09:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795109368; x=1795714168; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kn+TbEeBXhBtQNqlA2p7SVX4cJFhRc6trwMWmnBZWpA=;
        b=X2OW9ubLO7u299UrWLDnFAWY6QuDIfxP+1WZ5VCCNZVDX7jPQ2kGyxT3mMWftCFrQ+
         inBPvR/JD3shNiugMIgBGdWFs1CowtoeGprq5d7xr0yplcJt6tW8hDqxJxAU4qNlbrwh
         jtwx86khBYspCOGiER7X1zhS2GbKCZ7DDu71Yv7ajjwlN3usYNwDtRN+chSJ0Ds1MYm2
         xjlu0hPo9OFZWxvKxbqxZ0+dGJXEzyqalPuDCOMO+jP/M6LZj8KMMmwqHgyPhIoerthA
         A8LCJ2LSFuVE0DZjy/hDbzQQc73CZXeiA6SZzR6s50whzieHHxlD3JvtuxGvxO50sHB/
         fT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795109368; x=1795714168;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kn+TbEeBXhBtQNqlA2p7SVX4cJFhRc6trwMWmnBZWpA=;
        b=JY3nV6CML5T6oyRfCzgDvUzJODX3yTbcQyAQIR541s4zM+SHQlgb8s4+T5kLOQkVsE
         goyyE9oPpOlQWCHO7lRkgkmFdrGs4ksF6NFcrSU/cgi/Ur+itsj+WpT56IwQ57yV2GqV
         9cHYae+/LzKbxCqEAHBycv4Q2c9a47+5fyQNNhT3KE7fiObQDqQ1+Y0SDGLE/G4rBP0H
         YDDnAepZRCTtI5/2msLN8kRRwjtkj3HWmJkSV72aMDa+IjG2m84EAkeSc2N4o9idjRMw
         nELmI6Rnp3HLoEBkNzJ0iwi7m1qb+6WtVSLjKanI2Y8T9vSgGatr57W4S7KvLo9/25ok
         4dBg==
X-Gm-Message-State: APuU4Z/F1HKt3ydqx9U2EKkFYhnt4G1fl+bPac7mgj6KM5wFYoD9uyVA
	pLHwPr9cP66QkA4oQZq/mca0ZL9aTlJdiou0bta54fXj0RzMiTWwnn6lzlY0kw==
X-Gm-Gg: AZFdTZf3EqrO3zletuYHZCQUTyCeq9PcsVeJ5DBfAMfYDei5meA9AT7rp/vFeJixv0n
	8p0m1kh/OgtVObl26Fmq+6VurGZlzPbs+ueN9oLcBcCCCtZq5v8QgZZbYfs//jtE31xA1xIkaW8
	vE3vU9Jx7W+0MoTC0d4xaxLrw63LkO6eQ01QSw1qDk57tmJTShFg/ECQWwT/jUoFKZh5gbS9kQh
	rM4TSgsuoKsfXEN/2IDZYUpQZl5SWc+ZTAIbi/fFpjdBdj1HdOas6VM+spl7FkzRdCpzf1LWCW4
	EOppaIx+ikhZXng14Dfnj3Y9kW1dsmbUqHdnNC0OxlG4DEdJWUa8c3VJU8kWl4zbIobk+HguA5M
	DH8tXhDeIzHJz3FLldCTZ8dVfE0ialzudvtKIOtSEWtUbXJWqOnYwc1uYuidgeBeuJHLcxk1vqA
	9pTZesqYxdMjbWg9dpfpk+yGVmJKs0YlNeHP2+NBSzZ0GLibowcrjG7V+a1tnlckbIhyviivtJ/
	tIpVtbI5aZqiDUL8ekNQZwdSg4XxcAwO53wxOv4QmiHH4RS6vmCZmqpX2tIi6Ge4lAmCs68h7vE
	v+T1K683rbwHChiP3Rf3bLy4juXPdNXxVYRF6TsKJxH/Rp022v92soCpGw==
X-Received: by 2002:a05:7301:6782:b0:385:2ea8:aac7 with SMTP id 5a478bee46e88-3852ea8d7d4mr832374eec.23.1795109367407;
        Thu, 19 Nov 2026 09:29:27 -0800 (PST)
Received: from [127.0.1.1] ([106.51.27.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385667decc2sm266501eec.9.2026.11.19.09.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:29:27 -0800 (PST)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Thu, 19 Nov 2026 22:59:15 +0530
Subject: [PATCH v2] test-lib: run EXPENSIVE tests one at a time
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
Message-Id: <20261119-ks-ci-long-test-hang-fix-v2-1-37011c08380d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOwx/2oC/3WNQQ6CMBBFr0K6dkzbIIgr72FYYJnCKFDTqURDu
 LstxqXLN3nz3yIYPSGLU7YIjzMxuSmC3mXC9M3UIVAbWWipC6VUCXcGQzC4qYOAHCBJYOkFUh6
 x1LbNpSlEfH94jOdt+lJ/mZ/XG5qQ9pLREwfn31t7Vsn7Zar/mVmBgvxgtLW2aCsrz93Y0LA3b
 hT1uq4fx1Ax8dIAAAA=
X-Change-ID: 20261117-ks-ci-long-test-hang-fix-008e72fd40c6
In-Reply-To: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
References: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.16.0

Recently, we've acquired quite a few expensive tests in our test suite.
For instance, these commits add several tests that require
multi-gigabytes of memory:

  - 9048b48fb (t1600-index: add expensive tests for over-long
    tree paths, 2026-10-16) added tests to t1600

  - 288266c11d (xdiff: use size_t for merge buffer size computations,
    2026-10-16) added tests to t4300

  - 55c54fd375 (apply: reject binary patches greater than MAX_APPLY_SIZE,
    2026-03-25), added tests to t4141

We also have the memory hungry 5GB filtered hash-object test in t1007.

When GIT_TEST_LONG is set, "prove --jobs" happily runs several of these
at once. On the 16GB GitLab CI runners this exhausts memory: the
sanitizer jobs have been hanging in t1007 until they hit the job
timeout ever since the new EXPENSIVE tests in t1600 started running
alongside it. Running the two under a 16GB memory cap reproduces it,
with the t1007 git process getting OOM-killed.

GitHub CI runners are no exception and observe the same behaviour.

Take a lock shared by all test scripts around each EXPENSIVE test, so
only one of them runs at a time. The lock is a directory in
TEST_RESULTS_DIR, created with mkdir(1) like the existing valgrind
symlink lock. It records the holder's PID so that a lock left behind by
a script that was killed with SIGKILL gets taken over by the next
waiter. It is released after the test and its cleanup finish, and from
the EXIT trap when a script dies or is interrupted while holding it.

Cheap tests in the same scripts keep running in parallel. Only the
expensive ones wait for each other.

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
Changes in v2:
- Corrected commit messages as per Patrick's suggestions
- Tweaked the shell function comment to avoid mentioning 'prove --jobs'
- Made the owner and waiting variables local within acquire_expensive_lock_

Link to v1: https://patch.msgid.link/20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com
---
 t/README      |  4 +++-
 t/test-lib.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index fd7e8504b5..c156dd3af6 100644
--- a/t/README
+++ b/t/README
@@ -117,7 +117,9 @@ appropriately before running "make". Short options can be bundled, i.e.
 -l::
 --long-tests::
 	This causes additional long-running tests to be run (where
-	available), for more exhaustive testing.
+	available), for more exhaustive testing. These tests can use a
+	lot of memory and disk, so only one of them runs at a time, even
+	when several test scripts run in parallel (e.g. "prove --jobs").
 
 -r::
 --run=<test-selector>::
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c56654b7c5..193bf06aea 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -784,6 +784,7 @@ die () {
 	# test script run with '--immediate' fails, or when the user hits
 	# ctrl-C, i.e. when 'test_done' is not invoked at all.
 	test_atexit_handler || code=$?
+	release_expensive_lock_
 	if test -n "$GIT_EXIT_OK"
 	then
 		exit $code
@@ -1089,6 +1090,43 @@ fail_117 () {
 	return 117
 }
 
+# EXPENSIVE tests may need many gigabytes of memory or disk, so two of
+# them running at the same time can exhaust the machine.
+#
+# Allow only one at a time across all test scripts that share
+# this TEST_OUTPUT_DIRECTORY.
+expensive_lock_="$TEST_RESULTS_DIR/expensive.lock"
+have_expensive_lock_=
+
+acquire_expensive_lock_ () {
+	local owner waited=
+	mkdir -p "$TEST_RESULTS_DIR" || return 1
+	while ! mkdir "$expensive_lock_" 2>/dev/null
+	do
+		owner=$(cat "$expensive_lock_/pid" 2>/dev/null)
+		if test -n "$owner" && ! kill -0 "$owner" 2>/dev/null
+		then
+			# The holder was killed without releasing the lock.
+			rm -rf "$expensive_lock_"
+			continue
+		fi
+		if test -z "$waited"
+		then
+			say >&3 "waiting for another EXPENSIVE test to finish"
+			waited=t
+		fi
+		sleep 1
+	done
+	echo $$ >"$expensive_lock_/pid"
+	have_expensive_lock_=t
+}
+
+release_expensive_lock_ () {
+	test -n "$have_expensive_lock_" || return 0
+	rm -rf "$expensive_lock_"
+	have_expensive_lock_=
+}
+
 test_run_ () {
 	test_cleanup=:
 	expecting_failure=$2
@@ -1103,6 +1141,12 @@ test_run_ () {
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
@@ -1115,6 +1159,7 @@ test_run_ () {
 		test_eval_ "$test_cleanup"
 		teardown_malloc_check
 	fi
+	release_expensive_lock_
 	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"
 	then
 		echo ""

---
base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
change-id: 20261117-ks-ci-long-test-hang-fix-008e72fd40c6

