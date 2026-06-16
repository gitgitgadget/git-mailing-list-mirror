Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603937F8DB
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781640458; cv=none; b=QV/ygTD1TfmIYzBcs5wcKiPNtU8Az+d+Sbt1zEuYDdZL7ZjWrsEOys/d7cPzzwdcJ/foKnfgevZ7GbUJXEe5gfIpWAN5IgEoS6vKud/073ITm23jpz+QMuwahB/TLebxrEZm+Y2uOd/lOTUUzyJ+enjSCamUO9jZ1QNqgJgZ7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781640458; c=relaxed/simple;
	bh=HbMl4EseU4XM+YGA/qUqGzNrisfZk2+4cqAw1p1baQI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qtDptLnzGGA93S9QRoexaZ0AsL824dTXyB1BwBHtAXrN4u+tY20Qq4f9At5Z/hRH1WpiA6w3rEbSPxZd4/y1CBPhy5FS/mYn858eXsfrfiYbcyODjbjM2hhxyMCvN1C0PfsE7+MO+mV1zok7Suh77JJ3e8PsydmsfzBJWj/isFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bJoZ4LrT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LKksMW/J; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bJoZ4LrT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LKksMW/J"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 35887140001F;
	Tue, 16 Jun 2026 16:07:36 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 16 Jun 2026 16:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781640456;
	 x=1781726856; bh=O2FwyoSWU7SttbYEPa54LPRHEIGxYVRgwibtIkxi4eg=; b=
	bJoZ4LrT9QvCf8FyvPPJIr0DRS7xYkiLLIYm4P43W9qJR9540bqLJG5Win9/NboT
	4xhKwgqWI4l/um7S5IesoYcnADV88AKu1GyJqOmsXTnJBEs10W1/Uik5RhONw4Zj
	WmVsC+SMrw5z31iXhMQYPLAhMksXqjMT7UMbvc8ZlOB4zG8deJz4s3Pw0EfeUNBC
	9IaWP5oixs2EePBqnbDVRU/m48XYlejISKSQi3lxDI36dERhfi/bx6S2ePxYD6NF
	yn741u4Nd1BC405cWAEPwgiXqMohTsAsfNsJ8zC8nSp2xOHgjXoGUlRTIPV3GSpn
	BCz6STDPq5mLI2AbsxKg7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781640456; x=
	1781726856; bh=O2FwyoSWU7SttbYEPa54LPRHEIGxYVRgwibtIkxi4eg=; b=L
	KksMW/JkbkvmPi/gBFOQNF+AV2qkdWpKSvt8mRfNuLt1sCeQXPEVfpZp6Fhhn/Y5
	UWx9K7N2dJp4tKHhZiPIbQbD/cjgJoHiZyijiB6x4z+iJkh0LnY4QddbP41NtClK
	ONWfIY6yy6zVgxN9WMMnQPZ8SfDh/KcXduq9XDC/dtIp3KQpkXhT9ahf5QyKb6ta
	WIE2BgWhd/fMy2/GA1FliSO2x+/++KLP9zbrkfWmZGIrt8disFqIn0fWZ8wMF2XW
	7dAL3ORN3gbr69Ol5xlBSOdoeYiKT+uEIur0yjZXuNaghw2WYXxJWlRXU9jiTcKJ
	5nI1M1qwtZD2820dUdR9Q==
X-ME-Sender: <xms:CK0xaisY1Ppdk7V9AW9fYeeTY3WlIb1PNXQ3XlYIjiqeGAcuUNDjgg8>
    <xme:CK0xaiTAN8epYbHpCV5ZSSyqslM3tC0fAL2_6JEo0UZ2bkItGvbBZSRTeJTI5RDum
    HWXlscj3kWqWZ5Ntym70WGElwIafvDvO8GnCiN8B9qwGCLTKo6c>
X-ME-Proxy-Cause: dmFkZTEs/CuZAs+heX4/z/7xzcvb7YAYK+i+StvwVJcgDY5sKNmIklssrUnLNS6SiKc5Xi
    RTh2gVNvFi48FEiMw0L6YDx9cM7KkOwitBVujBETVjQuSmXipmQb3KjHQuJEzRc1STHrBw
    S6Hy41il/aJcUelS/0ulAKWDsxLkzxio/dSKX0yhN8ie9IQ4oPzZsneKAjEDBh5c5U9FAz
    I0OqUpMnMhtefCzLxMUt5cRD5ozmCePLUNOkVI3qBlH6bf1bcQz/pELvXdYo9nvbDRr4jC
    CQGFbDVPjql9kXwn2itOR/96G11jn+vimMppkIKGhR7cfpeNF2w7DDl1Tt073yEJ9WkMqF
    U8vAEbPPVSofKT3uCS0HhBtEB8LuQ1ickmrBvpGjG+tFvXmNzlRWZIp3En80IHCMOZ9fXw
    BRvm9/A2QKIvOvZVvkpYvPcRtCaLbNkhe7CrvEgmx9F4Ge7RBoyEoAhnw7y0bzyiT7zS5y
    pU4TVRg1qp8fzqRAKx7fN5seRauir2Nhhng6CVyA0yyeiqkfuMuqbCGmtnX8OAix1TWb0g
    fzhFA8JcEwG1vxxskKo+n6AQ6v+3Cf+1hEh5NkCKFr0eVwwgtXAOfewyMMxhAJhxMpLZmw
    TB06XxEcQDuK2UabNJ95h5Iu3zGHyRUTZN2IKf11CFSVzafBtnzikxo0aLEw
X-ME-Proxy: <xmx:CK0xahbg0GYHf5BQ_EpSPwcBssB2Jjk2nIKxGfB2n_z5FwGradbOVQ>
    <xmx:CK0xamV2ZUA-Kyq3FWnsyd0P_G9uMltps86XVhbXRk0GcYm3Rtw8ow>
    <xmx:CK0xarikdDhwoz6Ax3nv7pWHjCT5KBjYH0YFBz6YAC66oaPGpyeg_w>
    <xmx:CK0xasVd39yCXBMjhBJ28-ihR2a0QZ_Ga44gleefRM6nQVYqpSY7jg>
    <xmx:CK0xakBLTMkV8RYDFxYru4jslLc8N-HhjEWKu6FmCFMR0kptHjExivhN>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 07FC63021A93; Tue, 16 Jun 2026 16:07:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Au3Tfrf2ssUs
Date: Tue, 16 Jun 2026 22:07:15 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <e0bd8fb9-d34e-43d4-b3e0-f2a4b8d6a7a8@app.fastmail.com>
In-Reply-To: <xmqqse6tnho1.fsf@gitster.g>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
 <Based-on-patch-by.8f7@msgid.xyz> <xmqqse6tnho1.fsf@gitster.g>
Subject: Re: [PATCH 4/6] SubmittingPatches: document Based-on-patch-by trailer
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, at 18:52, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> +. `Based-on-patch-by:` can be used when someone else authored parts =
of
>> +  the patch that you are submitting. This might be relevant if someo=
ne
>> +  sent a patch to the mailing list without a commit message or a
>> +  `Signed-off-by:` and you have picked it up.
>
> Hmph, this seems to encourage pick up material that come outside of
> the usual DCO process, which should not be the intention of this
> document.

Oh, I have misread the room on this subject. It would be better to drop
the mention of signoff here.

>
> Unless the changes are trivial enough to not be copyrightable, it
> may be better to say "... if someone submitted a preliminary patch or
> a detailed code snippet with their sign-off", plus encourage asking
> the original author to sign-off if it initially came without, or
> something like that?

Okay, since they provided something concrete to copy (cf. Helped-by
where they did not provide precise changes in patch form, according to
the below context), it=E2=80=99s best to mention that signoff is relevan=
t here.

>
>>  . `Helped-by:` is used to credit someone who suggested ideas for
>>    changes without providing the precise changes in patch form.
>>  . `Mentored-by:` is used to credit someone with helping develop a
