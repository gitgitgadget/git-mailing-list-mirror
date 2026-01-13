Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48DA34FF7D
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329952; cv=none; b=ZccCUHiiKLjzrmCxBcnqBY6bxMdsGygWoRmeWoWKv2nD40M46Aq3/+cLyEUkBxyTXR5LrEioetp0OW8EsbHVbeiW6QczCxVfNO+2J3z8zo9ec+wVOVWaxKpkVsBlNuOZcP0hLkKHjTlFgv4Xc8YTPOztAVf10LYKsE2PLDv7Shk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329952; c=relaxed/simple;
	bh=qTEkH1BBKSkFksGlQgE++UO4fWzHvNdtf1zHZ16SzSc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hhE/2sG2MI40FijlilegDDy5o2KNBZ2EzlfAtAbWCdFTufbCOSnJZh5IbsppK3hIjA41q66fvIFr2DMEVAVr3WpvPp9Jycx2xXdLFqsVRnSw7rX0OtGmV33BEXcjOYPOqc4HEAjLmoKz3N9rLTXfP+vczCodUxT/rWr8nOZNL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Vgt9rek1; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Vgt9rek1"
Received: from ehlo.thunderbird.net (unknown [78.246.225.149])
	(Authenticated sender: jn.avila@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id E47042003CC;
	Tue, 13 Jan 2026 19:45:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1768329942;
	bh=qTEkH1BBKSkFksGlQgE++UO4fWzHvNdtf1zHZ16SzSc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Vgt9rek1zWybLNmxO5u9zq1MLgm/SH/Y3SV7fD2scFwfKr7iRB9N3aPl1qCmpRqKR
	 tgRBw44CGwFug3p/g82He3DO9xMj8tyQmNMyXG/QWJhQInLL6lT6Vl77h0weFCboKW
	 uHMisQy85S/jZ5VY6ecOfOYaiMcxBVGEeJHAag/S1IbAZgE4FFxgcF6S+/BCAjd8Me
	 uWFwQKwyzIKYqatX5LaUyJRr7jlVszWDaQv8FOmUPwoqo9BRrsMJkKhL8j7D2dWUZw
	 j98QINKN5R7jGfDu0Gjei9RNcewG7n23rU2RE49kuY+isVXbqg7pSv21Sn3QYgA71x
	 lcdPgKjTtb+Ow==
Date: Tue, 13 Jan 2026 19:45:36 +0100
From: =?ISO-8859-1?Q?Jean-No=EBl_Avila?= <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
CC: git@vger.kernel.org, Michael Lyons <git@michael.lyo.nz>
Subject: Re: [PATCH 1/1] doc: git-bisect: convert to new doc format
User-Agent: Thunderbird for Android
In-Reply-To: <xmqqqzrtllkw.fsf@gitster.g>
References: <20260111204316.836446-1-git@michael.lyo.nz> <20260111204316.836446-2-git@michael.lyo.nz> <4705928.LvFx2qVVIh@piment-oiseau> <xmqqqzrtllkw.fsf@gitster.g>
Message-ID: <1CDABB57-6197-49A5-B679-17D56153738C@free.fr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 13 janvier 2026 13:54:23 GMT+01:00, Junio C Hamano <gitster@pobox=2Ecom>=
 a =C3=A9crit=C2=A0:
>Jean-No=C3=ABl AVILA <jn=2Eavila@free=2Efr> writes:
>
>>>  ------------
>>> -$ git bisect run my_script arguments
>>> +$ git bisect run <my_script> <arguments>
>>>  ------------
>>
>> Here, if you want to use to use the synopsis formatting, you may replac=
e the=20
>> verbatim block with a [synopsis] one:
>>
>> [synopsis]
>> $ git bisect run <my_script> <arguments>
>>
>
>Can you add a bit to "if you _want_ to use" above?  What's the
>pros-and-cons of doing so or leaving it as the way it is written in
>the patch?  That would help people on the same page when they decide
>if they want to use the [synopsis], preferring over the verbatim
>block=2E
>

The rationale is simple: the patch is changing the mode of this section
from a verbatim instance of example to a synopsis model of command=2E
I'm not settled on whether this is a good move=2E What is sure though is t=
hat=20
when writing in synopsis grammar, it is better to switch to synopsis style=
, in=20
order to maintain a consistent output and allow clearer and more direct=20
explanations=2E

