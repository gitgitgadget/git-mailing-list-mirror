Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF06BFCE
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720210; cv=pass; b=hER9fBYfStRAev/vcKKX49GNrJsdmtF+sRG+9yuKY1+B7uovVk7m2TpfnkbWBxod78wDYvcjrBFYYqQ8tpvhzVNSgudipGEZJCq56Yi9CnmE+SPogjzXySCw+tjnhqkhi1wax90Axp296yHr6YUFj2wG0P4hf7wmnD1NYhyBe60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720210; c=relaxed/simple;
	bh=OZpFabY0n7iDcV6nD1YCr4G95bXnGhMpfoNASVIZsQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyJv8zeoMdpsVXBlh3IdjHBCyKw1BkUnFx9AxV5bvtVNFWcM/SS6Eh9KLyh0VWKvyhRIrjU0bK/oIJPCIwdQZQHpFN4Rfv/KVgesYOmenfz9GwNzQiapHq3Lswv2Vu9Q9q1bZa6iwUgHstaUtimmEnF/1DUhhy4Z4G82Uop3tl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=OZE+LAQU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="OZE+LAQU"
ARC-Seal: i=1; a=rsa-sha256; t=1771720175; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fhtG5lN7FxLNCAQxirwH4W5c92o1bqzFnEQB+1F4W0hkyLZ+VgGk45LUzXoJwGKoEGkujrIoZi/R6aozJEM43hKZnV6tUcam9UITUYoZH7y1oDQDwK/t4iyBTu0fz60I8elhPqxdMkGQxNPuhjfoxA1u+vRVZJtObYkb8fVLvKY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771720175; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5ug3WB33i9bkAy9WLUFiWIzV7v8h1phNVIOIF53hUMA=; 
	b=d/QiwsJr9hVsAzbQBRdyQkDzz+18Iab4LcvJLYMHggnuN/pk2Fw7l03o2YZCA7D3vI69KhxV6E4jjanXYxaPR4qO47eT6z+SldEsa/I1a5g6XypEXYAyOasJBvdGHe9Jv9X5gHGWpwLMQ/WKJVizIGmb6vRqm2J4oDWvAhMw3Zw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771720175;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5ug3WB33i9bkAy9WLUFiWIzV7v8h1phNVIOIF53hUMA=;
	b=OZE+LAQUh+rmh2xUQjgX4fU1WltLpZ+YuM4maEcTWjzMEL2IQg8W12bIO1Ox/Jto
	f9bU4z0rUb8Npz3M74mFynkONw1kufhOwoPF+msMGR0Iw5iyFutYHBSRfNF36eFG1c/
	pDef8pmOsTDR9hqFvT4Oj+4fgcsmXm0QGjSi13II=
Received: by mx.zohomail.com with SMTPS id 1771720172995379.8501483967307;
	Sat, 21 Feb 2026 16:29:32 -0800 (PST)
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
Subject: [PATCH v2 07/10] hook: add -j/--jobs option to git hook run
Date: Sun, 22 Feb 2026 02:29:01 +0200
Message-ID: <20260222002904.1879356-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260222002904.1879356-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260222002904.1879356-1-adrian.ratiu@collabora.com>
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
index 12d2701b52..c9492f6f8e 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -8,7 +8,8 @@ git-hook - Run git hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
+'git hook' run [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]
+	<hook-name> [-- <hook-args>]
 'git hook' list [-z] <hook-name>
 
 DESCRIPTION
@@ -134,6 +135,18 @@ OPTIONS
 -z::
 	Terminate "list" output lines with NUL instead of newlines.
 
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
 
@@ -156,7 +169,8 @@ running:
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
index 83020dfb4f..1fdde80113 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -9,7 +9,8 @@
 #include "abspath.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
-	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
+	N_("git hook run [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]\n" \
+	   "<hook-name> [-- <hook-args>]")
 #define BUILTIN_HOOK_LIST_USAGE \
 	N_("git hook list [-z] <hook-name>")
 
@@ -97,6 +98,8 @@ static int run(int argc, const char **argv, const char *prefix,
 			 N_("silently ignore missing requested <hook-name>")),
 		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
 			   N_("file to read into hooks' stdin")),
+		OPT_UNSIGNED('j', "jobs", &opt.jobs,
+			    N_("run up to <n> hooks simultaneously")),
 		OPT_END(),
 	};
 	int ret;
diff --git a/hook.c b/hook.c
index 3d624e2bcd..6214276e3d 100644
--- a/hook.c
+++ b/hook.c
@@ -524,15 +524,17 @@ static unsigned int get_hook_jobs(struct repository *r,
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
index 0d17969cdf..a6913b8c62 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -239,10 +239,20 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
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
@@ -260,12 +270,21 @@ test_hook_tty () {
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
@@ -604,6 +623,96 @@ test_expect_success 'server push-to-checkout hook expects stdout redirected to s
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

