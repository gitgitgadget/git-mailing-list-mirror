Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778178;
	b=c0LPyIxzOfqPaE9f4lNlmr7uDRYoETa5LrtCfxheje3c3cH1E48h/h9a5CXcqmXc+Tt8
	 PwWZtQ4rtqFBlxaPsq4dvEzP0fIpdIFO3g5WOxkmqOGsx4skAlzrL14+kjzWUeQyym2nu
	 NnEOmK7hdw0rqQXapycCb+YVvO2gogB3arrshR81oAm9hJd8oz74R2FmC5hGtKPZsUKjb
	 eAxDxig4093n2HpLOdct43Z+ZwzfwXv8WBKe9meR1cXH44aJMAEf3vIvc7kEZJbG6hNHH
	 c4vG5Znp4gimqzLw+ebCDSGNrLIaPMVqtX9nLTgX1lA3hiFk4OTQc7e6xYlEy/RDB2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778178;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=kCwPN813vlQu874heRYUodlZq6ApsrgHIHbThL7ah38=;
	b=QqUqLMvMslZBNHWihQYmljU3kHb3HCMyJ3Bijo9A6j4DXidqpYrIiu+p6a9tQ+ARMXvD
	 v63tGZbYOhbsfdbVW3lLKVrTlzmIMR/kppJnMTw5KjwrokyUy/dx6GUzZC2G37YvXh6IY
	 9vpZllvOaWjBZwRLp9fiVmyy/UwUHDul6X5BPj5r1Xrej1F549c1psvN8lfKrJSPMb96U
	 0i+Ya7eOkl5a8/o0+3YfT34L5M9+tU0MikB+lyt4EqvBoymStcamjf4qxMOKTg1pDnSQR
	 H8N2lrHeCfZtEc8dQic7o5XG0YnffEbTQ5zmVRQeFp0yPelW315LF2DDUF0458DWgsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hTU3duCE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kEebDv8V;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119B60A2629
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2119B60A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hTU3duCE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kEebDv8V
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 51280EC0123
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:56:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 23 Oct 2026 13:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792778177; x=1792864577; bh=kCwPN813vl
	Qu874heRYUodlZq6ApsrgHIHbThL7ah38=; b=hTU3duCE2r2Kf2pbi2NEwPbUi9
	Zayd4fXwpli3f8M7PZOIgQfn4B0JbTTYR1nZwrnUbFa+Q8e6WdLbN5J+LXMkr+KX
	iVhEZ4rc/o/8/kJoPhEq/srold/kmJwB0EN8i77NmSQ1FDCdaOEL3DPYbmDu0ZWy
	/+CnLW6ku0+j731Ex0ZocfGft3SyLuXFRt+zF/ba717oPROb3eIFmni5HgryeEg8
	CQW3nZQxdmtUyBh1a60r/lXAFGSaFFhrbaH3lj/XoEMxSyOF3Uk8G82YglS/Edpb
	I5WjqUumS47g0QC7NNkwmiilx4fFLw946lr29srnrjC4KLFxhBjmKpo2Eh3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792778177; x=1792864577; bh=kCwPN813vlQu874heRYUodlZq6ApsrgHIHb
	ThL7ah38=; b=kEebDv8V6YkPGEeXVDCT7SZNN+ESuvlnhuU5NLmPdA/RjhKe4iM
	KdM55BchE/Nq8/yrANEUE9eqs4LRXA2BvApL08hvGoPU3eNon05FIfqoVYe3mg4W
	1hdllDoqt0QJPhiU8Md2CMEMrixgpPCNiWSIm79WvuDFDxETqFaX1gs9jRp4UHqZ
	g7AzKdC0IltL3N6m0VMXNPihhKVwWuuotvn75x1vRY1GP1P+p1nrNtz8hMLJMLz1
	wW28cAB46Up4S9wwZbO/aslPoW9QLrXD8A/a6Gy6Y9NH392Sq3LoqJ/NnokxC/8Z
	mCjeadLI4jUadTV617F9pYHr1ieGqmqC0pQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792778177; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:o8QFfIkr6Wgq8+D4vRf2j5yQFcytjy0MiqPMxBOb+hd8KY6
	cStdupWQ7MQ8+Pi6GAZcj8KgfXTH9cExxnf22yN22GPkPj2zD1NbqFgIS9M/+jNR
	2U69AwfCSUqY4/Nd+kc80spCyT7eTTvTEYCN4i3cKJ5kiZFDryhO8zgd5N5r4qYP
	2bkKaTeGiSEVzKEC7JqwN0enIw1JV9Ws1KTGeGE5TSz3mZWot9VgfK0ts749DBkZ
	dCo6TPBf/Y5xEa7i8kLYwnMYEdm7psvMAt2t5jv2+ytTnpdWdtDHWgE2H/2SsC54
	D3XWaQQ1UOYnJtebADHil4TDQ0nVpN5l34qyiwQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:aU/qjRiTIo8uX/Jc50pT+n3e/86s43FMIiQpTLy/ExY=:qsagA/WJf6Pj7WrFyfmZJRrfzs1GSDQEv6fU0no6QFE=;
X-ME-Sender: <xms:wZ_bagPP1q1NMGoLwhkLHJSnHwenyJXvGd_klBF1Ii8smSk9KnV21w>
    <xme:wZ_bamDRnwHXHMPlWzb5En-POz-EDTw2_iv0Us-B6jIM1jjkvpyveTBAPFaPGGG64
    bpcy2CP4nAxwTqYUoIGMsji28WRjNftj4jAa9hcDKsNvtLf_96dRg>
X-ME-Received: <xmr:wZ_batcjNR__EXtjKui5LTx-0nDrMSy3wn-8y32-SYgUP-XUg0lEULaMA21_jZt1Xvp_lU-5FpePK5CVNo9nEqACaTZAZY38dMqa>
X-ME-Proxy-Cause: dmFkZTESsO9eR+LHGJlmQGQZGmLVcWUANYAXeGonqPafaP++weUglmsy0aplQsJPWOvym/
    GgHXpx3jdKurg7RcqyfCCqyTLK6N//i4qgREEgx4N8Su0P32uf9HiJEa6QjRngTsgOOF/E
    3l+x1GTrit5V/SxW7aA6r1cdO1Vtc//K+ptmrJZ9BHVqky26WYB1hECx2esWv7y/x6jYMf
    bGtIbK4ZUrHw+qoLGypc4uaz1n+Q9tcs9LNb7UMrhhe7zOwsOPyJLzpC6N8MJ+dvVcwMFj
    U9iz/EEuntBN1pwVSGDYlY17WHkBbU1ae5TF+CW/ygQ/xXXM3L27nxT377ly+QXzNa2IWE
    neDIGmr1sy0R5ICIsAeWST3Yw85VQcpfnHS+MkUU6+2FFcr2vY7h4cdvpFHUBbdS4SaWUo
    1tSX6tNkHgp8m2KlIg4oGsqdOQK4ce5PlUD8RLcczkXVHifEdFivgcyn5cB1pf072yWijp
    4A8OF0JhWcgJy5j1pYkzVDCgfvP8IamF15CSnVGxGuIB+oXv74J48aerAOHkp2WxN2xx7v
    CiQb1zk/I12JKYdZGTPsWkwBUCsH9zy4ZgXWVGbTa3UbEVrgBFl9tqB85YnkRtp5r3sWL1
    dqZ9d3WT6sGgSLC1zLGamEgF9HoAeV1pWJbydRnbga1UysAjSVCIjRAZnrTg
X-ME-Proxy: <xmx:wZ_balOK8PjLUtDaMNUg45qlGdASAzLHaajBflGl1lYW9kKh-zFQYA>
    <xmx:wZ_batIFdMG0KOjp10MAwjooq1pzV3aokpk3VUaamHrR1X6y5XVjHQ>
    <xmx:wZ_balIk8fW17WfIysegeOBt29r7EvgCi2r5Fmxsv5e0etnVGLf6_Q>
    <xmx:wZ_ban5zqXjrHgo1kIH-27hmrDh3AiEQwovODEx2cp-wY6mpDnlQbw>
    <xmx:wZ_bantjJx8C9UaGPLObOwreFDb03_wbAk-P5lNkKU8nFGEmUpcJ4Eps>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 13:56:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Priestess <herroyalpriestess@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  siddharthasthana31@gmail.com,  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] t2104: avoid suppressing git's exit code
In-Reply-To: <CAOcE0wLUZP+HG_X+C72U4vT4eYp=F9XK79aBdAiArYODxcYeAA@mail.gmail.com>
	(Priestess's message of "Thu, 22 Oct 2026 02:22:43 +0100")
References: <20261021033723.5265-1-herroyalpriestess@gmail.com>
	<athxA6S50czDEUYj@pks.im>
	<CAOcE0wLUZP+HG_X+C72U4vT4eYp=F9XK79aBdAiArYODxcYeAA@mail.gmail.com>
Date: Fri, 23 Oct 2026 10:56:15 -0700
Message-ID: <xmqq8q3o7134.fsf@gitster.g>
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

Priestess <herroyalpriestess@gmail.com> writes:

>> Makes sense, and the patch looks obviously good to me, too. Thanks!
>
> Thanks for the review, Patrick.

Thanks, both.  Queued.
