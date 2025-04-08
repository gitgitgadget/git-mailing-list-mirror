Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BCF218EB0
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093348; cv=none; b=EusXwTjwT8YNXyUzpXwCMs9I+ECaC672Vj+3VNUl6zkBFXRJLsS+svbHh1jSGEsYJvz2VSIQHZx1Wv45jq3xyIq5o5ve735S38pfyicpt2v/v9QefRihhQNfyyef9c/WiNoSprYpANcN83ALASzKLlz7d4xyeZuQPpOHKzslK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093348; c=relaxed/simple;
	bh=UANjqwOTcAFhz5jH1qa0LidB3Pvg01VZx4SaPoJHBiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5RS4Jk/DWaA0KfpgXt35MF5IugzQxW/1dHd0Z3lRM1aIvCz38+2OEzoKOWxhW5bFlApHCTntvs2DxhHKPclPwLpOF3mohQyxSypgVG/ucAvHSrMDRiW+BPdVL7xOIUuVq9ZAGD9pgbBNQF1sYCxs4kQPi7Ua3+Yi3icCb6NEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bZYVHWuU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tdBzI6xr; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bZYVHWuU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tdBzI6xr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 4D40D1380053;
	Tue,  8 Apr 2025 02:22:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 08 Apr 2025 02:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744093344;
	 x=1744179744; bh=Pzwtgsxf9quUrx5dhHVh9wOMuqbGW9NXqHWTvea7VCs=; b=
	bZYVHWuUBLmF6IRy3Ulv71huEiUquGul1WVKxhJoTbgJwFRrTR0RqtNoF/A/z+Ir
	/FZDXyz5nWXqknb0DkHfA3aBQz3mpX8u3IFPzemc9aHTXZpE8U4IOTaaztEbPzmM
	17A6q2dbWTcsx6BvI6drDSnUTh9Oja/yjke9ggwThv3EZHG4Txg7ERGNKd7VW3D1
	0ms2MoKqZJZDs7rnohF7X/EUiLfldmM1hYVokrm9WuvCcm6d4XMfXMUJnbAa1i9Z
	2ij5odh4/K8fy4ncAQtGoaf9dCG9fOXcybhHpQhztgscDQLK8eFm7thciz+MlY03
	kxO65H43m3RNbSJmJYIVEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744093344; x=
	1744179744; bh=Pzwtgsxf9quUrx5dhHVh9wOMuqbGW9NXqHWTvea7VCs=; b=t
	dBzI6xrzZPIFm7v2itH8Fk628uUPSWGGa0zsm9WhmVtZMvWEzhFcZGOP230W3cOn
	RHCCAuZPSWubCFHih4SSB/BUShJcygVE0ivmEEvozM+nVH0AHW/sYvkvpCn49/ea
	bTRhfIL3R5Q8nP6XYvzDOuTPy6N354KQxOE+fPPhdvG5BAPPeIJLun2p/qL3ztJa
	Xnx8WgRfUYj9UsiHWmRtblIfb8DKv47auLw6rq0pyUeOSVKI4AhY0NB2fsLAM+Jl
	rQxZrHmXUg8By6CeiRVCjCfpOQ9fsN9gBzHXSuQyWK5zItr5/u56Cxm7+WaxTXWx
	QN4o5xH78N7ZadTS4/P2A==
X-ME-Sender: <xms:oMD0ZwtSuhZ8gSDDIB9q2VQiUj4R6hmxbf7vomxvkZRXpTbsfn1iIQ>
    <xme:oMD0Z9fsJIfK-g99JDxQF32rVkgkFezBWl5SqPQy9OqEnYEBb6n5nIJ1koSj7iLtN
    N0snTcSWTqOY1brlg>
X-ME-Received: <xmr:oMD0Z7xZFnfJEO1LWvrsHhG9kBF1_WwQVLpAgj54R0XIjCcXF7RvUwcUA0IHwN9-EkdaVTMhV26TelSBqXq1GWUenINWfjU3RNnV5FPeCvXJbii6WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopedvtddvheesuhigphdruggvpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:oMD0ZzOJVs-8bHjVXCYwt8JOyXJ9xRBpTjXIR7iDvAcCOSDjB_Tfwg>
    <xmx:oMD0Zw8BZPgjnyIQWT1Pn2GDA15-bcyKVtNO9VNLV5ntsoI3CkPsGA>
    <xmx:oMD0Z7WJQhjnlQ7BzyO6FqSJWEWJP4HS1Jm2cLw-79L8S5QBrb8YzQ>
    <xmx:oMD0Z5fRhncB7bcXb6R3AFzCTawTA92RhgwJzD6MxoZFZffzlxKP7w>
    <xmx:oMD0Z-J0JmU2X9PV_yM0_USW-fbW683fd9i1wnJBniZPonHj_YNzvzUh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 02:22:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aef47ac6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Apr 2025 06:22:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Apr 2025 08:22:12 +0200
Subject: [PATCH v2 1/6] reflog: rename `cmd_reflog_expire_cb` to
 `reflog_expire_options`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-pks-maintenance-reflog-expire-v2-1-1ad8634798b7@pks.im>
References: <20250408-pks-maintenance-reflog-expire-v2-0-1ad8634798b7@pks.im>
In-Reply-To: <20250408-pks-maintenance-reflog-expire-v2-0-1ad8634798b7@pks.im>
To: git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>, 
 Derrick Stolee <stolee@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: b4 0.14.2

We're about to expose `struct cmd_reflog_expire_cb` via "reflog.h" so
that we can also use this structure in "builtin/gc.c". Once we make it
accessible to a wider scope though it becomes awkwardly named, as it
isn't only useful in the context of a callback. Instead, the function is
containing all kinds of options relevant to whether or not a reflog
entry should be expired.

Rename the structure to `reflog_expire_options` to prepare for this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/reflog.c | 38 +++++++++++++++++++-------------------
 reflog.c         | 30 +++++++++++++++---------------
 reflog.h         |  4 ++--
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 95f264989bb..dee49881d32 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -168,7 +168,7 @@ static int reflog_expire_config(const char *var, const char *value,
 	return 0;
 }
 
-static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, const char *ref)
+static void set_reflog_expiry_param(struct reflog_expire_options *cb, const char *ref)
 {
 	struct reflog_expire_cfg *ent;
 
@@ -207,15 +207,15 @@ static int expire_unreachable_callback(const struct option *opt,
 				 const char *arg,
 				 int unset)
 {
-	struct cmd_reflog_expire_cb *cmd = opt->value;
+	struct reflog_expire_options *opts = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (parse_expiry_date(arg, &cmd->expire_unreachable))
+	if (parse_expiry_date(arg, &opts->expire_unreachable))
 		die(_("invalid timestamp '%s' given to '--%s'"),
 		    arg, opt->long_name);
 
-	cmd->explicit_expiry |= EXPIRE_UNREACH;
+	opts->explicit_expiry |= EXPIRE_UNREACH;
 	return 0;
 }
 
@@ -223,15 +223,15 @@ static int expire_total_callback(const struct option *opt,
 				 const char *arg,
 				 int unset)
 {
-	struct cmd_reflog_expire_cb *cmd = opt->value;
+	struct reflog_expire_options *opts = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (parse_expiry_date(arg, &cmd->expire_total))
+	if (parse_expiry_date(arg, &opts->expire_total))
 		die(_("invalid timestamp '%s' given to '--%s'"),
 		    arg, opt->long_name);
 
-	cmd->explicit_expiry |= EXPIRE_TOTAL;
+	opts->explicit_expiry |= EXPIRE_TOTAL;
 	return 0;
 }
 
@@ -276,7 +276,7 @@ static int cmd_reflog_list(int argc, const char **argv, const char *prefix,
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 			     struct repository *repo UNUSED)
 {
-	struct cmd_reflog_expire_cb cmd = { 0 };
+	struct reflog_expire_options opts = { 0 };
 	timestamp_t now = time(NULL);
 	int i, status, do_all, single_worktree = 0;
 	unsigned int flags = 0;
@@ -292,15 +292,15 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 			N_("update the reference to the value of the top reflog entry"),
 			EXPIRE_REFLOGS_UPDATE_REF),
 		OPT_BOOL(0, "verbose", &verbose, N_("print extra information on screen")),
-		OPT_CALLBACK_F(0, "expire", &cmd, N_("timestamp"),
+		OPT_CALLBACK_F(0, "expire", &opts, N_("timestamp"),
 			       N_("prune entries older than the specified time"),
 			       PARSE_OPT_NONEG,
 			       expire_total_callback),
-		OPT_CALLBACK_F(0, "expire-unreachable", &cmd, N_("timestamp"),
+		OPT_CALLBACK_F(0, "expire-unreachable", &opts, N_("timestamp"),
 			       N_("prune entries older than <time> that are not reachable from the current tip of the branch"),
 			       PARSE_OPT_NONEG,
 			       expire_unreachable_callback),
-		OPT_BOOL(0, "stale-fix", &cmd.stalefix,
+		OPT_BOOL(0, "stale-fix", &opts.stalefix,
 			 N_("prune any reflog entries that point to broken commits")),
 		OPT_BOOL(0, "all", &do_all, N_("process the reflogs of all references")),
 		OPT_BOOL(0, "single-worktree", &single_worktree,
@@ -315,9 +315,9 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 	save_commit_buffer = 0;
 	do_all = status = 0;
 
-	cmd.explicit_expiry = 0;
-	cmd.expire_total = default_reflog_expire;
-	cmd.expire_unreachable = default_reflog_expire_unreachable;
+	opts.explicit_expiry = 0;
+	opts.expire_total = default_reflog_expire;
+	opts.expire_unreachable = default_reflog_expire_unreachable;
 
 	argc = parse_options(argc, argv, prefix, options, reflog_expire_usage, 0);
 
@@ -329,7 +329,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 	 * even in older repository.  We cannot trust what's reachable
 	 * from reflog if the repository was pruned with older git.
 	 */
-	if (cmd.stalefix) {
+	if (opts.stalefix) {
 		struct rev_info revs;
 
 		repo_init_revisions(the_repository, &revs, prefix);
@@ -363,11 +363,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 
 		for_each_string_list_item(item, &collected.reflogs) {
 			struct expire_reflog_policy_cb cb = {
-				.cmd = cmd,
+				.opts = opts,
 				.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
 			};
 
-			set_reflog_expiry_param(&cb.cmd,  item->string);
+			set_reflog_expiry_param(&cb.opts,  item->string);
 			status |= refs_reflog_expire(get_main_ref_store(the_repository),
 						     item->string, flags,
 						     reflog_expiry_prepare,
@@ -380,13 +380,13 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
 
 	for (i = 0; i < argc; i++) {
 		char *ref;
-		struct expire_reflog_policy_cb cb = { .cmd = cmd };
+		struct expire_reflog_policy_cb cb = { .opts = opts };
 
 		if (!repo_dwim_log(the_repository, argv[i], strlen(argv[i]), NULL, &ref)) {
 			status |= error(_("%s points nowhere!"), argv[i]);
 			continue;
 		}
-		set_reflog_expiry_param(&cb.cmd, ref);
+		set_reflog_expiry_param(&cb.opts, ref);
 		status |= refs_reflog_expire(get_main_ref_store(the_repository),
 					     ref, flags,
 					     reflog_expiry_prepare,
diff --git a/reflog.c b/reflog.c
index 1b5f031f6d7..bcdb75514d0 100644
--- a/reflog.c
+++ b/reflog.c
@@ -252,15 +252,15 @@ int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 	struct expire_reflog_policy_cb *cb = cb_data;
 	struct commit *old_commit, *new_commit;
 
-	if (timestamp < cb->cmd.expire_total)
+	if (timestamp < cb->opts.expire_total)
 		return 1;
 
 	old_commit = new_commit = NULL;
-	if (cb->cmd.stalefix &&
+	if (cb->opts.stalefix &&
 	    (!keep_entry(&old_commit, ooid) || !keep_entry(&new_commit, noid)))
 		return 1;
 
-	if (timestamp < cb->cmd.expire_unreachable) {
+	if (timestamp < cb->opts.expire_unreachable) {
 		switch (cb->unreachable_expire_kind) {
 		case UE_ALWAYS:
 			return 1;
@@ -272,7 +272,7 @@ int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 		}
 	}
 
-	if (cb->cmd.recno && --(cb->cmd.recno) == 0)
+	if (cb->opts.recno && --(cb->opts.recno) == 0)
 		return 1;
 
 	return 0;
@@ -331,7 +331,7 @@ void reflog_expiry_prepare(const char *refname,
 	struct commit_list *elem;
 	struct commit *commit = NULL;
 
-	if (!cb->cmd.expire_unreachable || is_head(refname)) {
+	if (!cb->opts.expire_unreachable || is_head(refname)) {
 		cb->unreachable_expire_kind = UE_HEAD;
 	} else {
 		commit = lookup_commit_reference_gently(the_repository,
@@ -341,7 +341,7 @@ void reflog_expiry_prepare(const char *refname,
 		cb->unreachable_expire_kind = commit ? UE_NORMAL : UE_ALWAYS;
 	}
 
-	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total)
+	if (cb->opts.expire_unreachable <= cb->opts.expire_total)
 		cb->unreachable_expire_kind = UE_ALWAYS;
 
 	switch (cb->unreachable_expire_kind) {
@@ -358,7 +358,7 @@ void reflog_expiry_prepare(const char *refname,
 		/* For reflog_expiry_cleanup() below */
 		cb->tip_commit = commit;
 	}
-	cb->mark_limit = cb->cmd.expire_total;
+	cb->mark_limit = cb->opts.expire_total;
 	mark_reachable(cb);
 }
 
@@ -390,7 +390,7 @@ int count_reflog_ent(struct object_id *ooid UNUSED,
 		     timestamp_t timestamp, int tz UNUSED,
 		     const char *message UNUSED, void *cb_data)
 {
-	struct cmd_reflog_expire_cb *cb = cb_data;
+	struct reflog_expire_options *cb = cb_data;
 	if (!cb->expire_total || timestamp < cb->expire_total)
 		cb->recno++;
 	return 0;
@@ -398,7 +398,7 @@ int count_reflog_ent(struct object_id *ooid UNUSED,
 
 int reflog_delete(const char *rev, enum expire_reflog_flags flags, int verbose)
 {
-	struct cmd_reflog_expire_cb cmd = { 0 };
+	struct reflog_expire_options opts = { 0 };
 	int status = 0;
 	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
 	const char *spec = strstr(rev, "@{");
@@ -421,17 +421,17 @@ int reflog_delete(const char *rev, enum expire_reflog_flags flags, int verbose)
 
 	recno = strtoul(spec + 2, &ep, 10);
 	if (*ep == '}') {
-		cmd.recno = -recno;
+		opts.recno = -recno;
 		refs_for_each_reflog_ent(get_main_ref_store(the_repository),
-					 ref, count_reflog_ent, &cmd);
+					 ref, count_reflog_ent, &opts);
 	} else {
-		cmd.expire_total = approxidate(spec + 2);
+		opts.expire_total = approxidate(spec + 2);
 		refs_for_each_reflog_ent(get_main_ref_store(the_repository),
-					 ref, count_reflog_ent, &cmd);
-		cmd.expire_total = 0;
+					 ref, count_reflog_ent, &opts);
+		opts.expire_total = 0;
 	}
 
-	cb.cmd = cmd;
+	cb.opts = opts;
 	status |= refs_reflog_expire(get_main_ref_store(the_repository), ref,
 				     flags,
 				     reflog_expiry_prepare,
diff --git a/reflog.h b/reflog.h
index d2906fb9f8d..eb948119e53 100644
--- a/reflog.h
+++ b/reflog.h
@@ -2,7 +2,7 @@
 #define REFLOG_H
 #include "refs.h"
 
-struct cmd_reflog_expire_cb {
+struct reflog_expire_options {
 	int stalefix;
 	int explicit_expiry;
 	timestamp_t expire_total;
@@ -18,7 +18,7 @@ struct expire_reflog_policy_cb {
 	} unreachable_expire_kind;
 	struct commit_list *mark_list;
 	unsigned long mark_limit;
-	struct cmd_reflog_expire_cb cmd;
+	struct reflog_expire_options opts;
 	struct commit *tip_commit;
 	struct commit_list *tips;
 	unsigned int dry_run:1;

-- 
2.49.0.682.gc9b6a7b2b0.dirty

