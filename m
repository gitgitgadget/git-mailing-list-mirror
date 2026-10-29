Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267845;
	b=iaozPhKjSLOf5sbwuAZB8vphg1HaE7qTZUP/c74bzyNDhGkTAZHLujT0fv9bXYkbRCCc
	 qACjdkfmAINbysGIeUvmF/Jzje1kQrRjgVL8smID0sXMT5Sl74zPj9A0V1c4BMl4mXNt8
	 x7lL2rUF+bVg+ev3AaFNzsuG/MlhaNfP8dG/iREv+kap/smTvRYxgde6Em32f6U3qCTfM
	 fAckto0iww2CzaszBXAeb85dNYzjPfc8fVHL7+eARwKeOPW9b9f/Q/y4PKeXKsMItX5+X
	 3bib2MKqHeLsrMg2n+zqFMJuHBZh/qwqKLDqZflDgGfTQ7sSqjiF2fGqW5sRoA+iP+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267845;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=DUvyBoNtROUipRsksc42VE2xcilS8ENzN5qHck9LmeI=;
	b=0V1cAJlIDXV7hIpyNtIwzDZFUKlsJzfGSkli/erv8N8Xmg4F8iFa3fN3ureBHikwWve1
	 ESrXyB14U6xYrFjdwirr1CJvK3PgRqJcdsD32wyNKHNxAAYZvzY6jctEkTMTppGJ2isdy
	 yFS7aQDK6PJWoLpeAYkJUMOdcnyI8FOmb8YKjOG/qoAKeDNG9o5BIBIyCCzo1jOFb3Fuv
	 TmZu9iHytrZOZMk1msgXIVdwI2r0Hjp1Bwt3kJAurXuFe8ZqaCWd8Glml0z4LEEPhsa30
	 DQ+HBpTaC/TMX/bQjoJNp/fKywHK6gHNJqN0T+1DcWZ/CCLnvXMF4gTVW1mG3ERrySQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=hs1f5lbw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mlaTIhlC;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FB960A2604
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 09:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1FB960A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=hs1f5lbw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mlaTIhlC
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D3FD7A0123
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:57:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 05:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793267843;
	 x=1793354243; bh=DUvyBoNtROUipRsksc42VE2xcilS8ENzN5qHck9LmeI=; b=
	hs1f5lbwHiZQD2OkpgMBllyiSu4rdg2fIjrSDc3dxY6tgsZDiGOpNZ71n62/Ax+y
	MZ1iF7knSCq0vo57Ri2e/TQqB0cSsyg0gIPqqMVLxD6wtOpE7RgFw0Dsy0I8CHcC
	Y2glRub0NuKtHgIZb2GGaHmRh2Es0Hxt8oabrvIQfVsOmYpaxychRjHWeR/GBL7e
	ie8sUm/0p+Ih9ZKPKXMkFTzW24WqvGuJfAwsOUPzdshoK6G52txoXQFM1dKLJ2j3
	QAOWrmL37/1WpbIUAdrEbH8M9tCuDTZD98hb/l9hYyiwuLiHiTptKKMSYjio9U5j
	AzjwWBan4vNICrfgP6YE1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793267843; x=
	1793354243; bh=DUvyBoNtROUipRsksc42VE2xcilS8ENzN5qHck9LmeI=; b=m
	laTIhlCAaYZb4K7W1aSvShpTaMwn/cfse2zAzUYaD3M7nVA+4R4G5N3WbW69RPc6
	GJJOcowrlT5itIlXtriyiSBncv3/weLa684Ch44kAS+52rvSW/h6I8NhhyaIxaGy
	yR6uwEpa8vJv41IdRV+b0AVTn+r4KqBhH+HZ8bfx0HNbZaLTUcD9cOwr+X0lyJLA
	DyYh57wwfjrdtcCaFe2R7uP1BAoeBvY5ZiwQzDTWKLmuRtPYKrpFKOAAKm6yRKaJ
	XQltjdHtC8JIDWYVo7r3F85e+hG5YFoRvGHS/ZsLK0H5nXAySiAI41jiA5Kr+9az
	XFSg7pIMleo9gUvb856uA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793267843; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IJ5laLEL5fIqEGFA8CNllbW+6Dq2LnbokLAe0SN+3uGCF++
	WuF5Nex23A4zGuWiDa+CyX8aedVQtj8SYgnEr1eqSdlzMXb757KkvQ9o54ssfV8q
	H1rm/lo813FsWqPyoGnYjpGnBjmALiQlsT7X64W85jfI92obYGSvf7Kes/cCGvJJ
	/OySuB7j1Zw/FV8B+IpWECZ0/niJOcIBpb8+vwMNAFzqRDiMf1EqWrQ4H6BJLPOP
	PlUDQF2Wjo3jApdQccd0aVwLZMOOdmJBkyAwtjVYbupfHMkxh8JFZP2Fyb3BNaH3
	ItxAuSo1K6W/9KOnTtlEgn/U3yIFKeremITH2kg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:49vduZopVMvLe911haLSar73K6gPurHtl4uTrMH0fv0=:xY1fdSQ8g2ZuIDo6V+24YXmZ21qy+J9WFbhtv+JlWnM=;
X-ME-Sender: <xms:gxjjajxpjx5_-WLjhGuek1uITHpldf-P0KWrNfrd3dHIah4f4K00DQ>
    <xme:gxjjaiuuvZh9pDaSE9WNW2ZLMEUdWi19zbrqEyPb5I_xvlnQlgfC2H0FCS75F3AOp
    -wy7OKKfAUsEbRWbvZ1cZWmzwEiaXJcYG32f7S8Mj0k9SAk7oO93Ac>
X-ME-Received: <xmr:gxjjaqvSX4FvqXjFYwqNDav6QD1NGV0mYBCupj6ivNonByZsuqNF-A>
X-ME-Proxy-Cause: dmFkZTGN6oeJR7otfSSVvdw42gSnuM/vOiOuTFBIRXaaTX+WyfNptir2dKNLWXae0Ccg/H
    Dw0kdIlCEIriHaB/16Z4yhETxZy9WpWVbCV5No/000ftN4GNucPScoQ5KkAWUzjoZWT0y/
    4K+z8cN8RbbwmEbCVA2o3dxUR234Pvg7fa8zCjVDYwZ4a88+TvOSFTJqaXKepL5aLugymQ
    94eqDXIHH+KgCM/ysQAVHXtzWZ+jp+UH8ANfqy8XQANds0O69Nn3IcrRQjn65hWQ4o24gk
    +sSNI7PSlqQEftXcXQKG4q+6scpPc+oCvIFhg4XMKrhkbLuMtLc2NHSNJl7zBq44s+shUl
    U27MtGeHYR55dCTmLEiNyc30X5gEbaskFYbGXcDt8fPaCUdNrOH8K8xLXfMvUPpDYnSM6F
    RYuREclW5/4Eb3Vko38MY/WUBJjDHf/W8SPZoi3zXin6bRhEsjTZYWNGt24JHmiiSIB4R2
    q2aHWh9Kgp+/QDD+7Km+XoCGcOSM44VlAlraIM3tOU8/kTNg5RJ78Ssz4XlEuRXEkIdVQq
    Txai4UVSCLnT23+kN5G69R4bPmQ+ziu62n/5vcNx1jxf8n79JS6XG8h0ZIweIz8CyVvY37
    srpkloLdqWvARX4KQH+8hObbh3kvISvBCFgMxLTOs+xw/30HX3Mg+MImr8ZQ
X-ME-Proxy: <xmx:gxjjanPYgJUGGQj4q8f9Ryf7dgVH3sr86lLCOD5F4gzSA_Z_xkvAOA>
    <xmx:gxjjao32uBiBjOLeH61rk4TUNkdx67APT5KBLVzE2Obe7aJR8A-AGQ>
    <xmx:gxjjajMp0U7x7hUU08fkJAf5wFaDO-GCjWi92eF4BoiJdgYeiWF4tw>
    <xmx:gxjjao1m6Rw1iMKOFQUKk9tonfJMYpbNqiLc6eOJZl82AYk7e4LWYw>
    <xmx:gxjjaq2NOplavNZ7MV2r2lsEeQwBRnfds0k25unpBNyduv3ayQJBQNpi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 05:57:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3383ef61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Oct 2026 09:57:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 29 Oct 2026 10:57:10 +0100
Subject: [PATCH v2 01/12] rerere: rename `repo_rerere()`
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
Message-Id: <20261029-pks-rerere-subcommands-v2-1-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
2.56.0.341.g393f52fd96.dirty

