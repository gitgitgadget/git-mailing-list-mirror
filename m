Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943417D2
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710982912; cv=none; b=ji2okPLbSgLtfZO2AtNNFUjeW9C5dgGUAgXnZYfHLs3FywpLvwtYy04tT6Z0WoiUpgv+iNBz/7gAuZVPznFgxQd10s011V7Z/wW3zJugLLoZyLXqHpTmi87Re35ILaLxEpNSW+opuzU2Z95dhMgsChzYp9wIezYREAajFuxnzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710982912; c=relaxed/simple;
	bh=uyftspPq5rn6XXAqZCtekVYSHjQqh+e9XaHLJ2qJ5e4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xmoz6NinoxY9X6FBHBvXuJuo3+59hgsQr5/tE0LuP7Ty8AfpboZqdc6N426y4/UgfTqOl/Z0X02K3bwJ7KfRn0dhXP8LrdCd9ky7C7gspQ4Z+elFUZyOaz2AwL4yc9bjao7+aio973wH2k0v0dF+TDtb+gyhtKmFIOaIAbXxVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=l6X4qsln; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l6X4qsln"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 397F525971;
	Wed, 20 Mar 2024 21:01:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uyftspPq5rn6XXAqZCtekVYSHjQqh+e9XaHLJ2
	qJ5e4=; b=l6X4qsln2jSVykr/nFMgnmAs8HxcjWVfm/zSk7n3atvawDJtxM9plR
	q1w9nrTGFSQlBOoiPrt/Pz3MxY381ftLghDIPIHIVZv+cPRPGko0B7hCPzGnQqSO
	lzMLYAHSPfaB42ss37l+fGCugVEU+uABg75G7JQPbtPusq5043ii0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 31B9E25970;
	Wed, 20 Mar 2024 21:01:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B2E2A2596D;
	Wed, 20 Mar 2024 21:01:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Brian Lyles" <brianmlyles@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: A note from the maintainer
In-Reply-To: <17be9ebbcb24ec98.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
	(Brian Lyles's message of "Thu, 21 Mar 2024 00:03:57 +0000")
References: <17be9ebbcb24ec98.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Wed, 20 Mar 2024 18:01:39 -0700
Message-ID: <xmqq4jd0fle4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 93A974B2-E71E-11EE-9FDD-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Brian Lyles" <brianmlyles@gmail.com> writes:

> To me, this initially sounded like it meant "your patch was not
> something that the git maintainers would be interested in accepting". I
> *suspect* that what is actually meant here is "your patch was
> straightforward and non-controversial to the point that no members of
> the list saw it and felt the need to comment on it", though to be honest
> I am not 100% sure.

I actually meant what I wrote.

It is possible that the reason why your patch did not receive any
response was because it was uninspiring, looked useless, and did not
deserve anybody's attention.  But it is also possible that it was
lost in the noise.

And pinging on the topic by responding to your own message is not
just acceptable but very much appreciated way to remind others who
may have missed it, in case it is the latter.

If a topic is truly obvious and straight-forward, it may be taken
silently to 'seen' and even to 'next', and since it is suggested for
the contributors to look at "master..seen", such a topic would not
fall into the "hear nothing about it from anybody for a long time"
category anyway.
