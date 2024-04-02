Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B415D5B3
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089474; cv=none; b=ErrlI6Bw6M1P9X96v4L9i2icWGy41Is77XCM36lQDqE1qeVMZaX+skQeutuQddYvAfLe4dgvuTyLTajwTPwdTyG1a4HoCdRzHErYRjJTuWtC9+baTxTTC0i6kjUTU5gGkxx/9IHBrkF0NE5sqYZG2fdOY1dv2pdAvracWzHLzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089474; c=relaxed/simple;
	bh=jrBc6VI0pgLvJ7UoNM7cj0olZZzhXNnSr61zmqLAstE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=APWstgWY6wotcLF1BZrvn92UHFInNdT/IX6Xg1mKrh/kS9ZFejI89hYBl1hifAfhXF1U7IZPqB3oK4QBGac664jgGp/xQE4CXgqK0HCZY3zbA3BWJ89lkUY37BYTiNuALoyJjr4BAz6JCXLisX7CisJow7+fOWK+EX9rOGjn62k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=h0X2kZ0O; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="h0X2kZ0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712089464; x=1712694264; i=l.s.r@web.de;
	bh=HpKY72yZb/YbIMDmImX4VbX6ovTTAuBHZTM7YUrA06s=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=h0X2kZ0OyJNM77ecfN6QjJY7F3DN3q4UO9whwMvEhKvYpskAbk5j2ovuwIarfPr/
	 HQItYo513TO10UGg+t/mzDPxaQNYGkLZ3p2BpROUp73wXZ8ggUftg3y32AAXjAfTT
	 2TY2G4wS0Dveox0/E5KaCE85TMvZHbY5CadMQZp6suByy3hIRbxcebgM4TILfcD6m
	 XyliaP0OiMF+yTEb4mlO92vnpZgRsHSvN/i1m80kahtoAnstfAi2oyyUdEZd5jpxq
	 Zlj9S0kqmaCXbV5C40xB3eFksxQ8VbeiGK6ZtJmvmn8NhgmsfQOrVNCjVJlotSyjf
	 cfCBDC69891pV6MP5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxpiO-1skHZO0Ci6-00zHnt; Tue, 02
 Apr 2024 22:24:24 +0200
Message-ID: <9b184d3e-412c-4357-83f6-5aad51a8e3d2@web.de>
Date: Tue, 2 Apr 2024 22:24:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] "git range-diff" does not know X^! is a valid range
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq7chf64l1.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq7chf64l1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+4NPPMqNuxYJkegfV2f35SoQh6M/TrdUwu5bxMhabSVbB7x1lH3
 XK1LJDmXX+0HYOkmMln3FpnD6k5N1eikuqGxExYhz4mRezx69nLWDfaJrwIDFGW1N1HZIG4
 LXuiXBEROasID/DMVraDedGZRzbjDOluW86tRxsMvDrjmnvnFeRbtingLtH3AzrGHdfm2Nd
 r6klolC5/gYJAQdQ1xd6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xkLP6Y0ns74=;KRqdNJvWZle/phd8oXehB7DjRUf
 0UlnnWJWLQY8PMGc4dm5c3Thk5Swql/CDuGKLEdSvIe24hMeiAzgSgXZX4Kt/Uot3MAlJIcvF
 kymde8oltRvQKI+L4A69mQwBRI3WE97lMGCuAuEKYMFxmaWLTMwJVADxqENDaO7+YKcWobjQ8
 zNiusIRwFULzIMM55Ia0RztBjuBz2zAvGCwIsxOpxL2yhdVHsEJkZNXBiYB+wNIbfCawI2ayB
 PN+JuGMQBcprHJEKS0OLtssxSzg4aQsDDW8jC7izyX9tkJADj3HDH2SSkeuWCAkci2Gkeg+lI
 8eZViYI46AFNs9nUAfSnK6JW8L/omZpz5DMrS3l1hEmrga56RPezFZhRFeLQq0D1OGiUnmxjL
 tkIDcYpUrhm3QoQwsAE8MSJS60jvnIz2DCcZTW2BwTcHTFSo7er+iRZoOJ7sKk3Eh0/U32O8h
 V3c/w1QBmtLOH/1JPtqISj7teW+5l5oqsypkbE+PZH8tSx7Jsmdh6LTOmaO3xw+3P+hzBjiFV
 cB5KCDZPz/V8z2cTU7F1U4JsuWQETXEPOhEqLLkyujdI4X/AaWIp1tjK0tw7ChwNWqE2NBHDT
 aVTpp8a19G7SatwaGSPVekODyw6FOsszZWZ4K3s6EQjJw4Wp/KReCzXfeBwUc5oBC2s7uVXlb
 4biF2kqe9Th+/PTM8QOhladJ2FZC4o69lkfi/azMcayHJvCixLHjQ/OItDjI8LCcSwf0Orfwf
 JJy2+LMmbq6mVBUxcS1hjrZSqHAq8TZUYJgB4c84bzDleGkQP9eZtJVMdJvhdf0LRvZAF0owe
 6FF18j3BxgdpoGn4YXgpUlyyGU0tFm2PrhANYVXeawToY=

Am 02.04.24 um 19:45 schrieb Junio C Hamano:
> When cherry-picking an existing commit X to a different base, which
> may have resulted in conflicts that needed a fix-up, you would want
> to be able to compare X~1..X and HEAD~1..HEAD and naturally, we
> would expect "range-diff" to have a handy way to allow giving the
> command without having to type the overly long branch name X twice.
>
> Individual "diff" for these two ranges are easy to obtain without
> repeating X:
>
>     $ git diff X^!
>     $ git diff HEAD^!
>
> The "git range-diff" however does not understand that X^! is a valid
> range X~1..X.  This command throws an error and ...
>
>     $ git range-diff refs/merge-fix/ew/khash-to-khashl^! HEAD^!
>     fatal: need two commit ranges

Seems to work fine in this example:

   $ git range-diff refs/remotes/origin/maint^! HEAD^!
   -:  ---------- > 1:  c2cbfbd2e2 The thirteenth batch

Are your refs valid?  Does "git rev-parse" resolve them properly?

is_range_diff_range() uses setup_revisions(); not sure how it could
misparse "X^!". :-?

> ... to add insult to injury, it shows the huge "git range-diff -h"
> output after that.

Yeah, that's annoying in general, I guess to anyone who has seen it
before or knows that -h or --help will list options.  Drowns out the
actual signal.

Ren=C3=A9

