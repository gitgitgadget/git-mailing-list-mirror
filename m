Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6B3C37B4
	for <git@vger.kernel.org>; Thu, 14 May 2026 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762513; cv=none; b=Ghp7fd2l9kiCLJF9qbcs8esIMoUOThALn+Ar9bGa1qQc0Uypsohyzy+sdPvvJsCkRKLpHiXZLAdIBSpjXHDi8n540njKLwPVVcUcmj71kOJicL+NNb+QafJKxLnKV/hUKg9/+BaXYR3CcYxobaOpBPucV6POhfuwXgV8ctR11XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762513; c=relaxed/simple;
	bh=04L04dCYOH0KzRE4dteTCCURFuT4jg+ck9W/lo4bxVQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=X8nX7ubbgh0yCTYCnT6o8ilUtcUZ/jfz5ml8jcEyWaIGXMyKAezmNjy+ZCGywQLTNMYLX6HYieom4WPA2j2M5zfLWT+QwpuCKlAjCO4Xqt4M+uzEnVvWOf38Hs1NlmAnUljQAPBxpSSUFSu0wlSjVbciuM2ir3wcIv2s8kEdHks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVD93LU+; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVD93LU+"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso5572742eec.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 05:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778762510; x=1779367310; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irS/aB9kHNTIzHmm21ppwCWEw+ATMyuA1BgQQhkjSAc=;
        b=oVD93LU+EWxmIU6eI2trhXDoAYYim+PxdPVDsNSsS//8eKeJunlJNTzCzPhvUrAbtJ
         VlewUQ3miMZ4uunZ+6051wSd1jzOFcWzV3c+Xj4otl4PvR7mFSo2FlABuiLsl2Hx1D68
         ts9SeKZezdeDu6J/gWjGhMvMU2hCvLbkoirHYiaxaU2V8RdtEByw1CcKaKFRIeIRYBr9
         CBZJ67BuIYGr/jqBEBXHS6WbwIsz8MFY0SVxSQDT8BdF6yYJs0pPwINhS+/PskXOpuob
         iTYscwwll/zOHCvfplhrkQY/FEjWMP+XBdlyNCpQ5udTlqAKd6BXFIoiGISZE1hD4YjG
         w35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762510; x=1779367310;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=irS/aB9kHNTIzHmm21ppwCWEw+ATMyuA1BgQQhkjSAc=;
        b=sD95iE7goo90783RnIA+CgduqP9KhQ1TbnK0f7uOGF540Ucbqmhc/xgP076EuzJFi7
         /aHPsGqWGmZEiWdbJODsKpNK35PlUOjt7onW0IBsQR0o1NDMs2pxSLg7dQciRND15M9w
         R8o1geN3SJ4nGBjLfqerguuEV7tALZKKExpglJqEr3gBE/6W0OnyH8d6Ffr2vcbH4nhM
         Q64yp8yZgUxgzx5Tpl7q9DCYVDbuHKt8F8Appoo5UeY0hG3B9IHhZsQPEDwzGCyEg8Zh
         DSrhg+eQXtp2WSkh6o+HiJLuBuMzUAOJvlvccAvlI2hd9trXaYE7IjUeJGQoWFLYVLU7
         iq8w==
X-Gm-Message-State: AOJu0YzoZjGJU4JgnLCoTU/r279gN2DIXRNPE0v00D9u/o5+J19fPx+G
	8JyaDpQO9VqYOhZiuXMGP27GUXBze78y8FaHoJ+PoX0LPW5Drl6LD9Pu0G8TCIiL
X-Gm-Gg: Acq92OH+FL3N/E4jMlpQfXEVMEE1BGGgw85QBb29oeXowJmauL1HEvY85cfM4rHm/0n
	YMF8m+nb+3OVecX1kvpms1Hs5+9rjz3pddjiCJJKlAF9A9ASwrQKZtnzZZrvQFZjrJFDnTOuEHq
	SIy2TTDB0O3EqPzO5kaYbyojXiPZqBAp9o1iClh4mhOk6YMzLOIrv4hOJfNBtkv89wP7ERFSF6u
	+U8ZAlxJ0prHIUnXED0hlhl27065xlTTwau84g1qkqELw682Vzfs8ut33HFeHq8cvn1P3WmhTKr
	Ma7URHOMFyxPwnytxVHC4myGa5EMkqUsAwraboRSebFAH1+Y5Y8+fo726womy76WNjtlxqS4tJh
	0jwuXCpKU7WjIsvRirpe94517+Z65smjLwdPGaZ8+gSvSXZ68TYvtKx6I81een3ZIeycgEaG9Ml
	+pt6oXUc9zcfwnSS1FRgYHp35kZg==
X-Received: by 2002:a05:7300:e12f:b0:2de:e194:5fb1 with SMTP id 5a478bee46e88-3025f672f90mr2042469eec.7.1778762509550;
        Thu, 14 May 2026 05:41:49 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.45.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e6a9sm2721697eec.2.2026.05.14.05.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:41:48 -0700 (PDT)
Message-Id: <7bd70a970b819c2d856bf8663e26797498526399.1778762495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
	<pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 12:41:34 +0000
Subject: [PATCH v4 7/8] remote: add remote.*.negotiationInclude config
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
    ps@pks.im,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add a new 'remote.<name>.negotiationInclude' multi-valued config option that
provides default values for --negotiation-include when no
--negotiation-include arguments are specified over the command line.  This
is a mirror of how 'remote.<name>.negotiationRestrict' specifies defaults
for the --negotiation-restrict arguments.

Each value is either an exact ref name or a glob pattern whose tips should
always be sent as 'have' lines during negotiation. The config values are
resolved through the same resolve_negotiation_include() codepath as the CLI
options.

This option is additive with the normal negotiation process: the negotiation
algorithm still runs and advertises its own selected commits, but the refs
matching the config are sent unconditionally on top of those heuristically
selected commits.

Similar to the negotiationRestrict config, an empty value resets the value
list to allow ignoring earlier config values, such as those that might be
set in system or global config.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/remote.adoc | 27 ++++++++++++++++++
 Documentation/fetch-options.adoc |  4 +++
 builtin/fetch.c                  | 11 +++++++
 remote.c                         |  5 ++++
 remote.h                         |  1 +
 t/t5510-fetch.sh                 | 49 ++++++++++++++++++++++++++++++++
 6 files changed, 97 insertions(+)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 4dcf81fbce..9ae20e4379 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -125,6 +125,33 @@ values are not used.
 Blank values signal to ignore all previous values, allowing a reset of
 the list from broader config scenarios.
 
+remote.<name>.negotiationInclude::
+	When negotiating with this remote during `git fetch`, the client
+	advertises a list of commits that exist locally.  In repos with
+	many references, this list of "haves" can be truncated. Depending
+	on data shape, dropping certain references may be expensive. This
+	multi-valued config option specifies references, commit hashes,
+	or ref pattern globs whose tips should always be sent as "have"
+	commits during fetch negotiation with this remote.
++
+Each value is either an exact ref name (e.g. `refs/heads/release`), a
+commit hash, or a glob pattern (e.g. `refs/heads/release/*`).  The
+pattern syntax is the same as for `--negotiation-include`.
++
+These config values are used as defaults for the `--negotiation-include`
+command-line option.  If `--negotiation-include` is specified on the
+command line, then the config values are not used.
++
+This option is additive with the normal negotiation process: the
+negotiation algorithm still runs and advertises its own selected commits,
+but the refs matching `remote.<name>.negotiationInclude` are sent
+unconditionally on top of those heuristically selected commits.  This
+option is also used during push negotiation when `push.negotiate` is
+enabled.
++
+Blank values signal to ignore all previous values, allowing a reset of
+the list from broader config scenarios.
+
 remote.<name>.followRemoteHEAD::
 	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
 	when fetching using the configured refspecs of a remote.
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 7b897a7202..8074004377 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -91,6 +91,10 @@ The pattern syntax is the same as for `--negotiation-restrict`.
 If `--negotiation-restrict` is used, the have set is first restricted by
 that option and then increased to include the tips specified by
 `--negotiation-include`.
++
+If this option is not specified on the command line, then any
+`remote.<name>.negotiationInclude` config values for the current remote
+are used instead.
 
 `--negotiate-only`::
 	Do not fetch anything from the server, and instead print the
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6b456b3689..2308cab377 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1630,6 +1630,17 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 		else
 			warning(_("ignoring %s because the protocol does not support it"),
 				"--negotiation-include");
+	} else if (remote->negotiation_include.nr) {
+		if (transport->smart_options) {
+			add_negotiation_tips(&remote->negotiation_include,
+					     &transport->smart_options->negotiation_include_tips);
+		} else {
+			struct strbuf config_name = STRBUF_INIT;
+			strbuf_addf(&config_name, "remote.%s.negotiationInclude", remote->name);
+			warning(_("ignoring %s because the protocol does not support it"),
+				config_name.buf);
+			strbuf_release(&config_name);
+		}
 	}
 	return transport;
 }
diff --git a/remote.c b/remote.c
index 620086e16e..6fb5758820 100644
--- a/remote.c
+++ b/remote.c
@@ -153,6 +153,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	refspec_init_fetch(&ret->fetch);
 	string_list_init_dup(&ret->server_options);
 	string_list_init_dup(&ret->negotiation_restrict);
+	string_list_init_dup(&ret->negotiation_include);
 
 	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
 		   remote_state->remotes_alloc);
@@ -181,6 +182,7 @@ static void remote_clear(struct remote *remote)
 	FREE_AND_NULL(remote->http_proxy_authmethod);
 	string_list_clear(&remote->server_options, 0);
 	string_list_clear(&remote->negotiation_restrict, 0);
+	string_list_clear(&remote->negotiation_include, 0);
 }
 
 static void add_merge(struct branch *branch, const char *name)
@@ -567,6 +569,9 @@ static int handle_config(const char *key, const char *value,
 	} else if (!strcmp(subkey, "negotiationrestrict")) {
 		return parse_transport_option(key, value,
 					      &remote->negotiation_restrict);
+	} else if (!strcmp(subkey, "negotiationinclude")) {
+		return parse_transport_option(key, value,
+					      &remote->negotiation_include);
 	} else if (!strcmp(subkey, "followremotehead")) {
 		const char *no_warn_branch;
 		if (!strcmp(value, "never"))
diff --git a/remote.h b/remote.h
index e6ec37c393..d8809b6991 100644
--- a/remote.h
+++ b/remote.h
@@ -118,6 +118,7 @@ struct remote {
 
 	struct string_list server_options;
 	struct string_list negotiation_restrict;
+	struct string_list negotiation_include;
 
 	enum follow_remote_head_settings follow_remote_head;
 	const char *no_warn_branch;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index bc2e2af959..33f61ac12a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1587,6 +1587,55 @@ test_expect_success '--negotiation-include avoids duplicates with negotiator' '
 	test_line_count = 1 matches
 '
 
+test_expect_success 'remote.<name>.negotiationInclude used as default for --negotiation-include' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	# test the reset of the list on an empty value
+	git -C client config --add remote.origin.negotiationInclude refs/tags/alpha_1 &&
+	git -C client config --add remote.origin.negotiationInclude "" &&
+	git -C client config --add remote.origin.negotiationInclude refs/tags/beta_1 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=beta_2 \
+		origin alpha_s beta_s &&
+
+	ALPHA_1=$(git -C client rev-parse alpha_1) &&
+	test_grep ! "fetch> have $ALPHA_1" trace &&
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace
+'
+
+test_expect_success 'remote.<name>.negotiationInclude works with glob patterns' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	git -C client config --add remote.origin.negotiationInclude "refs/tags/beta_*" &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		origin alpha_s beta_s &&
+
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace &&
+	BETA_2=$(git -C client rev-parse beta_2) &&
+	test_grep "fetch> have $BETA_2" trace
+'
+
+test_expect_success 'CLI --negotiation-include overrides remote.<name>.negotiationInclude' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	git -C client config --add remote.origin.negotiationInclude refs/tags/beta_2 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-include=refs/tags/beta_1 \
+		origin alpha_s beta_s &&
+
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep "fetch> have $BETA_1" trace &&
+	BETA_2=$(git -C client rev-parse beta_2) &&
+	test_grep ! "fetch> have $BETA_2" trace
+'
+
 test_expect_success '--negotiation-include avoids duplicates with v0' '
 	test_when_finished rm -f trace &&
 	setup_negotiation_tip server server 0 &&
-- 
gitgitgadget

