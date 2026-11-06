Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978055;
	b=00X7OvNUV058eVcOCNpgUxA517Xt9jtuCZsoaPj+w99vPEDoogpjkp14BrI/M+wkKpWt
	 Jq1g0nrnpAi9+MGh9fjXCg4XIZjTt2aOnRVQ35/JHrcrWd12UFr/Q5DodPcR8E5KEBBVF
	 NkcdD5QY4DKkLDx7x5TKdHhF1g3BZzacZit7TSipJ2NutmMt54o0MTzZ2ecFvHcHvT5F/
	 CjiD9xPNQlN2bg2zhHkkgXXxzed83cUzLTETwxA+oMruYGalF52dUuKpwZAOSPTilTEjQ
	 MjC8uOUToNe1UxBaD3FxbDKzmtlzVUBb7giYmFrvAgN0Hjaw/Ra42CRrd1ilzuCSHHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978055;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=R5gDD0KFwUSWvJgIWbb8qJa0RuhHz2bEMAA/nFerPsk=;
	b=K8DrNPFONC5q42Hbw7yU+PTGByhFVE9gey2Edj9elhfT81B0FQc9TEFXNbxdWT4scnWJ
	 RBLTTIv46BHYC3qjWqaDIpuXZ/fqOj32CYHnOk2R4FUL/90c7nw/4WqPELgGEwZMvQZ7B
	 qzzSpcUfd+tIsCP3Glg5unnRj8DsXJ0sTQH+E6PCvr9TWwAXx+D0cboIsmry20k/jM87Z
	 wKTtPw2q8cElBt5iXGDFNTq6bqlLoj21C76K9R2YsPV9jptiDAyEHY8A9Y2Psk4XLn1hS
	 aM3fblfZ4tcTYSUESa22xu3gC9HHDKV2y3RQWtpxkaJh7a+t7blwh9KZuaC8L3SeWvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=IvmNR8oh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MF4Y5Iaz;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC4606A330
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16CC4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=IvmNR8oh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MF4Y5Iaz
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 755C17A015B
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:14:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 06 Nov 2026 10:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793978054;
	 x=1794064454; bh=R5gDD0KFwUSWvJgIWbb8qJa0RuhHz2bEMAA/nFerPsk=; b=
	IvmNR8ohJzBz2UqfncFo77I2qM5AKqlUls5QMKqVlLtUBhSMasSoWL4UvwcD42e+
	AeLADakQHmceDB4EsNjpzPMPM+vXyKaTsTYpG2npo8hHnFk6w0kEE90dC+qnlS02
	GRm1PhvymQ4NVtbV2vbPgdHKyjsLZhQ6kBKUUkXNyEudE9VfhcL1/m2+CHBGatou
	7glgNdap2Tz7oKYh0YGt0mLd2I5KkWuTVVDI1Yml0ILv06N5A3EW1A7Ri6fogfNg
	/P8NJVLu+dD90RfQffTFOL1V/Py/NFuLtGw+QQ+yL8lgBhilmtg/Tg+8qo0/7v3g
	dRPl5rAeETmmhYYwgOBzxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793978054; x=
	1794064454; bh=R5gDD0KFwUSWvJgIWbb8qJa0RuhHz2bEMAA/nFerPsk=; b=M
	F4Y5Iazstt70nVa/UjfbMv4dSuCYKwd2JCJm4xHq7HHCKLSm+VAb+5JHDXpeD+rx
	+Xitv7JhPE/ogdoSherBYCLe9CTYYgSp5zoFpBluWjYklKv/XA+7BRBYg/XZl1of
	rUqFXn9DD63EClI9yUR9Dc4ArOSnqUrfIZieT/+7xcZGrXmeMJfN1v799/4e31Zl
	CYNpD7ULbhCwxxvdLPBuUAT8CyK9S48B95G8nXfIL2Q3dSlC6Nhx+0AlQOJcGB7M
	wA287TsZ1fA0NP9mtct3yqbx9dgaw17lkDK23LtwJPilIO0w0emcoebglyEhceqx
	uDjYKPcK/GeLEI8nospbg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793978054; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:tTpJoUGGmJ5b05sdpo1cTPO49giYHBvwaeLYqTvarF7c00h
	pk7qwdGVoZ72rGIgAO5dltK5WZwpSWznilhzZ7fIiRWMjsl7+cF/FxiXOC2omi+7
	HCXsJXADVIYrc7pjS98UFOAKOS1VuznEhXlFbVbpqjIiBWIufdGEP1OWEuq9GFbW
	qfADqAP9BR7cEMnoyb8s5YsfjwIaJQ8vgbdgUgvXXd+LYqN0tjnuoRHQQZlgJoi8
	ujmXD6e8ENhpHbWmYsD/0rqWo8iFwculi9LjmivnQBb8I4izhKkIjWR234/1v0aE
	h1RN0uBoxdkyH4UhWfQ5EyAGKOzBeFuFOD4obtg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:887lpEWwCwMPD5GnSLrLLWx/tFe8xIFrTXfWsI1CSmY=:7ZJcK0iN2x1Psh146lfKW96KbAhv7HL8IHV+Qg620eo=;
X-ME-Sender: <xms:xu7tagkWgt59BsId8MJLwZchX_eDgiO7JllwofJuAYapHtjQh9c2Nw>
    <xme:xu7tam04qh634DFhjDHbZvHP5WUt2gYLb1_LMa65xcaaRX7LR10M0HQve3AflIk9f
    4kYxVaclC2iuS241bkUusNbFsfGh96KaSK6RdG2jpw5iHwRLN1Cjpk>
X-ME-Received: <xmr:xu7tajoCkvW5LvfcUpxypxApSZdRKWRoFNXRhJFOq66XuJztuPSoO5bPHbwemyYBZLs_Tw>
X-ME-Proxy-Cause: dmFkZTF8AANCfbywY+lbcN+ohNyc4+Uq7c+zeGEOCYoDwafeYHrk7MGRIOuIhyoLtqB3aW
    Xvwj5mTcmTrWMl0JHY6fbhsy9e0FzdGlBocSX/7i9OOaMsTF1DL3BumyqzbngPyZSOiwJ5
    0JxDEm7T99EFFp4VUPo8RQQQLKlnyrkrmgTJMeHVh73Kdj4JAvpHEeSAG+bMUM+eDiWwMh
    SK0ogcfAlKZJaWA46m8fbBtlnGud8A4B50Oq9kg1H9n9oo5FWZfFUUC7KLuY6PT4GRNm71
    aGcKQO3ZgFFMmZ+0D3i6Qho/FfDmTxSVd0aHHmOkc3VcY7PSziOivmp6s9LiBnUJ6BjXMs
    BRwLTNOojTspMhzGlLIUYjw2q7qj/PYNyRCmKwVmULqqVCrwT4ZjXccV/Cs5TGVJrPnOh+
    g+YNMXKSseTM2DBErEM2f/9NsczYNo0Fk5LYjTpmUJ12n60li1XhQruoLzQ7b1m/KvAKlj
    w/XaEXTjE/hI467QeNo8gEC8dczPLB5FUiz3I81UALwS+DeRquHX1L+E8W2NmjNToGhB39
    wD9aDoRVus3imFyTX3RXb8SGym55eZb263UZGVORN5TK2o//C1LgeLp4vhfJ9kY2FVcacE
    yH59Bolfo5ayigvoFGu0kjGFseBecRS/AqbpWZLfVdIoJuxVeV47ziEFyA3A
X-ME-Proxy: <xmx:xu7tarccw-9qyySp37FTjdhdOWIvl4E6nuWjLFDv3EHYs40sEeSSjg>
    <xmx:xu7taqrZ1DmwWZpZyBpER9xO504HneJs07ZL_zE3E7ub1Y7ZgfBYcQ>
    <xmx:xu7takG3fT5wKcu9cO4xRhSIBUIIOFRrpCAKko_pMMoS7ILfwT2b_w>
    <xmx:xu7taiuAAmQ8xMIUz9nF4PRT1T7Z9K9MCrk-qDokShT1jMKIwX--dg>
    <xmx:xu7tavJ0fp8k3jYfahQr3h9UI3gDQ_Hs_iw5aRYTflwp3T9xFfrCqpx2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:14:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 781ffc2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 15:14:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 16:13:55 +0100
Subject: [PATCH v3 01/12] rerere: rename `repo_rerere()`
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
Message-Id: <20261106-pks-rerere-subcommands-v3-1-4ff164d8fb81@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
In-Reply-To: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The `repo_rerere()` function is the only function in "rerere.h" that
does not have a `rerere_` prefix. And while it does indeed receive a
repository as first parameter, that's not a good-enough reason to give
it a `repo_` prefix.

Rename the function to just `rerere()`. Move around and extend
documentation of this function to better explain what it does.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c          | 2 +-
 builtin/am.c     | 4 ++--
 builtin/commit.c | 2 +-
 builtin/merge.c  | 2 +-
 builtin/rerere.c | 2 +-
 builtin/stash.c  | 2 +-
 rerere.c         | 7 +------
 rerere.h         | 9 ++++++++-
 sequencer.c      | 4 ++--
 9 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/apply.c b/apply.c
index a0b7119c639..646fabeafa3 100644
--- a/apply.c
+++ b/apply.c
@@ -4866,7 +4866,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 		 * tree with conflict markers, but that isn't written with --cached.
 		 */
 		if (!state->cached)
-			repo_rerere(state->repo, 0);
+			rerere(state->repo, 0);
 	}
 
 	return errs;
diff --git a/builtin/am.c b/builtin/am.c
index e9623b83077..4a5b37bee00 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1649,7 +1649,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		o.verbosity = 0;
 
 	if (merge_ort_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
-		repo_rerere(the_repository, state->allow_rerere_autoupdate);
+		rerere(the_repository, state->allow_rerere_autoupdate);
 		free(their_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
@@ -1979,7 +1979,7 @@ static void am_resolve(struct am_state *state, int allow_empty)
 			goto next;
 	}
 
-	repo_rerere(the_repository, 0);
+	rerere(the_repository, 0);
 
 	do_commit(state);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 8ffd42681bb..3a4b94ad623 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1962,7 +1962,7 @@ int cmd_commit(int argc,
 
 	git_test_write_commit_graph_or_die(the_repository);
 
-	repo_rerere(the_repository, 0);
+	rerere(the_repository, 0);
 	run_auto_maintenance(the_repository, quiet);
 	run_commit_hook(use_editor, repo_get_index_file(the_repository),
 			NULL, "post-commit", NULL);
diff --git a/builtin/merge.c b/builtin/merge.c
index d7bf209114f..089e36e8575 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1061,7 +1061,7 @@ static int suggest_conflicts(void)
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
 	fclose(fp);
-	repo_rerere(the_repository, allow_rerere_auto);
+	rerere(the_repository, allow_rerere_auto);
 	printf(_("Automatic merge failed; "
 			"fix conflicts and then commit the result.\n"));
 	return 1;
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 2c17f02f56d..a499e7b9151 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -83,7 +83,7 @@ int cmd_rerere(int argc,
 		flags = RERERE_NOAUTOUPDATE;
 
 	if (argc < 1)
-		return repo_rerere(the_repository, flags);
+		return rerere(the_repository, flags);
 
 	if (!strcmp(argv[0], "forget")) {
 		struct pathspec pathspec;
diff --git a/builtin/stash.c b/builtin/stash.c
index e1a3a76bd04..91870a255fd 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -688,7 +688,7 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 		ret = error(_("could not write index"));
 
 	if (ret) {
-		repo_rerere(the_repository, 0);
+		rerere(the_repository, 0);
 
 		if (index)
 			fprintf_ln(stderr, _("Index was not unstashed."));
diff --git a/rerere.c b/rerere.c
index e0897612085..47a4a325bf5 100644
--- a/rerere.c
+++ b/rerere.c
@@ -951,12 +951,7 @@ int rerere_cache_setup(struct rerere_cache *cache,
 	return fd;
 }
 
-/*
- * The main entry point that is called internally from codepaths that
- * perform mergy operations, possibly leaving conflicted index entries
- * and working tree files.
- */
-int repo_rerere(struct repository *r, int flags)
+int rerere(struct repository *r, int flags)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	struct rerere_cache cache;
diff --git a/rerere.h b/rerere.h
index d3cbd10e13f..dd9da03d6db 100644
--- a/rerere.h
+++ b/rerere.h
@@ -45,7 +45,14 @@ int rerere_cache_setup(struct rerere_cache *cache,
 		       int flags);
 void rerere_cache_release(struct rerere_cache *cache);
 
-int repo_rerere(struct repository *, int);
+/*
+ * The main entry point that is called internally from codepaths that
+ * perform mergy operations, possibly leaving conflicted index entries
+ * and working tree files. It records (and optionally updates) resolved
+ * conflicts and reuses recorded resolutions for unresolved conflicts.
+ */
+int rerere(struct repository *r, int flags);
+
 /*
  * Given the conflict ID and the name of a "file" used for replaying
  * the recorded resolution (e.g. "preimage", "postimage"), return the
diff --git a/sequencer.c b/sequencer.c
index 508ec717920..ace1cfac1cb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2556,7 +2556,7 @@ static enum pick_result do_pick_commit(struct repository *r,
 		      : _("could not apply %s... %s"),
 		      short_commit_name(r, commit), msg.subject);
 		print_advice(r, res == 1, opts);
-		repo_rerere(r, opts->allow_rerere_auto);
+		rerere(r, opts->allow_rerere_auto);
 		goto leave;
 	}
 
@@ -4488,7 +4488,7 @@ static int do_merge(struct repository *r,
 
 	rollback_lock_file(&lock);
 	if (ret)
-		repo_rerere(r, opts->allow_rerere_auto);
+		rerere(r, opts->allow_rerere_auto);
 	else
 		/*
 		 * In case of problems, we now want to return a positive

-- 
2.56.0.500.g5d06dc02cd.dirty

