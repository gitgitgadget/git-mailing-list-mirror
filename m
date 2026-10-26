Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012910;
	b=xObqHSWAF7JW0Ty7VLvCexlX+9Qghj/04ykDfn1JwbplnEps1LKisLfS1Zuc4IPsdpXO
	 2Ub5nyaUVRL+jhGuZm9sA/1DnpD4FvhxbXKrAq2JCSzxpmZc8GF1pcHZktCO8N8p3Blf+
	 LOJEBBIs5s/L3DyHRyiOIe5XH9W6PWUavUgNyIJl+HwLj8mYHoZXSRdjCR2PyHcoM3y2K
	 L71DhUcufH67c3n36sLCFjfzzBL7A9jjrzl8Uo4yORiInRkrBrsysPBHiIRjTHtlkLqCK
	 gPN53SzouJYtcwoI+BFv8kPO5oDx/mY8O+16GCOlXj+Nf6ySbkaKtNRp5cON3f5Qopg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012910;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fzvjBzdv7HZ1JxkMhURypJFRaeC55V5PPaNInwVWomI=;
	b=r25g0ti6Zgt9i5NVAh9FbmzOwfowXh6ya2Kcyo1KxQFjx1tt1TN6PMnJ3puUlMRmjRJY
	 8RjeQ5111ki/EvLT2bFmLGewiOefIpkKXV8eOfS8HO4c4debQbWVQHVjOkaa/J8BK6rxQ
	 XihKSCaPiYja0JRrwjiNdEX2KyPi1IDTI0Vs5zKK/wPMLNXs1PX1n4FgERf2VnQupH+rp
	 Q1pTuuPDM/815Rf1N99M0dsNKnlTcbQaUN3ko9QGyRqY+uzNf39ho0S51zO2gQIAlTetK
	 feeSjaeeGv3QGp3W6cjly4G1FjR5zjJxxK5+gWE492YCtHQfy+xpWwTSUQ3Rt9VTS8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="a/FsS0KH";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="ys/k/0jc";
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D33606A329
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42D33606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=a/FsS0KH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ys/k/0jc
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 924BA7A01BB
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:08:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 26 Oct 2026 07:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793012908; x=1793099308; bh=fzvjBzdv7H
	Z1JxkMhURypJFRaeC55V5PPaNInwVWomI=; b=a/FsS0KHau2gTDWwzeBkNylgSG
	JQ0tjRoW9DVyM/2mMzXnudMDAStFRc0WWV3+k6fqeGx5L4GwNxVOu/6g8MfjQL77
	SiaWAprPvrvnS2ulqofmxnbF5PoxEN845D6IRaVF0e4FepRC36DRII33djd6J6eJ
	sthx/e2AVtJbGtzXhTwK1NO380XS2G0sssHjQbueRMZze5eMWttuIeSysVQCfUO9
	xuxvu15uobVIIBysa1M+49HKg7lTXq9vHJLpSc8/niJ0OYDrqnuUuw7/vFBTFK6C
	uuv1mDrvhWWKuzaH05dcExcXFEJ2GgsnBr6Gxq9KhF1fNxU9cwl7VlmKxygA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793012908; x=1793099308; bh=fzvjBzdv7HZ1JxkMhURypJFRaeC55V5PPaN
	InwVWomI=; b=ys/k/0jcZvmGCZ9mlrwj+MuJve4wGXb9bPFavIkP5HfUr8Ygj6+
	ctFhnfZ3x3ODBXP2hDwNXvG9eyPElQFf161gf5zuVOlFyYR0UIgQG6KSIVgl3GKD
	XJxnYGsT5XzkLe0ND1NciX25lk5bq8r2+hLmpk4M6qWZiYORsHVb9xjdQriSTXwb
	28o3fJN0XBaj/7C1qxPxDpPQBAiturY7ub/+tX/UA1AU+gLJtisquV233swrHCvz
	NH3VTEVORGnfZrDRywqSUYaq/ZSUdaDD23uaKFhmWY90gqDaLtVKLKAQnqUqmoNL
	g4WxOxfVjesZx62Q2h24Dk/+nv/P7ZgjLGg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793012908; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UziwqANceH4hddCRE0MR1TnlI7ziAq0HUYHsVJbTYApdtRX
	dGqM3eCdKTcOpLPVrssYvpaSflpRS/dnMZ4R8srvHhDNcvuBeRhJVPdW2PHFkkfk
	5NAUXOOZfqSMFRvmu5/rqR6o2tlU4Jh4RfAmGVbApgMyL8iJ1aNC+HoKqTscHZND
	6V/CHnn4q/KRhSXB4r8uGwMKIumdpA/pPNOBfgYDu/12RmgUYMJBOJ98freM8r7p
	eEWq27jCfYQlmAPk9+kLPfcG/4lL+PitGTs0u7CKKgmxT0Oy6BzGbITXXRCx3VW0
	xv0La3xuec1NUulKKI1qqhDs9x/Z5D4yAum8tMg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VGOdAYZM4iVU4evg6SsYKtyjfNyEF4c26jADmoSwLOY=:tu6Ukf/0qkAH7N6XXLKnzq399DSNw1UmDntlkgFK7XI=;
X-ME-Sender: <xms:rDTfan3I51x-gmg3ZQd27J_joURNDylFKEwjFCRzY3_DhVF3WB---Q>
    <xme:rDTfatii3rdHRf7Sjh-ryLoilIKw-yzltzWQmolIQaO1gkMsCnFSn_zjlb_D-Y4Y2
    FNuJK_p94G6OskWX3qNZfdIxIdHb73J8e3-_H0SRzKEuvfcHQZCHSc>
X-ME-Received: <xmr:rDTfalRut_MolY_76v1opYH8SbBeLUuA4pEuAPP3i0E5pUzk-j3E0w>
X-ME-Proxy-Cause: dmFkZTFn2IRUaAv3B2z8sPlQNPCazFcDn7WtN8fTcyZOpZZx7bZqBeIv7Dk/qkka99xHAx
    eNrObYfO6tWXBbEcAPhNelrvuumPB+3lX0lsL76rFJS2mzSLuuLRMK5QKqtApNxcCy/HAC
    qrr5whcvNSb3P7Z8J5LR3MGYccbAGrTD1qrzc+yvSKTdBCMfEqzryplml+B7VojtiWEtQJ
    6yc2h7pb3qc7ra3QdE4pJLWSw1hkk/ATXz5c2rc17QEYZ9taQDxp8kVyGqZ1XpHsQQJedx
    wkSPLKuvv+la2u15TBJgCkZrH/pBrF/LXk926a0pj3owBHr4hPil5xpuZKez5oGqjFa4FY
    FsyMNkSnVVb8yiZxRhNjh5LNZscjymubtnbQpzb+XHmpcOxnenhnBo+YDEh0hzWnAFplXP
    o+YMKYqH9xEx0pa05t5Q54RbzPucpOHucMzi5snjEUlnKVNG54wOJRLYvQa+2fdaziNItX
    JdP6bHVJNl2Dsha0MACbGbRLCdxK2qe2PHJ3YQHq4VqexGDt6NWQ9YXytHts6bMVF1zJUe
    mk0FWPnhwgjl6ykTGw3qx+t7s9qaT7Fo2lB6szE1SC0e/m116iHHtuOitIKgZQuVFtcvLX
    SO9PHK6skopSViVbGeqVtmvDuaoSjHAR9t6iE2ixjp6ccqAxg9uNAzPlkfBw
X-ME-Proxy: <xmx:rDTfamj1cwiSXi2rmbIAXLMR2fpDXGMgcKX1FHtvx3W6oqe29ytzJA>
    <xmx:rDTfat5oHJ5a3LxyukQGvG_FuQvG4rScyCOFP59ltXqzxRR2uG5l3w>
    <xmx:rDTfarCbiRPN9NP981FYuUu8SUKrVCvYi8a1EWCpDX6o-chtElt2Cw>
    <xmx:rDTfasZzioc88A8C2eg3T525W18gnM3UfO8Y8YZX0Cq-1LQ7Oy_k8g>
    <xmx:rDTfap_okqffQwFOWqLpP3k8fB0rcMYVKCTh_PZO-8Ua1BVwMF4KjLBp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:08:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1a2773b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 11:08:27 +0000 (UTC)
Date: Mon, 26 Oct 2026 12:08:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 1/2] ci: drop quarantine removal for macos perforce
 binaries
Message-ID: <at80qOfTn5_YUY_f@pks.im>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
 <pull.2403.v3.git.git.1793008465.gitgitgadget@gmail.com>
 <e85ce85d921f5c847c4a370a5c56c98f2f20cee2.1793008465.git.gitgitgadget@gmail.com>
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
In-Reply-To: <e85ce85d921f5c847c4a370a5c56c98f2f20cee2.1793008465.git.gitgitgadget@gmail.com>

On Mon, Oct 26, 2026 at 09:54:24AM +0000, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> A file downloaded with wget never gets com.apple.quarantine set,
> only Safari, Finder, and AirDrop apply that attribute through the
> LaunchServices quarantine API.

This is the explanation why we can remove the flag, but we haven't even
talked about the observation or what we want to do.

> 5ed9fc3fc8 (ci: prevent `perforce` from being quarantined,
> 2020-02-27) added this to stop p4d -V from hanging on a GUI

Nit: you start talking about "this" without even saying what "this" is.

> confirmation dialog that never comes on a CI box, back when perforce
> was installed via Homebrew's --no-quarantine cask flag. When
> 49af448197 (ci: reintroduce prevention from perforce being
> quarantined in macOS, 2022-05-12) replaced that with a plain wget and
> tar download, it kept an xattr -d call as a precaution while noting
> that call already does nothing on GitHub Actions. It has been a
> silent no-op ever since.

So the question is what this does on GitLab CI. [1] will answer that
question once the pipeline has succeeded.

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/714
