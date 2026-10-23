Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781380;
	b=I9HFkxtJ7gX8XbPv+rC5GORqEzaVSibQBrWozjUwAculJ3TW/SYoeIvB8HoTU81Sr9lI
	 MxNxuw6gbNssseKigQqaQj/rg+ljyEp9x8ZCtpn+Zi4c+JXVwXa6ws768CTaOKeYEA0NM
	 Xg9TK+LjQ2XgE3He2mOM7i3H4mvjkk79oI4oe+SwIZvUFCVW8vWAraTbfdOaSxpC7FtmT
	 OS0GkLpP44TYIkgoRtCVbCzZXmaIsSrBRe7ClUaymuk2E6C3ZnFs/We1WB80R7iqU1pKK
	 o4UBT1LZdVvF6MN9CGHWaN1OVub3tXAEOdXpLWoV8v3AOtG9bgFNHxPFetnNdctfPvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781380;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=elqAk79lJ8F6PFN5ayvKh55xlCTSFJAMhp2KEmOXifs=;
	b=O6/HofLQ/Tmvb5HE3t5PMRSP+3nBvZaVADLIO7kuyLg2GpJulXbNi7wmtUUUZxjxlKqy
	 WYGrEQK6HxPuhMglQBTjLhpuXXrRiOz5WvZP1/tZcfENgUzfBnCL09frVB/unNmGOUQdm
	 heUlcdSChxsm9yfCln0BpMzVO0C8TQIQzoqi+6Oj6RGyee/8Lv555Co7vA4gWQwoGTBT8
	 e21xZniPpnSE82sx+LTWbZxxUG3CfbGE2tDLj3nMvemyanJpumZ65HSmT496Nh7t1Hs8P
	 cBTmtRQDMsHu+nzkNRTBCKSXMjTSOu6W/XOSKEgyDYwbvexKtwq0wkag1g/xBAbKHWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=VoFgJL3c;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="Fp9/I21W";
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848B606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5848B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=VoFgJL3c;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Fp9/I21W
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B5E001D000B0
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:49:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 23 Oct 2026 14:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792781379; x=1792867779; bh=elqAk79lJ8
	F6PFN5ayvKh55xlCTSFJAMhp2KEmOXifs=; b=VoFgJL3ch0vCFEM8jjHRafJtGS
	oSSOG3hBtjauOmHuunlt5zPfBoT13Jd4PMKambTUS/y/5FXmrhyU75CuwhgJDnAO
	xAQP8WPzGZ5st2aHge6H+TT0IMnz1+gb+Ebxvz/g+V6412a2Asn6IJuicpgLUjbG
	7NRCiZ/9eUl/gDIAPQLwceGyOJSANdrZ1ZBnvltpV1POMsaQBD5YkQ/y6ZTCNaaF
	4Qn8cpMJjHjw8XIE+cYRLCgpJrTn2HrEh6+Xh1FBXmBeaNROJw9rwGucF6lRUwzK
	unEegOVE5PdWeI9eYGZHcJPir7bDj2dd+6AEfmK5cT6mSQcpAphTg1z5sbhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792781379; x=1792867779; bh=elqAk79lJ8F6PFN5ayvKh55xlCTSFJAMhp2
	KEmOXifs=; b=Fp9/I21WPi8bc2Y1IKnPCoEhBEATumn/B2MQRim72rWxjAl+Dcu
	4twZiHAz9jUXTiF1iL1Sv4ydUlFu/ZllB/8We8iqbE99CBYTh/3tlRNxHz+2NAh9
	nyaqDW2+7WAupdV+b6s+5nsQrQFlZei9GsZbWLIEP1QT4mOhc9Z8Uwd0x2Rx1/w4
	62UncxE4BZbgekTIHs/h3GDus7TOV1sCdzc5aZhNS1GwTiwu4Ycxon8v8pvCoLb2
	rMCrrTFOEPkkWglFnKydRoG0DBr/N3UxuMojetHWQou8+y7dcw4CGWIseOaE7Sae
	UPWU+bmbdaQtoSANHBXg/+T9B2jE5g+zxdw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792781379; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:qHZRtUaTbhSkvaPeNzwKYdUCRmUQyqi/g8Z3TCRpz06LcZt
	JY15CchWC49TkzpO7yxOoxgbBt5gGre4Gn8h1bOP5JRzZdGC5PUL4W9EX2c+Su7w
	HskvIF1qUdNsAat3CeAR92zXfbdW0oFB+31uh3W3gACZqhvKj+k6uTjyaz1fuLkj
	DZm0o2Mh28Amb3OYbdaR3SdfCLPAiDTKMEaJzDGcpxWth1UrN6dEwG/QrG3W6bSR
	HmkndVpKeHtxg7Syc25RfiAabZNfp2yl/1oJtYrlL+MdIPoX1np9wvhqMN306/rC
	/NLCZMtEm6EsUpyoWBqJ/9iTBC3IEA0lolqZEhA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7q6+HgW8yEyv/hNZpdVXVlCEa+4N+dzahV2Gq9nzvAE=:zdCQ9DQo1LN9y+MFA9DQwEPlAtDzx+vemwFNiAY9UTQ=;
X-ME-Sender: <xms:Q6zbajp0HEF69KB2l-5YQktuTgjFd2qTbvJZ4cdyt6m3cZrFbWvrAQ>
    <xme:Q6zbakh_LtZrNS9vxT91WsC-Qv4pDK0K__7j5JQCuUumC_c-2BtXwoTS79NqzBAQb
    9x1COShVRyJVxt1hsKqgOV0L7OSI9Gkv2Qrx7jZ_e11RQC5pYGZUb0>
X-ME-Received: <xmr:Q6zbaoh0mWH9hqvXYG_pP_ttcATLHtHDxQg2xmQxoSV55OyOKsl2KIUMM5-UoSVNS2StIHDlIfxhu5qvDRO6MwV8MJWnRE0kZlrW>
X-ME-Proxy-Cause: dmFkZTGqNBoEWP8Ibbe1fuNnlnr26HM4Rr0MSQF93piW0zUKyj7uSNi/vrZy7NcvurLiuU
    LlbQYumzcK7RyTTvbr+h6ZmL2N96gf5KO6TI862g2GF0MokKc3z6+rAdT3l1c3hFwxVG+i
    l0eYqGPtGi0CKGnfvBElPPRlkoKUwLgHPShSNKBV45AGhlpJACxp5vUOrw7uzrM59gqUnL
    GPRmc2LBr1jMDfZzQr2v+JUlDFczAVkMMboadO3+0NrII9/Tije9Pbt5zGpGiaeCY0UMNO
    0XyybpokqLy6DdnaC3BOtogpQntAva2R94NOmDrG9IVKVQWo2Cwci2qAwHPJ0SMbTQO3AA
    FovpAyoYRK4xqEciRZlu8fHSVQMk3tX6R/UYsaS4qCuqQBwGG/9MGnwO9R/JMhgBQ3WrQY
    xPVbEoHswrNW5whDG9FvVU083HZAfUbFxhT1kHy/YF6JHopx/C3UtTYnYqZ18iDjXp35vP
    fDnUzdgXFxrkyXZvq2FRSQjcvlBpcFmjNMde81/oAzN6NaOdqweZOxlMsK+rwPtAzJrfGQ
    oUG6wJ58Eee9ONNyIeRZoHpQaKYl5Sn+Y3AgVgEpDgljHyiEJkTsYB01fzUNiIOOQ5U8Aj
    +qKUculxAFAvoL+9rQy+B+UTxQuIKZAr97zVrcRf6Cn5mEs3Gxosw8WLuGNg
X-ME-Proxy: <xmx:Q6zbaij4CVANn8y52Tnqez3vu_OoMjjPH_t3GL_6Jm4tN9x0tFR7cA>
    <xmx:Q6zbagJWKLNQ7zP5mZ5TpLTqzgZbPL0XciH6m-__RSzBOXb6MCMQiA>
    <xmx:Q6zbapHERo_ax2lKxLM9RmOZcKq5zPnoD-8qS23niQjpM2pSWgF2Zw>
    <xmx:Q6zbasQ_od_FHZT3LICwkV_tYJmCxloXLOADAnqrM-2JwG6kJAd3-A>
    <xmx:Q6zbalwcGV2uUoD4aClIp4hhTyI4DcGw2Acp_dJowl-8bGNSwiBREUmM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 14:49:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v2] diff-delta: use safe integer arithmetic
In-Reply-To: <fe3d651a-d1af-47a7-9b7b-a4ff242ca303@gmail.com> (Phillip Wood's
	message of "Fri, 23 Oct 2026 16:15:47 +0100")
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
	<pull.2276.v2.git.1792734993812.gitgitgadget@gmail.com>
	<fe3d651a-d1af-47a7-9b7b-a4ff242ca303@gmail.com>
Date: Fri, 23 Oct 2026 11:49:37 -0700
Message-ID: <xmqq8q3o5k1q.fsf@gitster.g>
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
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +	memsize = st_add3(sizeof(*index),
>> +			st_mult(sizeof(*packed_hash), hsize + 1),
>
> What are the bounds of hsize? Can adding one to it overflow? The 
> alignment is off here as well, all the arguments to st_add3() should be 
> aligned.

Very good question, and I think hsize is capped at 1^26 in a code
early in this function, which makes this safe.  It needs to be
explained why it is safe in the log message, though.
