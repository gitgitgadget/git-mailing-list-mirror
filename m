Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C1D530
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728503591; cv=none; b=lxm1pOfERr/vBcv0enX2yZFpuji9kgnU9QW8qqNj504mEZf+/r/p2v+rA4lmZI6JacRTidxR1Fb8iMAHGkg0Q9EpMr9dxnrXD3uOAwUmAz8IcwSW4+TkGHZy5OF26iedPiGL/DgB+tsUJHZyBVooMsmR5wKT7JdnjSb1cNXhb8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728503591; c=relaxed/simple;
	bh=k6JKnbK+DkLqJ+xlbyaL5sfVEkc+5CKVBP/B/MWAr20=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=e5HPJvH/c2APkTi9RuZZ5weRx9sUHligiPlI98z9D1kvvwZI4JB5ikqO7sUSWicKo1gsBdF2X1QiakpLY4vReSSelNpM+Yl+5svViy+Fj3oom88qbLJ4oVfL+6q4svGqk5bpXYxUmPJFg4AwkSPwYsOZboEtjI82Snf98Sy1P70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=JvojGpXr; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="JvojGpXr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=WzEoapwhFU2S9O+wyfb/PRla4TIQGBOY/K8K3CDGvW4=;
 b=JvojGpXrCWlR6VyIWPZy5Sf9hHL7apeL93XGhikPA5VPv84A5g2SYXbEiVmlH5sruFc4p6/PBF40
   ppWQemyeoOzHI47jLP8q78YU0TDmzJnMOGvOL2EZNBCUYdhlO+5qavYikyY5DUosNUxcvFFxDzok
   XBqNjFqWW/BjHWGYbGZIX5pTweoWhmM6ks1z0s5ldLz/zkeP3Wf2w1aqH3/NoTWb/ZGm9BXyYQAO
   9ynYdSf9NIWk+KL1JH6Gm2b9Nm354QWGJ8IG4l0UJFSNW81d3e6+tXprEWVvKnFcE8pcxxbXkvsa
   5uDF4t6EjAt5zYkuCgLksMri1qoWaNp9SdCegg==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SL300KQDTNW7840@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 09 Oct 2024 19:47:56 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 09 Oct 2024 21:47:21 +0200
Message-id: <D4RJ9EZMHPHG.3BMTRPU3B2PMD@ferdinandy.com>
Subject: Re: [PATCH v5 2/6] set-head: add new variable for readability
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 "Taylor Blau" <me@ttaylorr.com>, =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <xmqq1q0xhu13.fsf@gitster.g>
 <20241009135747.3563204-1-bence@ferdinandy.com>
 <20241009135747.3563204-2-bence@ferdinandy.com> <xmqqttdlqdr2.fsf@gitster.g>
In-reply-to: <xmqqttdlqdr2.fsf@gitster.g>
Reporting-Meta:
 AAEOh8JvwDIwEtHVdovQ7aIYfruWuQirX1Irqbmhm8auUmIexQok5efponkZgmLn
 OJ71M0K4uoyImheFhcOh+UeN2i8/39Ea5dLiWHlcJsfYBUD2Do4AwzbsTRrS4EyZ
 bIlWuc0FoFG1W7Nud4vwpozekK93Sv3keAOQmFM0ahOughsAfmf9dPbKoLzzvCGn
 iOgtY21Oz1iHew7Dx/deZuoxfl7cVCltFMvQWQP72S9da4V83eX8FM+iFhcTwahS
 8bQ5YvO9MTrW4+j8RiVT+nOOCRQei1K3shBet5kwLCJ2tVjjttJEBL70puobxGlm
 jj0iXVwWmJT0MFFGozMTstQ6B+/UIma8FWjxUtHeI/ErGpxHdqa56NWDQ7ZO2Wa2
 0kvr7W9ZhXCAGR8quB5VDzGdsdsgPv6MRdy9/nLD6GbE0xUl/IKDCuH10b1dXLX0
 089vPV/cvGARx4T6XSEKEU6ELQK2YC1ueClI6ojSiL6r+d+2miN0r0u6


On Wed Oct 09, 2024 at 21:26, Junio C Hamano <gitster@pobox.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
>> Instead of calling get_main_ref_store(the_repository) multiple times,
>> call it once and store in a new refs variable. Although this change
>> probably offers some performance benefits, the main purpose is to
>> shorten the line lengths of function calls using this variable for
>> better readability.
>> ---
>>
>> Notes:
>>     v5: new patch (split from the next patch as a preparatory step)
>
> It is a good idea to help making it obvious that we are accessing
> the same ref store.

Indeed, although it was your idea ;)

>
> The patch needs to be signed-off, though.

Damn :/ Sorry, another oversight ... Should I send a v6 for the series with
this fixed now or wait a bit to see if there are other comments?

Thanks again for the patience!

Best,
Bence
