Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3D32D44F
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488303; cv=none; b=TRmET09MitPJavx2r9c+oMkgqSN+v3gT1Px312lN9MjteAPmghDKPQ1ZDXg7thbFNcXp57OtUDqvLgF05GI1EdhpG+RErxU9Mgphl/RYHxwp87aX/Oa/YykwigTUZ3qvlhyo3nS3AvcQPR25DCXNDkQKcnwtaHTYpk+zm5yuTBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488303; c=relaxed/simple;
	bh=onAXcl5NY7lFz5YNdz7GAnmrbp0pO7tLLVr+S4bwwb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMcu8vAdPYMBL5I2EQQfpUv5z5KRsmkl/co2SwjZrsDRCqDb9nBFqsSpHkAbhtHkjTm9Rb0FZpG57AYmPfoKlkkH4Vnr7qLQ9shMuFGFl4XPbZTihwlIS/jROJvNwjYWGGWJ2qNYAd9BQdZEn78yx0cmEqG8y0iCosSwsiAJ1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCL3Yl8N; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCL3Yl8N"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-431048c4068so2734626f8f.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 03:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766488298; x=1767093098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rrpy84mQ/GqJZt0JX++RJkh0pMBQNFO7IUA7rh/X2Yg=;
        b=mCL3Yl8NJeuDniYIs0cVTqXcvluyEAxzOXiVWUdSI5dYFcRsw8EpI0hDxnlHndj7bW
         gp7EsClOR2/4NhR0mcUCpCb6rJeIMXlR++o85Ttt86OHX3ioatlLyRdi0SqWcFEAv/ko
         R52jDtNrtS+WO76ADaXHiWRb5spembgTtVwdRoLj2axf9VqyUyhITH7eykNK3iIXhJDj
         hkCUEQO4LQZF3melEHB8twjN2WD7NY/CShQJznpn3uiD+wJ/9+hvrTIXDJY8OVz968Ek
         YFfetmpazl4XoGkaIkcoRQwvfUGOp3HdGYW1WYw/ac2FZrmoyoNyTvPR1fVKs+1+ex18
         BwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488298; x=1767093098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rrpy84mQ/GqJZt0JX++RJkh0pMBQNFO7IUA7rh/X2Yg=;
        b=CWKQcNpUQBlR+WLTUEX6+TZ3bNcCD0/dYbQokDvHFSDKh9i7ypCN0k/nPq7omwnFF9
         QZ8FsjgJ22gC1J678r8aSpBZuhxVK0MSsRvFWtqqd2OUn+n4YDtH0BxpSCzjhy6Jmwt9
         NHbCRKPdU5m1sTpqCyXHCxvfw5U2p0K16MFmCWrPGu1v1urMEKGsO5uRfK9Tsig450bc
         7hFEydr22HcyOkgjUq906L6A60glGvP4J54oCG+hpCC3590mDD6meZ7sN7S+GH61syHr
         3yyMkYEdW9Zr1pfhUim+caTF/qTJBEcz/ilWazBmFVqXvFT7IrwaJto+ubDBQNKK6Ofg
         YUOQ==
X-Gm-Message-State: AOJu0Yypd0hB0YOI/HsM/iM3wNoSCn/YlASSost9dDho/vIbHt6hEIza
	XHPLn/dNvAFiGaQcZMd60VduPRmFHY4IU46lbd/tRyHf0LXI4M/Zbmx6SAiZOA==
X-Gm-Gg: AY/fxX5iT73v8BaXhQh5LoVS+4gAstuWiAktkilEDgqLliCAO+ggrjEBL0OiZERHjYL
	TqaqHMacgT1UaCcMkleLPGf318MDxIUwP0/z5xvuz4/S6J7eZwPW3NGt0OX9hageAVVp8SPEszR
	VnC3zrrODXb1FiB5Sde/y56CYHswJrgS4kcjTr3eDp6Q2HJvRAVBSVt1mLY3rNNuFWi9kdn+aM4
	EWRkyCcaPVlKEpqiaUoj++jrNhNrB/nRQwBNT9swTaQ8/eDiVg7HT6e5uGaDpU0gMVOwe5+LfRL
	XqjvzG2y1JwdzBv1S0YEWOPlVcoe2OtcZFlxy3Ytmvzclgus6EcC9Xm7j1rZHxaeUNMffaFOzpV
	Kpi1MA0qCgfdzAfdE1v7GO0r3yuT5rrO2kcpEXytDURMaFpsbDg4E9mVjpMRKYEJRnaIwNkVTBj
	OyiiFKe3Mf5ptQyWRlQ3QKof4HtYVVlWqt5mh0+P9XHxO5oJFbpcm5bkU59ORVUOy9jNCTwSjDN
	KfTwNV7kZxEvK5SOGxYvzMOGEY/ilYa36qHxA==
X-Google-Smtp-Source: AGHT+IFozuUgTOg94qU0EGRIIiO9m4nqsMM5FYvrSB/Gq40Od9YCTlU5ajIFSF0dxKt4dGOAvITe/w==
X-Received: by 2002:a05:6000:2389:b0:430:fe6c:b1aa with SMTP id ffacd0b85a97d-432448c9ddemr21229938f8f.26.1766488297747;
        Tue, 23 Dec 2025 03:11:37 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227e0sm27932795f8f.17.2025.12.23.03.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 03:11:36 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/9] fetch: make filter_options local to cmd_fetch()
Date: Tue, 23 Dec 2025 12:11:08 +0100
Message-ID: <20251223111113.47473-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.319.gfcaffa7898
In-Reply-To: <20251223111113.47473-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `struct list_objects_filter_options filter_options` variable used
in "builtin/fetch.c" to store the parsed filters specified by
`--filter=<filterspec>` is currently a static variable global to the
file.

As we are going to use it more in a following commit, it could become a
bit less easy to understand how it's managed.

To avoid that, let's make it clear that it's owned by cmd_fetch() by
moving its definition into that function and making it non-static.

This requires passing a pointer to it through the prepare_transport(),
do_fetch(), backfill_tags(), fetch_one_setup_partial(), and fetch_one()
functions, but it's quite straightforward.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fetch.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 288d3772ea..b984173447 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -97,7 +97,6 @@ static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *gtransport;
 static struct transport *gsecondary;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
-static struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 
@@ -1449,7 +1448,8 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 	smart_options->negotiation_tips = oids;
 }
 
-static struct transport *prepare_transport(struct remote *remote, int deepen)
+static struct transport *prepare_transport(struct remote *remote, int deepen,
+					   struct list_objects_filter_options *filter_options)
 {
 	struct transport *transport;
 
@@ -1473,9 +1473,9 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	if (refetch)
 		set_option(transport, TRANS_OPT_REFETCH, "yes");
-	if (filter_options.choice) {
+	if (filter_options->choice) {
 		const char *spec =
-			expand_list_objects_filter_spec(&filter_options);
+			expand_list_objects_filter_spec(filter_options);
 		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER, spec);
 		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	}
@@ -1493,7 +1493,8 @@ static int backfill_tags(struct display_state *display_state,
 			 struct ref_transaction *transaction,
 			 struct ref *ref_map,
 			 struct fetch_head *fetch_head,
-			 const struct fetch_config *config)
+			 const struct fetch_config *config,
+			 struct list_objects_filter_options *filter_options)
 {
 	int retcode, cannot_reuse;
 
@@ -1507,7 +1508,7 @@ static int backfill_tags(struct display_state *display_state,
 	cannot_reuse = transport->cannot_reuse ||
 		deepen_since || deepen_not.nr;
 	if (cannot_reuse) {
-		gsecondary = prepare_transport(transport->remote, 0);
+		gsecondary = prepare_transport(transport->remote, 0, filter_options);
 		transport = gsecondary;
 	}
 
@@ -1713,7 +1714,8 @@ static int commit_ref_transaction(struct ref_transaction **transaction,
 
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
-		    const struct fetch_config *config)
+		    const struct fetch_config *config,
+		    struct list_objects_filter_options *filter_options)
 {
 	struct ref_transaction *transaction = NULL;
 	struct ref *ref_map = NULL;
@@ -1873,7 +1875,7 @@ static int do_fetch(struct transport *transport,
 			 * the transaction and don't commit anything.
 			 */
 			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
-					  &fetch_head, config))
+					  &fetch_head, config, filter_options))
 				retcode = 1;
 		}
 
@@ -2198,20 +2200,21 @@ static int fetch_multiple(struct string_list *list, int max_children,
  * Fetching from the promisor remote should use the given filter-spec
  * or inherit the default filter-spec from the config.
  */
-static inline void fetch_one_setup_partial(struct remote *remote)
+static inline void fetch_one_setup_partial(struct remote *remote,
+					   struct list_objects_filter_options *filter_options)
 {
 	/*
 	 * Explicit --no-filter argument overrides everything, regardless
 	 * of any prior partial clones and fetches.
 	 */
-	if (filter_options.no_filter)
+	if (filter_options->no_filter)
 		return;
 
 	/*
 	 * If no prior partial clone/fetch and the current fetch DID NOT
 	 * request a partial-fetch, do a normal fetch.
 	 */
-	if (!repo_has_promisor_remote(the_repository) && !filter_options.choice)
+	if (!repo_has_promisor_remote(the_repository) && !filter_options->choice)
 		return;
 
 	/*
@@ -2220,8 +2223,8 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * filter-spec as the default for subsequent fetches to this
 	 * remote if there is currently no default filter-spec.
 	 */
-	if (filter_options.choice) {
-		partial_clone_register(remote->name, &filter_options);
+	if (filter_options->choice) {
+		partial_clone_register(remote->name, filter_options);
 		return;
 	}
 
@@ -2230,14 +2233,15 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 	 * explicitly given filter-spec or inherit the filter-spec from
 	 * the config.
 	 */
-	if (!filter_options.choice)
-		partial_clone_get_default_filter_spec(&filter_options, remote->name);
+	if (!filter_options->choice)
+		partial_clone_get_default_filter_spec(filter_options, remote->name);
 	return;
 }
 
 static int fetch_one(struct remote *remote, int argc, const char **argv,
 		     int prune_tags_ok, int use_stdin_refspecs,
-		     const struct fetch_config *config)
+		     const struct fetch_config *config,
+		     struct list_objects_filter_options *filter_options)
 {
 	struct refspec rs = REFSPEC_INIT_FETCH;
 	int i;
@@ -2249,7 +2253,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 		die(_("no remote repository specified; please specify either a URL or a\n"
 		      "remote name from which new revisions should be fetched"));
 
-	gtransport = prepare_transport(remote, 1);
+	gtransport = prepare_transport(remote, 1, filter_options);
 
 	if (prune < 0) {
 		/* no command line request */
@@ -2304,7 +2308,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack_atexit);
 	sigchain_push(SIGPIPE, SIG_IGN);
-	exit_code = do_fetch(gtransport, &rs, config);
+	exit_code = do_fetch(gtransport, &rs, config, filter_options);
 	sigchain_pop(SIGPIPE);
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
@@ -2329,6 +2333,7 @@ int cmd_fetch(int argc,
 	const char *submodule_prefix = "";
 	const char *bundle_uri;
 	struct string_list list = STRING_LIST_INIT_DUP;
+	struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 	struct remote *remote = NULL;
 	int all = -1, multiple = 0;
 	int result = 0;
@@ -2594,7 +2599,7 @@ int cmd_fetch(int argc,
 		trace2_region_enter("fetch", "negotiate-only", the_repository);
 		if (!remote)
 			die(_("must supply remote when using --negotiate-only"));
-		gtransport = prepare_transport(remote, 1);
+		gtransport = prepare_transport(remote, 1, &filter_options);
 		if (gtransport->smart_options) {
 			gtransport->smart_options->acked_commits = &acked_commits;
 		} else {
@@ -2616,12 +2621,12 @@ int cmd_fetch(int argc,
 	} else if (remote) {
 		if (filter_options.choice || repo_has_promisor_remote(the_repository)) {
 			trace2_region_enter("fetch", "setup-partial", the_repository);
-			fetch_one_setup_partial(remote);
+			fetch_one_setup_partial(remote, &filter_options);
 			trace2_region_leave("fetch", "setup-partial", the_repository);
 		}
 		trace2_region_enter("fetch", "fetch-one", the_repository);
 		result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
-				   &config);
+				   &config, &filter_options);
 		trace2_region_leave("fetch", "fetch-one", the_repository);
 	} else {
 		int max_children = max_jobs;
@@ -2727,5 +2732,6 @@ int cmd_fetch(int argc,
 
  cleanup:
 	string_list_clear(&list, 0);
+	list_objects_filter_release(&filter_options);
 	return result;
 }
-- 
2.52.0.319.gfcaffa7898

