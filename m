Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EAF12E4A
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008799; cv=none; b=uRPjYgkhM7HW8feXjFYZ4edytyHQRiv60enwv6uBbTEZz0deFQ2G8w7ke6JN0m0Znz3MLDdhX6j99a0F+x53phdGHwjE6qTYChaC6cU8pCcwll4kW3n9/Lec6FjxMVLw2JZrExBhrdw/7E4uZaSCUU45Cs4Ayr8D/p6n7zEDz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008799; c=relaxed/simple;
	bh=INZ2jyeKomsKLFs+zmUSxj6x7L8himSHZrgYg5LTuBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PAVhfgWSsy6RRPAjuBKBZyziuYlIbcP9gCSZOP0GN+nElyStMwdKcKsD/FKjaT5QaIktap6UEYn0yqpU3A7wMy/ilaiSMmotTbWk0Iv1O01js7HU/9gNHAwdWj009Xu0fu31W01f/DGJxAGlawwirPvDdOG9IL7gSQcuQbl+jjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yTQ0EiOr; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yTQ0EiOr"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 275D73492D;
	Fri, 26 Jul 2024 11:46:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=INZ2jyeKomsKLFs+zmUSxj6x7L8himSHZrgYg5
	LTuBo=; b=yTQ0EiOrpIVmhXT360uKdl3vxVbd0Biv/oIVPMOA+Y1Vn1pWbggxC7
	BnXyKslsjR+hMrkD2paLh+qvxu1KFMfgAr7byT9iKW+NAk1k6G85DWaz8IU52xk5
	dhBBrG5uAKSC1D18GNMld+bEdrIZlT0DYYsSblAStyejiF6ofhXjI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 208D73492C;
	Fri, 26 Jul 2024 11:46:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A78F03492A;
	Fri, 26 Jul 2024 11:46:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Alexander Shopov <ash@kambanaria.org>,  git@vger.kernel.org,
  worldhello.net@gmail.com
Subject: Re: [PATCH  1/1] show-ref: improve short help messages of options
In-Reply-To: <ZqOWUrynjUN2A5TM@tanuki> (Patrick Steinhardt's message of "Fri,
	26 Jul 2024 14:28:02 +0200")
References: <20240724111116.91615-1-ash@kambanaria.org>
	<ZqH7mDh73vkX4bPT@tanuki> <xmqqr0bhldjp.fsf@gitster.g>
	<ZqOWUrynjUN2A5TM@tanuki>
Date: Fri, 26 Jul 2024 08:46:32 -0700
Message-ID: <xmqqle1oxijr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3BFE01A4-4B66-11EF-B76B-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Meanwhile, I think that the proposed change strictly improves this
> message and thus don't see a reason not to take it. Unless we see
> somebody come up with a less-awkward solution, that is.

Oh, that part is uncontroversial.

The wording without double-dashes has been with us forever since the
command was updated to use the parse-options API by 69932bc6
(show-ref: migrate to parse-options, 2009-06-20), and so far nobody
complained about it, so while "strictly improves" may be true (i.e.
the delta may not be negative), the degree of improvement may not be
all that much to be worth the combined brain cycles we are spending
on this topic.  Taking the patch would not make the future work any
harder to truly improve it further, so I do not see any reason not
to take it.

Thanks.



