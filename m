Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900532;
	b=i42NMGgnhE00FIe8QWx4b/BXt1aMNpg3tRYthMRyDQ9Clos7abgUBLJd+PXRx7UvAxbc
	 YJ0PSXXi8jn2dxj0xvaLMDqdria9Chhl55veSH1wQ3kLM4tk6Ip+Iwh0mYvXAQC/V7OW8
	 CASrdx+CYxko5cls0zCfMWCgqXCk5Rq4/KcrhDF8hAMq6OOYLT+1CMjqUJDx/5hSSTogB
	 woqpYwAF/SFDL5kGEur5KUNo2q1I9nt64kFmInJQ2HIcb23NhKqoYWCCjv4zlwiqxRZkt
	 MOjy4pqFVTdj9xz+Fmp1qfxa5PVmbDOejhOXEFrJn9nwNtm8BXdbMgQeHlqOb7aF8dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900532;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ciBA078OXH6pAXB1ZkAaYBtsvQaL877qy+nMQl4nq+E=;
	b=cTAEcg/PFJY28/3x6R9AKmjUXtjmANddhbKc0QjNSFCsFffhQqt7sFqeITxwal+HYxQj
	 U9lvmJjTMgJmQb9TR0I3qG33RdU4eZEJdKdzuYr/Lz5ki3Z3bxv9FgUW7tDwtNOLvESjc
	 vIbLlJJr4MWRK6LZ6L2VwIU3Ao1N8Ss69X8QundRn/cadCH8pzEUheyiLzXeysDR8Fugy
	 GtEVRetXcBcjQz+jMYZ80xbC3e09JC/2s/HfT/2SOHBGlfK+Hgq8mSIiJ4Zi3jh0orgJL
	 Ro88OAKRnLhr+3yPrleBcKIgv21zTvIHyq4XtQ85XISYz/Y6z5zeFia6LDcRqzbhkbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=YD+1jHFF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=T9H19lSf;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D8606A32F
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 17:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B17D8606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=YD+1jHFF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=T9H19lSf
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E6DBFEC01A2
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 12:42:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 05 Nov 2026 12:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793900530; x=1793986930; bh=ciBA078OXH
	6pAXB1ZkAaYBtsvQaL877qy+nMQl4nq+E=; b=YD+1jHFFxp00qvuuTf2OZt7NN+
	iPlUVPlVirv8GRO8OWiojtRmDYbHd01xD3cMFrybybc/2mjEw5OQ51xYiKMaOzZ9
	0dylkGkFOw62NWwtSeSFuLAK47vMGdx/dMFP3sS1A8XK+LEuOSpQ3sI/iOsAX1wk
	rlcLo80hgrpaS7GhSpD6RyrUXzkC2dmsPQxbxVU5Kb5/dnsygRLG1tBUCHhoSHml
	3n13yrAsNyvR8FdlkOTrHNVFljGuRR6P/dr4k7VAfjdwhJdkR1sxStSVnyj3eZnr
	xA6NhjLSS17la/OC+ia/KER9cwY8rss1Yw0P5zofOtX6fv4EKNdCNzKmbRqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793900530; x=1793986930; bh=ciBA078OXH6pAXB1ZkAaYBtsvQaL877qy+n
	MQl4nq+E=; b=T9H19lSfgfubivBT2do3XXpsrfC+dwMhaTPI6NqSR8+o1ce5dNU
	lGQA/DOdxCtAAsAYjsDYxymM+ROFJPIIdRkJ3zFQ8brlCvKU/HZuJKiskPAVD1Iq
	Mg50zwDYByrroX+WqhKTrD5aPLI5w5p/RlfFvYi2n7snxGJccSLq3LiZT1BhkJni
	sTtWTEkGV4EpFA8bdJqS6mLDsIquUaS8QkK1yaXsL5HyqT/MFBCfDQdreM0Nx+Ot
	AxiSlYWQRd5QCjGhdME83wIGvSpdP3POtQ7brAt0AUQMf2HcW4Ei7bZsi1uTzcyo
	N86wDkD5LC3kGr/140RKPLV6KPlsTmRRkqg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793900530; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Qg/POi2pntMYPkTjJ9kM/MWWnha92/RPnASf10NARNkdco6
	n2cHVJiTrIA7m1i+Y9UW6XZnhSoUo3X150cHrqYSksBbxSl65P4TlYQv6mIcFeXE
	HX6V4phHDKi+Knx46p8KIMneV7OqhLHaT6MTB6q3rCkaERARqDO8c/+px0CN9HER
	u94VOFWMtzQQhc1QuN1lRYBsCEBZXUSiKt1Q5LfB3pmaxpO8az3nf0Sb/eowji/a
	y7VvwmD53gPcZsijc7aaoF+Ezvg5fvo0AQUe3ox3AAse9k5MmFTKtCerfaZaE2qW
	N0uwFC4pr50GN3mxMUdsRIv0wJvWrGeYkl369SQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:G5fLQA2KosviTOR4G0MSmBUXQhOLOjmVf/aVNrmYeSY=:XDeibkstTxOwPZPGAxvaKXilgNeiK0ALauo/q3D4qCU=;
X-ME-Sender: <xms:8r_sam6nrr9vqwjl5JJ07HlqIvZisjYHNShgDnRGTZZTOAqplNUo-w>
    <xme:8r_sam7eYKh-I1uNG-P4EL1taxMP7AqaOz0X2zFt8PBwvPAV046v6W566iH_JmRKY
    acgHEVwooRl6RjfWF9_a7Mp80cDDedpsOtL5bDl3lS6620IR9eX3w>
X-ME-Received: <xmr:8r_saqeWZ5jXN7HcZGQ6ossXxuovdsVE9OCdEVUboAiJh3gmfgaLw45Qcj73tmkP8SA9SdYdwOtAWNryTooFebThp-nQfLf4Gn-E>
X-ME-Proxy-Cause: dmFkZTEaWADjM+Qb8XcL1hGku96c0MAArNdpiqmiSM6t2dzU7yfGwoyfX29N0irQyUG0v2
    f7wZ9FuBnHsqlkGdOtBmT/62R3lQ7PS+d9dfLrfYQpqPJR3xMXZz4bz8EMYjTW7R7enSRP
    lSh+xm6wtOeJpZkeDLwtU4MqpYAF5WPGBL/P6W+RUlIR5vjOkzw9OhobDpbybfamvnDA3y
    pvZf3l8NiButSdhYftCK3k65eRmzC+A9hW3Heg+6wKUN5+ml3pJaPEg3ywUsj5XlBmzDwO
    tfF7VgYyVFvQBJ+0fF97+H4POyXoS4XpS8gX0QWjvde3eszlVAwETYv9Wgc4r7URQ1dxbM
    uyLbfbOImz3Od4VpmdIb5x7JGkvKA/2X6u9kHcwUQOo8VqtmzNU0HLmfKmQCVhXELpcKiP
    Q6pAiS2If90PvZuRq5biBP0ZHXlw/62m9kkiuE83it3WzM17brLb/1CDo/6DLsQhT55XyK
    p1qJLwwiL6svu3JiHuOfOBg1DdbGSGL2ElV9wWySsjWwxBn4hM+w8TPvf/AHmSN1f3rkdP
    JFq1P4aoBXVoSwqIZnSTDDgtPwJlVfvAPo/IrQFsye6NV7IaC8+Hu713Stxe4/7rkW/bOO
    P8bs2/jEPQkVk9t0c5TfVFZaJxxG1yUqMO1Stq6iLNJIEnac9Sn87viRU6lA
X-ME-Proxy: <xmx:8r_saiA9iYIfBz6-8b5RiZ9q6PFbsxNVKONWuEAJcwrzRGDsS3bdqA>
    <xmx:8r_sal_8Gqj8RuMlcDuz1jgrk20O-UG-7ywckfmPa7eOcUgVMQNHRw>
    <xmx:8r_salIcZSol4GUX_brw3jHGSkhx8O-FBw7LKVQ6ctte9W5OMwp4ZA>
    <xmx:8r_samjOAaQUodogDBRhiK6sg1priuDwcqWbRapw0Y9FiIn-V3oziA>
    <xmx:8r_sasb3BPMdOvnyKV8jNZ_kP7OQu2BDYg8jZFqZSWPMfinrsZHBAjuj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 12:42:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: update the required Perl version
In-Reply-To: <auuxjhaauAQ7Vtjs@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Wed, 4 Nov 2026 22:28:30 +0000")
References: <20261101185846.24208-1-taahol@utu.fi>
	<xmqqjymvooyn.fsf@gitster.g> <20261104193450.XvTBf%taahol@utu.fi>
	<xmqq5wyc1iba.fsf@gitster.g>
	<auuxjhaauAQ7Vtjs@fruit.crustytoothpaste.net>
Date: Thu, 05 Nov 2026 09:42:09 -0800
Message-ID: <xmqqik2bw4y6.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2026-11-04 at 19:56:57, Junio C Hamano wrote:
>> Tuomas Ahola <taahol@utu.fi> writes:
>> 
>> > Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> >> Tuomas Ahola <taahol@utu.fi> writes:
>> >> 
>> >> > - - We try to support Perl 5.8.1 and later ("use Perl 5.008001").
>> >> > + - We try to support Perl 5.26.0 and later ("use Perl 5.026000").
>> >> 
>> >> Is this in line with what 702d8c1f3b did?  Shouldn't we say
>> >> 
>> >> > + - We try to support Perl 5.26.0 and later ("require v5.26").
>> >> 
>> >> "require v5.26" instead?
>> ...
>> It looks to me that the "parenthetical" you called was designed to
>> be useful by telling you what to have near the top of your Perl
>> source files.  Replacing it with "require v5.26" is exactly in line
>> with that, I would think.
>
> As mentioned above, you want `require`, not `use`, with Perl versions.
> The latter enables the relevant features, which include Unicode strings
> as of 5.12, and that will change the behaviour of our code in ways we're
> probably not expecting.  That didn't happen in 5.8.1 because features
> didn't exist, so the `use` for that version was okay.
>
> You effectively always want `require v5.26` or something equivalent such
> as `require 5.026` in our codebase.  The former is nicer to read,
> though.

Thanks.  Let's see the final version that can immediately be marked
as ready for 'next' then.

