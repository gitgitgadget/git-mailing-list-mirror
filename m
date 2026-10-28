Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188978;
	b=tM/fYnk80ncs7GnSpSLQtu25WTzVwClJ8Lf0BhFQ/jddHffLSwKv2LX56/0qF1xYE7id
	 793hIBrV77vnH8X/TmOqj3iV24/QwYqD3gcLOjb2gqTKbLTBPHgQkdMRM+SQd35YNLONY
	 GqoSoLnxqafCmtvmfL/MWldJfvT6mWf24rMzplvK882eERjNrMUP4+Ug+LXu3MvK+F8Si
	 jlsszPViHU+94GI6ZnDvJKn8WrA4E/NcPzPX8hF62U7qVqsmivnwpVzOaCTlmbRN5VqGb
	 QwVI8HoR3aN79vmJMLNrmhb6Pl21LN9HX/Ap4ln5+L/ZbB0ieG2yueVw+BkG9OeYLrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188978;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Qd+fSxyUq8qMlx5xfDd2ItaZ4NMKlpNGjV1RiR2RLVM=;
	b=4O2fZtuh89z4lx/kPmS4iAoDWk60eXYdHlo1qK/88lzA1O5gtxA7V91DILfldKfDqr1p
	 hTiyim+J3cvSy+1e1rbqR/M4mrQJwkRPTqS0le5KUMZL763lQ7PL6UZObeqAhJ2eHvOIz
	 zvUh+lC3pz/kKYNF+Hs66fPyOWq5ePdbAd/v0UO8eVCLDOnx94RQba9wXJW50Zi44YbR9
	 eQMAYtrVhcrsJm+IfzLDTD2OwNKrquZPTTHPaOGTFVvygCzemQnuqxgnOHH8lAIVFZCsC
	 7JvdRUc1TPysUYS37mYW+S9b9QqU+vBQ88SNUYnq5Mr8fkDs8AGByu4Rs1dBXrznEWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=TNr1QxcF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JxZFb4TL;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64045606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64045606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=TNr1QxcF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JxZFb4TL
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 90179140010B
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 28 Oct 2026 08:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793188977;
	 x=1793275377; bh=Qd+fSxyUq8qMlx5xfDd2ItaZ4NMKlpNGjV1RiR2RLVM=; b=
	TNr1QxcFximHzKOacNHcsaj0rVlXKdvO9nvgAzeZR8WHjcMqcfia0XVzcvQ2u8MW
	EU8VmXgLoRWbOIxs1GfFh9zB12Usgh68UHb9FTgQV5TDg1LH6w7EqIu/qI7YVd/b
	r7RUGoJ0fRcqWTHcZALvXx+n0CV2JLMxpi705IswLnu4sSWJJ6GfzOWWIRQiKJSt
	/4XO2wCYbvE83ghbSRijUZNzifTQNzTNmq6vr4m09A+di2W6sBb6NDgiBDq22hai
	NKR2UQ8gDjpOjcvdHEfgazVCG6PedcBhOIOCi+RUZXf73VXoEOQe5TwkzXa87WXP
	+rCS23jM3l7P/XsMVfhycw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793188977; x=
	1793275377; bh=Qd+fSxyUq8qMlx5xfDd2ItaZ4NMKlpNGjV1RiR2RLVM=; b=J
	xZFb4TL3gpoBZRIaiAhRk8HUnWNuv+QpVlevx93dD3Pi37SVNAuN0VmUYdiY9ySV
	pZGHJodfUJo1xZHRFzxPUl8LuWxfcCI86/++e2OA2AbiQCmrB4XB5tNWAxHXjTsr
	r/E5aI8IIpveVwm+ToU3RkbThpSRZMQjbxqynd+7gqSYX11vUOhFcVLFMRRyJqg+
	ECSZ/FDu3FUnOnBm4XOd2ditD6IsW9q2T6H33+LpAD/NZFcrUR/DeDXn1JaZ3ukA
	lZ/z3V0tbcFz56yoVLXH23jjsLpzEYLt6Bv8aKXAeIj/F+g5lANjfM2GVvAb3HOE
	AhO5NECfEnKnuRqHhY2kQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793188977; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vmXtYAAm4/74DKpyQzmvHqWP9DuVPavcJiw27VYdY3oWPX2
	85zxV5V9uc4FgxposiBw79ThiIGi5dk+E/cBnK2pqdlfrYtvr2U8PZ14ThlJ2rwP
	yX4fZ5nR7P+yU/OprzLlGwIlsaFGv0CRjlC+jKOzA4FFJS3aPYq7IiYg94dAl1QN
	Cws5mdkejaujyppQECqJqwOpG9AY8bOL0ehiHSQL4YbYz2vG02T7UoG8rLYPeuGO
	bfkhnU+lqI2pyWutz7DltCIvYNsecIZgVOIGKjUlFB8thMeZYbtrsSbp78Azattv
	CaAsf9Qj4ylEQrL10XsuzLH92SY+Cg2SjDrcuBA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2hqlmrNTNcriZcoVQLMc7tcz5mHed18kZ7BzTi3UXSo=:kOAbuY5yehiEEfxgkCDt6kcy/Tj7rVPZAbUTu7xJRuI=;
X-ME-Sender: <xms:ceThanNPuVykuNTnGw-3zt7Ub5gqWsT5w7JkwTeq-6nkr9uWSPjq9g>
    <xme:ceThao467JZrGzej-N9O4rb3fi49kKjNQBktugxQqsouf1lmGJBsR0qRs_HitdDBM
    oJiRaOrPO8H06cSrMz_pX-shYXhYY44db-jMZYDFe6GWK5QPZcXDBY>
X-ME-Received: <xmr:ceThar7tOho0g0OUcMaK4bLQZZio1AFIdbwD6FHFugjAL-oOlpa8rw>
X-ME-Proxy-Cause: dmFkZTF2Mc3g8z5gD8+pUCnfHo0lMqlp5+WCfQ6DsmMs7ZRLfmLWaPAYb3OxASUOPEyWii
    rrGgpP73XAFgqgFdZiQVcNzt70BknD6/ZmmrBAMiD3EdIwO8hYWgJwBghKUmNI97PfWjJD
    dgtYN9YY/E9q22Yhy2fa1Ym1d7UZTvT8Vq/JeZlfbe+TNu5Z8lvZt2oScPfQq0wGB7wmKU
    8IuWikhTGkGoqr4o6kk9jMI6s5BGPq64SYLjB8oDNH2FzUqfRY7ONmZsx4k/2aG8zqU7e+
    d/F1HDktwSDIEvNqnYSx2X+hHzOrsWqsioMfYGiJmCA0Ad0vys5hak9zDzQvBEnHvC85tZ
    J6wVX0Lud1hgFBi+Z9qQg5TYTkiJR55Jh2jnDnFR1sIlxlQIssvEkAV5zKmGH3jN0R6L/C
    prjfn/AFxyZ2TdjxqEoN3Oh3XZsnaSrkeYgfdI0S87+lR6sgkcxMd3vHnTiCsBMhyPCiGC
    xM06E/TNCbAJPjVAZwaa+D+pugH78pPsjNJlY4CHL/9dPbROhSuB4qBV9zM/vgZtMb32oe
    DYPzqBs+tQ9/G6hnpxrtME0cYoKdhl4fslRJ2H5Gga5OfkhFBngGe5yMp3FpKWrGsraimZ
    sqXVdNBVMYgAmE9LHD3deSZXKR7GwygXjhxrGmA2MNQP1ullrquPITQdYAIw
X-ME-Proxy: <xmx:ceThag1vTXTZaLe6qkWDA3iZeZDpdC-_xXFPPsGFcBbtAxx9-ZC33Q>
    <xmx:ceThavXr3l1E1vIyS4hwzigKW4CThUEOTOsd5RDZq7o86DTweyt8Aw>
    <xmx:ceThaj6Cb_1VQYw20MgYBqW0daWqfPUjhPZOYY8kPPU5-z60OhEKcw>
    <xmx:ceThauIxpfusqomyNUgJGILFIQHfSrwaIpKtvKMuaX7Ztb4LthXzdQ>
    <xmx:ceThar-bX7arPSeoJkwXBOYdgVALY437ti79rHNtocdUuaHB6VVdJOBu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bcaa733c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 28 Oct 2026 12:02:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Oct 2026 12:57:59 +0100
Subject: [PATCH 7/7] builtin/commit-graph: de-globalize options handling
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-pks-commit-graph-cleanups-v1-7-c549344c363f@pks.im>
References: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
In-Reply-To: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Same as in the preceding commit, de-globalize handling of options that
are common to both the "verify" and "write" subcommands. With this
change we don't have any global state in "builtin/commit-graph.c"
anymore.

Same as in the preceding commit, this requires us to drop the `static`
modifier for the options array as it references a local variable now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 2126619ad3e..4d28a9d51ec 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -40,7 +40,7 @@ static char const * const builtin_commit_graph_usage[] = {
 	NULL,
 };
 
-static struct opts_commit_graph {
+struct opts_commit_graph {
 	const char *obj_dir;
 	int reachable;
 	int stdin_packs;
@@ -50,7 +50,7 @@ static struct opts_commit_graph {
 	int shallow;
 	int progress;
 	int enable_changed_paths;
-} opts;
+};
 
 #define COMMIT_GRAPH_COMMON_OPTIONS(opts) \
 	OPT_STRING(0, "object-dir", &(opts)->obj_dir, \
@@ -62,6 +62,9 @@ static int cmd_commit_graph_verify(int argc,
 				   const char *prefix,
 				   struct repository *repo)
 {
+	struct opts_commit_graph opts = {
+		.progress = isatty(2),
+	};
 	struct commit_graph *graph = NULL;
 	struct odb_files_dir *dir = NULL;
 	char *graph_name;
@@ -72,7 +75,7 @@ static int cmd_commit_graph_verify(int argc,
 	int flags = 0;
 	int incomplete_chain = 0;
 	int ret;
-	static struct option options[] = {
+	struct option options[] = {
 		OPT_BOOL(0, "shallow", &opts.shallow,
 			 N_("if the commit-graph is split, only verify the tip file")),
 		OPT_BOOL(0, "progress", &opts.progress,
@@ -83,7 +86,6 @@ static int cmd_commit_graph_verify(int argc,
 
 	trace2_cmd_mode("verify");
 
-	opts.progress = isatty(2);
 	argc = parse_options(argc, argv, prefix,
 			     options,
 			     builtin_commit_graph_verify_usage, 0);
@@ -140,23 +142,24 @@ static int cmd_commit_graph_verify(int argc,
 
 struct commit_graph_write_config_data {
 	struct commit_graph_opts *write_opts;
+	struct opts_commit_graph *opts;
 };
 
 static int write_option_parse_split(const struct option *opt, const char *arg,
 				    int unset)
 {
-	enum commit_graph_split_flags *flags = opt->value;
+	struct commit_graph_write_config_data *data = opt->value;
 
 	BUG_ON_OPT_NEG(unset);
 
-	opts.split = 1;
+	data->opts->split = 1;
 	if (!arg)
 		return 0;
 
 	if (!strcmp(arg, "no-merge"))
-		*flags = COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED;
+		data->write_opts->split_flags = COMMIT_GRAPH_SPLIT_MERGE_PROHIBITED;
 	else if (!strcmp(arg, "replace"))
-		*flags = COMMIT_GRAPH_SPLIT_REPLACE;
+		data->write_opts->split_flags = COMMIT_GRAPH_SPLIT_REPLACE;
 	else
 		die(_("unrecognized --split argument, %s"), arg);
 
@@ -213,7 +216,7 @@ static int git_commit_graph_write_config(const char *var, const char *value,
 	if (!strcmp(var, "commitgraph.maxnewfilters"))
 		data->write_opts->max_new_filters = git_config_int(var, value, ctx->kvi);
 	else if (!strcmp(var, "commitgraph.changedpaths"))
-		opts.enable_changed_paths = git_config_bool(var, value) ? 1 : -1;
+		data->opts->enable_changed_paths = git_config_bool(var, value) ? 1 : -1;
 	/*
 	 * No need to fall-back to 'git_default_config', since this was already
 	 * called in 'cmd_commit_graph()'.
@@ -230,8 +233,13 @@ static int cmd_commit_graph_write(int argc,
 		.size_multiple = 2,
 		.max_new_filters = -1,
 	};
+	struct opts_commit_graph opts = {
+		.progress = isatty(2),
+		.enable_changed_paths = -1,
+	};
 	struct commit_graph_write_config_data config_data = {
 		.write_opts = &write_opts,
+		.opts = &opts,
 	};
 	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
@@ -251,7 +259,7 @@ static int cmd_commit_graph_write(int argc,
 			N_("include all commits already in the commit-graph file")),
 		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
 			N_("enable computation for changed paths")),
-		OPT_CALLBACK_F(0, "split", &write_opts.split_flags, NULL,
+		OPT_CALLBACK_F(0, "split", &config_data, NULL,
 			N_("allow writing an incremental commit-graph file"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			write_option_parse_split),
@@ -270,9 +278,6 @@ static int cmd_commit_graph_write(int argc,
 		OPT_END(),
 	};
 
-	opts.progress = isatty(2);
-	opts.enable_changed_paths = -1;
-
 	trace2_cmd_mode("write");
 
 	repo_config(repo, git_commit_graph_write_config, &config_data);

-- 
2.56.0.341.g393f52fd96.dirty

