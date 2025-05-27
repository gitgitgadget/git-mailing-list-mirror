Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78812110
	for <git@vger.kernel.org>; Tue, 27 May 2025 04:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748321890; cv=none; b=lMIKA0j2aH6Omx4eYsfR6BWvJmnIVRmAQp7b+uWRVb9HW12OxI9xPuyzJ/4R9DpormvDFZn8GJvns1uCKr9tv7wQx2ZemhvghNWElfHSYoy4TvWevSvOSXUHglVs69km44MOHYJqHofaYeaj5/g/RRO24d7PwtiatwZ/XQIb4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748321890; c=relaxed/simple;
	bh=SDlRqFF66j16MxBBLHpsineRn6RyFGuY6NyJz7sh+Ds=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=Dc6347ioc+9kjuW1etnploma1WGYiCn226vJ0hdUmiK6cMUT7sNYAyxAyt4ovimZTcCI9AixL1YzWVv5/XawV3IgtWOAsxGCqI5FZVsigGo9OypHSTXDMpNsepIAMnSPH2RtJw7KcAnL+4S9BKGz6hBsHoV3BEfm+tPf2526Otg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sanwhole.com; spf=pass smtp.mailfrom=sanwhole.com; dkim=pass (2048-bit key) header.d=sanwhole.com header.i=@sanwhole.com header.b=B6AVuxVz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kjzjox4S; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sanwhole.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanwhole.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sanwhole.com header.i=@sanwhole.com header.b="B6AVuxVz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kjzjox4S"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB98625400C5;
	Tue, 27 May 2025 00:58:06 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-03.internal (MEProxy); Tue, 27 May 2025 00:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sanwhole.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1748321886; x=1748408286; bh=SDlRqFF66j
	16MxBBLHpsineRn6RyFGuY6NyJz7sh+Ds=; b=B6AVuxVzsFDAPY5W6XZ2QvysgO
	aT15V0ouK2ifBXQMxcbKBxJxGHCwjLbIlP23WZeMNGzLwGvyfFX48ZSXj1LZFJdg
	/yPa9k0x5H8JpF3AaGzOs6cOKcweFx0AH80U92Ce9QOn2wyMkasCa98IaJ3fv8CC
	XuuaLAXoWNP2xJL3XxUk7Uoer1J8XRuig682tC2lin5d5NhZ/1eRi67JjZUyeKW3
	Mo3SMwNjjaP/gJK+b7D5dNsh06S/MofA+UdfumFEd2plZ3ouR9beFRpb4m5Xxvhy
	kUiz+XVAi3ya+BMnzry21fVq+VRVsDjy3XNSfCVRfyULEEvL+vTyqovqwOxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748321886; x=1748408286; bh=SDlRqFF66j16MxBBLHpsineRn6RyFGuY6Ny
	Jz7sh+Ds=; b=Kjzjox4SL7TTX+Og5U5uXQLxu160+wSNkgZJ7ZQdf1pPHWz6h4j
	SnVNDrZYgt4vG9wyRfjZUWJ6j/mJUZeGfM1U8WXJ++ovn9j9gilx3lWpQTmJtEuX
	eoI6CgpqvYwbIWeOXcZGorQ/XBNlwa1/oGBxFM9BHuFZQOLUbyN6BWlemUV6S5WG
	UU6ldkavN1RMfusDmCyqDSDIqHTK0wCGvASpipChh6P1nQ0LujHEF9WrhkoRJa/L
	T1B6fRsZRYQA0bYGVnOx/SDp4+90rlYvFwioht/6lvkMXWdb7au1i104GYH/J6XE
	SfaDZK0qSW9Qyfl1QQfnfQa7kpju2xxjb3A==
X-ME-Sender: <xms:XkY1aCmDeVShDsxB57x-xjswiHZ4ErnyOozOmcgKNAIXy_v3bY6qsw>
    <xme:XkY1aJ3KVeMKEb2IGaBt1F-zr1Gw5hTt9JK8rCj41YbMKlABJaUD8Dng0Sm0fkTTD
    L1vRfQnx21hzFwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduleegleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepofggfffhvffkufgtgfesthhqredtredtjeenucfhrhhomhepfdfp
    ohhrmhgrnhcuhghonhhgfdcuoehnohhrmhgrnhesshgrnhifhhholhgvrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvueffteevkeduleegleeuvdeiieeugfeuheefvdfhgeekjedv
    hfdtudegfeetveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehnohhrmhgrnhesshgrnhifhhholhgvrdgtohhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghlvghssehsrghnfihhohhlvg
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XkY1aAqrrMUtGgGkB5RYTLWUQKp72ZwDfZJQiclIlWdHBcWGNVXqyw>
    <xmx:XkY1aGk7S-ovNwnSWAZ7uJ-IC3tUfsZO96azyNkSyYTSYmS7pT-gUg>
    <xmx:XkY1aA1meGhfAJ7CVMEnEJBR8dVNl5iD1Rb7jPd3l3MnJWRK-H2cQw>
    <xmx:XkY1aNu91YE6_xxvrZWAro57coR7vgPzLTm9J4aLqmSCNT3Qmy0rpQ>
    <xmx:XkY1aL9kKa9PCB0-Z4EzEMOi8fVFbZigZweSKkcMx3OmdzvDLlPwlH6b>
Feedback-ID: i6a7040bd:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9ADBE700060; Tue, 27 May 2025 00:58:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 27 May 2025 12:57:42 +0800
From: "Norman Wong" <norman@sanwhole.com>
To: git@vger.kernel.org, sales@sanwhole.com
Message-Id: <b3c0317d-ffac-45d2-b240-19a520250a6d@app.fastmail.com>
Subject: =?UTF-8?Q?=E8=B5=A0=E9=80=81=E6=82=A8=E4=B8=80=E4=B8=87=E5=A5=97Vole_Off?=
 =?UTF-8?Q?ice=E5=8A=9E=E5=85=AC=E8=BD=AF=E4=BB=B6=E5=A5=97=E4=BB=B6?=
 =?UTF-8?Q?=EF=BC=8C=E6=82=A8=E5=B0=86=E5=85=B6=E5=88=86=E5=8F=91=E7=BB=99?=
 =?UTF-8?Q?=E7=94=A8=E6=88=B7=EF=BC=8C=E5=8F=AF=E7=9E=AC=E9=97=B4=E5=A2=9E?=
 =?UTF-8?Q?=E5=BC=BA=E6=82=A8=E5=B9=B3=E5=8F=B0=E7=9A=84=E5=90=B8=E5=BC=95?=
 =?UTF-8?Q?=E5=8A=9B=E3=80=82?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=E6=82=A8=E5=A5=BD=EF=BC=8C


=E6=88=91=E4=BB=AC=E6=98=AFSanwhole=EF=BC=8C=E6=9C=89=E7=B1=BB=E4=BC=BC=E5=
=BE=AE=E8=BD=AFOffice=E7=9A=84=E6=9C=AC=E5=9C=B0=E5=8A=9E=E5=85=AC=E8=BD=
=AF=E4=BB=B6Vole Office=E5=A5=97=E4=BB=B6=E3=80=82

=E6=88=91=E4=BB=AC=E6=AD=A3=E5=9C=A8=E5=9B=BD=E5=86=85=E5=AF=BB=E6=B1=82=
=E5=90=88=E4=BD=9C=EF=BC=8C=E6=9D=A5=E6=8E=A8=E5=B9=BF=E6=88=91=E4=BB=AC=
=E7=9A=84=E8=BD=AF=E4=BB=B6=E3=80=82

=E6=88=91=E4=BB=AC=E5=8F=AF=E4=BB=A5=E5=85=8D=E8=B4=B9=E6=8F=90=E4=BE=9B=
10,000=E5=A5=97=E8=AF=A5=E5=8A=9E=E5=85=AC=E5=A5=97=E4=BB=B6=E7=BB=99=E6=
=82=A8=EF=BC=8C=E5=B9=B6=E7=94=B1=E6=82=A8=E5=88=86=E5=8F=91=E7=BB=99=E6=
=82=A8=E7=9A=84=E5=AE=A2=E6=88=B7=E3=80=82 =E5=A5=97=E4=BB=B6=E8=BD=AF=E4=
=BB=B6=E4=BD=BF=E7=94=A8=E6=9C=9F=E9=99=90=E4=B8=BA=E5=8D=81=E5=B9=B4=E3=
=80=82=20

=E5=A6=82=E6=9E=9C=E6=82=A8=E6=84=BF=E6=84=8F=EF=BC=8C=E6=88=91=E4=BB=AC=
=E8=BF=98=E5=8F=AF=E4=BB=A5=E5=85=8D=E8=B4=B9=E4=B8=BA=E6=82=A8=E5=AE=9A=
=E5=88=B6=E8=BD=AF=E4=BB=B6=EF=BC=8C=E5=8C=85=E6=8B=AC=E5=9C=A8=E8=BD=AF=
=E4=BB=B6=E6=A0=87=E9=A2=98=E5=A4=84=E6=98=BE=E7=A4=BA=E8=B4=B5=E5=85=AC=
=E5=8F=B8=E7=9A=84=E5=90=8D=E5=AD=97=EF=BC=8C=E8=BF=98=E5=8F=AF=E4=BB=A5=
=E5=9C=A8=E8=BD=AF=E4=BB=B6=E7=9A=84=E4=B8=BB=E9=A1=B5=E6=B7=BB=E5=8A=A0=
=E4=B8=80=E6=9D=A1=E8=B4=B5=E5=85=AC=E5=8F=B8=E7=9A=84=E5=8A=A8=E6=80=81=
=E5=B9=BF=E5=91=8A=E3=80=82

=E5=9B=A0=E6=AD=A4=EF=BC=8C =E8=BF=99=E4=BC=9A=E8=AE=A9=E6=82=A8=E5=9C=A8=
=E5=90=8C=E8=A1=8C=E4=B8=AD=EF=BC=8C=E7=9E=AC=E9=97=B4=E6=88=90=E4=B8=BA=
=E6=9C=AC=E5=9C=B0=E5=8A=9E=E5=85=AC=E8=BD=AF=E4=BB=B6=E7=9A=84=E5=BC=BA=
=E4=BA=BA=EF=BC=8C=E8=83=BD=E4=B8=BA=E7=94=A8=E6=88=B7=E6=8F=90=E4=BE=9B=
=E5=BC=BA=E5=A4=A7=E7=9A=84=E7=A6=BB=E7=BA=BF=E5=8A=9E=E5=85=AC=E8=83=BD=
=E5=8A=9B=E3=80=82=E4=BB=8E=E8=80=8C=EF=BC=8C=E5=90=B8=E5=BC=95=E5=88=B0=
=E6=9B=B4=E5=A4=9A=E7=9A=84=E5=AE=A2=E6=88=B7=E3=80=82


=E5=A6=82=E6=9E=9C=E6=82=A8=E6=84=9F=E5=85=B4=E8=B6=A3=EF=BC=8C=E6=88=91=
=E4=BB=AC=E4=BC=9A=E7=BB=99=E6=82=A8=E5=8F=91=E8=A7=86=E9=A2=91=E4=BB=8B=
=E7=BB=8D=E3=80=82


=E8=B5=84=E6=BA=90=E6=9C=89=E9=99=90=EF=BC=8C=E8=AF=B7=E5=B0=BD=E5=BF=AB=
=E5=9B=9E=E5=A4=8D=E3=80=82


=E8=B0=A2=E8=B0=A2=E3=80=82



=E7=8E=8B=E5=85=88=E7=94=9F

=E8=81=94=E7=B3=BB=E9=82=AE=E7=AE=B1=EF=BC=9Anorman@sanwhole.com


