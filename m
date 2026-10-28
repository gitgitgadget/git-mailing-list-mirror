Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188965;
	b=era4BPO2+RAWTggFFIaP/JYgscb9v5t8LkefVSWmvhfIx0ZUIGAfQQs66a9mMH8YtAEb
	 BLzyEhR6vYtB5s0aQvCjaULkM/rEwEXzVWRa+hiJTKv4YHdC9I2XhBmhXS3uP2IX+IwbN
	 ZY6Ii8umJqGxmVhJY4EJKDx+JW/SpELr6RalrFsQs2n23SuOE/KDs32//mpRqKucSSu9I
	 c8+ofSEl9CdEtX9uQhgTHawfGsX8uyUJX6KqAcC94BD6wQoGvl+ITZWgKT/z324SDmIT3
	 VBI9UfJVnOUdEv0N1CvLhoR5M5OJ4PSbSEBFIGhhQ/tQwbztZVCRn0oSRuj2d8HfRmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188965;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=P0thmydYU5eK9xYfUe6KLlZs40ReS6yXBDguS/srotg=;
	b=qSiXvKa4JmgYkCi25XKudUfaAXZbC+xjIygzanVR1yMQwBCnAWcfoSVHhfmxLDrY2OjB
	 4as5Fo+ZDZ6EC3OGP2smfZeWxQ7FBYlZAo40DKLzrSD5TzP4eFFIlfJTqM6Dps8BxbkfN
	 QuDpssoq+GG8IJoGheeONEHaf7QGBh3j5Fjiafye7l3RDBoDMuc80Qby6R1e3gj4RYJ0O
	 NQB0a5LyqAffBApwFwJMLT5jL6ZNJOhuu0HDxiYbSp1J/J1HVMu+/ev2IHVzrrSMa/yEB
	 1wGcMd300umtWMOJ4MkRPqHT3IlmMRkfDneKaXyIZIy50WEYN/fm728IkqwDQNeLpng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=XmG+q1rI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=l0GCCka2;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484DD606A32A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 484DD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=XmG+q1rI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=l0GCCka2
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 899EA1400067
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 28 Oct 2026 08:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793188964;
	 x=1793275364; bh=P0thmydYU5eK9xYfUe6KLlZs40ReS6yXBDguS/srotg=; b=
	XmG+q1rIsFoHTUAzKopWG7vcPZOfFb7fWkmXUgTaChBY3Nb+7jMq+H3T9hdtgKcf
	BXOApqYP/MdLHRD3Tqr1axsqki2KY7F7epYh5yVGZQcF8Mxj23zxs/Uj8uJRe+0i
	tjnfZerV4Y357nJ8nenGF5zsEsNbE3f7Lnr9Y4nQ0IJm85mxb6wmsuC10En+J+R7
	+EdPxSY0zWaYTKsDwAgUkM3vEQM5BfMUP8/c8rX5xKAX4ucM1+XaZdDhTs8+cJ4E
	58Z1M6T4uXJnySw3KKDlvgbmEosyKo1uuLOrX0NrxbuQysNjYF79TssmEbF/BRen
	K7hJT6oYWZ0vJyEcktFU6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793188964; x=
	1793275364; bh=P0thmydYU5eK9xYfUe6KLlZs40ReS6yXBDguS/srotg=; b=l
	0GCCka22xgqpTGD0F5gQl0Hs/CZ9vgYaYuqIFkcuBP/+/z2zgG85v6kOCrr2h73g
	hpLkcf0oFH1OHcfcAFhZ36vHSDzOXffBG2sKB7Z1dnUskYqZSnoHd33QCYf3/+54
	J/zaafFHqxkUv/ksohitZiFFIj1UzGiUCaLRWERqB5q2fqFPycTWqsNJhV63iqHW
	cyAOBWyCYWFZN+AxNDbYUARNqlTJhhzcI1HJjiZLNn05noEaYV4HWSCOYluUxdJG
	kptufw/Be4F9UfHmK1beSpCM+OmLr7V4y9PtJZLzuj5ZtFCbY82nnpcaoWfI79xJ
	BbAxzNDKFkXYAWndAEWkw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793188964; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NMRV5LU+76f2mF4E1kfb7GMKc76nYjuScI4s43jpAXi5Bex
	JoZ3udbwSnTGN7Z6Vqhb55ubkb+m+0OFq+HenrKO6qIt436avolDYUzar0QRfI9W
	3yWpYxWGI8vXZBMrjRp5FkGEtbZ//ZT8Hc7x2LKiR3GaQqnbYpeugymU45Y4QxBQ
	+kv3eTR/T1h1l/fKFEqq0vkTptAJ24sAsGSe1VtdlJPOl7mZMteC2aaCDyO+Mrni
	bE/9OaicUeBRoSn2MhgvWAYEfSehwI8oNYHxudXrkRpelMFX3P5cwsvLhfvqiuy6
	LGRWADGxyUSTlO5uofgCsTqkvAlS8QN0kgYL8Yg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nVBxNQpEeqGYRam53FC0L0iY/hfNKzrE7khwE1wsv6Q=:MPiJgIyUcb0hjm/P9QbgqlymsgnWSS+txx14JLd6RYA=;
X-ME-Sender: <xms:ZOThaq--xV3TW0GnViQm8JBl1NwXAb0YDoNtCUduQvr7qaOx0Lu01g>
    <xme:ZOThahp_d8g0DlHCyziS4FMRwihcFIRwc89n9x1W2sk4UkNrBV-R4p9TkrQE3xd_t
    N-WBwd3FxmWaKOetb2h2Cqkdj6MbvvuE6XAgSLIqtkg3tBfbfIsOA>
X-ME-Received: <xmr:ZOThalrlLOt0FQrw7dWzuurnn07x3VamuqFL3xg17LYuERxG3T8W7g>
X-ME-Proxy-Cause: dmFkZTF2Mc3g8z5gD8+pUCnfHo0lMqlp5+WCfQ6DsmMs7ZRLfmLWaPAYb3OxASUOPEyWii
    rrGgpP73XAFgqgFdZiQVcNzt70BknD6/ZmmrBAMiD3EdIwO8hYWgJwBghKUmNI97PfWjJD
    dgtYN9YY/E9q22Yhy2fa1Ym1d7UZTvT8Vq/JeZlfbe+TNu5Z8lvZt2oScPfQq0wGB7wmKU
    8IuWikhTGkGoqr4o6kk9jMI6s5BGPq64SYLjB8oDNH2FzUqfRY7ONmZsx4k/2aG8zqU7e+
    d/F1HDktwSDIEvNqnYSx2X+hHzOrsWqsioMfYGiJmCA0Ad0vys5hak9zDzQvBEnHvC85ru
    zBCh10ThPPFh9UjI7OxVfeD5Kg4NBUGRTg1EAAmqAPiHcET6WfSIXmxuY+cazEKHw4NY6Q
    fF+/6Kt+iFphkwHGJClYXp96qTuljCiawAMXVqkO9XBBHa1bMQYUGjwZJUJUi6nI56++qy
    sPf1dsb+NIQoOZKSebFTkbtTwvboYv5HVBlTMqdBIYO6lwid5hcEGcRGCQCkMEoCzeML3z
    HTuwHb+85100kXo7zCFvC/X5xAmbPPl+QmF7o3utjED4nG5Cmx1dcBtWp/C45fCgUEyboQ
    AuVYIQfazSjaa2E6BNxUVnDKbwJhrTh2lmavCBIS8B/0xMfZZivpTcglX49w
X-ME-Proxy: <xmx:ZOThankEmlvE9koW6yeeEUUOn-Cg8y2Kppp4nXhjKIq8RljuV8J_Rg>
    <xmx:ZOThavGSSQ_qeg4R8iUCzDs9M3t6IjkmLRNIrci6NfM2Llmd8fm1hA>
    <xmx:ZOThaooDL9LqYv4XAgz7AA1YCeq82E_A_22kx5xgRnQU3KEImJR4eQ>
    <xmx:ZOThaj6HabksBxgaYOKbXImnBz5SMRtJ_SmS9TYewFGZvCfaxB_UdA>
    <xmx:ZOThaitk7D5Jc7SlJP0q9MiHrOQVOtj_r4S_XlJhIulFwaVdJVhNGotb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 28 Oct 2026 08:02:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d79f7f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 28 Oct 2026 12:02:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Oct 2026 12:57:55 +0100
Subject: [PATCH 3/7] builtin/commit-graph: get rid of `the_repository`
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
Message-Id: <20261028-pks-commit-graph-cleanups-v1-3-c549344c363f@pks.im>
References: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
In-Reply-To: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

There are a couple of references to `the_repository` in
git-commit-graph(1). As that command cannot run outside of a repository
these references can be trivially replaced by the repository that's
passed in as parameter to `cmd_commit_graph()`.

We don't have to worry about the repository being `NULL` when called
with "-h", either: we do pass the repository to `repo_config()` before
calling `parse_options()`, but that function can handle a `NULL`
repository alright.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 14f9db5456e..f8825980f40 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "commit.h"
 #include "config.h"
@@ -68,7 +67,7 @@ static struct option *add_common_options(struct option *to)
 static int cmd_commit_graph_verify(int argc,
 				   const char **argv,
 				   const char *prefix,
-				   struct repository *repo UNUSED)
+				   struct repository *repo)
 {
 	struct commit_graph *graph = NULL;
 	struct odb_files_dir *dir = NULL;
@@ -100,13 +99,13 @@ static int cmd_commit_graph_verify(int argc,
 		usage_with_options(builtin_commit_graph_verify_usage, options);
 
 	if (!opts.obj_dir)
-		opts.obj_dir = repo_get_object_directory(the_repository);
+		opts.obj_dir = repo_get_object_directory(repo);
 	if (opts.shallow)
 		flags |= COMMIT_GRAPH_VERIFY_SHALLOW;
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
-	dir = odb_source_files_find_dir(the_repository->objects, opts.obj_dir);
+	dir = odb_source_files_find_dir(repo->objects, opts.obj_dir);
 	if (!dir)
 		die(_("could not find object directory matching %s"), opts.obj_dir);
 
@@ -117,7 +116,7 @@ static int cmd_commit_graph_verify(int argc,
 	else if (errno != ENOENT)
 		die_errno(_("Could not open commit-graph '%s'"), graph_name);
 	else if (open_commit_graph_chain(chain_name, &fd, &st,
-					 the_repository->hash_algo))
+					 repo->hash_algo))
 		opened = OPENED_CHAIN;
 	else if (errno != ENOENT)
 		die_errno(_("could not open commit-graph chain '%s'"), chain_name);
@@ -129,9 +128,9 @@ static int cmd_commit_graph_verify(int argc,
 	if (opened == OPENED_NONE)
 		return 0;
 	else if (opened == OPENED_GRAPH)
-		graph = load_commit_graph_one_fd_st(the_repository, dir->abspath, fd, &st);
+		graph = load_commit_graph_one_fd_st(repo, dir->abspath, fd, &st);
 	else
-		graph = load_commit_graph_chain_fd_st(the_repository->objects, fd, &st,
+		graph = load_commit_graph_chain_fd_st(repo->objects, fd, &st,
 						      &incomplete_chain);
 
 	if (!graph)
@@ -171,17 +170,19 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static int read_one_commit(struct oidset *commits, struct progress *progress,
+static int read_one_commit(struct repository *repo,
+			   struct oidset *commits,
+			   struct progress *progress,
 			   const char *hash)
 {
 	struct object *result;
 	struct object_id oid;
 	const char *end;
 
-	if (parse_oid_hex(hash, &oid, &end))
+	if (parse_oid_hex_algop(hash, &oid, &end, repo->hash_algo))
 		return error(_("unexpected non-hex object ID: %s"), hash);
 
-	result = deref_tag(the_repository, parse_object(the_repository, &oid),
+	result = deref_tag(repo, parse_object(repo, &oid),
 			   NULL, 0);
 	if (!result)
 		return error(_("invalid object: %s"), hash);
@@ -228,7 +229,7 @@ static int git_commit_graph_write_config(const char *var, const char *value,
 static int cmd_commit_graph_write(int argc,
 				  const char **argv,
 				  const char *prefix,
-				  struct repository *repo UNUSED)
+				  struct repository *repo)
 {
 	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
@@ -277,7 +278,7 @@ static int cmd_commit_graph_write(int argc,
 
 	trace2_cmd_mode("write");
 
-	repo_config(the_repository, git_commit_graph_write_config, &opts);
+	repo_config(repo, git_commit_graph_write_config, &opts);
 
 	argc = parse_options(argc, argv, prefix,
 			     options,
@@ -288,7 +289,7 @@ static int cmd_commit_graph_write(int argc,
 	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
 		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs"));
 	if (!opts.obj_dir)
-		opts.obj_dir = repo_get_object_directory(the_repository);
+		opts.obj_dir = repo_get_object_directory(repo);
 	if (opts.append)
 		flags |= COMMIT_GRAPH_WRITE_APPEND;
 	if (opts.split)
@@ -301,12 +302,12 @@ static int cmd_commit_graph_write(int argc,
 	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
-	dir = odb_source_files_find_dir(the_repository->objects, opts.obj_dir);
+	dir = odb_source_files_find_dir(repo->objects, opts.obj_dir);
 	if (!dir)
 		die(_("could not find object directory matching %s"), opts.obj_dir);
 
 	if (opts.reachable) {
-		if (write_commit_graph_reachable(the_repository, dir->abspath, flags, &write_opts))
+		if (write_commit_graph_reachable(repo, dir->abspath, flags, &write_opts))
 			result = 1;
 		goto cleanup;
 	}
@@ -329,11 +330,11 @@ static int cmd_commit_graph_write(int argc,
 		oidset_init(&commits, 0);
 		if (opts.progress)
 			progress = start_delayed_progress(
-				the_repository,
+				repo,
 				_("Collecting commits from input"), 0);
 
 		while (strbuf_getline(&buf, stdin) != EOF) {
-			if (read_one_commit(&commits, progress, buf.buf)) {
+			if (read_one_commit(repo, &commits, progress, buf.buf)) {
 				result = 1;
 				stop_progress(&progress);
 				goto cleanup;
@@ -343,7 +344,7 @@ static int cmd_commit_graph_write(int argc,
 		stop_progress(&progress);
 	}
 
-	if (write_commit_graph(the_repository, dir->abspath,
+	if (write_commit_graph(repo, dir->abspath,
 			       opts.stdin_packs ? &pack_indexes : NULL,
 			       opts.stdin_commits ? &commits : NULL,
 			       flags,
@@ -371,7 +372,7 @@ int cmd_commit_graph(int argc,
 	};
 	struct option *options = parse_options_concat(builtin_commit_graph_options, common_opts);
 
-	repo_config(the_repository, git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
 	disable_replace_refs();
 	save_commit_buffer = 0;

-- 
2.56.0.341.g393f52fd96.dirty

