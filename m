Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399536;
	b=FJuH95HVPG3CcPAIaS9MiP1gj/MXZN+9TvYuP1EHPLP5EleYdFlz2A5mt0zHT0Hyr78n
	 BnjTUsPFDvis/2PpejKR9tSHfOa38jaLriphNy63P2RBIs4vrOdoeANhI7C+7l6qHXGEi
	 8Ve1I6kB7UWtDIf++nV53q06DGKjD4Ihva1XhcLGFoTV1ltiEjuGnIGukIc0U3sD6F4Hu
	 jF8SsEp6fWsTmvm7kHsAEdJs6QUvCD7j3bLyPpX9n4f7kk39VmVdtDWfF28sTFicZwmFI
	 Kw8yKsGq3G/3zCrbqo0mJJtY2A67Lx6OOwt4uJy027DD4o4mSQvwwByds/67DewVKZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399536;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=4vl+DLnoQ3295NuZwmXVc/MEudYsGAOp1Q/bKkU7t4M=;
	b=iQWQQ7qYsJe901Du0uUVieAssFxqu3SQT/xIkHBkLY0gHOLTdgDIVRNHcbAp39dIGrSz
	 y6gKvtoodGUIodaAJXXKSnBvv/DI8ZDN7S31iZ/MQfpQVfExjLd6VNKk1/MW72J11VFI2
	 VK8SUC6JHQNyCH3Wlb0n9Zn+RtW4DbA/qyPyJGbw9dL3kadgmduIHT9VJDi+bsBhIkdCR
	 w/Tjy45UE4fG8ZlGYUjPk3eW79BgeGd1BwsGsLQWeQY6QnOcH7KeYzlN35piaNGAky3vR
	 /vw8tsCqv/osK8IIVxafz9W87v4t39g9okcqFcDkvzptjkM2pMlRP9eHxZ/SpHjjoew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=zWKzxGoG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Wuv0Atvk;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929D606A33E
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7929D606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=zWKzxGoG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Wuv0Atvk
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 072C21D0015F
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:18:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 07:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794399535;
	 x=1794485935; bh=4vl+DLnoQ3295NuZwmXVc/MEudYsGAOp1Q/bKkU7t4M=; b=
	zWKzxGoGUdLP2uRqTRXPTeuD4jZmOklVpjFYk04jTF1PnBvayv7vrw/PBMg1ht+9
	FNEuIcDXIzpFe87ThfnqOJg5R2yH8Qex0n6YPMu6J/YeJGQUdE0c1Gpxie+2GAv8
	+KOFlk5RcwZ8jBfwdUglkphuabQgKcx51PrqeQepMa9P8U9ZE0QF5vEOhcPTUyc2
	00CuazqV0q+bCOOXgQp7uqPApcdReIO+34SNM08FYY88ILWgRFeyayItoIL1g9IN
	9wWP1O9c0NNujZLsIpJ7+lcBpVjTIa2fBerjQyk3WYCKXJE+qI3Qudmx0uVrfOm0
	ZhRlRO5iUGtDpARK8ncNbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794399535; x=
	1794485935; bh=4vl+DLnoQ3295NuZwmXVc/MEudYsGAOp1Q/bKkU7t4M=; b=W
	uv0AtvkNeX3cCtWhb7tTCUQ3/xM1edDv5NbUcqwhGOxRoDioKf6S42tNKCnzfqp9
	OagFxl8c6Vm/MoBid9y7Dn9lOzfZOMgmEA92QaFXjP6JwocLMcVCRqYGCtaohYbQ
	nSx2GX9O1ZmLHsDlX/s50szz4ndXd1bK+Mvh4ZJetMHJ7qtWllN6KTaCoYEUryr+
	Q0C1AWdtj/RuspNunNVeEOYjjsJfG0Dc7Qj9K2vJxUbO1E0tFT0vzxaWqIy6K80J
	MHhWn9VHeBhYBUjToNk6K/3pSixVKOiNP0SWzhU754+/N+7P2cTi034WkL2JiKoM
	I3qM+LHOFkO/Qj6sGYEgg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794399535; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:aFFt8g81frmnUiPtq7K9n5BnsnLAvDZ1lzVS+z1bW/WYJtS
	DkKMK9+YqQbMsMGKmV/0v6fjaW/BZY23o9fvxX81zpK1KABF+mUm+LcmcRvxKlwo
	umUK4GKkId8ZKYwvOJnuYA5e/HR1TFPYRkTMa6QGHXu62LxcuK5kzr1i5Pb77QJY
	mjcqJDo75OWll38pzbNIXRObe5gFrEibxnDqx3ourLGL5AroGZChDxWyo5bbsqCd
	PcARK51EWgJn2gwPkNbC7r9yDQTLg14gcrOQ/rvRnxjgSELp8vDmJNhs64i9D67+
	1nvI2Hl8pmlS23Ux0EMhqETl1VpdQZoVWBzlMFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fNzkHPMxjCnmHqwbIuCOgaziUH5dVM1UeY/eFQ7TX+s=:wt5SxAXMNHklxcyAdbSpXFTBg5RX24n274K1k6nRtwQ=;
X-ME-Sender: <xms:L130alPtoHnaGp31n5m5Qd6buXsuY8KDJobTFdARsBKgeR_stfUkOA>
    <xme:L130au9ecIT3EVEehf75vDMe226WNaCaz3SglkteXUyjvfU4-WeQcKmAxJPIU-iVG
    IuaJq-Wu2c2ugdROGIHKjKh9qjdv7w4c0rhypVTdE9_WnSucoaLBQ2F>
X-ME-Received: <xmr:L130apQzYY0Yh5btYj3aD-SS733jnIVhR9UqKMT8CCt2s7CCyvUVvFwxmUVKVbiAgvnwwg>
X-ME-Proxy-Cause: dmFkZTFX2c5zW7c3oLnSv0zcB+vdAUp3jsyHjOLJrg2xt/Ai/ZIo1TWOtwcJyo0qppmrMe
    thD7RnWdfdPsqo8u2WsKeMa7MRQYq2uWmgZAI382h9RDsZdYes2Id/eE1PyStFbEp3TrOe
    /ljcMS7fhS52JercJmsTuE3Me/s9aGfbTHkqRTwr8ymeNJbCtPDwfFFo3uBNrSaztlmsjS
    +Dagnpv1PuXT+4pDYznbLpmvTE0sFzbCSE5h2v95QYYoBsiyaOO1jcJxw/V7N2gIfS6TPa
    Zc93YTl6kHR25M13El3ysZfQKiG9LkJ78Myfzb7Znz1fg7m0Ik1v1E4JHHHCG3uMVf2JT7
    GbuzQIGzB5Zb3coTLcRLAXo9DlwD6fklDJXwyL+bAKJBywrRqLlyY42vDD9JegFA0XGmzb
    bsy23o7XWtJ/mqPK+HckiXJtAf2Rv06gyodt4/A6My4801r20iAyvKyzwYO/9p3qbCbzWR
    bZfZjUgqgSV5mvyab2TvgGjboFnRbWUR+yoA5gXkpPvW2YTJXb8MQZCPgizWLBEzpc9Am+
    xX0pal2Wv++VJdiSYDQYE6B9oWTHLSWRNBo3NCee4n9c/bUTo+n/Sb+PFmONlGfSxBSfmq
    LfGH2yf+Dvjsltp3zVFBdeBWlg6zD1mN05rWBnWltjjHOvHOyqzNe5HMEqhA
X-ME-Proxy: <xmx:L130agn8SURs4KvOvgCZivE7270aIo3wl6Yzli7BjE6W3Hgsa5QQ_g>
    <xmx:L130apSbfV8iiPvChTxdg0XGACiLc18M2fsgoYfUkCoiEusFy510Ag>
    <xmx:L130auODSJXIYFhF_FgSs_n90fFUT3jkFpFqP2TbUeSWuiTUSMVWqw>
    <xmx:L130aiUtja0YStgetgP9JfY9-F0ROd36msMuXIKjnKRFiHhgF-gYOg>
    <xmx:L130aswaHeIjsoSxRC_AW6GaRt6oD653hHk4nqOhV7AajJCma7YBZYEo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 07:18:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd9b0c58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 12:18:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 13:18:38 +0100
Subject: [PATCH v4 02/12] rerere: convert flags into an enum
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
Message-Id: <20261111-pks-rerere-subcommands-v4-2-df0c8bf79e16@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
In-Reply-To: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Our modern coding guidelines say that flags should typically be passed
around as enums so that it becomes trivial to see what kind of flags are
expected. Adapt the rerere flags accordingly and document them.

While at it, detect the case where both `RERERE_AUTOUPDATE` and
`RERERE_NOAUTOUPDATE` are passed. This combination does not make a lot
of sense, and it's not obvious which of those flags takes precedence
(it's `RERERE_AUTOUPDATE`). All current callers know to only pass one of
those flags, but let's be safe rather than sorry and `BUG()` in case
both are passed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 rerere.c |  9 ++++++---
 rerere.h | 36 +++++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/rerere.c b/rerere.c
index 47a4a325bf5..47d9077eeca 100644
--- a/rerere.c
+++ b/rerere.c
@@ -908,7 +908,7 @@ static int is_rerere_enabled(struct repository *r)
 int rerere_cache_setup(struct rerere_cache *cache,
 		       struct repository *r,
 		       struct string_list *merge_rr,
-		       int flags)
+		       enum rerere_flags flags)
 {
 	int lock_timeout_ms = 1000;
 	int fd;
@@ -922,6 +922,8 @@ int rerere_cache_setup(struct rerere_cache *cache,
 	repo_config_get_bool(r, "rerere.autoupdate", &cache->autoupdate);
 	repo_config_get_int(r, "rerere.locktimeout", &lock_timeout_ms);
 
+	if ((flags & RERERE_AUTOUPDATE) && (flags & RERERE_NOAUTOUPDATE))
+		BUG("RERERE_AUTOUPDATE cannot be used with RERERE_NOAUTOUPDATE");
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		cache->autoupdate = !!(flags & RERERE_AUTOUPDATE);
 	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
@@ -951,7 +953,7 @@ int rerere_cache_setup(struct rerere_cache *cache,
 	return fd;
 }
 
-int rerere(struct repository *r, int flags)
+int rerere(struct repository *r, enum rerere_flags flags)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	struct rerere_cache cache;
@@ -1336,7 +1338,8 @@ bool rerere_gc_needed(struct repository *r, size_t limit)
 	return needed;
 }
 
-void rerere_gc(struct repository *r, struct string_list *rr, int flags)
+void rerere_gc(struct repository *r, struct string_list *rr,
+	       enum rerere_flags flags)
 {
 	struct rerere_cache cache;
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
diff --git a/rerere.h b/rerere.h
index dd9da03d6db..10b25018c0e 100644
--- a/rerere.h
+++ b/rerere.h
@@ -9,12 +9,6 @@
 struct pathspec;
 struct repository;
 
-#define RERERE_AUTOUPDATE   01
-#define RERERE_NOAUTOUPDATE 02
-#define RERERE_READONLY     04
-/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */
-#define RERERE_NOWAIT       010
-
 /*
  * Marks paths that have been hand-resolved and added to the
  * index. Set in the util field of such paths after calling
@@ -39,10 +33,33 @@ struct rerere_id {
 	int variant;
 };
 
+enum rerere_flags {
+	/*
+	 * Auto-update the index with previously recorded resolutions. This can
+	 * be used to explicitly override "rerere.autoUpdate".
+	 */
+	RERERE_AUTOUPDATE = (1 << 0),
+
+	/*
+	 * update the file in the working tree but don't touch the index. This
+	 * can be used to explicitly override "rerere.autoUpdate".
+	 *
+	 * This flag is essentially the reverse of `RERERE_AUTOUPDATE`. It is
+	 * invalid to pass both flags at the same time.
+	 */
+	RERERE_NOAUTOUPDATE = (1 << 1),
+
+	/* Skip acquiring the MERGE_RR.lock for a read-only operation. */
+	RERERE_READONLY = (1 << 2),
+
+	/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled. */
+	RERERE_NOWAIT = (1 << 3),
+};
+
 int rerere_cache_setup(struct rerere_cache *cache,
 		       struct repository *r,
 		       struct string_list *merge_rr,
-		       int flags);
+		       enum rerere_flags flags);
 void rerere_cache_release(struct rerere_cache *cache);
 
 /*
@@ -51,7 +68,7 @@ void rerere_cache_release(struct rerere_cache *cache);
  * and working tree files. It records (and optionally updates) resolved
  * conflicts and reuses recorded resolutions for unresolved conflicts.
  */
-int rerere(struct repository *r, int flags);
+int rerere(struct repository *r, enum rerere_flags flags);
 
 /*
  * Given the conflict ID and the name of a "file" used for replaying
@@ -65,7 +82,8 @@ const char *rerere_path(struct repository *,
 int rerere_forget(struct repository *, struct pathspec *);
 int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct repository *, struct string_list *);
-void rerere_gc(struct repository *, struct string_list *, int);
+void rerere_gc(struct repository *, struct string_list *,
+	       enum rerere_flags flags);
 
 /*
  * Check whether garbage collection for rerere entries is needed, which is

-- 
2.56.0.611.g1030f0b940.dirty

