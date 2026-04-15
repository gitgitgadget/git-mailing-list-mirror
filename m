Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC183D88F6
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266078; cv=none; b=LuKKgg5puZ5dZPmU6k8A2A+pcR9/KHEuvXWnkUr0XW/yuA+ww0r79PM0HAWBjgnQrov+FChxp0jhRFUkQfJAKZPYHUFJJd+rc9HTgH4mVcIKFAU+QESXVjSQbfoA9EG000WKD63ODg6G7FFoXgSLOnqMK7DOa/uzbZnHxHZFb0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266078; c=relaxed/simple;
	bh=K+W5NLhuEYKPyXBVteZ+iKuZMPYXuXldQGsoTkNDgrE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RFjkuPX7HeHd79CeFlBhy+n9IR8n0akPo+R5PYbc2rRkmvgvs0K5RQilhaitLo1FzJEc0+tvDCXUAFbfRcvQS5wQXQjXdMqg6bOCr20vZyniZSgETDDEeg70pmLECybsQcbfocfyZxJ+iwpWOuwy+aQVt8rOYgyg6BbJtV+pmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0nvFY26; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0nvFY26"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50baafd6c4aso71256691cf.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776266075; x=1776870875; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pbMJkd339txn0qb211JtAM8y9yvMJAIxWM5hnCVhBc=;
        b=m0nvFY26uSrEcvKHATSzA8ioYCe+3ErGc3IE+tq1Sb3IhAYvOVrEPL+wtgc6HZOXUU
         vK09yyp0ItthtS+oWzds7gfHtM5eMvT1AEUVALZwtbKBIMOtQ8rdZ5DdCJ+pR9uOK5Nl
         pOHe4BVAl5EMSn410SjHrRo2TEc63DZXAMVTM8wkeATRGQAKXfuyOkYzYJPD0l8upwQM
         48y2znGCEi5BCueUkCFQWNprJpsFnLbqCfq0FkkdnNt2i1mdouM3iGApmrXnvdxzruyN
         y8XmCJ+aHvu8woUM12JOfhWX/MrbuffZsxi6iHfYNk2CAoBPrSAD76LmJ/ezpSjH0/ry
         3OZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776266076; x=1776870876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0pbMJkd339txn0qb211JtAM8y9yvMJAIxWM5hnCVhBc=;
        b=TNY+uhMJEPQSO9FGQihI6ASkc7OBCp42hqfh/WB/Z+9feicY6YwJ1WlbO7Y4DOMMIi
         F1c7w3iRWhP5K3V28VAuB3tby3oEOKLRJggN0FP0sA2gClfWKbGVVWWyZDnYUlQVeVIm
         m2mMR55OOQgBxNKlPT179IAQxH3mk2GnK7kdo86VXG8tSie1r8U58+mRPqXD8k2OCN+4
         jTvcfR6vujPdmSjATgHzvMe2UoWkp7J8h3IeI2nM46vz8Dcm7+iEvDP9IIUmoGOFyhio
         17BuPbXp1l4GXNwjJsgE2TkxKZPsqcEwJP4WZHgRPOphZNpxvZ/ppwTR0OKb2mc7o83O
         KKKw==
X-Gm-Message-State: AOJu0Ywx6uhxkS/Sta2v/rui+glslF4SS0CBYd+/U89gU4G2PrTN8dTu
	c89sGTJfYopiUiWquduTTMpbEGCf6/JYsX6qB0xPEQI+abTe/jkQBOPwhOwydg==
X-Gm-Gg: AeBDietpaix0wayvwHG0ByoUQztGkU4PwyYOQ1360wfkX2n9F3guQG8HcsVcc9BDJ3S
	7dOe/zcFun8r2u5D0vs0jx3n4EI2/9wQkIRbHmStQGNO2kzjxl/nvfG8SCjtNcE5wkNf+KbS3QZ
	iA4ByXXWUiiyWeevLbsCpBrM6QpqTcCluBtvat4cZFxO3FRTj06GqXK1WtvkmWTMjE1ZRcRLAI4
	ZCqnTyfKgW8eboM81kwKLlhG8GlaTQfFalyXnmCoc9pWogX1+7L6/ZtIOVb3PJ1tIG5dZJu+Z/S
	fKBfLENi/rDIU0LiYtYMOPrVhHsCklQYHAzKP94TINzF6PWNxJXFI2ncxVUQ6KUYA5XabKtcX5s
	PZjZMfOyYjl8aHcdZQUo+ac8iKK/mJFuRjRBJE4AwCUP8Zf7WJg/uYjuVBhBtZYjJ8BljojLh5H
	qBx8dkQjl3BDucxQdVRBYt3Tjq
X-Received: by 2002:a05:622a:1b24:b0:50b:4eb9:a97c with SMTP id d75a77b69052e-50dd5b66409mr302672131cf.15.1776266075290;
        Wed, 15 Apr 2026 08:14:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.13.164])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1e33ef66sm10672971cf.1.2026.04.15.08.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:14:34 -0700 (PDT)
Message-Id: <081f904c071d4cc502d41736dea13b201ff96182.1776266066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
	<pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 15:14:25 +0000
Subject: [PATCH v2 6/7] remote: add negotiationRequire config as default for
 --negotiation-require
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

Add a new 'remote.<name>.negotiationRequire' multi-valued config option
that provides default values for --negotiation-require when no
--negotiation-require arguments are specified over the command line.
This is a mirror of how 'remote.<name>.negotiationRestrict' specifies
defaults for the --negotiation-restrict arguments.

Each value is either an exact ref name or a glob pattern whose tips
should always be sent as 'have' lines during negotiation. The config
values are resolved through the same resolve_negotiation_require()
codepath as the CLI options.

This option is additive with the normal negotiation process: the
negotiation algorithm still runs and advertises its own selected
commits, but the refs matching the config are sent unconditionally
on top of those heuristically selected commits.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/config/remote.adoc | 24 +++++++++++++++++
 Documentation/fetch-options.adoc |  4 +++
 builtin/fetch.c                  | 10 +++++++
 remote.c                         |  6 +++++
 remote.h                         |  1 +
 t/t5510-fetch.sh                 | 46 ++++++++++++++++++++++++++++++++
 6 files changed, 91 insertions(+)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 5e8ac6cfdd..9dbe820275 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -123,6 +123,30 @@ command-line option.  If `--negotiation-restrict` (or its synonym
 `--negotiation-tip`) is specified on the command line, then the config
 values are not used.
 
+remote.<name>.negotiationRequire::
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
+These config values are used as defaults for the `--negotiation-require`
+command-line option.  If `--negotiation-require` is specified on the
+command line, then the config values are not used.
++
+This option is additive with the normal negotiation process: the
+negotiation algorithm still runs and advertises its own selected commits,
+but the refs matching `remote.<name>.negotiationRequire` are sent
+unconditionally on top of those heuristically selected commits.  This
+option is also used during push negotiation when `push.negotiate` is
+enabled.
+
 remote.<name>.followRemoteHEAD::
 	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
 	when fetching using the configured refspecs of a remote.
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 85ffc5b32b..16c6e8cee9 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -91,6 +91,10 @@ is the same as for `--negotiation-restrict`.
 If `--negotiation-restrict` is used, the have set is first restricted by
 that option and then increased to include the tips specified by
 `--negotiation-require`.
++
+If this option is not specified on the command line, then any
+`remote.<name>.negotiationRequire` config values for the current remote
+are used instead.
 
 `--negotiate-only`::
 	Do not fetch anything from the server, and instead print the
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b60652e6b1..a398115fb5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1622,6 +1622,16 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
 		else
 			warning(_("ignoring %s because the protocol does not support it"),
 				"--negotiation-require");
+	} else if (remote->negotiation_require.nr) {
+		if (transport->smart_options) {
+			transport->smart_options->negotiation_require = &remote->negotiation_require;
+		} else {
+			struct strbuf config_name = STRBUF_INIT;
+			strbuf_addf(&config_name, "remote.%s.negotiationRequire", remote->name);
+			warning(_("ignoring %s because the protocol does not support it"),
+				config_name.buf);
+			strbuf_release(&config_name);
+		}
 	}
 	return transport;
 }
diff --git a/remote.c b/remote.c
index 07cdf6434d..53deed7565 100644
--- a/remote.c
+++ b/remote.c
@@ -153,6 +153,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
 	refspec_init_fetch(&ret->fetch);
 	string_list_init_dup(&ret->server_options);
 	string_list_init_dup(&ret->negotiation_restrict);
+	string_list_init_dup(&ret->negotiation_require);
 
 	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
 		   remote_state->remotes_alloc);
@@ -181,6 +182,7 @@ static void remote_clear(struct remote *remote)
 	FREE_AND_NULL(remote->http_proxy_authmethod);
 	string_list_clear(&remote->server_options, 0);
 	string_list_clear(&remote->negotiation_restrict, 0);
+	string_list_clear(&remote->negotiation_require, 0);
 }
 
 static void add_merge(struct branch *branch, const char *name)
@@ -568,6 +570,10 @@ static int handle_config(const char *key, const char *value,
 		if (!value)
 			return config_error_nonbool(key);
 		string_list_append(&remote->negotiation_restrict, value);
+	} else if (!strcmp(subkey, "negotiationrequire")) {
+		if (!value)
+			return config_error_nonbool(key);
+		string_list_append(&remote->negotiation_require, value);
 	} else if (!strcmp(subkey, "followremotehead")) {
 		const char *no_warn_branch;
 		if (!strcmp(value, "never"))
diff --git a/remote.h b/remote.h
index e6ec37c393..d986257c78 100644
--- a/remote.h
+++ b/remote.h
@@ -118,6 +118,7 @@ struct remote {
 
 	struct string_list server_options;
 	struct string_list negotiation_restrict;
+	struct string_list negotiation_require;
 
 	enum follow_remote_head_settings follow_remote_head;
 	const char *no_warn_branch;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ec30b81c71..0246ac6bc5 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1573,6 +1573,52 @@ test_expect_success '--negotiation-require avoids duplicates with negotiator' '
 	test_line_count = 1 matches
 '
 
+test_expect_success 'remote.<name>.negotiationRequire used as default for --negotiation-require' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	git -C client config --add remote.origin.negotiationRequire refs/tags/beta_1 &&
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
+test_expect_success 'remote.<name>.negotiationRequire works with glob patterns' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	git -C client config --add remote.origin.negotiationRequire "refs/tags/beta_*" &&
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
+test_expect_success 'CLI --negotiation-require overrides remote.<name>.negotiationRequire' '
+	test_when_finished rm -f trace &&
+	setup_negotiation_tip server server 0 &&
+
+	git -C client config --add remote.origin.negotiationRequire refs/tags/beta_2 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
+		--negotiation-restrict=alpha_1 \
+		--negotiation-require=refs/tags/beta_1 \
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

