Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914084;
	b=a63y2yVvmODvvAyhmw2ShLCKO+ptLjJjrfsdW5uptztR9gK/CSTj50jqp/7rxfTMaqmr
	 TGP+PutNRhZXjCTuL/ePlLcDmcM51SXEcSPZxRMzW5UilLeAESuTwT8l3eRnKapgkHSih
	 OdSgXzrpYDP41hU7ah7/5d1qvgn35Q8UHrhMZ3zjJO6NqwWOtEqzWmfwb0UfQHmsjwOkT
	 TFs9KfV6DhGoUg6mTvi6yOzGVIrs+5Rlt4slcbTURsMhrpKxqb1sWTDFT0XpUbYNWjb/C
	 ttwW5b7+Qn5GRvyv9ZGgvAA81y+mLseuod3EAJh73VAscjjezsMcTFegRm+pv7G3f9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914084;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Xcg0+ulh/8lNkxUGeXcWLvcIm+X+xNTA+1F7dZgNWmw=;
	b=rE7+hmhqLofkE88KoBfwVxc1T6fRtZ1vCAnJCf2tH6Vj8rmN4iC2ud8/JPHIZP+fMRPO
	 UK0hIqCZwF6dLGJYziP3zJYO/0nmfsZF+UlUK2vmDvccap2TB9DNWyx6YO5FR2kVbzvNT
	 UMI1Lv93+aIerqjbueotvfy3c5PtO8NBEoGoD86dxLxl1M1/2AVq142UUph806W4KC1D8
	 f7kF0MlgWZauCTMtbAs+JGf4laP2RWq5Lp2Ul4tdQrVp0XKUmEFEPGsid3vLgyxKl0e8u
	 uRCpnmzvVa+hd8syeXey7ZL/geNedXSteNP2xw0I6YpOjb9HAWh+nyQuFuOtoD49o9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=S2Xv+k6s;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=i4N9SGwT;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1363606A329
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 21:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1363606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=S2Xv+k6s;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=i4N9SGwT
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D5EBDEC0170
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 16:28:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 05 Nov 2026 16:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793914082; x=1794000482; bh=Xcg0+ulh/8
	lNkxUGeXcWLvcIm+X+xNTA+1F7dZgNWmw=; b=S2Xv+k6sgVDB5Qsi1pgJuQERYK
	PnBM/Rwj9hSazCAOFCXv9R5K/V4hzWoMNfCpFzk4Rxv5Iq5bIjY+1FfLQcWlSt3h
	64qaEHNfpG7OT8c7KQ+SFxKqskcYnIyqhZ1Z/KjKuHo8M321zuX9z34j2ikxD+aw
	FdAwQrGN31Z7DTYVMdECSKta9Lg9Ux460u/DHJxusHvYicUNnB1vMRO3Je/Q9of9
	Uy//kheF3SwSjfGFrSs6f0hMhLqLP1iznqwfh09Bt/9wBhlphd1pc5z41WrRQRq5
	bBQKBFWyy3eC7wP9XUBxpjd8pZWSqkYnflDEVtAgMM2nLFSPykdrw0ZZvKtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793914082; x=1794000482; bh=Xcg0+ulh/8lNkxUGeXcWLvcIm+X+xNTA+1F
	7dZgNWmw=; b=i4N9SGwTiFQLmWYugXSA9DD1mQBqCO4bPYPwD1aHy0f2Tx06WN+
	AQ49Lg645xafj8Azpm5AsX9kq4MO99/OQSlYupJAj6/g/+3Q9p32sbGmCwz9NYOM
	uC7J+s53rWRvyRsAtiNGakk+bVolNinVkcTvWvB0UGxSex4KzUtAjp8+NN8l0HpX
	Nu9Vamfrek98RpoiIXau0/1CptWofiHH8JD8phNrpXDfPpyVh2Dhbj+gsGpz5KrP
	d9EOZjdAYLMuurvkmFNqta6q/p3+d97lrhU7u500duKy+nmWHC1nCTCNhUetl9LW
	DLEHMGIPGolYIe4sAVYkzxFSvuK9ihHshxw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793914082; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DY15SdXAtRPQ5hK/4175qVMJ91LT8LlwrcP7gjOyS7tGbrU
	lnWe7AgctoZ90IMR66+UEz/Hiy2tlApaxf2KaJzM46KtUvf63RBM8nKG1/RxPQk5
	3L+L+XV17t5VIRmPdD9pUdKE/QVLDMR0ku7niDZune8CfGEY2JKxNx0GpGjCYhQN
	s4Y9JDNubcyif71wegkbUOF4vLThOduyhwiuyvqpwj5gv26VatRd+KuS/KFCfXUm
	BoRk3tYqMRVlef3tvOtO4o1x/w78ZImYYqZjbxV/MIJx/sc1LrBZRoz947sOTl/t
	rKnMCXPTHbBsERhAO816VeItLLuPNgo15WoGlRg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:XEh089EmjhqXB1W9ReAkvX4jmGuyRzNOUrxoost9gX8=:/1Gjil/2hYFYueh7OzNUmmRa2ewtzM+1wgCNtf1aDIs=;
X-ME-Sender: <xms:4vTsasuoPg2vRvXFD9WTe01wmAkAQB1MZRYseLNeEHt8-_tvwHvg1A>
    <xme:4vTsaog74SIPHbH_vbXPga2E60YUiDN96qZyQ4rZec5g4bswtoIN4QBEZu1tv2hFV
    6aTeG6hbbYtY_4PgzLa6Gdms2SlDBxdZfHXipwbBUtyk4TC6glXZskB>
X-ME-Received: <xmr:4vTsat9GT5ogcWadzr0XWppiAN71vR0m3wXAXjNGnmrjV2jP78BPb-LEdVBuhr98dlGo-q2KZjbAEvIa1qRebpyZ2O8P6_FWH-6x>
X-ME-Proxy-Cause: dmFkZTF34nSXasPek8EOHFIZtROvh15KJrFAIzmOc0JEa64uD5tc/4anf+qhAtVRYCcBjw
    IV+Ktio7sGStJitJCwMd7wuR2VLnBT0JT42lC2yL+gdBPnhENtGSiIrnarXbMDsffiwomf
    SetWNkjL/Bg9JWlB3vsJpIXk1cQnbB56cfBCFCdiLGtiiMvgPGNYbJ7psINHqjjXQo9dGw
    iXQIAFbfI30X/dXpqMqDezewLk/zQd3r8Vi/MeRgVV1mfIQwGuwIs9NpHDRNz/rSkSoPM3
    Xdz4b/AYNKmRkvyoDN9RDSmji/NFtYvht2Bjb1/ifSsAemLCKCt/2BeA1VFE1K/SDs2UDh
    37Kylfr/TyNmOMlZ0Gj7JBqBfIeHsWyxQpDFAIE8b9JRsoYTXk5D/luazxDGYdUAOmXmt/
    p2H57t9rKWJ7PF8LXbj2YxcL4i5+pGe8lO94q44RgyDvV2XszqDvcUJCZnhD/NcNVfZxFD
    azULUsTgq9WvJq9mpxrmckJX6vUUwxCGVMxkcxRwJLERmqSsKlPO46q5/SDxlWQ4FV/rf2
    TAYXF6D0Og7lJDZYrIJmQ9A9gxPqCcXNNcbtBJBZlGwUPu4DLEpxwRmniqhXPv9pavU1OX
    CEFMfDy2nIB1uwHpZYLonJN7SesswyhikC21XAsy4UMAc60xMomfwdxJQjtQ
X-ME-Proxy: <xmx:4vTsaruk6hkNGCT4pFDtcoc3KXnhkG8PCv8LJUMiO0tE8KKjimOwqg>
    <xmx:4vTsahq0igfXqVZaL8jiQ5gqw6-N92hflqF74sBFGWDqan5f_DMkLQ>
    <xmx:4vTsavoIjkhcEC4566yrNwfsk5OqrIq2wL76k762Ccy1cxUEJ5lZ3g>
    <xmx:4vTsaga_xRVk3FDPqv2-GXQxFCqYZf31Mbi7JLHulhz4-8WdPMLO2w>
    <xmx:4vTsagNpug1BqTUhbUmLBh8NrbBkol5uBKmznkLeZKL87K31gv33t6Ff>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 16:28:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  Shashank S via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Christian
 Couder <christian.couder@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Shashank S <shashu8660@gmail.com>
Subject: Re: [PATCH] t0081: modernize the code testing whether a file exists
In-Reply-To: <2a050885-a1c2-48d6-b561-3c2ea0a05dbf@gmail.com> (Kaartic
	Sivaraam's message of "Fri, 23 Oct 2026 12:26:51 +0530")
References: <pull.2254.git.1791962806807.gitgitgadget@gmail.com>
	<CAPSxiM9-F-1XKvWeEnBk=_FyKyev5pfnid4fiN-OjLYLnCTWVw@mail.gmail.com>
	<xmqqzewgosyw.fsf@gitster.g>
	<9c905a79-22a2-4db2-b434-00ad8a287300@gmail.com>
	<xmqqzeweopov.fsf@gitster.g>
	<2a050885-a1c2-48d6-b561-3c2ea0a05dbf@gmail.com>
Date: Thu, 05 Nov 2026 13:28:00 -0800
Message-ID: <xmqqecczrmsf.fsf@gitster.g>
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

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Got it. Does the following change read better?
>
> diff --git a/links/mentoring/soc/SoC-2026-Microprojects.md 
> b/links/mentoring/soc/SoC-2026-Microprojects.md
> index 41354b50..17519e2d 100644
> --- a/links/mentoring/soc/SoC-2026-Microprojects.md
> +++ b/links/mentoring/soc/SoC-2026-Microprojects.md
> @@ -49,8 +49,9 @@ with Git's dedicated test helpers like 
> `test_path_is_file`.
>   - Start small: Pick a test file with just a few instances to convert
>   - Run the test suite after your changes to ensure nothing breaks
>   - Follow Git's commit message style
> -- You _do not need to_ include the command you used to find the instances
> -  in your commit message
> +- You can include the command you used to find the instances in your
> +  cover letter or between the three-dash line and the diffstat, whichever
> +  is appropriate. Do not mention it in your commit message

Yes, this reads much better.  It clearly guides contributors to put
the command below the three-dash line or in the cover letter without
cluttering the commit message.
