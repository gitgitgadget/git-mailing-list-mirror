Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE3145341
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 22:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717798560; cv=none; b=YbEyPxEal8ILtEHerha3oZqKPsNtZ8x5+FxQnzMUJhWfe7jWchpzrdL/vuHaLjq4wqbXsvd6vM59sInPvNE+YenJXORsg4qfpsWA0beLLk/GvhbTyLr6Qr4bcTWKTr2HhejbTrF6J282eqIjXF+OmUeQ9hONl0QKqSllTIodXrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717798560; c=relaxed/simple;
	bh=pJ+JTLF/YVjGK48yJdzdKHEWJBEhMitT/rfHTwISYM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gkgZO5s4NAUL5RHxPej9SOrDHP7iMec7UhM8UpITz6oXkcqs5Q/SBnrPkTRbwgKjh5slrjLxh49Urp8m3KhdgTwP7Oeds4RSZH4G1iuvq+iy0jY6Yh/iBXRRFimi8BG3U1hKt0Ap6wHBy5zSMhzEx8JsWszdOdNJCRWDdSVuzMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mgiIS5Ua; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mgiIS5Ua"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B9BA419B01;
	Fri,  7 Jun 2024 18:15:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pJ+JTLF/YVjGK48yJdzdKHEWJBEhMitT/rfHTw
	ISYM8=; b=mgiIS5Uaa9p+Ao/Wj5JbecwLS4VayYBcGMrmMtkBuMgUIb+6psN9aZ
	zbA7+LRL9m2bnGN9TVQKMG0B7/10MdGWIT6S7bEsV1+faAlZJeB4BZd8ViuoVCmf
	zugiDHE0v1yfLMeHAmd3U7kx3bS5bvjVJuDxD+d5vd7u+0rHXkKlM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B257D19B00;
	Fri,  7 Jun 2024 18:15:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F53B19AFF;
	Fri,  7 Jun 2024 18:15:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rjusto@gmail.com,  sunshine@sunshineco.com
Subject: Re: [PATCH v2] doc: imply that interactive.singleKey is disabled by
 default
In-Reply-To: <61f46d925e89b6a574d84970089f3c50@manjaro.org> (Dragan Simic's
	message of "Tue, 04 Jun 2024 22:11:30 +0200")
References: <7da73f15a018d858519eefa373001ccb3eaf32e2.1716412958.git.dsimic@manjaro.org>
	<xmqqy1811qkx.fsf@gitster.g>
	<673887a14c4f74deb4ef7771a331689b@manjaro.org>
	<35f5633ebf263ec743d673770eb86487@manjaro.org>
	<xmqq5xutgajw.fsf@gitster.g>
	<e5eb72eeb2f8e2de9400ed9373b72236@manjaro.org>
	<61f46d925e89b6a574d84970089f3c50@manjaro.org>
Date: Fri, 07 Jun 2024 15:15:56 -0700
Message-ID: <xmqqbk4ce6w3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 837C4232-251B-11EF-B8B6-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> On 2024-06-01 00:21, Dragan Simic wrote:
>> On 2024-05-31 19:23, Junio C Hamano wrote:
>>> Dragan Simic <dsimic@manjaro.org> writes:
>>>> Just checking, is there something left to be addressed for this
>>>> patch,
>>>> before it can be considered to be pulled into the next branch?
>>> Thanks for pinging, as these small things were on the back burner
>>> while preparing for updates to maintenance tracks.
>>> Apparently v2 cannot be pulled into the next branch, and I forgot
>>> if
>>> I saw v3 already.  In general, unless I explicitly say there is no
>>> need to resend (sometimes with conditions), I'd expect an updated
>>> iteration sent to the list.
>> I see, but I'm not really sure is there need for the v3?  Maybe the
>> patch description could be tweaked a bit further, but I wasn't under
>> impression that you asked for that to be done?  Am I wrong there?
>
> Any chances, please, to have a look at this?

I _have_ taken a look---as I said, "I saw v3 already".

Unless you were asking other folks, that is, but the message was
addressed to me with others CC'ed, so I am not sure what the true
intention was.

