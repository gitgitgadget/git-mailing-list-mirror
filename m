Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F383B0AD7
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318226; cv=none; b=YtWaMYIwfdUfqURmRKVBrWt+s8Xje2apCcMnrDwgr48xAjrMjvJ0m9RdFTPF0VeuWyE3qn93EfS9ob1icQI3oBIgAlaRRHsgK3B+wMUWByKm43FKIdafZNonchFZqIf3NIRX/Wt/9Bsg2ZF04WhPW4XullOMR0d2yb1fHhfT+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318226; c=relaxed/simple;
	bh=QFf9RWytaJqzn3azR8Gnx1iSpdiVJG9d8tGZC0W/g2E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Tc1RNXn94wRkN90Wp0QRGCB/2r4ZQBpbcKQduhYYJ1oAGjxsLWhe9UGpIURoPrI8R4n4n2EdrOcaTmG5vFdci550X9/i791c0nmm21C8V5HpCmPSPpvU/EhRsoQB8bbUG3WkfCMPPQw/2nnw4dIg+JBT8TZdgd8VdY+n4Nr7s+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fWHtFV0m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPgbDSpU; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fWHtFV0m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPgbDSpU"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FFF77A00B9;
	Fri, 21 Aug 2026 09:16:35 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 21 Aug 2026 09:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787318195;
	 x=1787404595; bh=QFf9RWytaJqzn3azR8Gnx1iSpdiVJG9d8tGZC0W/g2E=; b=
	fWHtFV0mEUHykLJkZ7gpY4uAoPWuXGMXQOcJodd5sRsnA9lWi3wd5itF/rOfJvmc
	rNsXFtCIksp51llgoefgBaEB7TAwqCmKPw60ij5cpgAkyQFd6NnEKTo4s+Y0JgdM
	/zKLPJePCbMRrPY9HGy3Ym0utT0nLZuB2dDHmZ1c7wDu0mbiwOO8mIVEzQdkyJ3v
	DMHgyA+1QZ+MmZTyf/l8jD1bc5xGxtT1pBLmEkW+3DoY2WilQdEKoSJW8zrC6xkO
	Q2VZV6hVmZ8U//+fLwf3APZpXxjBivldDigX6VhQ0fTzQoTWCwJF5qVGgqHHQ10F
	/2O5dGLSH3HNEqPBze8NZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787318195; x=
	1787404595; bh=QFf9RWytaJqzn3azR8Gnx1iSpdiVJG9d8tGZC0W/g2E=; b=U
	PgbDSpUqFbXB7f5gFKJe9V4t/CdwqJBJlffVSbSlRRkB4Uw69mmMS5X+eRh90fSY
	BpP8vf48aiFuJ5gfQy3h+Qskui7KuCaVFG/ufZ4hbZqyVjZupn1rL9eyBPhRf4BI
	bSmeBJ4MGszsvR0jzEOcmhaI2I8FcWqAQGElxuBKtG7VGTkCliTkJNbXYBOopzMm
	jQbTu/bfIrNFXa920xkthM19R7qjIdvhReU3hJFhufMQUiII7jynPhInzmcJ47qL
	7uHzPFFyGRqAO38KgbFwwyVlNV2har1HR7wZozTjW+MBPkNishdenjrje0npTObz
	C+IiFoJ7rn1Ukwla6mpqw==
X-ME-Sender: <xms:sE-IarvXYK1sSSfPx0Ra4VsNedHtrLWCNWhdHBBGaoBMY3NeFPKdAm0>
    <xme:sE-IanSwALp3O8t6AleITd1TgETjWxE4hDYkJ2ONjKc_n0cpxCetev1rrGGW0iC3T
    c7gz5WhJeSCAVYCCX-vUkOH9ghOwrsrSqz3UXGxiEyqWlfNDvRnyg>
X-ME-Proxy-Cause: dmFkZTFyvvNH3CgkbiwMchKndHbdFGuWzhEPJxSRiQRHQq3TfxqtauahZxIZVCxkELcrZ8
    5ccBt12r1fuY2LyGbJ1j8ipAe6uCcufsltI8Usq7G+e+S4/YEB0HD406Zk07+Zz5y5ReX2
    f3AkRn1k6oqgIL73wPbH9aQbbzXCBw4kgLpPopE2R7RWBiKanpbH9LtA9zf7GsP6XrZgWx
    J0DKrlY9Z61/bnQ480pBJUiDpm9qc0IPeifa0Zoar/QI1LUZ21TGSU2BUoS47d2Cbz0yOh
    cF6fhlVtW6JPaR/RE44jMwW/IA5NdxJBWQCx6vO5RZAiDOC/MmrhZ4iM82YqS+i4Q4JaWx
    RPIqcAewHwiqZwimbG2Jh9ATJtqZMpU2+OZYP8sy3ZCe+v00tDGaNR0plinQ0k1pZIp5bA
    qU453dcIM3yO9wLrpEn0726cMKVoMg4Qyz/DPTGuFHeHOBPQlXkVvmnaGx0zNi3DPcBxHx
    CLIjlIh0Tca1EXHFyswkFrJIN2TerkenaVpjdobZ4Xi+juTG6gZQlCZSuTANpMoRKUY6kp
    +QyOuuRE/4AKBn0yGoqvhCLfijQnIFsuL7vPSq0yY/0S9vL5YcY6ItQZy0PdDX3/6R22P0
    4h7dexgMoUwcYw91RcqDA9Uu/9Sx77f9SYzgCItVcaYeuvwoT7FEZmonqN8A
X-ME-Proxy: <xmx:sU-Iavp9GJWO_UO3EQ48WLtJ-TJZCqDd5WV7PMK3LeE5bx3U72HsIg>
    <xmx:sU-IahbD3lPJgeTtjnGpOKjIXNGLe560Jcs5T-N9FpOG5oPmEgVYGw>
    <xmx:sU-IavRPyC_CrEjmPBoBKhzimL6FejDNquuijdsVKN99oOFWGahZHA>
    <xmx:sU-Iag7EoKcLbC_iOFff7-bDKFIGi0PC6GRdBuOas7gMkiPuWfyoyA>
    <xmx:s0-IatCMmlufUGw-4jSlpE7LrnwJl2-y_kbOn78QpvmO_xPIp9zwQPb4>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 62C7622C007C; Fri, 21 Aug 2026 09:16:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_niM3_ov8QF
Date: Fri, 21 Aug 2026 15:16:10 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Julia Evans" <julia@jvns.ca>
Message-Id: <9f016c44-2236-4da4-8ef2-f8e0cc99bb96@app.fastmail.com>
In-Reply-To: <aohDFdjPU0t2d9_8@pks.im>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz>
 <git_to_datam.bec@msgid.xyz> <aohDFdjPU0t2d9_8@pks.im>
Subject: Re: [PATCH 2/4] doc: git: link to the gitdatamodel(7) tutorial
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026, at 14:22, Patrick Steinhardt wrote:
> On Thu, Aug 20, 2026 at 08:55:22PM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> The previous commit added the first mention of gitdatamodel(1) on
>
> It's gitdatamodel(7), not (1).
>
>> another page, namely in git(1). But there are also other places where
>> a mention is relevant.
>>
>> Let=E2=80=99s mention it:
>>
>> =E2=80=A2 under Description, since it as useful as the other tutorial=
s already
>
> Missing an "is"? -> "since it is as useful as the other"

Yes, all your input on this series is correct. I=E2=80=99ll make the
adjustments. Thanks for the careful read.
