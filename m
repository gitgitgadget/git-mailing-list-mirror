Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6D29A2
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749074785; cv=none; b=Kz7tJnVerne9gNPW89ZQuzmfGnTxHW8mFUjZI4vlW++C6pRKQgWgtUwwp/Px7OEk7RmT1gS58+rlpEOaEN0LonmjGs/0+NuwQM4fJtNkuGQoJuKouQxPZD4y6A6jIri3R5zA5JgPlA9J4k+jol0hCU2sT1vp4bUD48pbm4uAPWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749074785; c=relaxed/simple;
	bh=XFnKwTFakTz3o4RVlFON1QTxuh1+yyEq17VjYzgbc9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pUARz42ZAaZkJNiUkdUNx7lfp45oXsQKGvGeewdj6BEF2fpNwUBs199i47Fj7/s82vqyC1cOS1y0qsEKotFOGgcn+jj8J+jZ78a1l5GVi68DYrLUr5sgyrcsL6X4NwVdCjj0dN8rpMoZOLF3wwM0r3+Uf/+DdcThhTjBLDCgEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=fail (2048-bit key) header.d=plus.com header.i=@plus.com header.b=jElIjPKH reason="signature verification failed"; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plus.com header.i=@plus.com header.b="jElIjPKH"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id MwCVuZll2FvhQMwCWu6xD7; Wed, 04 Jun 2025 23:03:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1749074592; bh=TUOxhbCLsv6KjZUsmhSk9/LwBfoxrk7Di5nqmlXANtw=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=jElIjPKHd2DPhGXWK0z7FQyf1W4GWky2ogpshiukhhUNYUvtOSVtXEjUoBPTRC9GD
	 1dYOxFVFcpBzA5CRo74f5izCXhSgti9I87UVLDqvHChPpeoy810rNqpGWB25NG2ubl
	 GYLBI//HsQ4eUCWMoyhk5n7B64PCz2iD+hEYI4rzUcaPKibxvnRZoBizqAlWowmRCl
	 DoVwmcobvDYGiS1XEGjJCcvQbuyqLbcLe+97eMfxm50csWc7+OS9ce7P/sEa7RwrCJ
	 QADfxuJTdarG6py57lMyJQN+6gt+4A3S2W2xzTScXIfCv/P8Tayc98wkCTAF4QyYJb
	 nfi4Y2ZQc2OmA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=AdwSHGXG c=1 sm=1 tr=0 ts=6840c2a0
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=PrCtm78Qjd_wrglpL1MA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <769e85c6-c7f7-4732-881a-5765c6ca2410@ramsayjones.plus.com>
Date: Wed, 4 Jun 2025 23:03:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] silencing warnings with curl 8.14
To: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20250604205505.GA1510724@coredump.intra.peff.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20250604205505.GA1510724@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFGPjFt/EXbxWViBkKgEPdYIVfcuauF4ygQ05N3PV6XnHk7jx0N66FZPwdopyazLRZqxfSKz64bRB832fHflLcOo5mIy8JbeZZojgi7gFET+9Msp6hcN
 NMSx/2qFg443FP9iZ34TIjQ1Iqxi80RxEEKd38QgD7AQkUgcj9LOYnbKHWkxti2QZ8T3jRmsw5Exnx+/wSeEXHYBJ3SC2SxFKzY=



On 04/06/2025 21:55, Jeff King wrote:
> The new version of curl (which hit Debian unstable a few days ago)
> causes a bunch of compiler warnings because we are passing regular ints
> to curl_easy_setopt() instead of longs. Passing longs has always been
> what you're supposed to do, but the new version is better about
> generating warnings with gcc (I think the type-check has been there for
> a long time, but I gather it was broken and recently fixed).

Yep, I updated cygwin the other night and curl had been updated, so I
saw exactly the same ...

> 
> I split this into three patches since the solutions vary slightly (well,
> the last two are the same, but my pontificating on the solution varies).
> 
>   [1/3]: curl: fix integer constant typechecks with curl_easy_setopt()
>   [2/3]: curl: fix integer variable typechecks with curl_easy_setopt()
>   [3/3]: curl: fix symbolic constant typechecks with curl_easy_setopt()

.. and came up with the same (single) patch, which I was going to split
into three! :)

However, I also looked into what a patch to curl would look like to change
the constants in patch #3 to long constants. Until I read your commit
message, I didn't think there would be much of a problem ... :)

Thanks.

ATB,
Ramsay Jones


