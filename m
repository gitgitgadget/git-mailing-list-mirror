Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978063;
	b=jwKNdmfxLRoQXyJ02zstf9q6uUHY2oQz3AdPWzaPxmofn8Sqt2vdmxe+ONvIE7pfpRiX
	 ZmqfYlYINKe/fDmVFdlcXeV7yoWyiA5y0fBcN6h7sc73mFCeK3YCp4jBmc03uMZHLd8UA
	 43anEaptZ7IC2UeA2IyF/VstI0ta8+3iYokVgv0wUqfFbeJNadHvkDvq+2p7B4NTpvVuP
	 clpFMoR2l44Xc0/nF+faOxOdIxFNYuqYDVTc3B/VECFY4QZU6YOMeBZF9Fid9TfMwRdfy
	 u9OkgdhZESq+vdGPdY4ro+NdPeQtEgYPcUZdV16b9oyrMnHRY2QBkPACcyxur6N+tIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978063;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=fJtbqQDXcNTl1xbTR9cmbMNZFT8EdTwk0/x5C4krf7I=;
	b=M+dpnnMjTkuQmCWsNJU1En0ggHZ4iHXuWBZXWWVf7bV0Wd71dcNFbn22Ed+n2ArqkJ0n
	 rgb0vgO8P9UlKIeOuQcJE/qY+KbXA2G8EeM0y7MM32gZdTtM8+uUyka1vj/D6dY5VH53P
	 CDGyqtihFmZd3WCoEp+oPd9qlujsRjMQCVgLBTkS46YL/L0otlSr9dq4mYtDKnUqDAbN2
	 yF4q/Sxt8tG+KFAV+U5yfLf21XoEGBWsi3y/yRTCWUZzfD2mJkVJDMDdP2BBMfjCsZrqQ
	 JSbeW0r9a0yeALWsYL4sFQ1wD09F5fFGVlklSPdxFWWgeEaoLgTx9fYtOIEKBgf+9/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=MpRaE0sR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dgHaoykr;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7EF606A33B
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 15:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF7EF606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=MpRaE0sR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dgHaoykr
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 09E137A00D3
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:14:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 06 Nov 2026 10:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793978061;
	 x=1794064461; bh=fJtbqQDXcNTl1xbTR9cmbMNZFT8EdTwk0/x5C4krf7I=; b=
	MpRaE0sRB1mtLfcm3XQJrFbSnqFxoy+Wp9fhVsp3oPH0NP1BTGKIL/+cp2i5nYYy
	4c6fp2SQe4zbD0s/JLWtKKxo+oaEj8FeMfu3fkDc80lH1/yKq0WcalHcRBaiLacv
	+w1KEg3kSN+Cao3v376azUrvG1EuEdgQcEqph3XtIrXClPhTJzkqD/D34UCmX2Mx
	Wfo7iSjeXC+h0U9EjkycoLcvwNanMeIIKNCR8BL8RJs/DmyUc5lbd622uhnueXOA
	PDemnAwudPOyqpSsKzKd5GIieKWSywku2vISTaLiR393BIQrSgZYr2sJ6IVLufb0
	/qqMgiGCVHD+sKtRP4ITEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793978061; x=
	1794064461; bh=fJtbqQDXcNTl1xbTR9cmbMNZFT8EdTwk0/x5C4krf7I=; b=d
	gHaoykrV8m9SOEv/f9plZJ5ti+7zxTeU9FnfwAazwjI4u8vYIGzE6G+yV3hmMvdr
	RTVoZ4Kft6eucjuHwB5x0OBjogw/5QuHtX8hhF19h/wg/j21tM+83wxwq6TQqPHV
	NyHejfj1ZS0sJx05B9mZttMzA9fJy1G1v5oVm5GBKyikSJd+33qKfyiMFTPV0UcU
	K9vuf3LujK27Q4kLiKyTlj1xgWcpdYqPWJGXKwS8RrvNFTPEWMaL+AZ9pwCvyRkr
	R2FQNNG1dENpBLllKOYxAv1ptIl/fzBTOq271CxaLnpSRhcoFttjCgFpnmmCVsIP
	JTY8aS0I3V+dXpK+zQABg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793978061; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:nHhTkNDLCjdxLD82byyyVkSYkRksfeWUVxhkTpuTf698JWU
	e92N66lAy4gWFPFyZqVFny/LaTeszLGOW0I4lf8005IAoJPNQdbNcCYj/kn6dWLI
	XIVPaQJrWUP8WWj1OI1HAx3yJm3tzie/G6+KH7ZmxsHdC06AarVc2dY0hekLKWuY
	Q1MfqJf71akwmDiWVceXd4SYVyPUEWgTI2MfiSymUdJPJpI1AT4RV+iz1BndAoaG
	NOwbGOZ08GVY06CA0TxmGT74H/9sIsslAZ9tP2kr33hxErCJptcMzeU8j2VM/aUb
	9AeQ42pmXtui43cqcWIFZwudIp1EpufEPNDKXbw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XBnm2TJC/MSN/k/SMK7MvpDV+jOIRrL9o//dcS8lSNM=:gzYA6kBc0Vbb5cXZRKqS7/XXQmGd7YehbpFzvJXItjE=;
X-ME-Sender: <xms:ze7tanH-BZ8YuSz4rvnBzW92MAUtKf93KBFEgHQWbN0svYDLDLGxZw>
    <xme:ze7tarWcgQnqPdZnfNlD8q82jcbW2tTT3DCl0s1BRDEloLjjwN5cBKDFTffx5Wi3n
    RqZ9MWCp1p2h9GYriOy6J_478NdLQKatNJ7YyeVuBbU_tggHbyM08U>
X-ME-Received: <xmr:ze7tauJkwFncR6gfF6QUuhD37FMK2tIzaZthKmajF_UoKDkg4tR0qKDJPPo9r_B_n6IOQQ>
X-ME-Proxy-Cause: dmFkZTFpG1n8BNjrOjL9sUhDw3ZiP4mtgTk1U3/fCZUgMmr4wlQPFq/1BnXTuXw+zlS6mE
    IootibMXKeybvuZS0F3Yl3ONkICg0FdWX43CJz0MizalQ8U974cAXPiWoPbZL736ZnzCO8
    EtZYWO3+BkHKQalNcN1fXtfVzPi/xvBnpUp03+88tRsq0flFwtX3krA66QaVLRCtO0jyzT
    QGpB1Esb6lCXsgSSEoGleb1C2sdrFLHGOqn+Comvczkv/UdY1E3MphcIfbyMG6XxkZYVIW
    /gH+dST+86WdOm7ctQVetJGB/OBHpugz5WE4LKZe182sP1CEPsX1V+0sw13sos7UzXA8g4
    zl6g9IVd0SuKMBxm7fckcpNUHCtHLyb2lZOrmwAKFppS5rTm9y9+sri7WvDmfPFGNv+Lg6
    C43SpYqH/9FQg+8Tq9C46XYV9Ihxsv3KlRTVqrE6o9H47WLyQmGE+zUs2SyqiLJYi55Ol2
    /Z1nMvvMoJdhTsQ08rKrHSGgIH6nL9z0EUimq7pEw26ZtnZLEWjbmuXBRcT8YetPsE+L+f
    1HKnaBT7O+55tbmPzJb2+Ps9rs8QQiHP8XUPxTPSVcYeKaSlgbeQllNJxZXta+TpnPxVml
    Oe05G7dIAzi8/Nr9t1zUGyVgQbj1Eof2no0Oj6JPe1ljlkyWR7U5BCVIAVyw
X-ME-Proxy: <xmx:ze7taj8OBucLZahCAj6Pr0qIZSdgB1fTAMAFXzZcqQ5iNzLH4_62oA>
    <xmx:ze7tapLgtT_yrslBNoo-bHGDN75RlJCCE9ltUeS0Yp7LBVN4bHzBFA>
    <xmx:ze7tagkYYnkpfaYGp_UuSWFmHx_OQ7MLTLoKdu_yDXlDT-LwKiCPXA>
    <xmx:ze7talNlk06lobWMZ0kw8hq69tEh0zVlt-zBcD98btkWfty8EHvBQQ>
    <xmx:ze7tapq520zavflUSwqbPr7463k538OJJ9dSgmPAmz0XEFt-Olb0WrdD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:14:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c093f758 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 15:14:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 16:13:58 +0100
Subject: [PATCH v3 04/12] builtin/rerere: stop passing flags to subcommands
 that ignore them
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
Message-Id: <20261106-pks-rerere-subcommands-v3-4-4ff164d8fb81@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
In-Reply-To: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The git-rerere(1) command has a "--[no-]rerere-autoupdate" flag. If
passed, we explicitly enable or disable recording clean merge
resolutions that are staged in the index. This flag only matters to
git-rerere(1) when not executed with any subcommand, but we also forward
the flag to `git rerere status` and `git rerere diff`.

This is mostly harmless as we would ignore those flags anyway, but it
makes subsequent refactorings harder to understand. Prepare for these
refactorings by not using the flag in those subcommands anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 83fb3783c61..405276cc94b 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -107,7 +107,7 @@ int cmd_rerere(int argc,
 		struct rerere_cache cache;
 
 		if (rerere_cache_setup(&cache, repo, &merge_rr,
-				       flags | RERERE_READONLY) < 0)
+				       RERERE_READONLY) < 0)
 			return 0;
 		for (size_t i = 0; i < merge_rr.nr; i++)
 			printf("%s\n", merge_rr.items[i].string);
@@ -128,7 +128,7 @@ int cmd_rerere(int argc,
 		struct rerere_cache cache;
 
 		if (rerere_cache_setup(&cache, repo, &merge_rr,
-				      flags | RERERE_READONLY) < 0)
+				       RERERE_READONLY) < 0)
 			return 0;
 		for (size_t i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;

-- 
2.56.0.500.g5d06dc02cd.dirty

