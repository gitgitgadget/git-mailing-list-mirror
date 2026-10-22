Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792648578;
	b=ixKFVmICrv1Jd2rFMgfv5uF5GsBMGGHJu6Zgz+8ng/2Dr3LxmyEANbr/VXZYFAaKoq8C
	 /tIttJTvgOYxy6TGn99OWLJRCgBq/NSvF37FKOU6u3/FjSPIA0FXceMA2hLvAkQ9PEdgu
	 p4z22gKkb1ElU+ye0o/8S/VBOmQwPcLZegXpvRJNzPE6nQgvotBiP83XU9Mpl3LiGLKAw
	 YMZJ/VmYgfpr8Es3Bcc5FX+lJnWilsUnFu6q3wgJsM+lRg1Ytf6wcQ360IxukGMXBdZgr
	 1IGU5unAsDMHIdPFgO+6PQqTtSQzogwhMAcNBRDkl9NsGabnlGhtYWGAOxkyiE0aHeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792648578;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rIMC1HabvBJwOXYBIC0nOqVl2JPVfWMIoOcKSsdjxGw=;
	b=tNACBaAcEwg1MnJ2/zMMAKdzX3qyVFIS1f2HkHid8A6qLrpZ++1IW+rlxwSE7hfTjywk
	 hUI5ZQCblbzDwL/E6Ski7ilB5SnXsCjeyYv7Il7f1OUCOet5FXn9AcB10qeg1n1Y1v8BV
	 BOz+wjPtGsNMwYHFiFJSG7K7u8dbmXXK8vXr6ONRdlxHamF5eNmD3N3hIe9QzuX3VG9IX
	 rg5NjfyGJccFBfQqrKCImpX/pwBRMQbsc9PkCkv92fCiMvat3gfXOgrfniXkStLizmhr6
	 imcyoggdRRIjwLTlCQ3YMU//QKwz+e8H1wbXI54QQO2fOMov6s7d6DNn8fLZWVSRCOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ZvcEbGFU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hc97sMhX;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAF6606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 05:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFAF6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ZvcEbGFU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hc97sMhX
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECC847A00D0
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 01:56:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 22 Oct 2026 01:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792648576; x=1792734976; bh=rIMC1HabvB
	JwOXYBIC0nOqVl2JPVfWMIoOcKSsdjxGw=; b=ZvcEbGFUxTuYMmV+BzJTViXvhp
	xJhoJHj5ZF4cWpmOTsrPeOZNQYauoO0HaDpTmMeZb0PXVsthvxhCcSaVj7Z+FHDM
	Pbrc3Y4WsHbKb7CPsawzpfSV2kgG7QUhqhVL2jGOQ3CfDT0GNDBhDOoMfGgsAeF4
	uMwq4ybZM5V7ytOXiHlqYjRhiW7hU79mGUkIIkx+z8kx/x5dB0WmD19FYyD9mviS
	c8Pt0S8QmUzBILRDYmbmLccE0u7qJxEQxaOIzvMlTIIlPK//jYuCjFC/1jqj4LCm
	UE86n6VYjHvofXyD9g1A1goeOmlXnoDlWSoYjXZtD05mfLIBumawrrBpNLHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792648576; x=1792734976; bh=rIMC1HabvBJwOXYBIC0nOqVl2JPVfWMIoOc
	KSsdjxGw=; b=hc97sMhX6ax2u3KaCVnikBitPMxlNlzxKBtf2wt2dMHm9SG/ER4
	8FuAh8zJZg4hwfJ9Yi0XxQh9cU4fMXt64WRcPxXz/waplYCDlij5GmPCp1KXOfFf
	jpew7i0ZAHsH0NfPl2UgqqD8GVdRs89+JLp+XkdVtSPuahJ1b+9yyHSQnlDkN7uB
	rZFppuB9vvuUCpQ5RoihTZ6aFCJDoM9ndBde4UtTmDPDHbblEiMUab9+6Iq7T9yb
	fkqMaHnSgvb1nWwHrYljS+bYniV4omdNfYeWhl0ad78tWjHxjONtGNnEKuadg79L
	nH7UzHjJ287zqz6rhN1osOxHuyEtVNrMUjg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792648576; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:qMowtEHTkR8ttTitXK0sBFEzZQJr5tZRsMbP/GoWVhrfcDv
	Is430etXNPA6AHITaudDWFzzZTcBH0/NC03nPi+H6Slj1IMyexjYGBLuqoTjCZNh
	WZMA66K95PqoUe8OKsR+QE0PVXlvgKn9u/xpzRuzLGpMgE2QFl/skv9F7YeFtemt
	B6byQOGkvvgD3Q3mmVbyrHVVpNWYxGqCQhUEr4LSc2GFmhjJk1vs7MZH8opgNTgC
	Yhlwhf3B7sjl463iN/z9J+q8s20lZw2K/Lsy+M+OzLJx44brZP0X1iOYqSLIiSxp
	cVruIM9D49PvPuA0/DIgrzrNke8m4obegV+c6mQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4T9cZczLeP9X9UY56zl+uQeN3T0MIjU1e91IXUMpVBo=:tf7Kj5sQ1YstcKgPUCTOVyd6P/JN1sSiKCoLIZkqv48=;
X-ME-Sender: <xms:gKXZasPCnVQ4D8sWn8ZPRFudycK_VtIOd50xI9TSxgiewQtQyUMlmw>
    <xme:gKXZao--fkITG8_EnfFrJZl_GbiHRyK2t9P_GKMAVdg6N6Q2uxYFNEeXItRMmBnUn
    aldVWneLoFu48JpvqdOVyDeFHwOn4o_BWSIMmZ2hE_-f_lxftDJhzQ>
X-ME-Received: <xmr:gKXZag6TSBHR9lsImUAVTVjJw5V5WSYmBLqOn79zTeb0b6BeS0yl_cbVQwqMhRT_oAzQWA>
X-ME-Proxy-Cause: dmFkZTEun2C7+p8hc1iVd2HmDBRmZsR0XxJjfxoLk1icTgjdtPXH25FLNzIk9LqYmiLJ7l
    weis/Ue8Is29h4AtjsX/jPTw3JOnECwyqdWgJZOIiRj2AXjrBJS8mAplN8Q3908+Ja+9d6
    ZtgVAzReWV4TzsPJO/dVFPAMJV8CUnmbbe6a1l6of25B6GyNpHtLv5fentU+3fmRgqnwNN
    F/MOzig5uh7ZIZO7xKri5H7VoksRi2zHim/mSd0ijWmYcdVPcRl3w5R7N/6YKWXIfF9OUj
    r0S1+lMgAXEXOAPwcZJDu1EIqeUJAaG08QvxMOwGVBNycySjOAfM/JacmfuOYt1k+baJLg
    cnIK+rHoexh2q/Fstj4Gp6+dcwkBdaWUVvjnTWbuq5WlYYR71QP+way0j6FTKhQU2aUzYI
    m+iSIOvNegAzrtxxs48O+npKi+2sTjPuSZ2y2zLcx++UAGDxjEqhNNrYMmcMs88EYX8Itv
    tZgFYQP7uZppjsbdd3YiT2Twy87xXLKG17GLMM2a7Q2Zihd/feigUYM40MmUqOYkawZMY5
    hyx+0bCwKp/Y/A5jqDTOdGw15SegUEUH3xGB46CT3jKuQqJoTrFvgfMRlPGBNPhQylhyQ8
    D7peYfh0GPmjFn45e5ktoGbiAAo79NDQS88/fQfLHxKMPNoVoQXzWGao4j0w
X-ME-Proxy: <xmx:gKXZav15x2zERyEIfQ-kRnGuMj4jlBg5X7URqLQKqTUANiPbp5n7wA>
    <xmx:gKXZanC8ik3VLniEuItoe5bPXKYEWrm-mq4dGjr5OL9M1pvLTZpcWw>
    <xmx:gKXZah3HNh7toU53exicmuwELEfaBCNcuU5u-Xt0N04xfjM7u6P_Mw>
    <xmx:gKXZahuIh6TUr9xKDjMShTNrPNuKFu7nQ-q7dImPBu-JcZI73YT90g>
    <xmx:gKXZau_xG5w0jSpi23y82twZD6gN3pW4l4k1qfiemwxMhSO5rZAzm126>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 01:56:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83fcc52a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Oct 2026 05:56:14 +0000 (UTC)
Date: Thu, 22 Oct 2026 07:56:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 0/4] object-file: fix ".keep" lockfile ownership in
 ODB transactions
Message-ID: <atmle8tlGVcHpzs4@pks.im>
References: <20261020132900.1208343-1-jltobler@gmail.com>
 <20261021182528.3055494-1-jltobler@gmail.com>
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
In-Reply-To: <20261021182528.3055494-1-jltobler@gmail.com>

On Wed, Oct 21, 2026 at 01:25:24PM -0500, Justin Tobler wrote:
> Change since V3:
>   - Followed Patrick's suggestion correctly this time.

Thanks for bearing with me. I'm happy with this version.

Patrick
