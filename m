Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6E47A53
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 06:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654330; cv=none; b=kC0pq7cRUU5TBebcCLvJ9Y0GtKOYqmM0kAUhO6TO8c4Zn+DFIPFyJ2HoclSB8+cu9gi8nmXi1T7PwJ+FcQ66zhi4m+1rvkXPNA+f+A3MNvpZnIs8wE7w3GesDhuDpNru3fAK40w0WpVb0kFKSd7qvkWrCtrHujRKdA3SDPM9T+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654330; c=relaxed/simple;
	bh=FppQuTwsRKxy3Ay/Jdn0aokjMi4x7zJHeP6UezpKdG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g179AS79V2070tPPhjNDH+6WJZAW26Deu00MzkD1QBWTNeVXgjo3BjLjmdBMtPacFGUFEZWWZMyHQnkExKUPSX9Ej+tlfe4t/mvuxQCFdBXTFXVA+XO5Uj8Y6rDw3Ne+pSzT6V6xggYU9yAmIERGFJvYomCeKEPS/76+8sxS0WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ppwqrbSs; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ppwqrbSs"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF70D2ADC6;
	Thu,  6 Jun 2024 02:12:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FppQuTwsRKxy3Ay/Jdn0aokjMi4x7zJHeP6Uez
	pKdG4=; b=ppwqrbSsROsI2AxcnIeJ35MdKOp9SdC+Odi6K5et85jPUsh0/tAM2D
	Hex9ArRWI0D9l/g5sgFEp3nvIZFYp6aqH+QQfHtPLtDim77/JAiWqlW09Qs/BRpU
	9n2yXN1gsCjTKiML4SHgIPd3mBQRz/MUutX8PDi6bZQfKf4G0N+u4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A6A7B2ADC5;
	Thu,  6 Jun 2024 02:12:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1FC052ADC4;
	Thu,  6 Jun 2024 02:12:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "James Liu" <james@jamesliu.io>
Cc: "Patrick Steinhardt" <ps@pks.im>,  <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] Makefile: extract script to lint missing/extraneous
 manpages
In-Reply-To: <D1SPGQ8OOLLS.I6HUJZW81XLH@jamesliu.io> (James Liu's message of
	"Thu, 06 Jun 2024 16:03:45 +1000")
References: <cover.1717564310.git.ps@pks.im>
	<b06088a2ff65a3455f0f5db2a9b752901f2af14b.1717564310.git.ps@pks.im>
	<xmqqzfs0x8w9.fsf@gitster.g> <Zl_3TQrUHdb5osDA@tanuki>
	<D1SPGQ8OOLLS.I6HUJZW81XLH@jamesliu.io>
Date: Wed, 05 Jun 2024 23:12:04 -0700
Message-ID: <xmqqikymppl7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B312CA30-23CB-11EF-A380-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

"James Liu" <james@jamesliu.io> writes:

> On Wed Jun 5, 2024 at 3:27 PM AEST, Patrick Steinhardt wrote:
>> On Tue, Jun 04, 2024 at 10:20:54PM -0700, Junio C Hamano wrote:
>> > Patrick Steinhardt <ps@pks.im> writes:
>> > 
>> > > +++ b/Documentation/lint-manpages.sh
>> > > @@ -0,0 +1,82 @@
>> > > +#!/usr/bin/env bash
>> > 
>> > I do not see much bash-ism here.  Unless absolutely needed, please
>> > use "#!/bin/sh" instead.
>>
>> Ah, true. I initially did have some bash-isms, but got rid of them. Will
>> adapt.
>>
>> Patrick
>
> It looks like the script fails to run under /bin/sh:
> https://gitlab.com/gitlab-org/git/-/jobs/7021474555#L4365

Nice to know.  In any case, the original was an inline scriptlet in
the Makefile and should have been happily working for folks whose
/bin/sh is different from bash, so the version that is extracted out
shouldn't have to rely on bashisms.

Thanks.
