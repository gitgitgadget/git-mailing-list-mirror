Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504413;
	b=qoJNnWJMuTL7wVAb6e3SwTVXd/6dpTVVjQBRLjGQXw+KdssHEolkLPfzyQR8duIDDv9G
	 S+WzN8U6QteJJCK+sAthlKokmFi5Y3HsNlOVQJSsKMc7/f41Zvz+QPtX2KNpXcxlFnTKu
	 hgxk1EVRzhCcmEDYVuc7MvNhsFQpEkqAJuhPjpASnHURyPrYABQ71uTn32sDPqfKFutik
	 lRHp/84vmxUntCrcOWLt713cAROmbxAm83Exm/N0uedOyTl3dKwsDNMpQHKE206iDbFrL
	 GfE9Fabk6g5wR8IsbwZ+3hKfBRG2v3h7vpq+1h1+jdMS9xYLb+KyeVIdAyx2hWSvRDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504413;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=bFSmYv4jeiClJCgad+vOTabW19WAnCuO6r/1BImYxsc=;
	b=z9S7nJ/5e2gYGRvW8FIt0uxoVdyFno2C1zygOnxr/yu2E+m79KiBJw5NPylW6f/ka5wQ
	 Bh+jETcNxabLcZjAi34sYjDzaa98mjXv5s55LHNyxilXn117J0XtpV2/C1CDnk5lRVpFP
	 mBum5JJl9kOA6IELtJWwDZKEjU7NI5qEkN80cRD+dUd2/+AgbjzM8Jp8iQmlLg8pEou5G
	 /845/8cSNGgWpX3spOZA8CMwx0Bh60ZXr0Jea6h4ZjyF2mi8a3o11m2UO/sN88NJXsupt
	 c3v3NcCvpUjGhop9wCWTW1QKrv9kNsJZizR9se/kOdrZrORPxGdC7MisexrAzu07hBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=VoXNVvoy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BpoUISV3;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1674606A333
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1674606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=VoXNVvoy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BpoUISV3
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A8A601400071
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:53:31 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 20 Oct 2026 09:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792504409;
	 x=1792590809; bh=bFSmYv4jeiClJCgad+vOTabW19WAnCuO6r/1BImYxsc=; b=
	VoXNVvoy1AmY43cSPYMs6alpxsHTb8gvrWuQ19rE0P0cKQe/0SB74q+Pwd2/+kNX
	66UmMa2MfMKAR61VhIV6YrwlXKJqcSEThEFUgdYqt2pGUhAbP9FRzWBw39DQ3Nsc
	PkRDID/TwOVLiCehUQ9T4QWWiST1nqiCTWgUEZBTNvXxkag63G4LOd2fqn2RLOl7
	LW1xra6rQ/Peg1iw/mLKVEw73b3UvJ2gTzouwfsZocO+Qdgz5j1PN9ipR8HVgWAF
	NjRRsJ2EUrMmE4jPUmEPt3fIVOLCbA/ofTAS+NxPbsjuAFvdHIUOlKGvyerQ6C24
	dSWbptoGwNetm0ao6cwAYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792504409; x=
	1792590809; bh=bFSmYv4jeiClJCgad+vOTabW19WAnCuO6r/1BImYxsc=; b=B
	poUISV3Afqj7CP0FOUaU6ouWfzNORFH1nyerH6F3pd6HBJKCgpn5buAu7CfuMJeF
	Tr7JyXxDkJFCHhBREcIaV7sX3hZry4aZdSoeWGqfeTYRqG8eIlZaiOykUumdmG5e
	TXhgP603j7h48qyTXiASKvH9vz+DpLmFAWCbnb0yz7ewyvsCF9kmwDb4wMqpjahH
	PraxEOhfmCIg6pQoGbpOpJSpRRmOWC+K2NERcoIFvq2jfxi+cyZVuUK43hczdzgO
	AoyLTG2umGEsI+aF3gqp18c0xeZoHQRHVZsiLZh8pLXHGC7a1wXitFtEtUmu+H1X
	Ov+N1i/cTSLTOjPNH4dcw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792504409; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PepGT+wgqtIdwMU1X4AwPF+wpwP044LhBY79syOQ7xrKDJ9
	B8mPaRLBSmU2lkXq0cl+4qKLuYm4RX303g02trmQJO8E0PoBCWDm8NOwyQLRWnh9
	HVi0G8hoQTG1Z+9vcq7sJAjhC2eWw6X0U9M63XcxtmjGOliZytTusUT/n1rItzqp
	FocuitZWaxj8ngtEAD2NuWuup6r6YOOK9D3YNIH/58olwy60SVdfMpnffE/T5FDr
	2oULfwu+yvSd7XuNa87daozHTKVJyWhCElSsHycdbfnhFAP00XBPtF7o12DO+g+Z
	A5TDevgrTD6F/fYr6I4m3vZu2gTRz3Hnr1rWEaA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1ytudPVeagijYSup7tdzIIqZ2hMserIz3VdsgdZKo50=:bFSmYv4jeiClJCgad+vOTabW19WAnCuO6r/1BImYxsc=;
X-ME-Sender: <xms:V3LXarK3Ntz9umRIEIiKpDn5Jb4ECGFkVxGtq-6aUa4a4cHjRmk-WG0>
    <xme:V3LXap_2_HtRVCA4PEACKnnyVXal3oswfpIti1tJopezj4lQ8pJiK7-2yBKE_jgSs
    OdgozDfVU8jBT4KCUlf2tQpDkJQeUrxc9XPx4OJD2nfQ2i2Erm6i-Fd>
X-ME-Proxy-Cause: dmFkZTEQZ/n5IfcmHFDwmPs5SWegTyoQUZgsQalMaYrRnzDNbGUl8YSEV/MQpGZfXxj0/6
    jFuK1gr+hFsA8mCNbGV2oG2iRZudhSe+E3YrAueE6FHS7P1w/u05958Hv3pcwmDjL4V5wz
    lQlyhybcplBtp/EnOg7nBUfHhskMQ4ISF0yimE6NgvgN4RhhfE0y3Qtm34MBDNrqvzRC05
    YgGdky3NH8ZIOho1wm5E6DAhuWPuRhrPZTFBTAZ8hvXvv5aOis8Y3ml/4DBoGsZAp9Eg2a
    sBd1kGfK2WiqByEfw4jN0Bqk6NTu1JssGie8a+qROu3OLi7cmISoA2UP0J7fNOdLIDViiV
    ZNMf33HUTx3T9TP5Qgs1gadq/tK7kvpGpWhTulq16LvWVmI+gTBXZylbAb1KlED9AbiCuj
    FXgFd0QTDKz39lK68szWyK1gYMMW18kE8KGvQKzr5SG3MhVi87skk+PSDhvD+sVucbqM6Y
    L9uh65brVNdtEhVG9CtLTsMS7sZzaMhSFsctw0FUe+wYV49wEtsJR1kuj5pNb5i8KJNZbn
    ekxJnmdX2v47UpZoeeColPoz2/0Hes9lNrkrW8HbcGKhFacyAQG/MdSkeycpCgsfLosfj1
    VENtDDlRCGUJSdrsYvIAM89jnEp5PVN+6DfY7aP1KAQRDUr+LPBwDxylZ6KQ
X-ME-Proxy: <xmx:WHLXajwH2olKAA-aEu2W6OA8OJIb8n3hzFMWHPjhrZ-QEAM9Yvl_gw>
    <xmx:WHLXapEKxSA-Di6iyP0N2aZvImpxEqs3SNmnMIWRM0rbjGeSgImNGA>
    <xmx:WHLXanz7UCTPRG2CKxlS_43l-bWDddKK8sg17EjN63ztFVSiC9aXRQ>
    <xmx:WHLXaqvJUuWWvInAXr03z_8CIVtYHuqZmSSWekhXst94fRyXB7rRIQ>
    <xmx:WXLXal1xE6L4UI42VPizH5WzqKOtEDKyqd2rbOYwJ6Q7s6sGUJrN1_L_>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 722CF22C00A0; Tue, 20 Oct 2026 09:53:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AB9N__B7nd93
Date: Tue, 20 Oct 2026 15:53:07 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <8160091f-6227-42f7-ac0d-d63e23babffa@app.fastmail.com>
In-Reply-To: 
 <CALnO6CBuKKF=nCObFCK0coCDqbK=OJTWEshEtj6NaVV6XpWGuw@mail.gmail.com>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <V2_CV_gitbrchanges7_please.dc4@m5gid.xyz>
 <612b6065-9043-425c-83a7-2cfdbe140c4a@app.fastmail.com>
 <CALnO6CBuKKF=nCObFCK0coCDqbK=OJTWEshEtj6NaVV6XpWGuw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] doc: move BreakingChanges to a manpage
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026, at 15:48, D. Ben Knoble wrote:
> On Tue, Oct 20, 2026 at 9:41=E2=80=AFAM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
>> On Thu, Oct 8, 2026, at 21:27, kristofferhaugsbakk@fastmail.com wrote:
>> >[snip of a snip]
>>
>> Is there any interest in continuing this series?
>
> For myself, I favor making more of Git's documentation accessible to f=
olks.
>
> I haven't reviewed the series, and I know there was some conversation
> on how to handle links, but I'm in favor of the direction.

Thanks. Yeah the link thing turned out to be the most work here. I can
of course drop it if people don=E2=80=99t think it=E2=80=99s an improvem=
ent. Because as
far as making the documentation more accessible, all the info is there
with instructions on how to use the references. Just with an extra step.
