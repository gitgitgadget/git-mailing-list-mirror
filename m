Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148D49250C
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207905; cv=none; b=CHxUnbQ0czHInYLFuVSrrbbap+KKhejr3Ob7FwIJCeMKRYGz1O35uxuUV9NLLp/T583mkA0Wn5gMBw8olItf73sMiIi0uSy8XQTP/5SevcEQy1b5n9ElorHBjt/38B85D6H+KKEZlU/bg1JC8Ym/lDburl6oG++i+VtW+efihus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207905; c=relaxed/simple;
	bh=yGtqmSL5cb32k5kin+ONn3DRevoT89RcXOPnR1Z7em4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SilzF+re/fcMbognj6Vbw/EdB4GtZEYfH4QtdhFdiPgPGItpDhJtUUb+ykBylBvd0vgljL1JRf9NAqpATyjZ2qsAzI29znsnQDzcqm5CT8gAC+K51hjM0fx1/baaDlS0aAgQenn9dIw8kFJcUUIEORl0UAUNjb4mS+jmPA5aXIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV3uv9oQ; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV3uv9oQ"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c19d23b19so5166306c88.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779207903; x=1779812703; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZR1SYPchHaQeg/SLUPcNdH0hE7j2wONhTNb712vYKc=;
        b=QV3uv9oQAv7lvQUIOrPvUL7TI94+AnOTGCW49MZMIuezeubNiQwncg7swtCRitp7oj
         nYo+g9CitRH6iTulMKQuBoY8o2ybcfTYi1JRjJ9ZiVpp10h0eh9R1It9R9w7VuAyESBc
         D0/MC+9FERsyDcZ0V988QwdOGVct+IsdtmvNnRrl2unmc1oEPAo5LrDZ5ohOOdQVpwgd
         Feu7By2zQX6aO3XTQvILcIIBaHIEx86KpjEB6OO3jhHAXGCw0P8TdA82Wac7SfjNJByI
         xqvve61jWGkKRtD2BQrhJpdJFAjxf3Sb+SiORv/hvpidGssChgKpwdNX5mksZG9bVeC9
         NiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207903; x=1779812703;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZR1SYPchHaQeg/SLUPcNdH0hE7j2wONhTNb712vYKc=;
        b=il9Shs9J1xAH/y0U/iMC7d+YDehH11t7P8rBtNMHa3kZFe/Axvz1NJSMyEur5ha44B
         lVdzNI+gtbZqU3UXG8Sab7pWdVh65I5R0AA52WQ6LI2aXxCInGJkyzWooi4+bA9l6Pfm
         ppA9wOwMODdfDHsll5XOzFcwgCe8sAmUrerryQOnYtffSCg7CdPHb1aXc6AZoHT67wvV
         qXCGfJUux389gYvCLXdf7iRhKrdVj1RbRT6qAfnRPPj7HVLyX/KM6B0j+l3JICz1DTSn
         AA7lSoiGyCo6G+NL8p3xGgWaYMa1X/3kmeddTI3HY33X1WqXWiOYv780pZV04HBp+/B6
         4t/Q==
X-Gm-Message-State: AOJu0YzAkn4HOltfIW1UKANrvzjW3a1nqPWTJ+JEjwg6JJCvNyu80HZj
	+lfAOM7Y+CuGXOAOQ4J+V20uoPuk0BPktSuExFHmPXkpou8sqz0DIOLjvfj2ww==
X-Gm-Gg: Acq92OG8q7xDfd10Ou5+LVkFo+hh5U+tvJyI5d01tEdm/AVHDxLLqsKeiTTyuHJpYfU
	TBRolYR2scMosJMELtW44NH/WRp0WVlRTfCR3SP3cCXmcZZJnwpSs2vojC1yAMadY0yjo11grkE
	xvO1zVYIi8XiJy9DdUtqjAWq7SKtWnuHkmOoZLOepS/F+rIBBGTLZXCyAXIODJnQjYd0dKriJH1
	e45o5i1pxat9PRVjLf32iM98v20UIomynwbNugHSmapRT7wISdRUyFwjQ1e51ttA1GtbOM9+TYx
	3QB9fea/VDFv0iCOXQfa/Z2u+iTSO9Yk46685n8018zfvG54am8ROMZTh9cIXwifn8WIyJkG9Qm
	q3SesGyKdvkVy2timbadf/5WHi7CiTjyiRJsAAndEsNNKYzOwCS+6JY9QzVyLTZE/h1mzticKpn
	wJBR/hKuT3m9mIuBu/RMZl5+WKLyKJ
X-Received: by 2002:a05:7300:7490:b0:2f5:5907:3a48 with SMTP id 5a478bee46e88-30398285d3bmr9326349eec.1.1779207903111;
        Tue, 19 May 2026 09:25:03 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978ad18asm16338535eec.26.2026.05.19.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:25:02 -0700 (PDT)
Message-Id: <eec0f90e02b8f1f8b972c1dda506122ef8530088.1779207896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
References: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
	<pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 May 2026 16:24:51 +0000
Subject: [PATCH v6 4/8] remote: add remote.*.negotiationRestrict config
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

Reviewed-by: Matthew John Cheetham <mjcheetham@outlook.com>
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

