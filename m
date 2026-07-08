Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0952D3B993B
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479590; cv=none; b=EQuKbL7HtL3cSZNmxvXvoAVu6BKAlKCqbjNFGDNqD6xG1mEwXNVjOSrjiK/FaDGqMMKfIaAdTmdbMJpxxlKlb8DnRkqPkbMWDw5uGdraCd6jS6bNdGGD6r10cPAcHs4FrCs6LgkRLPH/8ilHIt4ON42B4dEf/P0KDskcUQlmOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479590; c=relaxed/simple;
	bh=QJkHxz6SFoCIwb3MO6Nhav/u3GAPJLGFYjoWuOC2QMA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aKquBFOAXsW5XtlT4b9E1+qZAUJsblVJwyvI7Tn0YvdQg7kMx/EbSqVMRpAmbgkZXTY9hk9uf8BxWdTMGKGFcQQwhYTMdy/Jrx1HGJqH8OaLoQE/B7UJ3WXmLvn9/vTHgLWjSc9aiOE10aiI0hQuPr4UOnKxCmQAGnPkVWo5aRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWfVrUOG; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWfVrUOG"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9f829d75aso128339a34.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 19:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479588; x=1784084388; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MdLFe8ZJYSx8fZr+XZzkA16bava9qqGqjMzlU6s9aY0=;
        b=TWfVrUOGY4/F4nAWd99GnJNuJvY6wnYaTwaVI21NxikTgfydiNhFrmUsxkc7xR741n
         b9oTdD5MKH9eu3aZqyUVXJirUFt5Gg6w/k8o3YfHj0Iw8gu2XqlN9AtVyN33uDl8gn+e
         zVrsG4y91pJzpeECvx1PPLkf3XMlYkaEFpMzNKvcs4wfXdvXKjOf+k4QyXRoXeRQifN2
         RQENJIvqRQvBUbmR5dtwdLZeIV9XHPdbrWhX1Ppyvumb27POfRNoyfRX0n8+hzKnxwS4
         DvtcutwifFJJFcKjb5Krgqpycj6wrzkVPqEI71qZja1M4gfxyTlKA0x8ulpGwee7S9vr
         kzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479588; x=1784084388;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MdLFe8ZJYSx8fZr+XZzkA16bava9qqGqjMzlU6s9aY0=;
        b=CUMYQslhaKduzO/L69YTHa0GUvNNi4/5phH932XfsJLOVL0ljmCJcqn9MfKevdkCn0
         fc7u10wMt85RRO4RnDa8MWemvbGHf0beaGOyDD3hClJR6G8mNoWWyYO+6PdmxoSKKX9j
         1msSunS7mdJWFlOxPkJpSWS6j1t2zhXHCIc5ISMJv/Tnbc3IEVmnlB1xp6G84fIoiDXJ
         /eAOVlIYiDwymIo9GYOeZsXszhCCEalLX/uSI3fNLR5tY0wgWsFzVbFVoypM/ni1DfmS
         Hlew1/xVGK2aiJSAM0xpu2V96WiX06su7xO3q28CFk4jMT24Tty01IGWCSfVdrfbBBRm
         TKpg==
X-Gm-Message-State: AOJu0Yx8XtQA+UHp0mzqfejEHg7IjsI/PSCGQT7D8WnA17XEfGkSI2qB
	RC1sN7DYb6RQ08/s61yinCYDY61E0NgB/W8JyVdO2EPEpS7OaN1f/vAbzueVUMOG
X-Gm-Gg: AfdE7cksQjCl13AmghbPgzjgZkXcXOEP5sGuz6ivURC2SFjHiW5xTlbIO+WVDRUs2ww
	PZwV4Rmix6tHtU4GNkWDd0Ly/aNw1+Yt/EY39gkLajTbF5i6DmJdx2BY1jFAS2gRxJsJz4YXqPn
	IGGu78u40BUJCQd1zSoeWmvhVmpA9F3x2hYGHeRUAbiwhTp/JRHFOpkDk5fd3VEfzM5/VjUZU1b
	Yom5AFV841qPm8/oKDC7fisfqGhAsCX1qvuWgrRnTTDdYzU+QiTqs6rDORAT0N2n6Cs2fwewaof
	8ZMzwEBecyaJFCfJJ6KfWfz48PzFOCYUMv1WuAZLuRwnUHcYfc7OsJoQ5hrzJkA36sImd7Jn+WJ
	wHmMgSO6tjUWWQBIXMfVWQKuhOCq72dTBN/GVhhWjWP6Qbap0ckEq4eGBHNLZ7sR6RasWySxHdG
	Zp6lo9f7uW+RMHQuAQ1w==
X-Received: by 2002:a05:6830:3c09:b0:7e6:f406:2cfa with SMTP id 46e09a7af769-7ebcff7f08fmr454976a34.17.1783479587687;
        Tue, 07 Jul 2026 19:59:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.202.102.208])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb262db2sm863795a34.16.2026.07.07.19.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:59:47 -0700 (PDT)
Message-Id: <9f48aa6d6ddea681b700f689f0509c4b30a7007d.1783479584.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 02:59:41 +0000
Subject: [PATCH 1/3] t/lib-httpd: fix apply-one-time-script race under
 concurrent requests
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

apply-one-time-script.sh checks for the "one-time-script" marker, runs
it, captures the git-http-backend response in the fixed-name files "out"
and "out_modified", and removes the marker only after it has finished
serving the modified response. Because the client receives the response
body before that removal, it can start its next request while the marker
still exists. Apache can then run this CGI for two requests at once: a
partial fetch that receives a REF_DELTA against a missing promisor
object lazily fetches that base while the first response is still in
flight. The second request passes the marker check, the first request
then removes the marker, and the second fails to exec the now-missing
marker, emits no output, and the server answers HTTP 500:

  fatal: ... The requested URL returned error: 500
  fatal: could not fetch <oid> from promisor remote

This has been seen as a flaky failure of t5616.47 on the macOS CI
runners.

Claim the marker atomically with a rename, and only once the one-time
script has succeeded and actually changed the response; give the scratch
files per-request names. A request that loses the rename, or whose
script fails or leaves the response unchanged, serves the unmodified
body and keeps the marker for a later request. No path emits an empty
body, so the HTTP 500 no longer occurs.

Add t5567 to lock this down. The overlap depends on timing, so a live
httpd test such as t5616.47 (the real code path) passes almost every
time even against the buggy helper; t5567 instead drives the helper
directly with a fake git-http-backend and forces the overlap with FIFOs.
Against the pre-fix helper it fails with the same shell error seen in
the field:

  ./one-time-script: No such file or directory

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-httpd/apply-one-time-script.sh | 38 +++++++----
 t/meson.build                        |  1 +
 t/t5567-one-time-script.sh           | 96 ++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 14 deletions(-)
 create mode 100755 t/t5567-one-time-script.sh

diff --git a/t/lib-httpd/apply-one-time-script.sh b/t/lib-httpd/apply-one-time-script.sh
index b1682944e2..a298ae89ae 100644
--- a/t/lib-httpd/apply-one-time-script.sh
+++ b/t/lib-httpd/apply-one-time-script.sh
@@ -6,21 +6,31 @@
 #
 # This can be used to simulate the effects of the repository changing in
 # between HTTP request-response pairs.
-if test -f one-time-script
-then
-	LC_ALL=C
-	export LC_ALL
+#
+# Apache can run this CGI for concurrent requests (for example a partial fetch
+# that lazily fetches a missing object while the first response is still in
+# flight), so the helper claims the marker atomically with a rename, and only
+# once it has decided to modify the response. A request that loses the race
+# finds the marker already gone and serves its response unchanged; no request
+# is left emitting an empty body, which the server would report as HTTP 500.
+# Scratch files are per-request ($$) so concurrent requests do not clobber each
+# other.
+
+test -f one-time-script || exec "$GIT_EXEC_PATH/git-http-backend"
 
-	"$GIT_EXEC_PATH/git-http-backend" >out
-	./one-time-script out >out_modified
+LC_ALL=C
+export LC_ALL
 
-	if cmp -s out out_modified
-	then
-		cat out
-	else
-		cat out_modified
-		rm one-time-script
-	fi
+out=out.$$
+modified=out-modified.$$
+"$GIT_EXEC_PATH/git-http-backend" >"$out"
+
+if ./one-time-script "$out" 2>/dev/null >"$modified" &&
+   ! cmp -s "$out" "$modified" &&
+   mv one-time-script one-time-script.$$ 2>/dev/null
+then
+	cat "$modified"
 else
-	"$GIT_EXEC_PATH/git-http-backend"
+	cat "$out"
 fi
+rm -f "$out" "$modified" one-time-script.$$
diff --git a/t/meson.build b/t/meson.build
index 3219264fe7..a118a4d719 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -707,6 +707,7 @@ integration_tests = [
   't5564-http-proxy.sh',
   't5565-push-multiple.sh',
   't5566-push-group.sh',
+  't5567-one-time-script.sh',
   't5570-git-daemon.sh',
   't5571-pre-push-hook.sh',
   't5572-pull-submodule.sh',
diff --git a/t/t5567-one-time-script.sh b/t/t5567-one-time-script.sh
new file mode 100755
index 0000000000..cd8e656005
--- /dev/null
+++ b/t/t5567-one-time-script.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+
+test_description='apply-one-time-script CGI helper is safe under concurrent requests'
+
+. ./test-lib.sh
+
+HELPER="$TEST_DIRECTORY/lib-httpd/apply-one-time-script.sh"
+
+test_expect_success PIPE 'concurrent requests: one rewritten, one passed through, neither empty' '
+	mkdir workdir fakebin &&
+	ENTERED="$PWD/entered" &&
+	GATE="$PWD/gate" &&
+	export ENTERED GATE &&
+	mkfifo "$ENTERED" "$GATE" &&
+
+	# Stand in for git-http-backend. The modify role returns a response
+	# containing "packfile", which the one-time script rewrites. The
+	# passthrough role returns a response that is left untouched, but first
+	# announces that it has entered the helper and then blocks, so that it
+	# is still in flight when the modify role claims and removes the marker.
+	write_script fakebin/git-http-backend <<-\EOF &&
+	printf "Status: 200 OK\r\n"
+	printf "Content-Type: application/x-git-result\r\n"
+	printf "\r\n"
+	if test "$ROLE" = modify
+	then
+		printf "packfile\n"
+	else
+		echo entered >"$ENTERED"
+		read -r released <"$GATE"
+		printf "refs\n"
+	fi
+	EOF
+
+	# The transform that replace_packfile would install as one-time-script:
+	# rewrite responses that contain "packfile", leave the rest alone.
+	write_script workdir/one-time-script <<-\EOF &&
+	if grep packfile "$1" >/dev/null
+	then
+		sed "/packfile/q" "$1" &&
+		printf "REPLACED\n"
+	else
+		cat "$1"
+	fi
+	EOF
+
+	GIT_EXEC_PATH="$PWD/fakebin" &&
+	export GIT_EXEC_PATH &&
+
+	# Hold GATE open read-write on fd 9 for the duration, so releasing the
+	# passthrough request below cannot block even if that request has
+	# already exited (it keeps a reader on the FIFO).
+	exec 9<>"$GATE" &&
+
+	# Launch the passthrough request in the background. It enters the
+	# helper, signals us through ENTERED, then blocks on GATE inside the
+	# fake backend. The braces keep the && chain intact while backgrounding
+	# only the subshell, so "wait" can reap it by pid; kill it on any exit
+	# so a stray blocked child cannot hold the test output open and stall a
+	# reader such as prove.
+	{ (
+		cd workdir &&
+		ROLE=passthrough sh "$HELPER" >../passthrough.out 2>../passthrough.err
+	) & } &&
+	passthrough_pid=$! &&
+	test_when_finished "kill $passthrough_pid 2>/dev/null || :" &&
+
+	# Wait until the passthrough request is past the marker check.
+	read -r entered <"$ENTERED" &&
+
+	# Run the modifying request to completion while the passthrough request
+	# is still blocked.
+	(
+		cd workdir &&
+		ROLE=modify sh "$HELPER" >../modify.out 2>../modify.err
+	) &&
+
+	# Release the passthrough request and let it finish. Ignore the helper
+	# exit status here so a broken helper is diagnosed by the assertions
+	# below rather than aborting the test.
+	echo released >&9 &&
+	{ wait "$passthrough_pid" || :; } &&
+
+	# Neither request may error out or produce an empty (HTTP 500) body,
+	# and each must have played its role: the modify request rewrote its
+	# response and the passthrough request came through untouched.
+	test_must_be_empty passthrough.err &&
+	test_must_be_empty modify.err &&
+	test_grep "Status: 200 OK" passthrough.out &&
+	test_grep "Status: 200 OK" modify.out &&
+	test_grep REPLACED modify.out &&
+	test_grep ! REPLACED passthrough.out &&
+	test_grep refs passthrough.out
+'
+
+test_done
-- 
gitgitgadget

