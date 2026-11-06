Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978057;
	b=rPquYC0Yt0bkNH6ydTWwIsDZlM0RU6+r/dnzQd4Rl7CZf68XywbG/pMDNbOTg8TVG+m8
	 uzgj2gqAIhPTJt7LWG4Oq3dIcP338Agg1rYS0qrW3uBE1WtLPPVDjSBCNSb73W8WWUMKn
	 zqXyBFufd9YpDEJ0OlS5hDSF/j5nPQKCLlToEoMPrJsAnM2Y0F5QToqQ+2UpjJGwsAhRk
	 h461cCqtadqqjq1TIuoC3r3bIjNvtIZ8etuilgLZwWeUxXyw2yk8qNS3qZbtJw4WfqyfF
	 MyPokpOv1N1fJStzeqtLWEmKdqGWNskVAnx9SxoRuQOaJtrB8/vfRQrtZe+bKHTi2XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978057;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=zAv3yslV2bVuWZUZ4LSva6DOh3RUZ9SMdl+wyhauoPA=;
	b=bhcRjl3B9NL8y71jLi8RlIERMPo86uqs14rJnU9x9O6ImognnNQ2JdA/Dit4esThcq8Y
	 eO+HvrvkmMzpnVa5Cr/jnsQhUynj0uvM1tcsIoctCO1qL5e8Vnv9V1/5goK3mHLpkgC9b
	 ejfs8pGll8kJhYzKTMP8xs8TcdWZ9x0dAbX67UtmWYKwEeyT7KsPaQ6nsaoRLT0bH0v6Y
	 ShCutgqzl1FEPSJ7pFIvSsJ7/nCTvGqH+er/1u5X/9KSuTjh80PxsJFSp+sz0f4TumbiG
	 GeEYRcK2D217ZoatcJ4bulc2WQB67AV3aRqQfAgSBLyYr70sboVsH2c5zWY3JuIfMZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=N0YRhiIc;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ICv3Zt+h;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70C8606A33E
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A70C8606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=N0YRhiIc;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ICv3Zt+h
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0BAC27A010C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:14:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 06 Nov 2026 10:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793978055;
	 x=1794064455; bh=zAv3yslV2bVuWZUZ4LSva6DOh3RUZ9SMdl+wyhauoPA=; b=
	N0YRhiIc6G2xCPlA2046PuTK7g6zeznoedo//spbMlhc6//EfCqGxYNH/rYTDdxe
	128wbVaEL1uuVQFfghkr3jZJSGQuwpJMyLFPpHM9fa3dMlum9HAYh/fznvzf0eIE
	txiPqaezIYN9Kz+B0xb3NS8awRoHfUgL7oSGBXVQRrDmmOAzFalnWMZwA+EHASmw
	iO28GmT9gOtNGW6bE4hllCv8xnnWBoAhoLuqCFh5EYvvHzabxLnEL1rKeknyI7bf
	xiIi2CYctQs4bgjOkuBu8kd/PtCxNrvfkNBQgnZlWolZ5/eZbAtYpg8F1FO+E2Bc
	AFAfJ7ityzeXrwZLuWNX1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793978055; x=
	1794064455; bh=zAv3yslV2bVuWZUZ4LSva6DOh3RUZ9SMdl+wyhauoPA=; b=I
	Cv3Zt+h/VVPYMzYqNnn4PLimcyIWzvSbEtF+Kse4opK+SHOlvvJY+HwpFQq3dhr2
	yA3d8EmGp1vTwJB1UakudeRGHaSPiTcUPI20kCrEpVD71sfJLXN62oM2Z3STt7Jh
	SsalkXZjunc97WQaqkJsjzFodz0Ex8PfyW6RoImiU33prX+OpQhdr8x20Knd0R3d
	U3VkKRSO9ZTM4cAoXzVSNoOY27QR77lKGz3cmJ+FR9/ZqchcEV6dk6q/WAyhrRc2
	UW2AqTXQ2FLtVEaoZNH11AcD01BnUE5OQsN1337XBxUU7TWVxESjRevU1K5Migdp
	Lv2ro5zB+xE9q7pHKoy6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793978055; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:GAZGlDpYy/tQIOyK55tGCUK9wwMbDypX+f+N2GWOa8ArkBX
	bEibSJiIwN+HyPOnaft1LUjzb3X8WlsIrb2PkTZF9d2oi4NYxspz9Ak+coL+2F8q
	SbhRQoI/N3IM8XE3VYFLSENKVGoPl9Eg9SicVAA2lkx38YpYg8/6rTB0Z9ELtiDh
	RevSq7yb5lSim8Br0yCUbzcL7enWet1rW/lndMJa/DwdX4dotsflmjsNS3xLC3kg
	K5vjHjw4mikz3W1SkrCqffv9zn/tSO+U71Lt5ZM0SV6n603M7kM77N4HVEQLL8bI
	wqZM/lTbMO+GsvV3b8cNceeH87j+vCQZ0OnKsxg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rCtKyXwZjFgKDL4cbLKKAqD6dMRY+IpOBRrn4H0C0w8=:wrW+DLA2JMW4vbqgWtUPEwsMFLm0rS9qWiL4isxkS7Y=;
X-ME-Sender: <xms:x-7tamZPcF4U5FJ22qvjcwm7ghJEkv3QzIE4ccVmcOUpvMs4LVtYrg>
    <xme:x-7tagYzXibcS1XlFkyttPCzoxCnNkqW8h5SAMPs_gIxGApEhTnS7gZiGiZQ95K2n
    _q6vjp7yU17XxP8FKKyodmggYr5M9ij7c4Kfh8HRgY_KUnscZ4JbbQ>
X-ME-Received: <xmr:x-7tal8rZaOtCqXMrxk8jWmePzs7gj-BQJNkr3oXVbagUFY59Ka5UH-OB4_tT7DZPp_3zg>
X-ME-Proxy-Cause: dmFkZTF8AANCfbywY+lbcN+ohNyc4+Uq7c+zeGEOCYoDwafeYHrk7MGRIOuIhyoLtqB3aW
    Xvwj5mTcmTrWMl0JHY6fbhsy9e0FzdGlBocSX/7i9OOaMsTF1DL3BumyqzbngPyZSOiwJ5
    0JxDEm7T99EFFp4VUPo8RQQQLKlnyrkrmgTJMeHVh73Kdj4JAvpHEeSAG+bMUM+eDiWwMh
    SK0ogcfAlKZJaWA46m8fbBtlnGud8A4B50Oq9kg1H9n9oo5FWZfFUUC7KLuY6PT4GRNm71
    aGcKQO3ZgFFMmZ+0D3i6Qho/FfDmTxSVd0aHHmOkc3VcY7PSziOivmp6s9LiBnUJ6BjXpK
    Hmq6oSHihAX2Ujn8IDiOTQf8TLHvcbV6BLyi/bpOwXUbMkZMf0/4517X84/EtVWm93LyO7
    p1r1uHdO93UIuzR6cPNGV3leQI0zJcBSFLGwT1tArEArV/9mKJOh0kj8otKN+2yeloseTe
    Fs16ThiE2oi3oYL1bKxluegewdhC3DPOvBqqwEgW7P5z9vtytJ3vumgSuRC1CuIdpkN6hl
    0Xajn0VRdm7pO0N4q1Jj+qpDJPOiDRA8rm0meGXlFATdqluRvTtRIkrQ/GHEi8j6WsbVJM
    hFvmsdZUv/GTykNsa1EAr3eKwNeQ/zPYOP6ilTsqVf92RgOYkP526zyj1XXg
X-ME-Proxy: <xmx:x-7tanjfvq1n8mIXNIAOdfxDNi7d3LsniG_v_8cAweZuCYS6ytufSQ>
    <xmx:x-7tatcr7Daunwl0IjBJ-yrmDmnwTkQn_slvcohH9lQ0RTOv3B7QrA>
    <xmx:x-7tamoivLyryMbBTqD89rRaMAO-xKiJmvL-S-UIo0vfRkOfieMAJg>
    <xmx:x-7taqD2qJAucoB54TQ5vaU_bZH5rUEEvoDeS9tegoftpNDH0nfEvw>
    <xmx:x-7taleeLZsdK3bf7MpevMqAvWTBZ8CMfU13D1cLVYuXO_idXkgNCKJA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:14:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ff89154 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 15:14:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 16:13:56 +0100
Subject: [PATCH v3 02/12] rerere: convert flags into an enum
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
Message-Id: <20261106-pks-rerere-subcommands-v3-2-4ff164d8fb81@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
In-Reply-To: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Our modern coding guidelines say that flags should typically be passed
around as enums so that it becomes trivial to see what kind of flags are
expected. Adapt the rerere flags accordingly and document them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 rerere.c |  7 ++++---
 rerere.h | 33 ++++++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/rerere.c b/rerere.c
index 47a4a325bf5..3652b7ac2d5 100644
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
@@ -951,7 +951,7 @@ int rerere_cache_setup(struct rerere_cache *cache,
 	return fd;
 }
 
-int rerere(struct repository *r, int flags)
+int rerere(struct repository *r, enum rerere_flags flags)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	struct rerere_cache cache;
@@ -1336,7 +1336,8 @@ bool rerere_gc_needed(struct repository *r, size_t limit)
 	return needed;
 }
 
-void rerere_gc(struct repository *r, struct string_list *rr, int flags)
+void rerere_gc(struct repository *r, struct string_list *rr,
+	       enum rerere_flags flags)
 {
 	struct rerere_cache cache;
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
diff --git a/rerere.h b/rerere.h
index dd9da03d6db..21ff867d824 100644
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
@@ -39,10 +33,30 @@ struct rerere_id {
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
+	 * Reverse of RERERE_AUTOUPDATE. That is, update the file in the
+	 * working tree but don't touch the index.
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
@@ -51,7 +65,7 @@ void rerere_cache_release(struct rerere_cache *cache);
  * and working tree files. It records (and optionally updates) resolved
  * conflicts and reuses recorded resolutions for unresolved conflicts.
  */
-int rerere(struct repository *r, int flags);
+int rerere(struct repository *r, enum rerere_flags flags);
 
 /*
  * Given the conflict ID and the name of a "file" used for replaying
@@ -65,7 +79,8 @@ const char *rerere_path(struct repository *,
 int rerere_forget(struct repository *, struct pathspec *);
 int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct repository *, struct string_list *);
-void rerere_gc(struct repository *, struct string_list *, int);
+void rerere_gc(struct repository *, struct string_list *,
+	       enum rerere_flags flags);
 
 /*
  * Check whether garbage collection for rerere entries is needed, which is

-- 
2.56.0.500.g5d06dc02cd.dirty

