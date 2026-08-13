Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E983C3128DF
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786583143; cv=none; b=LhLM4Np4Os88GLEODtBifVjEVrmbRW78h1cAKhzluGXKCeoFFLpsc60VO0M7lhj9Z32EHlziv4e/sijvou76yNzAUym5F6HhzucnqGZXvYItqEICOR39Q9TJlPjshvQL6qz8eYEvvvZs4FYb87vkQmPECc2AkBnMLXtUQ/LvOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786583143; c=relaxed/simple;
	bh=TeYggfWbLj9A1mEIhqekznRQ4NZXkgM1yLXIv7XZmHY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VsYntT81Q2iDvfv8h+km20BSTZ0u49meiURssbaBsWH9KapTV4F9ZPaYj/BLg+GLlBqLg+ZII+TLtWootLZl4ahdv5cI14D2bJ1hD9uxEOMRd69SCdW3mGe370OPr7WSplK8FoAF/qFyn+NvMxuuJQsBRcEvB7sDT2oh+9TD9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s0rg0UuP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0rg0UuP"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e54f8c051so75904385a.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 18:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786583141; x=1787187941; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qv1AN58NwNwy7GQWoSkPyx+PhRxEgZTFGQz1fHPrqng=;
        b=s0rg0UuPQjim0KDNJqZYxJMzNkmIehIDREFHKhRoB5Gm4/0LvLctsms5+MsuqcIgVe
         dMoJ/w+2dVPPyhV0Fn3X4yG9NV8EHJy9uLN/J9rIZJKuaTBnObCQ+SZZcXGILY4LAKcJ
         mtuydARPt0H6xxOhCdz6hpq2iLYqk9lZNIfhNFKbRVPSWEFlWJgxOCuqPBP+BjWyLots
         Y0kRP4nhIeBUoOnZcp/gFQJLrcCUJB7vy5dOqWzK3e8+MWR/ppQ+f47Iythjt86hhIhv
         adGAGJb5dEdoy8CWSTy/xkLXkBbmBYT1VqrZQD1HZYpkQtaxY/tjhq0FFvPzDW01I/Lr
         fKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786583141; x=1787187941;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qv1AN58NwNwy7GQWoSkPyx+PhRxEgZTFGQz1fHPrqng=;
        b=tEiz6WmGOZc9bQSWPBscEwWPBBlWjcSyNCjpRczc+ZnMObdZTUZyWer8SepgkFPvZg
         LBR+lD6jCQKORy93xTSM5RD47dx7u3ectlPwK2ow9lwBjJxSUEhtc1I99UnYSjAVbklF
         F+VnfLK/d403qMGjRjfipwA33TuJdUADHfAbn9KdbOIaKgjoORcIZUmP9YHGiMQTbnnT
         O5dMv9XvZ5unfJUcZIR4Yf/Mr6s3uYpKq1GdFblb2y879rTkKlTrD0bffe0Ogi5VHsL3
         3EU4CZPJx3D3FU9TjOUfdsms88fdJBbeDUKOj8jSwrOTjQNkuhOX/QShuWiwaS9P/qyZ
         sArw==
X-Gm-Message-State: AOJu0YxCeW2uaHR1p4FbwBObEMG94Rg4DG7VlHYuHOR8yjwu7LO3rIbX
	c66BcrR1w9cvfGpfUqLa8JsHpoAj6jOZ7n7YHjzBpuiHdvCSEvVwZk9ncagd1A==
X-Gm-Gg: AR+sD126a+gh1N5EA6bVBdwwTs2Vd6TJ9xiZietP2bFBaOxZJT3bm+EeqA4KYY4rJDX
	fQGXRAmaSKHvJ2w8dMvZJIYFFEluQPWio+PKegKymHwR+j98KWVcq9ViGtkq6xh3Sg+2kJSB4Ls
	C8F/x392w3u8VMbpII92mzTEFkIstsFlvKkmKPBrhizwTaBtB7tILGrkr5rBve1DNMdEb50zlXy
	cdczuT/J/QanVWRS/6U5f7Cl58McP3ypWxQDBIba7tbtzm1LdNCTAn1kfiSs7nNwlC7/Yzorvxd
	5F2zMa7IPGNr46FzFPbCKAJxuYCD7+jEfm+W0jbmJHsqivVOUyESvYla0Suf59JBygSd70oR2T8
	k/h9w85Bh6kFOtQSNBeJ8wSqXYLp1n2WJrue4PLK9+TS76OQmlGzb8AAKCFB4Kpad5CJJ2BulKY
	yVqLS32JI5qbUy6af3y+o71mxjo9cPMxICorgmogMUmTk2KthCZlACv8dL0dVm1Z0=
X-Received: by 2002:a05:620a:690c:b0:914:bd3f:b6db with SMTP id af79cd13be357-936bf8e897amr230295385a.10.1786583140484;
        Wed, 12 Aug 2026 18:05:40 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.53.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c1b667e9sm33435885a.38.2026.08.12.18.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 18:05:39 -0700 (PDT)
Message-Id: <862c4258e596e411063808a9a68d0bf4db454ebf.1786583137.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.v3.git.1786583137.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v3.git.1786583137.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 01:05:34 +0000
Subject: [PATCH v3 1/3] t/lib-httpd: fix apply-one-time-script race under
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

apply-one-time-script.sh is a CGI helper that, when the file
"one-time-script" is present, runs it to rewrite the git-http-backend
response. If "one-time-script" generates a response that differs from
git-http-backend, the modified response is returned and
"one-time-script" is deleted. Requests after the deletion return normal
git-http-backend responses.

The deletion is not safe under concurrency. The helper serves the
modified body first and deletes "one-time-script" only afterward, so a
client can issue its next request while the file still exists. Apache
runs the CGI for both requests at once, for example when a partial fetch
lazily fetches a missing promisor base while the first response is still
in flight. Both requests find the file and try to run it; the first
deletes it; the second then fails to exec the now-missing file, produces
no output, and the server returns HTTP 500:

  fatal: ... The requested URL returned error: 500
  fatal: could not fetch <oid> from promisor remote

This is the flaky failure of t5616.47 on the macOS CI runners.

Fix it by removing the file with "rm" only after the script has actually
changed the response. Because "rm" without "-f" fails once the file is
gone, exactly one request removes it and serves the modified body. Any
other request serves the unmodified body. Running the script more than
once is harmless; only its deletion is serialized, so exactly one
request's modified response is ever served. Per-request scratch file
names keep concurrent runs from overwriting each other, and no path
emits an empty response body.

t5616.47 exercises the real code path but, being timing-dependent,
passes against the buggy helper almost every time. Add t5567, which
drives the helper directly with a fake git-http-backend and forces the
overlap with FIFOs; against the pre-fix helper it fails with the same
shell error seen in the field:

  ./one-time-script: No such file or directory

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-httpd/apply-one-time-script.sh | 50 +++++++++++----
 t/meson.build                        |  1 +
 t/t5567-one-time-script.sh           | 96 ++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 14 deletions(-)
 create mode 100755 t/t5567-one-time-script.sh

diff --git a/t/lib-httpd/apply-one-time-script.sh b/t/lib-httpd/apply-one-time-script.sh
index b1682944e2..8ab97e882a 100644
--- a/t/lib-httpd/apply-one-time-script.sh
+++ b/t/lib-httpd/apply-one-time-script.sh
@@ -6,21 +6,43 @@
 #
 # This can be used to simulate the effects of the repository changing in
 # between HTTP request-response pairs.
-if test -f one-time-script
-then
-	LC_ALL=C
-	export LC_ALL
+#
+# Apache can run this CGI for several requests at the same time. For example, a
+# partial fetch lazily fetches a missing object while the first response is
+# still in flight. To stay correct, the helper removes the marker only after
+# the response changes, and only with "rm" (without "-f"). The "rm" fails for
+# every request except the one that removes the marker first. That request
+# serves the modified body. Every other request serves its response unchanged.
+# No request emits an empty body, which Apache would report as HTTP 500.
+#
+# A scratch file name includes the process ID ($$), so concurrent requests do
+# not overwrite each other's files.
+#
+# The helper can run one-time-script more than once. It consumes the marker
+# when the response changes (the "rm" after "cmp"), not when it runs the
+# script. A request whose response is not the target runs the script, finds no
+# change, and leaves the marker for a later request. This is safe because the
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
+# one-time-script can be gone here: a concurrent request may have consumed it
+# since the "test -f" above. Then "./one-time-script" fails, the exit status
+# selects the unmodified body, and "2>/dev/null" discards the expected
+# "no such file" message.
+if ./one-time-script "$out" 2>/dev/null >"$modified" &&
+   ! cmp -s "$out" "$modified" &&
+   rm one-time-script 2>/dev/null
+then
+	cat "$modified"
 else
-	"$GIT_EXEC_PATH/git-http-backend"
+	cat "$out"
 fi
+rm -f "$out" "$modified"
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

