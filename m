Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807883;
	b=aW7INaAmn1w+bHswXwiCQJ9qtqS8j3JX/nam8s1P0Q5WJdbSgunxErwmbygzRhDqzLwL
	 OM4Gp2733a3HXgQGfcgQTzRuxPxrQXM4DpVI9u6AmfxmbwxTvclFCYkr7V4pRVVu4afnh
	 hlqMU4R2xO9l6TvX53iaqzDPdiBa0WLhSY9j3cODMX0Hfl+Dfk/ovqc7q6p0wnXQjc/NT
	 pxePqqlUi8F5GYSM0S15Fa1fp6VE+TfRrFEn/MMGK/ZMSVL2+4tGDL2LuwxCWEgAcxFiY
	 8k4aUNnnEAdv40mzjmic7ji1TI43O5W1fMt734GrmE7XjiYChiqluVijvqtNfo1UD4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807883;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=z4kd1QmgLkZBItet8SFFoiUkIDIr11TOfRIB7AfqGwg=;
	b=wWTlmpvythSMNpbtMQNgRDSNHEgUqoR9wgCVikSWbMHDBuGYIWYi1pHkJrPnNKk64BuZ
	 K/HFw4X8wgwEdFJVYnfiwLBMpIHqSKH3quVqtyuyKrw8jgcbKuMkwrBSvdS9Mby4K+ngN
	 7Ur7TSY25y3FU4p8Ugq+GlKJJTMHVAFja5jWzlLJgoR5thecLZPOhnGbQ5xjpo2PXKLX0
	 PbeydvLgfyyU+5R6eTLOyXXQwfJE8F/VnC5D7Sc6ZQ1jMLabnpjTCBzLjk0JXp5d2dtBg
	 bnYfk0/oAg0heYQPpMAAWSMdzajPwfjuiBwCsbsI3Gv3hgz+1Plb5YSYlrLl+k8rGRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=MgEfe+TZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lR2UYVfz;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32036082BDB
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D32036082BDB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=MgEfe+TZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=lR2UYVfz
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1EA891400171
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:58:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 10:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793807882;
	 x=1793894282; bh=z4kd1QmgLkZBItet8SFFoiUkIDIr11TOfRIB7AfqGwg=; b=
	MgEfe+TZfaD+9hJq02W2U1WH8gyWdeDa0LKKKyDWW79XqVV08bl6T5Elq9MrFKzv
	bbxpveeQsO4yia7rmMyxJZANiEIMnFdu2OkEyRe8lyEtNKH0E0uirlIHHayn4nsg
	K6hcQOIK5tY9Ps9hanksholYNTYVGa1DHl73cmnXJiQXuIQnMNHXDuHDQf+/RTNu
	nwDlI1XdqA/8RtFz4QFzqbYIngWy2svY9TySf5cJ+yh8Y+YV+YzPNtl50tHM1DT6
	beIA7KCDBQ8g4P3o87GqQGwaI8e0GQ/er0h+51GErI5wZZ6ezZdE0Ziu39kdgyXv
	KxMplvHBs8WJXnfCfOTN+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793807882; x=
	1793894282; bh=z4kd1QmgLkZBItet8SFFoiUkIDIr11TOfRIB7AfqGwg=; b=l
	R2UYVfz5WgZO+xvOZbG7adXGF5NpmQ3h9zTitXU3msE41Oz79gVJ5mWAIqWEVHPp
	tDd7srtsD8pR4rvNHr8GoD6gszR7rgr7Us7hIDP7TTY+YMcNnSvf+M0XYDMW3Z13
	e5WdzKximCPUfETLhviiV2GOKJWOWtp4OYabsOmMVBA2RozMUHqCexTIoVFE1rfk
	TM18MWYyAI4E0Iw0rGoRfnj3j/VInvC5WhL5xhmetO/P7ng/ESXodH/g4LHRRd95
	QPwx5h12GG8dSTZ+Ym0IC31pF80Yi2nolROrql4RDLuJA8WayI3TAK5QPUCTmFtY
	jrJHfNzu/tv3FaKYmQLLg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793807882; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:o8d2kFpfbPmhx3vsZHEfyglA76xJlBgGF62NiJgylXEEcoK
	bieSiNhfRUsHDWNUUKxjzaebUWYtHswY5NNvtcRBElu4Vjg0z0aqs76OjrcYyVDF
	Ki8JAuzBDvInn9ZIzuToVXddH+l1cXuCUT6IdKvTzgmoOPAuDJNa0gpwQKS1MI9R
	eAVXZFohke+RTNvKBDQVh/l7dbCEvM/z8+PUlqnfLZUdi+ijcNLp8SewFCDNl2jB
	jwjx/Sg+I5l5ShL+W2AUcrwCC7vo8rSro6HYB4UpWjkd1ND+c8tVPOGCW1EjI6vW
	AwzHWDMiz+zdp0+vjXR7ftIydxKGP5srwJg11Mw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:f2s7YZ8+i8kWhHqbtkqegxwwr+QUEHTFopBdobrMbNs=:Jg1dohCz8kULFkWELFL+FuwFdP2fPtgS/wBWa/hBCrM=;
X-ME-Sender: <xms:ClbrapoIeBikbhifKlpchrBTCccBYkFvtugmd6IYtBDszhGhsuQ5Cw>
    <xme:ClbraikabmNPZhNOT0YSQwfDzUgwAgsXHKezjrcN7ggLx_i5By6g2UpZebDiJmLI2
    53kC2YbBXLMg_fAlDNLE4QWibaPb5Z_PXKtx4J0HnRwNGz4K1Uzg2Y>
X-ME-Received: <xmr:Clbrar1kUGkaRbOdj4hEs2rCm8SaJOWV1oJtRdXNfQcYWLkvA8Z0vQVInJPAQWhb2Lelrks>
X-ME-Proxy-Cause: dmFkZTEijChPbfh12L7GHgr1wrlICXQjT2WvPmwEzxfsGQeLnPBN5oSEwqQKp1JrSMf4h2
    DTN/FhucVO/TQWnw9AZiUtvh8J+fsiLopNU0yraxvKr/Q5k6FwxtXHmQHlwXcQwI9Lgxa2
    KpQciHVAjeQsDLrFiis2meieS5nomLtKrrgC2Bfp/5mKeU/162bo79wFoJ0Cq01G8nOoTz
    k5sL5HSaBb+b4flS4nj1fvAsLywsdoo6Dhiicp1vKE1NVHIIUp/v+/Aah8Go+J72JZTS+p
    B8AZs+BBkJIvGkshYWCxV+sfbpqUheUXpJxmAzqikWEJhVTHdVWlEIBaAQ/FD3Gk7XlqSL
    5r0zOEEkauVxxOHH7Ls8A9TqMbArnSFOEB+lF642pYAONIxklK1KZScvTpn791q3+kRn9j
    wSjyh25q4yK4UHbV13Bt2IFu+Mxy7zVZd2dbglxeFBEilqcXuk2/XKPzwDDkRz/8x8N8rt
    MCcPxKrkc7iC4NciYXPR8aeniY6leXoROOI8lhXxEZSdCci2ezGcLVKwm5PD3HP1W7WD3f
    94k00vFgdXEUnurHInEBc4o4q0YUG7riqQUa816UQTNae9k7YucdevQGlz5OSPCG9e0UPj
    N0Lbl8f6y9RPDZsUf016xygCkQqFW/S+pmQlmOPSliroS0hMrKsv1lXBSmDQ
X-ME-Proxy: <xmx:ClbraqAzbj4vnzCciD-FYothHMzACpaYxNuwSCZhjkBQpQ8EtvF-IA>
    <xmx:Clbraoyw8o_69Ty1P88F36Bf7zQC35_lWe7n3w4AWVISWDhdolI6lw>
    <xmx:ClbraongrT8caqAEVmZ7vsO1qvNW4v0spD7XSSITVP16PS926Q8MbA>
    <xmx:ClbratG5DjDQyFpw_1e04xJlAPbjwZe3zKQlmWfNqFTE0CRZppAazQ>
    <xmx:ClbrahKr1nyTwALkEJMwNzrUxy89FF_vpkyyfg6rd53svROvToh6wWKm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Nov 2026 10:58:01 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df0b7413 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Nov 2026 15:58:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 04 Nov 2026 16:57:31 +0100
Subject: [PATCH 09/10] odb/source-files: verify commit-graphs as part of
 fsck
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
Message-Id: <20261104-pks-commit-graph-write-refactorings-v1-9-d013d9401a59@pks.im>
References: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
In-Reply-To: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

git-fsck(1) verifies commit-graphs by downcasting the object database's
source to the "files" backend and spawning `git commit-graph verify
--object-dir` for each of its object directories. But starting with
14bf3a43f8b (Merge branch 'ps/odb-pluggable-fsck', 2026-09-15) we have
adapted git-fsck(1) so that the verification of the object database is
pluggable.

In a subsequent patch series we're also about to make commit graphs
themselves pluggable so that a backend can choose where exactly a commit
graph is stored. As part of that, we'll also have to make verification
of commit graphs pluggable in the same way.

Move the verification into `odb_source_files_fsck()`, same as we did for
multi-pack indices, bitmaps and all the other auxiliary data structures.
Same as when we adapted consistency checks for those, there are a couple
of consequences here:

  - Commit graphs stored in alternates are only verified when
    `ODB_FSCK_FULL` is set, which is the default for git-fsck(1).

  - Commit-graphs are not verified with `--connectivity-only` anymore,
    as that mode skips the object database checks altogether.

  - Failures are reported via `ERROR_OBJECT` instead of a dedicated
    exit code bit, same as we have dropped `ERROR_MIDX` et al. Those
    error codes were never documented or exercised anywhere.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c     | 20 --------------------
 odb/source-files.c | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 710780e35a8..c4558efcf18 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -46,7 +46,6 @@ static timestamp_t now;
 #define ERROR_OBJECT 01
 #define ERROR_REACHABLE 02
 #define ERROR_REFS 010
-#define ERROR_COMMIT_GRAPH 020
 
 static const char *describe_object(const struct object_id *oid)
 {
@@ -913,7 +912,6 @@ int cmd_fsck(int argc,
 		fsck_enable_object_names(&fsck_walk_options);
 
 	repo_config(repo, git_fsck_config, &fsck_obj_options);
-	prepare_repo_settings(repo);
 
 	if (check_references)
 		fsck_refs(repo);
@@ -984,24 +982,6 @@ int cmd_fsck(int argc,
 
 	check_connectivity(repo);
 
-	if (repo->settings.core_commit_graph) {
-		struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
-		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
-
-		for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
-			child_process_init(&commit_graph_verify);
-			commit_graph_verify.git_cmd = 1;
-			strvec_pushl(&commit_graph_verify.args, "commit-graph",
-				     "verify", "--object-dir", dir->abspath, NULL);
-			if (show_progress)
-				strvec_push(&commit_graph_verify.args, "--progress");
-			else
-				strvec_push(&commit_graph_verify.args, "--no-progress");
-			if (run_command(&commit_graph_verify))
-				errors_found |= ERROR_COMMIT_GRAPH;
-		}
-	}
-
 	free_snapshot_refs(&snap);
 	return errors_found;
 }
diff --git a/odb/source-files.c b/odb/source-files.c
index 5b4277fbfd3..224b47e38b1 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -1215,6 +1215,30 @@ static int odb_source_files_generate_pack(struct odb_source *source UNUSED,
 	return 0;
 }
 
+static int fsck_commit_graph(struct odb_source_files *files,
+			     struct odb_files_dir *dir,
+			     struct odb_fsck_options *opts)
+{
+	struct repository *repo = files->base.odb->repo;
+	struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
+
+	prepare_repo_settings(repo);
+	if (!repo->settings.core_commit_graph)
+		return 0;
+
+	commit_graph_verify.git_cmd = 1;
+	strvec_pushl(&commit_graph_verify.args, "commit-graph", "verify",
+		     "--object-dir", dir->abspath, NULL);
+	if (opts->flags & ODB_FSCK_PROGRESS)
+		strvec_push(&commit_graph_verify.args, "--progress");
+	else
+		strvec_push(&commit_graph_verify.args, "--no-progress");
+	if (run_command(&commit_graph_verify))
+		return -1;
+
+	return 0;
+}
+
 static int odb_source_files_fsck(struct odb_source *source,
 				 struct odb_fsck_options *opts)
 {
@@ -1227,6 +1251,7 @@ static int odb_source_files_fsck(struct odb_source *source,
 
 		ret |= odb_source_fsck(&dir->loose->base, opts);
 		ret |= odb_source_fsck(&dir->packed->base, opts);
+		ret |= fsck_commit_graph(files, dir, opts);
 	}
 
 	return ret;

-- 
2.56.0.500.g5d06dc02cd.dirty

