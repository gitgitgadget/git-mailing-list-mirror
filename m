Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962535979
	for <git@vger.kernel.org>; Tue, 12 May 2026 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614343; cv=none; b=tAUY+lJrOOVTozIoU3tixpf26tu/e7qKcUYzpDqQtFs2lIu584MGoyo9cYqzxoqRWFVF+13NUHwomrnXX9BSq+31ZJAgMBE/y+loTvPR78iTfG/gGcz/urHc9jVPjZoqZG3a+s9U7tNWNGBzKHpbe0jcdHBBbVv8gsAoqyWe8Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614343; c=relaxed/simple;
	bh=vpLC5SzF6h8/EHtCCtdHrFcrjuwoVU59SwHYWchxMlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rB1HhDACc1xe3Y+DBQgOy8cmNRrQ2+RRS3ewp5DaQ+4ztA1ys0ISDtn+M35Vg/GwsLNHESS1RimANuFnIJtDPwPq25KrH2arwJEoyTZfe3IYvdu0ott1Wv00fRDA1hUPFEoV8qRPiTWCr1Gl9EKq85JGdpm1SnPHvxqFwd3W/ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=XJ0gsK5P; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XJ0gsK5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778614330; x=1779219130; i=l.s.r@web.de;
	bh=+1diBgJn0HLTNiVyF8R4SE834gs5LKChK0QNhXK0Eso=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XJ0gsK5PooVF7Dg8XKiveQFUyx35focmd4p0w+eM5hZsX7WuL66f70rdI6SAYMLr
	 t3lGHPRoHrLIAzRkr1N0a1rcvCrofFYtP/TBUERrQkagS7bRbTSYZo+iCW/+Kgmwo
	 Oc/cfsAm0HkIy75c/ca6TK1DU2GV9MpVPkE/deyKRd4HflYw+LZi/9CssbBlzpQOh
	 o3l+kOk/3e+ZoSIg2CeCxNcCwYJMEY+DSFDpQWcvEcjZL9fp65G0wGJYsqjc8qjS1
	 yBicFSwEQcCQhdnb1e2Ctc9kYLPQ523Uta/gN+u430Di88HQ/1P7vYnVgioqUQtgh
	 fLrPTtiTTrQqFo4qUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAcpg-1wXvRi29s0-003D3e; Tue, 12
 May 2026 21:32:10 +0200
Message-ID: <60b1ef2a-3b12-449e-be0b-cb206425c80c@web.de>
Date: Tue, 12 May 2026 21:32:09 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] strbuf: add strbuf_add_uint()
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <20260512115603.80780-1-l.s.r@web.de>
 <20260512115603.80780-2-l.s.r@web.de>
 <20260512184238.GC70851@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20260512184238.GC70851@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g+3h+mDcCJ6TDbYEFs/Vr4H+03JqI7SfxLt7yuxuKDezfuTEF+8
 h2AWPlvAX/4rUhxEKYNen56LA2PiELeKrEIw5rXmPQmsLmuBm4oU6QmgjIW9SDK3cMrbS+U
 llFft495FOtuVGLpDEqAoj6WpCjvDcCEOj2oAZ7uQ3SmShWh9u+9azkFf6OJ+KrUyie/9U0
 UmU07Sta1/2ui/1kdYN5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Mxhp8Yercz8=;H1gA57al/ERCqTmjGzm/tusJb5P
 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
 DTjJCJLimiqmz5NJbQNbY0Yl/OatLrawQ==

On 5/12/26 8:42 PM, Jeff King wrote:
> On Tue, May 12, 2026 at 01:56:00PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> Prepare the number string in a temporary buffer.  Make it big enough fo=
r
>> any unsigned integer value: A decimal digit can represent ln(10)/ln(2) =
=E2=89=88
>> 3.32 bits; dividing the number of bits of uintmax_t by 3.3 and rounding
>> up gives a sufficiently close conservative size estimate.
>=20
> Cute. The naive obvious question here is: why not just grow the strbuf
> and format it there directly?
>=20
> And the answer is that it's much easier to format numbers right-to-left,
> and then you know how many digits you need. ;)

Right.  Using the strbuf to format the number at the right end and
memmove()ing it in place is a valid approach.  I expected it to be
faster than using a buffer on the stack because there's a chance that
only one cache line needs to be touched.

> You can compute the number of digits needed up front, of course, but
> it's log-10. You might be able to do it quickly based on the size of the
> leading bit, but there are a lot of off-by-one gotchas.

That's the simplest approach and I expected the few necessary extra
divisions to be faster than using a buffer and having to copy the
result.

The three variants were close in my tests, the no-copy variant slightly
winning on Apple silicon, but losing slightly more on an AMD Ryzen
laptop CPU.  So I went with the solid choice of using an on-stack
buffer, same as in printf(3) (at least on BSD).  Buffering at the end of
the strbuf was not really faster; perhaps memmove(3) is just that much
slower than memcpy(3).

Perhaps an optimized decimal_width() could change the picture somewhat,
but I don't expect a big win.  On the other hand I just told you how
unreliable my expectations are, so there might be treasure after all. :)

Ren=C3=A9

