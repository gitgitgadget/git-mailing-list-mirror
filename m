Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030195;
	b=kA6WpE82yt1zYXViwrIX8vPjZEzeNaAa2b3maomc64DRCMKSgJdt4EDPeK66Mj9WDomf
	 AM5hMylj97dFjkr1vMsayhKbrbr/67/k6MgQd5q+KvNWkDOmy0wdBDP+cZu5q5k96c9WD
	 JOOmpR7aXTPDCz2brfvvzWGMRkXN+ONzvGcUbip7Ux/fcMFNkA5kHnm/kkUqaxm637Z9h
	 lzMjQxZyNPIGojL6jZccbegMIXHcKhLIMILYwY+eAsavuztoWDLlGo50+dTQgxWU6L1I9
	 Wt2PtWYJZ8Cm7s1O9Ng6S7aoq6M4HOBD8aJWjIL8I0xAf4m/9QMsANRW2drQDAoezmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030195;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=DqiEdPSC6Sc8U5jHiTx5Ct/3outo9353845eVdvTjeE=;
	b=SQkBF/dVXxXvoIRu8CKBtCTlZtwsFnb22B+YL3pFFsadHA8DBXnDKHCDwGasdXCInJYq
	 nPa9U5aO0PQZonjgAI0uwTntANltB/6JmbGh/SB/II7/MW46bTtNl/L3u+mzhXlmmHLDH
	 sgektn57iWy0SCAnyBg8YviOWSbqFuaPZQx2vzZ1a6lsk+qRQjLTOY5oOstYsJcvDrIAv
	 MS70oevW5N8tfMX4BkOVHIJtOm4wIVAykto0wdm9ZpRpdcYJnr3Nzk+3UVePWISj+HkNn
	 D9YiPjN0uiwQpovC5pBF4uFnrwXToCeghZtTVJqbzE67lq1GiYG3IgWc3gPMBElV0+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=qgNWeVve;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF99606A32C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 19:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFF99606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=qgNWeVve
Received: from localhost (ip-109-41-49-52.web.vodafone.de [109.41.49.52])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AIJTlE11924439
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 18 Nov 2026 20:29:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1795030188; bh=DqiEdPSC6Sc8U5jHiTx5Ct/3outo9353845eVdvTjeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=qgNWeVveaAn3bMJ7sX2d96DyG9hXA76P/cSunnUxBTL3rAsPKhYuIWhQqMjjTKZVD
	 8Ul9qymJfQD/lCe0mIiAgTDqIz4ARr8XpI2ouG9roG0k7OlNSJ1Gi/Wk9dbUgDZEq8
	 l83b2pGWxlpVy0vEG1OCIMlCawInUfbCT/0j9FtQ=
From: Dirk Gouders <dirk@gouders.net>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <CAHWeT-ZjZHFE1BhRSwv6cvK4=rk0ZXNak8uG1y75Pgy+vNVQdQ@mail.gmail.com>
References: <xmqqmrr7fllq.fsf@gitster.g> <xmqqqzgjcjes.fsf@gitster.g>
	<CAHWeT-Zt=1MjD=fbOiAiQtb28Q4DAR_wF12iymXmeXzGyyLgbQ@mail.gmail.com>
	<xmqq33szavmy.fsf@gitster.g>
	<CAHWeT-ZcOqm9PXzM5W18+ktJ4gBdPNyx+g_2ZCaW25ufKH4g5A@mail.gmail.com>
	<ghwlqak2j9.fsf@gouders.net>
	<CAHWeT-Yh8yTnG7rLjvO+XBtU=bZHJ3WWoQQsPfvJO013P2GSPA@mail.gmail.com>
	<ghik1uassi.fsf@gouders.net>
	<CAHWeT-ZjZHFE1BhRSwv6cvK4=rk0ZXNak8uG1y75Pgy+vNVQdQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 18 Nov 2026 20:29:47 +0100
Message-ID: <ghecciaqfo.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 18 2026, Andy Koppe wrote:

> Dirk Gouders wrote:
>>
>> On Wed, Nov 18 2026, Andy Koppe wrote:
>
>> >> And as far as I know, we would need an FSM to identify valid sequences
>> >> if we are going to allow colons.
>>
>> > No. The parameter field can be any mix of digits, colons and
>> > semicolons.  Semicolons separate parameters, colons separate
>> > subparameters, and individual (sub)parameters can be empty, which is
>> > equivalent to zero. If the field consists of nothing but colons,
>> > that's one parameter with multiple empty subparameters.
>>
>> My statement was a bit misleading, because
>> display_mode_esc_sequence_len() already is an FSM
>> accepting the language "\033\[[0-9;]+m".  My concern was that I doubt
>> that simply adding ":" to the alphabet and as valid input to the state
>> "parameter"  (without introducing one or more new states) would still
>> let it accept only valid SGR sequences.
>
> "\033\[[0-9:;]*m" is the complete regex for SGRs. (Of course, it's not
> that simple if you wanted to actually collect the (sub)parameter
> values, but git doesn't need to.)
>
>> It seems I can learn something: is "\033[:;m" a valid SGR sequence?
>
> Yep. That's two parameters, with the first one consisting of two empty
> subparameters, and the second one an empty parameter.

OK, I didn't know that, thank you.

>> But, such a discussion is difficult without defining what language you
>> want to accept.  I guess the two links were meant as a definition and I
>> have to confess I didn't yet read them.
>
> To be fair, ECMA-48 isn't the most readable, but once you realise that
> 3/0 stands for 0x30 (aka '0') and 3/11 for 0x3B (aka ';'), it's not
> too bad.

That notation is fine for me, I will definitely read that document.

Regards,

Dirk
