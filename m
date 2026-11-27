Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795823099;
	b=RnuZXhS87J8IqmjsvYqrReB+VQu5zKS3hIj12PaLISCfRYFTr1LGoJbxMV3rognHhcLb
	 t+2sFMaw1vRIeYHI6lhE67PhYMqB2UnSt7SCEYejGcSSAESfveboYvKdgM3AoFMniNlkp
	 RCt9+l2BZR+uOjr8to1Pg+A0sAfjI7Y4sze6H7L2cM8qcqvm28QQglcv0u8EKV5+HUwOC
	 2JI/Jk2UbFpC5VZNpA+hn/tRUTmQ8nZbN5c/DsGCpBQZgc+1hC5PJ5LfPYq4i1siw4Jw0
	 fBwZcs0uFAUYxUH+4uOsoRpNLw0237AVhJvYcw+Ii5Nch6ovaO5NWsmdRh8/NPAEmvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795823099;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=3J3pPvzS6QysJJkJiN23FDU1ujbjgHWi0g5UScdg8vI=;
	b=tT9punf9ex/umKdIjyZZxLiMZM8usxrjo3sifLSss0zr8sIOPR9w4Vmahz6Hcly7rWSg
	 kjwgtGlGZWLM1QwJTlOP1SSwbKkcvMZKZ74DG5cKoRtHaKePDF0NCzZoL9wKzt/JvSZjb
	 BwcezQOmmxv93DtkdFFuq3NUPpkfcYu8K/axYdkR23sho1y4mruztYqhEAoBYwwjJbYj9
	 klwJw2xqliYmtrOu0VDm3HZWrcOJvVlLzyfSwGcWkvEgHbinYX8ghB1PH8eeKXTaa/l1r
	 tcPgB7WQvB+w8CegNKtrvd5smxKkZZVBgPv3mJrwJZaAXUF4zsfRPTvg9ISILF2nHUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=lydOeEg7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zRomUL7I;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C1606A324
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 23:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B39C1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=lydOeEg7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zRomUL7I
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC0337A02B3
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 18:44:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 27 Nov 2026 18:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795823097;
	 x=1795909497; bh=3J3pPvzS6QysJJkJiN23FDU1ujbjgHWi0g5UScdg8vI=; b=
	lydOeEg7a25KHXATDr6okl7M0WC8zZ9XSCdCxj+R3XnCzIkAJ+rcOjlJYfS38QKc
	IsuVWfQemgiwguP4UPGpwdX7DoUN9DQJLe3z70dGEzEhjDwzdv9oapXjZoV/RKBh
	xIWglm78PkaVV3qRLW2osHLNp5kt37YcVtJ5W0yaPup5isscdihM0JYhoBfqXxqM
	HigIWZSPTbztLrBnvRJlN6HIjmjgPuDUr2JJuwGVc5GRaT5GBEaU3xnyFx9rHq1M
	8woi956KQvjeWrPwE8y3zUTmwvmcC6yzT5wD0ai4jCg7SEg2H0ru2xfd4FyacgVf
	1kbB6OM8E/L5hMRGgs1XrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795823097; x=
	1795909497; bh=3J3pPvzS6QysJJkJiN23FDU1ujbjgHWi0g5UScdg8vI=; b=z
	RomUL7IAN+a6i3RfDAJi9TM3z/S32BSci2ztYTgLi7b3emtNHd29/iDg42Ubu9wN
	mrPrYjO6rIkMdN+15UtYo4R8NyErCEDa5NbzZb7x1d4XLgWGffLIcs1lFPNeejKT
	rYJk8E1stRCADldAU2eZcLBXG+F72T3vbCDkfpItUOhJ/IZtN4KJHGZkOLmbPz2n
	y2SCrpXH733ymoYsXLdNZnxC2w0Xq49+I28aYy/wE/milCr0Of/6MkFyCSDzcaw4
	7A6DrYM7FkRfkPhNQU9aYw0urVfdBYLuXW+pdOBWP041HnH4REga9GsRKMUd7Bri
	sjGBUOKT5mC4gDw299SHw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795823097; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ASYNaaflL2GfU1CiETpJPHJHlrAqg5XqnBI+qujbshCq0Ng
	486ZzxQjihx2yFHnlxMgvgt2tvfba7shOzItog2H576I8jJcZYSk7lR1bi/ASNuL
	4+pawtTpEz/xNSqwPbsLjBiOnHeDMT0j6Mo/GgVzttDIC0rYMA2JUNJGIvspbD+M
	Ky22CCdWu1h1C+1yTlMUk8PVftEw17MtScktCLBi59cDH2rb3LartFStLS7xlE88
	OCWCKa6MvRfqh4vtttNIId/Pr3vDMIwvHi8TqK5yVhlGrlW+C/XyiB8ExtGH7LDT
	JohurvMUz4rJuQLA3kj5Y/Cjwyn9kgKe/5IKJSw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:LdpQLTMjt7xDrhvVd3MmahnWv0pb8FmTlZA3ZFiDDbs=:iqEi5Tj2eAMMfHVNniQqlC1CCXKi16FtjbjOyBnJCAM=;
X-ME-Sender: <xms:-RUKa6jE-6neFtD85iy25b4Hf5eD_6WnaSJIEkPx5S7_1VytaRh2BQ>
    <xme:-RUKayBs8PCJ2TGPEquOAx4-1fgXMsMKSRcDf8i0zmSlvbQeqgashCZjnSMpGaCzL
    3iSCxI113frodOrTWuLmdGZ9P8xOUBgJRLi9iVoX-wb7hPJUB-9KLRq>
X-ME-Received: <xmr:-RUKa3HX7HIk05a-WfxH29OzD6CwNhNYroAVlDat77Gt5a2Nei999r3O67kyNfV0xO1nJkyGsoaedoVvmCtBl0U8xyaFIoxYsO5x42GihROAXCzkwg>
X-ME-Proxy-Cause: dmFkZTFKeMXsxS5z2D5mODU7eyO3ZHn/sLn4kxhf/yqf3dG4Ctv4nALzaOAxlGPy3u8c1w
    sApRC1S+cVwwgI9ipGfPjrDHn9AjLtR1KwNcZkXDsRad/YlfrXpxuUeDYX0+Ui32OPPjE8
    s5gJVOeR6MK7Z7cVXj7owLzzQbsHPo7eSvGpcez+utrLfIjrX4pKxGdcYxqv6uWNZ9XK4R
    N8+K+FoQ2gcL1KgCtecW+zqr1P1C4hEKmnwrBTPMe3RO8gFBSBEg8IITPkG6NRpCiCQAZ4
    qyW3liVyafNiPozSVq8E6pYLIKJB9gbuPLJGoXF6QvHV9EgQw5a44AOoAMmQ4y6xy7VGCO
    9hdCK/aE/6I+p1anrPtxa6S15vC+egCSmlj3Io1TfzI/t9vO2xEUpASnTw98aHkRdyoGgp
    rqyJF19nd+IxDcgzAsV3xzP+3AEJz/fPxYDj/K08FhiJfsQxRmEYKTU4LZHQDu44q/RevZ
    18/LAgexsliijP0+O1PuKd6SLfEYzlwv4GNXDl/ajU/IUUIHbx7aP1JP48ll2gAh+mxQG9
    +3cwpaAnKsIteDOmKEdSaToc79DvRcgQsFt+yd2tUyfZXJ2aQY64RtQL9UGxkOOXqFpbBu
    PO5Ch6nx25phYhtU0nyDBNl/zgOLTV4VBCa8WMdz95jGw9ygBg/6imDENwxQ
X-ME-Proxy: <xmx:-RUKayJPsytY8g-EZa65FH_XCm2_EjaMxvgCjMS6eCE7EV2xuPC5Jw>
    <xmx:-RUKazlzCtEHafN9xKQu6k7eGJ6SgfD1OPR9xySSt0Dq4Tc79nIJew>
    <xmx:-RUKaySTGloPMJt9NTgp0RvbRSUQFRdfCLrwemeQxuoCekYY9vrdfw>
    <xmx:-RUKa9IRnqIZ2qwJPtEjXeeD8WlBf9M0ZkwQ_mzP3IOcre9biBrduA>
    <xmx:-RUKa-lULCUt4BVlmbFml360YoFvEGKjmzgoG7tnsYh0mS-Q2G6y2qnJ>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 18:44:56 -0500 (EST)
Message-ID: <e9a048ab-677e-4d02-8a6b-c88aafdeeb20@jvns.ca>
Date: Fri, 27 Nov 2026 18:44:56 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: mention the tutorial in 'man git'
To: Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Thomas Bachem <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2334.git.1795636878793.gitgitgadget@gmail.com>
 <0db2d28c-0f8e-46b9-9e2e-b1a08213d64b@app.fastmail.com>
 <xmqqy0ad6hs2.fsf@gitster.g>
Content-Language: en-US
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <xmqqy0ad6hs2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-11-27 5:17 p.m., Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> Does this patch/commit “logically” belong to the commit that you mention
>> here?
>>
>> In other words, was it a small oversight and that is the reason
>> why it is coming now? I ask because I know that you have long-term goals
>> and are working by building on previous series that you’ve sent here.
> Very good point.  There are certain "sequencing" requirements for these
> patches.  Even without talking about Julia's long term goals, forking a
> topic to hold this patch as if it is independent from these two commits
> mentioned can make things inconsistent.
>
> Thanks for raising it.

I agree it doesn't logically belong in this commit. Basically what 
happened is that

1. I started a patch series to update git.adoc
2. I started a patch series to update the tutorial
3. patch series #1 was merged
4. patch series #2 was merged

I didn't know how to update patch series #2 (update tutorial) to update 
git.adoc after series #1 (update git.adoc) was merged, because my 
impression is that we're not supposed to rebase a branch on the latest 
master after it's been started. Hope that makes sense.

I'd love to understand better how to handle this kind of thing because 
I'm dealing with a similar issue right now in another series.

- Julia

