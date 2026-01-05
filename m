Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E079B33B95A
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616110; cv=none; b=jFoP2/SxxXvuU36N4Z36jngWOEnl2vWTnslSZ4WXqMtagg/V1LCJEhMfbsFhGiQFcF+TPtuhIbPvWFCdxHPEzyb1KrgX9+eWUOshDq01ji4Py1fj2BUHd/H+KCX2LVvMCsE/JQYlyQdc51iEDRKWyILKPR6Sbr//DiIaZv1snr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616110; c=relaxed/simple;
	bh=IvEXFw6CpuGP+tIq4ohM2w0f3u7tdu3uDdQm25ZZbMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bl0QB65HK7EMrVza66hJFJ2haJMIhKaLcyHGju1I5AEE3N2j7xS0Lj4G+Ux4Y4nf4FDLiaPZpLgkSb96er6nWWsztISCIk759IJaO62ctMzgRKflPu2GLf+PyDgLkxCTCPQl+Mq+/oVfJZV+aSPTxdpURmFsbuOxVhBG1ed/X/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UqoVVNZE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LpnWpz7y; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UqoVVNZE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LpnWpz7y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 243DB7A003B;
	Mon,  5 Jan 2026 07:28:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 05 Jan 2026 07:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767616107;
	 x=1767702507; bh=OXokM/a4S2hpwiixSWERQVg07lRjbpnCrxjju1aOXa8=; b=
	UqoVVNZEBaOERxCCJplyHONqrHxWYV/E/1hQWveny8ALGYelK0t7Pft/LtuqIdgx
	18BJA+6hZdHZb8mQpPaU/XaSIpzExnEUwyShvqoqJTXbqppSLVddNCnnYuXH4d+f
	A1LuzZXeu04O/X+e43DZzuAd2/cD549j5F4L8/wHoE5SirLDcQpRneom5B5wlXht
	pHRomXfyRMF16xJVBAEvxuTOLS/uq/Eeot62xhRTh+mckVWdN/mBIvaUsosyCGln
	Kejou2MeAKFVU0Recf/E9DBolNwDWMWxJFK9wujeeZJ4RSDJtbBELoFKTwcamMzN
	GgX8cHRL4zAr7AuWzQk/IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767616107; x=
	1767702507; bh=OXokM/a4S2hpwiixSWERQVg07lRjbpnCrxjju1aOXa8=; b=L
	pnWpz7yf/Biz+78pntPeDkcDKAbHTzqnryYnRyRXMDJ8/CVOiQZWTE+Q32z5oOOp
	JodVkRmM0nJCeJ/kSyGyL8FQjiv5xt5sT9zl5NPTsW+CvjYtMqlTBP5MOnKMNRSe
	jFkieUt174x7UBBfgSoWtjEJsSzvKQNc75zfO382+fE2AfZGSjGdOwsQaIF+eDxW
	AXCCCvoVHrrch0YHXMRKP4EZuLPpkDvywelPJdoZzn74Qn74lcouJymu+mWjk2Bk
	S6kCCC8FjJhv2/gLIvsW+rVjmoB7/OD8F9cVYMSeHbf946haRja6WKpaI6hxMilX
	sLmybnc1CofdaTaPVgW7g==
X-ME-Sender: <xms:aq5baU9ofqXonCUCfILEuLAk4wciMQwwHJc4Y34kkxLD9EJzWMIt-g>
    <xme:aq5baTskjBa6CSsh7s8adLOPW_C2POqE8G2_aFnNvNs_ggjzbUpb5q-1Lu-Wjb-Ex
    uo5b3Uvw-2LHq2A0PTuil67lsnTU-sAQoHTYbZlMJMbhh-xZsnSTA>
X-ME-Received: <xmr:aq5bafB8hoC3UJEhTDi0LEq9S7MgEDgGCeaF8GdDhHS6QxsrDcqdAnOYkmuVxJ3EHfT_k3EFaoRJaxlcAdH5Ytv11LpaEH0INvf8M2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffgkefhhfetieffteehleehtdfg
    hedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aq5baTXg4rMr1L4HFO2z3v-oQhaX-Jwxi4Zn_OeYpCagRsuFh0L4hA>
    <xmx:aq5baVBKJsECmKGbAct16achKSlmOgR0HKZZDot6rJqMbwN3Um85WQ>
    <xmx:aq5bae_RZ9QnIENjmVPC2nyh3X98P1OqnAK8SGFEAslqR3hptDVvQg>
    <xmx:aq5baUEwEAkGnE_yT1dYg0480z97En3ZEykaPNV4q1LfwNHs7ijehg>
    <xmx:a65baSgvXeJPtfW3Imos7kRLhI0r0-fNApyYLxk4L9FHBGz6mMxzUZzc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 07:28:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: Another look?
In-Reply-To: <20260105091517.86301-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Mon, 5 Jan 2026 10:15:17 +0100")
References: <xmqqa4ysn7a5.fsf@gitster.g>
	<20260105091517.86301-1-haraldnordgren@gmail.com>
Date: Mon, 05 Jan 2026 21:28:25 +0900
Message-ID: <xmqqldickzva.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> > -     } else if (!sti) {
>> > -             strbuf_addf(sb,
>> > -                     _("Your branch is up to date with '%s'.\n"),
>> > -                     base);
>> > -     } else if (abf == AHEAD_BEHIND_QUICK) {
>> > +     if (abf == AHEAD_BEHIND_QUICK) {
>> >               strbuf_addf(sb,
>> >                           _("Your branch and '%s' refer to different commits.\n"),
>> > -                         base);
>> > +                         branch_name);
>> >               if (advice_enabled(ADVICE_STATUS_HINTS))
>> >                       strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
>> >                                   "git status --ahead-behind");
>> > +     } else if (!ours && !theirs) {
>> > +             strbuf_addf(sb,
>> > +                     _("Your branch is up to date with '%s'.\n"),
>> > +                     branch_name);
>>
>> We used to check if there is nothing to report (i.e., !sti is a
>> signal from stat_tracking_info() that there are no differences
>> between the branches) and reported that first, so when abf was
>> checked, we knew that there are some differences.  Now, your patch
>> reverses the order so whether there is or is not a change, abf
>> codepath will always report "you have differences!".
>
> Agreed! This change was done to get rid of sti as a parameter. Maybe I
> misunderstood your previous comment around the sti.
>
> I will bring back sti as a parameter to ’format_branch_comparison’ now,
> I don’t see any other way to solve this.

Please don't.  Unless my assumption, which is that in the old code
"!sti" and "!ours && !theirs" is equivalent, is wrong, all you need
to do around that part is to first check "if (!ours && !theirs)" and
say "your branch is up to date with...", and then have the check
"else if (abf == ABQ)" next.  That way, when we check abf we know
the branches are different.

