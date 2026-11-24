Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556046;
	b=uIvE9OvyLLLct/i20zOUDIUzEu/c3EWSR4qDwan7/izl0QEv5t0VgYHrenru1pVtxzxZ
	 mar+ocSadca9IdDj0V1v2LeR6eRzd1zqawfxHMwGBCfq7HL/7dEM6qhWpVIko1CmXGrq2
	 JD+Vv2PYHXQH40oKch5iOerNkt111Jbr0ynd6mTebGNXms4ywnqGfqNIOlsqpZ6EalIEV
	 H+NVTwI1dyGsNRfQn1WPdsYTFVh8cCJI5hLmMYe0mCHuLpQoAyd1kH7gKiOYMtGuf9yWn
	 Ff9PZ42onOd9e7g46gHJLuzz/NMwiwhpP2piwuoXCBQnCtINb/vNgo1Aji/bNC4qMwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556046;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=y8b2uYqH3sWMZfzK1Be31B9oILxXimYhYtMAIVzzeB0=;
	b=QLIMDBGFF7AcxvqvISmRvYN85kEh1SxExEY4dagoDTlZcKzdoh5AR57XE+r7lgFSxbHp
	 tgtit7HIYgQyZfyheWwtVTJF78dp8UEh75rPdviAV7rtPWemIhRi+NBvxW1rYXuFtRLbT
	 TSAYuGaFwuIaWn73zh1gHuDRPhFJC9Ucw6RKqogFaLadlInbMh+1Dl6dTq5FpO5ib/JBM
	 83PSC1DTG0ax04watZM0JWlAM2Z0if2+9ls92LBgF2mSH59tllU/yjZmewMsXhWlsDSoX
	 Vq9nmBgNujZ/c1boknUN2IB/cZ1LykUq/pkzKOaYV1UynkHUZ4IryG2RTM8fwZPD1AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RNZEtB7P;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DJsFhuQ4;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6376606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 21:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6376606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=RNZEtB7P;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DJsFhuQ4
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D6E33EC0A79
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 16:34:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 24 Nov 2026 16:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795556044; x=1795642444; bh=y8b2uYqH3s
	WMZfzK1Be31B9oILxXimYhYtMAIVzzeB0=; b=RNZEtB7PveNHIvIwLXJMHv1dMi
	Pl0TK7eHU1SbozoCRWfkbOan6/NwU5qfY2ikJ+GtPM2gGWkOfGwXiHeQsSH5Wtsf
	0OY5qJ3r1qzqOc94g9SzCAh404XvTKLx1H/KoS81P3pCwhkQp5RtTydXK1xrTLno
	n8kmhIxZMy2OTZONJbVtKx6zBKq7qe74TTh5THQ9T15rKLX689ENxHVwWKK3s34b
	01VsRGp0TCwFVCNsV/IhjyaEpqc1bdgzqt5etI/eRV/7OXVqdUmcG1YtUY0YQiNL
	8eA5RbrOx1AArsuNnI88pev5stBIzc87dY1xL9RQXSXwMffg+3+J9Xw4wNFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795556044; x=1795642444; bh=y8b2uYqH3sWMZfzK1Be31B9oILxXimYhYtM
	AIVzzeB0=; b=DJsFhuQ4R0aAOmaaJ6dv2AMDqQyura/Xvo8d1hSFh/orXenjru6
	X8BWGCbPXQc/fwNKWFAHaG1U0aCtwfJMO7yAmro1J484OCQ7+bwgGcNfcm412UqA
	6DzIkp7VOWAwa95cdJjFYFoDHYOqK7DinE3P2mjGjArowY/BS0xZbKMEsXEFVDuh
	Wgm6MPCpI6We3Q9640cPm6AJhQFFKaHfI0pCwuMtSwfP6vDAhCNMTyUTl6TXpBHs
	UzfJ6TmbpWqXlituISF6JkwBDfqVGtBXFbCTBb5iQ6xjZpE31cS6plkEsgRkZMeG
	vT8s9d21Du/FBQH51IF20s+uYOZ2aN7HFzQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795556044; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MI9FPn9Geeyg2lvFhQw9DcOI8sNaXZnA2WryRMCcPLPVgMs
	7P/Gyb6EpuzCnMOGhkJSXSD9k+FTM+FPNaZmxJ2lRVqtap+nATbDJEYyYoZ70Rvq
	1K5GPveQlHeXaaYU3iH3lN76nOnvtNWk4n1gyz3cmjoG7brgEayHv8lZp9iM9M+N
	8FH7dlA4jNjTRreB+NlD+qHPE6WJBu2bJ/V5wYiH+XJwBHrqjcvvObgfN/e9Hje8
	X62i0UhSYECLixjIuUU+uf+MVxkpSHtXFKk9ReNERMEqa+GiPYfjAxPe8o+H7NvQ
	5lj1JHpAtLzxjhVJe1Eno+aMEslmRslwaQXEaog==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:rs/ooRa9eZNW0PB7UKKdh4tSOQkrFyCWc22CDvIK63A=:5dRKK9vDGbhEy2SVFZkH2KjkD2a1HpIXxOgrCV9lW5I=;
X-ME-Sender: <xms:zAIGa04gN6GvYTpjtbD1YfzqN7yFjS2x-o-Op_E7wrDTJrlNiLHudQ>
    <xme:zAIGa9XMOEk9zVotgF-oHM1SIrt9WRjJRKyR0eS92KoLnqBGz8VTNQuE9DdLFm00f
    MRhL2BY0olGDNH07pFhAXALyMaE2z_SwQoCwfnHbIK3TddIXRfs2-8>
X-ME-Received: <xmr:zAIGaw2dEPTswJzz1UyNZeDBZjMLA4mRXMTN7B9AYsGbTVPGKLFmnTMrg3mwJCvIrP-OdjxqL0ADYgJ9oXfSQ6OuCFwbxw7jkeijqwc>
X-ME-Proxy-Cause: dmFkZTGoP+pmhvvtbua+zbVWu2beVZac9aU3ZSoHKa0GCr5maScS370gJfa+Rc0oUCwBto
    m0YIvUv9iKxdNZs5RFTl9AGdRABTsvc6zEvwzm7NvoOQDki45p43FQbRtSQhKdyQn5gt92
    qFGHlo7LLEYRYtOVkPCJH2+3p53yxR+MgmIdlc6OKUQPcL4ayu5lxrza7C6oaOXoM1++7n
    lufzKmiAy/LQvE+FdKMmDBNCBg8ZIGJ/FfRSvi1vxAdSR/uTPbg0r5kQMJKUUhVKU8cYye
    GoD+5DHdd2StG7z0BMbhh/9kPez71Mc/7zpfkH+eTxziFQMMoXUQ/pbq1SyQFY8h4T73sf
    /fIOhmFBK5MiSJa5ojHoU0SIftGoe+eTHrP5QgzKe7DSnJkCTlwt5/IwGYtCdCiuLisnKF
    XyS5OAaZ6QPgk6LP5+VRNdVy/vI3PP2KHZhM7JQEaK/X39MzI/4E4Wu4+bjrF6glXLotNG
    3PaPEMuiwEiKtWHbJFpZxwu27j7pOp4B9xhyl+cfl4SUBqfbP6WoWHwWS8JZN7+830DApj
    H3y4R3LnceDkRXpWgx/bVFOrJzYHZuDFKXnCXQTX4mlGg8Cnr1rD5Kd1AReNdOSV7zkoNs
    cC5GO3nZzrDUBarlczisolKyVeKDWlzCCdEXnuZSWKNrtyD8ikjdkPL7RPdg
X-ME-Proxy: <xmx:zAIGay0Q8846tn4uv_mMpr4ui3srS9NjtOmVBMg85iLcofEp2Mtr3Q>
    <xmx:zAIGa7_M49deQGXzHFTQ-5_pK91VNMQZNyhJbpSaD_m5RG_Rmk-cYQ>
    <xmx:zAIGa31IlwIeO144ae9ljD5Cwiz4Jq2BhUPLAwbp1ium-nuJn0VUUw>
    <xmx:zAIGaw81maxbMPqOa_abhq63FTdGQu0ptMn9-gJVHltiXsitOxPVVQ>
    <xmx:zAIGa1dJDK2H2sVIQ9TKWc0Tz9HYvOzX7WcWdVZ1urmNSpT1QAZV3__7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 16:34:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] packfile: introduce function to free a packfile
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-4-19beb83b145f@pks.im>
	(Patrick Steinhardt's message of "Fri, 20 Nov 2026 13:02:31 +0100")
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
	<20261120-pks-packfile-global-statistics-v1-4-19beb83b145f@pks.im>
Date: Tue, 24 Nov 2026 13:34:03 -0800
Message-ID: <xmqqecc9ncc4.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> We have a bunch of callsites that want to free a packfile, which
> requires them to first close it followed by a call to free(3p). This
> feels rather leaky as an abstraction.
>
> Introduce `packfile_free()` to handle this properly. This function will
> also be extended in a subsequent patch to maintain a list of all packs.

OK.

> +void packfile_free(struct packed_git *p)
> +{
> +	packfile_close(p);
> +	free(p);
> +}

It seems that we have three kinds of free()-like functions in our
system.

 - Ones that make it the responsibility of the caller not to pass NULL
   (this one falls into this category).

 - Ones that allows the caller to pass NULL.

 - Ones that not just frees, but clears the pointer the caller has to
   prevent future headaches coming from use-after-free (the caller must
   pass a pointer to the pointer pointing at the resource being freed).

It seems all the callsites never passes NULL to this function, so this
is fine as-is, but I wonder if we want to move it to the second category
by guarding against NULL, making it behave similar to free(NULL)?
