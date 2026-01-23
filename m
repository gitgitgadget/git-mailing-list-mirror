Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC27261D
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165892; cv=none; b=DMk6D5KGuZPt+Xqd/FF5yUheEwWuX/IgyUx//f6po+PIdY98pnALc9cWQM5BLE/jwDAb1Vk1FFnBY53uPAXlF1+7tjBfb677ujvcovSfpkCDuh8BKYTUEvYeXUFUekqKeKks8rp1N+JSHqbLHD7y1B2S8Rv5u9mRYfT9nFq/YR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165892; c=relaxed/simple;
	bh=Lz624yylIgSFPG/vhpxMmeGAvcjZZOX7ioLjpWzAHfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrdkdgITuzbSHjmGX8GXCqCboZ8yIYrMI/ZMkT7KjUGv8nsxW0bjJfwklC6io5zs/EGFI23jm6+NAMIjmUxrkucW5DezpPGcDHfZPO7H7EaoKrJyoW6qFrJ8KYSy/zDr9kIte455mr2dKaWUAZEZm6Vt/qrmg/OJkmEX7rhdzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b1HwQvVh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hkUfGJrj; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b1HwQvVh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hkUfGJrj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 44A4E7A0068;
	Fri, 23 Jan 2026 05:58:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 23 Jan 2026 05:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769165889;
	 x=1769252289; bh=gAFd3XaV9SNNoyGDpiJ084U8JhT+QTLYh6J3uRrTlLY=; b=
	b1HwQvVhMQb1uUlfe3SQ3D8SJjF3lWJyaTzqDg858K3g2BmEyB+RPCA25p+MJACX
	Hke+PPtslzWeR/tEspVWCVXqt8aUuLMuNzBBJyusKsUXX8LIYJA6U5ufZt6KvSMV
	y9FVfpGJCrJqZrWUC4o1FOnSdMTow3e2+KFtg4ovWVwz2fEwqZ/Hu/YCcvO6Dpms
	q3HxAC0Hx8MwQ61U+FASpSKKR9RpRcaT+ccdHwPyryaUkgyOotYzuiCQ+qSiDEvy
	lpK1quFHhUmNN8an7h0+XWzFUGDpTp3ZfBt/iu4SaEX59IiCwj66aTUnhaGhGy8/
	5pGsADzLaxuyxqn2MOL6Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769165889; x=
	1769252289; bh=gAFd3XaV9SNNoyGDpiJ084U8JhT+QTLYh6J3uRrTlLY=; b=h
	kUfGJrj/+NpJ93P+kB8daOjKH+5kprB7PPP4B7/DNUGSCNaAYCwsmlm2O6g/A3Tq
	agxfCWYZ+QeoaaiRpdeE50DhSgOzqHSkEzm14NYK02NGKiFjZR4257v2s69Mvysy
	mLd1P564SWOepgiWr+SBOsXFrDftjP2FEsat83anTQWnRlnA28mDJbe4Uzm42meB
	MABcudnTsjE+wGwggEDlGebYFhGPXYDMQZk/+85KKM5O4CT7QK7heBCnXfPBz7ti
	rCnIIlNOk3tPflu2Iv7HIfntMg780Yajisq/cPvwAwr7+leac55e9QSdfKAiz+1F
	8Rzn6RSLuGib3Yn5PXbYA==
X-ME-Sender: <xms:QVRzaQjnQEkkfrXXbAmP_RxfHofxyp0aXYRtEmEfKGJAIHg9UzDo0g>
    <xme:QVRzacvPBGNbfmabdFYmJkwzXuTI3t5ei2mdMEIn2rQGd8up2kLHwGuUJ1MT2JIST
    EArAsIB8W-IPmoa5ybh74Zy3Tbs7iq4bLJAuxkYrd7abMZeSn6ERg>
X-ME-Received: <xmr:QVRzaR42pF2NjOoV05i8FLiUC9XIH6SFhcfzTeVGRJCvZoM9dO-KHXie2P9BDTQ0AsOomfihQQEnP3Dym3LuutPkCOvI0T5gUEVogDFR-Au9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeekkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetheffvddtleettdetueeukedugeettedutdegueeukeetheefueevvdeitddtveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QVRzaYNuHzMaZZdBjXMJcG6QtcSA1qv---0WhoZ5h8k44AImg32cfw>
    <xmx:QVRzafuO5eLQ5Fzy2j4PqhWuG_f1BTq1u5vj70TGPp2Ll2iPxc8W6Q>
    <xmx:QVRzabaBx-JpzOzjZJ95NBQt5frkxFHeUTF6LZxsRA0wDmq1ZzRFLQ>
    <xmx:QVRzaRw1TEMf3N17xgMQbVA1DFGGmZy1Z365Px5mnAp0W71rgeDgkA>
    <xmx:QVRzad8-T1mat1meFGXGyfH3L0lg6ekqWd_c8V-H_Jm1Wx0MYWoZBTdI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 05:58:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 92ccb376 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Jan 2026 10:58:06 +0000 (UTC)
Date: Fri, 23 Jan 2026 11:57:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 02/14] odb: fix flags parameter to be unsigned
Message-ID: <aXNUNJudud_KuT33@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-2-12c4dfd24227@pks.im>
 <20260121211128.GB723458@coredump.intra.peff.net>
 <aXFosXv328ZPjlcw@nand.local>
 <xmqqcy31pscg.fsf@gitster.g>
 <20260122192337.GC2098026@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122192337.GC2098026@coredump.intra.peff.net>

On Thu, Jan 22, 2026 at 02:23:37PM -0500, Jeff King wrote:
> On Thu, Jan 22, 2026 at 07:41:51AM -0800, Junio C Hamano wrote:
> 
> > Taylor Blau <me@ttaylorr.com> writes:
> > 
> > > I agree with you that we should be using an enum in these cases over
> > > unsigned for the reasons you suggest. I've stumbled over this in the
> > > past, so perhaps this is worth adding to the CodingGuidelines?
> > 
> > I am OK with declaring our preference of "enum" over "#define"d
> > constants.  The only two minor hesitation I have against the use of
> > "enum", especially for bitset but not for enumeration, are that
> 
> I don't think there's any disagreement over using enums in general. It's
> just a question of what type to declare in function interfaces.
> 
> >  (1) enum gives a false sense of type safety to casual coders. If I
> >      have two enum types and pass one to as a parameter to a
> >      function that expects the other one, would the compiler help me
> >      catch that as a potential mistake?  -Wenum-conversion is not
> >      enabled even with -Wall so I am assuming that the compiler
> >      folks fells that it is not reliable enough.
> 
> It is enabled with -Wextra, which we turn on with DEVELOPER=1. I think
> gcc will catch the most obvious mismatches like:
> 
>   enum one { FOO };
>   enum two { BAR };
>   void func(enum one value);
>   void doit(void) { func(BAR); }
> 
> which yields:
> 
>   $ gcc -c -Wall -Wextra foo.c
>   foo.c: In function ‘doit’:
>   foo.c:4:24: warning: implicit conversion from ‘enum two’ to ‘enum one’ [-Wenum-conversion]
>       4 | void doit(void) { func(BAR); }
>         |                        ^~~
> 
> What it doesn't help with is passing arbitrary integers, which includes
> #define'd constants. Swapping out "enum two" for:
> 
>   #define BAR 1
> 
> will not produce a warning. That's the issue that I ran into with the
> color code in:
> 
>   https://lore.kernel.org/git/20250916202748.GM612873@coredump.intra.peff.net/
> 
> Unfortunately bit operations on enum values seem to lose the "type" for
> the purposes of this warning, and just become regular integers. So if we
> modify our example to:
> 
>   num one { FOO_A = 1 << 0, FOO_B = 1 << 1 };
>   enum two { BAR_A = 1 << 0, BAR_B = 1 << 1 };
>   void func(enum one value);
>   void doit(void) { func(BAR_A | BAR_B); }
> 
> it no longer complains.
> 
> I still think we are better off declaring the flag parameters with the
> enum type, though. It will catch some problematic cases. And even if
> there were no compiler support at all, I think the hint to humans about
> the expected type is worth it.

I don't care strongly enough myself, but do you or Taylor maybe want to
send a patch that documents our preference? If so I'll be happy to adapt
my series to use whatever style we agree on.

Thanks!

Patrick
