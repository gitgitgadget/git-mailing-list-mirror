Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098030;
	b=GO94na5k+53gNBW10M2j8m1aeMZ4lKbMGe+xa5x6I7xEEux5OQJMiiMV2wpnnjHeSKEy
	 BstOAkBvpFp6/Ygg/CQpWsBi2FObn4T8RdeWLwS1USIadEwWn26EBdNO/lJVhSKn9nuhq
	 x12Cba0kFkUP8iceWwf02E85Rom/yQDGNLh1C3v1+RPR61EVbp4RJGTotV0L1r4SIhzy+
	 WQH4ry467HiwhqVxLX8KmdULHyPddNkBQ6vESGq45NkPRu+sXipbrbpa06R3FJNHtZyQo
	 pV0ZzSNNDPaXoh5RAiNSutk+F2L1mSS0chZgVZiaZe1GFQY/6oYzWJl5VlBKRAWIKTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098030;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=kbxdOlT/ucxsluPVxSV4NMODR4MRfa29qsc31tVqSp0=;
	b=QFj0yPdyras2yh/omTru3wgDw5B0ImrwZoHxVKAkyEh1t05EGGCZ046tNX+CPKRT4qtU
	 G5DpFbhkhw6/Xok+vHK3c0tt1PP5uwbEXL1HEyBV02ttxK9lwXHl0PvQXofQXIxR6N7Rp
	 owhOgkbyqkyputz2EQeWZCkdf+CV2xBTzNp4f54yJPlFXOPQ2oj33aHR/jFT47RIdt4pv
	 sxguQEbpciISrpokFvvLmx0WHBtg9XK6l+TOTvBa7ivaFiy6hiBNK/arYjLDnYTO7vT8y
	 r6/aTO/DBDlT6OI6h6usBsIqjKmBdWswoWye2AuURF1rTY6hwuuY52FGzhTU/xESo5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=keq+0rr+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fiYmul6l;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B80B606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B80B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=keq+0rr+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fiYmul6l
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 94B0C7A00CE
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 27 Oct 2026 06:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793098028;
	 x=1793184428; bh=kbxdOlT/ucxsluPVxSV4NMODR4MRfa29qsc31tVqSp0=; b=
	keq+0rr+OZNe470ARUmIvu1qggHds/Ivz3fx8azMUBZaDJ5elxQdkN/xCcs8Kqt4
	rh1Nos/VNswKOPYZpsQUNg4mtjfawv9q8Ptz+Z9J5NCBu2wcVzJpnPA021FhJBxu
	jF663SYFTfVRFHj4025lGPJ8x5o2uPomrVDKMyIZU2yDx0D0T1HKDsWSkcfMZa9N
	mwTkSH5EurjC5j/LWS0Lh5KcRn8GB+Jlna/RvpSwovQifArdV9T0urSWN21XL1YY
	msk0HWqygw367l5AQI39rl/6Vc8Bo19sgATctkc13YqgRi1VnNRTV6iEKryjo+Jl
	Zwy3Zfbvsq268ACWcTbBWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793098028; x=
	1793184428; bh=kbxdOlT/ucxsluPVxSV4NMODR4MRfa29qsc31tVqSp0=; b=f
	iYmul6l83BEC6fIEqwXxC9L+BKjboDau9qUVIE+SsecwlyZU32e9ZrwqTAQINxW8
	M4aoIVLZb0Mk6fAaObDoj+hTlEKCNuws21P0dLErZtstwFYeGAepE9W3CE6MEFrX
	eQtow9a9hDyqnLIw93u3SdNN5tisUU6Uw14VCbMH0S+Iphn8XrKE9C3OSo0254qn
	qeFZ9int9DQdGlaLRLPcKadMr/Nj1CQwBi7vkjnS5GdaA4zptySrt6YcmfgDWGBJ
	AT2O7vGo97J4EotpZIUnQ0UrsJml/eiikEU8jcmlgH5TfTEtDR1A1ysMeoyPrG78
	JPT+1q3IEt8DD4kDIWq1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098028; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MxTzqAQazzHd0fiJ7aMPR9agWF0Z9Kau4TRe/FKXQZqo/cJ
	eVgkk2ywGHx2npkIeQeZzKF+uJx+Y2LJF8tiVhC5fTDOzvsbuIsZNxiCHtSOvxvE
	Jl/C50yeBLnXWICWXhIYsV1wu0Ncq6xQW/TJeJlCh4tavRSnvWD1z2gABggGx6kI
	sAlVmE1OAMELzYR2mvcaK0J2QLSY8rcbgX0+D0aLBlUN3zqYeD1PtMozANacy7oR
	eFslvezrQpHPiSZU00imfhXDiRjzYCD1I8Ql/znWv0cPRqy5fW/j95vyP58WSNYv
	WybvKv//4FQ4JPDbaSEb1JPtE65M3XbRK+KfCIw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fMGeBsmguY8mPCI5mkqwIDk2PasTLLRmrt3zx4seAwI=:oMoRO6uVPwgqzql4QqBym/BzWwymoMkBnujYdzWWo6Y=;
X-ME-Sender: <xms:LIHgajC-fiKPXHxa8cblxk2Y_KeWlrpgrMRmaPiLBpr_U5ON1MRRbA>
    <xme:LIHgagcvtinjn-hnUCKjUwpoEcpD05D9rZCmPMRMgqay3c_fQ_L3MorGdJHTMF4lK
    N8lLbSupWhk8Jc5jKEFha_3Yk_gx-pqwORz0Sfn68ZgQnmnLKbOF7I>
X-ME-Received: <xmr:LIHgakO7aFmb8J-mNVLSoc9CpMsGm7wlavwvje_2gxkWTVCPU5XWNA>
X-ME-Proxy-Cause: dmFkZTGKSOc/wTTP6D8MlB4DlAAl3mwGQ3MedBExhMrHHiNRqDl2HTGylO4Nvjoj9ogmBu
    +xC8y71+V8w2dgeBezAtz7QynelTqzOcampIgZwX8bC6U6HHHCL85Ds+zUHe2qEidAOQVB
    5qfuxPSNQdyvdxvYbUeXGaqbcQNenJ7ziL0s0/nm7Z0iZfiRMMG43Z1tV/6MtdhhA9NdcH
    kAZSn3LjoMLLaixvl3L7TvDKTAoN+kFy2CL0w8U/NgPZ23Y6RECVpHzeGZGW6RmrZWzW3k
    wAjifpxRmtmebfdRy/YMgwIuTvJvC/FBLN4SVe405NtxCaGrV4mg8id/rprQwdvNTNLYsd
    oTlNOalF3OGjiQe7HLX6hlG5YTyu2nEwDZLsCNQmoj9rhVJ8yFZdXD4US5Y5oopXwJtTTb
    5nBijIE6w0BPO42TpaMt9gUfV8ZC2QG4URPHl8/oGrWYt/u3YsySggHCfHnDGNmNCnjyFf
    PxXyuTKc1O+Xj067OXeEJf/gLAguBK9oQrPpBgcLA5eNc4dWkfiP5gMxtISvlilsbwPYwB
    qEoB2UxnD4a5TUbZjZcHWsiScEA6zUN4rathIYYVg+6d64V/Uw9exA4zEDwREXYzEfWgBr
    fqqpwrxPG+KToVjYZl8N9BjWC/0vSw7FtxPaSXNdCJPiJCqDkUAHzrnRLlLw
X-ME-Proxy: <xmx:LIHgaq5uD07oTiwKkLPKSSUaFCl_YI9Tr5h-bqkDUDPnHDkPICSJ9w>
    <xmx:LIHgaoJpj6fwngIlA6ga6n8CDe_hdu5U-gHiBOkCBZ2aXvuBN7aTZA>
    <xmx:LIHgakelXfKMdqCtADb4IKttJQ-FP_8iGAMyHAE6bFnJX0rNrLqX1w>
    <xmx:LIHgarcy0FLjGY9FIhX_8Tsrjz9sAv7kPVzFKyy0Sd3xSaRiGCLjkw>
    <xmx:LIHgaqDFlLlsgvZ8CHg668IBKKPTMS8hHbcICegU8Y8-Bs-lBfh-bItw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Oct 2026 06:47:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19851b7f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Oct 2026 10:47:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 11:46:45 +0100
Subject: [PATCH 02/12] rerere: convert flags into an enum
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
Message-Id: <20261027-pks-rerere-subcommands-v1-2-d836c36ce0c5@pks.im>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
In-Reply-To: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Our modern coding guidelines say that flags should typically be passed
around as enums so that it becomes trivial to see what kind of flags are
expected. Adapt the rerere flags accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 rerere.c |  7 ++++---
 rerere.h | 21 ++++++++++++---------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/rerere.c b/rerere.c
index fd1c1ed6015..1ae7983445a 100644
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
@@ -956,7 +956,7 @@ int rerere_cache_setup(struct rerere_cache *cache,
  * perform mergy operations, possibly leaving conflicted index entries
  * and working tree files.
  */
-int rerere_record(struct repository *r, int flags)
+int rerere_record(struct repository *r, enum rerere_flags flags)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	struct rerere_cache cache;
@@ -1341,7 +1341,8 @@ bool rerere_gc_needed(struct repository *r, size_t limit)
 	return needed;
 }
 
-void rerere_gc(struct repository *r, struct string_list *rr, int flags)
+void rerere_gc(struct repository *r, struct string_list *rr,
+	       enum rerere_flags flags)
 {
 	struct rerere_cache cache;
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
diff --git a/rerere.h b/rerere.h
index a19d2407b59..362b348af25 100644
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
@@ -39,13 +33,21 @@ struct rerere_id {
 	int variant;
 };
 
+enum rerere_flags {
+	RERERE_AUTOUPDATE = (1 << 0),
+	RERERE_NOAUTOUPDATE = (1 << 1),
+	RERERE_READONLY = (1 << 2),
+	/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled */
+	RERERE_NOWAIT = (1 << 3),
+};
+
 int rerere_cache_setup(struct rerere_cache *cache,
 		       struct repository *r,
 		       struct string_list *merge_rr,
-		       int flags);
+		       enum rerere_flags flags);
 void rerere_cache_release(struct rerere_cache *cache);
 
-int rerere_record(struct repository *, int);
+int rerere_record(struct repository *r, enum rerere_flags flags);
 /*
  * Given the conflict ID and the name of a "file" used for replaying
  * the recorded resolution (e.g. "preimage", "postimage"), return the
@@ -58,7 +60,8 @@ const char *rerere_path(struct repository *,
 int rerere_forget(struct repository *, struct pathspec *);
 int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct repository *, struct string_list *);
-void rerere_gc(struct repository *, struct string_list *, int);
+void rerere_gc(struct repository *, struct string_list *,
+	       enum rerere_flags flags);
 
 /*
  * Check whether garbage collection for rerere entries is needed, which is

-- 
2.56.0.341.g393f52fd96.dirty

