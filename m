Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088837;
	b=vSYTTXqi2mi3cSUTynXaVFRD/vQndzK4akjUiGrwV2l09GSaUxL+P7OwdfEiBw/juq+4
	 9rABH1sXrEaJ+gklCWsKxKUC8Q4QsKWKi41JRBKOwxWQfZPO3w/0IqW/qCdY6C02szhYl
	 YZKL57rr2NpdT5hzHFD8V+wEfx/yjYbpT+klRAdHuGgMOIIdAkQ0t8IUUQb9nC6k+tUVz
	 vW7QREC4oXW1iyhQ0nfqtXlg43Lc6HGUG8RUYRESP+8nreNI4y1xoosdbuqXAnplxlrUk
	 LueZx2c9BjpcBioR6TTwATHBFaWVh+sbhZ5yGBPAVJh2xCUr7CLUQxYkPLTNNNWFhnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088837;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=z1ZmvMVux73/icsJQRAEz4DZqkOhHr2x++1IOtZuTuM=;
	b=5UavzxHThX1RqQTi4cFMIvSbGxu2CBMkZ6vQJXsKF6UCXiXkcBhDqIKE4+VVKD80JUfD
	 Awoi3Ajv6Tkld9MFp6DxhJ12amqMH4IzX75FqieHYsTa6DOFF2w0dlLihoY9oPMASGZyU
	 uY0BojtUbgwcTNpW2fJV0NN3s0KxI/Vd6ocdE7twdoKprm0sDVUgWpSSUy6NALh0bIRHO
	 PHeaykgpSUpM7PD4gs5ByTQlb5lFK7yRl7KwJ0wLHXLubHx2HE3Ac9F3XGn6nDjLLBK5e
	 9HuJJR1JzWXjqYP5ksjFdDd2T2KcgbGlFI610HO2CqKViYrrZfuH90UaNnrXl/VhHRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=rplnwuFn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V1Hp82OM;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBE1606A33C
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 11:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDBE1606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=rplnwuFn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V1Hp82OM
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA62214001C8
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:47:15 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Nov 2026 06:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795088835;
	 x=1795175235; bh=z1ZmvMVux73/icsJQRAEz4DZqkOhHr2x++1IOtZuTuM=; b=
	rplnwuFn98T63mNfjkevYJAj2E7hLxWaHqsJQKt6XQRBd6i1KDKC1bSrJk/oi/e4
	KReSKNir+qdGp6SuWAAdqeXUpDyAWZDv8pzUWP7RtS3QLux22gWtO9cWcenDQGVF
	RrQ6CCDMOlvpbheFMh0JQ3E+zhn5tzdbP96mnewX8qv8HW84Ws5wJnfoiLmSqKbH
	cBaBj8zRN++c9qNxymJ/1zty5n1EHnt0VpsKW403JSjTkyARaOy/0YxrpCerdDEg
	AaYegiVVx4vXIueYk0uMygb5Nq8frUuhwezcV4828KAYaXHtlIhpVf+4EqDx61QO
	huSBwqSFU2a5X3rTjs7bEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795088835; x=
	1795175235; bh=z1ZmvMVux73/icsJQRAEz4DZqkOhHr2x++1IOtZuTuM=; b=V
	1Hp82OMzoEpa5W8lO1AwXCItCb57uIiKh85kmUJ4nrnENpIOswKkyVNZOxIgXg7m
	EKhOvAWbT+ehM9/SQy+5Mneavw4GxDh45MYis0oNtW63BccJlKUwIrODG8glM2to
	vJAJMAzrsfwyfZiKMKMerniApvUO9eZhzrtRkQhATDEmCVm3yZpDaucgWxR/6QYk
	x4y0SGkxI5DyeMqiZQ3i5JPUUlfqRxdUzq82H0jl8V6jSTc3LfKowHZOU7wcoJUG
	YMIOu4Z8uvvz8aqtIv+OhZBi0hyDUSK7u3XjNLu8WFOGgVgsjQQzjZDaWT5t8UKb
	tQJH1OHbSPEl3DEemr5JA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795088835; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:xV0KlN+8nGswXgYuuANSl9Lap/1g228XoZZEMJA7MDTsPtN
	S2qyGRjrZeCJEgb97ST7StaUh+Lbp8+ljkoYK+EIyZwxoEPQegQiz/pXd3igYrc2
	p+39ORqU1ZFL8n8ZpNvpNdVfXBI0eJ8/gib1DX4P2ppMyoJde6T5dnFJiZFKeEqI
	vWO0kLovZAEvNJrqon3ip9O6pS/uo3u5mzfFYyXboBcgn1VZ0Z58tQA/5oevgvsp
	MnIVo3F3AfLX7jP9D+jxX1ExnOZzi9T96wCdValwt+mE8jhEqNsiz8gUr7wV8LOg
	EB201KuHrLdC0x+ikjZcq5nrdT6T8XYwh/EvxJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Ql3c31SASxi/4kiBexcxhuyFdfKqeqk0bkTWB8PAUzw=:v5fQuwKtXddk7P/REFP93TkLjBRkpPobKF7uBum/NJU=;
X-ME-Sender: <xms:w-H-apbU8crBu2tIzbI3pFHkvJfDsn-2U_OxkthRf_TUdRd-Cz3zZA>
    <xme:w-H-anYIbR9Cg07XpEYiPKzH_PQnyzCBhdNq81Kqb_pM-g7GdkUf_JL48byN10Hr4
    GOVaSN2U9OAWIFcOuGsBEXZIp3rhB84RftVdZuyzRRO1Mfoj6XmkzI>
X-ME-Received: <xmr:w-H-ag-suOXVz3Qq-G90aS4yKyvLhUy7mXuq9EntghNirwI008whAA2qKcS9HdyFLv7kG5o>
X-ME-Proxy-Cause: dmFkZTEXZEOjEM71ry1bXEPUyrZqX+lj5LhX/Ly29UsKVTRe21Y2eyCJWlEh2udTa5KEnz
    eoYFQvG6xuLPKNhARxbzj1z6+z2YrzJTj986YPy3tkngcgZgyh68VJu3U+YO+6PVTUMcr5
    QrGQnWpmNB7xda1uSgfFh/KJf5SXDY6GlebuSQ92BiRMVpqzNBycNApFQ/CVd94QPxkbTY
    oT7JtdpLBwothcIX9cCJMncyBzKol0AVwv35ZuDgRg8O7e+Z46ZE2TEt5Unuz+pSoLCA80
    zjaGnGvt9lT1UHSuOmdpS63tiMV7a+SeTYrp7EU4JoyaBnbYKfZ1JZKJ30mydOX4feVhDq
    zuPVFzdbF1bOMUHm3ZR7v+uE/jOyHgR7Q7BqIOjuNouiNyF2aEOz17EhlKgSAiWEs5bdW7
    Zc0fT9OzapIytrva+fu2mJpSINhnFqMGTXfR+Sk2V7SL3KLYyY0P0QhJZruMPBzcIbB9IX
    ETEbijhcsC52TW2VHluhrykUuOyOSFZUSbwhLhNC6mE63ErRsiRRCcpPG45VZatq6jJMW+
    kLyXH8TBfBfCgdyg3NmQawC5fcfd102i93H9mdRyzRZG5VfD6VzKOtqEfPkkNClnPGghg/
    q2SZqPGynhbfg5nDPCkJWeGRiCUh8JcWCzH4v1uYGFdeaHrl9IN1IHLzlLWA
X-ME-Proxy: <xmx:w-H-amjKKjPqX-KhTID8sA_sE9_GkUwguX1gX-PvbFxB9oi8kAFYmg>
    <xmx:w-H-agfUMrCVLjg5j5f6AH4TEeRlCQJmjJQdFrpzDqAbFOhrfWEHOg>
    <xmx:w-H-atreLIeu7R4Mt_F8Z4TJb48fuaEdxD4q6xGK_BGD4AYizHPQGw>
    <xmx:w-H-alDSNeO4rcQ9kLFUbNloGB772wbkWWwi1NdfWZDZWIeM1oIJ6g>
    <xmx:w-H-agfb9mnug65LmMRtNEPJ2aw4mt0M0DOVnexbwmLI-MJAt-Yjq5Ij>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 06:47:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba01cb9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 11:47:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Nov 2026 12:47:02 +0100
Subject: [PATCH v5 01/13] rerere: rename `repo_rerere()`
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
Message-Id: <20261119-pks-rerere-subcommands-v5-1-0c1092b88958@pks.im>
References: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
In-Reply-To: <20261119-pks-rerere-subcommands-v5-0-0c1092b88958@pks.im>
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
2.56.1.831.g720f3f5937.dirty

