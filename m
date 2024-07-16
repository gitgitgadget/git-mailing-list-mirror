Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A198927733
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144713; cv=none; b=EGFY48p6V3S2Ztg3MqnueXUMVORsPSpCv9LlScVaMtE4VwXFEgXLOAs3ockvg68WHIoSly1Pb1x6RtFUdXVXU+/vaNVBPnzgOiJIF5PQ3Em1wr2XgyGr+W4WL4qOMQGm28rRWqEeDyxqK4iAys1QoxxmNkzffVKnrnlB28tY7ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144713; c=relaxed/simple;
	bh=lzLqqp33YRFtfNDAKStjVNO0sRXHy608wmOKdnv9xn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dsVw4q3yi9PYvtkYFfekx7Z7PTWLakECSJWF8WTk8zzkmoB3PlPqjPpf8Oaq6NOVWXqnOaIf7yP7qO6f9wDH9n4IWI5UpbfVDzEU9IEFX1jeyCVZhQnCimol4Iq3hVTNCly/6oLsM3qIveLfPQQGtpXKlQr3h0iCSyV4FDiP554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v41dznUV; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v41dznUV"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 920433D4A7;
	Tue, 16 Jul 2024 11:45:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lzLqqp33YRFtfNDAKStjVNO0sRXHy608wmOKdn
	v9xn0=; b=v41dznUVxe8GdsCZOaEnCPX1xbwL+FNJLZmYOl+q64YLfOnEq0efkW
	KitYb3X6VS1tJt351I6ObUIM/KwhSVwaEXBPWAoYGX/3i3N0RpjbY/aaxWATQNyo
	ezvoKUDPYelEU4p/+BEhmTQa0rN4/DSmphIxuLysk6LcsTquL7pGA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85AC43D4A6;
	Tue, 16 Jul 2024 11:45:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4AB33D4A5;
	Tue, 16 Jul 2024 11:45:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: Matthew Hughes via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add builtin diff driver for TypeScript language
In-Reply-To: <20240716122112.zqauqgxmng2tk2j6@archP14s> (Matthew Hughes's
	message of "Tue, 16 Jul 2024 13:21:12 +0100")
References: <pull.1746.git.git.1721061218993.gitgitgadget@gmail.com>
	<20240716122112.zqauqgxmng2tk2j6@archP14s>
Date: Tue, 16 Jul 2024 08:45:08 -0700
Message-ID: <xmqq5xt5bat7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 61E81456-438A-11EF-8B05-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Matthew Hughes <matthewhughes934@gmail.com> writes:

> This needs some updates.

What does it mean?

The patterns that were posted were so broken that they are unusable
and harm the users by giving misleading information?

Or do the patterns work just fine in basic or tutorial cases, but
with more advanced or realistic uses of the language construct, they
highlight wrong lines as the function header and/or split at wrong
word boundaries that are obviously much less optimal than ideal that
any human users would find questionable?

In the latter case, how far from the ideal are the decisions done by
the current patterns, and what's the rough percentage of usual code
we see in the real world, for which the current patterns do not work
well?

What I am trying to gauge is if it is so broken that it should not
exist (in other words, you regret sending the patch to the list
before doing these updates), or is "already serviceable, but not
perfect yet".  Waiting for perfection takes forever.  If the latter,
letting the general public to use it to gather feedbacks by waiting
for the dust to settle before making such updates is often better.

