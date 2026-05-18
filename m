Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A516378822
	for <git@vger.kernel.org>; Mon, 18 May 2026 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135589; cv=none; b=Nu6mDr3KkVU21UcX2liAUUIrr8BlNRRGwLXI3gX25g/MLaE6CCYcP874qe3G9Z08unqspUOYQ3v3bZ/JAt7X0dL/mBDxKwUarK8uDTlwE0xtNz+p9dTNQ9WZhy08MAsn93r1o4xctveh0eiOiQNW6brJJLI/Vvladl/0z2EfmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135589; c=relaxed/simple;
	bh=x8vaxFYHSAHXbabvpkxB9i9+LIiFv5UvnXifLaV2vrw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TagRuXVu/MVGLkg1wNTCor5i/LexJU2bFU7rnUAneHA3T6ozc5ZXYRzkSW1O6w3LinVgfrO3tgVPa7Z6Ugm4BwQo2x4dk7IyrIG+sJ0dxu0qUpJp1ijlMaVPJ4KHy49xo+hCDkENP81FLblhkMoWfqceYESx25x8ZfUxAdcYSE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3iifSAr; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3iifSAr"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50d87610513so36044781cf.3
        for <git@vger.kernel.org>; Mon, 18 May 2026 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135587; x=1779740387; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpeSuSLmHk3UwR1YPOFErOLLgObFG3hQ9V81ODE7im0=;
        b=Y3iifSArQNIwN7OkQOvj/+xMLYBDmu0TavDEylCV520B34NX6MSj6i2rqzzK5XtMro
         DkaPnMcMsQHjKGLLyk2aNXJV7JrpHMfU9FrNnPxze36K8tXDJzaTxf2WQ5gt9Ei1rSRo
         tYwnFXqT48tH4zIaylq+NBFNzZZKFDaOjzS7jOoRj1LtDzthEyhHVcZ6wAuolH6KXlCS
         AIEi7NS7PCP94EvnRDTqsYXPwZ08h7kWd16JMyArWe08Jxjm2F5ifmvh2ITZEAKTCcpj
         Odka8WYaMhfVuM1qUf939vAt3G37pL+ueoI6m1SRQGg/aMF3FCQRCCKZtt+z8YIFl00J
         J7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135587; x=1779740387;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UpeSuSLmHk3UwR1YPOFErOLLgObFG3hQ9V81ODE7im0=;
        b=LnbP5UdJw3IRPFmFyojHa1R+pDBSxFkVnoksLRowUApXVHxyVOddzicqjXLYIFUeM4
         w9T6uqX/apAQ3rBXDGBbL+m5NL2YlVBfBGQXyX0i22SxPdc+gmCol7h5Ip2hxIAfZdUd
         +6cfe52NFsq5hAzzsnVK7wTRC1WbNAIGknzDX5xbo0YNDXbzUDXJF7lW6qhYHZoYAxaZ
         DvpdwhH2QsbyyNrIz5pD47sLWxEJgIpFbZx6UFvooWDDXgGR1fgm/eZV0prFWPlV+TiX
         7E10aMdZMxcCLmfFkXCXnJ3WlpKOXYLQA26JfWzhjVdcuiGYVm6+CWWgSMMt+4JImZTm
         vzJg==
X-Gm-Message-State: AOJu0Yz1L17tESMc8o6U0fpF/x7JWsayr+6OYdpWKf3hqFC98ckC2ihD
	Rvi4Yvpn+MI/puZVc+peSTanbqMeomI2xOOb9lTxBUEXmv8tVYzL4pVRpTdg0g==
X-Gm-Gg: Acq92OE0wR6fGZBdMhWVr/4VYhl1Zg2otEAB2oAVsJWkXL+WSsdj0gPjMtuo1dH8ZAs
	d2JyqlARe3xKDxLkAPnvjXe7s64MGxITIZjz3paAeynQg2dSZA+4LCEYPAP96BWy77DkUT6xVN/
	ZvJwdf6V2SbYgEurWxtFJreUS1PXcY5PFEXeTtUbouuW60F2e9SfpwpgS/sGYi0BLD8ER0ohtvg
	a1g/I4SZre6D5MjjXrLpAi/u1A4ZVFBrS8HHBCVQJMEPwga9pxLCoqr2f1+rj164A0MGf7ziXZa
	eaJ8kBZZBeoyM/OOtKhhcQAvlguw5fDHovyHyRyeOxbl+47XkyYMz+pdQeLzrJpPClicpLr4caF
	ZQKqO3Cx/JZ+ciyjpCuJ0ahiIwf9orxYQxUnLxQYONHKusnhSOccfTYFlhU5hFvP+xCNexsYCsq
	clHgun5VSIw8rT6GjmfBiyqDU5
X-Received: by 2002:a05:622a:aa4a:20b0:516:41f1:9203 with SMTP id d75a77b69052e-5165a1e530amr166800651cf.38.1779135586811;
        Mon, 18 May 2026 13:19:46 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516a6c61fc4sm2684591cf.9.2026.05.18.13.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:19:46 -0700 (PDT)
Message-Id: <e5714115b5e1f325dd185b327423d2cfb6f1d53f.1779135575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
References: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
	<pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 May 2026 20:19:33 +0000
Subject: [PATCH v5 7/8] remote: add remote.*.negotiationInclude config
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

Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/remote.adoc | 25 ++++++++++++++++
 Documentation/fetch-options.adoc |  4 +++
 builtin/fetch.c                  | 12 ++++++++
 remote.c                         |  5 ++++
 remote.h                         |  1 +
 t/t5510-fetch.sh                 | 49 ++++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 4dcf81fbce..1951df154e 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -125,6 +125,31 @@ values are not used.
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
+unconditionally on top of those heuristically selected commits.
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
index ba56e9022b..1af6500c1d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1634,6 +1634,18 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 		else
 			warning(_("ignoring %s because the protocol does not support it"),
 				"--negotiation-include");
+	} else if (remote->negotiation_include.nr) {
+		if (transport->smart_options) {
+			add_negotiation_tips(&remote->negotiation_include,
+					     &transport->smart_options->negotiation_include_tips,
+					     "--negotiation-include");
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

