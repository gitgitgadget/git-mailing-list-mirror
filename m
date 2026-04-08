Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B663D4105
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658982; cv=none; b=HoepGkbHpizIh/naVQ7ukw94EuT/5kdRoC/+M6tr4J1y3otq3nKcxBCMwGlE7XxaKQRW5b4tAOcx8OkJkdzVixp+pupFhxwMWH+hScW1eOA9kdilcYaRUrMf0CFKVJ/sdUCfLJuU82JKcCSW17DITQ8Mwv0MCtnQq/GwyMpZxAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658982; c=relaxed/simple;
	bh=Y7BI5NyiFybBNau5Ddt1O8ZLpWMFlbKyEbfxN81jWIQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DNETNZXLZIKWKFbfQXap7IfnaZjqYyyLPnkkrFDK+JLKmkGL6xQhaStQ7wOAUqSszbRTuBKg+pfm7yyUyjBFvGy2Nx9a4aCgW53D4x71fsQ8Fy0vs+OyCu2NBxb3Ag3YFJw/o6gSjW9lf+eqDr/KVyFUEeu2MldSADoe67z1atc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1SHxjMP; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1SHxjMP"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb38e86cf2so618665885a.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775658980; x=1776263780; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqwSugm5qbfdyz4Xkl2HffDyfAQBA1F0tLtV0RR8LxU=;
        b=m1SHxjMPM3srq3LS6EBKy95xkT1VvCHre7W2aH3j1Akb1GihwmQC8Zu9osfw8DmvNV
         QFJMiD0BkP3BJpuM9Z8JsZeH1jkkumnkmwSxcCGChQ6AMLnyTsqfpeAE/iRGu7XtQxjM
         RJIkUqOkYVTQSo9GOocy94U6kAUJQXIUSAcRKOJCLSSxJIdk2vvuOSSMJt2dyaFAeqF0
         booWpOAdAKMmBpCzApHxFom93uO+fAxv75qvLmN+9M9QSjGm71Xl6H2MhTjEw5QSJQh1
         WWJQyFKMVAEuzsqsSkk8vZVt5R2KRfUuHX6GIf60W83RM8PoZktGNPVVO45B//XslLNy
         Vlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775658980; x=1776263780;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OqwSugm5qbfdyz4Xkl2HffDyfAQBA1F0tLtV0RR8LxU=;
        b=op3yIxH1PVOxl/GrX5KLklYsD1h/U8nCDam9v8JifQPa/VdTWBSLquljdRjyw07ncC
         e9pUoWZfGniyK1nqQD7qvJ26TQppf31mSycnrw5hkeKQFQKkRW40ZjTQCdWhMkYaw8qs
         YVi0DHCpY9EJvKuSlrCuMrxviLFAwo01FnyfNH1I3dyYZHEGY2BGSEfJRypwMVaAV/5Z
         gcOay8lhPG8pRHvXeW6rf+9iyC9I+9E+O8Zo9NqTp5lups3IgIG6WeQvHAs1KoCj0Kq1
         YdcYF8e6k1hAVNtb2F59JdIta0/QmRyPJQL5ePKJ3bbpxgIAxUEbiXrU+4tnf6p0p95s
         Qlsg==
X-Gm-Message-State: AOJu0Yyy3rzYifuZddWowxetgeHKS1jXRY/hDZko46lpSowgCXBl7uLS
	io9BtbHToVd2Hpva9OAswQEQD0PiEdhTKRbD0GSO8R8xMW4zMn5AburI2ckjZA==
X-Gm-Gg: AeBDieu5USrcTaTmSTmNViIQ4Vym9qH1cDw7954p6VnA5AW/BtgV+tZttC8oFCoNEl3
	3jlF7RCWjTzxicl01UC3n1altpK/UtWCoOuboZi2vpMr6y3jKaL18wTOees86+oFsGIdyYxNuwW
	oS+U/wEBcxAIdVDPpaZy+vzy2LVmYKsKrxubqpvx4u5QSvaWW4V5rmxrOxiFxdXMieNcnfFSBJW
	BaaxECltNr22GOzI2bZMimxMZ05bXaCgexNzBkpORs2mIfxO4c9+N+TpZYUFKoB+4xfFNgRjOT0
	DHOYc+Ian30rPsjUcFR/Noos5qaKpNE2HLVIWLtmdM2Dr/qnBiDZ+5gqmfYbuK6re77cKqOv2Yu
	8Sm6AG/uYdzcqYVr4T8P9nv9wiek3D1yt1uwnnHIsGwIUTcJ4yVkAnOH53OY0ApttRZGsadSXun
	ob1ttVArxNqYpWfO6qDaB3cjhQvIU=
X-Received: by 2002:a05:620a:440a:b0:8d3:d13e:8ed with SMTP id af79cd13be357-8d41e24c0c6mr2727962985a.52.1775658979499;
        Wed, 08 Apr 2026 07:36:19 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.162])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d4b24ea458sm1155457585a.9.2026.04.08.07.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:36:18 -0700 (PDT)
Message-Id: <fbc98b0cbb93628e24b60163e4d3e55383ab9158.1775658970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 14:36:09 +0000
Subject: [PATCH 3/4] remote: add mustHave config as default for --must-have
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
    jonathantanmy@google.com,
    chooglen@google.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a new multi-valued config option remote.<name>.mustHave that
specifies ref patterns whose tips should always be sent as "have"
commits during fetch negotiation with that remote.

Parse the option in handle_config() following the same pattern as
remote.<name>.serverOption. Store the values in a string_list on struct
remote so they are available per-remote.

In builtin/fetch.c, when no --must-have options are given on the command
line, use the remote.<name>.mustHave config values as the default. If
the user explicitly provides --must-have on the CLI, the config is not
used, giving CLI precedence.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/remote.adoc | 23 +++++++++++++++
 Documentation/fetch-options.adoc |  4 +++
 builtin/fetch.c                  |  3 ++
 remote.c                         |  6 ++++
 remote.h                         |  1 +
 t/t5510-fetch.sh                 | 48 ++++++++++++++++++++++++++++++++
 6 files changed, 85 insertions(+)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 91e46f66f5..9df8be27eb 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -107,6 +107,29 @@ priority configuration file (e.g. `.git/config` in a repository) to clear
 the values inherited from a lower priority configuration files (e.g.
 `$HOME/.gitconfig`).
 
+remote.<name>.mustHave::
+	When negotiating with this remote during `git fetch` and `git push`,
+	the client advertises a list of commits that exist locally.  In
+	repos with many references, this list of "haves" can be truncated.
+	Depending on data shape, dropping certain references may be
+	expensive.  This multi-valued config option specifies ref patterns
+	whose tips should always be sent as "have" commits during fetch
+	negotiation with this remote.
++
+Each value is either an exact ref name (e.g. `refs/heads/release`) or a
+glob pattern (e.g. `refs/heads/release/*`).  The pattern syntax is the same
+as for `--negotiation-tip`.
++
+These config values are used as defaults for the `--must-have` command-line
+option.  If `--must-have` is specified on the command line, then the config
+values are not used.
++
+This option is additive with the normal negotiation process: the
+negotiation algorithm still runs and advertises its own selected commits,
+but the refs matching `remote.<name>.mustHave` are sent unconditionally on
+top of those heuristically selected commits.  This option is also used
+during push negotiation when `push.negotiate` is enabled.
+
 remote.<name>.followRemoteHEAD::
 	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
 	when fetching using the configured refspecs of a remote.
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 852e30191e..fa3969d68d 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -86,6 +86,10 @@ is the same as for `--negotiation-tip`.
 +
 If `--negotiation-tip` is used, the have set is first restricted by that
 option and then increased to include the tips specified by `--must-have`.
++
+If this option is not specified on the command line, then any
+`remote.<name>.mustHave` config values for the current remote are used
+instead.
 
 `--negotiate-only`::
 	Do not fetch anything from the server, and instead print the
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5d29cc6b1a..fa491c106f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1607,6 +1607,9 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 			transport->smart_options->must_have = &must_have;
 		else
 			warning(_("ignoring %s because the protocol does not support it"), "--must-have");
+	} else if (remote->must_have.nr) {
+		if (transport->smart_options)
+			transport->smart_options->must_have = &remote->must_have;
 	}
 	return transport;
 }
diff --git a/remote.c b/remote.c
index 7ca2a6501b..e07ec08fb3 100644
--- a/remote.c
+++ b/remote.c
@@ -152,6 +152,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	refspec_init_push(&ret->push);
 	refspec_init_fetch(&ret->fetch);
 	string_list_init_dup(&ret->server_options);
+	string_list_init_dup(&ret->must_have);
 
 	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
 		   remote_state->remotes_alloc);
@@ -179,6 +180,7 @@ static void remote_clear(struct remote *remote)
 	FREE_AND_NULL(remote->http_proxy);
 	FREE_AND_NULL(remote->http_proxy_authmethod);
 	string_list_clear(&remote->server_options, 0);
+	string_list_clear(&remote->must_have, 0);
 }
 
 static void add_merge(struct branch *branch, const char *name)
@@ -562,6 +564,10 @@ static int handle_config(const char *key, const char *value,
 	} else if (!strcmp(subkey, "serveroption")) {
 		return parse_transport_option(key, value,
 					      &remote->server_options);
+	} else if (!strcmp(subkey, "musthave")) {
+		if (!value)
+			return config_error_nonbool(key);
+		string_list_append(&remote->must_have, value);
 	} else if (!strcmp(subkey, "followremotehead")) {
 		const char *no_warn_branch;
 		if (!strcmp(value, "never"))
diff --git a/remote.h b/remote.h
index fc052945ee..e125313f45 100644
--- a/remote.h
+++ b/remote.h
@@ -117,6 +117,7 @@ struct remote {
 	char *http_proxy_authmethod;
 
 	struct string_list server_options;
+	struct string_list must_have;
 
 	enum follow_remote_head_settings follow_remote_head;
 	const char *no_warn_branch;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index c34f3805c1..09e7b613a5 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1801,6 +1801,54 @@ test_expect_success '--must-have avoids duplicates with negotiator' '
 	test_line_count = 1 matches
 '
 
+test_expect_success 'remote.<name>.mustHave used as default for --must-have' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	# No --must-have on CLI; config should be used as default.
+	git -C client config --add remote.origin.mustHave refs/tags/beta_1 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-tip=alpha_1 \
+		origin alpha_s beta_s &&
+
+	ALPHA_1=$(git -C client rev-parse alpha_1) &&
+	test_grep "fetch> have $ALPHA_1" trace &&
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace
+'
+
+test_expect_success 'remote.<name>.mustHave works with glob patterns' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	git -C client config --add remote.origin.mustHave "refs/tags/beta_*" &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-tip=alpha_1 \
+		origin alpha_s beta_s &&
+
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace &&
+	BETA_2=$(git -C client rev-parse beta_2) &&
+	test_grep "fetch> have $BETA_2" trace
+'
+
+test_expect_success 'CLI --must-have overrides remote.<name>.mustHave' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	# Config says beta_2, CLI says beta_1; only CLI should be used.
+	git -C client config --add remote.origin.mustHave refs/tags/beta_2 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-tip=alpha_1 \
+		--must-have=refs/tags/beta_1 \
+		origin alpha_s beta_s &&
+
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace &&
+	BETA_2=$(git -C client rev-parse beta_2) &&
+	test_grep ! "fetch> have $BETA_2" trace
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget

