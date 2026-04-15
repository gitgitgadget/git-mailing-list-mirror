Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E43D890B
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266075; cv=none; b=ShsgWO21Z+8j4uQwAGqNLieRWDglhls+BaPXbct1CiYnASZH/8Y+uBXvraBWaU9rHbKJYycpaS13fUr7cdhgEPnQRRdm3x5TMzkCbyd2w2cu38LwFgR+zwNbFmZb2B2V2ANfUJUKSIGj75iZ7OaQa2leA95fNOg9ur8zjD1VQZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266075; c=relaxed/simple;
	bh=fFCJXf3tM9Fmi3VMVP3AzLVyZCj6yTZ+pCDhoIflQmM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jS0HCqootj69mK9Kq/7QTg8qnNXrAyTx32xihBc8XD6bekrAfqnWpsBm6mNUgygS+MVMF8WcvfVeRRF9wK+YdaykBKYOUM0bJR3YF+5/TwPtE3gPr+J/VqArrBTq+l3M3dBGqq4RsLxGT1XtE8UY0HEJcGcPfOcZXHRmDzyowAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s59B11QR; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s59B11QR"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8a093c784b0so83570486d6.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776266073; x=1776870873; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eM5iBai/9m841mhqhbJd0CxFuSB1WFTVnFrZxUW7ts=;
        b=s59B11QR8N3ySivPYdaPv8CLYVV5XYXGBrh0/XJ432ruEwAjKNlJLLQepXNQmDzCL2
         qKior5wnT/M/ZGwkp9s/mXn4jlP67ckZoUrlr9o9mCYjsP4TpwxobkGr2bWkc6fJN1HG
         z266uPVp47wao7NZ4pJXw5bPBJdu5s6mlruaACcqaTPr0K+TXC4+3RSh4AjkzbuRqK9H
         WbrVAK4vBK/ho+lxlo2BV3EA7vckCl+cvBbUvX0SEJARqR7UXMOz6sLJnfmZTNscf0mU
         /MzNCCxhfiX9E6T8JWIdVlyb/yqHzeh8Sd0SbqReI5vCs3Wbnax8Lq7iuCm3LbPhNTvp
         oShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266073; x=1776870873;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9eM5iBai/9m841mhqhbJd0CxFuSB1WFTVnFrZxUW7ts=;
        b=Cm3BYjPMGAut7rs3Q9Ctx8/wO2Z1uOzbaMkM5cBe6d4gvA/zWLJYgtXX+xSj4qvFHa
         gJs3+OsclxAvA8qb4FGGH4mnYcSVMyHOOkFlghOyLdJrTRRSFHKmRhtFNaktwlZbvjwx
         DFKGNiPbAvfZ+7gEFcTXO1OxL+P7GakTHqQU4RdT1hS5EA7MgHzP7T/31kP7koILhaMb
         q/2TnxlUU5uM607clJ828LwvbiMXjdfqmx9UORel4DjnJ8NLxXKZgEt8LbTaMiCZYms8
         zP9RVP1P4p0160THDqb+OffqJbkCn1PJJRR++FV9NUo/8XEHsw8O0vsS7MjV/g44lunA
         u7WQ==
X-Gm-Message-State: AOJu0Yy8Ihs8IJ2tILh/deHEfewLfMBYMEoutDVsyhS+kujeqt3nHu+p
	jv6QRxSv596w7rthol4ag/VEYsSLjLH+YE78YG20o8D3Su4d1UbGeg1/PZF79A==
X-Gm-Gg: AeBDiesH/BJcXPSNN4H2REHNZ5k8AfHj5Mqf5gnpUWgK6o1N1N1z865OvPxPgwOCK9h
	VvmzPjV10GoAqg80+4Q+OJ3sFdFYa30eMvLNts3k2dL4j4VvSTK7LjWHrEtXfY0RUhULCySWaKM
	xEGAE94WBlZ2ah+tDmYTc7tyJ8OkQuE1hfXfG8T9eltkcWsCaG06saas1xXf/xaBNdZ9Rct4+Ds
	HR0Ln/1J2E5KYs7GM2vWw8PGa55VhGL+PJwuoRAwFIGRUr9OwFhXXBlw8FGErtqelL78eu74pA2
	1YUwmjfum+CAqNcHoNYJmWEdCJ6tcVsa4Rqu7oUcDZrd7LNykfR1iQ0ijxGP9epXBzzwsw/YG+Y
	gjltOGn58JgQJrLCaFLBuCCVVnInn5Lf+s0ATHqBIfV4n5EWa9K3nLhNnSH/w3WXh6R31eLNbzZ
	cCjPSuuMxEyg8gLrAdL2+xr3yy7fnr0o2sx/A=
X-Received: by 2002:a05:6214:6112:b0:89c:4cac:74c5 with SMTP id 6a1803df08f44-8ac862814dcmr276207166d6.25.1776266072514;
        Wed, 15 Apr 2026 08:14:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.13.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6ceb4a5fsm16849026d6.45.2026.04.15.08.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:14:31 -0700 (PDT)
Message-Id: <a731f4fc87ebee71d970d4fcaa36e8d991847984.1776266066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
	<pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 15:14:23 +0000
Subject: [PATCH v2 4/7] remote: add remote.*.negotiationRestrict config
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

In a previous change, the --negotiation-restrict command-line option of
'git fetch' was added as a synonym of --negotiation-tips. Both of these
options restrict the set of 'haves' the client can send as part of
negotiation.

This was previously not available via a configuration option. Add a new
'remote.<name>.negotiationRestrict' multi-valued config option that
updates 'git fetch <name>' to use these restrictions by default.

If the user provides even one --negotiation-restrict argument, then the
config is ignored.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/remote.adoc | 16 ++++++++++++++++
 builtin/fetch.c                  | 24 ++++++++++++++++++++++--
 remote.c                         |  6 ++++++
 remote.h                         |  1 +
 t/t5510-fetch.sh                 | 22 ++++++++++++++++++++++
 5 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 91e46f66f5..5e8ac6cfdd 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -107,6 +107,22 @@ priority configuration file (e.g. `.git/config` in a repository) to clear
 the values inherited from a lower priority configuration files (e.g.
 `$HOME/.gitconfig`).
 
+remote.<name>.negotiationRestrict::
+	When negotiating with this remote during `git fetch` and `git push`,
+	restrict the commits advertised as "have" lines to only those
+	reachable from refs matching the given patterns.  This multi-valued
+	config option behaves like `--negotiation-restrict` on the command
+	line.
++
+Each value is either an exact ref name (e.g. `refs/heads/release`) or a
+glob pattern (e.g. `refs/heads/release/*`).  The pattern syntax is the
+same as for `--negotiation-restrict`.
++
+These config values are used as defaults for the `--negotiation-restrict`
+command-line option.  If `--negotiation-restrict` (or its synonym
+`--negotiation-tip`) is specified on the command line, then the config
+values are not used.
+
 remote.<name>.followRemoteHEAD::
 	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
 	when fetching using the configured refspecs of a remote.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4c3c5f2faa..57b2b667ff 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1601,6 +1601,19 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 		else
 			warning(_("ignoring %s because the protocol does not support it"),
 				"--negotiation-restrict");
+	} else if (remote->negotiation_restrict.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &remote->negotiation_restrict)
+			string_list_append(&negotiation_tip, item->string);
+		if (transport->smart_options)
+			add_negotiation_restrict_tips(transport->smart_options);
+		else {
+			struct strbuf config_name = STRBUF_INIT;
+			strbuf_addf(&config_name, "remote.%s.negotiationRestrict", remote->name);
+			warning(_("ignoring %s because the protocol does not support it"),
+				config_name.buf);
+			strbuf_release(&config_name);
+		}
 	}
 	return transport;
 }
@@ -2659,8 +2672,12 @@ int cmd_fetch(int argc,
 		config.display_format = DISPLAY_FORMAT_PORCELAIN;
 	}
 
-	if (negotiate_only && !negotiation_tip.nr)
-		die(_("--negotiate-only needs one or more --negotiation-restrict=*"));
+	if (negotiate_only && !negotiation_tip.nr) {
+		/*
+		 * Defer this check: remote.<name>.negotiationRestrict may
+		 * provide defaults in prepare_transport().
+		 */
+	}
 
 	if (deepen_relative) {
 		if (deepen_relative < 0)
@@ -2749,6 +2766,9 @@ int cmd_fetch(int argc,
 		if (!remote)
 			die(_("must supply remote when using --negotiate-only"));
 		gtransport = prepare_transport(remote, 1, &filter_options);
+		if (!gtransport->smart_options ||
+		    !gtransport->smart_options->negotiation_restrict_tips)
+			die(_("--negotiate-only needs one or more --negotiation-restrict=*"));
 		if (gtransport->smart_options) {
 			gtransport->smart_options->acked_commits = &acked_commits;
 		} else {
diff --git a/remote.c b/remote.c
index 7ca2a6501b..07cdf6434d 100644
--- a/remote.c
+++ b/remote.c
@@ -152,6 +152,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	refspec_init_push(&ret->push);
 	refspec_init_fetch(&ret->fetch);
 	string_list_init_dup(&ret->server_options);
+	string_list_init_dup(&ret->negotiation_restrict);
 
 	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
 		   remote_state->remotes_alloc);
@@ -179,6 +180,7 @@ static void remote_clear(struct remote *remote)
 	FREE_AND_NULL(remote->http_proxy);
 	FREE_AND_NULL(remote->http_proxy_authmethod);
 	string_list_clear(&remote->server_options, 0);
+	string_list_clear(&remote->negotiation_restrict, 0);
 }
 
 static void add_merge(struct branch *branch, const char *name)
@@ -562,6 +564,10 @@ static int handle_config(const char *key, const char *value,
 	} else if (!strcmp(subkey, "serveroption")) {
 		return parse_transport_option(key, value,
 					      &remote->server_options);
+	} else if (!strcmp(subkey, "negotiationrestrict")) {
+		if (!value)
+			return config_error_nonbool(key);
+		string_list_append(&remote->negotiation_restrict, value);
 	} else if (!strcmp(subkey, "followremotehead")) {
 		const char *no_warn_branch;
 		if (!strcmp(value, "never"))
diff --git a/remote.h b/remote.h
index fc052945ee..e6ec37c393 100644
--- a/remote.h
+++ b/remote.h
@@ -117,6 +117,7 @@ struct remote {
 	char *http_proxy_authmethod;
 
 	struct string_list server_options;
+	struct string_list negotiation_restrict;
 
 	enum follow_remote_head_settings follow_remote_head;
 	const char *no_warn_branch;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index dc3ce56d84..0d87494794 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1485,6 +1485,28 @@ test_expect_success '--negotiation-restrict and --negotiation-tip can be mixed'
 	check_negotiation_tip
 '
 
+test_expect_success 'remote.<name>.negotiationRestrict used as default' '
+	setup_negotiation_tip server server 0 &&
+	git -C client config --add remote.origin.negotiationRestrict alpha_1 &&
+	git -C client config --add remote.origin.negotiationRestrict beta_1 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		origin alpha_s beta_s &&
+	check_negotiation_tip
+'
+
+test_expect_success 'CLI --negotiation-restrict overrides remote config' '
+	setup_negotiation_tip server server 0 &&
+	git -C client config --add remote.origin.negotiationRestrict alpha_1 &&
+	git -C client config --add remote.origin.negotiationRestrict beta_1 &&
+	ALPHA_1=$(git -C client rev-parse alpha_1) &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		origin alpha_s beta_s &&
+	test_grep "fetch> have $ALPHA_1" trace &&
+	BETA_1=$(git -C client rev-parse beta_1) &&
+	test_grep ! "fetch> have $BETA_1" trace
+'
+
 test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
 	git init df-conflict &&
 	(
-- 
gitgitgadget

