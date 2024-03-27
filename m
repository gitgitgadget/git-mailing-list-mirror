Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2736179B1
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711497936; cv=none; b=rweMjErghDHecnppLjALxhJ1bc8guBd/e6zicPBmaiTklt5rHw9Vf2BNVKe72dh12eTaKp+Pxega3WHb42fm5I7T1xIHaqzJu5IBw6/Xj2SbG8RLYARKKzCLXZ8YSEOLH2xUTQYPQ/HTV/zltYYTUrT6EcElF/u2XsSB2khQ6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711497936; c=relaxed/simple;
	bh=sBV1ZPZOSxUsndAb83FQ2PMlWpC0aSbF+UHcpxNEucw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DzM4cr67le6LWy0N/vGHZh//C6PrFXVZqJN0hiq1p4ZWEhT7xZINRDe6fE1PooGPFTJ0Ldrpk+0jtHRHjLAO3l6joVgh7QaC8NP9rIONJGDNpPIwyodjJK3VRUjuwBu0Hipu//xgvVNw63kU2UkVjACGr/1uIQB0z0eDI0W7+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tTOy7K0x; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tTOy7K0x"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A75B21DB5CE;
	Tue, 26 Mar 2024 20:05:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sBV1ZPZOSxUsndAb83FQ2PMlWpC0aSbF+UHcpx
	NEucw=; b=tTOy7K0x8joZ9M037cr7xns2l+GYa3li98aZbyuW1cWgB/HXRbBtuH
	v7U8fOn1Ns51MIPGuMHIU0kICdcVHqCF+OQbrJD02byC7SFDZSCQgDH1CbLZbXJ8
	BWiI3CB/cVfdyKDU+n3urkXkwIpctKH5/8H7HG+OKOR5UyhglePYE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F61C1DB5CD;
	Tue, 26 Mar 2024 20:05:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 117871DB5CC;
	Tue, 26 Mar 2024 20:05:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH] RFC: add MAINTAINERS file
In-Reply-To: <ZgNcvR8STOUxxc1e@nand.local> (Taylor Blau's message of "Tue, 26
	Mar 2024 19:39:41 -0400")
References: <pull.1694.git.git.1711164460562.gitgitgadget@gmail.com>
	<xmqqsf0gvjrg.fsf@gitster.g> <ZgNcvR8STOUxxc1e@nand.local>
Date: Tue, 26 Mar 2024 17:05:31 -0700
Message-ID: <xmqqwmpo5yk4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BADC52D0-EBCD-11EE-A51E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>>  - How binding is it for a contributor to be on this list as an area
>>    expert?  Will there be concrete "expected response time"?  It can
>>    be different for each area expert, of course.  I'd expect better
>>    from those who work on Git as a major part of their job and
>>    contributes some part of their work product back to the upstream,
>>    than from folks who do Git as a hobby.  Is each contributer
>>    expected to volunteer to be on this list, with self declared
>>    service level target?
>
> I share your concern here, too.

But I wasn't expressing any concern above ;-)

I'd consider it a progress if we can give contributors (and the
maintainer, too) more predictable review experience.  If we can even
optionally give some assurance on the response time, e.g., "I'll to
respond to and usher to completion any patches in this area if they
are promising within X days; I may not respond to all patches and
certainly not to ones that I do not find interesting" would already
be better than some patches that do not see any reviews for three
weeks without such an "optional" maintainer.

> Those kinds of things are hard to quantify exactly, and perhaps that is
> the point of a MAINTAINERS file.

Yeah, I am not interested in what exact form such a list of folks
who are willing to help guiding topics along comes from.  What I am
hoping to find out is if we can come up with a bit more structured
way to say "yes" or "no" to topics, rather than the current "nobody
may be interested in a topic, in which case it is anybody's guess
what will happen to it" (actually the default is "to drop", and I
often end up to be "somebody who gets sympathetic and reads the
topic to salvage, instead of the default action that is to drop").

Thanks.
