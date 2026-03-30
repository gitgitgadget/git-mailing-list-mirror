Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD99E15A864
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892466; cv=none; b=Amk/e50wh5Yzjz96eauFqhXwrShEvASrtVaC/ea80a91nMDcmQVEBIRswaiMCs830JggbuXoBjWdaARmF1OMXsDGiUpYKL4s2tVnAa4infZs2uGcFOAtYYpWO30u5ii+IOt3/NxLiAbt0ONvr8oGCG2eH5BbxBvL+ze6MGh2NDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892466; c=relaxed/simple;
	bh=7S/3VOATY89HzDEKW4BYeOSTfROL9bFGMH88w/rK4VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmvXwT8sNn2+Hzy2DQFX2tt7AqAYWegnGWOWJHNfM+elIzMokKt0VYBiaiSeX3V6RebTnPN8GpUQNGb84f6cJZpm0vT9A5Z431fm0G/AFGYWO0S4iiORZdKI67xM5Pgve7VB5efW9xwxIIuwD5FtosSibGszCOjlDspRJ3utbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqASDXaD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqASDXaD"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b982b0889d8so567783166b.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 10:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774892463; x=1775497263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t51Cryl+aYmksm3TdgnNbCgxe4NZtSKuOJjKQo3UyXk=;
        b=aqASDXaDdLlaAzhw3ACfW4COrCE+8LTrHefnP1Sq4UunqsUlp8CdWlp/iAoJSgN8W/
         0tmhVBICpCQ/283iFELEEpJGLlFG+Kle7KV2q0VANf2n7eZft9e2t69Za72mJHfNXSH5
         6GoGNqbALbQakmEEfcGgI2HXvNxj8GZcSZdfnLrJY61K8b2laRoNq1NcvyZj60A2kD8+
         9UoMb+hU6UWyggphQr8JEQ/GtP6VA866NkEPy9ogUM1sDkvJxvzMQJaA5mDG7Hv0KkE+
         7w/7FpIGHQ3Y6DG2xliKV4zT1gNT/19+BKWD8U1jMPXLmNfsVLdO0wIwRDXyYI4RYKoY
         ZdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774892463; x=1775497263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t51Cryl+aYmksm3TdgnNbCgxe4NZtSKuOJjKQo3UyXk=;
        b=mHFOluIXyhoBmuQbJWNjULUIsns30EEyQNno9sxOP5rCUHmBIGe+epwzeFAkt1DYtQ
         um6kkPsr0m0HuRLGIu0Y9iJTLjtmzxtjBxgcZ40lPl/1pVIpDStLvRwVuyhlAFqTCADz
         F4U0k3aKxMc3gUfcxvEP9ZgPXcjamymwPG6T2+Wn2eY2ZD1nlg+agVQ2x8P57VGQyA2I
         hQwdQeNxjrtQQnZAgAfOfybP1Hsa9Ym9APPdgTgk5hiSZWFLY/IapP+/6A60qbzwunhc
         kROSHqTr7On/Cp9WFSTtLALI7NJbcPAECwXfLk8TlTF4HHETl3NncO7LgjIlO6NGmdkv
         ZMSA==
X-Gm-Message-State: AOJu0Yz6WE9oNgl6S7GuKMvw/Jsk7SlDyyIi3HRAxGz2oCTZTIyX9GiO
	N9TnTrhKz4OpjDVEsNwWH5AnQS2o60qTO8qjE1TJR4WpjI2or3XT8O7vLvaNLg==
X-Gm-Gg: ATEYQzwZQSKkvUGuK/4uAE/QvxN3renI8SXE02/y3L+Rjer6aGqOF1mvWNOzay9RZ/M
	Vsr8G+knvM6Q6XldmC+sWP4fhKuFAurIrFwyb/yt0oDLlM8/Ko7ZqJsv5wCwyjHb4rxMRDwGhdP
	xxYghthpVQbVrgqcD3ILefgJ7wjGXuVHXlG7Du05eP+M1klyhao330WnU6W6OLsu/K0zsk/IdGq
	vFSoVRojTEasLyGXF0seP+wVSlGy3zE05GxavrrQuztQqHTUcxP6/Grfaatwqe/iaK2HR0oSDoP
	R3tjubX2mdTeSTOiCbX7h2lPLG7oZSsfoN2qvA3hiRmJufseIC/hv5oecDahneN3NJW6sDag+BP
	b6Sv/C3nip0Y3p9E7ODAycK84qJNn3GK6m3fZZPlvi6gpE4P9NcvJi2dp+kn93q1SP4cCWncGXo
	9toFV38r9SruOahnwf1rssiq4IDFW2TUNulo1zq/ZfmQ/Ml2O+aj6mafGPlbCSwymwGJap6QJgu
	C/+cwbnSyzazYyEV6htYaTWrxba52H5td3vAp6coBJK0SvfobJ5uSSK
X-Received: by 2002:a17:907:1c1e:b0:b97:1d24:c004 with SMTP id a640c23a62f3a-b9b5039c50bmr819143666b.21.1774892462387;
        Mon, 30 Mar 2026 10:41:02 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae520c2sm320769066b.21.2026.03.30.10.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 10:41:02 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH 2/2] fetch: add fetch.submoduleErrors to make submodule fetch errors non-fatal
Date: Mon, 30 Mar 2026 20:39:38 +0300
Message-ID: <20260330173938.3792358-3-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330173938.3792358-1-paulius.zaleckas@gmail.com>
References: <20260330173938.3792358-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fetching with --recurse-submodules, a submodule commit that is not
yet reachable from any of the submodule's remote refs causes the entire
fetch to fail.  This is overly strict when the missing commit belongs to
an upstream branch that is still being prepared (e.g. an in-progress
merge topic): the local branch does not need that commit, so there is no
reason to treat its absence as fatal.

Add a new config key fetch.submoduleErrors (values: fail/warn) and a
corresponding --submodule-errors=<fail|warn> command-line option that
control this behaviour.  The default remains fail (existing behaviour);
setting the value to warn causes submodule fetch failures to be reported
on stderr without affecting the overall exit status of git fetch / git
pull.

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 Documentation/config/fetch.adoc | 14 +++++
 builtin/fetch.c                 | 39 +++++++++++++-
 submodule.c                     |  8 ++-
 submodule.h                     |  7 ++-
 t/t5526-fetch-submodules.sh     | 96 +++++++++++++++++++++++++++++++++
 5 files changed, 160 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
index cd40db0cad..8a6b68e57e 100644
--- a/Documentation/config/fetch.adoc
+++ b/Documentation/config/fetch.adoc
@@ -1,3 +1,17 @@
+`fetch.submoduleErrors`::
+	Controls how errors from submodule fetches are handled when
+	`--recurse-submodules` is in effect. When set to `fail` (the default),
+	any submodule fetch error causes the overall `git fetch` or `git pull`
+	to exit with a non-zero status. When set to `warn`, submodule fetch
+	errors are reported to stderr but do not affect the exit status of the
+	command. This is useful when working in repositories where some
+	branches reference submodule commits that are not yet available on the
+	submodule remote, but those commits are not needed for the currently
+	checked-out branch.
++
+The value of this option can be overridden on the command line with
+`--submodule-errors=<fail|warn>`.
+
 `fetch.recurseSubmodules`::
 	This option controls whether `git fetch` (and the underlying fetch
 	in `git pull`) will recursively fetch into populated submodules.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4795b2a13c..07fa3cb0a4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -109,6 +109,7 @@ struct fetch_config {
 	int recurse_submodules;
 	int parallel;
 	int submodule_fetch_jobs;
+	int submodule_errors;
 };
 
 static int git_fetch_config(const char *k, const char *v,
@@ -151,6 +152,19 @@ static int git_fetch_config(const char *k, const char *v,
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.submoduleerrors")) {
+		if (!v)
+			return config_error_nonbool(k);
+		else if (!strcasecmp(v, "fail"))
+			fetch_config->submodule_errors = SUBMODULE_ERRORS_FAIL;
+		else if (!strcasecmp(v, "warn"))
+			fetch_config->submodule_errors = SUBMODULE_ERRORS_WARN;
+		else
+			die(_("invalid value for '%s': '%s'"),
+			    "fetch.submoduleErrors", v);
+		return 0;
+	}
+
 	if (!strcmp(k, "fetch.parallel")) {
 		fetch_config->parallel = git_config_int(k, v, ctx->kvi);
 		if (fetch_config->parallel < 0)
@@ -2460,6 +2474,19 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	return exit_code;
 }
 
+static int option_parse_submodule_errors(const struct option *opt,
+					  const char *arg, int unset)
+{
+	int *v = opt->value;
+	if (unset || !strcasecmp(arg, "fail"))
+		*v = SUBMODULE_ERRORS_FAIL;
+	else if (!strcasecmp(arg, "warn"))
+		*v = SUBMODULE_ERRORS_WARN;
+	else
+		die(_("invalid value for '%s': '%s'"), "--submodule-errors", arg);
+	return 0;
+}
+
 int cmd_fetch(int argc,
 	      const char **argv,
 	      const char *prefix,
@@ -2473,6 +2500,7 @@ int cmd_fetch(int argc,
 		.recurse_submodules = RECURSE_SUBMODULES_DEFAULT,
 		.parallel = 1,
 		.submodule_fetch_jobs = -1,
+		.submodule_errors = SUBMODULE_ERRORS_FAIL,
 	};
 	const char *submodule_prefix = "";
 	const char *bundle_uri;
@@ -2487,6 +2515,7 @@ int cmd_fetch(int argc,
 	int max_jobs = -1;
 	int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
 	int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
+	int submodule_errors_cli = -1; /* -1: not set on command line */
 	int fetch_write_commit_graph = -1;
 	int stdin_refspecs = 0;
 	int negotiate_only = 0;
@@ -2523,6 +2552,10 @@ int cmd_fetch(int argc,
 		OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_cli, N_("on-demand"),
 			    N_("control recursive fetching of submodules"),
 			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
+		OPT_CALLBACK_F(0, "submodule-errors", &submodule_errors_cli,
+			    N_("fail|warn"),
+			    N_("control how submodule fetch errors are handled"),
+			    0, option_parse_submodule_errors),
 		OPT_BOOL(0, "dry-run", &dry_run,
 			 N_("dry run")),
 		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
@@ -2609,6 +2642,9 @@ int cmd_fetch(int argc,
 	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
 		config.recurse_submodules = recurse_submodules_cli;
 
+	if (submodule_errors_cli != -1)
+		config.submodule_errors = submodule_errors_cli;
+
 	if (negotiate_only) {
 		switch (recurse_submodules_cli) {
 		case RECURSE_SUBMODULES_OFF:
@@ -2824,7 +2860,8 @@ int cmd_fetch(int argc,
 					  config.recurse_submodules,
 					  recurse_submodules_default,
 					  verbosity < 0,
-					  max_children);
+					  max_children,
+					  config.submodule_errors);
 		trace2_region_leave_printf("fetch", "recurse-submodule", the_repository, "%s", submodule_prefix);
 		strvec_clear(&options);
 	}
diff --git a/submodule.c b/submodule.c
index 0fda96a436..5b23aafb0f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1408,6 +1408,7 @@ struct submodule_parallel_fetch {
 	int oid_fetch_tasks_nr, oid_fetch_tasks_alloc;
 
 	struct strbuf submodules_with_errors;
+	int submodule_errors;
 };
 #define SPF_INIT { \
 	.args = STRVEC_INIT, \
@@ -1749,7 +1750,8 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 static void record_fetch_error(struct submodule_parallel_fetch *spf,
 			       const char *name)
 {
-	spf->result = 1;
+	if (spf->submodule_errors == SUBMODULE_ERRORS_FAIL)
+		spf->result = 1;
 	strbuf_addf(&spf->submodules_with_errors, "\t%s\n", name);
 }
 
@@ -1846,7 +1848,8 @@ int fetch_submodules(struct repository *r,
 		     const struct strvec *options,
 		     const char *prefix, int command_line_option,
 		     int default_option,
-		     int quiet, int max_parallel_jobs)
+		     int quiet, int max_parallel_jobs,
+		     int submodule_errors)
 {
 	int i;
 	struct submodule_parallel_fetch spf = SPF_INIT;
@@ -1867,6 +1870,7 @@ int fetch_submodules(struct repository *r,
 	spf.default_option = default_option;
 	spf.quiet = quiet;
 	spf.prefix = prefix;
+	spf.submodule_errors = submodule_errors;
 
 	if (!r->worktree)
 		goto out;
diff --git a/submodule.h b/submodule.h
index b10e16e6c0..c80b687d2a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -90,12 +90,17 @@ int should_update_submodules(void);
  */
 const struct submodule *submodule_from_ce(const struct cache_entry *ce);
 void check_for_new_submodule_commits(struct object_id *oid);
+/* Values for the submodule_errors parameter of fetch_submodules(). */
+#define SUBMODULE_ERRORS_FAIL 0  /* submodule fetch errors are fatal (default) */
+#define SUBMODULE_ERRORS_WARN 1  /* submodule fetch errors are non-fatal warnings */
+
 int fetch_submodules(struct repository *r,
 		     const struct strvec *options,
 		     const char *prefix,
 		     int command_line_option,
 		     int default_option,
-		     int quiet, int max_parallel_jobs);
+		     int quiet, int max_parallel_jobs,
+		     int submodule_errors);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int submodule_uses_gitfile(const char *path);
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 1242ee9185..469b92b89b 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -1262,4 +1262,100 @@ test_expect_success "fetch --all with --no-recurse-submodules only fetches super
 	! grep "Fetching submodule" fetch-log
 '
 
+# Create an isolated environment for fetch.submoduleErrors tests.
+#
+# Sets up sub_bare (the submodule upstream), super_bare (the superproject
+# upstream), super_work (a working clone of super_bare with an initialized
+# submodule), and clone (a clone of super_bare with an initialized submodule
+# at a reachable commit). The caller can then create an unreachable commit
+# and push the superproject to put the clone one commit behind a state it
+# cannot fully fetch.
+#
+# Usage: create_err_env <envdir>
+create_err_env () {
+	local envdir="$1" &&
+	mkdir "$envdir" &&
+
+	git init --bare "$envdir/sub_bare" &&
+	git clone "$envdir/sub_bare" "$envdir/sub_work" &&
+	test_commit -C "$envdir/sub_work" "${envdir}_base" &&
+	git -C "$envdir/sub_work" push &&
+
+	git init --bare "$envdir/super_bare" &&
+	git clone "$envdir/super_bare" "$envdir/super_work" &&
+	git -C "$envdir/super_work" submodule add \
+		"$pwd/$envdir/sub_bare" sub &&
+	git -C "$envdir/super_work" commit -m "add submodule" &&
+	git -C "$envdir/super_work" push &&
+
+	git clone "$envdir/super_bare" "$envdir/clone" &&
+	git -C "$envdir/clone" submodule update --init
+}
+
+# Push a commit to <envdir>/super_bare that records a submodule SHA that is
+# present locally in super_work/sub but NOT pushed to sub_bare, making the
+# submodule commit unreachable from clone's sub remote.
+push_unreachable_commit () {
+	local envdir="$1" &&
+	git -C "$envdir/super_work/sub" commit --allow-empty -m "unreachable" &&
+	git -C "$envdir/super_work" add sub &&
+	git -C "$envdir/super_work" commit -m "point sub to unreachable commit" &&
+	git -C "$envdir/super_work" push
+}
+
+test_expect_success 'setup for fetch.submoduleErrors tests' '
+	git config --global protocol.file.allow always
+'
+
+test_expect_success 'fetch --recurse-submodules fails when submodule commit is unreachable (default)' '
+	test_when_finished "rm -fr env_default" &&
+	create_err_env env_default &&
+	push_unreachable_commit env_default &&
+	test_must_fail git -C env_default/clone fetch --recurse-submodules 2>err &&
+	grep "Errors during submodule fetch" err
+'
+
+test_expect_success 'fetch.submoduleErrors=warn: unreachable submodule commit is non-fatal' '
+	test_when_finished "rm -fr env_warn_cfg" &&
+	create_err_env env_warn_cfg &&
+	push_unreachable_commit env_warn_cfg &&
+	git -C env_warn_cfg/clone -c fetch.submoduleErrors=warn \
+		fetch --recurse-submodules 2>err &&
+	grep "Errors during submodule fetch" err
+'
+
+test_expect_success '--submodule-errors=warn: unreachable submodule commit is non-fatal' '
+	test_when_finished "rm -fr env_warn_cli" &&
+	create_err_env env_warn_cli &&
+	push_unreachable_commit env_warn_cli &&
+	git -C env_warn_cli/clone fetch --recurse-submodules \
+		--submodule-errors=warn 2>err &&
+	grep "Errors during submodule fetch" err
+'
+
+test_expect_success '--submodule-errors=fail: unreachable submodule commit is fatal' '
+	test_when_finished "rm -fr env_fail_cli" &&
+	create_err_env env_fail_cli &&
+	push_unreachable_commit env_fail_cli &&
+	test_must_fail git -C env_fail_cli/clone fetch --recurse-submodules \
+		--submodule-errors=fail 2>err &&
+	grep "Errors during submodule fetch" err
+'
+
+test_expect_success 'fetch.submoduleErrors=warn does not suppress successful fetch' '
+	# A new reachable submodule commit (pushed to sub_bare) should be
+	# fetched without any error summary.
+	test_when_finished "rm -fr env_ok" &&
+	create_err_env env_ok &&
+	test_commit -C env_ok/sub_work reachable_ok &&
+	git -C env_ok/sub_work push &&
+	git -C env_ok/super_work submodule update --remote &&
+	git -C env_ok/super_work add sub &&
+	git -C env_ok/super_work commit -m "point sub to reachable commit" &&
+	git -C env_ok/super_work push &&
+	git -C env_ok/clone -c fetch.submoduleErrors=warn \
+		fetch --recurse-submodules 2>err &&
+	! grep "Errors during submodule fetch" err
+'
+
 test_done
-- 
2.53.0

