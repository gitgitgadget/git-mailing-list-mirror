Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238809;
	b=ELav3c2mnQH3dVZg6DGU7gvfbW7nRycFgXkoEO4Kr8Tz4iR+PQ+DCgTqjdVbqkgOTQae
	 5kpgLMUfgx0k3E7S82qYNmfB1CYffXpv8Tmp4sIuYeEPQHl1sfwb9MEiAUgCoVNGkhhjH
	 k0JUmOzyaqxb2s75VyAn5D2AGB7wGePH3iB3zXEr1QIPIKy3tiEG6+ykVXb6fqb/Qs2t/
	 uJEGOCQFW8l5RXnKnKdIyCDdatswCVkQIpkQcbS5dC4w0yT6f5MsXokryAHegV0Az7xbO
	 PVMYCYue6ukn7TRpvIUYnmNllIRf245zFUC64aaeQ3zhzPH90EcvVtKQtdPXAZvPp4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238809;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=271TGsqRDTQp6/xi8ErmsnJqR79f1zeOyoEIKbBFO44=;
	b=YPUFmsfSHeCTdW7NJq+TJJl4SNJH5LwCc9lnMy3rKUe0TWbtmD5Cv/72w7ahTr4vJfmq
	 9ViD75GmYc3/APwg85p4RzyBLJ5T5XAX1Zu0cNrAeRwMOkh1iZ4ECGrbf0jVp53qd4K0J
	 H0TvvaG2TH6TSY39cQ8Xqiun384WlUyW0VkPKYbATZVefI0vZTRpluABZlfZXKuCPa6T4
	 qgxKiHvgOEESnYgh/6XRmQwk8NaTC+sJIQuuE/i14sEJeQ/uSBGv4GL8+yAO6rSdcqduK
	 KBXYFrBGt4QpZjmAVPMFAo+giCuBlzjXDkkVW8oWPfH3kZ6GYtKzmswfVZ0grkyE/3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=HVo1iUlp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XHGQSHof;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62375606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62375606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=HVo1iUlp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XHGQSHof
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9BDC1EC0204
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 10:40:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 09 Nov 2026 10:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794238807; x=1794325207; bh=271TGsqRDT
	Qp6/xi8ErmsnJqR79f1zeOyoEIKbBFO44=; b=HVo1iUlp9guCFNrRq52f9u8571
	f6k28hOJYfPg/gKcg2OWAA07+D1dnN20k6ZwspxM3czaZ+l8ocyizGAvNopu3lvF
	zVF/+httn+Jv40FKViAA+y7mey96gTbxJb+cbjf00QVG6L5OHhEjrnMY3y/5UTco
	ZKLEFr5vFq3c0mNGyxU+yLGmJrnTpuq53Qw9euSpvm4eH+50VZUEg+pCPKbo8O3h
	12eIHWAyP/zs1WFi89mKHqcZ4uDfMbBGy7jz20h1HAjY4p48epsH5rhYl76A7W+o
	Opw/YnGa6NFPeWvK5ECKaO4qU600rAKhLgrwVOqPYiFjIvIK+ud/uQbj18Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794238807; x=1794325207; bh=271TGsqRDTQp6/xi8ErmsnJqR79f1zeOyoE
	IKbBFO44=; b=XHGQSHofL1wA3tcx35fExmFHsSBwiZWiVHU9AMpcRBLfuZ7VjHt
	HnFRgMmhOS9IZrfy6EYSxL2AihS9XpDJ61dF7NuJOhoWjLYHTgcW0nnDyiMfs7C0
	cM6AsnA++SxC3Nestb8YW+H3RwE0mFAlRsaoxz9XjcNq6IgEM0zi4P6qwb1Pdd59
	CeEYCKzY/gWalpJDMZBaKO6TDa5ax7VfMYCB/Rq+kAJaqpLrJuzZucDPnSSE2NcT
	pF84zBja2qFqBQVerrEBKxSkv1SYYk5RgeOqHcNejQxBvMwZpWrjcKgS/fzuEhC2
	/2x5lECOiu3s8gu80a+KnOWIIk2eRmql/3Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794238807; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:R3Ev1BpwwrT/bjQJKoKLeXv3AGGE1wEvzhuaRhuB8n2Xt/T
	IDvptA3KwYcec0RTyWadmjSkxIs7Dzk9logXGeGnIDdKRE9UMnssZ3isScJgwnbx
	CHsj03JdRwzTQJcumt9bjWxY/UkrF5CrddaSIIsBkwAYBYRAqxdky1yF7UF9P3Qx
	BKowp9KlXp/T40p1hObocXxL4fZNfxaPxW1wQt9u5JiK6othm6UVD4R1PtdWBImS
	/T3VXZQoOz0RtPxM3YwkaHV/GtrBGzIFQV85MScB5SE9DV7PVHYFm1EyThbfjPPE
	POKmaZr7M9Zax7UXdUSF7CDJ13i1n/h5X4G4pGg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ZvxJZG5mFgE6jXuxHyMCEkZC+YQE9bwSSy/KXRMw+As=:QixSu2lB8j6I1dDOk62rD3aD2RlZ6wleAubp5kv1kog=;
X-ME-Sender: <xms:V-nxatF6zrQ-AFSCRrBECO13omOHX_Y1VacozRdvkrjMypj5NmHkUg>
    <xme:V-nxapP3GhCv-bxd8qXJbchbuVhrB-AKgG-eH6Y4fNRb95TwkAiNuoQE58IUFKFoJ
    cJcjCDYTrcCIva576FefgSnorP_GyCsKwXzjHvZ3ZoSVoMiYvJykGs>
X-ME-Received: <xmr:V-nxancOgG4T32Ob_yoc15g6E3mfDPFnmjUH7JH5ttHMXF2sxHTYtQZFFFZXXM3Pnokzv2UlHmg9_zW7JlpBg4KNxNwUSm_0APuA>
X-ME-Proxy-Cause: dmFkZTEh4i0Gh88PpGyEnQpsEup9wlsWhgr0UIymVw8+OeZMiFKNW0O7530jO+5GndptHq
    VlEZElatFtV1PHcMbgxwqsLW24EoYfW7ktEYbhWMlDJCxvFO+M2iYUL6cixzB6fEPZugf0
    ahwa3U3uEADm3rYJqM2+3gVND7i3y3m+b1Ok6Xy60eA4cL6ehpA+eXwssygX51M9SZDtdW
    scm69jhprxePrItdAVR2rmg1MBe2z1ROTyWbR0hPd+PoFzVHMsjaNLhNyzD0FjhIdihDbR
    ibvBv41O29VDXj03DwJ2/IavB6ERtbcIxIsqcqjne37CwUjJM+klqSDAIFY8M6vgWdf0DK
    Q8AP0S2s3Y4KhflyKrXgc/iDEY/3NxszpVeh4L0gmrdRcToT5ZQxcKOpg+bMxrtMYSwlvl
    EzzW0wYM29uL/BwSFEFfdmehhQ527gjbUD+KEMVKM5k2CtNUq1oYQYFA/30dkISiYrwsyT
    Bo9QLT5DA8xwYurRuGlyNqruUFhenbIkzGvWoO68ZE/FSAoIuWSpOC7N+RUhBje2nEIgy2
    JTRtfnwQG2UoHUSIGgepz0WuKi/jtDtFKvniyYVoeg4cC3UkaKuQwgSFmdIl+q607ZPpr9
    LnP/kzx43xHE/j3c9smx2OL5Tw8ICwBFGodhQeO6kPITcarZ6oGCk7BA37rA
X-ME-Proxy: <xmx:V-nxaus82ia24yfQdWTASTz1lnkOp3sRblSso6BGzrPLchugYzf-0w>
    <xmx:V-nxagnPYMVtTHaAQQa3zKtg5L77GgGdNxm4qfGYlZ4zAee6JL0KzA>
    <xmx:V-nxaoyWgrKpOrFag7aUKepTLGxHeanZsoPTAUYIf7HWEqxBhJv8Zw>
    <xmx:V-nxaqMpJdyO3cxjPR7vPeY_YDDxTGEjOe06PoEdmdY0vTliySoExw>
    <xmx:V-nxat_SgtwJbocCsEwWVb6YaAQf5XwQKBRbfVBW5kdiABN4H2soRHEf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 10:40:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 02/12] rerere: convert flags into an enum
In-Reply-To: <avFxCywngxJgwylf@pks.im> (Patrick Steinhardt's message of "Mon,
	9 Nov 2026 08:06:51 +0100")
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
	<20261106-pks-rerere-subcommands-v3-2-4ff164d8fb81@pks.im>
	<xmqqqzgxlxrq.fsf@gitster.g> <avFxCywngxJgwylf@pks.im>
Date: Mon, 09 Nov 2026 07:40:05 -0800
Message-ID: <xmqqld7210a2.fsf@gitster.g>
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

>> What BOTH versions lack is an explanation why RERERE_NOAUTOUPDATE is
>> needed in the first place.  In other words, "How is it different
>> from the lack of RERERE_AUTOUPDATE bit?" is not answered here.  And
>> I think that is a lot more important thing to clarify.
>
> Heh, in this case _I_ thought that it's implicitly clear from the
> comment of `RERERE_AUTOUPDATE`: it overrides "rerere.autoUpdate". I
> figured that updating these comments would cause some discussions, and
> that's exactly why I didn't dare to update them at all in v1 :)

;-)
