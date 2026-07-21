Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600B8470452
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662412; cv=none; b=ep2OgdnUpnu4SEtLqUxcefUI9tIBzH3weUtoCTR9gqYo6WEbpnimK/upP1jd9E+1J5GVlxrpnCgTU5hsBkySZkJh6IO/SIYubNQiKqmAWA6G47noNNhpMiSUdmktmRt3KH9vJf03Kd7YVTaAAJjFgcCWleJNI1rOk0XBVl2FGCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662412; c=relaxed/simple;
	bh=1r7qC223Mjnm5i/u9NFWfsno9+ukyxMZg4Vsaqgi4s0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hWhvOyRx+jJC/0mK1Knd6Vnjk4SHy1sxCXQ434fTtjTxL+IVsEYfJZaF5KaOEL9iMZ9PJIR1PxB0z3yBlJixF0C+Rn6ByV7dv69Z7fKJNEXbdgfjEF5O+DwvymTE2BfflViB8ihlbjWU9/i0Z0Ll7nGYDryXP6Zue8kkfq7lw8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dRypqU+C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=alf365i8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dRypqU+C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="alf365i8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F7F87A00E2;
	Tue, 21 Jul 2026 15:33:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 21 Jul 2026 15:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784662410; x=1784748810; bh=W0bAQMZx/4
	CsTTYDpD3INQq2lzN3qTGRVgLd3nu1Zsw=; b=dRypqU+C8oUq68l3VsNKtEVBK+
	NHZU8wIyTI81TBZu0jccUzZI6qjQ3F0aCrMXeIuT5k8i9xyKcG6cJ2u/Kjj5DgtA
	Zh38babs6bO+F9hjqo9FqJcRer66hOga20d/ahrfQGC66N+gK/RkFdDALagq6bPY
	0BdO4Q+4FKi6vGrCy9hC0kX7mDRJdptL8uwByMnKIiKl2YzOru9/GRHXQNeKegfj
	/pVcroYuDfJBmYoFx/8X5EXYyajAmNIMJpM7inq98T7ywPchLou8/nXyKBjJc+Mz
	9T7kvyFWEU9kc0ilIXn/i9my4aAILCQVM7uQwc8qrVNi8RYxmyz50bSudOIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784662410; x=1784748810; bh=W0bAQMZx/4CsTTYDpD3INQq2lzN3qTGRVgL
	d3nu1Zsw=; b=alf365i8s7xt9aWyqS6iS8TUH7LLAWpi3+1clpgaAQEzogXrHK2
	YPBvxzcChG2qqiAhaLqWeWV5LwB+nPpmqNHfyvBaDfbgdAihd10llJIeX087JZud
	/AzqLlfcceGxmL7QRbMkdeoj5MvoF9dVBV4SGZZ6klsgeW+ZDriaApWLyQtouD8m
	NIeP7zbruNRog+qMJ1assPnJ6sncbwuM1XGWzDoqAlLFp1Cg4XrtvMpnqWJIaxJ0
	uMMvuGxZH9D2E7f0reYiUOgkVPUljBKzky+qgoTfBbLFuapjKdvbi4+nqZ9/pYmM
	l02MMAm1QlWfqWSj2drWmh27onTZwxkRM4A==
X-ME-Sender: <xms:islfairXYCuIybkW9N9XwaZj7thePBJv0bhPONNFe3izMizk5P_qXQ>
    <xme:islfavtTrM6nQGR2sKfXnWkfjQIQzk2-1-DqvIZLORex_Np394B2c69W5YfS7IFZu
    aTLFyjRI41z9gs2nSV9SYCx4GDMHkfh5leOKCSOlr1VNanH2cEV5S4>
X-ME-Received: <xmr:islfatYBxHsIp-LCLRE0ZqvFW1082QWqf9B1Xlf1Ppfo30wkYV2zlDVL7E-Epx_mjUSntxrmBZD7sfenTsOieZ89XkgL7MZw6Q>
X-ME-Proxy-Cause: dmFkZTE118U+LFxPFSZSINDRlvXYwfuNCyR4cVu1jtir1UK+gCCBiyWgzYtfFb7RIHQpOx
    2AAQEAfRNnsq1osoK6IRy3w+hJCxOv0b8FQKbdqD+1eGfhMSLG47QjB3MH0L/8lQpuoKa/
    4y+YQdkORQMzxs/4ai4l71S7NhOzDSuuRdTA4VMbilHRh/ByzX4198zAzWcdo5vY99SamT
    XHMaOLU9O47La3A0u0kirBjUIYVd5oULMKQ9W+DvUHnZr4CUnAMzaThRv3yQS882B7Igxt
    2PquUxMgftMJPhUekmSYPx8OJqph/nblyrLBfvOPAUjLdGIPKrJZ5wiViMophroVzQcSks
    9MwI9GQ3I+UGl6Gijcfij5hJBNmhnziNHb5B9PlWy3hCwVsP26smGhg5ooB5+3t+ljlmub
    TZvOv+WZKCYdnI1PNa5oCXBJ9UrLcdHlDFUq9F8CqghunhlKxB8bzD6NeOUN3oH2WRmRpu
    icwzypSl3WXnnyQIIHI/HpoDsD6pJIWH7WisCoRS9qLNDV3vVDz027phFzbsrJZXQLE+JD
    pnIMWBjtxhmBjtnZHqTxmRSLwSyi3nEsU5/jmR68xwPvTfrnRntlfyGQrbuBkKVEhYD75B
    iaHekO79fuOHJj0tpPZsj1ciaUvKCCO3LjewYNaLX9A2ecm/FsSkD5CUf/fQ
X-ME-Proxy: <xmx:islfauYpTIYY7Wk0UVYzis_fndmgiGdrq4KEyLO1TB7C10tBNyPZmw>
    <xmx:islfamkJWdi9b_zt4Aatds1Bk1bJ5wuY0AF87OZso-9cFDLTknSgAg>
    <xmx:islfap1V4bc3ogpFvWWBanArGiHK6sDR6fSBVvr2IYoFYV3hCTxCaw>
    <xmx:islfam3SW1MZiJDVDYKVNI19m9Wx-NNhkQq6y0JYQ0XUBMY33NheYA>
    <xmx:islfavC1H5ggo23hY_6kyiS-4AANwCasZ5Ve7Si743awHmK_ETSQ7TXB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jul 2026 15:33:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  "D . Ben Knoble"
 <ben.knoble@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Eric Sunshine
 <sunshine@sunshineco.com>,  "Scott L . Burson" <Scott@sympoiesis.com>
Subject: Re: [PATCH v2] userdiff: add support for Swift
In-Reply-To: <20260721065736.8747-1-diy2903@gmail.com> (Shlok Kulshreshtha's
	message of "Tue, 21 Jul 2026 12:27:36 +0530")
References: <20260717140232.6722-1-diy2903@gmail.com>
	<20260721065736.8747-1-diy2903@gmail.com>
Date: Tue, 21 Jul 2026 12:33:28 -0700
Message-ID: <xmqqmrvkw31z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shlok Kulshreshtha <diy2903@gmail.com> writes:

> Add a built-in userdiff driver for the Swift programming language so that
> diff hunk headers and word diffs work out of the box for ".swift" files.
>
> The funcname pattern is built for Swift's own declaration grammar: an
> optional run of attributes ("@objc", "@available(iOS 13, *)", ...),
> followed by an optional run of lowercase modifiers ("public", "static",
> "final", ...), followed by a declaration keyword (func, class, struct,
> enum, protocol, extension, actor, init, deinit, subscript). The keyword
> is followed by a boundary that allows whitespace, "(" (init/subscript),
> "?" or "!" (failable init), or "<" (generics), while still acting as a
> word boundary so e.g. "initialize(" does not match.
>
> The word regex recognizes Swift identifiers, hexadecimal, octal, binary,
> integer and floating-point literals, and the language's operators.
>
> Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
> ---
> v2, addressing Johannes Sixt's review of v1
> (<2a3a73c5-5e90-44a3-bf6a-6e98ce5e5a59@kdbg.org>).  Changes since v1:
>
>  - t4018/swift-{init,failable-init,generic-subscript}: "RIGHT" now
>    appears only once, on the declaration line, so the expected header is
>    unambiguous.
>  - word regex: dropped the redundant "?" after the single-character
>    operator class.  Single characters are already covered by the
>    "|[^[:space:]]" fallback that the PATTERNS macro appends, so only the
>    two-character forms need to be spelled out.
>
> (A couple of Hannes's other suggestions I kept as-is; I have explained
> the reasoning in a reply to his review.)

Thanks for an update.

Let's wait for a few days to see if we hear more comments and
otherwise mark the topic for 'next'.
