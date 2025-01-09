Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA6419E965
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416854; cv=none; b=tv7mrCqw9m2Fq5JUi+Swfwkhot7NH20+ebgNAKvUnLlF2FAGL72ru8L2NBzlbk8XbMHr++QWwagcvDi4NLLeYd6X4OMn4HWNbM6JUjhtyyXL0wlFEwa1jpc+VG8m/dZitgS+Y5Sv4iuSMJcYRh76PQTb7Z9jKRTtRJ3FrVYKKuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416854; c=relaxed/simple;
	bh=waPk3hPpY2i2k7TE69eun6gG6ezz+Nn1wA7ZKFvqpbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYiF//JJ/Cldz9qG5exneeVs3wqKIZyRNp1Z0FAT4LtdcYZonVqM0c3mQVrkLEDmXCuOveYO69RusNDwZcawLmE6fbCLQR14jFSB2PndG2JX7j/ZuE7UDTAyDk7XxB2al30za6wXcSXlYmx1TETJdW6a259RV/ylU8UoZPL7jQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gmbud3wu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mqUksrNk; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gmbud3wu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mqUksrNk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA89325401DC;
	Thu,  9 Jan 2025 05:00:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 09 Jan 2025 05:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736416849; x=1736503249; bh=L5xo2w9g1L
	+5qhtIA7CTHsbeIP+UqoWVujXEzuCAg4s=; b=Gmbud3wu5+sA93k6XkzFzFlg1+
	9pDFV6JFNAPQb8ugsGiCloPQX//W51X5Gq5umbkQ/Iq12vKoZKEmzAXM6jp6Ic+F
	XSp2qZuRTEBip8HV2ftsPkQsn42egq/BUuEe9u5B6LLRllvUMCwG8gExhJlPvDET
	AdDaZdXoUDnOYTK7jZa63zwkT/IpJIcviqD2MFCehdPrq/vlQMDjt2v68wHek8f7
	sYZy/WGwSwsPeZIqjtrzTv3Acy/vTrAOhepqU6UEXqkcVl1QA3C5AM3F7ieCSWk7
	LLmZpbFyNPCUMYqyrohMqaVP+Ho+pA9TzX4DztYAskmV/hK/paFkujM79oFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736416849; x=1736503249; bh=L5xo2w9g1L+5qhtIA7CTHsbeIP+UqoWVujX
	EzuCAg4s=; b=mqUksrNkx1FC5PPXpRpZhxQNtU62ht6wLyDamu2T7O2H8BF1g3J
	5e1EhJGRZt9CcxoXVJfdslLV6ZeuP0czof78kBsnZSuuZZiioH4VklBoVRr48I1U
	hcMzB58WNnuqVNGIrYBj4E2QCK+lz0tur+YMWifeC4YiErlh7wn9rsTU67GAhR6a
	iE48bWpS6LnoDP4wHQ/8K150W7TCyLhs+sVoOfHPqvAo7QSm8TO/pTPpGBRzM545
	mxihJGrITlqdiWyW3UPaY0UeDChmiEDgax7CyWh2aMX7/t/9VZKsm4lf+JpLITkH
	kruuoU/xPzLgnMcm1bt6uKVwYHTwjOmz/kg==
X-ME-Sender: <xms:UZ5_Z4YkjyRXtRX4eUr8-ZPwS4AbYwzxeelinAPJO2ifLZ7dIATGPQ>
    <xme:UZ5_ZzYNQVMM3b-oaEjh8BmoW51vAuh6F1lwbMkTdmVZBGlllv0gODuSYW9iCumPA
    7QtXYpspZnrFGoSgw>
X-ME-Received: <xmr:UZ5_Zy98ud0j95mF-oJNOoTiBn1b7oWjQ7EgnmYWszVkJpKlB2TSUJcrBqr3JSt2usAryke6CkBYIrKNisNFe2clvvFfYBVBdc6Pd4FhgKlruMjK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UZ5_ZyqGw4_hA8kKYvT5_ORbrZX_9xR14lg0uIwtGf-Zeamy0j1rrw>
    <xmx:UZ5_ZzqgxTffCrLVjMcQRQDrUyb57mdGtTZEKrgKgtoYs13Xo4qnqg>
    <xmx:UZ5_ZwTxd8__YZbxRyXWYOtDChClnmmJkOYT5qKbYDP8W0w5Ie7s2g>
    <xmx:UZ5_ZzrI6DKs2sNg-vLYsHfjlWxt_AVczlPjR51ts8EpeI-vrnn9hg>
    <xmx:UZ5_ZyXzY3TK1OK9cNbWKdfNtjUDuvWx6uoRcsztlbK3bltcT3C-VugU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 05:00:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f628d7ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jan 2025 10:00:45 +0000 (UTC)
Date: Thu, 9 Jan 2025 11:00:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] test-lib: simplify lsan results check
Message-ID: <Z3-eTDsHQ9Nu1er9@pks.im>
References: <20250107070409.GA584456@coredump.intra.peff.net>
 <20250107070752.GB584668@coredump.intra.peff.net>
 <Z3zZt2OCjcDGvjBS@pks.im>
 <20250109075750.GC2735258@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109075750.GC2735258@coredump.intra.peff.net>

On Thu, Jan 09, 2025 at 02:57:50AM -0500, Jeff King wrote:
> On Tue, Jan 07, 2025 at 08:37:33AM +0100, Patrick Steinhardt wrote:
> 
> > On Tue, Jan 07, 2025 at 02:07:52AM -0500, Jeff King wrote:
> > > We want to know if there are any leaks logged by LSan in the results
> > > directory, so we run "find" on the containing directory and pipe it to
> > > xargs. We can accomplish the same thing by just globbing in the shell
> > > and passing the result to grep, which has a few advantages:
> > > 
> > >   - it's one fewer process to run
> > > 
> > >   - we can glob on the TEST_RESULTS_SAN_FILE pattern, which is what we
> > >     checked at the beginning of the function, and is the same glob use
> > 
> > s/use/used
> > 
> > I'm always a bit thrown off by your style of bulleted lists, where they
> > feel like sentences but start with a lower-case letter, and sometimes
> > they do and sometimes they don't end with punctuation. Maybe it's just
> > me not being a native speaker and it's a natural thing to do in English.
> > In any case, it's nothing that really matters in the end, but would be
> > happy to learn if this is indeed something you tend to do in English.
> 
> Heh. Yeah, I've seen you mention them before and I've been tempted to
> start a big discussion. But I never felt like it was worth it. But
> tonight's your lucky night. ;)
> 
> In short: I think it's a style question. I perceive them as
> continuations of the sentence that has the ":". Though admittedly I do
> not always grammatically continue that sentence. So for example I could:
> 
>   - have one bullet item that completes the sentence.
> 
>   - and then another that likewise completes it.
> 
> ;) I think many style guides would frown on that. Especially with the
> periods at the end (you might argue that they should be semicolons).
> 
> In the example you quoted above they don't grammatically continue the
> sentence, so arguably what I'm saying doesn't even apply. But I also
> kind of think of the list items as sentence fragments. That sometimes
> happen to make a full sentence. Or need punctuation because that
> fragments gets so long it contains multiple sentences.
> 
> I dunno. You asked if it is something you tend to do in English. It is
> something _I_ tend to do in English, but I think most style guides would
> suggest against it (but then, most also suggest against bulleted lists
> in the first place). (They probably also suggest against lots of
> parentheses).  So I wouldn't necessarily copy me.
> 
> My general feeling is that unless a commit message is inaccurate or hard
> to understand, we should mostly let it pass (even typos). Yes, they are
> an artifact that is enshrined in the history. But at some point they are
> also just a written communication between developers, and we all have
> our own voices and styles. And make mistakes. Polishing them is
> something we _can_ do collaboratively, but there are diminishing
> returns.

Yup, agreed. It's a minor detail and I'm happy to gloss over it in the
future.

> In case it is not clear, I would not say the same for documentation,
> error messages, etc. Those are artifacts that hits a wider audience, and
> we have a tool for polishing them together: git.
> 
> And people should still proofread and correct their own messages before
> sending. Believe it or not, I do always take a final pass when sending
> out my commits and still manage to have errors. ;) A lot of times I end
> up improving clarity and wording on the final pass, but end up
> introducing a typo (I'm pretty sure that the use/used above was me
> switching last-minute between "the same glob we use" and "the same glob
> used").
> 
> Bringing it back to the example at hand, my assumption is that the
> bullet list capitalization and punctuation is mostly a question of
> style, and isn't making the result hard to understand. But if it is, I
> can try to adjust. I actually wrote a bulleted list in a commit message
> earlier today and capitalized it just for you. :)

Thanks for explaining!

Patrick
