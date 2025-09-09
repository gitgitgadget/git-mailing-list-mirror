Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9CB1F30A4
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404955; cv=none; b=JgB5QlqRS/bLuDqa7jrjS7lYpWM2AKfXsKSj8joqtk+wYoBaIUft8lBRrgGV8coh3z7aSqd7k04Mc3VzQGu9MQ6YhkmwdRd5HoH8pR8pvr9zsmX7o33NRaaW9l5Om1ow6DGbpufA/P+8mLbWXLQq+2dtxgYmCCMdUXJd1mQefco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404955; c=relaxed/simple;
	bh=E+idWqXryWKIXmpICOvbcQfAir8fbFSJL9ssU/MnCIk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PiblsxEtNmVmnkdZRakd8huOHnw/8nsNtISp5e6p0NM2APZP6oXLFuMw+TBu9gKViYjdf53n0Ac6ot72SycVTmhQCGobdEWd02ClIvvVE2eqg2HVqjQ5R3r1UsGiFVp350go3pPiijRdL1q5eyhmR9Cio/gJ4QTvvHkqc/KSz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=Ec0oBvvp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UQghQfYg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="Ec0oBvvp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQghQfYg"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E87414000F1;
	Tue,  9 Sep 2025 04:02:32 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 09 Sep 2025 04:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1757404952; x=1757491352; bh=/2dr5oJO96mE5MPYHFq/NMGz+3pkTCT8
	gmFO9cl9cVw=; b=Ec0oBvvpXBJMhicqweS4ywXv5M1gk8ZyonSpDuWnny3TCEFh
	iTDnp1sOecLVxxt9HcEQfcrGgEyUdIRgpu0Pvuzp2tfeC4t1Sm46vChc7WJ2lFGe
	OIwvKCAJnS8CUoAWxDHDL648mPa+xirvZ/yMuGiONO9l1Gs/FAPVre1S91R7/4jc
	Kt/gOaTxKzbV5hSjsjybh/W/be2VySwPJi8Gn8chKjq2d4ujLfjTYovfFp8K5xDq
	5KB8ICh42bcz+YaRiU4Raj2bVaPp7DNCEO4ficVS4Rrj+Z5132qTUorIMLICS/Ag
	puJY8/ZRW09sWCYk7ewnlPuJZqNTxKKAdd+l3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757404952; x=
	1757491352; bh=/2dr5oJO96mE5MPYHFq/NMGz+3pkTCT8gmFO9cl9cVw=; b=U
	QghQfYgfImQFd7xR7OzL3xVW9qkrbwUVIF0xn7pYQX6CYHhNQymsv8Kg3m8Ooewc
	YUwLg3DgwjAyp+sNuhSltpPvyWlKj9tElzCUtE1cRBaKYOa9JWIJBYb2y6FUII/G
	ABdV0k2iJQFbLoAXQlTYybmGph5vwYl1wm5k5COhco32C+Z4oqSiNUan68jyZE+3
	vzeujT9m9uY5dARccyVlXZVfsO3T7AUdsCNQjvq0950QGe60eKDMeBvXADYU1xr/
	vp6rOQ8B8dBX45gPI+Yi11e70VHCeJlbVOL45dfMLPIYHQM0Z1/v4ipS3cJNjs56
	qrhj3ULPDS0TlSU9gIztw==
X-ME-Sender: <xms:GN-_aILpgmZ9G2gHFtafaQX1Vcn7OwKbinMdXeCWHf4R5XuAiix5yxE>
    <xme:GN-_aIJUVotNUa7_DnfJMy2SDUSUR1gx5x8rY2idjgzgUZ9GWHA6IZ2tqM3XJVrtm
    w0aR3Ds9hKbro8SLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeefteeghfegfeevleeguddvkeetheeiveffudej
    lefgudffffejleffffeludekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GN-_aDKjgypTxfbDRg1GLhDuP7xxaECfbbSE8icvxJlBixQfgpTYHw>
    <xmx:GN-_aEQl2WHTgXboJPbFa8CTFho5s5DjvprdzTe7Og8yNJGa_fYU1Q>
    <xmx:GN-_aKtPnBc1G4yFuVMNG-u5Cld5qskeGm6HTSKFoOpMM-bJctZHpA>
    <xmx:GN-_aNbV_o52a2i8Mjhd86FldjVB1VZaF1woQfJwatQUZeDifJMxdQ>
    <xmx:GN-_aMQWZfCMPFdLI8lMisob_U8mSOOOW3daHdZK_cR2NwWpAmlGUaSb>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 35B031EA0068; Tue,  9 Sep 2025 04:02:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAEK-xvrxHXR
Date: Tue, 09 Sep 2025 10:02:11 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Patrick Steinhardt" <ps@pks.im>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Eric Sunshine" <sunshine@sunshineco.com>,
 "Jeff King" <peff@peff.net>
Message-Id: <a56d716f-8598-46d0-9b63-8d44b482e1e4@app.fastmail.com>
In-Reply-To: <aL_MdiBLx9sssBwc@pks.im>
References: <cover.1756480827.git.code@khaugsbakk.name>
 <cover.1757345711.git.code@khaugsbakk.name>
 <bdc683a92b38884e9428cd4bade1f86960ef432b.1757345711.git.code@khaugsbakk.name>
 <aL_MdiBLx9sssBwc@pks.im>
Subject: Re: [PATCH v3 1/8] git: add `deprecated` category to --list-cmds
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025, at 08:43, Patrick Steinhardt wrote:
> On Mon, Sep 08, 2025 at 05:36:12PM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>> Notes (series):
>>     v3 (new):
>>
>>     This is something I wanted to submit independently until the poin=
t about
>>     aliasing builtins was brought up.[1]  It will help (in a small wa=
y) with
>>     the upcoming patch =E2=80=9Cgit: allow alias-shadowing deprecated=
 builtins=E2=80=9D.
>>
>>     By the way: should `command-list.txt` be updated in some way (I d=
idn=E2=80=99t
>>     know what way?)
>
> I think it would be a good idea to introduce a new category for
> deprecated commands. After all, next to planning for the removal we
> should also actively discourage the use of such commands. But if they
> are still prominently featured in git(1) then people might be misled a=
nd
> use them, only to get a deprecation warning thrown at them.

Thanks.  I=E2=80=99ll add your Ack if that=E2=80=99s okay.

>>[snip]
>> +static void list_builtins(struct string_list *list, unsigned int inc=
lude_option, unsigned int exclude_option);
>
> Nit: let's wrap this overly long line.

I=E2=80=99ll do both of these, thanks.  In the same commit/patch I think.

>[snip]
> Same here.
>[snip]
>>  {
>> -	for (size_t i =3D 0; i < ARRAY_SIZE(commands); i++) {
>> -		if (exclude_option &&
>> -		    (commands[i].option & exclude_option))
>> -			continue;
>> -		string_list_append(out, commands[i].cmd);
>> +	if (include_option && exclude_option)
>> +		BUG("'include_option' and 'exclude_option' are mutually exclusive"=
);
>> +	if (include_option) {
>> +		for (size_t i =3D 0; i < ARRAY_SIZE(commands); i++)
>> +			if (commands[i].option & include_option)
>> +				string_list_append(out, commands[i].cmd);
>> +	} else {
>> +		for (size_t i =3D 0; i < ARRAY_SIZE(commands); i++) {
>> +			if (commands[i].option & exclude_option)
>> +				continue;
>> +			string_list_append(out, commands[i].cmd);
>> +		}
>>  	}
>>  }
>
> We could combine these two loops into one:
>
>     for (size_t i =3D 0; i < ARRAY_SIZE(commands); i++) {
>         if (include_option && !(commands[i].option & include_option))
>             continue;
>         if (exclude_option && (commands[i].option & exclude_option))
>             continue;
>         string_list_append(out, commands[i].cmd);
>     }
>
> Which results in a bit less code duplication.

That=E2=80=99s more elegant.  I=E2=80=99ll use that.  And I=E2=80=99ll r=
emove the function doc
now that it won=E2=80=99t be relevant.

Cheers

--=20
Kristoffer
