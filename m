Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF225D48F
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 18:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749321; cv=none; b=hI0WDKRMMwk/T1kxnUaurpTmvmsKeSzaCUWfpBNozKAS/poxPPRT1q9KqaEMjvfmNvzXElcP6Z8fmC/l7xe/K2rLgUEgEkXODeDW8tKx3RajK8xtiZlFz3QmBvm/e48k4LDjSSx4xvX+BwTEWHtAFYrvMl9Y33c1cyG66z6gQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749321; c=relaxed/simple;
	bh=kzBxRUjOgkPUazjqwx2cqCvCQTA3YUvnHGpAFeTpj6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETQEg4U27LxRkWsZmJ/tr14iFR94Uu19ZecQib495jvM1Yjx1RibdTZjbBzV+gds5/5zlUspFMVQha5oaMz8J19aYnkD3iLz2OuCUkm2ommmzIZ031VOzmqKlZO/zlrdrC/Ax/jbp2dfMsomgURrrOaeON3Owi2TGUILFri2Yb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=CWWt0CR5; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="CWWt0CR5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709749312; x=1710354112; i=l.s.r@web.de;
	bh=kzBxRUjOgkPUazjqwx2cqCvCQTA3YUvnHGpAFeTpj6M=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=CWWt0CR59c2SzXAs8hJjkcjtECYgh3/0KJbNMkvxPzehpU3siEZFZerwm8mh6AEm
	 nr/p9Yqprq+MCVT4HhTpq9XDaqiekRviwGhfcII+DX3GNZboIMTbM56ix5N6sZF2A
	 HF90vb/LfjyAfHP+GfwfNr4dQ6Un7SDY/3jdYCd72a5xBfpmXYX32Dg0APRjuP04s
	 gbXsXK7Bdssl/+fHhaROHeD5IMeHV7YN0f+UEKbvizabsu2qbilVQJqYevRHG3BPn
	 SnxO2NfVDpAe+/6OpMWJYFrDUfNVm9bGmEfs5WjKVDpzvow1sd+rRtGlaQP8zfzLE
	 NnIklBheAXyAa5bG7Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MF2ke-1rbHzZ1zHk-00FSlv; Wed, 06
 Mar 2024 19:16:45 +0100
Message-ID: <983c9e1f-2981-4e57-b00b-7ee5fe080b90@web.de>
Date: Wed, 6 Mar 2024 19:16:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] t-ctype: do one test per class and char
To: Christian Couder <christian.couder@gmail.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>, Achu Luma <ach.lumap@gmail.com>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240225112722.89221-4-l.s.r@web.de>
 <CAP8UFD0Wi3ot-t0Q7ruMauwj4zkMfd89Xr9SmxYa4eQ3=2VKOw@mail.gmail.com>
 <d96aaf45-f073-42d0-b69c-703393634848@web.de> <ZdzfYPim2SP22eeS@google.com>
 <CAP8UFD2t1KRo01eenK_RVndyVx5Vp9F4FepTgnR+mwhTGTvXnw@mail.gmail.com>
 <bd48f19b-0600-4e64-835b-98d3a97bb7f2@web.de>
 <CAP8UFD2M2+x-pRX2nzCXbLW=nKcW4_RWc9qua5q-fU8QbGu1oA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAP8UFD2M2+x-pRX2nzCXbLW=nKcW4_RWc9qua5q-fU8QbGu1oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EDBnuYHnUPq4T0iKQdksRXuJbGnuDSGrCa7mA1Pw0H++jhIbcUo
 MDWv093ffDNfvWSi0cCA1ybjPgYIWyWGk5iOMKxysVV6PCA/8kZErDfgL0TshonrNtKwAkz
 kvI8o/6Ne+Xbz1e0mAXXS96JPEbDPzdbi6grj0RN/DBliJvEXvGlvKA+wuLiOJz10iUkv3v
 fJr8rGOvz0up4m5yXjRTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kITYCqXtBYU=;iQfGtoW+7E5axG2uDpJlGh+lmoC
 DC5gGDyZ5ccaVvc1yo6peY4XgN0TniOIrUfkyw+LsKhq3kyptJNpcCyz+UxY/bAm9kHJ6f6Tu
 KKsPxt7i6fYCPko3+sfyFyzKpLAHuFGPLWpH5g9XN/2YtgvYvIkxu6UpuLjIns2hVk6bV7eh9
 M0SohBk41uIEH3rxXF+HMu7P0pHLSe+0orSMwHGegWv8M555o+0RxwAGXoUiL8ICE6oIknmFQ
 vZaEdAO1IyW4GaLMs4XR4NgB8ccHL6rEQDEpD/X07Wu7owID2S6UPwqgDa8W+3mD1kc6qk6uo
 IXJEb/IlMIexQ9OeH92e157dFUI0Iw4C0tBx6T8dtkZLnxan8U8Q4n8R0otHkznAnpOHZeNkG
 C4mtqoJcm5EI82k/zxdp06uNdD6oG9OiUkAEhLBxToS+stT1RWW44S/saa5Q1fbwezgCBcLYJ
 z2D0YCetGWVJKuTG60Sw/u886wvN7RQ7mvHFScJe3T02DHJH6yLIgLnSHO9ZuZiTXdw5cDh89
 dYXfYjCyAG/SYG5Z2hNKSInsnkQDmdT4c/SMvkY/GtL5hm4nyDwrJv7VrXkHTzvegxg7Zbt1g
 8+JDU/oDefNTbCyoBLpEKWOq5kwgBIArZkcMvVfNfz9RiwtrD86J5ClzMQ8TBSSxuGrHWAzu6
 l6XSgM8GPuE8lhaGyXBZFwyI/+bHofENRspTEQp/l1meO2r4Kj0zKX3F8z2H7pLpm2UqYSeom
 gPaT+e/t3z/7xVUuoIhFHclWoSBsJR4Be1c1cdq3SSZdWlETN+AZUGZmNUwYzRxk4lBnPybhN
 +BHLVw2TVe1rEUx3Gq1Vieycpp7eqd1dtohDfId4vf2F8=

Am 04.03.24 um 11:00 schrieb Christian Couder:
> And anyway it doesn't make sense to have meaningful messages as second
> arguments to the TEST() macros if we always want to use a test harness
> that just discards them. Either:
>
>   - we decide that we will always use some test harness, and then we
> might just want to remove that second argument and yeah we can have
> thousands of tests output lines from a single binary, or
>   - we acknowledge that we don't always want to use a test harness,
> and then we want a relatively short and meaningful output from a
> single binary.

Different situations require different levels of detail.  If all checks
pass, we just need that one bit of information.  If some fail, we need
as much helpful context as we can get.  Success messages are interesting
for someone who added a new test and as a progress indicator, but are
useless otherwise (to me at least).

Perhaps it would make sense to show ok message only after a delay if
writing to a terminal, similar to what progress.c does?  This would
effectively silence them, since our current unit tests currently take
only a fraction of a second to finish.

Ren=C3=A9
