Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B1312834
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170694; cv=none; b=lrPc4uh9vOrMhOxB6k8qSFOgbfnJsaK6+ZSJK2cnZ/1XffAAER/TVo1GspOfP/V6ojgEMi/p0uB2kCt8ZJzzFvTKv/9uSZVth/sEsCNaZJWvYp511tnCtblHUdKOVZ8b/risXA24UxgAEvma/GReDRko5RpmWvdFCE+eD2G8X40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170694; c=relaxed/simple;
	bh=9/vjgrvqVmtzoVpQ5leasrCbQEU2hSqrMDSG9dtierw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YsSqX1wxls38RFzBQK0VZJX388Si6DFo0FA0tNGHab+VClStvhzCdJEmXVOpxWlQJXrUVuxkQZmWNoScTgI9U7feRFiA5xeRn3ou8VLMwBt9LQTyRlZUTh9JiqB22u9vx0srcHcMCsqgf7BEuYTRUxp7i8BW6fmXK9jFFTEYvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C2l2xHDb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3ysELZP; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C2l2xHDb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3ysELZP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 76B0C7A0184;
	Wed, 19 Aug 2026 16:18:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 19 Aug 2026 16:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787170692; x=1787257092; bh=Uyi9X8s2Gu
	ckc/kwnHL1t2aUV/xqpR40YgwL2kx7gwc=; b=C2l2xHDbtB8gC7DZzDzhh8wsVd
	CdW14/5pHexbak0sB+hs1RqPgM2JfEsU5399RZks4CA93xSzwTGLvOreUesZS8os
	pPsUvABWFKQsG6RxK4YMfoXgjkXREkJ8k3uFDfUN01me+8YU7juDBbpcA9ptJduc
	NsOgfBpm6ZGRv6k/tz0Y5kyRJ6GDeAl19yhPNRqcArocC0AzmvHH60zpPhNMqFJB
	2RJwYGnSnNH1JMXf/kL2vUkTF7JWPeRglDENgvOPrH21zbdcVkOLr7LVYyZLFSro
	g/rOQMGyleRyYnmdZZKGODT9Jb8HDenNUwuoYAXdP8I1TEou0k3H75vHW35Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787170692; x=1787257092; bh=Uyi9X8s2Guckc/kwnHL1t2aUV/xqpR40Ygw
	L2kx7gwc=; b=k3ysELZPcW473BmO9sd+OoFIk9IcLO6K5z/0urXpBwD2UgBsWcx
	DBGjYNmFXe8JMQjL3ezNha8CJzNuKVtjn1OWzDDctVqO4msTJyAiXr6SDOWLti9r
	gQ0jMKSrYaY8mAvZ9ZT84L2q2FX0M6xMld4U5QP4MSJSpECrm7LYelf8XOxWBRUp
	xPTH3vD4pnDGu5HaZW8MGX30ldPEeVDUm+a8W720D1C8D7vFIthy74zJXL+1mrQQ
	7ke4E3z4ooIN9yh3r56tAfGC3RFgScfgECkWoN/cG6G3TR5vOxuULdTev04kKW/t
	dpBAwAYvbzbGH+fyPpMhRHqJiaxhZSTi/Pg==
X-ME-Sender: <xms:hA-GaoEgoBVi7TBmoofbxDfOvS1cpU_NcdTh2FlD618ZSspdtXKD6w>
    <xme:hA-GalD-vt4liOMTKxJ8R9S0CE7c16ZrR3XRnrlqUdSRLigWo9YXQDdT6y1OioWpn
    xn7vOmofqUchUGt2bDJMiLDvua3bTObchQuafVoc-dwbKjvtpk1cQ>
X-ME-Received: <xmr:hA-Gar-CUYreIxSC4SpXYMQ6CRRxCcLKWHAt4eXA80bzr7aG9wXfYr5Uje9CIOYr9K_v6R8E9ErZB_wOTIOPynqOI6-sqHO6sQ>
X-ME-Proxy-Cause: dmFkZTFP554062Bvr7o/vGbwCrk5a6xkWYTMwFarmGpqLD/8KDo6hrWp9fw2bZR/PeT83k
    Kt1T7LtCJn/+RRflKO1x9uNTmo9ECK4whOc1/d06EaJkCeHg+qZUSAiaXChLNDdjZVCA/z
    eK+0S+A051CA0qzVQQjW2Cu+wwCxIOPtO8SW3C5txOAx7WrEgO1gW0aXOeFT0702fm5FW4
    YJHx+LsifvLF9pyyvMGUsqNdeOeQq0JZ3UgyQ5Ae+GWh8ROp9KwPo9E0CAdI9Wgr/uwMxf
    O1fP6IpEdNt0Ilrx8a7l7uUfFUfMdYdKOUTo/uI+g9DvrrE6/tqJYYtBONoSGjSWIXRisH
    24sSf0cVQuO6OkQpI9XPPPQRVniF8wcK/6zHksIAyI81QjT4IMC4c6cbffS37fCL75kkAe
    NuqXa5eBZOJIeBpHYbSNoIR6lj+5y+b9RMYUc5iOZK3Qc2vfiivtWm6CRBcHPTCaQ4yiBR
    3Xjg4q6Oz/FUWyfKl6F/I112MlSxtbkz9h7Txc4hNummIOkXl2wLkaUZG/O9viD876NNHh
    HTWaqB6oh2dBP6yQfTEkr3uUXIZ3QmrNLPPh6SdkttS1j20qZAidgzRUJBN4pB5c6Npvl+
    0yTujnulVaBvTPA4x0sqIaQnd9adtMbWWjfjfz8kb4LJj6A6AZcwIApUMRPQ
X-ME-Proxy: <xmx:hA-GahC1LS7BDk-TWb0dwnw8pe5SvsRajBBsjXKrgijQ-xT3gYH54A>
    <xmx:hA-GagRHWOu6N3Qoq6LbRRMYDYms_ffe7vlCMb065sWRa00SR1-FVQ>
    <xmx:hA-GaovzQwPm4PdH7ADPYPAh-Umy-o6x6IMS1unY3rg1chR-zMy14g>
    <xmx:hA-Gas0K6owYchdm0nTlEyT4BLHB8O0nWf8ypNAvlXauAPChZciG8Q>
    <xmx:hA-GasDt3iqhWAAJtKZVXy4k-n7qBtW9K2iuwn_pVggKD-f2VIiGJCFZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 16:18:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Vincent Mailhol <mailhol@kernel.org>,  git@vger.kernel.org,  Philippe
 Blain <levraiphilippeblain@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 0/4] completion: add support for 'git history'
In-Reply-To: <aoWP3TYq5rNjUx7S@pks.im> (Patrick Steinhardt's message of "Wed,
	19 Aug 2026 13:13:33 +0200")
References: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org>
	<20260813-history_autocompletion-v3-0-69eed1cea93a@kernel.org>
	<aoWP3TYq5rNjUx7S@pks.im>
Date: Wed, 19 Aug 2026 13:18:10 -0700
Message-ID: <xmqqse49uanx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 13, 2026 at 09:05:01PM +0200, Vincent Mailhol wrote:
>> Changes in v3:
>> 
>>   - Ignore the split "<option> <value>" syntax for options that take
>>     arguments. This simplifies revision detection and avoids hard-coding
>>     option names.
>>   - Test that options are not completed before a subcommand.
>
> I'm happy with this version and I think it's a good base to build on
> going forward. Thanks!
>
> Patrick

Thanks, both.

I'll prepare an evil-merge to rewrite the test to add 'squash' to
the candidatesto adjust to the subcommand addition to another topic
in-flight brings in when merging these patches to 'seen'.

Vincent, this is strictly FYI.  You do not need to rebase on top of
the other topic, until I and/or the author of the other topic ask
you.

Thanks.
