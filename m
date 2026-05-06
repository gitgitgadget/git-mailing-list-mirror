Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130583F0A9E
	for <git@vger.kernel.org>; Wed,  6 May 2026 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083223; cv=none; b=EO8ZSQ9VE6JigztDhBDi5CEG9qtpiMikC0SfG0TFVF2IU+ZqYEP6PMw+yDsSDcWsHtnMx+M/6akwXZblVygr9kBw+Eu0uLQwR8+ZBaLoleftBpEqHvN8G2EtJe8KrflkyZBXKNyGrcoNoUa0nqoa4FKjNUU70mxwOhLJEK1Mpw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083223; c=relaxed/simple;
	bh=uFNiv6iFhJjjpKWm268E/2j4kygHiW4SKPbqhdsKZSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1Fm915MqSC0Mr5ED2DZtnDi8Y9nRHeI9q7cvXO7GJ7zNPRNItuomfZJ5D8aIwtRb/oOuObtQHZVRYbnEpOF0Si6XZJE7mQvBDn63P8kMuM2hdVfnhzq20iaTqIWfy6P/GVDSiUm9cFBQ6WMoTgNP3yZKZrdyjaW7nMcUqNuWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=MzWzuMp+; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="MzWzuMp+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778083205; x=1778688005; i=l.s.r@web.de;
	bh=ZTwo49VHp91RDBOq/FDIbGHx/raTywJ8gsvUPTw8e/c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MzWzuMp+l7Nn+o515VhFiHD34LDg+TrLZznlYOhXwG5foILjcJqokXznVWlnFYko
	 tNgjcdIyhjML+p3fmi6UG8J5YfRLCTNBT98mVj2IBM5fnfFI2v77eADAQW1bk+2Ye
	 LP4VvGaFWPlL1B2MPtxqwLEufUxdMJjoZYnUkAENEzwSEDEOllTtXq4azKkIUYBrN
	 2NrwA5OIY4cloTiVk3jhS233iVQlvlWhK4DvXbzBxLLMERlZzu7QC/0R0mzo3W9Ty
	 /xhe6lgK6veVSD/ROgvKI5UGs8DcWiJMGylOCwJUjdnTAlQ0x7Pm+JdCyZD9Hl7wN
	 Jgv6ydK3Ybv0tLG/7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2BM4-1vJRwQ3xwE-00wDm1; Wed, 06
 May 2026 18:00:05 +0200
Message-ID: <4d8aa86f-160a-4f01-beaf-e3f011f875cf@web.de>
Date: Wed, 6 May 2026 18:00:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git trims the last character of content from remotes
To: Mikael Magnusson <mikachu@gmail.com>
Cc: Chris Torek <chris.torek@gmail.com>,
 Hugo Osvaldo Barrera <hugo@whynothugo.nl>, git@vger.kernel.org
References: <2d3f5504-f5dd-4171-96e8-b5633b6a1f5e@app.fastmail.com>
 <CAPx1Gvf5Vts3oS2BdFQ4PpCR-UY=5cYW7fgOkRuQpi8ug2JXDg@mail.gmail.com>
 <3364c573-b7f4-4ec0-b471-312aa11028fe@web.de>
 <CAHYJk3Q6xjW8mBvbQkN3vsDb2e9Em6PuDinFoTFwqkTXaKK=rQ@mail.gmail.com>
 <CAHYJk3SW-JwWwk2h=vfDQ4udwQoW2TrmcntiPVwjUJSGiLU2wQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAHYJk3SW-JwWwk2h=vfDQ4udwQoW2TrmcntiPVwjUJSGiLU2wQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Eq3PpoY/3DrqhDJSusfL0i7fQddAobpHjkw0Kd6BRiw1qWPAGjI
 RM+NZP0TFOcRTLL3T2/diQdtVDfzsiHn/y/zBFFyz9h2D1RRGWJ0818fiRYk5UzUPDaiDaJ
 oWbRGH9lEQK1fGVuzXVod9OLDSINx9XFDFdufHabhMxWwcfiQRmI2L2/Euc0nBKU/CTKtB1
 V0D6IeTRzpppaAHbimwuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LgjXoKgpBfQ=;8c8NWGqfGxZER0yvOwj/M6jvIel
 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
 7znIKVrcJxIStNAssD7MyZeoFHkogI2K2TwE=

On 5/6/26 11:40 AM, Mikael Magnusson wrote:
> On Wed, May 6, 2026 at 11:37=E2=80=AFAM Mikael Magnusson <mikachu@gmail.=
com> wrote:
>>
>> On Tue, May 5, 2026 at 9:46=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de>=
 wrote:
>>>
>>> On 5/5/26 2:34 AM, Chris Torek wrote:
>>>> On Mon, May 4, 2026 at 10:02=E2=80=AFAM Hugo Osvaldo Barrera <hugo@wh=
ynothugo.nl> wrote:
>>>> [snippage]
>>>>> When the width of a whole line is the same as my terminal width ...
>>>> [snippage]
>>>>> ... sideband.c prints ANSI_SUFFIX =3D "\033[K", this escape
>>>>> sequence being "clear the line from the current position until the e=
nd of the
>>>>> line", and this is the root cause of the issue.
>>>
>>>> If you have a non-empty prefix
>>>> string before this "clear to end of line" suffix, the solution is mor=
e
>>>> obvious: print the ESC [ K as a *prefix* rather than a suffix, but
>>>> that fails with the empty prefix.
>>> We do have a non-empty prefix, but why would it be necessary?  What's
>>> wrong with clearing the full line starting from column 1?
>>>
>>> Anyway, do you mean something like this?
>>
>> If the purpose of the clear is to reset the background color on
>> wrapped lines, this will not have any effect, since you clear before
>> the new line is wrapped in. (This is a bit of an obscure edge case, if
>> you set the background color, and wrap the line, the entire new line
>> will be scrolled in with the active background color, then you write
>> perhaps 10 more characters and send the sequence to reset the
>> background color, but the entire rest of the line is still brown, or
>> whatever it was set to when you wrapped).
>>
>> Example command to reproduce locally,
>> % echo -e '\e[43maaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\e[0mhihi'
>> (Add more aaaaaaa if necessary so that the line breaks before they end)=
.
>=20
> Sorry for the double post, but I forgot an important thing, this only
> happens if you *actually* scroll in a new line, ie if you open a new
> terminal and run this, you won't see any problems until you get to the
> bottom of the screen.
The purpose of clearing here is to avoid leaving local progress line
remnants after the remote line.  Original discussion:
https://lore.kernel.org/git/alpine.LFD.0.9999.0711032328490.21255@xanadu.h=
ome/

You're right that erasing before filling the whole line and then some
is unnecessary.  But it wouldn't hurt, either, no?

Ren=C3=A9

