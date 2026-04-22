Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48034029E
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871565; cv=none; b=by+s8bvsxhV5bVhZJD1Sdompuo1iyUlK6LOzsRlr+YAGRtzqONLQJh3vwQYC0P6PT9ygoGr8/oICsVsIlo9c9/8tRhVB8gXDMgeqZlIPg6B3zJkLLsRBNWMsbB8zVwCd/ZhrVnTdnCpODLGF3V+8RZeJYWH1vGED2969gTsQKnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871565; c=relaxed/simple;
	bh=nKY1SoajErWekGokFSinQvdo84gfPN2ERw5JRMZmdvc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UF4y0MU3UCBs0QGDafaM2BHfYkcLlStKZycTBeoYogU24slWw1qSEx8nEPGCEHknBPjA6hupDFOaZMeT0Y9oScWy6e8dkY1dAGo30sFBDxp8XqYAKsVPd7nlyIChaYskF3fMxY2Mt8VxbNu633UKinkym3RuZQClu7XpWtTgucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKb2U+zd; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKb2U+zd"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c156c4a9efso7504063eec.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871559; x=1777476359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tk8Ui/am3eTzZ7Nvvg+XiOLyHwMTe860jt73MLbKgp4=;
        b=BKb2U+zdJJfSbp6NQa5TTyDkPhENJWVRGXnqmPc+ZjGZX1r/ZiHFX2lXpCOPpQ3keF
         1yuU67QxKuBLVQq8jgtBwwYMSvKkgbHPBWjo/yveRoywdpCuATHvUuT0ZVzaKzMbY2F6
         sv09+GxUF5pJM2ZAp821oh+crk31LPfXfij9skjCo47rqzr00E1oT/NXGb0HpwtYrWHX
         Pc0pPSLZQG0F7fvvwyCbQ7WX/sBiMwTrOqXjdWIqcsthyeOdYWCYTDmPXWW5m1+p5W/O
         NLcNNZxHXolXsjN/t6A+Nh7MOpFqheL3CJnAhsA6YxTOLho+ACyqRcBOariLpAgqeLXt
         gM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871559; x=1777476359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tk8Ui/am3eTzZ7Nvvg+XiOLyHwMTe860jt73MLbKgp4=;
        b=VGF5T1RCkPoq/vlB8lPbm1Js6u5XZ+hkoGcNgEyFDNsm2OjuPzKHaslUXBqyA8sDhY
         j2W7ygyekbfVlLRRA89tSjGLVMDlXRU9Ie2cKElHxDg9YR+sOasi+2Phc7ikjvVobtbW
         l0OwNVPVg/xnZGIRzzJJnUS/AmmX4gJevQhKLmKE0Uo3OhBUZ1ONqxw78jyUgijF/8BD
         y70Kwz99l56n1pIHfRAvWmSBZkiz+c7F9G0ijeQbONhcfMpkKJ6TQmpBzESrBCrtjOiJ
         EFyVPtCqWCzE2Xds3Rsg0VwUL1hEC7iaxmd4yItpdO8TXxm8jM23Xze0BLvMw337mwIX
         K1+A==
X-Gm-Message-State: AOJu0Yx8QVV1EdO8Db1orY4iJRYFVnmqyvAGMSMni2vv5GLcqk2Rr28u
	l3IRGBQ0c3kGhN0B1En/LuOphXrL875k3YbVLZtNDWPQuRUEh0eH+EtmsOpH8Q==
X-Gm-Gg: AeBDievX0wmqR1qutNhvpEhlgo+5DQfeAHj1AUdFNsX5yZiUmJhXSU7/xFJxPkzwU2D
	g6nJ7BCguf+j/Y93lt1UGaTKMN5kY6XHzijR73ChTpcoJw2K9lb9bpiDocWg53RBMRZAAfrHKNm
	sKouX2zm5zxcqzjLCEHzsBQa3hNoAIGrm17hCUnAwEM5HPkV8+i9uHu0xYwCHzMW2fhXVRhvXLj
	WFTAF48fNBlsSGPN5QOfD1U0rhm5p9HXzBN0YnIc21kOunTy0VFRI2LIEXWLSwVAKcFZ8LQ7SbB
	3mtIrm5Jk2KAJSygP3uPtDnYikY09C8ZyCE+ih4rJoY8QFKsG0ptkk5+VWAgeB4uHVkLX6NhOlh
	uUTu2UN1eGQe2N4tTaS4mpCeJ3tijrYJDaAjwBKxU3oVtP4MRbtJaA7hm64DxGPTdF+7VTaqQGU
	36fjXRrwoN0vFc+Y2+8bQFQC+Fm3+NNzPeTyf/fQ==
X-Received: by 2002:a05:7300:d70c:b0:2de:c5ca:c1e8 with SMTP id 5a478bee46e88-2e464eaa2demr12149889eec.4.1776871558261;
        Wed, 22 Apr 2026 08:25:58 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e79c2954f6sm22825012eec.30.2026.04.22.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:25:57 -0700 (PDT)
Message-Id: <a2d15fa12af70367ac6b289f69228cd33dd97d5e.1776871546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
	<pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Apr 2026 15:25:45 +0000
Subject: [PATCH v3 6/7] remote: add remote.*.negotiationInclude config
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
 builtin/fetch.c                  | 10 +++++++
 remote.c                         |  8 ++++++
 remote.h                         |  1 +
 t/t5510-fetch.sh                 | 49 ++++++++++++++++++++++++++++++++
 6 files changed, 99 insertions(+)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index f1d889d03e..44de6d3c1f 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -126,6 +126,33 @@ values are not used.
 Blank values signal to ignore all previous values, allowing a reset of
 the list from broader config scenarios.
 
+remote.<name>.negotiationInclude::
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
+as for `--negotiation-restrict`.
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
index decc7f6abd..c475932602 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -91,6 +91,10 @@ is the same as for `--negotiation-restrict`.
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
index ef50e2fbe9..827438cf98 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1626,6 +1626,16 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 		else
 			warning(_("ignoring %s because the protocol does not support it"),
 				"--negotiation-include");
+	} else if (remote->negotiation_include.nr) {
+		if (transport->smart_options) {
+			transport->smart_options->negotiation_include = &remote->negotiation_include;
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
index 166a56408a..15f3f12184 100644
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
@@ -570,6 +572,12 @@ static int handle_config(const char *key, const char *value,
 			string_list_clear(&remote->negotiation_restrict, 0);
 		else
 			string_list_append(&remote->negotiation_restrict, value);
+	} else if (!strcmp(subkey, "negotiationinclude")) {
+		/* reset list on empty value. */
+		if (!value || !*value)
+			string_list_clear(&remote->negotiation_include, 0);
+		else
+			string_list_append(&remote->negotiation_include, value);
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
index 4316f8d4ea..db73ed5379 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1577,6 +1577,55 @@ test_expect_success '--negotiation-include avoids duplicates with negotiator' '
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
+		--negotiation-restrict=alpha_1 \
+		origin alpha_s beta_s &&
+
+	ALPHA_1=$(git -C client rev-parse alpha_1) &&
+	test_grep "fetch> have $ALPHA_1" trace &&
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
 test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
 	git init df-conflict &&
 	(
-- 
gitgitgadget

