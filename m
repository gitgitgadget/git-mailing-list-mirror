Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E9928B4FD
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012514; cv=none; b=pi/6kLILuqVPzPpC+KwwqJox+hJvL4kzD5Fy6YMp9JnOZ85+PgQELDTsFi3JMPSXiTuMWHg9o8z2xxsRG9KVRRN+pt+FjSNmTEMpYllHy8upTaGtBuG5hjLPwLw8xsYBYMmWgTtS7AOYeOmis/8fJYp9EztjGDxEtCLJGEOephU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012514; c=relaxed/simple;
	bh=ttXBu8PI2/zXpuFfzHWq6M/Lzra+Pu+XqevWCDTjFCY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=antoW1UiuJKvWXsTNp6VMc1Qa0bc4tpJI99tq4E2OVtoEnAzTW/DXkpNWSuBL+98V3ISBATgPhwup2LtdieNi8u+/WC8OMT1CKDy0RvMQnK0foSZp/BdQRCWDISZ6HzgTH/337frHlmzTcR12qGTQGOi4gvGBUoZy9QwQzRcF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nImUKiQi; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nImUKiQi"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c7199e7f79so173023485a.0
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 11:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771012512; x=1771617312; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJhUeDXSF3BE4VfyvSfM9gPM2Lwx6wxy/Ir5illbZW0=;
        b=nImUKiQihbUQ5k4xq+TvPqjg7vU10oaq3jOhmnFWGt3bilkX2jbFEzG7SI2lmWyoLw
         MV7k2QjyMd0LMDHJcCJno4KoxuiBTVx7DkQupqOCUqsg4c2Y6JsVjN/kHTrRGOJQ7ZAz
         MHrZRbVZYRk8yb9J5EQabOV83h/q09xlKZ7g0KHmzJfzsqTbbTOtC8N05BaxfPKggdN2
         GKVxTdhOjgtVnnxghGuwzRZ9E2S8MNSOQzWwgmYU/buxMCL95iAEjs1EfoetXuYfqhvB
         gpfTrRFHzbIq3JAB+J/BVBRukW9ys5KKQT8ukAg7tPYbhdpahG39Txa/WGlDwtGTVQyL
         j+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771012512; x=1771617312;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fJhUeDXSF3BE4VfyvSfM9gPM2Lwx6wxy/Ir5illbZW0=;
        b=gEQQgIZPL1tjxwA6KhlZ/Gt08spDNLB9djnsDWZwu5k75yTrd95db/y8NhDZQn9x7G
         2XEaz1ORtpKJpDdl8RIEAb5iAmD2O/DMDDkk+ruTs/y7VEALcjqf4H4N9c0ciiX+5a1E
         Y9sShX/00qf5nWlJ3AgWHMeMKbocVUNAgWwScvsRnsqUnwK2LtBVDJVhjbYbTVZFq8x3
         ZrGn4IIRq+s7GCooRE7qeY551oYPtBT/6PN11W01FTXLiezRer0tuWNshfTZaloxj4dH
         4ukUUXdiguthQPpkrLHXujq+HrFgs9+aINFT41DzWtr0ElBGmNvPeNeDMMs9u02IlTxd
         aX4g==
X-Gm-Message-State: AOJu0Ywu0pHdVccHTs7ThX6NjLSNJBtY4qkDjoSY2RfG2wif6uiJTfXR
	eOSZM1fn4uKXozDb7OM8xYrQ39MJeJ5JXw1nSBCYWAM1hedCIB6FFbq0zYqxBA==
X-Gm-Gg: AZuq6aIgwfQ38DLDzhqslKBABzuzmy91nXA1KWkATcGZ9v+o2sY85/dBi8A+hwVZshJ
	lJYwg8aD5gsB9y+yiNWyNSvmlXPXwyFNSinnGN2FUcmW10o6DNmIsxrmVn1IgWiwgMuHqfLug44
	j0tPeRK5Uf0Dh8JG/qzpv0Iz0D7PcKKqIYJEmXh0n+4xQg3SxErLjQGmWArYV3kRwvOe1SaksTW
	gAC6IYn4GssklXYvnwRdSUk/akKkNjQljCALsH/vrzr9fBnHEmLnemzjdtMyHrWmgaJnMJt1SKK
	UMdQ16T9o11nobLdG1SRxF6tYswMHmCWzIeUwRN7kAV0lZSA0b/xMMuQtcVy+71g2KDYV6nWec2
	P8UcQyUWTLk08hW5jSJmOV1oGCpqpS0KeLnpadiDm0Uhyros3ToQffWCDocT8aoRXGnUaTKkI+y
	h5PyAcsWwT42AxP6IgwyaYBtXw
X-Received: by 2002:a05:620a:28cb:b0:89f:7109:185f with SMTP id af79cd13be357-8cb4bf97d9cmr95991785a.31.1771012511756;
        Fri, 13 Feb 2026 11:55:11 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.10])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb48c27330sm156104085a.19.2026.02.13.11.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:55:11 -0800 (PST)
Message-Id: <6a5232540ed8f7138b03cf3df9b7009f54188d97.1771012500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
	<pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 19:55:00 +0000
Subject: [PATCH v2 6/6] t0213: add trace2 cmd_ancestry tests
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
Cc: gitster@pobox.com,
    stolee@gmail.com,
    johannes.schindelin@gmx.de,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

From: Matthew John Cheetham <mjcheetham@outlook.com>

Add a new test script t0213-trace2-ancestry.sh that verifies
cmd_ancestry events across all three trace2 output formats (normal,
perf, and event).

The tests use the "400ancestry" test helper to spawn child processes
with controlled trace2 environments. Git alias resolution (which
spawns a child git process) creates a predictable multi-level process
tree. Filter functions extract cmd_ancestry events from each format,
truncating the ancestor list at the outermost "test-tool" so that only
the controlled portion of the tree is verified, regardless of the test
runner environment.

A runtime prerequisite (TRACE2_ANCESTRY) is used to detect whether the
platform has a real procinfo implementation; platforms with only the
stub are skipped.

We must pay attention to an extra ancestor on Windows (MINGW) when
running without the bin-wrappers (such as we do in CI). In this
situation we see an extra "sh.exe" ancestor after "test-tool.exe".

Also update the comment in t0210-trace2-normal.sh to reflect that
ancestry testing now has its own dedicated test script.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 t/meson.build              |   1 +
 t/t0210-trace2-normal.sh   |   5 +-
 t/t0213-trace2-ancestry.sh | 180 +++++++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+), 2 deletions(-)
 create mode 100755 t/t0213-trace2-ancestry.sh

diff --git a/t/meson.build b/t/meson.build
index a5531df415..551c3036c0 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -131,6 +131,7 @@ integration_tests = [
   't0210-trace2-normal.sh',
   't0211-trace2-perf.sh',
   't0212-trace2-event.sh',
+  't0213-trace2-ancestry.sh',
   't0300-credentials.sh',
   't0301-credential-cache.sh',
   't0302-credential-store.sh',
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 96c68f65df..7e1e7af862 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -74,8 +74,9 @@ scrub_normal () {
 	#      This line is only emitted when RUNTIME_PREFIX is defined,
 	#      so just omit it for testing purposes.
 	#
-	#   4. 'cmd_ancestry' is not implemented everywhere, so for portability's
-	#      sake, skip it when parsing normal.
+	#   4. 'cmd_ancestry' output depends on how the test is run and
+	#      is not relevant to the features we are testing here.
+	#      Ancestry tests are covered in t0213-trace2-ancestry.sh instead.
 	sed \
 		-e 's/elapsed:[0-9]*\.[0-9][0-9]*\([eE][-+]\{0,1\}[0-9][0-9]*\)\{0,1\}/elapsed:_TIME_/g' \
 		-e "s/^start '[^']*' \(.*\)/start _EXE_ \1/" \
diff --git a/t/t0213-trace2-ancestry.sh b/t/t0213-trace2-ancestry.sh
new file mode 100755
index 0000000000..a2b9536da8
--- /dev/null
+++ b/t/t0213-trace2-ancestry.sh
@@ -0,0 +1,180 @@
+#!/bin/sh
+
+test_description='test trace2 cmd_ancestry event'
+
+. ./test-lib.sh
+
+# Turn off any inherited trace2 settings for this test.
+sane_unset GIT_TRACE2 GIT_TRACE2_PERF GIT_TRACE2_EVENT
+sane_unset GIT_TRACE2_BRIEF
+sane_unset GIT_TRACE2_CONFIG_PARAMS
+
+# Add t/helper directory to PATH so that we can use a relative
+# path to run nested instances of test-tool.exe (see 004child).
+# This helps with HEREDOC comparisons later.
+TTDIR="$GIT_BUILD_DIR/t/helper/" && export TTDIR
+PATH="$TTDIR:$PATH" && export PATH
+
+# The 400ancestry helper spawns a child process so that the child
+# sees "test-tool" in its process ancestry.  We capture only the
+# child's trace2 output to a file.
+#
+# The tests use git commands that spawn child git processes (e.g.,
+# alias resolution) to create a controlled multi-level process tree.
+# Because cmd_ancestry walks the real process tree, processes will
+# also report ancestors above "test-tool" that depend on the test
+# runner environment (e.g., bash, make, tmux).  The filter functions
+# below truncate the ancestry at "test-tool", discarding anything
+# above it, so only the controlled portion is verified.
+#
+# On platforms without a real procinfo implementation (the stub),
+# no cmd_ancestry event is emitted.  We detect this at runtime and
+# skip the format-specific tests accordingly.
+
+# Determine if cmd_ancestry is supported on this platform.
+test_expect_success 'detect cmd_ancestry support' '
+	test_when_finished "rm -f trace.detect" &&
+	GIT_TRACE2_BRIEF=1 GIT_TRACE2="$(pwd)/trace.detect" \
+		test-tool trace2 001return 0 &&
+	if grep -q "^cmd_ancestry" trace.detect
+	then
+		test_set_prereq TRACE2_ANCESTRY
+	fi
+'
+
+# Filter functions for each trace2 target format.
+#
+# Each extracts cmd_ancestry events, strips format-specific syntax,
+# and truncates the ancestor list at the outermost "test-tool"
+# (or "test-tool.exe" on Windows), discarding any higher-level
+# (uncontrolled) ancestors.
+#
+# Output is a space-separated list of ancestor names, one line per
+# cmd_ancestry event, with the immediate parent listed first:
+#
+#   test-tool                          (or: test-tool.exe)
+#   git test-tool                      (or: git.exe test-tool.exe)
+#   git test-tool test-tool            (or: git.exe test-tool.exe test-tool.exe)
+
+if test_have_prereq MINGW
+then
+	TT=test-tool$X
+else
+	TT=test-tool
+fi
+
+filter_ancestry_normal () {
+	sed -n '/^cmd_ancestry/{
+		s/^cmd_ancestry //
+		s/ <- / /g
+		s/\(.*'"$TT"'\) .*/\1/
+		p
+	}'
+}
+
+filter_ancestry_perf () {
+	sed -n '/cmd_ancestry/{
+		s/.*ancestry:\[//
+		s/\]//
+		s/\(.*'"$TT"'\) .*/\1/
+		p
+	}'
+}
+
+filter_ancestry_event () {
+	sed -n '/"cmd_ancestry"/{
+		s/.*"ancestry":\[//
+		s/\].*//
+		s/"//g
+		s/,/ /g
+		s/\(.*'"$TT"'\) .*/\1/
+		p
+	}'
+}
+
+# On Windows (MINGW) when running with the bin-wrappers, we also see "sh.exe" in
+# the ancestry. We must therefore account for this expected ancestry element in
+# the expected output of the tests.
+if test_have_prereq MINGW && test -z "$no_bin_wrappers"; then
+	SH_TT="sh$X $TT"
+else
+	SH_TT="$TT"
+fi
+
+# Git alias resolution spawns the target command as a child process.
+# Using "git -c alias.xyz=version xyz" creates a two-level chain:
+#
+#   test-tool (400ancestry)
+#     -> git (resolves alias xyz -> version)
+#          -> git (version)
+#
+# Both git processes are instrumented and emit cmd_ancestry.  After
+# filtering out ancestors above test-tool, we get:
+#
+#   test-tool                 (from git alias resolver)
+#   git test-tool             (from git version)
+
+test_expect_success TRACE2_ANCESTRY 'normal: git alias chain, 2 levels' '
+	test_when_finished "rm -f trace.normal actual expect" &&
+	test-tool trace2 400ancestry normal "$(pwd)/trace.normal" \
+		git -c alias.xyz=version xyz &&
+	filter_ancestry_normal <trace.normal >actual &&
+	cat >expect <<-EOF &&
+	$SH_TT
+	git$X $SH_TT
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success TRACE2_ANCESTRY 'perf: git alias chain, 2 levels' '
+	test_when_finished "rm -f trace.perf actual expect" &&
+	test-tool trace2 400ancestry perf "$(pwd)/trace.perf" \
+		git -c alias.xyz=version xyz &&
+	filter_ancestry_perf <trace.perf >actual &&
+	cat >expect <<-EOF &&
+	$SH_TT
+	git$X $SH_TT
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success TRACE2_ANCESTRY 'event: git alias chain, 2 levels' '
+	test_when_finished "rm -f trace.event actual expect" &&
+	test-tool trace2 400ancestry event "$(pwd)/trace.event" \
+		git -c alias.xyz=version xyz &&
+	filter_ancestry_event <trace.event >actual &&
+	cat >expect <<-EOF &&
+	$SH_TT
+	git$X $SH_TT
+	EOF
+	test_cmp expect actual
+'
+
+# Use 004child to add a test-tool layer, creating a three-level chain:
+#
+#   test-tool (400ancestry)
+#     -> test-tool (004child)
+#          -> git (resolves alias xyz -> version)
+#               -> git (version)
+#
+# Three instrumented processes emit cmd_ancestry.  After filtering:
+#
+#   test-tool                  (from test-tool 004child)
+#   test-tool test-tool        (from git alias resolver)
+#   git test-tool test-tool    (from git version)
+
+test_expect_success TRACE2_ANCESTRY 'normal: deeper chain, 3 levels' '
+	test_when_finished "rm -f trace.normal actual expect" &&
+	test-tool trace2 400ancestry normal "$(pwd)/trace.normal" \
+		test-tool trace2 004child \
+			git -c alias.xyz=version xyz &&
+	filter_ancestry_normal <trace.normal >actual &&
+	cat >expect <<-EOF &&
+	$TT
+	$SH_TT $TT
+	git$X $SH_TT $TT
+	EOF
+	test_cmp expect actual
+'
+
+test_done
-- 
gitgitgadget
