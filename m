Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792860184;
	b=WrUkw/65s8178WQjYOjk6Sq10UVRVVf0Yn5n8ZEHkPpQJT397yIAHf65Pl8Q0VSpJkl0
	 h6oSbrbFDNaoiyyRVTMY9Mcvbhpb2CTPI4QMNVehZ4x7s7mm6Yburmq4AgrV/EKljLPwp
	 M0kd3STjCp60IATWEjGb/uQrGVryyNbnA1RzB9HdLYySf71/vNZNEOBGLtApOpJ6jRHNo
	 FPAB5kn2lvQK0QKUV18/EM6+wqweOu+J4oeXmsK16CE00vGyP0KmUM0rF9zFaTYQflklY
	 eWS+9C4jcjGXIA4difTyd/hlFBSIVz5eitRrZ71wZOqwZTDdnkVo+s2eoxGZ9+R+hjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792860184;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=WZJi7TJ5kBTzjPBFB3OkWmjYBjn/9pferK6b5NbqMvs=;
	b=TvwZpEuzvo4fVpcSI6z/a9ciKP5689DzLq6BMo01pXLYrkq352LjnOfNnWr0W+3H0/74
	 vXEyOivrS9GrTrf0F9p1rALL+bxluQEIJNaonwSg0wW73lvsdF2BHLp+RvpCQZV8gAQ5b
	 pr73Exu/jGK9RNB5fLRJrqkgbkfFZyEX5w6joRITTu9Xz2gWLuqK5S3DVjkc7lOaiukyf
	 8VoiX88s1B9G5jLyrlGFenvXtrvRpEgTanJT0Tsuusmr2843Nlg06GH1RcUUYVa2A+hhH
	 z70PtV0X1MCNGK94OjPma95T4Q6LOui6GNLpEvNgx+RS/PdsxyiZTv2niTnBtzj1aSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Xct45vYJ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Fm6wbFwu;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ABC606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 16:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9ABC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Xct45vYJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Fm6wbFwu
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 480397A00EC
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 12:43:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 24 Oct 2026 12:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792860182; x=1792946582; bh=WZJi7TJ5kB
	TzjPBFB3OkWmjYBjn/9pferK6b5NbqMvs=; b=Xct45vYJTYw1RLfzbirwY6g0EP
	8mBFys6HatTgJtn2BhTv1v8tGP8sDvg7Vi/9qWg8W80v1ZcwyH6+jkF4Gva7Rjr1
	BJz5C5IrCG0y+ewcHGsggVsVVSREXyTSIfrw76TSlH4UyECfNK14jvRPRSYG/nFb
	Nlqj6qOyXNPJcS6HfIWTq1mIoJqt7eFQwl2OHc/Bnu9vEh7pJlXAy1PsBnmDQAYr
	acJVUrTSiZUrD29IpE0qkRDHgH7o/kS0MsC8qK9YGKbZXxHReic5uyrTsnPv0syh
	6SQXsCb1wrmlFeiYSzfpvoMcMJPWlsRlORLJJGm1tiA1nLeBGzFjeY+tO9Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792860182; x=1792946582; bh=WZJi7TJ5kBTzjPBFB3OkWmjYBjn/9pferK6
	b5NbqMvs=; b=Fm6wbFwuFudgp6Ryi74R5FLU7YJ35WVQDA/NstzljqEFosfXx9l
	cDDJFgJZeXK/AbyvCMWi3k6n1kfkcj4IOUQSIyR9PD4Aq6P7eE57+xkn1W2ncpcJ
	5dpr++G4C2KJBfQ1D7bUSc7brmkYSrdno3Wul/9rrP6F1xwetjfIcFEGbZ+2GFVd
	4Rv562poy54jsruD4CFjum1RysuizFgsjMxRFHYcgcECkp7cFaN8uzIMcA15rkuE
	1GxEySjIdZMVaZyhpUKi1/RcOD8cPP1BHjQ51VpC8ojwUs/lq5BWhYUjonqESUFa
	U3WRSThTx7mZUvijp5izoe3pFAHGkCoavUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792860182; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:et/2SZCEcxmAtO/DI9ZPiqnkvoWo90ttwZ7NwtKdAA2s4jI
	5YJZRihqtB7/kacPqergzhnLOL/fF5GeiHdI2p7nE+TPTC4R1tRxJIuMmAoglg1+
	D4uMMHXtNXZ+GZReol3V3LitELERQEhZqlaakXCXhcoWQUrRuXGaW61uyjK8EQoD
	N9kWBSXoELsyU3IqnmSXqyPlP17COHdWjZnehgaymcKTYSwO/byLPvFjstuiMtsg
	WpI2PhwGPpbE7y878/tHpRZpPspdRljUdL5KqZobYiD85XwR+Kb5mRW8loO0v6U2
	AbqGz5oyadzzNa3k6Umv9QcUMjpVjEdH+QjokTQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:2HaZ5OBRrhnUkUrnZrWBeNcFkBhzrSTjDycO427Qbmw=:BqiMlidl9bMT70Y0FnxU669OFwWji1ti1Rttuf4+UfA=;
X-ME-Sender: <xms:FuDcaqWzECGxMJimI0K9B8YrN3-SbTWgkCdBHefZREe6BrusNkI1bA>
    <xme:FuDcalq2B1Z07hmSXlvkf1V0DiJojOOH_nxJP-3ijG97OZBClg9iFZivLpGY6ADkq
    98ODxiBpnzcBK8v6nfu_X2P4IDNumVgn_gSP1U1BhsPm3Fo2fEk6GRi>
X-ME-Received: <xmr:FuDcakk-oklIgwqsjtt5GF8aoKh8HO35z6Mn9ygeHLhnbrQ3Z8HqPJ-uJ2nqifv4Fat5rlecf9z72jkrpE4I8iPG-CJJICyLMpUS>
X-ME-Proxy-Cause: dmFkZTFnay/ixZP/jfzgrfp4wpO3xYxiRCWgnlU5NeJBX0n86SEvpy4XTIvKFwbP0Kcxoz
    mkxHGvtmiAam7OgH08du2DCEW9/apLq8jiq6B9Sr3hfSYUPiyOuou6juJLdaNGg+NWqhm/
    58dOIgHkV1KU/8zdjKKPbPI2b2kQ3PDmSmqksZvmA2DqnUFmfvTW5nG3nZQUlrek52G+MX
    XuQg1tykdgrvOTh9ckEksThtYV902idlCHrudJOyngZpWnkUnmJTBzuCPrURPvTw4zYuW8
    kqxcE//Q9T5s6v//6PeAuPYkMwTsIpYm6rmkHSI6U+JlzVuHXfxAfTDL2eqMTxXa+8L+ln
    jVxoyyO53xxENl5OzmOUddLJ53Z9cRsZd+LP0bIGxBo3kt99hKOyQpW2y3eMXGB4zqqWap
    REk2Ij/cMG5b0ui3stam7B9bOzbxPpuKqXsLZuS9zmn2fg8Dd+oGNo7PQM/xnN4TX8VNcE
    qRWWLo5kyriOJxE3B/HPmj2F5qG/zKMu3VpwqJx2Q/u1dlZdLeGBCpILIcQREY4it+eXUj
    u6OrlB9bIRS7inP/ANA5llvdki4Wsx2IJAeT/Gq4lAe3GudBSDiM+sypceuLWcioxWtV8F
    zjekeUKlAWt6rkliAbjAGl0UF+XiR6IVVXSkCFDbE7DAEBrFBvoAfTT9uvUw
X-ME-Proxy: <xmx:FuDcat04P0yiwfdLZT-QyCPRy71iHMWW9SNgxLyFiZVvdYzNOkwr-Q>
    <xmx:FuDcapRS_H0hvoGKLH6BSnp8hSTUtC-LYmG_CERGeYbfX2ibSnbaVA>
    <xmx:FuDcauweyK_HxXqZd-U-UVhIrR0RP0wZeriPgrVpnEmaTsodxGeOFw>
    <xmx:FuDcahCDUFDsg-cK4geXB3iNu0BTNCTjVNjHse6Hvv1wM5KhvQ9EDg>
    <xmx:FuDcao3dlLllxdGfWMgogawL8T4VelrSzR7ah27tLJkzyaDcVTxIigz6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Oct 2026 12:43:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] status: compare against both upstream and push
 branch by default
In-Reply-To: <CALnO6CBD2aGg_wDZZsT-mWJ99MXYUycx32JfsK8zJXfcmjTBDw@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 24 Oct 2026 09:49:26 -0400")
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
	<pull.2458.v2.git.git.1792585662669.gitgitgadget@gmail.com>
	<xmqqld7o71ot.fsf@gitster.g>
	<CALnO6CBD2aGg_wDZZsT-mWJ99MXYUycx32JfsK8zJXfcmjTBDw@mail.gmail.com>
Date: Sat, 24 Oct 2026 09:43:00 -0700
Message-ID: <xmqq1p9f123v.fsf@gitster.g>
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

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> control, so you may want to monitor its progress closely.  But isn't
>> your @{push} destination typically owned solely by you?  In other
>> words, aren't you the only one who pushes to it?  If so, whatever
>> you did locally would be the only change that could go on top of
>> @{push}, and unlike @{upstream} you would not see any unexpected
>> work over there appearing without your control.
>
> I think this paragraph assumes that either
>
> * I'm only pushing new commits to @{push}, or
> * I remember what the current state of @{push} is without checking.

I do strongly assume the former (I count revert in "new commits" in
this context, by the way), but not necessarily the latter.  But
unlike what appears in @{upstream}, I expect you would recognise
them when you see them.

