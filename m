Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0637B3F2
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780347572; cv=none; b=BJ/eu1ojH6znsyYmSBLP1nET3v1x3149nqbldCqUBEovn932+jcerrL/bChLOdz0l1zafjMSWGvzEA4B6hSg4oNz9kv32Wxn7o5DT5rDOf7gKaRvYlT7s1zFZNRhdZSravUMyhl/ujGoA8XO/KBDipfJu2G9o5cmJMbt2GtWjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780347572; c=relaxed/simple;
	bh=32mb56fgellgojD4d5i1jkexCdereOPO/kjppa1VO9E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ud2uDtQE/5rdgcs5nrphbR9DXtdOudG6KlixDbEEKPMZonqrMb5b7WLSMfF8thxAnv9LYeUKjNyhP7lv3a32uzr+QimXK8EBLoRGSNwPrmJOyqyIcUIsq91lL5aW5226OYmBArGfvszawzu3YJZxXSI1FWMajYrAGuaaAm04Tos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gtzYOI9N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWqOURzG; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gtzYOI9N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWqOURzG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 111FC1D00053;
	Mon,  1 Jun 2026 16:59:30 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 16:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780347569;
	 x=1780433969; bh=23gd8hWoiEHbvjJ3X8nIHOJ0CniL5XIFRfMOhoSKYEo=; b=
	gtzYOI9N5uIuQKs11A8cSljFgMhN38dAtqNWBaK1Um9X/sKpLxwbSkn2FgRUo8Dr
	Ys7eh2ngVjY69Ax6cgccunsy76lynPbU08YmzL8ZWVoa7OgsEUVltDMFyOcobj9H
	4WWIEuJohorLsyE+LRiQM7fzO83d6seOp+nnM6WE68VEg6K3hsExjE0pNc5sWQNo
	thHPnyj3525krJHVhI+jqNQH5ORk40whCsUIxSy2ZFfRJbQeQYaQi29f/JlRgVB0
	G8ixiK6yZoPIFT0rA1WB1oyDm2OtW7xxEHAErcszXwn8CZofcYWjzK6sCs9vJubP
	4X2Boc7jnTz1pkS0Z6M4zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780347569; x=
	1780433969; bh=23gd8hWoiEHbvjJ3X8nIHOJ0CniL5XIFRfMOhoSKYEo=; b=O
	WqOURzGTMGGGOlF9NCZegpNzbHyFauQQkJBfA6UdhiSlemHEVoGi+ZmJOAk9PZhs
	vUUHBLPQY9bAqsfFed4Q4FzshQVJ4PcMQ5J6fFMCbJDvC705JWEkKal6CBkaEPxY
	CeTAAEttde0VPAeUg/bfG85ccNn5e+Yn4TRJe6M9gSsYJdF0K3Wx3CtzojOKA5/7
	ktzalTakOZGdUpVKHbHV2sdmo8ceYnraRQj3jM72qBL/qCAf+h20D+ZiG7AEu0lD
	l6wRrpv8QtPvR2500az+zHWLozQYw4p3xWW0pdpPDwjFcYz6IxEqTuBIDgsEpPDY
	NF+epMphHh0Zt25yvJAkA==
X-ME-Sender: <xms:sfIdapc-M1GWDOm_ZmoN-dYeUATv0SFVaVutpI-xHEQBN4xrb0Ee_NI>
    <xme:sfIdaiAk0B0H7M7akhodS8r5tQJTs7nxN9aY7Qjzf48OM0HwyK_sWqDYY61l5hCmI
    5QMR_2wz1pHBcIMkpF7fgz12su6tfJMhtYsOT7BvaHWUzpOSJTy>
X-ME-Proxy-Cause: dmFkZTGjeKAzkyBpT6DTIB8N0TShPutBb/JXpERkTyNbVjBot+5jOc86Pm8TUogF3YxlH+
    IYyYNoSIPlDdFfp7h3VFhVchnZpfiwlDPdXRpkVm2sUp7vFxcGGR2BFZEiRCX8wqTg/141
    mVxpO5+ogUcBqF2NJAVQnJcaF+IYviceJmy/QnAgGvdT3ZQx0kuTEAjhB1cY3WTTOHuUG8
    YXTnGM38rEeeg1jE0exK8evxVOU6/+5ZKLkRYbdWTeb8I7YuV+9FKkxW88SISSM41OKl2C
    YMkqzgCenZsNkijF9QH8+6Z+QEkXRjUk34A5tD/ueTzRR6InIdoSKeERsMKXPX1aWEAtlz
    n20Jcg+v8f2ukFA1SI6vck9G/ydkEeGOtQtzbsCsWSm+JZf8YPyYMT/P/WWNLoGXg7fu+t
    IcXfg4OxKHpZRN4ayijrlnoJ+IjS9dd1s0xqVYFLur7/eyH3SruYZvr7Il2GmbBsteFdDP
    +EFVNrLbhxGNwraalLQdAnNjnPjCutjqNj0AB2XuDXoPoi7WQN+kwpll+ZDFS9L0p70xHG
    HfA8tR3ycose0Y12s/TWXC9sgaGxLY+exkGGdU1T2RPk1xhGN9qgF0n4NJWs1CRb/JrKit
    aRmeCWQPFwTlpyr7XYDFsT2MqJ1DzgExtf9TPNEV08Oxl543QZaAjHYvkG8w
X-ME-Proxy: <xmx:sfIdamKkMasnVq1e8FEcXly3NPe8UVMSKKmA35w5hrTrdKo98RjrrA>
    <xmx:sfIdalCFjG7ROP958vgLIeDXT8OEZn8paMwldfCeqoQsKgLkJLbQYg>
    <xmx:sfIdajok7KEcQXa_RmV_dhaYELRAedeHn0qXFCt54sE-xtTZ2TwiEg>
    <xmx:sfIdaoiSYjnhjpRFrX4lf8sHaUkXwPJ4epwXnG5k3m6gw55gcLPH0w>
    <xmx:sfIdaoIHMfn17tx-dsxS29yx914i_mf6LLv8RsjdyWw5_Ln_YbcFeuZF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BC5863020073; Mon,  1 Jun 2026 16:59:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Acu3FUFCGCiJ
Date: Mon, 01 Jun 2026 22:59:09 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Andrew Kreimer" <algonell@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <415f5646-4f4e-48be-a252-8db883f431d9@app.fastmail.com>
In-Reply-To: <xmqqo6hv9i1w.fsf@gitster.g>
References: <20260506101631.18127-1-algonell@gmail.com>
 <20260531184428.55905-1-algonell@gmail.com> <xmqqo6hv9i1w.fsf@gitster.g>
Subject: Re: [PATCH v2] doc: fix typos via codespell
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026, at 03:16, Junio C Hamano wrote:
>[snip]
>
> However, there are things that BREAK tests.
>
>> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
>> index ac4a5b2734..869fb4a14e 100755
>> --- a/t/t1700-split-index.sh
>> +++ b/t/t1700-split-index.sh
>> @@ -502,7 +502,7 @@ test_expect_success 'do not refresh null base ind=
ex' '
>>  		git checkout main &&
>>  		git update-index --split-index &&
>>  		test_commit more &&
>> -		# must not write a new shareindex, or we wont catch the problem
>> +		# must not write a new shareindex, or we won't catch the problem
>>  		git -c splitIndex.maxPercentChange=3D100 merge --no-edit side-bran=
ch 2>err &&
>>  		# i.e. do not expect warnings like
>>  		# could not freshen shared index .../shareindex.00000...
>
> The edit above is made to a STRING that is enclosed inside a pair of
> single quote.  If we want to use "won't", we would need to write "We
> won'\''t", but while it may be syntactically correct as a part of
> shell script, it is a pointless change, as the target audience wants
> to see this line as if it is just a plain text.

Sorry about not testing this on v1. =E2=80=9CSurely this does not affect=
 the
code...=E2=80=9D strikes again.

>
> "We will not" would be acceptable,
>
>> diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-=
file.sh
>>[snip]
