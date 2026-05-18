Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05CD36215A
	for <git@vger.kernel.org>; Mon, 18 May 2026 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135585; cv=none; b=gO+aLZ4lOO+BJ1uhAe7+DFrpjl8uA437gmkrNh8NuOf64F9s9tVhmUV1C0MgbCiSDFfQBKjbVSiEMe2PaeQdWc35Y6yB3acaNKZqwghw5N4vk/HUaclo9Xa9xY3RBp323yUl9s5LGJmENYi4RdFyJ8LYPT5m5g71hkSihQYzr9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135585; c=relaxed/simple;
	bh=d90a4KK5hpa0tEuSAWbCpZ8A9YZgjW9ILUgl3PDDHak=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Vcq9Wh2hC5T2JBXEGN0q15lxsNdAqkc8tu/oTP7Mms+eYFxiS2a3u7fC6qSut2btVIrphAcNe4SxRDZvWUM5PExMGAbesf5dt5EytlMrY+cbqWLKaFXWy80ymFZUEDu5wJGBVoTAq3QKP98+jVsTolfF95LumvCtW4Nl/1BVBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faUZubBA; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faUZubBA"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-911501a99feso367334385a.2
        for <git@vger.kernel.org>; Mon, 18 May 2026 13:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135583; x=1779740383; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o70Gh+DEWYTqmsOH6w1YFYNHBto3wmlNBtpTlqE7Cfk=;
        b=faUZubBALt7GajKyYTWaWd3IBrcj8F4zDYVrPTURY6L1q7pbf1h1Nh3nZ6jJ4dBohD
         4ojVhvSTfMp7p2+UgALl38HIQKc7qVMu+1D0sQVbp0KleK8DE1nvMjwB+/6am9yUR+mq
         olf0+IcmabilVLqhzQyLC+X2L0WQwSMBwprTf9vD2gHvGawGflGx7fGpRx4US2M7VA/7
         C7tWIZV31N3oj2Wz/wwxyz4oc21oFthpcajXRX/9Fi9XfHhYrrKG4DlALe3I5oXd88mx
         sfIYH/sJmMsGWSzNHAavYcgtb67XHeLUhpoudOVExoI4vxiQJEaEYraSt3v9dwHDIQjF
         Q6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135583; x=1779740383;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o70Gh+DEWYTqmsOH6w1YFYNHBto3wmlNBtpTlqE7Cfk=;
        b=jfi2yQuQO1KGUuZqzBok59PS7LhfA1dNzUgVM2F10Uu+Ip9x2ZORaZxsMT+5EVFURh
         O8SzQu680ch5aUhQPu0LJzoDbPWgA7uS4tIg7GM8DF0p15ufSP485JLVHMDqmjf2Lc43
         Z9bbj93cPfE6LIprRlsAGO8//ODIDR8cLkt3uj58P5ptK/f+VQCQ88GHcBq/5iEt/R9t
         Dx1tFBqlMfuQkJQAr0xkyaiCp0Umf+3FWX5pI2iaTHcZc8iDD3nyZC/mjzNP25/j9hbs
         l+zcLgdbj7dZ8DLfFLYZsSfX/+vi9hdDAusC1txupn1mYK2WZ+77ceHc62qZKeqrYGDr
         6u9A==
X-Gm-Message-State: AOJu0YytwSEW1OUbKm1MqWj2dZus9BfiOM7YVONDa93Qy/+LmV8mRPeS
	vNOVcdgqubbcrFbchWEgtA8PCppKYJhJYpI9b5UXAMhN8hGOiP19nBsjV6X+bA==
X-Gm-Gg: Acq92OHR5uoKs2pZU7vOdUCKm6y+9j5u7M/9PbqZKrF7a2bL3gkl2W08uue3ZM/OTCN
	sx667/GeMseUKRlfL/a+fUNE1hfESy7syQU5Ixiq8ljHOvmsDATgYFjwld0aF2IxMBhqIs0ojtS
	MS1UAy9RCu0r/hfzRdmwnumoOh1xUQM6au3W6Vyqz89NZa0cnyCIml1MGJHahrZpk/HtlKXdgjO
	N5pq7klWpkQIoDgVUJbFK37FHzJ5VhUU3Ud3J1X8IIIBaCvoBJ15OXaVA5bpzzHOhT0jyRdq0yA
	oE08Ky+MGYOhKelujYpia4rPIZgyNAGAmL0hwYSXMppKIJhWNLSPof+2r+g5+FCxyEWNORNIJzY
	yyCfV1MZpDuk7tMXTZ2uGBlLU9y9iRHbx+RkxSULUTz0s1f3q9QS7eLNW/lsGb2QkqXSipqR9Bd
	OoDMy7bUQd/EGQeOJsawzsgiNM
X-Received: by 2002:a05:620a:318b:b0:8ed:b41c:f864 with SMTP id af79cd13be357-911cf9e1395mr2444057085a.28.1779135582549;
        Mon, 18 May 2026 13:19:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83bbf5sm1609853385a.28.2026.05.18.13.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:19:41 -0700 (PDT)
Message-Id: <63c675e93e99cb7d24ea87c91e2682c6429a6740.1779135575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
References: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
	<pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 May 2026 20:19:30 +0000
Subject: [PATCH v5 4/8] remote: add remote.*.negotiationRestrict config
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

In a previous change, the --negotiation-restrict command-line option of 'git
fetch' was added as a synonym of --negotiation-tip. Both of these options
restrict the set of 'haves' the client can send as part of negotiation.

This was previously not available via a configuration option. Add a new
'remote.<name>.negotiationRestrict' multi-valued config option that updates
'git fetch <name>' to use these restrictions by default.

If the user provides even one --negotiation-restrict argument, then the
config is ignored.

An empty value resets the value list to allow ignoring earlier config
values, such as those that might be set in system or global config.

Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/remote.adoc | 18 ++++++++++++++++++
 builtin/fetch.c                  | 28 +++++++++++++++++++++-------
 remote.c                         |  5 +++++
 remote.h                         |  1 +
 t/t5510-fetch.sh                 | 26 ++++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 91e46f66f5..4dcf81fbce 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -107,6 +107,24 @@ priority configuration file (e.g. `.git/config` in a repository) to clear
 the values inherited from a lower priority configuration files (e.g.
 `$HOME/.gitconfig`).
 
+remote.<name>.negotiationRestrict::
+	When negotiating with this remote during `git fetch`, restrict the
+	commits advertised as "have" lines to only those reachable from refs
+	matching the given patterns.  This multi-valued config option behaves
+	like `--negotiation-restrict` on the command line.
++
+Each value is either an exact ref name (e.g. `refs/heads/release`) or a
+glob pattern (e.g. `refs/heads/release/*`).  The pattern syntax is the
+same as for `--negotiation-restrict`.
++
+These config values are used as defaults for the `--negotiation-restrict`
+command-line option.  If `--negotiation-restrict` (or its synonym
+`--negotiation-tip`) is specified on the command line, then the config
+values are not used.
++
+Blank values signal to ignore all previous values, allowing a reset of
+the list from broader config scenarios.
+
 remote.<name>.followRemoteHEAD::
 	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
 	when fetching using the configured refspecs of a remote.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2ba0051d52..a957739f37 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1601,6 +1601,19 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 		else
 			warning(_("ignoring %s because the protocol does not support it"),
 				"--negotiation-restrict");
+	} else if (remote->negotiation_restrict.nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, &remote->negotiation_restrict)
+			string_list_append(&negotiation_restrict, item->string);
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
@@ -2658,10 +2671,6 @@ int cmd_fetch(int argc,
 		config.display_format = DISPLAY_FORMAT_PORCELAIN;
 	}
 
-	if (negotiate_only && !negotiation_restrict.nr)
-		die(_("%s needs one or more %s"), "--negotiate-only",
-		    "--negotiation-restrict=*");
-
 	if (deepen_relative) {
 		if (deepen_relative < 0)
 			die(_("negative depth in --deepen is not supported"));
@@ -2749,14 +2758,19 @@ int cmd_fetch(int argc,
 		if (!remote)
 			die(_("must supply remote when using --negotiate-only"));
 		gtransport = prepare_transport(remote, 1, &filter_options);
-		if (gtransport->smart_options) {
-			gtransport->smart_options->acked_commits = &acked_commits;
-		} else {
+
+		if (!gtransport->smart_options) {
 			warning(_("protocol does not support --negotiate-only, exiting"));
 			result = 1;
 			trace2_region_leave("fetch", "negotiate-only", the_repository);
 			goto cleanup;
 		}
+		if (!gtransport->smart_options->negotiation_restrict_tips)
+			die(_("%s needs one or more %s"), "--negotiate-only",
+			    "--negotiation-restrict=*");
+
+		gtransport->smart_options->acked_commits = &acked_commits;
+
 		if (server_options.nr)
 			gtransport->server_options = &server_options;
 		result = transport_fetch_refs(gtransport, NULL);
diff --git a/remote.c b/remote.c
index 7ca2a6501b..620086e16e 100644
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
@@ -562,6 +564,9 @@ static int handle_config(const char *key, const char *value,
 	} else if (!strcmp(subkey, "serveroption")) {
 		return parse_transport_option(key, value,
 					      &remote->server_options);
+	} else if (!strcmp(subkey, "negotiationrestrict")) {
+		return parse_transport_option(key, value,
+					      &remote->negotiation_restrict);
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
index dc3ce56d84..eff3ce8e2d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1485,6 +1485,32 @@ test_expect_success '--negotiation-restrict and --negotiation-tip can be mixed'
 	check_negotiation_tip
 '
 
+test_expect_success 'remote.<name>.negotiationRestrict used as default' '
+	setup_negotiation_tip server server 0 &&
+
+	# test the reset of the list on an empty value
+	git -C client config --add remote.origin.negotiationRestrict alpha_2 &&
+	git -C client config --add remote.origin.negotiationRestrict "" &&
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

