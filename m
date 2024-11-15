Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6DC1D47C7
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688470; cv=none; b=kQEtfSNUgSq1+vZumUa38KSc0TZI0YZy/BqRsd15uW1i0qSSQqQ57LRNT3P8UOZGJ4ozAsE0rzTC2eyon+htSIhLKL912o0cfh41ldsQ+feg3hPDruYz5vEdyB/NVyiq7pj4Lt7zBKduYGwWdSQIhTlb6nNW9KVKxDb10hXLo4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688470; c=relaxed/simple;
	bh=ncZXoj3EdnW7l3IIBzBe82MkaVDiXQsF825kcJMqyes=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L41V1A6UWYJNJLjzjO0ZxWtVWKspIImYEuzRpLCE5JMr0VohEcUV9Byve5XwXmfOsHXVqD9SM8F329fnor26HdhY2u/X8wG+ZS7IpbSCoHcX7hKmw4C0xPk5iYgV90hBErf4DIy7Kyjrts1AQqKfj8kkZNvNDicuZJmW/XkdfXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=tftgjwu9; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="tftgjwu9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731688457; x=1732293257; i=l.s.r@web.de;
	bh=UoVtXNgFAt/BcsRVRYkQR2Ax4/8fcVAuWMT5e981COY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tftgjwu9v6lQR29dfBoLpX9JXmJJ6hsB/brx7oMBu0ub5vYXD6598RNlvadV3s7U
	 DZ7J/iJpAcZNNJh31BzDkyO9e20OoidlvoGjXG2uawput6HB66GJ6YFM1zjJXrLcL
	 lGYT9oveQUMUwv8bEfx2Q492H75Iv+59sY7EQK3XDCg+CNOwxloLjCP8Q9xGHVYXz
	 hRLz93v5WUeDkElmvvYGjrcxeQuCGNi8j0/QzzJ+mqnMh5OZIEPu/YvR9Sx0XmubD
	 w4fvBE/5m4XXlwnnLOIabdnb7tbixoc75dkRHE12fPhAIuEJpCCShBR3W59BSAvwM
	 wGNWHe1+r+55qAxFqA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.30.137]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidHZ-1tezN83BlX-00prOw; Fri, 15
 Nov 2024 17:34:17 +0100
Message-ID: <4ca84916-c5f5-4d52-8f6a-08b729bb66b8@web.de>
Date: Fri, 15 Nov 2024 17:34:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: malloc: *** error for object 0x1: pointer being freed was not
 allocated on MacOS with git 2.47.0
To: Attila Kerekes <ak@enrg8.com>, git@vger.kernel.org
References: <5FFE9429-7496-429F-BEC5-9D00C8409AC3@enrg8.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <5FFE9429-7496-429F-BEC5-9D00C8409AC3@enrg8.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uPjwTZnj1EkKlmIdG201W7B9daU3pnFKSpnUT6KwAVD2DQA05PU
 25LRV7SWfknsQVTowiA/ijJst9g7/zzBTMHMUQiJUZRyquA0XcPPbTXBqllzP1Bloa8lBPU
 BYz4Xy0F6NI0ZH0jjgwIOOzwj8AJeyOg/lL575xsC9Gg9sLOBws5dzhuJwJuKbHxyTMDLJA
 wIDiK/7s/vT2MZLBIbHyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Op2rL7U1i6M=;9aemURLCEoZqTAWHhAswHBVUhWk
 O/bzFnO8ce9aYSHD277baekAkr37TFFSBGxV/NDpKiuwjgMoeKvQAsdq2/6HugnqCtnGHQTTN
 TuF9TIz82OW98WhFPcwpUtydxytYFqL3mntMgpHnEhbuDXYGoIaw6Z0NJRQ3lUD6s2zF5RI2g
 w1bwnUZjPhDREMJ7fWmHmumDRkNl0GQb8sSswNxMcUVbfFFEjsHpyUK0a3q/m43n/r103rI6k
 H8pbjDHcrkU8eKOxT8NcLrI2Dsc2DSy3tRTWmccSA1AIurwBxa6GajiuhCFVOGjySpqxAVSdp
 cGxQoNqSZIE9nitS3QQoTXLsv1pf9cTL8KZfuMFjfgTF4V4Cq5fsUIOcg/kQkiUp48Xn5nsRd
 E5bF4MkGCH9KKBByMHWEBa2wA4yvDQgVFKu3hnI5ZZ55ywgviIHCnfeSqIDStxzlkLeUIkaDO
 lITRB4cbeG8tZ9nC/NI43VR5Jw5YgoCWuojSKLcFA5M/cAWoX1FPZRazZ3r7KYBlFhcbi3EdR
 4IgnmsVzBHBjikmuB7aW38Tk/BcuTbXTkiULtE0AzdydZ7NkCiMpALUomjm8tmTEUqLE3YiSK
 9AYbtwHps1fUWO5LUYYX4m88WScTJriYVNuNs0C6Hx4VLaPk4hnIgEd/tiQ03k06hJ9+SQeu2
 FQUG/IeqVhEOPHhTXvdj0rvAAMqsXRUHT3PccBHxMVBrhPo6jkT05OW1H7OYEDJK3Tam4B2Kr
 xZFkIUpnSwOf52jl9Wqim7lilSbLzHmYQHxU5rylQpw2AyO7pDTWPnuoqCSCqECOiaRCdxj7z
 NQeVW5DFjZw2VQj84D/7Gp9BoYy0Dyn7oWVI2c6E0DcuwmRjQdV6XmY/m0J7wjiVily3kNJcl
 VBuSgofkKhxA6+4Bsiqlja8joqlt6Bu3n1OS5eokowhdyv5T3UuFr/QrJ

Am 15.11.24 um 10:40 schrieb Attila Kerekes:
> Dear Maintainers!
>
> See my bug report below:
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> run the command:
>   git maintenance start
>
> What did you expect to happen? (Expected behavior)
>
> git maintenance is started
>
> What happened instead? (Actual behavior)
>
> git(26100,0x1ffd63840) malloc: *** error for object 0x1: pointer being f=
reed was not allocated
>
> What's different between what you expected and what actually happened?
>
> git maintenance jobs did not get set up, instead i got a malloc error

This is a known error.  Commit c95547a394 (builtin/gc: fix crash when
running `git maintenance start`, 2024-10-10) fixes it, but has not made
it into a released version, yet.

Ren=C3=A9

