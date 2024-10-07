Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8A23AB
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 05:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728279050; cv=none; b=ARS4O0y0VoxfhkeCy7UDO9P/g9PBLdltWyWdf/Qzp0iNjm5aMZBdOhakIU0LOzXA0v6RegHz4mlnUzXWiPnr10xzPIH4gmpoMK1NPALEL7tkaQzTGz1S7tAT+eT8wJyiLtAz72UfzD6qh1/QcM3AsqFCgcxm46I2TbTtMxzvUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728279050; c=relaxed/simple;
	bh=8kywMss/TWI92TbYPkx0toLgkGW8oWtnuf2bBf+HfKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkHUxzYVjYXn3LmqqvamUhkFDWluYvKaFHle0ClrkvpGGbdGkzY6u/48rDz+iEP4NGuvKusnxwQ2J6+aE+8G0Pr1ocCBWjvQU5auL5ufoM234wwqfU1nqu/TXy4QZOBHyey1AM0pbj3SwfYkCiB7QyI1mAjM6cZLfNx4adLGYhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fh/8+E9b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nW2Fz7km; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fh/8+E9b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nW2Fz7km"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id EFE0A138033C;
	Mon,  7 Oct 2024 01:30:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 07 Oct 2024 01:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728279047; x=1728365447; bh=8kywMss/TW
	I92TbYPkx0toLgkGW8oWtnuf2bBf+HfKw=; b=Fh/8+E9baI65VphRbMhABjXxEJ
	g+R7nI3zksErldzKXBVQbEE8YoRg5nKs7/J7Pk6gZ1vqn8N7onMhaXEyLtMSVD2j
	OCzIpM/ZGIR8y/YSUWmMsmUHquuwBf2NgYvMOmTpMlpufZ2ePYbI2nvmINOdOmf8
	Q8+J85DhO2NKW79Q7FmthcZOeORUHIPVsZUUecsB/b2tBn6wisNGNmLo12e34wgo
	N39hQECyHCPAwKOq7PVqaJnU5Irw3KSoJIfb+lUpc3L6V3MdUcYImtopn1cX5rA9
	/+H92kz/2d/jTtxYcsrCWkTvZP6054w+ptUOrB2HpD+s4YsmAdWjQd0M1P8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728279047; x=1728365447; bh=8kywMss/TWI92TbYPkx0toLgkGW8
	oWtnuf2bBf+HfKw=; b=nW2Fz7kmU7LrNKz3k//3u52tq8mTyUN4qkRo6T9JbVyb
	yaWH3BKYmK9iI9oaWPZhQ7S3Y/hFQbjj92/THeZLxYRI8NQIH56DhgqpTAHRetvx
	QMwjSlCfpThBFYadDV7DSajBPDVquH3jh+/eYELogxl1wgbhMamURKdzph8vr3ky
	vXzT2JsbefVxJG2FiSKy4yCYeYxdEi+rBtL0srRM7suoJ1I9kp3vx/x92Si31zmX
	OpSMIlrdGYSAhhUbNly3yEsogwTTfY1n8QNCSjTdh5c1pdG4c//Jn73BXZkbBfjB
	5LrP0QkYyZiEMXAIrZn87fTBgJ1+j2DxE33WADGjLg==
X-ME-Sender: <xms:B3IDZ82-XUR2_Ef75br-KJ8FOrjtcVpSsQdkDI0wnuIkVNPJX9jF6w>
    <xme:B3IDZ3GHSEg7fg6gHMaXrLiyPPUnj9zjT9b0sFwbfrTF19FY1gpgF3Aj74IjgUrh_
    5soAPPQ4W-_Lnh4Jg>
X-ME-Received: <xmr:B3IDZ06JHcJtn8QOVgI55loXB_9jsECTTGByE5f3Z6HmwbTwpSUffNvdg2E1HeaJclk28IakkucgXnKxl0Ca3Ly2Jul1gR0snfv_kfNLoGcGr64WBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrmhhmhihmohhrvgehtdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhm
    rdhorhhgrdhukh
X-ME-Proxy: <xmx:B3IDZ132uqzU3RmMiQLxes2xHhVSDPOsLnlZUo7jLBkyfJ36qqVVng>
    <xmx:B3IDZ_E38oS9dxcA2WdTMTk_GoCZR-FZgGGvVBL0LX4HCjXm7IlVDw>
    <xmx:B3IDZ-_zdkq84NXzwickXhrrg8Q7-WTeNKU0nKjfiHZt0MsRHC6q1g>
    <xmx:B3IDZ0kowCgXFwe0ODH4tKN8PEXGUnrm6bWv7X6AFGxadWXNawrVJg>
    <xmx:B3IDZ3BIChNxsEqDu2UBWqcVu-Bt1LK_zy_tZeKatxw8wzTv0Jlh-fNL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 01:30:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f454b087 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 05:29:46 +0000 (UTC)
Date: Mon, 7 Oct 2024 07:30:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Abraham Samuel <sammymore50@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [Outreachy]
Message-ID: <ZwNx-sKJJNDQ4sIC@pks.im>
References: <CAO1n884e13_9FZDBtcFrwU8oCyv+0_WUT-c16qN0W9c+D6k2PQ@mail.gmail.com>
 <834250ef-46ec-4667-8e41-e427472fd623@gmail.com>
 <CAO1n887uu5qUcqLcdKfh8FBKJAQUCGqVOnAzX7WWiFEnuuMF3A@mail.gmail.com>
 <CAO1n887hN81j5h12t-6xpNQAQ5uOx1wxLz48c+O4hZE-pWdY8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO1n887hN81j5h12t-6xpNQAQ5uOx1wxLz48c+O4hZE-pWdY8A@mail.gmail.com>

Hi Abraham,

On Sun, Oct 06, 2024 at 10:57:26AM +0100, Abraham Samuel wrote:
> Hi Philip,

one note up front: we tend to not top-post on this mailing list. The
reply to an email should either go below the quoted parts, or if you
want to reply to multiple parts of the mail you can provide your answers
inline like I do here.

[snip]
> Please kindly let me know the possibility of doing these microprojects.
> Thanks

All of the examples you picked seem valid. You do not require something
like approval to work on those projects, but it would be nice to check
that there are no concurrent threads on the Git mailing list that handle
the same microprojects. I'm not aware of any though, so please feel free
to pick any one of your proposals and work on it.

Thanks!

Patrick
