Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A13137750
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839393; cv=none; b=PKTWIlH0VDhKsq78WU3rbEd7JWCkVr16SRrcidC4Bmp6Od8sidCXPOu4Brc45qFqns1+m7fMYiRgMq/gYoqBGwdD1y28Y5jfsD6F+yXteoCr/1sjF8JVIPFcRdjEO6e5m0bKCr9FSsmn98TvV7SkNzbGnZjJoRSV+VFuwT7pyqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839393; c=relaxed/simple;
	bh=zV75DqjBS9zZEdNgaDU/Qv3kKXQYBGtOKe5lbG8yB64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq8XMJ4bDIxsux64qqP43TUO8T4fF2imzqvv8j/E22sjlSCGiuXIDNdioyMiyTg7UHVbs3PgdBkAkOr4q8UiQL0KYbTWk3YubCbTClI3TwWDfzdWd6oiIhYwBoBwYnR90RpUwFSgN/2YnxRynwzoEhCMZ3f0GNBmlJLImgLVxxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q1omWPjd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ir/OuM1G; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q1omWPjd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ir/OuM1G"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3BBBD140012C;
	Mon, 23 Feb 2026 04:36:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 04:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771839391; x=1771925791; bh=mdfg0fmEz4
	LldtmWcQZ1sNnKqatKuW6evsuNwif/gUM=; b=q1omWPjdsacR0vffhkJRUL+IVP
	dqWZ3CfGgilCB4+IqFARwqxYnZY4ywOKKYpeSs99RLruaiS1Di/OK/f3lvhl5Qd7
	COtTHwKwFUKNNA2+uUf4cSfS7eENqqjqRz7FoK4LBHUrnBfvkyi2sh7XjOdzCWWc
	IQZ9VuiXJjAKM6qh8JRclxqyKcr3G8Sma0pNWkuKJeK95x9+N8IEAeB0DrUNHBXo
	Fft/eowrrYmoVOCIPcUKwTkhlO7oyeoZBrVBDxbzqQ6IkYl1iQlrcpayC8EVwyXg
	5/g6qXcPP0Y9/qIj63f1E+BmSTdgYNYlb4Iy+1RBNVeCDC1Kve1NxEWZc1Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771839391; x=1771925791; bh=mdfg0fmEz4LldtmWcQZ1sNnKqatKuW6evsu
	Nwif/gUM=; b=ir/OuM1Gpx7Ts/Ep8ZaRo1zQ5pWj/h/+Xs6oox+sj0xoeO10hOe
	J5PeyJXhMLfRmZsDJnPrRCX6f/Kqd/azsGQ+Dxorx+VlR1hc0nVoa5WIwaXj+dfZ
	2reSoRy8ivWiwBB63J/stMlT2YrJZloi/ZsLAHSxiL7uFT+tlqyudIKJKOboUt6c
	4kljo3HckRImqbcy/GNfKkIFCKfd7TixBXqf3O3SOclRt12GtyLbuzZoRfVuVHui
	OqBiEhlvqRdvGnKAP5Kp/t+e+uKSt/+Lh4W3Rga5YSIbDtjsDDxHl+wiVD2Dwj/p
	Jk9SHO7klodLocvzFbdT4h9E2hIL/1cjRNw==
X-ME-Sender: <xms:nx-cafNKrE11NO8Lo9UfdNamdfhq_L0_itz8tOPcEFHKzm3xEVbecw>
    <xme:nx-caQ_85BL1Y314f_5LNgYSmVbX_DgaJFgbJKmIL79yEmM-eswyZ_qx3RZE2Sy8M
    vQ_kXkBwOPRjxv2WJr9FfsxW13bVHxTZNJ4D0FIqJ_KNiI2AjxO>
X-ME-Received: <xmr:nx-caTTaspMTdm2BULELyCWb18bmelGDPb5mslJZPYeTq2LWrNHi7BhUP7_56ANJk2rFxogtLAtWchFHxMmAXtoeJiTnVD6-65krBxePOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeikeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nx-caSmuQaxPgyS82jo6Nnz6_RK4bOwwWj70rqgv3x71maxKJXrA7g>
    <xmx:nx-caTQzfSNhF_OI9Vn1mTThohxcGtZhzJ3HdixRTtgOxRzNL8ax6Q>
    <xmx:nx-caQPT1TLBOgJnD_PskeNGKGRFMy6e5m1UdBDSRQ3GGmV2SAh3Qw>
    <xmx:nx-cacWdTml-_Jn1RwKzeGzc8PmJCWaT39XA1LcAQYTb8VkPAayO0A>
    <xmx:nx-caYQ89FwMfeuC1hJeedC6jCJMPOLw9t0hCGxdcsNbnFQParSgakvo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 04:36:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c6d4eb53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 09:36:28 +0000 (UTC)
Date: Mon, 23 Feb 2026 10:36:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] fsck: do not loop infinitely when processing packs
Message-ID: <aZwfmXG113t6OsUH@pks.im>
References: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
 <xmqqv7fopflu.fsf@gitster.g>
 <aZuMPcMYwFi4Sch5@fruit.crustytoothpaste.net>
 <20260223071215.GA136463@coredump.intra.peff.net>
 <aZwTyLMWbcXWnYhQ@pks.im>
 <20260223092523.GA209277@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223092523.GA209277@coredump.intra.peff.net>

On Mon, Feb 23, 2026 at 04:25:23AM -0500, Jeff King wrote:
> On Mon, Feb 23, 2026 at 09:46:00AM +0100, Patrick Steinhardt wrote:
> 
> > As pointed out in [1] the root cause is actually something different,
> > and we merely expose this now with the MRU-based iteration. But I
> > wouldn't mind if we eventually switched back to maintaining two lists,
> > or finding a different way for how to maintain the iteration order.
> 
> Maybe I don't understand what you're saying, but isn't the root cause
> the same?
> 
> Code is iterating the list, and then during that iteration calls
> find_pack_entry(). The fact that fsck only calls find_pack_entry() in
> some subset of cases is immaterial, I'd think. The risk is always there
> when iterating now.

It is, true. All I'm saying is that the problem runs a bit deeper, and
that fixing the actual root cause would also fix the issue reported by
brian.

So we might want to have another look at hardening packfile iteration
either by reinstating the second list for iteration or by extending
`repo_for_each_pack()` to also set the `skip_updating_mru` bit. Over
time though I'd rather get rid of `repo_for_each_pack()`, and once that
is the case and packed object iteration is neatly encapsulated in the
backend the risk of only having the MRU will be significantly reduced.

Thanks!

Patrick
