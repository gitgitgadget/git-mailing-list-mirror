Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781416;
	b=f3Lshpby9pTRfqVPJckm2iRj/vacvf/HPp+Fy6YYckltiNPDhoatyVWZXW7odQymaYRM
	 L+PVjfYdtcRONIzriMh5JwunBtUREywcsR+nyW1pRxWWpBPtnfJYgpDf8WZNt+4ek2nwc
	 6CnqHzEobI1VbRdAEI/nNT/nSXMXbYTSjhZUSn3mpFQg8wH60BOnsUhapXgCM8gucHbZ2
	 p3dZog9fSTh/B9LMM32k/WgdFy6JK3KjPKWo4dik6anyzQmsC+ULBnVxzh91fAmaE1ldo
	 y19TdgwFFiZmF/yzGPQtA6Mwmlu1a4GgOC15GbJFJTj+LQCtX6tOyXkQJdkxQwAeE+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/1Sse6UGETwPdlECcSkdVqmCNpCwnYq98Ciuz1I/atc=;
	b=aiEskJnc3RDQzKx26Tdd4HRVPDuJBi7cr7BriZmfjvcJgjB9RagH95ws1SjRH9GHeViY
	 /MvW0wUdTpx3iDZ3+WnuLxDkctOCtVXxIC9QwD/XTWOcTZyyJWxodXySr0Z9vUwR8sB/Y
	 WcMbuyDCV+HQ1kQi6Pu4WllMF4trusT7S5Iog+2aZ9eZdkyH93oqTFRKYHizJZJaschLR
	 5doXrqc0PXmeSX5cOeAoETQ0IaWazWxhgKtaqmmhSdBEUAHcEnCutfHBXOkB5WITQ1pUW
	 E5DJOtm+Xy00riS7ToHNtc3+Xf8234tWGOFVrMX+GeemQLso97jrySQ4z98AnEL0aAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UxEm9Yxy;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD16606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CD16606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UxEm9Yxy
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15ea896ddc8so1914782c88.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792781415; x=1793386215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/1Sse6UGETwPdlECcSkdVqmCNpCwnYq98Ciuz1I/atc=;
        b=UxEm9Yxy540uVZXF8FaNJSmLJqAGVk2tdVsePJjPLm+GvB/Ph7AVG7v+YktCHs/yPC
         gsD2p2ZwwYUcCKrGIf3kdo1cpcW0B4rjH+5OXYawxFDRUIaEFgLrpknf+KuAWUxosEfW
         xo9j7VxI7YnXcOYf/03qzknV9rS3cbXb8KlMHP02L6IznekBqSX/+2xdkLaHwwuus/0U
         DFipj1ho318Gpj3R+cYsFayzqUcQTC9Rxcn9rEgLDYZxy0nLN97Cn+RwLLA0Z4NX/4JU
         PWWNjogicQElWuJsapdbCPYDwwLVyzg84RMumRAH8htfmkRQBmuMnOsbR7AT+CsyqF8j
         nN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792781415; x=1793386215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/1Sse6UGETwPdlECcSkdVqmCNpCwnYq98Ciuz1I/atc=;
        b=KCUoGhTANnSC7y7cMCslUzHh6bJHTYY4gVhXpbasR4Owa5lzxpKyhopuNfCQeXqo/J
         ba+6Beere9SNnzxNQs+UQ6FdNk4B+ktDu659yCCm8d6s87Yu8ExI5Rj6I2kuowkIw7gS
         05WiQvN0Jww3coubdVglhgP9+qCoZk5i1uyzX0FrS3AqzJI3jIoBd6r06Zeu8dAYNg0V
         xPBC7bTe8rsDkEzxzqqMmBfNYigybBky710Xd3XQlJ3ZUTT0m/0+lfJTV+g3CAJR5c4f
         Te3hzAIl3XaoHOMt+M/9CydebCha7QZe1PUaBMLeg5DegCwcXrRiszIkrgaIkyWywp+N
         V8aQ==
X-Gm-Message-State: AFq9FYJqxy7RwCP7bBaLXz7/xSpEg79nvnDUBT/fio0TSRoGY2w64Ie/
	POrxxLGIW7V4OTMfQIe4t3vpQ/qP+JGvOa1hTED7WF1gADEhVcyvKB31AJ9oreq4
X-Gm-Gg: AYBFou2d0MF+FHs5js2zVdN9ilOGGMdKmiQ5rPfM+IoynURmyqux/LLizUvKygKXjbr
	CKui7wwVPCOEZtHCqpeFcFh7mAsNA3SDtShwcRISGJOJPUuRrcBu+WEzUfqQq7J6OiY0ngtJp8M
	2WhaI3VBBFZ7qPu0kR8UdZlYhnmf3gNsAXNze5wHI/J9QRGTqh35QLu/6lo0O1umTLmlBhdwfhJ
	g3BEFlghbJ0WitWjom8Kvhcsfchp+H5iHA/+9sxViqFlJfnuXOt8DmO7Wmw2xH0kobrKSQ5V5S7
	eKdGxmDWH1oTNlFM8KMU8U7P9fSYXk799V36C5OL575xV3iIwEQQLsRAw3EToE2a5guZ3NgaB2L
	ZN6NOy7Jgapc6vbRwWCipcuqCVQSNOBR1vA2zpdjTanLJb2RixGEdiU/7HGuDFAkqJhY40UcDGs
	zxWe+Xi/UW93PMmd6bSvr/4d5qeLzP3fYpXRmQmr97j9nSU3ZOTR4nAacKhZ9NIr1LisUIjkplc
	pOxT6gNlaMnv5eYAX+MvedoiH3SFiRRJ70KsKPk4IXe8oLttN4SCYFCJJL3WJ7rxrK+Np7cLA==
X-Received: by 2002:a05:701b:2713:b0:147:a685:912d with SMTP id a92af1059eb24-195c6563787mr3584601c88.29.1792781414283;
        Fri, 23 Oct 2026 11:50:14 -0700 (PDT)
Received: from Velociraptor ([2603:8002:d000:3d0d:1087:8c42:933e:a741])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec865esm49239eec.26.2026.10.23.11.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:50:13 -0700 (PDT)
From: Colin Hinton <colinlewishinton@gmail.com>
To: git@vger.kernel.org
Cc: m@lfurio.us,
	gitster@pobox.com,
	Colin Hinton <colinlewishinton@gmail.com>
Subject: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD validation
Date: Fri, 23 Oct 2026 11:50:07 -0700
Message-ID: <20261023185007.21642-1-colinlewishinton@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261018235508.848-1-colinlewishinton@gmail.com>
References: <20261018235508.848-1-colinlewishinton@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Continuing from 86129fd (fetch.c: defer fetch.followRemoteHEAD
validation), apply the same treatment to
remote.<name>.followRemoteHEAD, which is still validated in
handle_config(). That emits a warning for any command that loads the
remote configuration, such as "git push" or "git remote -v", even
though only "git fetch" ever consults the value.

Store the raw string in struct remote instead, and resolve it lazily
in do_fetch() through the get_follow_remote_head() helper introduced
by 86129fd. This replaces the parsed follow_remote_head and
no_warn_branch members, and the NEEDSWORK comment left behind by
86129fd is removed. "git remote set-head" now compares against the
raw string to decide whether to rewrite "always" to "warn".

Moved enum follow_remote_head_settings to builtin/fetch.c as it is no
longer referenced in remote.

Messages for an unrecognized or missing value name the full variable
name prefix, as the helper now serves both the fetch-level and
the remote-level setting.

Signed-off-by: Colin Hinton <colinlewishinton@gmail.com>
---
 Documentation/config/remote.adoc |  4 +--
 builtin/fetch.c                  | 45 +++++++++++++++++++++-----------
 builtin/remote.c                 |  3 ++-
 remote.c                         | 28 +++-----------------
 remote.h                         | 13 ++-------
 t/t5510-fetch.sh                 | 18 +++++++++++++
 6 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 3a20d0f752..d19fe88ef3 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -173,5 +173,5 @@ remote.<name>.followRemoteHEAD::
 	accepted values.
 +
 In addition to the values supported by `fetch.followRemoteHEAD`, this setting
-may also take on the value "warn-if-not-`$branch`", which behaves like "warn",
-but ignores the warning if the remote's `HEAD` is `remotes/<name>/$branch`.
+may also take on the value "warn-if-not-`<branch>`", which behaves like "warn",
+but ignores the warning if the remote's `HEAD` is `remotes/<name>/<branch>`.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1f76ae6242..bb59e70865 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -65,6 +65,15 @@ enum display_format {
 	DISPLAY_FORMAT_PORCELAIN,
 };
 
+#define BUILTIN_FOLLOW_REMOTE_HEAD_DFLT FOLLOW_REMOTE_CREATE
+enum follow_remote_head_settings {
+	FOLLOW_REMOTE_UNCONFIGURED = 0,
+	FOLLOW_REMOTE_NEVER,
+	FOLLOW_REMOTE_CREATE,
+	FOLLOW_REMOTE_WARN,
+	FOLLOW_REMOTE_ALWAYS,
+};
+
 struct display_state {
 	struct strbuf buf;
 
@@ -187,19 +196,22 @@ static int git_fetch_config(const char *k, const char *v,
 	return git_default_config(k, v, ctx, cb);
 }
 
-static enum follow_remote_head_settings get_follow_remote_head(const char *setting)
+static enum follow_remote_head_settings get_follow_remote_head(const char *setting,
+    const char *key, const char **no_warn_branch)
 {
 	if (!setting)
-		die(_("missing value for 'fetch.followRemoteHEAD'"));
+		die(_("missing value for '%s'"), key);
 	else if (!strcmp(setting, "never"))
 		return FOLLOW_REMOTE_NEVER;
 	else if (!strcmp(setting, "create"))
 		return FOLLOW_REMOTE_CREATE;
 	else if (!strcmp(setting, "warn"))
 		return FOLLOW_REMOTE_WARN;
+	else if (no_warn_branch && skip_prefix(setting, "warn-if-not-", no_warn_branch))
+		return FOLLOW_REMOTE_WARN;
 	else if (!strcmp(setting, "always"))
 		return FOLLOW_REMOTE_ALWAYS;
-	warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), setting);
+	warning(_("unrecognized %s value '%s' ignored"), key, setting);
 	return BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
 }
 
@@ -1760,12 +1772,11 @@ static void warn_set_head(const char *remote, const char *head_name,
 }
 
 static int set_head(const struct ref *remote_refs, struct remote *remote,
-			int follow_remote_head)
+		    int follow_remote_head, const char *no_warn_branch)
 {
 	int result = 0, create_only, baremirror, was_detached;
 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
 		      b_local_head = STRBUF_INIT;
-	const char *no_warn_branch = remote->no_warn_branch;
 	char *head_name = NULL;
 	struct ref *ref, *matches;
 	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
@@ -1955,6 +1966,7 @@ static int do_fetch(struct transport *transport,
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
 	int follow_remote_head = FOLLOW_REMOTE_NEVER;
+	const char *no_warn_branch = NULL;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1978,16 +1990,19 @@ static int do_fetch(struct transport *transport,
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
-			/*
-			 * See remote.c's handling of remote.<name>.followRemoteHEAD
-			 * for the analogous, still-unresolved case.
-			 */
-			if (transport->remote->follow_remote_head)
-				follow_remote_head = transport->remote->follow_remote_head;
-			else if (config->follow_remote_head_seen)
-				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
-			else
+			if (transport->remote->follow_remote_head_seen) {
+				char *key = xstrfmt("remote.%s.followRemoteHEAD", transport->remote->name);
+				follow_remote_head = get_follow_remote_head(
+					transport->remote->follow_remote_head_raw,
+					key, &no_warn_branch);
+				free(key);
+			} else if (config->follow_remote_head_seen) {
+				follow_remote_head = get_follow_remote_head(
+					config->follow_remote_head_raw,
+					"fetch.followRemoteHEAD", NULL);
+			} else {
 				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
+			}
 		}
 		if (branch && branch_has_merge_config(branch) &&
 		    !strcmp(branch->remote_name, transport->remote->name)) {
@@ -2195,7 +2210,7 @@ static int do_fetch(struct transport *transport,
 		 * Way too many cases where this can go wrong so let's just
 		 * ignore errors and fail silently for now.
 		 */
-		set_head(remote_refs, transport->remote, follow_remote_head);
+		set_head(remote_refs, transport->remote, follow_remote_head, no_warn_branch);
 	}
 
 cleanup:
diff --git a/builtin/remote.c b/builtin/remote.c
index fb7e5b114f..aad92c7dcd 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1606,7 +1606,8 @@ static int set_head(int argc, const char **argv, const char *prefix,
 	}
 	if (opt_a)
 		report_set_head_auto(argv[0], head_name, &b_local_head, was_detached);
-	if (remote->follow_remote_head == FOLLOW_REMOTE_ALWAYS) {
+	if (remote->follow_remote_head_raw &&
+	    !strcmp(remote->follow_remote_head_raw, "always")) {
 		struct strbuf config_name = STRBUF_INIT;
 		strbuf_addf(&config_name,
 			"remote.%s.followremotehead", remote->name);
diff --git a/remote.c b/remote.c
index 49ee2ea318..fa230005ff 100644
--- a/remote.c
+++ b/remote.c
@@ -184,6 +184,7 @@ static void remote_clear(struct remote *remote)
 	string_list_clear(&remote->server_options, 0);
 	string_list_clear(&remote->negotiation_restrict, 0);
 	string_list_clear(&remote->negotiation_include, 0);
+	free(remote->follow_remote_head_raw);
 }
 
 static void add_merge(struct branch *branch, const char *name)
@@ -581,30 +582,9 @@ static int handle_config(const char *key, const char *value,
 		return parse_transport_option(key, value,
 					      &remote->negotiation_include);
 	} else if (!strcmp(subkey, "followremotehead")) {
-		const char *no_warn_branch;
-		/*
-		 * NEEDSWORK: this is validated/warned about here, during config
-		 * parsing, regardless of whether the fetch that triggered this
-		 * parse will ever consult it for this particular remote. See
-		 * fetch.c's deferred handling of fetch.followRemoteHEAD for the
-		 * pattern this should likely follow.
-		 */
-		if (!strcmp(value, "never"))
-			remote->follow_remote_head = FOLLOW_REMOTE_NEVER;
-		else if (!strcmp(value, "create"))
-			remote->follow_remote_head = FOLLOW_REMOTE_CREATE;
-		else if (!strcmp(value, "warn")) {
-			remote->follow_remote_head = FOLLOW_REMOTE_WARN;
-			remote->no_warn_branch = NULL;
-		} else if (skip_prefix(value, "warn-if-not-", &no_warn_branch)) {
-			remote->follow_remote_head = FOLLOW_REMOTE_WARN;
-			remote->no_warn_branch = no_warn_branch;
-		} else if (!strcmp(value, "always")) {
-			remote->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
-		} else {
-			warning(_("unrecognized followRemoteHEAD value '%s' ignored"),
-				value);
-		}
+		free(remote->follow_remote_head_raw);
+		remote->follow_remote_head_raw = xstrdup_or_null(value);
+		remote->follow_remote_head_seen = 1;
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index cca02033b9..b95f00df2d 100644
--- a/remote.h
+++ b/remote.h
@@ -62,15 +62,6 @@ struct remote_state {
 void remote_state_clear(struct remote_state *remote_state);
 struct remote_state *remote_state_new(void);
 
-#define BUILTIN_FOLLOW_REMOTE_HEAD_DFLT FOLLOW_REMOTE_CREATE
-enum follow_remote_head_settings {
-	FOLLOW_REMOTE_UNCONFIGURED = 0,
-	FOLLOW_REMOTE_NEVER,
-	FOLLOW_REMOTE_CREATE,
-	FOLLOW_REMOTE_WARN,
-	FOLLOW_REMOTE_ALWAYS,
-};
-
 struct remote {
 	struct hashmap_entry ent;
 
@@ -122,8 +113,8 @@ struct remote {
 	struct string_list negotiation_restrict;
 	struct string_list negotiation_include;
 
-	enum follow_remote_head_settings follow_remote_head;
-	const char *no_warn_branch;
+	char *follow_remote_head_raw;
+	int follow_remote_head_seen;
 };
 
 /**
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 17c0be499c..5b97dced12 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -290,6 +290,24 @@ test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is di
 	test "z$head" = "z$branch"
 '
 
+test_expect_success "fetch test default followRemoteHEAD warn-if-not-branch is not supported" '
+	git -C two rev-parse --verify refs/remotes/origin/other &&
+	git -C two remote set-head origin other &&
+	test_config -C two fetch.followRemoteHEAD "warn-if-not-main" &&
+	git -C two fetch >out 2>err &&
+	test_must_be_empty out &&
+	test_grep "unrecognized fetch.followRemoteHEAD value ${SQ}warn-if-not-main${SQ} ignored" err &&
+	echo refs/remotes/origin/other >expect &&
+	git -C two symbolic-ref refs/remotes/origin/HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "fetch test followRemoteHEAD unrecognized value names the remote" '
+   	test_config -C two remote.origin.followRemoteHEAD bogus &&
+   	git -C two fetch 2>err &&
+   	test_grep "unrecognized remote.origin.followRemoteHEAD value ${SQ}bogus${SQ} ignored" err
+'
+
 test_expect_success "fetch test default followRemoteHEAD always" '
 	git -C two rev-parse --verify refs/remotes/origin/other &&
 	git -C two remote set-head origin other &&
-- 
2.55.0.windows.3

