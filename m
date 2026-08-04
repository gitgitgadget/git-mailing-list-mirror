Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE14582DD
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849691; cv=none; b=etHso87GuzGlnGHBcRA9FXdtxZhrjq+/qhCgkDT/X8ba3ioMJXJ/WxhlQQImprh6KVIVsVY/IVB17nUpnLZs/ZnwXfQmzfJq+SVmEh1VVjtGs0rL+fI7D9tW+I59kepO7v6G2hHPKZbk2whPmVstSdv2mYc/A8sgAP7IzUwP4Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849691; c=relaxed/simple;
	bh=JQ4FGKIy5X6j+czr4vw4w7+SmHwKU4h14a9TGPXZRrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OugH4191cFNu+zA1NVc0YGYGuWhNCxUjQ3q+or/wcqiRkicWImdbULpJ34x8CASoMVNngOW6lx7vhURy+YGON8rXLg2HbOBop8aMAsh7OMdtlpGdgdHXayQe/uSRUtWfKTEKc35lJLZKhtygDEIayqjH6SYqNwbZ8ehRd6/OJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hzbwb3Ii; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SPO+6oqW; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hzbwb3Ii";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SPO+6oqW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 542F47A00BD;
	Tue,  4 Aug 2026 09:21:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 04 Aug 2026 09:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785849688; x=1785936088; bh=h+GuHZGJpX
	/n/NmJ7ft3VCizVktgWHTjtPg9jj6G0M0=; b=hzbwb3IiuZd6GWlWudrCEo/waU
	qIKNPQh5EF86iwEA8EP6khpn23nxSyHGbXeLnYinx6q7MFUvSXF2uxjipdLRq0Cd
	/hzTekT8HbD4bvm+RNNMvfzuD2NsolUumqX9z2vcRfHgKNkM0Ifs/Zn3RxzFFBub
	KoOlIrgRRxl2hC3iIu9PiBYFU9Nl8wG7uxETssamy7MfjwyAuvD/GN+I5EO+uhcg
	Ex1hIXF4BsGkcCgPMOdPJdhHZ4qttlgtHjXu1yPfm/5oYX3VPrSXZsUaKOBH8V+l
	kjzX3vQ1FTIZKDWZZpQg2AAGG8Z2mczIB6HSMPaZEkb69111+Y/+UmCZy7MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785849688; x=1785936088; bh=h+GuHZGJpX/n/NmJ7ft3VCizVktgWHTjtPg
	9jj6G0M0=; b=SPO+6oqW+sIlU0CemlwwSLwGBK7XTuFqPlljTGq2Cl1S6TbdDGl
	zqMABt2M+CBCwe6lprCOXt073NWefWXqvFdkQbTmkL+2PpK+KLagEMymoB6Irl7k
	bJA3bcybMIiWu/euunq5BiQ2s1SzgwPxB+jl4Sd15uo05YM1ZaluUbB4fAag/slo
	qB8Jeanv68ZqvF3f2I0mu3Q7uBd4pat5QRKvpVk4xW55AWNXRh5Jp6IroZLIaI9t
	GddUoRPMX8HYWa6GA/bvmEBA8CKrZNKZwRz9VCTCd8lwqxXFkSLlqYml0is9Pg47
	VzuxfHImJeaRHafBl+nPG+XVPcrK0WQuMBw==
X-ME-Sender: <xms:V-dxalSQIH8WKIpEvzZ6iNxSZggAQGW5xr_ICDaSk8XERhfuAS6uDg>
    <xme:V-dxaqzpsCigyNgBMu8vlBdjtKQ2FYVNud9f5SVRvZH_lWBYfZlpZxLx_XOR479yT
    7WrkCPOuxY0HzUZ5I7EXi3XkRcKrfSwPVWVnG0vVr1_wTKNTPyl9A>
X-ME-Received: <xmr:V-dxatBWl1rljCQEN28KMS2sAl7ZUXSRKVhiCvpFsNL_AJS34wtkto0sxlXqMakCpMJCg1Wpn0g4UQGPZwRsRjo_vIXSDABMvQ>
X-ME-Proxy-Cause: dmFkZTFD2ID9ORgzrMyOdBR4EiR8TQt66j8IvbO0zNeYX5akyQFeD08KfcHmeV8A4gIA7i
    F3riZHxTmvzlh8dic4IJyEr/YPHp8SPfnytA1HjI7ZJYVAhcOGfDZoiv25PxrxCin2L75y
    srL5kmNN6F3ANAFvdeHQG1kfAqMe/4PCMHg0+dM4cDp3ma/hAVlMcH0Dsvh+DaGFBg7HSA
    1ogSiJbF3Hu8IWKOpXpLcMpkeXMcCjrT23PibvM/dBsB5PWuLhi/Q1A5d+FCK/eg5nQA1B
    5Ka0o+9N8CHd/Q8A1F/yGdNRdeBQh0b020TK6nDy08qmNGsMAYoa/uF3etxVoN/dOUEyCw
    fdlB3Eb7PhA/Se/aBcaLzfvot8xVw4wSCHJvitbb0cIQ+ETMsz2uPRe77lbEUDrIEO0v77
    vOJl2OV4S/+2IH3CknZIlCOKdi8+fIPaeDz+LfQP/LGgup6itcBQ630gyxvoxQjLgKrWdQ
    nXfw4GvkPSV37fk6rz7ivpzBDP55J+3wCGsP4eNmnfxX8vnge/qw6BcsoZ5C2YTbi+t1/b
    GqMSyynN9ICti1+z6TQvnjWKgrpqhq5+o/hUnKHc4N2KNaM9jttgC3s6w/D4sKxU+OpnhW
    PoWA20vamq8wgQDZeyrCCOGqEl6n/pXG2q4PvGe3dSnN5ElfzP7izSOZxSHw
X-ME-Proxy: <xmx:V-dxauG24iSZWy3kpld3fkMmcsfQB0AfdrbxdKQFfM_8nLse9ClQ0A>
    <xmx:V-dxasPYX6EVOQdJblVPs11QFRP4jdRZs8c5U8NC86qFT0gGloX9EA>
    <xmx:V-dxan4y383F3E5Guh7mgvBHjbuqqcoi2G1IjrEZjeX8hRAa2yXYLQ>
    <xmx:V-dxanjjDYExQvbi5h5A9UpejreOQkbehu29nY7DwSkTQ1IEJT8KLg>
    <xmx:WOdxaqjuv7TB9B9VrFhbNtKugEH_GmiH2fMfaMPV7H46LYveyg0qitrT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 09:21:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Phillip Wood <phillip.wood@dunlem.org.uk>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Matt Hunter <m@lfurio.us>,
  Patrick Steinhardt <ps@pks.im>,  "D . Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v10 3/5] history: add squash subcommand to fold a range
In-Reply-To: <CAHwyqnX8Api2VWqaDt4vgnG5P9RHGkK2Bhhi4dVAu7Qrh908rw@mail.gmail.com>
	(Harald Nordgren's message of "Mon, 3 Aug 2026 18:35:22 +0200")
References: <6b5b2c93f2e3e55bf456b86a8be61f5f85137a2c.1784536024.git.gitgitgadget@gmail.com>
	<cover.1785750108.git.phillip.wood@dunelm.org.uk>
	<CAHwyqnX8Api2VWqaDt4vgnG5P9RHGkK2Bhhi4dVAu7Qrh908rw@mail.gmail.com>
Date: Tue, 04 Aug 2026 06:21:25 -0700
Message-ID: <xmqqqzkevx62.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> These patches can be fetched with
>>
>>   git fetch https://github.com/phillipwood/git wip/hn/history-squash/v10-early-part
>>
>> note that they do not support editing the commit message of the
>> squashed commit.
>
> Thanks, what should I do with it?
>
> Is it a replacement for my branch, or should it apply them as fixups
> (if so how do we handle the lack of re-edit support)?

I am not Phillip, but in light of what I said elsewhere, I would
expect you to review them as if they were patch submissions to your
tree.  You may agree with some parts while disagreeing with others.

Respond to them.

Respond even to the ones you agree with, just as you would when
giving a positive review.  Demonstrate that you read them,
understood how they work, and then state that you agree.  If you
disagree, explain why you think it is better without such
changes.  

Just do not send a new iteration without a thorough explanation of
how you addressed each of the review comments, including those
review messages disguised as patches.  Be inviting to even those who
have not been involved in this topic so far to join the discussion,
which requires you to be transparent.  Engage in dialogue.  Explain
what you are doing.  Do not let patches alone explain themselves.

First and foremost, this development community is built on humans
collaborating with other humans.  An author posts a patch, a
reviewer responds with suggestions or critiques, and the author
replies to that e-mail.  In their own words, the author might:

 - build on the suggestion, rephrasing it and proposing further
   improvements;

 - disagree and offer a counter-proposal;

 - concede the patch's shortcomings and outline how they plan to fix
   them; or

 - defend their original design to give the reviewer a chance to
   reconsider.

Doing this in your own words helps reviewers see how close we are to
an agreement.  This kind of discussion often needs a few rounds of
back-and-forth.  It should also welcome folks watching from the
sidelines, which means letting the globe spin at least once so
developers in other timezones can chime in before we declare a rough
consensus.

Firing off a new iteration before there is a rough consensus on what
the final shape of the patches should look like makes it appear as
though the only thing you care about is producing the next
iteration, and that you care much less about collaborating with
others.

Thanks, Phillip, for these patches-as-reviews.
