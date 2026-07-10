Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA6078F26
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704665; cv=none; b=WtRk4apyvFfUBDCyTc3/KnMi73476Q+sQFv26tHdxg2qzZAfqC/zBF9XA/ALaevTV4tecNRWLk75kwln4Fe5mSVxzbGfuwUjRsamkNWUZeYgeVi52zZTWegGCd9u0xcMAozhXk055C/B2ApuZf48pnhsPOGEqwyGpCwXqIxOh+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704665; c=relaxed/simple;
	bh=wmy5XcSclduvkSo9SBm03qwNbwLANfVNkaEtmhpL7XU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jXpANPFHR7f+/1xw61fAE8gPqq2phLNGfsXwZ47ZTDPeAQh5tz62Alxy/V2J280Jw/z4jRfE8IkUrnfXVDzt0Cc+wYcmHHFST+caHAQnhM6oNoCPs1nyjPLZd9jbKVtKQnFPEcu+x9jGyyL0s+OjD/qUdUYLSJUors+eTj2k4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBYZxsPc; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBYZxsPc"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c1d487f2cso12205031cf.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783704661; x=1784309461; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oyNuxj5YKFe6jqwNYqW+5/2BY5HqqmcgSEjuVUqU6Tc=;
        b=nBYZxsPcrP40cF6ubrbB+4j/WWxCT4yjkqHGTWY2aTJPGh8O4r+dq1x0YK0mNHekMs
         XRds5UJSEw74BarbGAVQvmGisA9a0ABaCkvOaCWbeQm7Mh54t3gIabm6ZbRANhV6pkZp
         NH9OtIk2qx0jUaKAb0sqoRd9BGp7Ki8n5e5SnCM8jUS+P2O6J3ZJ/pP2akjJvXgewNRe
         HcM8u/jNl5VAQxuzvLcfFeuI+/X2U9wsBz9Cr9zSSbrG15ZmGbxjOWLrMt5WcV6JzyjN
         0kHdjENQqlrIjQVFZL/Kw5Y2I8wL854s8DsyZIwGkjvu/sSPbRiNQT7N4z2QuRULzS+N
         9JZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704661; x=1784309461;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oyNuxj5YKFe6jqwNYqW+5/2BY5HqqmcgSEjuVUqU6Tc=;
        b=Bc3yoUexme6Tef/0guWHfppN+r0MQnx5Cu0uPY9ln0oIEKr9KAxazfhxGAq6KxLGmP
         Aw+6+KRIs+WTDwSIAn/9ygAcOw4sNaeWyOXihHVnTPGrkRaG/vvvQkWpad0Nu5iifJrC
         BhU6XIVbBVzXEpMTry7802ESzIit8tVlBtSsGTuc4EA9n+7s+I234vleGCnW/RVNxSMN
         2Ct7+/S6uKxwuT/rFLfZkM76qwkpVARc8xBAQaMBsM5sJyZDkdWkDDJFmXNmkEm2OJzu
         4/22IpE1ch1YUZ0VhBxawKrLA/cJIixD0dd3nTqDy8B8A4tUm5tjDV5MYwYwg+kgIubX
         rSpA==
X-Gm-Message-State: AOJu0YzSwRrJ9KBiYKJHqEnrH//vDnN6TEHce7jAIywh6/t9EYOlqbSz
	Jnl/i03OX8fb1C6NFr0/wmfbQQJwr+P8ZxKtbYvbVbdzEmANcZSLdVTVOwPXbQ==
X-Gm-Gg: AfdE7cla81vBDCNTJh1azo/u3wn8XQrDUWeKKJA7Qu5tvG5RcSiJuGD9Ax3yHMuok3W
	rWHekwgGyMn7NeqZbzTOQ7auVfjZQFjpSLkNSmnGsSbcrtmBg5NWY6KNpXFmkV/ZF6hY46fuOIm
	3ofwDaOHLOAMlzhiYYq/97vrfjIa6T8gNppaqNmEPA/rtz7I2krkTft/0xZhdIH3/GBTutABRkD
	6+bgX5g398h0JxiBI4r5muNplUrfrVqzQtUj21gDcJKbUefrU3b7ZGSt9gvuD9m2odJDrgLpg6D
	EIW6U5GjAgs/Hrz6uM5PlDbLEEqvJH6TZvlrTl5HZBxw5CNxsazj+vdU7d65u3IEN+97z7RRX2b
	vQ/DbD8HcAj3GCkrTCEgpk5YzOIdipulsDKa0jvtTIWThDZhFeDBVp1jeHRAzm1GaS0VaDdeYzb
	tTSgyzEvHrRVn9EBv8
X-Received: by 2002:ac8:7d87:0:b0:51c:2685:2964 with SMTP id d75a77b69052e-51c8b48e9e2mr134656691cf.43.1783704660405;
        Fri, 10 Jul 2026 10:31:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.127.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1d3acsm45765816d6.24.2026.07.10.10.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:30:59 -0700 (PDT)
Message-Id: <79b56402c0d5d8b709f41b25ca66aed98ebbb007.1783704657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.v2.git.1783704657.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v2.git.1783704657.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 17:30:55 +0000
Subject: [PATCH v2 1/3] t/lib-httpd: fix apply-one-time-script race under
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

Running the one-time script more than once is fine; the only thing to
avoid is serving a second, racing request's modified output. Two
requests can both find the marker and run the script before either
renames it away, but the rename is atomic, so exactly one of them wins:
it serves its modified body and consumes the marker. The loser's rename
fails because the marker is already gone, so it discards the modified
output it produced and serves the unmodified body instead. The rename,
not running the script, is what is serialized.

Add t5567 to lock this down. The overlap depends on timing, so a live
httpd test such as t5616.47 (the real code path) passes almost every
time even against the buggy helper; t5567 instead drives the helper
directly with a fake git-http-backend and forces the overlap with FIFOs.
Against the pre-fix helper it fails with the same shell error seen in
the field:

  ./one-time-script: No such file or directory

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-httpd/apply-one-time-script.sh | 44 +++++++++----
 t/meson.build                        |  1 +
 t/t5567-one-time-script.sh           | 96 ++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 14 deletions(-)
 create mode 100755 t/t5567-one-time-script.sh

diff --git a/t/lib-httpd/apply-one-time-script.sh b/t/lib-httpd/apply-one-time-script.sh
index b1682944e2..adb9cec528 100644
--- a/t/lib-httpd/apply-one-time-script.sh
+++ b/t/lib-httpd/apply-one-time-script.sh
@@ -6,21 +6,37 @@
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
+#
+# The script may run more than once: the marker is consumed when the response
+# actually changes (the rename after "cmp"), not when the script runs, so a
+# request whose response is not the targeted one runs the script, sees no
+# change, and leaves the marker for a later request. That is safe because the
+# scripts are stateless filters over the captured response.
 
-	"$GIT_EXEC_PATH/git-http-backend" >out
-	./one-time-script out >out_modified
+test -f one-time-script || exec "$GIT_EXEC_PATH/git-http-backend"
 
-	if cmp -s out out_modified
-	then
-		cat out
-	else
-		cat out_modified
-		rm one-time-script
-	fi
+LC_ALL=C
+export LC_ALL
+
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

