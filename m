Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795838943;
	b=X0GbisB8ahN48viBZ/KsqCC36yUMUW5WbUsUS1N9MATk70GzBQ5Gge0haZfUgrduewA+
	 JQgbcwf1gEcDYfBfD/wzBgXr3BnaE5kZES+g92nRlfKRK6zDDcxyyI6jeNv7XcJ1v/sZS
	 pYK9L70A9gkbNCfNt9pWUu7VSAEXIj44O1nNO1Rqd8736Xy13y6bxWjRGjMTY1PyWv0cP
	 xVfbSxGlBVGuS9CE58tykInxq2aTMDb4ZX+GMvSaLtXXgSx9ORjWgb1P+wmrHgu2JwusN
	 G/jNesLH91QFbUTYmC6Z84Sac9QzxQpK+ts74JFyq7+VDqZ1dupVe3EewJj9P70+jXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795838943;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9jv1Zn9CZlLN+J9iMy9/9yqiaP5DxvgmHz5J56DSIPM=;
	b=P7GfiYUrbyc7El0N7S1myrBBpGwPAoDH4pfv635ntmo3yTwYNqWygWFoMaOsLXpUSccQ
	 Ss/Gi93wIexkSuV8M4S3ZS0pdYKpQh9YgnA+8XSOWZTpoMixOVDFMl4Nt/B3GiYsfc8ZN
	 bi4abkWB5BtTNgwLZ1OGw+RabwIsCI5GLC4I4adOGVWYpmoiBdrCVF9r8edOnHreuruhC
	 67vaywiVpgkHIJ8rgXxnxXUqJ2Ve87P2JIn0f3Tg1fP7UMW9XvJBEqc6nJM1MTsGaHJCj
	 YqLXdhHWAudClNMoEGTGf5dffKHmQAkMEu7lPxvJwxqSgNWT1bjT01nto/+zymHce6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="f/yq2oCl";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Cju3pHzC;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9309A606A32D
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 04:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9309A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=f/yq2oCl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Cju3pHzC
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id EBBE61D003A9
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 23:09:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 27 Nov 2026 23:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795838941;
	 x=1795925341; bh=9jv1Zn9CZlLN+J9iMy9/9yqiaP5DxvgmHz5J56DSIPM=; b=
	f/yq2oClW4PBP8+3eV6fIwJVoVX1DThtwalkCg/4GDSOFwZvQkxC7zA3sg4jnldJ
	HPOR5tfnknKlSlfy83KMoAWx9zlQgnGOsOgCB3ftevFDr4uehDdNta+uidw51GKG
	5GJPOns1W39SggIAs7ygHKV13oU4bF8zGppPb4MRr/4T+12TmZZU/JBiK8Y1FX5j
	sMpVCNtfLi6N3BliJvSKv4sSq8tnfPuaf5LgGclkTqsR7GlZDw7/lJKtHPKXVNzS
	b2Y+wxuMIfODOCYLitVKepwJe6qVSb1coN4I6SneULp3U34dG/2Fb3bX8iCQS/vm
	Clr1dyuRwvKRs2InxXZyVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795838941; x=
	1795925341; bh=9jv1Zn9CZlLN+J9iMy9/9yqiaP5DxvgmHz5J56DSIPM=; b=C
	ju3pHzColxJtnQQ2xdzrKj7n+Wjnq4s+Wxzh2uTfc7fVEYH4yf5n+21rEtb8iKCq
	w5vobEbHwdIFB6Hz7Kc05SI3TP5ExL1BfjRm6hWHSIPZhLiaz8dvNRKDYLdIb2PM
	OzMn9kuxicDoI0c0AMTxxxtAP7WN0wFf29MIvS5Tp2PdaLp178sOQ4CFAQ5CrjTL
	saATMMaeXXfw4pgvl4a8Dsu1a6W0wy4bsYYAwUdvXNzHY9eOHA7ZA8E9wea3hwzZ
	GcbSxxYVTDeQjGqBXoQc6bD5ZgqyRuviLER3GXrWiEGsNkAzThao649pRcd77o+t
	OgyYrkuwuTl1HMlmeOQ5A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795838941; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UI0oPXkx4bGPMBAXwk+Th/CFPPLcZjt1wyLGZ44mf36lYYW
	24E7DjMacaPSvUXaIvigcBcs4D9IwN4j7PLdKDugSBE3lvvP+VM1OpcGt2c2TD7I
	LkB3kMZaZZKj+ocFBmNlD1OxOYaNIUb0ylg0MBJbO8cogVQatgkxa37Mg+VcxPOH
	YwZtGS1zpkVAWKYKgh/UlgRkKv+iYbUxhvcjGqSwKl5QcW/3qDMVAb0lro64XEWk
	ua4zpNfjnvQwZPrUqizGOOFQHReBp0KJ2TAMRF4fu+CKWpsXh9G//cXMedVevfoK
	66cWsyfppAatXKNr2hiZiMtqcgde/P517l48btQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:DE3kqAoqKZLxF0v9pLNkSZ3ts8k/csCuu+mEeSKz/FE=:aa0B7kDLWv6P9aLWEY/P1xOIOeC7uStEHopwZXnlN4w=;
X-ME-Sender: <xms:3VMKa4__7No9aRr_vd1S4ySfIJ4DbOO8xDpws0FTdTGtfIpsa4dwlg>
    <xme:3VMKa3sKhiEbyq11rQgdrmirZWv_t_ocAADRBh5ELdt5XYRFMGKgN8k6W-Fgjc7fQ
    naNabys65nU0HiCfBna60jLKh9unaptHLoVLimGi571hZf4fCXDRbE>
X-ME-Received: <xmr:3VMKazAGy3SZXNrub3mTZf7_xELquzp1kr5cmhCUvg1Gi9r9CfZZlnEM4n2tKUxN54GnI4Zypo6Qb1BfohtE9rL13L6A2FsXB0V7P88>
X-ME-Proxy-Cause: dmFkZTGMWZSY243PpH1Uncynm6NFMlKJXHhxjfhu2IMOmUQjNuD8gy6V3TSC6PYPK/YWO2
    gxvVyawQ/yd4Gijoto71WBsOfBm8DYDxyPo37pFE2EX/XvQXKm0FKFLSKpJxB9seKJEivm
    3sPHYmdm1xQkE+EYW4wiOZrmdPcfkkoJ2rclNHtOEzAlyuVtFPtd/oZk2NVEVGOas9Dl8f
    +Bfh8tGoQfoDP9lFWwTuuQ8v7/9k4U0rInbzuazwQhonHhi3C54sOQhnrxK7Fidz2BhTxT
    gdtMdiStqAHvHX72CZDIUEDNoTNMKS3Y3sJd5uePFlg+sn1YaneTyPi6zFGhFx8X/VBfRA
    ImxZd0sbwC0aLpigf7RFhyxEn7dRn/WxiOZaBoHuEyAMLUJ7VdrvYPze2hGvr9SJBTCJb3
    Gf4BCrT8tm1HVhsT0mq74jvRnt1Xwr/8TRfW8/T9MFLOaVUaE3eY8mbGifoyUnquJiYE4t
    /d83eOgdAGiaffWNoAPsAGm47K3dgnklLaqg5aVk8NCO4kaCEbBy1jAybc+DqVHAieN6zy
    JdZaklaL62P9uPZkuMjgdT1T0z5rRfK0/EcKEgwQslBkHVm5cjzq3vVNocY8LFwkS9bXxe
    iY6n2VN3v6dJccaFKdbpo1/gcb668NYIRWzROpS/ZKaqbv3NxqrV+ZP9YiPw
X-ME-Proxy: <xmx:3VMKa3XQYE-xSzMtX9qC3UTXt5jsi-pnAw76LTNLbxoptlfhaqYn4A>
    <xmx:3VMKa5AVnxZRO3MLEfnATGQZWX6KYpqtob9CN5UM-KyMGT2B_m6VJQ>
    <xmx:3VMKay_ccZ7T6V4UeqgtBBvFsjTf94aBVCyu-eOiqzfEK9Hg2RFlCg>
    <xmx:3VMKa4ENjAcI98Mujlfj3wdIkP4BMmAVBCZxCleFaYjQ8lZjfqxENQ>
    <xmx:3VMKa_CxK5RMRmuHMkX-gg1h3SBiivsspwR7V1g920_wegGILOcwtbBK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 23:09:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: tboegi@web.de
Cc: git@vger.kernel.org,  curtis.allen.smith@gmail.com
Subject: Re: [PATCH/RESEND v6 0/2] read-cache: do not trust a size change
 when conversion is active
In-Reply-To: <20261127194233.10069-1-tboegi@web.de> (tboegi@web.de's message
	of "Fri, 27 Nov 2026 20:42:33 +0100")
References: <xmqqwm1no29m.fsf@gitster.g>
	<20261127194233.10069-1-tboegi@web.de>
Date: Fri, 27 Nov 2026 20:09:00 -0800
Message-ID: <xmqqqzg5y4v7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> This patch series was stalled, it seems.
> As agreed in the coooking thread:
> Lets try to move things forward, here comes my simplified summary:

Thanks.  These colon-at-the-end-of-line smells a bit funny.

The cover letter being a reply to an earlier discussion is good, but
can you make these patch messages [1/2] and [2/2] response to this cover
letter, not the same message that the cover letter is responding to?
Otherwise the threading is broken.

