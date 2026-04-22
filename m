Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD165349AF3
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871560; cv=none; b=GdCXxFO/wRyL+nQS5W7pFuMNMw8cSY6Q6aQH44pHuCiSnai53imhXkT2Tnjo/BriwZJDsBhGhm6smRDNTN4F1EQFt3SA6VHS+yVbQOuWwU/SNGiWO/cVoIjxc1cmIwYJaK4moLb9q6gDWpFrYIctLJZAWnUn3nVoGzt967vkI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871560; c=relaxed/simple;
	bh=vt+XRTrNJn6sThBAiwo+8fhVrBUEVRKP80CvnNxfj/o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C1qqImkJayjzeQz9sLTnT1KOfNEy9W3SHWD5Eq87ieIc5P0fDgNV+HPryGytKHUuby0EcGzEf1ee0Kc55aK6RZYK7Yun+HY29FmA+4u2VP34ThGTFv0nZsv2BKcf0kvr2+2RDhANwyOF8KICvvntCa6cljonx8h7F4cl3N5P2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akal3jVM; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akal3jVM"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c6df0b9bbso4479531c88.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871555; x=1777476355; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJ6C+Sfr7O62xMMSpZ97+mGq6gqDcZGPn8WdFIuK8bQ=;
        b=akal3jVMCj4d5b17R2/ioJpcq/+q+k8Z41VEaj6DDwyceQhN7s5WD6bFjcYIa5To4F
         zbD+EJnx/VQkQt46H0N5V1PvdJYR4/QT258Dh7MHP4ycJ7YQ6YKk592c4RSj/Wwx0Ffl
         BGJMlSeOW+ohIcXbjFhTzp3TsVFoff5KzA8D9qyCQoh7EuewZQj1y0FYyxfdQQZrQAxK
         zkPfzbFwKQ1hNexkD8IjruiV2m5tHCF3V935nvPmpdZ+3Mfhy/yETGQ4+O5mugnTQAZz
         APO5vkWnsZ3LsTiCH54R17JNU2SUP8wYMMtZy/v7OG62O76XHCqM5f2+729R9cU5FLWE
         +ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871555; x=1777476355;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJ6C+Sfr7O62xMMSpZ97+mGq6gqDcZGPn8WdFIuK8bQ=;
        b=A7LghE7F1CPwGcorcSFyfDkI1+k0K2Xvgu8rT0Vax14VatWGdeJCNYWI4t0qZ/5wNZ
         MjCEJTnv45lUdDgk3p+Eb0vVrtVKFURSF5rMBDVo+r3Es+Uf+INTD4Itmr1OqlN2cO1U
         9yoGQTIJBynnQpc4Bmjkj2Kuzfx6kSOnwb8/T50rYxokHALYL5Rxe6+fDfbkBDEZSNM1
         kxQXB7VahyoPctPqiAp3vnJx7Y7dL646oKNnmd/5yLxHyLdXQ1NonYK2etlx0HAblgLX
         xRd0MGPhe7AYDDUjYab20kV5DUxXMRFjN0vUzaJWc7IFAZrXj05m4oc/5rAkHOH+SX5g
         bh3Q==
X-Gm-Message-State: AOJu0YyO+/Dp62+qKpwojL3wrCZwTeMTQjJaB2iwNfdfYH2EJ309pxzU
	bej9uHyLXLfBt0eisul79cJQIRqAzr9Pi4fvq9voUvNOji90SWNr0MMLOUqTXQ==
X-Gm-Gg: AeBDiesQIdAXRBfg+u2JUwtvU8p/Fwx7G4QjTAihBz6kz4hfE37ykQBeQe4ghLgh7c/
	3abXBgKGiHLRxWPgNbLMWHTNzQ3NVbQ+sZPjeNizLVtMbr9AGAY8AOBbo+GDoWGSg2SgH6/qhsj
	9bDe3QvzPjs/zHMuuJYupYK+hhhqViSfbLZwGpGXuo0liaQjzne2Du4CkeEFL2wLYZRTG2yXwqO
	IIQnWzVlDTbCluQlEjmPKzEF6100lM3Fyx6+GJkNXYQOdMVK7jZo20d7x22UKlFA3lZiaAl9U0B
	SDVOgjGm+QkfQ+YEp+SAzozcfAQB5Z2rNZHT/9K08VRMg/nZGmUm4BLXUsmlLeuN6uS+G7+dvIr
	ciDWyirBhKi0G0fLD1alFS256hB6kOYdaaVHmP+J0JpHqdDAmfoIj5JHf0revVAAKCs5E87Qtdd
	bE6VF8eyMNBlVifADJYGS5pGoMQoEkEj8jI8h4NA==
X-Received: by 2002:a05:693c:2a10:b0:2e6:e916:7105 with SMTP id 5a478bee46e88-2e6e9167856mr7117765eec.13.1776871554968;
        Wed, 22 Apr 2026 08:25:54 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm23808069eec.28.2026.04.22.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:25:54 -0700 (PDT)
Message-Id: <d2f48b78b5b4c63269b1129865d94fdab9dffd92.1776871546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
	<pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Apr 2026 15:25:43 +0000
Subject: [PATCH v3 4/7] remote: add remote.*.negotiationRestrict config
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

An empty value resets the value list to allow ignoring earlier config
values, such as those that might be set in system or global config.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/remote.adoc | 19 +++++++++++++++++++
 builtin/fetch.c                  | 21 +++++++++++++++++----
 remote.c                         |  8 ++++++++
 remote.h                         |  1 +
 t/t5510-fetch.sh                 | 26 ++++++++++++++++++++++++++
 5 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 91e46f66f5..f1d889d03e 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -107,6 +107,25 @@ priority configuration file (e.g. `.git/config` in a repository) to clear
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
++
+Blank values signal to ignore all previous values, allowing a reset of
+the list from broader config scenarios.
+
 remote.<name>.followRemoteHEAD::
 	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
 	when fetching using the configured refspecs of a remote.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2ba0051d52..a1960e3e0c 100644
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
@@ -2749,6 +2758,10 @@ int cmd_fetch(int argc,
 		if (!remote)
 			die(_("must supply remote when using --negotiate-only"));
 		gtransport = prepare_transport(remote, 1, &filter_options);
+		if (!gtransport->smart_options ||
+		    !gtransport->smart_options->negotiation_restrict_tips)
+			die(_("%s needs one or more %s"), "--negotiate-only",
+			    "--negotiation-restrict=*");
 		if (gtransport->smart_options) {
 			gtransport->smart_options->acked_commits = &acked_commits;
 		} else {
diff --git a/remote.c b/remote.c
index 7ca2a6501b..166a56408a 100644
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
@@ -562,6 +564,12 @@ static int handle_config(const char *key, const char *value,
 	} else if (!strcmp(subkey, "serveroption")) {
 		return parse_transport_option(key, value,
 					      &remote->server_options);
+	} else if (!strcmp(subkey, "negotiationrestrict")) {
+		/* reset list on empty value. */
+		if (!value || !*value)
+			string_list_clear(&remote->negotiation_restrict, 0);
+		else
+			string_list_append(&remote->negotiation_restrict, value);
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

