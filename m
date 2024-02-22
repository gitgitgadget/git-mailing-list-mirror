Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B21426D
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609014; cv=none; b=I72xT9TRDENt4XrhPzF4jXoci/BOj4sKV8mOD2QFBTe+QdzwKhBhwHvgYbcegzrj55SSqQN5CiN50PQzuyRdtGUKlnNz5qbn1LrmLwTDaavcPvloeMm6DGi6GzHPuApOO/83hh6dilHtubzhFP9qmkJCNOoIi6MoFHX7u45aPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609014; c=relaxed/simple;
	bh=vRVvJwNo8kawAHfl2Mr3tDhIm/7DIQ1KboSDy27WPBU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PNjXpWmuNnULdaYfOMCpaAFnragvnL4GW3UyPPsA5IFpBhOn04lwxpwIbfKNPwnWgWILTdAk/XX2OKj07JAjLdRJMhpP8QUdrvh50Q7AN3Ka+vNZ9ja+qGGoO6g76wwyYzaFQafK1MF/MqWcNohpYhq++inVhOClhoNByJZ1a1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=P6Har/RX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EtI7DyLD; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="P6Har/RX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EtI7DyLD"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 333A81C0007A;
	Thu, 22 Feb 2024 08:36:51 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 22 Feb 2024 08:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708609010; x=1708695410; bh=vRVvJwNo8kawAHfl2Mr3tDhIm/7DIQ1K
	boSDy27WPBU=; b=P6Har/RXSLjhT4PvTMHS/4wRWe2VXe25lwsfJxQ3bPst4oVk
	DgD2QKgDgpoCbre69gOfLzjxYd/xixs37UhxZv7YJMLJ1V+ulULP5pIBnH9ZAtz5
	RCiCtRwtsgD5eSn5zEQ9pMXjwyasxbqF7DrnlpTYWEpXz1wq6QzN3ShuXCJFUtdw
	xH9JlaJeDOWGKqQf4WsWee4NLNmCCvnzIl2+vI6RAZY6w+gMoKESYc3BtACFWv+K
	1uuAWlvlmbNOf4lGefvzftTTYycxi3z/f9mpqVKw8N6c4qRMUDMnzBRshlBkWZH2
	g9Vi/kNeYpeUKT4kF16jfk2A0jqfvUkkjN2XZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708609010; x=
	1708695410; bh=vRVvJwNo8kawAHfl2Mr3tDhIm/7DIQ1KboSDy27WPBU=; b=E
	tI7DyLDhtI2FEKQEA0rgFC/PBY4ji826ptHHpH3PQfyJl7O/9dNrWDWSGyBdcSk5
	Dz5X93OT7Z5GY/nK+fZbYUkz/bp9Em/jgio+4khVyQceOR/c53ZjeN03TEj6vJm3
	RCc4KAuIJZ5p1fOGHK6j9SoogWksfu3urScnP7TbrvtZJ5LHKIOnCF0HErMxUYAa
	VJwmEPPGyHcmE5zyE/m0HBDF/5wbRFPdy8NqLclp4PJhmIN8g/INHEQO2YkdELZn
	XHYd8ymh1wUp1bLen2299ycV4KIP3zyPtdTGAWT+PoIv9sW62Ra/580xJuE+qkuk
	bI/a24Kv6H02c7CX0Qa6w==
X-ME-Sender: <xms:8k3XZdz8n-gFDUXrl5jESvvrJYwcBFjL966D1uW3B6D0lAFPCp073OQ>
    <xme:8k3XZdRtEvQRn615--GeQxRHUuo5bqNslz6K1ut2WOge8gY2xqCcn3udskodcQkcy
    h3H3kHbMugQp7ETRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepueegvdejffefffeftdfgvdffgfevleej
    tdehjefgleeuheffleeuffeikeeutdfhnecuffhomhgrihhnpehgihhtfhhorhifihhnug
    hofihsrdhorhhgpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:8k3XZXWTVYkhquJEzaBI6WsJNlztTPS7V9Yo_18wb0HpLKtvWRO9FQ>
    <xmx:8k3XZfhSqgZ3bfflpxK0pCE1M2E0_umyrh7lEevySReLzsI-2Z31sQ>
    <xmx:8k3XZfDn86X52vSQrDpUTVDFjSfryucHjTzIqXwFcRb1pVeMB5zvmg>
    <xmx:8k3XZa-4yoIVBtYXv0OE1HA3YX-I17TuIDYSvNBkum5CoZOONxinJKLUp6c>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0877E15A0092; Thu, 22 Feb 2024 08:36:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2c563682-aa29-41ca-8fd9-3890edb7bceb@app.fastmail.com>
In-Reply-To: <7ddaadd4-cfa6-00b3-1aee-34f5c57f4e7a@gmx.de>
References: 
 <LV8PR13MB6560538530A2A7D1C1FD89C19C422@LV8PR13MB6560.namprd13.prod.outlook.com>
 <DB9P250MB06926B4A6997EF6F866296ADA54A2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
 <LV8PR13MB65609D60ACB8A6EADFBFE3459C4D2@LV8PR13MB6560.namprd13.prod.outlook.com>
 <20240216110041.dqz2n5dz43mqtq25@carbon>
 <7ddaadd4-cfa6-00b3-1aee-34f5c57f4e7a@gmx.de>
Date: Thu, 22 Feb 2024 14:35:52 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 "Konstantin Khomoutov" <kostix@bswap.ru>,
 "Christian Castro" <christian.castro@dlhcorp.com>,
 =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: Hello question on Git for Windows 2.43.0 - GUID and/or SWID tag for this
 title
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024, at 23:06, Johannes Schindelin wrote:
> Hi,
>
> On Fri, 16 Feb 2024, Konstantin Khomoutov wrote:
>
>> On Thu, Feb 15, 2024 at 09:40:47PM +0000, Christian Castro wrote:
>>
>> >>> I have a question on the GUID and/or SWID tag for Git for Windows=
 2.43.0.
>>
>> > Question: Are you a Git for Windows developer, open-source contribu=
tor or?
>> > I ask because I will contact the manufacturer of our inventory prod=
uct and
>> > provide them your feedback. But I'd like to know what your role is =
with Git
>> > for Windows for as of now I just have a reply from someone named Ma=
tthias
>> > from a live.de email domain. I hope you understand. Truly no offens=
e meant
>> > on my part.
>> >
>> > Therefore, please let me know what your role is with Git for Window=
s so I
>> > can send this feedback accordingly and continue working on with our=
 software
>> > inventory vendor on the issue.
>>
>> I would say the chief Git-for-Windows maintainer is Johannes Schindel=
in [1].
>
> It is: https://gitforwindows.org/governance-model.html
>
> Matthias A=C3=9Fhauer is a trusted Git for Windows contributor with wr=
ite
> permissions on the repositories, so what he says has a ton of weight.
>
> Ciao,
> Johannes

The CC to Christian Castro got lost in one of the replies. I=E2=80=99m j=
ust
adding it back.

Christian: here is the whole thread: https://lore.kernel.org/git/LV8PR13=
MB6560538530A2A7D1C1FD89C19C422@LV8PR13MB6560.namprd13.prod.outlook.com/

--=20
Kristoffer Haugsbakk

