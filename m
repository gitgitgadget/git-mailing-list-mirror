Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75912396D2E
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496595; cv=none; b=LmcPiXKFablsI6mecQT134OdPAhEzsfUJZz+KEBznMnEwb1LL49hYQ7bB+uH5FoJwfVw8JlyaiDvO/bkcXoEop/YjXmr0RoZTDPzX6xv9LBGT5zyfzxeOsRUlgnDlr3jX0DnnbUzQyMpyBbnZw4ptRKWECh8uS6R3oqJsfOmZg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496595; c=relaxed/simple;
	bh=GfCtWANj7ghpFEKAbyYVsknWAa0Tl1Q1ED/4465oeJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ElNrc+4p7j+exBOiMIH0TYV4OfZZLoyNw6Xi2UUQ9TU/5Ch76rXjnAWvIDXQ6c5BGe1GokNhL6CkUCWWGT20XP7zhg72vgpA3CVkKDiL8qa/CQywtWBEUuRB5/GTO+rxxb4VvEJYVdP2MXzBedUs0MXtywDPLz1aF3GE2cXy14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kZeW23rq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Onveg4Ew; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kZeW23rq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Onveg4Ew"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 567BB7A0130;
	Wed,  3 Jun 2026 10:23:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 03 Jun 2026 10:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780496592; x=1780582992; bh=vSiLNEcO+i
	pRY+VX6OaRQaVzcF62pDzZew4aII6JeJU=; b=kZeW23rqsYww3RC3OGA9T4gzPj
	VRRUw8DL1sa+xmYzQrf52daz3VcyJhw7Vvp99MP8JsMFd0aK14tA09z6CGFGg/HS
	cHaUhobK3B7qkDxei2H7pJprim05F00jZnN4RU0HLZuxTIgyStRVP+6fAQ+zGjHg
	9HVaIbNmhkjzRy6MHK3RNxi+Pps+5U3qh/S5ifaqDaWdYm9OBqi5y9lQVSipX+3d
	AISYotQmJLEz6FEBNxqw8xjkPcGePxdTxWUi3wXF0ba7tH5gg0M6LW+qimX9xlji
	+niABP9Ur5veT7lQmHFvFBmw+0sY7cEO0rMHlGJS+W5hgM+mVhQijOaE6y2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780496592; x=1780582992; bh=vSiLNEcO+ipRY+VX6OaRQaVzcF62pDzZew4
	aII6JeJU=; b=Onveg4EwQfHVwBR0kx5+tpBE1IFzj72J6Abigi16y6BQpaQVXJm
	HBlyLL6QPWPWyf7f/do7TM9a5vumfjS9Ha0saHNFlBVUFzEufr0e+tbZfsYnat8w
	PRBP/2zNQ+uWYtEosF/yuxLiGwdLLjR+bpjMGt02K+tjBZ4pk4sZSqySizg74Jta
	51XiEW+IbWF/RFUQqZFJWnZ+i6TkRMeiuxXMs2+/uCScLBnX23m5smMhzOwI7Qjp
	r4J9e2lnrvf4Ch35ap+UpXWjxZm5KGXnoZe8U2geXX992RIe8DtTkozlezPaq/ce
	4oFTx/3Y7i4cryFDvIxkbvzTM+FXXXNbuNw==
X-ME-Sender: <xms:zzggal5Fh0ugVsNQrgkUHVRb98PiJYryNY5Qc-Vt12HdISQyrWmyoA>
    <xme:zzggapzjv0JYAcyxeY_lr_qYFEdChU-x9_Hgu6OvxiCx3pfqWvAHHXN0ovPD2-6W8
    OhZdXRiJQtjcZvrkMOqvCbwDZ3Zx67nXGCa2_9GSd2qjPfzwXyQaw>
X-ME-Received: <xmr:zzggakykFJH2GS1PNH8pl9xb21AJjl1wwF6Dcj5h2bnzZFpEkn_uEebnSbi1tpmzegpLed27E4yA_ZlsyCtk2-g4NlM71_tB8AOz>
X-ME-Proxy-Cause: dmFkZTFxKtfxIflm2A8o2c3pSzYWZaAEDcjBeF1U/mF4aJ3sUW0kkThh6GNO0qHFUVDua2
    f0lalekRj5GCYffTAdyI2XfwvSEc24NmzQhT8Ls7Wb2vZKd2RZ02sq8JgX/w7QEdqHbpKR
    dYg+oppaGdgndzQMmTfRVYtN1Z0Os7S3F2dtrTI+w7POlMOtxUAFR9GLE7N5XjDkC2QwnK
    YxLDTDI/4Hn6S1kjjoGiFLUYNcF4NJDsrXFOTOdYqaPQK6XGPSW0+ve2Tm9GRniH2udkMg
    /YnJgh+ud7582gwedx01HFLPAkjU73o4yzJm31ViosWZMsRwuoTc7SNRPXtDlktIw8f0p5
    Pblp1D84j8Ecuc2ZYfSbKGt2pfjij2ZVrVzeD8nhybHQxqjb5LJGjUGY1JZrwsTqU+8Kcw
    Kq1mwwcamZoTNwzsgn85LGvVi/7wUJHzyJHVPmWJ057+fHx+kG/R5gSJ2nktScAv5TXeuK
    xf7iYrvr+JFMBi1G4Wtt7AOOXDpIeqUpKKo2xlRggXd4J0UgCmkNoicmIhiPoK+Xq1Kayf
    6Jab+nQT3hH+X7xGCbZRwEf3Y3yUX2K1GMhRDS4Z38V3HVvrVB9Zksl+Pk9QniSm9wdre5
    fR76ZPtRsCP/78AFl4lk3qWjUkNGaQmziTjcaPHc0SaV/y1YgcSnnY436S1A
X-ME-Proxy: <xmx:zzggapxmFzXddarkZ1hPpTKlO5iIH6eYY5RYoaCthHnOFPtcGwBt_A>
    <xmx:0DggamaVDLaJq79i5xKecjQexVmtrPAYD1t8D984wmR0qKbJHfQZVg>
    <xmx:0DggaiWamQMR_chfH0C3Isqsi1dBA4BZkY-Yc6H1wvrTALPaQGZ6jw>
    <xmx:0DggasgnOQ-4uXdX9Reb3Il5ed6YetPhYrnIzcBoMAzWK7zBhiVjpQ>
    <xmx:0DgganNXM70A88-GyTjersJANrCS_u8j4Ul57bT6KM37GCOwIzZTwJrY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 10:23:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3070: skip ls-files tests with backslash patterns on
 Windows
In-Reply-To: <CAL71e4MLyEEWtrHvB2K+stZUq6s+5sQUpSjmos3F9aVo3ej=Fw@mail.gmail.com>
	(Kristofer Karlsson's message of "Fri, 29 May 2026 10:04:48 +0200")
References: <pull.2128.git.1779958849319.gitgitgadget@gmail.com>
	<xmqqecivjn7k.fsf@gitster.g>
	<CAL71e4MLyEEWtrHvB2K+stZUq6s+5sQUpSjmos3F9aVo3ej=Fw@mail.gmail.com>
Date: Wed, 03 Jun 2026 23:23:10 +0900
Message-ID: <xmqqecinsnxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> On Thu, 28 May 2026 at 22:26, Junio C Hamano <gitster@pobox.com> wrote:
>> Two questions.
>>
>>  * Has this been broken on Windows since October, or has something
>>    external change on Windows recently?  I do not know.  Anybody
>>    knows?
>>
>>  * Is this change a workaround that sweeps ugly breakage under the
>>    rug, or is backslash inherently unusable as an excape character
>>    when handling paths on Windows (which I am afraid would make
>>    wildmatch fairly useless there)?
>>
>
> I am fairly new to the git ecosystem as a developer (not as a user),
> so I am not sure how long this has been broken. The backslash patterns
> in the ls-files test path predate 8a6d158a - patterns like 'foo\*'
> and '[\-_]' have been there since de8bada2bf (2018) - so it may
> have been failing for a while before anyone noticed.

Hmph.

> My thinking was that it would be good in general if the CI results
> were green and did not include false positives for errors that we
> know cannot work on this platform. The risk is that people stop
> looking into CI failures in detail because they start to assume it
> is the same old backslash problem.

Oh, no question about that.

> That said, there is also a risk that the real underlying issue does
> not get fixed. I am hoping it is sufficient that the BSLASHPSPEC
> prereq and the case *\\* filter make it obvious to anyone reading
> the test what we are skipping over and why.
>
>> Will queue.  Thanks.
>
> Thanks! It felt a bit heavyweight to add noise to the list for trivial CI test
> changes but I suppose the process is the same even if it does not
> affect the production code.

Sure.  I just found it a little disturbing to declare that there
won't be ways on Windows to quote special letters with backslash
when writing wildmatch patterns.  But if some Windows folks got
motivated enough, they are capable of lifting the prereq when they
fix the underlying code as well, so it probably is not something I
should be worrying too much about.

Thanks.

