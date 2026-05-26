Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEDE3BBA1E
	for <git@vger.kernel.org>; Tue, 26 May 2026 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831750; cv=none; b=jbsYL6Eq3IGT88nBc6VXfBYGI7AMFZhts8NmfcVqN6rE97pj84F1zHurGIh/m5opMYMO6WmNIF87UCW/S1frADnhhFWpv8AlXzdtWZNc2J/nfoi0OX0OVvGjieLtR/CtKiMKChX1bFYFGBDbpLawErDSCtYaZg5yYWnqlIFokYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831750; c=relaxed/simple;
	bh=SeE+3Zg5Oz22fjZhHuL2vsOiHxi5xerUfJ/AHyB/Wbw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eqDoAXgh4FoWoOxpE3HyTW44sSO+2EIeVWeWU8MbKxYa0TC8yon74WrYZE3wOEPHsSAtwx8Rnt8G2Ok6GA+j8q5tGFYsPzWauveBUUFxiqIAHxCM+PuAFS6W80gNCtNDTOZhE7dA4P4hdan7Izq3sgSFNuUyO57x5+EQglUslDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=a8kSWKEb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hkS4nrmz; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="a8kSWKEb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hkS4nrmz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3CAEE1400116;
	Tue, 26 May 2026 17:42:28 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 17:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779831748;
	 x=1779918148; bh=SeE+3Zg5Oz22fjZhHuL2vsOiHxi5xerUfJ/AHyB/Wbw=; b=
	a8kSWKEbsHxSCtJLwnR0UIxMmG6s+Z8T8K0Xn8mDo+hzsnNgUbCrwGlUJ6Bl+GEy
	Liy1/00wQfVP+lEGQJehHnLcmNWPHE9uS8s9WzaSPjYtNt1ApY3CFXMXJnwhBF8x
	Iuh7Zk8j/rlU7gumDh7PIXFLk98ucrIfLyGcoPlqeCthr6trfKOHupsvopyWjFOb
	QT13jvdDDjfmHPD+hHmSf/6JtH+sV0qRi79WvkTW+gAE2m3pbsnOrQfEKrr+ZpUs
	HJg/RsMc0c9S2CsoLOznpMCMiL+ZGvRWFamlUuq4LVzwYmuJk4W1MRdINpk/GTR9
	NinQhE22LG/zPshF+LWIww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779831748; x=
	1779918148; bh=SeE+3Zg5Oz22fjZhHuL2vsOiHxi5xerUfJ/AHyB/Wbw=; b=h
	kS4nrmz8JDlJs684yZk6uYFr3Wx6TYT0RCL1IuKe+i/TJzoR3iLi6XXYrRR+fsln
	6ceweS9NNQAsLdtWlPSNTHT7MVIlC2RfoZAjQ4uKf71dchEd7CuQsLTHlC5tClUl
	on4Jse/0x9W94eUc3G/XXDJ0MjaZg2MZYTMdh31tR/5Py/60yak/4e8/dzBd5aCT
	3kLquaoVAJEMfnI2qBg6MVr/JNaR7+xj4kGz7qjRwQXQLJV1umXNEfhXC+F2oAsL
	vrGnzz+FpD4eBDGfTafFs/80Lc1ruQlCfOmanQ08HpZ2K9uq+xWkfcbCGwNsGEZn
	N19zqRKP3QzHXnlbxqzgw==
X-ME-Sender: <xms:xBMWapLquHTBhzdi9duprQHiJYlrYl9c_rpRQkev2cQ7a8ID_wyZ6g0>
    <xme:xBMWav_foYv1e6REPtBMzqob4Rv4VU0VzO3vZC9TG0x9rYqEDkDzjJ03-_C2XetMC
    e3DTdMsxlp_fWTKTKHQUguHiB4G9DkXh_9sb5Xg1cG1ZWFyaV9B0g>
X-ME-Proxy-Cause: dmFkZTF1JtkzqsEMVVbete7obBVOtjOw8IqPfzLYuHTUSYyU5Wku+Cldj+4V7DvcJyGb61
    Ab+ZcmlXv0w/cZwRH3nz19uCkC5Q/tRkUDf/LiYXJmVcRYajCDUbEQHpgcmaWeNfV9Z/M3
    uw3MIQIstfaFpkhpTDLrsInrtr6YbngqkQlPy8t7jk/45tTJFKj3/EJTxAXYCC8EWYF04Y
    s+RpJkfRWVrKIg1llWaIIKVIUTiZAbIThJlwmK0B9JS9H000NkYx3Z+cQ9uNYcYiJqfu/h
    mELBNw8u1Y8zqA/nqehpw3mJIWTvirzLYlspJ8mPANdOhhhkjSf9txqZSTx0K9xGM/AMWd
    t3wFEsC37HFj7JaUahKgkLf+CKxxV+bXVLFZEko4GHb2oVmbwsZWCT8LH9s1nRYJBcWgTE
    c6LcDagQDCG21dmPUzHto5lboImxLM2+ghsGt48KR4v9IdrxyrnTbIdkfRVXLdY8ZYvT9H
    U43TEVrRGPAyiJK6m4doFUerzIF+WUnDQR4Z1jp+XkgJj4qMrpGg+SWJuu4OxiV2/fquWe
    vGMy+p6g1kbSXKow3AmT3uYLE3XeGl8//TmEnOL25v4eqDcOxxt3Cw1+1c50/J5uLRduSK
    QVJcJ0FLRjVHY4xoTmNyHTWSxdPtrhCSGLxsMo/kOgR8eOUzX3z7et7c4Y1A
X-ME-Proxy: <xmx:xBMWao1g9KUkmZ5rUs8QTQwDVWsXmO6I9T4c8RxtWWRwPodxm3U_Mw>
    <xmx:xBMWasY5tWMslqcRQGSp4srg3GkdU5Dg5NO5mE6e8xrw3R16IQ__YQ>
    <xmx:xBMWaoJMD6N_yy-e_m_qAIyt5iD-weV3-9UFD36lXZ5NJet5oFkfCg>
    <xmx:xBMWajF-SP-mYzync6R1lCWRUhj7sbRCQ-05Vw50T5cnl5ebmtAMRg>
    <xmx:xBMWav5drjpSCsUxXpkBsLXOuexMiaIZeU1czY0j_ry-dGzAyFxkyY0G>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0AB403020073; Tue, 26 May 2026 17:42:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdJf8Qpl78Hc
Date: Tue, 26 May 2026 23:42:07 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
 "Christian Couder" <christian.couder@gmail.com>, jackmanb@google.com,
 "Linus Arver" <linus@ucla.edu>
Message-Id: <0faba437-31cf-4004-adaf-2dfcd2274a5b@app.fastmail.com>
In-Reply-To: <4DD440D4-145A-4A9E-ACBA-8E6ACFA231D1@gmail.com>
References: <fc1f8149-98c2-48e5-9725-08cc21696cb2@app.fastmail.com>
 <4DD440D4-145A-4A9E-ACBA-8E6ACFA231D1@gmail.com>
Subject: Re: [PATCH v2 0/9] doc: interpret-trailers: explain key format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026, at 23:34, Ben Knoble wrote:
>> Le 24 mai 2026 =C3=A0 08:41, Kristoffer Haugsbakk <kristofferhaugsbak=
k@fastmail.com> a =C3=A9crit :
>>
>> =EF=BB=BFOn Mon, May 11, 2026, at 21:23, D. Ben Knoble wrote:
>>> Overall looks good to me. Repeating a few points throughout the doc
>>> might create headaches if format restrictions are changed, but I thi=
nk
>>> they are essential points worth repeating for now.
>>
>> Thanks for taking a look again. :)
>
> Thank you for working on it :)
>
>>[snip]
>>
>> Here is a draft of this part of the doc. I have tried to consolidate
>> these two =E2=80=9CBy default=E2=80=9D paragrahs and be more explicit=
 about what =E2=80=9Cthe
>> trailer=E2=80=9D is. I have included one unchanged paragraph before a=
nd after
>> for context.
>
> I=E2=80=99ve read through the below a few times, and I don=E2=80=99t r=
eally have much
> to add for now :) I think that=E2=80=99s a fine improvement.
>
> Whether you roll that into this patch series or wait until the dust
> settles is up to you.

Many thanks!
