Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66AD36C5BB
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778008192; cv=none; b=BO6v2t8PowpRs/aQcqzhVMp3GL5psXBiNrt0bKpqRKPXbXs/VOz69S84uqtiSn9F1MB75IOzHP4alDlIDeB2fPElnN5FrNhQ/d9Seo8Q/pJLxVaX3dlk0E8JdgUxqz3AcKgAqFXPBy6Q4zgAegnnc4sOggC2gfpuJ4qQk8Wm2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778008192; c=relaxed/simple;
	bh=VYAqMAQeO+zTK2k6R/9LnpwLNUkSb8qSuImA9XKbXWc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u7x9GNkMYwxHF6SIMGYJjtzishN0kZEQgInlbWd/OiQn5rQCBgnwDgAraEmGeXwJhhKPM4RTewVlCuK0THU5kGMlOgjLIyLne5+LgNmm/AnurMyvj9r9QSF149DtqfknM+Hw9ZzkG10x+MYwpqwSXGsNmEOLIH2Oz1M4B0Xu1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gqntKqZJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sgra4f2b; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gqntKqZJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sgra4f2b"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F85914000D7;
	Tue,  5 May 2026 15:09:50 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Tue, 05 May 2026 15:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778008190;
	 x=1778094590; bh=R0MHfmbvqOD5X+WJzx+sSWVKKfO4vA6bzsjINejrJp8=; b=
	gqntKqZJVvxvqQGy6p4Lq0VFcAQi0ISFRiwYqWd1dNSlug0yT95O70RMtOD7lCDP
	hDfHyfPbRIQdTsI3Vxy2DoMLo7kUIiw2PsJxbJlKyUSb/twr20wqnDqKdhaFocg8
	deYHgP69hf4zVefiEmsZplEHAbRgk+8YzK5nJIzpFROsLHt8Ho99ThBScER/Ivb4
	hkHHpPgzm1EfQoR5u0cLw62VI/jGuGhc7azclwH4juskYjhMWDJ3E4F7SUo/Scva
	jlQCUdtb1f0Q+vtGdZQcNHalw9u+NwSW22yLNWWbNUVKg8xtxVdjUJuNgwwCCmnN
	+m2GQfbtWPepFMM5DTp9lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778008190; x=
	1778094590; bh=R0MHfmbvqOD5X+WJzx+sSWVKKfO4vA6bzsjINejrJp8=; b=S
	gra4f2b+ujDKgAhiALowgjrD+m36yS7in+PHIrWZa4O2AOqfWsHOlw+6SPJQRV2q
	KKJUwvNDGUHSX8aXl+Y/5HvCxGd0V979q9nOoFMVS7OaZjxUtyDACGcd2jRfk5Pp
	HrmWXMfSbk1vRUsg1EJ91dNe+GV4hbo/cK+0q4r18RihGs/t3GtoKQ9bjqa7BgKz
	Gast1vd0X0f6CeTGuTl8F8fwpd90LFQvltj+1ADlquAvm6r2uLRYq9RYtcTjSjvI
	n4oQ3yQSaOprBfXDxVIQoG8i1/+kM4lGgRrf97+NMXRchZ5e6IXnRx7219fVSETI
	Ghtli6OOwurZf0/m6F1vA==
X-ME-Sender: <xms:fUD6aXZ83nL1VBgzJY1RfaLKkFYsI9HdhHSuGADqyeaEVeEyiCrSKgM>
    <xme:fUD6aRPW47iZer1lN1Yslst_dzPIVDjBeRAjATU-WrUFay7IdeG_XvUyjCM7yfrKn
    CA3v7zyofcpoDwVbTQjL9hUE1cJnwcrgl5W20AgdUxQaRDmhYj77g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fUD6ac8tqHfTPsVFd0KLGJpVpqeeOaUv-jYMoFRcoNdRxABISFXsgA>
    <xmx:fUD6aU38KNOZSbO-4ZvVBerScRZbPwcivfYmjWtJ7mHQd30LnssGHg>
    <xmx:fUD6aZ-k74W-mKFHq0yq1BPK5dM7S5jnxEHjf2BseulTzHm5JN5Ncg>
    <xmx:fUD6aUuyslz1s3klpdpRswkVVYJVeAJTKSU6TIPkkUxNJIk0jIJx4w>
    <xmx:fkD6aSquoDpPxs_wa91NjMz6aJmAdbMxFZmTurfloaCCPAeU97t79CAT>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9A0B1C4006E; Tue,  5 May 2026 15:09:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHDyktfZDWSB
Date: Tue, 05 May 2026 21:09:28 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "GIT Mailing-list" <git@vger.kernel.org>
Message-Id: <f3e3130b-40a7-43f9-b8dc-41ab57de5f2b@app.fastmail.com>
In-Reply-To: <aad833e9-d34e-4e57-a1e7-99dc0c6c7d24@ramsayjones.plus.com>
References: <e74a8fd8-0617-46a8-8bef-a454d51a99c1@ramsayjones.plus.com>
 <xmqqv7d4ou3m.fsf@gitster.g>
 <b04e98e3-0840-456d-a627-351f2378c037@ramsayjones.plus.com>
 <cccf9618-31de-447b-ab17-4fb8cee23363@app.fastmail.com>
 <aad833e9-d34e-4e57-a1e7-99dc0c6c7d24@ramsayjones.plus.com>
Subject: Re: [PATCH] name-rev: fix an 'may be used uninitialized' error
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026, at 02:41, Ramsay Jones wrote:
> On 04/05/2026 10:56 pm, Kristoffer Haugsbakk wrote:
>> On Mon, May 4, 2026, at 22:26, Ramsay Jones wrote:
>>>[snip]
>>
>> This is what I had when maybe-uninit. didn=E2=80=99t fail for me.
>>
>>     $ cat config.mak
>>     DEVELOPER=3D1
>>     DEBUG=3D1
>>     CC =3D ccache gcc
>>     CFLAGS+=3D-O0
>
> Ah, yes -O0 will disable the warning/error. Normally CFLAGS would be s=
et to
> something like 'CFLAGS =3D -g -O2 -Wall'. (which still produces a bina=
ry you
> can reasonably use with gdb).

Thanks :)

>
>>     CFLAGS+=3D-ggdb3
>>     USE_ASCIIDOCTOR=3Dtrue
>>[snip]
