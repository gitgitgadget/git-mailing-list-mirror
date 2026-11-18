Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021367;
	b=teBx0C5F6ZMphVpmIvuuASS/hwewmLpzkDr5dtrXknxRBbCVk0jwdRxjxHlkU/Mi0t2F
	 C1ybF6tTfBe5UjJV1gnv8vrx6g/yg+WkHBeXpFwk1wbsUDMOSPr0ocBi0yIorKeLZEKWG
	 g5O3y2ohpZ8ha3aps/ov1+yNhqq/s89oZRXavUvIPd1+TChWtE5qNO5NQJB/eLNGQOzDn
	 KqoGCkv6F3UrjpjOAL6tNZR6EEL/mpp+XXQ359zH/H2iS5TRa/Hdq2/tdeTZq8i8+Dsdi
	 JDMGPtsYGMV2M7a3YyJ7neKUamP3e0NpVBO+c6y0kTmkkr8+md/NVWgrE5nuNeCrcqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021367;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=+kUr8fO8MJgIIvM2hAXjq/sxw0PBqHptDhIP58FZsm8=;
	b=eZLaRribdgU4xtzC3aNywC7v8SYjgeHu8FDLHwJcjvv4dvpPj9bO8JmCfUzzUY1+mNOj
	 iO3HWEQ2ySf2Gqi9i1cZLKnRa3suPAg//YiSkEuA/ym4ebWDgGefXfh3a8gXtgOtgibXj
	 7TvwA6lZcEKHuqdpzqkg1jCYf2ld2yaNEQHlwAX8BuNolfKFwaz63Nj12fsMEdESlarwD
	 GMcEgET35n+i9+THJiJe4t4D1bUnmxPuFoM4oL0lMwUyoDl1l2VpRJ6tCHtVQkijKg/4l
	 hSuhR6I0ic9CrHP601uu6y+94SnJwdHxEwmUvZChjjd+DtJTqOLj+v0ICUnqhhr5ZiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QH5isG0d;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="k/0KdEZK";
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EBA606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 17:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0EBA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=QH5isG0d;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=k/0KdEZK
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DEC93EC05AA
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 12:02:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 18 Nov 2026 12:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795021365; x=1795107765; bh=+kUr8fO8MJ
	gIIvM2hAXjq/sxw0PBqHptDhIP58FZsm8=; b=QH5isG0dwkjAyQ1/iaJ6yB1gIc
	ECbwG8AjiqLrg/q+cmK19UwSDHAsegDyGPyUmZRKhoT0JQK7f7VGjRWtjtiCCbgN
	WurKfcrZhM4J04BWIzj0G2zOsfkZUu5LisBlyAjrqFIVHgdC09gvgYcpjok/Iy8o
	sZlFFqnLHcvlO/6SnHUeI/y9ipDi/LumakJ7nzQ64haYRd6DMhf1xvT40ZlEaHEZ
	44SLE2bYpInMHbna+eY19UyROjM8JTsJdEb7L0WFUHMBKuWOsuEpVPNIrt8jRJwU
	J2BdLOCkviqktwrTeJkI0Rc61VomvbJDVoalYJlLJUU3fKl+sT+8pMjcoznA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795021365; x=1795107765; bh=+kUr8fO8MJgIIvM2hAXjq/sxw0PBqHptDhI
	P58FZsm8=; b=k/0KdEZKBCPYo5p+hBJpJr8qymuemEdHBbTeVfj8bVuQNuKvgiS
	UTrcu8uqb+rLntI0qnwWKlwRwre1ZhE80VpGrxN5lo/n3QxWczoAIYQgBemAXMWs
	j3ezUrBqF+Zqvad3wI6nllTm2DBEu24s9UjuydR0xydXI3va66xBBZVdgFEOB5J6
	7sliT/Fnvjecf43xbeIiHAYjHZ415NAmu8W/jNH0QXUGTvVu41ILdGzHCcgTw6l8
	Pi6ShQEBJOMuNqb0GS18l537lDDil6qmW2xcBJm/ACqyCClyDHsNyChsY9eyUKLd
	f4y4iF0G4+9SDL6kFILFLhLkCITES6o0Z2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795021365; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OLZlz+TdFeh1ZU3JkoYzVGKTZ8aSGRFr4MDZxTj3maRqCTX
	KLpttklR92+nw9tqsPmc4EoQXpgFj4TkUXiJjEkF5UjH/ZwvTCTFkFOE3/+HVPLW
	1fm/0PAPt9Q81hz1Fkdrqh/I6rfpJX1BJVMKwRvmKHoYxnU/URSAshxDJVYsbYic
	701Y3PGuLCaVqaaHGHZNLQ7h4Ik50oHDPf6oSTfmAfJQMfr0y9OKflzs2ckFai8Y
	L82dfZo1zCcrS0wX6angG5qye8AFqZ6slVC7WVsbdqFLZPuEMhkK1q/y5tZdj14M
	GGXPOFl7Nbin+ZtthhFuuTtUtQRRwzzQLQSJwHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:cO/vPo0061mE1LAPsJtHCs8jhs39l52zbSkpoVHbk9A=:j4YDYm8to5XBd2bOMF4bl09j1XBOIRZNJojRoDb6U6I=;
X-ME-Sender: <xms:Ndr9arki2z9Shtof1dZm_1gNSXetnQDj-7EtX4J--jq0qx61yM42sA>
    <xme:Ndr9alvlOJ0PL9lPPNfhSRqdThzfx9PJEBd1x5UNl_pFEYokIkkytiitmjL7MFfXs
    n66x6n9DFAfR_zw3i5OlGu268oNsdjymzxd7ioxSDpTmZbsvgZ0n-Ez>
X-ME-Received: <xmr:Ndr9ap_8PwyfX4c9nMDdKDavzY9b0t0KP14li1Z3nGOiy09gKyd4n_j_HopAduZNyidGTMuYBuJJckZpf2uO8jx6hTdP5g0P90Ci>
X-ME-Proxy-Cause: dmFkZTEUAapgzvyZE/DfHmlNWfiZmO+f/9Yw1s9Iimb/yNVGdybBgWTxRuy+BRAxpz+ozs
    UBFzvtdgV3o76F4dj86zpfhkXdg/l6hZxhRfI6FavPHiIIwSFOpzVMXGPZQ/RjWpI9EXd0
    +DnKTONEomYMrffJ0fuamZsDUtxdu8Mlpj6exTJDKT+3JaA3uBYPJKSNw5c1Fc4lmGiUPw
    AO218F4f9J5RtVmhjxJvdm/OlT0TfXKjheQS6gIAiBTXagb7mGOd2howw4/Dzac1+owarQ
    CO7mbm5ocjQxRA59meXVmywiejs7AMGpFiF0S1len1G11WrKOlwEXmIuw8VE1vko65PaLz
    VBHvy6Ya3Vkp+7kumBRtdGopbKlYouaJozzX2nCcGxpNIk1wPLLy9dymLL+pZffWyMLW25
    3vfpkvdpy7xhy8FTHzm3TaOSzai0TqSBYxHaN8jYLcTqwnavAXC+BSlNpWygb0+kBzhULT
    2SfKKz1mA7PFXUeqdfeBPF32rAQOedn+FzhY2m8b2kzuvLOvbPKiHdCy6HV/EhvWHagDu+
    Sw2NWhLUTjpK0MY4w2TGpz5WMcc5nbnLJofnC2EQE9wcsPak8ounu9DSYJJxFulI4rsqI5
    Kdfh8FaXhuqZVOXPF0mK4soAKuKUWC5srvCAN4+3MWGR3TQojwo9jNqq+VbQ
X-ME-Proxy: <xmx:Ndr9avOTav5YiRC6bi3cI34K9T2SzXWjo2zOW-Xb2IfWkKTKcJUUmA>
    <xmx:Ndr9anENZ2fAFDEjy-h7EXWyZczy0u3E6ynmdl0pWDN6RA56HxTfnA>
    <xmx:Ndr9atSYHAN1bfF5AH3-zTVzr7f4AwcyEvvEZ50g8f0NP_GMaSEPmA>
    <xmx:Ndr9akvSJBbgzmrBVgZQXGkfyCftB3gw7tsFVEXtr7tzieVBK9drjw>
    <xmx:Ndr9aicm8UJqhDsndHcL9dlwwNELhnIilMXHRsoTun4Jl2AmSyByjfV7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 12:02:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 11/12] builtin/rerere: use `OPT_SUBCOMMAND()`
In-Reply-To: <av2xpF67qs6S0Hb7@pks.im> (Patrick Steinhardt's message of "Wed,
	18 Nov 2026 15:09:40 +0100")
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
	<20261111-pks-rerere-subcommands-v4-11-df0c8bf79e16@pks.im>
	<xmqqwlqcgsan.fsf@gitster.g> <av2xpF67qs6S0Hb7@pks.im>
Date: Wed, 18 Nov 2026 09:02:44 -0800
Message-ID: <xmqqse0y6pjf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > +		CALLOC_ARRAY(args_copy, args.nr);
>> > +		COPY_ARRAY(args_copy, args.v, args.nr);
>> 
>> Does args.nr count the terminating NULL pointer?  We mimic the
>> familiar (ac, av) convention of the C language; av[ac] being NULL is
>> also part of the convention, so if CALLOC_ARRAY() is not allocating
>> an entry for the terminating NULL and COPY_ARRAY() is not copying
>> args together with the NULL, this may want to be corrected.
>
> That's a good point indeed. It likely doesn't matter, but better be safe
> than sorry. Will adapt.

The COPY_ARRAY() call can stay as-is.  CALLOC_ARRAY() needs to
allocate one more element.



