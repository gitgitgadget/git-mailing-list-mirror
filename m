Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85FB3BF66D
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520474; cv=pass; b=IjAErEqKiHz5aCc2x4nXt7ugRtDKp+N5wH22MzTP1DMUoeQDvIiysGR2gXFe/5GOVLme60KtLv9FJ/vubiShaVMw+DUpUrdksEJU1G95kw//y1NUhKCeMVEamgtZrHzMXvw4+q2arV4lvXX4j3tYcRJTDK2wz+cAsOTY9w/wv4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520474; c=relaxed/simple;
	bh=5mlKM8wlSyLHBm5DzhvHHQTY7kjIHEmXwshhO10QuXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCifK16iYVmxP/rmUWnjhuPEz3l5tseHglyxwrlR9g07/MZSWh9m6L1psdzO6S5ftYqNHwdlfNYNcttpbW4RiBbZ8dJRXmUhjgZuakdUw3W8Bl348KvlvAhuqZkplOVuBdhdUUfwdOteh8YWuBFamWCXRicrX2i2YBjeoBb5FmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ZSX7eNOs; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ZSX7eNOs"
ARC-Seal: i=1; a=rsa-sha256; t=1774520448; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PEcjKOGcE4z5wkVbc3C2tJHGRuqMlmuievr+49VZwM89r1rFI0q28fY5HsLUPMPsHwU1ZeEMZ4G4qxvdgBIvWd+UNmi79eM3NVIREtq8wFAPhJLiVqx9rnJgLjgb22aCVj4I2GwmPhisTWCS0YA8KB8PaC6w5dIDrYRWWQV8lgs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774520448; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=j17x8KwYVOQOShZ29Yjs9lOQo/R3KXvHPVdq2Vrfc7k=; 
	b=hgZEHPoZ5N5aOQ48oZN0W+FhlW/KpEmUZFRLLzLIw+JYGx7v7wGo+Ys6U9tPPVZqzQBBtrbRodN4ASdkm/sWjSfInZmpuE8FRxn5aAHpjaIAGoouzT22uA22XelEfF8bTjTw+sBvycDQeSnPt5VWi6la7MWVQ+4FG/hEJqeVWxE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774520448;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=j17x8KwYVOQOShZ29Yjs9lOQo/R3KXvHPVdq2Vrfc7k=;
	b=ZSX7eNOsjTWCnLzIzmqO7z7Oq5U2Xkv/fWV24sX0orQtqHTfq7JxOsmEzkqBV8wP
	5ZuJ57x6yjVLD8mFQxUxIfzf0MvINj529/MkV7keyA9UUNPIAyTqXjWglH/2s8173e1
	W9+aQQ8B+veQ9ZkkALQwDIZDQN/7aUAsDVke6Ieg=
Received: by mx.zohomail.com with SMTPS id 1774520442119547.9020316232298;
	Thu, 26 Mar 2026 03:20:42 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v5 12/12] hook: allow hook.jobs=-1 to use all available CPU cores
Date: Thu, 26 Mar 2026 12:18:19 +0200
Message-ID: <20260326101819.1307742-13-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260326101819.1307742-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260326101819.1307742-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Allow -1 as a value for hook.jobs, hook.<event>.jobs, and the -j
CLI flag to mean "use as many jobs as there are CPU cores", matching
the convention used by fetch.parallel and other Git subsystems.

The value is resolved to online_cpus() at parse time so the rest
of the code always works with a positive resolved count.

Other non-positive values (0, -2, etc) are rejected with a warning
(config) or die (CLI).

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc |  4 ++-
 builtin/hook.c                 | 15 +++++++--
 hook.c                         | 60 ++++++++++++++++++++++++----------
 t/t1800-hook.sh                | 49 +++++++++++++++++++++++++++
 4 files changed, 108 insertions(+), 20 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index e0db3afa19..a9dc0063c1 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -58,7 +58,8 @@ hook.<event>.jobs::
 	hook event (e.g. `hook.post-receive.jobs = 4`). Overrides `hook.jobs`
 	for this specific event. The same parallelism restrictions apply: this
 	setting has no effect unless all configured hooks for the event have
-	`hook.<friendly-name>.parallel` set to `true`. Must be a positive int,
+	`hook.<friendly-name>.parallel` set to `true`. Set to `-1` to use the
+	number of available CPU cores. Must be a positive integer or `-1`;
 	zero is rejected with a warning. See linkgit:git-hook[1].
 +
 Note on naming: although this key resembles `hook.<friendly-name>.*`
@@ -74,6 +75,7 @@ valid event name when setting `hook.<event>.jobs`.
 hook.jobs::
 	Specifies how many hooks can be run simultaneously during parallelized
 	hook execution. If unspecified, defaults to 1 (serial execution).
+	Set to `-1` to use the number of available CPU cores.
 	Can be overridden on a per-event basis with `hook.<event>.jobs`.
 	Some hooks always run sequentially regardless of this setting because
 	they operate on shared data and cannot safely be parallelized:
diff --git a/builtin/hook.c b/builtin/hook.c
index 8e47e22e2a..cceeb3586e 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "hook.h"
 #include "parse-options.h"
+#include "thread-utils.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
 	N_("git hook run [--allow-unknown-hook-name] [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]\n" \
@@ -123,6 +124,7 @@ static int run(int argc, const char **argv, const char *prefix,
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	int ignore_missing = 0;
 	int allow_unknown = 0;
+	int jobs = 0;
 	const char *hook_name;
 	struct option run_options[] = {
 		OPT_BOOL(0, "allow-unknown-hook-name", &allow_unknown,
@@ -131,8 +133,8 @@ static int run(int argc, const char **argv, const char *prefix,
 			 N_("silently ignore missing requested <hook-name>")),
 		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
 			   N_("file to read into hooks' stdin")),
-		OPT_UNSIGNED('j', "jobs", &opt.jobs,
-			    N_("run up to <n> hooks simultaneously")),
+		OPT_INTEGER('j', "jobs", &jobs,
+			    N_("run up to <n> hooks simultaneously (-1 for CPU count)")),
 		OPT_END(),
 	};
 	int ret;
@@ -141,6 +143,15 @@ static int run(int argc, const char **argv, const char *prefix,
 			     builtin_hook_run_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	if (jobs == -1)
+		opt.jobs = online_cpus();
+	else if (jobs < 0)
+		die(_("invalid value for -j: %d"
+		     " (use -1 for CPU count or a"
+		     " positive integer)"), jobs);
+	else
+		opt.jobs = jobs;
+
 	if (!argc)
 		goto usage;
 
diff --git a/hook.c b/hook.c
index bc990d4ed4..d10eef4763 100644
--- a/hook.c
+++ b/hook.c
@@ -12,6 +12,7 @@
 #include "setup.h"
 #include "strbuf.h"
 #include "strmap.h"
+#include "thread-utils.h"
 
 bool is_known_hook(const char *name)
 {
@@ -165,13 +166,17 @@ static int hook_config_lookup_all(const char *key, const char *value,
 	/* Handle plain hook.<key> entries that have no hook name component. */
 	if (!name) {
 		if (!strcmp(subkey, "jobs") && value) {
-			unsigned int v;
-			if (!git_parse_uint(value, &v))
-				warning(_("hook.jobs must be a positive integer, ignoring: '%s'"), value);
-			else if (!v)
-				warning(_("hook.jobs must be positive, ignoring: 0"));
-			else
+			int v;
+			if (!git_parse_int(value, &v))
+				warning(_("hook.jobs must be an integer, ignoring: '%s'"), value);
+			else if (v == -1)
+				data->jobs = online_cpus();
+			else if (v > 0)
 				data->jobs = v;
+			else
+				warning(_("hook.jobs must be a positive integer"
+					  " or -1, ignoring: '%s'"),
+					value);
 		}
 		return 0;
 	}
@@ -259,17 +264,21 @@ static int hook_config_lookup_all(const char *key, const char *value,
 				  " ignoring: '%s'"),
 				hook_name, value);
 	} else if (!strcmp(subkey, "jobs")) {
-		unsigned int v;
-		if (!git_parse_uint(value, &v))
-			warning(_("hook.%s.jobs must be a positive integer,"
+		int v;
+		if (!git_parse_int(value, &v))
+			warning(_("hook.%s.jobs must be an integer,"
 				  " ignoring: '%s'"),
 				hook_name, value);
-		else if (!v)
-			warning(_("hook.%s.jobs must be positive,"
-				  " ignoring: 0"), hook_name);
-		else
+		else if (v == -1)
+			strmap_put(&data->event_jobs, hook_name,
+				   (void *)(uintptr_t)online_cpus());
+		else if (v > 0)
 			strmap_put(&data->event_jobs, hook_name,
 				   (void *)(uintptr_t)v);
+		else
+			warning(_("hook.%s.jobs must be a positive"
+				  " integer or -1, ignoring: '%s'"),
+				hook_name, value);
 	}
 
 	free(hook_name);
@@ -688,6 +697,25 @@ static void warn_non_parallel_hooks_override(unsigned int jobs,
 	}
 }
 
+/* Resolve a hook.jobs config key, handling -1 as online_cpus(). */
+static void resolve_hook_config_jobs(struct repository *r,
+				     const char *key,
+				     unsigned int *jobs)
+{
+	int v;
+
+	if (repo_config_get_int(r, key, &v))
+		return;
+
+	if (v == -1)
+		*jobs = online_cpus();
+	else if (v > 0)
+		*jobs = v;
+	else
+		warning(_("%s must be a positive integer or -1,"
+			  " ignoring: %d"), key, v);
+}
+
 /* Determine how many jobs to use for hook execution. */
 static unsigned int get_hook_jobs(struct repository *r,
 				  struct run_hooks_opt *options,
@@ -721,14 +749,12 @@ static unsigned int get_hook_jobs(struct repository *r,
 			if (event_jobs)
 				options->jobs = (unsigned int)(uintptr_t)event_jobs;
 		} else {
-			unsigned int event_jobs;
 			char *key;
 
-			repo_config_get_uint(r, "hook.jobs", &options->jobs);
+			resolve_hook_config_jobs(r, "hook.jobs", &options->jobs);
 
 			key = xstrfmt("hook.%s.jobs", hook_name);
-			if (!repo_config_get_uint(r, key, &event_jobs) && event_jobs)
-				options->jobs = event_jobs;
+			resolve_hook_config_jobs(r, key, &options->jobs);
 			free(key);
 		}
 	}
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 273588e4d4..dbd5299d92 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -1058,6 +1058,55 @@ test_expect_success 'hook.<event>.jobs does not warn for a real event name' '
 	test_grep ! "friendly-name" err
 '
 
+test_expect_success 'hook.jobs=-1 resolves to online_cpus()' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "true" &&
+	test_config hook.hook-1.parallel true &&
+
+	test_config hook.jobs -1 &&
+
+	cpus=$(test-tool online-cpus) &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git hook run --allow-unknown-hook-name test-hook >out 2>err &&
+	grep "\"region_enter\".*\"hook\".*\"test-hook\".*\"max:$cpus\"" trace.txt
+'
+
+test_expect_success 'hook.<event>.jobs=-1 resolves to online_cpus()' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "true" &&
+	test_config hook.hook-1.parallel true &&
+
+	test_config hook.test-hook.jobs -1 &&
+
+	cpus=$(test-tool online-cpus) &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git hook run --allow-unknown-hook-name test-hook >out 2>err &&
+	grep "\"region_enter\".*\"hook\".*\"test-hook\".*\"max:$cpus\"" trace.txt
+'
+
+test_expect_success 'git hook run -j-1 resolves to online_cpus()' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "true" &&
+	test_config hook.hook-1.parallel true &&
+
+	cpus=$(test-tool online-cpus) &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git hook run --allow-unknown-hook-name -j-1 test-hook >out 2>err &&
+	grep "\"region_enter\".*\"hook\".*\"test-hook\".*\"max:$cpus\"" trace.txt
+'
+
+test_expect_success 'hook.jobs rejects values less than -1' '
+	test_config hook.jobs -2 &&
+	git hook run --allow-unknown-hook-name --ignore-missing test-hook >out 2>err &&
+	test_grep "hook.jobs must be a positive integer or -1" err
+'
+
+test_expect_success 'hook.<event>.jobs rejects values less than -1' '
+	test_config hook.test-hook.jobs -5 &&
+	git hook run --allow-unknown-hook-name --ignore-missing test-hook >out 2>err &&
+	test_grep "hook.test-hook.jobs must be a positive integer or -1" err
+'
+
 test_expect_success 'hook.<event>.enabled=false skips all hooks for event' '
 	test_config hook.hook-1.event test-hook &&
 	test_config hook.hook-1.command "echo ran" &&
-- 
2.52.0.732.gb351b5166d.dirty

