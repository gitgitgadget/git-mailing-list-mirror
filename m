Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CEC4A06
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742238087; cv=none; b=jaJJUvLC2vAUFHSVdNr8a3BfQGSh2jAFuIqicDHl2AF2x/ZELm7mFaMyfc2R8ZYmwgNSdf1Q/i4kvhO/GPbTf7OV8+cmvEUh9+2jB/opVG+O2JFQFxKgf22Nj+cXZf9JHPKRF1VmNsvqFtbJ2+xXwVQLWzpGEKHcbY/A3E5D6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742238087; c=relaxed/simple;
	bh=rc942rmNDc/HUcq865GTt/9RKvzEzJVbsPk28HHysJk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jqlY0Jxl1CXW+t5Psvg66Cp2UlZKoF4DdnADOUexnXcFZAZLCFGb2uXATv056UExuns+PS7YI/Xh0l4kZBOEW+TCQe6wd7naMoQvKJmJ6ta85z1nQ1swn4lKNb5GJQCKlfTXs+KUtUQ1cxRTATaKuJNmcRmCLqVi33NgZhvvva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q5pTokgQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wnSVNjpk; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q5pTokgQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wnSVNjpk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E7BED1140168;
	Mon, 17 Mar 2025 15:01:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 17 Mar 2025 15:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742238083; x=1742324483; bh=6kREtnlyVY
	ouGOWIkL/y+YWb3ZjSkrC9ymCgBHzvNB8=; b=q5pTokgQ2V5bQZC1mm18PUKQly
	JrVQndSegqza1jssuNIXxkRhHXE9jfcu4V5aUGTY1P7i3zg5wZHiFjQriakPJ7cK
	FBr5Z+GL3I6qnzcDuZNszgmIxUMUEu/IafE+S1YtzV+vnoNy8MG82qr0ZRR2GCF7
	IrZKk43GYaFTLDPJXhNGDZAOs/cdOJLylZViXmj30dgUUpOa+oDSGbM70fl5RSKG
	31rf1Qk7yKUXsnFw4/ZEr2ZwFHi4JrkqjT7OB9IO1BZtTSvpozKJZ66JBbQXh4Tq
	ApuEfhIdTld6w7NEHY237yVZyekqfpw5HN6I8oa290sGF1KiQYa0sagc/kjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742238083; x=1742324483; bh=6kREtnlyVYouGOWIkL/y+YWb3ZjSkrC9ymC
	gBHzvNB8=; b=wnSVNjpk7tRYK/i8rDLeZf6S+AAcu8/6L+Ywi9mnam8ougJjww+
	/AQN0e0GM28nKKvmrqHVnrfMlk/Tt5cy8EUIMn1UMdXRwaKILWgDj8asCm171d0x
	tRp3gI6WVn3L/3dUZJo9hIDVg4tkSmx5Rvhm795kBAOR2Mlw9Hgn/QyuIPmIiDXE
	TDgn83WtVd5cRChWgrqOpcRu7BRy+jjWrOXWECzRpdA3RVhf++LBzsmMkFR+SlLp
	Li6RmV8zVzZ53wkez5eXhNz+2WwFM9k/TLSK+x+e46NpRkKYCYmiAv5zRJRDcne/
	cjwBkQSSw6zq1qdBMGM9k4eVgLziZUOgDWg==
X-ME-Sender: <xms:g3HYZxblimq2Hw6Fzo5F6HaEE0dZq67im9fG9y-ICK7MwZscSQFwOA>
    <xme:g3HYZ4ZqM7NksoxGNq9jupOtwVzsrHpKOOt26Vs9TASt5avXkYGpdSDhSuHSW7Zt8
    IIpIFlhpzDhrAus_w>
X-ME-Received: <xmr:g3HYZz8Xgd31hxP--sKi7jUS85lExzsAHJFtvr7Palqx4cbItAWczb6AZTXWCORWIaNaHCDy_7MmCVBpLf9Rm8OUwaFnKi6MSqzAzU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhoughorh
    hovhestggrrdhisghmrdgtohhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghn
    ugihrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:g3HYZ_rr0J9KKDbtH9nNN0dVSdvrH0SwaR69IoNZ7fzF_LrEtHMfTg>
    <xmx:g3HYZ8rZslJuhN5JPFsQvIcx2gOTOdvxZum7-4CGFq6suW-YK2Tyag>
    <xmx:g3HYZ1TT8FhptPMPrK_-BphIxDJ6sE-DP_HLgIDbj5cy3Y9BdhdxWA>
    <xmx:g3HYZ0oEdVh3m580Vmvt1ypnDa1QSG1aucm7MPHpOsxWwAxhV0-6sQ>
    <xmx:g3HYZ9e7c9wkvt-zOC4gQHo7WGucUc-W6vecWwrU0M9l76MGmfbCrsbC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 15:01:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Igor Todorovski
 <itodorov@ca.ibm.com>,  Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 8/9] fetch: avoid ls-refs only to ask for HEAD symref
 update
In-Reply-To: <20250317180604.GB704553@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 17 Mar 2025 14:06:04 -0400")
References: <20250309030101.GA2334064@coredump.intra.peff.net>
	<20250309032016.GH2334191@coredump.intra.peff.net>
	<xmqq4izxq63y.fsf@gitster.g>
	<20250317180604.GB704553@coredump.intra.peff.net>
Date: Mon, 17 Mar 2025 12:01:21 -0700
Message-ID: <xmqq1puva3cu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> That was my intuition, too, but there's a case in between. Doing:
>
>   git fetch origin main
>
> will update HEAD, too (with the current code).

Good point, and I do not think it should.

> But if and only if it
> points to "main"! Is that something we want to keep? It feels like it
> could sometimes be useful, but it is awfully hard to explain.

Again, I do not think it should update HEAD.  Is this something hard
to fix?  When I say "please tell me where their main branch is",
that is what I mean.  I didn't ask about their HEAD, period.  Unlike
"git fetch" (that default to 'origin') and "git fetch origin", which
is "please update our view of 'origin'" and should update HEAD if it
is missing (or configured to be updated every time).

> So I could see going in two different directions:
>
>   1. Only do the HEAD update when we are using the configured refspecs.
>
>   2. Do the HEAD update even when we are not fetching its destination,
>      but do not otherwise trigger ls-refs to discover it (so basically,
>      not on object-only fetches). This kicks in for more cases, but is
>      hard to explain.
>
> Both are a user-visible divergence from how the feature behaves now (and
> so I did not want to touch that in my series), but if we are all in
> agreement, we can fix it on top. I do think option 1 (i.e., what you are
> suggesting in your email) is how I would have done it if starting from
> scratch. And the current rules are weird enough and the feature is new
> enough that I think it is OK to change.

Yup, I do think #1 is the way to go.

Thanks.
