Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D93B8945
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465101; cv=none; b=KD5aTBs6WQanA5Oi1Lnfw9BjPTJDuio6EDII/KV0UwetbVEGbppjn5ektJ95dO/PF79mZaGVdjPB+GyALUw+H0bWgyC8iFWmPIdLap99M+HevK80FoXIXFgtr5dYsESogwEVN+bOrwADHLVMTnSsW+ULZ/pgAjqt9Pb8qY9t6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465101; c=relaxed/simple;
	bh=UABcyiHyvTawAceQFyvgxL8TCuQslU4wLLwFftWxtR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUqQBur6dtjZcSX/TRDIwtZeGMLwXH8SPfi7pHeQHHIAyP1xXDWTPxmFtbc70Q1urXKWemZokbZ5kZklZV6vREF3rOT2OWKJ4AhTyNLVlJC2d3tKkoBlJneANNm2Dk+WbbYgzo966Kan3n3eJdlYl0h7PcwAKtC1GSGwKLTRYaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pDyItzTL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OvLO4Eri; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pDyItzTL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OvLO4Eri"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4458BEC016D;
	Tue, 11 Aug 2026 12:18:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 12:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786465099; x=1786551499; bh=0RrCWHCGRV
	11biZJGbNSvR/DNali0BbwNZoTyp5CrNE=; b=pDyItzTL7XSMXtyMBjPgInX4lF
	H9r5sssnf17s3vRkuaqETqUJQ0+bcOF0FPrWC+SbpIruM2P9kjGaksKq+fA1P3+i
	GoGwvMtO9lrsBrOo2r2YDC198EZgKK/vInEoVP50rhQPguFAPByAStT67XGJh5ng
	cC9wu7D52j27g1xJnNl1WEBUkuv5NPxh2SesT4KRAXQ5udXydwFSmVHHhO9wQWfk
	EePsNhJjNK91uAtmmKDqkglqRic2kJqaWrOiEObSP7Zk/+VjCGFm2dJQiT1a8BiJ
	80iUkpvX03tATmIq/XBrSSNPBzQuHfzE425UPfpYJId9RoOqjVXX9KZwz1cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786465099; x=1786551499; bh=0RrCWHCGRV11biZJGbNSvR/DNali0BbwNZo
	Typ5CrNE=; b=OvLO4Erio0phSco9K/YIjoz9/kUu9ucCNU7VcAP/wD42B1OM7li
	FTTwR3sp/b+eBkMtdHE0HU4FW6l9CD+vZZdvjgAtA8JXLtAQBSV3G988ulc5Ppr+
	gqTsxQ0/JqoHkec5pPGWibdLJiQVOg9Wa3wm8CillTzZFTJ4Z4Ll1JGryjNmb0bN
	nPnQohNpIG2LsWCkASEMoUS+NXvuqWNOYaK1e7MwsD+bj6cf5vsgiPM5gxsKbHFK
	uPhaTPxEbpK7crhF+Q3XSdV9f2kJOpeS0TKpG2BL3afEYtpzDxvZlDRvDcoSzE8P
	hyt2n9OCSqm00FloDp9mkvorB3zWgAQNRvQ==
X-ME-Sender: <xms:S0t7amWVd9fYOKvPBR3WfQsdbwffpDanqDnWhQF3aReMA_fAxZhhKw>
    <xme:S0t7apdAbJhfqbvVPfYdRUan6HL5tKNxGx1iJqjE0qbXRrvqdKFnf0RKdJqDgzh7E
    n2iKTKy9lfXElNM6SyP04uJEAH0lOBdNhU3w5ipjUTV0ThCq8v7Qg>
X-ME-Received: <xmr:S0t7aiu9ZUhSh7HN_xVd06rDpjaoQ9El7Qv2x5qcmYVM9DHrsYUU0nYP9GedmwzcFHtdjK2rvzRHEWbRKXn5UstlphUiDMSdEboXEqonlA>
X-ME-Proxy-Cause: dmFkZTFKET5OXYsu21O06OnHSh2ze1hXHjBMBraJeQV6THcB9SNhRvG6VZKpcKbeUtC/x/
    By6qSlbld+4Taw7FPkHrT2hHORtLSs1xgN9myvTo3+s0Vi5FDPbdCXPYh5cKsib16doh+f
    g3GJG5lkbtzcM+ubUySBYEPnslY9J8TQfik7VRNS/lTB9DuJgoslXIqmWbDePXvOgk8ETy
    LD33d5+AAfVltIpYy9gIetcNXjrTVRJXXMBJmlfXK+ga63IU/b0P9GrOJS4bQBGJY4xd65
    /5Ydp5YtuP9407ajhTDikKD1l3wPARhj+GEzVlxroGjQyd8IGCqlg7tH2ekBG8gKWIwaT1
    NBaZFiM6ehxO0nyf38z+ZkPl81ebtf3jMnBWzGbo13uVsYbwWuTpvMSMR9kzYH3DMjqdeL
    Q48gVzZ6mWCTJuWg/9MxLlIwtT61A+8FsJvhk084L8VVh0NAIRX6bWVxlABIZdKd23rdqj
    yjsK4II+2DpCW7Hrsooz+UZt/hIErdMRmJ076oJhoZA5k4icn9U2UD1RBu/QyjEK56f8L7
    9Fn59o94c1fTT4pTD8mal93MenLjCeW7Vp/6J8lOChPmX3foa80D0nzanyNlCfnrmjxblw
    q9kGJm7yM6WWlV67Mtw1xSHVBmZAQO7aOiu397td48nOlGYBsMzOiWJbnItw
X-ME-Proxy: <xmx:S0t7ao9Xi27b-B3l1f76ibBZptBU9wWpKHjgjkrsxbcT17bzWkW3pQ>
    <xmx:S0t7at1-6DC-Tths-1-uKmM9gI7Zo_KIcjjAyNZ9H4ynhVLgXMVjiA>
    <xmx:S0t7atDrsFKsgNyTj8ZIh-RJx05_gAGYdRaKTypOMZdUUt00s4l15w>
    <xmx:S0t7apePKkOEcjHWCJ1WJfA-iGmV6oXILVYScp06Utr0J49vWxXseQ>
    <xmx:S0t7ajcVfDwwcUFqFZIndzTsPuPodFqzAmugk_lspDaldao_05yS7OHV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:18:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba469861 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 16:18:15 +0000 (UTC)
Date: Tue, 11 Aug 2026 18:18:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Ted Nyman <tnyman@openai.com>
Subject: Re: [PATCH 1/2] maintenance: account for promisor pack geometry
Message-ID: <antLRFfKMtSLaqdy@pks.im>
References: <cover.1785902237.git.ttaylorr@openai.com>
 <a9de123b43efb58c53c99c71eb7e34f29e075071.1785902237.git.ttaylorr@openai.com>
 <annqJGFJPviEyfEC@pks.im>
 <ann0nnSGfSJ7y7YK@com-79390>
 <anry8wAbkxNfVgfh@pks.im>
 <antEnTVfHFEGQQZ_@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <antEnTVfHFEGQQZ_@com-79390>

On Tue, Aug 11, 2026 at 10:49:49AM -0500, Taylor Blau wrote:
> On Tue, Aug 11, 2026 at 12:01:23PM +0200, Patrick Steinhardt wrote:
> > > So I am not sure that I understand your concern here, but please let me
> > > know if I am missing some aspect of it.
> >
> > The concern is that it's quite unlikely that both the geometric and
> > non-geometric sequence will merge all packs together at the same point
> > in time. Consequently, we'll never hit the case where we perform an
> > all-into-one pack to prune unreachable objects, and that may cause us to
> > never prune objects at all.
> >
> > So what I'm wondering is whether we should be a bit more clever about
> > that and perform an all-into-one repack under a new condition, like for
> > example when the objects we're about to repack exceed a certain
> > percentage of the repository size.
> >
> > Hope that clarifies it a bit :)
> 
> Ah, I see what you're saying. We should still be OK here as the goal of
> geometric repacking is to converge both the promisor and non-promisor
> packs towards a single pack, at which point we would do an all-into-one
> repack.
> 
> If the two are perfectly out of phase, then this change would prevent us
> from running all-into-one maintenance. But that does not seem like a
> likely scenario, and the behavior here should be a strict improvement in
> the meantime otherwise.

Yeah, I tend to agree. It's heuristics anyway, and from my point of view
it's something that we can iterate on going forward.

Thanks!

Patrick
