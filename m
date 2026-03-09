Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5093C6A43
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063546; cv=pass; b=QqSViMxYGlu2F9hQV3WQZY7Ybrf1oHLZBlFrCEcHfVTRy+CNsh9E5nFCGM3qUWp1I7fIR8mnkvk2O04DuBSACHgl0m5/FnqlzUhy+trA/yKH10KqwMvicQW8PVxUlwQ6qXy4sROVNuX9fOFXjJi+4tydxFv+FGZyegjU0uqEJ7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063546; c=relaxed/simple;
	bh=oIRJi597x6HrhhqDo8MEIxsQyU3dkVSV1CfhDRB/Bn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDtzT1RG1tUqWSl78VNn5mtiDNHB8uJ6Rh1Sv+nyQPlq+SRmUmCUiqArcOW08iqub8jkLLYqCi5H5IeOsUO554y5vduUhLexJd5lwGiORD50K988Efx7H60UjFpH1B6Mx3tVY1PGLmEaD6NfGhNOLmOws8Mcw5qzDuP63cYnP58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Z8cZTCUc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Z8cZTCUc"
ARC-Seal: i=1; a=rsa-sha256; t=1773063525; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m5gsRudDtOYz9OdreyERuqLtchWqHAq5po5D76Yi6Kw2dYEGTN3+iYgALPybzN5sILxeRMYmsYpP+jR0eyauxfwc3GGepLlaesFQw51UCER3zFEaWi46FlBHJQtEeDvuwNg5G9tnEZ1SHeONZJQan4jck/gOgX5kbUNtYxvu6uc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773063525; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NQ5XKLbaJ5ysVjz13G76O27mf3lhWXe1yRioixpfZHs=; 
	b=ksLIRPs3T0ZKXXEO+4TeHtHwJ0RgqhALYuJcMMjU75Fk2U9I2o6eSwNZHpV+W/fotGL+JajeGqp8DfN6oWSe4BRl0FFdcgOHmzhu9CwJyFBizbPl9mzBhRQkw2Z+sSuxr+gftpp4U5z+Ay4GDZ1cnr+yKLCDkh7a3R1KX3ReVy0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773063525;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NQ5XKLbaJ5ysVjz13G76O27mf3lhWXe1yRioixpfZHs=;
	b=Z8cZTCUcs9U6hT9K2+mBWaXBKkQPLCMNGMT91qRHRgDz33JDYLzC2hj7nS44dMBN
	Vzv2n7Ok71mVYYu5xATUplpIby36tVj+p0d39WeIlfDK2dJ2S6lL2c6DaWEUs0LZ5/U
	CwEPZLTXqgPhDuHCok2CWMdQg8gfEjMxHQnL8tJ4=
Received: by mx.zohomail.com with SMTPS id 1773063523707325.5556023411011;
	Mon, 9 Mar 2026 06:38:43 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 6/9] hook: add -j/--jobs option to git hook run
Date: Mon,  9 Mar 2026 15:37:36 +0200
Message-ID: <20260309133739.294555-7-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260309133739.294555-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

Expose the parallel job count as a command-line flag so callers can
request parallelism without relying only on the hook.jobs config.

Add tests covering serial/parallel execution and TTY behaviour under
-j1 vs -jN.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/git-hook.adoc |  18 +++++-
 builtin/hook.c              |   5 +-
 hook.c                      |  14 ++--
 t/t1800-hook.sh             | 123 ++++++++++++++++++++++++++++++++++--
 4 files changed, 144 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index 4d4e728327..17105cc729 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -8,7 +8,8 @@ git-hook - Run git hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
+'git hook' run [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]
+	<hook-name> [-- <hook-args>]
 'git hook' list [-z] [--show-scope] <hook-name>
 
 DESCRIPTION
@@ -139,6 +140,18 @@ OPTIONS
 	in parentheses after the friendly name of each configured hook, to show
 	where it was defined. Traditional hooks from the hookdir are unaffected.
 
+-j::
+--jobs::
+	Only valid for `run`.
++
+Specify how many hooks to run simultaneously. If this flag is not specified,
+the value of the `hook.jobs` config is used, see linkgit:git-config[1]. If
+neither is specified, defaults to 1 (serial execution). Some hooks always run
+sequentially regardless of this flag or the `hook.jobs` config, because git
+knows they cannot safely run in parallel: `applypatch-msg`, `pre-commit`,
+`prepare-commit-msg`, `commit-msg`, `post-commit`, `post-checkout`, and
+`push-to-checkout`.
+
 WRAPPERS
 --------
 
@@ -161,7 +174,8 @@ running:
 git hook run mywrapper-start-tests \
   # providing something to stdin
   --stdin some-tempfile-123 \
-  # execute hooks in serial
+  # execute multiple hooks in parallel
+  --jobs 3 \
   # plus some arguments of your own...
   -- \
   --testname bar \
diff --git a/builtin/hook.c b/builtin/hook.c
index ff446948fa..6ec0319cc5 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -7,7 +7,8 @@
 #include "parse-options.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
-	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
+	N_("git hook run [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]\n" \
+	   "<hook-name> [-- <hook-args>]")
 #define BUILTIN_HOOK_LIST_USAGE \
 	N_("git hook list [-z] [--show-scope] <hook-name>")
 
@@ -109,6 +110,8 @@ static int run(int argc, const char **argv, const char *prefix,
 			 N_("silently ignore missing requested <hook-name>")),
 		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
 			   N_("file to read into hooks' stdin")),
+		OPT_UNSIGNED('j', "jobs", &opt.jobs,
+			    N_("run up to <n> hooks simultaneously")),
 		OPT_END(),
 	};
 	int ret;
diff --git a/hook.c b/hook.c
index 815b299bf8..299cbf9e97 100644
--- a/hook.c
+++ b/hook.c
@@ -567,15 +567,17 @@ static unsigned int get_hook_jobs(struct repository *r,
 	if (!options->stdout_to_stderr)
 		return 1;
 
-	/* An explicit job count (FORCE_SERIAL jobs=1, or -j from CLI). */
-	if (options->jobs)
-		return options->jobs;
+	/* Pinned serial: FORCE_SERIAL (internal) or explicit -j1 from CLI. */
+	if (options->jobs == 1)
+		return 1;
 
 	/*
-	 * Use hook.jobs from the already-parsed config cache (in-repo), or
-	 * fall back to a direct config lookup (out-of-repo).  Default to 1.
+	 * Resolve effective job count: -jN (when given) overrides config.
+	 * Default to 1 when both config an -jN are missing.
 	 */
-	if (r && r->gitdir && r->hook_config_cache)
+	if (options->jobs > 1)
+		jobs = options->jobs;
+	else if (r && r->gitdir && r->hook_config_cache)
 		/* Use the already-parsed cache (in-repo) */
 		jobs = r->hook_config_cache->jobs ? r->hook_config_cache->jobs : 1;
 	else
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index dad7583f3a..fbe8be25c8 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -238,10 +238,20 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 '
 
 test_hook_tty () {
-	cat >expect <<-\EOF
-	STDOUT TTY
-	STDERR TTY
-	EOF
+	expect_tty=$1
+	shift
+
+	if test "$expect_tty" != "no_tty"; then
+		cat >expect <<-\EOF
+		STDOUT TTY
+		STDERR TTY
+		EOF
+	else
+		cat >expect <<-\EOF
+		STDOUT NO TTY
+		STDERR NO TTY
+		EOF
+	fi
 
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -259,12 +269,21 @@ test_hook_tty () {
 	test_cmp expect repo/actual
 }
 
-test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY' '
-	test_hook_tty hook run pre-commit
+test_expect_success TTY 'git hook run -j1: stdout and stderr are connected to a TTY' '
+	# hooks running sequentially (-j1) are always connected to the tty for
+	# optimum real-time performance.
+	test_hook_tty tty hook run -j1 pre-commit
+'
+
+test_expect_success TTY 'git hook run -jN: stdout and stderr are not connected to a TTY' '
+	# Hooks are not connected to the tty when run in parallel, instead they
+	# output to a pipe through which run-command collects and de-interlaces
+	# their outputs, which then gets passed either to the tty or a sideband.
+	test_hook_tty no_tty hook run -j2 pre-commit
 '
 
 test_expect_success TTY 'git commit: stdout and stderr are connected to a TTY' '
-	test_hook_tty commit -m"B.new"
+	test_hook_tty tty commit -m"B.new"
 '
 
 test_expect_success 'git hook list orders by config order' '
@@ -677,6 +696,96 @@ test_expect_success 'server push-to-checkout hook expects stdout redirected to s
 	check_stdout_merged_to_stderr push-to-checkout
 '
 
+test_expect_success 'parallel hook output is not interleaved' '
+	test_when_finished "rm -rf .git/hooks" &&
+
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo "Hook 1 Start"
+	sleep 1
+	echo "Hook 1 End"
+	EOF
+
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+		    "echo \"Hook 2 Start\"; sleep 2; echo \"Hook 2 End\"" &&
+	test_config hook.hook-2.parallel true &&
+	test_config hook.hook-3.event test-hook &&
+	test_config hook.hook-3.command \
+		    "echo \"Hook 3 Start\"; sleep 3; echo \"Hook 3 End\"" &&
+	test_config hook.hook-3.parallel true &&
+
+	git hook run -j3 test-hook >out 2>err.parallel &&
+
+	# Verify Hook 1 output is grouped
+	sed -n "/Hook 1 Start/,/Hook 1 End/p" err.parallel >hook1_out &&
+	test_line_count = 2 hook1_out &&
+
+	# Verify Hook 2 output is grouped
+	sed -n "/Hook 2 Start/,/Hook 2 End/p" err.parallel >hook2_out &&
+	test_line_count = 2 hook2_out &&
+
+	# Verify Hook 3 output is grouped
+	sed -n "/Hook 3 Start/,/Hook 3 End/p" err.parallel >hook3_out &&
+	test_line_count = 2 hook3_out
+'
+
+test_expect_success 'git hook run -j1 runs hooks in series' '
+	test_when_finished "rm -rf .git/hooks" &&
+
+	test_config hook.series-1.event "test-hook" &&
+	test_config hook.series-1.command "echo 1" --add &&
+	test_config hook.series-2.event "test-hook" &&
+	test_config hook.series-2.command "echo 2" --add &&
+
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo 3
+	EOF
+
+	cat >expected <<-\EOF &&
+	1
+	2
+	3
+	EOF
+
+	git hook run -j1 test-hook 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook run -j2 runs hooks in parallel' '
+	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
+	test_when_finished "rm -rf .git/hooks" &&
+
+	mkdir -p .git/hooks &&
+	write_sentinel_hook .git/hooks/test-hook &&
+
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+	test_config hook.hook-2.parallel true &&
+
+	git hook run -j2 test-hook >out 2>err &&
+	echo parallel >expect &&
+	test_cmp expect hook.order
+'
+
+test_expect_success 'git hook run -j2 is blocked by parallel=false' '
+	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command \
+	    "touch sentinel.started; sleep 2; touch sentinel.done" &&
+	# hook-1 intentionally has no parallel=true
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+	# hook-2 also has no parallel=true
+
+	# -j2 must not override parallel=false on configured hooks.
+	git hook run -j2 test-hook >out 2>err &&
+	echo serial >expect &&
+	test_cmp expect hook.order
+'
+
 test_expect_success 'hook.jobs=1 config runs hooks in series' '
 	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
 
-- 
2.52.0.732.gb351b5166d.dirty

