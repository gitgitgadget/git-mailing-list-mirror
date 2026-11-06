Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962958;
	b=nikgmfXTc16qUFCe4sTnNsGSM27zTPeKzTwMLfLf7EBwSKAsXoBV2wCdZiCBjss9rfcx
	 UdFP+3jaw3QfIdakIbTx3APeu5SGR7Ps4PuUvOFIfh4BBeFpx5BKutIdlOx9sV8ORzBzW
	 I1rs/octx7nsTuVDh2JlbQ3Dwj03dScpiDTtD9Ptd7+V10yZ9rLJH5qilYEIOSdqHTpkJ
	 ZNfXRdWdukYPywLTMRNfk9yqdkJYSayOoJJ1x5ayJwRxFi3LwVxaVqFjz+EkuwdonTijQ
	 mHanCLtGEoDSX+b4j/yiGNIX8BcYWD7Mdfn8IKgQUU8vD5A9QQFK06hWYMfi9BanT2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962958;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gaGva8GZE+qN7bNJFZUoXlJNkdHW4LpqO42IYYVZo/8=;
	b=o0RNAm8G6ejL/wHkmEklu5PiG2XVSrcahN0Ko41OodImfGt5QKM+yHr+MkFSi48KJKfu
	 mCk8gn1+17lyF1h+1JwxaBNXx+C4olVsir2gabQADbxo6KNayCgljxEEX/2hGvCmquLjG
	 RsoaCeSxIGlx7RVzLOCbe5vmMJmOOeL73ktS++nuoNcXWg6qB6iadE+zlG61s6jDZzBcV
	 ET2xf5OWzyA6JfFxxXPLE6pcUMpJGjVlpvwX2o7CDgFKpzVkhmc5lIH2yD9/GhBCCL3y5
	 k8zUuAPAnyMPAxqZZVRIqJT/0RwxX2DE01rPkyC2OYs7bSALZbv5IzNSPtcCVBunpkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=c2CUYNik;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fRYVSnNQ;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA509606A329
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 11:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA509606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=c2CUYNik;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fRYVSnNQ
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3106AEC01EA
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 06:02:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 06 Nov 2026 06:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793962957; x=1794049357; bh=gaGva8GZE+
	qN7bNJFZUoXlJNkdHW4LpqO42IYYVZo/8=; b=c2CUYNikv8pQC3+xBk5EV1OTba
	uxeXolx9dOmwPWRgXmSzB4SeVUlBhmiF3QDxuJaCIDpb0aMm7q06nbH75CvwxPaw
	fYyrcxb/SLXpesyYHWPGY+01MH12R1kYW7XwYFYdjvb/dwQ612TPpnKlprtyJhMn
	+zIqn0N7Ghkgyg11OmXMYRfYBGdoaJnnTucsU0XVkIlj7rvvIm7XP3T2gYvPpevG
	Y8fh+Dnqjf4luaTOewhnVdY6re9pjwWA01njQxdYJGPC/4TgiK5A55+DlnGpW5H3
	rK8KdcqNjrn3dO0p2Fm10VpddLyR7KwFMHlmPIw/YUCebVJVkskF1jEdv4yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793962957; x=1794049357; bh=gaGva8GZE+qN7bNJFZUoXlJNkdHW4LpqO42
	IYYVZo/8=; b=fRYVSnNQKgkuhF1MSskEvZ9a6aGV8v1TdlMWdhmX+4wzONhrSUU
	KgSPajm+nHthccI28VL2ZfLETIgzTfqHg8lvz640uAwkVRt//S095DtDIK6FmHfq
	GHRcrbg7XwdcChLxCOch4z+tO85QeK++jzvi5MXtrpJepT5x3PLoMlfGtZh1MWQQ
	uVGvsWszQIVRZ6q2FIeiaERB+/2bzyz8f5sXpkvrLMa8fEhaPwKSv6sT85vxGRZi
	zhKQ4wEC3yvnoWirTfx8MHCtkGYj5LYzHzycoQ5AOL8jSHrlSWpjnOuNA+o4xvyQ
	uAH8x/xKpNJD609Ayll9oFdGZXPCoOuziTA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793962957; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:MAjNqoOPsIK/pFoV5Nqq/UTdV6+MZ5bP1/PSkGbJdzzVIW0
	8cS4YL/YEKVq/72od0Vm4+idcYFS+7N4nuPT0kF8uJC0EnVER6Ul4TMpNGoMzT2S
	yBXSkVeggJABrgF5xK+4vfxR+DID1VyQAVC8sn8STzICBUYWoDJbUCnk3Ur4yNcY
	AFtNi9HVMK3jyidA5T/uO3pN68s/9d1ZEKOKqfJDEjRfTmtqm2cljDn4kD/cuNft
	vp0ybJ2C+KOtnNWREMpGBhRwlujOmL/JdmpCdv+PSFxFfRFqBGySSCfFc9yu+tEa
	adFgcfH/rQHJZ1VKWZieHGxSjCF7I2Rm6tSXt2g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LBupDNIJ6ORI3SneABtHkYjb0FhflvoPPzazIFNUN1k=:wdFLtdWSWB4O8dl1T1msksx+6msg4XL9i7Mipxb690s=;
X-ME-Sender: <xms:zbPtai_HwD407IsOjCCidYq8AiYLfM71w4oFRTQDbE472ffGjgImZw>
    <xme:zbPtaouo8CQ4St5a8Y1xrEyJWkzUD6XPE3BA5Oua7jES33TF4atJV5jr1_vRntxgS
    C3rHU91Zln20aSLifJDQ_jr_bLvv4wwUwLchVgzWERVIj_Ik3bSSQ>
X-ME-Received: <xmr:zbPtalqbURB8SyzNetjce4E-jOdCrGcSnFINqnLvWXt4yN-7KdgBA3tVoUszfXVE_c8i5A>
X-ME-Proxy-Cause: dmFkZTEa8gPNBTbC5Lwyxe8TaeBboQADibc8e38oboVETAjSQGU2CR+KyR0xJ+NgbV3Mxl
    v5WYeHEpxni4NOBP6cirXel1yp1SnyDYuhbAPpuLvjlXrisHfuk20kvVVpmPwjqeGR19u9
    hGh8Bqiyk+MSsfh8Z2N79/D7jlZQY2LpNbhJz7Fkmpk/AQdU/lNEyD7N2XVgaVrDcA4YYQ
    Xifl7Wt8D/21PR1eVpjXqIzgvieJ8k1f86AlyENn/pyXCoT83KEUfjPcLCDdhEgSARi9B9
    m6ePmvO0QqXOnC1dY08hUKJ9U2gtgbLdneid4NIH1cLb3vz2sOEu174lxaqMaiCxWzwVJg
    OkJnMNYAt/S44JHbZ/s8Z5Z2MSOZBhHV4vkA4oJkVdSdvbKafPBmYrz/M+uNkC3dnuCxWs
    B3bV4l0KmoSXfJv2mKxPh2//P63DK3ov+RJiuza+grXDfSRijeM/HjMufjKhTti2eT1GCU
    sgoZYu7Vf1ZPW5tE6L3VnDzJZRb3ZPPfdN8Rx14j68f+tY7KzsqEw0FgXlGCKtM9jIrmhG
    qUWL6GNokbykkEHeGBYMgDdGGqj2UeV2dVcr+n6s6uv1F+IQa6PooLzPEgAs9M2exkIj3a
    G9rC4UX/U7wUVn56N/xv/ep7xxs7xtieHmcYy4WoB7Il57nErn/6ilFNiiAw
X-ME-Proxy: <xmx:zbPtallKJK-x0K77uOyP52ELyl_ZIy1nULY4NW2Ih5WV2Zq_VSY6Eg>
    <xmx:zbPtapwbEs_r2bFkJ00r-izeksW1AJt-4-XNaEn4DmGjIvc6F0H_HA>
    <xmx:zbPtatnU68jhgW0eVUYgOkCKLS_KTw3enqGb06Z4fY8k3QXkUfufjQ>
    <xmx:zbPtaidJRa_w6WXz22zhipGRmQqEnsap_eP-04ypgRT3wJ4Z_F3p5g>
    <xmx:zbPtahtdVIs_q8URMvFm3U921ZZxzJqJImHmInre2o7n7JT_FiTreV2P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 06:02:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6499631f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 11:02:35 +0000 (UTC)
Date: Fri, 6 Nov 2026 12:02:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] Improvements for storage format handling
Message-ID: <au2zyG0TY6IjmK39@pks.im>
References: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
 <CAOLa=ZROTekhsC5g4vQKgCKg-akb4X0DMFf3bcfbO2k0uHtxsg@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZROTekhsC5g4vQKgCKg-akb4X0DMFf3bcfbO2k0uHtxsg@mail.gmail.com>

On Fri, Nov 06, 2026 at 02:41:41AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this patch series includes a couple of improvements for how we handle
> > ref and object storage formats.
> >
> > Most importantly, this series allows us to run tests with a different
> > object storage backend via `GIT_TEST_DEFAULT_OBJECT_STORAGE_FORMAT=`. As
> > we don't have an alternative backend, I also introduce the ability to
> > specify a default object (and ref) storage format that carries a payload
> > so that you can run all tests with "files://objdir", for example. That
> > surfaces a bunch of tests that assume objects exist in ".git/objects".
> >
> > Overall it's a surprisingly small number of test failures, only 1105 out
> > of 35000 tests fail. Fixing those is not part of this patch series, but
> > we'll start upstreaming fixes once this lands. Such tests will either
> > have to be adapted to use plumbing commands, or they'll need to be
> > tagged with a prerequisite. It's going to be a bunch of work, but it's
> > basically preparing for the introduction of alternative backends
> > already.
> >
> > The series is built on top of 0ffa3e35c7c (The 15th batch, 2026-11-04)
> > with ps/odb-object-storage-extension at 87a55d790ca (builtin/submodule:
> > propagate "--object-storage-format=", 2026-10-27) merged into it.
> >
> > Thanks!
> >
> > Patrick
> >
> 
> This was a very easy read. I don't have much to add apart from a comment
> on 1/5. But you can also leave it as is! Thanks

Thanks for your review! I'd prefer to leave 1/5 as-is as explained in my
reply there.

Patrick
