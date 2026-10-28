Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205379;
	b=pTYOGw0tZ/bNW9e5g28rpnInOP+qlu8oMmSetMxrA91DvRQOeLDi2YqX3W06KW/666Qb
	 yYHLQ5XK5i6qRYoXP7F3Y2PDLrbjBXy5ZZ5sbx1YB7Z3IXPVE95kbWW5I+6kS3oS7hLe8
	 O0RhVW/lTzYAbxyjX7H4miTQDfvzihOwf3XZ94sPMSo3maiGyt/ffwDgEYrGM64MDgXjI
	 iuzt1/rPud28DLaI8ge+Mt92gCCcJLkaxaObCETDlpVpzx+Xkc1riko4gfnLjTtbNdTEg
	 KSfSLaS4p3JcU1keAONmSzowmu8/1lg8sLg6qR7cCLi+IOg7JyCXMC5K9mpX36UkiKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205379;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=KJwZJgO8jGusQEOiTHeKG+SAwW3RqWnlL3MEltDSHN8=;
	b=RD7n11y2ogIC+ArtPNmV70qMabhfXGKkhDr+cHxO0AfHBbI27m/mnPXIZIAsMbj0iEs9
	 /Z1LIJmn6INIGIOAVrVI34CvBHjzMHjMGDrCiBzYWfdfaMj737HKqZ1qC1AOINc9mm6fB
	 wxdUT+nZl/eoRfdB/GssFChArmmV3ii7a0Sm9P0AGWDFs1p68NbXQ1QyRHv7mbxbtSvtn
	 L2M9fTf2bY5ye6hvAYSPzfHyCkyjx0YOQXemx/ECpLSFdJYn80BLaeTBCFfBEaCtabBV6
	 hB3kCgOrQxHouY/nkmIlZJIaTo9QeRgEuJ2j/xvMxZ7gMu4F8GaCnPrFGgJmJclSFBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=f7wD2hM4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=AUeYtxiJ;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C54606A32E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 16:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2C54606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=f7wD2hM4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=AUeYtxiJ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 701567A0074
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:36:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 28 Oct 2026 12:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793205377; x=1793291777; bh=KJwZJgO8jG
	usQEOiTHeKG+SAwW3RqWnlL3MEltDSHN8=; b=f7wD2hM4j2Kx1Q3pM+fZMnfBd9
	3BpaCQz1M6kxEjMgcXYdXizS8sxtDjXou1Ep1bTKmlPzIQHs6XlWX4NKxeLhb3Mx
	59IFQHpllq0JH0Lyxauk69SGXgQSuf8eP6cbHtyy8ovscam34yoCq7aPHMVz++N9
	hgCEOYYKm6EmWsqNVZTtHxZa7veo+FIvTdx/39QRb3NpDf7wyaZfeZlIqFD0mBG1
	fE6ajMHM4t6Oj7ecwIb8s3q0v5Ca3fgN7o1lSgE+OL9vroaOjgybmjgVeHBlODw7
	SARpYEYXWPB6qTF54P/uCfFnYHM+DDVc9ATvKDuFTHWQ8P6M3T9rfEGowm3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793205377; x=1793291777; bh=KJwZJgO8jGusQEOiTHeKG+SAwW3RqWnlL3M
	EltDSHN8=; b=AUeYtxiJxfnaNfMdYnmly4El/Ywp6qGmy7C36F35/Jyb9zPDAkz
	oh51E5FZ57JOF4wQxx1DoxC3sGOwH9m7VyLoy2E91BCIpAaM4xx6+PwECNN3vLAy
	UqfyJ1+ULteuz9/qtYoPxQMAvw6WLyB6Mqf1jiw2GeGATSraYdnpO5hM4YGQnfLC
	nTYuYcxDDhePh3VbtAt4pyBi2IhTYe3B3hK4wG7EddSVXZn8OdH4HVO+dKl9PWr9
	mF6uKAwVrEZv6oMrwA/OD4voJXQyqst6BsSbqrz61bgWRKE4NtbNhI+fGwOWcrPl
	E/Kr9MWv+MeCHh4k/EOYU5HcQAtYlra7G4w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793205377; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:E6m6rCMmPGnhbORaKuI6TPruN0vD2b572Yr1iLlDfxOV/OL
	H8lRqqYnDblkBiaEBQv+ST8VY0kKohyd5TsfcxtoSxzVF53YOb5xLiAJMIEvIJTI
	fSCeiqxkDu3W3CsJ7YVb1d/jsU+474yppKMIKjg4FpSeS7uXNBEFVTL2C6UFgl1S
	FX8jqaI6KCkxNwCjeiR25fbpjB2EZy4gSd2PgNmV2oSjFF/HOgOVSnmEuaOZE8lM
	4bfj5LWX5wOhmKcdYmvX/VuJajI2pgAuX8yodGLHIbikxyHg5rI3FXhQbI5RWtvJ
	FcEuW4FrjMKHugqSa1lvsOQrC/8iUOiD5xD8iJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:kGjTOUSVF8/v37kvrJ/Qw6EGDFaAutsRx6eZPXoKfpo=:AtwFAJMfCxShNwHEeKHMSb3bLARMLC34afgLS8obuDo=;
X-ME-Sender: <xms:gSTiak2PlL5YzEM6BS1cf-AnH2qsKuH889_yk6keMkHH1ohbkWZNDg>
    <xme:gSTiauIsZQ1TV0Yicde219ublCm0Aaz7W1yFPIyi6-use2Lmo0S3-MBDAjC9w3Gtz
    z5-_5va7pWJgCQFs-ordpTb4XE9eP219S0Ld8XvOj6XBY4nLQa_7mQ3>
X-ME-Received: <xmr:gSTiajHmS4qs01gu18Afs9KEOPLoQN6sEUnr_sPpO5K-RvpR229Mu2E_saWJkrE6adsVzZJEms5sf6WtIvdMP5kpWvoFIxKhMA9c>
X-ME-Proxy-Cause: dmFkZTGW4LP4V85T/hoVbqyFf2UqY6gUgzf5HJc7HI9X5wxAVJ7skaxJHN4B2JaDBrg0rb
    tPj3OIjkR/F32dMuoZdPhykwF6DvGL29eLhqWqdwMaVpKYJwWNqjKRkaDkmKvbRF9g9AD3
    sm4HcLXXG6GLlulm/Bm6qydnCEOFXRRYqYFoFBrFx5QLQPH8MCTm7FqsS4ymAAl32pgpZX
    XvN/j7IBRLoWyw9b1YBps1HJ7D/ZKbEdnKG+bBP8f94p3KUTLJ3QrAQ/9S7qFSeSFYBIBp
    wzwZ+C3EDfgtojsWTHHR3QptI3LayPrgSZnWFqhL3Opom938bh9gUzy/celESQOizkGCEQ
    g/nAe7vXqTUaIH6eEB7319kJBCbsK7atQ6CUSuqET1TR2f+nVGZd+Gm+Sg4OvlxFNAMUYg
    w7vhNcjv03+qjUfOzJ3tiSwPWO9gPTAVe6lGTcPZ9+Jb9C72f3RIh/TqCE8ySTYftBxh4s
    9G+7eIVVeQwrhUl/qgdgJETX96TUDiLKp2MDkbZ5w/mTvmNDUs+MPnUK2inAhzA2eqIhYC
    IXTaV+hkl/6Q9SBh1DwTQm5UDrFsa4hGPAhLp0aSgAh9VbPLMrxyicEngmahLwIdEKeGyo
    cLzwwSxbq+eDeyjK7yPUQXhgL3453aCHGmRs6cVXcSdshRYcYna7f+GtmcIQ
X-ME-Proxy: <xmx:gSTiaqUmNjvZ14SrFJFQtH0xQdAtSGgsXCONAD3NaGz6DRGtBz4zhQ>
    <xmx:gSTiarxAIbteBI4Q0SXw5oFaDTKtAS5pH3halTxpA0jxYn7WEZaUjQ>
    <xmx:gSTiavR1WSPrQ2H_j-k4Am-NSmcr_hbJ8WjB1ww_idPOJqrf-9Z86Q>
    <xmx:gSTianjBw0S5nt2UK3M8XHz51nxvV-MdWI_FlgivaFDmO4nOOQ14iA>
    <xmx:gSTiavUtt3eBFvAiVYAYaTu-5mO_bnm4dEVrKSQR9sxBg-H2ceYfFqzi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:36:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  siddharthasthana31@gmail.com,  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] bundle-uri: use the passed repository for
 refs and tracing
In-Reply-To: <CAOLa=ZQK_ZjCj5G+rk2Cz+-hQ054uJW6Eq4NEofQLHx0jnnfWQ@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 28 Oct 2026 06:05:04 -0500")
References: <20261028093455.76247-1-okhuomonajayi54@gmail.com>
	<CAOLa=ZQK_ZjCj5G+rk2Cz+-hQ054uJW6Eq4NEofQLHx0jnnfWQ@mail.gmail.com>
Date: Wed, 28 Oct 2026 09:36:16 -0700
Message-ID: <xmqqcxstbx4v.fsf@gitster.g>
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

Karthik Nayak <karthik.188@gmail.com> writes:

> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
>> unbundle_from_file() receives r and unbundles the objects into
>> it, but reads and writes the refs in the_repository.
>> fetch_bundle_uri() also has r, but uses the_repository for its
>> trace2 region.
>>
>
> Looking at the callers of `unbundle_from_file()` I don't see there is a
> reason for divergence. i.e. both `r` and `the_repository` should point
> to the same repository. So this does make sense to me.
>
> Thanks

Thanks.  Will queue and mark it ready for 'next'.
