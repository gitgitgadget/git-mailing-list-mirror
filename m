Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE2480DDA
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791144875; cv=none; b=P/+PaFjH5LSgC0Y8tqo4euERjV43xd5hgVIhX0svSR3pLg28gmaL56NH0Fkq2F9zq/AD+dV6ZfYuJFQIrseaSeDgwllInqZjN2ShR22pZQXL6NgfN+L9h3dDJSgiPY0AwQgshEuGn15XAR4GKl99D2OjG/B3dHbwwDIIkETYwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791144875; c=relaxed/simple;
	bh=HxT5MDpeVQWwECuHEG75gazH5pTJ8vPQM1sUpnaXUi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxjalTQaxgUYJPUDXB2cXvXCGBPyyNkN4aU8Ng9ZXhvKO8ItCfAzPlEt3KdZD4a2srRG87BCIAtgKhAwYs2NIodFusudhV1vwU7ZatsY0WPCCSEybDP430yTqwjNA6m3BT/DVImVrNzoe7vch7/LZdEMcW8a+l9QDqhOKzQ/BUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D162xCk3; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D162xCk3"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34daf1b9a1fso759823eec.2
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791144871; x=1791749671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YjrVQpVCNDwt87Dwm78a1OhqrvcjrOZzLIkdPiCCj6k=;
        b=D162xCk395P36H/5160yJunPsEOMOUGH/rXpWVBk83XHsiEVfBD0xqdfgjJUz74qzG
         GOYeiQGZP+had9iJenqrZ8Jo9w+CSuTAoATHjwUozZ1ccJZGL+Cap2E5CRaZrB6tlClu
         2loE/HOO50GxXbbG6bhI8T9YB3DpLpSI+pbp3uEAuT1MMK7YNybPuR0eproVr0Yi+kR3
         d/nlrc8pKpHfpcJtceE6rKZtyCSYH2yBfRVLW+V0ojmiJDgEPgeOID2WqAlquTQLx8m0
         TcknshhmaTgeh53Yejx5KUpjVlmo4nhmrNeUobzr5Phca5b1peFVTuHpQquzIAYb+/21
         +g8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791144871; x=1791749671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YjrVQpVCNDwt87Dwm78a1OhqrvcjrOZzLIkdPiCCj6k=;
        b=gSULhxYcxbxsLEp2T65+e94ceFXagkP8zApcDNF112iYScb/LuiMIvHiwT5jXBkMkq
         orjHcS65YTAtutmnS6FcLjYSY1nSFP6NDeYIHLdq3VOvmpALM9e08ApDnjqpJ7nLWFZs
         0FoCMj5akND6rPezoEoS9+AV5CXNER6dNqMK550uxit/F7NakcszPUA1YBOym5tuKSbY
         8FwHC5dSq10/Wq5oHmw98sBs3MyjW5IrEdRECr+x8ho0OuUrXg9moyeDvanos6Axu4td
         EgdDBIWbKTjUk1w8oPilxBAYSONN0Y26c2sm0ZsYF73CpW1yK9PD3FgKqTd03rlvinyf
         z/Gg==
X-Gm-Message-State: AFuF++l4g5xnheKzGgGIRxwSsdWEIYCvmP49FTlsqMieBAcNdpkafWJ5
	XmbJyxYscGwpVECGGye/PelTnVTJmItQ/e1WtG6ONHVhWW1PH/DTrlMR+obB8SWr
X-Gm-Gg: AYBFou2lHIwskxbweezK5RcriwR+fHVmeGXWtudLMCpepspf92IsfKe3wcbNZNE9N+l
	DQi4x3saEviZdy8/5PROC5tjQXEElsz1/ezkiXRVGCb39BDZEbrqCMbJTf1+O1ggUfuPO8FIN1+
	SZOMMrecwwxT+5q1oYjAkoBJ91lJbbrO1O1xEB/Fst2ZtUcNcNNyH3rgGutUzeKWwBtMa/kqsSQ
	BF5sg9B0+7P5Wne0k0eQrD1Vh+AaonqJHtKCmmDmWSVhYHYtIPn4SP7yqpETmSP5KIyN+uppHlY
	TTfvSPbID8TyEkzMvTVCHj1sv+hOZHiDmVXhs5V289KF5OHnDO6ayRB+H5tlocbsnaFHD1bCjit
	Prjs3Dh3OWfEJveniusXgdNAVNexqcCNx33hv03yTbiCuUcOoRttJi441sG3Th/bs8gEliO015L
	pletZ6reavAFC8xdaIjXXzdLnMNIOBv90boonaw61DNytSz/iYiZrMvQ+j2r+K2iHTmAshcqpGX
	adwpPLnn2xDlLQ=
X-Received: by 2002:a05:7022:150e:b0:151:2e62:fe6e with SMTP id a92af1059eb24-1512e630a8dmr11429241c88.19.1791144871319;
        Sun, 04 Oct 2026 13:14:31 -0700 (PDT)
Received: from Velociraptor ([2603:8002:cb00:3bb7:1527:50f:68b1:b790])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fc39a6cbsm15639470c88.5.2026.10.04.13.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 13:14:30 -0700 (PDT)
From: Colin Hinton <colinlewishinton@gmail.com>
To: git@vger.kernel.org
Cc: m@lfurio.us,
	gitster@pobox.com,
	Colin Hinton <colinlewishinton@gmail.com>
Subject: [PATCH v5] fetch.c: defer fetch.followRemoteHEAD validation
Date: Sun,  4 Oct 2026 13:14:27 -0700
Message-ID: <20261004201428.5210-1-colinlewishinton@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261003231422.6004-1-colinlewishinton@gmail.com>
References: <20261003231422.6004-1-colinlewishinton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of the fetch.followRemoteHEAD configuration variable is
validated while the configuration file is being parsed, which
produces a warning even when this particular "git fetch" invocation
will never consult it.

Store the raw config string instead, and resolve/validate it lazily
at the one place in do_fetch() that actually uses it, so a mistyped
value only warns, and a missing value only dies, when this fetch
would have consulted it.

remote.c's handle_config() has the same problem for
remote.<name>.followRemoteHEAD, but is left unaddressed here since
it touches shared remote-parsing infrastructure used well beyond
fetch. Leave NEEDSWORK comments at both the now unresolved call site
in do_fetch() and at the actual defect in handle_config(), so the
remaining scope is easy to find for a follow-up patch.

Signed-off-by: Colin Hinton <colinlewishinton@gmail.com>
---
 builtin/fetch.c | 72 ++++++++++++++++++++++++-------------------------
 remote.c        |  7 +++++
 2 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 533fdfe7d8..e0b4394fea 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -103,7 +103,8 @@ static struct string_list negotiation_include = STRING_LIST_INIT_NODUP;
 
 struct fetch_config {
 	enum display_format display_format;
-	enum follow_remote_head_settings follow_remote_head;
+	char *follow_remote_head_raw;
+	int follow_remote_head_seen;
 	int all;
 	int prune;
 	int prune_tags;
@@ -176,24 +177,31 @@ static int git_fetch_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "fetch.followremotehead")) {
-		if (!v)
-			return config_error_nonbool(k);
-		else if (!strcmp(v, "never"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_NEVER;
-		else if (!strcmp(v, "create"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_CREATE;
-		else if (!strcmp(v, "warn"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_WARN;
-		else if (!strcmp(v, "always"))
-			fetch_config->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
-		else
-			warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), v);
+		free(fetch_config->follow_remote_head_raw);
+		fetch_config->follow_remote_head_raw = xstrdup_or_null(v);
+		fetch_config->follow_remote_head_seen = 1;
 		return 0;
 	}
 
 	return git_default_config(k, v, ctx, cb);
 }
 
+static enum follow_remote_head_settings get_follow_remote_head(const char *setting)
+{
+	if (!setting)
+		die(_("missing value for 'fetch.followRemoteHEAD'"));
+	else if (!strcmp(setting, "never"))
+		return FOLLOW_REMOTE_NEVER;
+	else if (!strcmp(setting, "create"))
+		return FOLLOW_REMOTE_CREATE;
+	else if (!strcmp(setting, "warn"))
+		return FOLLOW_REMOTE_WARN;
+	else if (!strcmp(setting, "always"))
+		return FOLLOW_REMOTE_ALWAYS;
+	warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), setting);
+	return BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
+}
+
 static int parse_refmap_arg(const struct option *opt, const char *arg, int unset)
 {
 	BUG_ON_OPT_NEG(unset);
@@ -1918,11 +1926,10 @@ static int do_fetch(struct transport *transport,
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 	struct fetch_head fetch_head = { 0 };
 	struct strbuf err = STRBUF_INIT;
-	int do_set_head = 0;
 	struct ref_update_display_info_array display_array = { 0 };
 	struct strmap rejected_refs = STRMAP_INIT;
 	int summary_width = 0;
-	int follow_remote_head;
+	int follow_remote_head = FOLLOW_REMOTE_NEVER;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1938,22 +1945,6 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 	}
 
-	/*
-	 * NEEDSWORK: By the time this function executes, we have already parsed
-	 * all such followRemoteHEAD values from the external configuration,
-	 * potentially emitting warning messages for bogus values.  Ideally, if
-	 * this fetch ends up not needing to consult these values, then git would
-	 * not ever output a value warning. (eg: when pulling from a URL directly -
-	 * rather than a configured remote, or when a remote's followRemoteHEAD
-	 * overrides the fallback fetch setting)
-	 */
-	if (transport->remote->follow_remote_head)
-		follow_remote_head = transport->remote->follow_remote_head;
-	else if (config->follow_remote_head)
-		follow_remote_head = config->follow_remote_head;
-	else
-		follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
-
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
@@ -1962,8 +1953,16 @@ static int do_fetch(struct transport *transport,
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
-			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
-				do_set_head = 1;
+			/*
+			 * See remote.c's handling of remote.<name>.followRemoteHEAD
+			 * for the analogous, still-unresolved case.
+			 */
+			if (transport->remote->follow_remote_head)
+				follow_remote_head = transport->remote->follow_remote_head;
+			else if (config->follow_remote_head_seen)
+				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
+			else
+				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
 		}
 		if (branch && branch_has_merge_config(branch) &&
 		    !strcmp(branch->remote_name, transport->remote->name)) {
@@ -1987,7 +1986,7 @@ static int do_fetch(struct transport *transport,
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "refs/tags/");
 
-	if (do_set_head)
+	if (follow_remote_head != FOLLOW_REMOTE_NEVER)
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "HEAD");
 
@@ -2164,7 +2163,7 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
-	if (do_set_head) {
+	if (follow_remote_head != FOLLOW_REMOTE_NEVER) {
 		/*
 		 * Way too many cases where this can go wrong so let's just
 		 * ignore errors and fail silently for now.
@@ -2509,7 +2508,8 @@ int cmd_fetch(int argc,
 {
 	struct fetch_config config = {
 		.display_format = DISPLAY_FORMAT_FULL,
-		.follow_remote_head = FOLLOW_REMOTE_UNCONFIGURED,
+		.follow_remote_head_raw = NULL,
+		.follow_remote_head_seen = 0,
 		.prune = -1,
 		.prune_tags = -1,
 		.show_forced_updates = 1,
diff --git a/remote.c b/remote.c
index fe62068463..58f3436222 100644
--- a/remote.c
+++ b/remote.c
@@ -582,6 +582,13 @@ static int handle_config(const char *key, const char *value,
 					      &remote->negotiation_include);
 	} else if (!strcmp(subkey, "followremotehead")) {
 		const char *no_warn_branch;
+		/*
+		 * NEEDSWORK: this is validated/warned about here, during config
+		 * parsing, regardless of whether the fetch that triggered this
+		 * parse will ever consult it for this particular remote. See
+		 * fetch.c's deferred handling of fetch.followRemoteHEAD for the
+		 * pattern this should likely follow.
+		 */
 		if (!strcmp(value, "never"))
 			remote->follow_remote_head = FOLLOW_REMOTE_NEVER;
 		else if (!strcmp(value, "create"))
-- 
2.55.0.windows.3

