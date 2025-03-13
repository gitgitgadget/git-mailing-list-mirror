Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC19537FF
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873005; cv=none; b=nplPwXZhJw/O9ZPlOEDeWu7GwxKdPsUvbthil7HLMmpPPjload/MT4NaPJemPICjOdvUq5fdAG1X/CxsLN6lJlsrAl4eDHqkDfYBQe3aParOgL/+sfjcRhG/UuFdSRmZXHwPJGNfuFWVtHgBEPQ+ijSI8lECwFuYXUo+LFbnT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873005; c=relaxed/simple;
	bh=BGMA/TyV0QwDiAK6olCRSJyF7LPMHW8e2IpXbdVTXfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VIOT1jW3LDh2DbYrsP81I3ghJYUSA7cZHeZB23ykbu6Qagf9B5bwHO25qwtSNN9n8iZmUYIFaSZCuj7pEtcHGIp9+eoIGelfsrTedBobF0VY68aMVvmjz0MpwkB7+kIHJL++Ok6xxoCQoFbwNlCNewtShiq5l/+GzxJBJuK6a0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Iju2S8b6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2Mmqi/uQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Iju2S8b6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2Mmqi/uQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A3D681383168;
	Thu, 13 Mar 2025 09:36:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 13 Mar 2025 09:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741873001; x=1741959401; bh=fUFYzzT0nn
	/D71owpTpMFAbRRJE9lbfAb3II0qriaxc=; b=Iju2S8b6xUxuicF4+YqRwy8LJv
	4SRytfNQJ3TcuUUg1I7SjOgR02M3sS21uzbqgLXWdEVtTRdqAfZIhPCdba5ExL7t
	Xt/UJuUB5zNJ1ddN1lJLIBHZYNVPYrUeWYn5jsEI9Sp70bLYnhAk5DqjgOhHZSTO
	/YxBX2SAGw4cf0anwxZqBix4H9838j7fjOaxhCPR+o5J5MooAGVrHOCILFd2xfmP
	zfjqU14g5aXwq76FXSXhLqWwFwfsX0dPQfN7wmQgzyC7pd5J/Q0Pko/0EC+BU1m+
	olYxDPMrI0oAiEBt3JOI5C7DHmMOdAq0igwvM7q5kW8mKbISErl1RLcVmmgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741873001; x=1741959401; bh=fUFYzzT0nn/D71owpTpMFAbRRJE9lbfAb3I
	I0qriaxc=; b=2Mmqi/uQvI7fekJLWecWnTWK7WdKvpJvvPFJE4n9J+tF2SaHWGu
	ZFdsuTSjkN5Z7YXM6epc/vAVqeKEz+TqgY8I6fOOWosuRCVoNSrBtJidx4n5fTje
	pcSHndFpQFjGenWLmotndXqJSvimp6Tyo6dQ53BzJF896LxF6KEZYLVR6CpYkvZ7
	/sKWpI/fvv+TVsUF6gwgRqO7N2UV0jJMZtcEdR9/UgLMwgCNGFz2MJvxI9GvvKay
	iG3v5CkkSnmg6R34v8yRLZk+xRhdf3pAS3H0M6s2bZlcJikOdFdQZs7tdpTDPcCC
	2DKJD7G3sT3qvzUmmMPwbvs1edQ43UsKjiQ==
X-ME-Sender: <xms:ad_SZ1O6VUrdi3Tqgt1y2mK2FCXR-sH1Wd-24RneBsGIbBWuIWydjg>
    <xme:ad_SZ38DYbJkbwaDDcDq9cJKlQPVJ8Zo7BH2u2d3Avhisa-mUiw8w7VxjLDsYYKr-
    RyRFVdX81FIBXPelw>
X-ME-Received: <xmr:ad_SZ0Tv5m4kxkdAqmMHgIOefGsHkPOqh0vl1xTOjvohsUK3nB9_NYY2nesMr_oC0e_zhLZPUamfOp0z97E5ScwCWYfcPMPFAJZxmps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehsihhmohhnsehjohhsvghfshhsohhnrdhorhhgpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ad_SZxtk3oJt0Cx0-jedU5JiaAJOwzQi59OqVlYcOtFJcmaECF_5TQ>
    <xmx:ad_SZ9elyHUNyoPgoTjKM_JVYedaxZOWBCab89EhdLgOu0vA2ftQiA>
    <xmx:ad_SZ91iiECDJ5-mL9SqYsqcB0B8nBjwJT0ucPAvPXuZ_CFFs-wZcg>
    <xmx:ad_SZ583Pj_C_kozwwBu4Njn5AWNrRZcDFj_uWrELrESYGe3IkMDAw>
    <xmx:ad_SZ057fesiGKUoVvEiUO5SPajaaZjD2AzM_wN6R22WKkq8wx332cnk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 09:36:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Simon Josefsson <simon@josefsson.org>,  git@vger.kernel.org
Subject: Re: Making bit-by-bit reproducible Git Bundles?
In-Reply-To: <20250313051538.GA94015@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 13 Mar 2025 01:15:38 -0400")
References: <871pv2jx4a.fsf@josefsson.org>
	<20250313051538.GA94015@coredump.intra.peff.net>
Date: Thu, 13 Mar 2025 06:36:39 -0700
Message-ID: <xmqqzfhpqcgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> .... But there are some gotchas:
>
>   1. It's stable only for a given Git version, and with a particular set
> ...
>   2. There is no way to pass pack-objects options down through
> ...
>   3. It will be really slow. We're throwing out all of the deltas and
> ...
There also is 4.

    4. We do not control zlib, so even with the same Git binary, the
       zlib implementation that is dynamically linked to us is free
       to produce better compressed base object (or compressed
       delta).

3. is not a downside if the priority of the requestor is about
bit-for-bit reproducibility (iow, "no matter what the cost").

>   # print all commits in topological order, with ties broken by
>   # committer date, which should be stable. And then follow up with the
>   # trees and blobs for each.
>   git rev-list --topo-order --objects HEAD >objects
>
>   # now print the contents of each object (preceded by its name, type,
>   # and length, so there's no chance of weird prepending or appending
>   # attacks). We cut off the path information from rev-list here, since
>   # the ordered set of objects is all we care about.
>   cut -d' ' -f1 objects |
>   git cat-file --batch >content
>
>   # and then take a hash over that content; this will be unambiguous.
>   sha256sum <content

Gross but probably stable ;-)
