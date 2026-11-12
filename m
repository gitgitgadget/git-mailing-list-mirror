Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506033;
	b=LXYRZDpxDDJsOvJJKHtElQ2bKRct/YnAO4L/D3Nq5fytBUV/7u972WCUFxqzqtA0eVqe
	 aXzZXRnSl+5mnYsEWi3m0W5pxvPhcdxpjaqA6Ob363KdVMDGtPypp8790NE/b5ZGNZfQT
	 +pNTnXsJj2uisP4oRCDhcEQ+v4cKUc3jnOL/aDUljcH49Mfhza4PxDvR9m0/JyqgwRASe
	 5x+fDThHfo2KNAIm5TDHuuhbUeFsM+GFV03KzUleAzpc8kVnCdXuw4oP6uwQmzInaihDT
	 /aVUMfZ84w8veTApw8l8QR+La8ce2tMpeNU6TeCtDv8tCUlJC8CR8jvl/YUp3ckgfgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506033;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=VY4PS3muNcJG8OgAlDu35HXbFCUweBdug/U+NfJE8Ew=;
	b=IR7Lb41Xfc+MIydJ6Y+XbxGD6mKRMBRznGSeb1nc0Zv1pQyaCls7iTpUVJRxNE+K3PSI
	 J/HTrcY6uMXPiyLoQToCt7phdWcma34exUkqkFZ7ZzsSGDOG3aU1/jrfTm5CIqd2lCPNx
	 In4mDoY1uyTfU7pVSg6Ozm/hnA70RI8VAaY+svtktHuce9kIC7FttzLN3M0eXVAsAaPRP
	 cN0pnAEqCosrSz/PgOVGCVnFz9ELDu9vl5VWPUFjr1qu6+n0G2tp+GnsROL+PU4h0ZC99
	 +PgjE68LIYvM6UEr1/0MsLizTD05Kpc8u8LsB3EJW6Sc5GTiQtkp9itUFzmuSAzQQHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NSnrX2TS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="gEXy/RYn";
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3F606A327
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DA3F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=NSnrX2TS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gEXy/RYn
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AB5EFEC0224
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 12:53:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 12 Nov 2026 12:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794506031; x=1794592431; bh=VY4PS3muNc
	JG8OgAlDu35HXbFCUweBdug/U+NfJE8Ew=; b=NSnrX2TSZAKUSwrRH3lQYvN6Nk
	0rY980HfsWi6n2g1rM7yRm7oaolYhV7Obwh1XL5VAt6hDgic6reQs9G1Pb53pUX9
	390RmLkTEkiEBoQVUpW/oPuDV1ItICrehtMTt4zNyfNBJZpgzdNish9uf5tqNAby
	rMCiPx69UqgzpLP7Vt4Bn6K9jfIcbj0jByAmHK8tv0Oo27sTgEBTWZxPnQw/76yw
	1tpKAf2QHJqMn7r46l8Vrmhd9vWX6LAFzKd0Ry8VNjaY0PEVaaF+rrlhNGXP61j7
	WpCfRu4EtNYST+NgHcwWiN6cgk0fs+JvvI+UoQfzpJIBxgmyyZhFNB9fg8hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794506031; x=1794592431; bh=VY4PS3muNcJG8OgAlDu35HXbFCUweBdug/U
	+NfJE8Ew=; b=gEXy/RYnShOcYNCojz8s5lfQ4Zkp2IUevWr6Zilc+5LQRFs2FEy
	kaOlJ0A+MJP+WZC+3bXS5encjcAAxNmGroP3lihyS+PSCWBsGSJFklIv2KqSxvOv
	ZrYXEaC9+9NGOMd7J1mAaHaRg6FYWw3a95iOGeRDOB3ZOmygmP4JNegTYOTBlMsN
	prIQDC+Bj0gf2ABzILMCO413Dok8Vog1WEt3ARJTMuiNhRd31KZmYlgCmY40658B
	HgtHkqmZpGguRfC3dUV9dGwsTLLsu1CoxZVHdZ+M/3NOXjIkNQD41XaFwCeRlXsK
	apqbsupjZOe9KczPP1K2A/BI2iwXcwsV7yg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794506031; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CrjqykZ4l5z54XQ5Rc5JErDf0ejcKHtYWcqGh7m76oji9sN
	2jhI0pUiF7bxt2xwHSx1vUsQTHri+WUfVjhfEPF+PNp9bCbMg08/acQBvi/Fcqrm
	IPvxaSYQCwdTqdV3stf/4WxoRQ1NKCVvVGu79DmTwZWMYWuZ307bRGJriILl7QhI
	d6lRHU2xfHzi0Xt+lxq/DnF30InrV7LcehQe6W4TGbaC03IADAgJxQ42sYXklW/p
	Yry4F8bMdEIsaZE0XwFoK/xHz3KduoIZRLXzjprVtAMoq9VlssukVf1XPHxb+qKm
	waTbS2XeK+l/Hvp8lJop27mwxhrFehc+ozC/ABw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xE85Km5r13cxylb+KXrfFKLs/+7Jl2gOwizoQppWCzQ=:CfEuADFsBCBEf2/jLHeIoPBQsfdOely+YM7w1aAQX88=;
X-ME-Sender: <xms:Lf31avDCbZepxHbThwhW7_2T36F30lJRgeuHuoqXWtHUVmpXZqkL0w>
    <xme:Lf31akAoigsxWOFuIe2G5KtBYk3v55mMMMAyC70UT5ThoVzn31C2h6lI-GPKCgcBU
    pByEmL69lQAS7ga7EfpVR5T_LAZ7_1J5l7_VfCZ1Le62_AzSmAzn80>
X-ME-Received: <xmr:Lf31amHiGkOYxqM3lb-t4aFeoPBy6PgmWuAa8LxAPtq_MD4CjYi67g5hsuk4_bHeu_5tAysQk0hwxAvw5zPgeI7cJErSLTART6gY>
X-ME-Proxy-Cause: dmFkZTGtQvZHJmKbYz7Rvx/R9Ou7+SbEQQuV5REFlTnukYTRvQfph2QG/fJSjVTLy2EbOB
    mKPAX0eNJ+y6tH1GTXQtBgmm1iNKn7dFloJ5cI6a1ivQjg7oVKnWQ2DvO0OUcGKqcyjs7L
    UnuQJYS/Q7gNiImOG3EHyk9lJP3brY3Swvgn8gj83qYnviL47bgTmJbPCeyxBdeVCm+wY3
    TyZ6MrCUknOHFx7J+0gNyDFVpV9xwSWp1DMDncNGhFDyviDaTNDlJKhFw7NwyGxyYpu4w7
    OxKtQO0iWT9GCH35PBGyN801xvqTJRI8/9ty+uGUYyN+xBt/Was3BtHhLJHKB/Kj2T2QqD
    29fKkcVabM5zDC/ujilOvnfUfJK1kFpsv/eufLt//Z7DuJ0nJ6Fsoy9bXi5UTYeWEZhgbd
    +1PfPsH8GqJyDFIMHicwd7R5AEPG1ODbRSv6QV3vZ7XpPTzRsv1puM7dKJDMwh6qA0+Bd7
    wXv2t4Je5ID23zHk17vXZmMDXIOBVx1w3tFVwAlo8LbA+mnA1f5ZzJmv2TIsoc9TbNSqKJ
    mGh/QDo1g5yHa6uikBiqWK/58Y9A/nMy0T1VBy6WNvDyauKhiC6YsSitIIHrEzT8jypZzU
    XfUwtjrdlg8bIZF80QRCWaS9uvtK6T2NHNVtO9LOUiDzwlg1LiaF0zGvHyGQ
X-ME-Proxy: <xmx:Lf31ar4cvWuLE13ZFvMcKajCW2ZaIFbmDnF41eFshpDXFNPGocq0Qg>
    <xmx:Lf31atRwYEtNtUya9nLrKTOYWDN3yZUsq7xDGEbZ55oH9o87bTyClA>
    <xmx:Lf31am4TmtsTskI5hirIp0xHxfTAk0WvCkJwIZJCjuSXODLxUVyubQ>
    <xmx:Lf31aqQurML85gQwyxrCL3Y6RzgUm9CunD8bt68goSyFG3Dli-4z0A>
    <xmx:L_31avmaWr9sh8Q0Ht2Zcu1asgdIh9vcR5SBTgvFbkRFR6sSfw8SxyV3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 12:53:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Jeff
 King <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>,  Colin Hinton <colinlewishinton@gmail.com>,  Matt Hunter
 <m@lfurio.us>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Usman
 Akinyemi <usmanakinyemi202@gmail.com>,  Miklos Vajna
 <vmiklos@collabora.com>,  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v3 00/15] Fix segfaults on settings given without a value
In-Reply-To: <e8f6cbb1-8324-44e8-b703-d7a29ae7fa09@gmail.com> (Derrick
	Stolee's message of "Thu, 12 Nov 2026 09:25:47 -0500")
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
	<e8f6cbb1-8324-44e8-b703-d7a29ae7fa09@gmail.com>
Date: Thu, 12 Nov 2026 09:53:47 -0800
Message-ID: <xmqqqzgqj5qs.fsf@gitster.g>
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

Derrick Stolee <stolee@gmail.com> writes:

> On 11/11/2026 5:49 PM, Thomas Bachem via GitGitGadget wrote:
>> A setting given without a value, as in "git -c foo.bar" or a bare "bar"
>> under "[foo]", is passed as NULL to the code that reads it. In these places
>> git does not check for that and segfaults:
>
> ...
>> Changes since v2:
>> 
>>  * Where an invalid value is ignored, a missing one now is too, with a
>>    warning: remote.*.tagOpt (patch 6) and color.blame.repeatedLines (patch
>>    7). v2 rejected them (Phillip).
>> 
>>  * The test in patch 1 rebases onto HEAD~3 and checks the result with
>>    test_commit_message (Phillip).
>
> I reviewed the range-diff and found it reasonable.
>
> But I was also happy with v2, so I look forward to
> Phillip chiming in on v3.

Thanks for writing and reviewing.  Let me mark the topic as ready
for 'next' then.
