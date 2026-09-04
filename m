Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC21A6817
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 01:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483811; cv=none; b=MlSTdFJVyZvJzzEfZ+nmKZ/w/eolei4pwvXuRwSvF+6yZIItn82qx+9N8VPsHeR0OPGhm2Q0ocdJ6GRFbzDUMWTA2EW4Oa/lqkGDyPh7k4tmJM+qPKdD+cwOvKcFzwxy3bkSeyKhoFQ/N/kB8JeDWMM1+pdsthBeF6fMkr/N7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483811; c=relaxed/simple;
	bh=OYc1vmReCtFOHupIgSe3dQS8VLIc/GeG1VqIR2mGdyA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Kmbz8Crer9qrWpi9MWrqANsBHZPjnDIm7dBhK4UPtIFk6AWvkoNlR+fXUTV1+AjpDSd6GP0LJVfTqYEXcodEeEsoMd4652uuAh9IS8w8A8rWVjDCyHDb+/m0HMzbQ5QsZPtEDi+M0vE4nwH2zM6vG/qo2gY3jZF7rDW1Hfbo+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fKgyDBkP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u6c5tXD3; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fKgyDBkP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u6c5tXD3"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CA77A1400077;
	Thu,  3 Sep 2026 21:03:27 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 03 Sep 2026 21:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788483807;
	 x=1788570207; bh=OYc1vmReCtFOHupIgSe3dQS8VLIc/GeG1VqIR2mGdyA=; b=
	fKgyDBkPqp6uE0lK7ezCtD61NmLQsNH6ywMhHK3im2jN+kB4W8H5/duNMKZppg8C
	ERr0gSvicHtm63J800dwv9Fr7unCHLGoc+gvjLwR4QxtbAEP9eOGgGVPyfuJD4+E
	//w7KKkBtEcTGmjmsu9X27ynV/8GAeEhV3ncF5IJ8rZ8Mv9vVczOIiWrP3lA2JKG
	yLYvFBVVrDxEVz/eHI0QIkRAwFV+E3h/Byte5Zr6dc29pPDo0FjCl9zDyOGzQGcF
	Jzl8RS7DCCpEUAjNE3Tvg6lBab4tSgqlypGTNwoOp52jo88E7T8Yb4wKpn3PDh9L
	dBexdvJOZQSebbqXTqErPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788483807; x=
	1788570207; bh=OYc1vmReCtFOHupIgSe3dQS8VLIc/GeG1VqIR2mGdyA=; b=u
	6c5tXD34lF0mhtnO/nnYTn2Tb2kx5hB+yd4dMXhT2ZPWf+jtg4VlIN73XwQop9pc
	axGCTQnnQWhV9e0xSDsaAHrdRbRTbZgHVastBR//nVQWP/pe50I7q5Kl/u5aj3lC
	MKew4p7sdmhWt1yV6Q393QCHm+T2TuOe+7HTdonULFgV84XYyQGzayBfKJmJubwL
	8Ixu12ZAIiGbacsZFWgb7tY0HMDPo+oPQeQrri3OGjX0uyVzFX8HhmHcxAqu7GgJ
	Wsp3Y0Tqv8qZQFbSwSLLUGGOpX45sYwyi8hBfpfWxMYtU85E1hbP1TJss7uggZml
	8d2ssN3H7UThzHury8w6g==
X-ME-Sender: <xms:3Biaaoc-o5tYvfrBH0saqR7BhKsZagdvBn7vrFyLWdrxvam13BRkdwQ>
    <xme:3BiaalC9sYCGNLmbWBvlb4tBywADUG8SAysh6tp2mQAgGHlyWG5Ungp9njZXsHs8N
    p26i95RewFazbs5WoSZ3ZZ4uE6NsyKLZzLjuoXTO0FQ3HVl1jnMIg>
X-ME-Proxy-Cause: dmFkZTFaTTY7gys6ccKPX+GoVEtYBXkBKjIgrzrIVePx0ydCaj2TVh4csximm4AThA0VTu
    MrRxYralRdmg5sAV8CNaxk7l7D/A8EouqAJu42DieIiecrwu1MltBnV9Wk2xE3Ph/n4cea
    Q8BzIVw+qB24iZz2K2ImYpF2XVF1l6fKqSVwLgKUU7Bc98MWFHbm/5/2PLviMlZFBNlyFM
    bG/kUT87BJNO9074nNGOkVpPRKRPMLjZ6PVuAkb0xcB+5u51FMcD8NHM6/t4zjCz3m0pR2
    wum6hF44YUmJDP8wHQF/lEA+ECVaaIu9eUsbnqbicOZfg+RB628FzMLSar5YPcPa8uVUB7
    7MQbOwrYIj2CsdbG7yTpY3XmVoI1YiI7GlJZeGOeB6EFgQWQk9O/D682vdKQ24Ih8/zO7q
    RpaWsPXmS7anUuGQahFGnGiYsDOevVXyzG/WYmblA2tOsVD0GeLSp9wAYFnJQsHevasC1L
    8XtOl440S7Ms4dgsnd/fNNRwhushxHvGZbyfcrGM6AtjD4jS538RgIfoidcQnFwhBdW1lX
    X8bSyzr6PmkjZqAsELmCBtT8tnTGGhk/IXPxXlNl+sSGQLj/s4Fx+HjwbJNIDK0aJ3FFVk
    iqV7EFsyJfpI66GcHR71qNbsY+njDwhxP9vjVihmyMNETP+vpTtKsvuCq3iw
X-ME-Proxy: <xmx:3RiaamaBPlCGpbqreL9yygNd3HGa0Tc1uY44f-HuHVWUail7ABFj4Q>
    <xmx:3RiaahJAsfmOG3C-Q7xxceZFLNG_51hxELr7ugmvMIAcFXqj8_vPfw>
    <xmx:3RiaakDvAafJGFdiD2n4tDl_2Wv8YbgxWdcjivow17WTzAr7v154_w>
    <xmx:3RiaamrfV_J_WLPZ495YNwYz96M1i4OSF39ymJQZbTtfUa1-r1vfrw>
    <xmx:3xiaarV1plhylKs4rjCG6Sr9hAn9H_Oao8ZMGKtIfg_85QMl4cF1idWZ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2FB9922C007D; Thu,  3 Sep 2026 21:03:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 04 Sep 2026 03:03:03 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Aleksei Sviridkin" <f@lex.la>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>
Message-Id: <642a1c7c-e159-41db-a3ae-19ea8ed300b7@app.fastmail.com>
In-Reply-To: <20260903200015.36849-1-f@lex.la>
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g>
 <20260903200015.36849-1-f@lex.la>
Subject: Re: [PATCH] push: fix --force-if-includes when remote-tracking ref has no
 reflog
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026, at 22:00, Aleksei Sviridkin wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> your sign-off must be the last line in the trailers.
>
> I took Assisted-by from the kernel, which asks for it. I could not find
> anything either way in git's guidelines, so I followed the kernel.=20

If there is no mention of it in the guidelines
the fallback guideline becomes the one for
an operating system kernel? =E2=80=99,:|

Maybe you saw the few ones that have landed
in the last months in this project. But those don't
follow the recent Linux workflow change to just
=E2=80=9CLLM=E2=80=9D.

> I will
> put the sign-off last in v2, and drop Assisted-by if you would rather =
not
> have it.
