Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399535;
	b=V1WKZOqY7bXbNHwJ2UlHJGP2KLmKg2mTpq4RRCkjMpvBixhkRx9nLlW8+49iiBD8toYO
	 /WeM/hjWSkJs81IqnR6GjcB3BZXjS6uHBeu7FKbiHdCiAEGCj2NYT6CmYHDR1XUmU6iFw
	 vQtv+fVpE2v8xB+qjc6yDEwmblUmcfueK38NCVxCSxdRhsoW6alXMr1cXMRLFC9VRiFYg
	 sVXdLMffgwSm2NYle3o/29kpu4CGYM4ff9WTrAurJ/5yI5rYZJqaAJuc57o45Ent9mtr8
	 LcUlsgW5mg7YmY03tFOixqiulBpg0dEE8U4bBpIlrPTA/5VYJt+3haznF8wKyF3gzoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399535;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=t7GstCP1nlRbejIx40yR6DLz/aDH7fcYmys1ys/2+4M=;
	b=XuKHe2Cn/1Bmp0SqOR8cbVwizUflS3hr8G2/NTbyBs69GG2rwc8AEHXlukfln5NJ394I
	 GY1Of6QRJok5tDXWnDKDmKuAyv+kGVF72j3C9krT00B7rR7zPJIqfTRLJCxXuHssf/psS
	 Twpk9LGhWlp8G+6KC5vF6PUTcQengdTsIgiwLmmIhXkY1UgDCP0m9xbNHSX7o4Vs7ws5s
	 n24b/t4fsv4BbOjfYenkM7E5YlRV+7Qt3PZKxqif7BQmTL8O6+1TZb002kO2itWUBIFdW
	 d8wnyR2IecZtv8bA2BzCYhf5EZjReWEiNBmWjqLx1yYiIUX+YtSYtWexEWEIn/Bum0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=WDC9wFbf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3tMwPiHn;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23F606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB23F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=WDC9wFbf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3tMwPiHn
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 56E791D001F1
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:18:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 07:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794399534;
	 x=1794485934; bh=t7GstCP1nlRbejIx40yR6DLz/aDH7fcYmys1ys/2+4M=; b=
	WDC9wFbfJeGf7I5qx9rgrusL03eSS6yfCzES5qv97aOiG1dDdpqOV0UEXPWecb8V
	GWNLpVdnr2SIdkfbg5rJJzgwKjsGnbMn4xljgObR8Mtv380XlQnzvdLQrV0wjfzy
	nK3NDRRGoy9mzz7rsdFw9ZWZ86o9Si4GGNqamZ5fGoNv7etLU/T+1X3kMp0af0Ay
	viBq+sRFsLOJgk0OjMXzXCcj2lEZs2jVaDwLT+yNvOTOz3owIpG1KqFdHVHTmXXs
	I5kBjaw2aKpsEl6YWUfh16MFscuG5PXX7zvpJlFT4JoKrdDJch9nfAyVIAPNe6dZ
	KAWO+CnmRbfNcVZcRVmrpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794399534; x=
	1794485934; bh=t7GstCP1nlRbejIx40yR6DLz/aDH7fcYmys1ys/2+4M=; b=3
	tMwPiHnqvb7Foph1Rb99tpDBeSfI0WrZzcDEH0qCQWWd5cF0mUFQGYrpyEOI/jo9
	9lcPk+PslsuoWm27MVmeNkIjr1WkGAN0t+ZPmxPdQpZ46RMxCP9AfRJ5LqmT6CTR
	8iBS0MUyp7yxwanDyTPXrwpIHdZC42kz8XztF2Z4n3XPLup0UXQqFFPhsEzAWnGi
	AOsYQQmsAFf4MuV7NDa7aU37muD+IqhhyB9NH7sMwKVZqeNNRunKZryruKkCyhG5
	lHEtFOKyC0NcMkU5x5QLMmzVaZfDPra8xEY5DgTr6B86XcjuQr23fskR7CSUBFvN
	fhOrcWR6oB2hDwhREWw+A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794399534; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:owQiBKUk/78rNFp7EXSUlNFYe+J9SncE4MBIZkp3Y3G8yQl
	eto2iFZeReIfGR9ryRnCeXwOJczeO6K6J1HtQVwo/kxvDubctK52PRlft0ocLH4C
	BgcIcpdIn5acHmW4akI9hUMYSrl6ryHYAkuVUCup1vI4DAPb121CyaIvYa7a/MIh
	7BS8h5uJdD4Fl1+dSIvbUTW8x7H5Uyy7wxezr96H/XUoaxN9Wd9Z8dhZjEuBJjVy
	xXfRWX0aCZ25E+Sl1rBNnjSTj3pzQJJpdU4+Gk7xdRBBlBXOQ7KxSAahVtiaEjTP
	Yxmnwi6GML9edfaSPTGiFXGFo6Z9IAoMkZ0vSiA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1sLNO7qLj+nWsWhTZiNvZ0I43sX86mmYC18khi6DmZI=:NvJoKU2ZlCxTyHKOf3MwQOt+RFyF4V1YaWtWBAuX294=;
X-ME-Sender: <xms:Ll30aq5G0krQw4kLAcjWUeESuuhVS6yGXe13jWBIyGRbRt35HNaPbw>
    <xme:Ll30aq4snzYEhfvIP70IxUquxNqcMEcBRe2KM2_bCRmsnAtjeuhLox6iMHBgrgLlA
    9ykMWh8aIbsXlB0wDxqm8m0ZZp-R2HBLULyh-Pu047U8_4_GPo06c2->
X-ME-Received: <xmr:Ll30audnPMY0tYenTvabaDX-KqPBDJAtOl7MiwJQ08P726w99I7VWuFdEmc6_NiEV--iQw>
X-ME-Proxy-Cause: dmFkZTFX2c5zW7c3oLnSv0zcB+vdAUp3jsyHjOLJrg2xt/Ai/ZIo1TWOtwcJyo0qppmrMe
    thD7RnWdfdPsqo8u2WsKeMa7MRQYq2uWmgZAI382h9RDsZdYes2Id/eE1PyStFbEp3TrOe
    /ljcMS7fhS52JercJmsTuE3Me/s9aGfbTHkqRTwr8ymeNJbCtPDwfFFo3uBNrSaztlmsjS
    +Dagnpv1PuXT+4pDYznbLpmvTE0sFzbCSE5h2v95QYYoBsiyaOO1jcJxw/V7N2gIfS6TPa
    Zc93YTl6kHR25M13El3ysZfQKiG9LkJ78Myfzb7Znz1fg7m0Ik1v1E4JHHHCG3uMVf2JS/
    76GyG4T/iv89L6zNPwIfWHRCbwN4sjRri5xbxxArnW6lCCx+wKITEZ1BJjKfiJwAguFDfm
    YER+l+21d5TZYrvd1MSJJWDvFsE7ZoUhfm0Gxif5+562jv/TlCpSCzgH5aY2Nl9dLUZgY7
    8QpYFJeFWXR1xPzIjZCSxgxeoiZB0F25KGgiVh1R8AhbRq+plQohnku3KZxPHFc64eW7gr
    13vNHu0vwIhkNRhOF5RI9KZqxqCBB+puZHpuJtsf1HcgpSi4L0jVMKxecL1g73nD6YO7Id
    sLPAaHR/vPR2ITynEUYwCBkSutacmBcdMyrFM8uLr2izKzyX4L+hdCxg0jBQ
X-ME-Proxy: <xmx:Ll30amDVJaHN1PYXKoA-PyYrtpA7ZobJwRHj9KtAv23WZEMQ2a3d6g>
    <xmx:Ll30ap9PkTwxq06cLL9S9-eIR3aUQCbsr2aQx0igoK6tp5dH2OUKIw>
    <xmx:Ll30apIOku4oNyiyrbzZ0JkV8jON9EQ2TnV6QygKpqtlUGNP2gDbpw>
    <xmx:Ll30aqhzyl8lruwtXRKpO9s9TDIUqtitcoczzhKXvghTI92Y9ABOAw>
    <xmx:Ll30aip7sdv_WBVUbsCelU13gAcUzudnIYC-s0lTBbmQedFG-pLpWDj8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:18:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5a4b22b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:18:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 13:18:37 +0100
Subject: [PATCH v4 01/12] rerere: rename `repo_rerere()`
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
Message-Id: <20261111-pks-rerere-subcommands-v4-1-df0c8bf79e16@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
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
2.56.0.611.g1030f0b940.dirty

