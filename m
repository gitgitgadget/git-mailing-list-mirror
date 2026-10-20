Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500757;
	b=EjTyLzRqjDRtxgtOjIfhxBRID7dzETIgOppjEPweau8O40lZnfFiusWnr+YTpeHx9lQt
	 uKjlzhpB+x3M104c0FujWIKoBBW0WMLRSvcz2GKpWuljhcvKLJgTtE3j4RHLcg9rD1Wb2
	 TWNpWkpRcjE5lsffRFnQz8ff0e2GUj8AhIQG3Ri5LHwwhqeDGVxuXf7ASYNbsqTZhq/tG
	 Au7ZKF7MmhxAsKnETWImLX55/V/yh6JdiVM8ewQqtqYW4p2ktJBz6njPnU4o8oL/LfDdG
	 iC8ZOrO/iWepod5LTDYgnzY9g7Var+byVdxGuowjhlv/Eza4S5YsUe3yC26WS0c47yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500757;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=bVd5OajzAx3kYWKiFuP5T5GWx0Cw8dlRFEG7zgbJq/8=;
	b=Zy/Al2kwXRU5sNFceTENx24jzTp5V9EGvMhrVpQASmN7lJhs7ifVXZ5g+3mbzH8MSPSb
	 Qu6iDIOor/VzRFk2FjuHunuj9vZYACo7v/GMnOSbIn44EEl22h22GQzk2B2IMKQYL9pDY
	 X4lMb2Xkv3byYFnFXYE4I7ub1aVZqjjDOe2NXSkPHJlmZk7YgnnTRuh5tRBGyusKUmOOD
	 5qqEiVS3E3G31B5RDn1kIqcVtkbJeCe4a0C00kQDT7ubCTVeHotr+kl547Ug7sTSVj/I6
	 aPL8v89SLsn+ANofbn4Ks48JO+gAkqRB1H3v8c4u79qipNmmM5gxZSfFNF9dadM9UpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=cNn+9aBd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rvS4ylv6;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4696C606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 12:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4696C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=cNn+9aBd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=rvS4ylv6
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 931297A00E4
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:52:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 20 Oct 2026 08:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792500756;
	 x=1792587156; bh=bVd5OajzAx3kYWKiFuP5T5GWx0Cw8dlRFEG7zgbJq/8=; b=
	cNn+9aBdq4S51mNTCJ8/2l2qZqDmZxCMahHcsLhpgrvkQ7CFxF1UJWSm1yd5zM2I
	khdoDLpZp2JxSqk+aQ+b6IsvaPtni7SDyBAnK6Vm2VgnpPwAXGJxfJ38+UxqHv/D
	6q2Tr9/zLAhj5BBNXykaHP9PeLHs+yPCm78H8uqwbGi2XgE0EoaAsUvfYvaQqfoW
	3RftEETRyzamGWLoeB+RzUZQrTesopfK1pj8m1jGhryMLVaaNUo7Ohd4MghbQkNT
	thWN3K+3knzg5U6n29JMBFXmZQCKVZNV3sywXRIVwfrrPiNvimkHfxFAdl467cP8
	zJCLsMVEWL3g+xsjdYw4MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792500756; x=
	1792587156; bh=bVd5OajzAx3kYWKiFuP5T5GWx0Cw8dlRFEG7zgbJq/8=; b=r
	vS4ylv6RQoD49spwQJn19c3wvgx/D4E4aC3DoAvBRWQJR54Ft/rkAcoeLRaXY7Nl
	pd/0KqBv7v4mcpRcHZ795tC8iTJY5gunw97zGL1/7V8L10DlMS2XNlbxMopvCgaV
	PPQwZHpcE5SjTvbWgV1M6jFy0BraGXuYf5kH+d8if/qiB0e28HrXeZb8x0yQAiYG
	8LygiX96xuKJB+qrLoO395VLVb/0zdyMmaGl1l/bIIYAm7TARu4VeONakWwH3s2N
	+5i7Pxli5wxzT/prAyPjIiD2kqq8AfFVe1/kP10QnAVLX7o9jIdrdA15304LAWnd
	nHoqar6FDiWznYzpfNCIw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792500756; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WDgxhwHXABogeQGqtrX+Y304yzYQHCKtsuVHDLQq2YWbet3
	Df+wFPAP1tR/Bgd2kx0Fhwsj3u00mgpwZQZlxJyieb5UP9U20C+04xnWoM/jkHCQ
	yYS8TtB0vxzvR2j+WTCmqdNMQdxKN23LfaFCBsIEoGYhYE/+DzGM1ZMK3lfk5DA8
	+7P8RpjDyJSB46SBZ9HnHXA+weZd9YP6Er1hlLxf5CUNDTrBQ8ay/P0ELOgLCec4
	naUDSuXp1vsWUPzY/bNK3tDhH4d7xSK4M381eL3bsu4dTSoOWN3Yg32d5RJeVBF7
	czK3RcbClybOlWwv91qYCZDizRD8h+PLkSQuXgQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:U1L0IupP5p1JZnDEtPFFB22OUZ6i8g4QHVifKWubumo=:1HBRVlGmfk3ClW/h9nB7kTOmj9H6nPRLWeoMbSrA1Zs=;
X-ME-Sender: <xms:E2TXanoTCl-8jX_EGG0Zs-V_X2rZwGN-Pb25Nz96YaQd9UgXv5ygDw>
    <xme:E2TXapHeE_drgTxot7LUXF3HZB3QO6UacGVOD5h_4lnh8G-YHNvQRwZkX7-SEQ2nG
    wLu5sMW1QOzJALuZe_ZkGafxcfU9JGDcTqnAiSDvGeHOrTfxBN7fsYV>
X-ME-Received: <xmr:E2TXahkSli3EmpN5YadE3JsuqXbNAm_5RA5IjcNicyJtQ7dsKgqLNAFHtHxe8HbksJJI09PLaVeQNvuNSMYlJVsVQ6RgcdSMz_4VM40ca1G-qscszO7v>
X-ME-Proxy-Cause: dmFkZTFxn5ABv+YDC5pUpYv+WLf8d9owACTRHQXvtRU0ChyfTvXz5sjD8qP3twE1piNabV
    cwk4UQc/dzrj0c6k7O8gA4vAqxJalUpeewwoa1ugiO2wu5XaOwqsmTOkwf5eUl3gjk/g5M
    R0IqyPwO0TvSSF42gTqlcXOugiXQdYMZ4NOuIpT/KBkQTLAUOn8QDsrP8XEjY1A6xOLuky
    xWAfxAeQojcmKD+XvhGTRWIBFHW9v2nFcSJoWQi1Y/LS8hVrPCZoDfEJJ03f/j51bypXFt
    HLCL9us54GDUsFJNWvHPGNzXfPIGXtdC1+YOhbWQuOGp5vlUGTn63nruYfGGx9sE8l+7lZ
    fnV3lFzHGTm86y+beTS04Kqu0a1R3hzS5gM5//1f2QE3VAiIf05FvzdUwew1UgKj4054Y2
    +6xW7Mi8x5h22w3gY2U5FHJWWq6MHtMT2xrCkgvg194JkSzv9Y9uOhEdDFlw8BRLoSjh9W
    MjXdSZ/SGrT0YMZN0f6Yko7/WbnGxZFF4J9RUE+JcG2r3KBAL1gTE7WGCiEbalwBg3Qa6J
    gAI9Y6MDPBeIEVnY2oMggDPaShbV9skbEoBSN/YT/al4msN0Y6N1oD5XlYzqfIJS8hPDuZ
    4YkDOeaUrg9mAGVve6iVuGsVM7PpdvK4jpd3/wGZrLFJTxhNepXEm3LHy+aw
X-ME-Proxy: <xmx:E2TXakmu_oLpkJWcD-8hb6kVVQF8bRyBiqgg4-d0rD69Cl2fybLeQw>
    <xmx:FGTXaqtGs_ovZRRYe8Z7ZlWVqtlpeaQ3IVfrVVxlqRkRBrwc8yQl6Q>
    <xmx:FGTXavk5CEo6SVh_4mvcsB_gkzVdbikz4EA1ia0u8YJoG5i8VSfo1g>
    <xmx:FGTXattu9baGEou4NDGzJPOm-V19cJx-L6plmwCjpjelwRdgEn3SwQ>
    <xmx:FGTXahEIInrLivWOWsFUIFKdLaRlVQYOJvaq1Mi1BFmFrwyB2gj8IdQE>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 08:52:35 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH] doc: checkout: rewrite detached HEAD state explanation
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <xmqqcxt52xkn.fsf@gitster.g>
Date: Tue, 20 Oct 2026 08:52:25 -0400
Cc: Julia Evans <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1AA9F133-4B0C-4AAC-B296-5C2543C642F2@jvns.ca>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <xmqqik3da2bs.fsf@gitster.g>
 <9c15d34e-406d-4702-b606-da102a340e71@app.fastmail.com>
 <xmqqcxt52xkn.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)


> On Oct 19, 2026, at 5:24=E2=80=AFPM, Junio C Hamano =
<gitster@pobox.com> wrote:
>=20
> "Julia Evans" <julia@jvns.ca> writes:
>=20
>> Let me know if this is a helpful way for you to bring some user =
perspectives
>> into the conversation. Like I said earlier I don't really think it's =
possible to
>> discuss how to explain HEAD in a vacuum so maybe these quotes will =
help!
>=20
> It surely is more helpful than "I think it is not better" that is
> not backed by anything.
>=20
>> Also if you could give me any ideas for how to reply in a "shorter" =
way than
>> "I don't think this is clearer" let me know, I can't bring you quotes =
from user
>> research to justify every single wording choice :)
>=20
> IOW, "Trust me" ;-)
>=20
> It is often good enough among those who have worked together for
> some time, and you certainly do qualify.

That=E2=80=99s good to hear!

>> -  "HEAD is a mysterious thing I never need to know about unless =
something has
>> g-one wrong, eg. merge conflicts."
>=20
> Somebody may have said so, but how does bringing it (together with
> many other examples) up in _this_ discussion help us find a better
> way to explain it to users?

> Somebody is clueless about HEAD and does not feel the need to
> understand it until they really need to.  This fact alone, that they
> can get going with such a sketchy understanding and make use of Git
> sufficiently well may be a great thing by itself.  It may support an
> argument that we do not really have to explain what HEAD is to our
> readers.  Is that the argument you are making?
>=20
> I won't comment on each and every one of them, but is your point
> that many potential readers do not understand HEAD and doing fine?

I do think that=E2=80=99s true yes.

> Of course there are a handful of examples that they do get it, like
> this one.
>=20
>> - "HEAD is a reference to a commit, either directly or indirectly. A =
direct
>> commit is just in detached state, where HEAD is looking at the commit =
itself.
>> An indirect reference would be the case you=E2=80=99ve shown above, =
where HEAD is a
>> reference to a reference."
>=20
> But what did you want to illustrate again?  I am little bit fuzzy on
> what you wanted to achieve by dumping these at me.

Mostly to give an idea of the kind of language users are using when
talking about Git, to explain why saying =E2=80=9Crecords=E2=80=9D =
isn=E2=80=99t appropriate
and why more generally it might not be possible for me to accept
your suggested wordings for how to explain things verbatim.
For example elsewhere in this thread you suggested another wording
and seemed to find it hard to understand why I wouldn't replace
what Marie and I had written with your suggested =E2=80=9Cbetter=E2=80=9D =
wording.

Also I have the impression that our assumptions about what Git users
know and what users need are quite different, and I thought it might
help illustrate why I might have a different point of view.

I agree these kinds of comments can be a little unsettling to read when
some of them are =E2=80=9Cwrong=E2=80=9D. I believe that these comments =
are from
folks who are quite a bit more knowledgeable than the average Git user.

It=E2=80=99s my job to sort through them and figure out how to write the =
docs
with them in mind and I=E2=80=99m definitely not asking you to do that =
:)
I do need some trust though.=
