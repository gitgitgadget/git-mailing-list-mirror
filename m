Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398871;
	b=WsFkufzAd9u0z7LaesOixxzxxTKNY0n4UtH5lVFCXH2dvLJeywV73I9rsPi/ybZjVu+c
	 TeoDOiaNTFKXaK+PfdYRkrqJMJCNty0JxK4bKuU3jbuD9m4emjzsTXJoWUqiNuujTDUbf
	 6UEBWTdeXDxYGUY6DR1xr9O15PmBqXHlbAL1Q3KjWxIlNDpzG9CaCmuzq0S6Vm/BIVQZG
	 HmepvfE1Mnw3BH2Y4XSxqc65zB84qxhhfmr5kLhMZD1elaejQ9HZgpbVt6D9DIlxvDRiO
	 l55XlEuWd92lP+1TNJCrmMCMHf4HUU6jIVXvlVqAFQ9Cej0clbclrY0GjUv+oIHmslQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398871;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Provags-ID:X-Spam-Flag:UI-OutboundReport:
	 Content-Transfer-Encoding;
	bh=G6lSglILtLyhe/Kyzl8c+UOGGDxG9XyhcesUBLhtBF0=;
	b=Ew3ZTdzoWO2oO5KLXwVfJH5si4JYPI1356+gu8iKrCg0PYi7X6JC9GcyoZOrhvwv2lpg
	 VpXlc+PC9IfQVmC2gOyrtHRKYJ0hb36qyUpfzMp+4nEQ2zSg3+G2DkHYgWKl3rcAOzavS
	 p185EgdbHAtG/kXc2SEdouevVT8U+9GVfkuGelc2YMrAF6SISf8R9ZbpHZFT6lG5Imeik
	 BoO3/IYEzo4LeUhudPaxvNZDIWh/M/b3JiwRlYW6EKSoeHsjYlF2EzXLkKUFxI2gJCHzw
	 s3HfahaEFQJFqqvM4DBFzJVOF4XH7zogWc1G9p4J17CgY09Lcv3oRyubAXmHUK8lbwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=nB0zuao2;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5427606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 12:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5427606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=nB0zuao2
DKIM2-Signature:  i=1; m=1; t=1794398868;
 mf=PG9zd2FsZC5idWRkZW5oYWdlbkBnbXguZGU+;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:Wdp43bglMFvVmoYA/+epucpEPgno
   ZvJTJ2RYCwVZ64QOMwPGixLmODnbRmFeDPKWJlKaawvNn0OuNUOZVlsGimn7NWXHC237JjvXEg5
   6iXPOt5w2U+1s269oYsLIgEbstdd3Sx3Pl+0BWenq5MW9cgmJeN5y6aRK/FT03zq5a2i/5RSXCx
   cTiZko41yMkg4sR/52KSXWbWqV9LyvLs39lx41oWB4OQzBbyAuxuFrMSE7SVqpXU0PeGqWNU7yg
   4q2HB+OvibwZBRfcIWGDbsgwmSCHSmoXvAZudkO6ELNCMBK3EMq+nRlnvCRUuD5yxG/RlZIUGUc
   RP8El+pPSEEjSA==;
Message-Instance:  m=1;
 h=sha256:
   uTTY0sd81xXuFaGuHaKcUBWIHGMo7IKEG7sjuPiRj4Y=:
   G6lSglILtLyhe/Kyzl8c+UOGGDxG9XyhcesUBLhtBF0=,
  sha512:
   6FN6p3vL7NjPud0q+dBBpEDMIu2XV4q2+D+i5e/AZIoPu1+S117Yh6yCDv4KkmnNXspR0LdeWAOsSwLZBh6dwA==:
   GoVMIwo05J5QilYbru0k/w4kKLm1Cp8C3HOBH9ELQe0R1jlaQVMMd+saLrvYb+TlwFYiOd3cuU6yfw9sGtAIkQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794398868; x=1795003668;
	i=oswald.buddenhagen@gmx.de;
	bh=G6lSglILtLyhe/Kyzl8c+UOGGDxG9XyhcesUBLhtBF0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nB0zuao2UXFidYA2uWj3EjckSa9cOqnC47r/CusnuX/XRqYdMTGeNonTyDB6peJW
	 AoAHtsUsn05Tsb+h+nCwlRW3Ei0uwxv4IxP47ouoQevRMeKd4k+lVqqnY6561PsTj
	 zF2uiefMDS2cAAus9AypbRK+3CgywcQ2TS4wFW0rz/vpJ1a8QekBiPEB2rTgY/DJL
	 Fl4u7w7s+DyL3YtZQc+MixQVsGWQFHU7G43fHjmiAGksIGJPRz8nd/Vu9Gp9cZ6P3
	 l2txC4be9OefobYLbMila3pRPgYfqqRGllATi2zNs8caBPL9e0ga8EOGB2klrgc2S
	 6Kx/EK1cn61ZCwNCzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Udt-1xPAEv28Ov-009zLO; Wed, 11
 Nov 2026 13:07:48 +0100
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1xR77D-iF9-00; Wed, 11 Nov 2026 13:07:47 +0100
Date: Wed, 11 Nov 2026 13:07:47 +0100
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristofer Karlsson <krka@spotify.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] describe: count the distance correctly when commit dates
 are skewed
Message-ID: <avRakxssSCm1qQ4B@ugly.lan>
References: <20261031065525.19883-2-torvalds@kernel.org>
 <auiGP4XhObUzC9vD@pks.im>
 <CAHk-=wijLfduoJyOM+AW6FS6c02cuEFRAuQWLE+uf7SGhj8jXA@mail.gmail.com>
 <aumKXUS7_x0i7ZU1@pks.im>
 <xmqq5wyd4epv.fsf@gitster.g>
 <CAL71e4PqEQkGoont3tL5wJWd1_itsaaxfX+DOkLj64x-S7xR1A@mail.gmail.com>
 <xmqqv76c1mwb.fsf@gitster.g>
 <CAHk-=wj-5hp+FZBAqryzTwJ8DKvuNHub2e0kUG3g_+7borFfEQ@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wj-5hp+FZBAqryzTwJ8DKvuNHub2e0kUG3g_+7borFfEQ@mail.gmail.com>
X-Provags-ID: V03:K1:gFe5HMIxUXdpI44K4wdHgf9KEt2Oqr2zV3cQsNz21QZzU8lwoHO
 SoaVgxQ/40ikmAP+xB6jJe9XlmKCV+GwKeqWqh7RVVs3g5UCC86o1UdJs/FCWZQqc3hQh2K
 7NM13iRxZZhUcmMZMnF97G1tBxoeM6kh79EURsP6uavBrlnWSfzSQCdZiDKqNeT/YrvUHv0
 XsYQSmGT21+Nn2o8autwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ue43Zq3n0p0=;RPhf5XvWSVbwQEYcKrKoYLE/ZQ1
 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
 c+uuIMxTlZ5gAErqnNoupw2r4DavbH3dXnvIQ==
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 10:29:27AM -0800, Linus Torvalds wrote:
>For the kernel, people figured out what the issue is: it's not clock
>skew, it's intentional bad behavior by the gitlab Marge-bot merge
>logic.
>[...]
>Don't ask me what complete insanity caused somebody to think that
>keeping the committer name and email should mean that you should also
>lie about the commit *date*.
>
dude! you forgot the "content warning: asbestos underwear required"=20
disclaimer ... ;-)

anyway, i suspect that nobody actually thought about this at all, and=20
it's simply a result of the default view of committer/-date (and=20
author/-date) as pseudo-atomic entities. of course, closer consideration=
=20
reveals this to be a not necessarily helpful view, see also [1].

[1] https://lore.kernel.org/all/CAP9es6tyaGwfTguz5zgBmE5xN7MLDN3-rxRfo_JJB=
f79RCNzgg@mail.gmail.com/T/#u
