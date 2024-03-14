Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAB473516
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433331; cv=none; b=YKCKZBbsuNf7COguVCjcSXesCyG7LhC/JALB8jYn/nFiNo/6FJR/QXMIJKWjaZINgtYyUhUXMin8StT7N4yn8YH2DEcxl8ZO11qRKtFMF+SCM28lU3cKNa42Z7sViqMp1k2/ClzRYSJ+Rj5m0b0dkxAlfn/NoLaWXiiX4IcmmXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433331; c=relaxed/simple;
	bh=G7zrTXzPBbijHXPM9fGUPooiXFeHZHVrZ7OaUssxd9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mDqNeMIsfwM1zV7RwtnliISWLNNPBV5qdfBcvlNHpGiql5myHUrSe7x8V3DR8+RLSzBsnzMVZzcucV3eTaXfMBRTID3csFVpR2XOGFwoYl0pw8N3jIU/CCx4a3StsbFK1gkFODWUr2nwc58lSXC9h59FB5BU9WpNQ2fgP3zMxig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XFlC7Muo; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XFlC7Muo"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4041529593;
	Thu, 14 Mar 2024 12:22:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=G7zrTXzPBbijHXPM9fGUPooiXFeHZHVrZ7OaUs
	sxd9o=; b=XFlC7MuoQPxuFV7dQmxW1kQVRfD/e8MZfiLjKLTBqF9z6ZNdtwsYSO
	KeVGImew0SUBbS3VURXfXvkZ2yBEFaPVkezfrzzXoMvbmMlxyLswgoLERhTfX0EP
	THMzKdJZgk1CmXP/O22ipYq643G9Y4/jbMoxkwXOo3wxvAOEDrMMs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3878129592;
	Thu, 14 Mar 2024 12:22:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CBEBC29591;
	Thu, 14 Mar 2024 12:22:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rsbecker@nexbridge.com,  github@seichter.de
Subject: Re: [PATCH 2/3] config.txt: perform some minor reformatting
In-Reply-To: <07d0ac0d11b47983d3aa1760fc01ad92@manjaro.org> (Dragan Simic's
	message of "Thu, 14 Mar 2024 07:20:25 +0100")
References: <cover.1710258538.git.dsimic@manjaro.org>
	<d50c0f22c41ec36b574e1ff67e68485d9a6f2a84.1710258538.git.dsimic@manjaro.org>
	<xmqqedcd1sm5.fsf@gitster.g>
	<07d0ac0d11b47983d3aa1760fc01ad92@manjaro.org>
Date: Thu, 14 Mar 2024 09:22:03 -0700
Message-ID: <xmqqfrwsyeac.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FEE7193C-E21E-11EE-A55C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>> I was a bit surprised to see such a "preliminary clean-up" step to
>> come before the main change, not after, but separating this from the
>> change to the next paragraph, which is the main change in this series,
>> is nevertheless a very good idea.
>
> The reason why this patch went as the second in the series was simply
> because it's a somewhat unrelated cleanup that performs no actual
> changes
> to the contents of the documentation.

It would have been understandable if it were left at the end, as
"after the dust settles".  It would made even more sense if it were
at the front, "before doing anything else, let's clean up the
mess--we do not intend to change the behaviour with this change at
all".  Having it in the middle was what made me surprised.

Generally, the order of preference is to do "preliminary clean-up"
first, followed by the real change.  That way, trivial clean-up that
is designed not to change any behaviour can go ahead and merged down
even before the real change solidifies.

Unrelated changes has no place in a series with a real purpose.
Unless the series is about "assorted clean-ups that are not related
with each other", that is.

Thanks.


