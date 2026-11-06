Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986791;
	b=wvfiJ6IZMqxaCFw2bIsIcMbcLi77bHth+nKuWqtb4jFUp9Af4qXat+ypxweBfp3QdKYs
	 +0yjddl9sWjrBeTvxat5Yw2NEyJ5E23eoQM6466Qdp7qb1azThzQ2VFYwLqVAOnru6y+S
	 azoRzMrOTxvvzCAfR5qxPM/vNazPvf8lx7McqXlAD8fqxu8kkwdmggWLfdzRUR9hriovX
	 33PQzv3xAPN2TmLXlhEaCjgrUEpKSBmklNFkXUuqRr5CwHGtfH4O6Z2HVueqsvjwQbh9J
	 Csa0mVpVmA86XFSWjU9qtAv5qNU6556Ol22hoT2izRdGp45xIuWUURnnayZD1LrlS0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986791;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=8nCWbg9Afl+8u2xXS7xg13xjE2lQDcsSwqjIajQ+bNg=;
	b=q6nXK+YJZo+MY5dGSAPAU6hZ6e9vkGmH5LX37LUALt/F3S4p+68ocBN904bnsSPkIl/Y
	 CT9W4lUDI/uskhV09nO3dUxGnBoXZnYPwgcp1+eRGB8Eedzca99irPY+q5ffY+BXbbNaM
	 TeN5IXBXmOFkHzF0t6tpYurBWRgOo2MjT6zj4ar3Wf++AD/u15sY83p0OLhilRNOia6rA
	 zMTNiudmmHOlJQpUU4+4gfq6RndrhWsxz5TRATlHKllPNXuBW/n33Lk4XUYSjte38ca14
	 Ia2qi5EnwMR2TYM2SxUcbICZSlldjVFZLGDnIudv14AuGKHbLl4d456wIOsQoY4UbzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aHfEgcAD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gDNHNdVg;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C772606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 17:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C772606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=aHfEgcAD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gDNHNdVg
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id CA6561D00105
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 12:39:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 06 Nov 2026 12:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793986789; x=1794073189; bh=8nCWbg9Afl
	+8u2xXS7xg13xjE2lQDcsSwqjIajQ+bNg=; b=aHfEgcADWwNEYBEu86+szGj5Hb
	cgzMVcc60KLEG8//XUh/fWzO92kqU7FKjISXYl6NJ2R/AiAn8dGdqEECs2VqfGsa
	JsD1ROopo80Y/CW2FEUmumpb4q2BeL0STW4I3GlcFD0GLecZmY8s1t+vZU1TlatZ
	YcgCMQJuTnO+ho6nagsdBbJCf4VSMvJJqG9CAFihwOKwqI4HDNS4gPr9xJJ/x21M
	UsPLBlRaC13HFG/Nu4Tm9nq49a2kcZrfNC4A4gpsk8J+M6SGnmmthYKFNtY3vOmt
	hR+40RrS/FK5WiTPZqKhM537gFlDPP1cPtieRUE+CfdZAoAZ2TX9Oj6msi/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793986789; x=1794073189; bh=8nCWbg9Afl+8u2xXS7xg13xjE2lQDcsSwqj
	IajQ+bNg=; b=gDNHNdVgFBXgHH9aXGo0FRVHvtPREPWCGPALveSamduwH7/Aw72
	p1NcK65yJcN41ZTcALW1OFuhcK+Z+2a0EHjc9tEAR81Wxz1cNH7HBMn7JlCosIfG
	rtry+q0FV3ANI1EJ30lp04LG891/zauBY4VC6deLTtMbhGPWLV5QOrmu+v62qsjc
	dIlNiw21gCgguxTTo1crblp6bV0yadVJJoTBHjSI5G2cn1ftCBn3bmG/5X4a6Jxj
	wWuZ+/SCfSzDsEENEmI42j25BzKilRg+qCKp1epGMgJldizocmuPLqW5t3C+dHBK
	lOYH8ZZwjkQMY106z5FoyvsOsb7LxduVhiw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793986789; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dsUfkTFVJhiv/0nyHASm9Umehaq/xIotyhDwpfG0gDgUGBg
	tCWim3OCZuBbKAlCNzM8UG9flggN3u4HSeydWkIVpskFvn2C7guhUS+SuTgxdehB
	WR+21mAapiyA8r8N2GFGuG1FcSJMZUOrc1ZZAYPZ5+gCwT4CtidoXeyvxEhyqp7W
	s+k9WAOc80Yr6ICE4jd0fTrACCKwPRiXBDdt1dkkWgb9K0EOy4R8obiWtIZZxniD
	/vuUGrurz1GVPp4s4roP8lXtM2LzRk6ZFzilGpfJBCvF/jTmV9MvBUp07RAPj5v6
	7ETCluuQLmxK6JdOuxbQyZHKlXPzdYg1sLA1LHA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:x6GYy6be7JXyzQo2I3TgM78Y0yLiNvI900YiAakMOg0=:Vv7pon7AhqPAnw+vd0PTEBnCHAcvYKudqJohJlFqCV8=;
X-ME-Sender: <xms:5RDuap6pg2jAvvc9SnViosRNN-mVsoED7IhMT9-l3Epr_bCgVTmvrA>
    <xme:5RDuat7sSY8TUEVzRTSXBza5-BwHBOqOpu_6DD_PSdE0nVFKjENcei7I02M5gUFMU
    UYe94BAOcZf94jgFtB8ArQcJgTpwvliBEEh6NyfdWDfJJGCXneGVg>
X-ME-Received: <xmr:5RDualdc27vwZ1DLPb2qZ7QHMRORbspui9HiI0AOMvqZ94AYnUSfiRc0V1tp4FRjnkSwXR4UTO44Oi_lmazVyPTLLn-K4fOkkYBs>
X-ME-Proxy-Cause: dmFkZTGOxl54iNzmo4g4uCmNRhaiFPXqd0yHPdTFQ1deAPtyweSf6tifa5Ajkf8Yg6Htx2
    duS9CAfoYeZ3Tu56rbcG88DMpnqxBl3QwhPQNHnTN9rJKt54ew1kme3fgUEcQdf/bsygqD
    Hb1Xgg5/noQEU5xCeI07S1GHIP3DXzy6fCqPmqTuLMNcYaf0yyKXEv4shy6/XKfZI0uuRj
    A4poSPKOrSyeEPOjsmw972ynR8wnnNjpSurpaNj0EpiCOZKiP16geb8tnSESbjlO5KNl49
    ARWvnwu/BZbb7iyfwwtU5BEO3dZpSkDMGsATEN3qYMiMXz1gq3Jdd+ZBW3iS2FrcXr/CtN
    +jzSGyc9dB+WNxyff1p2WhsFfB3JUWx4W14OYKuamrEIo5oFfh1T2BQrgQbSwUsgrZ8wFE
    72cDJ9UpY5kQsVnqqLXOp9nMCSFQpenLzIu6e2gqlJrS2mH4uCYtqXdWtuEBc2I0kmLXsl
    A802Fw2wHLSuc+FkahWuIXc2FJO+kIEHp5ck5nDBwe6xmQqC8NU0qDluCbCJe/i8cb2g7Z
    pS/MuaM1hc+OiXzI/G07mKiKN3krqhv9ODS5EA127U47PV3FCIV0Iu3cCH9UEcSxM0tsbr
    JSQsF70mPMCwFrN2ZFmYBHeOd+ALi21VbinBBqjOTDRpT7pI29ZBUZPMHzGA
X-ME-Proxy: <xmx:5RDuahCJsHypg0FRAG3PpCtNDKdDME-UfN5ABNQoCpPm37sL6JxtnQ>
    <xmx:5RDuao_xT5rNLqw6rpDadrZB5NtW8geSQO_L8u1xDgkCBVR9BUxOTw>
    <xmx:5RDuasKheocI62IACRE6Qp2F5BBJHZD8We-HARsB15JymWHvuU5YWw>
    <xmx:5RDuahg_Tr8abVWuaOW6MDxUex5HlGfQ127nysTHO_0CjWlFcCw90A>
    <xmx:5RDuanbz1XOEQPB20FvvbEGcuZAnbtgD0hSKUset7cAJT5LUYoZYP5Vk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 12:39:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/7] ci: some speedups for slow tests
In-Reply-To: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
	(Patrick Steinhardt's message of "Fri, 06 Nov 2026 11:30:00 +0100")
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
Date: Fri, 06 Nov 2026 09:39:47 -0800
Message-ID: <xmqqqzgxkgf0.fsf@gitster.g>
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

> I was staring at CI way more often recently, and that got me annoyed
> real fast because it's just painstakingly slow. So I decided to have a
> look and try do something about it, the result of which is this patch
> series.

Thanks for these patches.  I didn't leave comments on later parts of
the series, but all of them were interesting read and fully made
sense to me.
