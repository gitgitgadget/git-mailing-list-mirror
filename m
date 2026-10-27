Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098026;
	b=TF4BVIg8bA8Eo/nJkW+8SMGUMorrcRyq8mjwkND7OladgmpkHtYKvRh/EQJ2NyB1GL33
	 kOKVCxmHnxyUjtjuwcgvLW2vqg++4gtP6ztnYHozTh46KCMXR0kQmypbT1OvZ+x4eZ5Zy
	 MnUmgtHHfhbSXTkyy/f1d0gLjLyeLhLH1Qdipo6VBsA7iXRBTmhW4lJLhuazyotJCuzDC
	 2CUOyydIf5wzi0huJvGfAYHgPYberHNGXfndS2sQcgNh/BfAv9PMw7tNnDnOizREwOkyQ
	 fZHXb1f8b2586gWlko9jFmMtFBBS4/XVzCmm8MzH1RoyFek8rqmPeDBOURMVF/R/Ctw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098026;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=RHZGJep1V8remYg6n6dFFWNOstiVOfiTl+bceHB3HaA=;
	b=rzKuSHRE+Tk8+a2gU8exPpvHcKymQ8yZ6PxRdBb3znesl7rnbCDlFK2tA0Rk5Uumd6xv
	 UwWg2wt4FuPc1AUS93T+kZp1rjwBjdp9s96INzAtoiFNkNIGv80cK9EKyeTRP/gCwnOPP
	 NBxpQE5WzgLKfzFp16udOZlCCyq27o6BnYYCQOYRDMKDSeq+c06IYZCXpjQ82OS+dzduv
	 N+caKadJf7K+NYS8pj8m4HSHG0tqf1WOYK0YsttVTxp8ZDeuhUKTSnRq9GFVbIXt7W6+V
	 JKLnYR8GkZLXR6MuJ/Na/t6lpsS4hp0Lrn7I+W8NgxUk7WZ3SU9DEwtVQUVnjT0wPAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=cFRM52EM;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WKVJHgxT;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58394606A324
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58394606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=cFRM52EM;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=WKVJHgxT
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 979AE1D00132
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 06:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793098025;
	 x=1793184425; bh=RHZGJep1V8remYg6n6dFFWNOstiVOfiTl+bceHB3HaA=; b=
	cFRM52EM6aL17Y7S4xNQwOJI07cncqLVSBZMo1GA+4hINyqJ3rCtQtTvNSpCC+38
	4WIz31Mz76mwckBukuZEjfn4As8bODBDIaxyHSdPAV8JHgHRgaL6ceo90kFgb8aN
	lQKgVyJDpt/ZaKynQ2GZM2z1y1n8jqNp1GbnnHT7NLbfajlKLoXyRyZdIAuKFJDk
	MPTs5Bdv1GksnUshlK7atYAsIB2bmZQB067/+j6yfzZLeMny5HIlZAwYBCWcuq5S
	x2VkmpclVinSIrStlJCJndw14qn4jPB4cjpLpqe1AFAR1v4jhH/z4FGwKOdgtcJl
	IDU+VbvmIYeFl2ev84fEbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793098025; x=
	1793184425; bh=RHZGJep1V8remYg6n6dFFWNOstiVOfiTl+bceHB3HaA=; b=W
	KVJHgxTypuSGF4bedtXHXPNOulVthBMt4q/NpT6SU93kbjW+x4ndWY0Tqa88mTqP
	t7DrYr+xswiDaJFvF92I3D7KORKTs6WW0FqL4qVI1T7B18Fe6gcd58JCcELQANT4
	rMRfettnzM9ahjexxW+a7fTt1uQtulf8UoKMXasYk21FhgurCTOympabp/ySYUbU
	COhRisZcRxZvHLlbesHh11EFtvVFcdsstl9rmfdUPX6obY9LVZipE4LGPb3COV0j
	cWVfKEunxZvru2lQtqSYSjtgvR3UnvyycZpvR1JOmz8DitvAhb+hPZCa8JPplTKb
	iZXi/Sac7Ah2PV5I7Z3lg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098025; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FPlwF5kfsyygybQ7SojlibwTghGO9RXHMF58T/hy0B6vMcb
	ykRWEEXok2ovtSLj2JMKPZE4+dDbJBoEIxBLsMJ/v6SxwtTNmb/DP0PqqQKS1Qd8
	gO/Lve6M6+51O33ZmcJFdYhhogKaoXsX+jNePUgmbV8g6/2SaII4qxhI+wudi/nh
	Ap1Swr3xT2zG8Xqb7hdIIieeXJD/vz1VuUhLQ49xJJ79vUBHlfXGkGbocA6m36no
	6dP4Nzp3bIHoPuSVAW78zcpalWVf3hZtSzL+ASO+fsTDpr1iPC+xgi7tijxSgg90
	JXwJb1eORD3o+3fnOF1dhnhWxNdDp3UM/HZ/UjQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9a0ASAzHadevITHoqOKP95Os6wcKPLU9qwR11+aJMu0=:4BdyfXMBWXSQrszGixmg9qzVu21ZbM0VrkkD5mojGXs=;
X-ME-Sender: <xms:KYHgamj_NO-a6CuQoeZihxx7ut0_3SR1D0D1d5J33F2lIwxvOw4hjg>
    <xme:KYHgat9DiMEuKgf-ooP8YdfZahjmjtNlZGZPaiTTKTXGWMNM6ofw4gfjUTFYIbFLB
    tgFbZPk-SZF405evaYFjGz4I-YG0aQTBayPYGrQFj_bOm70ANTwE88>
X-ME-Received: <xmr:KYHgajurtUM9ybh167bDSjkjda7ABtEEV1J-wSxSHomM_K-hY3da9A>
X-ME-Proxy-Cause: dmFkZTGKSOc/wTTP6D8MlB4DlAAl3mwGQ3MedBExhMrHHiNRqDl2HTGylO4Nvjoj9ogmBu
    +xC8y71+V8w2dgeBezAtz7QynelTqzOcampIgZwX8bC6U6HHHCL85Ds+zUHe2qEidAOQVB
    5qfuxPSNQdyvdxvYbUeXGaqbcQNenJ7ziL0s0/nm7Z0iZfiRMMG43Z1tV/6MtdhhA9NdcH
    kAZSn3LjoMLLaixvl3L7TvDKTAoN+kFy2CL0w8U/NgPZ23Y6RECVpHzeGZGW6RmrZWzW3k
    wAjifpxRmtmebfdRy/YMgwIuTvJvC/FBLN4SVe405NtxCaGrV4mg8id/rprQwdvNTNLYfW
    5B2oO6YSinXGGxQK3szvOO7N9O222kV2SxUZdLTIQG73wmC1vv80fRoARM5vnIMM6oU7n2
    iNv9BCVzrHireId9h+tlSxncRQO/SxZ49Ucmc8RYkSgYDT9s0tJy36zVra+f7O0phq4IWh
    NzWJFE+C+qIscw50hiH5wim3Y/i6gC2Byg3TMKcZyhBDURenRUQmRLvP482hGLaFT1LdXQ
    tBpvPKZPeXjj9kStARDwkanLaqek5X8+0fga8VFfEy9GZjCLixK/OLYMxyPVU22ZaOkaKF
    DU0QunaAj14ZC9jCNAC0CFvGod+AHL4YyJkHINjF8gLJtK8cNf4fRTpAHMOQ
X-ME-Proxy: <xmx:KYHgakZrCnmGCAiAy16QBFXwSsBBA4ilhv886uIjfHqorjZdwHK0tA>
    <xmx:KYHgajqGfR9oyawhAWy8L8xBmQ-lOtynKJ9dYLjJSO9p9Nv7FrmftQ>
    <xmx:KYHgap8vLfqkOGf7Furd6nHWp5S0ixWC2AGBjoxqypqO3i8r9cUWVw>
    <xmx:KYHgai8qmfW9ZGAOgmR22eGTmmk4vDzq6IwtWXRxWiZ9kCOkhXjd3Q>
    <xmx:KYHgajgYKA7ctB-mgTVuTxD4tC3jaB3HkEgytsO9-_vuTmUzyPKJ_bzd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0f1c155 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Oct 2026 10:47:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 11:46:44 +0100
Subject: [PATCH 01/12] rerere: rename `repo_rerere()`
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
Message-Id: <20261027-pks-rerere-subcommands-v1-1-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `repo_rerere()` function is the only function in "rerere.h" that
does not have a `rerere_` prefix. And while it does indeed receive a
repository as first parameter, that's not a good-enough reason to give
it a `repo_` prefix.

Rename the function to `rerere_record()` to be consistent with all the
other functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c          | 2 +-
 builtin/am.c     | 4 ++--
 builtin/commit.c | 2 +-
 builtin/merge.c  | 2 +-
 builtin/rerere.c | 2 +-
 builtin/stash.c  | 2 +-
 rerere.c         | 2 +-
 rerere.h         | 2 +-
 sequencer.c      | 4 ++--
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/apply.c b/apply.c
index a0b7119c639..d0b100ca065 100644
--- a/apply.c
+++ b/apply.c
@@ -4866,7 +4866,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 		 * tree with conflict markers, but that isn't written with --cached.
 		 */
 		if (!state->cached)
-			repo_rerere(state->repo, 0);
+			rerere_record(state->repo, 0);
 	}
 
 	return errs;
diff --git a/builtin/am.c b/builtin/am.c
index e9623b83077..1d156cf877c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1649,7 +1649,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		o.verbosity = 0;
 
 	if (merge_ort_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
-		repo_rerere(the_repository, state->allow_rerere_autoupdate);
+		rerere_record(the_repository, state->allow_rerere_autoupdate);
 		free(their_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
@@ -1979,7 +1979,7 @@ static void am_resolve(struct am_state *state, int allow_empty)
 			goto next;
 	}
 
-	repo_rerere(the_repository, 0);
+	rerere_record(the_repository, 0);
 
 	do_commit(state);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 8ffd42681bb..c472e8f6638 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1962,7 +1962,7 @@ int cmd_commit(int argc,
 
 	git_test_write_commit_graph_or_die(the_repository);
 
-	repo_rerere(the_repository, 0);
+	rerere_record(the_repository, 0);
 	run_auto_maintenance(the_repository, quiet);
 	run_commit_hook(use_editor, repo_get_index_file(the_repository),
 			NULL, "post-commit", NULL);
diff --git a/builtin/merge.c b/builtin/merge.c
index d7bf209114f..aaf15fdd69d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1061,7 +1061,7 @@ static int suggest_conflicts(void)
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
 	fclose(fp);
-	repo_rerere(the_repository, allow_rerere_auto);
+	rerere_record(the_repository, allow_rerere_auto);
 	printf(_("Automatic merge failed; "
 			"fix conflicts and then commit the result.\n"));
 	return 1;
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 2c17f02f56d..1717fb7a65d 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -83,7 +83,7 @@ int cmd_rerere(int argc,
 		flags = RERERE_NOAUTOUPDATE;
 
 	if (argc < 1)
-		return repo_rerere(the_repository, flags);
+		return rerere_record(the_repository, flags);
 
 	if (!strcmp(argv[0], "forget")) {
 		struct pathspec pathspec;
diff --git a/builtin/stash.c b/builtin/stash.c
index e1a3a76bd04..1b9c7f0eb6b 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -688,7 +688,7 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 		ret = error(_("could not write index"));
 
 	if (ret) {
-		repo_rerere(the_repository, 0);
+		rerere_record(the_repository, 0);
 
 		if (index)
 			fprintf_ln(stderr, _("Index was not unstashed."));
diff --git a/rerere.c b/rerere.c
index e0897612085..fd1c1ed6015 100644
--- a/rerere.c
+++ b/rerere.c
@@ -956,7 +956,7 @@ int rerere_cache_setup(struct rerere_cache *cache,
  * perform mergy operations, possibly leaving conflicted index entries
  * and working tree files.
  */
-int repo_rerere(struct repository *r, int flags)
+int rerere_record(struct repository *r, int flags)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	struct rerere_cache cache;
diff --git a/rerere.h b/rerere.h
index d3cbd10e13f..a19d2407b59 100644
--- a/rerere.h
+++ b/rerere.h
@@ -45,7 +45,7 @@ int rerere_cache_setup(struct rerere_cache *cache,
 		       int flags);
 void rerere_cache_release(struct rerere_cache *cache);
 
-int repo_rerere(struct repository *, int);
+int rerere_record(struct repository *, int);
 /*
  * Given the conflict ID and the name of a "file" used for replaying
  * the recorded resolution (e.g. "preimage", "postimage"), return the
diff --git a/sequencer.c b/sequencer.c
index 508ec717920..58e58503794 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2556,7 +2556,7 @@ static enum pick_result do_pick_commit(struct repository *r,
 		      : _("could not apply %s... %s"),
 		      short_commit_name(r, commit), msg.subject);
 		print_advice(r, res == 1, opts);
-		repo_rerere(r, opts->allow_rerere_auto);
+		rerere_record(r, opts->allow_rerere_auto);
 		goto leave;
 	}
 
@@ -4488,7 +4488,7 @@ static int do_merge(struct repository *r,
 
 	rollback_lock_file(&lock);
 	if (ret)
-		repo_rerere(r, opts->allow_rerere_auto);
+		rerere_record(r, opts->allow_rerere_auto);
 	else
 		/*
 		 * In case of problems, we now want to return a positive

-- 
2.56.0.341.g393f52fd96.dirty

