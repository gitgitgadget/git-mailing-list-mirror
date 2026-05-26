Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763953BFAD7
	for <git@vger.kernel.org>; Tue, 26 May 2026 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775044; cv=none; b=dG9vrTpXDqK62FD7JaJFy70yUyLKRrojKA7XGKIgjWI6P9ftW1YiAAzB8JzJU2u3t2d6qwXVAu96CtqQ4cfQwjOQy/AGa4CcWNHV29UiuMf5Rsneo0FcFhI7p7MJ/QIVmjWQIMKpwoGRQWUYu5BKeNleQg/t2LOPo14JJHbZrCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775044; c=relaxed/simple;
	bh=mElZI7zMmdm0ASmHE45y2POjw+COlzcT1YEPv0zSHjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lnH6PQ8QwBHLh76W063fsCcMH7416pLPKhRIfKEFSZXg9rRTFJCCpR57Z/QcQy1L2Z3XWMiVuxDCizO1u4+qtY9sPNbsXXX1CuYjVzCSb40uqZGKvTVVbaNMho8ckunUFRDdQIU2y7xiZAGRQ/cqerny0EO3ieVGwqd6A1lRFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D61DunRP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UGhG4djf; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D61DunRP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UGhG4djf"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BAF637A00CD;
	Tue, 26 May 2026 01:57:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 01:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779775038;
	 x=1779861438; bh=B+NTQbmxWeRK6a/325puout5oQosyo0se0bLv4ELjhk=; b=
	D61DunRP7TFv94NYpPpm6ssKK9ukQVOM0uO2gzyVAzcxSHXhXNJZ1xaZw4WOsbzP
	bJQwE7O9rJ6tdR6PtJwNoC+XsQfikkpQQK+OsYpv1uFcow7qoqZPTmR9qS/rZcCH
	tfgalHVCS2bJw8YyO9XPd7reLt73859kybW6iACD353vHW+WcFKmr4iAeDX2hZZp
	vJulvnhR0V2k77xnBRv8/VcbPJMgX8Oo8CQnahMcyQSe2O620bgIGgCfbEYDdhl/
	SZAAE7nHUdWgyU5+eLM1KpsqDhXd/+wZEgzYS6BHfc+/isMiK55zGGVliPVz8Ot2
	jlKQkQJB+IKwe56IvGnpag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779775038; x=
	1779861438; bh=B+NTQbmxWeRK6a/325puout5oQosyo0se0bLv4ELjhk=; b=U
	GhG4djf2qP957h/ty6pS3psoqVdtT/0j8Wgy5EGYzz9gvsA6dlRjUeI2tr9z1USJ
	T8GVrUgseYvlql7ZXnxeTyCUrPnGMF0yEvIk1TYxq7VNhJi78sPqhUb4kmpByl0g
	1yZOe3lcYlx6AlgBHe8GrCexWnlqFzk5XyYyTeyzAXG/KdhgHSGB78szSuRv17A6
	noFOeRdkeRDB/hDbZr9ObYswx3Uxl1mf+ndXsmKi6SwOPx+rck4Rq19VQNsdMsSG
	ioiV9+9KZhuRxHUFr8vRGdhPvK3BQgfEIo1/NMak5VdfbBrg/Cgf2pRQbPa4fjal
	3mhdoSj62tw3dXcC+7FIA==
X-ME-Sender: <xms:PjYVap9Lx57fWNW5WWnrOmiIzuVUq2kgyoph371HzrXAnjUSzFkvdw>
    <xme:PjYValIEMvOiJW38wuASnI15sLBxZLygetDS_15oUNDPJJpicYvpcOow2PwpMK4NH
    Y1x5PnF3vV4FDphf94oSN8SNTnrr9wEqLA3m9hj2d5FGsqYAEgJiA>
X-ME-Received: <xmr:PjYVakaLQ8iis2zIS_OMYgovWZvsqZ8nzO-xMx96mW34TvmMko0h4ag3k22fMUUBPiUUfAVYYQmC0KwV429cvNMYHJIvky7CqOuUzWvnlA>
X-ME-Proxy-Cause: dmFkZTGqV+s7APH2UOcyHrhmKoqvwvNlffKSOiADVJ3qphopUXzmz9WB+uhd8kvRj6fGOt
    PwdV3OwDCIIjXBuAbAJ5aINiGe6qOPkUFokhvK/aggOjrwBNXUFKnxQK+mQlrwGOPxfEqt
    2f6Zj7uGanL5di5UW+nZQNrz1A3MWRt6vU223vYI3FnPxXG+5+9BuQSKKbHYtLUJlH+oyM
    a6eQmpjyvNqHfILSoi/RPScZwGwUuNbjPUi9b+0jpNYZwUweMAFUzaDtmG0RCDIIF9bttt
    RwHuEuLQNnjzjrwyiZKjkmpswsjviFfPY601Oz3Y5htNkxzh92TASzYWAP18jHC/uxM3ND
    v8/8heasfF6SwQP0Laj9/+Lie8tJnXiecNPa9XO47fjnG+ltK8Ft80gRYrV2Sf74BnK25M
    +NwbbpkH2i8MM41fp/aY8jyNF+0xo3r3EP7Emyfsn31HX9FyM+ykPocKK8fe11z3RPxSY7
    eqrOl6kYLwIMs0XSq12zJUnwntKa3xL5NrmwIYvoZEtmW1Vfpe4iEkghnAJv03e3PSb6Dh
    GiarZv1Rbpk3iYpqnpRXOLwu8Ai4ujpnwkshYwr+Q1OB7P3Jj5uw/mi78d28LtvRb4wVSt
    DKPpqwC24sNKKQe8T4OjHLHGnpVYh/yfd99UPlQkq5s7wTLXZ8pwtYpdQicg
X-ME-Proxy: <xmx:PjYVanK0NfUIqG8XLljRjnn8vHnydjsKvEl9_atwBNmtGsNEQlZL4Q>
    <xmx:PjYVaiC8dUcY3w06J6usI4l63DWa1bAtBhh1e534FOFpHnzVJHXsrg>
    <xmx:PjYVaspaN2wy1LTgJo6pRxMfjDodf5FxnrKzg0WyzRiY8NZ-QBJDFw>
    <xmx:PjYVatgtLhs3swzrSqg-EHIiVuND9SI1khKpj-Yl1JYH_npw5wbaIQ>
    <xmx:PjYVaj9xnVv-OPg8gL_Ck7nWKeeq0v4URmpUu3w6SLywAPXvR2q8ulb->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 01:57:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 05b87a20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 May 2026 05:57:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 May 2026 07:57:01 +0200
Subject: [PATCH v2 6/8] setup: stop initializing object database without
 repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-pks-setup-centralize-odb-creation-v2-6-2fa5b385c13e@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
In-Reply-To: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The function `setup_git_directory_gently()` is responsible for
discovering and setting up a Git repository based on various environment
variables and the current working directory. The result is thus a fully
usable Git repository.

One oddity of this function is that we may set up the object database
even in the case where we don't have a repository, namely in the case
where the `GIT_DIR_EXPLICIT` environment variable is set but points to a
non-existent repository. If so, we call `setup_git_env_internal()` with
the value of the environment variable so that the repository's Git
directory is configured, even if it points to a non-existent directory.

Historically though, this function didn't only configure the repository,
but also initialized the object database. We retained this behaviour
from a preceding commit, even though it really doesn't make much sense
in the first place -- there is no repository, so we don't have an object
database either. There seemingly isn't much of a reason to construct the
object database, as we typically won't try to read objects when we don't
have an object database.

There's one exception though: git-index-pack(1) may run outside of a
repository, which can be used to perform consistency checks for a
packfile. The code path is _almost_ working: we already know to call
`parse_object_buffer()`, which can read objects without an object
database being available. And that works for all object types except for
commits, because `parse_commit_buffer()` calls `parse_commit_graph()`,
and that function doesn't handle the case where we don't have an object
database.

Fix this instance to check for the object database instead of checking
for the Git directory having been initialized. With this fixed, we can
now stop constructing an object database completely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 4 ++--
 setup.c        | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9abe62bd5a..0820cf5fb8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -740,13 +740,13 @@ static struct commit_graph *prepare_commit_graph(struct repository *r)
 	struct odb_source *source;
 
 	/*
-	 * Early return if there is no git dir or if the commit graph is
+	 * Early return if there is no object database or if the commit graph is
 	 * disabled.
 	 *
 	 * This must come before the "already attempted?" check below, because
 	 * we want to disable even an already-loaded graph file.
 	 */
-	if (!r->gitdir || r->commit_graph_disabled)
+	if (!r->objects || r->commit_graph_disabled)
 		return NULL;
 
 	if (r->objects->commit_graph_attempted)
diff --git a/setup.c b/setup.c
index 0dc9fe4565..4a8d6230b1 100644
--- a/setup.c
+++ b/setup.c
@@ -2043,13 +2043,12 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			setup_git_env_internal(repo, gitdir);
 		}
 
-		repo->objects = odb_new(repo,
-					getenv_safe(&to_free, DB_ENVIRONMENT),
-					getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
-
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
 
+			repo->objects = odb_new(repo,
+						getenv_safe(&to_free, DB_ENVIRONMENT),
+						getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT));
 			if (apply_repository_format(repo, &repo_fmt, &err) < 0)
 				die("%s", err.buf);
 

-- 
2.54.0.926.g75ba10bac6.dirty

