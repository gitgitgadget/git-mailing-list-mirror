Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C492C80
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038872; cv=none; b=fPyZ7kXHbmdoqUqQTE2ldbCTcYN2gCVbTd7lgWIU76unSaz0jGv0FZWtuLAH7imGikHo95NjqqPq7l+sNmKIfxTlEe6/GlNJT/AxatYUQfEneA2klImh3qK9/NOuGM06eZl/3hqCTtskzRjlViTJoxw6xTRr8a3rCV6lFAJ6YGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038872; c=relaxed/simple;
	bh=wDekPyH354O3SWG264W0LrYdBMh1xy7jM5TeTl+lQRE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qSSIeVclrthnGIcMGi4spvc08+h1Hwxyb9TfhaJAKy1SEmYaEy44wfKDor3wa/6kE21auJT0ur7O26khKgpx/wyvfsgFzl4YW265qjWvYzmgB2wy5btmyV8B8/p+sIBE+muJRazlv4GaWdAW2GMQSqh/5xbcesEFrAnhBfm7Unw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bJHPMQNy; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bJHPMQNy"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FDC71EB203;
	Thu, 21 Mar 2024 12:34:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wDekPyH354O3
	SWG264W0LrYdBMh1xy7jM5TeTl+lQRE=; b=bJHPMQNyNgfkdHdPywbYB30h9DOR
	C9WbVJXJnQy3BcIt3+KxlsOYKSHTMbi0J0FGSYPit1ng1jbgjYrUVPM0aH+R5L8W
	dWApgQ07n4IDXFKbuyqAcNtSvHbwpRVq5b9fSPhp9SneXay7iBs39TlQ+PNPZIW5
	2mh4qCYkofxmZEI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8784F1EB202;
	Thu, 21 Mar 2024 12:34:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D53731EB201;
	Thu, 21 Mar 2024 12:34:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Olliver Schinagl <oliver@schinagl.nl>,  git@vger.kernel.org,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
  psteinhardt@gitlab.com,  Christian
 Couder <christian.couder@gmail.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: Git mirror at gitlab
In-Reply-To: <ZfwY_h70OeuRT7mk@tanuki> (Patrick Steinhardt's message of "Thu,
	21 Mar 2024 12:24:46 +0100")
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>
	<ZYQl_G-S4vQibHWn@framework> <Zad1S3vCuv4KYIzx@tanuki>
	<ZfwY_h70OeuRT7mk@tanuki>
Date: Thu, 21 Mar 2024 09:34:25 -0700
Message-ID: <xmqqy1aba6i6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E215BCE6-E7A0-11EE-AD6D-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

>> Circling back on this topic: https://gitlab.com/git is unfortunately
>> taken, so it's out of question. I'd say the most pragmatic thing to do
>> would thus be to retain the already-existing location of the official
>> mirror at GitLab.

https://gitlab.com/git/ sems to give us 404, though.

> I still have not been able to reach =C3=86var until now. Unless somebod=
y else
> has a way to contact him directly we at GitLab are wondering how to
> continue.

Git @ SFC has heard from avarab@gmail.com on Nov 29, 2023 but I do
not recall any more recent communications X-<.

> It would certainly be great to set up ownership of whatever solution we
> arrive at such that it's more distributed across the community so that
> we don't have a single point of failure in the future. Also, I don't
> want us at GitLab to be the sole owners of the mirror, so I have been
> wondering how the other mirrors are set up and whom we should add to an=
y
> such mirror.

Distribution, yes.  I do not think we mind if the set of volunteer
owners end up to be all GitLab folks, but aiming for diversity is
good.

> In any case, once things are arranged I will collaborate with our
> support folks to get free CI minutes for the new mirror.

Wonderful.

Thanks.
