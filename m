Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1D31AF07
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748589; cv=none; b=ZDkLJa6FAnwtHHi753ncIQATSAE3GkotJp8oksmRF5SQQc2WHmWHuFgFmdAxS5D8+DRTZYsLA+wkdwgz0l5HJvpvblQu45rQzt6Bz4acn8uETcthLUY9RVSIGrTMMQ9I1xsL71aav+GIc7k2r20uD4DsGgoAQn6aPB8oX0S2BBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748589; c=relaxed/simple;
	bh=i0Mxt5Qy/bgzCUAHOCaIJ/4FrSC//ELBDRX7dPrcAJI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IsqcJKNpXJXM2uFCJH3n4BKksxFjZrk5yZq9WvXYWs+4SsylpG87sMkwMuULoPadOUCnfKABU67bJ83FEPMzAGV7tc219j7E7Ai7GMKi8XqrzfgyHGzzmjhyocms5wd9ERkyeMJbShkZMF+WL4F7o2ZdhkWphknKwqb0+MNlGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5BKYpkN; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5BKYpkN"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c2a97ec17so561555eec.3
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790748587; x=1791353387; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zzE3eH+O+l8dCIwSNjBf4zd/qVoICk9loygGXizId2o=;
        b=L5BKYpkNL0gf3OSLvk/AeuT/ZFfHZhPuDlYlxyPx/SEJkBC/WDq3YqxgmPSTDbKa3h
         XNgl3h3qD864CA9VD2KBTZTZKhv8coDGoub64Oaga+y8TwPdDAetIw5BxSvhKDNDFteF
         9o2ZH2ej/bPhpFZBxBoON5LesKiF+sHB8J32+omQUe2DJePAs4h8V8fsRaNhQj/j/LQc
         59KWpS2DkY/HxNgPhFX8DD9xbPVJod5PElvMkrv3443N6PAb+N7eFHnf2ffSkU7YKuH6
         N0NDOGmT+l/q0QRJBPsWReYgJGvkJKYIxO49SoHTIuTGgLHn/x0KeUaiQgA0foq0ItTZ
         KvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790748587; x=1791353387;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zzE3eH+O+l8dCIwSNjBf4zd/qVoICk9loygGXizId2o=;
        b=Rd3SmSPaapOClWtMkZuRSnCEgnSaNKHeVh9ZfIUr8x5n6KwHdz0a8BQY4/MPwqCKKy
         rFHBVgYdOdLxc1x0OMZoOAJgxbFx04oACL784SjsKM8wlrZQhm8YlmKDHVBIXr3zWGGW
         yeYHbevFe7uS0JwuIDutXT8+0fSeahaOqrZIDE8SLPvz/RTdAimqzLjjIoGGdzyi2v7K
         mfA8TPAyBUTdOyeUE+LxzEStx8wmyrTPjEdFt02infMJwIbrun4UcnG/yUCH+w6Ic4OZ
         S9a3VDkuG9z9hiZyLhSwPazM0hEed54GMsr0jdgAnimob1FoU2oSZgJhAbff7ExJbdBz
         eb/g==
X-Gm-Message-State: AFq9FYK1tMHahdn3IKci3q8xb2DpxTLGANmODriEt++3HBPzH9x5/SMG
	5f7SBqlOLHlot8/Fp9mIb6sLJh9nfxRPx7Z2AvSR4/K6Br8u7ySKurTXcl+7XA==
X-Gm-Gg: AYBFou0jbqxWCmZR3FwKTgS6lbFBQN/0MpjoXV0hE1WY4k4jcr6asLkvTLpJXmvBGKi
	espN7EDUoIZBIuB/A5Ksn2fxL836yYZw54JER0lKnLukQfjCnyA6HYizzvBv4QtwsfsEc6RZ+AF
	qDKVv6O+67xRSj2Yt+pfliwqHKphKB9ArUwW8OIq4SBlOu75ahWYox+wXk31H10k4QZrN8kut+Z
	hnA9Yo090bAXFaaMM7WU7bIbGA7I6fgzXiEWssQNWjf0aMrdG+kMZ30eFtCJzqv7rnMIQKiE/ND
	zsjqNv7w9Qy7QE/fNLqUBQah1JVU/5krPgyuJKTqPHqqV/QWi7yjJr/LpjsJ4abnq8J9GRuVg4Q
	adsOOp9VQXzuBaNZu7ZS4SXsWzC7uvX2YgrVDoga/HRlKEex2Odlgk3N6I64KCJqusj3eGk4nLb
	Hgb7wxfj3aIVdEfI2oyNt5EtCcMzOg9I+8tLjvfFiCe+dzjZ1pCV2qGDHBENUkcZV0QXZt1NqK/
	hA=
X-Received: by 2002:a05:7300:c4c1:b0:34b:5ab2:e221 with SMTP id 5a478bee46e88-34cdd0aaba6mr739099eec.33.1790748586637;
        Tue, 29 Sep 2026 23:09:46 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.137.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf4a651desm1740109eec.9.2026.09.29.23.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:09:46 -0700 (PDT)
Message-Id: <b6a36820ae3c50e36d71f751b7ff25b7f3275cea.1790748583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.v3.git.git.1790748583.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v3.git.git.1790748583.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 30 Sep 2026 06:09:42 +0000
Subject: [PATCH v3 1/2] ci: annotate leaks and stop a leak-sanitizer script at
 its first failure
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A leak is only discovered once, at the end of a whole script, well
after every test has already reported ok, and it gets no annotation at
all, so a leak-sanitizer job's only visible failure is:

    Process completed with exit code 1.

Give a leak its own annotation. Point it at the test script, the exact
line isn't known, only which script the leak turned up in, and put the
full sanitizer report in a log group next to it, so it stays visible
and isn't capped to a handful of lines.

Once a script has one leak, it keeps running: the sanitizer log
directory is never cleared between tests, so every later test in the
same script sees the same leftover log entries and also reports "not
ok", burying the one real failure in copies of itself. Stop a
leak-sanitizer script at its first failure with --immediate instead.

A failing test already gets its own annotation once its script
finishes, but --immediate exits as soon as that test fails, before
reaching the code that writes it. Write the annotation first, so
turning on --immediate here does not silently drop it.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 ci/lib.sh                            |  1 +
 t/test-lib-github-workflow-markup.sh | 16 ++++++++++++++++
 t/test-lib.sh                        |  6 +++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index c6ccbf8c17..a89f480a78 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -382,6 +382,7 @@ linux-leaks|linux-reftable-leaks)
 	export NO_CVS_TESTS=LetsSaveSomeTime
 	export NO_SVN_TESTS=LetsSaveSomeTime
 	export NO_P4_TESTS=LetsSaveSomeTime
+	GIT_TEST_OPTS="$GIT_TEST_OPTS --immediate"
 	;;
 linux-asan-ubsan)
 	export SANITIZE=address,undefined
diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index fa29a62aa3..0d54496358 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -28,6 +28,11 @@ start_test_output () {
 	github_markup_output="${GIT_TEST_TEE_OUTPUT_FILE%.out}.markup"
 	>$github_markup_output
 	GIT_TEST_TEE_OFFSET=0
+	github_markup_script_name=${0##*/}
+}
+
+github_annotation_ () {
+	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
 }
 
 # No need to override start_test_case_output
@@ -53,4 +58,15 @@ finalize_test_case_output () {
 	echo >>$github_markup_output "::endgroup::"
 }
 
+finalize_test_leak_output () {
+	# The exact line the leak turned up on isn't known, only the script,
+	# so point at line 1.
+	github_annotation_ error "t/$github_markup_script_name" 1 \
+		"memory leak logged in $this_test"
+
+	echo >>$github_markup_output "::group::leak: $this_test.$test_count"
+	cat "$TEST_RESULTS_SAN_FILE".* >>$github_markup_output
+	echo >>$github_markup_output "::endgroup::"
+}
+
 # No need to override finalize_test_output
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1f0505e412..e74a12f1dd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -199,6 +199,7 @@ mark_option_requires_arg () {
 start_test_output () { :; }
 start_test_case_output () { :; }
 finalize_test_case_output () { :; }
+finalize_test_leak_output () { :; }
 finalize_test_output () { :; }
 
 parse_option () {
@@ -822,6 +823,9 @@ test_failure_ () {
 	say_color error "not ok $test_count - ${pfx:+$pfx }$1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
+	# Write the annotation before either --immediate exit path below,
+	# both of which call exit and would otherwise skip it.
+	finalize_test_case_output failure "$failure_label" "$@"
 	if test -n "$immediate"
 	then
 		say_color error "1..$test_count"
@@ -835,7 +839,6 @@ test_failure_ () {
 		check_test_results_san_file_ "$test_failure"
 		_error_exit
 	fi
-	finalize_test_case_output failure "$failure_label" "$@"
 }
 
 test_known_broken_ok_ () {
@@ -1218,6 +1221,7 @@ check_test_results_san_file_ () {
 		return
 	fi &&
 	say_color >&4 error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
+	finalize_test_leak_output &&
 
 	if test "$test_failure" = 0
 	then
-- 
gitgitgadget

