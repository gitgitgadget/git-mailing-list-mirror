Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DEB14B978
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723494777; cv=none; b=ICYQevEYhqpD/dB4x48u3XW24TIPTINfTSNU014SkbZRWCJk8gv5OTlWFBnou9l2TeRGOpPXY8rY07QF9l4ENLNiMNasFmhHn293wR4xQkyIRH7VUNBdlZUnq6U2i7FgfpH8qqILnKWOiWuaNiSneo+8/qdT2aIGs+gM6MlgD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723494777; c=relaxed/simple;
	bh=VVsYs6zI51Rffp9WVRb6FMeLq9kIaFowvo0VMvgE3ns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OMF3aOlgwxI43yTEPv4Z70HDi6zTjVgAALRQYXHM34ML1SA0C0sNcBKd0Mppg73QUCx3s6TzhU64slZTcG+TIcJuK926Q5Z+CRr27rc3bT6KNndA7TXACo/bkgYx8yDqf8dCAiiNegXB89bryc9ySt0+IzgrV/kSjH06QWNZDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MJCSp1vx; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MJCSp1vx"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A6EB2D202;
	Mon, 12 Aug 2024 16:32:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VVsYs6zI51Rffp9WVRb6FMeLq9kIaFowvo0VMv
	gE3ns=; b=MJCSp1vxm/7yns4GhRtl6BKV9RHTVA7YnkN01khlu9TIw1QfbsQMrq
	xkNPjmfDrkgUMwzBgWuHKO7Xzn2wrAR0Sg6SEFt/F1Tg9swdnh4Yc0SYhaejf1pN
	xKN0Sxo/3CAg0GXSnDOe458dkfb0reDJe6lcI8bQzWvlxXjfnQHRM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 210F92D1FF;
	Mon, 12 Aug 2024 16:32:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8167B2D1FE;
	Mon, 12 Aug 2024 16:32:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  James Liu <james@jamesliu.io>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 08/22] config: fix leaking comment character config
In-Reply-To: <Zrm9ix5aN_g76Qxq@tanuki> (Patrick Steinhardt's message of "Mon,
	12 Aug 2024 09:45:39 +0200")
References: <cover.1722933642.git.ps@pks.im> <cover.1723121979.git.ps@pks.im>
	<8fbd72a1002d1a285847c62b5524041927a7b4d4.1723121979.git.ps@pks.im>
	<xmqq34nfhrb9.fsf@gitster.g> <Zrm9ix5aN_g76Qxq@tanuki>
Date: Mon, 12 Aug 2024 13:32:53 -0700
Message-ID: <xmqqbk1x1nyi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0D98A986-58EA-11EF-89DE-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 08, 2024 at 10:12:26AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > diff --git a/config.c b/config.c
>> > index 6421894614..cb78b652ee 100644
>> > --- a/config.c
>> > +++ b/config.c
>> > @@ -1596,7 +1596,9 @@ static int git_default_core_config(const char *var, const char *value,
>> >  		else if (value[0]) {
>> >  			if (strchr(value, '\n'))
>> >  				return error(_("%s cannot contain newline"), var);
>> > -			comment_line_str = xstrdup(value);
>> > +			free(comment_line_str_allocated);
>> > +			comment_line_str = comment_line_str_allocated =
>> > +				xstrdup(value);
>> 
>> If you are to follow the _to_free pattern, you do not have to
>> allocate here, no?  We borrow the value in the configset and point
>> at it via comment_line_str, and clear comment_line_str_to_free
>> because there is nothing to free now.  I.e.
>> 
>> 			comment_line_str = value;
>> 			FREE_AND_NULL(comment_line_str_allocated);
>
> Only if it is guaranteed that the configuration will never be re-read,
> which would end up discarding memory owned by the old string. Which
> should be the case already, but to the best of my knowledge we do not
> document the expected lifetime of config strings anywhere.

Then let's mark it as #leftoverbits to document it.  Many other code
paths depend on it.

>> I still think the approach taken by the previous iteration was
>> simpler and much less error prone, though.
>
> I personally prefer this iteration.

If so, then let's fully take advantage of the fact that you have a
to-free variable dedicated for the comment_line_str variable.

I still think it is a maintenance burden to keep them always in sync
(which is another thing the developers have to remember---when they
are updating _this_ particular variable, an extra rule applies and
they need to take care of this _allocated thing associated with it),
and the first approach, by not forcing all the other assignment code
paths to worry about it, simplifies the mental model for developers
greatly (i.e. we know we do not own the initial value, but
everything else we allocate thus we free everything but the initial
value), in exchange for a slightly wasteful allocation.

The approach in the second patch is worse in two counds compared to
the original.  It does wasteful allocation (which we do not have
to---the fix was shown above).  It also burdens the developers to
know that they have to manually manage the _allocated half of the
two-variable pair.
